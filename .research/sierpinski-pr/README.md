# Sierpiński's theorem on atomless measures — mathlib PR draft

> **⚠ Superseded — 2026-06-06.** Active development has moved to a dedicated
> sibling repository at `../../../mathlib-sierpinski-pr/` (committed
> `996f45b`, tag `v0.1.0`). This folder remains as the archival record of
> the round-8 staging step. **Do not edit files here**; update the sibling
> repo instead. The sibling has:
>
> - A proper Lake project (`lake build` against vanilla mathlib v4.29.1).
> - Library split into `Sierpinski/{Core,Halving,SigmaFinite,Companion}.lean`
>   so each `sorry` is isolated to its own file.
> - Regression test bundle, GitHub Actions CI, issue + PR templates, dependabot.
> - Documentation suite of ~10 pages under `docs/` (ROADMAP, ProofStrategy,
>   API, DesignNotes, References, ReviewerGuide, Tutorial, Building, PR_PROPOSAL).
> - Helper scripts: `verify.{sh,ps1}` (CI mirror), `prepare-pr.sh`
>   (consolidates the diff for the eventual mathlib PR).
>
> The PR-completion workflow is in `../../../mathlib-sierpinski-pr/docs/ROADMAP.md`.

---

*A `.research/`-scoped artifact, not built/tested against a live mathlib worktree. Library-grade style; proof strategy fully laid out; the 300-LoC measure-theory development is described in detail in [`Tutorial.md`](Tutorial.md) and the `MeasuredSets`-based skeleton in [`Sierpinski.lean`](Sierpinski.lean). Round-8 panel verdict ([`../../19-panel_verdict.md`](../../19-panel_verdict.md) §5) recommended this PR be readied in parallel with the COLT/JMLR submission so it can be cited in the manuscript's mechanization paragraph.*

## What this folder contains

| File | Purpose | Audience |
|---|---|---|
| [`PR_PROPOSAL.md`](PR_PROPOSAL.md) | The text that becomes the GitHub PR description — motivation, statement, file path, reviewer suggestions, breaking-change analysis. | mathlib maintainers |
| [`Sierpinski.lean`](Sierpinski.lean) | Library-grade Lean 4 source, drop-in style for `Mathlib/MeasureTheory/Measure/Typeclasses/NoAtoms.lean`. The IVT skeleton is complete; one `sorry` remains for the measure-algebra continuity lemma. | mathlib reviewer / proof-completer |
| [`Tutorial.md`](Tutorial.md) | Walk-through of the Sikorski 1958 / Carlen IVT proof — math first, Lean second — for a reviewer who wants the argument before the code. | mathematician + library reviewer |
| [`DownstreamUsage.lean`](DownstreamUsage.lean) | The rigidity project's four realizability typeclasses (`SingleCellRealizable`, `BinarySplitRealizable`, `SingleCellRealizableSimplex`, `TwoCellRealizableSimplex`) each derived as a single-line `instance` from the proposed Sierpiński lemma. Demonstrates the PR's downstream impact. | mathlib reviewer (concrete-use case) + rigidity team (drop-in once PR lands) |
| [`README.md`](README.md) | (This file.) Index + status. | everyone |

## Why this PR exists

`MeasureTheory.Measure.NoAtoms` carries 30+ supporting lemmas in mathlib v4.29.1 (Iio≡Iic ae, Finset.measure_zero, etc.) but is missing the **synthesis lemma** that makes the typeclass useful for existence problems:

> **Sierpiński's theorem.** Let $(\Omega, \Sigma, \mu)$ be an atomless σ-finite measure space and let $t \in [0, \mu(\Omega)]$. Then there exists $S \in \Sigma$ with $\mu(S) = t$.

The 2026-06-05 research memo [`.research/2026-06-05-sierpinski-atomless-realizability.md`](../2026-06-05-sierpinski-atomless-realizability.md) catalogued the literature (Sikorski 1958, Maharam 1942, Carlen 2010) and confirmed the absence of this lemma in mathlib4 across `MeasureTheory/Measure/`, `MeasureTheory/Decomposition/`, `MeasureTheory/Function/`, and the typeclass roots. The lemma is asked about on MathOverflow #222583, MathSE #3919475, MathSE #1606451, and Wikipedia's "Atom (measure theory)" article. **High-value mathlib contribution.**

The opportunity item is logged at [`.research/opportunities.md` §1](../opportunities.md).

## Status

| Component | State |
|---|---|
| Statement | Final |
| Mathlib file path | `Mathlib/MeasureTheory/Measure/Typeclasses/NoAtoms.lean` (chosen so `[NoAtoms μ]` users discover the lemma in their existing import) |
| Proof strategy | Sikorski/Carlen IVT via `Mathlib.MeasureTheory.Measure.MeasuredSets` (Gouëzel, added in mathlib v4.29.1) — avoids Zorn's lemma in the σ-finite case |
| Central skeleton (`Sierpinski.lean`) | Drafted; one `sorry` for the `MeasuredSets`-continuity step (≈ 60–80 LoC of mathlib-style elaboration that we leave for the proof-completion phase) |
| Tutorial | Drafted; 5-page Lean-reviewer-targeted walkthrough |
| Downstream usage (rigidity) | Drafted as four `instance` declarations + a worked example |
| Integration test against live mathlib | **Pending** — requires a mathlib worktree at v4.29.1 and is out of scope for the round-8 closure |
| Submitted upstream | **No.** Round-8 verdict deferred submission until close to journal acceptance so the PR carries the published-citation gravity. |

## Reading order

For a mathlib reviewer evaluating the proposal:

1. [`PR_PROPOSAL.md`](PR_PROPOSAL.md) — what is being added and why
2. [`Tutorial.md`](Tutorial.md) §1–§2 — the math
3. [`Sierpinski.lean`](Sierpinski.lean) — the API surface
4. [`Tutorial.md`](Tutorial.md) §3–§4 — how the IVT proof discharges
5. [`DownstreamUsage.lean`](DownstreamUsage.lean) — what the lemma unlocks

For the rigidity team consuming this PR once landed:

1. [`DownstreamUsage.lean`](DownstreamUsage.lean) — the four `instance` declarations to copy into `lean/Rigidity/`
2. [`PR_PROPOSAL.md`](PR_PROPOSAL.md) §"Breaking-change analysis" — confirms the four typeclasses can be marked `@[deprecated]` after the bridging instances ship

## Cross-references

- Pre-PR strategy memo: [`.research/2026-06-05-sierpinski-atomless-realizability.md`](../2026-06-05-sierpinski-atomless-realizability.md)
- Opportunity entry: [`.research/opportunities.md`](../opportunities.md) §1
- Panel verdict scheduling this PR: [`19-panel_verdict.md`](../../19-panel_verdict.md) §5 "Two-paper publication track"
- Round-8 closure where this folder was committed: [`20-judge_f_harness_log.md`](../../20-judge_f_harness_log.md)
- Manuscript section that will cite this PR (once landed): [`03-t0-achievable_error_floor.md`](../../03-t0-achievable_error_floor.md) §5 "Mechanization"

## License + attribution

Apache-2.0 (matching mathlib). Author block at the top of [`Sierpinski.lean`](Sierpinski.lean) credits the rigidity project + names the corresponding author once the PR is filed.
