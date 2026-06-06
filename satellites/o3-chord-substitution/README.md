# O3 — *"The chord substitution closes the continuous Jensen equation"*

**Satellite paper of:** [`../../03-t0-achievable_error_floor.md`](../../03-t0-achievable_error_floor.md) (Draft 0.7 Final).
**Construct seeded:** C4 — chord substitution for the continuous Jensen equation.
**Mode (per [`../../21-publication_plan.md`](../../21-publication_plan.md) §1.4):** **Star** — directly cited by §4.2 Step 2 of the main paper, replacing the Hamel detour the panel verdict flagged in M-2.
**Primary venue:** *Comptes Rendus Mathématique* (Académie des sciences). **Fallback:** *Expositiones Mathematicae*.
**Author lane:** Executor T. **Audit lane:** Judge π then Judge S.

---

## Status

Multi-phase audit + LaTeX harness package. Two-phase trail: the initial mathematical-audit cycle (Rounds 0–5) produced a Markdown manuscript; the CRAS-targeting cycle (Phases A–J) re-audited for the wide-mathematician CRAS audience, added the French native version, and produced the LaTeX submission package.

### Initial audit cycle (Rounds 0–5) — mathematical content frozen

| Round | Deliverable | File | Status |
|---|---|---|---|
| 0 | Extraction + context + 5-question pre-flight | [`00-extraction-and-context.md`](00-extraction-and-context.md) | landed |
| 1 | Draft 0.0 — skeleton manuscript | [`01-draft0.0-manuscript.md`](01-draft0.0-manuscript.md) | landed |
| 2 | Judge π — adversarial audit memo (4 [Material] + 4 [Minor] + 2 [Strategic]) | [`02-judge-pi-audit.md`](02-judge-pi-audit.md) | landed |
| 3 | Draft 0.1 — closure of π audit | [`03-draft0.1-manuscript.md`](03-draft0.1-manuscript.md) | landed |
| 4 | Judge S — prior-art audit memo (2 [Minor] strengthenings) | [`04-judge-s-prior-art-audit.md`](04-judge-s-prior-art-audit.md) | landed |
| 5 | Draft 0.2 — Markdown-format submission-ready manuscript | [`05-draft0.2-manuscript.md`](05-draft0.2-manuscript.md) | landed |

### CRAS-targeting cycle (Phases A–J) — venue-fit + bilingual + LaTeX

| Phase | Deliverable | File | Status |
|---|---|---|---|
| A | Multi-phase strategy memo (commitology, intermediate objectives IO-1/IO-2/IO-3) | [`06-cras-strategy.md`](06-cras-strategy.md) | landed |
| B | CRAS format reconnaissance (9 hard gates G-1…G-9; verbatim source citations) | [`07-cras-format-reconnaissance.md`](07-cras-format-reconnaissance.md) | landed |
| C | Judge π rigor + wide-mathematician-audience audit (3 [Material] + 4 [Minor] + 2 [Strategic]) | [`08-judge-pi-rigor-audit.md`](08-judge-pi-rigor-audit.md) | landed |
| D | English Draft 0.3 — CRAS-ready, Roman §, declaration-of-interests, MSC simplified, table widened | [`09-draft0.3-manuscript.md`](09-draft0.3-manuscript.md) | landed |
| E | French translation specification (notation, idiom, typography — espace insécable, « », ISO intervals) | [`10-french-translation-spec.md`](10-french-translation-spec.md) | landed |
| F | French native Draft 0.3 | [`11-draft0.3-fr-manuscrit.md`](11-draft0.3-fr-manuscrit.md) | landed |
| G | Judge fr linguistic audit (2 [Material] + 4 [Minor] + 1 [Strategic]) | [`12-judge-fr-audit.md`](12-judge-fr-audit.md) | landed |
| H | French Draft 0.4 — closure of fr audit; ready for LaTeX | [`13-draft0.4-fr-manuscrit.md`](13-draft0.4-fr-manuscrit.md) | landed |
| I | LaTeX harness — `.tex` (en+fr) + BibTeX + build script + README, with `crmath` and amsart-fallback configurations | [`latex/`](latex/) | landed |
| J | Submission checklist + cover letter draft + arXiv-first plan + fallback plan | [`99-submission-checklist.md`](99-submission-checklist.md) | landed |

### Pending operational items (block submission)

- ⏳ **G-1**: author institutional affiliation confirmation (CRAS rejects independent researchers without review).
- ⏳ **G-6**: install Centre Mersenne `crmath` class (or ship with the amsart fallback).
- ⏳ Replace `[AUTHOR]`, `[INSTITUTION, COUNTRY]`, `[author@institution.country]` placeholders in `.tex` files.
- ⏳ (Optional) arXiv-first deposit 24–48 h before OJS dispatch.

When the manuscript is sent to *Comptes Rendus Mathématique* (CRAS), the submission record (OJS manuscript ID, dispatch date, decision letters) is appended to §5 of [`99-submission-checklist.md`](99-submission-checklist.md).

---

## What this satellite gives the main paper

A one-line citation. After publication, the main paper's §4.2 Step 2 will read:

> *"By [Author, CRAS 2026, Lemma 1], the continuous-coefficient form of Jensen's equation $(\star)$ has the unique solution $G(v)=av+b$ with $a=(G(\varphi_{\max})-G(0))/\varphi_{\max}$ and $b=G(0)$; in particular no Hamel-basis pathology can arise, and no measurability or boundedness hypothesis on $G$ is needed."*

That is the entirety of the Step 2 prose in the main paper post-citation. The satellite carries the proof, the dictionary of regularity hypotheses that are *not* needed, the literature positioning, and the worked examples of where the trap recurs.

---

## What this satellite does *not* claim

- **Not a novel theorem.** The chord substitution is folklore — the proof is one line and goes back at least to Aczél (1966). The contribution is **expository / methodological** in the CRAS-tradition of clean one-page notes correcting a recurring confusion.
- **Not a contribution to the theory of pathological functional equations.** Hamel (1905), Sierpiński (1920), Steinhaus (1920), Kuczma (1985/2009) own that literature; this note merely articulates *which* of their pathologies the continuous-coefficient form sidesteps.
- **Not a unification.** The discrete and continuous Jensen equations remain genuinely different — this note draws the line clearly, it does not erase it.

---

## Audit discipline (per [`../../21-publication_plan.md`](../../21-publication_plan.md) §1.2)

Each round / phase closes only when the named judge signs off in writing. The audit memos are not marketing; they are line-cited adversarial findings tagged `[Critical] / [Material] / [Minor] / [Strategic]`, in the same format as the seven-round audit trail of the main paper ([`../../05`](../../05-pi_adversarial_audit_of_draft0.md), [`../../07`](../../07-pi_adversarial_audit_of_04.md), [`../../10`](../../10-external_reviewer_audit_of_draft0.2.md), [`../../12`](../../12-external_reviewer_second_audit_of_draft0.3.md), [`../../17`](../../17-pi_adversarial_audit_of_draft0.6_post_phase_d.md), [`../../19`](../../19-panel_verdict.md)).

Four audit personae have signed off on this satellite~: Judge π (twice — Rounds 2 and C), Judge S (Round 4), Judge fr (Phase G), and Judge E (Phase J). The composite verdict is **CONDITIONAL PASS pending operational gates G-1 / G-6 / placeholders**.
