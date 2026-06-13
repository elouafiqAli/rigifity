from __future__ import annotations

import json
import subprocess
from datetime import datetime, timezone
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parents[2]
LOG_PATH = REPO_ROOT / "library" / "extracted" / "job_log.jsonl"


def append_log(entry: dict) -> None:
    LOG_PATH.parent.mkdir(parents=True, exist_ok=True)
    with LOG_PATH.open("a", encoding="utf-8") as fh:
        fh.write(json.dumps(entry, ensure_ascii=False) + "\n")


def run_modal(app_py: str, pattern: str, output_root: str) -> int:
    # Normalize app path: allow passing either "rigifity/..." or "library/..."
    repo_name = REPO_ROOT.name
    if app_py.startswith(f"{repo_name}/"):
        app_arg = app_py[len(repo_name) + 1 :]
    else:
        app_arg = app_py

    out_dir = REPO_ROOT / output_root
    out_dir.mkdir(parents=True, exist_ok=True)

    cmd = [
        "modal",
        "run",
        app_arg,
        "--pattern",
        pattern,
        "--max-docs",
        "1",
        "--output-root",
        output_root,
    ]
    started = datetime.now(timezone.utc).isoformat()
    proc = subprocess.run(cmd, cwd=REPO_ROOT, capture_output=True, text=True)
    finished = datetime.now(timezone.utc).isoformat()

    entry = {
        "phase": "no_text",
        "file": pattern,
        "status": "success" if proc.returncode == 0 else "failed",
        "started_at": started,
        "finished_at": finished,
        "return_code": proc.returncode,
        "output_root": output_root,
        "stdout_tail": "\n".join(proc.stdout.splitlines()[-80:]),
        "stderr_tail": "\n".join(proc.stderr.splitlines()[-80:]),
    }
    append_log(entry)
    print(f"{pattern} -> {entry['status']} (rc={entry['return_code']})")
    return proc.returncode


if __name__ == '__main__':
    import sys

    if len(sys.argv) < 4:
        print("Usage: run_single_modal.py <app_py> <pattern> <output_root>")
        raise SystemExit(2)

    app_py = sys.argv[1]
    pattern = sys.argv[2]
    output_root = sys.argv[3]
    raise SystemExit(run_modal(app_py=app_py, pattern=pattern, output_root=output_root))
