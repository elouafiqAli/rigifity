# Review Gates

## Gate A: Build gate

- Dependency install succeeds from `requirements.txt`.
- Unit tests pass.
- Modal app imports without runtime errors.

## Gate B: Smoke extraction gate

- Run on 1-2 representative PDFs.
- Verify each output set contains `md`, `json`, `doctags`, `txt`, `metadata`.
- Confirm formulas/tables survive in markdown and json.

## Gate C: Throughput gate

- Launch full corpus extraction.
- Monitor worker fan-out and queueing behavior.
- Confirm no systemic timeout pattern.

## Gate D: Data integrity gate

- Validate `manifest.jsonl` is parseable line-by-line.
- Verify `artifact_hashes` exists for every artifact.
- Ensure every source PDF has exactly one latest output directory by slug.

## Gate E: Publication gate

- Run deterministic rerun check on a fixed subset.
- Compare output hash stability where expected.
- Record any nondeterministic fields (timestamps, order-only variance).
