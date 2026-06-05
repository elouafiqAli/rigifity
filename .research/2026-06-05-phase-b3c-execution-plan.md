# Phase B3c — execution plan + proof strategy for `theorem2_reverse`

**Phase**: B3c
**Status**: **closed** — proved in commit on 2026-06-05 (theorem2_reverse + theorem2 both `@[rigidity_proved]`, 23/23 audit clean)
**First raised**: 2026-06-05
**Last updated**: 2026-06-05

## The question

The two outstanding sub-`sorry`s inside `theorem2_reverse` need to be filled.
The structure was sketched in commit `bcabee7`; this file holds the proof
strategy at the level of detail needed to execute it without re-deriving.

## State before B3c

**21 proved theorems**, audit-clean. The skeleton of `theorem2_reverse` is:

```lean
theorem theorem2_reverse μ φ h h_exact : Set.EqOn φ tent (Icc 0 1) := by
  intro η hη
  rcases eq_or_lt_of_le hη.1 with hη_zero | hη_pos
  · -- η = 0: CLOSED (uses h.vanishes_at_zero)
    rw [← hη_zero, h.vanishes_at_zero]; unfold tent; simp
  · rcases le_or_gt η (1/2) with hη_half | hη_half
    · sorry  -- sub-sorry #1: η ∈ (0, 1/2] pinning
    · sorry  -- sub-sorry #2: η ∈ (1/2, 1] symmetry
```

## Sources consulted

- Sample-repo cross-reference: `.samples/pfr/PFR/ImprovedExponent.lean` for
  the "specialize identity at a chosen value, deduce constant" pattern (Tao
  uses this repeatedly in the polynomial Freiman-Ruzsa proof).
- `.research/2026-06-05-sierpinski-atomless-realizability.md` for the
  realizability typeclass `SingleCellRealizable μ` we're consuming.
- Existing helpers in `Bracket.lean` and `Theorem2.lean`:
  - `cellRate_trivial_boolIndicator`, `barPhi_trivial_boolIndicator`,
    `epsilonStar_trivial_boolIndicator` (computed-on-trivial-partition values)
  - `cPhi_eq_half_of_normalized` — wait, this assumes `NormalizedScore φ` and
    derives `cPhi φ = 1/2`. **Critical realization**: we already have this!
    The reverse direction does NOT need to re-derive `cPhi φ = 1/2` because
    `h : NormalizedScore φ` is a hypothesis.

## Findings

The proof is actually shorter than the commit message claimed. We don't need
to derive `cPhi φ = 1/2` via the bracket equation — it's a *consequence* of
`NormalizedScore φ` alone (proved in B1 as `cPhi_eq_half_of_normalized`).

So sub-sorry #1 simplifies to:

```
η ∈ (0, 1/2], realize η via SingleCellRealizable as (μ s).toReal.
Apply h_exact at (boolIndicator s, trivialPartition):
  bracket eqn 2: epsilonStar = cPhi φ * barPhi
              ⟹ min η (1-η) = cPhi φ * φ(η)
              ⟹ η = cPhi φ * φ(η)        (η ≤ 1/2 ⟹ min = η)
              ⟹ η = (1/2) * φ(η)        (cPhi φ = 1/2)
              ⟹ φ(η) = 2η = tent(η)
```

And sub-sorry #2:
```
η ∈ (1/2, 1]. h.symmetric η hη : φ η = φ (1 - η).
Then 1 - η ∈ [0, 1/2] (specifically ∈ [0, 1/2)) so the (0, 1/2] case applies
to (1 - η) yielding φ(1 - η) = 2(1 - η).
tent symmetry: tent η = tent (1 - η) = 2(1 - η). So φ η = tent η.
```

## Strategic decision

Extract a `private lemma phi_eq_two_eta_on_Ioc_zero_half` that handles the
η ∈ (0, 1/2] case in isolation. Then `theorem2_reverse` becomes:
- η = 0: direct (already done).
- η ∈ (0, 1/2]: apply the private lemma.
- η ∈ (1/2, 1]: rewrite via `h.symmetric`, reduce to (0, 1/2) via aux lemma,
  match against `tent η = tent (1 - η)` (which holds for tent definitionally).

## Open follow-ups

- Execute the plan; commit as Phase B3c.
- After B3c lands, `theorem2_reverse` becomes `@[rigidity_proved]` and so
  does `theorem2` (the iff glue). Audit count goes from 21 → 23.
- `[opportunity]` After B3c, the only theorem-level scaffolds left in the
  binary-rigidity layer are absent. Re-evaluate Phase B4 (Proposition 6)
  priority vs. Phase C (Theorem 1).

## Detailed proof skeleton (for direct insertion)

```lean
/-- For normalized φ on a probability space with realizable single-cell
    rates, φ(η) = 2η on (0, 1/2]. Used by theorem2_reverse. -/
private lemma phi_eq_two_eta_on_Ioc_zero_half {α : Type*} [MeasurableSpace α]
    (μ : Measure α) [IsProbabilityMeasure μ] [SingleCellRealizable μ]
    (φ : ℝ → ℝ) (h : NormalizedScore φ)
    (h_exact : ∀ (f : α → Bool) (P : FinitePartition α),
        barPhi μ φ f P = φ (epsilonStar μ f P) ∧
        epsilonStar μ f P = cPhi φ * barPhi μ φ f P)
    {η : ℝ} (hη_pos : 0 < η) (hη_le : η ≤ 1/2) :
    φ η = 2 * η := by
  -- Realize η.
  obtain ⟨s, hs_meas, hs_eq⟩ :=
    SingleCellRealizable.exists_set_of_measure_eq η ⟨le_of_lt hη_pos, hη_le⟩
  -- Apply bracket eqn 2.
  obtain ⟨_, h2⟩ := h_exact (boolIndicator s) trivialPartition
  rw [barPhi_trivial_boolIndicator μ φ hs_meas,
      epsilonStar_trivial_boolIndicator μ hs_meas, hs_eq] at h2
  -- min η (1-η) = η since η ≤ 1/2.
  rw [min_eq_left (by linarith : η ≤ 1 - η)] at h2
  -- cPhi φ = 1/2.
  rw [cPhi_eq_half_of_normalized φ h] at h2
  -- h2 : η = (1/2) * φ η.  Solve for φ η.
  linarith
```

Then `theorem2_reverse` reduces to ~12 lines combining η=0 / (0,1/2] /
(1/2,1] cases.
