---
name: wsl-lean-bridge
description: Use when building or iterating Lean 4 + mathlib proofs in this workspace from Windows. Covers the WSL Debian bridge setup, ext4 build directory, cold/warm build sequences, PowerShell invocation pitfalls, and Lean-side gotchas discovered during Phase A/B mechanization.
---

# WSL Lean Bridge — rigidity workspace

This workspace runs Lean 4 + mathlib through WSL Debian because a
Windows-native `lake build` would compile mathlib from source (multi-hour).
WSL Debian already has the toolchain and a pre-populated mathlib cache.

## Environment invariants

| Thing | Value |
|---|---|
| Default WSL distro | Debian (also: Alpine, docker-desktop — unused) |
| Linux user | `aelouafiq`, HOME `/home/aelouafiq` |
| elan | `4.2.1` at `/home/aelouafiq/.elan/bin/{elan,lean,lake}` |
| Lean toolchain installed | `leanprover/lean4:v4.29.1` |
| Mathlib cache | `/home/aelouafiq/.cache/mathlib/` ~408 MB of `.ltar` |
| Windows workspace | `C:\Users\aelouafiq\workdir\rigidity\` |
| WSL view of workspace | `/mnt/c/Users/aelouafiq/workdir/rigidity/` |
| WSL-native build dir | `~/rigidity-build/` (ext4, symlinks to Windows source) |

## CRITICAL: Use the ext4 build directory

**Never put `.lake/` on NTFS (the Windows-side `lean/` dir).** The git
clone of mathlib runs through 9P into NTFS and hangs — a prior attempt
reached ~391 MB of `mathlib/.git` without completing.

The solution: `~/rigidity-build/` on ext4 holds `.lake/` and symlinks to
the Windows-side source files. Edits on Windows are reflected immediately
(via symlinks). Build artifacts stay on fast ext4.

`verify/run-all.ps1` creates this directory automatically on first run.
For manual setup:

```bash
# Run once inside WSL Debian
mkdir -p ~/rigidity-build && cd ~/rigidity-build
rm -f lakefile.lean lean-toolchain Rigidity.lean Rigidity
ln -s /mnt/c/Users/aelouafiq/workdir/rigidity/lean/lakefile.lean .
ln -s /mnt/c/Users/aelouafiq/workdir/rigidity/lean/lean-toolchain .
ln -s /mnt/c/Users/aelouafiq/workdir/rigidity/lean/Rigidity.lean .
ln -s /mnt/c/Users/aelouafiq/workdir/rigidity/lean/Rigidity Rigidity
```

## Build sequences

**Cold (first run):**
```powershell
wsl -d Debian -- bash -lc 'cd ~/rigidity-build && lake update && lake exe cache get && lake build'
```
- `lake update` — resolves deps, generates `lake-manifest.json` (~2 min first time).
- `lake exe cache get` — decompresses 8229 pre-built oleans from `~/.cache/mathlib/` in ~54 s (no network needed).
- `lake build` — compiles only `Rigidity/*.lean` modules (~30 s).

**Warm (subsequent runs, after editing source):**
```powershell
wsl -d Debian -- bash -lc 'cd ~/rigidity-build && lake build 2>&1 | tail -50'
```

**Single-module iteration loop (typical proof work):**
```powershell
# After editing lean/Rigidity/Bracket.lean on Windows:
wsl -d Debian -- bash -lc 'cd ~/rigidity-build && lake build Rigidity.Bracket 2>&1 | tail -30'
```

`tail -50` (or `tail -30` per module) keeps output bounded — mathlib
import errors can dump many pages.

## Full harness

```powershell
./verify/run-all.ps1          # uses WSL Debian automatically
./verify/run-all.ps1 -NoWsl   # force Windows-native lake (must be in PATH)
```

Exits 0 and prints `HARNESS: PASS` when both the Lean kernel build and
the Python numerics checks pass.

## Toolchain pin alignment

`lean/lean-toolchain` and `lean/lakefile.lean` MUST both pin `v4.29.1`
(the installed toolchain and the cached oleans). A version mismatch causes
elan to download a second toolchain or `lake exe cache get` to miss and
fetch from the network.

## PowerShell ↔ WSL bridge rules

### Always single-quote bash commands

```powershell
# CORRECT — bash sees literal $HOME
wsl -d Debian -- bash -lc 'echo $HOME'

# BROKEN — PowerShell interpolates $HOME first → "C:Usersaelouafiq"
wsl -d Debian -- bash -lc "echo $HOME"
```

### Always use `bash -lc` (login shell)

`bash -c` (without `-l`) gets a minimal PATH without
`/home/aelouafiq/.elan/bin/`, so `lake` and `lean` are not found.

### Multi-line bash scripts: write a temp file

PowerShell heredocs + WSL is a minefield. For multi-line scripts:

```powershell
$script = @'
set -e
cd ~/rigidity-build
lake build
'@
# Write with LF line endings (CRLF makes bash choke on "set: -\r: invalid option")
$tmp = [System.IO.Path]::GetTempFileName() + '.sh'
[System.IO.File]::WriteAllText($tmp, ($script -replace "`r`n", "`n"), [System.Text.Encoding]::ASCII)
$wslTmp = $tmp -replace '\\', '/' -replace '^([A-Za-z]):', { "/mnt/$($_.Value[0].ToString().ToLower())" }
wsl -d Debian -- bash -l $wslTmp
Remove-Item $tmp -ErrorAction SilentlyContinue
```

Key points:
- `Set-Content` writes CRLF by default → bash fails with `set: -\r: invalid option`.
- Use `[System.IO.File]::WriteAllText(...)` with explicit CRLF→LF replacement.
- Invoke via `bash -l <file>`, not `bash -lc <heredoc>`.

## Lean-side gotchas

### `Π` is a reserved token

`Π` is Lean's dependent-product syntax `Π (x : α), β`. Use `P` for
partition variable names in code. Docstrings (`/-! ... -/` and `/-- ... -/`)
are plain text and can freely use `Π`.

### Imports must precede module docstrings

```lean
-- CORRECT
import Mathlib
/-! # My module -/

-- BROKEN — Lean error: "invalid 'import' command, it must be used in the beginning of the file"
/-! # My module -/
import Mathlib
```

### `ℝ≥0∞` vs `ENNReal`

The Unicode notation `ℝ≥0∞` parses incorrectly in some def return-type
positions (Lean misparses `≥` as `LE Type`). Use the spelled-out name
`ENNReal` for return types.

### `decide` vs `native_decide` for rational arithmetic

`decide` does not reduce `ℚ` arithmetic at elaboration time; it produces
a `Decidable` instance that doesn't evaluate. Use `native_decide` for
rational equality / inequality checks.

```lean
-- BROKEN
example : (3/5 : ℚ) + 1/5 + 1/5 = 1 := by decide

-- CORRECT
example : (3/5 : ℚ) + 1/5 + 1/5 = 1 := by native_decide
```

### `variable` auto-binding is fragile

`variable {α : Type*} [MeasurableSpace α] (μ : Measure α)` auto-binds
only when a theorem / def directly references those variables. If
intervening defs don't use them, the auto-bind can silently stop working
for later defs. **Prefer explicit `{α : Type*} [MeasurableSpace α] (μ : Measure α)`
in every def and theorem signature.**

### One namespace block per file

Splitting into two `namespace X ... end X` blocks loses the `open`
directives from the first block. Keep one namespace block per file:

```lean
namespace Rigidity
open MeasureTheory Set

-- all defs and theorems here

end Rigidity
```

### `iSup` / `sSup` on `ℝ` needs conditional-sup API

`ℝ` is a `ConditionallyCompleteLinearOrder`, not a `CompleteLattice`.
`iSup_le` and `le_iSup` require `CompleteLattice` and will fail on `ℝ`.
Use the conditional variants:

```lean
ciSup_le  -- for ⊢ ⨆ i, f i ≤ a
le_ciSup  -- for ⊢ a ≤ ⨆ i, f i  (needs BddAbove hypothesis)
```

**Even better: avoid `⨆ x ∈ s, f x` for ℝ entirely.** Define using
`sSup ∘ image` instead — far cleaner proofs via `csSup_le`,
`csSup_eq_of_forall_le_of_forall_lt_exists_gt`, `le_csSup`, etc:

```lean
-- BAD: nested iSup over (η ∈ s) is a Prop; conditional-sup lemmas
-- for ℝ have BddAbove or ConditionallyCompleteLinearOrderBot side
-- conditions that don't apply.
noncomputable def cPhi (φ : ℝ → ℝ) : ℝ := ⨆ η ∈ Set.Ioc (0:ℝ) (1/2), η / φ η

-- GOOD: csSup_le / le_csSup work directly on the image set.
noncomputable def cPhi (φ : ℝ → ℝ) : ℝ :=
  sSup ((fun η : ℝ => η / φ η) '' Set.Ioc (0:ℝ) (1/2))
```

### `div_le_iff` is now `div_le_iff₀` in v4.29.1

The old name `div_le_iff` was deprecated; use `div_le_iff₀` (with the
zero subscript) for the `0 < b → (a / b ≤ c ↔ a ≤ c * b)` form. Same
goes for `lt_div_iff` → `lt_div_iff₀`, `div_le_one` → `div_le_one₀`, etc.

### `Set.Nonempty (f '' s)` constructor

`Set.Nonempty s = ∃ x, x ∈ s`. For image:

```lean
-- BAD: anonymous-constructor over-flattens
have : (f '' s).Nonempty := ⟨_, hx_in_s, rfl⟩  -- type error

-- GOOD: use Set.mem_image_of_mem to construct the membership proof
have : (f '' s).Nonempty := ⟨_, Set.mem_image_of_mem _ hx_in_s⟩
```

### `ConcaveOn.inf` not `ConcaveOn.min`

```lean
-- CORRECT: min of two concave functions (ℝ-valued)
hf.inf hg  -- type: ConcaveOn _ _ (f ⊓ g)

-- WRONG: .min doesn't exist
hf.min hg  -- error: "Invalid field `min`"
```

### `add_const` on `ConcaveOn` produces a Pi-add form

```lean
h_neg_id.add_const 1
-- produces: ConcaveOn _ _ ((fun η => -η) + fun _ => 1)
-- NOT:      ConcaveOn _ _ (fun η => 1 - η)
```

Bridge the gap with `convert`:
```lean
convert h_neg_id.add_const 1 using 1
ext η; simp [Pi.add_apply]; ring
```

### `LinearMap.id.concaveOn` needs an explicit `Convex` arg

```lean
have h_cvx : Convex ℝ (Set.Icc (0:ℝ) 1) := convex_Icc 0 1
have h_id : ConcaveOn ℝ (Set.Icc (0:ℝ) 1) (fun η : ℝ => η) :=
  (LinearMap.id (R := ℝ) (M := ℝ)).concaveOn h_cvx
```

## Proved lemmas in this workspace

| Lemma | File | Description |
|---|---|---|
| `tent_normalized` | `Rigidity/Bracket.lean` | `T(η) = 2 min(η, 1-η)` is a `NormalizedScore` |
| `two_eta_le_of_normalized` | `Rigidity/Bracket.lean` | Chord lemma: `2η ≤ φ(η)` on `[0, 1/2]` for any normalized `φ` |
| `cPhi_eq_half_of_normalized` | `Rigidity/Bracket.lean` | Universal `c_φ = 1/2` for normalized scores (uses `sSup ∘ image` form) |
| `cellRate_nonneg` | `Rigidity/Bracket.lean` | `0 ≤ cellRate μ f P c` — ratio of `ENNReal.toReal`s |
| `cellRate_le_one` | `Rigidity/Bracket.lean` | `cellRate μ f P c ≤ 1` — handles `μ c = ∞` edge case via `toReal_mono` |
| `cellMass_toReal` | `Rigidity/Bracket.lean` | Definitional unfolding `(cellMass μ P c).toReal = (μ c).toReal` |
| `cellRate_mem_Icc` | `Rigidity/Bracket.lean` | Bundle `cellRate ∈ Set.Icc 0 1` |
| `min_self_one_sub_mem_Icc_zero_half` | `Rigidity/Bracket.lean` | `min η (1-η) ∈ [0, 1/2]` for `η ∈ [0, 1]` |
| `phi_eq_phi_min_symm` | `Rigidity/Bracket.lean` | `φ η = φ (min η (1-η))` for normalized φ via symmetry |
| `concave_on_Icc_zero_half` | `Rigidity/Bracket.lean` | Restrict concavity of normalized φ to `[0, 1/2]` |
| `sum_cellMass_eq_one` | `Rigidity/Bracket.lean` | `Σ_c (μ c).toReal = 1` for probability measure + finite partition |
| `bracket_lower` | `Rigidity/Bracket.lean` | `barPhi ≤ φ(epsilonStar)` — Jensen on `[0, 1/2]` |
| `bracket_upper` | `Rigidity/Bracket.lean` | `epsilonStar ≤ cPhi φ * barPhi` — chord-bound aggregation |
