import Mathlib.MeasureTheory.Measure.Typeclasses.NoAtoms
import Mathlib.MeasureTheory.Measure.Typeclasses.Probability
import Rigidity.Bracket
import Rigidity.Util.Attributes

/-!
# Theorem 1 — refinement-monotonicity ⟺ concavity

For an atomless probability space, a continuous score `φ : [0, 1] → ℝ`
satisfies `Π' ⪰ Π ⟹ bar φ(Π') ≤ bar φ(Π)` over all finite measurable
partitions and labels iff `φ` is concave on [0, 1].

## Provenance

* Manuscript: §3.1 Theorem 1.
* Defining commits:
  - `(base)`   initial three-equivalence statement + proof
  - `23814f7`  atomless realizability hypothesis lifted into the statement
* Brick: `T1`. Mandatory kernel target per `09-mechanization_strategy.md`.

Phase C1 status: structural skeleton + typeclass infrastructure landed.
Phase C2 fills the tower-property workhorse (`barPhi_refinement_le`) and
the easy direction. Phase C3 fills the hard direction via
`BinarySplitRealizable`.

See `.research/2026-06-05-phase-c-theorem1-strategy.md`.
-/

namespace Rigidity

open MeasureTheory Set

/-! ## Phase C1 typeclass: binary-split realizability -/

/-- Existence-of-binary-split hypothesis for the hard direction of `theorem1`.

    For `[NoAtoms μ] [IsProbabilityMeasure μ]` this is provable via two
    applications of Sierpiński's theorem (realize `lam`, then `a · lam`
    inside, then `b · (1 - lam)` outside). Mathlib4 lacks Sierpiński so we
    use the same typeclass-as-hypothesis pattern as `SingleCellRealizable`
    (cf. `.research/2026-06-05-sierpinski-atomless-realizability.md`).

    No instance is provided here — see opportunity #1. -/
class BinarySplitRealizable {α : Type*} [MeasurableSpace α] (μ : Measure α) : Prop where
  /-- For every `(a, b, lam)` with `a, b ∈ [0, 1]` and `lam ∈ [0, 1]`, there
      exists a measurable set `s` with `(μ s).toReal = lam` and a function
      `f : α → Bool` such that the cell rates `cellRate μ f` on the binary
      partition `{s, sᶜ}` are exactly `a` (on `s`) and `b` (on `sᶜ`). -/
  exists_binary_split :
    ∀ a ∈ Set.Icc (0:ℝ) 1, ∀ b ∈ Set.Icc (0:ℝ) 1, ∀ lam ∈ Set.Icc (0:ℝ) 1,
      ∃ (P : FinitePartition α) (f : α → Bool) (s : Set α),
        s ∈ P.cells ∧ (cellMass μ P s).toReal = lam ∧
        cellRate μ f P s = a ∧
        (∀ c ∈ P.cells, c ≠ s → cellRate μ f P c = b)

/-! ## Phase C1 helper skeleton: refinement-monotonicity of barPhi -/

/-- **Workhorse** (Phase C2): for concave `φ` on `[0, 1]`, `barPhi` is
    monotone under refinement. The proof uses the per-cell tower property
    (`cellRate μ f P c` is a weighted average of the `cellRate` on the
    refining sub-cells) plus `ConcaveOn.le_map_sum` (the abstract Jensen).

    Phase C2 will fill this; meanwhile a `sorry` skeleton with
    `@[rigidity_scaffold]` so the audit harness flags it correctly. -/
@[rigidity_scaffold, rigidity_AMS_28, rigidity_AMS_60]
theorem barPhi_refinement_le {α : Type*} [MeasurableSpace α]
    (μ : Measure α) [IsProbabilityMeasure μ]
    (φ : ℝ → ℝ) (_h_cvx : ConcaveOn ℝ (Set.Icc (0:ℝ) 1) φ)
    (f : α → Bool) (P P' : FinitePartition α) (_h_ref : P' ⪰ P) :
    barPhi μ φ f P' ≤ barPhi μ φ f P := by
  sorry

/-! ## Phase C1 skeleton: theorem1 -/

/-- **Theorem 1** (refinement-monotone ⟺ concave).
    On a probability space with `BinarySplitRealizable μ`, the partition
    functional `bar φ` is monotone under refinement iff `φ` is concave on
    `[0, 1]`.

    Easy direction (←): apply `barPhi_refinement_le` (Phase C2 target).
    Hard direction (→): use `BinarySplitRealizable` to realize the convex
    combination `a · lam + b · (1 - lam)` as a 2-cell refinement, where
    refinement monotonicity collapses to the concavity inequality. -/
@[rigidity_scaffold, rigidity_AMS_28, rigidity_AMS_60]
theorem theorem1 {α : Type*} [MeasurableSpace α] (μ : Measure α)
    [IsProbabilityMeasure μ] [BinarySplitRealizable μ]
    (φ : ℝ → ℝ) (_hc : ContinuousOn φ (Set.Icc (0:ℝ) 1)) :
    (∀ (f : α → Bool) (P P' : FinitePartition α),
        P' ⪰ P → barPhi μ φ f P' ≤ barPhi μ φ f P) ↔
    ConcaveOn ℝ (Set.Icc (0:ℝ) 1) φ := by
  sorry

end Rigidity
