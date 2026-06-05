import Mathlib.Analysis.SpecialFunctions.Pow.Real
import Mathlib.Analysis.SpecialFunctions.Sqrt
import Rigidity.Bracket
import Rigidity.Util.Attributes

/-!
# Proposition 6 — two-query identity + variance bracket

For a uniform draw `X` of a node and `X'` a uniform draw from the same cell
`Π(X)`, the cross-cell disagreement probability satisfies

  `p_dis := P[f(X) ≠ f(X')] = 2 · E[Var(f | Π)]`,

and the bracket of the normalized variance `φ_var(η) = 4η(1-η)` reads in this
one observable:

  `(1 - √(1 - 2 p_dis)) / 2 ≤ ε*(Π) ≤ p_dis`.

## Provenance

* Manuscript: §7 Proposition 6.
* Defining commit: `15729f6` (normalized-variance convention throughout the proof,
  m-3 of audit 05).
* Brick: `P6`. Mandatory kernel target.

Phase A scaffold: statement present; proof `sorry`. Phase C2 will land:
* Conditioned on cell i, two independent draws disagree with prob `2 ηᵢ(1-ηᵢ)`.
* Average over cells: `p_dis = Σ pᵢ · 2 ηᵢ (1 - ηᵢ) = 2 E[Var(f | Π)]`.
* With `φ_var(η) = 4η(1-η)` from §2: `bar φ_var = 2 p_dis`, so the universal
  `c_φ = 1/2` bracket (Theorem T-bracket) reads
  `φ_var⁻¹(2 p_dis) ≤ ε* ≤ p_dis`; solving `4η(1-η) = 2 p_dis` on [0, 1/2]
  gives the lower endpoint.
-/

namespace Rigidity

open MeasureTheory Real

variable {α : Type*} [MeasurableSpace α] (μ : Measure α)

/-- Probability that two independent draws from the same cell disagree on `f`.
    -/
noncomputable def pDisagree (f : α → Bool) (P : FinitePartition α) : ℝ :=
  ∑ c ∈ P.cells,
    (cellMass μ P c).toReal *
      (2 * cellRate μ f P c * (1 - cellRate μ f P c))

/-- **Proposition 6** (two-query identity). The cross-cell disagreement
    probability equals `2 · E[Var(f | Π)]`. The expression in `pDisagree`
    contains a per-cell factor `2 · ηᵢ · (1 - ηᵢ)`; this identity pulls
    the constant `2` out of the sum. Pure `Finset.sum` arithmetic. -/
@[rigidity_proved, rigidity_AMS_60]
theorem two_query_identity (f : α → Bool) (P : FinitePartition α) :
    pDisagree μ f P =
      2 * ∑ c ∈ P.cells,
        (cellMass μ P c).toReal *
          (cellRate μ f P c * (1 - cellRate μ f P c)) := by
  unfold pDisagree
  rw [Finset.mul_sum]
  apply Finset.sum_congr rfl
  intro c _
  ring

/-- The normalized variance score: `φ_var(η) = 4η(1-η)`. Manuscript §2 ¶3. -/
noncomputable def phiVar : ℝ → ℝ := fun η => 4 * η * (1 - η)

/-- `phiVar` is a normalized score. The seven NormalizedScore fields:
    concave (since `-4η² + 4η` is a downward parabola), continuous (polynomial),
    symmetric (`4η(1-η) = 4(1-η)η`), vanishes at 0 and 1, equals 1 at 1/2,
    strict_mono on `[0, 1/2]` (since `dφ/dη = 4 - 8η > 0` there). -/
@[rigidity_proved, rigidity_AMS_60]
theorem phiVar_normalized : NormalizedScore phiVar := by
  refine ⟨?_, ?_, ?_, ?_, ?_, ?_, ?_⟩
  · -- concave_on: 4η(1-η) = -(2η - 1)² + 1, a downward parabola.
    -- Use the inner-product characterization: f is concave iff for x,y in s
    -- and 0 ≤ a, 0 ≤ b, a+b = 1, a•f x + b•f y ≤ f (a•x + b•y).
    unfold phiVar
    refine ⟨convex_Icc _ _, ?_⟩
    intro x _ y _ a b ha hb hab
    -- Direct: 4·(ax+by)·(1 - (ax+by)) - [a·4x(1-x) + b·4y(1-y)] = 4ab(x-y)² ≥ 0.
    simp only [smul_eq_mul]
    -- Eliminate b using a + b = 1 to give nlinarith concrete coefficients.
    have hb_eq : b = 1 - a := by linarith
    subst hb_eq
    nlinarith [sq_nonneg (x - y), ha, hb, mul_nonneg ha hb]
  · -- continuous: polynomial 4η(1-η).
    unfold phiVar
    have h_cont : Continuous (fun η : ℝ => 4 * η * (1 - η)) := by
      exact (continuous_const.mul continuous_id).mul
            (continuous_const.sub continuous_id)
    exact h_cont.continuousOn
  · -- symmetric: 4η(1-η) = 4(1-η)(1 - (1-η)) = 4(1-η)η.
    intro η _
    unfold phiVar
    ring
  · -- vanishes_at_zero: 4·0·(1-0) = 0.
    unfold phiVar; ring
  · -- vanishes_at_one: 4·1·(1-1) = 0.
    unfold phiVar; ring
  · -- unit_at_half: 4·(1/2)·(1 - 1/2) = 1.
    unfold phiVar; norm_num
  · -- strict_mono on [0, 1/2]: η < η' ⟹ 4η(1-η) < 4η'(1-η').
    intro η hη η' hη' hlt
    unfold phiVar
    obtain ⟨hη_pos, hη_le⟩ := hη
    obtain ⟨hη'_pos, hη'_le⟩ := hη'
    -- Difference: 4η'(1-η') - 4η(1-η) = 4(η' - η)(1 - η - η') > 0 since η' > η and η + η' < 1.
    nlinarith [hlt, hη_pos, hη'_pos, hη_le, hη'_le]

/-- Specialization: `barPhi μ phiVar f P = 2 · pDisagree μ f P`. Pure `Finset`
    arithmetic — each term `pᵢ · φ_var(ηᵢ) = pᵢ · 4ηᵢ(1-ηᵢ) = 2 · pᵢ · 2ηᵢ(1-ηᵢ)`
    matches `pDisagree`'s per-cell shape times 2. -/
@[rigidity_proved, rigidity_AMS_60]
theorem barPhi_phiVar_eq_two_pDisagree (f : α → Bool) (P : FinitePartition α) :
    barPhi μ phiVar f P = 2 * pDisagree μ f P := by
  unfold barPhi pDisagree phiVar
  rw [Finset.mul_sum]
  apply Finset.sum_congr rfl
  intro c _
  ring

/-- **Variance bracket** (Proposition 6 corollary): the achievable floor is
    bracketed by a closed-form function of the single observable `p_dis`.

    Lower endpoint: `(1 - √(1 - 2·p_dis))/2 ≤ ε*`. From `bracket_lower` at
    `φ_var`: `barPhi = 2·p_dis ≤ φ_var(ε*) = 4·ε*·(1-ε*)`, hence
    `4·ε*² - 4·ε* + 2·p_dis ≤ 0`, and the lower root of the quadratic is
    `(1 - √(1 - 2·p_dis))/2`. Since `ε* ≤ 1/2` (proved), it's the lower root.

    Upper endpoint: `ε* ≤ p_dis`. From `bracket_upper` at `φ_var` with
    `cPhi φ_var = 1/2`: `ε* ≤ (1/2) · barPhi = (1/2) · (2·p_dis) = p_dis`. -/
@[rigidity_proved, rigidity_AMS_60, rigidity_AMS_62]
theorem variance_bracket [IsProbabilityMeasure μ] (f : α → Bool) (P : FinitePartition α) :
    (1 - Real.sqrt (1 - 2 * pDisagree μ f P)) / 2 ≤ epsilonStar μ f P ∧
    epsilonStar μ f P ≤ pDisagree μ f P := by
  -- Abbreviate the cell-Bayes risk and disagreement probability.
  set ε := epsilonStar μ f P with hε_def
  set d := pDisagree μ f P with hd_def
  -- Apply the two bracket lemmas at phiVar.
  have h_lower := bracket_lower μ phiVar phiVar_normalized f P
  have h_upper := bracket_upper μ phiVar phiVar_normalized f P
  -- Rewrite via the barPhi/cPhi specializations.
  have h_barPhi : barPhi μ phiVar f P = 2 * d := barPhi_phiVar_eq_two_pDisagree μ f P
  have h_cPhi : cPhi phiVar = 1/2 := cPhi_eq_half_of_normalized phiVar phiVar_normalized
  rw [h_barPhi] at h_lower h_upper
  rw [h_cPhi] at h_upper
  -- h_lower : 2 * d ≤ phiVar ε
  -- h_upper : ε ≤ (1/2) * (2 * d) = d
  -- ε ∈ [0, 1/2] from B3a helpers.
  have hε_nonneg : 0 ≤ ε := epsilonStar_nonneg μ f P
  have hε_le_half : ε ≤ 1/2 := epsilonStar_le_half μ f P
  refine ⟨?_, ?_⟩
  · -- LOWER endpoint: (1 - √(1 - 2d))/2 ≤ ε.
    -- From h_lower: 2d ≤ phiVar ε = 4ε(1-ε), i.e. 4ε² - 4ε + 2d ≤ 0.
    -- Hence (2ε - 1)² ≤ 1 - 2d, and since ε ≤ 1/2 so (1 - 2ε) ≥ 0,
    -- (1 - 2ε)² ≤ 1 - 2d, hence 1 - 2ε ≤ √(1 - 2d) by Real.le_sqrt_of_sq_le.
    -- Solving for ε: ε ≥ (1 - √(1 - 2d))/2.
    unfold phiVar at h_lower
    -- h_lower : 2 * d ≤ 4 * ε * (1 - ε)
    -- Step 1: (1 - 2ε)² ≤ 1 - 2d.
    have h_sq : (1 - 2 * ε)^2 ≤ 1 - 2 * d := by nlinarith [h_lower]
    -- Step 2: 0 ≤ 1 - 2ε.
    have h_nonneg : 0 ≤ 1 - 2 * ε := by linarith
    -- Step 3: 1 - 2ε ≤ √(1 - 2d).
    have h_sqrt : 1 - 2 * ε ≤ Real.sqrt (1 - 2 * d) :=
      Real.le_sqrt_of_sq_le h_sq
    -- Step 4: ε ≥ (1 - √(1 - 2d))/2.
    linarith
  · -- UPPER endpoint: ε ≤ d.
    -- h_upper : ε ≤ (1/2) * (2 * d) = d.
    linarith

end Rigidity
