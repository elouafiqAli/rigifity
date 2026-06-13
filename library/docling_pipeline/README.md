# Modal + Docling Extraction Pipeline

This scaffold builds a high-throughput extraction pipeline focused on `library/`.

## Goals

- Convert every PDF in `library/` into parseable artifacts.
- Default to Docling VLM pipeline with Granite Docling.
- Parallelize aggressively on Modal GPU workers.
- Store outputs locally in `library/extracted/` with stable structure.
- Keep run metadata and hash manifests for auditability.

## Output contract

Per document:

- `document.md` for human-readable Markdown (formula-rich text preserved by Docling).
- `document.json` for lossless machine parsing.
- `document.doctags` for structure-first downstream pipelines.
- `document.txt` for fast lexical tooling.
- `metadata.json` with extraction settings and hashes.

Global:

- `manifest.jsonl` append-only ledger for all runs.
- `manifest-<run_id>.jsonl` run-scoped ledger.
- `run-<run_id>.json` run summary.

## Runbook

1. Install dependencies.

```bash
python -m pip install -r library/docling_pipeline/requirements.txt
```

2. Authenticate Modal once.

```bash
modal token new
```

3. Full extraction with max GPU fan-out allowed by account capacity.

```bash
modal run library/docling_pipeline/modal_app.py
```

4. Smoke run before full fan-out.

```bash
modal run library/docling_pipeline/modal_app.py --max-docs 2 --page-batch-size 8 --num-threads 4
```

## Throughput strategy

- One GPU worker per document via `extract_one.starmap(...)`.
- Worker shape: `A100-80GB`, 8 vCPU, 32 GB RAM.
- `concurrency_limit=64` allows broad scale-out while respecting account limits.
- PDF-internal parallelism enabled with Docling `--num-threads` and `--page-batch-size`.

## Model policy

Primary path:

- `docling --pipeline vlm --vlm-model granite_docling`
- Reference model family: `ibm-granite/granite-docling-258M`

If a newer upstream model becomes better validated for your corpus, bump only after adding a benchmark note in `planning/` and a gate sign-off.

## Testing

```bash
python -m unittest discover -s library/docling_pipeline/tests -p "test_*.py"
```

## Review gates

See:

- `planning/00-strategy.md`
- `planning/01-review-gates.md`
- `planning/02-commit-plan.md`
