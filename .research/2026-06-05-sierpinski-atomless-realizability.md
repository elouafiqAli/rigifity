# Sierpiński's theorem on atomless measures — realizability for `theorem2_reverse`

**Phase**: B3b
**Status**: decided
**First raised**: 2026-06-05
**Last updated**: 2026-06-05

## The question

`theorem2_reverse` (binary rigidity) needs a *realizability lemma*: on an
atomless probability space `(α, μ)`, every `η ∈ [0, 1/2]` arises as
`cellRate μ f` for some measurable `f`. Equivalently: there exists
`s : Set α` with `MeasurableSet s` and `(μ s).toReal = η`.

This is the classical **Sierpiński theorem on non-atomic measures** (1922 /
Sikorski 1958 — attribution disputed). The standard statement:

> For an atomless measure space `(Ω, Σ, μ)` and any `a ∈ [0, μ(Ω)]`, there
> exists `A ∈ Σ` with `μ A = a`.

We need it for the single-cell argument that pins `φ(η) = 2η` on `[0, 1/2]`.

## Sources consulted

### Mathematical (the classical literature)

- [MathOverflow #222583 — A result of Sierpiński on non-atomic measures](https://mathoverflow.net/questions/222583/a-result-of-sierpiński-on-non-atomic-measures) — attribution dispute (Sikorski 1958 is the earliest unambiguous source; the 1922 Sierpiński paper proves a weaker statement). Maharam (1942) "On homogeneous measure algebras" provides an alternate construction via measure algebras.
- [MathOverflow #187975 — Reference for a strong intermediate value theorem for measures](https://mathoverflow.net/questions/187975) — companion question.
- [MathOverflow #225677 — Darboux property of non-atomic σ-additive nonnegative measures equivalent to AC?](https://mathoverflow.net/questions/225677) — proof uses Zorn's lemma (AC-dependent).
- [Math.SE #3919475 — Atoms and Sierpinski theorem](https://math.stackexchange.com/questions/3919475/atoms-in-a-measure-space-and-sierpinski-theorem-for-non-atomic-measures) — clean Zorn's lemma proof.
- [Math.SE #1606451 — Property of atomless probability measures](https://math.stackexchange.com/questions/1606451/property-of-atomless-probability-measures) — nested-version proof sketch.
- [Wikipedia: Atom (measure theory)](https://en.wikipedia.org/wiki/Atom_(measure_theory)) — proof sketch for the Lebesgue case via IVT on `t ↦ μ(A ∩ B_t)`.
- [Rutgers 501 notes (Carlen, 2010), "Notes on divisibility of non-atomic measures"](https://sites.math.rutgers.edu/~carlen/501F10/atomic.pdf) — clean 5-page proof, IVT-style for the σ-finite case.
- [Lyapunov's theorem on vector measures (arXiv:2411.16651)](https://arxiv.org/pdf/2411.16651) — generalization to vector-valued measures (convexity of range).

### Lean / mathlib

- Direct mathlib search: `grep -rE "atomless.*exists|Sierp|exists.*subset.*measure_eq" mathlib/MeasureTheory/` — **no measure-theoretic Sierpiński in mathlib4**. Only topology-Sierpiński (the Σ space, T0 spaces).
- [`Mathlib.MeasureTheory.Measure.Typeclasses.NoAtoms`](https://leanprover-community.github.io/mathlib4_docs/Mathlib/MeasureTheory/Measure/Typeclasses/NoAtoms.html) — the `NoAtoms` typeclass exists and has substantial supporting API (`Iio_ae_eq_Iic`, `Finset.measure_zero`, etc.) but no realizability lemma.
- [`Mathlib.MeasureTheory.Measure.MeasuredSets`](https://leanprover-community.github.io/mathlib4_docs/Mathlib/MeasureTheory/Measure/MeasuredSets.html) — Gouëzel's recent file defining `MeasuredSets μ` as a metric space under `edist s t = μ (s Δ t)` with `μ` as a continuous function. **This is the right machinery for an IVT-based proof of Sierpiński in mathlib**, but the theorem itself is not (yet) there.
- [`Mathlib.MeasureTheory.Measure.NullMeasurable`](https://leanprover-community.github.io/mathlib4_docs/Mathlib/MeasureTheory/Measure/NullMeasurable.html) — null-measurable set API; would be useful for the proof's "exhaust by countable chain" step.

### Sample-repo cross-references

- `.samples/testing-lower-bounds/TestingLowerBounds/Testing/Risk.lean:259` — Rémy Degenne's `HasGenBayesEstimator` typeclass: **the pattern for axiomatizing existence-of-realizing-object as a typeclass hypothesis**, instead of trying to construct it in the library.
  ```lean
  class HasGenBayesEstimator (E : estimationProblem Θ 𝒴 𝒵)
      (P : Kernel Θ 𝒳) [IsFiniteKernel P] (π : Measure Θ) [IsFiniteMeasure π] where
    estimator : 𝒳 → 𝒵
    property : IsGenBayesEstimator E P estimator π
  ```
- `.samples/testing-lower-bounds/` overall has zero uses of `NoAtoms` — confirming the broader pattern: even probability-theory-heavy projects defer to typeclass hypotheses for existence claims that mathlib doesn't carry.

## Findings

1. **Sierpiński's theorem is mathematically true but missing from mathlib.**
2. **The standard proof is non-trivial**: Zorn's lemma in general (~300-500 LoC of measure theory); IVT-based for σ-finite cases (uses `MeasuredSets` metric and continuity).
3. **Mathlib has 80% of the ingredients** (`MeasuredSets`, `NoAtoms`, `NullMeasurable`) but not the synthesis lemma.
4. **The community pattern for missing-but-needed existence claims is typeclass-as-hypothesis** (Rémy Degenne's `HasGenBayesEstimator`).

## Strategic decision

**Adopt Rémy Degenne's `HasGenBayesEstimator` pattern.** Define a typeclass
`SingleCellRealizable μ` in `Rigidity.Bracket` (or a new `Rigidity.Realizability`):

```lean
class SingleCellRealizable {α : Type*} [MeasurableSpace α] (μ : Measure α) : Prop where
  exists_realizing_set : ∀ η ∈ Set.Icc (0:ℝ) (1/2),
    ∃ s : Set α, MeasurableSet s ∧ (μ s).toReal = η
```

- `theorem2_reverse` takes `[SingleCellRealizable μ]` (not `[NoAtoms μ]`).
- The reverse direction is then **fully provable** from this typeclass plus our existing helpers — no hidden `sorry`.
- The `@[rigidity_proved]` tag is honest: the proof is sorry-free; the dependency is *explicit* as a typeclass hypothesis.
- **No** `[NoAtoms μ] [IsProbabilityMeasure μ] → SingleCellRealizable μ` instance is provided, because that *would* require Sierpiński and we don't have it. This honesty is enforced by the audit harness.
- Users instantiating `SingleCellRealizable μ` for a concrete `μ` must either prove Sierpiński themselves OR specialize to a case where it's constructive (e.g., Lebesgue on `[0, 1]`).

Why this is honest vs. cheating:
- The typeclass has a `where` clause requiring a *proof of the existence statement* at instantiation time.
- Anyone using `theorem2_reverse` is forced to supply such a proof.
- The audit harness `verify/print-axioms.ps1` shows `theorem2_reverse` depends only on the standard three Lean axioms — there's no `sorryAx` smuggled in.
- The mathematical gap is **named** (`SingleCellRealizable`), **isolated** (one typeclass), and **deferrable** (instances can be provided later).

## Open follow-ups

- `[opportunity]` PR Sierpiński's theorem to mathlib4 in `Mathlib/MeasureTheory/Measure/Typeclasses/NoAtoms.lean`. Estimated cost: 300-500 LoC. Use the `MeasuredSets` continuous-distance machinery for an IVT-based proof (avoids Zorn's lemma in the σ-finite case). Would simultaneously unlock our `instance [NoAtoms μ] [IsProbabilityMeasure μ] : SingleCellRealizable μ`. **High-value mathlib contribution** because this lemma is asked about repeatedly on MathOverflow / Math.SE and is a textbook result.
- `[opportunity]` Once Sierpiński is in mathlib, our `SingleCellRealizable` typeclass becomes vestigial — should provide the bridging instance and then mark `SingleCellRealizable` as `@[deprecated]`.
- Verify the typeclass works for our concrete `theorem2_reverse` proof (Phase B3b, next commit).
- Check whether `Mathlib.MeasureTheory.Measure.MeasuredSets` is actually usable from our import set (added in mathlib v4.29.1?).
