# Scaffold improvements from external research (Tavily web review)

*Phase A scaffold review. Sources include DeepMind's `formal-conjectures` repo
(994⭐, 1992 formalised problems, Apache 2.0), mathlib documentation, the
Bologna MSc thesis on Lean information theory, Tao's PFR blueprint writeup,
Patrick Massot's `leanblueprint`, and the Lean search-tools ecosystem
(Loogle, LeanSearch, LeanExplore, `lean-lsp-mcp`).*

> **Headline.** Ten actionable improvements, ranked by impact. Three quick
> wins applied immediately (lakefile hardening, selective imports, category
> attributes). One medium follow-up (replacing `bracket_lower` sorry with
> `ConcaveOn.le_map_centerMass`). Three deferred but planned (blueprint
> methodology, `lean-lsp-mcp` integration, category-tagged provenance map
> in §15-bricks). Two parked (`answer( )` elaborator, full mathlib
> Probability.Kernel use for OP1b — both require Phase D progress first).

---

## 1. DeepMind `formal-conjectures` — adopt their conventions

Repo: <https://github.com/google-deepmind/formal-conjectures>

**1992 formalised problem statements** (1090 open, 902 solved, 121 formally
proved) across Erdős's lists, Wikipedia, MathOverflow, OEIS, papers,
Hilbert problems, Millennium prizes. Lean 4 + Mathlib, Apache 2.0,
released alongside a Nature-companion paper.

### What we should adopt

**A. Lakefile.toml format** (replacing `lakefile.lean`):

```toml
[package]
name = "Rigidity"
[leanOptions]
pp.unicode.fun = true       # Pretty-prints `fun a ↦ b`
autoImplicit = false        # Don't assume a typo is a new variable
relaxedAutoImplicit = false # Same, stricter

[lean_lib.Rigidity]
[lean_lib.leanOptions]
warn.sorry = false          # Sorry is a warning not an error during scaffolding

[[require]]
name = "mathlib"
scope = "leanprover-community"
rev = "v4.29.1"             # Track tagged release matching our toolchain
```

The `warn.sorry = false` lets us keep `sorry` placeholders for incomplete
proofs without `lake build` complaining; flip back to default once a
target is real.

**B. Category attributes** for every numbered statement:

```lean
@[category research solved, AMS 60]  -- AMS 60 = Probability theory
theorem theorem1 ... := by ...

@[category research solved, AMS 68]  -- AMS 68 = Computer science
theorem cPhi_eq_half_of_normalized ... := by ...

@[category research open, AMS 68]
theorem softKernelLifting ... := by sorry  -- OP1b
```

This gives a structured query: `grep '@\[category research open' lean/`
lists every open conjecture in our kernel, ready for downstream LLM/agent
benchmarking exactly the way `formal-conjectures` does.

**C. `answer( )` elaborator** for "what is the value of X?" type problems:

```lean
@[category research solved]
theorem rigidity_classification (φ : ℝ → ℝ) (h : NormalizedScore φ) :
    (φ is exact ↔ φ = answer(tent)) := by sorry
```

The `answer(...)` lets the statement compile without committing to the
proven answer, useful for posing open variants of our results.

**D. Per-statement file layout** (Lean 4.27+ feature, we're on 4.29.1):

```lean
module

public import Rigidity.Util.ProblemImports

namespace MyTheorem
@[category research open, AMS 60]
theorem my_conjecture : Statement := by sorry
end MyTheorem
```

The `module` keyword + `public import` gives clean import boundaries.
Reduces incremental rebuild scope.

**E. Util/ProblemImports.lean pattern**:

```lean
module
public import Mathlib  -- once, here only
public import Rigidity.Bracket
-- ...etc
```

Every other file imports just this one module. Keeps top-of-file noise
down and centralises import management.

---

## 2. Selective imports (the biggest perf win)

Current state: every kernel module starts with `import Mathlib`, pulling
the full ~5000-module library. Cold build is fast (oleans cached) but
**incremental rebuilds revisit every transitively-imported olean**.

Per-module import audit (what we actually need):

| Module | Current | Should be |
|---|---|---|
| `Bracket.lean` | `import Mathlib` | `import Mathlib.Analysis.Convex.Function`<br>`import Mathlib.Analysis.Convex.Jensen`<br>`import Mathlib.MeasureTheory.Measure.MeasureSpace`<br>`import Mathlib.Order.ConditionallyCompleteLattice.Basic`<br>`import Mathlib.Tactic.Common`<br>`import Mathlib.Tactic.NormNum`<br>`import Mathlib.Tactic.Linarith` |
| `Theorem1.lean` | `import Mathlib` | + `import Mathlib.MeasureTheory.MeasurableSpaceDef`<br>+ `import Mathlib.Probability.ProbabilityMassFunction.NoAtoms` (for `NoAtoms`) |
| `Theorem2.lean` | `import Mathlib` | (same as Bracket) |
| `Theorem2Prime.lean` | `import Mathlib` | + `import Mathlib.LinearAlgebra.AffineSpace.Simplex`<br>+ `import Mathlib.Analysis.Convex.Combination` |
| `Proposition6.lean` | `import Mathlib` | + `import Mathlib.Analysis.SpecialFunctions.Pow.Real` (for `Real.sqrt`) |
| `WorkedExample.lean` | `import Mathlib` | **just** `import Mathlib.Data.Rat.Defs`<br>+ `import Mathlib.Data.Fin.VecNotation`<br>+ `import Mathlib.Tactic.NormNum` |

WorkedExample alone — currently pulls everything for 10 `native_decide`
arithmetic checks — would shrink from ~5000 transitive imports to ~50.

**Expected impact**: warm `lake build` after editing one module goes from
~30 s (current — lots of cached but still indexed oleans) to <5 s for
non-mathlib-heavy modules.

---

## 3. Mathlib lemmas to use in Phase B–D

### Phase B1 (cPhi + bracket)

| What we wrote | Should use |
|---|---|
| `cPhi_eq_half_of_normalized` (sorry) | Manual via `ciSup_le` + `le_ciSup` (BddAbove via chord lemma) — see "Lean-side gotcha" below |
| `bracket_lower` (sorry) | `ConcaveOn.le_map_centerMass` from `Mathlib.Analysis.Convex.Jensen` — finite-sum Jensen specialised exactly to our `Finset.centerMass`-shaped definition of `barPhi` |
| `bracket_upper` (sorry) | Direct via `ConcaveOn.smul_le_sum` or fold-with `cellMass` weights |

The `centerMass` version is the canonical mathlib pattern. Our `barPhi` is
already morally `Finset.centerMass cellMass (φ ∘ cellRate)`; matching the
shape exactly should let `ConcaveOn.le_map_centerMass` apply nearly
verbatim.

### Phase B2 (Theorem 1)

Atomless realisation argument (ii)⇒(iii): use
`MeasureTheory.NoAtoms` + the existence-of-prescribed-measure-subset
lemmas. Loogle query: `NoAtoms, exists_measure_eq`. The right lemma is
likely `MeasureTheory.NoAtoms.exists_subset_measure_eq` or similar.

### Phase D (simplex rigidity)

`Mathlib.LinearAlgebra.AffineSpace.Simplex` has the simplex as an affine
object; `Mathlib.Analysis.Convex.Combination` has convex-hull machinery.
Step 2's IVT-on-connected-simplex use applies via
`IsConnected.image` + `ContinuousOn.image_Icc`.

### Phase E (OP1b — soft-kernel lifting; deferred)

`Mathlib.Probability.Kernel.Basic` has:

```lean
structure Kernel (α β : Type) [MeasurableSpace α] [MeasurableSpace β] where
  toFun : α → Measure β
  measurable' : Measurable toFun
```

This is *exactly* the object OP1b's soft-kernel lifting needs. The Bologna
MSc thesis on Lean information theory has a Bayesian-inverse construction
that's likely directly reusable. When we get to OP1b in earnest, **start
there** rather than re-inventing.

---

## 4. The Lean search-tools ecosystem (immediately useful)

Tools we should use during proof writing:

| Tool | URL | Best for |
|---|---|---|
| **Loogle** | <https://loogle.lean-lang.org> | Pattern-based search by constants, subexpressions, hypothesis shapes. E.g. `ConcaveOn, Finset.sum, _ ≤ _` finds Jensen-style lemmas |
| **LeanSearch** | <https://leansearch.net> | Natural-language semantic search. E.g. "Jensen's inequality for concave function on finite sum" |
| **LeanExplore** | <https://leanexplore.com> | Multi-library natural-language search with dependency exploration |
| `#loogle` command | inside Lean (with mathlib) | Loogle from within VS Code / Lean |
| `exact?` / `apply?` | inside Lean | "find a lemma to close this goal" — should always try first |
| `#help tactic` | after `import Mathlib.Tactic.HelpCmd` | List all available tactics |
| `#find` / `#leansearch` | with LeanSearchClient | In-editor LeanSearch |

**Working pattern**: when stuck on a goal, ALWAYS try `exact?` first, then
Loogle the goal's type-skeleton, then LeanSearch the prose description.

---

## 5. `lean-lsp-mcp` — agentic Lean LSP

Repo: <https://github.com/oOo0oOo/lean-lsp-mcp> (referenced in ProofBench).

An MCP server that exposes Lean LSP. Tools include:
- `goalState` — get the current goal at a position
- `searchExact` — find lemmas matching the goal
- `runTactic` — execute a tactic and see the new state

This would let me (as an agent) drive proof development without round-tripping
through `lake build` + `tail` of error logs. **Genuinely transformative for
proof iteration; significant install/setup investment.**

Deferred to after Phase B1 lands real `bracket_lower`/`bracket_upper`; we can
re-evaluate the install cost then with a clearer sense of how slow our
current loop actually is.

---

## 6. Blueprint methodology — replace `14-harness_and_reproduction.md` DAG

Patrick Massot's `leanblueprint` (plasTeX plugin) is used by:
- PFR (Polynomial Freiman-Ruzsa) by Tao
- Liquid Tensor Experiment by Scholze
- Sphere Eversion by Massot/Van Doorn/Nash
- Fermat's Last Theorem by Buzzard/Taylor
- Carleson's theorem by van Doorn et al.
- Unit Fractions by Bloom/Mehta

What it does:
1. You write your paper as LaTeX with `\lean{Rigidity.theorem1}` cross-references.
2. `leanblueprint` renders an HTML+PDF blueprint with each statement
   linked to its Lean target, colour-coded by status (red: not started,
   blue: ready to formalise, green: formalised, blue background: proof
   ready, green background: proof done).
3. Dependency graph auto-generated.
4. GitHub Pages + GitHub Actions auto-deploys on every commit.

For our paper this would mean: `03-t0-achievable_error_floor.md` →
LaTeX → blueprint, every theorem links to its `Rigidity/*.lean` target,
public dashboard shows kernel completion %.

**Bigger than just a rendering improvement** — it's the standard tooling
for collaborative formalisation projects and would put us in conversation
with the Lean community in their idiom.

**Cost**: requires LaTeX-ifying the paper. Defer to after Phase D ships
the rigidity kernel.

---

## 7. Lean-side gotchas discovered during Phase B1 (additions to `wsl-lean-bridge` SKILL)

Already in the SKILL, but worth restating since the Tavily research
confirmed these are standard issues, not workspace-specific:

- `iSup_le` / `le_iSup` require `CompleteLattice`; `ℝ` has only
  `ConditionallyCompleteLinearOrder`. Use `ciSup_le` / `le_ciSup` with
  explicit `BddAbove`.
- `decide` does not reduce `ℚ` arithmetic — `native_decide` does.
- `ENNReal` notation `ℝ≥0∞` can misparse in return-type positions.

---

## 8. AGENTS.md pattern (DeepMind formal-conjectures has one)

The `formal-conjectures` repo root has an `AGENTS.md` that's a project-level
agent instructions file (sibling to `CONTRIBUTING.md`). When working with
Claude/Copilot/Cursor, the agent reads `AGENTS.md` first to learn project
conventions. Adopt:

`/AGENTS.md`:
- Pin language (Lean 4.29.1)
- Pin convention (one module per kernel target, P not Π)
- Required tactics: `exact?` before manual proof; `Loogle` before guessing lemma names
- Forbidden patterns: `import Mathlib` (use selective imports)
- Build command: `wsl -d Debian -- bash -lc 'cd ~/rigidity-build && lake build 2>&1 | tail -50'`

We already have an `.agents/skills/` dir with two SKILL files. AGENTS.md
would be a complementary top-level pointer.

---

## 9. Quick-win priorities for immediate application

Three commits to land now:

1. `chore(lakefile): switch to lakefile.toml; harden leanOptions`
2. `refactor(imports): replace 'import Mathlib' with selective imports per module`
3. `chore(lean): add @[category] + @[AMS 60] attributes to all kernel statements`

After those, Phase B1 picks up `bracket_lower` using `ConcaveOn.le_map_centerMass`.

---

## 10. Things to NOT do yet

- Don't switch to `answer( )` elaborator — our kernel theorems are not
  "what's the answer?" type questions. The pattern is for genuinely open
  conjectures.
- Don't pull in `Mathlib.Probability.Kernel` until Phase E (OP1b). It's a
  heavy dependency; defer the import cost.
- Don't switch to LaTeX-blueprint until Phase D closes. The markdown paper
  is fine for iteration; blueprint becomes worth the cost when proofs are
  done and ready for public display.
- Don't install `lean-lsp-mcp` yet — see if the `lake build` loop is
  actually the bottleneck after we've written a few more proofs the
  current way.

---

*Document owner: agent (via Tavily MCP web research, 2026-06-05).*
*Cross-references: `14-harness_and_reproduction.md`, `.agents/skills/wsl-lean-bridge/SKILL.md`.*
