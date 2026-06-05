import Mathlib.MeasureTheory.Measure.Typeclasses.NoAtoms
import Rigidity.Bracket
import Rigidity.Util.Attributes

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

/-- **Theorem 2 — forward direction** (binary rigidity, easy half).
    If `φ` agrees with `tent` on `[0, 1]`, then both bracket equalities
    hold for every cell-Bayes risk on a probability measure.

    Proof: at `φ = tent`,
    - `barPhi φ = 2 · epsilonStar` (`barPhi_tent_eq_two_epsilonStar`)
    - `tent(epsilonStar) = 2 · epsilonStar` (`tent_epsilonStar_eq_two_epsilonStar`,
      uses `epsilonStar ≤ 1/2`)
    - `cPhi tent = 1/2` (`cPhi_eq_half_of_normalized` + `tent_normalized`)

    The `Set.EqOn` hypothesis (rather than the stronger `φ = tent`) is
    deliberate: `NormalizedScore φ` only constrains φ on `[0, 1]`, and the
    cell-Bayes risk + cell rates all lie in `[0, 1]`. Outside `[0, 1]`, φ
    is free, so pointwise equality off the interval is genuinely
    unprovable from the bracket data. -/
@[rigidity_proved, rigidity_AMS_60, rigidity_AMS_62]
theorem theorem2_forward {α : Type*} [MeasurableSpace α] (μ : Measure α)
    [IsProbabilityMeasure μ] (φ : ℝ → ℝ) (h_eq : Set.EqOn φ tent (Set.Icc (0:ℝ) 1)) :
    ∀ (f : α → Bool) (P : FinitePartition α),
        barPhi μ φ f P = φ (epsilonStar μ f P) ∧
        epsilonStar μ f P = cPhi φ * barPhi μ φ f P := by
  intro f P
  -- Step 1: barPhi μ φ f P = Σ p c * φ (η c) = Σ p c * tent (η c) = barPhi μ tent f P,
  --   because each η c ∈ [0, 1] so h_eq applies pointwise.
  have h_barPhi : barPhi μ φ f P = barPhi μ tent f P := by
    unfold barPhi
    apply Finset.sum_congr rfl
    intro c _
    have hη_mem : cellRate μ f P c ∈ Set.Icc (0:ℝ) 1 := cellRate_mem_Icc μ f P c
    rw [h_eq hη_mem]
  -- Step 2: epsilonStar ∈ [0, 1/2] ⊂ [0, 1], so φ (epsilonStar) = tent (epsilonStar).
  have h_eps_mem : epsilonStar μ f P ∈ Set.Icc (0:ℝ) 1 :=
    ⟨epsilonStar_nonneg μ f P,
     le_trans (epsilonStar_le_half μ f P) (by norm_num)⟩
  have h_φ_eps : φ (epsilonStar μ f P) = tent (epsilonStar μ f P) := h_eq h_eps_mem
  -- Step 3: cPhi φ = cPhi tent = 1/2.
  have h_cPhi : cPhi φ = 1/2 := by
    -- φ agrees with tent on (0, 1/2] ⊂ [0, 1], so the image set defining cPhi
    -- is the same for φ and tent. Then cPhi tent = 1/2 by the proved theorem
    -- applied to tent_normalized.
    have h_image : (fun η : ℝ => η / φ η) '' Set.Ioc (0:ℝ) (1/2) =
        (fun η : ℝ => η / tent η) '' Set.Ioc (0:ℝ) (1/2) := by
      apply Set.image_congr
      intro η hη
      have hη_mem : η ∈ Set.Icc (0:ℝ) 1 := ⟨le_of_lt hη.1, by linarith [hη.2]⟩
      rw [h_eq hη_mem]
    show sSup ((fun η : ℝ => η / φ η) '' Set.Ioc (0:ℝ) (1/2)) = 1/2
    rw [h_image]
    -- Now reduce to cPhi tent = 1/2, which is exactly cPhi_eq_half_of_normalized applied to tent.
    exact cPhi_eq_half_of_normalized tent tent_normalized
  refine ⟨?_, ?_⟩
  · -- barPhi = φ (epsilonStar)
    rw [h_barPhi, h_φ_eps, barPhi_tent_eq_two_epsilonStar,
        tent_epsilonStar_eq_two_epsilonStar]
  · -- epsilonStar = cPhi φ * barPhi
    rw [h_cPhi, h_barPhi, barPhi_tent_eq_two_epsilonStar]
    ring

/-- Existence-of-realizing-rate hypothesis for binary rigidity.

    For `[NoAtoms μ] [IsProbabilityMeasure μ]` this is provable via
    **Sierpiński's theorem on atomless measures** (1922/Sikorski 1958), but
    mathlib4 does not currently carry this theorem. See
    `.research/2026-06-05-sierpinski-atomless-realizability.md` for the full
    research log; the strategy follows Rémy Degenne's `HasGenBayesEstimator`
    pattern (testing-lower-bounds/Testing/Risk.lean:259): axiomatize the
    existence as a typeclass that callers must instantiate.

    No `[NoAtoms μ] → SingleCellRealizable μ` instance is provided here
    because providing it would require proving Sierpiński. The mathlib
    contribution that closes this gap is item #1 in
    `.research/opportunities.md`. -/
class SingleCellRealizable {α : Type*} [MeasurableSpace α] (μ : Measure α) : Prop where
  /-- For every `η ∈ [0, 1/2]`, there exists a measurable set with measure
      `η.toENNReal` (equivalently, `(μ s).toReal = η`). -/
  exists_set_of_measure_eq :
    ∀ η ∈ Set.Icc (0:ℝ) (1/2),
      ∃ s : Set α, MeasurableSet s ∧ (μ s).toReal = η

/-- The single-cell trivial partition `{univ}`. The cellRate on this partition
    over a `Bool`-valued `f` is exactly `(μ {x | f x = true}).toReal /
    (μ univ).toReal = (μ {x | f x = true}).toReal` (under
    `[IsProbabilityMeasure μ]`). Used by the realizability argument. -/
noncomputable def trivialPartition {α : Type*} [MeasurableSpace α] :
    FinitePartition α where
  cells := {Set.univ}
  measurable := by
    intro c hc
    rw [Finset.mem_singleton] at hc
    rw [hc]
    exact MeasurableSet.univ
  disjoint := by
    intro c₁ hc₁ c₂ hc₂ hne
    simp only [Finset.coe_singleton, Set.mem_singleton_iff] at hc₁ hc₂
    exact absurd (hc₁.trans hc₂.symm) hne
  covers := by
    simp only [Finset.coe_singleton, Set.sUnion_singleton]

/-- The indicator-of-measurable-set function as `α → Bool`.
    `Set.indicator` is mathlib's name for the ℝ-valued indicator; here we want
    the `Bool` version. Uses classical decidability for membership in arbitrary
    measurable sets. -/
noncomputable def boolIndicator {α : Type*} (s : Set α) : α → Bool :=
  fun x => by classical exact if x ∈ s then true else false

/-! ## Phase B3b skeletons

    Four sub-`sorry`s implementing the reverse direction of `theorem2` via
    the realizability typeclass + single-cell argument. Skeletonized
    Tao-step-2a-style so the dependency chain is visible before any are
    discharged. -/

/-- On the trivial partition `{univ}` with indicator `boolIndicator s` for a
    measurable `s ⊆ α`, `cellRate μ (boolIndicator s) trivialPartition univ =
    (μ s).toReal` under `[IsProbabilityMeasure μ]`.

    Proof: `cellRate` unfolds to `(μ ({x | boolIndicator s x = true} ∩ univ)).toReal /
    (μ univ).toReal = (μ s).toReal / 1 = (μ s).toReal`. -/
@[rigidity_proved, rigidity_AMS_28, rigidity_AMS_60]
theorem cellRate_trivial_boolIndicator {α : Type*} [MeasurableSpace α]
    (μ : Measure α) [IsProbabilityMeasure μ] {s : Set α} (_hs : MeasurableSet s) :
    cellRate μ (boolIndicator s) trivialPartition Set.univ = (μ s).toReal := by
  unfold cellRate
  -- {x | boolIndicator s x = true} = s by definition of boolIndicator.
  have h_set_eq : {x | boolIndicator s x = true} = s := by
    ext x
    simp only [Set.mem_setOf_eq, boolIndicator]
    classical
    by_cases hx : x ∈ s
    · simp [hx]
    · simp [hx]
  rw [h_set_eq, Set.inter_univ, measure_univ]
  simp

/-- `epsilonStar` on the trivial partition simplifies to
    `min ((μ s).toReal) (1 - (μ s).toReal)`. -/
@[rigidity_proved, rigidity_AMS_28, rigidity_AMS_60]
theorem epsilonStar_trivial_boolIndicator {α : Type*} [MeasurableSpace α]
    (μ : Measure α) [IsProbabilityMeasure μ] {s : Set α} (hs : MeasurableSet s) :
    epsilonStar μ (boolIndicator s) trivialPartition =
      min ((μ s).toReal) (1 - (μ s).toReal) := by
  -- Same shape as barPhi_trivial_boolIndicator with φ = (fun η => min η (1 - η)).
  show ∑ c ∈ trivialPartition.cells, (cellMass μ trivialPartition c).toReal *
        min (cellRate μ (boolIndicator s) trivialPartition c)
            (1 - cellRate μ (boolIndicator s) trivialPartition c) = _
  show ∑ c ∈ ({Set.univ} : Finset (Set α)),
        (cellMass μ trivialPartition c).toReal *
        min (cellRate μ (boolIndicator s) trivialPartition c)
            (1 - cellRate μ (boolIndicator s) trivialPartition c) = _
  rw [Finset.sum_singleton, cellRate_trivial_boolIndicator μ hs]
  unfold cellMass
  rw [measure_univ]
  simp

/-- `barPhi` on the trivial partition simplifies to `φ ((μ s).toReal)`. -/
@[rigidity_proved, rigidity_AMS_60]
theorem barPhi_trivial_boolIndicator {α : Type*} [MeasurableSpace α]
    (μ : Measure α) [IsProbabilityMeasure μ] (φ : ℝ → ℝ)
    {s : Set α} (hs : MeasurableSet s) :
    barPhi μ φ (boolIndicator s) trivialPartition = φ ((μ s).toReal) := by
  -- Unfold barPhi to its definition (sum over trivialPartition.cells).
  show ∑ c ∈ trivialPartition.cells, (cellMass μ trivialPartition c).toReal *
       φ (cellRate μ (boolIndicator s) trivialPartition c) = φ ((μ s).toReal)
  -- trivialPartition.cells = {univ} by definition.
  show ∑ c ∈ ({Set.univ} : Finset (Set α)),
        (cellMass μ trivialPartition c).toReal *
        φ (cellRate μ (boolIndicator s) trivialPartition c) = φ ((μ s).toReal)
  rw [Finset.sum_singleton]
  -- (cellMass μ P univ).toReal = (μ univ).toReal = 1.
  show (cellMass μ trivialPartition Set.univ).toReal *
        φ (cellRate μ (boolIndicator s) trivialPartition Set.univ) = φ ((μ s).toReal)
  rw [cellRate_trivial_boolIndicator μ hs]
  unfold cellMass
  rw [measure_univ]
  simp

/-- **Theorem 2 — reverse direction.** Bracket exactness on a probability
    measure satisfying `SingleCellRealizable` forces `φ = tent` on `[0, 1/2]`,
    and symmetry of `NormalizedScore` extends to `[0, 1]`.

    Proof structure (Tao step 2a skeleton with 3 sub-sorries; full chain
    documented):

    Per `η ∈ (0, 1/2]`, realize η = (μ s).toReal via `SingleCellRealizable`.
    Apply bracket eqn 2 at f = boolIndicator s, P = trivialPartition:
        `epsilonStar = cPhi φ * barPhi`
        ⟹ `min(η, 1-η) = cPhi φ * φ(η)` (via epsilonStar_trivial + barPhi_trivial)
        ⟹ `η = cPhi φ * φ(η)` (since η ≤ 1/2 ⟹ min = η)
        ⟹ `η / φ(η) = cPhi φ` (when φ(η) ≠ 0; sub-sorry #1: positivity)
    Now at η = 1/2: `cPhi φ * φ(1/2) = 1/2`, and `φ(1/2) = 1`
    (from `NormalizedScore.unit_at_half`), so `cPhi φ = 1/2`.
    Hence `φ(η) = 2η = tent(η)` for all realizable η ∈ (0, 1/2].
    Extend to η = 0 by `NormalizedScore.vanishes_at_zero` matching
    `tent 0 = 0`. (Sub-sorry #2.)
    Extend to η ∈ (1/2, 1] by symmetry: φ(η) = φ(1 - η) = tent(1 - η) =
    tent(η). (Sub-sorry #3.)

    The full proof is ~60 lines of pinning algebra; left for the next
    commit. -/
@[rigidity_scaffold, rigidity_AMS_60, rigidity_AMS_62]
theorem theorem2_reverse {α : Type*} [MeasurableSpace α] (μ : Measure α)
    [IsProbabilityMeasure μ] [SingleCellRealizable μ]
    (φ : ℝ → ℝ) (h : NormalizedScore φ)
    (h_exact : ∀ (f : α → Bool) (P : FinitePartition α),
        barPhi μ φ f P = φ (epsilonStar μ f P) ∧
        epsilonStar μ f P = cPhi φ * barPhi μ φ f P) :
    Set.EqOn φ tent (Set.Icc (0:ℝ) 1) := by
  intro η hη
  -- Case split: η = 0, η ∈ (0, 1/2], or η ∈ (1/2, 1].
  rcases eq_or_lt_of_le hη.1 with hη_zero | hη_pos
  · -- η = 0: φ(0) = 0 = tent(0).
    rw [← hη_zero, h.vanishes_at_zero]
    unfold tent
    simp
  · rcases le_or_gt η (1/2) with hη_half | hη_half
    · -- η ∈ (0, 1/2]: realize, apply bracket eqn 2, derive φ(η) = 2η.
      -- Sub-sorry #1: requires pinning via bracket equation + cPhi = 1/2.
      sorry
    · -- η ∈ (1/2, 1]: use symmetry φ(η) = φ(1 - η) and the previous case.
      -- Sub-sorry #3: symmetry case.
      sorry

/-- **Theorem 2** (binary rigidity).
    On a probability space with `SingleCellRealizable μ` (provable for
    `[NoAtoms μ]` via Sierpiński's theorem; see `.research/`), a normalized
    score `φ` has an exact bracket on every cell-Bayes risk iff `φ` agrees
    with `tent` on `[0, 1]`.

    The `Set.EqOn` formulation (vs the manuscript's `φ = T`) is the honest
    one: `NormalizedScore φ` doesn't constrain φ outside `[0, 1]`.

    Currently `@[rigidity_scaffold]` because `theorem2_reverse` still has
    `sorry` sub-goals — even though the glue here is trivial, transitive
    `sorryAx` would make this tag dishonest. Re-tag to `@[rigidity_proved]`
    once `theorem2_reverse` is sorry-free. -/
@[rigidity_scaffold, rigidity_AMS_60, rigidity_AMS_62]
theorem theorem2 {α : Type*} [MeasurableSpace α] {μ : Measure α}
    [IsProbabilityMeasure μ] [SingleCellRealizable μ]
    (φ : ℝ → ℝ) (h : NormalizedScore φ) :
    (∀ (f : α → Bool) (P : FinitePartition α),
        barPhi μ φ f P = φ (epsilonStar μ f P) ∧
        epsilonStar μ f P = cPhi φ * barPhi μ φ f P) ↔
    Set.EqOn φ tent (Set.Icc (0:ℝ) 1) :=
  ⟨theorem2_reverse μ φ h, theorem2_forward μ φ⟩

end Rigidity
