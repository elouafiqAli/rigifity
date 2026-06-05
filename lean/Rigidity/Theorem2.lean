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

/-- **Theorem 2** (binary rigidity).
    On an atomless probability space, a normalized score `φ` has an exact
    bracket on every cell-Bayes risk iff `φ` agrees with `tent` on `[0, 1]`.

    The `Set.EqOn` formulation (vs the manuscript's `φ = T`) is the honest
    one: `NormalizedScore φ` doesn't constrain φ outside `[0, 1]`, and the
    cell-Bayes / cellRate values used in the bracket all lie in `[0, 1]`.
    So pointwise equality on `ℝ` cannot follow from any bracket-side
    hypothesis. Audit finding 2026-06-05.

    Reverse direction (still `sorry`): the single-cell argument needs a
    realizability lemma — for `[NoAtoms μ]`, every `η ∈ [0, 1/2]` arises as
    `cellRate μ f` for some measurable `f` on the trivial partition.
    Tracked separately as Phase B3b. -/
@[rigidity_scaffold, rigidity_AMS_60, rigidity_AMS_62]
theorem theorem2 {α : Type*} [MeasurableSpace α] {μ : Measure α}
    [IsProbabilityMeasure μ] [NoAtoms μ]
    (φ : ℝ → ℝ) (h : NormalizedScore φ) :
    (∀ (f : α → Bool) (P : FinitePartition α),
        barPhi μ φ f P = φ (epsilonStar μ f P) ∧
        epsilonStar μ f P = cPhi φ * barPhi μ φ f P) ↔
    Set.EqOn φ tent (Set.Icc (0:ℝ) 1) := by
  constructor
  · -- Reverse direction: bracket equality ⟹ φ agrees with tent on [0, 1].
    --   Single-cell argument: for any η ∈ [0, 1/2] there's an f making
    --   cellRate equal to η. Then the equality `epsilonStar = cPhi φ · barPhi`
    --   becomes `η = (1/2) · φ(η)`, i.e. `φ(η) = 2η = tent(η)` on [0, 1/2].
    --   Symmetry of NormalizedScore extends to (1/2, 1].
    --   Requires Phase B3b realizability helper.
    sorry
  · -- Forward direction: discharged by theorem2_forward.
    intro h_eq
    exact theorem2_forward μ φ h_eq

end Rigidity
