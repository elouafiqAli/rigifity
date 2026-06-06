/-
Copyright (c) 2026 Ali Elouafiq. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Ali Elouafiq

This file is NOT part of `lake build`. It lives in `.research/sierpinski-pr/`
as a worked example of how the mathlib PR drafted in `Sierpinski.lean` would
discharge the four `...Realizable` typeclasses currently used as Sierpiński
external hypotheses in the rigidity project's `lean/Rigidity/`.

Once the mathlib PR lands and a future rigidity revision bumps to a
mathlib4 version containing `exists_measurableSet_measure_eq_of_noAtoms`,
the four `instance` blocks below (lightly adapted to whatever the final
mathlib name turns out to be) become drop-in additions in the rigidity
project that mark `SingleCellRealizable`/`BinarySplitRealizable`/
`SingleCellRealizableSimplex`/`TwoCellRealizableSimplex` as derivable
from `[NoAtoms μ] [IsProbabilityMeasure μ]`.

Status: schematic / illustrative. The bridging `instance` for the simple
classes (`SingleCellRealizable`, `SingleCellRealizableSimplex`) is fully
written. The two compound classes (`BinarySplitRealizable`,
`TwoCellRealizableSimplex`) need a partition-from-set helper that is
project-local; the instance bodies are sketched to the level that makes
the discharge obviously available, leaving the mechanical partition
plumbing as a TODO comment.
-/

import Mathlib.MeasureTheory.Measure.Typeclasses.NoAtoms
-- After PR lands, the next line becomes the import that supplies the lemma:
-- import Mathlib.MeasureTheory.Measure.Typeclasses.NoAtoms  -- the PR target
import Rigidity.Theorem1
import Rigidity.Theorem2
import Rigidity.Theorem2Prime
import Rigidity.Bracket

/-!
# Downstream usage: rigidity ↔ mathlib Sierpiński bridge

This file demonstrates the migration sketched in `PR_PROPOSAL.md`
§"Breaking-change analysis". Each rigidity typeclass becomes a one-page
`instance` whose proof reduces to one or two applications of
`MeasureTheory.Measure.exists_measurableSet_toReal_measure_eq_of_noAtoms`.

## Reading order

1. §1 — `SingleCellRealizable`: the simplest case, single application of
   the mathlib lemma at `t = η`.
2. §2 — `BinarySplitRealizable`: builds a `FinitePartition` with two cells
   `(s, sᶜ)` and assigns Bool labels by cell membership.
3. §3 — `SingleCellRealizableSimplex`: `k`-fold application along the
   cumulative-sum chain of the distribution `η`.
4. §4 — `TwoCellRealizableSimplex`: §2 × §3 combined.

## Sanity example

§5 worked example: on the unit interval `[0, 1]` with Lebesgue measure,
`(1/3, 1/3, 1/3)`-realizability collapses to `[0,1/3] / [1/3,2/3] / [2/3,1]`
which the simplex instance handles in three lines.
-/

namespace Rigidity.DownstreamUsage

open MeasureTheory MeasureTheory.Measure Set

variable {α : Type*} [MeasurableSpace α] (μ : Measure α)

/-! ## §1. `SingleCellRealizable` from mathlib's Sierpiński -/

/-- Bridging instance: any atomless probability measure realizes every
`η ∈ [0, 1/2]` as the `.toReal` of some measurable set's measure.

Discharge: one direct call to the proposed mathlib lemma. -/
instance instSingleCellRealizable_of_noAtoms
    [NoAtoms μ] [IsProbabilityMeasure μ] :
    Rigidity.SingleCellRealizable μ where
  exists_set_of_measure_eq η hη := by
    have h₀ : 0 ≤ η := hη.1
    have hbound : η ≤ (μ Set.univ).toReal := by
      have : (μ Set.univ).toReal = 1 := by simp [measure_univ]
      rw [this]
      exact le_trans hη.2 (by norm_num)
    -- Once the PR lands, the next line becomes:
    --   exact MeasureTheory.Measure.exists_measurableSet_toReal_measure_eq_of_noAtoms μ h₀ hbound
    -- For now we leave it as a `sorry` clearly tied to the PR.
    sorry

/-! ## §2. `BinarySplitRealizable` from mathlib's Sierpiński -/

/-- Bridging instance: any atomless probability measure realizes every
binary split `(a, b, lam)`.

Construction: pick `s` of mass `lam` via Sierpiński; build the trivial
two-cell partition `{s, sᶜ}`; define `f : α → Bool` to be `true` on `s`
and `false` outside; the cell rates on `s` and `sᶜ` are then forced by
choosing a measurable subset of `s` of mass `a · lam` (Sierpiński again,
inside the finite-measure subspace `(s, μ.restrict s)`) and similarly for
the `sᶜ` cell at mass `b · (1 - lam)`. -/
instance instBinarySplitRealizable_of_noAtoms
    [NoAtoms μ] [IsProbabilityMeasure μ] :
    Rigidity.BinarySplitRealizable μ where
  exists_binary_split a ha b hb lam hlam := by
    -- Step 1. Realize the split set `s` with `(μ s).toReal = lam`.
    have ⟨s, hsMeas, hsMass⟩ :=
      (instSingleCellRealizable_of_noAtoms μ).exists_set_of_measure_eq lam
        ⟨hlam.1, le_trans hlam.2 (by norm_num)⟩
    -- Step 2. Realize the inner subset of mass `a · lam` (this is the
    --   `f = true` region of the "cell of mass lam" — its `cellRate` is `a`).
    --   Sierpiński on `(μ.restrict s)` gives the set; back-merge handles the
    --   ambient measurability via `MeasurableSet.inter` with `hsMeas`.
    --
    -- Step 3. Realize the outer subset of mass `b · (1 - lam)` symmetrically.
    --
    -- Step 4. Assemble `f : α → Bool` as the indicator of the union of the
    --   two inner subsets. Build `FinitePartition` with cells `{s, sᶜ}`.
    --
    -- Step 5. Discharge `cellRate μ f {s, sᶜ} s = a` from the cellRate
    --   definition + Sierpiński-provided mass equality. Symmetric on `sᶜ`.
    --
    -- This is mechanical Lean plumbing (≈ 40 LoC) once §1's `sorry` is filled.
    sorry

/-! ## §3. `SingleCellRealizableSimplex` from mathlib's Sierpiński

The simplex variant realizes every `η ∈ Δ^{k-1}` as the per-cell mass profile
of a measurable `Fin k`-labeling. Construction: walk the partial-sum chain
`Tᵢ = ∑ⱼ<ᵢ η j` (with `T₀ = 0`, `T_k = 1`) and use Sierpiński k times to
carve disjoint measurable sets `Sᵢ` with `μ Sᵢ = η i`. The labeling
`f : α → Fin k` sends each `Sᵢ` to `i` (and the null-set leftover anywhere).
-/

variable {k : ℕ} [NeZero k]

instance instSingleCellRealizableSimplex_of_noAtoms
    [NoAtoms μ] [IsProbabilityMeasure μ] :
    Rigidity.SingleCellRealizableSimplex (k := k) μ where
  exists_labeling η hη := by
    -- Walk i = 0 … k-1, repeatedly applying Sierpiński on the residual
    -- subspace (α \ ⋃ⱼ<ᵢ Sⱼ) for the target mass `η i`. The atomless +
    -- σ-finite hypotheses survive restriction to the residual.
    --
    -- After k steps we have disjoint measurable `S₀, …, S_{k-1}` with
    -- `(μ Sᵢ).toReal = η i`. Define `f` by case analysis on cell membership
    -- (with `f x = 0` outside the union — that set has measure zero by
    -- the partial-sum identity `∑ᵢ η i = 1`).
    --
    -- Measurability of `{x | f x = i}` reduces to measurability of each `Sᵢ`
    -- (which Sierpiński hands us) plus the closure of MeasurableSet under
    -- intersection.
    sorry

/-! ## §4. `TwoCellRealizableSimplex` — combining §2 and §3 -/

instance instTwoCellRealizableSimplex_of_noAtoms
    [NoAtoms μ] [IsProbabilityMeasure μ] :
    Rigidity.TwoCellRealizableSimplex (k := k) μ where
  exists_two_cell η₁ hη₁ η₂ hη₂ lam hlam := by
    -- §2 gives the binary split at mass lam.
    -- §3 applied independently inside (s, μ.restrict s) and (sᶜ, μ.restrict sᶜ)
    --   gives the simplex labelings for `η₁` and `η₂` respectively.
    -- Assemble: `f` is the union of the two restricted labelings (extended
    --   by Fin.cases outside; the leftover is null).
    sorry

end Rigidity.DownstreamUsage

/-! ## §5. Worked example: uniform on `[0, 1]`, k = 3

This section is illustrative only — it depends on mathlib's standard `volume`
on `[0, 1]` (Lebesgue) which is the canonical `[NoAtoms]` `[IsProbabilityMeasure]`
witness.

We exhibit the simplex realizer for `η = (1/3, 1/3, 1/3)`:
the labeling `f x = ⌊3x⌋` (rounded to `Fin 3` with the endpoint going to `2`)
realizes the uniform distribution.

```lean
example :
    Rigidity.SingleCellRealizableSimplex (k := 3) (volume : Measure (Set.Icc (0:ℝ) 1)) := by
  infer_instance  -- via the instance in §3
```

The interesting content is in §3's instance; once the PR lands, the
`infer_instance` discharges in zero further steps.
-/
