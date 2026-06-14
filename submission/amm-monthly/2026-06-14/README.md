# AMM Submission Package (2026-06-14)

This folder contains a ready-to-submit package for The American Mathematical Monthly.

## Contents

- `source/manuscript.tex`: final manuscript source with title page + anonymous body.
- `source/manuscript-anonymous.tex`: anonymous-only source for double-blind upload.
- `source/cover-letter.tex`: submission cover letter source.
- `pdf/manuscript-with-author.pdf`: compiled manuscript PDF from `manuscript.tex`.
- `pdf/manuscript-anonymous.pdf`: compiled anonymous PDF.
- `pdf/cover-letter.pdf`: compiled cover letter PDF.
- `guidelines/maa-author-instructions.md`: local Monthly author instructions mirror.
- `guidelines/README-Author-Instructions.pdf`: template guideline PDF.
- `assets/final_table.md`: supporting reference table used during drafting.
- `logs/`: optional build logs.

## Build notes

- Manuscript build requires `maa-monthly.sty` from `AMM_MAA Templates/Style File/`.
- If rebuilding manually, run from this repo root with:
  - `TEXINPUTS='AMM_MAA Templates/Style File//:' pdflatex -interaction=nonstopmode source/manuscript.tex`
  - run twice for cross-references.
