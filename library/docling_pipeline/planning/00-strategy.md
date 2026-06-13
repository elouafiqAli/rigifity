# Strategy: Multi-Phase Library Extraction

## Objective

Build a reproducible, high-capacity, audit-friendly extraction system for `library/` with Modal + Docling.

## Frame

On the one hand:

- We need maximal throughput and broad GPU parallelism.
- We need to preserve rich structure (math/formulas/tables) for downstream reasoning.

On the other hand:

- We need strict reproducibility and deterministic artifacts.
- We need review checkpoints so scaling does not hide extraction regressions.

## Phases

### Phase 0: Baseline and rebase hygiene

- Keep local library additions and markdown additions.
- Rebase branch on latest upstream main.
- Confirm clean git status before scaffold work.

Exit criteria:

- Branch rebased without conflict loss.
- No unstaged changes.

### Phase 1: Pipeline scaffold

- Create `library/docling_pipeline/` with Modal app and runbook.
- Define output contract (`md`, `json`, `doctags`, `txt`, `metadata`, manifests).

Exit criteria:

- `modal run` entrypoint exists.
- `library/extracted/README.md` defines sink contract.

### Phase 2: Parallel GPU extraction

- Use one Modal GPU function invocation per document.
- Configure VLM mode with Granite Docling preset.
- Tune page batching and thread count for throughput.

Exit criteria:

- Smoke run passes on a subset.
- Full run command documented and deterministic.

### Phase 3: Validation and audit trail

- Emit per-artifact hashes.
- Append run-level and global manifest ledgers.
- Add unit tests for manifest and file contracts.

Exit criteria:

- Unit tests pass.
- Manifests are valid JSONL.

### Phase 4: Review gates and release discipline

- Add mandatory quality gates before broad extraction and before publication.
- Encode commit sequence so each merge is reviewable.

Exit criteria:

- Gate checklist available in repository.
- Commit plan available and actionable.
