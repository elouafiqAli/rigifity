"""Tiny tree-sitter helper: lazy parser loading + lossless source slicing."""

from __future__ import annotations

import functools
from typing import Any


@functools.lru_cache(maxsize=16)
def get_parser(lang_name: str) -> Any | None:
    """Return a tree-sitter Parser for `lang_name`, or None if unavailable.

    Uses tree_sitter_language_pack which bundles prebuilt grammars for
    Lean, LaTeX, Markdown, TOML, YAML, Python, Bash, etc.
    """
    try:
        from tree_sitter_language_pack import get_parser as _get
    except ImportError:  # pragma: no cover
        return None
    try:
        return _get(lang_name)
    except Exception:
        return None


def node_text(source_bytes: bytes, node: Any) -> str:
    """UTF-8 lossless slice of `source_bytes` for a tree-sitter `node`."""
    return source_bytes[node.start_byte:node.end_byte].decode("utf-8", errors="replace")


def line_range(node: Any) -> tuple[int, int]:
    """1-based inclusive (start_line, end_line) for a tree-sitter node."""
    return node.start_point[0] + 1, node.end_point[0] + 1
