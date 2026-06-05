import Mathlib.MeasureTheory.Measure.Typeclasses.NoAtoms
import Rigidity.Bracket

/-!
# Theorem 2 — binary rigidity (T is the unique exact score)

A normalized score `φ` has an exact bracket
(`bar φ(Π) = φ(ε*(Π))` and `ε*(Π) = c_φ · bar φ(Π)` simultaneously, for every
partition) if and only if `φ = T`. On atomless spaces with realizability of
single-cell rates, the proof collapses to the single-cell argument; on
general spaces density + continuity extend the conclusion.

## Provenance

* Manuscript: §3.2 Theorem 2.
* Defining commits:
  - `(base)`   initial statement
  - `f556246`  proof tightening via the single-cell argument (M-4 of audit 05)
  - `07ddde8`  atomless realizability hypothesis lifted into the statement
              (M-2 of audit 12)
* Brick: `T2`. Mandatory kernel target.

Phase A scaffold: statement present; proof `sorry`. Phase C1 (long-pole)
will fill in: single-cell argument pins `η = c_φ · φ(η)` on [0, 1/2];
normalization gives `c_φ = 1/2`, hence `φ = 2η` on [0, 1/2]; symmetry of
`NormalizedScore` extends to [0, 1].
-/

namespace Rigidity

open MeasureTheory Set

/-- **Theorem 2** (binary rigidity).
    On an atomless probability space, a normalized score `φ` has an exact
    bracket iff `φ = T` (the normalized 0-1 Bayes risk). -/
theorem theorem2 {α : Type*} [MeasurableSpace α] {μ : Measure α} [NoAtoms μ]
    (φ : ℝ → ℝ) (_h : NormalizedScore φ) :
    (∀ (f : α → Bool) (P : FinitePartition α),
        barPhi μ φ f P = φ (epsilonStar μ f P) ∧
        epsilonStar μ f P = cPhi φ * barPhi μ φ f P) ↔
    φ = tent := by
  sorry

end Rigidity
