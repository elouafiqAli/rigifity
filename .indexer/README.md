# `.indexer/` — tree-sitter + ChromaDB RAG over the `.samples/` archive

Local-only Python tool that builds a fast, queryable index over every Lean
blueprint-style reference project shallow-cloned into `../.samples/`. Used
to look up “how did project X structure their lakefile / theorem statement /
CI workflow / blueprint LaTeX” without grepping 5,000+ files.

Nothing in this directory is tracked by git (see top-level `.gitignore`).
Re-create the venv + index on a fresh checkout with `tools.ps1 setup`
followed by `tools.ps1 index`.

## What gets indexed

| Source | Chunker | Chunk granularity |
|---|---|---|
| `*.lean` | tree-sitter `lean` (regex fallback) | one chunk per top-level decl (theorem / lemma / def / instance / structure / inductive / class / axiom / abbrev / example), grouped with leading `@[...]` attributes and docstrings |
| `*.tex`, `*.sty` | tree-sitter `latex` (regex fallback) | theorem-like environments, sections; extracts `\label`, `\lean{...}`, `\uses{...}` |
| `*.md` | tree-sitter `markdown` (regex fallback) | section per ATX header (one chunk per `#`/`##`/...) |
| `*.toml`, `*.yaml`, `*.yml`, `*.py`, `*.sh`, `*.bib` | generic char-window | 1.6 kB target with 200-char overlap |

Anything beyond `max_chunk_chars` (4 kB) is re-split by the generic chunker
while preserving the structural metadata (`kind`, `name`, `start_line`).

Files larger than `max_file_bytes` (512 kB) are skipped — they’re almost
always generated `.json` / `.lock` / minified artifacts. Adjust in
[config.yaml](./config.yaml).

## Embedding model

Default: `BAAI/bge-small-en-v1.5` (384-dim, ~130 MB download, CPU-fast).
Edit `embedding.model` in `config.yaml` to swap models. Larger / code-aware
alternatives are listed inline. Embeddings are L2-normalized and stored
with cosine distance in Chroma.

## Storage

Persistent Chroma collection at `./chroma/`. Each chunk row stores:

```
relpath, ext, root, file_sha1, chunk_index, start_line, end_line,
kind, name, extra_json
```

`file_sha1` is used for fast incremental reindexing: unchanged files are
skipped unless `--reindex` is passed.

## Setup

```powershell
# one-time
.\.indexer\tools.ps1 setup                   # creates .venv/, installs deps via uv
```

`uv` is required (`winget install astral-sh.uv`).

## Index

```powershell
# everything in .samples/
.\.indexer\tools.ps1 index

# wipe and rebuild
.\.indexer\tools.ps1 index --clear

# one project (matches first path segment under .samples/)
.\.indexer\tools.ps1 index --root unit-fractions

# smoke test on a few files
.\.indexer\tools.ps1 index --limit 5 --root pfr

# force re-embed even if file sha1 is unchanged
.\.indexer\tools.ps1 index --reindex
```

## Query

```powershell
.\.indexer\tools.ps1 query "polynomial Freiman Ruzsa" -k 5
.\.indexer\tools.ps1 query "blueprint lean uses graph" -k 5 --ext .tex
.\.indexer\tools.ps1 query "lakefile lean options" -k 8 --ext .toml
.\.indexer\tools.ps1 query "theorem ent_compress_le" --kind lean.theorem
.\.indexer\tools.ps1 query "github actions blueprint" --project pfr
```

Filters compose: `--ext`, `--kind` (Chroma `where`), `--project` (post-filter
on relpath).

## Stats / clear

```powershell
.\.indexer\tools.ps1 stats
.\.indexer\tools.ps1 clear --yes
```

## Programmatic access

```python
from pathlib import Path
from indexer.config import Config
from indexer.embed import Embedder
from indexer.store import Store

cfg = Config.load(Path('.indexer/config.yaml'), Path('.'))
store = Store(cfg.chroma, cfg.chroma_abspath())
embed = Embedder(cfg.embedding)
res = store.query(embed.encode_query("dependent type rewriting"), k=10)
for doc, meta, dist in zip(res['documents'][0], res['metadatas'][0], res['distances'][0]):
    print(f"{1 - dist:.3f}  {meta['relpath']}#L{meta['start_line']}  {meta['kind']}  {meta['name']}")
```

## File layout

```
.indexer/
├─ pyproject.toml          # hatch / editable install
├─ config.yaml             # roots, extensions, model, chroma, chunk sizes
├─ tools.ps1               # setup / index / query / stats / clear
├─ README.md               # this file
├─ .gitignore              # ignores .venv/, chroma/, caches
├─ .venv/                  # uv-managed venv (not tracked)
├─ chroma/                 # persistent ChromaDB (not tracked)
└─ src/indexer/
   ├─ __init__.py
   ├─ __main__.py
   ├─ cli.py               # click CLI
   ├─ config.py            # YAML → frozen dataclasses
   ├─ walk.py              # filesystem traversal
   ├─ embed.py             # sentence-transformers wrapper
   ├─ store.py             # chromadb wrapper
   └─ chunkers/
      ├─ __init__.py       # dispatch by ext
      ├─ _types.py         # Chunk dataclass
      ├─ _ts.py            # tree-sitter helper
      ├─ generic.py        # char-window fallback
      ├─ lean.py           # Lean 4 grammar + regex fallback
      ├─ latex.py          # LaTeX grammar + regex fallback
      └─ markdown.py       # Markdown grammar + regex fallback
```

## Notes

- The walker silently skips files whose path contains `/.lake/`, `/.git/`,
  `/node_modules/`, `/_target/`, `/build/`, etc. Add more under
  `exclude_path_fragments` in `config.yaml`.
- `tree-sitter-language-pack` ships pre-built grammars; no compiler required.
- CPU-only embedding via sentence-transformers. On an 8-core machine, expect
  ~3 chunks/s for `bge-small`; full `.samples/` index runs in a single sitting.
- To extend indexing to workspace notes (`.research/`, top-level `*.md`),
  uncomment the entries under `roots:` in `config.yaml`.
