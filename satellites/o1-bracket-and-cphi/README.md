# O1 — *"A bracket for the partition-restricted Bayes risk"*

**Satellite paper of:** [`../../03-t0-achievable_error_floor.md`](../../03-t0-achievable_error_floor.md) (Draft 0.7 Final).
**Constructs seeded:** C1 (bracket + universal $c_\varphi=\tfrac12$) and C9 (refinement-lattice converse to Blackwell: binary-split monotone ⟹ concave).
**Mode (per [`../../21-publication_plan.md`](../../21-publication_plan.md) §1.4):** **Star** — directly cited by §1 and §3.1 of the main paper, so that the main paper drops the inline bracket derivation and the Theorem 1 converse proof and writes `"by [Author, SPL], ..."`.
**Primary venue:** *Statistics & Probability Letters* (Elsevier). **Fallback:** *Electronic Communications in Probability* (open access, IMS/Bernoulli Society).
**Author lane:** Executor T (convex analysis / decision theory). **Audit lane:** Judge π then Judge S (with Judge S as the load-bearing prior-art auditor against Reid–Williamson 2011, BJM 2006, Zhang 2004).

---

## Status

| Round | Deliverable | File | Status |
|---|---|---|---|
| 0 | Extraction + context + 5-question pre-flight | [`00-extraction-and-context.md`](00-extraction-and-context.md) | landed |
| 1 | Draft 0.0 — skeleton SPL/ECP manuscript | [`01-draft0.0-manuscript.md`](01-draft0.0-manuscript.md) | landed |
| 2 | Judge π — adversarial audit memo | [`02-judge-pi-audit.md`](02-judge-pi-audit.md) | landed |
| 3 | Draft 0.1 — closure of π audit | `03-draft0.1-manuscript.md` | queued |
| 4 | Judge S — prior-art audit memo (Reid–Williamson, BJM, Zhang) | `04-judge-s-prior-art-audit.md` | queued |
| 5 | Draft 0.2 — submission-ready manuscript | `05-draft0.2-manuscript.md` | queued |

When the manuscript is sent to *Statistics & Probability Letters* (SPL), the submission record (date, manuscript ID, decision letters) is appended to a `99-submission-log.md` in this folder.

---

## What this satellite gives the main paper

Two one-line citations. After publication, the main paper's §1 (bracket and universal $c_\varphi=\tfrac12$) and §3.1 (Theorem 1) will be allowed to read:

> *"For every normalized concave score $\varphi$ on $[0,1]$, the partition functional $\bar\varphi$ brackets the partition-restricted Bayes risk as $\varphi^{-1}(\bar\varphi(\Pi)) \le \varepsilon^\ast(\Pi) \le \tfrac12\,\bar\varphi(\Pi)$ ([Author, SPL 2026, Theorem 3]); the upper constant $c_\varphi = \tfrac12$ is uniform across the class and attained at $\eta=\tfrac12$. Refinement-monotonicity of $\bar\varphi$ over partitions is equivalent to concavity of $\varphi$ ([Author, SPL 2026, Theorem 1]) — the refinement-lattice converse of Blackwell's qualitative comparison-of-experiments inequality."*

That replaces the current ~25-line derivation block in §1 of the main paper (the bracket statement, the chord argument for $c_\varphi=\tfrac12$, the supremum-vs-attained sub-remark) and the ~14-line Theorem 1 proof block in §3.1. The satellite carries the proofs, the historical positioning against Blackwell / Le Cam / BJM / Reid–Williamson, the worked examples (Shannon entropy, rescaled variance, tent), and the explicit dictionary that distinguishes the resolution-axis bracket from the optimization-axis $\psi$-transform.

---

## What this satellite does *not* claim

- **Not the original Bayes-risk / generalized-entropy correspondence.** That is Savage 1971 / DeGroot 1962 / Grünwald–Dawid 2004. We use it; we recall it; we do not claim it.
- **Not Blackwell's monotonicity-under-refinement direction.** Theorem 1's $(\mathrm{iii})\Rightarrow(\mathrm{i})$ direction is Blackwell 1953 on the refinement lattice; we recall it for completeness. The **converse direction** $(\mathrm{ii})\Rightarrow(\mathrm{iii})$ — that binary-split monotonicity *forces* $\varphi$ concave — is what we extract and articulate.
- **Not surrogate calibration on the optimization axis.** BJM 2006, Zhang 2004, Tewari–Bartlett 2007, Reid–Williamson 2010/2011 own that line. We position the resolution-axis bracket against it explicitly in §6 of the manuscript, drawing a clean line: their $\psi$-transform controls excess risk of a *predictor*; our bracket controls the absolute floor as a function of the *partition* the model can access.
- **Not the GNN consequences.** The main paper derives Corollary 4 (aggregator half-chain), Theorem 5 (depth/architecture), Proposition 6 (two-query local test) from the bracket. This satellite stops one inch short — pure decision theory, no graph content. The C7 (aggregator half-chain) and C6 (two-query identity) satellites are O6 and O5 in the publication plan respectively, each with its own seeding.
- **Not the multiclass extension.** Theorem 2$'$ (simplex rigidity) and the lower-bracket biconjugate construction are extracted in their own satellites (the simplex rigidity is in scope for the multiclass-rigidity satellite, and the level-set floor is C5 / O7 in the publication plan). This satellite is binary throughout.

---

## Audit discipline (per [`../../21-publication_plan.md`](../../21-publication_plan.md) §1.2)

Each round closes only when the named judge signs off in writing. The audit memos are line-cited adversarial findings tagged `[Critical] / [Material] / [Minor] / [Strategic]`, in the same format as the seven-round audit trail of the main paper ([`../../05`](../../05-pi_adversarial_audit_of_draft0.md), [`../../07`](../../07-pi_adversarial_audit_of_04.md), [`../../10`](../../10-external_reviewer_audit_of_draft0.2.md), [`../../12`](../../12-external_reviewer_second_audit_of_draft0.3.md), [`../../17`](../../17-pi_adversarial_audit_of_draft0.6_post_phase_d.md), [`../../19`](../../19-panel_verdict.md)). The pattern mirrors the sibling satellite [`../o3-chord-substitution/`](../o3-chord-substitution/README.md), which carries the same Round 0 → Round 5 cadence for the chord-substitution note.

---

## Workspace / worktree note

This satellite is a sibling folder under [`satellites/`](../), not a separate git worktree. The artefacts are pure markdown (manuscript + audit memos + extraction notes), so the worktree machinery (independent branch checkout, isolated build artefacts) buys nothing here. If at some future point the satellite acquires its own Lean kernel or its own build pipeline, the worktree option becomes worth revisiting; until then, sibling-folder is the established pattern (see [`../o3-chord-substitution/`](../o3-chord-substitution/)).
