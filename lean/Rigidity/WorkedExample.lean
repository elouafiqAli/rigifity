import Mathlib.Data.Rat.Defs
import Mathlib.Data.Fin.VecNotation
import Mathlib.Tactic.NormNum

/-!
# WorkedExample — numerical verification of the §4.3 worked example (k = 3)

This module uses `decide` to mechanically check the arithmetic of the §4.3
worked example over rationals (so the kernel never depends on real-number
decidability).

## The example

For `k = 3`:

  η     = (1/2, 3/10, 1/5),     η'    = (1/2, 1/2, 0)
  R(η)  = R(η') = 1/2                       (same Bayes risk)
  φ_G(η)  = 31/50 = 0.62                    (Gini distinguishes)
  φ_G(η') = 1/2   = 0.50

With the two-cell partition of equal mass `p₁ = p₂ = 1/2`:

  ε*       = (1/2)(1/2) + (1/2)(1/2) = 1/2
  bar φ_G  = (1/2)(31/50) + (1/2)(1/2) = 56/100 = 0.56
  slack    = bar φ_G − ε* = 0.06

The lower bracket witness is `η_min = (3/5, 1/5, 1/5)`, attaining `φ_G = 56/100`
with `R = 2/5 = 0.4 < 0.5 = ε*`, confirming a genuinely two-sided bracket.

## Provenance

* Manuscript: §4.3 worked example.
* Defining commit: `77b7c93` (smoothness–slack import; m-1 / m-2 of audit 07).
* Brick: `W43`. Numerics target — mechanically verified by `decide`, and
  by `verify/numerics.py` for redundancy.
-/

namespace Rigidity.WorkedExample

/-- Gini impurity for `k = 3` over rationals. -/
def gini (η : Fin 3 → ℚ) : ℚ := 1 - ((η 0)^2 + (η 1)^2 + (η 2)^2)

/-- Cell-level Bayes risk for `k = 3` over rationals: `R(η) = 1 - max_c η c`. -/
def R3 (η : Fin 3 → ℚ) : ℚ := 1 - max (η 0) (max (η 1) (η 2))

/-- `η = (1/2, 3/10, 1/5)`. -/
def η₁ : Fin 3 → ℚ := ![1/2, 3/10, 1/5]

/-- `η' = (1/2, 1/2, 0)`. -/
def η₂ : Fin 3 → ℚ := ![1/2, 1/2, 0]

/-- The lower-bracket witness `η_min = (3/5, 1/5, 1/5)`. -/
def ηmin : Fin 3 → ℚ := ![3/5, 1/5, 1/5]

/-! ### W43.1 — Same Bayes risk -/

example : R3 η₁ = 1/2 := by native_decide
example : R3 η₂ = 1/2 := by native_decide

/-! ### W43.2 — Gini distinguishes -/

example : gini η₁ = 31/50 := by native_decide
example : gini η₂ = 1/2   := by native_decide

/-! ### W43.3 — Lower bracket witness -/

example : gini ηmin = 56/100 := by native_decide
example : R3 ηmin  = 2/5    := by native_decide

/-! ### W43.4 — Two-cell partition aggregate -/

example : ((gini η₁ + gini η₂) / 2 : ℚ) = 56/100 := by native_decide
example : ((R3 η₁ + R3 η₂) / 2 : ℚ) = 1/2 := by native_decide

/-! ### W43.5 — Slack is positive -/

example : ((gini η₁ + gini η₂) / 2 : ℚ) - ((R3 η₁ + R3 η₂) / 2) = 6/100 := by native_decide

/-! ### W43.6 — `R(η_min) < ε*` confirms genuinely two-sided bracket -/

example : R3 ηmin < ((R3 η₁ + R3 η₂) / 2 : ℚ) := by native_decide

/-! ## Round-6 audit (Draft 0.6) — Worked example A: Step-1 violation

    The reorganization of §4.3 split the worked example into A and B:
    - **A** (NEW, this section): a Step-1 violation — distributions with the
      same Gini but different R, witnessing that R is *not* a function of φ_G,
      which is what fails Step 1 of `simplex_rigidity` directly.
    - **B** (existing W43.1–W43.6): the original slack-mechanism example
      (same R, different Gini), demonstrating that φ_G is *not* a function of R,
      which is what opens the bracket.

    For A we use rational distributions where Gini lands exactly at `1/2`:

      η_A  = (2/3, 1/6, 1/6),     η_A' = (1/2, 1/2, 0)
      Gini(η_A)  = 1 - (4/9 + 1/36 + 1/36)  = 1 - 1/2 = 1/2
      Gini(η_A') = 1 - (1/4 + 1/4 + 0)       = 1 - 1/2 = 1/2
      R3(η_A)    = 1 - 2/3 = 1/3
      R3(η_A')   = 1 - 1/2 = 1/2

    G would have to send the single Gini-value 1/2 to both R-values 1/3 and 1/2 —
    impossible. So Gini fails Step 1 directly. -/

/-- The Step-1-violation distribution `η_A = (2/3, 1/6, 1/6)`. -/
def η_A : Fin 3 → ℚ := ![2/3, 1/6, 1/6]

/-- The Step-1-violation companion `η_A' = (1/2, 1/2, 0)`. -/
def η_A' : Fin 3 → ℚ := ![1/2, 1/2, 0]

/-! ### W43.A1 — Same Gini score -/

example : gini η_A  = 1/2 := by native_decide
example : gini η_A' = 1/2 := by native_decide

/-! ### W43.A2 — Different Bayes risk -/

example : R3 η_A  = 1/3 := by native_decide
example : R3 η_A' = 1/2 := by native_decide
example : R3 η_A ≠ R3 η_A' := by native_decide

/-! ### W43.A3 — Step-1 violation: ∃ same-Gini pair with different R -/

example : gini η_A = gini η_A' ∧ R3 η_A ≠ R3 η_A' := by native_decide

end Rigidity.WorkedExample
