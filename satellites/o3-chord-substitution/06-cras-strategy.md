# CRAS Submission Strategy — O3 chord-substitution note

*Strategy memo authored 2026-06-06 by Coordinator + Judge E, on the basis of the format-reconnaissance fetch ([`07-cras-format-reconnaissance.md`](07-cras-format-reconnaissance.md)) and the user-stated gaps in the Draft 0.2 submission package ([`05-draft0.2-manuscript.md`](05-draft0.2-manuscript.md)).*

---

## 0. Three gaps to close

The user named three gaps in the Draft 0.2 package that block CRAS submission:

1. **Mathematical rigor for the CRAS audience.** CRAS Mathématique targets a **wide audience of mathematicians**, beyond the functional-equations specialist subcommunity (editorial policy update, Spring 2025+ — "without falling into the category of popularization aimed at a non-mathematician public", but explicitly *broad-mathematical* in scope). Draft 0.2 was written for an analyst comfortable with $(\star)$, Cauchy's equation, and Hamel pathology already; some notation and several arguments need to land for a probabilist / number theorist / topologist who has never thought about functional equations.

2. **French native version.** Bilingual title + abstract + keywords are **mandatory** for CRAS Mathématique; a full French translation is strongly encouraged and increases the article's reach. Beyond translation, the French version needs French notation conventions (espace insécable before `: ; ? !`, French quotation marks « », theorem-environment names in French, decimal comma vs. point, etc.).

3. **LaTeX formatting + harness.** CRAS Mathématique requires LaTeX (not optional) using the Centre Mersenne `pack_author-crmath` class. The current Markdown drafts need to convert to LaTeX with a clean BibTeX bibliography, a build harness, and bilingual source files.

This strategy memo plans the phased work to close all three.

---

## 1. Personnel (standing cast for this strategy)

Per [`../../21-publication_plan.md`](../../21-publication_plan.md) §2 and the existing audit chain for O3 ([`02-judge-pi-audit.md`](02-judge-pi-audit.md), [`04-judge-s-prior-art-audit.md`](04-judge-s-prior-art-audit.md)).

| Persona | Domain | Role in this strategy |
|---|---|---|
| **Executor T** | Convex analysis, decision theory | Owns mathematical-rigor revisions; owns English Draft 0.3 |
| **Executor E** | Expository voice, *Notices*-style | Owns French translation Draft 0.3; co-owns LaTeX conversion |
| **Executor F** | Lean / mathlib / formal infrastructure | Owns LaTeX harness, BibTeX, build script |
| **Judge π** | Adversarial referee | Re-audits Draft 0.3 against the wide-mathematician standard |
| **Judge S** | Statistics referee | Already signed off in Round 4; consulted for §5.2 if revised |
| **Judge fr** | French native-speaker reviewer | NEW — audits French translation for register (académique), notation, idiom, typography |
| **Judge E** | Editor / venue strategist | Audits venue-fit compliance (Centre Mersenne template, bilingual metadata, biblio style, length, affiliation gate) |
| **Coordinator** | Process / sequencing | Tracks the phases; non-voting |

Two **new** personae enter the cast at this strategy: **Judge fr** (French linguistic audit) and **Judge E** (venue-fit / format compliance). The latter was always implicit in the publication plan but didn't have a per-piece audit memo until now.

---

## 2. Hard constraints (gates that block submission before any drafting matters)

These are HARD GATES — not soft preferences. If any one is unresolved at submission time, the manuscript will be rejected without evaluation. They live in [`99-submission-checklist.md`](99-submission-checklist.md) as well.

| # | Gate | Source | Status at this writing |
|---|---|---|---|
| **G-1** | **Author has a university or research-organization affiliation.** *"Manuscripts submitted by independent researchers will be rejected without review."* | CRAS instructions to authors (mandatory metadata section) | **Not yet confirmed** — author to verify before LaTeX submission |
| **G-2** | **Author has not submitted ≥3 manuscripts to CRAS in the past 12 months.** *"We may automatically decline publication when a (co)author has already submitted 3 manuscripts in the past year."* | CRAS instructions to authors | **Most likely OK** (first CRAS submission) — author to confirm |
| **G-3** | **The article has not been submitted to another journal** (including in another language). | CRAS code of ethics | **OK** — this is the first venue |
| **G-4** | **Bilingual metadata (title, abstract, keywords) in BOTH French and English.** | CRAS instructions, "Language" section | **closed in Phase D/F** (this strategy) |
| **G-5** | **LaTeX source + compiled PDF + BibTeX file.** | CRAS instructions, "Files to be provided" for Mathématique | **closed in Phase I** (this strategy) |
| **G-6** | **No reuse of copyright-protected images without CC-BY-4.0 permission.** | CRAS code of ethics | **Trivially OK** — no images |
| **G-7** | **Centre Mersenne LaTeX class is used.** | CRAS, "Article templates" section, URL `centre-mersenne.org/pack_author/` (`pack_author-crmath.zip`) | **closed in Phase I** |
| **G-8** | **Declaration of interests included.** | CRAS instructions, mandatory section | **closed in Phase D** |
| **G-9** | **MSC2020 classification included.** | CRAS instructions, CR Mathématique only | **already in Draft 0.2** (39B22 / 39B05 / 26A51) |

**G-1 is the strategically decisive gate.** If unresolved, the entire CRAS track collapses and the satellite re-targets *Expositiones Mathematicae* (Fallback 1) or *L'Enseignement Mathématique* (Fallback 2) — neither of which has an independent-researcher exclusion. The phased work below is structured so that none of it is wasted in the fallback scenario (LaTeX template would differ but content carries over).

---

## 3. Phase structure (B → J) and commitology

Each phase has: an **owner**, an **input**, an **output**, an **exit criterion**, and a **veto persona**. A phase closes only when the veto persona signs off in writing (per [`../../21-publication_plan.md`](../../21-publication_plan.md) §1.2 audit cadence).

### Phase B — Format reconnaissance (read-only)

**Owner:** Coordinator.
**Input:** CRAS instructions website, `pack_author-crmath` description.
**Output:** [`07-cras-format-reconnaissance.md`](07-cras-format-reconnaissance.md) — single source of truth for CRAS submission requirements, with all decision-relevant findings and the 9 hard gates G-1…G-9.
**Exit criterion:** every gate G-1…G-9 is documented with a verification path.
**Veto:** none — read-only memo, signed off by Coordinator.

### Phase C — Judge π rigor audit (vs. wide-mathematician standard)

**Owner:** Judge π (adversarial referee).
**Input:** Draft 0.2 ([`05-draft0.2-manuscript.md`](05-draft0.2-manuscript.md)) + Phase B findings.
**Output:** [`08-judge-pi-rigor-audit.md`](08-judge-pi-rigor-audit.md).
**Audit dimensions:**
- *RIGOR-1.* Every notation is introduced before use (a wide-mathematics-audience standard, not a functional-equations-specialist standard).
- *RIGOR-2.* "Affine" is defined explicitly (some readers will only know it via "linear plus constant"; some will think of affine planes in geometry).
- *RIGOR-3.* The Hamel-basis pathology is *tangible* — the construction in §4.3 Proposition 4 must be unambiguous for a reader who has not seen a Hamel basis (or has not seen it for a decade).
- *RIGOR-4.* Each regularity hypothesis in Table 1 (continuity / measurability / monotonicity / boundedness) is glossed: the *one-sentence reminder* of what the hypothesis says, for a reader who is not an analyst.
- *RIGOR-5.* §5.2's calibration-theory pivot must read for a probabilist who has never seen "$\psi$-transform" — the convex-analysis-vs-functional-equation-style distinction must land in one paragraph, not three references.
- *RIGOR-6.* The MSC2020 classification (39B22, 39B05, 26A51) is correct for a wide-mathematician audience.
- *STYLE-1.* CRAS-Mathématique register: clean, declarative, no rhetorical flourishes; theorems lead, prose supports.
- *STYLE-2.* No undefined acronyms; no in-jokes (Round-7 audit references must be removed or replaced).
- *STYLE-3.* The "where the trap recurs" section (§5) is intelligible without prior knowledge of [El1, El2] (the main paper is not yet published).

**Exit criterion:** every audit dimension produces a verdict (PASS / [Material] / [Minor]) and a disposition.
**Veto:** Judge π — must explicitly sign off that the manuscript reaches CRAS-Mathématique-wide-audience standard.

### Phase D — English Draft 0.3 closure

**Owner:** Executor T.
**Input:** [`08-judge-pi-rigor-audit.md`](08-judge-pi-rigor-audit.md).
**Output:** [`09-draft0.3-manuscript.md`](09-draft0.3-manuscript.md).
**Exit criterion:** every [Material] and [Minor] finding from Phase C closed; Judge π signs off; declaration-of-interests added; affiliation placeholder marked clearly.
**Veto:** Judge π.

### Phase E — French translation specification

**Owner:** Executor E.
**Input:** Phase D Draft 0.3 + Phase B findings.
**Output:** [`10-french-translation-spec.md`](10-french-translation-spec.md) — *the dictionary the French manuscript will be assembled from*. Covers:
- **Mathematical notation map** — what changes (e.g., decimal comma 0,5 vs. 0.5; intervals notation; integration variable), what stays the same (e.g., $\mathbb R$, $\mathbb Q$ in math mode).
- **Theorem-environment names** — Théorème / Démonstration / Corollaire / Proposition / Lemme / Définition / Remarque / Exemple.
- **Mathematical idiom map** — Soit / Considérons / Posons / On a / Il s'ensuit que / Par conséquent / D'où / En effet / En particulier / Or / D'autre part / etc.
- **Section headings** — Introduction / Le résultat / Le dictionnaire / Variantes et limites / Où le piège ressurgit / Références.
- **Typography rules** — espace insécable before `: ; ? ! %` and inside « », French quotation marks for in-text quotations, italics for emphasis, capitalization conventions (lower-case after `:` in French, capital after `:` in English).
- **Abstract conventions** — "Résumé" not "Abstract"; English-style "Abstract" still required for the bilingual abstract; both lead with the *result*, not the equation.
- **Register decisions** — académique (formal), not pédagogique (lecture-style); third person ("on" not "nous" or "je"), present tense ("on démontre" not "nous démontrons" not "je démontre").
- **Reference language convention** — bibliography entries in their original publication language (Aczél [1] stays English; Cauchy [4] stays French; Hamel [9] stays German title with French gloss; etc.).
- **Footnote placement** — French convention is footnote indicators *before* the punctuation (`mot¹.` not `mot.¹`).

**Exit criterion:** spec is complete; Executor E commits to the dictionary; no decision is left open for the translator to improvise.
**Veto:** Judge fr (must approve the typography/idiom decisions before drafting).

### Phase F — French native Draft 0.3

**Owner:** Executor E.
**Input:** Phase D Draft 0.3 + Phase E spec.
**Output:** [`11-draft0.3-fr-manuscrit.md`](11-draft0.3-fr-manuscrit.md).
**Exit criterion:** every section of Draft 0.3 (en) has a French counterpart; every theorem-environment is converted; every quotation is converted to « ... »; every espace insécable is in place; bibliography reordered alphabetically by first-author surname (mathematics-series convention).
**Veto:** Judge fr.

### Phase G — Judge fr linguistic audit

**Owner:** Judge fr (French native-speaker reviewer).
**Input:** [`11-draft0.3-fr-manuscrit.md`](11-draft0.3-fr-manuscrit.md).
**Output:** [`12-judge-fr-audit.md`](12-judge-fr-audit.md).
**Audit dimensions:**
- *FR-IDIOM.* Every "Soit / Considérons / Posons / On a / Il s'ensuit que" sounds natural to a French mathematician; no machine-translation residue.
- *FR-TYPOGRAPHY.* Every `: ; ? ! %` carries an espace insécable on its left; every « » carries an espace insécable inside; no double-space residue from the conversion.
- *FR-NOTATION.* Decimal comma or decimal point — single choice, applied consistently; interval notation chosen (open intervals: $]a,b[$ or $(a,b)$ — French convention historically the former, ISO permits the latter; pick one and apply consistently).
- *FR-REGISTER.* The register is *académique* (formal); no second-person, no "nous" except in the rare collective sense, no informal contractions.
- *FR-MATHEMATIQUE-COMPLIANCE.* MSC2020 classification line is preserved; "Mots-clés" is the French keyword header; "Résumé" + "Abstract" both appear.
- *FR-BILIOGRAPHY-LANGUAGE.* References that exist in French translation are cited in the publication language; titles in foreign languages may be glossed in French only if the original is unavailable.
- *FR-DEPENDABLE-TRANSLATION.* Pasting the French manuscript into DeepL (English direction) returns the English Draft 0.3 within the tolerance of a competent translator — i.e., no mathematical drift was introduced.

**Exit criterion:** every audit dimension produces a verdict; Judge fr signs off.
**Veto:** Judge fr.

### Phase H — French Draft 0.4 closure

**Owner:** Executor E.
**Input:** [`12-judge-fr-audit.md`](12-judge-fr-audit.md).
**Output:** [`13-draft0.4-fr-manuscrit.md`](13-draft0.4-fr-manuscrit.md).
**Exit criterion:** every finding closed; Judge fr signs off; ready for LaTeX conversion in Phase I.
**Veto:** Judge fr.

### Phase I — LaTeX harness (en + fr)

**Owner:** Executor F.
**Input:** [`09-draft0.3-manuscript.md`](09-draft0.3-manuscript.md) (en) + [`13-draft0.4-fr-manuscrit.md`](13-draft0.4-fr-manuscrit.md) (fr).
**Output:** folder [`latex/`](latex/) containing:
- `chord-substitution-en.tex` — English manuscript using `\documentclass{crmath}` with fallback amsart compatibility.
- `chord-substitution-fr.tex` — French manuscript, same class.
- `refs.bib` — BibTeX (single file, both manuscripts share it; cited as `[1]…[N]` alphabetically).
- `README.md` — build instructions, dependency list, fallback instructions for users without the `crmath` class.
- `build.ps1` — Windows PowerShell harness: pdflatex + bibtex + pdflatex × 2, both manuscripts, with line-count + word-count + page-count summary.
- `build.sh` — POSIX equivalent for verification on Linux/macOS.
- `.gitignore` — excludes LaTeX build artifacts (`*.aux`, `*.bbl`, `*.blg`, `*.log`, `*.toc`, `*.out`).

**Exit criterion:**
- Both `.tex` files compile cleanly under `pack_author-crmath` (verified manually after Centre Mersenne template download).
- A *fallback* compilation works without `crmath` (using vanilla amsart) — for users who can't immediately download the Centre Mersenne package.
- BibTeX produces the expected `[1]…[N]` numbering.
- Output PDFs match Draft 0.3 / Draft 0.4 content exactly.
- The harness script produces the page/word/character counts.

**Veto:** Judge E (venue-fit) + Judge F (technical correctness of the build).

### Phase J — Submission checklist + cover letter + arXiv-first

**Owner:** Coordinator.
**Input:** all of Phase I.
**Output:** [`99-submission-checklist.md`](99-submission-checklist.md).
**Content:**
- All hard gates G-1…G-9 with explicit verification path before OJS dispatch.
- arXiv-first plan with timing: deposit at `math.HO` (primary) + `math.CA` + `math.FA` (cross-list), 24h before OJS dispatch, footnote *"Submitted to Comptes Rendus Mathématique"*.
- Draft cover letter (one paragraph) for the OJS Letter to Editor field.
- OJS metadata schema (title-fr, title-en, abstract-fr, abstract-en, keywords-fr, keywords-en, MSC2020, suggested reviewers).
- Reviewer suggestions (4 names with affiliations) — for a CRAS short note this is optional but Centre Mersenne welcomes it.
- Post-submission tracking table (manuscript ID, decision-letter dates, response targets).

**Exit criterion:** when this file is fully populated and Judge E signs off, the manuscript is ready to OJS-dispatch.
**Veto:** Judge E.

---

## 4. Intermediate objectives (commitology)

The phase exit criteria above are the per-phase gates. Three larger **intermediate objectives** span phases — these are the milestones at which the strategy meets its own goals.

### Intermediate objective IO-1: "English Draft 0.3 sign-off"

**Closes when:** Phase D exits with Judge π written sign-off; declaration-of-interests included; affiliation placeholder marked.
**Significance:** the mathematical content is frozen for both the English submission *and* the French translation. Any further mathematical change after IO-1 requires re-translation, re-audit, re-LaTeX.

### Intermediate objective IO-2: "French Draft 0.4 sign-off"

**Closes when:** Phase H exits with Judge fr written sign-off.
**Significance:** the bilingual content is frozen. Any further linguistic change requires Judge fr re-audit.

### Intermediate objective IO-3: "Both LaTeX manuscripts compile + harness PASS"

**Closes when:** Phase I exits with both `.tex` files compiling cleanly under `crmath` (or fallback amsart) and the `build.ps1` harness reporting PASS.
**Significance:** the package is ready for OJS dispatch — only the affiliation gate (G-1) remains.

---

## 5. Risk register update (CRAS-specific)

Additions to [`../../21-publication_plan.md`](../../21-publication_plan.md) §7 for this specific submission.

| Risk | Likelihood | Mitigation |
|---|---|---|
| G-1 (affiliation) not resolved | **decisive** | Audit before any LaTeX work; if unresolved, pivot to *Expositiones Mathematicae* (no affiliation rule) — the rest of the strategy (Phases B–J) carries over with minor template change |
| G-2 (3/year quota) triggered | low | First CRAS submission per author; flagged for verification |
| Bilingual metadata not propagated correctly to OJS | moderate | Submission checklist explicitly enumerates which fields go in which OJS field |
| Centre Mersenne `crmath` class is hard to install for an author on Windows | moderate | LaTeX harness ships a fallback amsart configuration; class file install steps in `latex/README.md` |
| Mathematical-content drift between en and fr versions | moderate | Phase G's FR-DEPENDABLE-TRANSLATION audit checks DeepL round-trip; Phase H closure freezes the bilingual pair |
| 11% acceptance rate at CRAS | high (this is the base rate) | Fallback to *Expositiones Mathematicae* triggered automatically on rejection; arXiv deposit gives a citable pointer in the interim |
| Mediocre French (machine-translation residue) | moderate | Judge fr's FR-IDIOM audit specifically targets this |
| Notation inconsistency between English and French (e.g., $]a,b[$ vs $(a,b)$) | moderate | Phase E spec freezes the choice before Draft 0.3 fr; FR-NOTATION audit verifies |
| Acceptance + slow proofs cycle (median 251 days) | known (this is the venue) | OK with project clock; CRAS speed is on the fast end for refereed math venues |

---

## 6. Out of scope for this strategy

These items are *not* addressed in Phases B–J. They are either (a) for the main paper, not this satellite, or (b) for a different satellite.

- ❌ Updating the *main* paper's §4.2 Step 2 to cite the satellite. The main paper revision is on its own track (Round 7 closure of M-1, M-2, S-1 per [`../../19-panel_verdict.md`](../../19-panel_verdict.md)).
- ❌ Building the LaTeX harness for the other satellites (O1, O2, O4–O20). Each satellite has its own format requirements; the present LaTeX harness is tailored to CRAS Mathématique.
- ❌ HAL deposit. CRAS Mathématique is Diamond Open Access via Centre Mersenne; HAL deposit is optional and can be done post-acceptance.
- ❌ ORCID setup or registry. Author-account-level item, not strategy-level.

---

## 7. Hand-off to Phase B

Phase B (format reconnaissance) is **already complete** in [`07-cras-format-reconnaissance.md`](07-cras-format-reconnaissance.md). Phase C (Judge π rigor audit) is the first work item that consumes this strategy.

The sequence runs **B → C → D → E → F → G → H → I → J** with the IO-1 / IO-2 / IO-3 milestones at the points indicated. Each phase is read-only or write-only in its primary file (the LaTeX harness in Phase I is the one phase that produces multiple files).

Coordinator opens Phase C immediately on hand-off.
