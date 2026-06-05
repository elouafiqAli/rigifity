# PI's Adversarial Audit of `04-t1_1_simplex_rigidity.md`

*Stress-test of the multiclass simplex companion. Conducted on the post-commit-`027ba89` version of `04` (i.e., after `04` was rephrased to drop the T9 reference and frame the soft-kernel lifting as Open Problem 1b of `03`).*

> **Headline.** The paper is fundamentally sound. The rigidity theorem (§3) and the smoothness–slack corollary (§4) hold as stated, and the proof structure (single-cell $\Rightarrow R = G\circ\varphi$, two-cell $\Rightarrow G$ affine, vertex $\Rightarrow$ pin constants) is the right multiclass adaptation of the binary argument. Residual issues are about presentation and hidden hypotheses, not about the mathematics. **Promotable to the next draft with the eight items below closed.**
>
> **Severity codes.** **C** critical (mathematical or framing flaw that invalidates a claim), **M** major (correct claim but mis-stated hypothesis, missing qualifier, or load-bearing parenthetical), **m** minor (presentation, wording, cross-reference, consistency).

---

## 1. Findings

### Critical

*None.*

### Major

**M-1. Atomless realizability is a hypothesis, not a parenthetical (§3).**
The exact-functional definition reads: *"…for every finite partition (over an atomless configuration, so that cells of arbitrary mass and arbitrary conditional distribution are realizable)."* The theorem statement that follows does not repeat this. Step 2 of the proof uses it twice — to vary $u_1, u_2$ independently over $[0, \varphi_{\max}]$, and to make $p_1 \in [0,1]$ free. A reader reading the theorem in isolation will miss the assumption that powers the strongest universality claim of the paper.
*Fix.* Either lift the hypothesis into the theorem statement, or mirror `03` Theorem 1's two-step pattern: prove on an atomless space, extend to general spaces by a density argument with continuity.

**M-2. $c_\varphi$ is assumed finite without comment (§2).**
The upper bound $\varepsilon^\ast \le c_\varphi\,\bar\varphi$ uses $c_\varphi := \sup_{\boldsymbol\eta \ne \text{vertex}} R(\boldsymbol\eta)/\varphi(\boldsymbol\eta)$. For any $\varphi$ vanishing *faster* than linearly at some vertex (e.g., $\varphi(\boldsymbol\eta) = \|\boldsymbol\eta - \mathbf e_c\|^2$), $c_\varphi = \infty$ and the upper bound is vacuous. The running examples (entropy, Gini) satisfy the regularity, but the hypothesis is not stated.
*Fix.* Add to the bracket statement: *"for scores with $c_\varphi < \infty$ — equivalently, $\varphi$ that vanishes at most linearly at every vertex; satisfied by entropy and Gini."*

### Minor

**m-1. "Coarsest concave functional" mis-states the theorem (§4).**
Final sentence: *"The Bayes risk is the coarsest concave functional that still resolves the achievable error."* The rigidity proves $R$ is the **unique** exact one (up to scalar) — a different and stronger claim. "Coarsest" requires a partial order on functionals and a notion of "resolve", neither defined.
*Fix.* Replace with the level-set framing: *$R$ is the unique functional (up to scalar) whose level sets coincide with the Bayes-risk level sets; every smooth score has strictly finer level sets, and the surplus is the slack.*

**m-2. "In general it is *dimension*" overstates the mechanism (§4 final line).**
The binary obstruction is the kink at $\eta=\tfrac12$. The multiclass obstruction is also kinks — on the loci $\{\eta_c = \eta_{c'} = \max\}$ where the argmax switches. *Dimension* is the **measure** of those loci, not the **mechanism**.
*Fix.* Say "*the kink locus widens from a point to a $(k-2)$-dimensional skeleton, but the mechanism (smooth scores can't reproduce kinks) is identical to the binary case.*"

**m-3. Step 1 buries the operative structural fact (§3 proof).**
Step 1 derives $R = G\circ\varphi$, equivalently *"$\varphi$'s level sets refine $R$'s"*. This is the load-bearing constraint exactness places on $\varphi$ — exactly the constraint §4's Gini-vs-Bayes example violates — but it is buried in the middle of a proof step.
*Fix.* Pull a one-sentence highlight: *"Step 1 says: an exact $\varphi$ must be constant on $R$-level sets; Steps 2–3 then pin the proportionality constant. The Gini and entropy examples of §4 violate Step 1 directly — they distinguish distributions $R$ identifies, and the rigidity theorem rules them out at that step."* Pre-positions the soft-kernel question (where the refinement-of-level-sets constraint gets relaxed).

**m-4. Step 2's "Jensen-equality forces affine" needs the boundedness footnote (§3 proof).**
The functional equation $p_1 G(u_1) + p_2 G(u_2) = G(p_1 u_1 + p_2 u_2)$ admits pathological (non-affine measurable) solutions if $G$ is unbounded — the standard Hamel-basis caveat. Here $G$ is bounded (image $\subseteq [0, 1-1/k]$) so the bounded-Jensen-implies-affine theorem applies, but the argument should say so for a careful referee.
*Fix.* Half-sentence: *"$G$ is bounded on $[0, \varphi_{\max}]$ (image lies in $[0, 1-1/k]$), so the Jensen-equality identity forces $G$ affine — no measurable pathology."*

**m-5. The preamble line is stale post-commit `027ba89` (header).**
Preamble: *"Resolves task T1.1. Slots into the Draft 0 as the multiclass section."* True when `04` was conceived as a section to be merged into `03`. After commit `d0f175b` split Open Problem 1 and commit `027ba89` updated `04` accordingly, `04` is now a *companion* document and `03` §8 cites it as such (OP1a).
*Fix.* Replace with: *"Multiclass companion to `03-t0-achievable_error_floor.md`; resolves Open Problem 1a of `03`."* (Or, if consolidated into `03`, this line vanishes entirely.)

**m-6. The simplex refinement-monotonicity analogue is not stated (§2 or §3).**
`03` Theorem 1 (refinement monotonicity of $\bar\varphi$) is a load-bearing pillar of the framework. The simplex analogue holds verbatim — the tower-property + Jensen argument is dimension-agnostic for concave permutation-symmetric scores on $\Delta^{k-1}$ — but `04` never states it. The bracket and rigidity sit on this scaffolding implicitly.
*Fix.* One-line statement: *"Theorem 1 of `03` — refinement monotonicity of $\bar\varphi$ — extends to the simplex without modification: for concave permutation-symmetric $\varphi$ on $\Delta^{k-1}$, $\Pi' \succeq \Pi \Rightarrow \bar\varphi(\Pi') \le \bar\varphi(\Pi)$, by the same tower-property + Jensen argument."* Closes the structural loop.

---

## 2. Strengths to record

1. The proof structure (single-cell $\Rightarrow R = G\circ\varphi$; two-cell $\Rightarrow$ $G$ affine; vertex $\Rightarrow$ $b=0$) is the *right* multiclass adaptation of the binary argument — no detours, no ad-hoc moves, and Step 1 generalizes the binary symmetry step in a structurally illuminating way.

2. The Fenchel-biconjugate lower endpoint $\ell_\varphi^{\ast\ast}$ is the correct machinery: it makes the binary closed form a corollary (level sets are singletons, $\ell_\varphi = \varphi^{-1}$ already convex) and the multiclass implicit form an honest deferral. The acknowledgement that the lower endpoint is *computable but not closed-form for entropy/Gini* is the right level of honesty.

3. The §4 worked example is concrete and *numerically verified*: $\boldsymbol\eta=(0.5, 0.3, 0.2)$ and $\boldsymbol\eta'=(0.5, 0.5, 0)$ both give $R=0.5$; Gini values $0.62$ and $0.50$, entropy $1.485$ and $1.000$ bits; the $p_1=p_2=\tfrac12$ partition has $\varepsilon^\ast=0.5$, $\bar\varphi_G = 0.56$, upper bound $0.56$ (slack $0.06$). The lower bracket is genuinely two-sided: minimizing $R$ on the level set $\{\varphi_G = 0.56\}$ gives $\boldsymbol\eta = (0.6, 0.2, 0.2)$ with $R = 0.4 < 0.5$.

4. The "honest positioning" in §6 correctly anchors the result in the multiclass surrogate-calibration literature (Tewari–Bartlett 2007, Ramaswamy–Agarwal 2012, Pires–Szepesvári 2016), and explicitly carves out the *resolution-level* contribution as new while crediting the optimization-level theory as classical.

5. Post-commit-`027ba89` framing of the soft-kernel extension as Open Problem 1b (not as a corollary) is structurally honest: the rigidity here is about *label* simplex $\Delta^{k-1}$, and the *cell-assignment* simplex $\Delta(\mathrm{Cells})$ needed for attention-style architectures is genuinely a separate question requiring a Markov-kernel lifting that nobody has constructed yet.

---

## 3. Prioritized fix list

| Priority | Tag | Item | Effort | Scope |
|---|---|---|---|---|
| 1 | M-1 | Lift atomless realizability into theorem hypothesis | small | §3 statement |
| 2 | M-2 | Note $c_\varphi < \infty$ on bracket | small | §2 statement |
| 3 | m-3 | Highlight Step 1 level-set refinement | small | §3 proof |
| 4 | m-4 | Bounded-Jensen footnote on Step 2 | small | §3 proof |
| 5 | m-1 | Replace "coarsest" with level-set coincidence | small | §4 closer |
| 6 | m-2 | Replace "dimension" with kink-locus widening | small | §4 final line |
| 7 | m-6 | State simplex refinement monotonicity (Thm 1 transfer) | small | §2 or §3 opener |
| 8 | m-5 | Update preamble (companion, not section) — *moot if consolidated* | trivial | header |

**Total effort: one focused editing pass.** None of the findings touch the main theorem; all are about hypothesis hygiene or presentation.

---

## 4. Verdict

`04` proves what it claims, and the proof is correct. The audit recommends two paths:

- **Path A (lightweight): `04` remains a companion document.** Apply the eight fixes in place, bump `04` to "Draft 0.1 of the companion," and continue treating it as a separate file cross-referenced from `03` §8 OP1a.

- **Path B (consolidation): fold `04` into `03` as §4.** `03`'s current §4 is a stub ("merged into §1.2"); the multiclass content lands there naturally with no renumbering. Apply the eight fixes *during* consolidation (no point landing known-broken text and then patching), collapse OP1a into a cross-reference to the new §4, bump `03` to Draft 0.2, retire `04`. Larger surface area, but the resulting paper is structurally complete and the eight items get cleared on the way.

PI recommendation: **Path B.** The papers were designed for it (preamble of `04` originally said "slots into the Draft 0 as the multiclass section"), and the resulting single document carries the multiclass result with the same audit-closure discipline as the rest of the manuscript. Execution plan and PERT in [08-draft0.2_commitology.md](08-draft0.2_commitology.md).

---

*Audit owner: PI (acting as senior critic). Document follows the same severity/closure discipline as `05-pi_adversarial_audit_of_draft0.md`.*
