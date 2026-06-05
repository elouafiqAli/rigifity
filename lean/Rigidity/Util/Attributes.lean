import Lean

/-!
# Util.Attributes — provenance tags for kernel statements

A minimal adaptation of DeepMind formal-conjectures' `@[category]` and `@[AMS N]`
attribute pattern (cf. `15-scaffold-improvements.md` §3), trimmed to the small
set of tags this project actually needs. Each is a zero-argument tag attribute
registered via `Lean.registerTagAttribute`; declarations marked with one are
searchable via standard tooling (`#print` introspection, `grep`).

## Why minimal

DeepMind's machinery uses environment extensions, `Qq`, and syntax extensions
to parse multi-argument attributes like `@[category research solved, AMS 60]`.
That is appropriate for their ~2000 statements with full provenance tooling.
For our ~10 kernel statements, a flat namespace of zero-argument tags gives
the same searchability with one screen of code and zero new dependencies.

## Status tags

- `@[rigidity_proved]`   — the declaration body is sorry-free against mathlib v4.29.1.
- `@[rigidity_scaffold]` — the declaration is scaffolded with `sorry`; tracked for completion.

## AMS subject tags (MSC2020)

We declare only the subjects this project actually touches:

- `@[rigidity_AMS_28]` — Measure and integration.
- `@[rigidity_AMS_60]` — Probability theory and stochastic processes.
- `@[rigidity_AMS_62]` — Statistics.
- `@[rigidity_AMS_94]` — Information and communication, circuits.

## Usage

```lean
@[rigidity_proved, rigidity_AMS_60]
theorem two_eta_le_of_normalized ... := by ...

@[rigidity_scaffold, rigidity_AMS_60, rigidity_AMS_62]
theorem theorem2 ... := by sorry
```

## Provenance

* Adopted: commit applying Quick Win #3 of `15-scaffold-improvements.md`.
* Inspired by: DeepMind formal-conjectures' `FormalConjectures/Util/Attributes/`.
-/

open Lean

namespace Rigidity.Util

initialize rigidityProvedAttr : TagAttribute ←
  registerTagAttribute `rigidity_proved
    "The declaration body is sorry-free against mathlib v4.29.1."

initialize rigidityScaffoldAttr : TagAttribute ←
  registerTagAttribute `rigidity_scaffold
    "The declaration is scaffolded with sorry; tracked for completion."

initialize rigidityAMS28Attr : TagAttribute ←
  registerTagAttribute `rigidity_AMS_28
    "AMS 28: Measure and integration."

initialize rigidityAMS60Attr : TagAttribute ←
  registerTagAttribute `rigidity_AMS_60
    "AMS 60: Probability theory and stochastic processes."

initialize rigidityAMS62Attr : TagAttribute ←
  registerTagAttribute `rigidity_AMS_62
    "AMS 62: Statistics."

initialize rigidityAMS94Attr : TagAttribute ←
  registerTagAttribute `rigidity_AMS_94
    "AMS 94: Information and communication, circuits."

end Rigidity.Util
