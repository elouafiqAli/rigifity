# Draft 0.1 → Draft 0.2 Commitology
### *Consolidation plan: fold `04` into `03` as a real §4, applying the eight audit fixes from [`07`](07-pi_adversarial_audit_of_04.md) during the import.*

> **Discipline.** Same as `06`: each commit (i) has a *single* scope, (ii) cites the audit item(s) it closes, (iii) is independently revertible, (iv) leaves the manuscript textually coherent. Audit severity codes: **C** critical, **M** major, **m** minor.
>
> **Convention.** `<type>(<scope>): <imperative summary>`; body cites audit items by tag and states verification. Types: `chore`, `feat`, `fix`, `docs`. Scopes: paper section (`§N`), document name (`03`, `04`, `08`).

---

## Strategy

**Path B from [`07`](07-pi_adversarial_audit_of_04.md):** fold `04` into `03` as §4 (currently a stub: "merged into §1.2"). Apply audit fixes M-1, M-2, m-1, m-2, m-3, m-4, m-5, m-6 **during** the import — no value in landing known-broken text and then patching it. `04` is retired to a one-line redirect at the end.

**Why not in-place fixes to `04`?** (i) `04`'s preamble was originally written for this exact arrangement (*"slots into the Draft 0 as the multiclass section"*); (ii) `03` has a vacant §4 slot, so no renumbering; (iii) consolidation eliminates cross-document inconsistency by construction (m-5 vanishes at the structural level); (iv) the final paper is a single self-contained artifact.

---

## Target structure of `03` after consolidation

| § | Title | Source | Δ |
|---|---|---|---|
| 1 | Introduction | `03` §1 | abstract + §1: note multiclass reach in §4 |
| 2 | Preliminaries | `03` §2 | unchanged (`6a86ffd`) |
| 3 | Calibration on the refinement lattice (binary) | `03` §3 | unchanged (`f556246`, `779d533`) |
| **4** | **Multiclass extension on the simplex** | **all of `04`** | **NEW: replaces stub** |
| 4.1 | Simplex setup + bracket | `04` §1–2 | + M-2 ($c_\varphi<\infty$) |
| 4.2 | Simplex rigidity theorem | `04` §3 | + M-1 (atomless hyp), m-3 (Step 1 highlight), m-4 (bounded-Jensen) |
| 4.3 | Smoothness forces slack | `04` §4 | + m-1 (level-set framing), m-2 (kink-locus widening) |
| 4.4 | Binary consistency check | `04` §5 | unchanged |
| 4.5 | Refinement monotonicity transfer | new line | + m-6 (Thm 1 transfer) |
| 5 | Expressivity as a calibrated gap test | `03` §5 | unchanged (`f65b838`) |
| 6 | Depth and architecture | `03` §6 | unchanged (`d21be23`, `a7ce551`) |
| 7 | The measure is operational | `03` §7 | unchanged (`b02a214`, `15729f6`) |
| 8 | Discussion, scope, and open problems | `03` §8 | collapse OP1a → "see §4"; OP1b–3 unchanged |
| 9 | References | merged | + Tewari–Bartlett 2007, Ramaswamy–Agarwal 2012, Pires–Szepesvári 2016 |

---

## Notation unification

| Symbol | Binary use | Multiclass use | Rule |
|---|---|---|---|
| $\eta$ | scalar in $[0,1]$ | — | §§1–3, 5–7 |
| $\boldsymbol\eta$ | — | vector in $\Delta^{k-1}$ | §4 only |
| $\eta_c$ | — | component $c$ of $\boldsymbol\eta$ | §4 only |
| $R$ | $\min(\eta,1-\eta)$ | $1-\max_c\eta_c$ | universal; type-overloaded |
| $\varphi$ | concave score on $[0,1]$ | concave score on $\Delta^{k-1}$ | universal |
| $c_\varphi$ | upper bracket const | upper bracket const | universal; $=\tfrac12$ binary normalized, hyp-tagged multiclass |

§4 opener line: *"$\boldsymbol\eta\in\Delta^{k-1}$ denotes a simplex-valued conditional class distribution (boldface), with components $\eta_c$. The binary case $k=2$ is recovered by $\eta:=\eta_1$."*

---

## Sequence

| # | Subject | Closes | Files | State | SHA |
|---|---|---|---|---|---|
| 1 | `chore(plan): track Draft 0.2 commitology as 08` | — | `08` | — | — |
| 2 | `fix(notation): declare bold-η simplex convention in §1` | preamble for §4 | `03` | — | — |
| 3 | `feat(§4.1): import 04 setup + multiclass bracket` | M-2 | `03` | — | — |
| 4 | `feat(§4.2): import 04 rigidity theorem with hypothesis hygiene` | M-1, m-3, m-4 | `03` | — | — |
| 5 | `feat(§4.3): import 04 smoothness–slack + worked example` | m-1, m-2 | `03` | — | — |
| 6 | `feat(§4.4–5): binary consistency + refinement-monotonicity transfer` | m-6 | `03` | — | — |
| 7 | `feat(§4 narrative): consolidate "what this buys" + merge references` | m-5 (resolved by consolidation) | `03` | — | — |
| 8 | `fix(§8): collapse OP1a → §4 reference; keep OP1b–3` | — | `03` | — | — |
| 9 | `fix(abstract+§1): note multiclass reach via §4` | — | `03` | — | — |
| 10 | `docs: bump 03 draft note → 0.2; enumerate closed audit items` | — | `03` | — | — |
| 11 | `chore(repo): retire 04 to one-line redirect` | — | `04` | — | — |
| 12 | `chore(plan): finalize 08 commitology with SHAs` | — | `08` | — | — |

(SHA column backfilled by commit 12.)

---

## Dependency graph (PERT — activity-on-node, S=1 / M=3 / L=5)

```
A(1·S) ──► B(2·S) ──► C(3·M) ──► D(4·L) ──► E(5·M) ──► F(6·S) ──► G(7·M) ──┬──► H(8·S) ──┬──► J(10·S) ──► K(11·S) ──► L(12·S)
                                                                            │              │
                                                                            └──► I(9·S) ───┘
```

**Critical path.** A → B → C → D → E → F → G → (H ‖ I) → J → K → L. Weights: 1+1+3+5+3+1+3+1+1+1+1 = **21**; with H ‖ I parallelization → **20**.

**Long-pole node: D (commit 4 — §4.2 rigidity import).** Single largest commit. Folds three audit fixes (M-1, m-3, m-4) into a proof block. If D regresses, E–G inherit broken text. **Mitigation:** review D before opening the next commit.

**Risk table:**

| Risk | Node | Reason |
|---|---|---|
| High | D | Largest single edit; three audit fixes folded into a proof block |
| Medium | C, E, G | Notational, worked-example, and reference-merge edits that downstream commits read from |
| Low | A, B, F, H, I, J, K, L | Mechanical edits with localized scope |

**Slack:** zero on D (long-pole, on critical path, no parallel alternative); one unit on H or I (parallelizable pair); zero elsewhere.

**Dependency rationale:**
- `B → C`: notation declaration must precede first multiclass content
- `C → D → E → F`: each subsection builds vocabulary the next uses (bracket → rigidity → slack → consistency)
- `F → G`: narrative-and-refs commit collects citations introduced by §4.1–4.5
- `G → H` and `G → I`: cannot reference §4 from §8 or §1 until §4 exists in full
- `H ‖ I`: disjoint section edits, safe to interleave
- `J → K`: don't retire `04` until the draft note in `03` enumerates the consolidation
- `K → L`: SHA backfill must follow all preceding commits

---

## Post-mortem fields (filled after each commit)

| # | SHA | Files | Verification notes |
|---|---|---|---|
| 1 | _to be filled_ | `08` | This file under VCS; subsequent commits cite it. |
| … | | | |

---

## What this draft does *not* claim

After commit 10 closes, Draft 0.2 closes the audits of `03` (Draft 0) and `04` (Draft 0.1 of the companion). It does **not** add:

- Mechanization (deferred — see [`09-mechanization_strategy.md`](09-mechanization_strategy.md); Lean 4 + mathlib kernel scheduled after 0.2 ships).
- Open Problem 1b construction (soft-cell-assignment lifting via Markov kernels — genuinely open).
- Open Problem 2 closure (quantitative over-smoothing rate, $\delta^{(L)} \le C\lambda_2^L$).
- Open Problem 3 closure (gap amplification / hardness of approximation).
- Empirical companion paper (Cor 4 ladder, over-smoothing onset curves, local test).
- Closed-form $\ell_\varphi$ for entropy and Gini (minor open thread noted in §4.1).

These remain marked in `03` §8 after consolidation.

---

*Plan owner: PI. Execution: agent, atomically. Any deviation must be justified inline in the corresponding commit body.*
