# Phase B — CRAS Mathématique format reconnaissance

*Read-only memo, authored 2026-06-06 by Coordinator. Sources fetched the same day from `comptes-rendus.academie-sciences.fr` and `centre-mersenne.org` (verbatim citations in §6 below). Single source of truth for CRAS-Mathématique submission requirements that the rest of the strategy ([`06-cras-strategy.md`](06-cras-strategy.md)) consumes.*

---

## 0. Headline

CRAS Mathématique is a **Diamond Open Access** electronic journal, peer-reviewed, published by the Académie des sciences via the Centre Mersenne (and co-published with the CNRS since 2026-01-01). It accepts **French or English** submissions, with **LaTeX mandatory**. The editorial board's spring-2025 policy update emphasizes accessibility to a **wide audience of mathematicians** (cross-field, but not popularization for a non-mathematician audience). 2025 acceptance rate: ≈ 11.2 % (54 accepted of 482 submitted); median submission-to-publication time ≈ 251 days.

For the chord-substitution note this is the right venue: short, broad-mathematics scope, fast for a refereed math journal, no fees, Diamond Open Access, and aligned with the editorial direction.

---

## 1. Editorial scope and audience (Spring 2025 policy)

Verbatim from the journal's *Our journal* page:

> *"The editorial board of Comptes Rendus Mathématique wishes to orient the journal towards submissions that will be of interest to a wide audience of mathematicians, and even beyond, without falling into the category of popularization aimed at a non-mathematician public."*

Three submission categories explicitly prioritized:

1. *State of the art on active fields*, including a historical overview, the most significant recent advances, and outstanding conjectures.
2. *Targeted presentations of recent and significant results*, written to be accessible beyond the specialist community. These articles can:
   - complement detailed results published in more specialized journals, focusing on scope and context;
   - be written by authors *from outside the work itself*, in the spirit of the Bourbaki seminar.
3. *More traditional research articles*, written as accessibly as possible; contributions establishing links between different sub-fields of mathematics are valued.

**Assessment of fit for the chord-substitution note.** Category 2 — *targeted presentation of a small but recurrent result, accessible beyond the functional-equations specialist community*. The note is short, sits at the analysis/decision-theory boundary, and articulates a teaching-and-citation contribution. The editorial direction is favourable.

---

## 2. Submission gates (HARD constraints — failure = rejection without review)

Re-stated and numbered here for cross-reference from [`06-cras-strategy.md`](06-cras-strategy.md) §2.

### G-1. Author must have a university or research-organization affiliation

Verbatim:

> *"Only authors affiliated with universities or research organizations (in any country) are authorized to submit articles to our journals. Manuscripts submitted by independent researchers will be rejected without review."*

**Status:** **Not yet confirmed for the author.** This is the decisive gate. If the author cannot list an institutional affiliation in OJS, the submission will be rejected without evaluation. Mitigation: the satellite re-targets *Expositiones Mathematicae* (Fallback 1), which has no such rule.

### G-2. Submission quota: at most 3 manuscripts in the past 12 months

Verbatim:

> *"Please note: we may automatically decline publication when a (co)author has already submitted 3 manuscripts in the past year."*

**Status:** Most likely OK (this is the author's first CRAS submission). Verify before dispatch.

### G-3. The article has not been submitted to another journal

Verbatim:

> *"L'article n'a été soumis à aucune autre revue (y compris dans une autre langue)."*

**Status:** OK — the satellite has not been submitted anywhere.

### G-4. Bilingual metadata is mandatory

Verbatim:

> *"If your article is written in English: Providing a title, abstract and keywords in English is mandatory. We would also be grateful if you could provide us with a French translation of your title, abstract and keywords. If this metadata in French is not provided by the authors, the editorial team will automatically translate the English metadata."*

> *"If your article is written in French, providing a title, an abstract and keywords in French AND in English is mandatory."*

**Status:** We will provide *full* bilingual metadata (and the full body in both languages — much stronger than the minimum). Closed in Phases D + F + H.

### G-5. LaTeX source + compiled PDF + BibTeX bibliography

Verbatim:

> *"For Comptes Rendus Mathématique, submission in TeX format is mandatory. All submissions in TeX format must include at least three elements:*
> *• The full text of the article in TeX format (source file);*
> *• The full text of the article in PDF format (compiled file);*
> *• The article's bibliography in BIB format."*

**Status:** Closed in Phase I (LaTeX harness).

### G-6. Centre Mersenne LaTeX class

Verbatim:

> *"Authors are requested to use [the journal's LaTeX class and the associated bibtex style](http://www.centre-mersenne.org/pack_author/)."*

The package is `pack_author-crmath.zip`, downloadable from `https://www.centre-mersenne.org/media/texmf/pack_author-crmath.zip`. **Status:** Class file URL confirmed; download + integration is part of Phase I. Phase I also ships a fallback `amsart` configuration in case the class file cannot be installed locally.

### G-7. Declaration of interests required in body

Verbatim:

> *"Declaration of interests: if you have no conflict of interest to declare, please include the following statement: 'The authors do not work for, advise, own shares in, or receive funds from any organisation that could benefit from this article, and have declared no affiliation other than their research organisations'."*

**Status:** Closed in Phase D (Draft 0.3 closure).

### G-8. MSC2020 classification (CR Mathématique only)

Verbatim:

> *"CR Mathématique only: the mathematical classification to which the subject of your article relates."*

**Status:** Already in Draft 0.2: **39B22** (Functional equations on real intervals), **39B05** (General theory of functional equations), **26A51** (Convexity of real functions in one variable). Verified appropriate.

### G-9. No copyright-protected material without CC-BY-4.0 permission

**Status:** Trivially OK — the note has no figures, no tables-from-elsewhere, no images.

---

## 3. Format requirements (compositional)

### 3.1 Length

> *"Comptes Rendus Mathématique covers all the fields of the discipline: algebra, analysis, geometry, logic, probability, applied mathematics, etc. Articles are published in English or French, with no limit in length and in a format as flexible as necessary (figures, associated data, etc.)."*

**No hard limit.** The expectation for short notes is ~4–8 typeset pages; the Draft 0.2 is ~6 pages of Markdown which will compile to roughly 5 pages under `crmath`. Length is not a constraint for this satellite.

### 3.2 Language

English or French. Author chooses; bilingual metadata required either way (G-4). For this satellite both will be provided.

### 3.3 Body structure (mandatory)

- **Sections numbered in Roman numerals** (top level: I, II, III, …); **sub-sections in decimal** (1.1, 1.1.1). The current Markdown uses Arabic 1, 2, 3 for top-level — to be converted to Roman in LaTeX.
- **Double-spaced, numbered lines** (this is the *submission* version; the published version is single-spaced).
- **Declaration of interests** as a dedicated section before the bibliography.
- **References** as a final bibliography, no sub-sections.
- **Acknowledgements** as a separate section before references (not on the title page, not in a footnote).

### 3.4 Mathematical formulas

> *"Number them (if they are explicitly mentioned in the text); in editable text form (no images); ensure that a given quantity is always designated by the same symbol in the same font; use the solidus (/) instead of a horizontal line for small fractional terms; carefully place superscripts and subscripts; avoid ambiguous expressions such as 1/2x — write either 1/(2x) or (1/2)x; write variables in italics; indicate powers of e by exp."*

The Markdown drafts mostly already comply. LaTeX conversion (Phase I) needs:
- Equation numbering for the equations cited in text: $(\star)$, $(\star_0)$, $(J_2)$, $(J_{\mathbb Q})$ — already named.
- `\exp` not `e^x` where the exponent is complicated. (Not relevant in this note.)
- Variables in `$ ... $` (italic by default in math mode).

### 3.5 Tables

> *"Use only one grid for each individual table, not one grid for each row; align columns using tabs (not spaces) if your table does not have a grid; number your tables using Roman numerals, in the order in which they appear in the article; avoid vertical lines within tables; provide a caption for each table."*

Draft 0.2 has one table (Table 1, the regularity-hypothesis dictionary). LaTeX conversion: use the `crmath`-provided table style (or `booktabs` if not available), Roman-numeral table label.

### 3.6 Figures

None in this note. N/A.

### 3.7 Conventions and abbreviations

> *"Any unusual conventions or abbreviations must be defined in parentheses after their first mention in the text. Please use only internationally accepted units and nomenclature (ISO 31 and ISO 1000)."*

None relevant in this note (no units).

### 3.8 Cited-quantity hygiene

Same symbol = same font. The Draft 0.2 uses $G$, $\varphi_{\max}$, $u_1$, $u_2$, $p$, $M$, $\mathbb R$, $\mathbb Q$, $I$ consistently. LaTeX conversion (Phase I) will preserve this.

---

## 4. Bibliography conventions (numeric, CR-Mathématique-specific)

### 4.1 In-text citation

> *"For Comptes Rendus Mathématique, Mécanique, Physique or Chimie (numerical style): Indicate the number of your reference in square brackets, listing them sequentially as they appear in the text."*

> *"If you wish to cite several references at the same time, assign each one a number and separate them with a semicolon. E.g.: [25; 26]."*

> *"If necessary, specify the exact page number of the passage/figure to which you are referring, bearing in mind that the overall pagination of the journal article or book chapter cited will appear in the final bibliography. E.g.: [42, p. 283]."*

**Convention.** In-text citations are `[N]` or `[N; M]` or `[N, p. PP]`. The Draft 0.2's existing format `[1]`, `[B1]`, `[El1]` is non-conforming — to be renumbered as sequential `[1], [2], …` for the LaTeX version.

### 4.2 Bibliography list (the Mathematics-series exception)

> *"Arrange your references in the order in which they are cited in the text;"*

Followed by a specific override for the mathematics series:

> *"In the Mathematics series, authors' names will be listed in alphabetical order."*

**Resolution.** The CR Mathématique convention is: cite in text as `[N]`, but the bibliography itself is ordered alphabetically by first-author surname (with `[N]` then matching the alphabetical position). This is the standard mathematics-journal convention (cf. *Annals of Mathematics*, *Inventiones*, *Bourbaki Seminar*) and the `pack_author-crmath` BibTeX style implements it automatically.

For the chord-substitution note the references are (alphabetical by first-author surname):
1. Aczél (1966) — *Lectures on Functional Equations…*
2. Aczél, Dhombres (1989) — *Functional Equations in Several Variables*
3. Bartlett, Jordan, McAuliffe (2006) — Convexity, classification, and risk bounds
4. Boas (1981) — *A Primer of Real Functions*
5. Cauchy (1821) — *Cours d'analyse…*
6. Darboux (1875) — Mémoire sur les fonctions discontinues
7. [El1] / [El2] — main paper, author placeholder (alphabetical position depends on actual surname)
8. Hamel (1905) — Eine Basis aller Zahlen…
9. Kuczma (2009) — *An Introduction to the Theory of Functional Equations…*
10. Ostrowski (1929) — Über die Funktionalgleichung der Exponentialfunktion…
11. Reid, Williamson (2010) — Composite binary losses
12. Reid, Williamson (2011) — Information, divergence and risk…
13. Sierpiński (1920) — Sur les fonctions convexes mesurables
14. Steinhaus (1920) — Sur les distances des points…
15. Steinwart (2007) — How to compare different loss functions…
16. Tewari, Bartlett (2007) — On the consistency of multiclass classification methods

The renumbering happens automatically when BibTeX processes the `.bib` file with the `crmath` style. The Draft 0.3 manuscripts (en + fr) can still use named placeholders like `\cite{Aczel1966}` until the BibTeX style assigns final numbers.

### 4.3 Bibliography entry format (verbatim sample from CRAS instructions)

> *"[1] Xiaoli Chen, …, Sebastian Neubert, 'Open is not enough', Nature Physics 15 (2019), pp. 113–119, https://doi.org/10.1038/s41567-018-0342-2."*

Pattern observed:

- All authors enumerated (no `et al.` in the journal-citation form; "et al." is acceptable only in the in-text citation if >3 authors, per the author-date Géoscience rule, which does *not* apply here).
- Article title in plain text inside double quotation marks.
- Journal name in italic (via the BibTeX style).
- Volume in italic (e.g. *15*).
- Year in parentheses.
- pp. range with en-dash.
- DOI as URL.

Monograph pattern:

> *"[1] Peter Broks, Understanding popular science, 4th edition, MacGrow-Hill Education: London, 2016."*

- Author, *Title*, edition, Publisher: City, Year.

For BibTeX preparation in Phase I: use `@article{}`, `@book{}`, `@incollection{}`, `@misc{}` as appropriate; the `crmath` style handles the rest.

### 4.4 CSL file (optional, for Zotero users)

Provided by CRAS at `https://comptes-rendus.academie-sciences.fr/media/CR/uploads/2024/08/19/20240816_cr_numeric.csl` (despite the filename being `numeric`, this is the file linked from the math-series page and used by the mathematics-series alphabetical convention).

---

## 5. Editorial process and timing (information only)

From the *Our journal* page:

- All manuscripts first evaluated by editor-in-chief (or guest editor / associate editor) for fit to journal criteria.
- Peer review process initiated once first step completed.
- Authors revise as needed; final version validated.
- Final version sent to Centre Mersenne layout team; proofs sent to corresponding author for verification (only formal corrections at this stage).

**2025 figures (from the journal's own report):**

- Submissions: 482
- Reviews requested: 287
- Reviews received: 198
- Manuscripts accepted: 54 (**11.2 % acceptance rate**)
- Mean submission-to-publication: 316 days
- Median submission-to-publication: 251 days

**Implication for the strategy.** Acceptance rate is realistic for a Diamond Open Access journal with low-prestige-but-real peer review. The expected median publication date is roughly 8 months after dispatch. The fallback to *Expositiones Mathematicae* (Fallback 1, no affiliation requirement) is the safety net.

**Editorial board (2026):** Olivier Debarre, Hugo Duminil-Copin, Bertrand Maury (editors-in-chief).

---

## 6. Verbatim source citations

Source pages fetched 2026-06-06:

1. `https://comptes-rendus.academie-sciences.fr/page/instructions-auteurs/` — "Contents of the manuscript to be submitted." Authoritative for: files-to-be-provided, LaTeX-mandatory-for-CR-Mathématique, language (bilingual metadata), length (no hard limit), mandatory elements (title / authors / affiliation gate / abstract ≤250 words / 3–7 keywords / MSC for CR Mathématique only), body structure (double-spaced, numbered lines, Roman section numbers), declaration of interests, mathematical formulas, tables, figures, conventions, special-instructions-for-ancient-sources (not applicable).

2. `https://comptes-rendus.academie-sciences.fr/page/composition-manuscrit/` — same content as (1) on the French-language version of the page (slightly different wording in places).

3. `https://comptes-rendus.academie-sciences.fr/mathematique/` — journal home page. Authoritative for: editorial direction (Diamond OA, French+English, no length limit), editorial board (Debarre, Duminil-Copin, Maury), ISSN (1631-073X print, 1778-3569 electronic), latest articles.

4. `https://comptes-rendus.academie-sciences.fr/mathematique/page/our-journal/` — authoritative for: 2025-and-after editorial policy (wide-mathematics-audience, not specialist, not non-mathematician), editorial-process steps, 2025 figures (482 / 287 / 198 / 54 / 316 / 251), single-blind peer review.

5. `https://comptes-rendus.academie-sciences.fr/page/bibliographical-references-numeric/` — authoritative for: numeric in-text citation `[N]`, bibliography ordered (general) by citation order *but* mathematics-series alphabetical-by-first-author override, full-author-list (no et al.) in journal-citation form, monograph / chapter / preprint / web / dataset format patterns, CSL file URL.

6. `http://www.centre-mersenne.org/pack_author/` — authoritative for: Centre Mersenne LaTeX class packages. CRAS Mathématique package is `pack_author-crmath.zip` at `https://www.centre-mersenne.org/media/texmf/pack_author-crmath.zip`.

7. `https://comptes-rendus.academie-sciences.fr/page/code-ethique-bonnes-pratiques/` — authoritative for: code of ethics (single-blind, no concurrent submissions in any language, copyright respect).

---

## 7. Hand-off to Phase C

Phase B is complete. Phase C (Judge π rigor + wide-mathematician-audience audit) consumes:

- This memo's §1 (editorial direction) and §2 (gates) to set the audit dimensions.
- Draft 0.2 ([`05-draft0.2-manuscript.md`](05-draft0.2-manuscript.md)) as the audit target.
- Phase A strategy memo ([`06-cras-strategy.md`](06-cras-strategy.md)) §3 Phase C for the eight audit dimensions (RIGOR-1 … RIGOR-6, STYLE-1 … STYLE-3).

Coordinator opens Phase C immediately.
