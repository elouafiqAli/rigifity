"""Markdown chunker: split on ATX headers (#, ##, ###).

Each section becomes a chunk; chunk text starts at the heading line and
continues until the next heading of equal-or-shallower depth (or EOF).
The chunk's `name` is the heading text; the kind encodes header depth.
"""

from __future__ import annotations

import re
from typing import Any

from indexer.chunkers._types import Chunk
from indexer.chunkers._ts import get_parser, line_range, node_text

# Fallback regex
_HEADING_RE = re.compile(r"^(#{1,6})\s+(.*?)\s*#*\s*$", re.MULTILINE)


def chunk(source: str) -> list[Chunk]:
    parser = get_parser("markdown")
    if parser is None:
        return _regex_chunk(source)
    try:
        src_bytes = source.encode("utf-8")
        tree = parser.parse(src_bytes)
        chunks = _ts_chunk(src_bytes, tree.root_node)
        if chunks:
            return chunks
    except Exception:
        pass
    return _regex_chunk(source)


# ---------- tree-sitter path -----------------------------------------------


def _ts_chunk(src_bytes: bytes, root: Any) -> list[Chunk]:
    """Find atx_heading nodes and slice from each to the next equal-or-shallower."""
    headings: list[tuple[int, int, int, str]] = []  # (level, byte_start, line_start, title)
    for node in _walk(root):
        if not node.is_named:
            continue
        if node.type not in {"atx_heading", "setext_heading"}:
            continue
        text = node_text(src_bytes, node)
        m = re.match(r"^(#{1,6})\s*(.*)", text)
        if not m:
            continue
        level = len(m.group(1)) or 1
        title = m.group(2).strip()
        headings.append((level, node.start_byte, node.start_point[0] + 1, title))

    if not headings:
        return []

    out: list[Chunk] = []
    full_len = len(src_bytes)
    # Emit a leading "preamble" chunk if there's content before the first heading.
    first_start = headings[0][1]
    if first_start > 0:
        pre = src_bytes[:first_start].decode("utf-8", errors="replace")
        if pre.strip():
            out.append(Chunk(
                text=pre, start_line=1, end_line=pre.count("\n") + 1,
                kind="md.preamble", name="",
            ))
    for i, (level, sb, sl, title) in enumerate(headings):
        # find end: next heading whose level <= this one
        eb = full_len
        el = src_bytes.count(b"\n") + 1
        for j in range(i + 1, len(headings)):
            if headings[j][0] <= level:
                eb = headings[j][1]
                el = headings[j][2] - 1
                break
        text = src_bytes[sb:eb].decode("utf-8", errors="replace")
        if not text.strip():
            continue
        out.append(Chunk(
            text=text, start_line=sl, end_line=el,
            kind=f"md.h{level}", name=title,
        ))
    return out


def _walk(node: Any):
    yield node
    for ch in node.children:
        yield from _walk(ch)


# ---------- regex fallback -------------------------------------------------


def _regex_chunk(source: str) -> list[Chunk]:
    matches = list(_HEADING_RE.finditer(source))
    if not matches:
        return []

    out: list[Chunk] = []
    if matches[0].start() > 0:
        pre = source[:matches[0].start()]
        if pre.strip():
            out.append(Chunk(
                text=pre, start_line=1, end_line=pre.count("\n") + 1,
                kind="md.preamble", name="",
            ))
    levels = [len(m.group(1)) for m in matches]
    for i, m in enumerate(matches):
        level = levels[i]
        start = m.start()
        end = len(source)
        for j in range(i + 1, len(matches)):
            if levels[j] <= level:
                end = matches[j].start()
                break
        text = source[start:end]
        if not text.strip():
            continue
        sl = source.count("\n", 0, start) + 1
        el = sl + text.count("\n")
        out.append(Chunk(
            text=text, start_line=sl, end_line=el,
            kind=f"md.h{level}", name=m.group(2).strip(),
        ))
    return out
