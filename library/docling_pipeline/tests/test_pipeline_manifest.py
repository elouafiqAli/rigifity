from __future__ import annotations

import json
import sys
import tempfile
import unittest
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))

from pipeline_manifest import append_manifest, sha256_text, slugify, write_payload


class PipelineManifestTests(unittest.TestCase):
    def test_slugify(self) -> None:
        self.assertEqual(slugify("AczelWagner1980.pdf"), "aczelwagner1980")
        self.assertEqual(slugify("  weird name!!.PDF"), "weird-name")

    def test_sha256_text(self) -> None:
        digest = sha256_text("abc")
        self.assertEqual(
            digest,
            "ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad",
        )

    def test_write_payload_and_manifest(self) -> None:
        payload = {
            "source_pdf": "Demo.pdf",
            "slug": "demo",
            "status": "success",
            "artifact_hashes": {"document.md": "123"},
            "files": {"document.md": "# Demo\n", "document.json": '{"a":1}'},
        }

        with tempfile.TemporaryDirectory() as tmp_dir:
            root = Path(tmp_dir)
            docs_root = root / "docs"
            manifest = root / "manifest.jsonl"

            out_dir = write_payload(docs_root, payload)
            self.assertTrue((out_dir / "document.md").exists())
            self.assertTrue((out_dir / "document.json").exists())
            self.assertTrue((out_dir / "metadata.json").exists())

            record = {"slug": "demo", "status": "success"}
            append_manifest(manifest, record)

            lines = manifest.read_text(encoding="utf-8").strip().splitlines()
            self.assertEqual(len(lines), 1)
            self.assertEqual(json.loads(lines[0]), record)


if __name__ == "__main__":
    unittest.main()
