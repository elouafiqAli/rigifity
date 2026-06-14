# AMM Submission Package (2026-06-14)

This folder contains a ready-to-submit package for The American Mathematical Monthly.

## Contents

- `source/manuscript.tex`: final manuscript source with title page + anonymous body.
- `source/manuscript-anonymous.tex`: anonymous-only source for double-blind upload.
- `source/cover-letter.tex`: submission cover letter source.
- `source/authors-contributions.tex`: author-contributions statement source.
- `pdf/manuscript-with-author.pdf`: compiled manuscript PDF from `manuscript.tex`.
- `pdf/manuscript-anonymous.pdf`: compiled anonymous PDF.
- `pdf/cover-letter.pdf`: compiled cover letter PDF.
- `pdf/authors-contributions.pdf`: compiled author-contributions PDF.
- `assets/figures/`: dedicated TikZ figure bundle with standalone source and PDF outputs.
  - `assets/figures/extract-tikz-pdfs.sh`: helper script that rebuilds the figure PDFs.
  - `assets/figures/dictionary/dictionary.tex`, `.pdf`, and `.eps`: load-diagram figure.
  - `assets/figures/mechanism/mechanism.tex`, `.pdf`, and `.eps`: endpoint-substitution figure.
  - `assets/figures/resolution/resolution.tex`, `.pdf`, and `.eps`: resolution-axis figure.
- `guidelines/maa-author-instructions.md`: local Monthly author instructions mirror.
- `guidelines/README-Author-Instructions.pdf`: template guideline PDF.
- `instructions.md`: anonymization and MAA figure-spec directives used for package generation.
- `assets/final_table.md`: supporting reference table used during drafting.
- `logs/`: optional build logs.

## Build notes

- Manuscript build requires `maa-monthly.sty` from `AMM_MAA Templates/Style File/`.
- If rebuilding manually, run from this repo root with:
  - `TEXINPUTS='AMM_MAA Templates/Style File//:' pdflatex -interaction=nonstopmode source/manuscript.tex`
  - run twice for cross-references.
- To rebuild the standalone TikZ figure PDFs, run `assets/figures/extract-tikz-pdfs.sh` from this folder.
