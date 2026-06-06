# O2 — *"Calibration on the resolution axis: a methodology note"*

*Satellite #2 of the seeding plan ([`../21-publication_plan.md`](../21-publication_plan.md) §4.1 / §8). Construct C2. Mode **Bush** (around the transposition concept). Primary venue **EMS Magazine**; fallback **Snapshots of Modern Mathematics from Oberwolfach** / **Mathematical Intelligencer**.*

---

## 0. Status

| Round  | Phase                                                                                        | Owner                | Deliverable                                                                  | State          |
| ------ | -------------------------------------------------------------------------------------------- | -------------------- | ---------------------------------------------------------------------------- | -------------- |
| —      | Pre-flight (5-question check, [`../21-publication_plan.md`](../21-publication_plan.md) §1.3) | Coordinator          | [`00-preflight.md`](00-preflight.md)                                         | **done**       |
| **1**  | Skeleton draft                                                                               | Executor E           | [`01-skeleton-draft0.md`](01-skeleton-draft0.md)                             | **done**       |
| **2**  | Adversarial audit (hostile-referee mode)                                                     | Judge π + Judge S    | [`02-adversarial_audit.md`](02-adversarial_audit.md)                         | **done**       |
| **3**  | Closure — commitology + revised text                                                         | Executor E           | [`03-closure-draft0.1.md`](03-closure-draft0.1.md)                           | **done**       |
| **3′** | Manuscript (publishable text, EMS layout)                                                    | Executor E           | [`04-manuscript-final.md`](04-manuscript-final.md)                           | **done**       |
| **4**  | Submission package (cover letter + arXiv preface + venue intel + decision log)               | Executor E + Judge E | [`05-submission-package.md`](05-submission-package.md)                       | **done**       |
| 5      | Submit to EMS Magazine + arXiv deposit                                                       | Author               | submitted manuscript, arXiv ID, EMS submission acknowledgement               | *not yet*      |
| 6      | Decision (accept / R&R / reject)                                                             | EMS Editor           | Decision letter; if R&R, Round 7 closure; if reject, fallback-venue redirect | *open*         |

This folder is **self-contained**. Anyone reading the satellite for the first time should be able to read [`README.md`](README.md) → [`00-preflight.md`](00-preflight.md) → [`04-manuscript-final.md`](04-manuscript-final.md) and have everything they need, with the audit / closure documents serving as the audit trail.

## 1. What this satellite is

A short expository methodology note (~6–8 pp.) that names and explains the **resolution-axis transposition** of classical surrogate calibration. The piece contrasts the *optimization axis* (BJM 2006, Reid–Williamson 2011 — the predictor is varied) against the *resolution axis* (the partition $\Pi$ is varied), shows the two-sided bracket on $\varepsilon^*(\Pi)$ with universal $c_\varphi = \tfrac12$, gives one fully worked two-cell example, and ends with forward pointers to where the GNN / property-test / refinement-lattice applications live — **without** revealing those applications.

The note is **not** a theorem paper. Its three theorems are imported verbatim from satellite **O1** (the bracket paper, [`../21-publication_plan.md`](../21-publication_plan.md) §4 Tier 1) and the main paper. Its contribution is *vocabulary* — the named transposition, the perpendicular-axes picture, the read-aloud distinction between the BJM $\psi$-transform gap and the bracket's $c_\varphi$ gap.

## 2. What this satellite is **not**

- It is **not** the bracket paper itself — that is **O1** (SPL), submitted in parallel.
- It does **not** carry the GNN consequences — those live in the main paper (after seeding completes) and in **O5/O6/O8/O9/O10/O11**.
- It does **not** carry the simplex extension — that is in the main paper (and satellite **O7** for the lower bracket).
- It does **not** carry the formal-methods backstop — that is **O12** / **O13** / **O14**.
- It does **not** carry the f-divergence / Le Cam / Bregman dual pieces — those are the Tier 5 Exploration pieces **O15** / **O16** / **O19**.

The Bush-mode discipline (per [`../21-publication_plan.md`](../21-publication_plan.md) §1.4) is to *populate the on-ramp* without duplicating any single result. The audit in [`02-adversarial_audit.md`](02-adversarial_audit.md) verifies this discipline holds across the draft.

## 3. One-sentence backstop the main paper gains

> *"The transposition framing is the methodology note [Author, EMS Magazine 2026]; here we apply it to the partition induced by a graph neural network."*

(Per Q2 of the pre-flight, [`00-preflight.md`](00-preflight.md).)

## 4. File index

| File                                                       | Purpose                                                                                                                                                                                                                                                              |
| ---------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| [`README.md`](README.md)                                   | This navigation document.                                                                                                                                                                                                                                            |
| [`00-preflight.md`](00-preflight.md)                       | The five pre-flight questions ([`../21-publication_plan.md`](../21-publication_plan.md) §1.3) answered before any drafting began. The piece's no-go gate.                                                                                                            |
| [`01-skeleton-draft0.md`](01-skeleton-draft0.md)           | Round 1 — skeleton draft (Executor E voice). Establishes the perpendicular-axes picture, the bracket statement, the worked example, and the three forward pointers. *Imported and revised in Round 3 → Manuscript.*                                                  |
| [`02-adversarial_audit.md`](02-adversarial_audit.md)       | Round 2 — adversarial audit (Judge π for methodology over-claiming, Judge S for calibration-literature precedent). Numbered findings, severity-tagged ([C] / [M] / [m] / [S]), with the same hostile-referee discipline as the main-paper audits ([`../05`](../05-pi_adversarial_audit_of_draft0.md), [`../17`](../17-pi_adversarial_audit_of_draft0.6_post_phase_d.md)). |
| [`03-closure-draft0.1.md`](03-closure-draft0.1.md)         | Round 3 — closure commitology. Atomic dispositions per finding (accept / push-back / defer), with the diff against Round 1 enumerated.                                                                                                                              |
| [`04-manuscript-final.md`](04-manuscript-final.md)         | The publishable manuscript. EMS Magazine layout (one column, ~6–8 pp., minimal apparatus). This is what gets sent to the editor.                                                                                                                                    |
| [`05-submission-package.md`](05-submission-package.md)     | Cover letter to EMS Magazine, arXiv tutorial preface for the simultaneous deposit, decision log of the venue choice, and the fallback ladder (Snapshots → Mathematical Intelligencer → arXiv-as-archival).                                                          |

## 5. Cross-references into the workspace

- The publication plan that scoped this satellite: [`../21-publication_plan.md`](../21-publication_plan.md) §4.1 (O2) and §8 (the two lists).
- The panel verdict that signed off the main paper: [`../19-panel_verdict.md`](../19-panel_verdict.md).
- The main paper this note seeds the on-ramp for: [`../03-t0-achievable_error_floor.md`](../03-t0-achievable_error_floor.md) — specifically §§1.1–1.2 ("what is new, and what is not" and the prior-art audit), where the resolution-axis transposition is named and contrasted against BJM and Reid–Williamson.
- The audit discipline these documents mirror: [`../05-pi_adversarial_audit_of_draft0.md`](../05-pi_adversarial_audit_of_draft0.md), [`../17-pi_adversarial_audit_of_draft0.6_post_phase_d.md`](../17-pi_adversarial_audit_of_draft0.6_post_phase_d.md), [`../18-panel_review_charter.md`](../18-panel_review_charter.md) §3.
- The personas referenced (Executor E, Judge π, Judge S, Judge E): [`../18-panel_review_charter.md`](../18-panel_review_charter.md) §1, recast for satellite authorship per [`../21-publication_plan.md`](../21-publication_plan.md) §2.
