# Phase B4 — Proposition 6 (`two_query_identity` + `variance_bracket`)

**Phase**: B4
**Status**: **closed** — both proved 2026-06-05
**First raised**: 2026-06-05
**Last updated**: 2026-06-05

## The question

`Proposition6.lean` had two scaffolded targets:
- `two_query_identity` — `p_dis = 2 · Σ pᵢ · ηᵢ·(1-ηᵢ)` (just the per-cell `2` factored out).
- `variance_bracket` — the closed-form variance-style bracket `(1 - √(1 - 2·p_dis))/2 ≤ ε* ≤ p_dis`.

## Sources consulted

- `Bracket.lean` — `bracket_lower`, `bracket_upper`, `cPhi_eq_half_of_normalized`,
  `epsilonStar_le_half`, `epsilonStar_nonneg` (all proved in Phase B1–B3a).
- Mathlib `Real.le_sqrt_of_sq_le : x^2 ≤ y → x ≤ √y` (via `lean_leansearch`).
  This is the textbook IVT-style inversion lemma.

## Findings

`variance_bracket` is straightforward to assemble once you realize:
1. `phiVar η = 4η(1-η)` is the right "variance score"; it's a normalized score
   (proved as `phiVar_normalized`).
2. `barPhi μ phiVar = 2 · pDisagree` (proved as `barPhi_phiVar_eq_two_pDisagree`).
3. Then `bracket_lower` at `phiVar` ⟹ `2·p_dis ≤ phiVar(ε*) = 4ε*(1-ε*)`,
   and `bracket_upper` at `phiVar` ⟹ `ε* ≤ cPhi phiVar · barPhi = (1/2)·2·p_dis = p_dis`.
4. The lower endpoint inverts the quadratic: `4ε² - 4ε + 2d ≤ 0` ⟹
   `(1 - 2ε)² ≤ 1 - 2d`. Since `ε ≤ 1/2`, `1 - 2ε ≥ 0`, so
   `Real.le_sqrt_of_sq_le` gives `1 - 2ε ≤ √(1 - 2d)`, hence
   `ε ≥ (1 - √(1 - 2d))/2`.

## Strategic decision

Five new proved theorems landed:
- `two_query_identity` — `unfold pDisagree + Finset.mul_sum + ring`.
- `phiVar` — definition.
- `phiVar_normalized` — 7 fields. Concavity needed `nlinarith` with `(x - y)²` hint after eliminating `b = 1 - a`.
- `barPhi_phiVar_eq_two_pDisagree` — `unfold + Finset.mul_sum + ring`.
- `variance_bracket` — `[IsProbabilityMeasure μ]` added to signature (the bracket lemmas require it; no downstream callers yet so non-breaking).

## Open follow-ups

- `[opportunity]` Most other normalized-score proofs (`tent_normalized`, `phiVar_normalized`, future `phiEnt_normalized` for entropy) repeat the same 7-field structure with different per-cell tactics. Could factor out a `NormalizedScore.mk_polynomial` constructor that takes the polynomial form and discharges concavity / continuity / boundary checks via `nlinarith` + `norm_num`. Estimated savings: ~25 LoC per future score, ~5 minutes per proof.

## Lessons

- **`nlinarith` concavity proofs benefit from variable elimination**. The polynomial-concavity goal `4(ax+by)(1-(ax+by)) - [a·4x(1-x) + b·4y(1-y)] ≥ 0` was opaque to `nlinarith` with the symmetric `(x-y)² + (a-b)²` hint set. Eliminating `b = 1 - a` first via `subst` made the goal a polynomial in `a, x, y` only, and `nlinarith [sq_nonneg (x - y), ha, hb, mul_nonneg ha hb]` closed it.
- **`Real.le_sqrt_of_sq_le` is the right square-root inversion lemma**. Found via `lean_leansearch "a squared le b implies a le sqrt b for nonneg"` — natural-language search beats type-pattern search for inversion lemmas.
- **Tag discipline pays off again**. The variance_bracket draft was first written with `@[rigidity_proved]` but a `sorry` in the lower endpoint. Demoted to `@[rigidity_scaffold]` immediately, then re-promoted only after the lower endpoint was filled. The audit harness would catch transitively-`sorryAx` proofs, but the demote-first discipline catches it before the audit runs.
