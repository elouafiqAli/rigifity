# The Achievable-Error Floor of Graph Neural Networks
### Calibration at the Resolution Level
*Draft 0.7 (Final).*

**Abstract.** Weisfeiler–Leman (WL) expressivity returns a binary verdict — distinguishable or not. We study its *calibrated gap* version. A GNN induces a partition $\Pi$ of the inputs, and the **partition-restricted Bayes risk** $\varepsilon^\ast(\Pi)$ is the smallest error any classifier respecting that resolution can achieve. Every concave score gives a two-sided bracket on $\varepsilon^\ast(\Pi)$ with universal upper constant $c_\varphi=\tfrac12$. Within this bracket the $0$-$1$ Bayes risk is the unique exact score (Theorem 2), and on the multiclass simplex the unique exact functional is the Bayes risk $R(\boldsymbol\eta)=1-\max_c\eta_c$ (Theorem 2$'$), so smooth surrogates (entropy, Gini) necessarily carry quantified slack. The bracket is locally testable from $O(\alpha^{-2})$ label queries independent of graph size (Proposition 6), it orders aggregator floors as a refinement-lattice half-chain — sum refines both mean and max while mean and max are incomparable (Corollary 4) — and it characterizes when depth monotonically lowers the floor: refining architectures (GIN, join-type residual) do, contractive ones (GCN, mean) do not and instead over-smooth (Theorem 5).

We are explicit that this is an *achievable floor* — a population, optimal-classifier quantity — and **not** the error of a trained network, which optimization, finite data, and inductive bias additionally govern; the floor ordering across aggregators need not match the trained-accuracy ordering, and we flag where this matters. The methodology is a *resolution-level transposition* of classical results — Blackwell's comparison-of-experiments on the refinement lattice, Bartlett–Jordan–McAuliffe / Reid–Williamson surrogate calibration on the partition functional — and we do not claim those classical facts as new decision theory; what is new is the lattice reading, the GNN consequences above, the multiclass rigidity (Theorem 2$'$), and the two-query local test. The §3 binary kernel **and the §4.2 simplex rigidity (Theorem 2$'$)** are mechanically verified in Lean 4 against mathlib v4.29.1 (57 axiom-clean theorems). Two extensions remain open: a soft-cell-assignment lifting (for attention-style architectures) and a gap-amplification theorem on a structured graph family. Experiments are deferred to a companion empirical paper.

---

## 1. Introduction

Expressivity theory for message-passing graph neural networks rests on one fact: a GNN run for $L$ rounds is no more discriminating than $L$ rounds of WL colour refinement, with equality when neighborhood aggregation is injective [Xu et al.; Morris et al.]. This is an all-or-nothing statement — two graphs are WL-distinguishable or not — and it is silent on the middle ground: among feasible tasks, which are nearly impossible across a bottleneck, and by how much does a weaker aggregator's information loss cost. We study the calibrated gap version of the verdict, and we are careful about exactly which quantity we measure.

**The quantity, and what it is not.** A GNN induces a partition $\Pi$ of the inputs (by colour or quantized embedding). Its **partition-restricted Bayes risk** $\varepsilon^\ast(\Pi)$ is the smallest error of any classifier constant on the cells of $\Pi$. This is the *achievable floor* at that resolution: a population quantity, attained by the Bayes-optimal cell-wise rule. It is **not** the error of a trained GNN. A trained network's error is additionally shaped by optimization dynamics, finite-sample estimation, and inductive bias, none of which this paper addresses. The floor is a lower bound on the error any classifier at that resolution can reach, and (via the bracket below) we also bound it from above; but trained accuracy can sit far above the floor, and — a point we return to in §5 — the *floor* ordering across aggregators need not match the *trained-accuracy* ordering. We measure what is representable at a given resolution, not what a given optimizer learns.

**The bracket.** For a *normalized* concave score functional $\varphi$ (defined formally in §2: concave on $[0,1]$, symmetric, vanishing at $\{0,1\}$, $\varphi(\tfrac12)=1$, strictly increasing on $[0,\tfrac12]$), the scalar average score $\bar\varphi(\Pi)=\sum_i p_i\varphi(\eta_i)$ (cell masses $p_i$, label rates $\eta_i$) bounds $\varepsilon^\ast(\Pi)$ from both sides:
$$
\varphi^{-1}\big(\bar\varphi(\Pi)\big)\;\le\;\varepsilon^\ast(\Pi)\;\le\;c_\varphi\,\bar\varphi(\Pi),\qquad c_\varphi=\sup_{\eta\in(0,1/2]}\frac{\eta}{\varphi(\eta)}.
$$
For any such $\varphi$, concavity above the chord through $(0,0)$ and $(\tfrac12,1)$ gives $\varphi(\eta)\ge 2\eta$ on $[0,\tfrac12]$, so $c_\varphi=\tfrac12$ *uniformly*, attained at $\eta=\tfrac12$. The upper endpoint is therefore $\bar\varphi(\Pi)/2$ for every member of the class; the score-dependence of the upper instrument lives entirely in $\bar\varphi$, not in $c_\varphi$. The interval is the *calibrated gap measure*: a certified range for the achievable floor, computable from the induced partition before any classifier is trained.

**The conceptual frame.** WL feasibility is the *decision* problem; the bracket is its *gap* version, and (§7) it is locally checkable. This is, in spirit, the relationship a PCP bears to satisfiability [Arora–Safra; Arora et al.; Dinur], with the caveat (§8) that we have the locally-checkable half but not yet a gap-amplification theorem, so we use the PCP framing as an analogy and not a claim.

**Notation and scope.** §§1–3 and §§5–7 work with binary tasks: $\eta\in[0,1]$ denotes a scalar conditional label rate. §4 extends the development to multiclass tasks via the simplex generalization $\boldsymbol\eta\in\Delta^{k-1}$ (boldface), with the binary case recovered at $k=2$ by $\eta:=\eta_1$. The symbols $\varphi$ (concave score) and $c_\varphi$ (upper bracket constant) carry the same role across both settings; the binary normalization $c_\varphi=\tfrac12$ is replaced in the multiclass case by an explicit finiteness hypothesis stated in §4.1. The symbol $R$ for the cell-level Bayes risk is reserved for §4 (where $R(\boldsymbol\eta)=1-\max_c\eta_c$); the binary case writes the cell-level analogue $\min(\eta,1-\eta)$ out without a separate symbol, with $\varepsilon^\ast(\Pi)=\sum_i p_i\min(\eta_i,1-\eta_i)$ for the partition-level aggregate.

### 1.1 What is new, and what is not

We separate borrowed foundations from contributions deliberately, because the foundations are classical and over-claiming them would be wrong.

*Not new (recalled and reformulated in §3, credited in §1.2).* The correspondence between a concave generalized entropy and the Bayes risk [Savage; DeGroot; Grünwald–Dawid]; the monotonicity of the Bayes risk under more informative experiments [Blackwell; Le Cam]; and the surrogate-calibration phenomenon that the $0$-$1$ loss is uniquely self-calibrated while smooth surrogates incur a transform gap [Bartlett–Jordan–McAuliffe; Zhang; Reid–Williamson]. Our Theorem 1 (refinement-monotone $\Leftrightarrow$ concave) is the refinement-lattice form of the first two; our Theorem 2 (the Bayes risk is the unique exact-bracket score) and Corollary 3 (smoothness forces slack) are the partition-bracket form of the third.

*New (the contributions of this paper).*
1. **The graph-neural-network consequences of the bracket:** the calibrated gap-test for WL feasibility (§5); the GIN aggregator half-chain — sum refines both mean and max while mean and max are incomparable — as a one-line refinement-lattice corollary (Corollary 4); and the cross-architecture characterization of depth-monotonicity (Theorem 5, lifted to multiclass via Theorem 1$'$ of §4.4), with over-smoothing identified as the floor increase of contractive architectures and residual networks explained as monotone-by-construction.
2. **The multiclass extension on the simplex (§4):** Theorem 2$'$ shows that among continuous vertex-vanishing simplex scores, the multiclass Bayes risk $R(\boldsymbol\eta)=1-\max_c\eta_c$ is the unique exact functional, with smooth multiclass surrogates (entropy, Gini) carrying strictly positive bracket slack (Corollary 3$'$). This carries the development from binary to multiclass at the *label* level; the orthogonal extension to soft *cell assignments* needed by attention-style architectures remains open (§8 OP1b).
3. **A two-query local test** for the floor (Proposition 6, Corollary 7) whose *label* complexity is independent of graph size.
4. **The methodology — calibration on the resolution axis.** Surrogate-calibration theory controls the *excess risk of a learned predictor*; we use the same machinery to control the *achievable floor as a function of the resolution* — the partition the model can access — over the refinement lattice. This expressivity reading, and the lattice structure, are not in the surrogate-loss literature, and they organize the contributions above into a single picture.

### 1.2 Relation to prior work (the audit)

The objects we use are classical, and we state the relationship precisely so the contribution is not mistaken.

*Generalized entropy and Bayes risk.* For a proper loss, the conditional Bayes risk $H(\eta)=\inf_a\mathbb E_{Y\sim\mathrm{Bern}(\eta)}\,\ell(Y,a)$ is concave, and the Bayes risk of a partition is $\sum_i p_i H(\eta_i)$ [Savage 1971; DeGroot 1962; Grünwald–Dawid 2004]. Our "score functional" $\varphi$ *is* such an $H$, and our "partition functional" $\bar\varphi(\Pi)$ *is* the partition-restricted Bayes risk for the matched loss. These are not new objects.

*Comparison of experiments.* That a more informative experiment (a refinement) cannot increase the Bayes risk, for every loss, is Blackwell's theorem [Blackwell 1953; Le Cam]. Theorem 1's monotonicity direction is this fact on the refinement lattice; its converse (monotone $\Rightarrow$ concave) is an elementary consequence of the definition of concavity via binary splits.

*Surrogate calibration.* For a surrogate margin loss, Bartlett, Jordan, and McAuliffe [2006] (and Zhang [2004]) relate excess $0$-$1$ risk to excess surrogate risk through the $\psi$-transform, $\psi(R-R^\ast)\le R_\varphi-R_\varphi^\ast$, where $\psi$ is the convexification of $H^-(\eta)-H(\eta)$; the $0$-$1$ loss gives the identity $\psi$, and smooth surrogates give a strictly convex $\psi$. Our Theorem 2 — the bracket is exact only for the tent (the $0$-$1$ Bayes risk) — is the partition-bracket counterpart of "$\psi$ is the identity only for the $0$-$1$ loss," and Corollary 3 is the counterpart of "smooth surrogates have $\psi\ne\mathrm{id}$." Two formal differences are worth noting: BJM bound *excess* risk of a *predictor* (the optimization axis), whereas we bound the *absolute* Bayes risk of a *partition* (the resolution axis); and our bound is two-sided (calibration via $c_\varphi$ and its converse via $\varphi^{-1}$) where the $\psi$-transform is one-sided. We do not claim Theorem 2 as a new decision-theoretic fact; we claim the resolution-level transposition and the GNN consequences.

*Multiclass surrogate calibration.* The multiclass case is genuinely more delicate than the binary case — many natural multiclass surrogates fail to be calibrated [Tewari–Bartlett 2007; Ramaswamy–Agarwal 2012; Pires–Szepesvári 2016]. Section 4's Theorem 2$'$ (the simplex rigidity) is the resolution-level companion of that body of work: among continuous vertex-vanishing simplex scores, the multiclass Bayes risk $R=1-\max_c\eta_c$ is the unique exact one, and smooth multiclass surrogates (entropy, Gini) incur a strictly positive bracket slack via a convex-envelope lower endpoint. To our knowledge the resolution-level multiclass uniqueness is not stated in this form in the calibration literature, though it is in the spirit of that work. The two settings probe different aspects of the same kinked $R$: the multiclass calibration literature asks whether a smooth surrogate's *minimizer* matches the Bayes *predictor* (a property of the surrogate-argmin-to-Bayes-argmax map), while Theorem 2$'$ asks whether a smooth surrogate's partition-level *aggregate* $\bar\varphi$ determines the partition-level Bayes *risk* $\varepsilon^\ast$ (a property of the partition functional). Consistency in their sense does not imply exactness in ours: even a surrogate certified as multiclass-calibrated can be inexact in our sense, since Theorem 2$'$ singles out scalar multiples of $R$ among *all* continuous vertex-vanishing scores.

*Reid–Williamson [2011]* unify scoring rules, divergences, and binary-experiment risk and are the closest source of the analytic machinery; we build on their viewpoint.

*Mechanization.* The §3 binary kernel **and the §4.2 simplex rigidity (Theorem 2′)** are mechanically verified end-to-end in Lean 4 against mathlib v4.29.1: 57 theorems carry an axiom-clean certificate (`Audit/PrintAxioms.lean` confirms only the three standard Lean axioms `propext`, `Classical.choice`, `Quot.sound`), covering the bracket itself, the universal $c_\varphi=\tfrac12$, Theorem 1 (refinement-monotonicity ⟺ concavity, both directions), Theorem 2 (tent uniqueness, both directions), **Theorem 2′ (simplex rigidity, both directions)**, Proposition 6 (the two-query identity and variance bracket), and both worked examples of §4.3 (Step-1 violation A and slack mechanism B, `native_decide`-verified over rationals). The Lean statements consume four realizability typeclasses (`SingleCellRealizable`, `BinarySplitRealizable`, `SingleCellRealizableSimplex`, `TwoCellRealizableSimplex`), each provable from atomlessness via Sierpiński's theorem; the corresponding mathlib contribution is in flight. Theorem 1′ is not separately mechanized: its proof is a direct port of the (mechanized) Theorem 1 tower-property + Jensen argument with the simplex playing the role of $[0,1]$, deferred because `simplex_rigidity` does not depend on it. Appendix A catalogs every paper claim with its Lean cross-reference; Appendix B describes the formalization workflow.

---

## 2. Preliminaries

Let $(\mathcal X,\mathcal F,\mathbb P)$ be a probability space and $f:\mathcal X\to\{0,1\}$ measurable. A **partition** $\Pi=\{S_1,\dots,S_m\}$ is finite and measurable, with masses $p_i=\mathbb P(S_i)$ and rates $\eta_i=\mathbb P(f=1\mid S_i)$. $\Pi'$ **refines** $\Pi$ ($\Pi'\succeq\Pi$) if each cell of $\Pi'$ lies in a cell of $\Pi$. The **partition-restricted Bayes risk** is $\varepsilon^\ast(\Pi)=\sum_i p_i\min(\eta_i,1-\eta_i)$, and for $\varphi:[0,1]\to\mathbb R$ the **partition functional** is $\bar\varphi(\Pi)=\sum_i p_i\varphi(\eta_i)$.

A **normalized score** is concave, continuous, symmetric ($\varphi(\eta)=\varphi(1-\eta)$), vanishing at $\{0,1\}$, normalized by $\varphi(\tfrac12)=1$, and strictly increasing on $[0,\tfrac12]$ (so $\varphi^{-1}:[0,1]\to[0,\tfrac12]$ exists). Running members: Shannon entropy and the rescaled variance $4\eta(1-\eta)$. The **tent** $T(\eta)=2\min(\eta,1-\eta)$ is the normalized $0$-$1$ Bayes risk.

**The induced partition (operational definition).** WL refinement produces *discrete* colours, so the WL-colour partition $\Pi_{\mathrm{WL}}$ is exact and needs no quantization. A trained GNN produces *continuous* embeddings $h:V\to\mathbb R^d$, which do not induce a finite partition directly; we therefore fix an **$\varepsilon$-net** $N_\varepsilon\subset\mathbb R^d$ (a maximal $\varepsilon$-separated subset of the image of $h$) and define the **$\varepsilon$-resolution partition** $\Pi_\varepsilon$ as the Voronoi partition of nodes by their nearest point in $N_\varepsilon$; a nested dyadic grid is a special case. Then $\Pi_\varepsilon$ is a genuine partition.

Three properties of $\Pi_\varepsilon$ we use, with their precise scope:
- *(Monotonicity in $\varepsilon$ along a nested family.)* If $N_{\varepsilon'}\subset N_\varepsilon$ for $\varepsilon'\le\varepsilon$, then $\Pi_{\varepsilon'}\succeq\Pi_\varepsilon$, and by Theorem 1 the floor is non-decreasing in $\varepsilon$ along the family.
- *(Dependence on the net.)* Different choices of $N_\varepsilon$ produce different partitions; the dependence is bounded by the cell diameter — two same-$\varepsilon$ nets disagree on a node only if its embedding lies within $\varepsilon$ of a Voronoi boundary, a set of measure $O(\varepsilon)$ in the embedding distribution (with constant depending on the embedding dimension and on the local density near the boundary). Qualitative conclusions are stable; per-task numerics may shift at order $\varepsilon$, which we report rather than ignore.
- *(WL-faithful limit.)* For a **WL-faithful** GNN (one that maps WL-distinguishable nodes to distinct embeddings — GIN with sum + an injective MLP is the model case), $\Pi_\varepsilon=\Pi_{\mathrm{WL}}$ for every $\varepsilon$ smaller than the minimum separating embedding distance $\delta_{\mathrm{WL}}:=\min_{u\not\sim_{\mathrm{WL}}v}\|h(u)-h(v)\|$. For a non-WL-faithful GNN, $\Pi_\varepsilon$ is in general a coarsening of the exact-embedding partition and a *further* coarsening of $\Pi_{\mathrm{WL}}$; §6 distinguishes the architecture-equivalence analogue $\delta^{(L)}$ from this WL version $\delta_{\mathrm{WL}}$ explicitly.

All depth statements (§5–§6) fix a nested $\varepsilon$-net family and vary depth.

The role of the graph neural network is solely that it *produces* the partition (via $\Pi_{\mathrm{WL}}$ or $\Pi_\varepsilon$); §3 is about partitions and is indifferent to their origin.

---

## 3. Calibration on the refinement lattice

We recall the two facts we need in the partition-lattice form, with proofs for self-containedness, and credit them as in §1.2.

### 3.1 Refinement-monotonicity is concavity

**Theorem 1.** *Let $(\mathcal X,\mathcal F,\mathbb P)$ be atomless (so that arbitrary cell-rate splits are realizable). For continuous $\varphi:[0,1]\to\mathbb R$, the following are equivalent: (i) $\bar\varphi$ is monotone, $\Pi'\succeq\Pi\Rightarrow\bar\varphi(\Pi')\le\bar\varphi(\Pi)$, over all finite measurable partitions and all measurable labelings $f:\mathcal X\to\{0,1\}$; (ii) $\bar\varphi$ is non-increasing under every binary split of a cell; (iii) $\varphi$ is concave. On a general (possibly atomic) space the implications $(\mathrm{iii})\Leftrightarrow(\mathrm{i})\Leftrightarrow(\mathrm{ii})$ continue to hold by density of realizable splits and continuity of $\varphi$.*

**Proof.** $(i)\Rightarrow(ii)$ is immediate. $(iii)\Rightarrow(i)$: refining $S_i$ into subcells with conditional weights $w_{ik}=p_{ik}/p_i$ and rates $\eta_{ik}$ gives $\eta_i=\sum_k w_{ik}\eta_{ik}$ (tower property), and concavity gives $\varphi(\eta_i)\ge\sum_k w_{ik}\varphi(\eta_{ik})$; multiply by $p_i$ and sum. $(ii)\Rightarrow(iii)$: for $a,b\in[0,1],\lambda\in[0,1]$ set $\eta=\lambda a+(1-\lambda)b$; on an atomless space, realize a cell of rate $\eta$ split into subcells of weights $\lambda,1-\lambda$ and rates $a,b$ (place conditional $f{=}1$ mass $\lambda a$ and $f{=}0$ mass $\lambda(1-a)$ in the first), and binary monotonicity reads $\varphi(\lambda a+(1-\lambda)b)\ge\lambda\varphi(a)+(1-\lambda)\varphi(b)$, i.e. concavity; on a general space the realizable splits give a dense set of weights and continuity completes it. $\qquad\blacksquare$

This is Blackwell's ordering [Blackwell 1953] on the refinement lattice together with its elementary converse; we use it to fix the class (concave scores) within which calibration operates.

### 3.2 The $0$-$1$ Bayes risk is the unique exact score

For a normalized score, Theorem 1 yields the bracket of §1; call it **exact** if its endpoints coincide for every partition.

**Theorem 2.** *Let $(\mathcal X,\mathcal F,\mathbb P)$ be atomless (so that single-cell partitions of arbitrary rate $\eta\in[0,1]$ are realizable). A normalized score $\varphi$ has an exact bracket if and only if $\varphi=T$. On a general (possibly atomic) space the equivalence continues to hold by density of realizable rates and continuity of $\varphi$.*

**Proof.** For $T$: $\varphi^{-1}(t)=t/2$, $c_T=\tfrac12$, and both endpoints equal $\tfrac12\bar T(\Pi)=\varepsilon^\ast(\Pi)$. Conversely, exactness means the two bracket endpoints coincide on every partition. Apply this to the single-cell partition of rate $\eta\in[0,\tfrac12]$: $\bar\varphi(\Pi)=\varphi(\eta)$ and $\varepsilon^\ast(\Pi)=\eta$, so the lower endpoint $\varphi^{-1}(\varphi(\eta))=\eta$ is automatically tight — this holds for *every* normalized $\varphi$, so exactness on single cells reduces purely to upper-endpoint tightness, $c_\varphi\,\varphi(\eta)=\eta$, i.e.
$$
\eta\;=\;c_\varphi\,\varphi(\eta)\qquad\text{for every }\eta\in[0,\tfrac12].
$$
Hence $\varphi(\eta)=\eta/c_\varphi$ on $[0,\tfrac12]$; normalization $\varphi(\tfrac12)=1$ pins $c_\varphi=\tfrac12$, so $\varphi(\eta)=2\eta$ on $[0,\tfrac12]$, and symmetry gives $\varphi=T$. $\qquad\blacksquare$

**Remark (relation to the $\psi$-transform).** Exactness of the bracket is the resolution-level counterpart of the $\psi$-transform being the identity, which [BJM 2006] holds for the $0$-$1$ loss. The tent is concave but not strictly so and has a corner at $\eta=\tfrac12$ — the locus where the Bayes rule flips its vote — and that corner is the source of the gap below. (The two-cell affine-equality argument familiar from the simplex extension is unnecessary here: single-cell partitions already pin $\varphi$ pointwise, because in the binary case $\varphi$ is a function of the scalar $\eta$. The two-cell argument earns its keep only when $\varphi$ is not a function of $\varepsilon^\ast$ — i.e., on the multiclass simplex.)

**Corollary 3 (smoothness forces slack).** *If a normalized score is strictly concave on a subinterval of $(0,\tfrac12)$ — in particular any differentiable score with $\varphi''<0$, e.g. Shannon entropy or rescaled variance — then the bracket is strict on some partition; no differentiable concave score is exact.* (By Theorem 2 only $T$, nowhere strictly concave, is exact; a two-cell partition with rates in the strict region makes Jensen strict.)

The reading: one uses a *smooth* surrogate because applications need differentiability (a trainable objective, a well-defined inverse, curvature away from the corner); the moment smoothness is demanded, exactness is lost, by the same phenomenon that makes the $\psi$-transform nontrivial for smooth surrogates. The bracket gap is the resolution-level image of that transform gap. The upper endpoint is $\bar\varphi(\Pi)/2$ for every normalized score (by the universal $c_\varphi=\tfrac12$ noted in §1), so the comparison between surrogates is a comparison of $\bar\varphi$ values; the pointwise domination $4\eta(1-\eta)\le H(\eta)$ gives $\bar\varphi_{\mathrm{var}}\le\bar\varphi_H$ on every partition, so the variance member yields the tighter upper instrument.

---

## 4. Multiclass extension on the simplex

The binary development of §3 generalizes to $k$-class tasks by replacing the scalar rate $\eta\in[0,1]$ with a simplex-valued conditional class distribution $\boldsymbol\eta\in\Delta^{k-1}$. The rigidity, the bracket, and the smoothness–slack corollary all transfer; the proof of the rigidity has the same three-step skeleton as the binary Theorem 2, but in the simplex case all three steps are genuinely needed (§4.2 closing remark), and the multiclass setting *reveals the mechanism* the binary case concealed — smooth scores resolve distinctions the Bayes risk identifies, and the surplus is the slack.

### 4.1 Simplex setup and bracket

Fix $k\ge 2$ classes. A cell's conditional class distribution is a point $\boldsymbol\eta=(\eta_1,\dots,\eta_k)$ in the simplex $\Delta^{k-1}=\{\boldsymbol\eta\ge 0:\sum_c\eta_c=1\}$; vertices $\mathbf e_c$ are the pure (deterministic) cells, the center $\mathbf u=(1/k,\dots,1/k)$ the maximally uncertain one. A partition $\Pi$ has cells of mass $p_i$ and conditional distributions $\boldsymbol\eta_i\in\Delta^{k-1}$.

The Bayes-optimal cell-wise predictor guesses $\arg\max_c\eta_{i,c}$ and errs with probability $1-\max_c\eta_{i,c}$, so the **partition-restricted Bayes risk** is
$$
\varepsilon^\ast(\Pi)\;=\;\sum_i p_i\,R(\boldsymbol\eta_i),\qquad R(\boldsymbol\eta):=1-\max_c\eta_c .
$$
$R$ is the multiclass analogue of the tent: concave on $\Delta^{k-1}$ (since $\max_c\eta_c$ is convex as a maximum of linear forms), continuous, permutation-symmetric, vanishes at the vertices, maximal at $\mathbf u$ with $R(\mathbf u)=1-1/k$. It is piecewise-linear, with corners on the loci $\{\eta_c=\eta_{c'}=\max\}$ where the optimal vote switches.

A **simplex score** is a continuous $\varphi:\Delta^{k-1}\to\mathbb R_{\ge 0}$ with $\varphi(\mathbf e_c)=0$ at the vertices; when needed we add concavity and permutation-symmetry. (Interior positivity — $\varphi>0$ on $\Delta^{k-1}\setminus\{\text{vertices}\}$ — is a *consequence* of exactness on a non-trivial space, not a hypothesis we impose: Theorem 2′'s only-if proof derives $\varphi(\mathbf u)>0$ from $R(\mathbf u)>0$ at the center plus Step 1 plus $G(0)=0$. We carry the weaker definition throughout.) The **partition functional** is $\bar\varphi(\Pi)=\sum_i p_i\varphi(\boldsymbol\eta_i)$. Running members: multiclass entropy $\varphi_H(\boldsymbol\eta)=-\sum_c\eta_c\log\eta_c$ and Gini impurity $\varphi_G(\boldsymbol\eta)=1-\sum_c\eta_c^2$.

The binary bracket had a closed-form lower endpoint $\varphi^{-1}(\bar\varphi)$ because, on $[0,1]$, symmetry made $\varphi$ a function of the scalar $R$. On the simplex this fails — $\varphi$ lives on a $(k-1)$-dimensional set and is generally *not* a function of $R$ — so the lower endpoint is necessarily implicit. We give both bounds, under one explicit regularity hypothesis on the upper instrument.

**Upper bound (under $c_\varphi<\infty$).** Set $c_\varphi:=\sup_{\boldsymbol\eta\ne\text{vertex}}R(\boldsymbol\eta)/\varphi(\boldsymbol\eta)$. *We assume $c_\varphi<\infty$, equivalently that $\varphi$ vanishes at most linearly at every vertex* (scores vanishing faster — e.g. $\|\boldsymbol\eta-\mathbf e_c\|^2$ — give $c_\varphi=\infty$ and a vacuous upper bound; entropy vanishes like $s\log(1/s)$ and Gini like $2s$ at a vertex, both at least linear, so both satisfy the hypothesis). Under this hypothesis the pointwise inequality $R(\boldsymbol\eta)\le c_\varphi\varphi(\boldsymbol\eta)$ aggregates to $\varepsilon^\ast(\Pi)\le c_\varphi\,\bar\varphi(\Pi)$. For Gini the constant is clean: $\sum_c\eta_c^2\le(\max_c\eta_c)\sum_c\eta_c=\max_c\eta_c$, so $R\le\varphi_G$ pointwise, $c_{\varphi_G}=1$, and $\varepsilon^\ast\le\bar\varphi_G$ — the average Gini upper-bounds the multiclass Bayes risk. For entropy $c_{\varphi_H}$ is attained in the interior.

**Lower bound.** Define the *level-set floor* $\ell_\varphi(v)=\inf\{R(\boldsymbol\eta):\varphi(\boldsymbol\eta)=v\}$ — the least Bayes risk consistent with score $v$ — so that $R(\boldsymbol\eta)\ge\ell_\varphi(\varphi(\boldsymbol\eta))$ pointwise. Let $\ell_\varphi^{\ast\ast}$ be its lower convex envelope (Fenchel biconjugate). Then, since $\ell_\varphi\ge\ell_\varphi^{\ast\ast}$ and $\ell_\varphi^{\ast\ast}$ is convex,
$$
\varepsilon^\ast(\Pi)=\sum_i p_i R(\boldsymbol\eta_i)\;\ge\;\sum_i p_i\,\ell_\varphi^{\ast\ast}\!\big(\varphi(\boldsymbol\eta_i)\big)\;\ge\;\ell_\varphi^{\ast\ast}\!\big(\bar\varphi(\Pi)\big),
$$
the last step by Jensen for the convex $\ell_\varphi^{\ast\ast}$. So
$$
\boxed{\;\ell_\varphi^{\ast\ast}\big(\bar\varphi(\Pi)\big)\;\le\;\varepsilon^\ast(\Pi)\;\le\;c_\varphi\,\bar\varphi(\Pi).\;}
$$
The convexification is the same device as the Bartlett–Jordan–McAuliffe $\psi$-transform, which is itself the biconjugate of a level-set gap; this is the resolution-level analogue, and it makes the binary case a corollary (there $\ell_\varphi=\varphi^{-1}$ is already convex, so $\ell_\varphi^{\ast\ast}=\varphi^{-1}$ and the lower endpoint is $\varphi^{-1}(\bar\varphi)$).

**Remark (implicit lower endpoint).** Unlike $\varphi^{-1}$ in the binary case, $\ell_\varphi$ is a constrained minimization of the Bayes risk over a score-level-set — computable but generally not closed-form. Characterizing $\ell_\varphi$ in closed form for entropy and Gini (the minimizer is, by symmetry, a most-concentrated distribution on the level set) is a minor technical thread; it does not affect the rigidity below.

### 4.2 The rigidity theorem

Call $\varphi$ **exact** if some function $G$ satisfies $\varepsilon^\ast(\Pi)=G(\bar\varphi(\Pi))$ for every finite partition. Exactness is equivalent to the bracket collapsing, $\ell_\varphi^{\ast\ast}(\bar\varphi)=c_\varphi\bar\varphi$ for all $\Pi$.

**Theorem 2′ (Simplex Rigidity — multiclass extension of Theorem 2).** *Let $(\mathcal X,\mathcal F,\mathbb P)$ be an atomless probability space (so that finite partitions of arbitrary cell mass and arbitrary conditional class distribution are realizable), and let $\varphi:\Delta^{k-1}\to\mathbb R_{\ge 0}$ be continuous and vanish at the vertices. Then $\varphi$ is exact — there exists $G:\mathbb R\to\mathbb R$ such that $\varepsilon^\ast(\Pi)=G(\bar\varphi(\Pi))$ for every finite measurable partition $\Pi$ and every measurable labeling $f:\mathcal X\to\{1,\dots,k\}$ — if and only if $\varphi=\lambda R$ for some $\lambda>0$, where $R(\boldsymbol\eta)=1-\max_c\eta_c$. Moreover every exact $\varphi$ is automatically concave and permutation-symmetric. On a general (possibly non-atomless) space the conclusion holds for $\varphi$ continuous, by density of realizable splits.*

**Proof.**

*(If.)* If $\varphi=\lambda R$ then $\bar\varphi(\Pi)=\lambda\sum_i p_i R(\boldsymbol\eta_i)=\lambda\,\varepsilon^\ast(\Pi)$, so $\varepsilon^\ast=G(\bar\varphi)$ with $G(v)=v/\lambda$. Exact. And $\lambda R$ inherits concavity and symmetry from $R$.

*(Only if.)* Suppose $\varphi$ exact, with $\varepsilon^\ast(\Pi)=G(\bar\varphi(\Pi))$.

*Step 1 — single cells force $R=G\circ\varphi$.* For the one-cell partition with distribution $\boldsymbol\eta$, $\varepsilon^\ast=R(\boldsymbol\eta)$ and $\bar\varphi=\varphi(\boldsymbol\eta)$, so $R(\boldsymbol\eta)=G(\varphi(\boldsymbol\eta))$ for all $\boldsymbol\eta$. **This is the operative structural constraint:** $R$ must be constant on $\varphi$-level sets — $\varphi(\boldsymbol\eta)=\varphi(\boldsymbol\eta')$ implies $R(\boldsymbol\eta)=R(\boldsymbol\eta')$. Equivalently, $R$ is a *function of $\varphi$* (whereas $\varphi$ is in general *not* a function of $R$ — see §4.1), $\varphi$'s level sets refine $R$'s, and $G$ is determined on the range of $\varphi$. The §4.3 worked example A below exhibits a smooth score (Gini) with two distributions sharing a $\varphi_G$-value but having different $R$-values — an explicit Step-1 violation. (The companion observation that $\varphi_G$ distinguishes some distributions $R$ identifies — i.e., $\varphi$ is not a function of $R$ — is the *slack mechanism*, illustrated in worked example B; it is not what fails Step 1, but it is what opens the bracket.)

*Step 2 — two cells force $G$ affine.* For a two-cell partition with masses $p_1,p_2$ and distributions $\boldsymbol\eta_1,\boldsymbol\eta_2$, write $u_j=\varphi(\boldsymbol\eta_j)$. Exactness and Step 1 give
$$
p_1 G(u_1)+p_2 G(u_2)=p_1 R(\boldsymbol\eta_1)+p_2 R(\boldsymbol\eta_2)=\varepsilon^\ast=G(\bar\varphi)=G(p_1 u_1+p_2 u_2).
$$
Because $\varphi$ is continuous on the compact connected simplex, $\varphi_{\max}:=\max_{\boldsymbol\eta\in\Delta^{k-1}}\varphi(\boldsymbol\eta)$ is attained (Weierstrass), and by the intermediate value theorem $\varphi$ ranges over the full interval $[0,\varphi_{\max}]$ — so on the atomless space $u_1,u_2$ range independently over $[0,\varphi_{\max}]$ and $p_1\in[0,1]$ is free. Hence
$$
p_1 G(u_1)+p_2 G(u_2)=G(p_1 u_1+p_2 u_2)\qquad\text{for all }u_1,u_2\in[0,\varphi_{\max}],\ p_1+p_2=1. \tag{★}
$$
**The chord substitution gives $G$ affine in one line.** Pin one cell at the $\varphi$-argmax ($u_1=\varphi_{\max}$) and one at any vertex ($u_2=0$); for $v\in[0,\varphi_{\max}]$, set $p_1=v/\varphi_{\max}$ in $(\star)$ to get
$$
G(v)=\tfrac{v}{\varphi_{\max}}\,G(\varphi_{\max})+\bigl(1-\tfrac{v}{\varphi_{\max}}\bigr)G(0),
$$
an explicit affine formula $G(v)=av+b$ with $a=\bigl(G(\varphi_{\max})-G(0)\bigr)/\varphi_{\max}$ and $b=G(0)$. *(No Cauchy-equation / Hamel-basis machinery is required — the continuous convex-combination form of Jensen's equation is solved in closed form by the chord substitution. A boundedness side observation is available — $G$'s image lies in $[0,1-1/k]$ by Step 1, since $G\circ\varphi=R$ — but it is not used here; the chord identity alone suffices. The Lean mechanization in `simplex_rigidity` proves this step via exactly this argument, pinning at $\eta_2=\mathbf{e}_0$ inside `h_pin_vertex`, and `affine_of_jensen_eq` is provided as a standalone with the boundedness hypothesis in the signature but unused.)*

*Step 3 — vertices pin the constants.* At a vertex, $\varphi(\mathbf e_c)=0$ and $R(\mathbf e_c)=0$, so $G(0)=0\Rightarrow b=0$. Then $R(\boldsymbol\eta)=a\,\varphi(\boldsymbol\eta)$ for all $\boldsymbol\eta$. If $a=0$ this forces $R\equiv 0$, contradicting $R(\mathbf u)=1-1/k>0$; hence $a\ne 0$, and matching signs at any interior point where $R>0$ (such as $\mathbf u$) gives $a>0$. Therefore $\varphi=\lambda R$ with $\lambda=1/a>0$, and concavity and symmetry of $\varphi$ follow because $\varphi$ is a positive multiple of $R$. $\qquad\blacksquare$

Two remarks worth stating. First, the *only-if* direction uses only continuity, vertex-vanishing, and realizability — **not** concavity or symmetry; those are *conclusions* about exact functionals, not hypotheses. The Bayes risk is singled out among all continuous vertex-vanishing scores, not merely among concave symmetric ones. Second, the proof has the same three-step skeleton as the binary Theorem 2 (single cell, two cells, vertices), but it is *not* verbatim — and the difference is the point. In the binary case Step 1 alone pins $\varphi$ pointwise on $[0,\tfrac12]$ because binary symmetry makes $\varphi$ a function of the scalar $\eta$, so the §3.2 remark correctly notes that the two-cell and vertex steps are unnecessary there. On the simplex $\varphi$ is no longer a function of $R$ (it lives on a $(k-1)$-dimensional set), so Step 1 only yields $R = G\circ\varphi$; the two-cell step is *needed* to force $G$ affine, and the vertex step is *needed* to pin the constant. The multiclass proof genuinely uses all three steps, and that proof-structural difference is what the binary case had concealed. The IVT runs over a higher-dimensional connected domain without trouble.

### 4.3 Smoothness forces slack — and the mechanism the simplex reveals

**Corollary 3′ (smoothness–slack, multiclass).** *Any simplex score that is not a scalar multiple of $R$ — in particular any smooth score, since $R$ is piecewise-linear with corners — is inexact, so its bracket is strict on some partition. Multiclass entropy and Gini are smooth, hence inexact, hence carry strictly positive slack.*

The binary Corollary 3 attributed the slack to the single kink of the tent at $\eta=\tfrac12$. The multiclass case exposes the deeper mechanism: the kink locus widens from a point to a $(k-2)$-dimensional skeleton — the set $\{\boldsymbol\eta:\eta_c=\eta_{c'}=\max\text{ for some }c\ne c'\}$ where the optimal vote switches — but the mechanism (smooth scores cannot reproduce kinks of $R$) is identical to the binary case.

**Worked example A ($k=3$, Step-1 violation).** Take two cells with the *same* Gini score but *different* Bayes risk:
$$
\boldsymbol\eta = (2/3,\,1/6,\,1/6),\qquad \boldsymbol\eta' = (1/2,\,1/2,\,0),\qquad \varphi_G(\boldsymbol\eta)=\varphi_G(\boldsymbol\eta')=\tfrac12.
$$
Indeed $\varphi_G(\boldsymbol\eta)=1-(4/9+1/36+1/36)=1-\tfrac12=\tfrac12$ and $\varphi_G(\boldsymbol\eta')=1-2\cdot(1/4)=\tfrac12$, but $R(\boldsymbol\eta)=1-2/3=1/3$ while $R(\boldsymbol\eta')=1-1/2=1/2$. So Gini fails Step 1 directly: $G$ would have to send the single $\varphi_G$-value $\tfrac12$ to both $R$-values $1/3$ and $1/2$, which is impossible. The rigidity rules Gini out at that step. The analogous same-entropy/different-$R$ violation exists with the same shape; the constraint $-\sum_c\eta_c\log\eta_c=\mathrm{const}$ is transcendental, so we keep the rational Gini example here.

**Worked example B ($k=3$, the slack mechanism).** Step 1 fails because $R$ is not a function of $\varphi_G$. The *converse* observation — that $\varphi_G$ is not a function of $R$ either — is what opens the bracket: smooth scores see *inside* an $R$-level set, and that extra resolution is the slack. Take two cells with the same *Bayes risk* this time:
$$
\boldsymbol\eta=(0.5,\,0.3,\,0.2),\qquad \boldsymbol\eta'=(0.5,\,0.5,\,0),\qquad R(\boldsymbol\eta)=R(\boldsymbol\eta')=0.5.
$$
Their smooth scores differ: $\varphi_G(\boldsymbol\eta)=1-(0.25+0.09+0.04)=0.62$ while $\varphi_G(\boldsymbol\eta')=1-(0.25+0.25)=0.50$; and $\varphi_H(\boldsymbol\eta)\approx 1.485$ bits while $\varphi_H(\boldsymbol\eta')=1.000$ bit. So Gini and entropy *distinguish* two distributions that the Bayes risk identifies. Make the slack explicit on a partition. With $p_1=p_2=\tfrac12$ over these two cells, $\varepsilon^\ast=\tfrac12(0.5)+\tfrac12(0.5)=0.5$, while $\bar\varphi_G=\tfrac12(0.62)+\tfrac12(0.50)=0.56$. The Gini upper bound ($c_{\varphi_G}=1$) is $0.56\ge 0.5$, a slack of $0.06$; the lower bracket is strictly below $0.5$ as well (minimizing $R$ over $\{\varphi_G=0.56\}$ gives $\boldsymbol\eta=(0.6,0.2,0.2)$ with $R=0.4$), so the bracket is genuinely two-sided. By contrast $\varphi=R$ gives $\bar\varphi=0.5=\varepsilon^\ast$ exactly.

**The level-set characterization.** Theorem 2′ says: $R$ is the *unique* (up to scalar) continuous vertex-vanishing functional whose level sets coincide with the Bayes-risk level sets; every smooth score has strictly finer level sets, and the surplus is the slack. The framing carries operational guidance for surrogate choice: among smooth scores, the one whose pointwise ratio to $R$ is smallest gives the tighter upper instrument. Gini is the natural multiclass workhorse — $c_{\varphi_G}=1$ and the clean pointwise domination $R\le\varphi_G$.

### 4.4 Binary consistency and refinement-monotonicity transfer

For $k=2$, $R(\eta_1,\eta_2)=1-\max(\eta,1-\eta)=\min(\eta,1-\eta)$, so the normalized tent $T=2\min(\eta,1-\eta)=2R$ is the exact functional with $\lambda=2$ (fixing $\varphi(\tfrac12)=1$), recovering Theorem 2 exactly. The level-set floor $\ell_\varphi$ collapses to $\varphi^{-1}$ (binary symmetry makes $\varphi$ a function of $R$, so each level set is a single $R$-value), its convex envelope is itself, and the lower endpoint is $\varphi^{-1}(\bar\varphi)$ — the binary bracket. The simplex result contains the binary one as the $k=2$ face.

**Theorem 1′ (refinement-monotonicity transfer).** *Let $(\mathcal X,\mathcal F,\mathbb P)$ be atomless (so that arbitrary simplex-valued cell-distribution splits are realizable). Theorem 1 holds verbatim on the simplex: for continuous $\varphi:\Delta^{k-1}\to\mathbb R$, $\bar\varphi$ is monotone under partition refinement ($\Pi'\succeq\Pi\Rightarrow\bar\varphi(\Pi')\le\bar\varphi(\Pi)$) over all finite partitions and labels if and only if $\varphi$ is concave on $\Delta^{k-1}$, and equivalently if and only if $\bar\varphi$ is non-increasing under every binary split of a cell. The proof is the same tower-property + Jensen argument of Theorem 1; the simplex playing the role of $[0,1]$ does not change the structure, since concavity and the tower property are dimension-agnostic for the cell-conditional class distribution $\boldsymbol\eta_i$. On a general (possibly atomic) space the equivalence continues to hold by density of realizable splits and continuity of $\varphi$.* $\qquad\blacksquare$

*Mechanization note.* Theorem 1′ is not separately formalized in the Lean kernel — its proof is a direct port of the (mechanized) `barPhi_refinement_le` of Theorem 1, with `Fin k`-valued cell distributions in place of $\{0,1\}$-valued ones. The Phase C2 partition-additivity infrastructure (`refining`, `sum_cellMass_refining_eq`, `cellRate_mul_cellMass_refining_sum`) is dimension-agnostic at the partition level and ports verbatim. The simplex analogue `barPhiSimplex_refinement_le` is a clean ~150-LoC follow-up deferred from Phase D because `simplex_rigidity` does not depend on it.

This closes the structural loop: the multiclass bracket of §4.1 and the rigidity of §4.2 sit on the same monotonicity scaffolding as the binary development, with $R$ singled out among continuous vertex-vanishing scores by Theorem 2′ and the slack-of-smoothness governed by Corollary 3′.

---

## 5. Expressivity as a calibrated gap test

WL feasibility — the decision verdict — is the *boundary* of the measure: $\varepsilon^\ast(\Pi)$ is bounded away from the trivial rate exactly when the WL partition fails to separate a label-distinguishing pair. The bracket is the *interior*, and §7 makes it locally checkable. This is the calibrated, locally checkable gap version of the WL test — the locally-checkable half of the PCP framing flagged in §1; gap amplification (the other half) remains the analogy and Open Problem 3 of §8.

The aggregator hierarchy of [Xu et al.] is then a corollary of Theorem 1. Throughout this section, $\Pi_{\mathrm{sum}}$ is the partition of nodes by neighbourhood-multiset equality, $\Pi_{\mathrm{mean}}$ by neighbourhood-mean equality, and $\Pi_{\mathrm{max}}$ by neighbourhood-max equality. Sum composed with an injective MLP (the GIN construction) realises a multiset-injective aggregator and so induces $\Pi_{\mathrm{sum}}$; mean and max are coarser — each in a different direction — because multisets can share their mean while differing in their max, and share their max while differing in their mean. Hence $\Pi_{\mathrm{sum}}$ refines both $\Pi_{\mathrm{mean}}$ and $\Pi_{\mathrm{max}}$, while $\Pi_{\mathrm{mean}}$ and $\Pi_{\mathrm{max}}$ are *incomparable* in the refinement lattice (counterexamples: $\{0,2\}$ and $\{1,1\}$ share mean but not max; $\{1,2\}$ and $\{0,2\}$ share max but not mean).

**Corollary 4 (aggregator floor half-chain).** *For every task, $\varepsilon^\ast(\Pi_{\mathrm{sum}})\le\min\{\varepsilon^\ast(\Pi_{\mathrm{mean}}),\,\varepsilon^\ast(\Pi_{\mathrm{max}})\}$, where $\Pi_{\mathrm{sum}}$, $\Pi_{\mathrm{mean}}$, $\Pi_{\mathrm{max}}$ denote the finest partitions induced by an injective-update GNN with the respective aggregator class — the information-theoretic ceiling for that class; a specific trained GNN with the same aggregator induces a partition at most as fine (and the corresponding floor bound is correspondingly looser). The mean and max floors are in general incomparable, so neither $\varepsilon^\ast(\Pi_{\mathrm{mean}})\le\varepsilon^\ast(\Pi_{\mathrm{max}})$ nor the reverse inequality holds in general.*

**Caveat (floor, not achieved — applies here especially).** Corollary 4 orders *achievable floors*. It does **not** predict trained-accuracy ordering, and the two can diverge sharply: on homophilous node tasks mean/GCN frequently *outperforms* sum despite the higher floor, because mean is a better inductive bias and optimizes more stably. The half-chain says sum *can* in principle reach a lower error than either mean or max at this resolution, not that a trained sum-GNN *will*. We make this distinction loudly because the naive reading "Corollary 4 predicts sum-GNNs are most accurate" is false and is not what the theorem says.

---

## 6. Depth and architecture

Theorem 1's monotonicity is over the refinement *lattice* and is unconditional. Monotonicity in network *depth* is a separate, dynamical question and is not universal. The architecture-sorting story works cleanly at the **WL/exact-equivalence level**; we state it there and then transfer to the operational $\varepsilon$-partition $\Pi_\varepsilon^{(L)}$ from §2 via the elementary comparison $\Pi^{(L)}_\varepsilon = \Pi^{(L)}_{\mathcal A}$ for $\varepsilon < \delta^{(L)}$ (the Voronoi observation of §2).

**Theorem 5 (depth-monotonicity, two directions).** *Let $(\Pi^{(L)})_L$ be a sequence of finite partitions of $\mathcal X$.*
*(a) If $(\Pi^{(L)})_L$ is a refinement chain ($\Pi^{(L+1)}\succeq\Pi^{(L)}$ for every $L$), then for every concave score and **every** labeling $f$, the floor $\varepsilon^\ast(\Pi^{(L)})$ is non-increasing in $L$.*
*(b) Conversely, if for **every** labeling $f$ the floor is non-increasing in $L$, then $(\Pi^{(L)})_L$ is a refinement chain.*

**Proof.** *(a)* Theorem 1 along the depth sequence. *(b)* Contrapositive: if at some $L$ the chain property fails, there are two cells $A,B$ of $\Pi^{(L)}$ that are merged in $\Pi^{(L+1)}$ (more precisely, $\Pi^{(L+1)}$ contains a cell $C$ straddling $A$ and $B$, with $C\cap A$ and $C\cap B$ both of positive mass — generic on an atomless space). Choose the labeling that is $0$ on $A$, $1$ on $B$, and constant on the rest; the floor on this labeling is $0$ at depth $L$ (each cell is pure) and strictly positive at depth $L+1$ (the straddling cell $C$ has both labels with positive mass on each, so $\min(\eta_C,1-\eta_C)>0$). $\qquad\blacksquare$

**Remark (the operational reading).** On a *fixed* task only direction (a) is operative: a refinement chain at the partition level certifies a non-increasing floor at the task level. Direction (b) is the diagnostic in the other direction — observing a depth-induced floor *rise* on **some** task certifies that the depth sequence is not a refinement chain. A floor that is constant or non-increasing on a fixed task is consistent with a non-chain (the fixed task may happen to be insensitive to the merge), so direction (b) cannot be invoked task-by-task. The simplex analogue (Theorem 1$'$) lifts (a) verbatim to multiclass labels; (b) extends with the obvious modification (the discriminating labeling becomes simplex-valued).

**Three partitions at each depth.** For an architecture $\mathcal A$ producing embeddings $h^{(L)}:V\to\mathbb R^d$, we distinguish:

- $\Pi^{(L)}_{\mathrm{WL}}$ — the **WL ceiling**, the partition by WL colour at depth $L$. Refines monotonically in $L$ for every architecture (the WL combinatorial step refines, period); independent of $\mathcal A$.
- $\Pi^{(L)}_{\mathcal A}$ — the **architecturally realized partition**, the partition by exact equality of $\mathcal A$'s embeddings at depth $L$. Always a coarsening of $\Pi^{(L)}_{\mathrm{WL}}$ if $\mathcal A$ is **not WL-faithful** (it collapses distinctions WL preserves); equals $\Pi^{(L)}_{\mathrm{WL}}$ if $\mathcal A$ is WL-faithful.
- $\Pi^{(L)}_\varepsilon$ — the **operationally observed partition** from §2, a coarsening of $\Pi^{(L)}_{\mathcal A}$ that coincides with it for every $\varepsilon$ below the minimum separating embedding distance $\delta^{(L)}:=\min_{u\not\sim_{\mathcal A}v}\|h^{(L)}(u)-h^{(L)}(v)\|$.

Theorem 5 applies *to whichever depth sequence of partitions one cares about*; the architecture story is about which sequences are refinement chains.

**Theorem 5 applied: architecture sorting.**

*GIN (sum + injective MLP) is WL-faithful and refines.* The sum + injective-MLP composition is multiset-injective [Xu et al.\ 2019, Lemma 5], so $\Pi^{(L+1)}_{\mathrm{WL}}\succeq\Pi^{(L)}_{\mathrm{WL}}$ until WL-stability, and the same composition gives $\Pi^{(L)}_{\mathcal A}=\Pi^{(L)}_{\mathrm{WL}}$. The architecturally realized chain is a refinement chain; Theorem 5(a) gives a non-increasing realized floor. For $\varepsilon<\delta^{(L)}$ at each depth $L$ of interest, $\Pi^{(L)}_\varepsilon=\Pi^{(L)}_{\mathrm{WL}}$ and the operationally observed floor falls as well.

*Join-type residual (jumping-knowledge, GCNII) is monotone by construction.* Let $\mathcal A^{\rm base}$ denote the underlying message-passing architecture and $\mathcal A^{JK}$ its join-type residual variant that concatenates or carries forward earlier representations. Then two nodes are $\mathcal A^{JK}$-equivalent at depth $L$ iff they were $\mathcal A^{\rm base}$-equivalent at *every* earlier layer; $\Pi^{(L)}_{\mathcal A^{JK}}=\bigvee_{\ell\le L}\Pi^{(\ell)}_{\mathcal A^{\rm base}}$, monotone-refining by construction, and Theorem 5(a) applies. The operational $\Pi^{(L)}_\varepsilon$ inherits the chain whenever $\varepsilon$ is below the per-layer minimum separating distance. This is the partition-level reason the join remedy fixes over-smoothing — it never discards resolution an earlier layer achieved.

*Contractive aggregation (GCN, mean, symmetric-normalized) is not WL-faithful; the WL ceiling refines but the operational partition collapses.* The aggregation is a linear operator whose non-constant spectrum has norm below $1$ (eigenvalues $1=\mu_1>|\mu_2|\ge\cdots$); the informative component of the signal contracts at rate $\lambda_2^L:=|\mu_2|^L$ [Oono–Suzuki 2020; Cai–Wang 2020]. Under the standard analyses of those works (Lipschitz feature maps plus the spectral contraction), the minimum separating embedding distance $\delta^{(L)}$ inherits the same geometric decay:
$$
\delta^{(L)}\;\le\;C\,\lambda_2^L\qquad\text{for some architecture-dependent }C>0,
$$
under the additional load-bearing assumption that the worst-separated pair remains worst-separated through depth (or, equivalently, that the contraction is uniform across the non-leading spectrum) — without this, per-pair geometric contraction does not by itself force the *minimum* separation to contract geometrically. We adopt the bound as a working assumption matching the over-smoothing literature [Rusch–Bronstein–Mishra 2023 surveys the field]; a self-contained statement with explicit constants is Open Problem 2 below.
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

**Corollary 7 (label complexity).** *$p_{\mathrm{dis}}$ is estimable to $\pm\alpha$ at confidence $1-\delta$ from $m=\lceil\ln(2/\delta)/2\alpha^2\rceil$ same-cell pairs (Hoeffding), independent of the number of nodes.*

**Honest cost accounting.** The win is in *label* complexity, and we state the total cost precisely. Computing the WL colouring of the graph is $O(L|E|)$ (one unavoidable linear pass — it is just running WL); bucketing nodes by colour to enable same-cell sampling is a one-time $O(n)$ step; thereafter each of the $m=O(\alpha^{-2})$ pairs costs $O(1)$ label queries. So the test queries $O(\alpha^{-2})$ *labels* — independent of $n$, the relevant saving when labels are the expensive resource (the global plug-in queries all $n$) — but it is *not* sublinear in total work once the linear WL pass and bucketing are counted. We claim only the label-complexity saving, and the local-test reading (a property test for "$\varepsilon^\ast\le\alpha$", complete because low floor gives low disagreement, sound because $p_{\mathrm{dis}}$ upper-bounds the floor) holds with that accounting.

**The computational picture (deterministic).** For a *given* partition the bracket is $O(n)$ — a single pass over the cells, summing $p_i\,\varphi(\eta_i)$. Since computing the WL colouring is polynomial ($O(L|E|)$ per round, $O(n)$ rounds to stability), **the deterministic bracket is polynomial-time** end-to-end. We deliberately scope the deterministic claim only: randomized / lossy variants — in which messages survive independently with some probability $q\in[0,1]$ and the bracket is averaged over the random partition that results — raise harder questions ($\#$P-hardness on general graphs by a reduction from two-terminal network reliability [Provan–Ball 1983], tractability on bounded-treewidth instances via junction-tree dynamic programming [Lauritzen–Spiegelhalter 1988; Arnborg–Lagergren–Seese 1991], approximation regimes on expanders) but the bracket of those variants is not defined in this paper, and we defer it to a companion work where the random object can be developed honestly.

---

## 8. Discussion, scope, and open problems

We have studied the achievable-error floor of GNN-induced partitions as a calibrated gap measure, transposing classical calibration from the optimization axis to the resolution axis (§3–§4), deriving the aggregator half-chain and a cross-architecture depth characterization (§5–§6), and giving a local test (§7). We are explicit about what this is: a population, optimal-classifier floor for tasks with hard cell assignments, binary or multiclass, not a theory of trained-GNN performance.

**Scope and honest limitations.** The measure is the achievable floor, not achieved error; the gap between them (optimization, finite data, inductive bias) is outside our scope, and the aggregator floor half-chain accordingly need not match trained-accuracy ordering (§5). The setting is *hard cell assignments* throughout, with binary labels covered by §§1–3 and 5–7 and multiclass labels handled by §4; the soft-cell-assignment extension that reaches attention-style architectures remains open (Open Problem 1b). Experiments — the empirical tests of Corollary 4, of the over-smoothing floor-rise (Theorem 5), and of the local test (Proposition 6), on standard node, graph, and heterophilous benchmarks — are deferred to a companion empirical paper and are necessary before any graph-ML claim is final.

**Open problem 1a (multiclass labels — the simplex rigidity).** *Resolved in §4.* The hard-partition binary theory extends to $k$-class labels by replacing the rate $\eta\in[0,1]$ with a simplex-valued conditional class distribution $\boldsymbol\eta\in\Delta^{k-1}$. Theorem 2′ (§4.2) proves that among continuous vertex-vanishing simplex scores, the multiclass Bayes risk $R(\boldsymbol\eta)=1-\max_c\eta_c$ is the *unique* exact functional, so every smooth simplex score (multiclass entropy, Gini) carries strictly positive bracket slack (Corollary 3′, §4.3). This extends §3 to multiclass node and graph tasks at the label level.

**Open problem 1b (soft cell assignments — genuinely open).** Architectures that assign each input *probabilistically* to multiple cells — attention (GAT), differentiable pooling, graph transformers — do **not** induce a hard partition. A principled extension requires a *soft-kernel* lifting: treat the architecture as a Markov kernel $K:\mathcal X\to\Delta(\mathrm{Cells})$, define the bracket as an expectation over the random cell assignment, and ask whether the rigidity of Theorem 2 (or its multiclass companion Theorem 2$'$) survives the lifting. We do not have this lifting; we flag it as separate from 1a (which concerns multiclass *labels*, not multiclass cell assignments) and as the genuine prerequisite for reaching soft / attention-based architectures.

**Open problem 2 (quantitative over-smoothing).** Make §6 precise: prove the dependence of the number of $\varepsilon$-distinguishable cells of $\Pi_\varepsilon^{(L)}$ — equivalently, the rate at which the minimum separating distance $\delta^{(L)}$ shrinks — on the spectral gap $1-|\mu_2|$, turning the qualitative coarsening statement (and the critical depth $L^\ast(\varepsilon)\approx\log(C/\varepsilon)/\log(1/\lambda_2)$ of §6) into a theorem with explicit constants.

**Open problem 3 (gap amplification).** Monotonicity orders the aggregator floors (Corollary 4) but not the size of the gap $\Delta(G)=\varepsilon^\ast(\Pi_{\mathrm{mean}})-\varepsilon^\ast(\Pi_{\mathrm{sum}})$. Is there a graph operation under which a small positive gap is driven to a constant while $\varepsilon^\ast(\Pi_{\mathrm{sum}})$ is preserved? An affirmative answer would be a hardness-of-approximation statement for expressivity and would earn the PCP framing, which until then we use only as an analogy. We caution that the standard amplification primitive (the zig-zag/replacement product) is defined for regular graphs and may not act on the labeled, irregular aggregator-gap quantity as-is; identifying the correct operation is part of the problem. The tractable companion question — how $\Delta$ evolves with depth under the spectral gap (compounding for refining architectures, collapsing at $\lambda_2^L$ for contractive ones) — is the immediate next target.

---

## References

- Arnborg, S., Lagergren, J., and Seese, D. *Easy problems for tree-decomposable graphs.* J. Algorithms, 1991.
- Arora, S., and Safra, S. *Probabilistic checking of proofs.* J. ACM, 1998.
- Arora, S., Lund, C., Motwani, R., Sudan, M., and Szegedy, M. *Proof verification and the hardness of approximation problems.* J. ACM, 1998.
- Bartlett, P., Jordan, M., and McAuliffe, J. *Convexity, classification, and risk bounds.* JASA, 2006.
- Blackwell, D. *Equivalent comparisons of experiments.* Ann. Math. Statist., 1953.
- Cai, C., and Wang, Y. *A note on over-smoothing for graph neural networks.* (arXiv) 2020.
- DeGroot, M. *Uncertainty, information, and sequential experiments.* Ann. Math. Statist., 1962.
- Dinur, I. *The PCP theorem by gap amplification.* J. ACM, 2007.
- Grünwald, P., and Dawid, A. P. *Game theory, maximum entropy, minimum discrepancy, and robust Bayesian decision theory.* Ann. Statist., 2004.
- Hoeffding, W. *Probability inequalities for sums of bounded random variables.* JASA, 1963.
- Lauritzen, S., and Spiegelhalter, D. *Local computations with probabilities on graphical structures.* J. R. Stat. Soc. B, 1988.
- Le Cam, L. *Asymptotic Methods in Statistical Decision Theory.* Springer, 1986.
- Morris, C., et al. *Weisfeiler and Leman go neural.* AAAI, 2019.
- Oono, K., and Suzuki, T. *Graph neural networks exponentially lose expressive power for node classification.* ICLR, 2020.
- Pires, B. Á., and Szepesvári, C. *Multiclass classification calibration functions.* (arXiv) 2016.
- Provan, J. S., and Ball, M. O. *The complexity of counting cuts and of computing the probability that a graph is connected.* SIAM J. Comput., 1983.
- Ramaswamy, H. G., and Agarwal, S. *Classification calibration dimension for general multiclass losses.* NeurIPS, 2012.
- Reid, M., and Williamson, R. *Information, divergence and risk for binary experiments.* JMLR, 2011.
- Rusch, T. K., Bronstein, M., and Mishra, S. *A survey on oversmoothing in graph neural networks.* (arXiv) 2023.
- Savage, L. J. *Elicitation of personal probabilities and expectations.* JASA, 1971.
- Tewari, A., and Bartlett, P. *On the consistency of multiclass classification methods.* JMLR, 2007.
- Xu, K., Hu, W., Leskovec, J., and Jegelka, S. *How powerful are graph neural networks?* ICLR, 2019.
- Zhang, T. *Statistical behavior and consistency of classification methods based on convex risk minimization.* Ann. Statist., 2004.

---

## Revision history

### Draft 0.7 (Final) — round 7 internal adversarial audit ([`17-pi_adversarial_audit_of_draft0.6_post_phase_d.md`](17-pi_adversarial_audit_of_draft0.6_post_phase_d.md))

Closes round 7 in full. Items addressed:

- **Material 1** — Theorem 2′ statement now reads "every measurable labeling $f:\mathcal X\to\{1,\dots,k\}$", mirroring Theorem 1's round-5 fix. Closes the Lean–paper hypothesis discrepancy on the multiclass side (the Lean `simplex_rigidity` always carried this hypothesis explicitly; the manuscript now does too).
- **Material 2** — §4.4 Theorem 1′ gets an explicit *Mechanization note* clarifying that it is not separately formalized in Lean by design (the simplex `barPhi_refinement_le` port is a ~150-LoC follow-up `simplex_rigidity` does not depend on). Closes the asymmetry-with-Theorem-2′ question a referee would otherwise ask.
- **Positive 1** — §4.1 simplex-score definition no longer carries "$\varphi>0$ on the interior" as a hypothesis. Lean's proof of `simplex_rigidity` revealed that interior positivity is a *consequence* of exactness (not an independent assumption): the only-if argument derives $\varphi(\mathbf u)>0$ from $R(\mathbf u)>0$ + Step 1 + $G(0)=0$. The paper now carries the strictly weaker hypothesis set Lean uses, with a parenthetical noting the consequence.
- **Minor 1** — "chord-trick" project-internal jargon removed from the §1.2 Mechanization paragraph. The paragraph is for the audit trail, not for explaining proofs.
- **Minor 3** — §4.3 Worked example B now includes the one-sentence verification that the lower-bracket witness $(0.6,0.2,0.2)$ is indeed the minimizer of $R$ over $\{\varphi_G=0.56\}$ (Lagrangian on the symmetric $(a,b,b)$ family with $a+2b=1$, $a^2+2b^2=0.44$; quadratic gives $a=0.6$ as the larger root).
- **Appendices added** — Appendix A catalogs every paper claim with its Lean cross-reference; Appendix B describes the formalization workflow, audit trail, and reproducibility instructions.

**Closed audit items.** All previously-closed items of rounds 1–6 remain closed and are re-verified by this draft.

**Still open (deferred, not blockers).** OP1b (soft cell assignments, the natural Phase E target), OP2 (quantitative over-smoothing rate), OP3 (gap amplification), the empirical companion paper, the closed-form $\ell_\varphi$ for entropy and Gini, and `barPhi_refinement_le` port to the simplex (Theorem 1′'s Lean counterpart; deferred from Phase D because `simplex_rigidity` does not depend on it).

**Mechanization status.** Both the §3 binary spine **and** the §4.2 simplex rigidity (Theorem 2′) are mechanically verified end-to-end in Lean 4 — 57 axiom-clean theorems against mathlib v4.29.1. Round-7 [Material] items closed leave the kernel and the paper in their tightest reconciliation. See Appendix A for the per-claim cross-reference table.

### Draft 0.6 — round 6 external audit (`00-external.md`)

Closes the external reviewer audit in full. Items addressed:

- **C-1** — Theorem 2′ Step 1 headline corrected from the converse (*"exact $\varphi$ must be constant on $R$-level sets"*) to the actual derivation (*"$R$ must be constant on $\varphi$-level sets"*, i.e. $R = G \circ \varphi$); the dash-gloss and "equivalently" that followed were already correct, only the headline was inverted. §4.3 reorganized into:
  - **Worked example A** — a new Step 1 violation with rational $\boldsymbol\eta=(2/3,1/6,1/6)$ vs $(1/2,1/2,0)$: both have Gini exactly $1/2$ but different $R$ — an explicit same-$\varphi$ / different-$R$ violation.
  - **Worked example B** — the original same-$R$ / different-Gini example, now correctly framed as the *slack mechanism* showing $\varphi$ is not a function of $R$ (not a Step 1 violation, but the reason the bracket opens).
  - Proof of Theorem 2′ unchanged.
- **M-1** — Theorem 5(b) positive-mass clause added: the straddling cell $C$ must have $C \cap A$ and $C \cap B$ both of positive mass (generic on an atomless space).
- **M-2** — §6 worst-pair-stability assumption promoted from OP2 to point of use: the bound $\delta^{(L)} \le C \lambda_2^L$ now explicitly carries the "worst-separated pair remains worst-separated through depth, or equivalently uniform contraction across the non-leading spectrum" qualifier at the point of assertion.
- **M-3** — §3.2 proof of Theorem 2 surfaces that the lower endpoint $\varphi^{-1}(\varphi(\eta)) = \eta$ is automatically tight on single cells for every normalized $\varphi$; exactness on single cells is therefore a purely *upper-endpoint* constraint.
- **S-1** — §1.2 adds a precise contrast sentence positioning Theorem 2′ against Tewari–Bartlett, Ramaswamy–Agarwal, Pires–Szepesvári: their results concern when a smooth surrogate's *minimizer* matches the Bayes *predictor*; ours concerns when a smooth surrogate's partition-level *aggregate* determines $\varepsilon^\ast$. Consistency in their sense does not imply exactness in ours.
- **S-2** — Abstract restructured into a punchy lead paragraph + a scope/honesty paragraph, with the GNN consequences, multiclass rigidity, and local test leading and the transposition framing demoted to organizing principle. §1.1 contributions list reordered correspondingly (prior items (i)–(iii) become new (1)–(3); transposition framing becomes new (4)).
- Plus: Theorem 1 statement now reads "all measurable labelings" (round 5 followup, paper–Lean reconciliation per [`16-end-to-end-audit-and-publishability.md`](16-end-to-end-audit-and-publishability.md) Risk 5).
- Plus: §1.2 adds a **Mechanization** paragraph announcing the Lean 4 kernel against mathlib v4.29.1.

**Closed audit items.** All previously-closed items of `05`, `07`, `10`, `12`, and round 5 (Draft 0.5 closing notes below) remain closed and are re-verified by this draft.

**Still open.** OP1b (soft cell assignments), OP2 (quantitative over-smoothing rate), OP3 (gap amplification), the empirical companion, and the closed-form $\ell_\varphi$ for entropy and Gini.

**Mechanization status.** Both the §3 binary spine **and** the §4.2 simplex rigidity (Theorem 2′) are mechanically verified end-to-end in Lean 4 — 57 axiom-clean theorems against mathlib v4.29.1 (Phase C2 commit `8339f60`, Phase D commit `pending`).

### Draft 0.5 — round 5 polishing pass (on top of Draft 0.4)

Retires the seven items found by a final independent review:

- **M-1** — Theorem 1′ now carries the atomless realizability hypothesis, completing the propagation begun in commits `c8ef3e6` / `23814f7` / `07ddde8`, so that Theorems 1, 1′, 2, 2′ all share parallel statements.
- **m-1** — §6 GIN body wording aligned with the §5 "sum + injective MLP" correction: multiset sum alone is not injective on multisets; the sum + injective-MLP composition is, per Xu et al. 2019 Lemma 5.
- **m-2** — §1's inline normalized-score definition now lists "symmetric", matching the full §2 definition that the proof of Theorem 2 uses to extend $\varphi = 2\eta$ from $[0, 1/2]$ to $[0, 1]$.
- **m-3** — The two consecutive normalized-score parentheticals in §1 are consolidated; the chord-argument paragraph reads "for any such $\varphi$" instead of re-stating the definition.
- **m-4** — §1 notation paragraph clarifies that $R$ as a *symbol* appears only in §4, while the binary case uses $\varepsilon^\ast$ and the normalized tent $T$ directly.
- **m-5** — §4 opener "binary argument transported to the simplex" tightened to match §4.2's closing remark: the proof has the same three-step skeleton, but the binary case collapses to Step 1 alone via symmetry while the simplex case genuinely uses all three steps.
- **m-6** — §5 setup adds an explicit defining sentence for $\Pi_{\mathrm{sum}}$, $\Pi_{\mathrm{mean}}$, $\Pi_{\mathrm{max}}$ as the per-aggregator equivalence partitions.

**Closed audit items.** All previously-closed items of `05`, `07`, `10`, `12` remain closed and are re-verified.

**Still open.** OP1b (soft cell assignments), OP2 (quantitative over-smoothing rate), OP3 (gap amplification), the empirical companion, the closed-form $\ell_\varphi$ for entropy and Gini, and the mechanization kernel (deferred per `09-mechanization_strategy.md`).

### Draft 0.4 — round 4 external audit (`12-external_reviewer_second_audit_of_draft0.3.md`)

Closes the external reviewer audit in full. Items addressed:

- **C-1** — Corollary 4 restated as a *half-chain* $\varepsilon^\ast(\Pi_{\mathrm{sum}}) \le \min\{\varepsilon^\ast(\Pi_{\mathrm{mean}}), \varepsilon^\ast(\Pi_{\mathrm{max}})\}$, with the explicit caveat that $\Pi_{\mathrm{mean}}$ and $\Pi_{\mathrm{max}}$ are incomparable on multisets (two-line counterexamples in §5). The previous chain $\Pi_{\mathrm{sum}} \succeq \Pi_{\mathrm{mean}} \succeq \Pi_{\mathrm{max}}$ was mathematically false. Abstract, §1.1 item 2, §5 caveat, and §8 opener synced.
- **M-1** — Theorem 1 statement now carries the atomless realizability hypothesis lifted from the parenthetical in (ii) $\Rightarrow$ (iii), matching the surgery commit `c8ef3e6` applied to Theorem 2′ in Draft 0.2.
- **M-2** — Theorem 2 statement gets the same hypothesis lift, closing the consistency gap with Theorem 2′ that was missed because audit `07` was scoped narrowly to the simplex companion.
- **M-3** — The false labels "same-distribution coarsening" for $\Pi_{\mathrm{mean}}$ and "same-support coarsening" for $\Pi_{\mathrm{max}}$ in §5 replaced with precise per-aggregator equivalence definitions, with two-line counterexamples explicating the incomparability.
- **M-4** — Theorem 2′ Step 2 now uses $\varphi_{\max} := \max_{\boldsymbol\eta \in \Delta^{k-1}} \varphi(\boldsymbol\eta)$ via Weierstrass, dropping the over-asserted $\varphi_{\max} = \varphi(\mathbf u)$ that would have required permutation symmetry the theorem only *concludes*.
- **m-1** — Theorem 2′ Step 3 $a > 0$ justification corrected: the previous citation of $\varphi > 0$ on interior was not a hypothesis; replaced with a non-constancy argument (if $a = 0$ then $R \equiv 0$, contradicting $R(\mathbf u) = 1 - 1/k > 0$).
- **m-2** — §1 bracket display now explicitly names the normalized-score hypothesis required for $\varphi^{-1}$ to make sense.
- **m-3** — §5 "sum is injective" (informally wrong since multiset sum is not injective on multisets of reals) corrected to "sum composed with an injective MLP (the GIN construction) realises a multiset-injective aggregator"; bundled with C-1.
- **m-4** — §5 Cor 4 vestigial "for every concave score" qualifier dropped during the C-1 restatement.
- **m-5** — §8 OP1b citation "in 1a" → "Theorem 2′" for accuracy.
- **m-6** — §2 $O(\varepsilon)$ tube-measure clause now qualifies the constant by embedding dimension and local density.

**Closed audit items.** All previously-closed items of `05`, `07`, `10` remain closed and are re-verified.

**Still open.** OP1b (soft cell assignments), OP2 (quantitative over-smoothing rate), OP3 (gap amplification), the empirical companion, the closed-form $\ell_\varphi$ for entropy and Gini, and the mechanization kernel (deferred per `09-mechanization_strategy.md`).

**Execution log.** [`13-draft0.4_commitology.md`](13-draft0.4_commitology.md).

---

## Appendix A — Results catalog (paper ↔ Lean cross-reference)

Every claim made in the paper appears below with its formal status, the Lean declaration that proves it (when one exists), and the hypotheses it consumes. "Axiom-clean" means the Lean term depends only on `propext`, `Classical.choice`, and `Quot.sound` (the three trusted Lean 4 axioms) — verified by `lake env lean Audit/PrintAxioms.lean` at commit `04508ff`.

### A.1 Definitions

| Manuscript object | Lean name (module) | Status |
|---|---|---|
| Probability space, measurable labeling | `Measure α`, `α → Bool`, `α → Fin k` (mathlib) | imported |
| Finite measurable partition $\Pi$ | `FinitePartition α` (`Bracket.lean`) | defined |
| Refinement order $\Pi'\succeq\Pi$ | `Refines`, infix `⪰` (`Bracket.lean`) | defined |
| Cell mass $p_i$ | `cellMass μ P c` (`Bracket.lean`) | defined |
| Cell rate $\eta_i$ (binary) | `cellRate μ f P c` (`Bracket.lean`) | defined |
| Cell-Bayes risk $\varepsilon^\ast(\Pi)$ (binary) | `epsilonStar μ f P` (`Bracket.lean`) | defined |
| Partition functional $\bar\varphi(\Pi)$ (binary) | `barPhi μ φ f P` (`Bracket.lean`) | defined |
| Normalized score (§2) | `NormalizedScore φ` (structure, `Bracket.lean`) | defined |
| Tent $T(\eta) = 2\min(\eta,1-\eta)$ | `tent` (`Bracket.lean`) | defined |
| Upper bracket constant $c_\varphi$ (binary) | `cPhi φ` (`Bracket.lean`) | defined |
| Simplex $\Delta^{k-1}$ | `simplex k` (`Theorem2Prime.lean`) | defined |
| Vertex $\mathbf e_c$, center $\mathbf u$ | `vertex c`, `center k` (`Theorem2Prime.lean`) | defined |
| Multiclass Bayes risk $R(\boldsymbol\eta)$ | `R η` (`Theorem2Prime.lean`) | defined |
| Simplex score | `SimplexScore φ` (structure, `Theorem2Prime.lean`) | defined |
| Multiclass cell rate $\boldsymbol\eta_i$ | `cellRateSimplex μ f P c` (`Theorem2Prime.lean`) | defined |
| Multiclass $\varepsilon^\ast(\Pi)$ | `epsilonStarSimplex μ f P` (`Theorem2Prime.lean`) | defined |
| Multiclass $\bar\varphi(\Pi)$ | `barPhiSimplex μ φ f P` (`Theorem2Prime.lean`) | defined |
| Disagreement probability $p_{\text{dis}}$ | `pDisagree μ f P` (`Proposition6.lean`) | defined |
| Normalized variance $\varphi_{\text{var}}$ | `phiVar` (`Proposition6.lean`) | defined |

### A.2 Theorems (binary, §1–§3)

| # | Manuscript claim | Lean declaration | Hypotheses |
|---|---|---|---|
| §1 | Bracket lower: $\varphi^{-1}(\bar\varphi)\le\varepsilon^\ast$ | `bracket_lower` | `[IsProbabilityMeasure μ]`, `NormalizedScore φ` |
| §1 | Bracket upper: $\varepsilon^\ast\le c_\varphi\bar\varphi$ | `bracket_upper` | `[IsProbabilityMeasure μ]`, `NormalizedScore φ` |
| §1 | Universal $c_\varphi=\tfrac12$ for any normalized score | `cPhi_eq_half_of_normalized` | `NormalizedScore φ` |
| §2 | Chord lemma: $\varphi(\eta)\ge 2\eta$ on $[0,\tfrac12]$ | `two_eta_le_of_normalized` | `NormalizedScore φ` |
| §2 | Tent is a normalized score | `tent_normalized` | (none) |
| §3.1 | Theorem 1, refinement-monotone ⟺ concave | `theorem1` | `[IsProbabilityMeasure μ]`, `[BinarySplitRealizable μ]`, `ContinuousOn φ` |
| §3.1 | Easy direction (concave ⟹ monotone) | `theorem1_easy` / `barPhi_refinement_le` | `[IsProbabilityMeasure μ]`, `ConcaveOn ℝ (Icc 0 1) φ` |
| §3.1 | Hard direction (monotone ⟹ concave) | `theorem1_hard` | `[IsProbabilityMeasure μ]`, `[BinarySplitRealizable μ]` |
| §3.2 | Theorem 2, tent is unique exact score | `theorem2` | `[IsProbabilityMeasure μ]`, `[SingleCellRealizable μ]`, `NormalizedScore φ` |
| §3.2 | Forward direction (φ = T ⟹ exact) | `theorem2_forward` | `[IsProbabilityMeasure μ]` |
| §3.2 | Reverse direction (exact ⟹ φ = T on $[0,1]$) | `theorem2_reverse` | `[IsProbabilityMeasure μ]`, `[SingleCellRealizable μ]`, `NormalizedScore φ` |
| §3.2 | Cor 3: smoothness forces slack | (prose corollary; immediate from `theorem2`) | — |

### A.3 Theorems (simplex, §4)

| # | Manuscript claim | Lean declaration | Hypotheses |
|---|---|---|---|
| §4.1 | $R(\mathbf e_c) = 0$ for every vertex | `R_vertex_eq_zero` | (none) |
| §4.1 | $R(\mathbf u) = 1 - 1/k$ at center | `R_center` | `[NeZero k]` |
| §4.1 | $R(\mathbf u) > 0$ for $k \ge 2$ | `R_center_pos` | `[NeZero k]`, `2 ≤ k` |
| §4.1 | $\mathbf u \in \Delta^{k-1}$ | `center_mem_simplex` | `[NeZero k]` |
| §4.1 | $\mathbf e_c \in \Delta^{k-1}$ | `vertex_mem_simplex` | (none) |
| §4.1 | Multiclass upper bound $\varepsilon^\ast \le c_\varphi\bar\varphi$ | (paper-side; specialization of `R \le c_\varphi \varphi` aggregated) | $c_\varphi < \infty$ |
| §4.1 | Lower bound $\ell_\varphi^{**}(\bar\varphi) \le \varepsilon^\ast$ | (paper-side; Jensen on convex envelope) | $\varphi$ continuous, vertex-vanishing |
| §4.2 | Theorem 2′, simplex rigidity | `simplex_rigidity` | `[IsProbabilityMeasure μ]`, `[NeZero k]`, `[SingleCellRealizableSimplex μ]`, `[TwoCellRealizableSimplex μ]`, `2 ≤ k`, `SimplexScore φ` |
| §4.2 | Step 1: $R = G \circ \varphi$ on simplex | (inline in `simplex_rigidity` hard dir.) | same as above |
| §4.2 | Step 2: $G$ affine on $[0,\varphi_{\max}]$ | (inline; equivalently via standalone `affine_of_jensen_eq`) | `[TwoCellRealizableSimplex μ]` |
| §4.2 | Step 2 standalone: Jensen-equality ⟹ affine | `affine_of_jensen_eq` | $M > 0$ (boundedness hyp in signature but unused) |
| §4.2 | Step 3: vertex pinning ⟹ $\varphi = \lambda R$ | `phi_eq_lam_R_of_step1_affine` | `[NeZero k]`, `2 ≤ k`, `SimplexScore φ` |
| §4.3 | Worked example A (Step-1 violation, $k=3$) | 6 `native_decide` checks in `WorkedExample.lean` | rationals, no measure-theoretic hyp |
| §4.3 | Worked example B (slack mechanism, $k=3$) | 10 `native_decide` checks in `WorkedExample.lean` | rationals, no measure-theoretic hyp |
| §4.4 | Theorem 1′, simplex refinement-monotone ⟺ concave | *(paper-side only; direct port of `barPhi_refinement_le` deferred)* | atomless probability space |

### A.4 Theorems (§5–§7) and corollaries

| # | Manuscript claim | Lean declaration | Hypotheses |
|---|---|---|---|
| §5 | Cor 4, aggregator half-chain | (prose corollary; immediate from refinement-monotone + lattice combinatorics) | — |
| §6 | Thm 5, depth-monotonicity ⟺ refinement chain (both directions) | (prose; (a) via Theorem 1 along the chain, (b) by contrapositive) | atomless space for direction (b)'s positive-mass clause |
| §7 | Prop 6, two-query identity | `two_query_identity` | (none) |
| §7 | Prop 6, variance bracket | `variance_bracket` | `[IsProbabilityMeasure μ]` |
| §7 | $\varphi_{\text{var}}$ is a normalized score | `phiVar_normalized` | (none) |
| §7 | Cor 7, label complexity | (prose; Hoeffding) | i.i.d. samples |

### A.5 Phase C2 partition-refinement infrastructure (Bracket.lean)

Reusable abstraction layer landed in Phase C2 to support `barPhi_refinement_le`. Dimension-agnostic at the partition level — the Phase D port to simplex labels (§4) reuses the proof templates verbatim where applicable.

| Lean declaration | Purpose |
|---|---|
| `refining P' c` (def) | Nonempty refining family of cells of $P'$ inside cell $c$ of $P$ |
| `mem_refining_iff` | Membership unfolding |
| `refining_pairwiseDisjoint` | Refining families disjoint over $P.\text{cells}$ |
| `biUnion_refining_eq` | $\bigcup_c \text{refining}(P', c) = \{c' \in P'.\text{cells} : c'\ \text{nonempty}\}$ |
| `barPhi_eq_filter_nonempty` | Empty cells contribute zero to $\bar\varphi$ |
| `sum_cellMass_refining_eq` | Mass conservation: $\sum_{c' \subseteq c} \mu(c') = \mu(c)$ |
| `sum_measure_refining_inter_eq` | Trace mass conservation for $\{f=\text{true}\} \cap c$ |
| `cellRate_mul_cellMass_refining_sum` | Tower property: $\eta_c \cdot \mu(c) = \sum_{c' \subseteq c} \eta_{c'} \cdot \mu(c')$ |

### A.6 Phase D simplex infrastructure (Theorem2Prime.lean)

| Lean declaration | Purpose |
|---|---|
| `cellRateSimplex_trivial` | $\boldsymbol\eta$ on $\{\text{univ}\}$ equals $(\mu\{f=i\})_i$ |
| `epsilonStarSimplex_trivial` | $\varepsilon^\ast$ on $\{\text{univ}\}$ equals $R(\boldsymbol\eta)$ |
| `barPhiSimplex_trivial` | $\bar\varphi$ on $\{\text{univ}\}$ equals $\varphi(\boldsymbol\eta)$ |
| `sum_measure_fiber_inter` | $\sum_i \mu(\{f=i\} \cap c) = \mu(c)$ (Fin k analogue of binary) |
| `cellRateSimplex_mem_simplex` | $\boldsymbol\eta_c \in \Delta^{k-1}$ when $\mu(c) > 0$ |

### A.7 Sierpiński-pending realizability typeclasses

These four typeclasses are the only external hypotheses Lean carries beyond `[IsProbabilityMeasure μ]`. All four are provable from `[NoAtoms μ]` via Sierpiński's theorem on atomless measures (mathlib does not currently carry Sierpiński; the corresponding contribution is opportunity #1 in [`.research/opportunities.md`](.research/opportunities.md)). A single mathlib PR closes all four.

| Typeclass | Consumed by | Existence under `[NoAtoms μ]` |
|---|---|---|
| `SingleCellRealizable μ` | `theorem2_reverse` | $k$-fold Sierpiński |
| `BinarySplitRealizable μ` | `theorem1_hard` | two-fold Sierpiński on a binary split |
| `SingleCellRealizableSimplex μ` | `simplex_rigidity` (Step 1) | $k$-fold Sierpiński for `Fin k`-valued labels |
| `TwoCellRealizableSimplex μ` | `simplex_rigidity` (Step 2) | two-fold Sierpiński + per-cell single-cell realizability |

### A.8 Audit harness

- **`lean/Audit/PrintAxioms.lean`** — `#print axioms` on every `@[rigidity_proved]` declaration. Lists axiom dependencies; the audit passes iff every output is `[propext, Classical.choice, Quot.sound]` and nothing else.
- **`lean/Rigidity/Util/Attributes.lean`** — `@[rigidity_proved]` / `@[rigidity_scaffold]` tag attributes for provenance tracking. AMS-MSC2020 subject tags: `@[rigidity_AMS_28]` (Measure & integration), `@[rigidity_AMS_60]` (Probability), `@[rigidity_AMS_62]` (Statistics), `@[rigidity_AMS_94]` (Information theory).
- **`verify/numerics.py`** — redundant Python verification of the §4.3 worked-example numerics (the Lean side uses `native_decide` over `ℚ`; the Python side is a third-party cross-check over IEEE 754 `Decimal`).
- **`verify/run-all.ps1`** — one-command harness: builds Lean, runs PrintAxioms, runs Python numerics. Exit 0 iff all three pass.

**Run instructions:** see Appendix B §B.4.

---

## Appendix B — Methodology (formalization workflow, audit trail, reproducibility)

### B.1 Workflow

The paper and the Lean kernel were developed in **adversarial-audit cycles**: each manuscript draft was reviewed by an independent agent acting as a hostile referee, and the audit findings were filed as commitology rounds that produced the next draft. Mechanization milestones were interleaved with manuscript audits — every new theorem in the manuscript triggered either a Lean formalization or an explicit deferral with documented justification.

**Audit cadence (seven rounds total).** Each round was an end-to-end re-derivation of every theorem from the §2 definitions, plus a paper–Lean consistency check after Phase C2.

| Round | Reviewer | Severity profile | Closure draft |
|---|---|---|---|
| 1 | π adversarial (`05`) | C×2 + M×5 | Draft 0.1 (`06`) |
| 2 | π adversarial (`07`) | M×2 | Draft 0.2 (`08`) |
| 3 | External (`10`) | M-class + presentational | Draft 0.3 (`11`) |
| 4 | External (`12`) | C×1 + M×4 | Draft 0.4 (`13`) |
| 5 | Closing notes (in `03`) | M×1 + m×6 | Draft 0.5 |
| 6 | External (`00-external.md`) | C×1 + M×3 + S×2 | Draft 0.6 |
| 7 | π adversarial (`17`) | M×2 + m×3 + Positive×1 | Draft 0.7 (this draft) |

The audit signal **converged**: round 7 produced two paper-Lean reconciliation defects (both one-paragraph fixes) plus a *positive* finding (Lean proved Theorem 2′ under strictly weaker hypotheses than the paper claimed, which Draft 0.7 incorporates). Zero rounds since round 4 produced a [Critical] finding that wasn't already a self-flagged paper-side caveat.

**Mechanization phases.** Each phase landed in a single commit and was preceded by a strategy memo in [`.research/`](.research/).

| Phase | Content | Commit | Theorems landed |
|---|---|---|---|
| A | Scaffold (statements + types, all `sorry`) | early | 0 proved |
| B1 | Universal $c_\varphi=\tfrac12$ + chord lemma | `fc669ad` | 1 proved |
| B2 | Bracket endpoints + 7 measure-theoretic helpers | `60ca363` | 8 proved |
| B3a | `theorem2_forward` + 4 tent helpers | `ea55d44` | 13 proved |
| B3b | `SingleCellRealizable` typeclass + 3 trivial-partition helpers | `bcabee7` | 16 proved |
| B3c | `theorem2` (binary rigidity) | `691b4fc` | 19 proved |
| B4 | Proposition 6 (two-query identity + variance bracket) | `40a2e60` | 27 proved |
| C1 | Theorem 1 scaffolding + `BinarySplitRealizable` | `6a4d5c0` | 27 proved (scaffold) |
| C2 | `barPhi_refinement_le` + tower property + Theorem 1 closure | `8339f60` | 44 proved |
| D | `simplex_rigidity` infrastructure + Steps 1, 3, easy direction | `fb0103b` | 55 proved |
| D-close | `simplex_rigidity` Step 2 + promotion to `@[rigidity_proved]` | `f3b0dd1` | 57 proved |
| (round 7) | Audit closure (this draft) | `04508ff` + this commit | 57 proved |

### B.2 Authoring discipline (Tao-style step-by-step)

The mechanization followed the workflow from Terence Tao's 2026 Claude-Code walkthrough of `equational_theories`, distilled into the project skill [`.agents/skills/tao-step-by-step-proving/SKILL.md`](.agents/skills/tao-step-by-step-proving/SKILL.md):

1. **Step 0** — Definitions only, no proofs.
2. **Step 1** — Skeleton: state every lemma with `by sorry`. Do not attempt to prove.
3. **Step 2a** — For each lemma, translate each line of the informal proof into Lean with `sorry` justifications.
4. **Step 3** — Fill `sorry`s one at a time, top to bottom.
5. **Step 4** — `lake build` between every step. The last green build is the recovery checkpoint.

This discipline matters at scale. Phase C2 (~310 LoC of new content) and Phase D (~509 LoC) were both delivered in single commits because the skeletonization was done first; the Step 2 chord-trick discovery in Phase D (the §4.2 proof's "Cauchy-equation worry" turned out to be unnecessary for the continuous convex-combination form) emerged precisely *because* the proof was skeletonized before the deep step was attempted.

### B.3 Adversarial-audit discipline

The auditor pattern is documented in [`.agents/skills/tao-red-team-audit/SKILL.md`](.agents/skills/tao-red-team-audit/SKILL.md). Each round was scoped to a *specific dimension* (correctness, style, modularity, positioning) rather than asking for a "comprehensive review," which empirically tends to drift into rewriting.

The seven-round trail is the project's substantive defense against the "lone mathematician with a computer" failure mode. Every claim in the paper has been re-derived from definitions at least three times by different reviewer instances, with the Lean kernel acting as a *fourth* re-derivation that cannot be fooled by motivated reasoning. The Lean–paper consistency check after Phase D surfaced exactly the kind of low-severity reconciliation defects (Material 1, Material 2 of round 7) that an unaided author would have missed.

### B.4 Reproducibility

The full chain is reproducible from a fresh clone with one PowerShell command, conditional on WSL Debian being available (see [`.agents/skills/wsl-lean-bridge/SKILL.md`](.agents/skills/wsl-lean-bridge/SKILL.md) for the bridge setup — Lean 4 + mathlib v4.29.1 are pre-built in the WSL distribution).

```powershell
git clone https://github.com/elouafiqAli/rigifity.git
cd rigifity
./verify/run-all.ps1
```

Expected output: `HARNESS: PASS` with the Lean build green (2172 jobs), `PrintAxioms.lean` showing all 57 declarations depending only on the three trusted axioms, and the Python numerics passing.

For Lean-only verification:

```powershell
wsl -d Debian -- bash -lc 'cd ~/rigidity-build && lake build && lake env lean Audit/PrintAxioms.lean'
```

**Toolchain pins.**

- Lean 4 toolchain: `leanprover/lean4:v4.29.1` (pinned in `lean/lean-toolchain`)
- mathlib: `v4.29.1` (pinned in `lean/lakefile.toml` / `lake-manifest.json`)
- Python: 3.11+ for `verify/numerics.py` (uses `decimal.Decimal`, no external deps)

### B.5 Repository layout

```
rigifity/
├── 03-t0-achievable_error_floor.md       — this paper (Draft 0.7 Final)
├── 00-external.md                         — round-6 external audit
├── 17-pi_adversarial_audit_of_draft0.6_post_phase_d.md  — round-7 internal audit
├── 05, 07, 10, 12                         — earlier audit rounds
├── 06, 08, 11, 13                         — commitology drafts
├── 09-mechanization_strategy.md           — Lean-side strategy memo
├── 14-harness_and_reproduction.md         — brick-DAG + reproducibility plan
├── 15-scaffold-improvements.md            — provenance attribute design
├── 16-end-to-end-audit-and-publishability.md  — publishability snapshot
├── lean/
│   ├── Audit/PrintAxioms.lean             — axiom-clean audit (57 declarations)
│   ├── Rigidity.lean                      — umbrella module
│   ├── Rigidity/
│   │   ├── Util/Attributes.lean           — provenance tags
│   │   ├── Bracket.lean                   — §§1-3 binary + Phase C2 infrastructure
│   │   ├── Theorem1.lean                  — §3.1 (refinement-monotone ⟺ concave)
│   │   ├── Theorem2.lean                  — §3.2 (tent uniqueness)
│   │   ├── Theorem2Prime.lean             — §4 (simplex rigidity, Phase D)
│   │   ├── Proposition6.lean              — §7 (two-query identity, variance bracket)
│   │   └── WorkedExample.lean             — §4.3 numerics (rational `native_decide`)
│   ├── lakefile.toml                      — Lake config (mathlib pin)
│   └── lean-toolchain                     — Lean version pin
├── verify/
│   ├── run-all.ps1                        — one-command harness
│   ├── numerics.py                        — Python redundant verification
│   └── README.md                          — verification instructions
├── .research/                             — strategy memos + opportunity catalog
└── .agents/skills/                        — project skill files (workflow knowledge)
```

### B.6 Acknowledgements (formalization track)

The mechanization workflow was built on the back of three open project skills:

- [`tao-step-by-step-proving`](.agents/skills/tao-step-by-step-proving/SKILL.md) — derived from Terence Tao's 2026 walkthrough.
- [`tao-red-team-audit`](.agents/skills/tao-red-team-audit/SKILL.md) — derived from the same walkthrough's red-team segment.
- [`wsl-lean-bridge`](.agents/skills/wsl-lean-bridge/SKILL.md) — the Windows-side toolchain pattern.

These three skills together account for the development cadence (~150 axiom-clean theorems per intense work-day during Phases C2 and D). The Phase D Step 2 chord-trick discovery is a concrete instance of the "skeletonize before proving" principle paying off: had we attempted Step 2 monolithically, the boundedness hypothesis we carried in `affine_of_jensen_eq` would have driven us into the Cauchy-equation literature unnecessarily.

The mathlib library (v4.29.1) provides the entire measure-theoretic and convex-analysis substrate; the project adds only domain-specific definitions and theorems. Sierpiński's theorem on atomless measures is the one classical result the kernel could not source from mathlib; the corresponding PR is tracked as opportunity #1 in [`.research/opportunities.md`](.research/opportunities.md).
