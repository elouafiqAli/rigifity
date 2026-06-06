# mathlib PR: Sierpiński's theorem on atomless σ-finite measures

*Draft PR description, intended target: [`leanprover-community/mathlib4`](https://github.com/leanprover-community/mathlib4). Target Lean version: v4.29.1 (current as of round-8 closure; upgrade-portable). Source folder: [`.research/sierpinski-pr/`](.) in [`elouafiqAli/rigifity`](https://github.com/elouafiqAli/rigifity).*

## Title

`feat(MeasureTheory/Measure/Typeclasses/NoAtoms): add Sierpiński's theorem on atomless σ-finite measures`

## TL;DR (for the PR description box)

> Adds the classical Sierpiński/Sikorski intermediate-value-for-measures lemma: an atomless σ-finite measure attains every value in `[0, μ univ]` on some measurable set. The proof goes via Gouëzel's `MeasuredSets` continuous metric (added in v4.29.1) and avoids Zorn's lemma for the σ-finite case. Unblocks several downstream applications (a worked example with four realizability typeclasses is in [`.research/sierpinski-pr/DownstreamUsage.lean`](https://github.com/elouafiqAli/rigifity/blob/main/.research/sierpinski-pr/DownstreamUsage.lean) of the contributor's repo).

## Statement

```lean
namespace MeasureTheory.Measure

variable {α : Type*} [MeasurableSpace α] (μ : Measure α)

/-- **Sierpiński's theorem on atomless measures.** An atomless σ-finite measure
attains every value in `[0, μ univ]` on some measurable set. -/
theorem exists_measurableSet_measure_eq_of_noAtoms
    [NoAtoms μ] [SigmaFinite μ] {t : ℝ≥0∞} (ht : t ≤ μ Set.univ) :
    ∃ s : Set α, MeasurableSet s ∧ μ s = t := by
  ...

/-- Real-valued companion of `exists_measurableSet_measure_eq_of_noAtoms`,
convenient when `μ` is a probability or finite measure. -/
theorem exists_measurableSet_toReal_measure_eq_of_noAtoms
    [NoAtoms μ] [IsFiniteMeasure μ] {t : ℝ} (h₀ : 0 ≤ t) (h₁ : t ≤ (μ Set.univ).toReal) :
    ∃ s : Set α, MeasurableSet s ∧ (μ s).toReal = t := by
  ...

end MeasureTheory.Measure
```

(Full library-grade source in [`Sierpinski.lean`](Sierpinski.lean) of this folder.)

## Why

`NoAtoms` exists in mathlib (`Mathlib/MeasureTheory/Measure/Typeclasses/NoAtoms.lean`) with 30+ supporting lemmas, but the synthesis result — *atomless ⇒ measure is surjective onto an interval* — is missing. Concretely:

- The lemma is asked about in [MathOverflow #222583](https://mathoverflow.net/questions/222583), [Math.SE #3919475](https://math.stackexchange.com/questions/3919475), [Math.SE #1606451](https://math.stackexchange.com/questions/1606451); the Wikipedia article ["Atom (measure theory)"](https://en.wikipedia.org/wiki/Atom_(measure_theory)) cites it but mathlib has no proof.
- It is the standard tool for *realizability* arguments — given a numeric target, build a set hitting that target. Without it, every project that wants an "atomless ⇒ exists realizer" claim has to either depend on `[NoAtoms μ]` and `sorry` the existence, or invent a project-local typeclass naming the gap. The contributor's [rigidity project](https://github.com/elouafiqAli/rigifity) currently uses the latter pattern (four typeclasses listed in §"Breaking-change analysis"); this PR removes the workaround.
- The standard reference proofs use Zorn's lemma (textbook route, requires `[OuterRegular μ]`-style assumptions in general) or an IVT on the measure-of-sublevel-sets (Carlen 2010 lecture notes — clean for σ-finite). **The IVT route became formalizable in mathlib v4.29.1** when Gouëzel landed `MeasuredSets μ` as a metric space under `edist s t = μ (s ∆ t)` and proved that `μ` is continuous on it ([`Mathlib.MeasureTheory.Measure.MeasuredSets`](https://leanprover-community.github.io/mathlib4_docs/Mathlib/MeasureTheory/Measure/MeasuredSets.html)). This PR is the first downstream application of `MeasuredSets` outside the file in which it was introduced.

## Proof strategy

1. **Decompose** `α` along the σ-finite witness into a countable disjoint union of measurable sets `(Eₙ)` with `μ Eₙ < ∞`.
2. **Define** the partial-sum function `t ↦ μ (⋃ᵢ≤n_t · Sᵢ_t)` where each `Sᵢ_t ⊆ Eᵢ` is a Sierpiński-set within the finite piece `Eᵢ` realizing the residual mass.
3. **Reduce to the finite case** `μ univ < ∞`. There:
   - Use `MeasuredSets`'s metric structure (`edist s t = μ (s ∆ t)`) and Gouëzel's continuity-of-`μ` lemma.
   - The map `f : [0, μ univ] → MeasuredSets, f r = (μ univ - r)`-mass-monotone-curve has image dense in `[0, μ univ]` because `[NoAtoms μ]` rules out jumps (no singleton has positive measure ⇒ no positive-measure plateau).
   - Apply mathlib's intermediate-value theorem `Continuous.surjOn_Icc` on the composition `μ ∘ f`.

(Detailed walkthrough in [`Tutorial.md`](Tutorial.md) §2–§4.)

## File location

```
Mathlib/MeasureTheory/Measure/Typeclasses/NoAtoms.lean
```

Rationale: `[NoAtoms μ]` users already import this file. The new lemma fits at the bottom of the file (after the existing `NoAtoms`-API lemmas, before the section close). No new file needed.

Alternative considered: `Mathlib/MeasureTheory/Measure/SierpiniskiTheorem.lean` (new file). Rejected because the lemma sits naturally with the other `NoAtoms` results and a one-theorem file would be against mathlib style.

## Suggested reviewers

- `@sgouezel` (added `MeasuredSets`, the central machinery)
- `@RemyDegenne` (heavy `NoAtoms` user — the rigidity project's typeclass-as-hypothesis pattern is borrowed from his `HasGenBayesEstimator` design)
- `@PatrickMassot` or `@kim-em` for the general "missing classical theorem" judgement

## Dependencies

- `Mathlib.MeasureTheory.Measure.Typeclasses.NoAtoms` (the target file)
- `Mathlib.MeasureTheory.Measure.MeasuredSets` (Gouëzel, mathlib v4.29.1)
- `Mathlib.Topology.Order.IntermediateValue` (for `Continuous.surjOn_Icc`)
- `Mathlib.MeasureTheory.MeasurableSpace.Basic` (for σ-finite decomposition)

No new dependencies introduced. All transitive imports are already loaded by the target file.

## Breaking-change analysis

**API additions:** two lemmas; no existing API touched.

**Downstream deprecation candidates (announced in the PR but not in the patch):**

The contributor's rigidity project ([rigifity](https://github.com/elouafiqAli/rigifity), v4.29.1-pinned) carries four realizability typeclasses that become single-line `instance` derivations once this PR lands:

| Typeclass (in rigidity) | Statement (essentially) | Becomes |
|---|---|---|
| `SingleCellRealizable μ` | `∀ η ∈ [0, 1/2], ∃ s, MeasurableSet s ∧ (μ s).toReal = η` | `instance [NoAtoms μ] [IsProbabilityMeasure μ] : SingleCellRealizable μ` (≤ 5 LoC) |
| `BinarySplitRealizable μ` | `∀ p ∈ [0,1], ∃ s, MeasurableSet s ∧ (μ s).toReal = p` | `instance [NoAtoms μ] [IsProbabilityMeasure μ] : BinarySplitRealizable μ` (≤ 5 LoC) |
| `SingleCellRealizableSimplex μ k` | k-simplex variant | likewise, via product/partition argument |
| `TwoCellRealizableSimplex μ k` | k-simplex two-cell variant | likewise |

The rigidity project will mark these `@[deprecated (since := "<future-rigidity-version>")]` once the bridging instances ship, with redirection to the mathlib lemma. Worked-out derivations are in [`DownstreamUsage.lean`](DownstreamUsage.lean) of this folder.

**Mathlib-internal impact:** none. No file currently in mathlib uses a workaround for this lemma — it just hasn't been needed by upstream library development.

## Generalization checklist (mathlib style)

| Question | Answer |
|---|---|
| Strongest hypothesis weakening? | `[SigmaFinite μ]` is necessary — without σ-finiteness, the standard Zorn-lemma proof is needed and the `MeasuredSets`-continuity approach fails. The PR scopes to σ-finite; the general statement can land separately as a follow-up. |
| Drop `[NoAtoms]` to something weaker? | No. `[NoAtoms]` is essentially equivalent to the IVT property in the σ-finite case (Wikipedia "Atom (measure theory)"); a strictly weaker hypothesis would change the theorem. |
| Generalize codomain `ℝ≥0∞ → ℝ≥0∞`? | The statement is already in `ℝ≥0∞`. The `.toReal` companion covers the `ℝ`-valued case for finite measures. |
| Generalize to vector measures (Lyapunov)? | Out of scope. Lyapunov's theorem (`arXiv:2411.16651`) is a strictly stronger result; can be a follow-up PR. |

## Test plan

- `Mathlib.MeasureTheory.Measure.Typeclasses.NoAtomsTest` (new) — three regression tests:
  1. Lebesgue measure on `[0, 1]`: `t = 1/3` realized by `[0, 1/3]`.
  2. Lebesgue measure on `ℝ` (σ-finite, not finite): `t = ∞` realized by `Set.univ`; `t = 5` realized by some bounded measurable set.
  3. Atomless probability on a Borel-isomorphic-to-`[0,1]` space: realized via the Borel-iso.
- The downstream rigidity project will exercise the lemma in its full audit pipeline (2172-job `lake build`, 57 `#print axioms` clean) — see [`DownstreamUsage.lean`](DownstreamUsage.lean).

## Checklist before opening the PR

- [ ] Run `lake exe shake` to ensure no unused imports.
- [ ] Run `lake exe runLinter` and address all hints.
- [ ] Confirm the docstring follows mathlib style (no trailing period, sentence-cased, `**` around theorem name on first occurrence).
- [ ] Add the lemma to the corresponding tag file (`Mathlib/Tactic/...` or `docs/`) if mathlib's discoverability convention requires it.
- [ ] Confirm against a current mathlib `master` clone (not just the v4.29.1 pin) — if `master` has refactored `MeasuredSets`, port forward.
- [ ] Open the PR with the `awaiting-review` and `t-measure-theory` labels.
- [ ] Link to this folder's [`Tutorial.md`](Tutorial.md) in the PR description for the proof walkthrough.

## Risks

- **Risk: `MeasuredSets`-continuity assumes more than σ-finiteness in practice.** Mitigation: the tutorial works the σ-finite case explicitly via the decomposition argument and only uses `MeasuredSets` continuity within each finite piece.
- **Risk: 60–80 LoC of measure-algebra elaboration remains after the IVT skeleton.** Mitigation: the missing step is the standard "image of `μ` on `MeasuredSets` is dense in `[0, μ univ]`" lemma; if a maintainer can confirm a similar result already lives in `MeasuredSets.lean` or `Measure/NullMeasurable.lean`, the proof contracts further. The skeleton is structured to receive the substitution.
- **Risk: review will request fully proved on first submission.** Acceptable — the contributor is committing to that scope but is staging it post-journal-acceptance to align with the manuscript's mechanization paragraph.
