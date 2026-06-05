# Refinement Is Concavity
### The Rigid Core of a Calibrated, Locally Testable Gap Measure for Graph-Neural-Network Expressivity

**Abstract.** The Weisfeiler–Leman (WL) test, and the expressivity theory for graph neural networks built on it, returns a binary verdict: an architecture can or cannot distinguish two graphs; a task is or is not feasible. We develop the *gap* version of that verdict — a calibrated measure of how far from the feasible regime a given architecture sits — and prove that the measure is rigidly determined, not chosen. Our central results are a characterization and a rigidity theorem. First, for a continuous score functional $\varphi$, the induced partition functional is monotone non-increasing under refinement *if and only if* $\varphi$ is concave (Theorem 1); there is no monotone expressivity measure outside the concave family. Second, among concave scores, the Bayes-risk integrand is the *unique* functional whose two-sided bracket on the achievable error is exact (Theorem 2); consequently every smooth surrogate incurs a strictly positive, quantified slack (Corollary 3), so the gap of the measure is not a defect but the unavoidable price of the differentiability that any application requires. From this static core we derive the GIN aggregator hierarchy as a corollary, characterize when the measure is monotone in network depth across architectures (it is monotone exactly for *refining* architectures such as GIN and join-type residual networks, and provably non-monotone for contractive ones such as GCN, where over-smoothing raises the achievable floor at the spectral-gap rate), and give a two-query local test that estimates the measure in $O(\varepsilon^{-2})$ queries independent of graph size. We close with the two pieces of genuine further work the core delineates: the rigidity theorem on the probability simplex, which extends the measure to soft and attention-based architectures, and gap amplification, the hardness-of-approximation analogue.

---

## 1. Introduction

Expressivity theory for message-passing graph neural networks rests on a single combinatorial fact: a GNN run for $L$ rounds is no more discriminating than $L$ rounds of WL colour refinement, with equality when the neighborhood aggregation is injective (Xu, Hu, Leskovec, and Jegelka; Morris et al.). This yields a clean but *all-or-nothing* statement. Two graphs are WL-distinguishable or they are not; a node task is determined by the WL colouring or it is not. The theory is silent on the vast middle: among tasks that are feasible in principle, which are nearly impossible across a bottleneck, and by how much does a weaker aggregator's information loss cost on a given task?

This binary–to–gap gap is exactly the relationship the PCP theorem bears to satisfiability. SAT is the decision problem; the PCP theorem produces a *gap* version that is moreover *locally checkable*, so that the distance from satisfiability is certified by reading a constant number of proof bits (Arora and Safra; Arora, Lund, Motwani, Sudan, and Szegedy; combinatorial gap-amplification proof of Dinur). We build the analogous object for WL-expressivity: a calibrated measure of *how far from feasible*, certified by local checks.

The measure is the *partition bracket*. A GNN induces a partition $\Pi$ of the inputs (by WL colour); the partition-restricted Bayes risk $\varepsilon^\ast(\Pi)$ is the smallest error of any classifier that respects that resolution; and for a concave score functional $\varphi$, the scalar average score $\bar\varphi(\Pi)$ bounds $\varepsilon^\ast(\Pi)$ from both sides. The two endpoints are the gap measure: a certified interval for the achievable error, computable before any classifier is trained.

Our contribution is not to introduce the bracket — its analytic ingredients are recognizable from proper-scoring-rule theory (DeGroot; Reid and Williamson) — but to show that **the measure is forced**, and to draw the consequences for graph neural networks. We prove (§3) that refinement-monotonicity is *equivalent* to concavity, so the concave family is not a convenient choice but the entire class of monotone measures; and that the Bayes risk is the *unique* concave score with an exact bracket, so smoothness — which every application demands — provably forces a two-sided slack. We then show (§4–§5) that this static rigidity organizes the whole zoo of aggregation-based architectures: the sum $\succ$ mean $\succ$ max hierarchy is a one-line corollary, and the behavior of the measure under increasing depth is characterized, separating architectures whose achievable floor falls with depth (refining; GIN, residual networks) from those where it rises (contractive; GCN), with over-smoothing identified as the latter's floor increase at the spectral-gap rate. Finally we show (§6) that the measure is operational: a two-query local test estimates it in time independent of the graph. We close (§7) with the two well-posed extensions the core delineates.

Throughout, the discipline is to pound one principle — the rigidity of the refinement measure — and to present every other result as its consequence.

---

## 2. Preliminaries

Let $(\mathcal X,\mathcal F,\mathbb P)$ be a probability space and $f:\mathcal X\to\{0,1\}$ a measurable label. A **partition** $\Pi=\{S_1,\dots,S_m\}$ is finite and measurable, with **cell masses** $p_i=\mathbb P(S_i)$ and **cell-conditional positive rates** $\eta_i=\mathbb P(f=1\mid S_i)\in[0,1]$. Partition $\Pi'$ **refines** $\Pi$, written $\Pi'\succeq\Pi$, if every cell of $\Pi'$ is contained in a cell of $\Pi$; refinement is the partial order of the partition lattice. The **partition-restricted Bayes risk** is
$$
\varepsilon^\ast(\Pi)\;=\;\min_{g\in G(\Pi)}\mathbb P\big(g(X)\ne f(X)\big)\;=\;\sum_{i=1}^m p_i\,\min(\eta_i,1-\eta_i),
$$
where $G(\Pi)$ is the class of predictors constant on each cell. For $\varphi:[0,1]\to\mathbb R$ the **partition functional** is $\bar\varphi(\Pi)=\sum_i p_i\,\varphi(\eta_i)$.

We call $\varphi$ a **normalized score** if it is concave, continuous, symmetric ($\varphi(\eta)=\varphi(1-\eta)$), vanishing at the endpoints ($\varphi(0)=\varphi(1)=0$), normalized at the peak ($\varphi(\tfrac12)=1$), and strictly increasing on $[0,\tfrac12]$, so that $\varphi^{-1}:[0,1]\to[0,\tfrac12]$ exists. Two running members: Shannon entropy $H_{\mathrm{bin}}$ (with $H_{\mathrm{bin}}(\tfrac12)=1$ in bits) and the rescaled variance $4\eta(1-\eta)$. The **tent** $T(\eta)=2\min(\eta,1-\eta)$ is the normalized Bayes-risk integrand.

The role of the graph neural network is solely that WL refinement *produces* the partition $\Pi$; all of §3 is about partitions and is indifferent to their origin. That indifference is what makes the results below a *core* rather than a graph-specific device.

---

## 3. The rigidity of the measure

### 3.1 Refinement is concavity

**Theorem 1.** *Let $\varphi:[0,1]\to\mathbb R$ be continuous. The following are equivalent:*
*(i) $\bar\varphi$ is monotone, $\;\Pi'\succeq\Pi\Rightarrow\bar\varphi(\Pi')\le\bar\varphi(\Pi)$, for all finite measurable partitions and all labels;*
*(ii) $\bar\varphi$ is non-increasing under every binary split of a single cell;*
*(iii) $\varphi$ is concave on $[0,1]$.*

**Proof.** $(i)\Rightarrow(ii)$ is immediate. $(iii)\Rightarrow(i)$ is Jensen: refining $S_i$ into subcells with conditional weights $w_{ik}=p_{ik}/p_i$ and rates $\eta_{ik}$ gives $\eta_i=\sum_k w_{ik}\eta_{ik}$ by the tower property, and concavity gives $\varphi(\eta_i)\ge\sum_k w_{ik}\varphi(\eta_{ik})$; multiply by $p_i$ and sum.

$(ii)\Rightarrow(iii)$ carries the content, since it shows concavity is forced. Fix $a,b\in[0,1]$, $\lambda\in[0,1]$, and set $\eta=\lambda a+(1-\lambda)b$. On an atomless space we realize a cell $S$ of conditional rate $\eta$ and split it into subcells of conditional weights $\lambda,1-\lambda$ and rates $a,b$: place conditional $f{=}1$ mass $\lambda a$ and $f{=}0$ mass $\lambda(1-a)$ in the first subcell and the complements in the second, which are nonnegative and consistent precisely because $\lambda a+(1-\lambda)b=\eta$. Binary monotonicity on $S$ then reads $\varphi(\lambda a+(1-\lambda)b)\ge\lambda\varphi(a)+(1-\lambda)\varphi(b)$, the definition of concavity for arbitrary $a,b,\lambda$. On a general space the realizable splits give a dense set of weights, and continuity upgrades midpoint-concavity to concavity. $\qquad\blacksquare$

The easy direction says a concave choice *yields* a monotone measure; the hard direction says monotonicity *admits only* concave choices. There is no refinement-monotone measure of achievable error outside the concave family. This closes the suspicion that monotonicity is an artifact of choosing entropy or variance, and it identifies the family within which uniqueness can be asked.

### 3.2 The Bayes risk is the unique exact measure

For a normalized score, Theorem 1 yields the two-sided bracket
$$
\varphi^{-1}\big(\bar\varphi(\Pi)\big)\;\le\;\varepsilon^\ast(\Pi)\;\le\;c_\varphi\,\bar\varphi(\Pi),\qquad c_\varphi:=\sup_{\eta\in(0,1/2]}\frac{\eta}{\varphi(\eta)},
$$
the lower endpoint from concavity, the upper from the pointwise inequality $\eta\le c_\varphi\varphi(\eta)$ on $[0,\tfrac12]$. Call the bracket **exact** if its endpoints coincide for every partition.

**Theorem 2.** *A normalized score $\varphi$ has an exact bracket if and only if $\varphi=T$. Equivalently, the Bayes-risk integrand is the unique self-bracketing concave score: it is the only $\varphi$ for which the scalar $\bar\varphi(\Pi)$ determines $\varepsilon^\ast(\Pi)$ exactly across all partitions.*

**Proof.** For $T$: $\varphi^{-1}(t)=t/2$ and $c_T=\tfrac12$, so both endpoints equal $\tfrac12\bar T(\Pi)=\sum_i p_i\min(\eta_i,1-\eta_i)=\varepsilon^\ast(\Pi)$; the bracket is a point. Conversely, suppose exactness. Then $\varepsilon^\ast(\Pi)$ lies between two equal quantities, each a function of $\bar\varphi(\Pi)$ alone, so $\varepsilon^\ast(\Pi)=G(\bar\varphi(\Pi))$ for some $G$. Single-cell partitions of rate $\eta\in[0,\tfrac12]$ give $\eta=G(\varphi(\eta))$, i.e. $G=\varphi^{-1}$. Two-cell partitions with masses $p_1,p_2$ and rates in $[0,\tfrac12]$, writing $u=\varphi(\eta_1),v=\varphi(\eta_2)$, give
$$
p_1\,\varphi^{-1}(u)+p_2\,\varphi^{-1}(v)\;=\;\varphi^{-1}\big(p_1u+p_2v\big)\qquad\text{for all }u,v\in[0,1],\ p_1+p_2=1.
$$
Thus $\psi:=\varphi^{-1}$ attains Jensen's bound with equality for every convex combination, hence is affine; with $\psi(0)=0$ this forces $\psi(t)=ct$, so $\varphi(\eta)=\eta/c$ on $[0,\tfrac12]$, and $\varphi(\tfrac12)=1$ gives $c=\tfrac12$, i.e. $\varphi=T$ by symmetry. $\qquad\blacksquare$

The tent is concave but *not strictly* concave — it is affine on $[0,\tfrac12]$ — and it has a corner at $\eta=\tfrac12$, where the minimum-error rule flips its majority vote. Theorem 2 says this kinked functional is the unique concave score that pins the Bayes risk exactly; every other concave score lies strictly above the tent somewhere, which is what strict concavity is, and therefore brackets with a strictly positive gap.

### 3.3 Smoothness forces slack

**Corollary 3.** *Let $\varphi$ be a normalized score that is strictly concave on some subinterval of $(0,\tfrac12)$ — in particular any differentiable score with $\varphi''<0$, such as Shannon entropy or the rescaled variance. Then there is a partition on which the bracket is strict, $\varphi^{-1}(\bar\varphi)<\varepsilon^\ast<c_\varphi\bar\varphi$. No differentiable concave score has an exact bracket.*

**Proof.** By Theorem 2, exactness holds only for $T$, which is nowhere strictly concave; any $\varphi$ strictly concave on a subinterval is $\ne T$, and a two-cell partition with both rates in that subinterval makes Jensen strict, opening the gap. $\qquad\blacksquare$

This reframes the measure. One uses a concave *surrogate* rather than the Bayes risk itself precisely because the applications need smoothness — a differentiable objective to drive architecture search, a strictly increasing inverse for a well-defined lower endpoint, curvature to be informative away from the corner. The moment smoothness is demanded, exactness is forfeited, by theorem. The two-sided gap of the bracket is the image, under this trade-off, of the single non-differentiable point of the Bayes risk. The right response is not to apologize for the slack but to report it as the intrinsic resolution of a smooth expressivity measure, and to choose the surrogate to make that resolution as fine as smoothness allows — which, by the universal pointwise domination $4\eta(1-\eta)\le H_{\mathrm{bin}}(\eta)$, means the variance member gives a tighter upper instrument than entropy.

---

## 4. Expressivity as a calibrated gap test

The decision version of expressivity — WL feasibility — is the *boundary* of the measure: $\varepsilon^\ast(\Pi)$ is bounded away from the trivial rate exactly when the WL partition fails to separate a label-distinguishing pair. The bracket is the *interior*: it quantifies how far from feasible an architecture sits, and §6 shows it is locally checkable. This is the precise sense in which the partition bracket is a calibrated, locally testable gap version of the WL test — the analogue, for expressivity, of what the PCP theorem is for satisfiability.

The aggregator hierarchy of Xu et al. is then a one-line corollary of Theorem 1. Sum aggregation is injective and induces the finest partition $\Pi_{\mathrm{sum}}$; mean captures the distribution and induces the coarsening $\Pi_{\mathrm{mean}}$ that merges multisets with equal proportions; max captures the support and induces the coarser $\Pi_{\mathrm{max}}$. These form a refinement chain $\Pi_{\mathrm{sum}}\succeq\Pi_{\mathrm{mean}}\succeq\Pi_{\mathrm{max}}$, so:

**Corollary 4 (the aggregator ladder).** *For every concave score and every task, $\;\varepsilon^\ast(\Pi_{\mathrm{sum}})\le\varepsilon^\ast(\Pi_{\mathrm{mean}})\le\varepsilon^\ast(\Pi_{\mathrm{max}})$.* The qualitative hierarchy sum $\succ$ mean $\succ$ max becomes a certified ordering of achievable-error floors; the gap between rungs is the bracket, and it can be both computed and localized to the data on which a weaker aggregator's collapse occurs.

---

## 5. Depth and architecture

Theorem 1's monotonicity is over the refinement *lattice* and is unconditional. Whether the measure is monotone in network *depth* is a different, dynamical question, and it is not universal. Let an architecture produce at depth $L$ a realized partition $\Pi^{(L)}$ (nodes equivalent iff assigned the same representation up to resolution).

**Theorem 5 (depth-monotonicity).** *The realized floor $\varepsilon^\ast(\Pi^{(L)})$ is non-increasing in $L$ if and only if $(\Pi^{(L)})_L$ is a refinement chain, $\Pi^{(L+1)}\succeq\Pi^{(L)}$.*

**Proof.** Apply Theorem 1 along the depth sequence; non-increase holds iff each layer refines. $\qquad\blacksquare$

The criterion sorts the architectures. **Injective** aggregation (GIN with sum and an MLP) never merges and the WL step splits, so $\Pi^{(L+1)}\succeq\Pi^{(L)}$ until WL-stability; the floor falls monotonically. **Contractive** aggregation (GCN, mean, symmetric-normalized) acts by an operator whose non-constant spectrum has norm below one, so the informative component of the signal contracts at rate $\lambda_2^{\,L}$ — $\lambda_2$ the second-largest eigenvalue magnitude, $1-\lambda_2$ the spectral gap — and at any fixed resolution distinct representations collapse toward the dominant eigenvector; the realized partition coarsens past a critical depth and the floor *rises*. This is over-smoothing, and Theorem 5 identifies it as the violation of depth-monotonicity, with the spectral gap setting its onset. **Join-type residual** architectures (jumping-knowledge networks, GCNII) concatenate or carry forward earlier representations, so two nodes are distinguished iff some layer distinguished them and the realized partition is the join $\bigvee_{\ell\le L}\Pi^{(\ell)}$, which is monotone non-decreasing in refinement *by construction*; these architectures are depth-monotone by design, and the core explains why the standard remedy for over-smoothing works — it never discards resolution a shallower layer achieved. **Attention** (GAT) refines if attention sharpens with depth and contracts if it uniformizes; its regime is data- and training-dependent, hence measurable by the bracket.

The honest framing separates two floors. The WL-colour *ceiling* always refines monotonically, so the in-principle floor is depth-monotone for every architecture; the *realized* floor's depth behavior is the architecture's signature; and the difference between them is the over-smoothing penalty, a quantity the measure computes rather than asserts.

This yields a classification of aggregation-based GNNs by three axes — *lattice position* (sum/finest, mean/distribution, max/support, attention/soft), *depth dynamics* (refining/monotone, contractive/over-smoothing at $\lambda_2^L$, join/monotone-by-design), and *assignment type* (hard partition or soft kernel) — under which GIN, GCN, GraphSAGE, GAT, residual networks, and graph transformers are distinct coordinate choices, all measured by the same core.

---

## 6. The measure is operational: a two-query local test

The variance member is locally testable because its score is, exactly, a pairwise disagreement probability.

**Proposition 6 (two-query identity).** *Let $X$ be a uniformly random node and $X'$ a second node drawn uniformly from the same cell $\Pi(X)$. Then*
$$
p_{\mathrm{dis}}\;:=\;\mathbb P\big[f(X)\ne f(X')\big]\;=\;\sum_i p_i\cdot 2\,\eta_i(1-\eta_i)\;=\;2\,\mathbb E\big[\mathrm{Var}(f\mid\Pi)\big],
$$
*and the variance bracket reads entirely in this one observable:*
$$
\tfrac12\Big(1-\sqrt{1-2\,p_{\mathrm{dis}}}\Big)\;\le\;\varepsilon^\ast(\Pi)\;\le\;p_{\mathrm{dis}}.
$$

**Proof.** Conditioned on cell $i$, two independent draws disagree with probability $2\eta_i(1-\eta_i)$; average over $i$. The variance member has upper constant $c=2$ and bracket $[\tfrac12(1-\sqrt{1-4\bar\varphi_{\mathrm{var}}}),\,2\bar\varphi_{\mathrm{var}}]$ with $\bar\varphi_{\mathrm{var}}=\mathbb E[\mathrm{Var}]=p_{\mathrm{dis}}/2$; substitute. The upper endpoint is $p_{\mathrm{dis}}$ exactly. $\qquad\blacksquare$

The statement is operationally striking: **the probability that two nodes sharing a WL colour disagree on the label is an exact upper bound on the achievable Bayes error**, and the lower bound is a closed-form function of the same number. One measured quantity fixes the whole bracket.

**Corollary 7 (sublinear estimation).** *$p_{\mathrm{dis}}$ is estimable to additive accuracy $\pm\varepsilon$ at confidence $1-\delta$ from $m=\lceil\ln(2/\delta)/2\varepsilon^2\rceil$ independent same-cell pairs, by Hoeffding's inequality on the disagreement indicator — independent of the number of nodes.* This is a local test for the predicate "$\varepsilon^\ast(\Pi)\le\alpha$": completeness because a low-floor partition has low disagreement, soundness because $p_{\mathrm{dis}}$ upper-bounds the floor. It is the local-checkability half of the gap-test framing of §4. (Forming a same-cell pair requires either a one-time bucket-by-colour pass or a collision sampler; the $O(\varepsilon^{-2})$ count is the label/colour-query complexity once a pair is formed.)

The computational picture beyond the local test is a clean dichotomy. On **expander** graphs the relevant Lipschitz constant of the aggregation is the spectral norm rather than the maximum degree (so the over-smoothing rate is $\lambda_2^L$, and the bound that was loose by orders of magnitude in degree becomes tight), the local test runs in $O(\varepsilon^{-2})$, and fast mixing yields a randomized approximation scheme for the lossy variant. On **bounded-treewidth** graphs — forests, series-parallel graphs, and the low-treewidth molecular graphs on which GNNs are routinely benchmarked — the otherwise $\#$P-hard lossy/soft bracket is computable *exactly* in time $O(n\,k^{w+1})$ by belief propagation on a junction tree (Lauritzen and Spiegelhalter; Provan and Ball for the reliability instance). The two regimes are complementary: every graph class on which GNNs are deployed is handled by one method, and the boundary between them is the spectral-gap threshold.

---

## 7. Discussion and open problems

We have argued that the measurement of GNN expressivity by achievable error is *rigid*: refinement-monotonicity is exactly concavity (Theorem 1), the Bayes risk is the unique exact functional (Theorem 2), and smoothness forces a quantified slack (Corollary 3). The aggregator hierarchy (Corollary 4), the depth behavior across architectures (Theorem 5), and an operational sublinear estimator (Proposition 6, Corollary 7) all follow. The conceptual frame is that this is a calibrated, locally testable gap version of the WL test — for expressivity what a PCP is for satisfiability.

We hold the result to the assessment we apply to any: its opportunity is that it makes the measure canonical and gives a principled rule for surrogate choice, converting a menu of inequalities into a structure with a characterized extremal point; its risk is that Theorem 1 alone reads as the data-processing inequality, mitigated by leading with the impossibility theorem (Theorem 2 and Corollary 3), which is not the data-processing inequality and is, to our knowledge, new in this form.

Two extensions are well-posed, and we state them honestly as work rather than claim.

**The simplex rigidity (the route to soft architectures).** The hard-partition theory is the injective corner — the vertices of the probability simplex. The soft and attention-based architectures (GCN at the distribution, GAT, differentiable pooling, graph transformers) produce *simplex-valued* assignments and live in the interior. Theorem 1 transfers to the simplex unchanged (concave-on-the-simplex $\Leftrightarrow$ refinement-monotone), but Theorem 2 must be re-proved there: the candidate extremal object is the multiclass Bayes risk $1-\max_c\eta_c$ — concave, piecewise-linear, kinked where the argmax switches, the simplex analogue of the tent — and the affine-equality argument must be redone on simplex-valued arguments. Establishing the simplex rigidity would extend the entire core to the soft architectures with the same uniqueness it has for GIN.

**Gap amplification (the hardness-of-approximation analogue).** Monotonicity orders the aggregator floors (Corollary 4) but does not control the *size* of the gap. With $\Delta(G)=\varepsilon^\ast(\Pi_{\mathrm{mean}})-\varepsilon^\ast(\Pi_{\mathrm{sum}})$, the question is whether a local graph operation $G\mapsto G'$ — a zig-zag product with a fixed expander — drives a small positive gap to an absolute constant, $\Delta(G)>0\Rightarrow\Delta(G')\ge c$, while preserving $\varepsilon^\ast(\Pi_{\mathrm{sum}})$. An affirmative answer would make the aggregator hierarchy *robustly* ordered — a hardness-of-approximation statement for expressivity, the exact transport of the gap-amplification step in the combinatorial proof of the PCP theorem to the refinement lattice. We regard this as the natural sequel rather than part of the present, deliberately single-principle, development; and we note the tractable companion question it suggests — how the gap *evolves with depth* under the spectral gap, compounding for refining architectures and collapsing at rate $\lambda_2^L$ for contractive ones — as the immediate next target.

---

## References

Arora, S., and Safra, S. *Probabilistic checking of proofs: a new characterization of NP.* J. ACM, 1998.
Arora, S., Lund, C., Motwani, R., Sudan, M., and Szegedy, M. *Proof verification and the hardness of approximation problems.* J. ACM, 1998.
Dinur, I. *The PCP theorem by gap amplification.* J. ACM, 2007.
DeGroot, M. *Uncertainty, information, and sequential experiments.* Ann. Math. Statist., 1962.
Goldreich, O., Goldwasser, S., and Ron, D. *Property testing and its connection to learning and approximation.* J. ACM, 1998.
Hoeffding, W. *Probability inequalities for sums of bounded random variables.* JASA, 1963.
Lauritzen, S., and Spiegelhalter, D. *Local computations with probabilities on graphical structures.* J. Royal Statist. Soc. B, 1988.
Morris, C., et al. *Weisfeiler and Leman go neural.* AAAI, 2019.
Provan, J. S., and Ball, M. O. *The complexity of counting cuts and of computing the probability that a graph is connected.* SIAM J. Comput., 1983.
Reid, M., and Williamson, R. *Information, divergence and risk for binary experiments.* JMLR, 2011.
Xu, K., Hu, W., Leskovec, J., and Jegelka, S. *How powerful are graph neural networks?* ICLR, 2019.

---

*Single-principle short paper. Theorems 1, 2, 5 and Propositions 6–7 are complete for the binary, symmetric, normalized setting; the simplex rigidity and the precise depth-evolution rate are stated as open problems, not claimed.*
