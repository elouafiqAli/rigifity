import Mathlib

/-!
# Bracket — definitions and the binary bracket

Definitions: probability space, finite partition, partition-restricted Bayes
risk, partition functional, normalized score, tent, c_phi.

Theorems: universal `c_phi = 1/2` for normalized scores; the binary bracket
`bar phi(P) ≤ phi(eps*(P))` (lower endpoint) and `eps*(P) ≤ c_phi · bar phi(P)`
(upper endpoint), stated in inverse-free form to avoid committing to a
specific definition of `phi^{-1}` in the scaffold.

## Naming convention

In the manuscript these objects use `Π` for partitions; in Lean we use `P`
because `Π` is a reserved token in the dependent-product syntax `Π (x : α), β`.
The manuscript's `Π` and the Lean `P` denote the same `FinitePartition`.

## Provenance

* Manuscript: §1 (bracket display), §2 (preliminaries).
* Defining commits:
  - `(base)`   initial definitions of partition, Bayes risk, normalized score
  - `f556246`  Theorem 2 proof tightening (single-cell argument)
  - `779d533`  `c_phi = 1/2` universal for normalized scores
  - `6a86ffd`  grid-invariant ε-net partition + WL-faithful limit
  - `0a3e62c`  normalized-score hypothesis on bracket display (m-2 of audit 12)
  - `8850ddf`  cell-level vs partition-level Bayes risk in §1 notation (f-1)
* Bricks: `D-prob`, `D-part`, `D-eps*`, `D-bphi`, `D-norm`, `D-tent`, `D-cphi`,
  `T-bracket`.

Phase A scaffold: type signatures are present; all proofs are `sorry`.
Phase B will fill in `cPhi_eq_half_of_normalized`, `bracket_lower`,
`bracket_upper`.
-/

namespace Rigidity

open MeasureTheory Set

/-! ## D-part: partitions -/

/-- A finite measurable partition of `α`. Brick: `D-part`.
    Lean note: the manuscript uses `Π` for partitions; we use `P` here because
    `Π` is reserved for the dependent-product syntax in Lean. -/
structure FinitePartition (α : Type*) [MeasurableSpace α] where
  cells : Finset (Set α)
  measurable : ∀ c ∈ cells, MeasurableSet c
  disjoint : (cells : Set (Set α)).PairwiseDisjoint id
  covers : ⋃₀ (cells : Set (Set α)) = univ

/-- Refinement order on partitions: `P'` refines `P` iff every cell of `P'`
    lies inside a cell of `P`. (Manuscript: `Π' ⪰ Π`.) -/
def Refines {α : Type*} [MeasurableSpace α] (P' P : FinitePartition α) : Prop :=
  ∀ c' ∈ P'.cells, ∃ c ∈ P.cells, c' ⊆ c

@[inherit_doc] infix:50 " ⪰ " => Refines

/-- Mass of a cell under measure `μ`. (`P` is taken explicit even though only
    `μ c` is used, since cellMass is the partition-side projection conceptually.) -/
noncomputable def cellMass {α : Type*} [MeasurableSpace α] (μ : Measure α)
    (_P : FinitePartition α) (c : Set α) : ENNReal :=
  μ c

/-- Conditional rate of `f = true` given cell `c`, with the convention `0` when
    the cell has measure zero. Brick: cellRate (used by `D-eps*`, `D-bphi`).
    Phase B target: `(μ ({x | f x = true} ∩ c)).toReal / (μ c).toReal`. -/
noncomputable def cellRate {α : Type*} [MeasurableSpace α] (_μ : Measure α)
    (_f : α → Bool) (_P : FinitePartition α) (_c : Set α) : ℝ := by
  exact sorry

/-- Partition-restricted Bayes risk: `ε*(P) = Σᵢ pᵢ · min(ηᵢ, 1 - ηᵢ)`.
    Brick: `D-eps*`. Manuscript: §2 ¶1. -/
noncomputable def epsilonStar {α : Type*} [MeasurableSpace α] (μ : Measure α)
    (f : α → Bool) (P : FinitePartition α) : ℝ :=
  ∑ c ∈ P.cells, (cellMass μ P c).toReal *
    min (cellRate μ f P c) (1 - cellRate μ f P c)

/-- Partition functional `bar φ(P) = Σᵢ pᵢ · φ(ηᵢ)`.
    Brick: `D-bphi`. Manuscript: §2 ¶1. -/
noncomputable def barPhi {α : Type*} [MeasurableSpace α] (μ : Measure α)
    (φ : ℝ → ℝ) (f : α → Bool) (P : FinitePartition α) : ℝ :=
  ∑ c ∈ P.cells, (cellMass μ P c).toReal * φ (cellRate μ f P c)

/-! ## D-norm and D-tent: normalized scores -/

/-- A normalized score on [0, 1]: concave, continuous, symmetric (`φ η = φ (1-η)`),
    vanishing at the endpoints, `φ(1/2) = 1`, strictly increasing on [0, 1/2].
    Brick: `D-norm`. Manuscript: §2 ¶2. Refined by `0a3e62c` (m-2) and `8850ddf` (f-1)
    for the inline §1 hypothesis list. -/
structure NormalizedScore (φ : ℝ → ℝ) : Prop where
  concave_on : ConcaveOn ℝ (Set.Icc (0:ℝ) 1) φ
  continuous : ContinuousOn φ (Set.Icc (0:ℝ) 1)
  symmetric : ∀ η ∈ Set.Icc (0:ℝ) 1, φ η = φ (1 - η)
  vanishes_at_zero : φ 0 = 0
  vanishes_at_one : φ 1 = 0
  unit_at_half : φ (1/2) = 1
  strict_mono : StrictMonoOn φ (Set.Icc (0:ℝ) (1/2))

/-- The normalized 0-1 Bayes risk: `T(η) = 2 · min(η, 1 - η)`. Brick: `D-tent`. -/
def tent : ℝ → ℝ := fun η => 2 * min η (1 - η)

/-- The tent satisfies the normalized-score conditions. -/
theorem tent_normalized : NormalizedScore tent := by sorry

/-! ## D-cphi and T-bracket -/

/-- Upper bracket constant `c_φ = sup_{η ∈ (0, 1/2]} η / φ(η)`. Brick: `D-cphi`.
    Manuscript: §1 bracket display. -/
noncomputable def cPhi (φ : ℝ → ℝ) : ℝ := ⨆ η ∈ Set.Ioc (0:ℝ) (1/2), η / φ η

/-- Universal `c_φ = 1/2` for any normalized score. Chord argument: concavity
    above the chord through `(0, 0)` and `(1/2, 1)` gives `φ(η) ≥ 2η` on
    [0, 1/2], with equality at `η = 1/2`.
    Defining commit: `779d533`. -/
theorem cPhi_eq_half_of_normalized (φ : ℝ → ℝ) (_h : NormalizedScore φ) :
    cPhi φ = 1/2 := by sorry

/-- **Binary bracket — lower endpoint** (inverse-free form).
    For a normalized concave `φ`, with cell rates `ηᵢ` and `qᵢ := min(ηᵢ, 1-ηᵢ)`,
    symmetry gives `φ(ηᵢ) = φ(qᵢ)` and Jensen for concave `φ` on `[0, 1/2]`
    gives `Σ pᵢ φ(qᵢ) ≤ φ(Σ pᵢ qᵢ)`, i.e. `bar φ(P) ≤ φ(ε*(P))`.
    Applying `φ⁻¹` (which exists by `StrictMonoOn`) recovers `φ⁻¹(bar φ) ≤ ε*`.
    Brick: `T-bracket` (lower half). -/
theorem bracket_lower {α : Type*} [MeasurableSpace α] (μ : Measure α)
    (φ : ℝ → ℝ) (_h : NormalizedScore φ)
    (f : α → Bool) (P : FinitePartition α) :
    barPhi μ φ f P ≤ φ (epsilonStar μ f P) := by sorry

/-- **Binary bracket — upper endpoint** `ε*(P) ≤ c_φ · bar φ(P)`.
    Via the pointwise inequality `η ≤ c_φ · φ(η)` on `(0, 1/2]`, aggregated.
    Brick: `T-bracket` (upper half). -/
theorem bracket_upper {α : Type*} [MeasurableSpace α] (μ : Measure α)
    (φ : ℝ → ℝ) (_h : NormalizedScore φ)
    (f : α → Bool) (P : FinitePartition α) :
    epsilonStar μ f P ≤ cPhi φ * barPhi μ φ f P := by sorry

end Rigidity
