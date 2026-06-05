import Mathlib.MeasureTheory.Measure.MeasureSpace
import Mathlib.MeasureTheory.Measure.Typeclasses.Probability
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
    Computed as `(μ ({x | f x = true} ∩ c)).toReal / (μ c).toReal`, which
    yields `0` when `μ c = 0` thanks to `div_zero`. -/
noncomputable def cellRate {α : Type*} [MeasurableSpace α] (μ : Measure α)
    (f : α → Bool) (_P : FinitePartition α) (c : Set α) : ℝ :=
  (μ ({x | f x = true} ∩ c)).toReal / (μ c).toReal

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
    have h_cont : Continuous (fun η : ℝ => 2 * min η (1 - η)) :=
      continuous_const.mul (continuous_id.min (continuous_const.sub continuous_id))
    exact h_cont.continuousOn
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

/-! ## Bracket helpers (Phase B1 foundations) -/

/-- Cell rate is always non-negative. Proof: ratio of two `ENNReal.toReal`s
    is non-negative. -/
@[rigidity_proved, rigidity_AMS_28]
theorem cellRate_nonneg {α : Type*} [MeasurableSpace α] (μ : Measure α)
    (f : α → Bool) (P : FinitePartition α) (c : Set α) :
    0 ≤ cellRate μ f P c := by
  unfold cellRate
  exact div_nonneg ENNReal.toReal_nonneg ENNReal.toReal_nonneg

/-- Cell rate is at most one. Proof: numerator measure is `≤ μ c` (intersection
    is a subset), and `(μ ({x | f x = true} ∩ c)).toReal ≤ (μ c).toReal` holds
    whenever `μ c < ∞` (`ENNReal.toReal_mono`); the edge cases `μ c = 0` and
    `μ c = ∞` both yield `cellRate = 0 ≤ 1` via `div_zero` (since
    `(∞).toReal = 0` by convention). -/
@[rigidity_proved, rigidity_AMS_28]
theorem cellRate_le_one {α : Type*} [MeasurableSpace α] (μ : Measure α)
    (f : α → Bool) (P : FinitePartition α) (c : Set α) :
    cellRate μ f P c ≤ 1 := by
  unfold cellRate
  -- Case split on whether (μ c).toReal is zero.
  by_cases h_zero : (μ c).toReal = 0
  · -- Denominator is zero ⇒ cellRate = 0 ≤ 1.
    simp [h_zero]
  · -- Denominator positive: numerator ≤ denominator gives cellRate ≤ 1.
    have h_μc_pos : (0 : ℝ) < (μ c).toReal :=
      lt_of_le_of_ne ENNReal.toReal_nonneg (Ne.symm h_zero)
    rw [div_le_one h_μc_pos]
    -- (μ c).toReal ≠ 0 ⇒ μ c ≠ ∞ (and ≠ 0).
    have h_μc_finite : μ c ≠ ⊤ := by
      intro h
      apply h_zero
      simp [h]
    -- Apply ENNReal.toReal_mono.
    exact ENNReal.toReal_mono h_μc_finite (measure_mono Set.inter_subset_right)

/-! ## Phase B2 measure-theoretic helpers

    Six helpers that compose into `bracket_lower` and `bracket_upper`,
    skeletonized Tao-step-2a-style before any are filled. -/

/-- Unfold `(cellMass μ P c).toReal = (μ c).toReal`. Trivial by definition. -/
@[rigidity_proved, rigidity_AMS_28]
theorem cellMass_toReal {α : Type*} [MeasurableSpace α] (μ : Measure α)
    (P : FinitePartition α) (c : Set α) :
    (cellMass μ P c).toReal = (μ c).toReal := rfl

/-- `cellRate ∈ [0, 1]` bundle. -/
@[rigidity_proved, rigidity_AMS_28]
theorem cellRate_mem_Icc {α : Type*} [MeasurableSpace α] (μ : Measure α)
    (f : α → Bool) (P : FinitePartition α) (c : Set α) :
    cellRate μ f P c ∈ Set.Icc (0:ℝ) 1 :=
  ⟨cellRate_nonneg μ f P c, cellRate_le_one μ f P c⟩

/-- `min η (1 - η) ∈ [0, 1/2]` whenever `η ∈ [0, 1]`. Pure ℝ arithmetic. -/
@[rigidity_proved]
theorem min_self_one_sub_mem_Icc_zero_half {η : ℝ} (hη : η ∈ Set.Icc (0:ℝ) 1) :
    min η (1 - η) ∈ Set.Icc (0:ℝ) (1/2) := by
  obtain ⟨h0, h1⟩ := hη
  refine ⟨le_min h0 (by linarith), ?_⟩
  -- min η (1-η) ≤ 1/2: if η ≤ 1/2 use η ≤ 1/2 directly, else 1-η ≤ 1/2.
  rcases le_or_gt η (1/2) with h | h
  · exact (min_le_left _ _).trans h
  · exact (min_le_right _ _).trans (by linarith)

/-- For a normalized score, `φ η = φ (min η (1-η))` on `[0, 1]`. Case-split
    on `η ≤ 1/2`: if so, `min = η`; else use `symmetric` to flip to `1 - η`
    which is `≤ 1/2`. -/
@[rigidity_proved, rigidity_AMS_60]
theorem phi_eq_phi_min_symm {φ : ℝ → ℝ} (h : NormalizedScore φ)
    {η : ℝ} (hη : η ∈ Set.Icc (0:ℝ) 1) :
    φ η = φ (min η (1 - η)) := by
  obtain ⟨h0, h1⟩ := hη
  rcases le_or_gt η (1/2) with hle | hgt
  · -- η ≤ 1/2 ⇒ η ≤ 1-η ⇒ min η (1-η) = η.
    have h_min : min η (1 - η) = η := min_eq_left (by linarith)
    rw [h_min]
  · -- η > 1/2 ⇒ 1-η < η ⇒ min η (1-η) = 1-η. Use symmetry to flip.
    have h_min : min η (1 - η) = 1 - η := min_eq_right (by linarith)
    rw [h_min]
    exact h.symmetric η ⟨h0, h1⟩

/-- Restrict concavity from `[0, 1]` to `[0, 1/2]`. -/
@[rigidity_proved, rigidity_AMS_60]
theorem concave_on_Icc_zero_half {φ : ℝ → ℝ} (h : NormalizedScore φ) :
    ConcaveOn ℝ (Set.Icc (0:ℝ) (1/2)) φ :=
  h.concave_on.subset
    (Set.Icc_subset_Icc le_rfl (by norm_num))
    (convex_Icc _ _)

/-- **Measure-theoretic core.** For a probability measure and a finite
    measurable partition, the masses sum to one (as ℝ). Uses
    `P.measurable`, `P.disjoint`, `P.covers`, and `μ univ = 1`.

    Proof structure (Tao step 2a skeleton):
    1. Finite additivity: `μ (⋃ c ∈ cells, c) = Σ c, μ c` via `measure_biUnion_finset`
       with `f = id`.
    2. Bridge: `⋃ c ∈ cells, c = ⋃₀ cells = univ` via `P.covers`.
    3. `μ univ = 1` via `IsProbabilityMeasure.measure_univ`.
    4. Push `.toReal` through the sum (every cell has finite measure since
       `μ ≤ μ univ = 1 < ∞`) via `ENNReal.toReal_sum`. -/
@[rigidity_proved, rigidity_AMS_28, rigidity_AMS_60]
theorem sum_cellMass_eq_one {α : Type*} [MeasurableSpace α] (μ : Measure α)
    [IsProbabilityMeasure μ] (P : FinitePartition α) :
    ∑ c ∈ P.cells, (cellMass μ P c).toReal = 1 := by
  -- Step 1: finite additivity on disjoint measurable cells indexed by themselves.
  have h_add : μ (⋃ c ∈ P.cells, c) = ∑ c ∈ P.cells, μ c :=
    measure_biUnion_finset P.disjoint P.measurable
  -- Step 2: ⋃ c ∈ P.cells, c = univ via P.covers (after bridging Finset → Set).
  have h_univ : ⋃ c ∈ P.cells, c = Set.univ := by
    have h := P.covers
    rw [Set.sUnion_eq_biUnion] at h
    exact h
  -- Step 3: combine to get Σ_c μ c = 1 (as ENNReal).
  have h_sum_ennreal : ∑ c ∈ P.cells, μ c = 1 := by
    rw [← h_add, h_univ, measure_univ]
  -- Step 4: each μ c is finite (≤ μ univ = 1 < ∞), so toReal pushes through.
  have h_finite : ∀ c ∈ P.cells, μ c ≠ ⊤ := by
    intro c _
    refine ne_of_lt ?_
    refine lt_of_le_of_lt (measure_mono (Set.subset_univ c)) ?_
    rw [measure_univ]
    exact ENNReal.one_lt_top
  -- Push toReal through: (Σ μ c).toReal = Σ (μ c).toReal = (1 : ℝ).
  calc ∑ c ∈ P.cells, (cellMass μ P c).toReal
      = ∑ c ∈ P.cells, (μ c).toReal := by
            simp only [cellMass_toReal]
    _ = (∑ c ∈ P.cells, μ c).toReal := (ENNReal.toReal_sum h_finite).symm
    _ = (1 : ENNReal).toReal := by rw [h_sum_ennreal]
    _ = 1 := ENNReal.toReal_one

/-- **Binary bracket — lower endpoint** (inverse-free form).
    For a normalized concave `φ`, with cell rates `ηᵢ` and `qᵢ := min(ηᵢ, 1-ηᵢ)`,
    symmetry gives `φ(ηᵢ) = φ(qᵢ)` and Jensen for concave `φ` on `[0, 1/2]`
    gives `Σ pᵢ φ(qᵢ) ≤ φ(Σ pᵢ qᵢ)`, i.e. `bar φ(P) ≤ φ(ε*(P))`.
    Applying `φ⁻¹` (which exists by `StrictMonoOn`) recovers `φ⁻¹(bar φ) ≤ ε*`.
    Brick: `T-bracket` (lower half).

    Proof composition: Tao step 2a skeleton fully filled.
    1. `barPhi = Σ pᵢ φ(min ηᵢ (1-ηᵢ))` via `phi_eq_phi_min_symm` on each cell.
    2. Apply `ConcaveOn.le_map_sum` with weights `pᵢ := (μ cᵢ).toReal`, points
       `qᵢ := min ηᵢ (1-ηᵢ)`, concavity from `concave_on_Icc_zero_half`,
       `Σ pᵢ = 1` from `sum_cellMass_eq_one`, `pᵢ ≥ 0` from
       `ENNReal.toReal_nonneg`, `qᵢ ∈ [0, 1/2]` from
       `min_self_one_sub_mem_Icc_zero_half` applied to `cellRate_mem_Icc`.
    3. Yields `Σ pᵢ φ(qᵢ) ≤ φ(Σ pᵢ qᵢ) = φ(epsilonStar)`.
    4. `smul_eq_mul` to reconcile the `•` from Jensen with our `*` definitions. -/
@[rigidity_proved, rigidity_AMS_60, rigidity_AMS_62]
theorem bracket_lower {α : Type*} [MeasurableSpace α] (μ : Measure α)
    [IsProbabilityMeasure μ] (φ : ℝ → ℝ) (h : NormalizedScore φ)
    (f : α → Bool) (P : FinitePartition α) :
    barPhi μ φ f P ≤ φ (epsilonStar μ f P) := by
  -- Abbreviations.
  set p : Set α → ℝ := fun c => (cellMass μ P c).toReal with hp_def
  set η : Set α → ℝ := fun c => cellRate μ f P c with hη_def
  set q : Set α → ℝ := fun c => min (η c) (1 - η c) with hq_def
  -- Weights are nonneg.
  have hp_nonneg : ∀ c ∈ P.cells, 0 ≤ p c :=
    fun c _ => ENNReal.toReal_nonneg
  -- Weights sum to 1.
  have hp_sum : ∑ c ∈ P.cells, p c = 1 := sum_cellMass_eq_one μ P
  -- Points lie in [0, 1/2].
  have hq_mem : ∀ c ∈ P.cells, q c ∈ Set.Icc (0:ℝ) (1/2) := by
    intro c _
    -- η c ∈ [0, 1] by cellRate_mem_Icc.
    have hη_mem : η c ∈ Set.Icc (0:ℝ) 1 := cellRate_mem_Icc μ f P c
    exact min_self_one_sub_mem_Icc_zero_half hη_mem
  -- Concavity on [0, 1/2].
  have h_concave : ConcaveOn ℝ (Set.Icc (0:ℝ) (1/2)) φ :=
    concave_on_Icc_zero_half h
  -- Apply Jensen: Σ pᵢ • φ(qᵢ) ≤ φ(Σ pᵢ • qᵢ).
  have h_jensen :
      (∑ c ∈ P.cells, p c • φ (q c)) ≤ φ (∑ c ∈ P.cells, p c • q c) :=
    h_concave.le_map_sum hp_nonneg hp_sum hq_mem
  -- Rewrite the goal to match Jensen's conclusion.
  -- barPhi = Σ p c * φ(η c) = Σ p c * φ(q c) by phi_eq_phi_min_symm.
  have h_barPhi_eq : barPhi μ φ f P = ∑ c ∈ P.cells, p c * φ (q c) := by
    unfold barPhi
    apply Finset.sum_congr rfl
    intro c _
    -- η c ∈ [0, 1] needed for phi_eq_phi_min_symm.
    have hη_mem : η c ∈ Set.Icc (0:ℝ) 1 := cellRate_mem_Icc μ f P c
    rw [phi_eq_phi_min_symm h hη_mem]
  -- epsilonStar = Σ p c * q c (definitional).
  have h_epsilonStar_eq : epsilonStar μ f P = ∑ c ∈ P.cells, p c * q c := rfl
  -- Combine: barPhi = Σ p * φ(q) ≤ φ(Σ p * q) = φ(epsilonStar).
  rw [h_barPhi_eq, h_epsilonStar_eq]
  -- Replace • with * (smul_eq_mul on ℝ).
  simpa only [smul_eq_mul] using h_jensen

/-- **Binary bracket — upper endpoint** `ε*(P) ≤ c_φ · bar φ(P)`.
    Via the pointwise inequality `η ≤ c_φ · φ(η)` on `(0, 1/2]`, aggregated.
    Brick: `T-bracket` (upper half).

    Proof composition:
    1. `cPhi φ = 1/2` from `cPhi_eq_half_of_normalized`.
    2. Pointwise: for `q := min η (1-η) ∈ [0, 1/2]`, the chord lemma
       `2q ≤ φ(q)` (proved via `two_eta_le_of_normalized` on `[0, 1/2]`)
       gives `q ≤ (1/2) * φ(q) = cPhi φ * φ(q)`.
       Edge case `φ(q) = 0`: by `NormalizedScore.vanishes_at_zero` only when
       `q = 0`, then both sides are 0.
    3. Multiply by `p c ≥ 0` and sum: `Σ p c * q c ≤ (1/2) * Σ p c * φ(q c)`.
    4. LHS = `epsilonStar`; RHS uses `barPhi = Σ p c * φ(η c) = Σ p c * φ(q c)`
       via `phi_eq_phi_min_symm`. -/
@[rigidity_proved, rigidity_AMS_60, rigidity_AMS_62]
theorem bracket_upper {α : Type*} [MeasurableSpace α] (μ : Measure α)
    [IsProbabilityMeasure μ] (φ : ℝ → ℝ) (h : NormalizedScore φ)
    (f : α → Bool) (P : FinitePartition α) :
    epsilonStar μ f P ≤ cPhi φ * barPhi μ φ f P := by
  -- Abbreviations.
  set p : Set α → ℝ := fun c => (cellMass μ P c).toReal with hp_def
  set η : Set α → ℝ := fun c => cellRate μ f P c with hη_def
  set q : Set α → ℝ := fun c => min (η c) (1 - η c) with hq_def
  -- Constants.
  have h_cPhi : cPhi φ = 1/2 := cPhi_eq_half_of_normalized φ h
  rw [h_cPhi]
  -- Goal: epsilonStar μ f P ≤ (1/2) * barPhi μ φ f P
  -- Pointwise bound on each cell: q c ≤ (1/2) * φ(q c).
  -- This is the chord lemma applied at q c ∈ [0, 1/2].
  have h_pointwise : ∀ c ∈ P.cells, q c ≤ (1/2) * φ (q c) := by
    intro c _
    have hη_mem : η c ∈ Set.Icc (0:ℝ) 1 := cellRate_mem_Icc μ f P c
    have hq_mem : q c ∈ Set.Icc (0:ℝ) (1/2) :=
      min_self_one_sub_mem_Icc_zero_half hη_mem
    -- Chord lemma: 2 * q c ≤ φ (q c). Divide by 2.
    have h_chord : 2 * q c ≤ φ (q c) := two_eta_le_of_normalized φ h hq_mem
    linarith
  -- Weighted sum.
  have hp_nonneg : ∀ c ∈ P.cells, 0 ≤ p c :=
    fun c _ => ENNReal.toReal_nonneg
  -- epsilonStar = Σ p c * q c, barPhi-as-q = Σ p c * φ (q c) (via symmetry).
  have h_epsilonStar_eq : epsilonStar μ f P = ∑ c ∈ P.cells, p c * q c := rfl
  have h_barPhi_eq : barPhi μ φ f P = ∑ c ∈ P.cells, p c * φ (q c) := by
    unfold barPhi
    apply Finset.sum_congr rfl
    intro c _
    have hη_mem : η c ∈ Set.Icc (0:ℝ) 1 := cellRate_mem_Icc μ f P c
    rw [phi_eq_phi_min_symm h hη_mem]
  rw [h_epsilonStar_eq, h_barPhi_eq, Finset.mul_sum]
  -- Goal: Σ p c * q c ≤ Σ (1/2) * (p c * φ (q c))
  apply Finset.sum_le_sum
  intro c hc
  -- (p c * q c) ≤ (1/2) * (p c * φ (q c)) given p c ≥ 0 and q c ≤ (1/2) * φ (q c).
  have hpc := hp_nonneg c hc
  have hpw := h_pointwise c hc
  nlinarith [hpc, hpw]

/-! ## Tent-specific helpers (Phase B3a)

    Four foundational facts used by `theorem2` (binary rigidity).
    Skeletonized Tao-style before any are filled. -/

/-- `epsilonStar ≥ 0`: the partition Bayes risk is a sum of non-negative terms. -/
@[rigidity_proved, rigidity_AMS_28, rigidity_AMS_60]
theorem epsilonStar_nonneg {α : Type*} [MeasurableSpace α] (μ : Measure α)
    (f : α → Bool) (P : FinitePartition α) :
    0 ≤ epsilonStar μ f P := by
  unfold epsilonStar
  apply Finset.sum_nonneg
  intro c _
  apply mul_nonneg ENNReal.toReal_nonneg
  -- min(η, 1-η) ≥ 0 since η ∈ [0, 1].
  have hη_mem : cellRate μ f P c ∈ Set.Icc (0:ℝ) 1 := cellRate_mem_Icc μ f P c
  obtain ⟨h0, h1⟩ := hη_mem
  exact le_min h0 (by linarith)

/-- `epsilonStar ≤ 1/2`: each term is `pᵢ · min(ηᵢ, 1-ηᵢ) ≤ pᵢ · (1/2)`,
    and `Σ pᵢ = 1`. -/
@[rigidity_proved, rigidity_AMS_28, rigidity_AMS_60]
theorem epsilonStar_le_half {α : Type*} [MeasurableSpace α] (μ : Measure α)
    [IsProbabilityMeasure μ] (f : α → Bool) (P : FinitePartition α) :
    epsilonStar μ f P ≤ 1/2 := by
  unfold epsilonStar
  -- Bound each summand by p c * (1/2), then collect: Σ p c * (1/2) = (1/2) * Σ p c = 1/2.
  calc ∑ c ∈ P.cells,
        (cellMass μ P c).toReal * min (cellRate μ f P c) (1 - cellRate μ f P c)
      ≤ ∑ c ∈ P.cells, (cellMass μ P c).toReal * (1/2 : ℝ) := by
            apply Finset.sum_le_sum
            intro c _
            have hp_nonneg : (0:ℝ) ≤ (cellMass μ P c).toReal := ENNReal.toReal_nonneg
            have hη_mem : cellRate μ f P c ∈ Set.Icc (0:ℝ) 1 :=
              cellRate_mem_Icc μ f P c
            have hq_mem : min (cellRate μ f P c) (1 - cellRate μ f P c) ∈
                Set.Icc (0:ℝ) (1/2) :=
              min_self_one_sub_mem_Icc_zero_half hη_mem
            exact mul_le_mul_of_nonneg_left hq_mem.2 hp_nonneg
    _ = (∑ c ∈ P.cells, (cellMass μ P c).toReal) * (1/2 : ℝ) := by
            rw [← Finset.sum_mul]
    _ = 1 * (1/2 : ℝ) := by rw [sum_cellMass_eq_one]
    _ = 1/2 := one_mul _

/-- Specialization of `barPhi` at `φ = tent`: each `tent(η) = 2 min(η, 1-η)`,
    so the sum is exactly `2 · epsilonStar`. -/
@[rigidity_proved, rigidity_AMS_60]
theorem barPhi_tent_eq_two_epsilonStar {α : Type*} [MeasurableSpace α]
    (μ : Measure α) (f : α → Bool) (P : FinitePartition α) :
    barPhi μ tent f P = 2 * epsilonStar μ f P := by
  unfold barPhi epsilonStar tent
  rw [Finset.mul_sum]
  apply Finset.sum_congr rfl
  intro c _
  ring

/-- Evaluating tent at the cell-Bayes risk: `tent(ε*) = 2 · ε*` since
    `ε* ≤ 1/2` (which collapses the min). -/
@[rigidity_proved, rigidity_AMS_60]
theorem tent_epsilonStar_eq_two_epsilonStar {α : Type*} [MeasurableSpace α]
    (μ : Measure α) [IsProbabilityMeasure μ] (f : α → Bool)
    (P : FinitePartition α) :
    tent (epsilonStar μ f P) = 2 * epsilonStar μ f P := by
  unfold tent
  -- Since ε* ≤ 1/2, ε* ≤ 1 - ε*, hence min collapses to ε*.
  have h_le : epsilonStar μ f P ≤ 1/2 := epsilonStar_le_half μ f P
  have h_min : min (epsilonStar μ f P) (1 - epsilonStar μ f P) = epsilonStar μ f P :=
    min_eq_left (by linarith)
  rw [h_min]

end Rigidity
