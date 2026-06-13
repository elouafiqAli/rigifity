# Extracted Corpus Outputs

This directory is the local sink for parsed outputs produced by the Docling + Modal pipeline in `library/docling_pipeline/`.

Expected structure after a run:

- `docs/<document-slug>/document.md`
- `docs/<document-slug>/document.json`
- `docs/<document-slug>/document.doctags`
- `docs/<document-slug>/document.txt`
- `docs/<document-slug>/metadata.json`
- `manifest.jsonl`

`manifest.jsonl` is machine-oriented and can be consumed directly for indexing, retrieval, and downstream QA checks.
