"""ChromaDB persistent store wrapper."""

from __future__ import annotations

import hashlib
import json
from pathlib import Path
from typing import Any, Iterable

import numpy as np

from indexer.chunkers import Chunk
from indexer.config import ChromaCfg
from indexer.walk import FileEntry


class Store:
    def __init__(self, cfg: ChromaCfg, persist_dir: Path) -> None:
        import chromadb
        from chromadb.config import Settings
        persist_dir.mkdir(parents=True, exist_ok=True)
        self._client = chromadb.PersistentClient(
            path=str(persist_dir),
            settings=Settings(anonymized_telemetry=False, allow_reset=True),
        )
        self._collection = self._client.get_or_create_collection(
            name=cfg.collection,
            metadata={"hnsw:space": cfg.distance},
            # We provide our own embeddings; tell chroma not to default-embed.
            embedding_function=None,
        )

    @property
    def collection(self):  # type: ignore[no-untyped-def]
        return self._collection

    def reset(self) -> None:
        """Drop and recreate the collection."""
        name = self._collection.name
        meta = self._collection.metadata
        self._client.delete_collection(name=name)
        self._collection = self._client.get_or_create_collection(
            name=name, metadata=meta, embedding_function=None,
        )

    def file_signatures(self, relpaths: Iterable[str]) -> dict[str, str]:
        """Return {relpath: file_sha1} for existing rows. Lets us skip
        unchanged files on re-index."""
        out: dict[str, str] = {}
        # Chroma `get` paged; batch in groups of 200 for safety
        rels = list(relpaths)
        for i in range(0, len(rels), 200):
            batch = rels[i:i + 200]
            res = self._collection.get(
                where={"$and": [
                    {"relpath": {"$in": batch}},
                    {"chunk_index": 0},
                ]},
                include=["metadatas"],
            )
            for meta in res.get("metadatas", []) or []:
                rp = meta.get("relpath")
                sha = meta.get("file_sha1")
                if rp and sha:
                    out[rp] = sha
        return out

    def delete_file(self, relpath: str) -> None:
        try:
            self._collection.delete(where={"relpath": relpath})
        except Exception:
            pass

    def upsert_file(
        self,
        entry: FileEntry,
        file_sha1: str,
        chunks: list[Chunk],
        embeddings: np.ndarray,
    ) -> int:
        if not chunks:
            return 0
        ids: list[str] = []
        docs: list[str] = []
        metas: list[dict[str, Any]] = []
        for i, c in enumerate(chunks):
            chunk_id = _stable_id(entry.relpath, file_sha1, i, c.start_line, c.end_line)
            ids.append(chunk_id)
            docs.append(c.text)
            meta = {
                "relpath": entry.relpath,
                "ext": entry.ext,
                "file_sha1": file_sha1,
                "chunk_index": i,
                "start_line": c.start_line,
                "end_line": c.end_line,
                "kind": c.kind,
                "name": c.name or "",
                "root": _first_segment(entry.relpath),
                "project": _project_segment(entry.relpath),
            }
            if c.extra:
                # Chroma metadata values must be scalars; JSON-encode the rest.
                meta["extra_json"] = json.dumps(c.extra, separators=(",", ":"))
            metas.append(meta)
        self._collection.upsert(
            ids=ids,
            documents=docs,
            embeddings=embeddings.tolist(),
            metadatas=metas,
        )
        return len(ids)

    def query(
        self,
        embedding: np.ndarray,
        k: int = 8,
        where: dict | None = None,
    ) -> dict:
        return self._collection.query(
            query_embeddings=[embedding.tolist()],
            n_results=k,
            where=where,
            include=["documents", "metadatas", "distances"],
        )

    def count(self) -> int:
        return self._collection.count()


def _stable_id(relpath: str, file_sha1: str, idx: int, sl: int, el: int) -> str:
    h = hashlib.sha1(f"{relpath}|{file_sha1}|{idx}|{sl}-{el}".encode("utf-8")).hexdigest()
    return h[:32]


def _first_segment(relpath: str) -> str:
    return relpath.split("/", 1)[0] if "/" in relpath else relpath


def _project_segment(relpath: str) -> str:
    """For paths like `.samples/<proj>/...` return `<proj>`; otherwise the
    first segment. Lets us filter chunks by project via a Chroma `where`
    clause instead of a post-hoc relpath substring match."""
    parts = relpath.split("/", 2)
    if len(parts) >= 2 and parts[0] == ".samples":
        return parts[1]
    return parts[0] if parts else ""
