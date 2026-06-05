---
name: solo-blueprint-workflow
description: Use when developing a solo (one-person) Lean 4 formalization project, especially when deciding what blueprint / CI infrastructure to set up. Distills the patterns common to Rémy Degenne's testing-lower-bounds, Patrick Massot's unit-fractions, Oliver Butterley's SpectralThm, and similar one-author projects.
---

# Solo blueprint-style Lean project workflow

For a **one-person team** doing a Lean 4 + mathlib formalization. Patterns
mined from `.samples/` (37 reference blueprint-style projects). Solo-
authored exemplars: `testing-lower-bounds`, `zeta_3_irrational`,
`SpectralThm`, `unit-fractions`, `pfr`, `ExtremeValueProject`,
`brownian-motion`, `CLT`.

The big realization: most blueprint infrastructure (CI deployment,
GitHub Pages, doc-gen4 caching, dependabot) is built for **multi-author
collaboration**. Solo projects need only a subset.

## Tier 1 — apply early (high ROI, low cost)

### `Sorry/` subdirectory pattern (Rémy Degenne)

Every held-back lemma lives in `<Project>/Sorry/<Topic>.lean`. The
benefits for solo:

- `git grep sorry` returns exactly your work queue.
- Sorry-rot can't hide in random files.
- You can ship just the sorry-free subset via lakefile targets.

Adoption sketch:
```
lean/Rigidity/Sorry/Bracket.lean   -- bracket_lower, bracket_upper, cPhi_eq_half
lean/Rigidity/Sorry/Theorem1.lean  -- theorem1
lean/Rigidity/Sorry/Theorem2.lean  -- theorem2
```
With re-exports from the canonical module so existing imports keep
working.

### `ForMathlib/` subdirectory (testing-lower-bounds, SpectralThm)

Pre-stage lemmas you plan to upstream to mathlib. Our candidates:
- `ConcaveOn.one_sub` (the Pi-form `add_const` trick we needed in
  `tent_normalized`)
- Any general `ConcaveOn`/`StrictMono` glue we add

### Patrick Massot's `checkdecls` integration

One `require` line in `lakefile.toml` + a flat text file
`blueprint/lean_decls` listing every blueprint `\lean{X}` reference.
`lake exe checkdecls blueprint/lean_decls` fails if any drifted.
**This is THE solo-team anti-rot tool.**

### `LAYOUT.md` at repo root (Oliver Butterley pattern)

One file describing every directory and its purpose. We have
`14-harness_and_reproduction.md` doing this in narrative form;
`SpectralThm/LAYOUT.md` is the bullet-list complement.

## Tier 2 — apply when work continues (per-lemma blueprint annotation)

The "magic four" tags per lemma (used by PFR, testing-lower-bounds,
zeta_3_irrational):

```latex
\begin{lemma}[Chord bound]
  \label{lem:chord}
  \lean{Rigidity.two_eta_le_of_normalized}
  \leanok
  \uses{def:normalized-score}
  For normalized $\varphi$: $\varphi(\eta) \ge 2\eta$ on $[0,1/2]$.
\end{lemma}
```

- `\label{}` — for cross-references
- `\lean{...}` — links to the Lean declaration name
- `\leanok` — proof formalized (omit if still `sorry`)
- `\uses{...}` — explicit dependency

This gives you a clickable dependency graph after `leanblueprint web`
even without a CI deployment. Run it locally to a `blueprint/web/`
directory and open `index.html` in a browser.

## Tier 2.5 — when to write the blueprint .tex

Don't until you have ~10 lemmas. Below that, the manuscript markdown
files (`01-...md` through `15-...md`) are sufficient. The blueprint
becomes valuable when:
- You want to see dependency chains visually
- You want to track "what's proved vs what's sorry'd" across files
- You're approaching a public-facing milestone

For us, that's after Phase B1 closes.

## Tier 3 — DEFER for solo

Don't set up these until they clearly become bottlenecks:

- **Full blueprint CI + GitHub Pages.** 80-line YAML, 10-20 min per
  push, requires PR-style code review you don't have. Render locally
  with `leanblueprint pdf && leanblueprint web` instead.
- **Multi-chapter blueprint.** Single `content.tex` until you cross
  ~50 lemmas. PFR's chapter split is for multi-author scale.
- **`doc-gen4` integration in CI.** Breaks on every toolchain bump.
- **`dependabot` mathlib bumps.** Bump manually with `lake update` +
  smoke test. Bumps periodically break the world; you want to be the
  one watching when they do.
- **`CITATION.cff`, `CODE_OF_CONDUCT.md`.** Ceremonial.

## The closest topical neighbor

`testing-lower-bounds` is the rosetta stone for us. Their
`ProbabilityTheory.bayesRisk`, `ProbabilityTheory.bayesianRisk`,
`ProbabilityTheory.IsBayesEstimator`, `ProbabilityTheory.minimaxRisk`
are parallel definitions to ours under mathlib-compliant names. Their
`Sorry/Jensen.lean` contains `ConvexOn.apply_condexp_le` — the
conditional-expectation Jensen that is **exactly** the structural
ingredient our `bracket_lower` needs. Read it before re-deriving.

## The 1-person CI pipeline that we actually need

Our `verify/run-all.ps1` already does the right thing:
- `lake build` via WSL Debian
- Python numerics (`verify/numerics.py`)
- Exit 0 with `HARNESS: PASS` summary

Don't expand this until you're collaborating. The next things to add
(in priority order, only when needed):
1. `lake exe checkdecls blueprint/lean_decls` (after blueprint .tex exists)
2. Style scan (column width, doc strings) — Python regex script
3. `lake build Rigidity.<Module>` parallelization for faster iteration

## What NOT to copy from multi-author exemplars

- **Multi-stage CI matrices.** Solo + WSL = no need.
- **`AGENTS.md` per-team contributor norms.** We're using
  `.agents/skills/*/SKILL.md` instead — more focused, more actionable.
- **Branch-protection rules.** Pushing straight to master is fine for
  a personal project.
- **Issue templates.** TODOs in markdown files work for us.

## See also

- `tao-step-by-step-proving` — the blue-team workflow that pairs with
  the solo blueprint structure.
- `tao-red-team-audit` — the audit pass before each commit.
- `wsl-lean-bridge` — the build infrastructure all of this rides on.
