"""One-shot script: reformat the three Draft-X closing notes at the tail of
03-t0-achievable_error_floor.md into a structured ## Revision history section
with proper bullet lists. Idempotent: detects the structured form and skips."""

import sys
from pathlib import Path

PAPER = Path(r"c:\Users\aelouafiq\workdir\rigidity\03-t0-achievable_error_floor.md")


REPLACEMENT = """## Revision history

### Draft 0.6 — round 6 external audit (`00-external.md`)

Closes the external reviewer audit in full. Items addressed:

- **C-1** — Theorem 2′ Step 1 headline corrected from the converse (*"exact $\\varphi$ must be constant on $R$-level sets"*) to the actual derivation (*"$R$ must be constant on $\\varphi$-level sets"*, i.e. $R = G \\circ \\varphi$); the dash-gloss and "equivalently" that followed were already correct, only the headline was inverted. §4.3 reorganized into:
  - **Worked example A** — a new Step 1 violation with rational $\\boldsymbol\\eta=(2/3,1/6,1/6)$ vs $(1/2,1/2,0)$: both have Gini exactly $1/2$ but different $R$ — an explicit same-$\\varphi$ / different-$R$ violation.
  - **Worked example B** — the original same-$R$ / different-Gini example, now correctly framed as the *slack mechanism* showing $\\varphi$ is not a function of $R$ (not a Step 1 violation, but the reason the bracket opens).
  - Proof of Theorem 2′ unchanged.
- **M-1** — Theorem 5(b) positive-mass clause added: the straddling cell $C$ must have $C \\cap A$ and $C \\cap B$ both of positive mass (generic on an atomless space).
- **M-2** — §6 worst-pair-stability assumption promoted from OP2 to point of use: the bound $\\delta^{(L)} \\le C \\lambda_2^L$ now explicitly carries the "worst-separated pair remains worst-separated through depth, or equivalently uniform contraction across the non-leading spectrum" qualifier at the point of assertion.
- **M-3** — §3.2 proof of Theorem 2 surfaces that the lower endpoint $\\varphi^{-1}(\\varphi(\\eta)) = \\eta$ is automatically tight on single cells for every normalized $\\varphi$; exactness on single cells is therefore a purely *upper-endpoint* constraint.
- **S-1** — §1.2 adds a precise contrast sentence positioning Theorem 2′ against Tewari–Bartlett, Ramaswamy–Agarwal, Pires–Szepesvári: their results concern when a smooth surrogate's *minimizer* matches the Bayes *predictor*; ours concerns when a smooth surrogate's partition-level *aggregate* determines $\\varepsilon^\\ast$. Consistency in their sense does not imply exactness in ours.
- **S-2** — Abstract restructured into a punchy lead paragraph + a scope/honesty paragraph, with the GNN consequences, multiclass rigidity, and local test leading and the transposition framing demoted to organizing principle. §1.1 contributions list reordered correspondingly (prior items (i)–(iii) become new (1)–(3); transposition framing becomes new (4)).
- Plus: Theorem 1 statement now reads "all measurable labelings" (round 5 followup, paper–Lean reconciliation per [`16-end-to-end-audit-and-publishability.md`](16-end-to-end-audit-and-publishability.md) Risk 5).
- Plus: §1.2 adds a **Mechanization** paragraph announcing the Lean 4 kernel against mathlib v4.29.1.

**Closed audit items.** All previously-closed items of `05`, `07`, `10`, `12`, and round 5 (Draft 0.5 closing notes below) remain closed and are re-verified by this draft.

**Still open.** OP1b (soft cell assignments), OP2 (quantitative over-smoothing rate), OP3 (gap amplification), the empirical companion, and the closed-form $\\ell_\\varphi$ for entropy and Gini.

**Mechanization status.** Both the §3 binary spine **and** the §4.2 simplex rigidity (Theorem 2′) are mechanically verified end-to-end in Lean 4 — 57 axiom-clean theorems against mathlib v4.29.1 (Phase C2 commit `8339f60`, Phase D commit `pending`).

### Draft 0.5 — round 5 polishing pass (on top of Draft 0.4)

Retires the seven items found by a final independent review:

- **M-1** — Theorem 1′ now carries the atomless realizability hypothesis, completing the propagation begun in commits `c8ef3e6` / `23814f7` / `07ddde8`, so that Theorems 1, 1′, 2, 2′ all share parallel statements.
- **m-1** — §6 GIN body wording aligned with the §5 "sum + injective MLP" correction: multiset sum alone is not injective on multisets; the sum + injective-MLP composition is, per Xu et al. 2019 Lemma 5.
- **m-2** — §1's inline normalized-score definition now lists "symmetric", matching the full §2 definition that the proof of Theorem 2 uses to extend $\\varphi = 2\\eta$ from $[0, 1/2]$ to $[0, 1]$.
- **m-3** — The two consecutive normalized-score parentheticals in §1 are consolidated; the chord-argument paragraph reads "for any such $\\varphi$" instead of re-stating the definition.
- **m-4** — §1 notation paragraph clarifies that $R$ as a *symbol* appears only in §4, while the binary case uses $\\varepsilon^\\ast$ and the normalized tent $T$ directly.
- **m-5** — §4 opener "binary argument transported to the simplex" tightened to match §4.2's closing remark: the proof has the same three-step skeleton, but the binary case collapses to Step 1 alone via symmetry while the simplex case genuinely uses all three steps.
- **m-6** — §5 setup adds an explicit defining sentence for $\\Pi_{\\mathrm{sum}}$, $\\Pi_{\\mathrm{mean}}$, $\\Pi_{\\mathrm{max}}$ as the per-aggregator equivalence partitions.

**Closed audit items.** All previously-closed items of `05`, `07`, `10`, `12` remain closed and are re-verified.

**Still open.** OP1b (soft cell assignments), OP2 (quantitative over-smoothing rate), OP3 (gap amplification), the empirical companion, the closed-form $\\ell_\\varphi$ for entropy and Gini, and the mechanization kernel (deferred per `09-mechanization_strategy.md`).

### Draft 0.4 — round 4 external audit (`12-external_reviewer_second_audit_of_draft0.3.md`)

Closes the external reviewer audit in full. Items addressed:

- **C-1** — Corollary 4 restated as a *half-chain* $\\varepsilon^\\ast(\\Pi_{\\mathrm{sum}}) \\le \\min\\{\\varepsilon^\\ast(\\Pi_{\\mathrm{mean}}), \\varepsilon^\\ast(\\Pi_{\\mathrm{max}})\\}$, with the explicit caveat that $\\Pi_{\\mathrm{mean}}$ and $\\Pi_{\\mathrm{max}}$ are incomparable on multisets (two-line counterexamples in §5). The previous chain $\\Pi_{\\mathrm{sum}} \\succeq \\Pi_{\\mathrm{mean}} \\succeq \\Pi_{\\mathrm{max}}$ was mathematically false. Abstract, §1.1 item 2, §5 caveat, and §8 opener synced.
- **M-1** — Theorem 1 statement now carries the atomless realizability hypothesis lifted from the parenthetical in (ii) $\\Rightarrow$ (iii), matching the surgery commit `c8ef3e6` applied to Theorem 2′ in Draft 0.2.
- **M-2** — Theorem 2 statement gets the same hypothesis lift, closing the consistency gap with Theorem 2′ that was missed because audit `07` was scoped narrowly to the simplex companion.
- **M-3** — The false labels "same-distribution coarsening" for $\\Pi_{\\mathrm{mean}}$ and "same-support coarsening" for $\\Pi_{\\mathrm{max}}$ in §5 replaced with precise per-aggregator equivalence definitions, with two-line counterexamples explicating the incomparability.
- **M-4** — Theorem 2′ Step 2 now uses $\\varphi_{\\max} := \\max_{\\boldsymbol\\eta \\in \\Delta^{k-1}} \\varphi(\\boldsymbol\\eta)$ via Weierstrass, dropping the over-asserted $\\varphi_{\\max} = \\varphi(\\mathbf u)$ that would have required permutation symmetry the theorem only *concludes*.
- **m-1** — Theorem 2′ Step 3 $a > 0$ justification corrected: the previous citation of $\\varphi > 0$ on interior was not a hypothesis; replaced with a non-constancy argument (if $a = 0$ then $R \\equiv 0$, contradicting $R(\\mathbf u) = 1 - 1/k > 0$).
- **m-2** — §1 bracket display now explicitly names the normalized-score hypothesis required for $\\varphi^{-1}$ to make sense.
- **m-3** — §5 "sum is injective" (informally wrong since multiset sum is not injective on multisets of reals) corrected to "sum composed with an injective MLP (the GIN construction) realises a multiset-injective aggregator"; bundled with C-1.
- **m-4** — §5 Cor 4 vestigial "for every concave score" qualifier dropped during the C-1 restatement.
- **m-5** — §8 OP1b citation "in 1a" → "Theorem 2′" for accuracy.
- **m-6** — §2 $O(\\varepsilon)$ tube-measure clause now qualifies the constant by embedding dimension and local density.

**Closed audit items.** All previously-closed items of `05`, `07`, `10` remain closed and are re-verified.

**Still open.** OP1b (soft cell assignments), OP2 (quantitative over-smoothing rate), OP3 (gap amplification), the empirical companion, the closed-form $\\ell_\\varphi$ for entropy and Gini, and the mechanization kernel (deferred per `09-mechanization_strategy.md`).

**Execution log.** [`13-draft0.4_commitology.md`](13-draft0.4_commitology.md).
"""


def main() -> int:
    text = PAPER.read_text(encoding="utf-8")
    if "## Revision history" in text:
        print("Already formatted; skipping.")
        return 0
    # Find the closing-notes block: starts at the line "*Draft 0.6 closes..."
    marker = "*Draft 0.6 closes the external reviewer audit"
    idx = text.find(marker)
    if idx == -1:
        print("ERROR: could not find Draft 0.6 closing-notes marker", file=sys.stderr)
        return 1
    # Backtrack to the start of the line (find preceding newline).
    line_start = text.rfind("\n", 0, idx) + 1
    header = text[:line_start]
    # Strip any trailing whitespace + blank lines from the header.
    header = header.rstrip() + "\n\n"
    new_text = header + REPLACEMENT.lstrip()
    PAPER.write_text(new_text, encoding="utf-8")
    print(f"Reformatted closing notes. New line count: {len(new_text.splitlines())}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
