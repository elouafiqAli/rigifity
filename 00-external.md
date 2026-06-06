# Review — *The Achievable-Error Floor of Graph Neural Networks* (Draft 0.5)

Reviewer pass on **correctness of the mathematics, the assumptions, the models, and the context/positioning**, with a prioritized fix list at the end. Severity tags: **[Critical]** (must fix before submission), **[Minor]** (should fix), **[Strategic]** (positioning / venue).

---

## 0. Assessment strategy (the lens used)

The draft is a *transposition* paper: it claims no new decision theory and instead lifts classical calibration/comparison-of-experiments machinery onto the refinement lattice, then reads off GNN consequences. That shape dictates the review:

1. **Verify every bracket and theorem independently from the definitions** — don't trust the prose, re-derive the endpoints, the equivalences, and the constants. The risk in a transposition paper is not exotic error; it's a quiet sign slip or a misattributed step.
2. **Separate "theorem correct" from "exposition correct."** A proof can be sound while its verbal gloss or worked example points the wrong way — and a sharp ITCS/MFCS referee will catch the gloss even if the proof is right.
3. **Audit the assumptions for where they actually bind** (atomless realizability; the ε-net/Voronoi construction; the contractivity working-assumption) and confirm the paper flags each where it matters.
4. **Stress the novelty claims against the cited prior art** (Blackwell, BJM/Zhang, Reid–Williamson, Tewari–Bartlett, Ramaswamy–Agarwal) to see whether (i)–(iv) survive a hostile "this is just X applied to a lattice" reading.
5. **Numerically confirm the load-bearing example** (the §4.3 multiclass slack example) rather than eyeball it.

**Headline verdict.** The mathematics is, with one localized exception, correct and carefully hedged. Every theorem checks out on re-derivation; the honesty about *floor ≠ achieved error* is consistent and well-placed. The one substantive issue is an exposition bug in the **Theorem 2′ Step‑1 statement and its §4.3 worked example** — the proof itself is sound, but the verbal constraint is stated as the converse of what is derived, and the illustrative example demonstrates the converse rather than the actual Step‑1 violation. This is fixable in a paragraph but should be fixed, because it is exactly the kind of self-contradiction a careful referee will flag.

---

## 1. Correctness pass — theorem by theorem

All re-derived from the §2 definitions. ✓ = verified correct.

| Result | Status | Note |
|---|---|---|
| Bracket (§1): $\varphi^{-1}(\bar\varphi)\le\varepsilon^\ast\le c_\varphi\bar\varphi$ | ✓ | Lower via Jensen on convex $\varphi^{-1}$; upper via $\min(\eta,1-\eta)\le c_\varphi\varphi(\eta)$. |
| Universal $c_\varphi=\tfrac12$ | ✓ | Concavity above the chord $(0,0)\!-\!(\tfrac12,1)$ gives $\varphi\ge 2\eta$ on $[0,\tfrac12]$; sup attained at $\eta=\tfrac12$. Clean and worth keeping front-and-center. |
| Thm 1 (monotone ⟺ concave) | ✓ | Tower property + Jensen; atomless realizability correctly invoked for (ii)⇒(iii); density+continuity for general spaces. |
| Thm 2 (tent is unique exact score) | ✓ | Single-cell partition pins $\varphi(\eta)=2\eta$ on $[0,\tfrac12]$; symmetry closes it. Note the lower endpoint is *already* tight on single cells for any normalized $\varphi$; the constraint is delivered by the upper endpoint. |
| Cor 3 (smoothness forces slack) | ✓ | Strict concavity ⇒ strict Jensen on a two-cell partition ⇒ not the tent ⇒ inexact. Differentiable ⇒ not tent (corner at $\tfrac12$) ⇒ inexact. |
| Variance tighter than entropy upper instrument | ✓ | $4\eta(1-\eta)\le H_2(\eta)$ pointwise (both normalized to 1 at $\tfrac12$); since upper endpoint $=\bar\varphi/2$ for both, smaller $\bar\varphi$ wins. |
| §4.1 multiclass upper bound, Gini $c_{\varphi_G}=1$ | ✓ | $\sum\eta_c^2\le(\max\eta_c)\sum\eta_c=\max\eta_c$ ⇒ $R\le\varphi_G$ pointwise; ratio $=1$ at the center, so $c_{\varphi_G}=1$ exactly. Entropy: at-most-linear vanishing confirmed ($\varphi_H\sim s\log\frac1s\gg s=R$ near a vertex, ratio $\to0$; sup interior). |
| §4.1 lower bound via $\ell_\varphi^{\ast\ast}$ | ✓ | $R\ge\ell_\varphi(\varphi)\ge\ell_\varphi^{\ast\ast}(\varphi)$ pointwise; Jensen on convex $\ell_\varphi^{\ast\ast}$. Binary collapse to $\varphi^{-1}$ correct. |
| **Thm 2′ (Simplex Rigidity)** | **✓ proof / ✗ exposition** | Proof (Steps 1–3) is correct. Step‑1 *verbal statement* and the §4.3 worked example are wrong — see §2 below. |
| Thm 1′ (refinement transfer to simplex) | ✓ | Dimension-agnostic tower + Jensen. |
| Cor 4 (aggregator half-chain) | ✓ | sum+injective-MLP = multiset-injective ⇒ $\Pi_{\rm sum}$ refines $\Pi_{\rm mean},\Pi_{\rm max}$; mean/max incomparable (counterexamples valid: $\{0,2\}$ vs $\{1,1\}$; $\{1,2\}$ vs $\{0,2\}$). Floor-not-achieved caveat correctly loud. |
| Thm 5 (depth-monotonicity, two directions) | ✓ | (a) Thm 1 along the chain; (b) contrapositive via a straddling cell. One **[Minor]** positive-mass caveat — see §3. |
| Prop 6 (two-query identity) | ✓ | $p_{\rm dis}=2\mathbb E[\mathrm{Var}(f\mid\Pi)]=\bar\varphi_{\rm var}/2\cdot2$; bracket $[\tfrac12(1-\sqrt{1-2p_{\rm dis}}),\,p_{\rm dis}]$ re-derived exactly. $p_{\rm dis}\le\tfrac12$ always, so the square root is real. |
| Cor 7 (label complexity) | ✓ | Standard Hoeffding $m=\lceil\ln(2/\delta)/2\alpha^2\rceil$, independent of $n$; cost accounting (no false sublinearity claim) is honest. |

**Numerically confirmed** (independent script): the §4.3 example values (Gini $0.62/0.50$, entropy $1.485/1.000$ bits, partition slack $0.060$); and the property-test sandwich $\varepsilon^\ast\le p_{\rm dis}\le 2\varepsilon^\ast$ (100k random binary partitions, no violations) — which is what underwrites the completeness *and* soundness of the §7 test.

---

## 2. [Critical] The Theorem 2′ Step‑1 statement and the §4.3 example are the converse of what is proved

**The proof is fine — do not touch the three steps.** Step 2 correctly uses $G(\varphi(\boldsymbol\eta_j))=R(\boldsymbol\eta_j)$, Jensen-equality forces $G$ affine, vertices pin it linear. The theorem ("only $\lambda R$ is exact") is correct.

**The bug is verbal, and it propagates into the example.** Step 1 derives, from single-cell partitions,
$$
R(\boldsymbol\eta)=G\big(\varphi(\boldsymbol\eta)\big)\quad\text{for all }\boldsymbol\eta,
$$
i.e. **$R$ is a function of $\varphi$** — equivalently, *$R$ is constant on $\varphi$-level sets*, equivalently *$\varphi$'s level sets refine $R$'s*. The dash-gloss in the draft ("$\varphi(\boldsymbol\eta)=\varphi(\boldsymbol\eta')\Rightarrow R(\boldsymbol\eta)=R(\boldsymbol\eta')$") and the "equivalently, $\varphi$'s level sets refine $R$'s" are **both correct**.

But the headline phrase that opens the sentence — *"an exact $\varphi$ must be constant on $R$-level sets"* — says the **converse**: "$R(\boldsymbol\eta)=R(\boldsymbol\eta')\Rightarrow\varphi(\boldsymbol\eta)=\varphi(\boldsymbol\eta')$", i.e. *$\varphi$ is a function of $R$*. The sentence therefore contradicts itself, and it contradicts your own (correct) statement in §4.1 that "$\varphi$ … is generally *not* a function of $R$" and the §4.4 remark.

The §4.3 worked example then illustrates the **wrong direction**:
$$
\boldsymbol\eta=(0.5,0.3,0.2),\quad \boldsymbol\eta'=(0.5,0.5,0):\qquad R=R'=0.5,\quad \varphi_G=0.62\ne0.50=\varphi_G'.
$$
This pair has *same $R$, different $\varphi_G$* — it shows $\varphi_G$ is **not a function of $R$**, which is a true statement and exactly the §4.1 point about why the lower endpoint is implicit. It is **not** a violation of Step 1: two different $\varphi_G$-values can perfectly well map to the same $R$ under $G$, so $R=G\circ\varphi$ is not contradicted by this pair at all.

**The genuine Step‑1 violation needs *same $\varphi$, different $R$*** (so that $R=G\circ\varphi$ becomes impossible). It exists — fix Gini and move the max:
$$
\boldsymbol\eta=(0.6,\,0.373,\,0.027),\quad \boldsymbol\eta'=(0.5,\,0.5,\,0):\qquad \varphi_G=\varphi_G'=0.50,\quad R=0.40\ne0.50=R'.
$$
(Construction: $\sum_c\eta_c^2=0.5$ with two distinct maxima; verified numerically.) Here $G$ would have to send the single value $0.50$ to both $0.40$ and $0.50$ — impossible — so $R$ is not a function of $\varphi_G$ and Step 1 genuinely fails.

**Recommended fix (one paragraph).** Either:
- **(A) Restate Step 1 correctly** as "*$R$ must be constant on $\varphi$-level sets ($R=G\circ\varphi$)*" and replace the §4.3 example used to illustrate the rigidity-step with the *same-Gini/different-$R$* pair above; **then** present the original *same-$R$/different-Gini* pair separately as the **slack mechanism** for Corollary 3′ (it correctly shows smooth scores resolving *inside* an $R$-level set, which is the right intuition for the slack). Or:
- **(B)** Keep the current example but relabel it: it illustrates "$\varphi_G$ is not a function of $R$ ⇒ the lower endpoint is implicit / smooth scores carry slack," and **decouple it from "violates Step 1."**

I'd take (A): it keeps the proof's logic and the slack intuition both visible and correctly attributed. Net effect on the result: zero. Net effect on referee confidence: large.

---

## 3. [Minor] Smaller gaps and caveats

- **Thm 5(b), positive-mass caveat.** The contrapositive needs $C\cap A$ and $C\cap B$ to both have positive measure for the depth-$(L{+}1)$ floor to be *strictly* positive. On an atomless space with the stated straddling this is generic, but state it: "where $A,B$ and the straddling cell $C$ have $C\cap A, C\cap B$ of positive mass." One clause.
- **§6 contractive decay $\delta^{(L)}\le C\lambda_2^L$.** You already defer the constant to OP2 and call it a working assumption — good. Flag explicitly that the *nontrivial* part is the **min over pairs**: a geometrically contracting per-pair separation does not by itself force the *minimum* separation to contract geometrically unless the worst-separated pair is stable (or the contraction is uniform across the non-leading spectrum). You mention "worst-separated pair remains worst-separated" inside OP2; promote that half-sentence to the main text where the bound is first asserted, so the reader sees the load-bearing assumption at the point of use.
- **ε-net dependence.** The $O(\varepsilon)$-measure boundary disagreement is handled honestly; consider stating the constant's dependence on the *embedding density near Voronoi boundaries* a touch more precisely, since that's where a referee will poke for the "operational" claims.
- **§3.2 lower endpoint is tight on single cells.** Minor expository nicety: the bracket's lower endpoint already equals $\varepsilon^\ast$ for *any* normalized $\varphi$ on a single cell, so the §3.2 uniqueness argument is genuinely a statement about the *upper* endpoint. Saying so makes the asymmetry (which you exploit) explicit.
- **Abstract density.** One ~450-word paragraph. ITCS/MFCS tolerate it, but a 3-sentence lead before the dense part would help the page-2 reader who decides whether to keep going.

---

## 4. Assumptions & models — audit

- **Atomless realizability.** Correctly and consistently invoked wherever arbitrary splits/rates are needed (Thms 1, 2, 2′, 1′), with the density+continuity fallback for general spaces. No over-reach.
- **Hard cell assignments.** Scope is stated honestly and repeatedly; §4 extends the *label* axis to multiclass; soft *cell* assignment is correctly quarantined to OP1b (the Markov-kernel lifting). The OP1a/OP1b split is exactly the right cut — multiclass labels ≠ multiclass assignment, and conflating them would be the easy mistake; you avoid it.
- **WL-faithfulness / the three partitions $\Pi_{\rm WL}\supseteq\Pi_{\mathcal A}\supseteq\Pi_\varepsilon$.** This is the cleanest part of the modeling. Localizing over-smoothing to the *gap* between the monotone-refining WL ceiling and the collapsing operational partition is genuinely clarifying and is the paper's best modeling idea after the bracket itself.
- **Contractivity (GCN/mean).** Imported as a working assumption matching Oono–Suzuki / Cai–Wang; appropriately not claimed as proved (OP2). Fine.

No assumption is silently load-bearing; the one place an assumption is doing more work than the surrounding prose admits is the min-over-pairs point in §3 above.

---

## 5. [Strategic] Context, novelty, and venue fit

- **The transposition claim survives the hostile reading, but barely, on its own.** "Calibration on the resolution axis instead of the optimization axis" is a real reframing, and you credit Savage/DeGroot/Grünwald–Dawid, Blackwell/Le Cam, and BJM/Zhang/Reid–Williamson precisely. A referee *will* say "Theorems 1–2 are Blackwell + the BJM identity-$\psi$ fact on a lattice." Your pre-emption ("we do not claim these as new decision theory") is the correct defense. The weight of novelty therefore rests on (a) **Thm 2′**, (b) the **GNN corollaries** (Cor 4, Thm 5, the local test), and (c) the **conceptual lattice framing**. Make sure the abstract and intro put (a) and (b) first, not the transposition slogan — the slogan is the frame, not the contribution.
- **Thm 2′ vs multiclass calibration literature.** You hedge ("not stated in this form … though in the spirit of"). Strengthen the comparison: state in one sentence how the *resolution-level* uniqueness of $R=1-\max_c\eta_c$ differs from the classical "$0$-$1$ loss is the unique self-calibrated multiclass loss" and from the *calibration-dimension* results of Ramaswamy–Agarwal and the negative results of Tewari–Bartlett / Pires–Szepesvári. As written a referee in that community may suspect it's a restatement; one precise contrast sentence defuses that.
- **The "so what does it predict" pressure.** Because floor ≠ achieved (which you handle honestly), the practical payload is: feasibility ceilings + a cheap label-complexity-$O(\alpha^{-2})$ diagnostic. That's a clean theory contribution but a *limited* empirical promise. For a **theory venue (ITCS/MFCS)** this is the right paper and the deferral of experiments is fine. For **ICLR** the companion will live or die on showing the bracket/floor *predicts something measurable that practitioners don't already know* — start thinking now about what specific, falsifiable prediction the empirical paper makes beyond "GCN over-smooths" (which is known).
- **PCP framing and FOCS.** You use PCP strictly as analogy and own that you have the locally-checkable half (Prop 6/Cor 7) but not gap amplification (OP3). That honesty is correct and necessary. Concretely for venue: **as written this is a strong ITCS/MFCS submission, not yet a FOCS one** — the PCP framing only "earns its keep" (your words) once OP3 is a theorem, and the hardness-of-approximation-for-expressivity payoff is what a FOCS PC would want to see. If FOCS 2026 visibility is the goal, OP3 (even a restricted gap-amplification on a structured graph family) is the single highest-leverage thing to crack; absent that, route this to ITCS/MFCS as the theory spine and let it do exactly that job in the serialization plan.
- **Fit with the serialization.** This reads as the *foundational/theory* paper, upstream of the lossy/randomized variant (which you correctly defer in §7 to the companion, with the right #P-hardness / bounded-treewidth / Provan–Ball framing). Coherent with a theory→empirical→ablation split.

---

## 6. Prioritized action list

1. **[Critical]** Fix Theorem 2′ Step‑1: state the constraint as **$R=G\circ\varphi$ ("$R$ constant on $\varphi$-level sets")**, and either swap in the same-Gini/different-$R$ example $\{(0.6,0.373,0.027),(0.5,0.5,0)\}$ to illustrate the Step‑1 violation, or relabel the current example as the *slack mechanism* for Cor 3′ and detach it from Step 1. Reconcile with §4.1/§4.4 (where you already say $\varphi$ is *not* a function of $R$). *Proof unchanged.*
2. **[Minor]** Add the positive-mass clause to Thm 5(b).
3. **[Minor]** Promote the "worst-separated pair stable / uniform contraction" assumption to the point of use in §6, not only OP2.
4. **[Strategic]** Add one precise contrast sentence positioning Thm 2′ against Tewari–Bartlett / Ramaswamy–Agarwal / Pires–Szepesvári.
5. **[Strategic]** Reorder abstract/intro emphasis so Thm 2′ + GNN corollaries lead and the transposition is the frame; decide venue (ITCS/MFCS now vs FOCS-conditional-on-OP3) and aim the framing accordingly.
6. **[Minor]** Trim/lead the abstract; add the §3.2 "single cells already pin the lower endpoint" remark.

Nothing here threatens a result. The paper is in good mathematical health for Draft 0.5; the one critical item is a self-contradiction in prose that the proof itself already gets right.