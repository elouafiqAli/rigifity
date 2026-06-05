import Lake
open Lake DSL

/-!
# Lakefile for the Rigidity kernel

Phase A scaffold per `14-harness_and_reproduction.md`.

To use:
  1. Install `elan` (https://github.com/leanprover/elan).
  2. `cd lean`
  3. `lake update`  (one-time; generates `lake-manifest.json`).
  4. `lake build`   (mechanically verifies the kernel; will report `sorry`
     warnings until Phase B–D commits land real proofs).

The toolchain pin in `lean-toolchain` should match the mathlib release
referenced below. Update both together.
-/

package «Rigidity» where
  leanOptions := #[
    ⟨`pp.unicode.fun, true⟩,
    ⟨`autoImplicit, false⟩
  ]

require mathlib from git
  "https://github.com/leanprover-community/mathlib4.git" @ "v4.29.1"

@[default_target]
lean_lib «Rigidity»
