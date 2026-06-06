"""rigidity-indexer CLI: index / query / stats / clear."""

from __future__ import annotations

import hashlib
import sys
import time
from pathlib import Path
from typing import Optional

import click
from rich.console import Console
from rich.table import Table

from indexer.chunkers import chunk_file
from indexer.config import Config
from indexer.embed import Embedder
from indexer.store import Store
from indexer.walk import FileEntry, walk

DEFAULT_CONFIG_REL = "config.yaml"


def _find_workspace_root(start: Path) -> Path:
    p = start.resolve()
    while p.parent != p:
        if (p / ".samples").is_dir() or (p / ".git").is_dir():
            return p
        p = p.parent
    return start.resolve()


def _load_cfg(config: Optional[Path]) -> Config:
    indexer_dir = Path(__file__).resolve().parents[2]   # .indexer/
    workspace_root = _find_workspace_root(indexer_dir)
    cfg_path = config or (indexer_dir / DEFAULT_CONFIG_REL)
    if not cfg_path.exists():
        raise click.ClickException(f"config file not found: {cfg_path}")
    return Config.load(cfg_path, workspace_root)


@click.group()
@click.version_option()
def main() -> None:
    """Tree-sitter + ChromaDB RAG over the Lean blueprint samples."""


# ---------- index ----------------------------------------------------------


@main.command()
@click.option("--config", type=click.Path(dir_okay=False, path_type=Path), default=None,
              help="Path to config.yaml (default: alongside the package).")
@click.option("--reindex", is_flag=True, help="Force reindex even if file is unchanged.")
@click.option("--clear/--no-clear", default=False, help="Wipe the collection before indexing.")
@click.option("--limit", type=int, default=0, help="Stop after this many files (0 = all). Smoke-test helper.")
@click.option("--root", "root_filter", default=None,
              help="Only index files whose first path segment matches (e.g. unit-fractions).")
def index(config: Optional[Path], reindex: bool, clear: bool, limit: int, root_filter: Optional[str]) -> None:
    """Walk roots, chunk, embed, and upsert into Chroma."""
    console = Console()
    cfg = _load_cfg(config)
    persist_dir = cfg.chroma_abspath()
    console.log(f"workspace_root = {cfg.workspace_root}")
    console.log(f"chroma_path    = {persist_dir}")
    console.log(f"model          = {cfg.embedding.model}")

    store = Store(cfg.chroma, persist_dir)
    if clear:
        console.log("[yellow]Clearing collection...[/yellow]")
        store.reset()

    embedder = Embedder(cfg.embedding)

    # 1) discover files
    entries: list[FileEntry] = []
    for e in walk(cfg):
        if root_filter:
            seg = e.relpath.split("/", 2)[1] if e.relpath.startswith(".samples/") else e.relpath.split("/", 1)[0]
            if seg != root_filter:
                continue
        entries.append(e)
        if limit and len(entries) >= limit:
            break
    console.log(f"discovered {len(entries)} files")

    # 2) skip unchanged unless --reindex
    existing: dict[str, str] = {}
    if not reindex:
        existing = store.file_signatures([e.relpath for e in entries])

    # 3) chunk → embed → upsert
    total_chunks = 0
    skipped = 0
    started = time.time()
    last_log = started
    # Line-based progress (no Live progress bar — keeps stdout append-only so
    # terminal hosts don't misread redraws as input prompts).
    log_every_files = 25
    log_every_seconds = 20.0
    n_total = len(entries)
    for i, entry in enumerate(entries, start=1):
        try:
            source = entry.abspath.read_text(encoding="utf-8", errors="replace")
        except OSError as ex:
            console.log(f"[red]read failed[/red] {entry.relpath}: {ex}")
            continue

        file_sha = hashlib.sha1(source.encode("utf-8", errors="replace")).hexdigest()
        if (not reindex) and existing.get(entry.relpath) == file_sha:
            skipped += 1
        else:
            chunks = chunk_file(entry, source, cfg)
            if chunks:
                if existing.get(entry.relpath):
                    store.delete_file(entry.relpath)
                texts = [c.text for c in chunks]
                embeddings = embedder.encode_documents(texts)
                n = store.upsert_file(entry, file_sha, chunks, embeddings)
                total_chunks += n

        now = time.time()
        if i == n_total or i % log_every_files == 0 or (now - last_log) >= log_every_seconds:
            elapsed = now - started
            rate = i / elapsed if elapsed > 0 else 0.0
            remaining = (n_total - i) / rate if rate > 0 else float("inf")
            console.log(
                f"  {i:>5}/{n_total}  chunks={total_chunks:>6}  "
                f"skipped={skipped:>5}  rate={rate:0.2f} f/s  "
                f"eta={_fmt_secs(remaining)}  last={entry.relpath}"
            )
            last_log = now

    dur = time.time() - started
    console.log(
        f"[green]done[/green] indexed_chunks={total_chunks} "
        f"skipped_unchanged={skipped} files={n_total} "
        f"duration={dur:.1f}s collection_size={store.count()}"
    )


def _fmt_secs(s: float) -> str:
    if s == float("inf") or s != s:  # nan
        return "?"
    s = int(s)
    h, rem = divmod(s, 3600)
    m, sec = divmod(rem, 60)
    if h:
        return f"{h}h{m:02d}m"
    if m:
        return f"{m}m{sec:02d}s"
    return f"{sec}s"

# ---------- query ----------------------------------------------------------


@main.command()
@click.argument("question", nargs=-1, required=True)
@click.option("--config", type=click.Path(dir_okay=False, path_type=Path), default=None)
@click.option("-k", "--k", default=8, show_default=True, help="Top-k results.")
@click.option("--ext", default=None, help="Filter by file extension, e.g. .lean")
@click.option("--kind", default=None, help="Filter by chunk kind, e.g. lean.theorem")
@click.option("--project", default=None, help="Filter by sample project name (e.g. unit-fractions).")
@click.option("--show-text/--no-show-text", default=True)
@click.option("--max-chars", default=600, show_default=True, help="Truncate displayed chunk text.")
def query(
    question: tuple[str, ...],
    config: Optional[Path],
    k: int,
    ext: Optional[str],
    kind: Optional[str],
    project: Optional[str],
    show_text: bool,
    max_chars: int,
) -> None:
    """Search the index."""
    console = Console()
    cfg = _load_cfg(config)
    q = " ".join(question)

    store = Store(cfg.chroma, cfg.chroma_abspath())
    embedder = Embedder(cfg.embedding)
    qvec = embedder.encode_query(q)

    where: dict = {}
    conds: list[dict] = []
    if ext:
        conds.append({"ext": ext})
    if kind:
        conds.append({"kind": kind})
    if project:
        # `project` is the second path segment of `.samples/<proj>/...`,
        # stored as a scalar metadata field so we can filter server-side.
        conds.append({"project": project})
    if len(conds) == 1:
        where = conds[0]
    elif len(conds) > 1:
        where = {"$and": conds}

    res = store.query(qvec, k=k, where=where or None)

    table = Table(show_lines=show_text)
    table.add_column("#", justify="right", style="dim")
    table.add_column("score", justify="right")
    table.add_column("kind")
    table.add_column("name")
    table.add_column("location")

    metadatas = res.get("metadatas", [[]])[0]
    documents = res.get("documents", [[]])[0]
    distances = res.get("distances", [[]])[0]
    for shown, (meta, doc, dist) in enumerate(zip(metadatas, documents, distances), start=1):
        loc = f"{meta.get('relpath')}#L{meta.get('start_line')}-L{meta.get('end_line')}"
        table.add_row(
            str(shown),
            f"{1.0 - float(dist):.3f}",
            meta.get("kind", ""),
            meta.get("name", "") or "",
            loc,
        )
        if show_text:
            snippet = (doc or "").strip()
            if len(snippet) > max_chars:
                snippet = snippet[:max_chars] + "…"
            table.add_row("", "", "", "", snippet, style="dim")

    console.print(table)


# ---------- stats ----------------------------------------------------------


@main.command()
@click.option("--config", type=click.Path(dir_okay=False, path_type=Path), default=None)
def stats(config: Optional[Path]) -> None:
    """Print index statistics."""
    console = Console()
    cfg = _load_cfg(config)
    store = Store(cfg.chroma, cfg.chroma_abspath())
    total = store.count()
    console.print(f"[bold]Collection:[/bold] {cfg.chroma.collection}")
    console.print(f"[bold]Path:[/bold] {cfg.chroma_abspath()}")
    console.print(f"[bold]Chunks:[/bold] {total}")
    if total == 0:
        return
    # Page through ALL metadatas. Chroma's SQLite backend caps params per
    # query (~999 in older builds), and a single `get(limit=N)` allocates
    # `N` placeholders. Stay under 500 per page.
    by_kind: dict[str, int] = {}
    by_ext: dict[str, int] = {}
    by_project: dict[str, int] = {}
    page = 500
    seen = 0
    while seen < total:
        batch = store.collection.get(
            include=["metadatas"], limit=page, offset=seen,
        )
        metas = batch.get("metadatas", []) or []
        if not metas:
            break
        for m in metas:
            by_kind[m.get("kind", "?")] = by_kind.get(m.get("kind", "?"), 0) + 1
            by_ext[m.get("ext", "?")] = by_ext.get(m.get("ext", "?"), 0) + 1
            proj = _project_of(m.get("relpath", ""))
            by_project[proj] = by_project.get(proj, 0) + 1
        seen += len(metas)
    _print_breakdown(console, "by kind", by_kind, top=25)
    _print_breakdown(console, "by extension", by_ext, top=25)
    _print_breakdown(console, "by project", by_project, top=50)


def _project_of(relpath: str) -> str:
    """Derive a project name from a relpath. `.samples/pfr/Foo.lean` → `pfr`."""
    parts = relpath.split("/")
    if len(parts) >= 2 and parts[0] == ".samples":
        return parts[1]
    return parts[0] if parts else "?"


def _print_breakdown(console: Console, title: str, counts: dict[str, int], top: int) -> None:
    t = Table(title=title)
    t.add_column("key")
    t.add_column("count", justify="right")
    for k, v in sorted(counts.items(), key=lambda kv: -kv[1])[:top]:
        t.add_row(k, str(v))
    console.print(t)


# ---------- clear ----------------------------------------------------------


@main.command()
@click.option("--config", type=click.Path(dir_okay=False, path_type=Path), default=None)
@click.option("--yes", is_flag=True, help="Skip confirmation.")
def clear(config: Optional[Path], yes: bool) -> None:
    """Drop the collection (irreversible)."""
    cfg = _load_cfg(config)
    if not yes:
        click.confirm(f"Delete chroma collection '{cfg.chroma.collection}' at {cfg.chroma_abspath()}?",
                      abort=True)
    store = Store(cfg.chroma, cfg.chroma_abspath())
    store.reset()
    click.echo("collection reset")


if __name__ == "__main__":  # pragma: no cover
    main()
