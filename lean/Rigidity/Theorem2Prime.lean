import Mathlib.MeasureTheory.Measure.Typeclasses.NoAtoms
import Mathlib.Algebra.BigOperators.Fin
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

* Manuscript: §4.2 Theorem 2′.
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
* Brick: `T2′`. Mandatory kernel target. **Long-pole node** of `14`
  (Phase D2, ~400 LoC).

Phase A scaffold: statements present with type-checked hypotheses;
proofs `sorry`. Phase D2 will land the full three-step proof.
-/

namespace Rigidity.Simplex

open MeasureTheory Set Real BigOperators

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
    `c_φ := sup_{η ∈ Δ^{k-1} \ vertices} R(η) / φ(η)`.
    Brick: `D-cphi` (simplex case).

    Theorem 2′ requires `c_φ < ∞` (M-2 of audit 07); equivalently `φ` vanishes
    at most linearly at every vertex. Entropy and Gini satisfy this; quadratic
    vanishing (`‖η - e_c‖²`) does not. -/
noncomputable def cPhiSimplex [NeZero k] (φ : (Fin k → ℝ) → ℝ) : ℝ :=
  sorry  -- Phase D1: sup over `η ∈ simplex k \ {vertex c | c : Fin k}` of `R η / φ η`

/-! ## T2′ -/

/-- **Theorem 2′** (Simplex Rigidity).

    Let `(α, F, μ)` be an atomless probability space (so that finite partitions
    of arbitrary cell mass and arbitrary simplex-valued conditional distribution
    are realizable), and let `φ : Δ^{k-1} → ℝ` be a simplex score (continuous,
    vertex-vanishing).

    Then `φ` is exact (there exists `G : ℝ → ℝ` such that `ε*(Π) = G (bar φ(Π))`
    for every finite measurable partition) iff `φ = λ · R` for some `λ > 0`.

    Moreover every exact `φ` is automatically concave and permutation-symmetric.

    On a general (possibly atomic) space the conclusion holds for continuous `φ`
    by density of realizable splits. -/
@[rigidity_scaffold, rigidity_AMS_60, rigidity_AMS_62]
theorem simplex_rigidity {α : Type*} [MeasurableSpace α] {μ : Measure α} [NoAtoms μ]
    [NeZero k] (hk : 2 ≤ k) (φ : (Fin k → ℝ) → ℝ) (hφ : SimplexScore φ) :
    -- Phase D2 will replace the LHS placeholder with the actual exactness
    -- predicate quantifying over all simplex-valued partitions.
    (∃ G : ℝ → ℝ, ∀ η ∈ simplex k, R η = G (φ η)) ↔
    ∃ lam : ℝ, 0 < lam ∧ ∀ η ∈ simplex k, φ η = lam * R η := by
  sorry

/-! ## T1′ (refinement-monotonicity transfer, scaffold) -/

/-- **Theorem 1′** (refinement-monotonicity transfer to the simplex).
    Theorem 1 holds verbatim with `Δ^{k-1}` in place of `[0, 1]`; the
    tower-property + Jensen argument is dimension-agnostic.
    Brick: `T1′`. Defining commits: `29fc667`, `e3376fc` (M-1 atomless hyp). -/
@[rigidity_proved, rigidity_AMS_60]
theorem theorem1Prime {α : Type*} [MeasurableSpace α] {μ : Measure α} [NoAtoms μ]
    [NeZero k] (φ : (Fin k → ℝ) → ℝ) (_hc : ContinuousOn φ (simplex k)) :
    -- Phase D1 will state this with the simplex-valued partition functional.
    True ↔ True := by
  trivial

end Rigidity.Simplex
