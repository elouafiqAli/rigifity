# Strategy memo — *Expositiones Mathematicae* Short Research Note

*Submission planning for opportunity O3 of the publication plan ([`../../21-publication_plan.md`](../../21-publication_plan.md)) in its Expositiones lane. Authored 2026-06-07 by Coordinator + Judge E. Single source of truth for Elsevier-specific gates, format compliance, and operational pre-flight before EES dispatch.*

---

## 1. Headline

**Venue:** *Expositiones Mathematicae* (Elsevier). **Target category:** Short Research Note (≤10 pages). **Submission system:** Elsevier Editorial System (EES) at <https://www.editorialmanager.com/exmath/>. **License:** subscription or open access (CC BY) per author choice. **Single anonymized peer review** with minimum two reviewers.

The Expositiones submission is **parallel-prepared** to the CRAS submission. It is not currently submitted (gate G-ETHICS-1 of §2 below: Elsevier prohibits concurrent submission to other venues). The author chooses one venue to dispatch first and holds the other as fallback.

The Expositiones submission is **substantively different** from the CRAS version in framing, depth, and self-containment — not the same paper in any meaningful sense, but the same mathematical content extracted with different pedagogical scaffolding. The CRAS version is a 5-page citation point for working researchers; the Expositiones version is a 9-page self-contained pedagogical Short Research Note.

---

## 2. Hard gates (Elsevier-specific)

Per the Expositiones author guidelines fetched 2026-06-07. Each gate must be **green** before EES dispatch.

### G-AFFIL: corresponding-author affiliation

Elsevier corresponding-author affiliation is used to determine eligibility for institutional discounts and open-access agreements. It is *not* a hard scientific gate (unlike CRAS), but the OJS author profile must list a real institution.

**Status:** placeholder `[INSTITUTION, COUNTRY]` in the `.tex` files. **Action:** resolve before dispatch.

### G-ETHICS-1: no concurrent submission

Elsevier: *"the article is not under consideration for publication elsewhere."*

**Status:** if the CRAS submission is active, **do not dispatch Expositiones**. Wait for CRAS decision; on CRAS reject, dispatch Expositiones.

If the CRAS submission has not been dispatched yet, the author chooses which venue is primary. Recommendation: CRAS first (faster median review, no fees), Expositiones as fallback.

### G-ETHICS-2: original work (no prior publication)

Elsevier: *"the work described has not been published previously except in the form of a preprint, an abstract, a published lecture, academic thesis or registered report."*

**Status:** OK. The arXiv deposit (per the publication plan §6.1) is *permitted* explicitly as a preprint. Cite the arXiv ID in the manuscript front matter if deposited.

### G-AI: declaration of generative AI use

Elsevier mandates a declaration if AI tools were used in manuscript preparation. The declaration appears in a dedicated section **before** the references list, with the exact heading:

> **Declaration of generative AI and AI-assisted technologies in the manuscript preparation process.**
> *During the preparation of this work the author(s) used [NAME OF TOOL / SERVICE] in order to [REASON]. After using this tool/service, the author(s) reviewed and edited the content as needed and take(s) full responsibility for the content of the published article.*

This is **non-negotiable** if AI tools were used. The CRAS satellite did not require this (CRAS has no AI policy as of 2026); Expositiones (Elsevier-wide policy) does.

**Status:** declaration text drafted in §5 below. **Action:** review and adapt before dispatch.

### G-COI: declaration of competing interests as separate file

Elsevier requires a separate Word/.doc/.docx file uploaded at the "attach/upload files" step containing the declaration of competing interests. The text is generated from the *declarations tool* in EES.

**Status:** template content drafted in §6 below. **Action:** create `declaration-of-interests.docx` from the template content before dispatch.

### G-FUND: funding declaration

Elsevier mandates a funding declaration. The standard formulation:

> **Funding:** *This research did not receive any specific grant from funding agencies in the public, commercial, or not-for-profit sectors.*

(Or, if applicable: *This work has been supported by [funder] under grant numbers [xxxx, yyyy].*)

**Status:** the default no-funding text is used (the satellite is methodological, not grant-funded). **Action:** verify before dispatch and adapt if author received funding.

### G-HIGHLIGHTS: 3–5 article highlights

Elsevier *encourages* (not mandates) 3–5 bullet-point highlights, each ≤85 characters including spaces, submitted as a separate editable file. Helps discoverability via search engines.

**Status:** drafted at [`latex/highlights.txt`](latex/highlights.txt). All five bullets verified ≤85 characters.

### G-INCLUSIVE: inclusive language

Elsevier mandates inclusive language: gender-neutral phrasing, no descriptors about personal attributes unless relevant.

**Status:** the manuscript has no occasion to use gendered language about people. The Polish-school context describes named historical mathematicians with their actual names; no further inclusive-language concerns arise.

### G-FORMAT: LaTeX or Word; single column

Elsevier allows either; LaTeX preferred. Single column for Word; LaTeX may use elsarticle's double-column option but single is fine and is what we use.

**Status:** the LaTeX uses Elsevier's `elsarticle` class, single-column option (`elsarticle, preprint, 12pt`).

### G-REFS: references in citation-order, numerical style

Elsevier numerical reference style: in-text `[1]`, `[1,2]`, list ordered by **first appearance in the text** (not alphabetical, unlike CRAS Mathématique). Standard format examples documented in §C.6 below.

**Status:** the BibTeX uses `\bibliographystyle{elsarticle-num}` which produces the correct format.

### G-ABSTRACT: ≤250 words

Elsevier: abstract should not exceed 250 words. Avoid references in abstract.

**Status:** Draft 0.1 abstract is ~210 words; well under the limit.

### G-KEYWORDS: 1–7 keywords

Elsevier: 1 to 7 keywords for indexing. Avoid multi-word keywords joined by "and"/"of".

**Status:** 6 keywords selected: *Jensen equation, Cauchy equation, Hamel basis, functional equation, affine function, chord substitution*.

### G-MSC: not required for Expositiones (but include)

Elsevier general guidelines do not mandate an MSC line, but Expositiones' editorial practice welcomes it. We include `\subjclass[2020]{39B22, 39B05}` matching the CRAS submission.

**Status:** included.

---

## 3. Self-containment audit (Expositiones-specific)

Expositiones values clarity of exposition above all. A Short Research Note must be **fully self-contained** — readable end-to-end without prerequisite reading.

The CRAS satellite's §V (recurrence) relied on the reader broadly knowing what surrogate calibration is. For Expositiones we reframe §5 around the **structural pattern of Jensen saturation** in mathematics generally, with three example application areas treated symmetrically:

1. **Expected-utility representation theorems** (von Neumann–Morgenstern, Herstein–Milnor): the linearity-in-probability of utility on lotteries is exactly $(\star)$ with lotteries as the abstract points. The classical closure uses the Archimedean axiom; the chord substitution is the natural algebraic alternative.

2. **Shannon entropy's axiomatic characterization** (Khinchin, Faddeev): the recursivity axiom reduces, in intermediate steps, to $(\star)$ for certain auxiliary functions. The chord substitution is part of the standard toolkit.

3. **Surrogate calibration on the resolution axis** (the main paper [El2]): partition-Bayes-risk identities saturate Jensen and produce $(\star)$ directly. The lemma in the Lean formalization initially carried a boundedness hypothesis; the chord substitution retired it.

All three are presented at the same level of detail. The reader does not need to know any of them in advance — each is given its own one-paragraph setup. The Expositiones version is therefore self-contained even for a reader who has never seen Shannon entropy axiomatized or surrogate calibration formulated.

Compare with the CRAS version, where §V.1 invoked main-paper-specific notation ($\eta$, $\varphi_{\max}$, "aggregated concave score") in the first sentence. The Expositiones §5 invokes none of that vocabulary; the main paper is one example among three, not the load-bearing context.

---

## 4. Reframing decisions (CRAS → Expositiones)

Twelve concrete reframing decisions made for the Expositiones version:

| # | CRAS version (Draft 0.3) | Expositiones version (Draft 0.1) |
|---|---|---|
| R-1 | Roman section numbers §I, §II | Arabic §1, §2 (Elsevier convention) |
| R-2 | Bibliography alphabetical | Bibliography in citation order |
| R-3 | Abstract ~195 words | Abstract ~210 words (slightly expanded for pedagogical clarity) |
| R-4 | §V.1 leads with [El2] (one recurrence) | §5 leads with the *structural pattern* and uses three examples symmetrically |
| R-5 | §V.2 surrogate-calibration vocabulary (BJM, $\psi$-transform, biconjugate) | §5.4 uses the same vocabulary but with one-line glosses for non-specialists |
| R-6 | §V.3 adjacent settings as a brief footnote | §5.2–§5.3 promoted to full sections (vNM utility + entropy axiomatic, each with full paragraph) |
| R-7 | No concluding remarks section | §6 Concluding remarks (about half a page) |
| R-8 | Highlights not used (CRAS) | Highlights file with 5 bullets (Elsevier encouraged) |
| R-9 | Declaration of interests inline in text | Declaration of interests as separate `.docx` (Elsevier mandated) |
| R-10 | No AI declaration (CRAS has no policy) | AI declaration as new mandated section |
| R-11 | Funding not mentioned | Funding declaration as new section |
| R-12 | Bilingual metadata block (mandatory) | English only |

The mathematical *content* is identical: Theorem 1, Corollary 2, Theorem 1$'$, Theorem 3, Proposition 4, the dictionary table, the structural-mechanism argument. The *exposition* is rebuilt for the new audience.

---

## 5. AI declaration — draft text

The honest declaration, scoped precisely to what AI tools were used for:

> **Declaration of generative AI and AI-assisted technologies in the manuscript preparation process.**
>
> *During the preparation of this work the author used GitHub Copilot (Anthropic Claude family of models) in the following capacities: (i) drafting and revising prose in the manuscript and the supporting materials; (ii) cross-referencing bibliographic entries and verifying citation formats against journal guidelines; (iii) structuring the multi-round adversarial-audit cycle documented in the source repository accompanying this work. The mathematical content — including all theorems, proofs, examples, the structural argument of §5, and the dictionary of regularity hypotheses in §3 — was reviewed, verified, and refined by the author through the audit cycle. The author has reviewed and edited the content as needed and takes full responsibility for the content of the published article.*

This declaration is honest (the AI usage matches the project's documented workflow), specific (names the tools used and what they were used for), and accountable (asserts the author's responsibility for content).

If the author chooses **not** to declare AI usage (which is permissible if AI use was limited to basic grammar/spelling tools per Elsevier's policy), the declaration may be omitted. But given the extensive use of AI in the development of this satellite, honesty favors inclusion.

---

## 6. Declaration of competing interests — draft text

To be filed as a separate `.doc`/`.docx` file at the "attach/upload files" step in EES. The template content:

> **Declaration of competing interests.**
>
> *The author declares the following competing interests:*
>
> ☐ *Employment* — None to declare.
>
> ☐ *Consultancies* — None to declare.
>
> ☐ *Stock ownership relevant to this article* — None to declare.
>
> ☐ *Honoraria related to this article* — None to declare.
>
> ☐ *Paid expert testimony related to this article* — None to declare.
>
> ☐ *Patent applications or registrations related to this article* — None to declare.
>
> ☐ *Grants or other funding directly supporting this work* — None to declare.
>
> ☐ *Affiliation with the journal as Editor or Advisory Board Member* — None to declare.
>
> *Per Elsevier's standard formulation: "I have nothing to declare."*
>
> *Date:* [DATE OF SUBMISSION]
>
> *Author name:* [AUTHOR]
>
> *Author signature:* (Elsevier does not require signature for this declaration.)

The declaration is converted to a Word/`.docx` file by the author before EES upload. Elsevier does *not* accept the declaration as plain text — it must be the file format the *declarations tool* in EES produces.

---

## 7. Funding declaration — draft text

The default (no funding) text, per Elsevier's recommended formulation:

> **Funding.**
>
> *This research did not receive any specific grant from funding agencies in the public, commercial, or not-for-profit sectors.*

This appears as a numbered section in the manuscript body, just before the AI declaration and the references.

If the author received any funding for the broader research program of which this satellite is a part (e.g., an institutional grant supporting the main paper [El2]), update the text per Elsevier's standard formulation:

> *Funding: This work was supported by [funder name] [grant number aaaa].*

---

## 8. Editorial process and timing

Single-anonymized peer review with minimum two reviewers.

**Expected timeline** (estimates; verify against current Elsevier journal page before submission):

- Editor's initial-suitability assessment: ~1–2 weeks.
- Reviewer assignment: ~1–2 weeks.
- Reviewer turnaround: 4–12 weeks.
- Editor's decision (first round): ~3–6 months total.
- Revision cycle (if applicable): 4–8 weeks for author revision + 4–8 weeks for re-review.
- Total decision time: ~6–9 months typical for Short Research Notes.

This falls within the author's stated tolerance (6 months acceptable, 9 months upper bound).

**Editorial board contact**: an editor in analysis or general mathematics will be assigned by routing; no specific editor is requested.

---

## 9. Submission package contents

The complete Expositiones submission package consists of:

| File | Format | Purpose |
|---|---|---|
| [`latex/manuscript.tex`](latex/manuscript.tex) | LaTeX (`elsarticle` class) | Source file |
| [`latex/manuscript.pdf`](latex/manuscript.pdf) | PDF | Compiled manuscript for review |
| [`latex/refs.bib`](latex/refs.bib) | BibTeX | Bibliography source |
| [`latex/highlights.txt`](latex/highlights.txt) | Plain text | Article highlights (3–5 bullets) |
| `declaration-of-interests.docx` | Word (separate file) | Competing interests declaration (from §6 above) |
| Cover letter | Plain text in EES "Comments to Editor" | Per §10 below |

The harness ([`latex/build.ps1`](latex/build.ps1) / [`latex/build.sh`](latex/build.sh)) produces the PDF from the source. The Word `declaration-of-interests.docx` is produced by the author (Elsevier requires Word/.doc format specifically).

---

## 10. Cover letter — draft

To paste into the EES "Comments to Editor" field on submission.

> *Dear Editor,*
>
> *I am pleased to submit "The continuous-coefficient Jensen equation: A note on three vestigial regularity hypotheses" for consideration as a Short Research Note in Expositiones Mathematicae.*
>
> *The note (~9 pages) is a self-contained pedagogical treatment of a recurrent confusion in applied analysis. The continuous-coefficient form of Jensen's functional equation — $p G(u_1) + (1-p) G(u_2) = G(p u_1 + (1-p) u_2)$, imposed for every $u_1, u_2$ and every $p \in [0,1]$ — has a one-line proof of affineness via a chord substitution, with no regularity hypothesis on $G$ required. The classical Cauchy–Hamel literature establishes that the same conclusion for the discrete-coefficient version $(J_2)$ does require a regularity hypothesis (Cauchy, Darboux, Sierpiński, Steinhaus, Ostrowski together provide the dictionary). The note articulates the dictionary of three regularity hypotheses (continuity, measurability, boundedness) that become vestigial under the continuous-coefficient form and articulates the structural reason — the Hamel pathology lives at irrational $p$, exactly where the continuous coefficient closes the door.*
>
> *The note further documents a structural pattern: the trap of invoking unnecessary Cauchy/Hamel regularity recurs whenever a derivation pushes Jensen's inequality to saturation across a wide class of two-point distributions, and the chord substitution is the natural closure in each such case. Three example application areas are treated symmetrically: expected-utility representation (von Neumann–Morgenstern), Shannon entropy's axiomatic characterization (Khinchin–Faddeev), and surrogate calibration on the resolution axis (a recent manuscript of the author, cited as [El2] in the bibliography).*
>
> *The mathematical content is folkloric (Aczél [1, §2.1], Kuczma [9, Ch. 13]). The contribution of the note is the explicit packaging of the dictionary, the structural-pattern observation, and the citation point for working analysts. I believe the Short Research Note category is the right fit: the topic is specialized (a corner of functional equations), the result is precise (the dictionary plus the structural pattern), and the level is suitable for a broad mathematical audience interested in classical analysis and its modern applications.*
>
> *The note is original work, has not been submitted elsewhere in any language, and is currently a preprint on arXiv (math.HO, math.CA). I look forward to your review.*
>
> *Sincerely,*
> *[AUTHOR NAME]*
> *[INSTITUTION]*
> *[author@institution.country]*

---

## 11. Fallback plan

| Verdict | Action |
|---|---|
| **Accept (round 1)** | Proceed to production; expected ~6 weeks from acceptance to publication for an Elsevier journal of this profile. |
| **Revise & resubmit (R&R)** | Address the editor's points in a closure-round Markdown file. Re-build LaTeX. Re-submit through EES. |
| **Reject — out of scope** | Pivot to *Mathematical Intelligencer* (Springer, more popular tone) or *L'Enseignement Mathématique* (EMS, slightly different format). The manuscript carries over with minor template-only changes. |
| **Reject — quality** | Re-audit Judge π / Judge S findings (the CRAS audit chain) for anything missed; open a new audit round if needed. Re-target *Mathematical Intelligencer*. |
| **No response after 6 months** | Status query via the EES message system. If no response after 9 months, withdraw and re-submit. |

If the CRAS submission has not yet been dispatched and the author dispatches Expositiones instead, the CRAS satellite is held as the fallback for any Expositiones rejection. The fallback chain is symmetric.

---

## 12. Sign-off (Judge E)

Strategy memo **complete**. The Expositiones submission package complies with every Elsevier gate that does not depend on operational decisions (author affiliation, AI-declaration text, funding declaration text). The remaining items are operational and require human input:

- Resolve `[AUTHOR]` / `[INSTITUTION]` placeholders.
- Decide AI declaration text (§5 draft is the recommendation; adapt if the author's AI usage differs).
- Decide funding text (§7 default is no-funding; update if applicable).
- Create the Word `.docx` declaration-of-interests file from §6 template.
- (If CRAS is active) wait for CRAS decision before EES dispatch.

When operational items are resolved, follow the Day –1 / Day 0 procedure in [`99-submission-checklist.md`](99-submission-checklist.md).

**Judge E sign-off:** the Expositiones lane of opportunity O3 is ready for dispatch pending operational decisions.
