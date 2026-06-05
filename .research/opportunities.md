# Opportunities — mathlib PRs, future work, follow-ups

Aggregator of `[opportunity]`-tagged items from `.research/*.md`. Each entry
links back to the originating research file.

Ordered by **estimated value** (high → low), not chronologically.

## Mathlib PR opportunities

### 1. Sierpiński's theorem on atomless measures (HIGH value)

**Source**: [`2026-06-05-sierpinski-atomless-realizability.md`](./2026-06-05-sierpinski-atomless-realizability.md)
**Phase that needs it**: B3b (currently using `SingleCellRealizable` typeclass workaround)
**Estimated cost**: 300-500 LoC
**Why high value**: Asked about repeatedly on MathOverflow / Math.SE (#222583,
#187975, #225677, #3919475, #1606451). Textbook result (Halmos §40 ex. 8).
Mathlib already has 80% of the prerequisites:

- `MeasureTheory.Measure.Typeclasses.NoAtoms` — the typeclass
- `MeasureTheory.Measure.MeasuredSets` (recent, Gouëzel) — continuous-distance machinery for IVT-based proof
- `MeasureTheory.Measure.NullMeasurable` — null-measurable set API for the construction

**Sketch of the proof for σ-finite case** (avoids Zorn's lemma):

1. Show `MeasuredSets μ` is path-connected for `[NoAtoms μ] [IsFiniteMeasure μ]`
   by exhibiting a path from `∅` to any `s` via a measurable "exhaustion".
2. `MeasuredSets.continuous_measure` ⟹ `μ` maps connected to connected.
3. So the image `μ '' MeasuredSets μ` is an interval (subset of `[0, μ univ]`).
4. Contains `0 = μ ∅` and `μ univ` ⟹ contains `[0, μ univ]`.

**Where it goes**: `Mathlib/MeasureTheory/Measure/Typeclasses/NoAtoms.lean` (extend) or
new file `Mathlib/MeasureTheory/Measure/Sierpinski.lean`.

**Cost-benefit**: HIGH — fixes a long-standing community ask AND unblocks our
`theorem2_reverse`. Defer until our paper is closer to publication so we can
cite the mathlib PR.

### 2. `ConcaveOn.one_sub` Pi-form helper (LOW value)

**Source**: `Rigidity.Bracket.tent_normalized` proof — we used a `convert` +
`ext` + `simp [Pi.add_apply]; ring` to bridge the gap between mathlib's
`add_const` (which produces a Pi-add form) and the desired
`fun η => 1 - η` form. A small mathlib helper:

```lean
theorem ConcaveOn.one_sub_self {s : Set ℝ} (hs : Convex ℝ s) :
    ConcaveOn ℝ s (fun η : ℝ => 1 - η) := ...
```

would clean up the `tent_normalized` proof and any future similar use.

**Estimated cost**: ~10 LoC
**Where it goes**: `Mathlib/Analysis/Convex/Function.lean`

## Our-codebase future work

### A. Wire `SingleCellRealizable` typeclass

**When**: immediately, as part of Phase B3b commit.
**What**: Define the typeclass; use it in `theorem2_reverse`; do NOT provide
the `[NoAtoms μ]` → instance.

### B. `Realizability.lean` module

**When**: when we get a second realizability hypothesis (e.g., for simplex case in Phase D).
**What**: Extract all typeclass-as-existence-hypothesis declarations into a
single module `Rigidity.Realizability` so they're easy to find / extend.

### C. Specialize `SingleCellRealizable` to concrete `μ`

**When**: when we want a closed worked example beyond `WorkedExample.lean`.
**What**: Prove `instance : SingleCellRealizable (volume : Measure (Set.Icc (0:ℝ) 1))`
for Lebesgue measure on `[0, 1]` — the realization there is constructive
(`s = Icc 0 η`).
