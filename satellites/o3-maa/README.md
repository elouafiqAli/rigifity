# MAA American Mathematical Monthly — Submission Package

**Author:** Ali Elouafiq, Principal Research Engineer, SQLI Digital Laboratory, Levallois-Perret, France (`ali@sqli.com`)

**Title:** *The continuous-coefficient Jensen equation: A note on vestigial regularity hypotheses*

**Date assembled:** 2026-06-09

---

## Files in this package

| File | Purpose | Pages | Size |
|---|---|---|---|
| `manuscript.tex` | Canonical LaTeX source (with title page block) | — | — |
| `manuscript.pdf` | Canonical PDF with title page on page 1 | 10 | 240 KB |
| `manuscript-anon.tex` | Anonymous LaTeX source (title page suppressed) | — | — |
| `manuscript-anon.pdf` | Anonymous PDF (double-blind review copy) | 9 | 235 KB |
| `cover-letter.tex` | Cover letter LaTeX source | — | — |
| `cover-letter.pdf` | Cover letter PDF | 2 | 88 KB |
| `refs.bib` | Bibliography (NLM Vancouver style) | — | — |
| `maa-monthly.sty` | Official MAA Monthly style file (do not modify) | — | — |
| `vancouver.bst` | Bibliography style required by the Monthly | — | — |

## Build instructions (TeX Live 2024 or later)

```bash
pdflatex manuscript      # canonical
bibtex   manuscript
pdflatex manuscript
pdflatex manuscript

pdflatex manuscript-anon # anonymous
bibtex   manuscript-anon
pdflatex manuscript-anon
pdflatex manuscript-anon

pdflatex cover-letter    # cover letter (no bibliography)
```

All three documents build with zero overfull/underfull boxes and zero
undefined references on a clean TeX Live 2024+ install.

## Submission notes

- **Manuscript type:** Article (expository).
- **Word count:** ~3,400 words (TeX-counted body).
- **MSC 2020:** 39B22 (primary); 26B25, 91B16, 94A17 (secondary).
- **Submission portal:** Taylor & Francis ScholarOne.
- **Double-blind:** Upload `manuscript-anon.pdf` as the anonymous review copy
  and `manuscript.pdf` as the version with author details. The cover letter
  may be uploaded as `cover-letter.pdf`.
- **Preprint:** None deposited; the manuscript is not under consideration
  elsewhere.
- **AI disclosure:** A generative AI assistant was used for adversarial
  review of drafts and LaTeX/bibliography formatting; all mathematical
  content was conceived, verified, and refined by the author. This is
  disclosed in the manuscript Acknowledgments and the cover letter.
