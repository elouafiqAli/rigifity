# O3 satellite — *Expositiones Mathematicae* track

*Short Research Note submission of the chord-substitution result. Parallel to the CRAS satellite at [`../o3-chord-substitution/`](../o3-chord-substitution/), with a different framing for a different venue.*

---

## Why a second satellite?

The CRAS satellite is a tight 5-page note targeting the working-researcher *Comptes Rendus Mathématique* audience: declarative, compressed, optimized as a citation point. *Expositiones Mathematicae* publishes a different category of work — **Short Research Notes** (≤10 pages) on specialized topics, with editorial emphasis on *clarity of exposition*. The two satellites are not redundant: each is the *right shape* for its venue.

Per the publication plan ([`../../21-publication_plan.md`](../../21-publication_plan.md)), the CRAS satellite is the **primary** O3 submission and the Expositiones manuscript is the **prepared fallback** — fully drafted and ready to dispatch if CRAS declines, or as a parallel primary submission if the author prefers a longer pedagogical framing. The two have *substantively different framings* (citation-point vs. self-contained pedagogical note) and are not the same paper in any meaningful sense.

| | CRAS satellite | Expositiones satellite |
|---|---|---|
| **Venue** | *Comptes Rendus Mathématique* | *Expositiones Mathematicae* |
| **Length target** | ~5 pages | ~9–10 pages |
| **Audience** | Working researchers in analysis/calibration | Mathematics community broadly; emphasis on clarity |
| **Section numbering** | Roman (§I, §II, §III) | Arabic (§1, §2, §3) |
| **Reference style** | Numeric in text, alphabetical-by-first-author in list | Numeric in text, citation-order in list |
| **LaTeX class** | Centre Mersenne `crmath` (or amsart fallback) | Elsevier `elsarticle` |
| **Bilingual** | English primary + French native translation | English only |
| **Self-containment** | Cites [El2] for the recurrence example | Generalizes §5 to "Jensen-saturation" pattern; main paper is one example among three |
| **Acceptance rate** | ~11 % (2025) | comparable specialist range |
| **Hard gates** | G-1 affiliation, G-4 bilingual, G-6 `crmath` | G-AI declaration, G-COI declaration in DOC, G-highlights, G-funding |

---

## Files in this folder

| File | Purpose |
|---|---|
| [`README.md`](README.md) | This file — overview + audit chain + status |
| [`00-strategy.md`](00-strategy.md) | Submission strategy: Elsevier-specific gates, single-anonymized peer-review process, AI-declaration drafting, fallback plan |
| [`01-manuscript.md`](01-manuscript.md) | Markdown source of the manuscript (~9–10 typeset pages) |
| [`latex/`](latex/) | LaTeX harness (`elsarticle` class, BibTeX, build scripts, README) |
| [`99-submission-checklist.md`](99-submission-checklist.md) | Operational pre-flight before EM editorial-system dispatch |

---

## Audit chain (compressed)

The mathematical content of the manuscript is *identical* to the CRAS version ([`../o3-chord-substitution/09-draft0.3-manuscript.md`](../o3-chord-substitution/09-draft0.3-manuscript.md)) — so it inherits the full audit chain:

- Round 2 Judge π audit ([`../o3-chord-substitution/02-judge-pi-audit.md`](../o3-chord-substitution/02-judge-pi-audit.md))
- Round 4 Judge S prior-art audit ([`../o3-chord-substitution/04-judge-s-prior-art-audit.md`](../o3-chord-substitution/04-judge-s-prior-art-audit.md))
- Phase C Judge π rigor + wide-audience audit ([`../o3-chord-substitution/08-judge-pi-rigor-audit.md`](../o3-chord-substitution/08-judge-pi-rigor-audit.md))

What is *new* for the Expositiones version:

- **Framing audit** ([`00-strategy.md`](00-strategy.md) §3): the introduction is rewritten for the broader Expositiones audience; §5 is reframed around "Jensen-saturation as a structural pattern" with three example fields (utility theory, entropy axiomatic characterization, surrogate calibration) rather than a single calibration-theory recurrence.
- **Self-containment audit** ([`00-strategy.md`](00-strategy.md) §4): every external reference is checked against the *can-a-reader-follow-this-without-prior-knowledge?* standard. The Expositiones version cites [El2] as one example among three, not as the load-bearing context.
- **Elsevier-format compliance audit** ([`00-strategy.md`](00-strategy.md) §2): seven Elsevier-specific gates (AI declaration, competing interests in DOC, funding, highlights, inclusive language, jurisdictional claims, reference style).

---

## Status

| Phase | Deliverable | Status |
|---|---|---|
| Strategy | [`00-strategy.md`](00-strategy.md) | landed |
| Manuscript | [`01-manuscript.md`](01-manuscript.md) | landed (Draft 0.1, ~9 pages typeset) |
| LaTeX | [`latex/manuscript.tex`](latex/manuscript.tex), [`latex/refs.bib`](latex/refs.bib), [`latex/highlights.txt`](latex/highlights.txt), [`latex/build.{ps1,sh}`](latex/), [`latex/README.md`](latex/README.md) | landed |
| Submission | [`99-submission-checklist.md`](99-submission-checklist.md) | landed |

**Pending operational items before EES (Elsevier Editorial System) dispatch:**

- Replace `[AUTHOR]` / `[INSTITUTION]` / `[author@institution.country]` placeholders.
- Prepare the **Declaration of Competing Interests** as a separate `.docx` file (instructions in [`99-submission-checklist.md`](99-submission-checklist.md) §3 G-COI).
- Decide on the AI declaration text (draft in [`00-strategy.md`](00-strategy.md) §5).
- Decide on funding text (template in [`00-strategy.md`](00-strategy.md) §6).
- (Optional) Coordinate with the CRAS submission: only one venue at a time per Elsevier ethics policy.

---

## Cross-reference to the publication plan

This satellite folder is the **Expositiones lane** of opportunity O3 in [`../../21-publication_plan.md`](../../21-publication_plan.md) §4 Tier 1. The CRAS lane is at [`../o3-chord-substitution/`](../o3-chord-substitution/). Both are *Star* mode (per §1.4 of the publication plan): directly cited by §4.2 Step 2 of the main paper [El2] once published.

The author chooses one as the **primary** submission and holds the other as the **fallback**. Recommendation: dispatch CRAS first (faster median review, Diamond Open Access, no fees), hold Expositiones as fallback if CRAS declines. Both are fully prepared.
