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

**Status (round-8 closure, 2026-06-06)**: Library-grade PR draft assembled at
[`./sierpinski-pr/`](./sierpinski-pr/). Contains:
[`README.md`](./sierpinski-pr/README.md),
[`PR_PROPOSAL.md`](./sierpinski-pr/PR_PROPOSAL.md) (mathlib PR description),
[`Sierpinski.lean`](./sierpinski-pr/Sierpinski.lean) (statement + IVT skeleton via
Gouëzel's `MeasuredSets`; one `sorry` remaining for the doubling lemma),
[`Tutorial.md`](./sierpinski-pr/Tutorial.md) (5-section proof walkthrough),
[`DownstreamUsage.lean`](./sierpinski-pr/DownstreamUsage.lean) (four
`instance` derivations that retire the rigidity-local realizability typeclasses).
Final upstream submission still deferred to align with journal acceptance —
see [`19-panel_verdict.md`](../19-panel_verdict.md) §5 and
[`20-judge_f_harness_log.md`](../20-judge_f_harness_log.md) closure summary.

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

### 3. `NormalizedScore.mk_polynomial` helper (in-repo, LOW value)

**Source**: [`2026-06-05-phase-b4-proposition6.md`](./2026-06-05-phase-b4-proposition6.md)
**Why**: `tent_normalized`, `phiVar_normalized`, and any future polynomial-form score
(e.g., entropy-style) repeat the same 7-field structure with `nlinarith` + `norm_num`
on the per-cell arithmetic. A constructor

```lean
def NormalizedScore.mk_polynomial (φ : ℝ → ℝ) (h_poly : ∃ ...) :
    NormalizedScore φ := ...
```

could factor the proof obligations down to "show the symbolic polynomial form".

**Estimated cost**: ~50 LoC for the constructor + ~25 LoC saved per future score.
**Where it goes**: `Rigidity/Bracket.lean` (right after `NormalizedScore` definition).
**Decision**: defer until we have 3+ uses (currently 2: tent, phiVar).

### 4. Conditional Jensen for `ConcaveOn`/`ConvexOn` (HIGH value)

**Source**: Phase C2 (`barPhi_refinement_le`) discovery, 2026-06-05.
**Phase that needs it**: Phase C2 — refinement-monotonicity of `barPhi`.
**Estimated cost**: ~150 LoC (Rémy Degenne has `sorry` body in `testing-lower-bounds/Sorry/Jensen.lean`).
**Why high value**: Conditional Jensen is the universal tool for inequalities
involving conditional expectations. **Mathlib does not have it.** Rémy
Degenne's `testing-lower-bounds` formalization left it as a `sorry` placeholder
(`TestingLowerBounds/Sorry/Jensen.lean:23` — `ConvexOn.apply_condexp_le`),
which means even a probability-theory-heavy mathlib-adjacent project blocks on it.

The statement (concave form):

```lean
lemma ConcaveOn.condexp_apply_le {m mα : MeasurableSpace α} (hm : m ≤ mα)
    {μ : Measure α} (hf : StronglyMeasurable f)
    (hf_cvx : ConcaveOn ℝ (Ici 0) f) (hf_cont : ContinuousOn f (Ici 0))
    {g : α → ℝ} (hg : Measurable g) (hg_pos : 0 ≤ g)
    (h_int1 : Integrable g μ) (h_int2 : Integrable (fun x ↦ f (g x)) μ) :
    (fun x ↦ μ[f ∘ g | m]) ≤ᵐ[μ.trim hm] fun x ↦ f ((μ[g | m]) x)
```

**Where it goes**: `Mathlib/MeasureTheory/Function/ConditionalExpectation/Jensen.lean`
(new file) or extend existing `ConditionalExpectation` files.

**Workaround for now**: Specialize to **finite partitions** (which is what
we actually need for `barPhi_refinement_le`). The finite-partition case
reduces to discrete Jensen on the per-cell weighted average, avoiding
the full conditional-expectation machinery. This is what `barPhi_refinement_le`'s
Phase C2 implementation will do — ~100 LoC of partition-specific Jensen
instead of waiting for the full mathlib lemma.

### 5. `FinitePartition.nonempty` field (in-repo, MEDIUM value)

**Source**: [`2026-06-05-phase-c2-refinement-tower.md`](./2026-06-05-phase-c2-refinement-tower.md)
**Why**: The current `FinitePartition` structure permits empty cells. This
breaks the pairwise-disjointness argument that Phase C2's
`refines_partition_biUnion` helper requires (an empty cell of `P'` would lie
inside every cell of `P` simultaneously). Adding `nonempty : ∀ c ∈ cells, c.Nonempty`
restricts to the mathematically standard notion of a partition.

**Estimated cost**: ~15 LoC. Update `trivialPartition` to use
`Set.univ_nonempty` (which needs `[Nonempty α]` — supplied automatically
by `[IsProbabilityMeasure μ]` since `μ univ = 1 ≠ 0` forces `Nonempty α`).

**Where it goes**: `Rigidity/Bracket.lean`, `FinitePartition` struct definition.

**Decision**: defer until Phase C2 implementation begins (when the helper
that needs it is actually being written). The change is small but propagates
through every existing `FinitePartition.mk` use (currently only
`trivialPartition`), so coordinate it with C2.

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
