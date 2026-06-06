"""Sentence-transformers wrapper with lazy loading."""

from __future__ import annotations

import functools
from typing import Iterable

import numpy as np

from indexer.config import EmbeddingCfg


class Embedder:
    """Lazy wrapper around a SentenceTransformer model."""

    def __init__(self, cfg: EmbeddingCfg) -> None:
        self.cfg = cfg
        self._model = None  # loaded on first use

    @functools.cached_property
    def model(self):  # type: ignore[no-untyped-def]
        # Heavy import deferred so --help / stats don't pay the cost.
        from sentence_transformers import SentenceTransformer
        return SentenceTransformer(self.cfg.model)

    def encode_documents(self, texts: list[str]) -> np.ndarray:
        return self.model.encode(
            texts,
            batch_size=self.cfg.batch_size,
            show_progress_bar=False,
            convert_to_numpy=True,
            normalize_embeddings=True,
        )

    def encode_query(self, text: str) -> np.ndarray:
        prefixed = (self.cfg.query_prefix or "") + text
        return self.model.encode(
            [prefixed],
            batch_size=1,
            show_progress_bar=False,
            convert_to_numpy=True,
            normalize_embeddings=True,
        )[0]

    @property
    def dim(self) -> int:
        return int(self.model.get_sentence_embedding_dimension())
