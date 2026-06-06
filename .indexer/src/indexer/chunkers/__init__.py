"""Chunker dispatch."""

from __future__ import annotations

from indexer.chunkers._types import Chunk
from indexer.config import Config
from indexer.walk import FileEntry


def chunk_file(entry: FileEntry, source: str, cfg: Config) -> list[Chunk]:
    """Return structure-aware chunks for a file's source."""
    from indexer.chunkers import lean, latex, markdown, generic

    ext = entry.ext
    raw_chunks: list[Chunk]
    if ext == ".lean":
        raw_chunks = lean.chunk(source)
    elif ext in (".tex", ".sty"):
        raw_chunks = latex.chunk(source)
    elif ext == ".md":
        raw_chunks = markdown.chunk(source)
    else:
        raw_chunks = generic.chunk(source, cfg.chunking.generic)

    # Post-process: split anything too large via generic chunker; drop tiny.
    out: list[Chunk] = []
    for c in raw_chunks:
        if len(c.text.strip()) < cfg.chunking.min_chunk_chars:
            continue
        if len(c.text) <= cfg.chunking.max_chunk_chars:
            out.append(c)
            continue
        for sub in generic.chunk(c.text, cfg.chunking.generic):
            out.append(
                Chunk(
                    text=sub.text,
                    start_line=c.start_line + sub.start_line - 1,
                    end_line=c.start_line + sub.end_line - 1,
                    kind=c.kind + "+gen",
                    name=c.name,
                    extra=dict(c.extra),
                )
            )
    return out


__all__ = ["Chunk", "chunk_file"]
