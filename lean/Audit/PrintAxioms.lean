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

-- Theorem2.lean
#print axioms Rigidity.theorem2_forward
#print axioms Rigidity.cellRate_trivial_boolIndicator
#print axioms Rigidity.barPhi_trivial_boolIndicator
#print axioms Rigidity.epsilonStar_trivial_boolIndicator

-- Theorem2Prime.lean
-- (theorem1Prime removed 2026-06-05 — was vacuous `True ↔ True`, see audit notes.)
