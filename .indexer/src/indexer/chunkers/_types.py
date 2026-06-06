"""Shared dataclasses for chunkers (avoids circular imports)."""

from __future__ import annotations

from dataclasses import dataclass, field


@dataclass(frozen=True, slots=True)
class Chunk:
    text: str                         # the content slice
    start_line: int                   # 1-based inclusive
    end_line: int                     # 1-based inclusive
    kind: str                         # e.g. "lean.theorem", "tex.theorem", "md.section"
    name: str = ""                    # identifier if extractable
    extra: dict = field(default_factory=dict)
