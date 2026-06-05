---
name: tao-step-by-step-proving
description: Use when formalizing a non-trivial informal proof in Lean 4 with agent assistance. Step-by-step skeletonization workflow (Tao, March 2026) that beats "do the whole thing" by an order of magnitude. Covers when to pause, where the agent gets stuck, and parallelizing agent + human work on independent lemmas.
---

# Tao's step-by-step formalization workflow

Distilled from Terence Tao's 2026 Claude-Code walkthrough of formalizing
equation 1689 ⇒ equation 2 in `equational_theories`. Same task, three runs:

- **Run 1** ("do the whole thing"): 45 min, computer crashed mid-way, token
  budget exhausted, nothing usable.
- **Run 2** (step-by-step, no recording): 25 min, complete proof.
- **Run 3** (recorded): 30 min including a crash, complete proof.

The takeaway: agents tend to overthink and burn tokens trying to do
end-to-end formalization. Decomposing the task into ~5 mechanical steps,
each verified by `lake build` before moving on, dramatically reduces both
wall-clock time and token burn.

## The five-step recipe (write at top of file as a comment)

Tao puts these as a literal comment block at the top of the Lean file so
the agent sees the same instructions in context every time.

```
-- Formalization recipe (do exactly one step per agent invocation):
--
-- Step 0: Formalize the notation/definitions only (no lemma bodies).
-- Step 1: Create the skeleton — state lemmas 1, 2, 3 with `by sorry`
--         bodies. Do NOT try to prove them.
-- Step 2a: For each lemma, turn each line of the informal proof into a
--          line of Lean code. Justifications are `sorry`.
-- Step 3:  Fill in each `sorry` one at a time, top to bottom.
-- Step 4:  Run `lake build` to verify after every step.
```

## Critical rules

1. **One step per agent invocation.** Resist the temptation to chain.
   Each step ends with `lake build` returning green.
2. **Skeletonize before proving.** Tao caught the agent repeatedly trying
   to "understand and prove" simultaneously, looping for minutes on what
   should be one-liners. Forcing skeletonization first separates concerns.
3. **Don't fight the lowest level.** Counter-intuitively, agents get stuck
   most on basic `linarith`/`norm_num` steps — not on the high-level
   structure. When you see backtracking on a one-line proof, pause and
   fill it by hand.
4. **Keep proof structure aligned with the informal proof.** When the
   agent decides to "do its own thing" and discards the informal proof,
   debugging drops to zero — you can't compare lines anymore. Always
   re-anchor on the original argument.
5. **Resume-ability is a feature, not a side-effect.** Step-by-step makes
   it trivial to recover from a crash mid-formalization. The last green
   `lake build` is your checkpoint.
6. **Extract repeated sub-proofs as their own lemma.** Tao noticed lemma
   2's H1 was structurally identical to lemma 1's H1. Pulling it out as
   a key lemma both shortened the proof and made the dependency explicit.

## The parallel-work pattern

Once you've skeletonized lemma N, you can in parallel:
- Hand-fill a `sorry` in lemma N-1 (where you understand the proof)
- Have the agent skeletonize lemma N+1

Tao tried this and confirmed: the agent doesn't mind that you're editing
the same file. It just merges. The lake type-checker catches any
genuine conflict.

**Don't go above one agent.** Tao explicitly tried multiple agents and
rejected it: the mental overhead of orchestrating dwarfs the throughput
gain for a solo developer.

## When the agent gets stuck

Symptom: 30+ seconds of "let me try a different approach", multiple
edits to the same line, repeated rewrites that don't converge.

Diagnosis: the lemma it's stuck on is usually a one- or two-liner that
the agent has decided is hard. Examples Tao hit:
- `congru` worked, `mul_comm` didn't, and the agent kept proposing increasingly
  baroque rewrites instead of the right tactic.
- Cancellation that needed `simp; ring` after a key rewrite.

Fix: take over by hand, give the agent the resulting code as
"this is how it's done", and let it skeletonize the next lemma. The agent
gets unblocked AND learns the pattern for next time.

## What to delegate vs. what to keep

| Delegate to agent | Keep for yourself |
|---|---|
| Skeletonization | Strategic decomposition |
| Filling `sorry` bodies you trust | Filling `sorry` you want to learn from |
| Mechanical refactors after a name change | Designing the new name |
| Hunting matching mathlib lemmas | Choosing which lemma to use |
| Style/spacing fixes | Mathematical content |

## Anti-patterns (do NOT do these)

- **"Just do the whole proof."** Recipe for burned tokens + half-broken file.
- **"Generate it all then I'll fix it."** Fix-it costs > generate-it cost.
- **Letting the agent overthink instead of stepping in.** Watch for the
  3rd "alternative approach" — that's your cue to pause.
- **Multiple agents on the same file.** Pure overhead.
- **Skipping `lake build` between steps.** Errors compound silently.

## Application to our pipeline

For Phase B1's three remaining `sorry`s (`cPhi_eq_half_of_normalized`,
`bracket_lower`, `bracket_upper`):

1. Tao step 0 = already done (definitions in `Bracket.lean`).
2. Tao step 1 = already done (lemma statements present, body = `sorry`).
3. Tao step 2a = NOT done. For each, write down the proof structure
   (chord-bound + `ciSup_le`, Jensen on cells, chord-bound aggregation)
   as a sequence of `have` statements with `sorry` justifications BEFORE
   trying to discharge any of them.
4. Tao step 3 = fill `sorry`s one at a time, smallest first.
5. Tao step 4 = `lake build Rigidity.Bracket` after each filled `sorry`.

The `lean-lsp-mcp` server's `lean_goal` tool is the per-step verifier;
`lean_multi_attempt` is the agent's per-tactic experiment harness. Both
are cheap to call between steps — use them.
