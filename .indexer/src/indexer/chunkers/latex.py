"""LaTeX chunker for blueprint files.

Strategy:
  1. Try tree-sitter `latex` grammar. Split on:
     - sectioning commands (\\section, \\subsection, \\subsubsection)
     - theorem-like environments (theorem/definition/lemma/corollary/
       proposition/remark/example/conjecture/claim)
  2. Fallback: regex find `\\begin{<env>} ... \\end{<env>}` and section
     command boundaries.

Each emitted chunk records its environment name, \\label{...} if any, and
the blueprint-specific `\\lean{...}` / `\\uses{...}` references via extras.
"""

from __future__ import annotations

import re
from typing import Any

from indexer.chunkers._types import Chunk
from indexer.chunkers._ts import get_parser, line_range, node_text

_THEOREM_LIKE = {
    "theorem", "lemma", "corollary", "proposition", "remark",
    "definition", "example", "conjecture", "claim", "fact",
    "observation", "notation",
}

_LABEL_RE = re.compile(r"\\label\{([^}]+)\}")
_LEAN_RE = re.compile(r"\\lean\{([^}]+)\}")
_USES_RE = re.compile(r"\\uses\{([^}]+)\}")
_SECTION_RE = re.compile(r"^(\\(?:section|subsection|subsubsection|chapter|part)\*?)\{([^}]*)\}", re.MULTILINE)
_BEGIN_RE = re.compile(r"\\begin\{(?P<env>[^}]+)\}")


def chunk(source: str) -> list[Chunk]:
    parser = get_parser("latex")
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


# ---------- tree-sitter path -----------------------------------------------


def _ts_chunk(src_bytes: bytes, root: Any, full_text: str) -> list[Chunk]:
    out: list[Chunk] = []
    # tree-sitter-latex node types of interest
    interesting = {
        "generic_environment", "math_environment",
        "section", "subsection", "subsubsection",
        "chapter", "part",
        "theorem_environment", "definition_environment",  # newer rev names
    }
    for node in _walk(root):
        if not node.is_named:
            continue
        if node.type not in interesting:
            continue
        text = node_text(src_bytes, node)
        kind, env_name = _classify_tex(node, text)
        if not kind:
            continue
        sl, el = line_range(node)
        name = _first_label(text) or _section_title(text) or env_name
        extras = _extract_extras(text, env_name)
        out.append(Chunk(
            text=text, start_line=sl, end_line=el,
            kind=kind, name=name, extra=extras,
        ))
    return out


def _walk(node: Any):
    yield node
    for ch in node.children:
        yield from _walk(ch)


def _classify_tex(node: Any, text: str) -> tuple[str | None, str]:
    t = node.type
    if t in {"section", "subsection", "subsubsection", "chapter", "part"}:
        return f"tex.{t}", t
    if t in {"generic_environment", "math_environment",
             "theorem_environment", "definition_environment"}:
        m = _BEGIN_RE.search(text[:200])
        env = m.group("env").strip("*") if m else ""
        if env in _THEOREM_LIKE:
            return f"tex.{env}", env
        if env in {"proof", "align", "align*", "equation", "equation*"}:
            return f"tex.{env}", env
        return None, env
    return None, ""


# ---------- regex fallback -------------------------------------------------


def _regex_chunk(source: str) -> list[Chunk]:
    """Coarse: split on \\begin{env}...\\end{env} for env in _THEOREM_LIKE,
    plus standalone \\section* commands as their own chunks."""
    out: list[Chunk] = []
    n = len(source)

    # 1) theorem-like envs
    for m in _BEGIN_RE.finditer(source):
        env = m.group("env").strip("*")
        if env not in _THEOREM_LIKE:
            continue
        end_pat = re.compile(r"\\end\{" + re.escape(m.group("env")) + r"\}")
        em = end_pat.search(source, m.end())
        if not em:
            continue
        start = m.start()
        end = em.end()
        body = source[start:end]
        sl = source.count("\n", 0, start) + 1
        el = sl + body.count("\n")
        out.append(Chunk(
            text=body, start_line=sl, end_line=el,
            kind=f"tex.{env}",
            name=_first_label(body) or env,
            extra=_extract_extras(body, env),
        ))

    # 2) section headers — emit as 1-line chunks (handy for navigation)
    for m in _SECTION_RE.finditer(source):
        sl = source.count("\n", 0, m.start()) + 1
        out.append(Chunk(
            text=m.group(0),
            start_line=sl, end_line=sl,
            kind=f"tex.{m.group(1).strip('\\').rstrip('*')}",
            name=m.group(2),
        ))
    return out


def _first_label(text: str) -> str:
    m = _LABEL_RE.search(text)
    return m.group(1) if m else ""


def _section_title(text: str) -> str:
    m = _SECTION_RE.search(text)
    return m.group(2) if m else ""


def _extract_extras(text: str, env: str) -> dict:
    extras: dict = {"env": env}
    label = _first_label(text)
    if label:
        extras["label"] = label
    lean_refs = _LEAN_RE.findall(text)
    if lean_refs:
        extras["lean_refs"] = lean_refs
    uses = _USES_RE.findall(text)
    if uses:
        extras["uses"] = uses
    return extras
