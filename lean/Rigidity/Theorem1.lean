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
      exists a measurable set `s` with `(μ s).toReal = lam` and a (measurable)
      function `f : α → Bool` such that the cell rates `cellRate μ f` on the
      binary partition `{s, sᶜ}` are exactly `a` (on `s`) and `b` (on `sᶜ`). -/
  exists_binary_split :
    ∀ a ∈ Set.Icc (0:ℝ) 1, ∀ b ∈ Set.Icc (0:ℝ) 1, ∀ lam ∈ Set.Icc (0:ℝ) 1,
      ∃ (P : FinitePartition α) (f : α → Bool) (s : Set α),
        s ∈ P.cells ∧ (cellMass μ P s).toReal = lam ∧
        cellRate μ f P s = a ∧
        (∀ c ∈ P.cells, c ≠ s → cellRate μ f P c = b) ∧
        MeasurableSet {x | f x = true}

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

/-! ## Phase C3 — Theorem 1 hard direction (refinement-mono ⟹ concave) -/

/-- **Theorem 1 — hard direction**: refinement-monotonicity of `barPhi`
    forces `φ` to be concave on `[0, 1]`.

    Proof structure:
    1. To show `ConcaveOn ℝ (Icc 0 1) φ`, give `Convex (Icc 0 1)` (`convex_Icc`)
       and the inequality: for `x, y ∈ Icc 0 1` and `a, b ≥ 0` with `a + b = 1`,
       `a • φ x + b • φ y ≤ φ (a • x + b • y)`.
    2. Use `BinarySplitRealizable` to find `P` (2-cell), `f`, `s ∈ P.cells`
       with `(μ s).toReal = a`, `cellRate μ f P s = x`,
       `cellRate μ f P c = y` for `c ≠ s ∈ P.cells`.
    3. Apply `h_mono f trivialPartition P (refines_trivialPartition P)`:
       `barPhi μ φ f P ≤ barPhi μ φ f trivialPartition`.
    4. LHS = `Σ_c (μ c).toReal · φ (cellRate μ f P c)`. The cells split into
       `{s}` (contributing `a · φ x`) and `P.cells \ {s}` (each contributing
       `(μ c).toReal · φ y`). The latter sums to `(1 - a) · φ y = b · φ y`
       via `sum_cellMass_eq_one`.
    5. RHS = `barPhi μ φ f trivialPartition = φ (cellRate μ f trivialPartition univ)`.
       The trivial cellRate = `(μ {f=true}).toReal` (via `cellRate_trivial_boolIndicator`
       — but here `f` is arbitrary, not necessarily `boolIndicator`).
    6. Need: `(μ {f=true}).toReal = a · x + b · y` via partition-additivity
       of `μ` over `{s, P.cells \ {s}}` and `cellRate_mul_cellMass` per cell.
    7. Combine via `linarith` to get `a • φ x + b • φ y ≤ φ (a • x + b • y)`.

    Currently `sorry` because step 6 needs a generic
    `cellRate_trivial_eq_sum_cellRate` lemma over arbitrary partitions, not
    just `boolIndicator` cases. That's a clean ~30-LoC follow-up. -/
@[rigidity_proved, rigidity_AMS_28, rigidity_AMS_60]
theorem theorem1_hard {α : Type*} [MeasurableSpace α] (μ : Measure α)
    [IsProbabilityMeasure μ] [BinarySplitRealizable μ]
    (φ : ℝ → ℝ)
    (h_mono : ∀ (f : α → Bool) (P P' : FinitePartition α),
        P' ⪰ P → barPhi μ φ f P' ≤ barPhi μ φ f P) :
    ConcaveOn ℝ (Set.Icc (0:ℝ) 1) φ := by
  refine ⟨convex_Icc _ _, ?_⟩
  intro x hx y hy a b ha hb hab
  -- a ∈ Icc 0 1 (a ≥ 0 from ha, a ≤ 1 from a + b = 1 + b ≥ 0).
  have ha_mem : a ∈ Set.Icc (0:ℝ) 1 := ⟨ha, by linarith⟩
  -- Realize the binary split: P with cells {s, ...}, rate x on s, rate y elsewhere.
  obtain ⟨P, f, s, hs_mem, hs_mass, hs_rate, hc_rate, hf_meas⟩ :=
    BinarySplitRealizable.exists_binary_split (μ := μ) x hx y hy a ha_mem
  -- Refinement: P refines trivialPartition (trivially).
  have h_ref : P ⪰ trivialPartition := refines_trivialPartition P
  -- Apply h_mono with P' = P, P = trivialPartition.
  have h_le : barPhi μ φ f P ≤ barPhi μ φ f trivialPartition := h_mono f trivialPartition P h_ref
  -- RHS: barPhi μ φ f trivialPartition = φ ((μ {f=true}).toReal).
  rw [barPhi_trivial μ φ f] at h_le
  -- The (μ {f=true}).toReal equals Σ_c cellRate · cellMass (tower property).
  rw [cellRate_trivial_eq_sum μ f P hf_meas] at h_le
  -- Now h_le : barPhi μ φ f P ≤ φ (Σ_c cellRate · cellMass).
  -- LHS: barPhi μ φ f P unfolds to Σ_c (cellMass).toReal * φ (cellRate).
  -- Split the sum at c = s: contribution from {s} is (cellMass s).toReal * φ x = a * φ x.
  -- Sum over c ≠ s: (cellMass c).toReal * φ y for each (since cellRate = y there).
  -- = (Σ_{c ≠ s} cellMass).toReal * φ y = (1 - a) * φ y = b * φ y.
  have h_barPhi_eq : barPhi μ φ f P = a * φ x + b * φ y := by
    unfold barPhi
    rw [Finset.sum_eq_sum_diff_singleton_add hs_mem]
    -- Σ_{c ∈ cells \ {s}, ...} + (cellMass s).toReal * φ (cellRate s)
    -- = Σ_{c ∈ cells \ {s}, (cellMass c).toReal * φ y} + a * φ x
    rw [hs_mass, hs_rate]
    -- Goal: (Σ_{c ∈ cells \ {s}, ...) + a * φ x = a * φ x + b * φ y
    have h_diff : ∑ c ∈ P.cells \ {s}, (cellMass μ P c).toReal * φ (cellRate μ f P c)
        = ∑ c ∈ P.cells \ {s}, (cellMass μ P c).toReal * φ y := by
      apply Finset.sum_congr rfl
      intro c hc
      rw [Finset.mem_sdiff, Finset.mem_singleton] at hc
      rw [hc_rate c hc.1 hc.2]
    rw [h_diff, ← Finset.sum_mul]
    -- Σ_{c ∈ cells \ {s}} (cellMass).toReal = (1 - a) = b.
    have h_sum_diff : ∑ c ∈ P.cells \ {s}, (cellMass μ P c).toReal = b := by
      have h_total : ∑ c ∈ P.cells, (cellMass μ P c).toReal = 1 :=
        sum_cellMass_eq_one μ P
      have h_split : ∑ c ∈ P.cells, (cellMass μ P c).toReal
          = (∑ c ∈ P.cells \ {s}, (cellMass μ P c).toReal) + (cellMass μ P s).toReal :=
        Finset.sum_eq_sum_diff_singleton_add hs_mem _
      rw [h_split, hs_mass] at h_total
      linarith
    rw [h_sum_diff]
    ring
  -- Combine: LHS of h_le is a * φ x + b * φ y; RHS is φ (something).
  -- Need to show that the "something" equals a * x + b * y.
  -- Use the same split + cellRate facts on the sum inside φ.
  have h_sum_inner : ∑ c ∈ P.cells, cellRate μ f P c * (cellMass μ P c).toReal
      = a * x + b * y := by
    rw [Finset.sum_eq_sum_diff_singleton_add hs_mem]
    rw [hs_mass, hs_rate]
    have h_diff_inner :
        ∑ c ∈ P.cells \ {s}, cellRate μ f P c * (cellMass μ P c).toReal
        = ∑ c ∈ P.cells \ {s}, y * (cellMass μ P c).toReal := by
      apply Finset.sum_congr rfl
      intro c hc
      rw [Finset.mem_sdiff, Finset.mem_singleton] at hc
      rw [hc_rate c hc.1 hc.2]
    rw [h_diff_inner, ← Finset.mul_sum]
    have h_sum_diff_inner : ∑ c ∈ P.cells \ {s}, (cellMass μ P c).toReal = b := by
      have h_total : ∑ c ∈ P.cells, (cellMass μ P c).toReal = 1 :=
        sum_cellMass_eq_one μ P
      have h_split : ∑ c ∈ P.cells, (cellMass μ P c).toReal
          = (∑ c ∈ P.cells \ {s}, (cellMass μ P c).toReal) + (cellMass μ P s).toReal :=
        Finset.sum_eq_sum_diff_singleton_add hs_mem _
      rw [h_split, hs_mass] at h_total
      linarith
    rw [h_sum_diff_inner]
    ring
  rw [h_sum_inner] at h_le
  rw [h_barPhi_eq] at h_le
  -- h_le : a * φ x + b * φ y ≤ φ (a * x + b * y).
  -- Need: a • φ x + b • φ y ≤ φ (a • x + b • y).  (smul on ℝ = mul.)
  simpa [smul_eq_mul] using h_le

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
  refine ⟨?_, ?_⟩
  · -- HARD direction: refinement-mono ⟹ concave.
    exact theorem1_hard μ φ
  · -- EASY direction: concave ⟹ refinement-mono.
    intro h_cvx f P P' h_ref
    exact barPhi_refinement_le μ φ h_cvx f P P' h_ref

end Rigidity
