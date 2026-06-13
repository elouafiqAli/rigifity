from __future__ import annotations

import json
from pathlib import Path

LOG = Path(__file__).resolve().parents[2] / "library" / "extracted" / "embedded_texts" / "embedded_texts_log.jsonl"
BASE = LOG.parent

if not LOG.exists():
    raise SystemExit("Log file not found: %s" % LOG)

lines = LOG.read_text(encoding="utf-8").splitlines()
new_lines = []

for line in lines:
    if not line.strip():
        continue
    row = json.loads(line)
    out_dir = row.get("out_dir")
    if not out_dir:
        new_lines.append(row)
        continue
    out_path = Path(out_dir)
    if not out_path.exists():
        # Try to resolve relative to repo
        candidate = BASE / out_path.name
        if candidate.exists():
            out_path = candidate
        else:
            new_lines.append(row)
            continue

    orig_file = row.get("file")
    stem = Path(orig_file).stem
    target = BASE / stem
    suffix = 1
    while target.exists() and target.resolve() != out_path.resolve():
        target = BASE / f"{stem}_{suffix}"
        suffix += 1

    if out_path.resolve() == target.resolve():
        # already correct
        row["out_dir"] = str(target)
        new_lines.append(row)
        continue

    out_path.rename(target)
    row["out_dir"] = str(target)
    new_lines.append(row)
    print(f"Renamed {out_path.name} -> {target.name}")

# Write back updated log
LOG.write_text("\n".join(json.dumps(r, ensure_ascii=False) for r in new_lines) + "\n", encoding="utf-8")
print("Done")
