# Phase C — `theorem1` strategy + scope assessment

**Phase**: C
**Status**: open — strategy decided, scaffolding to be applied
**First raised**: 2026-06-05
**Last updated**: 2026-06-05

## The question

`theorem1` ([Theorem1.lean:40](../lean/Rigidity/Theorem1.lean)) is the
refinement-monotone ⟺ concave equivalence:

```lean
(∀ (f : α → Bool) (P P' : FinitePartition α),
    P' ⪰ P → barPhi μ φ f P' ≤ barPhi μ φ f P) ↔
ConcaveOn ℝ (Set.Icc (0:ℝ) 1) φ
```

Both directions need machinery beyond what Phase B built.

## Sources consulted

- `Bracket.lean` — has `bracket_lower` (Jensen for a single partition) but
  NOT a `barPhi`-monotonicity-under-refinement lemma. The tower property
  is the missing piece.
- Manuscript §3.1 — proof sketch: (iii)⇒(i) via tower-property + Jensen at
  every refinement step; (ii)⇒(iii) via realizing the binary split that
  embodies a convex combination.
- `.research/2026-06-05-sierpinski-atomless-realizability.md` — the
  typeclass-as-hypothesis pattern we'll reuse for the realizability side.

## Findings

### Easy direction (ConcaveOn ⟹ refinement-monotone)

Requires a **new bracket helper** `barPhi_refinement_le`:

```lean
theorem barPhi_refinement_le {α : Type*} [MeasurableSpace α]
    (μ : Measure α) [IsProbabilityMeasure μ]
    (φ : ℝ → ℝ) (h_cvx : ConcaveOn ℝ (Set.Icc (0:ℝ) 1) φ)
    (f : α → Bool) (P P' : FinitePartition α) (h_ref : P' ⪰ P) :
    barPhi μ φ f P' ≤ barPhi μ φ f P
```

Proof structure (per-cell tower):
1. For each cell `c ∈ P.cells`, the refining cells `c'_i ⊆ c` partition `c`
   (with measures summing to `μ c`).
2. `cellRate μ f P c = Σ_i (μ c'_i / μ c) · cellRate μ f P' c'_i` (the tower
   property — conditional-expectation linearity).
3. Apply `ConcaveOn.le_map_sum` (the abstract Jensen) at the per-cell level
   with weights `μ c'_i / μ c` and points `cellRate μ f P' c'_i`:
   `Σ_i (μ c'_i / μ c) · φ(cellRate ... c'_i) ≤ φ(cellRate ... c)`.
4. Multiply by `μ c` and sum over `c ∈ P.cells`; LHS rearranges to
   `barPhi μ φ f P'`, RHS to `barPhi μ φ f P`.

**Cost**: ~80 LoC of measure theory + Finset arithmetic. The tower property
itself is ~30 LoC and reusable; the rest is bookkeeping.

### Hard direction (refinement-monotone ⟹ ConcaveOn)

Use the same typeclass pattern as `SingleCellRealizable`:

```lean
class BinarySplitRealizable {α : Type*} [MeasurableSpace α]
    (μ : Measure α) : Prop where
  /-- For every (a, b, λ) with a, b ∈ [0, 1] and λ ∈ [0, 1], there exists
      a binary partition {s, sᶜ} and f, g : α → Bool with cellRate-values
      η_s = a, η_{sᶜ} = b, p_s = λ. -/
  exists_binary_split :
    ∀ a ∈ Set.Icc (0:ℝ) 1, ∀ b ∈ Set.Icc (0:ℝ) 1, ∀ lam ∈ Set.Icc (0:ℝ) 1,
      ∃ (f : α → Bool) (s : Set α), MeasurableSet s ∧
        (μ s).toReal = lam ∧
        cellRate μ f (trivialPartition.refineBy s) s = a ∧
        cellRate μ f (trivialPartition.refineBy s) sᶜ = b
```

The right-hand side requires:
- A `FinitePartition.refineBy : FinitePartition → Set → FinitePartition`
  operation (the binary refinement at `s`).
- Or a direct construction of a 2-cell `FinitePartition`.

For `[NoAtoms μ] [IsProbabilityMeasure μ]`, `BinarySplitRealizable` is
provable via **two applications of Sierpiński's theorem**: first realize
`lam`, then realize `a · lam` inside `s` and `b · (1 - lam)` inside `sᶜ`.
So the same mathlib PR (opportunity #1) unblocks both `SingleCellRealizable`
and `BinarySplitRealizable`.

**Cost**: ~30 LoC for the typeclass + ~40 LoC for theorem1's hard direction
(realize the split, apply binary-split monotonicity, derive the convex
combination inequality, hence concavity).

## Strategic decision

**Two-step rollout** (mirrors B3a → B3b → B3c pattern):

### Phase C1 (next commit)
- Skeletonize all helpers + theorem1 with full structural sub-`sorry`s.
- Define `BinarySplitRealizable` typeclass.
- Smoke-test; commit.

### Phase C2 (subsequent commit)
- Fill `barPhi_refinement_le` (the tower-property workhorse).
- Fill `theorem1_easy` direction.

### Phase C3 (subsequent commit)
- Fill `theorem1_hard` direction.
- Glue both into `theorem1`.

**Why split**: Phase C1 surfaces the structural dependencies cheaply
(catch type errors before measure-theoretic plumbing); C2 is the heavy
measure-theoretic lift; C3 composes.

## Open follow-ups

- `[opportunity]` Sierpiński PR (opportunity #1) closes both
  `SingleCellRealizable` and `BinarySplitRealizable` instance gaps.
- `[opportunity]` After C2 lands, see if `barPhi_refinement_le` belongs in
  `Bracket.lean` as a general-purpose lemma — it's the conditional-Jensen
  for partition functionals and might be reusable in the simplex case
  (Phase D).
- `[opportunity]` `FinitePartition.refineBy` (binary split at a measurable
  set) is a basic operation we'll need repeatedly. Define once, use in:
  `BinarySplitRealizable`, future simplex partitions, worked examples.

## Lessons in advance

- The "easy direction" of an iff is rarely as easy as it looks when there's
  a refinement quantifier. `bracket_lower` was a single-partition Jensen;
  `theorem1_easy` needs Jensen at every refinement step + bookkeeping.
- Don't conflate "structurally simple" with "tactically simple". The audit
  should re-check the `@[rigidity_proved]` tag carefully on `theorem1_easy`
  when it lands — it depends on a new `barPhi_refinement_le` that itself
  must be proved first.
