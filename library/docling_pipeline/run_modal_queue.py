from __future__ import annotations

import json
import subprocess
from datetime import datetime, timezone
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parents[2]
PIPELINE_DIR = REPO_ROOT / "library" / "docling_pipeline"
SMALLEST3_PATH = PIPELINE_DIR / "targets_smallest3.json"
UNDER10_PATH = PIPELINE_DIR / "targets_under10.json"
LOG_PATH = REPO_ROOT / "library" / "extracted" / "job_log.jsonl"

PHASES = [
    ("smallest3", SMALLEST3_PATH, "library/extracted/tmp_smallest3"),
    ("under10", UNDER10_PATH, "library/extracted/tmp_under10"),
]


def load_completed_successes() -> set[str]:
    if not LOG_PATH.exists():
        return set()

    successes: set[str] = set()
    for line in LOG_PATH.read_text(encoding="utf-8").splitlines():
        if not line.strip():
            continue
        try:
            row = json.loads(line)
        except json.JSONDecodeError:
            continue
        if row.get("status") == "success":
            successes.add(row.get("file", ""))
    return successes


def append_log(entry: dict) -> None:
    LOG_PATH.parent.mkdir(parents=True, exist_ok=True)
    with LOG_PATH.open("a", encoding="utf-8") as handle:
        handle.write(json.dumps(entry, ensure_ascii=False) + "\n")


def run_doc(phase: str, file_name: str, pages: int, output_root: str) -> int:
    cmd = [
        "modal",
        "run",
        "library/docling_pipeline/modal_app.py",
        "--pattern",
        file_name,
        "--max-docs",
        "1",
        "--page-batch-size",
        "8",
        "--num-threads",
        "4",
        "--output-root",
        output_root,
    ]

    started = datetime.now(timezone.utc).isoformat()
    proc = subprocess.run(cmd, cwd=REPO_ROOT, capture_output=True, text=True)
    finished = datetime.now(timezone.utc).isoformat()

    status = "success" if proc.returncode == 0 else "failed"
    entry = {
        "phase": phase,
        "file": file_name,
        "pages": pages,
        "status": status,
        "started_at": started,
        "finished_at": finished,
        "return_code": proc.returncode,
        "output_root": output_root,
        "stdout_tail": "\n".join(proc.stdout.splitlines()[-40:]),
        "stderr_tail": "\n".join(proc.stderr.splitlines()[-40:]),
    }
    append_log(entry)

    print(f"[{phase}] {file_name} pages={pages} -> {status} (rc={proc.returncode})")
    return proc.returncode


def main() -> int:
    completed = load_completed_successes()
    overall_rc = 0

    for phase, targets_path, output_root in PHASES:
        targets = json.loads(targets_path.read_text(encoding="utf-8"))
        print(f"=== Phase {phase}: {len(targets)} targets ===")

        for item in targets:
            file_name = item["file"]
            pages = int(item["pages"])
            if file_name in completed:
                print(f"[{phase}] skip (already successful): {file_name}")
                continue

            rc = run_doc(phase=phase, file_name=file_name, pages=pages, output_root=output_root)
            if rc != 0:
                overall_rc = 1

    print(f"Log written to: {LOG_PATH}")
    return overall_rc


if __name__ == "__main__":
    raise SystemExit(main())
