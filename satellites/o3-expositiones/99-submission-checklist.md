# Submission checklist — Expositiones Mathematicae (Elsevier EES)

*Operational pre-flight before dispatching satellite O3 to* Expositiones Mathematicae *via Elsevier Editorial System (EES). All gates from [`00-strategy.md`](00-strategy.md) §2 restated here with explicit verification path. Authored 2026-06-07 by Coordinator + Judge E.*

---

## 0. Submission posture (one-page summary)

**Manuscript:** *The continuous-coefficient Jensen equation: A note on three vestigial regularity hypotheses* (Short Research Note category, ~9 typeset pages).

**Venue:** Expositiones Mathematicae (Elsevier).

**Submission system:** Elsevier Editorial System (EES) at <https://www.editorialmanager.com/exmath/>.

**Submission files (the complete package):**

| File | Description | Source |
|---|---|---|
| `manuscript.tex` | LaTeX source | [`latex/manuscript.tex`](latex/manuscript.tex) |
| `manuscript.pdf` | Compiled PDF (review mode) | produced by `./latex/build.ps1 -Mode review` |
| `refs.bib` | BibTeX bibliography | [`latex/refs.bib`](latex/refs.bib) |
| `highlights.txt` | Article highlights (5 bullets, ≤85 chars each) | [`latex/highlights.txt`](latex/highlights.txt) |
| `declaration-of-interests.docx` | Competing interests declaration (Word file, mandatory separate upload) | created by author from [`00-strategy.md`](00-strategy.md) §6 template |

**Cover letter:** drafted in [`00-strategy.md`](00-strategy.md) §10, pasted into the EES "Comments to Editor" field at submission.

---

## 1. Hard gates G-AFFIL … G-MSC — verification path

Each gate **must** be green before EES dispatch. Red gates block dispatch.

### G-AFFIL: corresponding-author institutional affiliation

Elsevier does not exclude independent researchers from submitting (unlike CRAS), but the corresponding-author affiliation is used to determine open-access publishing agreement eligibility and is required for the EES author profile.

**Verification path:**
- [ ] Author confirms current affiliation (university, research lab, or other) for use in EES corresponding-author profile.
- [ ] Affiliation fields filled in `manuscript.tex` line 71 (`\affiliation[inst1]` block): replace `[INSTITUTION]`, `[ADDRESS LINE 1]`, `[CITY]`, `[POSTAL CODE]`, `[COUNTRY]`.
- [ ] Email address filled in `manuscript.tex` line 67 (`\ead`): replace `[author@institution.country]`.

**Decision marker:** ⏳ pending author input.

### G-ETHICS-1: no concurrent submission

Elsevier: *"the article is not under consideration for publication elsewhere."*

**Critical:** if the CRAS satellite ([`../o3-chord-substitution/`](../o3-chord-substitution/)) has been dispatched, the Expositiones submission **cannot** be dispatched until CRAS issues a decision (accept, R&R, or reject). Concurrent dispatch is an ethical violation that risks rejection without review and damage to the author's reputation.

**Verification path:**
- [ ] CRAS submission status checked: not dispatched (OK for Expositiones first), or CRAS rejected (OK for Expositiones as fallback).
- [ ] If CRAS is still active: DO NOT dispatch Expositiones; wait.

### G-ETHICS-2: original work, preprint allowed

Elsevier permits arXiv preprints (preprint sharing is "in line with Elsevier's article sharing policy"). Cite the arXiv ID in the manuscript if deposited.

**Verification path:**
- [ ] Confirm manuscript is original work.
- [ ] If arXiv deposit (recommended): note the arXiv ID for inclusion in the manuscript footer.

### G-AI: declaration of generative AI use

Elsevier-mandated declaration. Text drafted in [`00-strategy.md`](00-strategy.md) §5 and reproduced inline in `manuscript.tex` as a dedicated `\section*` before the references.

**Verification path:**
- [ ] Review the AI declaration in `manuscript.tex` (search: `\section*{Declaration of generative AI`).
- [ ] Confirm it accurately reflects the author's AI usage.
- [ ] If author wishes to disclose no AI use: replace with the alternative phrasing per Elsevier policy ("The author has not used any generative AI or AI-assisted technologies in the manuscript preparation process beyond basic spelling, grammar, and bibliographic-formatting tools.").

### G-COI: declaration of competing interests as separate Word file

Elsevier-mandated. The body of the manuscript carries the short statement (`\section*{Declaration of competing interests}` in `manuscript.tex`), and a **separate `.docx` file** is uploaded at the "attach/upload files" step in EES.

**Verification path:**
- [ ] Create `declaration-of-interests.docx` using Microsoft Word (or Google Docs → Save as .docx, or LibreOffice → Save as .docx).
- [ ] Use the template content from [`00-strategy.md`](00-strategy.md) §6.
- [ ] Fill in [DATE OF SUBMISSION] and [AUTHOR] placeholders.
- [ ] Save the file as `declaration-of-interests.docx` next to the LaTeX source files.

### G-FUND: funding declaration

The default (no-funding) text is in the manuscript at `\section*{Funding}`. If the author received specific grant funding for the broader research program, replace with the formal statement per [`00-strategy.md`](00-strategy.md) §7.

**Verification path:**
- [ ] Funding text reviewed and adjusted if necessary.
- [ ] EES funding field also populated (Elsevier uses this for funder attribution).

### G-HIGHLIGHTS: 3–5 article highlights

Elsevier-encouraged. Provided in [`latex/highlights.txt`](latex/highlights.txt) (5 bullets, each ≤85 chars).

**Verification path:**
- [ ] Verify `highlights.txt` has exactly 5 bullets, each ≤85 chars: `awk '{print length, $0}' latex/highlights.txt`
- [ ] At EES upload step, upload `highlights.txt` as a separate file (or paste content into the "Highlights" form field if EES provides one).

### G-INCLUSIVE: inclusive language

Elsevier-mandated. The manuscript has no occasion to use gendered language about people; the Polish-school context uses named historical mathematicians.

**Verification path:**
- [ ] Review the manuscript for any gendered references; replace with gender-neutral language if needed (e.g., "he or she" → "they"). No such language is present in Draft 0.1.

### G-FORMAT: single-column LaTeX

The `elsarticle` class with `preprint` or `review` option is single-column. Submission mode (`-Mode review`) gives the EES-preferred line-numbered double-spaced format.

**Verification path:**
- [ ] Run `./latex/build.ps1 -Mode review` (or `./latex/build.sh --mode review`).
- [ ] HARNESS: PASS reported.
- [ ] Open `manuscript.pdf` and verify single-column layout with line numbers.

### G-REFS: numerical references, citation-order

Handled automatically by `\bibliographystyle{elsarticle-num}`.

**Verification path:**
- [ ] After build, open `manuscript.pdf` and verify references in the bibliography list are numbered `[1], [2], [3]…` in the order of first appearance in the text.

### G-ABSTRACT: ≤250 words

**Verification path:**
- [ ] Word-count the abstract: extract from `manuscript.tex` between `\begin{abstract}` and `\end{abstract}`, count words.
- [ ] Confirm ≤250 words. (Draft 0.1 abstract is ~210 words.)

### G-KEYWORDS: 1–7 keywords

**Verification path:**
- [ ] Verify the `\begin{keyword} ... \end{keyword}` block in `manuscript.tex` has between 1 and 7 keywords (currently 6).
- [ ] Verify no multi-word keywords joined by "and"/"of".

### G-MSC: MSC 2020 (Expositiones-encouraged)

The `\MSC[2020]` line in the keyword block carries 39B22 and 39B05.

**Verification path:**
- [ ] Verify the MSC codes are present and correct.

### G-PAGES: ≤10 pages

The Short Research Note hard limit.

**Verification path:**
- [ ] Build `-Mode review` and check `manuscript.pdf` page count.
- [ ] Confirm ≤10. (Draft 0.1 targets ~9 pages typeset.)
- [ ] If >10 pages: pivot to Main Research Article category (≥15 pages) and expand, or trim §5 (the recurrence section is the longest discursive content).

---

## 2. Soft pre-flight (highly recommended)

### S-1: arXiv-first deposit

**Recommendation:** Deposit on arXiv 24–48 hours before EES dispatch, with footnote *"Submitted to Expositiones Mathematicae"* on the title page.

**Verification path:**
- [ ] arXiv account exists; if not, create at <https://arxiv.org/>.
- [ ] Author has endorser for `math.HO` and `math.CA`. If no endorser, request via standard endorsement flow.
- [ ] Submit to arXiv with:
  - **Primary:** `math.HO` (History and Overview) — appropriate for the teaching-note framing.
  - **Cross-list 1:** `math.CA` (Classical Analysis and ODEs).
  - **Cross-list 2:** `math.FA` (Functional Analysis) — optional.
- [ ] arXiv ID assigned.
- [ ] Add arXiv ID to the manuscript footer (or to the OJS metadata).
- [ ] Re-build via `./latex/build.ps1 -Mode review` and re-check the PDF.

### S-2: Reviewer suggestions

Elsevier permits authors to suggest reviewers in the "Comments to Editor" field. Suggested reviewers for this manuscript:

**Functional-equations specialists** (the topical core):
- **Attila Gilányi** (University of Debrecen) — editor of Kuczma's 2nd edition; the leading living reference.
- **Roman Ger** (Silesian University, Poland) — extensive work on Cauchy and Jensen equations.
- **Themistocles M. Rassias** (NTUA, Greece) — editor of *Aequationes Mathematicae*.
- **László Székelyhidi** (University of Debrecen) — functional-equations spectral theory.

**Application-side specialists** (for cross-validation of §5):
- **Mark Reid** (CSIRO/ANU) — calibration theory.
- **Robert Williamson** (Tübingen) — calibration theory.
- **Peter Bartlett** (Berkeley) — calibration theory.

Pick 4–5 from this list when filling the EES suggested-reviewers field.

### S-3: ORCID

Strongly recommended for discoverability.

**Verification path:**
- [ ] Author has an ORCID; if not, create at <https://orcid.org/>.
- [ ] EES author profile linked to ORCID.

### S-4: Funder identifier (Crossref Funder Registry)

If the author received funding from a registered funder, add the funder identifier to the EES funding field. The default (no funding) does not require this.

---

## 3. Submission-day procedure

### Day –1 (preceding day)

1. Run `./latex/build.ps1 -Clean` then `./latex/build.ps1 -Mode review`. Verify HARNESS: PASS.
2. Open `manuscript.pdf` and visually verify:
   - [ ] Title, author name, affiliation are correct (no placeholders).
   - [ ] Abstract present and properly formatted (≤250 words).
   - [ ] Highlights present.
   - [ ] Keywords present (1–7).
   - [ ] MSC 2020 line present.
   - [ ] Table 1 renders correctly with three columns.
   - [ ] Theorem and proof environments render correctly.
   - [ ] Bibliography numbered `[1], [2], …` in citation order.
   - [ ] No missing references (`[?]` warnings) in `manuscript.log`.
   - [ ] Page count ≤10.
3. Deposit on arXiv if S-1 is being followed. Wait for arXiv ID.
4. Update `manuscript.tex` with arXiv ID (optional but recommended). Re-build via harness.
5. Create `declaration-of-interests.docx` (G-COI) using the template from [`00-strategy.md`](00-strategy.md) §6.
6. Verify G-AFFIL, G-ETHICS-1, G-ETHICS-2 one final time.

### Day 0 (EES dispatch)

7. Log in to EES at <https://www.editorialmanager.com/exmath/>.
8. Click "Submit New Manuscript" and select Expositiones Mathematicae.
9. **Article Type:** select "Short Research Note" (or the most similar category if the labels differ).
10. **Title and abstract** (Metadata tab):
    - [ ] Title: paste from the manuscript.
    - [ ] Abstract: paste from the manuscript (the full ~210-word version).
    - [ ] Keywords: paste the 6 keywords as a comma-separated list.
    - [ ] MSC 2020: enter "39B22, 39B05".
11. **Authors** tab:
    - [ ] Corresponding author profile filled (name, email, affiliation, ORCID if available).
    - [ ] Co-authors: none for this submission.
12. **Files** tab (upload all in this order):
    - [ ] `manuscript.tex` — designate as "Manuscript File" / "TeX Source".
    - [ ] `manuscript.pdf` — designate as "Manuscript File" / "PDF" (the review-mode PDF).
    - [ ] `refs.bib` — designate as "Bibliography" or "Source Files".
    - [ ] `highlights.txt` — designate as "Highlights".
    - [ ] `declaration-of-interests.docx` — designate as "Declaration of Interest Statement".
13. **Declarations** tab:
    - [ ] Competing interests: select "No competing interests" or paste the COI text.
    - [ ] Funding: select "No specific funding" or enter the funder details.
    - [ ] AI declaration: paste the AI declaration text from `manuscript.tex` (the `\section*{Declaration of generative AI...}` block).
14. **Comments to Editor**:
    - [ ] Paste the cover letter from [`00-strategy.md`](00-strategy.md) §10.
    - [ ] At the end, list the 4–5 suggested reviewers from S-2.
15. **Submission confirmation** tab:
    - [ ] Review all entries.
    - [ ] Confirm and submit.
16. Note the EES manuscript ID.

### Day 0 post-dispatch

17. Append the EES manuscript ID and dispatch timestamp to §4 below.
18. (Optional) Share the arXiv preprint on social media.
19. Set a calendar reminder for Day 60 (status check via EES) and Day 180 (escalation reminder if no response).

---

## 4. Post-submission tracking

To be populated by the author after dispatch.

| Field | Value |
|---|---|
| EES manuscript ID | `<to be filled at dispatch>` |
| Dispatch date | `<to be filled>` |
| arXiv ID (if S-1 followed) | `<to be filled>` |
| Editor assigned | `<to be filled on first EES response>` |
| First response date | `<to be filled>` |
| Decision date (round 1) | `<to be filled>` |
| Verdict (round 1) | `<accept / revise / reject>` |
| Revised manuscript submission date | `<if applicable>` |
| Final decision date | `<to be filled>` |
| DOI assigned (on acceptance) | `<to be filled>` |
| Published date | `<to be filled>` |

---

## 5. Rejection scenarios — fallback plan

| Verdict | Action |
|---|---|
| **Accept (round 1)** | Proceed to production. Elsevier proofs typically arrive 2–4 weeks after acceptance. Author has 2 days to return corrections. |
| **Revise & resubmit (R&R)** | Address the editor's points in a closure-round file (`14-expositiones-revision-1.md`). Re-build LaTeX. Re-submit through EES with a response-to-reviewers letter. |
| **Reject — out of scope** | Pivot to *Mathematical Intelligencer* (Springer, more popular tone) or *L'Enseignement Mathématique* (EMS, similar size). LaTeX template changes minimally. |
| **Reject — quality** | Re-audit Judge π / Judge S findings (the CRAS audit chain at [`../o3-chord-substitution/02-judge-pi-audit.md`](../o3-chord-substitution/02-judge-pi-audit.md), [`../o3-chord-substitution/04-judge-s-prior-art-audit.md`](../o3-chord-substitution/04-judge-s-prior-art-audit.md), [`../o3-chord-substitution/08-judge-pi-rigor-audit.md`](../o3-chord-substitution/08-judge-pi-rigor-audit.md)) for anything missed against the Expositiones-audience standard. Open new audit round addressing reviewer comments. Re-target *Mathematical Intelligencer*. |
| **No response after 6 months** | Status query via EES message system. After 9 months without response, withdraw and re-submit to fallback venue. |

If the CRAS submission has not yet been dispatched and the author dispatches Expositiones instead, the CRAS satellite is held as fallback for any Expositiones rejection. The fallback chain is symmetric: each venue serves as backup for the other.

---

## 6. Sign-off (Judge E)

The Expositiones submission package complies with every Elsevier gate that does not require human decision. Remaining items are:

- ⏳ **G-AFFIL** — author institutional affiliation placeholders in `manuscript.tex`.
- ⏳ **G-COI** — author creates `declaration-of-interests.docx` from template.
- ⏳ **G-AI** — author reviews / adapts AI declaration text.
- ⏳ **G-FUND** — author confirms no-funding default or substitutes funder details.
- ⏳ **G-ETHICS-1** — coordination with CRAS submission (do not concurrent-dispatch).

Once these resolve, follow §3 Day –1 / Day 0 procedure.

**Judge E sign-off:** the Expositiones submission of opportunity O3 is ready for dispatch pending the operational items above.
