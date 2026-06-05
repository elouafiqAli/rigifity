/-!
# Theorem 1 — refinement-monotonicity ⟺ concavity

For an atomless probability space, a continuous score `φ : [0, 1] → ℝ`
satisfies `Π' ⪰ Π ⟹ bar φ(Π') ≤ bar φ(Π)` over all finite measurable
partitions and labels iff `φ` is concave on [0, 1]. On general (possibly
atomic) spaces the equivalence continues to hold by density of realizable
splits and continuity of `φ`.

## Provenance

* Manuscript: §3.1 Theorem 1.
* Defining commits:
  - `(base)`   initial three-equivalence statement + proof
  - `23814f7`  atomless realizability hypothesis lifted into the statement
              (M-1 of audit 12, parallel to commit `c8ef3e6` on Theorem 2′)
* Brick: `T1`. Mandatory kernel target per `09-mechanization_strategy.md`.

Phase A scaffold: statement is present with type-checked hypotheses; proof
is `sorry`. Phase B2 will fill in via the tower-property + Jensen argument
(direction (iii)⇒(i)) and the binary-split realization argument
(direction (ii)⇒(iii)).
-/

import Mathlib
import Rigidity.Bracket

namespace Rigidity

open MeasureTheory Set

/-- **Theorem 1** (refinement-monotone ⟺ concave).
    On an atomless probability space, the partition functional `bar φ` is
    monotone under refinement iff `φ` is concave on [0, 1]. The intermediate
    condition (binary-split monotonicity) is equivalent to both.

    On a general (possibly atomic) space the equivalence holds by density
    of realizable splits and continuity of `φ`. -/
theorem theorem1 {α : Type*} [MeasurableSpace α] {μ : Measure α} [NoAtoms μ]
    (φ : ℝ → ℝ) (_hc : ContinuousOn φ (Set.Icc (0:ℝ) 1)) :
    (∀ (f : α → Bool) (Π Π' : FinitePartition α),
        Π' ⪰ Π → barPhi μ φ f Π' ≤ barPhi μ φ f Π) ↔
    ConcaveOn ℝ (Set.Icc (0:ℝ) 1) φ := by
  sorry

end Rigidity
