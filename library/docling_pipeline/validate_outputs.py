from __future__ import annotations

import json
from pathlib import Path

REQUIRED_ARTIFACTS = {
    "document.md",
    "document.json",
    "document.doctags",
    "document.txt",
    "metadata.json",
}


def validate(extracted_root: Path) -> int:
    docs_root = extracted_root / "docs"
    manifest = extracted_root / "manifest.jsonl"

    if not docs_root.exists():
        print(f"Missing docs root: {docs_root}")
        return 1
    if not manifest.exists():
        print(f"Missing manifest: {manifest}")
        return 1

    exit_code = 0

    lines = manifest.read_text(encoding="utf-8").splitlines()
    for idx, line in enumerate(lines, start=1):
        try:
            record = json.loads(line)
        except json.JSONDecodeError as exc:
            print(f"Manifest parse error on line {idx}: {exc}")
            return 1

        slug = record.get("slug")
        if not slug:
            print(f"Manifest line {idx} missing slug")
            exit_code = 1
            continue

        doc_dir = docs_root / slug
        if not doc_dir.exists():
            print(f"Missing output directory for slug '{slug}': {doc_dir}")
            exit_code = 1
            continue

        present = {p.name for p in doc_dir.glob("*") if p.is_file()}
        missing = REQUIRED_ARTIFACTS - present
        if missing:
            print(f"Slug '{slug}' missing artifacts: {sorted(missing)}")
            exit_code = 1

    if exit_code == 0:
        print(f"Validation passed: {len(lines)} manifest entries checked")
    return exit_code


if __name__ == "__main__":
    root = Path("library/extracted")
    raise SystemExit(validate(root))
