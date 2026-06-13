# Commit Plan (Strong, Reviewable Units)

## Commit 1: Rebase + structure seed

- Rebase local branch onto `origin/main`.
- Add `library/README.md` and `library/extracted/README.md`.

Message template:

- `chore(library): rebase on upstream and establish extraction sink contract`

## Commit 2: Modal extraction core

- Add `modal_app.py` with GPU fan-out extraction.
- Add `pipeline_manifest.py` helpers.
- Add dependency file.

Message template:

- `feat(library): add modal docling gpu pipeline with structured outputs`

## Commit 3: Tests + review gates + planning

- Add unit tests for output/manifest helpers.
- Add strategy and gate docs.
- Add operational runbook.

Message template:

- `docs+test(library): add phased strategy, quality gates, and scaffold tests`
