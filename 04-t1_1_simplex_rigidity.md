# The Simplex Rigidity
### Multiclass companion to the achievable-error floor: the Bayes risk is the unique exact functional on the probability simplex
*Resolves task T1.1. Slots into the Draft 0 as the multiclass section.*

> **What this establishes.** The binary rigidity (the $0$-$1$ Bayes risk is the unique concave score whose bracket is exact) generalizes to $k$-class tasks: among continuous, vertex-vanishing scores on the probability simplex, the multiclass Bayes risk $R(\boldsymbol\eta)=1-\max_c\eta_c$ is the unique exact one, and every smooth score (multiclass entropy, Gini) is strictly inexact. The proof is the same functional-equation argument as the binary case, but the multiclass setting *reveals the mechanism* the binary case concealed: smooth scores carry strictly more information than the Bayes risk — they distinguish distributions the Bayes risk identifies — and that surplus resolution is exactly the bracket slack. This is the multiclass-label extension of the achievable-error floor framework (it resolves Open Problem 1a of `03-t0-achievable_error_floor.md`); the orthogonal extension to *soft cell assignments* needed by attention-style architectures (Open Problem 1b of `03`) requires a separate Markov-kernel lifting and is not addressed here.

---

## 1. Setup

Fix $k\ge 2$ classes. A cell's conditional class distribution is a point $\boldsymbol\eta=(\eta_1,\dots,\eta_k)$ in the simplex $\Delta^{k-1}=\{\boldsymbol\eta\ge 0:\sum_c\eta_c=1\}$; vertices $\mathbf e_c$ are the pure (deterministic) cells, the center $\mathbf u=(1/k,\dots,1/k)$ the maximally uncertain one. A partition $\Pi$ has cells of mass $p_i$ and conditional distributions $\boldsymbol\eta_i\in\Delta^{k-1}$.

The Bayes-optimal cell-wise predictor guesses $\arg\max_c\eta_{i,c}$ and errs with probability $1-\max_c\eta_{i,c}$, so the **partition-restricted Bayes risk** is
$$
\varepsilon^\ast(\Pi)\;=\;\sum_i p_i\,R(\boldsymbol\eta_i),\qquad R(\boldsymbol\eta):=1-\max_c\eta_c .
$$
$R$ is the multiclass analogue of the tent: it is concave on $\Delta^{k-1}$ (since $\max_c\eta_c$ is convex, a maximum of linear forms), continuous, permutation-symmetric, vanishes at the vertices, and is maximal at $\mathbf u$ with $R(\mathbf u)=1-1/k$. It is piecewise-linear, with corners on the loci $\{\eta_c=\eta_{c'}=\max\}$ where the optimal vote switches.

A **simplex score** is a continuous $\varphi:\Delta^{k-1}\to\mathbb R_{\ge 0}$ with $\varphi(\mathbf e_c)=0$ at the vertices and $\varphi>0$ on the interior; when needed we add concavity and permutation-symmetry. The **partition functional** is $\bar\varphi(\Pi)=\sum_i p_i\varphi(\boldsymbol\eta_i)$. Running members: multiclass entropy $\varphi_H(\boldsymbol\eta)=-\sum_c\eta_c\log\eta_c$ and the Gini impurity $\varphi_G(\boldsymbol\eta)=1-\sum_c\eta_c^2$.

---

## 2. The multiclass bracket

The binary bracket had a closed-form lower endpoint $\varphi^{-1}(\bar\varphi)$ because, on $[0,1]$, symmetry made $\varphi$ a function of the scalar $R$. On the simplex this fails — $\varphi$ lives on a $(k-1)$-dimensional set and is generally *not* a function of $R$ — so the lower endpoint is necessarily implicit. We give both bounds.

**Upper bound.** With $c_\varphi:=\sup_{\boldsymbol\eta\ne\text{vertex}}R(\boldsymbol\eta)/\varphi(\boldsymbol\eta)$, the pointwise inequality $R(\boldsymbol\eta)\le c_\varphi\varphi(\boldsymbol\eta)$ aggregates to $\varepsilon^\ast(\Pi)\le c_\varphi\,\bar\varphi(\Pi)$. For Gini the constant is clean: since $\sum_c\eta_c^2\le(\max_c\eta_c)\sum_c\eta_c=\max_c\eta_c$, we have $R\le\varphi_G$ pointwise, so $c_{\varphi_G}=1$ and $\varepsilon^\ast\le\bar\varphi_G$ — the average Gini upper-bounds the multiclass Bayes risk. For entropy $c_{\varphi_H}$ is attained in the interior (entropy vanishes like $s\log(1/s)$ at a vertex, slower than $R\sim s$, so the ratio $\to 0$ there).

**Lower bound.** Define the *level-set floor* $\ell_\varphi(v)=\inf\{R(\boldsymbol\eta):\varphi(\boldsymbol\eta)=v\}$ — the least Bayes risk consistent with score $v$ — so that $R(\boldsymbol\eta)\ge\ell_\varphi(\varphi(\boldsymbol\eta))$ pointwise. Let $\ell_\varphi^{\ast\ast}$ be its lower convex envelope (Fenchel biconjugate). Then, since $\ell_\varphi\ge\ell_\varphi^{\ast\ast}$ and $\ell_\varphi^{\ast\ast}$ is convex,
$$
\varepsilon^\ast(\Pi)=\sum_i p_i R(\boldsymbol\eta_i)\;\ge\;\sum_i p_i\,\ell_\varphi^{\ast\ast}\!\big(\varphi(\boldsymbol\eta_i)\big)\;\ge\;\ell_\varphi^{\ast\ast}\!\big(\bar\varphi(\Pi)\big),
$$
the last step by Jensen for the convex $\ell_\varphi^{\ast\ast}$. So
$$
\boxed{\;\ell_\varphi^{\ast\ast}\big(\bar\varphi(\Pi)\big)\;\le\;\varepsilon^\ast(\Pi)\;\le\;c_\varphi\,\bar\varphi(\Pi).\;}
$$
The convexification is the same device as the Bartlett–Jordan–McAuliffe $\psi$-transform, which is itself the biconjugate of a level-set gap; this is the resolution-level analogue, and it makes the binary case a corollary (there $\ell_\varphi=\varphi^{-1}$ is already convex, so $\ell_\varphi^{\ast\ast}=\varphi^{-1}$ and the lower endpoint is $\varphi^{-1}(\bar\varphi)$).

**Honest limitation.** Unlike $\varphi^{-1}$ in the binary case, $\ell_\varphi$ is a constrained minimization of the Bayes risk over a score-level-set — computable but generally not closed-form. Characterizing $\ell_\varphi$ in closed form for entropy and Gini (the minimizer is, by symmetry, a most-concentrated distribution on the level set) is a minor open direction; it does not affect the rigidity below.

---

## 3. The rigidity theorem

Call $\varphi$ **exact** if some function $G$ satisfies $\varepsilon^\ast(\Pi)=G(\bar\varphi(\Pi))$ for every finite partition (over an atomless configuration, so that cells of arbitrary mass and arbitrary conditional distribution are realizable). Exactness is equivalent to the bracket collapsing, $\ell_\varphi^{\ast\ast}(\bar\varphi)=c_\varphi\bar\varphi$ for all $\Pi$.

**Theorem (Simplex Rigidity).** *Let $\varphi:\Delta^{k-1}\to\mathbb R_{\ge 0}$ be continuous and vanish at the vertices. Then $\varphi$ is exact if and only if $\varphi=\lambda R$ for some $\lambda>0$, where $R(\boldsymbol\eta)=1-\max_c\eta_c$. Moreover every exact $\varphi$ is automatically concave and permutation-symmetric.*

**Proof.**

*(If.)* If $\varphi=\lambda R$ then $\bar\varphi(\Pi)=\lambda\sum_i p_i R(\boldsymbol\eta_i)=\lambda\,\varepsilon^\ast(\Pi)$, so $\varepsilon^\ast=G(\bar\varphi)$ with $G(v)=v/\lambda$. Exact. And $\lambda R$ inherits concavity and symmetry from $R$.

*(Only if.)* Suppose $\varphi$ exact, with $\varepsilon^\ast(\Pi)=G(\bar\varphi(\Pi))$.

Step 1 — *single cells force $R$ to be a function of $\varphi$.* For the one-cell partition with distribution $\boldsymbol\eta$, $\varepsilon^\ast=R(\boldsymbol\eta)$ and $\bar\varphi=\varphi(\boldsymbol\eta)$, so $R(\boldsymbol\eta)=G(\varphi(\boldsymbol\eta))$ for all $\boldsymbol\eta$. Thus $\varphi(\boldsymbol\eta)=\varphi(\boldsymbol\eta')\Rightarrow R(\boldsymbol\eta)=R(\boldsymbol\eta')$: the level sets of $\varphi$ refine those of $R$, and $G$ is determined on the range of $\varphi$.

Step 2 — *two cells force $G$ affine.* For a two-cell partition with masses $p_1,p_2$ and distributions $\boldsymbol\eta_1,\boldsymbol\eta_2$, write $u_j=\varphi(\boldsymbol\eta_j)$. Exactness and Step 1 give
$$
p_1 G(u_1)+p_2 G(u_2)=p_1 R(\boldsymbol\eta_1)+p_2 R(\boldsymbol\eta_2)=\varepsilon^\ast=G(\bar\varphi)=G(p_1 u_1+p_2 u_2).
$$
Because $\varphi$ is continuous on the connected simplex and ranges from $0$ (vertices) to $\varphi_{\max}=\varphi(\mathbf u)$, by the intermediate value theorem every value in $[0,\varphi_{\max}]$ is attained, so $u_1,u_2$ range independently over $[0,\varphi_{\max}]$ as $\boldsymbol\eta_1,\boldsymbol\eta_2$ vary, and $p_1\in[0,1]$ is free. Hence
$$
p_1 G(u_1)+p_2 G(u_2)=G(p_1 u_1+p_2 u_2)\qquad\text{for all }u_1,u_2\in[0,\varphi_{\max}],\ p_1+p_2=1,
$$
i.e. $G$ attains Jensen's bound with equality for every convex combination on $[0,\varphi_{\max}]$, which forces $G$ to be affine: $G(v)=av+b$.

Step 3 — *vertices pin the constants.* At a vertex, $\varphi(\mathbf e_c)=0$ and $R(\mathbf e_c)=0$, so $G(0)=0\Rightarrow b=0$. Then $R(\boldsymbol\eta)=a\,\varphi(\boldsymbol\eta)$ for all $\boldsymbol\eta$, i.e. $\varphi=\lambda R$ with $\lambda=1/a>0$ ($a>0$ since $R,\varphi$ are positive on the interior). Concavity and symmetry of $\varphi$ follow because $\varphi$ is a positive multiple of $R$. $\qquad\blacksquare$

Two remarks worth stating. First, the *only-if* direction uses only continuity, vertex-vanishing, and realizability — **not** concavity or symmetry; those are *conclusions* about exact functionals, not hypotheses. The Bayes risk is singled out among all continuous vertex-vanishing scores, not merely among concave symmetric ones. Second, the argument is verbatim the binary proof (single cell gives $G=\varphi^{-1}$, two cells force affine, vertices pin it), transported to the simplex; the only new ingredient is that the IVT now runs over a higher-dimensional connected domain, which it does without trouble.

---

## 4. Smoothness forces slack — and the mechanism the simplex reveals

**Corollary (smoothness–slack, multiclass).** *Any simplex score that is not a scalar multiple of $R$ — in particular any smooth score, since $R$ is piecewise-linear with corners — is inexact, so its bracket is strict on some partition. Multiclass entropy and Gini are smooth, hence inexact, hence carry strictly positive slack.*

The binary case attributed the slack to the single kink of the tent at $\eta=\tfrac12$. The multiclass case exposes the deeper mechanism, and it is worth seeing concretely.

**Worked example ($k=3$).** Take two cells with the *same* Bayes risk:
$$
\boldsymbol\eta=(0.5,\,0.3,\,0.2),\qquad \boldsymbol\eta'=(0.5,\,0.5,\,0),\qquad R(\boldsymbol\eta)=R(\boldsymbol\eta')=0.5.
$$
Their smooth scores differ: $\varphi_G(\boldsymbol\eta)=1-(0.25+0.09+0.04)=0.62$ while $\varphi_G(\boldsymbol\eta')=1-(0.25+0.25)=0.50$; and $\varphi_H(\boldsymbol\eta)=1.485$ bits while $\varphi_H(\boldsymbol\eta')=1.000$ bit. So Gini and entropy **distinguish two distributions that the Bayes risk identifies**. By Step 1 of the rigidity, an exact score must be constant on $R$-level sets; Gini and entropy are not, so they cannot be exact. Their surplus — the resolution with which they see *inside* an $R$-level set — is precisely what opens the bracket.

Make the slack explicit on a partition. With $p_1=p_2=\tfrac12$ over these two cells, $\varepsilon^\ast=\tfrac12(0.5)+\tfrac12(0.5)=0.5$, while $\bar\varphi_G=\tfrac12(0.62)+\tfrac12(0.50)=0.56$. The Gini upper bound ($c_{\varphi_G}=1$) is $0.56\ge 0.5$, a slack of $0.06$; the lower bound is strictly below $0.5$ as well, so the bracket is genuinely two-sided — the hallmark of an inexact, smooth score. By contrast $\varphi=R$ gives $\bar\varphi=0.5=\varepsilon^\ast$ exactly. The Bayes risk is the *coarsest* concave functional that still resolves the achievable error; every smoother score over-resolves, and over-resolution is the price.

This is the multiclass sharpening of Corollary 3: in one dimension the obstruction looked like a kink; in general it is *dimension*, the surplus information a smooth score carries beyond the Bayes risk.

---

## 5. Consistency with the binary case

For $k=2$, $R(\eta_1,\eta_2)=1-\max(\eta,1-\eta)=\min(\eta,1-\eta)$, so the normalized tent $T=2\min(\eta,1-\eta)=2R$ is the exact functional with $\lambda=2$ (fixing $\varphi(\tfrac12)=1$), recovering the binary Theorem 2 exactly. The level-set floor $\ell_\varphi$ collapses to $\varphi^{-1}$ (binary symmetry makes $\varphi$ a function of $R$, so each level set is a single $R$-value), its convex envelope is itself, and the lower endpoint is $\varphi^{-1}(\bar\varphi)$ — the binary bracket. The simplex result contains the binary one as the $k=2$ face.

---

## 6. What this buys, and the honest relationship to prior work

**Multiclass tasks, directly.** The simplex is the label-distribution simplex for $k$-class node and graph classification — the setting of essentially every real benchmark beyond the binary toy. The rigidity, the bracket, and the smoothness–slack corollary now apply there, and the surrogate-selection guidance carries over: among smooth scores, the one whose pointwise ratio to $R$ is smallest gives the tighter upper instrument (Gini, with $c_{\varphi_G}=1$ and the clean pointwise domination $R\le\varphi_G$, is the natural multiclass workhorse).

**Soft and attention architectures — a separate prerequisite, not a corollary.** The rigidity here is a statement about the *induced conditional label distribution* $\boldsymbol\eta_i$ of each cell, and it does not care whether the cell arises from a hard partition or from a soft assignment — *provided* a $\boldsymbol\eta_i$ per cell is well-defined. For attention-style architectures (GAT, differentiable pooling, graph transformers) cell assignments are themselves *soft* (each input lands in multiple cells with probabilities given by a learned kernel), and there is no canonical per-cell $\boldsymbol\eta_i$ to feed into the bracket. Reaching those architectures therefore requires a *soft-kernel lifting* — a recipe that turns a Markov kernel $K:\mathcal X\to\Delta(\mathrm{Cells})$ into a population object on which the simplex rigidity can be evaluated. We do not construct that lifting here; it is Open Problem 1b of `03`, separate from this companion's contribution. The genuinely new theorem of this paper is the *multiclass label* rigidity; composing it with a future soft-kernel lifting is the route to soft architectures, but the lifting is not in hand.

**Honest positioning.** As in the binary case, we do not claim the rigidity as new decision theory in isolation. Multiclass surrogate calibration is a studied and genuinely subtle area — more delicate than the binary case, since many natural multiclass surrogates fail to be calibrated (Tewari–Bartlett 2007; Ramaswamy–Agarwal 2012; Pires–Szepesvári) — and our result is its resolution-level companion: the statement that, on the refinement lattice, the multiclass Bayes risk is the unique exact functional and smooth scores incur a (convex-envelope) slack. The contribution is the transposition to the resolution/expressivity axis and the GNN reach, consistent with the framing of the main paper; the binary phenomenon (BJM) is classical, and the multiclass resolution-level uniqueness is, to our knowledge, not stated in this form though it is in the spirit of that literature.

---

## 7. Summary

The simplex rigidity closes the multiclass case of the framework's core. Among continuous vertex-vanishing scores on $\Delta^{k-1}$, the multiclass Bayes risk $R=1-\max_c\eta_c$ is the **unique** exact functional (Theorem, §3); every smooth score is strictly inexact (Corollary, §4); and the mechanism is now visible — smooth scores resolve distinctions the Bayes risk identifies, and that surplus is the bracket slack. The result reduces to the binary tent at $k=2$ (§5), it extends the achievable-error floor to multiclass tasks (§6), and it carries the same honest relationship to (multiclass) surrogate-calibration theory as the binary case does to BJM. Reaching soft / attention architectures requires the separate soft-kernel lifting (`03` Open Problem 1b) and is not claimed here. The two-sided bracket is in place (§2), with the one genuine difference from the binary case stated plainly: the lower endpoint is the convex envelope of a level-set minimization rather than a closed-form inverse, computable but implicit — and characterizing it for entropy and Gini is the small remaining technical thread.

---

## References (additions to Draft 0)

Ramaswamy, H. G., and Agarwal, S. *Classification calibration dimension for general multiclass losses.* NeurIPS, 2012.
Tewari, A., and Bartlett, P. *On the consistency of multiclass classification methods.* JMLR, 2007.
Pires, B. Á., and Szepesvári, C. *Multiclass classification calibration functions.* (arXiv) 2016.
*(Bartlett–Jordan–McAuliffe 2006, Zhang 2004, Reid–Williamson 2011, Blackwell 1953, and the remainder are as in Draft 0.)*

---

*T1.1 complete. The rigidity and smoothness–slack corollary are proved in full for general $k$; the implicit lower-endpoint $\ell_\varphi$ (closed forms for entropy and Gini) is the one technical thread left open, and it does not affect the rigidity. With this, the main paper's core extends from binary to multiclass, which is the prerequisite for the soft-architecture reach and for the experiments on real (multiclass) benchmarks.*
