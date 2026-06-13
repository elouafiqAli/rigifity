from __future__ import annotations

import hashlib
import json
import re
import subprocess
import tempfile
from datetime import datetime, timezone
from pathlib import Path
from typing import Any

import modal

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


APP_NAME = "rigifity-library-docling-md-text"
DOCLING_VERSION = "2.102.1"
VLM_MODEL_PRESET = "granite_docling"
VLM_MODEL_REPO = "ibm-granite/granite-docling-258M"

_THIS_FILE = Path(__file__).resolve()
if len(_THIS_FILE.parents) >= 3 and (_THIS_FILE.parents[2] / "library").exists():
    REPO_ROOT = _THIS_FILE.parents[2]
else:
    REPO_ROOT = Path.cwd()
LIBRARY_DIR = REPO_ROOT / "library"
DEFAULT_OUTPUT_ROOT = LIBRARY_DIR / "extracted"
DEFAULT_DOCS_ROOT = DEFAULT_OUTPUT_ROOT / "docs"
DEFAULT_MANIFEST = DEFAULT_OUTPUT_ROOT / "manifest.jsonl"

image = modal.Image.debian_slim(python_version="3.11").pip_install(
    f"docling=={DOCLING_VERSION}",
)

app = modal.App(APP_NAME)


@app.function(
    image=image,
    gpu="A100-80GB",
    cpu=8.0,
    memory=32768,
    timeout=60 * 60,
    retries=1,
    max_containers=8,
)
def extract_one(
    pdf_filename: str,
    pdf_bytes: bytes,
    page_batch_size: int = 16,
    num_threads: int = 8,
    document_timeout_s: float = 3600.0,
) -> dict[str, Any]:
    slug = slugify(pdf_filename)
    started_at = datetime.now(timezone.utc).isoformat()

    with tempfile.TemporaryDirectory(prefix=f"docling-{slug}-") as tmp_dir:
        source_path = Path(tmp_dir) / pdf_filename
        source_path.write_bytes(pdf_bytes)

        output_dir = Path(tmp_dir) / "output"
        output_dir.mkdir(parents=True, exist_ok=True)

        # Export only markdown and plain text to reduce returned blob size
        command = [
            "docling",
            str(source_path),
            "--from",
            "pdf",
            "--to",
            "md",
            "--to",
            "text",
            "--pipeline",
            "vlm",
            "--vlm-model",
            VLM_MODEL_PRESET,
            "--device",
            "cuda",
            "--num-threads",
            str(num_threads),
            "--page-batch-size",
            str(page_batch_size),
            "--document-timeout",
            str(document_timeout_s),
            "--abort-on-error",
            "--output",
            str(output_dir),
        ]

        proc = subprocess.run(command, capture_output=True, text=True, check=False)
        if proc.returncode != 0:
            raise RuntimeError(
                "Docling CLI failed for "
                f"{pdf_filename} with exit code {proc.returncode}\n"
                f"stdout:\n{proc.stdout}\n"
                f"stderr:\n{proc.stderr}"
            )

        files: dict[str, str] = {}
        hashes: dict[str, str] = {}
        for artifact in sorted(output_dir.rglob("*")):
            if not artifact.is_file():
                continue
            rel = artifact.relative_to(output_dir).as_posix()
            text = artifact.read_text(encoding="utf-8", errors="replace")
            files[rel] = text
            hashes[rel] = sha256_text(text)

    finished_at = datetime.now(timezone.utc).isoformat()
    return {
        "source_pdf": pdf_filename,
        "slug": slug,
        "status": "success",
        "started_at": started_at,
        "finished_at": finished_at,
        "vlm_model_preset": VLM_MODEL_PRESET,
        "vlm_model_repo": VLM_MODEL_REPO,
        "docling_version": DOCLING_VERSION,
        "gpu": "A100-80GB",
        "page_batch_size": page_batch_size,
        "num_threads": num_threads,
        "document_timeout_s": document_timeout_s,
        "artifact_hashes": hashes,
        "files": files,
    }


def _iter_pdf_names(pattern: str) -> list[str]:
    pdfs = sorted(path.name for path in LIBRARY_DIR.glob(pattern) if path.is_file() and path.suffix.lower() == ".pdf")
    return pdfs


@app.local_entrypoint()
def run(
    pattern: str = "*.pdf",
    output_root: str = str(DEFAULT_OUTPUT_ROOT),
    page_batch_size: int = 16,
    num_threads: int = 8,
    max_docs: int = 0,
) -> None:
    pdf_names = _iter_pdf_names(pattern)
    if max_docs > 0:
        pdf_names = pdf_names[:max_docs]

    if not pdf_names:
        raise RuntimeError(f"No PDFs matched pattern '{pattern}' in {LIBRARY_DIR}")

    out_root = Path(output_root)
    docs_root = out_root / "docs"
    manifest_path = out_root / "manifest.jsonl"
    docs_root.mkdir(parents=True, exist_ok=True)

    run_id = datetime.now(timezone.utc).strftime("%Y%m%dT%H%M%SZ")
    session_manifest_path = out_root / f"manifest-{run_id}.jsonl"

    jobs = [
        (
            name,
            (LIBRARY_DIR / name).read_bytes(),
            page_batch_size,
            num_threads,
            3600.0,
        )
        for name in pdf_names
    ]

    payloads = extract_one.starmap(
        jobs,
        order_outputs=False,
    )

    processed = 0
    for payload in payloads:
        write_payload(docs_root=docs_root, payload=payload)

        record = {
            "source_pdf": payload["source_pdf"],
            "slug": payload["slug"],
            "status": payload["status"],
            "started_at": payload["started_at"],
            "finished_at": payload["finished_at"],
            "docling_version": payload["docling_version"],
            "vlm_model_preset": payload["vlm_model_preset"],
            "vlm_model_repo": payload["vlm_model_repo"],
            "gpu": payload["gpu"],
            "page_batch_size": payload["page_batch_size"],
            "num_threads": payload["num_threads"],
            "document_timeout_s": payload["document_timeout_s"],
            "artifact_hashes": payload["artifact_hashes"],
        }
        append_manifest(manifest_path, record)
        append_manifest(session_manifest_path, record)
        processed += 1

    run_summary = {
        "run_id": run_id,
        "processed": processed,
        "pattern": pattern,
        "output_root": str(out_root),
        "docling_version": DOCLING_VERSION,
        "vlm_model_repo": VLM_MODEL_REPO,
        "vlm_model_preset": VLM_MODEL_PRESET,
    }
    (out_root / f"run-{run_id}.json").write_text(json.dumps(run_summary, indent=2), encoding="utf-8")
    print(json.dumps(run_summary, indent=2))
