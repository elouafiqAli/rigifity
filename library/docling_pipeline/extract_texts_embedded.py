from __future__ import annotations

import json
from pathlib import Path
from typing import Dict

import sys
import subprocess

try:
    from pypdf import PdfReader
except Exception:
    # Attempt a best-effort install into the current Python environment
    try:
        subprocess.run([sys.executable, "-m", "pip", "install", "pypdf"], check=True)
        from pypdf import PdfReader
    except Exception:
        raise SystemExit("pypdf is required and could not be installed automatically. Activate your venv and `pip install pypdf` then re-run.")

REPO_ROOT = Path(__file__).resolve().parents[2]
LIBRARY_DIR = REPO_ROOT / "library"
OUT_ROOT = REPO_ROOT / "library" / "extracted" / "embedded_texts"
LOG_PATH = OUT_ROOT / "embedded_texts_log.jsonl"


def slugify(name: str) -> str:
    s = Path(name).stem.lower()
    return "-".join(c if c.isalnum() else "-" for c in s).strip("-") or "document"


def load_log() -> Dict[str, Dict]:
    if not LOG_PATH.exists():
        return {}
    out = {}
    for line in LOG_PATH.read_text(encoding="utf-8").splitlines():
        if not line.strip():
            continue
        try:
            row = json.loads(line)
        except json.JSONDecodeError:
            continue
        out[row.get("file")] = row
    return out


def append_log(entry: Dict) -> None:
    LOG_PATH.parent.mkdir(parents=True, exist_ok=True)
    with LOG_PATH.open("a", encoding="utf-8") as fh:
        fh.write(json.dumps(entry, ensure_ascii=False) + "\n")


def extract_embedded_text(pdf_path: Path) -> str:
    reader = PdfReader(str(pdf_path))
    texts = []
    for page in reader.pages:
        try:
            t = page.extract_text() or ""
        except Exception:
            t = ""
        texts.append(t)
    return "\n\n".join(texts).strip()


def main():
    completed = load_log()

    pdfs = sorted(p for p in LIBRARY_DIR.glob("*.pdf") if p.is_file())
    print(f"Found {len(pdfs)} PDFs in {LIBRARY_DIR}")

    for pdf in pdfs:
        fname = pdf.name
        if fname in completed and completed[fname].get("status") == "success":
            print(f"skip (already extracted): {fname}")
            continue

        print(f"processing: {fname}")
        text = extract_embedded_text(pdf)
        started = __import__("datetime").datetime.utcnow().isoformat() + "Z"
        if text:
            slug = slugify(fname)
            out_dir = OUT_ROOT / slug
            out_dir.mkdir(parents=True, exist_ok=True)
            (out_dir / "document.txt").write_text(text, encoding="utf-8")
            (out_dir / "metadata.json").write_text(
                json.dumps({"file": fname, "pages": len(text.splitlines()), "slug": slug}, indent=2),
                encoding="utf-8",
            )
            entry = {"file": fname, "status": "success", "started_at": started, "finished_at": __import__("datetime").datetime.utcnow().isoformat() + "Z", "out_dir": str(out_dir)}
            append_log(entry)
            print(f"wrote embedded text for {fname} -> {out_dir}")
        else:
            entry = {"file": fname, "status": "no_text", "started_at": started, "finished_at": __import__("datetime").datetime.utcnow().isoformat() + "Z"}
            append_log(entry)
            print(f"no embedded text in {fname}")


if __name__ == '__main__':
    raise SystemExit(main())
