import Rigidity

/-!
# Audit: print axioms used by every proved theorem.

Run via:

```bash
wsl -d Debian -- bash -lc 'cd ~/rigidity-build && lake env lean Audit/PrintAxioms.lean 2>&1 | tail -100'
```

Expected: every theorem uses only `propext`, `Classical.choice`, `Quot.sound`
(the three "trusted" Lean axioms) — no `sorryAx`, no other `axiom`s.
-/

-- Bracket.lean
#print axioms Rigidity.tent_normalized
#print axioms Rigidity.two_eta_le_of_normalized
#print axioms Rigidity.cPhi_eq_half_of_normalized
#print axioms Rigidity.cellRate_nonneg
#print axioms Rigidity.cellRate_le_one
#print axioms Rigidity.cellMass_toReal
#print axioms Rigidity.cellRate_mem_Icc
#print axioms Rigidity.cellRate_mul_cellMass
#print axioms Rigidity.refines_trivialPartition
#print axioms Rigidity.sum_measure_inter_eq
#print axioms Rigidity.cellRate_trivial_eq_sum
#print axioms Rigidity.cellRate_trivial
#print axioms Rigidity.barPhi_trivial
#print axioms Rigidity.min_self_one_sub_mem_Icc_zero_half
#print axioms Rigidity.phi_eq_phi_min_symm
#print axioms Rigidity.concave_on_Icc_zero_half
#print axioms Rigidity.sum_cellMass_eq_one
#print axioms Rigidity.bracket_lower
#print axioms Rigidity.bracket_upper
#print axioms Rigidity.epsilonStar_nonneg
#print axioms Rigidity.epsilonStar_le_half
#print axioms Rigidity.barPhi_tent_eq_two_epsilonStar
#print axioms Rigidity.tent_epsilonStar_eq_two_epsilonStar

-- Bracket.lean (Phase C2 — refinement-monotonicity infrastructure)
#print axioms Rigidity.mem_refining_iff
#print axioms Rigidity.refining_pairwiseDisjoint
#print axioms Rigidity.biUnion_refining_eq
#print axioms Rigidity.barPhi_eq_filter_nonempty
#print axioms Rigidity.sum_cellMass_refining_eq
#print axioms Rigidity.sum_measure_refining_inter_eq
#print axioms Rigidity.cellRate_mul_cellMass_refining_sum

-- Theorem2.lean
#print axioms Rigidity.theorem2_forward
#print axioms Rigidity.cellRate_trivial_boolIndicator
#print axioms Rigidity.barPhi_trivial_boolIndicator
#print axioms Rigidity.epsilonStar_trivial_boolIndicator
#print axioms Rigidity.theorem2_reverse
#print axioms Rigidity.theorem2

-- Proposition6.lean
#print axioms Rigidity.two_query_identity
#print axioms Rigidity.phiVar_normalized
#print axioms Rigidity.barPhi_phiVar_eq_two_pDisagree
#print axioms Rigidity.variance_bracket

-- Theorem1.lean (Phase C2/C3/C4 — refinement-monotonicity ⟺ concavity)
#print axioms Rigidity.barPhi_refinement_le
#print axioms Rigidity.theorem1_easy
#print axioms Rigidity.theorem1_hard
#print axioms Rigidity.theorem1

-- Theorem2Prime.lean (Phase D — simplex rigidity infrastructure + Steps 1/3)
#print axioms Rigidity.Simplex.R_vertex_eq_zero
#print axioms Rigidity.Simplex.R_center
#print axioms Rigidity.Simplex.R_center_pos
#print axioms Rigidity.Simplex.center_mem_simplex
#print axioms Rigidity.Simplex.vertex_mem_simplex
#print axioms Rigidity.Simplex.cellRateSimplex_trivial
#print axioms Rigidity.Simplex.epsilonStarSimplex_trivial
#print axioms Rigidity.Simplex.barPhiSimplex_trivial
#print axioms Rigidity.Simplex.sum_measure_fiber_inter
#print axioms Rigidity.Simplex.cellRateSimplex_mem_simplex
#print axioms Rigidity.Simplex.phi_eq_lam_R_of_step1_affine
-- (theorem1Prime removed 2026-06-05 — was vacuous `True ↔ True`, see audit notes.)
