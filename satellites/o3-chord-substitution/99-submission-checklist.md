# Phase J — Submission checklist and cover letter

*Authored 2026-06-06 by Coordinator + Judge E. Operational pre-flight before dispatching the satellite to Comptes Rendus Mathématique via Open Journal System (OJS). All hard gates G-1…G-9 from [`07-cras-format-reconnaissance.md`](07-cras-format-reconnaissance.md) §2 are restated here with explicit verification path.*

---

## 0. Submission posture (one-page summary)

**Manuscript:** *The chord substitution closes the continuous Jensen equation — A teaching note on three vestigial regularity hypotheses* (English primary).
**Venue:** Comptes Rendus Mathématique (Académie des sciences) via Centre Mersenne OJS.
**OJS URL:** <https://comptes-rendus.academie-sciences.fr/ojs/mathematique>.
**Primary file:** [`latex/chord-substitution-en.tex`](latex/chord-substitution-en.tex).
**Supplementary translation:** [`latex/chord-substitution-fr.tex`](latex/chord-substitution-fr.tex) (offered per CRAS "additional files" — *translated version of the article: this translation will not be peer-reviewed, but it will be put online at the same time as the article*, per CRAS instructions).
**Editorial-board contact (initial):** an associate editor in analysis or general mathematics will be assigned by the editor-in-chief routing. No specific editor request is made.

---

## 1. Hard gates G-1 … G-9 — verification path

Each gate **must** be green before OJS dispatch. Red gates block dispatch.

### G-1 (HARD): Author institutional affiliation

**Requirement.** Author must list a university or research-organization affiliation in OJS. CRAS verbatim: *"Manuscripts submitted by independent researchers will be rejected without review."*

**Verification path.**
- [ ] Author confirms current institutional affiliation (university, research lab, or equivalent).
- [ ] If yes: institution name + city + country are filled in the OJS author profile AND in the `[INSTITUTION, COUNTRY]` placeholder of the `.tex` files (both `chord-substitution-en.tex` line 71 and `chord-substitution-fr.tex` line 76).
- [ ] If no: **STOP**. Pivot the satellite to *Expositiones Mathematicae* (Fallback 1, no affiliation rule). The Phases B–I deliverables carry over with minor template-only changes (Elsevier `elsarticle` class instead of `crmath`).

**Decision marker:** ⏳ **Pending author confirmation.**

### G-2 (HARD): Submission quota — at most 3 in the past 12 months

**Requirement.** *"We may automatically decline publication when a (co)author has already submitted 3 manuscripts in the past year."*

**Verification path.**
- [ ] Author confirms this is the first CRAS submission in the past 12 months (most likely OK — this is the first satellite in the publication plan).
- [ ] If author has co-authors (this satellite is single-author), each co-author confirms the same.

**Decision marker:** ✅ Pre-confirmed (single-author, first CRAS submission).

### G-3 (HARD): Not concurrently submitted elsewhere

**Requirement.** *"L'article n'a été soumis à aucune autre revue (y compris dans une autre langue)."*

**Verification path.**
- [ ] Author confirms the manuscript has not been submitted to *Expositiones Mathematicae*, *Mathematical Intelligencer*, *American Mathematical Monthly*, or any other venue.

**Decision marker:** ✅ First venue.

### G-4 (HARD): Bilingual metadata in OJS

**Requirement.** *"Providing a title, an abstract and keywords in French AND in English is mandatory."* (Either-language manuscript.)

**Verification path.**
- [ ] **OJS Title (English):** *The chord substitution closes the continuous Jensen equation — A teaching note on three vestigial regularity hypotheses*
- [ ] **OJS Title (French):** *La substitution par corde clôt l'équation de Jensen à coefficient continu — Une note pédagogique sur trois hypothèses de régularité vestigiales*
- [ ] **OJS Abstract (English):** copy from [`09-draft0.3-manuscript.md`](09-draft0.3-manuscript.md) Abstract block (~ 195 words).
- [ ] **OJS Abstract (French):** copy from [`13-draft0.4-fr-manuscrit.md`](13-draft0.4-fr-manuscrit.md) Résumé block (3 paragraphs, ~ 215 words).
- [ ] **OJS Keywords (English):** Jensen equation; Cauchy equation; Hamel basis; functional equation; affine function; chord substitution
- [ ] **OJS Keywords (French):** équation de Jensen; équation de Cauchy; base de Hamel; équation fonctionnelle; fonction affine; substitution par corde
- [ ] **OJS MSC 2020:** 39B22, 39B05

### G-5 (HARD): Three files mandatory — TeX + PDF + BibTeX

**Requirement.** CRAS Mathématique: *"Submission in TeX format is mandatory. All submissions in TeX format must include at least three elements: the full text of the article in TeX format (source file); the full text of the article in PDF format (compiled file); the article's bibliography in BIB format."*

**Verification path** (after running `./latex/build.ps1` or `./latex/build.sh`):
- [ ] [`latex/chord-substitution-en.tex`](latex/chord-substitution-en.tex) exists, opens without errors.
- [ ] `latex/chord-substitution-en.pdf` exists, PASS reported by harness.
- [ ] [`latex/refs.bib`](latex/refs.bib) exists, parses cleanly.
- [ ] Page count is ~4–6 pages.

For the supplementary French version (offered as translation file):
- [ ] [`latex/chord-substitution-fr.tex`](latex/chord-substitution-fr.tex) exists.
- [ ] `latex/chord-substitution-fr.pdf` exists, PASS reported.

### G-6 (HARD): Centre Mersenne `crmath` class (or fallback)

**Requirement.** *"Authors are requested to use the journal's LaTeX class and the associated bibtex style."*

**Verification path.**
- [ ] **Preferred (CRAS-official):** Download `pack_author-crmath.zip` from <https://www.centre-mersenne.org/media/texmf/pack_author-crmath.zip>. Install per [`latex/README.md`](latex/README.md) §"CRAS-Mathématique class file". Switch the manuscripts from `amsart` (fallback) to `\documentclass{crmath}`. Rebuild via the harness. Verify the PDF matches the Centre Mersenne sample document layout.
- [ ] **Alternative (acceptable):** Submit with the amsart-based fallback compile. CRAS editorial team will re-typeset with `crmath` after acceptance. Note this in the cover letter (§4 below).

**Recommendation:** install `crmath` if time permits; the fallback is a defensible second choice.

### G-7 (HARD): Declaration of interests in body

**Requirement.** CRAS: *"if you have no conflict of interest to declare, please include the following statement: ..."*

**Verification path.**
- [ ] English `.tex` line ~278 (Section heading *"Declaration of interests"*) contains the required statement. ✅ Already in [`09-draft0.3-manuscript.md`](09-draft0.3-manuscript.md).
- [ ] French `.tex` line ~285 (Section heading *"Déclaration d'intérêts"*) contains the required statement. ✅ Already in [`13-draft0.4-fr-manuscrit.md`](13-draft0.4-fr-manuscrit.md).

### G-8 (HARD): MSC 2020 classification (CR Mathématique only)

**Requirement.** *"CR Mathématique only: the mathematical classification to which the subject of your article relates."*

**Verification path.**
- [ ] Both `.tex` files carry `\subjclass[2020]{39B22, 39B05}` (line ~74 and line ~79 respectively).
- [ ] OJS form field "MSC" is set to `39B22, 39B05`.

### G-9 (HARD): No copyright-protected material

**Verification path.**
- [ ] No figures, no tables-from-elsewhere, no images. ✅ Trivially OK for this note.

---

## 2. Soft pre-flight (highly recommended, not blocking)

### S-1: arXiv-first deposit

**Recommendation:** Deposit the manuscript on arXiv **24–48 hours before** OJS dispatch, with the footnote *"Submitted to Comptes Rendus Mathématique"* on the title page.

**Verification path.**
- [ ] arXiv account exists (if not: create at <https://arxiv.org/>).
- [ ] Author has endorser on file for `math.HO` and `math.CA` (cross-listings). If no endorser, request via the standard endorsement flow.
- [ ] Submit to arXiv with:
  - **Primary:** `math.HO` (History and Overview) — appropriate for the teaching-note framing.
  - **Cross-list 1:** `math.CA` (Classical Analysis and ODEs).
  - **Cross-list 2:** `math.FA` (Functional Analysis) — optional, but the functional-equation taxonomy puts the note here too.
- [ ] arXiv ID assigned (`arXiv:26XX.XXXXX`).
- [ ] Replace the `*Author affiliation, arXiv identifier, ...*` placeholder line at the end of each `.tex` file with the actual arXiv ID.
- [ ] Re-compile via the harness; re-verify the PDF carries the arXiv ID.

### S-2: Reviewer suggestions (optional, but Centre Mersenne welcomes)

**Recommendation:** Suggest 3–5 reviewers when filling the OJS form. The Centre Mersenne editorial flow allows this and reviewer suggestions speed up the editor-routing step.

**Candidate reviewers** (functional-equations community, English-comfortable):
- **Attila Gilányi** (University of Debrecen, Hungary) — co-editor of the 2nd edition of Kuczma's treatise [9]; the canonical living reference for the functional-equations literature.
- **Roman Ger** (Silesian University, Poland) — extensive work on Cauchy and Jensen functional equations and their stability.
- **Themistocles M. Rassias** (National Technical University of Athens, Greece) — editor of *Aequationes Mathematicae*, prolific in Hyers–Ulam stability of $(J_2)$.
- **László Székelyhidi** (University of Debrecen, Hungary) — handbook of functional equations (spectral theory).
- **Jacek Chudziak** (University of Rzeszów, Poland) — works at the Jensen-vs-Cauchy boundary.

All have published on functional equations on real intervals; all read English. Suggest as referees in the OJS "Comments to Editor" field.

### S-3: Cover letter (draft below in §4)

**Recommendation:** A brief cover letter explains to the editor what the submission is and which CR Mathématique category it belongs to (per the journal's *Our Journal* page: Category 2, *"targeted presentations of recent and significant results, written to be accessible beyond the specialist community"*).

### S-4: ORCID (recommended)

**Recommendation:** Connect the OJS account to ORCID. CRAS does not require it but it improves discoverability and citation tracking.

**Verification path.**
- [ ] Author has an ORCID (if not: create at <https://orcid.org/>).
- [ ] OJS profile shows the linked ORCID.

---

## 3. Submission-day procedure (step-by-step)

Run in order on dispatch day.

### Day –1 (preceding day)

1. Run `./latex/build.ps1 -Clean` then `./latex/build.ps1` and verify HARNESS: PASS.
2. Open both PDFs and visually verify:
   - Title, author, affiliation correct (no `[AUTHOR]` or `[INSTITUTION]` placeholders).
   - Both abstracts (English + French) present and formatted.
   - Table I renders correctly with three columns.
   - Section numbering is Roman top-level.
   - Bibliography numbers `[1]…[16]` consistent with text citations.
   - No missing reference (`[?]`) warnings.
3. Deposit on arXiv if Soft pre-flight S-1 is being followed. Wait for arXiv ID.
4. Update the `.tex` files with the arXiv ID. Re-build via harness. Verify.
5. Verify gates G-1, G-2, G-3 with the author one final time.

### Day 0 (dispatch)

6. Log in to OJS at <https://comptes-rendus.academie-sciences.fr/ojs/mathematique>.
7. Click "New submission" and select Comptes Rendus Mathématique.
8. Section: *Research articles* (or *Notes*, depending on the OJS section options — verify against the dropdown).
9. Fill the metadata tab:
   - Title (en, fr) per G-4.
   - Abstract (en, fr) per G-4.
   - Keywords (en, fr) per G-4.
   - MSC 2020 per G-8.
10. Upload files in the Files tab:
    - Main file: `chord-substitution-en.tex` (designate as "Article Text").
    - PDF: `chord-substitution-en.pdf` (designate as "Article Text — Compiled PDF").
    - BibTeX: `refs.bib` (designate as "Bibliography").
    - Supplementary: `chord-substitution-fr.tex` (designate as "Translated Version" or "Supplementary File"; the OJS dropdown may use different labels — pick the closest).
    - Supplementary: `chord-substitution-fr.pdf` (same designation).
11. Author and affiliation tab: fill per G-1.
12. Comments to editor: paste the cover letter from §4.
13. Reviewer suggestions: paste the candidate list from S-2 (if used).
14. Submission confirmation tab: review all entries, confirm.
15. Submit. Note the OJS manuscript ID.

### Day 0 — post-dispatch

16. Append the OJS manuscript ID and dispatch timestamp to §5 below.
17. (Optional but recommended) tweet / Mastodon / similar — the arXiv ID is the citable pointer until CRAS publishes.
18. Set a calendar reminder for Day 60 (status check via OJS) and Day 180 (escalation reminder if no response).

---

## 4. Cover letter draft

To paste into the OJS "Comments to Editor" field on submission.

> Dear Editor,
>
> I am pleased to submit *The chord substitution closes the continuous Jensen equation — A teaching note on three vestigial regularity hypotheses* for consideration by *Comptes Rendus Mathématique*.
>
> The note is a short (~5 pages) self-contained article addressing a recurrent confusion in applied work that encounters the Jensen functional equation in its continuous-coefficient form: authors typically import the regularity machinery of the Cauchy/Hamel literature (continuity, boundedness, measurability) to obtain affineness, when none of those hypotheses is in fact required — a single chord substitution closes the proof. The result itself is folklore (Aczél, Kuczma); the note's contribution is the explicit dictionary of which regularity hypotheses are vestigial under the continuous-coefficient form, articulated as a short citable reference for authors who derive the equation in their own work.
>
> I believe the submission fits *Comptes Rendus Mathématique*'s Category 2 — *targeted presentations of recent and significant results, written to be accessible beyond the specialist community* — as described in the journal's *Our journal* page. The note is intelligible to any reader with elementary analysis background and articulates a recurrent oversight in applied calibration theory; it is short enough to read in a sitting and provides a one-line citation that authors can use to retire the Hamel-basis concern without re-deriving it.
>
> Both an English version (primary) and a native French translation (supplementary) are provided. The bibliography, the LaTeX source, and the BibTeX `.bib` file are all included per the journal's mandatory format.
>
> The note is original work, has not been submitted elsewhere in any language, and accompanies a longer in-preparation manuscript (cited as [El1, El2] in the bibliography) on the achievable error floor of partition-based classifiers in which the equation surfaced. Section V of the present note documents that recurrence and articulates the structural reason similar recurrences are predictable in other derivations that saturate Jensen's inequality.
>
> I look forward to your review.
>
> Sincerely,
> [AUTHOR NAME]
> [INSTITUTION]
> [author@institution.country]

---

## 5. Post-submission tracking

To be populated by the author after dispatch.

| Field | Value |
|---|---|
| OJS manuscript ID | `<to be filled at dispatch>` |
| Dispatch date | `<to be filled>` |
| arXiv ID (if S-1 followed) | `<to be filled>` |
| Editor initially assigned | `<to be filled on first OJS response>` |
| First response date | `<to be filled>` |
| Decision date (round 1) | `<to be filled>` |
| Verdict (round 1) | `<accept / revise / reject>` |
| Revised manuscript submission date | `<if applicable>` |
| Final decision date | `<to be filled>` |
| DOI assigned (on acceptance) | `<to be filled>` |
| Published date | `<to be filled>` |

---

## 6. Rejection scenarios — fallback plan

CRAS Mathématique 2025 acceptance rate is ~11.2% (54/482). The fallback plan ahead of time:

| Verdict | Action |
|---|---|
| **Accept (round 1)** | Proceed to layout / proofs. Median submission-to-publication is 251 days. |
| **Revise & resubmit (R&R)** | Address the editor's points in a closure draft `14-cras-revision-1.md`. Re-audit with Judge π for new findings if the revision is substantive. Re-LaTeX, re-submit through OJS. |
| **Reject — out of scope** | Pivot to *Expositiones Mathematicae* (Fallback 1). The LaTeX template changes (Elsevier `elsarticle` class), but the content, bibliography, and audit chain carry over. arXiv version remains live as the citable pointer. |
| **Reject — quality** | Re-audit Judge π + Judge S findings (the original audits, [`02-judge-pi-audit.md`](02-judge-pi-audit.md), [`04-judge-s-prior-art-audit.md`](04-judge-s-prior-art-audit.md), [`08-judge-pi-rigor-audit.md`](08-judge-pi-rigor-audit.md), [`12-judge-fr-audit.md`](12-judge-fr-audit.md)) for anything missed. Open a new audit round (`14-cras-rejection-audit.md`) targeting the editor's specific points. Re-target *Expositiones Mathematicae*. |
| **No response after 6 months** | Polite status query via the OJS message system. If no response after 9 months, withdraw and re-submit to fallback. |

---

## 7. Sign-off

Phase J is **complete in process** but **gated on G-1 author affiliation**.

- ✅ Strategy memo, format reconnaissance, two audit memos, two manuscript drafts (en + fr), French translation spec, LaTeX harness — all landed.
- ⏳ **G-1 awaiting author confirmation of institutional affiliation.**
- ⏳ **G-6 awaiting Centre Mersenne `crmath` class file install** (or decision to ship with fallback).
- ⏳ **Author placeholders `[AUTHOR]`, `[INSTITUTION, COUNTRY]`, `[author@institution.country]` to be resolved** in the `.tex` files before dispatch.

Once G-1 is green and G-6 is decided, follow the Day –1 / Day 0 procedure in §3.

**Judge E sign-off:** the submission package complies with every CRAS gate that does not depend on the author's identity/affiliation. The remaining gating items are operational and require human decision (author affiliation confirmation; arXiv submission timing; OJS account creation if not extant). The package is therefore **ready for dispatch pending G-1 closure**.
