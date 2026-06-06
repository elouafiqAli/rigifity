import Mathlib.MeasureTheory.Measure.Typeclasses.NoAtoms
import Mathlib.MeasureTheory.Measure.Typeclasses.Probability
import Mathlib.Algebra.BigOperators.Field
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

/-! ## Phase C2 — refinement-monotonicity of barPhi -/

/-- **Workhorse** (Phase C2): for concave `φ` on `[0, 1]`, `barPhi` is
    monotone under refinement.

    Proof structure (Tao step 2a, fully skeletonized):
    1. Drop empty cells from `P'.cells` via `barPhi_eq_filter_nonempty` —
       they contribute zero to both sides.
    2. Reindex the resulting sum over `P.cells.biUnion (refining P')` via
       `biUnion_refining_eq` (which equals the filtered nonempty cells).
    3. Apply `Finset.sum_biUnion` using `refining_pairwiseDisjoint` to obtain
       a double sum: `Σ c ∈ P.cells, Σ c' ∈ refining P' c, ...`.
    4. For each `c ∈ P.cells`, apply per-cell Jensen via
       `ConcaveOn.le_map_sum` with weights `pᵢ' := (μ c'ᵢ).toReal / (μ c).toReal`
       and points `ηᵢ' := cellRate μ f P' c'ᵢ`. The tower
       `cellRate_mul_cellMass_refining_sum` identifies the weighted average
       with `cellRate μ f P c`, so Jensen yields
       `Σ pᵢ' · φ(ηᵢ') ≤ φ(cellRate μ f P c)`. Multiplying by `(μ c).toReal`:
       `Σ (μ c'ᵢ).toReal · φ(ηᵢ') ≤ (μ c).toReal · φ(cellRate μ f P c)`.
    5. Sum over `c ∈ P.cells` to get the full inequality. -/
@[rigidity_proved, rigidity_AMS_28, rigidity_AMS_60]
theorem barPhi_refinement_le {α : Type*} [MeasurableSpace α]
    (μ : Measure α) [IsProbabilityMeasure μ]
    (φ : ℝ → ℝ) (h_cvx : ConcaveOn ℝ (Set.Icc (0:ℝ) 1) φ)
    (f : α → Bool) (hf : MeasurableSet {x | f x = true})
    (P P' : FinitePartition α) (h_ref : P' ⪰ P) :
    barPhi μ φ f P' ≤ barPhi μ φ f P := by
  classical
  -- Step 1: barPhi μ φ f P' = Σ over nonempty cells of P'.
  rw [barPhi_eq_filter_nonempty μ φ f P']
  -- Step 2: rewrite the index set as P.cells.biUnion (refining P').
  rw [← biUnion_refining_eq P P' h_ref]
  -- Step 3: split the biUnion into a double sum.
  rw [Finset.sum_biUnion (refining_pairwiseDisjoint P P')]
  -- Step 4: per-cell inequality.
  -- Goal: ∑ c ∈ P.cells, ∑ c' ∈ refining P' c, (cellMass μ P' c').toReal * φ (cellRate μ f P' c')
  --       ≤ barPhi μ φ f P
  -- Unfold barPhi on the RHS to expose the matching sum.
  show ∑ c ∈ P.cells, ∑ c' ∈ refining P' c,
        (cellMass μ P' c').toReal * φ (cellRate μ f P' c') ≤
      ∑ c ∈ P.cells, (cellMass μ P c).toReal * φ (cellRate μ f P c)
  refine Finset.sum_le_sum (fun c hc => ?_)
  -- Sub-goal: per-cell. Case-split on (cellMass μ P c).toReal = 0.
  by_cases h_zero : (cellMass μ P c).toReal = 0
  · -- Degenerate: μ c = 0 ⟹ μ c' = 0 for all c' ⊆ c ⟹ both sides 0.
    rw [h_zero, zero_mul]
    have h_finite_c : μ c ≠ ⊤ := by
      refine ne_of_lt ?_
      refine lt_of_le_of_lt (measure_mono (Set.subset_univ c)) ?_
      rw [measure_univ]
      exact ENNReal.one_lt_top
    have h_μc_zero : μ c = 0 := by
      rcases (ENNReal.toReal_eq_zero_iff (μ c)).mp h_zero with h | h
      · exact h
      · exact absurd h h_finite_c
    -- Each term in the sum is 0.
    apply le_of_eq
    apply Finset.sum_eq_zero
    intro c' hc'
    rw [mem_refining_iff] at hc'
    obtain ⟨_, _, h_sub⟩ := hc'
    have h_μc'_zero : μ c' = 0 := measure_mono_null h_sub h_μc_zero
    show (cellMass μ P' c').toReal * φ (cellRate μ f P' c') = 0
    show (μ c').toReal * φ (cellRate μ f P' c') = 0
    rw [h_μc'_zero]
    simp
  · -- Non-degenerate: (μ c).toReal > 0. Apply Jensen.
    set p_c := (cellMass μ P c).toReal with hp_c_def
    have hp_c_pos : 0 < p_c :=
      lt_of_le_of_ne ENNReal.toReal_nonneg (Ne.symm h_zero)
    -- Factor LHS as p_c · (Σ (μ c'/p_c) · φ(cellRate μ f P' c')).
    have h_LHS_factor :
        ∑ c' ∈ refining P' c,
          (cellMass μ P' c').toReal * φ (cellRate μ f P' c') =
        p_c * ∑ c' ∈ refining P' c,
          ((cellMass μ P' c').toReal / p_c) * φ (cellRate μ f P' c') := by
      rw [Finset.mul_sum]
      apply Finset.sum_congr rfl
      intro c' _
      field_simp
    rw [h_LHS_factor]
    -- Goal: p_c * (Σ ...) ≤ p_c * φ (cellRate μ f P c). Reduce to Jensen.
    apply mul_le_mul_of_nonneg_left _ (le_of_lt hp_c_pos)
    -- Goal: ∑ c' ∈ refining P' c, ((cellMass μ P' c').toReal / p_c) * φ (cellRate μ f P' c')
    --       ≤ φ (cellRate μ f P c).
    -- Jensen hypotheses.
    have hw_nonneg : ∀ c' ∈ refining P' c,
        0 ≤ (cellMass μ P' c').toReal / p_c :=
      fun c' _ => div_nonneg ENNReal.toReal_nonneg (le_of_lt hp_c_pos)
    have hw_sum_one : ∑ c' ∈ refining P' c,
        (cellMass μ P' c').toReal / p_c = 1 := by
      rw [← Finset.sum_div _ _ _]
      rw [sum_cellMass_refining_eq μ P P' h_ref hc]
      exact div_self (ne_of_gt hp_c_pos)
    have hη_mem : ∀ c' ∈ refining P' c,
        cellRate μ f P' c' ∈ Set.Icc (0:ℝ) 1 :=
      fun c' _ => cellRate_mem_Icc μ f P' c'
    -- Apply Jensen.
    have h_jensen := h_cvx.le_map_sum hw_nonneg hw_sum_one hη_mem
    -- h_jensen : ∑ c' ∈ refining P' c, w c' • φ (cellRate ...) ≤
    --            φ (∑ c' ∈ refining P' c, w c' • cellRate ...)
    -- The weighted average inside φ equals cellRate μ f P c via the tower.
    have h_avg : ∑ c' ∈ refining P' c,
        ((cellMass μ P' c').toReal / p_c) • cellRate μ f P' c' =
        cellRate μ f P c := by
      simp only [smul_eq_mul]
      calc ∑ c' ∈ refining P' c,
              (cellMass μ P' c').toReal / p_c * cellRate μ f P' c'
          = ∑ c' ∈ refining P' c,
              cellRate μ f P' c' * (cellMass μ P' c').toReal / p_c := by
                apply Finset.sum_congr rfl
                intro c' _
                ring
        _ = (∑ c' ∈ refining P' c,
              cellRate μ f P' c' * (cellMass μ P' c').toReal) / p_c :=
                (Finset.sum_div _ _ _).symm
        _ = (cellRate μ f P c * p_c) / p_c := by
                rw [← cellRate_mul_cellMass_refining_sum μ f P P' h_ref hf hc]
        _ = cellRate μ f P c := by
                rw [mul_div_assoc, div_self (ne_of_gt hp_c_pos), mul_one]
    rw [h_avg] at h_jensen
    -- h_jensen : ∑ c' ∈ refining P' c, w c' • φ (cellRate ...) ≤ φ (cellRate μ f P c)
    simpa only [smul_eq_mul] using h_jensen

/-- Bridge: `barPhi_refinement_le` packaged as a hypothesis form for use
    in `theorem1`'s easy direction (which needs the unconditional `∀ f P P'`
    over measurable `f`). -/
@[rigidity_proved, rigidity_AMS_28, rigidity_AMS_60]
theorem theorem1_easy {α : Type*} [MeasurableSpace α] (μ : Measure α)
    [IsProbabilityMeasure μ] (φ : ℝ → ℝ) (h_cvx : ConcaveOn ℝ (Set.Icc (0:ℝ) 1) φ) :
    ∀ (f : α → Bool) (_hf : MeasurableSet {x | f x = true})
      (P P' : FinitePartition α),
      P' ⪰ P → barPhi μ φ f P' ≤ barPhi μ φ f P := by
  intro f hf P P' h_ref
  exact barPhi_refinement_le μ φ h_cvx f hf P P' h_ref

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

    Phase C4 closure (2026-06-05): step 6 discharged via the generic
    `cellRate_trivial_eq_sum` lemma over arbitrary `f : α → Bool` (added in
    `Bracket.lean` alongside `sum_measure_inter_eq` and `cellRate_trivial`).

    Note (Phase C2 reconciliation, 2026-06-06): `h_mono` now takes
    `MeasurableSet {x | f x = true}` to match `theorem1`'s iff statement.
    The hypothesis is satisfied by `BinarySplitRealizable`'s `hf_meas` field. -/
@[rigidity_proved, rigidity_AMS_28, rigidity_AMS_60]
theorem theorem1_hard {α : Type*} [MeasurableSpace α] (μ : Measure α)
    [IsProbabilityMeasure μ] [BinarySplitRealizable μ]
    (φ : ℝ → ℝ)
    (h_mono : ∀ (f : α → Bool) (_hf : MeasurableSet {x | f x = true})
        (P P' : FinitePartition α),
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
  have h_le : barPhi μ φ f P ≤ barPhi μ φ f trivialPartition :=
    h_mono f hf_meas trivialPartition P h_ref
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
    functional `bar φ` is monotone under refinement (over **measurable** `f`)
    iff `φ` is concave on `[0, 1]`.

    Note (Phase C2 reconciliation): the measurability of `{x | f x = true}`
    is required by the easy direction's tower-property (partition-additivity
    of `μ ({f=true} ∩ ·)`). The hard direction uses `BinarySplitRealizable`
    which provides a measurable witness, so this hypothesis is satisfied by
    construction in `theorem1_hard`.

    Easy direction (←): apply `barPhi_refinement_le` (Phase C2 target).
    Hard direction (→): use `BinarySplitRealizable` to realize the convex
    combination `a · lam + b · (1 - lam)` as a 2-cell refinement, where
    refinement monotonicity collapses to the concavity inequality. -/
@[rigidity_proved, rigidity_AMS_28, rigidity_AMS_60]
theorem theorem1 {α : Type*} [MeasurableSpace α] (μ : Measure α)
    [IsProbabilityMeasure μ] [BinarySplitRealizable μ]
    (φ : ℝ → ℝ) (_hc : ContinuousOn φ (Set.Icc (0:ℝ) 1)) :
    (∀ (f : α → Bool) (_hf : MeasurableSet {x | f x = true})
        (P P' : FinitePartition α),
        P' ⪰ P → barPhi μ φ f P' ≤ barPhi μ φ f P) ↔
    ConcaveOn ℝ (Set.Icc (0:ℝ) 1) φ := by
  refine ⟨?_, ?_⟩
  · -- HARD direction: refinement-mono ⟹ concave.
    exact theorem1_hard μ φ
  · -- EASY direction: concave ⟹ refinement-mono.
    intro h_cvx
    exact theorem1_easy μ φ h_cvx

end Rigidity
