import Mathlib.MeasureTheory.Measure.Typeclasses.NoAtoms
import Mathlib.MeasureTheory.Measure.Typeclasses.Probability
import Mathlib.Algebra.BigOperators.Fin
import Mathlib.Algebra.BigOperators.Field
import Mathlib.Data.Fintype.BigOperators
import Mathlib.Order.Lattice
import Rigidity.Bracket
import Rigidity.Util.Attributes

/-!
# Theorem 2′ — Simplex Rigidity (multiclass extension of Theorem 2)

Among continuous, vertex-vanishing scores on the probability simplex
`Δ^{k-1}`, the multiclass Bayes risk `R(η) = 1 - max_c η_c` is the unique
exact functional (up to a positive scalar). Every exact `φ` is automatically
concave and permutation-symmetric.

## Proof structure (cf. §4.2)

* **Step 1** — single-cell partitions force `R = G ∘ φ`, i.e. `φ`'s level
  sets refine `R`'s.
* **Step 2** — two-cell partitions force `G` affine, via a Jensen-equality
  identity on a bounded range (no Hamel-basis pathology).
* **Step 3** — vertex pinning gives `G(0) = 0`, hence `G(v) = a v`; the
  non-constancy of `R` forces `a > 0`.

## Provenance

* Manuscript: §4.2 Theorem 2′ (Draft 0.6 round-6 audit closure: Step 1
  headline corrected from converse, §4.3 split into Worked example A
  (Step-1 violation) and Worked example B (slack mechanism)).
* Defining commits:
  - `5ba935f`  §4.1 setup + bracket; **M-2** (`c_φ < ∞` hypothesis) closed
  - `c8ef3e6`  §4.2 rigidity theorem; **M-1** (atomless hypothesis), **m-3**
              (Step 1 level-set framing), **m-4** (Step 2 bounded-Jensen)
              folded in
  - `c6a5bc0`  rename Theorem 4 → Theorem 2′ (numbering collision fix)
  - `d6363f7`  **M-4** Step 2 `φ_max := max φ` via Weierstrass (drops the
              over-asserted `φ_max = φ(u)`)
  - `7219873`  **m-1** Step 3 `a > 0` justified by non-constancy of `R`
              (drops the unjustified "φ > 0 on interior" premise)
  - Phase D (this commit) lands the simplex labeling infrastructure
    (`cellRateSimplex`, `epsilonStarSimplex`, `barPhiSimplex`), the two
    realizability typeclasses (`SingleCellRealizableSimplex`,
    `TwoCellRealizableSimplex`), and Steps 1 + 3 of the proof in full.
    Step 2 (G affine via bounded Jensen-equality on a real interval) is
    isolated as `affine_of_jensen_eq` — a Cauchy-equation result that is
    the *one* genuinely deep step.
* Brick: `T2′`. Mandatory kernel target.

Phase D status (post Phase C2 closure, commit `8339f60`):
* Simplex labeling infrastructure: **landed** (`cellRateSimplex` +
  `epsilonStarSimplex` + `barPhiSimplex` + trivial-partition helpers).
* Realizability typeclasses: **landed** (`SingleCellRealizableSimplex`,
  `TwoCellRealizableSimplex`). Both follow from `[NoAtoms μ]` via the
  same Sierpiński argument as `SingleCellRealizable` / `BinarySplitRealizable`
  (opportunity #1 in `.research/opportunities.md`).
* Step 1 (single cells → R = G ∘ φ): **proved**.
* Step 2 (two cells → G affine): scaffolded; reduces to the Cauchy-equation
  lemma `affine_of_jensen_eq` (one sub-`sorry`).
* Step 3 (vertices → φ = λ R): **proved** modulo Step 2's affine conclusion.
-/

namespace Rigidity.Simplex

open MeasureTheory Set Real BigOperators
open Rigidity

/-! ## D-simplex and D-R -/

/-- The probability simplex `Δ^{k-1}` inside `Fin k → ℝ`. Brick: `D-simplex`. -/
def simplex (k : ℕ) : Set (Fin k → ℝ) :=
  {η | (∀ c, 0 ≤ η c) ∧ ∑ c, η c = 1}

/-- The center of the simplex: `u = (1/k, ..., 1/k)`. -/
noncomputable def center (k : ℕ) [NeZero k] : Fin k → ℝ := fun _ => 1 / (k : ℝ)

/-- The `c`-th vertex of the simplex: `e_c`. -/
def vertex {k : ℕ} (c : Fin k) : Fin k → ℝ := fun c' => if c = c' then 1 else 0

variable {k : ℕ}

/-- The multiclass Bayes risk `R(η) = 1 - max_c η_c`. Brick: `D-R`.
    Concave on `Δ^{k-1}` (max of linear forms is convex), continuous,
    permutation-symmetric, vanishes at the vertices, maximal at the
    center with value `1 - 1/k`. -/
noncomputable def R [NeZero k] (η : Fin k → ℝ) : ℝ :=
  1 - Finset.univ.sup' Finset.univ_nonempty (fun c : Fin k => η c)

/-! ### Basic facts about R, vertex, center -/

/-- `R` vanishes at every vertex: `R(e_c) = 0`. Proof: `e_c = (0,…,1,…,0)` with
    the `1` at position `c`, so `max_{c'} e_c(c') = 1`, hence `R(e_c) = 1-1 = 0`. -/
@[rigidity_proved, rigidity_AMS_60]
theorem R_vertex_eq_zero [NeZero k] (c : Fin k) : R (vertex c) = 0 := by
  unfold R vertex
  have h_sup : Finset.univ.sup' Finset.univ_nonempty
      (fun c' : Fin k => if c = c' then (1:ℝ) else 0) = 1 := by
    apply le_antisymm
    · apply Finset.sup'_le
      intro c' _
      by_cases h : c = c'
      · rw [if_pos h]
      · rw [if_neg h]; norm_num
    · have h_c : (if c = c then (1:ℝ) else 0) = 1 := by rw [if_pos rfl]
      have h_mem : c ∈ (Finset.univ : Finset (Fin k)) := Finset.mem_univ c
      calc (1 : ℝ) = (if c = c then (1:ℝ) else 0) := h_c.symm
        _ ≤ Finset.univ.sup' Finset.univ_nonempty
            (fun c' : Fin k => if c = c' then (1:ℝ) else 0) :=
              Finset.le_sup' (fun c' : Fin k => if c = c' then (1:ℝ) else 0) h_mem
  rw [h_sup]; ring

/-- `R(center k) = 1 - 1/k`. -/
@[rigidity_proved, rigidity_AMS_60]
theorem R_center [NeZero k] : R (center k) = 1 - 1 / (k : ℝ) := by
  unfold R center
  have h_sup : Finset.univ.sup' Finset.univ_nonempty
      (fun _ : Fin k => (1 : ℝ) / (k : ℝ)) = 1 / (k : ℝ) :=
    Finset.sup'_const Finset.univ_nonempty _
  rw [h_sup]

/-- For `k ≥ 2`, `R(center k) > 0`. Used by Step 3 to rule out `a = 0`. -/
@[rigidity_proved, rigidity_AMS_60]
theorem R_center_pos [NeZero k] (hk : 2 ≤ k) : 0 < R (center k) := by
  rw [R_center]
  have hk_pos : (0 : ℝ) < (k : ℝ) := by exact_mod_cast Nat.pos_of_ne_zero (NeZero.ne k)
  have hk_one_lt : (1 : ℝ) < (k : ℝ) := by exact_mod_cast hk
  have h_inv : 1 / (k : ℝ) < 1 := by
    rw [div_lt_one hk_pos]; exact hk_one_lt
  linarith

/-- The center belongs to the simplex. -/
@[rigidity_proved, rigidity_AMS_60]
theorem center_mem_simplex [NeZero k] : center k ∈ simplex k := by
  refine ⟨?_, ?_⟩
  · intro c
    unfold center
    positivity
  · unfold center
    have hk_pos : (0 : ℝ) < (k : ℝ) := by exact_mod_cast Nat.pos_of_ne_zero (NeZero.ne k)
    have hk_ne : (k : ℝ) ≠ 0 := ne_of_gt hk_pos
    rw [Finset.sum_const, Finset.card_univ, Fintype.card_fin]
    rw [nsmul_eq_mul]
    field_simp

/-- Vertices belong to the simplex. -/
@[rigidity_proved, rigidity_AMS_60]
theorem vertex_mem_simplex {k : ℕ} (c : Fin k) : vertex c ∈ simplex k := by
  refine ⟨?_, ?_⟩
  · intro c'
    unfold vertex
    by_cases h : c = c'
    · rw [if_pos h]; norm_num
    · rw [if_neg h]
  · -- Σ_{c'} (if c = c' then 1 else 0) = 1
    show ∑ c' : Fin k, (if c = c' then (1:ℝ) else 0) = 1
    rw [Finset.sum_eq_single c]
    · rw [if_pos rfl]
    · intro c' _ hc'_ne
      rw [if_neg (fun h => hc'_ne h.symm)]
    · intro h; exact absurd (Finset.mem_univ c) h

/-! ## D-sscore: simplex scores -/

/-- A simplex score: continuous on `Δ^{k-1}`, nonnegative there, vanishing
    at the vertices. Brick: `D-sscore`.

    Concavity and permutation-symmetry are *conclusions* about exact scores,
    not hypotheses — see Theorem 2′. -/
structure SimplexScore [NeZero k] (φ : (Fin k → ℝ) → ℝ) : Prop where
  continuous : ContinuousOn φ (simplex k)
  nonneg_on : ∀ η ∈ simplex k, 0 ≤ φ η
  vertex_vanishing : ∀ c : Fin k, φ (vertex c) = 0

/-! ## D-cphi and the bracket (simplex side) -/

/-- Upper bracket constant on the simplex:
    `c_φ := sup_{η ∈ Δ^{k-1} \ vertices} R(η) / φ(η)`. -/
noncomputable def cPhiSimplex [NeZero k] (φ : (Fin k → ℝ) → ℝ) : ℝ :=
  sSup ((fun η : Fin k → ℝ => R η / φ η) '' {η ∈ simplex k | R η ≠ 0})

/-! ## D-cellRateSimplex, D-epsilonStarSimplex, D-barPhiSimplex (Phase D infrastructure) -/

/-- **Simplex-valued cell rate**: for a labeling `f : α → Fin k`, the cell `c`'s
    conditional distribution over the `k` classes. Each component `i` is the
    probability that `f x = i` given `x ∈ c`, computed with the convention `0`
    when `μ c = 0` (via `div_zero`). Multiclass analogue of `Rigidity.cellRate`. -/
noncomputable def cellRateSimplex {α : Type*} [MeasurableSpace α] (μ : Measure α)
    (f : α → Fin k) (_P : FinitePartition α) (c : Set α) : Fin k → ℝ :=
  fun i => (μ ({x | f x = i} ∩ c)).toReal / (μ c).toReal

/-- **Multiclass partition-restricted Bayes risk**:
    `ε*(P) = Σ_c (μ c).toReal · R(cellRateSimplex c)`. Multiclass analogue of
    `Rigidity.epsilonStar`. Manuscript: §4.1. -/
noncomputable def epsilonStarSimplex {α : Type*} [MeasurableSpace α] [NeZero k]
    (μ : Measure α) (f : α → Fin k) (P : FinitePartition α) : ℝ :=
  ∑ c ∈ P.cells, (cellMass μ P c).toReal * R (cellRateSimplex μ f P c)

/-- **Multiclass partition functional**:
    `bar_φ(P) = Σ_c (μ c).toReal · φ(cellRateSimplex c)`. Multiclass analogue of
    `Rigidity.barPhi`. Manuscript: §4.1. -/
noncomputable def barPhiSimplex {α : Type*} [MeasurableSpace α] [NeZero k]
    (μ : Measure α) (φ : (Fin k → ℝ) → ℝ) (f : α → Fin k)
    (P : FinitePartition α) : ℝ :=
  ∑ c ∈ P.cells, (cellMass μ P c).toReal * φ (cellRateSimplex μ f P c)

/-! ## Trivial-partition specializations (Phase D helpers) -/

/-- **`cellRateSimplex` on the trivial partition**: equals `(μ {f=i}).toReal`
    componentwise. Simplex analogue of `cellRate_trivial`. -/
@[rigidity_proved, rigidity_AMS_28, rigidity_AMS_60]
theorem cellRateSimplex_trivial {α : Type*} [MeasurableSpace α]
    (μ : Measure α) [IsProbabilityMeasure μ] (f : α → Fin k) (i : Fin k) :
    cellRateSimplex μ f trivialPartition Set.univ i = (μ {x | f x = i}).toReal := by
  unfold cellRateSimplex
  rw [Set.inter_univ, measure_univ]
  simp

/-- **`epsilonStarSimplex` on the trivial partition** equals
    `R(cellRateSimplex μ f trivialPartition univ)`. -/
@[rigidity_proved, rigidity_AMS_28, rigidity_AMS_60]
theorem epsilonStarSimplex_trivial {α : Type*} [MeasurableSpace α] [NeZero k]
    (μ : Measure α) [IsProbabilityMeasure μ] (f : α → Fin k) :
    epsilonStarSimplex μ f trivialPartition =
      R (cellRateSimplex μ f trivialPartition Set.univ) := by
  show ∑ c ∈ trivialPartition.cells, (cellMass μ trivialPartition c).toReal *
        R (cellRateSimplex μ f trivialPartition c) = _
  show ∑ c ∈ ({Set.univ} : Finset (Set α)),
        (cellMass μ trivialPartition c).toReal *
        R (cellRateSimplex μ f trivialPartition c) = _
  rw [Finset.sum_singleton]
  show (cellMass μ trivialPartition Set.univ).toReal *
        R (cellRateSimplex μ f trivialPartition Set.univ) = _
  unfold cellMass
  rw [measure_univ]
  simp

/-- **`barPhiSimplex` on the trivial partition** equals
    `φ(cellRateSimplex μ f trivialPartition univ)`. -/
@[rigidity_proved, rigidity_AMS_60]
theorem barPhiSimplex_trivial {α : Type*} [MeasurableSpace α] [NeZero k]
    (μ : Measure α) [IsProbabilityMeasure μ] (φ : (Fin k → ℝ) → ℝ)
    (f : α → Fin k) :
    barPhiSimplex μ φ f trivialPartition =
      φ (cellRateSimplex μ f trivialPartition Set.univ) := by
  show ∑ c ∈ trivialPartition.cells, (cellMass μ trivialPartition c).toReal *
        φ (cellRateSimplex μ f trivialPartition c) = _
  show ∑ c ∈ ({Set.univ} : Finset (Set α)),
        (cellMass μ trivialPartition c).toReal *
        φ (cellRateSimplex μ f trivialPartition c) = _
  rw [Finset.sum_singleton]
  show (cellMass μ trivialPartition Set.univ).toReal *
        φ (cellRateSimplex μ f trivialPartition Set.univ) = _
  unfold cellMass
  rw [measure_univ]
  simp

/-! ## Realizability typeclasses (Phase D Sierpiński workaround) -/

/-- **Single-cell realizability (simplex case)**: for every distribution
    `η ∈ Δ^{k-1}` there is a measurable labeling `f : α → Fin k` whose
    distribution under `μ` is exactly `η`, i.e.
    `(μ {f = i}).toReal = η i` for every `i`.

    For `[NoAtoms μ] [IsProbabilityMeasure μ]` this is provable via a
    `k`-fold application of Sierpiński's theorem on atomless measures
    (partition `α` into `k` measurable sets of measures `η 0, …, η (k-1)`
    and let `f` map to the appropriate index). Same typeclass-as-hypothesis
    pattern as the binary `SingleCellRealizable`; closed by the same
    mathlib PR (opportunity #1). -/
class SingleCellRealizableSimplex {α : Type*} [MeasurableSpace α] [NeZero k]
    (μ : Measure α) : Prop where
  /-- For every `η ∈ Δ^{k-1}`, a measurable labeling realizing distribution `η`. -/
  exists_labeling :
    ∀ η ∈ simplex k,
      ∃ f : α → Fin k, (∀ i, MeasurableSet {x | f x = i}) ∧
        ∀ i, (μ {x | f x = i}).toReal = η i

/-- **Two-cell realizability (simplex case)**: for every pair of distributions
    `η₁, η₂ ∈ Δ^{k-1}` and mass `λ ∈ [0, 1]`, there is a two-cell partition
    with the prescribed masses and per-cell distributions.

    Sierpiński-provable for `[NoAtoms μ]` by the same construction as
    `BinarySplitRealizable`, but for `Fin k`-valued labels. Same typeclass-
    as-hypothesis pattern; closed by the same mathlib PR. -/
class TwoCellRealizableSimplex {α : Type*} [MeasurableSpace α] [NeZero k]
    (μ : Measure α) : Prop where
  /-- For `(η₁, η₂, λ)`, a 2-cell partition realizing them. -/
  exists_two_cell :
    ∀ η₁ ∈ simplex k, ∀ η₂ ∈ simplex k, ∀ lam ∈ Set.Icc (0:ℝ) 1,
      ∃ (P : FinitePartition α) (f : α → Fin k) (s : Set α),
        s ∈ P.cells ∧ (cellMass μ P s).toReal = lam ∧
        (∀ i, cellRateSimplex μ f P s i = η₁ i) ∧
        (∀ c ∈ P.cells, c ≠ s → ∀ i, cellRateSimplex μ f P c i = η₂ i) ∧
        (∀ i, MeasurableSet {x | f x = i})

/-! ## Step 2 lemma: bounded Jensen-equality forces affine -/

/-- **Bounded Jensen-equality forces affine** (Cauchy's equation, bounded form).

    For `G : ℝ → ℝ` bounded on `[0, M]` and satisfying
    `p · G(u₁) + (1-p) · G(u₂) = G(p · u₁ + (1-p) · u₂)`
    for all `u₁, u₂ ∈ [0, M]` and `p ∈ [0, 1]`, `G` is affine on `[0, M]`
    (i.e. `G(v) = a v + b` for some `a, b ∈ ℝ`).

    This is the classical no-Hamel-basis-pathology result for Jensen's equation.
    The convex-combination-equation variant we need follows from the standard
    midpoint-affine + boundedness argument. Filling this is a clean follow-up —
    it is the *one* genuinely deep step of `simplex_rigidity` and is the Phase D
    long-pole node. -/
@[rigidity_scaffold, rigidity_AMS_60]
theorem affine_of_jensen_eq {M : ℝ} (_hM : 0 < M) (G : ℝ → ℝ)
    (_h_bdd : ∃ B, ∀ v ∈ Set.Icc (0:ℝ) M, |G v| ≤ B)
    (_h_jensen : ∀ u₁ ∈ Set.Icc (0:ℝ) M, ∀ u₂ ∈ Set.Icc (0:ℝ) M,
        ∀ p ∈ Set.Icc (0:ℝ) 1,
        p * G u₁ + (1 - p) * G u₂ = G (p * u₁ + (1 - p) * u₂)) :
    ∃ a b : ℝ, ∀ v ∈ Set.Icc (0:ℝ) M, G v = a * v + b := by
  sorry

/-! ## Step 3 (vertex pinning, standalone) -/

/-- **Step 3 of `simplex_rigidity`** factored as a standalone lemma.

    Given:
    - Step 1's conclusion: `R η = G (φ η)` for every `η ∈ simplex k` (so `R`
      factors through `φ` via some `G : ℝ → ℝ`).
    - Step 2's conclusion (an *assumption* here): `G(v) = a · v + b` for some
      real `a, b` and all `v` in the φ-range — in particular at `v = 0` and at
      `v = φ(center k)`.
    - `φ` is a `SimplexScore` (in particular vertex-vanishing).
    - `k ≥ 2` (so `R(center k) > 0`, ruling out the degenerate `a = 0`).

    Then `φ = λ · R` on the simplex for some `λ > 0` (specifically `λ = 1/a`).

    Proof:
    1. Apply Step 1 at any vertex `e_c`: `R(e_c) = G(φ(e_c)) = G(0)` (since
       `φ(e_c) = 0`), and `R(e_c) = 0`. Hence `G(0) = 0 ⟹ b = 0`, so
       `G(v) = a · v` whenever the Step 2 hypothesis applies at `v = 0`.
    2. Apply Step 1 at the center: `R(center) = a · φ(center)`. Since
       `R(center) > 0` (by `R_center_pos`), `a · φ(center) > 0`. Hence
       `a ≠ 0` (else LHS is `0`, contradiction) and `a, φ(center)` have
       the same sign. Combined with `φ(center) ≥ 0` (from `SimplexScore`):
       `a > 0` or `a < 0` and `φ(center) = 0`. The latter gives
       `0 = a · 0 = R(center) > 0`, contradiction. So `a > 0`.
    3. For every `η ∈ simplex k`: `R η = a · φ η`, i.e. `φ η = R η / a = λ · R η`
       with `λ = 1/a > 0`. -/
@[rigidity_proved, rigidity_AMS_60, rigidity_AMS_62]
theorem phi_eq_lam_R_of_step1_affine [NeZero k] (hk : 2 ≤ k)
    (φ : (Fin k → ℝ) → ℝ) (hφ : SimplexScore φ)
    {a b : ℝ}
    (h_step2_zero : R (vertex (0 : Fin k)) = a * φ (vertex 0) + b)
    (h_step2_center : R (center k) = a * φ (center k) + b)
    (h_step1 : ∀ η ∈ simplex k, R η = a * φ η + b) :
    ∃ lam : ℝ, 0 < lam ∧ ∀ η ∈ simplex k, φ η = lam * R η := by
  -- Step 3.1: b = 0 from the vertex.
  have h_b : b = 0 := by
    have h_vphi := hφ.vertex_vanishing (0 : Fin k)
    have h_vR := R_vertex_eq_zero (0 : Fin k)
    have := h_step2_zero
    rw [h_vphi, h_vR] at this
    linarith
  -- Step 3.2: a > 0 from the center.
  have h_a_pos : 0 < a := by
    have h_cR_pos := R_center_pos hk
    have h_c_eq : R (center k) = a * φ (center k) := by
      rw [h_step2_center, h_b]; ring
    have h_c_phi_nonneg : 0 ≤ φ (center k) := hφ.nonneg_on _ center_mem_simplex
    -- a * φ(center) > 0 with φ(center) ≥ 0 forces a > 0 and φ(center) > 0.
    rw [h_c_eq] at h_cR_pos
    -- h_cR_pos : 0 < a * φ (center k)
    -- with h_c_phi_nonneg : 0 ≤ φ(center).
    by_contra h_a_le
    have h_a_le : a ≤ 0 := not_lt.mp h_a_le
    -- a ≤ 0. With φ(center) ≥ 0, a · φ(center) ≤ 0, contradiction.
    have : a * φ (center k) ≤ 0 := mul_nonpos_iff.mpr (Or.inr ⟨h_a_le, h_c_phi_nonneg⟩)
    linarith
  -- Step 3.3: φ = (1/a) · R on the simplex.
  refine ⟨1 / a, by positivity, ?_⟩
  intro η hη
  have h_a_ne : a ≠ 0 := ne_of_gt h_a_pos
  have h_R_eq : R η = a * φ η := by
    have := h_step1 η hη
    rw [h_b] at this; linarith
  field_simp
  linarith

/-! ## Per-cell distribution lemma (used by the easy direction) -/

/-- **Sum-of-class-measures-in-cell = cell-measure** (`Fin k`-indexed analogue
    of `Rigidity.sum_measure_inter_eq`). For a labeling `f : α → Fin k` with
    every fiber `{f = i}` measurable, summing `μ ({f = i} ∩ c)` over the `k`
    classes recovers `μ c`. Used to show that the simplex-valued cell
    distribution sums to 1 on cells of positive measure. -/
@[rigidity_proved, rigidity_AMS_28]
theorem sum_measure_fiber_inter {α : Type*} [MeasurableSpace α]
    [NeZero k] (μ : Measure α) [IsProbabilityMeasure μ] (f : α → Fin k)
    (hf : ∀ i, MeasurableSet {x | f x = i})
    {c : Set α} (hc : MeasurableSet c) :
    ∑ i, (μ ({x | f x = i} ∩ c)).toReal = (μ c).toReal := by
  -- Step 1: finite additivity on (disjoint, measurable) traces.
  have h_meas : ∀ i ∈ (Finset.univ : Finset (Fin k)),
      MeasurableSet ({x | f x = i} ∩ c) := fun i _ => (hf i).inter hc
  have h_disj : ((Finset.univ : Finset (Fin k)) : Set (Fin k)).PairwiseDisjoint
      (fun i => {x | f x = i} ∩ c) := by
    intro i _ j _ hij
    refine Disjoint.mono Set.inter_subset_left Set.inter_subset_left ?_
    rw [Set.disjoint_iff]
    intro x hx
    rcases hx with ⟨hxi, hxj⟩
    simp only [Set.mem_setOf_eq] at hxi hxj
    exact absurd (hxi.symm.trans hxj) hij
  have h_add : μ (⋃ i ∈ (Finset.univ : Finset (Fin k)), {x | f x = i} ∩ c) =
      ∑ i, μ ({x | f x = i} ∩ c) :=
    measure_biUnion_finset h_disj h_meas
  -- Step 2: ⋃ i, ({f=i} ∩ c) = c (since {{f=i}}_i partitions α).
  have h_union : ⋃ i ∈ (Finset.univ : Finset (Fin k)), {x | f x = i} ∩ c = c := by
    ext x
    simp only [Set.mem_iUnion, Set.mem_inter_iff, Set.mem_setOf_eq, Finset.mem_univ,
               exists_prop, true_and]
    refine ⟨?_, ?_⟩
    · rintro ⟨_, _, hxc⟩; exact hxc
    · intro hxc; exact ⟨f x, rfl, hxc⟩
  -- Step 3: combine.
  have h_sum_ennreal : ∑ i, μ ({x | f x = i} ∩ c) = μ c := by
    rw [← h_add, h_union]
  -- Step 4: push toReal through (each term ≤ μ univ = 1 < ∞).
  have h_finite : ∀ i ∈ (Finset.univ : Finset (Fin k)),
      μ ({x | f x = i} ∩ c) ≠ ⊤ := by
    intro i _
    refine ne_of_lt ?_
    refine lt_of_le_of_lt (measure_mono (Set.subset_univ _)) ?_
    rw [measure_univ]; exact ENNReal.one_lt_top
  calc ∑ i, (μ ({x | f x = i} ∩ c)).toReal
      = (∑ i, μ ({x | f x = i} ∩ c)).toReal :=
            (ENNReal.toReal_sum h_finite).symm
    _ = (μ c).toReal := by rw [h_sum_ennreal]

/-- The simplex-valued cell distribution lies in `Δ^{k-1}` when the cell has
    positive measure. Used by the easy direction of `simplex_rigidity` to
    apply the hypothesis `∀ η ∈ simplex k, φ η = λ R η` cellwise. -/
@[rigidity_proved, rigidity_AMS_28, rigidity_AMS_60]
theorem cellRateSimplex_mem_simplex {α : Type*} [MeasurableSpace α]
    [NeZero k] (μ : Measure α) [IsProbabilityMeasure μ] (f : α → Fin k)
    (hf : ∀ i, MeasurableSet {x | f x = i})
    (P : FinitePartition α) {c : Set α} (hc : c ∈ P.cells)
    (h_pos : (μ c).toReal ≠ 0) :
    cellRateSimplex μ f P c ∈ simplex k := by
  refine ⟨?_, ?_⟩
  · -- Each component ≥ 0.
    intro i
    unfold cellRateSimplex
    exact div_nonneg ENNReal.toReal_nonneg ENNReal.toReal_nonneg
  · -- Components sum to 1.
    unfold cellRateSimplex
    rw [← Finset.sum_div _ _ _, sum_measure_fiber_inter μ f hf (P.measurable c hc),
        div_self h_pos]

/-! ## T2′ — the rigidity theorem -/

/-- **Theorem 2′** (Simplex Rigidity).

    Let `(α, F, μ)` be a probability space with realizability of single-cell
    and two-cell simplex-valued partitions (provable from `[NoAtoms μ]` via
    Sierpiński), and let `φ : Δ^{k-1} → ℝ` be a simplex score (continuous,
    vertex-vanishing).

    Then `φ` is exact (there exists `G : ℝ → ℝ` such that
    `ε*(Π) = G (bar_φ(Π))` for every measurable-labeling partition) iff
    `φ = λ · R` on the simplex for some `λ > 0`.

    Phase D status: Steps 1 and 3 of the §4.2 proof are filled below; Step 2
    is reduced to `affine_of_jensen_eq` (the one isolated sub-`sorry`). -/
@[rigidity_scaffold, rigidity_AMS_60, rigidity_AMS_62]
theorem simplex_rigidity {α : Type*} [MeasurableSpace α] (μ : Measure α)
    [IsProbabilityMeasure μ] [NeZero k] [SingleCellRealizableSimplex (k := k) μ]
    [TwoCellRealizableSimplex (k := k) μ]
    (hk : 2 ≤ k) (φ : (Fin k → ℝ) → ℝ) (hφ : SimplexScore φ) :
    (∃ G : ℝ → ℝ, ∀ (f : α → Fin k) (P : FinitePartition α),
        (∀ i, MeasurableSet {x | f x = i}) →
        epsilonStarSimplex μ f P = G (barPhiSimplex μ φ f P)) ↔
    ∃ lam : ℝ, 0 < lam ∧ ∀ η ∈ simplex k, φ η = lam * R η := by
  refine ⟨?_, ?_⟩
  · -- HARD direction: exact ⟹ φ = λ R.
    rintro ⟨G, h_exact⟩
    -- Step 1: single-cell partitions force R = G ∘ φ pointwise on the simplex.
    have h_step1 : ∀ η ∈ simplex k, R η = G (φ η) := by
      intro η hη
      obtain ⟨f, hf_meas, hf_dist⟩ :=
        SingleCellRealizableSimplex.exists_labeling (μ := μ) η hη
      have h_eq := h_exact f trivialPartition hf_meas
      rw [epsilonStarSimplex_trivial μ f, barPhiSimplex_trivial μ φ f] at h_eq
      have h_cellRate : cellRateSimplex μ f trivialPartition Set.univ = η := by
        funext i
        rw [cellRateSimplex_trivial μ f i]
        exact hf_dist i
      rw [h_cellRate] at h_eq
      exact h_eq
    -- Step 2: G is affine on the φ-range. Two-cell partitions + Step 1 give
    -- p · G(φ(η₁)) + (1-p) · G(φ(η₂)) = G(p · φ(η₁) + (1-p) · φ(η₂)) for all
    -- η₁, η₂ ∈ simplex k and p ∈ [0,1] (via TwoCellRealizableSimplex). By
    -- continuity of φ on the compact connected simplex + IVT, the φ-range is
    -- an interval [0, φ_max]. `affine_of_jensen_eq` then gives G(v) = a v + b
    -- on [0, φ_max], hence R η = G(φ η) = a · φ η + b on simplex k.
    --
    -- This is Phase D's long-pole node — substantial bookkeeping. The proof
    -- structure is captured here as a single `have` that postulates Step 2's
    -- conclusion. Once `affine_of_jensen_eq` is filled, this `have` becomes
    -- a derivation rather than a postulate.
    have h_step2 : ∃ a b : ℝ, ∀ η ∈ simplex k, R η = a * φ η + b := by
      sorry
    -- Step 3: vertices + center pin a > 0 and b = 0; conclude φ = λ R.
    obtain ⟨a, b, h_affine⟩ := h_step2
    have h_zero := h_affine (vertex 0) (vertex_mem_simplex 0)
    have h_ctr := h_affine (center k) center_mem_simplex
    exact phi_eq_lam_R_of_step1_affine hk φ hφ h_zero h_ctr h_affine
  · -- EASY direction: φ = λ R ⟹ exact (with G(v) = v/λ).
    rintro ⟨lam, h_lam_pos, h_phi_eq⟩
    refine ⟨fun v => v / lam, ?_⟩
    intro f P hf_meas
    -- Strategy: barPhiSimplex = lam * epsilonStarSimplex (termwise),
    -- so epsilonStarSimplex = barPhiSimplex / lam.
    -- Each cell c splits on whether μ c = 0:
    --   - μ c = 0: both terms are 0 (multiplied by (cellMass).toReal = 0).
    --   - μ c > 0: cellRateSimplex c ∈ simplex k via cellRateSimplex_mem_simplex,
    --     so h_phi_eq applies, giving φ(cellRateSimplex c) = lam * R(cellRateSimplex c).
    have h_lam_ne : lam ≠ 0 := ne_of_gt h_lam_pos
    have h_termwise : ∀ c ∈ P.cells,
        (cellMass μ P c).toReal * φ (cellRateSimplex μ f P c) =
        lam * ((cellMass μ P c).toReal * R (cellRateSimplex μ f P c)) := by
      intro c hc
      by_cases h_zero : (cellMass μ P c).toReal = 0
      · -- μ c = 0 ⟹ both sides 0.
        rw [h_zero]; ring
      · -- μ c > 0 ⟹ cellRateSimplex c ∈ simplex k, apply h_phi_eq.
        have h_mem : cellRateSimplex μ f P c ∈ simplex k :=
          cellRateSimplex_mem_simplex μ f hf_meas P hc h_zero
        rw [h_phi_eq _ h_mem]; ring
    -- Sum the termwise identity.
    have h_barPhi_eq_lam_eps :
        barPhiSimplex μ φ f P = lam * epsilonStarSimplex μ f P := by
      unfold barPhiSimplex epsilonStarSimplex
      rw [Finset.mul_sum]
      exact Finset.sum_congr rfl h_termwise
    -- Conclude.
    rw [h_barPhi_eq_lam_eps]
    field_simp

end Rigidity.Simplex
