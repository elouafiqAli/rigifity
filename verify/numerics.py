#!/usr/bin/env python3
"""
numerics.py — re-verify the §4.3 worked example (W43) and the Corollary 4
incomparability counterexamples over exact rationals.

Exit codes:
    0  all checks PASS
    1  any check FAILS (assertion error; details on stderr)

Pure-Python, standard library only (`fractions` for exact arithmetic).
No third-party deps. Python 3.9+.

Provenance:
    Manuscript: §4.3 worked example; §5 aggregator half-chain (Corollary 4).
    Defining commits:
        77b7c93 — §4.3 smoothness–slack + worked example landed
        963fe94 — Cor 4 half-chain + mean/max incomparability counterexamples
    Brick targets:
        W43 — §4.3 numerical verification (Lean redundancy in WorkedExample.lean)
        C4  — incomparability of Pi_mean and Pi_max in the refinement lattice
"""

from __future__ import annotations
import sys
from fractions import Fraction


def gini(eta: list[Fraction]) -> Fraction:
    """Gini impurity: phi_G(eta) = 1 - sum eta_c^2."""
    return Fraction(1) - sum((x * x for x in eta), start=Fraction(0))


def bayes_risk(eta: list[Fraction]) -> Fraction:
    """Cell-level Bayes risk: R(eta) = 1 - max_c eta_c."""
    return Fraction(1) - max(eta)


def check_worked_example() -> None:
    """N1: §4.3 worked example over Fraction."""
    eta = [Fraction(1, 2), Fraction(3, 10), Fraction(1, 5)]
    eta_p = [Fraction(1, 2), Fraction(1, 2), Fraction(0)]
    eta_min = [Fraction(3, 5), Fraction(1, 5), Fraction(1, 5)]

    # W43.1 — Same Bayes risk
    assert bayes_risk(eta) == Fraction(1, 2), \
        f"R(eta) = {bayes_risk(eta)}, expected 1/2"
    assert bayes_risk(eta_p) == Fraction(1, 2), \
        f"R(eta') = {bayes_risk(eta_p)}, expected 1/2"

    # W43.2 — Gini distinguishes
    assert gini(eta) == Fraction(31, 50), \
        f"phi_G(eta) = {gini(eta)}, expected 31/50 (= 0.62)"
    assert gini(eta_p) == Fraction(1, 2), \
        f"phi_G(eta') = {gini(eta_p)}, expected 1/2 (= 0.50)"

    # W43.3 — Lower bracket witness
    assert gini(eta_min) == Fraction(56, 100), \
        f"phi_G(eta_min) = {gini(eta_min)}, expected 56/100 (= 0.56)"
    assert bayes_risk(eta_min) == Fraction(2, 5), \
        f"R(eta_min) = {bayes_risk(eta_min)}, expected 2/5 (= 0.40)"

    # W43.4 — Two-cell partition aggregate (p1 = p2 = 1/2)
    bar_gini = (gini(eta) + gini(eta_p)) / 2
    bar_R = (bayes_risk(eta) + bayes_risk(eta_p)) / 2
    assert bar_gini == Fraction(56, 100), \
        f"bar phi_G = {bar_gini}, expected 56/100"
    assert bar_R == Fraction(1, 2), \
        f"bar R (= eps*) = {bar_R}, expected 1/2"

    # W43.5 — Positive slack
    slack = bar_gini - bar_R
    assert slack == Fraction(6, 100), f"slack = {slack}, expected 6/100"

    # W43.6 — Two-sided bracket confirmed: R(eta_min) < eps*
    assert bayes_risk(eta_min) < bar_R, \
        f"R(eta_min) = {bayes_risk(eta_min)} not < eps* = {bar_R}"

    print("[PASS] N1: §4.3 worked example (W43)")


def check_aggregator_incomparable() -> None:
    """N2: Pi_mean and Pi_max are incomparable in the refinement lattice."""
    # Counterexample 1: {0, 2} and {1, 1} share mean (= 1) but differ in max (2 vs 1)
    A = (Fraction(0), Fraction(2))
    B = (Fraction(1), Fraction(1))
    assert sum(A) == sum(B), \
        f"|A| * mean(A) = {sum(A)}, |B| * mean(B) = {sum(B)}; expected equal"
    assert max(A) != max(B), \
        f"max(A) = {max(A)}, max(B) = {max(B)}; expected unequal"

    # Counterexample 2: {1, 2} and {0, 2} share max (= 2) but differ in mean
    C = (Fraction(1), Fraction(2))
    D = (Fraction(0), Fraction(2))
    assert sum(C) != sum(D), \
        f"|C| * mean(C) = {sum(C)}, |D| * mean(D) = {sum(D)}; expected unequal"
    assert max(C) == max(D), \
        f"max(C) = {max(C)}, max(D) = {max(D)}; expected equal"

    # Both directions of non-implication confirmed:
    #   ~_mean does not imply ~_max  (Counterexample 1)
    #   ~_max  does not imply ~_mean (Counterexample 2)
    # Hence Pi_mean and Pi_max are incomparable in the refinement lattice.
    print("[PASS] N2: Corollary 4 incomparability counterexamples (C4)")


def check_normalized_variance_bracket() -> None:
    """N3 (bonus): Proposition 6 closed-form bracket arithmetic for a few partitions.

    For a two-cell partition with rates (eta_1, eta_2) and masses (p_1, p_2):
        bar phi_var = sum p_i * 4 eta_i (1 - eta_i)
        p_dis       = bar phi_var / 2
        upper       = p_dis
        lower       = (1 - sqrt(1 - 2 p_dis)) / 2

    Check the lower endpoint is well-defined (1 - 2 p_dis >= 0) and the bracket
    contains eps* = sum p_i min(eta_i, 1 - eta_i).
    """
    # Exact rationals where possible; sqrt forces float for the lower endpoint.
    import math

    def normalized_variance(eta: Fraction) -> Fraction:
        return 4 * eta * (1 - eta)

    def bracket(rates: list[Fraction], masses: list[Fraction]) -> tuple[float, float, float]:
        bar_phi = sum(p * normalized_variance(e) for p, e in zip(masses, rates))
        p_dis = bar_phi / 2
        eps_star = sum(p * min(e, 1 - e) for p, e in zip(masses, rates))
        upper = float(p_dis)
        lower = (1 - math.sqrt(1 - 2 * float(p_dis))) / 2 if 2 * p_dis <= 1 else float("nan")
        return (lower, float(eps_star), upper)

    # Case 1: pure cells — bracket should be tight at 0.
    rates = [Fraction(0), Fraction(1)]
    masses = [Fraction(1, 2), Fraction(1, 2)]
    lower, eps, upper = bracket(rates, masses)
    assert lower <= eps <= upper, f"pure-cell bracket fails: {lower} ≤ {eps} ≤ {upper}"
    assert abs(eps) < 1e-12, f"pure cells should give eps* = 0; got {eps}"

    # Case 2: balanced cells (eta = 1/2 each) — bracket at eps* = 1/2.
    rates = [Fraction(1, 2), Fraction(1, 2)]
    lower, eps, upper = bracket(rates, masses)
    assert lower <= eps <= upper + 1e-12, f"balanced bracket fails: {lower} ≤ {eps} ≤ {upper}"
    assert abs(eps - 0.5) < 1e-12

    # Case 3: a mixed case (eta = 1/4, 3/4)
    rates = [Fraction(1, 4), Fraction(3, 4)]
    lower, eps, upper = bracket(rates, masses)
    assert lower <= eps <= upper + 1e-12, f"mixed bracket fails: {lower} ≤ {eps} ≤ {upper}"

    print("[PASS] N3: Proposition 6 closed-form bracket on a few partitions")


def main() -> int:
    try:
        check_worked_example()
        check_aggregator_incomparable()
        check_normalized_variance_bracket()
    except AssertionError as e:
        print(f"[FAIL] {e}", file=sys.stderr)
        return 1
    print("\n[PASS] All numerics checks")
    return 0


if __name__ == "__main__":
    sys.exit(main())
