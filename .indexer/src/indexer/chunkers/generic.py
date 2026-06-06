"""Character-based fallback chunker with overlap."""

from __future__ import annotations

from indexer.chunkers._types import Chunk
from indexer.config import GenericChunkCfg


def chunk(text: str, cfg: GenericChunkCfg) -> list[Chunk]:
    """Split `text` into overlapping windows.

    Tries to break on the nearest newline within the trailing 200 chars so
    we don't sever a token. Always yields at least one chunk for non-empty
    input.
    """
    target = max(200, cfg.target_chars)
    overlap = max(0, min(cfg.overlap_chars, target // 2))
    if len(text) <= target:
        return [_make(text, 0, len(text), text)] if text.strip() else []

    out: list[Chunk] = []
    start = 0
    n = len(text)
    while start < n:
        end = min(n, start + target)
        if end < n:
            cut = text.rfind("\n", max(start + target // 2, end - 200), end)
            if cut > start:
                end = cut
        slice_text = text[start:end]
        if slice_text.strip():
            out.append(_make(text, start, end, slice_text))
        if end == n:
            break
        next_start = max(0, end - overlap)
        if out and next_start <= out[-1].extra.get("char_start", -1):
            next_start = end  # bail from pathological overlap
        start = next_start
    return out


def _make(full: str, start: int, end: int, slice_text: str) -> Chunk:
    start_line = full.count("\n", 0, start) + 1
    end_line = start_line + slice_text.count("\n")
    return Chunk(
        text=slice_text,
        start_line=start_line,
        end_line=end_line,
        kind="generic",
        extra={"char_start": start, "char_end": end},
    )
