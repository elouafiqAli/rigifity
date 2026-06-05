# Verification harness

Two-step verification of every load-bearing claim in
[`03-t0-achievable_error_floor.md`](../03-t0-achievable_error_floor.md):

1. **Lean kernel build** (`../lean/`) — mechanically verifies the four
   rigidity-class theorems plus Proposition 6 against type-checked hypotheses.
2. **Python numerics** (`numerics.py`) — re-verifies the §4.3 worked example
   over exact rationals and confirms the Corollary 4 incomparability
   counterexamples.

See [`../14-harness_and_reproduction.md`](../14-harness_and_reproduction.md)
for the full brick-DAG and the phased rollout plan.

---

## What gets verified

### Lean kernel (`../lean/`)

After Phases B–D of `14` are complete, `lake build` will mechanically verify:

| Theorem | Lean target | Brick |
|---|---|---|
| Theorem 1 (refinement ⟺ concave) | `Rigidity.theorem1` | T1 |
| Binary bracket (`bar φ ≤ φ(ε*)` and `ε* ≤ c_φ · bar φ`) | `Rigidity.bracket_lower`, `Rigidity.bracket_upper` | T-bracket |
| Theorem 2 (T is the unique exact score) | `Rigidity.theorem2` | T2 |
| Theorem 1′ (refinement-monotonicity transfers to simplex) | `Rigidity.Simplex.theorem1Prime` | T1′ |
| Theorem 2′ (simplex rigidity) | `Rigidity.Simplex.simplex_rigidity` | T2′ |
| Proposition 6 (two-query identity + variance bracket) | `Rigidity.two_query_identity`, `Rigidity.variance_bracket` | P6 |

The scaffold landed in commit `2c8f196` (Phase A2) compiles with `sorry`
placeholders for every theorem; the worked-example checks in
`Rigidity.WorkedExample` use `decide` and should evaluate successfully.

### Numerics (`numerics.py`)

| Check | What it verifies | Brick |
|---|---|---|
| N1 | §4.3 worked example arithmetic (R, Gini, lower-bracket witness, slack) over exact rationals | W43 |
| N2 | Pi_mean and Pi_max incomparability counterexamples (two multiset pairs) | C4 |
| N3 | Proposition 6 closed-form bracket on a few partitions | P6 (sanity) |

All three exit 0 on PASS, 1 on any assertion failure.

---

## How to run

### Prerequisites

- **Lean toolchain** managed by [`elan`](https://github.com/leanprover/elan).
  After installing elan, `cd` into `lean/` and elan will auto-install the
  toolchain pinned in `lean/lean-toolchain` (currently `v4.18.0`).
- **Python 3.9+** (standard library only — `fractions`, `math`, `sys`).

### One-command harness

From the repo root:

```powershell
./verify/run-all.ps1
```

If `lake` is not yet installed the script prints a clear skip notice and runs
the Python numerics anyway.

### Step by step

```powershell
# Step 1: Lean kernel
cd lean
lake update     # one-time only, generates lake-manifest.json
lake build      # mechanically verifies every kernel theorem

# Step 2: numerics
cd ../verify
python numerics.py
```

Both should exit 0.

---

## What this does NOT verify

By design (per `09-mechanization_strategy.md` and `14` §1 non-goals):

- **§6 architecture sorting** — modeling claim, outside Lean's domain.
- **§7 algorithmic complexity** — requires a model of computation.
- **Theorem 5, Corollary 3, Corollary 3′, Corollary 7** — mathematically
  clean once the kernel is in place; intentionally not mechanized in the
  initial round.
- **Empirical companion claims** — Corollary 4 ladder benchmarks,
  over-smoothing onset curves, field deployment of the local test.
  Separate workstream.

---

## Phase status

| Phase | Description | Status |
|---|---|---|
| A1 | Harness plan persisted as `14` | ✓ done (`fb4c31d`) |
| A2 | Lean scaffold (lakefile + 6 modules with `sorry`) | ✓ done (`2c8f196`) |
| A3 | Numerics scaffold (this commit) | ✓ done |
| B1 | T-bracket mechanization | pending |
| B2 | Theorem 1 mechanization | pending |
| C1 | Theorem 2 mechanization (long-pole, 200 LoC) | pending |
| C2 | Proposition 6 mechanization | pending |
| D1 | Theorem 1′ mechanization | pending |
| D2 | Theorem 2′ mechanization (long-pole, 400 LoC) | pending |
| E1 | Numerics N1+N2+N3 implementation | ✓ done (folded into A3 — N3 added as bonus) |
| E2 | Brick provenance ledger as `15` | pending |
| E3 | Reproduction handbook as `16`; Draft 1.0 bump | pending |
