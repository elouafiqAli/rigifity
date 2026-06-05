# Phase C2 — `barPhi_refinement_le` proof strategy

**Phase**: C2
**Status**: open — strategy decided, blocked on FinitePartition nonempty modeling decision
**First raised**: 2026-06-05
**Last updated**: 2026-06-05 (added nonempty-cell discovery)

## The question

`barPhi_refinement_le` (the easy direction of Theorem 1) says:
```lean
ConcaveOn ℝ (Icc 0 1) φ → ∀ f P P', P' ⪰ P → barPhi μ φ f P' ≤ barPhi μ φ f P
```

Currently `sorry`. This is the only blocker for promoting `theorem1` to
`@[rigidity_proved]`.

## Sources consulted

- Mathlib: `Finset.sum_biUnion` — the workhorse for the double-sum reindex.
  Signature:
  ```lean
  theorem Finset.sum_biUnion [DecidableEq ι] {s : Finset κ} {t : κ → Finset ι}
      (hs : (↑s).PairwiseDisjoint t) :
      ∑ x ∈ s.biUnion t, f x = ∑ x ∈ s, ∑ i ∈ t x, f i
  ```
- Mathlib: `Finset.sum_partition` is Setoid-based, less convenient.
- Phase B foundations: `sum_cellMass_eq_one`, `cellRate_mul_cellMass`,
  `cellRate_trivial_eq_sum`, `ConcaveOn.le_map_sum`.
- `.research/2026-06-05-phase-c-theorem1-strategy.md` — the original C2 plan.

## Findings

The proof requires three pieces of infrastructure, two of which need new
helpers in `Bracket.lean`:

### Piece 1: `refines_partition_biUnion` (new helper)

For `P' ⪰ P`:
```lean
P'.cells = P.cells.biUnion (fun c => P'.cells.filter (· ⊆ c))
```

with pairwise-disjointness of the filter families (any two distinct cells
of `P` have disjoint refining-cell families, because each cell of `P'`
lies inside *exactly one* cell of `P` by `P.disjoint` + `P.covers`).

Cost: ~40 LoC. Needs the "every cell of P' lies in some cell of P"
direction (from `Refines`) plus the "in exactly one" uniqueness
(from `P.disjoint`).

### Piece 2: `cellRate_eq_weighted_avg_refining` (new helper, the tower)

For `P' ⪰ P` and `c ∈ P.cells`:
```lean
cellRate μ f P c · μ c =
  Σ_{c' ∈ P'.cells.filter (· ⊆ c)} cellRate μ f P' c' · μ c'
```

(Both sides equal `μ ({f=true} ∩ c)`: LHS by `cellRate_mul_cellMass`,
RHS by partition-additivity over the refining sub-cells.)

Cost: ~50 LoC. Reuses `sum_measure_inter_eq` pattern (partition-additivity
of `{f=true} ∩ c` over the refining sub-cells).

### Piece 3: per-cell Jensen + aggregate (the main proof)

For each `c ∈ P.cells`:
1. Let `weights = fun c' => μ c' / μ c` (normalized to sum to 1 over
   refining cells).
2. Let `points = cellRate μ f P' c'`.
3. By Piece 2, `cellRate μ f P c = Σ weights · points` (the
   centerMass).
4. Apply `ConcaveOn.le_map_sum`: `Σ weights · φ(points) ≤ φ(Σ weights · points)`.
5. Multiply by `μ c`: `Σ μ c' · φ(cellRate c') ≤ μ c · φ(cellRate c)`.

Then sum over `c ∈ P.cells`, reindex via `Finset.sum_biUnion` + Piece 1:
LHS becomes `barPhi μ φ f P'`, RHS becomes `barPhi μ φ f P`.

Cost: ~100 LoC.

**Total cost: ~190 LoC**, splitting into 3 helpers + final glue.

## Strategic decision

Defer Phase C2 to its own focused session. The work is well-scoped but
requires careful Finset+Set bookkeeping that benefits from uninterrupted
focus. **The current session has 34/34 proved theorems and `theorem1_hard`
done** — a clean checkpoint.

Phase D (`simplex_rigidity`) does NOT depend on C2 — it depends on
`bracket_lower`/`bracket_upper` (already proved) at the simplex level,
which is a separate parallel track. So Phase D can proceed without
finishing C2.

## Open follow-ups

- `[opportunity]` `cellRate_eq_weighted_avg_refining` and
  `refines_partition_biUnion` are reusable beyond `theorem1`. Could
  package them as a separate `Rigidity.PartitionRefinement` module if
  Phase D's simplex case also needs them.
- After C2 lands, `theorem1` flips to `@[rigidity_proved]` automatically.
- **DISCOVERED 2026-06-05**: `FinitePartition` does NOT require non-empty
  cells. Concretely `{∅, univ}` with appropriate edge cases satisfies
  the structure. This breaks Piece 1's pairwise-disjointness of the
  filter families (since `∅ ⊆ c` for every `c`, an empty cell of `P'`
  would be in every `t c` simultaneously). Three resolution options:
  1. **Add `nonempty : ∀ c ∈ cells, c.Nonempty`** to FinitePartition.
     Breaks `trivialPartition` (would need `[Nonempty α]` which we don't
     always have — but actually `Set.univ.Nonempty` only requires `Nonempty α`,
     which is forced by `IsProbabilityMeasure μ` since `μ univ = 1 ≠ 0`).
     **Recommended**: this is the cleanest mathematical model. Track
     `instance [IsProbabilityMeasure μ] : Nonempty α` as the bridge.
  2. **Filter out empty cells** in the proof: work with
     `P.cells.filter (·.Nonempty)`. Adds bookkeeping to every helper.
  3. **Allow `∅` in the partition but quotient it out** in the
     pairwise-disjointness proof. Most error-prone option.
  Decision deferred until C2 implementation begins.

## Lessons in advance

- The "tower of partition refinements" is the central abstraction for
  any refinement-monotonicity argument. Once Pieces 1 + 2 land, all
  similar arguments (e.g. for entropy, for simplex-valued scores)
  become one-step applications.
- `Finset.sum_biUnion` is the right reindexing tool (not `Finset.sum_partition`
  which uses Setoid).
