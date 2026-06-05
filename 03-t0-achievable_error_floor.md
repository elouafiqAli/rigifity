# The Achievable-Error Floor of Graph Neural Networks
### Calibration at the Resolution Level
*Draft 0.*

**Abstract.** Weisfeiler–Leman (WL) expressivity theory returns a binary verdict — an architecture can or cannot distinguish two graphs. We study its calibrated *gap* version: the partition-restricted Bayes risk $\varepsilon^\ast(\Pi)$ of the partition $\Pi$ a graph neural network induces, the smallest error any classifier respecting that resolution can achieve, together with a two-sided bracket on it from a concave score. We are explicit that this is an *achievable floor* — a population, optimal-classifier quantity — and **not** the error of a trained network, which optimization, finite data, and inductive bias additionally govern; the gap between floor and achieved error is outside our scope, and we flag where this matters. Our theoretical observations are the *resolution-level transposition* of classical results: the monotonicity of the floor under refinement is the concavity-of-Bayes-risk / Blackwell ordering on the refinement lattice, and the fact that the bracket is exact only for the $0$-$1$ loss is the partition-bracket form of the surrogate-calibration phenomenon (the Bartlett–Jordan–McAuliffe $\psi$-transform is the identity only for the $0$-$1$ loss), so smoothness forces a quantified slack. We do not claim these as new decision theory. What is new is (i) moving calibration from the *optimization* axis (excess risk of a learned predictor) to the *resolution* axis (the achievable floor as a function of the partition a GNN induces); (ii) the consequences for graph neural networks — a calibrated gap-test for WL feasibility, the GIN aggregator hierarchy as a one-line refinement-chain corollary, and a characterization of when the floor is monotone in network depth (it is, exactly for *refining* architectures such as GIN and join-type residual networks, and provably not for contractive ones such as GCN, where over-smoothing raises the floor); and (iii) a two-query local test whose label complexity is independent of graph size. Two extensions are stated as open problems: the rigidity on the probability simplex, which would reach multiclass and the soft/attention architectures, and gap amplification. Experiments are deferred to a companion empirical paper.

---

## 1. Introduction

Expressivity theory for message-passing graph neural networks rests on one fact: a GNN run for $L$ rounds is no more discriminating than $L$ rounds of WL colour refinement, with equality when neighborhood aggregation is injective [Xu et al.; Morris et al.]. This is an all-or-nothing statement — two graphs are WL-distinguishable or not — and it is silent on the middle ground: among feasible tasks, which are nearly impossible across a bottleneck, and by how much does a weaker aggregator's information loss cost. We study the calibrated gap version of the verdict, and we are careful about exactly which quantity we measure.

**The quantity, and what it is not.** A GNN induces a partition $\Pi$ of the inputs (by colour or quantized embedding). Its **partition-restricted Bayes risk** $\varepsilon^\ast(\Pi)$ is the smallest error of any classifier constant on the cells of $\Pi$. This is the *achievable floor* at that resolution: a population quantity, attained by the Bayes-optimal cell-wise rule. It is **not** the error of a trained GNN. A trained network's error is additionally shaped by optimization dynamics, finite-sample estimation, and inductive bias, none of which this paper addresses. The floor is a lower bound on the error any classifier at that resolution can reach, and (via the bracket below) we also bound it from above; but trained accuracy can sit far above the floor, and — a point we return to in §5 — the *floor* ordering across aggregators need not match the *trained-accuracy* ordering. We measure what is representable at a given resolution, not what a given optimizer learns.

**The bracket.** For a concave score functional $\varphi$, the scalar average score $\bar\varphi(\Pi)=\sum_i p_i\varphi(\eta_i)$ (cell masses $p_i$, label rates $\eta_i$) bounds $\varepsilon^\ast(\Pi)$ from both sides:
$$
\varphi^{-1}\big(\bar\varphi(\Pi)\big)\;\le\;\varepsilon^\ast(\Pi)\;\le\;c_\varphi\,\bar\varphi(\Pi),\qquad c_\varphi=\sup_{\eta\in(0,1/2]}\frac{\eta}{\varphi(\eta)}.
$$
For any *normalized* concave score (concave on $[0,1]$ with $\varphi(0)=\varphi(1)=0$ and $\varphi(\tfrac12)=1$), concavity above the chord through $(0,0)$ and $(\tfrac12,1)$ gives $\varphi(\eta)\ge 2\eta$ on $[0,\tfrac12]$, so $c_\varphi=\tfrac12$ *uniformly*, attained at $\eta=\tfrac12$. The upper endpoint is therefore $\bar\varphi(\Pi)/2$ for every member of the class; the score-dependence of the upper instrument lives entirely in $\bar\varphi$, not in $c_\varphi$. The interval is the *calibrated gap measure*: a certified range for the achievable floor, computable from the induced partition before any classifier is trained.

**The conceptual frame.** WL feasibility is the *decision* problem; the bracket is its *gap* version, and (§7) it is locally checkable. This is, in spirit, the relationship a PCP bears to satisfiability [Arora–Safra; Arora et al.; Dinur], with the caveat (§8) that we have the locally-checkable half but not yet a gap-amplification theorem, so we use the PCP framing as an analogy and not a claim.

### 1.1 What is new, and what is not

We separate borrowed foundations from contributions deliberately, because the foundations are classical and over-claiming them would be wrong.

*Not new (recalled and reformulated in §3, credited in §1.2).* The correspondence between a concave generalized entropy and the Bayes risk [Savage; DeGroot; Grünwald–Dawid]; the monotonicity of the Bayes risk under more informative experiments [Blackwell; Le Cam]; and the surrogate-calibration phenomenon that the $0$-$1$ loss is uniquely self-calibrated while smooth surrogates incur a transform gap [Bartlett–Jordan–McAuliffe; Zhang; Reid–Williamson]. Our Theorem 1 (refinement-monotone $\Leftrightarrow$ concave) is the refinement-lattice form of the first two; our Theorem 2 (the Bayes risk is the unique exact-bracket score) and Corollary 3 (smoothness forces slack) are the partition-bracket form of the third.

*New (the contributions of this paper).*
1. **The transposition of calibration from the optimization axis to the resolution axis.** Surrogate-calibration theory controls the *excess risk of a learned predictor*; we use the same machinery to control the *achievable floor as a function of the resolution* — the partition the model can access — over the refinement lattice. This expressivity reading, and the lattice structure, are not in the surrogate-loss literature.
2. **The graph-neural-network consequences:** the calibrated gap-test for WL feasibility (§5); the GIN aggregator hierarchy sum $\succ$ mean $\succ$ max as a one-line refinement-chain corollary (Corollary 4); and the cross-architecture characterization of depth-monotonicity (Theorem 5), with over-smoothing identified as the floor increase of contractive architectures and residual networks explained as monotone-by-construction.
3. **A two-query local test** for the floor (Proposition 6, Corollary 7) whose *label* complexity is independent of graph size.

### 1.2 Relation to prior work (the audit)

The objects we use are classical, and we state the relationship precisely so the contribution is not mistaken.

*Generalized entropy and Bayes risk.* For a proper loss, the conditional Bayes risk $H(\eta)=\inf_a\mathbb E_{Y\sim\mathrm{Bern}(\eta)}\,\ell(Y,a)$ is concave, and the Bayes risk of a partition is $\sum_i p_i H(\eta_i)$ [Savage 1971; DeGroot 1962; Grünwald–Dawid 2004]. Our "score functional" $\varphi$ *is* such an $H$, and our "partition functional" $\bar\varphi(\Pi)$ *is* the partition-restricted Bayes risk for the matched loss. These are not new objects.

*Comparison of experiments.* That a more informative experiment (a refinement) cannot increase the Bayes risk, for every loss, is Blackwell's theorem [Blackwell 1953; Le Cam]. Theorem 1's monotonicity direction is this fact on the refinement lattice; its converse (monotone $\Rightarrow$ concave) is an elementary consequence of the definition of concavity via binary splits.

*Surrogate calibration.* For a surrogate margin loss, Bartlett, Jordan, and McAuliffe [2006] (and Zhang [2004]) relate excess $0$-$1$ risk to excess surrogate risk through the $\psi$-transform, $\psi(R-R^\ast)\le R_\varphi-R_\varphi^\ast$, where $\psi$ is the convexification of $H^-(\eta)-H(\eta)$; the $0$-$1$ loss gives the identity $\psi$, and smooth surrogates give a strictly convex $\psi$. Our Theorem 2 — the bracket is exact only for the tent (the $0$-$1$ Bayes risk) — is the partition-bracket counterpart of "$\psi$ is the identity only for the $0$-$1$ loss," and Corollary 3 is the counterpart of "smooth surrogates have $\psi\ne\mathrm{id}$." Two formal differences are worth noting: BJM bound *excess* risk of a *predictor* (the optimization axis), whereas we bound the *absolute* Bayes risk of a *partition* (the resolution axis); and our bound is two-sided (calibration via $c_\varphi$ and its converse via $\varphi^{-1}$) where the $\psi$-transform is one-sided. We do not claim Theorem 2 as a new decision-theoretic fact; we claim the resolution-level transposition and the GNN consequences.

*Reid–Williamson [2011]* unify scoring rules, divergences, and binary-experiment risk and are the closest source of the analytic machinery; we build on their viewpoint.

---

## 2. Preliminaries

Let $(\mathcal X,\mathcal F,\mathbb P)$ be a probability space and $f:\mathcal X\to\{0,1\}$ measurable. A **partition** $\Pi=\{S_1,\dots,S_m\}$ is finite and measurable, with masses $p_i=\mathbb P(S_i)$ and rates $\eta_i=\mathbb P(f=1\mid S_i)$. $\Pi'$ **refines** $\Pi$ ($\Pi'\succeq\Pi$) if each cell of $\Pi'$ lies in a cell of $\Pi$. The **partition-restricted Bayes risk** is $\varepsilon^\ast(\Pi)=\sum_i p_i\min(\eta_i,1-\eta_i)$, and for $\varphi:[0,1]\to\mathbb R$ the **partition functional** is $\bar\varphi(\Pi)=\sum_i p_i\varphi(\eta_i)$.

A **normalized score** is concave, continuous, symmetric ($\varphi(\eta)=\varphi(1-\eta)$), vanishing at $\{0,1\}$, normalized by $\varphi(\tfrac12)=1$, and strictly increasing on $[0,\tfrac12]$ (so $\varphi^{-1}:[0,1]\to[0,\tfrac12]$ exists). Running members: Shannon entropy and the rescaled variance $4\eta(1-\eta)$. The **tent** $T(\eta)=2\min(\eta,1-\eta)$ is the normalized $0$-$1$ Bayes risk.

**The induced partition (operational definition).** WL refinement produces *discrete* colours, so the WL-colour partition $\Pi_{\mathrm{WL}}$ is exact and needs no quantization. A trained GNN produces *continuous* embeddings $h:V\to\mathbb R^d$, which do not induce a finite partition directly; we therefore fix an **$\varepsilon$-net** $N_\varepsilon\subset\mathbb R^d$ (a maximal $\varepsilon$-separated subset of the image of $h$) and define the **$\varepsilon$-resolution partition** $\Pi_\varepsilon$ as the Voronoi partition of nodes by their nearest point in $N_\varepsilon$; a nested dyadic grid is a special case. Then $\Pi_\varepsilon$ is a genuine partition.

Three properties of $\Pi_\varepsilon$ we use, with their precise scope:
- *(Monotonicity in $\varepsilon$ along a nested family.)* If $N_{\varepsilon'}\subset N_\varepsilon$ for $\varepsilon'\le\varepsilon$, then $\Pi_{\varepsilon'}\succeq\Pi_\varepsilon$, and by Theorem 1 the floor is non-decreasing in $\varepsilon$ along the family.
- *(Dependence on the net.)* Different choices of $N_\varepsilon$ produce different partitions; the dependence is bounded by the cell diameter — two same-$\varepsilon$ nets disagree on a node only if its embedding lies within $\varepsilon$ of a Voronoi boundary, a set of measure $O(\varepsilon)$ in the embedding distribution. Qualitative conclusions are stable; per-task numerics may shift at order $\varepsilon$, which we report rather than ignore.
- *(WL-faithful limit.)* For a **WL-faithful** GNN (one that maps WL-distinguishable nodes to distinct embeddings — GIN with sum + an injective MLP is the model case), $\Pi_\varepsilon=\Pi_{\mathrm{WL}}$ for every $\varepsilon$ smaller than the minimum separating embedding distance $\delta:=\min_{u\not\sim_{\mathrm{WL}}v}\|h(u)-h(v)\|$. For a non-WL-faithful GNN, $\Pi_\varepsilon$ is in general a coarsening of the exact-embedding partition and a *further* coarsening of $\Pi_{\mathrm{WL}}$; we make this explicit in §6.

All depth statements (§5–§6) fix a nested $\varepsilon$-net family and vary depth.

The role of the graph neural network is solely that it *produces* the partition (via $\Pi_{\mathrm{WL}}$ or $\Pi_\varepsilon$); §3 is about partitions and is indifferent to their origin.

---

## 3. Calibration on the refinement lattice

We recall the two facts we need in the partition-lattice form, with proofs for self-containedness, and credit them as in §1.2.

### 3.1 Refinement-monotonicity is concavity

**Theorem 1.** *For continuous $\varphi:[0,1]\to\mathbb R$, the following are equivalent: (i) $\bar\varphi$ is monotone, $\Pi'\succeq\Pi\Rightarrow\bar\varphi(\Pi')\le\bar\varphi(\Pi)$, over all finite measurable partitions and labels; (ii) $\bar\varphi$ is non-increasing under every binary split of a cell; (iii) $\varphi$ is concave.*

**Proof.** $(i)\Rightarrow(ii)$ is immediate. $(iii)\Rightarrow(i)$: refining $S_i$ into subcells with conditional weights $w_{ik}=p_{ik}/p_i$ and rates $\eta_{ik}$ gives $\eta_i=\sum_k w_{ik}\eta_{ik}$ (tower property), and concavity gives $\varphi(\eta_i)\ge\sum_k w_{ik}\varphi(\eta_{ik})$; multiply by $p_i$ and sum. $(ii)\Rightarrow(iii)$: for $a,b\in[0,1],\lambda\in[0,1]$ set $\eta=\lambda a+(1-\lambda)b$; on an atomless space, realize a cell of rate $\eta$ split into subcells of weights $\lambda,1-\lambda$ and rates $a,b$ (place conditional $f{=}1$ mass $\lambda a$ and $f{=}0$ mass $\lambda(1-a)$ in the first), and binary monotonicity reads $\varphi(\lambda a+(1-\lambda)b)\ge\lambda\varphi(a)+(1-\lambda)\varphi(b)$, i.e. concavity; on a general space the realizable splits give a dense set of weights and continuity completes it. $\qquad\blacksquare$

This is Blackwell's ordering [Blackwell 1953] on the refinement lattice together with its elementary converse; we use it to fix the class (concave scores) within which calibration operates.

### 3.2 The $0$-$1$ Bayes risk is the unique exact score

For a normalized score, Theorem 1 yields the bracket of §1; call it **exact** if its endpoints coincide for every partition.

**Theorem 2.** *A normalized score $\varphi$ has an exact bracket if and only if $\varphi=T$.* 

**Proof.** For $T$: $\varphi^{-1}(t)=t/2$, $c_T=\tfrac12$, and both endpoints equal $\tfrac12\bar T(\Pi)=\varepsilon^\ast(\Pi)$. Conversely, exactness means the two bracket endpoints coincide on every partition. Apply this to the single-cell partition of rate $\eta\in[0,\tfrac12]$: $\bar\varphi(\Pi)=\varphi(\eta)$ and $\varepsilon^\ast(\Pi)=\eta$, so $\varphi^{-1}(\varphi(\eta))=c_\varphi\,\varphi(\eta)$, i.e.
$$
\eta\;=\;c_\varphi\,\varphi(\eta)\qquad\text{for every }\eta\in[0,\tfrac12].
$$
Hence $\varphi(\eta)=\eta/c_\varphi$ on $[0,\tfrac12]$; normalization $\varphi(\tfrac12)=1$ pins $c_\varphi=\tfrac12$, so $\varphi(\eta)=2\eta$ on $[0,\tfrac12]$, and symmetry gives $\varphi=T$. $\qquad\blacksquare$

**Remark (relation to the $\psi$-transform).** Exactness of the bracket is the resolution-level counterpart of the $\psi$-transform being the identity, which [BJM 2006] holds for the $0$-$1$ loss. The tent is concave but not strictly so and has a corner at $\eta=\tfrac12$ — the locus where the Bayes rule flips its vote — and that corner is the source of the gap below. (The two-cell affine-equality argument familiar from the simplex extension is unnecessary here: single-cell partitions already pin $\varphi$ pointwise, because in the binary case $\varphi$ is a function of the scalar $\eta$. The two-cell argument earns its keep only when $\varphi$ is not a function of $\varepsilon^\ast$ — i.e., on the multiclass simplex.)

**Corollary 3 (smoothness forces slack).** *If a normalized score is strictly concave on a subinterval of $(0,\tfrac12)$ — in particular any differentiable score with $\varphi''<0$, e.g. Shannon entropy or rescaled variance — then the bracket is strict on some partition; no differentiable concave score is exact.* (By Theorem 2 only $T$, nowhere strictly concave, is exact; a two-cell partition with rates in the strict region makes Jensen strict.)

The reading: one uses a *smooth* surrogate because applications need differentiability (a trainable objective, a well-defined inverse, curvature away from the corner); the moment smoothness is demanded, exactness is lost, by the same phenomenon that makes the $\psi$-transform nontrivial for smooth surrogates. The bracket gap is the resolution-level image of that transform gap. The upper endpoint is $\bar\varphi(\Pi)/2$ for every normalized score (by the universal $c_\varphi=\tfrac12$ noted in §1), so the comparison between surrogates is a comparison of $\bar\varphi$ values; the pointwise domination $4\eta(1-\eta)\le H(\eta)$ gives $\bar\varphi_{\mathrm{var}}\le\bar\varphi_H$ on every partition, so the variance member yields the tighter upper instrument.

---

## 4. (merged into §1.2)

---

## 5. Expressivity as a calibrated gap test

WL feasibility — the decision verdict — is the *boundary* of the measure: $\varepsilon^\ast(\Pi)$ is bounded away from the trivial rate exactly when the WL partition fails to separate a label-distinguishing pair. The bracket is the *interior*, and §7 makes it locally checkable. This is the calibrated, locally checkable gap version of the WL test — the locally-checkable half of the PCP framing flagged in §1; gap amplification (the other half) remains the analogy and Open Problem 3 of §8.

The aggregator hierarchy of [Xu et al.] is then a corollary of Theorem 1. Sum is injective and induces the finest $\Pi_{\mathrm{sum}}$; mean induces the same-distribution coarsening $\Pi_{\mathrm{mean}}$; max the same-support coarsening $\Pi_{\mathrm{max}}$, forming a refinement chain.

**Corollary 4 (aggregator floor ladder).** *For every concave score and task, $\varepsilon^\ast(\Pi_{\mathrm{sum}})\le\varepsilon^\ast(\Pi_{\mathrm{mean}})\le\varepsilon^\ast(\Pi_{\mathrm{max}})$, where $\Pi_{\mathrm{sum}}$, $\Pi_{\mathrm{mean}}$, $\Pi_{\mathrm{max}}$ denote the finest partitions induced by an injective-update GNN with the respective aggregator class — the information-theoretic ceiling for that class; a specific trained GNN with the same aggregator induces a partition at most as fine (and the corresponding floor bound is correspondingly looser).*

**Caveat (floor, not achieved — applies here especially).** Corollary 4 orders *achievable floors*. It does **not** predict trained-accuracy ordering, and the two can diverge sharply: on homophilous node tasks mean/GCN frequently *outperforms* sum despite the higher floor, because mean is a better inductive bias and optimizes more stably. The ladder says sum *can* in principle reach a lower error at this resolution, not that a trained sum-GNN *will*. We make this distinction loudly because the naive reading "Corollary 4 predicts sum-GNNs are most accurate" is false and is not what the theorem says.

---

## 6. Depth and architecture

Theorem 1's monotonicity is over the refinement *lattice* and is unconditional. Monotonicity in network *depth* is a separate, dynamical question and is not universal. The architecture-sorting story works cleanly at the **WL/exact-equivalence level**; we state it there and then transfer to the operational $\varepsilon$-partition $\Pi_\varepsilon^{(L)}$ from §2 via a Lipschitz/quantization bridge.

**Three partitions at each depth.** For an architecture $\mathcal A$ producing embeddings $h^{(L)}:V\to\mathbb R^d$, we distinguish:

- $\Pi^{(L)}_{\mathrm{WL}}$ — the **WL ceiling**, the partition by WL colour at depth $L$. Refines monotonically in $L$ for every architecture (the WL combinatorial step refines, period); independent of $\mathcal A$.
- $\Pi^{(L)}_{\mathcal A}$ — the **architecturally realized partition**, the partition by exact equality of $\mathcal A$'s embeddings at depth $L$. Always a coarsening of $\Pi^{(L)}_{\mathrm{WL}}$ if $\mathcal A$ is **not WL-faithful** (it collapses distinctions WL preserves); equals $\Pi^{(L)}_{\mathrm{WL}}$ if $\mathcal A$ is WL-faithful.
- $\Pi^{(L)}_\varepsilon$ — the **operationally observed partition** from §2, a coarsening of $\Pi^{(L)}_{\mathcal A}$ that coincides with it for every $\varepsilon$ below the minimum separating embedding distance $\delta^{(L)}:=\min_{u\not\sim_{\mathcal A}v}\|h^{(L)}(u)-h^{(L)}(v)\|$.

Theorem 5 applies *to whichever depth sequence of partitions one cares about*; the architecture story is about which sequences are refinement chains.

**Theorem 5 applied: architecture sorting.**

*GIN (injective sum + MLP) is WL-faithful and refines.* The aggregation is injective on multisets, so $\Pi^{(L+1)}_{\mathrm{WL}}\succeq\Pi^{(L)}_{\mathrm{WL}}$ until WL-stability, and the MLP injectivity gives $\Pi^{(L)}_{\mathcal A}=\Pi^{(L)}_{\mathrm{WL}}$. The architecturally realized chain is a refinement chain; Theorem 5(a) gives a non-increasing realized floor. For $\varepsilon<\delta^{(L)}$ at each depth $L$ of interest, $\Pi^{(L)}_\varepsilon=\Pi^{(L)}_{\mathrm{WL}}$ and the operationally observed floor falls as well.

*Join-type residual (jumping-knowledge, GCNII) is monotone by construction.* These architectures concatenate or carry forward earlier representations, so two nodes are $\mathcal A$-equivalent at depth $L$ iff they were equivalent at *every* earlier layer; $\Pi^{(L)}_{\mathcal A}=\bigvee_{\ell\le L}\Pi^{(\ell)}_{\mathcal A}$, monotone-refining by construction, and Theorem 5(a) applies. The operational $\Pi^{(L)}_\varepsilon$ inherits the chain whenever $\varepsilon$ is below the per-layer minimum separating distance. This is the partition-level reason the join remedy fixes over-smoothing — it never discards resolution an earlier layer achieved.

*Contractive aggregation (GCN, mean, symmetric-normalized) is not WL-faithful; the WL ceiling refines but the operational partition collapses.* The aggregation is a linear operator whose non-constant spectrum has norm below $1$ (eigenvalues $1=\mu_1>|\mu_2|\ge\cdots$); the informative component of the signal contracts at rate $\lambda_2^L:=|\mu_2|^L$, and the minimum separating embedding distance $\delta^{(L)}$ shrinks geometrically:
$$
\delta^{(L)}\;\le\;C\,\lambda_2^L\qquad\text{for some architecture-dependent }C>0.
$$
The WL ceiling still refines (it is a combinatorial object), so Theorem 5(a) applies at the WL level — the *in-principle* floor is depth-monotone. But at any **fixed** $\varepsilon$, once $\delta^{(L)}<\varepsilon$ — i.e., once $L>L^\ast(\varepsilon)\approx\log(C/\varepsilon)/\log(1/\lambda_2)$ — distinct WL classes collapse into common $\varepsilon$-cells, $\Pi^{(L)}_\varepsilon$ coarsens, and the operationally observed floor *rises*. **This is over-smoothing, identified as the operational gap between the (monotone-refining) WL ceiling and the (coarsening past $L^\ast(\varepsilon)$) operational partition**, with the spectral gap $1-|\mu_2|$ setting its onset. The qualitative statement is robust; turning the constant $C$ and the cell-count rate into a quantitative theorem is Open Problem 2 (§8).

*Attention (GAT) is not statically classified by Theorem 5.* Attention sharpness can refine (sharper-than-uniform attention may, in principle, split a WL cell by exploiting continuous attention weights) or contract (uniform attention reduces to mean). Which regime obtains depends on the data and training, and Theorem 5 yields no static prediction. The bracket of §1, §3 is the diagnostic — it measures the realized regime per task and depth.

**The honest framing.** Three layers, with over-smoothing localized at the gap between them.
- (i) The **WL ceiling** $\Pi^{(L)}_{\mathrm{WL}}$: monotone-refining for every architecture in principle.
- (ii) The **architecturally realized partition** $\Pi^{(L)}_{\mathcal A}$: equals (i) for WL-faithful architectures (GIN, JK), strictly coarser for contractive ones (GCN), undetermined for attention.
- (iii) The **operational partition** $\Pi^{(L)}_\varepsilon$: equals (ii) for $\varepsilon<\delta^{(L)}$, strictly coarser otherwise. Over-smoothing lives in this gap; depth pushes $\delta^{(L)}$ below any positive $\varepsilon$ exactly for contractive architectures.

This yields a three-axis classification — *lattice position* (aggregator class), *WL-faithfulness* (does $\Pi^{(L)}_{\mathcal A}$ reach $\Pi^{(L)}_{\mathrm{WL}}$?), *quantization-collapse regime* (how fast does $\delta^{(L)}$ shrink versus $\varepsilon$?) — under which GIN, GCN, GraphSAGE, residual networks, and graph transformers are distinct coordinate choices measured by the same machinery, and attention is reduced to a per-instance measurement rather than a static classification.

---

## 7. The measure is operational

The variance member is locally testable because its score is a pairwise disagreement probability.

**Proposition 6 (two-query identity).** *Let $X$ be uniform on the nodes and $X'$ uniform on the cell $\Pi(X)$. Then $p_{\mathrm{dis}}:=\mathbb P[f(X)\ne f(X')]=2\,\mathbb E[\mathrm{Var}(f\mid\Pi)]$, and the variance bracket reads in this one observable:*
$$
\tfrac12\big(1-\sqrt{1-2p_{\mathrm{dis}}}\big)\;\le\;\varepsilon^\ast(\Pi)\;\le\;p_{\mathrm{dis}}.
$$

**Proof.** Conditioned on cell $i$, two independent draws disagree with probability $2\eta_i(1-\eta_i)$; averaging over cells, $p_{\mathrm{dis}}=\sum_i p_i\cdot 2\eta_i(1-\eta_i)=2\,\mathbb E[\mathrm{Var}(f\mid\Pi)]$. With the normalized variance $\varphi_{\mathrm{var}}(\eta)=4\eta(1-\eta)$ from §2, $\bar\varphi_{\mathrm{var}}=\mathbb E[4\eta(1-\eta)]=2p_{\mathrm{dis}}$. The bracket of §1 with $c_\varphi=\tfrac12$ (universal for normalized scores) reads $\varphi_{\mathrm{var}}^{-1}(2p_{\mathrm{dis}})\le\varepsilon^\ast(\Pi)\le\tfrac12\cdot 2p_{\mathrm{dis}}=p_{\mathrm{dis}}$; solving $4\eta(1-\eta)=2p_{\mathrm{dis}}$ on $[0,\tfrac12]$ gives the lower endpoint $\tfrac12(1-\sqrt{1-2p_{\mathrm{dis}}})$. $\qquad\blacksquare$

The probability that two co-cell nodes disagree on the label is *exactly* an upper bound on the achievable floor, and one measured number fixes the whole bracket.

**Corollary 7 (label complexity).** *$p_{\mathrm{dis}}$ is estimable to $\pm\varepsilon$ at confidence $1-\delta$ from $m=\lceil\ln(2/\delta)/2\varepsilon^2\rceil$ same-cell pairs (Hoeffding), independent of the number of nodes.*

**Honest cost accounting.** The win is in *label* complexity, and we state the total cost precisely. Computing the WL colouring of the graph is $O(L|E|)$ (one unavoidable linear pass — it is just running WL); bucketing nodes by colour to enable same-cell sampling is a one-time $O(n)$ step; thereafter each of the $m=O(\varepsilon^{-2})$ pairs costs $O(1)$ label queries. So the test queries $O(\varepsilon^{-2})$ *labels* — independent of $n$, the relevant saving when labels are the expensive resource (the global plug-in queries all $n$) — but it is *not* sublinear in total work once the linear WL pass and bucketing are counted. We claim only the label-complexity saving, and the local-test reading (a property test for "$\varepsilon^\ast\le\alpha$", complete because low floor gives low disagreement, sound because $p_{\mathrm{dis}}$ upper-bounds the floor) holds with that accounting.

**The computational picture (deterministic).** For a *given* partition the bracket is $O(n)$ — a single pass over the cells, summing $p_i\,\varphi(\eta_i)$. Since computing the WL colouring is polynomial ($O(L|E|)$ per round, $O(n)$ rounds to stability), **the deterministic bracket is polynomial-time** end-to-end. We deliberately scope the deterministic claim only: randomized / lossy variants — in which messages survive independently with some probability $q\in[0,1]$ and the bracket is averaged over the random partition that results — raise harder questions ($\#$P-hardness on general graphs by a reduction from two-terminal network reliability [Provan–Ball 1983], tractability on bounded-treewidth instances via junction-tree dynamic programming [Lauritzen–Spiegelhalter 1988; Arnborg–Lagergren–Seese 1991], approximation regimes on expanders) but the bracket of those variants is not defined in this paper, and we defer it to a companion work where the random object can be developed honestly.

---

## 8. Discussion, scope, and open problems

We have studied the achievable-error floor of GNN-induced partitions as a calibrated gap measure, transposing classical calibration from the optimization axis to the resolution axis (§3), deriving the aggregator ladder and a cross-architecture depth characterization (§5–§6), and giving a local test (§7). We are explicit about what this is: a population, optimal-classifier floor for *binary* tasks, not a theory of trained-GNN performance.

**Scope and honest limitations.** The measure is the achievable floor, not achieved error; the gap between them (optimization, finite data, inductive bias) is outside our scope, and the aggregator floor ladder accordingly need not match trained-accuracy ordering (§5). The setting is *binary labels with hard cell assignments*; multiclass labels are handled by the simplex companion (Open Problem 1a), and the soft-cell-assignment extension that reaches attention-style architectures remains open (Open Problem 1b). Experiments — the empirical tests of Corollary 4, of the over-smoothing floor-rise (Theorem 5), and of the local test (Proposition 6), on standard node, graph, and heterophilous benchmarks — are deferred to a companion empirical paper and are necessary before any graph-ML claim is final.

**Open problem 1a (multiclass labels — the simplex rigidity).** *Resolved by the companion `04-t1_1_simplex_rigidity.md`.* The hard-partition binary theory extends to $k$-class labels by replacing the rate $\eta\in[0,1]$ with a simplex-valued conditional class distribution $\boldsymbol\eta\in\Delta^{k-1}$. The companion proves that among continuous, vertex-vanishing simplex scores, the multiclass Bayes risk $R(\boldsymbol\eta)=1-\max_c\eta_c$ is the *unique* exact functional (the analogue of Theorem 2 here), so every smooth simplex score (multiclass entropy, Gini) carries strictly positive bracket slack. This extends §3 to multiclass node and graph tasks at the label level.

**Open problem 1b (soft cell assignments — genuinely open).** Architectures that assign each input *probabilistically* to multiple cells — attention (GAT), differentiable pooling, graph transformers — do **not** induce a hard partition. A principled extension requires a *soft-kernel* lifting: treat the architecture as a Markov kernel $K:\mathcal X\to\Delta(\mathrm{Cells})$, define the bracket as an expectation over the random cell assignment, and ask whether the rigidity of Theorem 2 (or its multiclass companion in 1a) survives the lifting. We do not have this lifting; we flag it as separate from 1a (which concerns multiclass *labels*, not multiclass cell assignments) and as the genuine prerequisite for reaching soft / attention-based architectures.

**Open problem 2 (quantitative over-smoothing).** Make §6 precise: prove the dependence of the number of $\varepsilon$-distinguishable cells of $\Pi_\varepsilon^{(L)}$ — equivalently, the rate at which the minimum separating distance $\delta^{(L)}$ shrinks — on the spectral gap $1-|\mu_2|$, turning the qualitative coarsening statement (and the critical depth $L^\ast(\varepsilon)\approx\log(C/\varepsilon)/\log(1/\lambda_2)$ of §6) into a theorem with explicit constants.

**Open problem 3 (gap amplification).** Monotonicity orders the aggregator floors (Corollary 4) but not the size of the gap $\Delta(G)=\varepsilon^\ast(\Pi_{\mathrm{mean}})-\varepsilon^\ast(\Pi_{\mathrm{sum}})$. Is there a graph operation under which a small positive gap is driven to a constant while $\varepsilon^\ast(\Pi_{\mathrm{sum}})$ is preserved? An affirmative answer would be a hardness-of-approximation statement for expressivity and would earn the PCP framing, which until then we use only as an analogy. We caution that the standard amplification primitive (the zig-zag/replacement product) is defined for regular graphs and may not act on the labeled, irregular aggregator-gap quantity as-is; identifying the correct operation is part of the problem. The tractable companion question — how $\Delta$ evolves with depth under the spectral gap (compounding for refining architectures, collapsing at $\lambda_2^L$ for contractive ones) — is the immediate next target.

---

## References

Arnborg, S., Lagergren, J., and Seese, D. *Easy problems for tree-decomposable graphs.* J. Algorithms, 1991.
Arora, S., and Safra, S. *Probabilistic checking of proofs.* J. ACM, 1998.
Arora, S., Lund, C., Motwani, R., Sudan, M., and Szegedy, M. *Proof verification and the hardness of approximation problems.* J. ACM, 1998.
Bartlett, P., Jordan, M., and McAuliffe, J. *Convexity, classification, and risk bounds.* JASA, 2006.
Blackwell, D. *Equivalent comparisons of experiments.* Ann. Math. Statist., 1953.
DeGroot, M. *Uncertainty, information, and sequential experiments.* Ann. Math. Statist., 1962.
Dinur, I. *The PCP theorem by gap amplification.* J. ACM, 2007.
Grünwald, P., and Dawid, A. P. *Game theory, maximum entropy, minimum discrepancy, and robust Bayesian decision theory.* Ann. Statist., 2004.
Hoeffding, W. *Probability inequalities for sums of bounded random variables.* JASA, 1963.
Lauritzen, S., and Spiegelhalter, D. *Local computations with probabilities on graphical structures.* J. R. Stat. Soc. B, 1988.
Le Cam, L. *Asymptotic Methods in Statistical Decision Theory.* Springer, 1986.
Morris, C., et al. *Weisfeiler and Leman go neural.* AAAI, 2019.
Pearl, J. *Probabilistic Reasoning in Intelligent Systems.* Morgan Kaufmann, 1988.
Provan, J. S., and Ball, M. O. *The complexity of counting cuts and of computing the probability that a graph is connected.* SIAM J. Comput., 1983.
Reid, M., and Williamson, R. *Information, divergence and risk for binary experiments.* JMLR, 2011.
Savage, L. J. *Elicitation of personal probabilities and expectations.* JASA, 1971.
Valiant, L. *The complexity of enumeration and reliability problems.* SIAM J. Comput., 1979.
Xu, K., Hu, W., Leskovec, J., and Jegelka, S. *How powerful are graph neural networks?* ICLR, 2019.
Zhang, T. *Statistical behavior and consistency of classification methods based on convex risk minimization.* Ann. Statist., 2004.

---

*Draft 0. Tier-0 review tasks are addressed: the novelty is audited against surrogate-loss and comparison-of-experiments theory and the framing repositioned onto the resolution-level transposition and the GNN consequences (T0.1–T0.2); the induced partition has an operational $\varepsilon$-resolution definition (T0.3); the floor-versus-achieved distinction is stated in the abstract, §1, and §5 (T0.4); and the complexity claims and local-test cost are corrected and honestly accounted (T0.5). The simplex rigidity, the quantitative over-smoothing rate, gap amplification, and all experiments remain open and are marked as such.*
