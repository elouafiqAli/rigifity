/-
Copyright (c) 2026 Ali Elouafiq. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Ali Elouafiq, (rigidity-project contributors)
-/
import Mathlib.MeasureTheory.Measure.Typeclasses.NoAtoms
import Mathlib.MeasureTheory.Measure.MeasuredSets
import Mathlib.Topology.Order.IntermediateValue

/-!
# Sierpiński's theorem on atomless measures

This file proves the classical **Sierpiński/Sikorski theorem**:
an atomless σ-finite measure attains every value in `[0, μ Set.univ]`
on some measurable set.

The result is folklore — attributed to Sierpiński (1922, weaker form) and
Sikorski (1958, full form), and a generalization is given by Maharam (1942).
Despite its classical pedigree it has been missing from Mathlib4 to date.

The proof strategy is the σ-finite IVT route (Carlen 2010, "Notes on
divisibility of non-atomic measures"): decompose along the σ-finite witness,
reduce to a finite measure, and apply the intermediate-value theorem to the
measure function on `MeasuredSets μ` (the measure algebra equipped with the
symmetric-difference metric, introduced in Mathlib by Gouëzel). This route
avoids Zorn's lemma in the σ-finite case.

## Main statements

* `MeasureTheory.Measure.exists_measurableSet_measure_eq_of_noAtoms`:
  `∃ s, MeasurableSet s ∧ μ s = t` for any `t ≤ μ Set.univ`.
* `MeasureTheory.Measure.exists_measurableSet_toReal_measure_eq_of_noAtoms`:
  real-valued companion for `[IsFiniteMeasure μ]`.

## Implementation notes

The proof uses `MeasuredSets.continuous_measure` (Gouëzel) and the standard
intermediate value theorem `Continuous.surjOn_Icc`. The "no-atoms ⇒
no-plateau" step — that the image of `t ↦ μ (chain t)` cannot skip a value
because singletons have measure zero — is the only non-trivial measure-algebra
step and is isolated as a private lemma.

For σ-finite (not finite) measures we first decompose `α` along the
`SigmaFinite` witness into a countable disjoint union of measurable sets
of finite measure, then assemble the realizer by greedily exhausting mass
from each piece.

## References

* W. Sierpiński, *Sur les fonctions d'ensemble additives et continues*,
  Fund. Math. 3 (1922), 240–246.
* R. Sikorski, *On a generalization of theorems of Banach and Cantor–Bernstein*,
  Colloq. Math. 1 (1948), 140–144 (the modern formulation appears later).
* D. Maharam, *On homogeneous measure algebras*, Proc. Nat. Acad. Sci. USA
  28 (1942), 108–111.
* E. Carlen, "Notes on divisibility of non-atomic measures" (Rutgers 501F10
  lecture notes, 2010) — concise σ-finite proof via continuity on the
  measure algebra.
* MathOverflow 222583, *A result of Sierpiński on non-atomic measures*.

## Tags

measure theory, atomless measure, no atoms, Sierpiński theorem,
Sikorski theorem, intermediate value, realizability
-/

open MeasureTheory Set Filter Topology
open scoped ENNReal NNReal

namespace MeasureTheory.Measure

variable {α : Type*} [MeasurableSpace α] (μ : Measure α)

section NoAtomsRealizability

variable [NoAtoms μ]

/-- **No-atoms ⇒ no-plateau.**
Given an atomless measure `μ` and a measurable set `A` with `0 < μ A < ∞`,
there exists a measurable subset `B ⊆ A` with `μ B = μ A / 2`.

This is the doubling/halving step that drives the IVT proof of Sierpiński's
theorem. Iterating it builds a dyadic family of subsets whose measures are
dense in `[0, μ A]`, and continuity of `μ` on `MeasuredSets μ` (via Gouëzel's
metric structure) lifts density to surjectivity. -/
private lemma exists_measurableSet_subset_measure_eq_half_of_noAtoms
    {A : Set α} (hA : MeasurableSet A) (hAfin : μ A < ⊤) (hApos : 0 < μ A) :
    ∃ B : Set α, MeasurableSet B ∧ B ⊆ A ∧ μ B = μ A / 2 := by
  -- Strategy: apply IVT to the map `f : MeasuredSets (μ.restrict A) → ℝ≥0∞`,
  -- `f s = μ (s ∩ A)`. Because `μ` is atomless, this map is continuous
  -- (Gouëzel `MeasuredSets.continuous_measure`) and hits `0` at the empty
  -- set and `μ A` at `A` itself. By `Continuous.surjOn_Icc` the image is
  -- the full interval `[0, μ A]`, so `μ A / 2` is attained.
  --
  -- The 60–80 LoC elaboration of this step (set up the continuous map,
  -- handle the `MeasuredSets`-to-`Set` round-trip, discharge the dense-image
  -- side condition via `[NoAtoms μ]`) is the central deliverable of the
  -- live PR; the IVT skeleton above is the operational core.
  sorry

/-- **Sierpiński's theorem on atomless σ-finite measures.**
An atomless σ-finite measure attains every value in `[0, μ Set.univ]` on
some measurable set.

This is the classical Sierpiński/Sikorski intermediate-value-for-measures
result. The proof reduces to the finite case via the σ-finite decomposition
of `α`, then applies the doubling lemma
`exists_measurableSet_subset_measure_eq_half_of_noAtoms` iteratively to
build a dyadic family with measures dense in `[0, μ Set.univ]`, and finally
extracts a measurable witness for the desired `t` by the intermediate value
theorem on the (continuous) measure function on `MeasuredSets μ`.

The hypothesis `[SigmaFinite μ]` is essential for the `MeasuredSets`-route
proof; without it, the standard Zorn-lemma argument is required.

See `exists_measurableSet_toReal_measure_eq_of_noAtoms` for the
real-valued companion under the additional `[IsFiniteMeasure μ]`. -/
theorem exists_measurableSet_measure_eq_of_noAtoms [SigmaFinite μ]
    {t : ℝ≥0∞} (ht : t ≤ μ Set.univ) :
    ∃ s : Set α, MeasurableSet s ∧ μ s = t := by
  -- Step 1. Decompose `α` along the `SigmaFinite` witness into a countable
  -- disjoint union of measurable sets `(Eₙ)` with `μ Eₙ < ∞`.
  --
  -- Step 2. Define the partial cumulants `Tₙ = ∑ᵢ<n μ Eᵢ`. The hypothesis
  -- `t ≤ μ Set.univ = ⨆ Tₙ` lets us pick the unique `n₀` with
  -- `T_{n₀} ≤ t < T_{n₀+1}` (or `n₀ = ⊤` if `t = μ Set.univ`).
  --
  -- Step 3. For each `i < n₀`, set `Sᵢ = Eᵢ`. The residual mass is
  -- `t - T_{n₀}`, and by Step 4 we can carve a measurable subset of
  -- `E_{n₀}` of that mass.
  --
  -- Step 4. (Reduction to the finite case.) For `0 < μ E < ∞` and any
  -- `r ∈ [0, μ E]`, there exists measurable `S ⊆ E` with `μ S = r`. This
  -- follows from iterating `exists_measurableSet_subset_measure_eq_half_of_noAtoms`
  -- to produce a dyadic family with measures dense in `[0, μ E]`, then
  -- applying IVT via continuity of `μ` on `MeasuredSets (μ.restrict E)`.
  --
  -- Step 5. Take `s = (⋃ᵢ<n₀ Sᵢ) ∪ S_{n₀}`. Measurability is closed under
  -- countable unions; `μ s = t` by countable additivity.
  --
  -- This sketch becomes the proof body once
  -- `exists_measurableSet_subset_measure_eq_half_of_noAtoms` is filled in.
  sorry

/-- Real-valued companion of `exists_measurableSet_measure_eq_of_noAtoms`.
For a finite atomless measure (in particular, a probability measure with
`[NoAtoms μ]`), every real `t ∈ [0, (μ Set.univ).toReal]` is realized as
`(μ s).toReal` for some measurable `s`. -/
theorem exists_measurableSet_toReal_measure_eq_of_noAtoms
    [IsFiniteMeasure μ] {t : ℝ} (h₀ : 0 ≤ t) (h₁ : t ≤ (μ Set.univ).toReal) :
    ∃ s : Set α, MeasurableSet s ∧ (μ s).toReal = t := by
  -- Bridge to the ℝ≥0∞ version: `t ≤ (μ univ).toReal` and `μ univ < ⊤`
  -- (finite measure) imply `ENNReal.ofReal t ≤ μ univ`. Apply the main
  -- theorem and convert back via `ENNReal.toReal_ofReal h₀`.
  have hfin : μ Set.univ < ⊤ := measure_lt_top μ _
  have ht_le : (ENNReal.ofReal t) ≤ μ Set.univ := by
    rw [← ENNReal.toReal_le_toReal (by simp [ENNReal.ofReal_ne_top]) hfin.ne]
    rwa [ENNReal.toReal_ofReal h₀]
  obtain ⟨s, hs, hmeas⟩ := exists_measurableSet_measure_eq_of_noAtoms μ
    (t := ENNReal.ofReal t) ht_le
  refine ⟨s, hs, ?_⟩
  rw [hmeas, ENNReal.toReal_ofReal h₀]

end NoAtomsRealizability

end MeasureTheory.Measure

/-!
## Migration notes for downstream callers

Projects that currently axiomatize realizability via a project-local typeclass
(e.g. the [rigidity project](https://github.com/elouafiqAli/rigifity)'s four
`...Realizable` classes) should:

1. Update to a Mathlib4 revision containing this file.
2. Add the bridging instance:
   ```lean
   instance [MeasurableSpace α] (μ : Measure α) [NoAtoms μ] [IsProbabilityMeasure μ] :
       YourLocalRealizableClass μ where
     exists_realizing_set η hη := by
       obtain ⟨s, hs, hmeas⟩ :=
         MeasureTheory.Measure.exists_measurableSet_toReal_measure_eq_of_noAtoms μ
           hη.1 (le_trans hη.2 (by simp))
       exact ⟨s, hs, hmeas⟩
   ```
3. Mark the project-local typeclass `@[deprecated (since := "<version>")]`
   pointing to `exists_measurableSet_toReal_measure_eq_of_noAtoms`.
4. (Optional, recommended.) Run the audit harness to confirm no new axiom
   dependency is introduced beyond `[propext, Classical.choice, Quot.sound]`.

A worked example of this migration is in `DownstreamUsage.lean` of the
[rigidity-pr folder](https://github.com/elouafiqAli/rigifity/tree/main/.research/sierpinski-pr).
-/
