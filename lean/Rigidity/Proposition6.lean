/-!
# Proposition 6 — two-query identity + variance bracket

For a uniform draw `X` of a node and `X'` a uniform draw from the same cell
`Π(X)`, the cross-cell disagreement probability satisfies

  `p_dis := P[f(X) ≠ f(X')] = 2 · E[Var(f | Π)]`,

and the bracket of the normalized variance `φ_var(η) = 4η(1-η)` reads in this
one observable:

  `(1 - √(1 - 2 p_dis)) / 2 ≤ ε*(Π) ≤ p_dis`.

## Provenance

* Manuscript: §7 Proposition 6.
* Defining commit: `15729f6` (normalized-variance convention throughout the proof,
  m-3 of audit 05).
* Brick: `P6`. Mandatory kernel target.

Phase A scaffold: statement present; proof `sorry`. Phase C2 will land:
* Conditioned on cell i, two independent draws disagree with prob `2 ηᵢ(1-ηᵢ)`.
* Average over cells: `p_dis = Σ pᵢ · 2 ηᵢ (1 - ηᵢ) = 2 E[Var(f | Π)]`.
* With `φ_var(η) = 4η(1-η)` from §2: `bar φ_var = 2 p_dis`, so the universal
  `c_φ = 1/2` bracket (Theorem T-bracket) reads
  `φ_var⁻¹(2 p_dis) ≤ ε* ≤ p_dis`; solving `4η(1-η) = 2 p_dis` on [0, 1/2]
  gives the lower endpoint.
-/

import Mathlib
import Rigidity.Bracket

namespace Rigidity

open MeasureTheory Real

variable {α : Type*} [MeasurableSpace α] (μ : Measure α)

/-- Probability that two independent draws from the same cell disagree on `f`.
    -/
noncomputable def pDisagree (f : α → Bool) (Π : FinitePartition α) : ℝ :=
  ∑ c ∈ Π.cells,
    (cellMass μ Π c).toReal *
      (2 * cellRate μ f Π c * (1 - cellRate μ f Π c))

/-- **Proposition 6** (two-query identity). -/
theorem two_query_identity (f : α → Bool) (Π : FinitePartition α) :
    pDisagree μ f Π =
      2 * ∑ c ∈ Π.cells,
        (cellMass μ Π c).toReal *
          (cellRate μ f Π c * (1 - cellRate μ f Π c)) := by
  sorry

/-- **Variance bracket** (Proposition 6 corollary): the achievable floor is
    bracketed by a closed-form function of the single observable `p_dis`. -/
theorem variance_bracket (f : α → Bool) (Π : FinitePartition α) :
    (1 - Real.sqrt (1 - 2 * pDisagree μ f Π)) / 2 ≤ epsilonStar μ f Π ∧
    epsilonStar μ f Π ≤ pDisagree μ f Π := by
  sorry

end Rigidity
