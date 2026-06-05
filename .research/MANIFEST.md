# Research catalog — `.research/`

Tracked notes on external research informing the Rigidity formalization. Unlike
`.samples/` (read-only shallow clones, gitignored), `.research/` is **tracked
in git** — these notes shape future commits and audit decisions.

## Structure

- [`MANIFEST.md`](./MANIFEST.md) — this file (index + conventions).
- `YYYY-MM-DD-topic.md` — one file per research thread, dated by first entry.
  Each file is append-only; update existing files rather than creating new ones
  for the same topic.
- [`opportunities.md`](./opportunities.md) — aggregator of "things to upstream
  to mathlib" / "PRs we could open" / "future work blocked by external".

## Conventions

Each `YYYY-MM-DD-topic.md` file should follow this template:

```markdown
# Topic name

**Phase**: BX / CY / DZ (which phase of the formalization this informs)
**Status**: open / decided / superseded / upstreamed
**First raised**: YYYY-MM-DD
**Last updated**: YYYY-MM-DD

## The question

What we needed to know.

## Sources consulted

- [Title](URL) — short summary of what we got from it.
- (Repeat for each source — MathOverflow, Stack Exchange, Lean Zulip,
  mathlib docs, sample-repo cross-references, etc.)

## Findings

What we learned.

## Strategic decision

What we will do in our codebase. Cross-reference the commit / SKILL file
that landed the decision.

## Open follow-ups

What is left undone. Mark `[opportunity]` for items that should also appear
in `opportunities.md`.
```

## Index

| File | Phase | Status | Topic |
|---|---|---|---|
| [`2026-06-05-sierpinski-atomless-realizability.md`](./2026-06-05-sierpinski-atomless-realizability.md) | B3b | decided | Sierpiński's theorem on atomless measures — not in mathlib, use typeclass-as-hypothesis pattern |
| [`2026-06-05-phase-b3c-execution-plan.md`](./2026-06-05-phase-b3c-execution-plan.md) | B3c | **closed** | Execution plan + proof skeleton for `theorem2_reverse` (now proved) |
| [`2026-06-05-phase-b4-proposition6.md`](./2026-06-05-phase-b4-proposition6.md) | B4 | **closed** | Proposition 6: `two_query_identity` + `variance_bracket` (now proved, 27/27 audit) |
