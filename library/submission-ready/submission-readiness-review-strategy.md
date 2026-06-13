# Submission Readiness Review Strategy

Scope: `rigifity/library/submission-ready` only.

Sources to review:
- `manuscript.tex`
- `cover-letter.tex`

Sources explicitly excluded:
- `manuscript-anon.tex`
- all PDFs
- all files outside `submission-ready`

Review exclusions:
- Do not review references.
- Do not review diagrams or figure art.
- Do not review mathematical correctness.
- Do not change original TeX files.

Deliverables:
- `manuscript-review.tex`, a marked-up review copy of `manuscript.tex`.
- `cover-letter-review.tex`, a marked-up review copy of `cover-letter.tex`.
- `submission-readiness-review-log.md`, an execution log of decisions and edits.
- `manuscript-review.pdf`, compiled from `manuscript-review.tex`.

Markup convention:
- Additions use `\ReviewAdd{...}` in blue.
- Deletions use `\ReviewDel{...}` in red with strike-through.
- Edits preserve LaTeX correctness and are meant to be inspectable, not silent replacements.

Review strategy:
1. Abstract pass: improve hook, continuity, economy, and Monthly-facing exposition while preserving claims.
2. Introduction pass: smooth transitions among the three Jensen forms, the theorem, and the historical/structural motivation.
3. Body coherence pass: reduce local repetition, clarify paragraph chaining, and keep expository signposts crisp.
4. Recurrence/field-guide pass: ensure the taxonomy reads as a guide rather than a survey dump, without checking factual correctness or references.
5. Conclusion/provenance pass: tighten the final reader-facing claim and preserve authorial voice.
6. Cover-letter pass: keep fidelity to the paper, remove the Kuczma sentence as requested, and improve flow without changing submission facts.
7. Compile pass: build `manuscript-review.pdf`; if feasible, also build `cover-letter-review.pdf` as a convenience artifact.
