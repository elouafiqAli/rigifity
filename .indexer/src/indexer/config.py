"""Load and validate indexer config from YAML."""

from __future__ import annotations

import dataclasses
from pathlib import Path
from typing import Any

import yaml


@dataclasses.dataclass(frozen=True, slots=True)
class GenericChunkCfg:
    target_chars: int = 1600
    overlap_chars: int = 200


@dataclasses.dataclass(frozen=True, slots=True)
class ChunkingCfg:
    generic: GenericChunkCfg
    max_chunk_chars: int
    min_chunk_chars: int


@dataclasses.dataclass(frozen=True, slots=True)
class EmbeddingCfg:
    model: str
    batch_size: int
    query_prefix: str


@dataclasses.dataclass(frozen=True, slots=True)
class ChromaCfg:
    path: str
    collection: str
    distance: str


@dataclasses.dataclass(frozen=True, slots=True)
class Config:
    roots: list[str]
    extensions: set[str]
    exclude_path_fragments: list[str]
    max_file_bytes: int
    chunking: ChunkingCfg
    embedding: EmbeddingCfg
    chroma: ChromaCfg
    workspace_root: Path

    @classmethod
    def load(cls, config_path: Path, workspace_root: Path) -> "Config":
        with config_path.open("r", encoding="utf-8") as fh:
            raw: dict[str, Any] = yaml.safe_load(fh) or {}
        chunking_raw = raw.get("chunking", {})
        generic_raw = chunking_raw.get("generic", {})
        embedding_raw = raw.get("embedding", {})
        chroma_raw = raw.get("chroma", {})

        return cls(
            roots=list(raw.get("roots", [".samples"])),
            extensions={e.lower() for e in raw.get("extensions", [])},
            exclude_path_fragments=list(raw.get("exclude_path_fragments", [])),
            max_file_bytes=int(raw.get("max_file_bytes", 512 * 1024)),
            chunking=ChunkingCfg(
                generic=GenericChunkCfg(
                    target_chars=int(generic_raw.get("target_chars", 1600)),
                    overlap_chars=int(generic_raw.get("overlap_chars", 200)),
                ),
                max_chunk_chars=int(chunking_raw.get("max_chunk_chars", 4000)),
                min_chunk_chars=int(chunking_raw.get("min_chunk_chars", 40)),
            ),
            embedding=EmbeddingCfg(
                model=str(embedding_raw.get("model", "BAAI/bge-small-en-v1.5")),
                batch_size=int(embedding_raw.get("batch_size", 64)),
                query_prefix=str(embedding_raw.get("query_prefix", "")),
            ),
            chroma=ChromaCfg(
                path=str(chroma_raw.get("path", ".indexer/chroma")),
                collection=str(chroma_raw.get("collection", "samples")),
                distance=str(chroma_raw.get("distance", "cosine")),
            ),
            workspace_root=workspace_root.resolve(),
        )

    def chroma_abspath(self) -> Path:
        return (self.workspace_root / self.chroma.path).resolve()
