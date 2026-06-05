import Mathlib.MeasureTheory.Measure.MeasureSpace
import Mathlib.Analysis.Convex.Basic
import Mathlib.Analysis.Convex.Function
import Mathlib.Analysis.Convex.Jensen
import Mathlib.Topology.Order.Lattice
import Mathlib.Order.ConditionallyCompleteLattice.Basic
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Ring
import Rigidity.Util.Attributes

/-!
# Bracket — definitions and the binary bracket

Definitions: probability space, finite partition, partition-restricted Bayes
risk, partition functional, normalized score, tent, c_phi.

Theorems: universal `c_phi = 1/2` for normalized scores; the binary bracket
`bar phi(P) ≤ phi(eps*(P))` (lower endpoint) and `eps*(P) ≤ c_phi · bar phi(P)`
(upper endpoint), stated in inverse-free form to avoid committing to a
specific definition of `phi^{-1}` in the scaffold.

## Naming convention

In the manuscript these objects use `Π` for partitions; in Lean we use `P`
because `Π` is a reserved token in the dependent-product syntax `Π (x : α), β`.
The manuscript's `Π` and the Lean `P` denote the same `FinitePartition`.

## Provenance

* Manuscript: §1 (bracket display), §2 (preliminaries).
* Defining commits:
  - `(base)`   initial definitions of partition, Bayes risk, normalized score
  - `f556246`  Theorem 2 proof tightening (single-cell argument)
  - `779d533`  `c_phi = 1/2` universal for normalized scores
  - `6a86ffd`  grid-invariant ε-net partition + WL-faithful limit
  - `0a3e62c`  normalized-score hypothesis on bracket display (m-2 of audit 12)
  - `8850ddf`  cell-level vs partition-level Bayes risk in §1 notation (f-1)
* Bricks: `D-prob`, `D-part`, `D-eps*`, `D-bphi`, `D-norm`, `D-tent`, `D-cphi`,
  `T-bracket`.

Phase A scaffold: type signatures are present; all proofs are `sorry`.
Phase B will fill in `cPhi_eq_half_of_normalized`, `bracket_lower`,
`bracket_upper`.
-/

namespace Rigidity

open MeasureTheory Set

/-! ## D-part: partitions -/

/-- A finite measurable partition of `α`. Brick: `D-part`.
    Lean note: the manuscript uses `Π` for partitions; we use `P` here because
    `Π` is reserved for the dependent-product syntax in Lean. -/
structure FinitePartition (α : Type*) [MeasurableSpace α] where
  cells : Finset (Set α)
  measurable : ∀ c ∈ cells, MeasurableSet c
  disjoint : (cells : Set (Set α)).PairwiseDisjoint id
  covers : ⋃₀ (cells : Set (Set α)) = univ

/-- Refinement order on partitions: `P'` refines `P` iff every cell of `P'`
    lies inside a cell of `P`. (Manuscript: `Π' ⪰ Π`.) -/
def Refines {α : Type*} [MeasurableSpace α] (P' P : FinitePartition α) : Prop :=
  ∀ c' ∈ P'.cells, ∃ c ∈ P.cells, c' ⊆ c

@[inherit_doc] infix:50 " ⪰ " => Refines

/-- Mass of a cell under measure `μ`. (`P` is taken explicit even though only
    `μ c` is used, since cellMass is the partition-side projection conceptually.) -/
noncomputable def cellMass {α : Type*} [MeasurableSpace α] (μ : Measure α)
    (_P : FinitePartition α) (c : Set α) : ENNReal :=
  μ c

/-- Conditional rate of `f = true` given cell `c`, with the convention `0` when
    the cell has measure zero. Brick: cellRate (used by `D-eps*`, `D-bphi`).
    Phase B target: `(μ ({x | f x = true} ∩ c)).toReal / (μ c).toReal`. -/
noncomputable def cellRate {α : Type*} [MeasurableSpace α] (_μ : Measure α)
    (_f : α → Bool) (_P : FinitePartition α) (_c : Set α) : ℝ := by
  exact sorry

/-- Partition-restricted Bayes risk: `ε*(P) = Σᵢ pᵢ · min(ηᵢ, 1 - ηᵢ)`.
    Brick: `D-eps*`. Manuscript: §2 ¶1. -/
noncomputable def epsilonStar {α : Type*} [MeasurableSpace α] (μ : Measure α)
    (f : α → Bool) (P : FinitePartition α) : ℝ :=
  ∑ c ∈ P.cells, (cellMass μ P c).toReal *
    min (cellRate μ f P c) (1 - cellRate μ f P c)

/-- Partition functional `bar φ(P) = Σᵢ pᵢ · φ(ηᵢ)`.
    Brick: `D-bphi`. Manuscript: §2 ¶1. -/
noncomputable def barPhi {α : Type*} [MeasurableSpace α] (μ : Measure α)
    (φ : ℝ → ℝ) (f : α → Bool) (P : FinitePartition α) : ℝ :=
  ∑ c ∈ P.cells, (cellMass μ P c).toReal * φ (cellRate μ f P c)

/-! ## D-norm and D-tent: normalized scores -/

/-- A normalized score on [0, 1]: concave, continuous, symmetric (`φ η = φ (1-η)`),
    vanishing at the endpoints, `φ(1/2) = 1`, strictly increasing on [0, 1/2].
    Brick: `D-norm`. Manuscript: §2 ¶2. Refined by `0a3e62c` (m-2) and `8850ddf` (f-1)
    for the inline §1 hypothesis list. -/
structure NormalizedScore (φ : ℝ → ℝ) : Prop where
  concave_on : ConcaveOn ℝ (Set.Icc (0:ℝ) 1) φ
  continuous : ContinuousOn φ (Set.Icc (0:ℝ) 1)
  symmetric : ∀ η ∈ Set.Icc (0:ℝ) 1, φ η = φ (1 - η)
  vanishes_at_zero : φ 0 = 0
  vanishes_at_one : φ 1 = 0
  unit_at_half : φ (1/2) = 1
  strict_mono : StrictMonoOn φ (Set.Icc (0:ℝ) (1/2))

/-- The normalized 0-1 Bayes risk: `T(η) = 2 · min(η, 1 - η)`. Brick: `D-tent`. -/
def tent : ℝ → ℝ := fun η => 2 * min η (1 - η)

/-- The tent satisfies the normalized-score conditions. -/
@[rigidity_proved, rigidity_AMS_60]
theorem tent_normalized : NormalizedScore tent := by
  refine ⟨?_, ?_, ?_, ?_, ?_, ?_, ?_⟩
  · -- concave_on: 2 * min η (1-η) is concave (inf of two affine, scaled by 2 > 0)
    have h_cvx : Convex ℝ (Set.Icc (0:ℝ) 1) := convex_Icc 0 1
    -- f(η) = η is concave (linear)
    have h_id : ConcaveOn ℝ (Set.Icc (0:ℝ) 1) (fun η : ℝ => η) :=
      (LinearMap.id (R := ℝ) (M := ℝ)).concaveOn h_cvx
    -- g(η) = 1 - η is concave (affine: -id + constant)
    have h_neg_id : ConcaveOn ℝ (Set.Icc (0:ℝ) 1) (fun η : ℝ => -η) :=
      ((-LinearMap.id (R := ℝ) (M := ℝ))).concaveOn h_cvx
    have h_one_sub : ConcaveOn ℝ (Set.Icc (0:ℝ) 1) (fun η : ℝ => 1 - η) := by
      have h := h_neg_id.add_const 1
      -- h : ConcaveOn _ _ ((fun η => -η) + fun _ => 1)
      convert h using 1
      ext η
      simp [Pi.add_apply]
      ring
    -- min of concaves is concave (mathlib: ConcaveOn.inf, since min = ⊓ on ℝ)
    have h_min_concave : ConcaveOn ℝ (Set.Icc (0:ℝ) 1) (fun η => min η (1 - η)) := by
      have h := h_id.inf h_one_sub
      -- h is on (fun η => fun η => η) ⊓ (fun η => 1 - η)
      simpa [Pi.inf_def, min_def] using h
    have h2 : (0:ℝ) ≤ 2 := by norm_num
    exact h_min_concave.smul h2
  · -- continuous
    unfold tent
    exact ((continuous_const.mul (continuous_id.min (continuous_const.sub continuous_id))).continuousOn)
  · -- symmetric: tent η = tent (1 - η)
    intro η _
    unfold tent
    have : min η (1 - η) = min (1 - η) (1 - (1 - η)) := by
      rw [sub_sub_cancel]; exact min_comm _ _
    rw [this]
  · -- φ 0 = 0
    unfold tent; simp
  · -- φ 1 = 0
    unfold tent; norm_num
  · -- φ (1/2) = 1
    unfold tent; norm_num
  · -- strict_mono on [0, 1/2]: tent η = 2η there
    intro η hη η' hη' hlt
    unfold tent
    have hη_le : η ≤ 1 - η := by
      have h1 : η ≤ 1/2 := hη.2
      linarith
    have hη'_le : η' ≤ 1 - η' := by
      have h1 : η' ≤ 1/2 := hη'.2
      linarith
    rw [min_eq_left hη_le, min_eq_left hη'_le]
    linarith

/-! ## D-cphi and T-bracket -/

/-- Upper bracket constant `c_φ = sup_{η ∈ (0, 1/2]} η / φ(η)`. Brick: `D-cphi`.
    Manuscript: §1 bracket display.

    Stated as `sSup ∘ image` rather than `⨆ η ∈ s, η/φ η` so that the
    conditional-supremum lemmas (`csSup_le`, `le_csSup`,
    `csSup_eq_of_forall_le_of_forall_lt_exists_gt`) apply directly without
    needing to unwind the nested `iSup` over a `Prop`. The two forms are
    semantically identical for ℝ. -/
noncomputable def cPhi (φ : ℝ → ℝ) : ℝ :=
  sSup ((fun η : ℝ => η / φ η) '' Set.Ioc (0:ℝ) (1/2))

/-- **Chord lemma.** For a normalized score `φ`, `φ(η) ≥ 2η` on `[0, 1/2]`.

    Proof: by concavity, the graph of `φ` on `[0, 1/2]` lies above the chord
    through `(0, φ(0)) = (0, 0)` and `(1/2, φ(1/2)) = (1/2, 1)`. The chord
    equation is `y = 2η`, so `φ(η) ≥ 2η`. -/
@[rigidity_proved, rigidity_AMS_60]
theorem two_eta_le_of_normalized (φ : ℝ → ℝ) (h : NormalizedScore φ)
    {η : ℝ} (hη : η ∈ Set.Icc (0:ℝ) (1/2)) :
    2 * η ≤ φ η := by
  obtain ⟨hη0, hη1⟩ := hη
  -- Express η as a convex combination of 0 and 1/2 with weights (1 - 2η) and 2η.
  have h_a : (0:ℝ) ≤ 1 - 2 * η := by linarith
  have h_b : (0:ℝ) ≤ 2 * η := by linarith
  have h_ab : (1 - 2 * η) + 2 * η = 1 := by ring
  have h_combo : (1 - 2 * η) • (0:ℝ) + (2 * η) • (1/2:ℝ) = η := by
    simp; ring
  -- Apply concavity at x = 0, y = 1/2.
  have h_0_mem : (0:ℝ) ∈ Set.Icc (0:ℝ) 1 := ⟨le_refl 0, by norm_num⟩
  have h_half_mem : (1/2:ℝ) ∈ Set.Icc (0:ℝ) 1 := ⟨by norm_num, by norm_num⟩
  have h_jensen := h.concave_on.2 h_0_mem h_half_mem h_a h_b h_ab
  -- h_jensen : (1 - 2η) • φ 0 + (2η) • φ (1/2) ≤ φ ((1 - 2η) • 0 + (2η) • (1/2))
  rw [h_combo] at h_jensen
  rw [h.vanishes_at_zero, h.unit_at_half] at h_jensen
  -- h_jensen : (1 - 2η) • 0 + (2η) • 1 ≤ φ η
  simpa using h_jensen

/-- Universal `c_φ = 1/2` for any normalized score. Chord argument: concavity
    above the chord through `(0, 0)` and `(1/2, 1)` gives `φ(η) ≥ 2η` on
    [0, 1/2] (proved as `two_eta_le_of_normalized`), with equality at `η = 1/2`.
    Hence `sup_{η ∈ (0, 1/2]} η / φ(η) = 1/2`.
    Defining commit: `779d533`.

    Proof structure (Tao step 2a skeleton):
    1. Pointwise `η / φ η ≤ 1/2` on `Ioc 0 (1/2)` via chord lemma + `η > 0`.
    2. At `η = 1/2`: `φ(1/2) = 1`, so value attained is exactly `1/2`.
    3. `BddAbove` on the indexed family for `ciSup_le` / `le_ciSup`.
    4. `le_antisymm` combines bounds. -/
@[rigidity_proved, rigidity_AMS_60]
theorem cPhi_eq_half_of_normalized (φ : ℝ → ℝ) (h : NormalizedScore φ) :
    cPhi φ = 1/2 := by
  -- Membership witness: 1/2 ∈ Ioc 0 (1/2).
  have h_half_mem : (1/2 : ℝ) ∈ Set.Ioc (0:ℝ) (1/2) := ⟨by norm_num, le_refl _⟩
  -- Pointwise upper bound: η / φ η ≤ 1/2 on Ioc 0 (1/2).
  have h_each_le : ∀ η ∈ Set.Ioc (0:ℝ) (1/2), η / φ η ≤ 1/2 := by
    intro η hη
    obtain ⟨hη_pos, hη_le⟩ := hη
    -- Chord lemma: 2η ≤ φ η on [0, 1/2].
    have h_chord : 2 * η ≤ φ η :=
      two_eta_le_of_normalized φ h ⟨le_of_lt hη_pos, hη_le⟩
    -- 0 < 2η ≤ φ η, so φ η > 0.
    have h_φ_pos : 0 < φ η := lt_of_lt_of_le (by linarith) h_chord
    -- η/φη ≤ 1/2  ↔  η ≤ (1/2)·φη, which follows from 2η ≤ φη.
    rw [div_le_iff₀ h_φ_pos]
    linarith
  -- Value at witness 1/2 equals 1/2.
  have h_witness : (1/2 : ℝ) / φ (1/2) = 1/2 := by
    rw [h.unit_at_half]; norm_num
  -- The image set is bounded above by 1/2.
  have h_bdd : BddAbove ((fun η : ℝ => η / φ η) '' Set.Ioc (0:ℝ) (1/2)) := by
    refine ⟨1/2, ?_⟩
    rintro x ⟨η, hη, rfl⟩
    exact h_each_le η hη
  -- The image set is nonempty (witness η = 1/2).
  have h_nonempty : ((fun η : ℝ => η / φ η) '' Set.Ioc (0:ℝ) (1/2)).Nonempty :=
    ⟨_, Set.mem_image_of_mem _ h_half_mem⟩
  -- Combine via le_antisymm: csSup ≤ 1/2 and 1/2 ≤ csSup.
  unfold cPhi
  apply le_antisymm
  · -- Upper: csSup ≤ 1/2
    apply csSup_le h_nonempty
    rintro x ⟨η, hη, rfl⟩
    exact h_each_le η hη
  · -- Lower: 1/2 ≤ csSup, via le_csSup at the witness (1/2)/φ(1/2) = 1/2.
    calc (1/2 : ℝ)
        = (1/2 : ℝ) / φ (1/2) := h_witness.symm
      _ ≤ sSup ((fun η : ℝ => η / φ η) '' Set.Ioc (0:ℝ) (1/2)) :=
            le_csSup h_bdd ⟨(1/2 : ℝ), h_half_mem, rfl⟩

/-- **Binary bracket — lower endpoint** (inverse-free form).
    For a normalized concave `φ`, with cell rates `ηᵢ` and `qᵢ := min(ηᵢ, 1-ηᵢ)`,
    symmetry gives `φ(ηᵢ) = φ(qᵢ)` and Jensen for concave `φ` on `[0, 1/2]`
    gives `Σ pᵢ φ(qᵢ) ≤ φ(Σ pᵢ qᵢ)`, i.e. `bar φ(P) ≤ φ(ε*(P))`.
    Applying `φ⁻¹` (which exists by `StrictMonoOn`) recovers `φ⁻¹(bar φ) ≤ ε*`.
    Brick: `T-bracket` (lower half). -/
@[rigidity_scaffold, rigidity_AMS_60, rigidity_AMS_62]
theorem bracket_lower {α : Type*} [MeasurableSpace α] (μ : Measure α)
    (φ : ℝ → ℝ) (_h : NormalizedScore φ)
    (f : α → Bool) (P : FinitePartition α) :
    barPhi μ φ f P ≤ φ (epsilonStar μ f P) := by sorry

/-- **Binary bracket — upper endpoint** `ε*(P) ≤ c_φ · bar φ(P)`.
    Via the pointwise inequality `η ≤ c_φ · φ(η)` on `(0, 1/2]`, aggregated.
    Brick: `T-bracket` (upper half). -/
@[rigidity_scaffold, rigidity_AMS_60, rigidity_AMS_62]
theorem bracket_upper {α : Type*} [MeasurableSpace α] (μ : Measure α)
    (φ : ℝ → ℝ) (_h : NormalizedScore φ)
    (f : α → Bool) (P : FinitePartition α) :
    epsilonStar μ f P ≤ cPhi φ * barPhi μ φ f P := by sorry

end Rigidity
