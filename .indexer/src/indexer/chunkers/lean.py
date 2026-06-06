"""Lean 4 chunker.

Strategy:
  1. Try tree-sitter `lean` grammar; split on each top-level declaration node.
     Group leading docstrings, `@[...]` attributes, and `noncomputable`/
     `protected`/visibility modifiers with the declaration they decorate.
  2. Fall back to a regex split on a fixed set of declaration keywords if
     the parser is unavailable or the file fails to parse.

Each declaration becomes one Chunk; non-decl preamble (header imports, file
docstring, `set_option`s) becomes a single "lean.preamble" chunk.
"""

from __future__ import annotations

import re
from typing import Any

from indexer.chunkers._types import Chunk
from indexer.chunkers._ts import get_parser, line_range, node_text

# Tree-sitter-lean exposes top-level declarations under several node names.
# We accept any node whose `type` is in this set OR whose first named child
# is in this set (covers `declaration_modifiers` + `declaration` wrappers).
_DECL_TYPES = {
    "definition",
    "theorem",
    "lemma",                # legacy alias; lean4 grammar may not use it
    "structure",
    "inductive",
    "class",
    "instance",
    "axiom",
    "example",
    "abbrev",
    "declaration",          # top-level command wrapper in some grammar revs
    "namespace",            # we treat each namespace open as a delimiter
    "section",
}

# Regex fallback: matches top-level decl keywords at start of line.
_DECL_RE = re.compile(
    r"^(?P<head>(?:@\[[^\]]*\]\s*\n)*"               # attribute lines
    r"(?:(?:private|protected|noncomputable|partial|nonrec|unsafe|scoped)\s+)*"
    r"(?:theorem|lemma|def|abbrev|instance|structure|inductive|class|axiom|example|opaque|constant)\b)",
    re.MULTILINE,
)
_NAME_RE = re.compile(
    r"\b(?:theorem|lemma|def|abbrev|instance|structure|inductive|class|axiom|example|opaque|constant)\s+"
    r"(?:@\[[^\]]*\]\s*)*"
    r"(?P<name>[^\s\(\[\{:]+)"
)


def chunk(source: str) -> list[Chunk]:
    parser = get_parser("lean")
    if parser is None:
        return _regex_chunk(source)
    try:
        src_bytes = source.encode("utf-8")
        tree = parser.parse(src_bytes)
        chunks = _ts_chunk(src_bytes, tree.root_node, source)
        if chunks:
            return chunks
    except Exception:
        pass
    return _regex_chunk(source)


# ---------- tree-sitter path ----------------------------------------------


def _ts_chunk(src_bytes: bytes, root: Any, full_text: str) -> list[Chunk]:
    """Walk top-level commands; emit one chunk per decl."""
    out: list[Chunk] = []
    children = [c for c in root.children if c.is_named]
    if not children:
        return out

    # Group attributes / modifiers that precede a declaration with that decl.
    pending: list[Any] = []
    preamble_nodes: list[Any] = []
    started_decls = False

    for node in children:
        t = node.type
        if t in _DECL_TYPES or _looks_like_decl(node):
            grouped = pending + [node]
            pending = []
            kind = _classify(node, src_bytes)
            name = _extract_name(node_text(src_bytes, node))
            start_line = grouped[0].start_point[0] + 1
            end_line = node.end_point[0] + 1
            start_byte = grouped[0].start_byte
            end_byte = node.end_byte
            text = src_bytes[start_byte:end_byte].decode("utf-8", errors="replace")
            out.append(Chunk(
                text=text, start_line=start_line, end_line=end_line,
                kind=kind, name=name,
            ))
            started_decls = True
        elif _is_modifier(t):
            pending.append(node)
        elif not started_decls:
            preamble_nodes.append(node)
        else:
            # stray top-level command after first decl — emit standalone
            text = node_text(src_bytes, node)
            sl, el = line_range(node)
            out.append(Chunk(
                text=text, start_line=sl, end_line=el,
                kind=f"lean.{t}", name="",
            ))

    if preamble_nodes:
        sl = preamble_nodes[0].start_point[0] + 1
        el = preamble_nodes[-1].end_point[0] + 1
        sb = preamble_nodes[0].start_byte
        eb = preamble_nodes[-1].end_byte
        text = src_bytes[sb:eb].decode("utf-8", errors="replace")
        out.insert(0, Chunk(
            text=text, start_line=sl, end_line=el,
            kind="lean.preamble", name="",
        ))
    return out


def _is_modifier(t: str) -> bool:
    return t in {
        "attributes", "attribute", "declaration_modifiers",
        "modifier", "doc_comment", "docComment", "comment",
    }


def _looks_like_decl(node: Any) -> bool:
    # Some grammar revs wrap declarations in a generic "command" node whose
    # first named child carries the actual kind.
    if node.type not in {"command", "declaration"}:
        return False
    for ch in node.children:
        if ch.is_named and ch.type in _DECL_TYPES:
            return True
    return False


def _classify(node: Any, src_bytes: bytes) -> str:
    t = node.type
    if t in _DECL_TYPES:
        return f"lean.{t}"
    # generic wrapper: look inside
    for ch in node.children:
        if ch.is_named and ch.type in _DECL_TYPES:
            return f"lean.{ch.type}"
    # last-ditch: scan the first 64 bytes for the keyword
    head = src_bytes[node.start_byte:node.start_byte + 64].decode("utf-8", errors="replace")
    for kw in ("theorem", "lemma", "def", "instance", "structure",
               "inductive", "class", "axiom", "example", "abbrev"):
        if re.search(rf"\b{kw}\b", head):
            return f"lean.{kw}"
    return "lean.other"


def _extract_name(text: str) -> str:
    m = _NAME_RE.search(text)
    return m.group("name") if m else ""


# ---------- regex fallback -------------------------------------------------


def _regex_chunk(source: str) -> list[Chunk]:
    starts = [m.start() for m in _DECL_RE.finditer(source)]
    if not starts:
        return []
    out: list[Chunk] = []
    # preamble = everything before first decl
    if starts[0] > 0:
        preamble = source[:starts[0]]
        if preamble.strip():
            out.append(Chunk(
                text=preamble,
                start_line=1,
                end_line=preamble.count("\n") + 1,
                kind="lean.preamble",
                name="",
            ))
    ends = starts[1:] + [len(source)]
    for s, e in zip(starts, ends):
        body = source[s:e]
        if not body.strip():
            continue
        name = _extract_name(body[:512])
        kind = _kind_from_keyword(body)
        line_start = source.count("\n", 0, s) + 1
        line_end = line_start + body.count("\n")
        out.append(Chunk(
            text=body, start_line=line_start, end_line=line_end,
            kind=kind, name=name,
        ))
    return out


def _kind_from_keyword(body: str) -> str:
    head = body[:256]
    for kw in ("theorem", "lemma", "instance", "structure", "inductive",
               "class", "axiom", "example", "abbrev", "opaque", "constant", "def"):
        if re.search(rf"\b{kw}\b", head):
            return f"lean.{kw}"
    return "lean.decl"
