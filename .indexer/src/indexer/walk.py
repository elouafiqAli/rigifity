"""Filesystem walker with extension filter, byte cap, and path-fragment excludes."""

from __future__ import annotations

import os
from dataclasses import dataclass
from pathlib import Path
from typing import Iterator

from indexer.config import Config


@dataclass(frozen=True, slots=True)
class FileEntry:
    abspath: Path                 # resolved absolute path on disk
    relpath: str                  # POSIX path relative to workspace root
    ext: str                      # lowercase extension including the dot
    size: int                     # bytes


def _is_excluded(posix_path: str, fragments: list[str]) -> bool:
    return any(frag in posix_path for frag in fragments)


def walk(cfg: Config) -> Iterator[FileEntry]:
    """Yield FileEntry for every indexable file under cfg.roots.

    Skips files whose extension is not in cfg.extensions, whose path contains
    any of cfg.exclude_path_fragments, or whose size exceeds cfg.max_file_bytes.
    """
    seen: set[Path] = set()
    for root in cfg.roots:
        root_abs = (cfg.workspace_root / root).resolve()
        if not root_abs.exists():
            continue
        if root_abs.is_file():
            entry = _maybe_entry(root_abs, cfg)
            if entry and entry.abspath not in seen:
                seen.add(entry.abspath)
                yield entry
            continue
        for dirpath, dirnames, filenames in os.walk(root_abs, followlinks=False):
            # prune obvious heavy dirs early
            dirnames[:] = [
                d for d in dirnames
                if not _dir_excluded(d, dirpath, cfg.exclude_path_fragments)
            ]
            for fn in filenames:
                p = Path(dirpath) / fn
                entry = _maybe_entry(p, cfg)
                if entry and entry.abspath not in seen:
                    seen.add(entry.abspath)
                    yield entry


def _dir_excluded(name: str, parent: str, fragments: list[str]) -> bool:
    # Build a candidate posix path with trailing slash so /.git/ matches.
    candidate = (Path(parent) / name).as_posix() + "/"
    return _is_excluded(candidate, fragments)


def _maybe_entry(p: Path, cfg: Config) -> FileEntry | None:
    try:
        if not p.is_file():
            return None
        ext = p.suffix.lower()
        if ext not in cfg.extensions:
            return None
        size = p.stat().st_size
        if size == 0 or size > cfg.max_file_bytes:
            return None
        try:
            relpath = p.resolve().relative_to(cfg.workspace_root).as_posix()
        except ValueError:
            # outside workspace; use absolute posix path
            relpath = p.resolve().as_posix()
        if _is_excluded("/" + relpath, cfg.exclude_path_fragments):
            return None
        return FileEntry(abspath=p.resolve(), relpath=relpath, ext=ext, size=size)
    except (OSError, PermissionError):
        return None
