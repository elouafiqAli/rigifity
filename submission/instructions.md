# Submission Instructions

## Anonymous manuscript requirements

When producing an anonymized manuscript, remove all author-identifying and non-anonymous backmatter:

1. Remove all author names, affiliations, emails, and biographies.
2. Remove contribution statements.
3. Remove disclosure/conflict-of-interest statements that mention author identity.
4. Remove funding statements.
5. Remove AI-assistance disclosures if they identify author or affiliation context.
6. Keep the manuscript content, theorem numbering, figures, and bibliography intact.
7. Ensure comments in the anonymized source do not contain author names, affiliation, or email.

## MAA graphics specifications (apply to both full and anonymous manuscripts)

These apply to submission figures for AMM/MM/CMJ:

1. Line weight: minimum 0.5 pt, typically not above 1 pt.
2. Font family in graphics: Times New Roman (or matching manuscript Times style).
3. Font size targets:
   - Labels/text: 9 pt
   - Axes: 8 pt
4. Bitmap resolution: 300 dpi minimum at final size.
5. Do not scale bitmaps in LaTeX.
6. Printed-journal figure bounds: max 5 in wide and 8 in tall.
7. Prefer vector line art (EPS/SVG).
8. Export graphics from drawing tools (do not rely on Save As conversions).
9. PDF container does not automatically convert bitmap line art to vector.
10. For TikZ graphics, submit both TeX source and corresponding PDF for each figure.

## TikZ-specific baseline

For manuscript sources in this repository, use at least:

- `\tikzset{every picture/.style={line width=0.5pt}}`

and use explicit font sizes in nodes/axis labels where needed to meet 9 pt / 8 pt guidance.

## Operational rule for this repo

Whenever regenerating the anonymized manuscript for submission packages:

1. Verify no occurrences of author name, affiliation, or email remain.
2. Verify no contribution/disclosure/funding sections remain.
3. Rebuild the anonymized PDF from the anonymized source (not from the full source).
4. Keep this file as the governing instruction set for submission assembly.
