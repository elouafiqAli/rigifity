from __future__ import annotations

import hashlib
import json
import re
from pathlib import Path
from typing import Any

_SLUG_SAFE = re.compile(r"[^a-z0-9]+")


def slugify(filename: str) -> str:
    stem = Path(filename).stem.lower().strip()
    slug = _SLUG_SAFE.sub("-", stem).strip("-")
    return slug or "document"


def sha256_text(text: str) -> str:
    return hashlib.sha256(text.encode("utf-8")).hexdigest()


def write_payload(docs_root: Path, payload: dict[str, Any]) -> Path:
    slug = payload["slug"]
    output_dir = docs_root / slug
    output_dir.mkdir(parents=True, exist_ok=True)

    files = payload.get("files", {})
    for rel_path, content in files.items():
        target = output_dir / rel_path
        target.parent.mkdir(parents=True, exist_ok=True)
        target.write_text(content, encoding="utf-8")

    metadata = {k: v for k, v in payload.items() if k != "files"}
    (output_dir / "metadata.json").write_text(
        json.dumps(metadata, indent=2, ensure_ascii=False),
        encoding="utf-8",
    )
    return output_dir


def append_manifest(manifest_path: Path, record: dict[str, Any]) -> None:
    manifest_path.parent.mkdir(parents=True, exist_ok=True)
    with manifest_path.open("a", encoding="utf-8") as handle:
        handle.write(json.dumps(record, ensure_ascii=False) + "\n")
