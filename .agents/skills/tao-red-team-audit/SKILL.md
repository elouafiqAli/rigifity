---
name: tao-red-team-audit
description: Use when auditing Lean 4 code for mathlib style compliance, refactoring opportunities, or post-hoc cleanup. Red-team workflow (Tao, May 2026) — agent verifies/critiques human-written code instead of generating it. Includes the "skill-file growing" pattern and the mathlib style-guide checklist.
---

# Tao's red-team audit workflow

Distilled from Terence Tao's 2026 walkthrough of the Riemann–Stieltjes
integral mathlib contribution. Where `tao-step-by-step-proving` covers
the **blue team** (creating proofs), this skill covers the **red team**
(verifying that already-written proofs are correct, idiomatic, and
mathlib-style compliant).

Tao's claim: AI is actually *more* valuable as a red-teamer than as a
blue-teamer, because the human stays in charge of the creative work
while the agent handles the tedious-but-essential audit.

## Core principle

> The lean type checker is the minimum red-teaming tool. If your code
> doesn't type-check, the agent can fix it immediately. But mathlib
> demands much more: naming conventions, spacing, line length, doc
> strings, modular API design. Those are what AI red-teaming is for.

## The skill-file-as-checklist pattern

Tao asked Claude to read mathlib's style guide and **turn it into a
markdown file of actionable items**. The agent then runs that checklist
on each file. Over time, the checklist accumulates project-specific
gotchas that the agent records itself.

This workspace's analogue: `.agents/skills/<name>/SKILL.md`. We already
have:
- [`wsl-lean-bridge`](../wsl-lean-bridge/SKILL.md) — 9 lean-side gotchas already recorded
- [`lean-proof`](../lean-proof/SKILL.md) — one-step-at-a-time + error priority

When a new gotcha surfaces, the agent should write it into the relevant
SKILL.md. Tao's example: `integral.def` was a reserved-word collision;
mathlib uses `_def` instead; the fix was recorded in the skill file so
the agent doesn't repeat it.

## The audit checklist (excerpted from mathlib style guide)

Run these scans before every PR-equivalent commit:

### Naming
- Lemma names follow `subject_verb_object` pattern (`Set.image_union`).
- Use `_def` not `.def` (reserved word collision).
- Predicates over `Prop` use `Is` prefix (`IsCompact`, `IsClosed`).
- `Foo.bar` for the API of `Foo`, `bar_of_foo` for converse direction.
- See [naming guide](https://leanprover-community.github.io/contribute/naming.html).

### Spacing & formatting
- Single space after `def`, `theorem`, `lemma`.
- One blank line between declarations, two between sections.
- Max line length: 100 chars (mathlib limit).
- No trailing whitespace.
- No double-blank-line spurts.

### Tactic hygiene
- `simp at goal` — drop the `at goal`, that's the default.
- Prefer the more specific tactic (`linarith`, `ring`, `norm_num`)
  over `simp` when both work.
- Avoid `convert` unless the matching is genuinely hard; prefer `rw` /
  `simp only` chains.
- Avoid `decide` for non-trivial rationals; use `native_decide`.

### Modular API
- If a sub-pattern appears 3+ times, consider extracting a helper lemma.
- BUT: Tao explicitly noted he often decides NOT to abstract — sometimes
  6 explicit cases is more readable than one clever generalization.
- Make arguments implicit when usage shows lean can always infer them.
  Explicit by default if you have to write them in 2+ call sites.

### Doc strings
- Every theorem and definition gets a `/-- ... -/` doc string.
- First line is a brief summary; following lines can elaborate.
- Reference manuscript / paper / brick wherever applicable
  (we use `Brick: T-bracket`, `Manuscript: §3`, etc. — see Bracket.lean).

## The refactor-with-bonus pattern

Tao's surprise during the audit: when he made several arguments
**implicit** (changed `(a : α)` to `{a : α}`), a downstream three-line
proof **collapsed to one line** because Lean now had more freedom to
elaborate. Refactors can have non-local positive side effects.

Corollary: after any refactor, re-run `lake build` and look at how the
errors / required changes propagate. Sometimes the propagation reveals
that a more general or shorter proof is now possible.

## When to override the agent's suggestion

| Agent says | When to override |
|---|---|
| "Abstract these 3 similar lemmas." | When the abstraction adds machinery the abstraction-user would have to learn. |
| "Replace `convert` with `simp_rw + ring`." | When the explicit version is longer or more brittle. |
| "Make this argument implicit." | When you genuinely need to pass it explicitly in most call sites. |
| "Remove this doc string." | Never. We always keep doc strings. |

## Anti-patterns

- **Trusting the audit blindly.** Tao kept manual control even with
  auto-edit on. The type checker catches typo-level errors, but not
  semantic regressions like a forgotten special case.
- **Letting the agent generate AND audit the same code.** Worth using
  separate agent invocations (or different agents) for create-vs-verify.
- **Asking for "comprehensive review"** instead of asking for specific
  audit dimensions (style, performance, correctness, modularity).
  Comprehensive reviews drift into rewriting.

## Application to our pipeline

After Phase B1 fills the three remaining `sorry`s, run this audit
sequence before committing:

1. `lake build` — type-check baseline.
2. Style scan: column width, doc strings, spacing.
3. Naming scan: are our lemma names mathlib-compliant?
4. Tactic-hygiene scan: any `convert` we should drop?
5. Modularity scan: any 3+-repeated sub-proof to abstract?

`lean-lsp-mcp`'s `lean_diagnostics` tool surfaces lint warnings; pair
with manual `grep` for style violations.
