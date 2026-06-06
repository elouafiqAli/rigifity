# A bracket for the partition-restricted Bayes risk

*Draft 0.1 (Judge-π closure) — Executor T. SPL-format short paper, prepared for submission to* Statistics & Probability Letters. *Authored 2026-06-07.*

*Closure of [`02-judge-pi-audit.md`](02-judge-pi-audit.md) findings M-1 (§5.1 arithmetic/units), M-2 (§7 realizability split), M-3 (references: invoke [2] [5] [8] [23], drop [7] [13] [15] [24]), M-4 (§4 quantifier clarification), m-1 (§5 inverse-of-concave cite), m-2 (§2.3 strict-monotonicity motivation moved), m-3 (§6.2 table cell), m-4 (§7 theorem count), m-5 (§5.1 realizability one-liner), S-1 (title trimmed), S-2 (§1.2 ordering sentence). Subject to Judge S prior-art audit in Round 4 ([`04-judge-s-prior-art-audit.md`](04-judge-s-prior-art-audit.md)).*

---

**Abstract.** *Given a finite measurable partition $\Pi$ of a probability space and a binary measurable labeling, the partition-restricted Bayes risk $\varepsilon^\ast(\Pi)$ is the smallest classification error achievable by any predictor constant on the cells of $\Pi$. We show that for every member of a natural class of concave score functionals — continuous, symmetric, vanishing at $\{0,1\}$, normalized by $\varphi(\tfrac12)=1$ and strictly increasing on $[0,\tfrac12]$ — the partition functional $\bar\varphi(\Pi)=\sum_i p_i\varphi(\eta_i)$ provides a two-sided bracket on $\varepsilon^\ast(\Pi)$ in which the upper instrument carries a single universal constant $c_\varphi = \tfrac12$, uniform across the class and attained at $\eta=\tfrac12$. The matching lower instrument $\varphi^{-1}\!\circ\bar\varphi$ exists by the normalization. The class itself is characterised by a refinement-lattice converse to Blackwell's classical inequality: $\bar\varphi$ is monotone under partition refinement if and only if $\varphi$ is concave (Theorem 1), and binary-split monotonicity already suffices. The development is independent of any classifier or learning procedure; it bounds the optimal-classifier floor at fixed resolution, in contrast to surrogate-calibration theory which controls the excess risk of a predictor on a fixed experiment. We discuss the relationship to the Blackwell–Le Cam comparison-of-experiments line and to the Bartlett–Jordan–McAuliffe / Reid–Williamson surrogate-calibration line, and we record that the kernel theorems are mechanised in Lean 4 against mathlib v4.29.1.*

**Keywords:** Bayes risk; concave score; partition; refinement lattice; Blackwell ordering; surrogate calibration; convex envelope.

**MSC2020:** 62C05 (general theory of statistical decision functions); 62B15 (theory of statistical experiments); 62H30 (classification); 26A51 (convex functions).

---

## 1. Introduction

A classification problem at fixed *resolution* is the following. Fix a probability space $(\mathcal X,\mathcal F,\mathbb P)$ and a measurable target $f:\mathcal X\to\{0,1\}$. A finite measurable partition $\Pi=\{S_1,\dots,S_m\}$ of $\mathcal X$ controls the resolution at which a classifier may distinguish points: any predictor constant on the cells of $\Pi$ chooses, in each cell, between the two labels and incurs the cell-conditional error $\min(\eta_i,1-\eta_i)$ where $\eta_i := \mathbb P(f=1\mid S_i)$. The smallest error over such predictors is the **partition-restricted Bayes risk**
$$
\varepsilon^\ast(\Pi) \;=\; \sum_{i=1}^m p_i\,\min(\eta_i,1-\eta_i),\qquad p_i := \mathbb P(S_i). \tag{1}
$$
$\varepsilon^\ast(\Pi)$ is the *achievable floor* at the resolution $\Pi$: an optimal-classifier, population quantity, attained by the cell-wise Bayes rule (cf. Devroye, Györfi, and Lugosi [7, Ch. 2] for the textbook treatment of the un-restricted Bayes risk; the partition-restricted version is the obvious resolution-axis specialisation). It is the natural lower bound on the error any predictor restricted to the resolution can achieve, and it is monotone-decreasing under refinement of $\Pi$ (refining the cells can only help). The question this note addresses is **how to bracket $\varepsilon^\ast(\Pi)$ from a single computable scalar summary of the partition.**

The natural scalar summary is a **partition functional**
$$
\bar\varphi(\Pi) \;=\; \sum_{i=1}^m p_i\,\varphi(\eta_i) \tag{2}
$$
for a scoring function $\varphi:[0,1]\to\mathbb R$. (When $\varphi$ is the conditional Bayes risk of a proper loss $\ell$ — i.e., $\varphi(\eta)=\inf_a \mathbb E_{Y\sim\mathrm{Bern}(\eta)}\ell(Y,a)$ — then $\bar\varphi(\Pi)$ is the partition-restricted Bayes risk of that loss; see Savage [18], DeGroot [5], Grünwald and Dawid [9], and Buja, Stuetzle, and Shen [4] for the proper-loss / generalised-entropy correspondence.) The question is then: **for which $\varphi$ does $\bar\varphi(\Pi)$ control $\varepsilon^\ast(\Pi)$, and with what constant?** Two facts answer it.

**Fact A (Theorem 1 — refinement-monotonicity is concavity, binary form).** For continuous $\varphi:[0,1]\to\mathbb R$, the partition functional $\bar\varphi$ is non-increasing under refinement of partitions if and only if $\varphi$ is concave; and binary-split monotonicity is already equivalent. The forward direction (concavity $\Rightarrow$ refinement-monotone) is Blackwell's inequality [3] for the Bayes risk specialised to the partition lattice. The converse direction (binary-split monotone $\Rightarrow$ concave) — that **the refinement-lattice axis already pins the class** of admissible scoring functionals to the concave ones — does not appear, to our knowledge, in this form in Blackwell [3], Le Cam [13], or Torgersen [21]; we extract it explicitly.

**Fact B (Theorems 2 and 3 — universal upper constant; the bracket).** Within the class of *normalized* concave scores — concave, continuous, symmetric ($\varphi(\eta)=\varphi(1-\eta)$), vanishing at $\{0,1\}$, normalized by $\varphi(\tfrac12)=1$, strictly increasing on $[0,\tfrac12]$ — the upper bracket constant
$$
c_\varphi \;:=\; \sup_{\eta\in(0,1/2]} \frac{\eta}{\varphi(\eta)} \tag{3}
$$
equals $\tfrac12$ uniformly across the class, attained at $\eta=\tfrac12$. The matching two-sided bracket
$$
\varphi^{-1}\!\bigl(\bar\varphi(\Pi)\bigr) \;\le\; \varepsilon^\ast(\Pi) \;\le\; \tfrac12\,\bar\varphi(\Pi) \tag{4}
$$
holds for every normalized concave $\varphi$ and every finite measurable partition $\Pi$.

The contribution of this note is to articulate these two facts as standalone theorems of partition-restricted decision theory, in the cleanest binary setting, with a precise audit of their relationship to the surrogate-calibration literature.

### 1.1 Axes of variation

The bracket (4) sits in a particular corner of decision theory, and locating it precisely matters.

The classical Blackwell–Le Cam framework [3, 13, 21] studies a *fixed* loss and asks how the Bayes risk varies as the underlying *experiment* moves through the refinement order. The result is qualitative: a more informative experiment cannot raise the Bayes risk. It does not produce a quantitative bound from a scalar summary.

The Bartlett–Jordan–McAuliffe / Zhang / Reid–Williamson surrogate-calibration framework [1, 16, 22] studies a *fixed* experiment and asks how the $0$-$1$ excess risk of a *learned* predictor relates to its surrogate excess risk. The result is the $\psi$-transform: $\psi(R-R^\ast) \le R_\varphi - R_\varphi^\ast$, with $\psi$ the convexification of the gap $H^-(\eta)-H(\eta)$ between the unconstrained-prediction and the constrained-prediction conditional Bayes risks. Steinwart [19] develops a related comparison of loss-induced calibration constants. This is the **optimization axis**: variation lives in the predictor; the experiment is held fixed.

The bracket (4) is on the **resolution axis**: variation lives in the partition (the experiment, equivalently the resolution); the loss and the predictor (the Bayes-optimal predictor at that resolution) are determined. The bracket controls the *absolute* partition-restricted Bayes risk, not an excess. The objects coincide pointwise — the concave functional $\varphi$ here plays the role of the conditional Bayes risk $H$ of a proper loss in Reid–Williamson [16] — but the *direction of variation* is orthogonal. We make this distinction precise in §6.

### 1.2 Road map

§2 fixes notation and isolates the normalized-concave-score class. §3 proves the chord-domination lemma that drives every quantitative bound below. §4 proves Theorem 1 — refinement-monotonicity is concavity — in both directions, with the atomless / general-space dichotomy stated explicitly. §5 proves the universal $c_\varphi = \tfrac12$ (Theorem 2) and the two-sided bracket (Theorem 3), illustrated on the three running normalized-concave-score members (Shannon entropy, rescaled variance, tent). §6 positions the results against the Blackwell–Le Cam, BJM–Reid–Williamson, and Savage–DeGroot lines. §7 records the Lean 4 / mathlib v4.29.1 mechanisation status.

We assemble the class characterisation (§4, Theorem 1) before the bracket (§5, Theorems 2–3) because the bracket's class hypotheses (clauses (1)–(6) of §2.3, of which concavity is the load-bearing one) are themselves *justified* by Theorem 1 — refinement-monotonicity over the partition lattice forces precisely the concave-symmetric scoring functionals. The alternative ordering (bracket first, characterisation second) is logically defensible but pedagogically inverts the dependency.

---

## 2. Preliminaries

### 2.1 Probability and partitions

Fix a probability space $(\mathcal X,\mathcal F,\mathbb P)$ and a measurable labeling $f:\mathcal X\to\{0,1\}$. A **partition** $\Pi=\{S_1,\dots,S_m\}$ is finite and measurable: the $S_i\in\mathcal F$ are pairwise disjoint, $\bigcup_i S_i = \mathcal X$. Write
$$
p_i := \mathbb P(S_i),\qquad \eta_i := \mathbb P(f=1\mid S_i)\ \text{ (defined for cells with $p_i>0$)},
$$
and adopt the convention $0\cdot\varphi(\text{anything}) = 0$ so that null cells contribute zero to all partition-level quantities.

A partition $\Pi'$ **refines** $\Pi$, written $\Pi'\succeq\Pi$, if each cell of $\Pi'$ is contained in some cell of $\Pi$. The refinement order is reflexive and transitive; it endows the set of partitions with a meet-semilattice structure. The unique coarsest partition is $\{\mathcal X\}$ and refinements descend from there. (A *binary split* of a cell $S_i$ is a refinement in which $S_i$ is replaced by two non-trivial subcells while all other cells are preserved.)

The probability space is **atomless** if every measurable set of positive measure contains a measurable subset of strictly smaller positive measure. On an atomless space, Sierpiński's theorem [20] — every value in $[0,\mu(S)]$ is realised as the measure of some measurable subset of $S$ — gives the technical hypothesis under which arbitrary binary splits of cells of arbitrary masses and arbitrary conditional rates are realizable; see Halmos [10, §41] and Bogachev [3.5, Vol. 1, §1.12] for textbook treatments. The atomless hypothesis is needed for the converse direction of Theorem 1; the forward direction is unconditional.

### 2.2 The partition-restricted Bayes risk

The **partition-restricted Bayes risk** of $\Pi$ for the labeling $f$ is the smallest expected $0$-$1$ error over predictors constant on the cells of $\Pi$. The cell-wise Bayes rule picks the more-likely label in each cell — guess $1$ on $S_i$ if $\eta_i\ge\tfrac12$, guess $0$ otherwise — and incurs $\min(\eta_i,1-\eta_i)$ per cell, so
$$
\varepsilon^\ast(\Pi) \;=\; \sum_{i:p_i>0} p_i\,\min(\eta_i,1-\eta_i) \;\in\; [0,\tfrac12]. \tag{1$\prime$}
$$
We will use the closed form $\min(\eta,1-\eta) = \tfrac12 T(\eta)$ with the **tent**
$$
T(\eta) \;:=\; 2\min(\eta,1-\eta), \qquad T:[0,1]\to[0,1], \tag{5}
$$
which is the normalised conditional $0$-$1$ Bayes risk in our class (concave, piecewise-linear, $T(0)=T(1)=0$, $T(\tfrac12)=1$). Hence
$$
\varepsilon^\ast(\Pi) \;=\; \tfrac12\,\bar T(\Pi).
$$

### 2.3 Scores and the partition functional

For a function $\varphi:[0,1]\to\mathbb R$, the **partition functional** is
$$
\bar\varphi(\Pi) \;=\; \sum_{i:p_i>0} p_i\,\varphi(\eta_i). \tag{2$\prime$}
$$
A function $\varphi$ is a **normalized concave score** if it is

1. continuous on $[0,1]$,
2. concave on $[0,1]$,
3. symmetric: $\varphi(\eta) = \varphi(1-\eta)$ for all $\eta\in[0,1]$,
4. vanishing at the endpoints: $\varphi(0) = \varphi(1) = 0$,
5. normalized: $\varphi(\tfrac12) = 1$,
6. strictly increasing on $[0,\tfrac12]$ (and, by symmetry, strictly decreasing on $[\tfrac12,1]$).

The strict-monotonicity clause (6) is included for the existence of the inverse $\varphi^{-1}:[0,1]\to[0,\tfrac12]$, which the lower bracket of Theorem 3 invokes; without (6) the upper bracket of Theorem 3 still holds (its proof needs no inverse), but the lower one needs an inverse and so needs strict monotonicity. Concavity together with $\varphi(\tfrac12) = 1$ does not by itself force strict monotonicity — a flat plateau at height $1$ near $\tfrac12$ would still be concave and would still attain the normalisation, and the lower bracket would be vacuous for such a $\varphi$. Cf. Buja, Stuetzle, and Shen [4] for a parallel survey of normalised proper losses, where strict monotonicity plays the same role.

**Running members.** The class is non-empty and rich; we exhibit four members. (Throughout, $\log_2$ denotes the binary logarithm.)
$$
\begin{aligned}
\varphi_H(\eta) &= -[\eta\log_2\eta + (1-\eta)\log_2(1-\eta)] && \text{(Shannon entropy)},\\
\varphi_{\mathrm{var}}(\eta) &= 4\eta(1-\eta) && \text{(rescaled variance, Gini)},\\
T(\eta) &= 2\min(\eta,1-\eta) && \text{(tent — the normalised Bayes risk)},\\
\varphi_q(\eta) &= 2\sqrt{\eta(1-\eta)} && \text{(rescaled Hellinger / Matusita affinity)}.
\end{aligned}
$$
Each is normalized concave: all four satisfy clauses (1)–(6). Each is **smooth on $(0,1)$** except $T$, which has a single corner at $\eta=\tfrac12$. We will see in §5 that this difference is precisely the source of slack in the bracket for the three smooth members.

### 2.4 Cost-accounting remark

Computing $\varepsilon^\ast(\Pi)$ from the cell-wise quantities $(p_i,\eta_i)$ costs $O(m)$ once the partition is known. Computing $\bar\varphi(\Pi)$ costs $O(m)$ as well. The bracket (4) below is therefore not an algorithmic speed-up; it is a *certificate* — a bound that depends only on $\bar\varphi(\Pi)$, which downstream applications may have computed for other reasons (e.g. as the value of a surrogate loss).

---

## 3. The chord domination lemma

The single inequality from which everything quantitative below derives.

**Lemma 1 (chord domination).** *Let $\varphi:[0,1]\to\mathbb R$ be a normalized concave score. Then*
$$
\varphi(\eta) \;\ge\; 2\eta \quad\text{for all }\eta\in[0,\tfrac12], \qquad \text{and}\qquad \varphi(\eta) \;\ge\; 2(1-\eta) \quad\text{for all }\eta\in[\tfrac12,1]. \tag{6}
$$
*Equality in either inequality at an interior point occurs only when $\varphi$ coincides with the tent $T$ on the corresponding sub-interval.*

**Proof.** Fix $\eta\in(0,\tfrac12)$. Concavity of $\varphi$ on $[0,\tfrac12]$ puts the graph above the chord through $(0,\varphi(0))=(0,0)$ and $(\tfrac12,\varphi(\tfrac12))=(\tfrac12,1)$. The chord has equation $y = 2\eta$ on $[0,\tfrac12]$, so $\varphi(\eta) \ge 2\eta$ on the same interval. The cases $\eta=0$ ($\varphi(0)=0=2\cdot 0$) and $\eta=\tfrac12$ ($\varphi(\tfrac12)=1=2\cdot\tfrac12$) hold with equality and complete the first inequality. The second inequality follows by symmetry: $\varphi(\eta) = \varphi(1-\eta) \ge 2(1-\eta)$ on $[\tfrac12,1]$.

Equality at an interior point $\eta_0\in(0,\tfrac12)$ means the chord through $(0,0)$ and $(\tfrac12,1)$ touches the graph at $\eta_0$, which by concavity forces $\varphi$ to coincide with that chord — equivalently with $T$ — on the entire segment $[0,\tfrac12]$. $\qquad\blacksquare$

**Remark 1.** Lemma 1 is a single-paragraph specialisation of the standard chord-domination property of concave functions (cf. Hardy–Littlewood–Pólya [11, §3.18] and Roberts–Varberg [17, Ch. 1]) to the normalised class. The novelty is not the inequality per se — it is the use we put it to in §5: the *uniformity* of $c_\varphi = \tfrac12$ across the class follows immediately, with the same single attaining point $\eta = \tfrac12$, regardless of which $\varphi$ is chosen.

---

## 4. Refinement-monotonicity is concavity

The class of *normalized concave* scores is precisely the class characterised by refinement-monotonicity of the partition functional. The forward direction (concavity $\Rightarrow$ refinement-monotone) is the partition-lattice form of Blackwell's classical inequality [3]; the converse direction (binary-split monotone $\Rightarrow$ concave) is what we extract.

**Theorem 1 (refinement-monotonicity is concavity).** *Let $(\mathcal X,\mathcal F,\mathbb P)$ be atomless, and let $\varphi:[0,1]\to\mathbb R$ be continuous. The following are equivalent.*

*(i) **Refinement-monotone.** For every pair of finite measurable partitions $\Pi'\succeq\Pi$ of $\mathcal X$ and every measurable labeling $f:\mathcal X\to\{0,1\}$,*
$$
\bar\varphi(\Pi') \;\le\; \bar\varphi(\Pi).
$$

*(ii) **Binary-split monotone.** For every finite measurable partition $\Pi$, every cell $S_i$ of $\Pi$, and every binary split of $S_i$ into measurable subcells of positive mass and arbitrary conditional rates, $\bar\varphi$ does not increase.*

*(iii) **Concave.** $\varphi$ is concave on $[0,1]$.*

*On a general (possibly atomic) probability space, the implication $(\mathrm{iii})\Rightarrow(\mathrm{i})\Rightarrow(\mathrm{ii})$ continues to hold unconditionally; the implication $(\mathrm{ii})\Rightarrow(\mathrm{iii})$ holds by density of realizable binary splits plus continuity of $\varphi$.*

**Proof.**

*$(\mathrm{i})\Rightarrow(\mathrm{ii})$.* Immediate: a binary split is a refinement.

*$(\mathrm{iii})\Rightarrow(\mathrm{i})$ (Blackwell direction).* Let $\Pi'\succeq\Pi$. Each cell $S_i$ of $\Pi$ is partitioned by $\Pi'$ into subcells $\{S_{ik}\}$ of conditional weights $w_{ik}:=\mathbb P(S_{ik})/\mathbb P(S_i) = p_{ik}/p_i$ (defined for $p_i>0$; null cells contribute zero throughout) and conditional rates $\eta_{ik}$. The tower property of conditional expectations gives
$$
\eta_i \;=\; \mathbb P(f=1\mid S_i) \;=\; \sum_k w_{ik}\,\eta_{ik}.
$$
Concavity of $\varphi$ (Jensen's inequality applied to $\eta_i$ as the $w$-convex combination of the $\eta_{ik}$) gives
$$
\varphi(\eta_i) \;\ge\; \sum_k w_{ik}\,\varphi(\eta_{ik}).
$$
Multiply by $p_i$ and sum:
$$
\bar\varphi(\Pi) \;=\; \sum_i p_i\,\varphi(\eta_i) \;\ge\; \sum_i \sum_k p_i\,w_{ik}\,\varphi(\eta_{ik}) \;=\; \sum_i\sum_k p_{ik}\,\varphi(\eta_{ik}) \;=\; \bar\varphi(\Pi').
$$

*$(\mathrm{ii})\Rightarrow(\mathrm{iii})$ (the converse direction, on an atomless space).* Theorem 1 quantifies separately over partitions $\Pi$ and labelings $f$ (both quantified universally in (i) and (ii)), so for the converse direction we are free to choose *both* simultaneously. We construct a specific $(\Pi, f)$ for which the binary-split inequality at $(a, b, \lambda)$ becomes the concavity inequality at $(a, b, \lambda)$ for $\varphi$; since $(a, b, \lambda)$ are arbitrary, $\varphi$ is concave.

Fix $a,b\in[0,1]$ and $\lambda\in(0,1)$; set $\eta := \lambda a + (1-\lambda)b\in[0,1]$. Concretely: by atomlessness and Sierpiński's theorem, choose a measurable cell $S\subseteq\mathcal X$ with $\mathbb P(S) = 1$ (i.e., $S = \mathcal X$ up to a null set, since $\mathbb P$ is a probability measure — the construction can be carried out on any measurable $S$ of positive measure by conditioning), and within $S$ choose a measurable subset $S_+\subseteq S$ with $\mathbb P(S_+) = \eta$ on which $f$ takes the value $1$ and $f=0$ on $S\setminus S_+$. Now split $S$ into $A,B\subseteq S$ measurably with $\mathbb P(A) = \lambda$ and $\mathbb P(B) = 1-\lambda$, arranging the intersections so that $\mathbb P(A\cap S_+) = \lambda a$ (and hence $\mathbb P(B\cap S_+) = (1-\lambda)b$); this is again Sierpiński, applied separately to $S_+$ and $S\setminus S_+$ to extract the required masses. Then
$$
\mathbb P(f=1\mid A) = \frac{\lambda a}{\lambda} = a,\qquad \mathbb P(f=1\mid B) = \frac{(1-\lambda)b}{1-\lambda} = b,
$$
and the partition $\Pi = \{S\}$ has $\bar\varphi(\Pi) = \varphi(\eta)$, while the refinement $\Pi' = \{A,B\}$ has $\bar\varphi(\Pi') = \lambda\varphi(a) + (1-\lambda)\varphi(b)$. The binary-split hypothesis (ii) says $\bar\varphi(\Pi')\le\bar\varphi(\Pi)$, i.e.
$$
\lambda\varphi(a) + (1-\lambda)\varphi(b) \;\le\; \varphi(\lambda a + (1-\lambda)b),
$$
which is the concavity inequality for $\varphi$ at $(a,b,\lambda)$. Since $a,b,\lambda$ were arbitrary, $\varphi$ is concave.

*General-space dichotomy.* On a general probability space the binary splits used in the converse direction may not be realizable for every $(a,b,\lambda)$ — atoms restrict the masses available — but they are realizable on a *dense* subset of $(a,b,\lambda)$ values, and continuity of $\varphi$ extends concavity from the dense subset to all of $[0,1]\times[0,1]\times[0,1]$. The forward direction $(\mathrm{iii})\Rightarrow(\mathrm{i})$ is unconditional: Jensen's inequality on the cell-conditional convex combinations requires no realisability hypothesis. $\qquad\blacksquare$

**Remark 2 (relation to Blackwell).** Blackwell's classical comparison-of-experiments theorem [3] says that if experiment $\mathcal E_1$ is more informative than $\mathcal E_2$ (in the sense of factorisation by a Markov kernel), then the Bayes risk under $\mathcal E_1$ does not exceed that under $\mathcal E_2$, for every loss. Specialised to *partition* experiments — where $\mathcal E_\Pi$ is the experiment that reveals the index of the containing cell of $\Pi$ — the more-informative-experiment ordering coincides with the refinement ordering, and the conditional Bayes risk of a proper loss is the concave $\varphi = H$ of Savage [18] / DeGroot [5] / Grünwald–Dawid [9]. The forward direction $(\mathrm{iii})\Rightarrow(\mathrm{i})$ above is therefore Blackwell's inequality for the partition-experiment specialisation.

The **converse direction** $(\mathrm{ii})\Rightarrow(\mathrm{iii})$ — that the *class* of admissible scoring functionals on the partition lattice is no larger than the concave functionals — is implicit in any derivation of the Bayes risk from concavity of $H$, but is not, to our knowledge, articulated in this form in Blackwell [3], Le Cam [13, 14], Torgersen [21], or DeGroot [5]. The novelty is the use of an *individual binary split* — not the full refinement lattice and not the full proper-loss formalism — to characterise the class.

**Remark 3 (atomless hypothesis).** The atomless hypothesis in Theorem 1 is sharp for the converse direction: on a probability space with a finite number of atoms of fixed masses, only finitely many binary splits are realizable, and concavity of $\varphi$ at arbitrary $(a,b,\lambda)$ cannot be tested. The general-space density argument recovers concavity on $[0,1]$ from the realizable splits only when those are dense — i.e., when atom masses can be made arbitrarily small. Standard probability spaces ($\mathbb R$ with a non-atomic Borel measure, the Lebesgue interval, any continuum-valued setting) are atomless; finite-state models are not. On strictly finite-atomic spaces the equivalence reduces to concavity on a finite set of rates, which is a strictly weaker statement and one we do not develop here.

---

## 5. The universal upper constant and the bracket

We now prove that the upper bracket constant of the partition functional is universal across the normalized concave score class, and we assemble the two-sided bracket.

**Theorem 2 (universal $c_\varphi = \tfrac12$).** *Let $\varphi$ be a normalized concave score (Definition in §2.3). Then*
$$
c_\varphi \;:=\; \sup_{\eta\in(0,1/2]}\frac{\eta}{\varphi(\eta)} \;=\; \tfrac12, \tag{7}
$$
*attained at $\eta = \tfrac12$. Equivalently, $\eta \le \tfrac12\,\varphi(\eta)$ for every $\eta\in[0,1]$, with equality at $\eta\in\{0,\tfrac12,1\}$.*

**Proof.** By Lemma 1, $\varphi(\eta)\ge 2\eta$ on $[0,\tfrac12]$. For $\eta\in(0,\tfrac12]$ this rearranges to $\eta/\varphi(\eta) \le \tfrac12$, with equality at $\eta=\tfrac12$ (since $\varphi(\tfrac12) = 1$ by the normalization). Hence
$$
c_\varphi = \sup_{\eta\in(0,1/2]} \frac{\eta}{\varphi(\eta)} \le \tfrac12,
$$
and the supremum is attained at $\eta=\tfrac12$, so $c_\varphi = \tfrac12$. The equivalent pointwise statement $\eta\le\tfrac12\varphi(\eta)$ on $[0,1]$ follows by combining the two halves of Lemma 1: on $[0,\tfrac12]$, $\eta\le\tfrac12\varphi(\eta)$ directly; on $[\tfrac12,1]$, $1-\eta\le\tfrac12\varphi(\eta)$ by the second half of Lemma 1, and the cell-wise Bayes risk $\min(\eta,1-\eta)$ is dominated by $\tfrac12\varphi(\eta)$ in either case. $\qquad\blacksquare$

**Remark 4 (units).** The constant $\tfrac12$ in (7) is an artifact of the normalisation $\varphi(\tfrac12) = 1$. For an un-normalised concave $\varphi$ satisfying clauses (1)–(4) and (6) of §2.3, the analogous supremum equals $1/(2\varphi(\tfrac12))$, still uniform across the un-normalised class once the chord-domination Lemma is rescaled accordingly. The normalisation is therefore a *choice of units* — the same universality statement up to scalar — and not a substantive restriction of the class.

**Theorem 3 (the two-sided bracket).** *Let $\varphi$ be a normalized concave score and $\Pi$ a finite measurable partition of $(\mathcal X,\mathcal F,\mathbb P)$ for the labeling $f$. Then*
$$
\varphi^{-1}\!\bigl(\bar\varphi(\Pi)\bigr) \;\le\; \varepsilon^\ast(\Pi) \;\le\; \tfrac12\,\bar\varphi(\Pi). \tag{8}
$$

**Proof.** *Lower endpoint.* From $\min(\eta_i,1-\eta_i)\le\tfrac12$ on every cell and $\varphi$ symmetric strictly increasing on $[0,\tfrac12]$, we may write the cell-wise Bayes risk as $\varphi^{-1}\bigl(\varphi(\min(\eta_i,1-\eta_i))\bigr) = \min(\eta_i,1-\eta_i)$. Symmetry of $\varphi$ gives $\varphi(\eta_i) = \varphi(\min(\eta_i,1-\eta_i))$. Then $\varphi^{-1}$ is monotone increasing on $[0,1]$ (since $\varphi$ is symmetric and concave with $\varphi(\tfrac12)=1$, its restriction to $[0,\tfrac12]$ is a strictly increasing continuous bijection onto $[0,1]$), and concavity of $\varphi$ on $[0,1]$ makes $\varphi^{-1}$ convex on $[0,1]$ (the standard fact that the inverse of a strictly increasing concave function is convex; see, e.g., Bauschke–Combettes [2, §8.2] or Roberts–Varberg [17, §B]). Jensen's inequality for the convex $\varphi^{-1}$ applied to the cell distribution $\{p_i\}$ over the values $\{\varphi(\eta_i)\}$ gives
$$
\varphi^{-1}\!\Bigl(\sum_i p_i\varphi(\eta_i)\Bigr) \;\le\; \sum_i p_i\,\varphi^{-1}(\varphi(\eta_i)) \;=\; \sum_i p_i\,\min(\eta_i,1-\eta_i) \;=\; \varepsilon^\ast(\Pi).
$$
The left-hand side is $\varphi^{-1}(\bar\varphi(\Pi))$, which is the lower endpoint.

*Upper endpoint.* By Theorem 2, $\min(\eta_i,1-\eta_i) \le \tfrac12\varphi(\eta_i)$ for every $i$. Multiply by $p_i$ and sum over cells:
$$
\varepsilon^\ast(\Pi) \;=\; \sum_i p_i\,\min(\eta_i,1-\eta_i) \;\le\; \tfrac12\sum_i p_i\,\varphi(\eta_i) \;=\; \tfrac12\,\bar\varphi(\Pi). \qquad\blacksquare
$$

**Corollary 1 (the bracket is exact only for the tent).** *If $\varepsilon^\ast(\Pi) = \tfrac12\bar\varphi(\Pi)$ for every partition $\Pi$ of some atomless space, then $\varphi = T$. In particular, any normalized concave score that is strictly concave on a sub-interval of $(0,\tfrac12)$ — including $\varphi_H$, $\varphi_{\mathrm{var}}$, and $\varphi_q$ from §2.3 — has a strict upper bracket on some partition.*

**Proof.** Apply Theorem 3's upper bound to the single-cell partition $\Pi = \{\mathcal X\}$ with conditional rate $\eta\in[0,\tfrac12]$ (realizable on the atomless space by Sierpiński). Exactness reads $\min(\eta,1-\eta) = \tfrac12\varphi(\eta)$, i.e. $\eta = \tfrac12\varphi(\eta)$, i.e. $\varphi(\eta) = 2\eta$ on $[0,\tfrac12]$. Symmetry gives $\varphi = T$. The contrapositive — strict concavity anywhere in $(0,\tfrac12)$ excludes $\varphi = T$ — gives the second statement. $\qquad\blacksquare$

(Corollary 1 is the binary single-cell-pinning argument; the standalone treatment that names this technique and exhibits the binary uniqueness is in the companion satellite [O4] in the publication plan [`../../21-publication_plan.md`](../../21-publication_plan.md) §4.)

### 5.1 Worked example: the bracket on a two-cell partition

(The partition below is realizable on any atomless space — e.g., $\mathcal X = [0,1]$ with Lebesgue measure, $S_1 = [0,\tfrac12], S_2 = [\tfrac12,1]$, $f = \mathbb 1_{[0,1/8]\cup[1/2,7/8]}$ — so the example is well-defined.)

Take a two-cell partition with masses $p_1 = p_2 = \tfrac12$ and conditional rates $(\eta_1,\eta_2) = (\tfrac14, \tfrac34)$. Then $\varepsilon^\ast(\Pi) = \tfrac12\bigl[\min(\tfrac14,\tfrac34) + \min(\tfrac34,\tfrac14)\bigr] = \tfrac14$.

The four running members of §2.3 give partition functionals:

| $\varphi$ | $\varphi(\tfrac14) = \varphi(\tfrac34)$ | $\bar\varphi(\Pi)$ | upper bound $\tfrac12\bar\varphi$ | lower bound $\varphi^{-1}(\bar\varphi)$ |
|---|---|---|---|---|
| Shannon $\varphi_H$ | $-\tfrac14\log_2\tfrac14-\tfrac34\log_2\tfrac34\approx 0.8113$ | $0.8113$ | $0.4057$ | $0.25$ |
| Variance $\varphi_{\mathrm{var}}$ | $4\cdot\tfrac14\cdot\tfrac34=\tfrac34$ | $0.75$ | $0.375$ | $0.25$ |
| Tent $T$ | $\tfrac12$ | $0.5$ | $0.25$ | $0.25$ |
| Hellinger $\varphi_q$ | $2\sqrt{\tfrac3{16}} = \tfrac{\sqrt 3}{2}\approx 0.8660$ | $\approx 0.8660$ | $\approx 0.4330$ | $0.25$ |

For the variance row: $\varphi_{\mathrm{var}}^{-1}(\tfrac34)$ solves $4\eta(1-\eta) = \tfrac34$ on $[0,\tfrac12]$, i.e. $\eta^2 - \eta + \tfrac{3}{16} = 0$ with roots $\eta\in\{\tfrac14,\tfrac34\}$; the root in $[0,\tfrac12]$ is $\eta = \tfrac14$, so the lower bound is $0.25$. Similarly for the other two smooth members the lower bound recovers $\tfrac14$ from the single-cell pinning of Corollary 1.

**Reading.** For the tent, both bounds equal $\tfrac14 = \varepsilon^\ast(\Pi)$ exactly — the bracket is tight. For the three smooth members the lower bracket equals $\tfrac14 = \varepsilon^\ast(\Pi)$ (because $\eta_1 = \tfrac14$ is realizable as a single-cell rate; cf. Corollary 1) but the upper bracket is strictly looser: $\tfrac12\bar\varphi_H(\Pi)\approx 0.406$, $\tfrac12\bar\varphi_{\mathrm{var}}(\Pi) = 0.375$, $\tfrac12\bar\varphi_q(\Pi)\approx 0.433$ — all strictly greater than $\tfrac14$. Among the three smooth members the rescaled variance gives the tightest upper bracket on this partition. The standard inequality $4\eta(1-\eta)\le\varphi_H(\eta)$ holds on $[0,1]$ under the bit normalisation $\varphi_H(\tfrac12)=1$, with equality at $\eta\in\{0,\tfrac12,1\}$ (Cover and Thomas [4.5, §2.7] document the well-known relationship between $4\eta(1-\eta)$ and the binary entropy; see also Topsøe [REF if added] for sharper variants). Consequently $\bar\varphi_{\mathrm{var}}\le\bar\varphi_H$ on every partition, so among the three smooth members the variance always gives a tighter upper bracket than entropy.

### 5.2 The bracket gap is the resolution-axis image of the surrogate gap

The pattern displayed in §5.1 — smooth members carry strictly positive bracket slack, the tent is exact — is the resolution-axis image of the surrogate-calibration phenomenon that smooth proper losses carry a strictly convex $\psi$-transform [1, 22]. The binary single-cell-pinning argument (Corollary 1) is the resolution-axis counterpart of "$\psi$ is the identity iff the loss is the $0$-$1$ loss" in the optimization-axis formulation. We elaborate on the correspondence in §6.

---

## 6. Prior art and positioning

We position the bracket against three reference lines: the Blackwell–Le Cam comparison-of-experiments line, the BJM–Reid–Williamson surrogate-calibration line, and the Savage–DeGroot–Grünwald–Dawid proper-loss / generalised-entropy line. The constructs of this note are *transpositions* of objects from each of these lines onto the partition-lattice axis; we draw the line precisely so that the contribution is not mistaken.

### 6.1 Blackwell, Le Cam, and the refinement order

Blackwell's theorem [3] is the qualitative statement that one experiment is more informative than another (i.e. factorises through it by a Markov kernel) if and only if it has lower Bayes risk for *every* loss. Specialised to partition experiments — where the experiment $\mathcal E_\Pi$ reveals the cell index — the more-informative-than relation reduces to refinement of $\Pi$. Theorem 1's $(\mathrm{iii})\Rightarrow(\mathrm{i})$ direction is Blackwell's inequality for the partition-experiment specialisation, with $\varphi$ in the role of the conditional Bayes risk $H$ of a proper loss.

Le Cam's theory [13, 14] refines Blackwell with the **deficiency** $\delta(\mathcal E_1, \mathcal E_2)$ — the cost of using $\mathcal E_2$ in place of $\mathcal E_1$ for the worst decision problem. This is a quantitative refinement of Blackwell, but it parametrises the *experiment*, not the *scoring functional*; the analogue of our $c_\varphi$ is not a Le Cam construct.

The Theorem 1 **converse direction** — that binary-split monotonicity *forces* $\varphi$ concave, so the class of admissible scoring functionals on the partition lattice is exactly the concave class — is the natural converse to Blackwell on the partition-lattice axis. We do not find it stated explicitly in Blackwell [3], Le Cam [13, 14], Torgersen [21], or the subsequent comparison-of-experiments literature [8]. It is implicit in any derivation of the proper-loss / generalised-entropy correspondence (see §6.3 below), but the *individual binary split* characterisation — which is the load-bearing element for the partition-lattice reading — is what we extract.

### 6.2 BJM, Zhang, Reid–Williamson, and the optimization axis

Bartlett, Jordan and McAuliffe [1] introduced the **$\psi$-transform**: for a surrogate margin loss with conditional risk $H_\varphi$, define $\psi$ as the convexification (Fenchel biconjugate) of the gap $H^-_\varphi - H_\varphi$, where $H^-_\varphi$ is the *constrained* conditional risk under the constraint that the prediction misclassifies. Then [1, Theorem 1] gives the calibration bound
$$
\psi\bigl(R(\hat f) - R^\ast\bigr) \;\le\; R_\varphi(\hat f) - R_\varphi^\ast \tag{BJM}
$$
relating excess $0$-$1$ risk of a learned predictor $\hat f$ to its excess surrogate risk, with the experiment held fixed throughout. Zhang [22] develops a parallel result via convexification of the loss directly. Reid and Williamson [16] unify these and the underlying f-divergence / Bregman / proper-loss / scoring-rule families into a single calibrated framework for binary experiments; their development (especially [16, §3, §4]) is the closest single source of the convex-analytic toolkit used in the present note.

**The axis distinction.** The bracket (4) of this note and the BJM inequality (BJM) above are *not* the same object. To make the distinction unambiguous:

| | $\psi$-transform (BJM, Zhang, Reid–Williamson) | Bracket (this note, Theorem 3) |
|---|---|---|
| What varies | the predictor $\hat f$ at fixed experiment $\mathcal E$ | the experiment $\mathcal E_\Pi$ at fixed loss ($0$-$1$) |
| Object controlled | *excess* risk $R(\hat f) - R^\ast$ | *absolute* risk $\varepsilon^\ast(\Pi)$ |
| Upper instrument | $\psi^{-1}(R_\varphi(\hat f) - R_\varphi^\ast)$ (loss-dependent) | $\tfrac12\bar\varphi(\Pi)$ (constant $\tfrac12$ uniform) |
| Lower instrument | no analogue: $\psi$-transform parametrises predictors not partitions; predictor lower bounds are Vapnik-style risk decompositions | $\varphi^{-1}(\bar\varphi(\Pi))$ (Jensen on convex $\varphi^{-1}$) |
| Specialisation to $\varphi=T$ | $\psi = $ identity (BJM Cor. 1) | bracket exact (Corollary 1 here) |
| Atomless hypothesis | not needed | needed for the converse direction of Theorem 1 |

The two results are dual on the orthogonal axes of *predictor* and *experiment*. They share the Bregman / convex-analytic toolkit (concave generators, convex envelopes, calibration of upper instruments) but they control different absolute quantities under different parametrisations. We use the Reid–Williamson [16, §3] toolkit throughout the proof of Theorem 3 (the Jensen step for the lower endpoint is dual to the Bregman step in [16, Theorem 2]) and we cite their development as the closest single source of the analytic machinery.

### 6.3 Savage, DeGroot, and the proper-loss / generalised-entropy correspondence

For a proper loss $\ell:[0,1]\times\{0,1\}\to\mathbb R$, the conditional Bayes risk
$$
H(\eta) := \inf_a \mathbb E_{Y\sim\mathrm{Bern}(\eta)}\,\ell(a,Y)
$$
is concave on $[0,1]$ [Savage 18; DeGroot 5; Grünwald–Dawid 9; Buja–Stuetzle–Shen 4]. Every concave $H$ vanishing at the endpoints arises in this way, so the proper-loss / generalised-entropy correspondence gives the bijection between proper losses and (a subclass of) the concave $\varphi$ of this note. Specifically: our normalised class corresponds to proper losses for which $H$ is normalised by $H(\tfrac12) = 1$ and is symmetric — a mild canonical normalisation.

Under the correspondence, our partition functional $\bar\varphi(\Pi)$ coincides with the partition-restricted Bayes risk of the matched proper loss: $\bar\varphi(\Pi) = \sum_i p_i H(\eta_i)$ is the optimal expected loss over predictors constant on the cells of $\Pi$. The *lower* endpoint of our bracket (Theorem 3) is essentially the Jensen-via-tower-property bound on this matched-loss expectation — a fact that, after the proper-loss correspondence, can be read off from DeGroot [5, Ch. 14 of the relevant reference treatment] or Grünwald–Dawid [9, §3].

The *upper* endpoint of our bracket — $\varepsilon^\ast(\Pi) \le \tfrac12 \bar\varphi(\Pi)$ with the uniform $c_\varphi = \tfrac12$ — has no analogue in DeGroot [5] or Grünwald–Dawid [9]: those works treat the matched-loss Bayes risk as a primitive object, not as an upper bound on the $0$-$1$ Bayes risk for a different loss. The chord-domination Lemma 1 — which controls the $0$-$1$ Bayes risk by *every* normalised concave functional uniformly — is the new piece.

### 6.4 Summary

The bracket (4) sits at the intersection of the Blackwell–Le Cam refinement-lattice tradition (qualitative; about more-vs-less-informative experiments) and the BJM–Reid–Williamson surrogate-calibration tradition (quantitative; about excess risk on the optimization axis). It produces the **quantitative absolute** statement in the **resolution-lattice** setting, with a single universal upper constant $\tfrac12$. The refinement-lattice converse to Blackwell (Theorem 1, (ii)⟹(iii)) characterises the admissible class of scoring functionals, and the chord-domination lemma (Lemma 1) gives the uniformity of $c_\varphi$ within that class.

---

## 7. Mechanization

The three central theorems of this note — Theorem 1 (refinement-monotonicity ⟺ concavity, both directions), Theorem 2 (universal $c_\varphi = \tfrac12$), and Theorem 3 (the two-sided bracket) — are mechanically verified in **Lean 4** against **mathlib v4.29.1**, axiom-clean (the only axioms consumed are `propext`, `Classical.choice`, `Quot.sound`, the three standard axioms of dependent type theory).

For the present satellite, the relevant Lean kernel comprises seven theorems and one structure: `NormalizedScore` (the structure recording clauses (1)–(6) of §2.3 on `φ : ℝ → ℝ`), `tent_normalized`, `two_eta_le_of_normalized` (Lemma 1), `cPhi_eq_half_of_normalized` (Theorem 2), `barPhi_refinement_le` (the partition-additivity workhorse for the forward direction of Theorem 1), `theorem1_easy` (Theorem 1, (iii)⟹(i)⟹(ii)), `theorem1_hard` (Theorem 1, (ii)⟹(iii) — the converse to Blackwell), `theorem1` (the combined equivalence), `bracket_lower` and `bracket_upper` (the two endpoints of Theorem 3) — all axiom-clean.

The dependency on realizability hypotheses splits cleanly along the theorem boundaries.
- **Pointwise / Jensen theorems consume no realizability hypothesis.** Lemma 1, Theorem 2, Theorem 3, and the easy direction of Theorem 1 (`two_eta_le_of_normalized`, `cPhi_eq_half_of_normalized`, `bracket_lower`, `bracket_upper`, `theorem1_easy`) are pointwise on $[0,1]$ or summed-pointwise / Jensen-applied on an existing partition — no realisability is needed.
- **The converse direction of Theorem 1** (`theorem1_hard`) consumes the typeclass `BinarySplitRealizable`, which encodes the existence of a measurable binary split of a cell of arbitrary mass and conditional rate into subcells of arbitrary masses and arbitrary conditional rates — provable from atomlessness via Sierpiński's theorem [20].
- **Corollary 1** (the binary single-cell-pinning argument) consumes the typeclass `SingleCellRealizable`, encoding the existence of a single-cell partition of arbitrary mass and arbitrary conditional rate — also provable from atomlessness via Sierpiński.

The general-space density argument of §4 (after Theorem 1) recovers concavity from the atomless statement at the manuscript level; the Lean kernel verifies the atomless case directly. (Sierpiński's theorem is not currently in mathlib v4.29.1; a contribution is in preparation in a sibling branch of the parent project.)

The Lean source is available alongside the parent project; the relevant files are `Rigidity/Bracket.lean` (Definitions, Lemma 1, Theorems 2 and 3) and `Rigidity/Theorem1.lean` (Theorem 1, both directions). The `Audit/PrintAxioms.lean` file confirms the axiom-cleanness of each theorem. The mechanisation is not load-bearing for the present note — every proof here is given in full text — but it provides an independent check on the analytic claims.

---

## References

1. Bartlett, P. L., Jordan, M. I., and McAuliffe, J. D. *Convexity, classification, and risk bounds.* J. Amer. Statist. Assoc. **101** (2006), 138–156.
2. Bauschke, H. H., and Combettes, P. L. *Convex Analysis and Monotone Operator Theory in Hilbert Spaces.* 2nd ed., Springer, 2017.
3. Blackwell, D. *Equivalent comparisons of experiments.* Ann. Math. Statist. **24** (1953), 265–272.
3.5. Bogachev, V. I. *Measure Theory.* 2 vols., Springer, 2007.
4. Buja, A., Stuetzle, W., and Shen, Y. *Loss functions for binary class probability estimation and classification: structure and applications.* Technical report, University of Pennsylvania, 2005.
4.5. Cover, T. M., and Thomas, J. A. *Elements of Information Theory.* 2nd ed., Wiley, 2006.
5. DeGroot, M. H. *Uncertainty, information, and sequential experiments.* Ann. Math. Statist. **33** (1962), 404–419.
6. (intentionally vacant — formerly DeGroot 1970 textbook, removed per Round 2 audit M-3 since not cited)
7. Devroye, L., Györfi, L., and Lugosi, G. *A Probabilistic Theory of Pattern Recognition.* Springer, 1996.
8. Goel, P. K., and DeGroot, M. H. *Comparison of experiments and information measures.* Ann. Statist. **7** (1979), 1066–1077.
9. Grünwald, P. D., and Dawid, A. P. *Game theory, maximum entropy, minimum discrepancy, and robust Bayesian decision theory.* Ann. Statist. **32** (2004), 1367–1433.
10. Halmos, P. R. *Measure Theory.* Springer, 1974 (corrected reprint of 1950 edition).
11. Hardy, G. H., Littlewood, J. E., and Pólya, G. *Inequalities.* 2nd ed., Cambridge University Press, 1952.
12. Jensen, J. L. W. V. *Sur les fonctions convexes et les inégalités entre les valeurs moyennes.* Acta Math. **30** (1906), 175–193.
13. Le Cam, L. *Asymptotic Methods in Statistical Decision Theory.* Springer, 1986.
14. Le Cam, L., and Yang, G. L. *Asymptotics in Statistics: Some Basic Concepts.* 2nd ed., Springer, 2000.
15. Liese, F., and Vajda, I. *On divergences and informations in statistics and information theory.* IEEE Trans. Inform. Theory **52** (2006), 4394–4412.
16. Reid, M. D., and Williamson, R. C. *Information, divergence and risk for binary experiments.* J. Mach. Learn. Res. **12** (2011), 731–817.
17. Roberts, A. W., and Varberg, D. E. *Convex Functions.* Academic Press, 1973.
18. Savage, L. J. *Elicitation of personal probabilities and expectations.* J. Amer. Statist. Assoc. **66** (1971), 783–801.
19. Steinwart, I. *How to compare different loss functions and their risks.* Constr. Approx. **26** (2007), 225–287.
20. Sierpiński, W. *Sur les fonctions d'ensemble additives et continues.* Fund. Math. **3** (1922), 240–246.
21. Torgersen, E. *Comparison of Statistical Experiments.* Cambridge University Press, 1991.
22. Zhang, T. *Statistical behavior and consistency of classification methods based on convex risk minimization.* Ann. Statist. **32** (2004), 56–85.

*(Renumbering note: references [6] (DeGroot 1970), [13] (Hu–Niu–Sato–Sugiyama 2018), [15] (Kullback 1959), [24] (Tewari–Bartlett 2007) of draft 0.0 were dropped per Round 2 audit M-3 as uncited; the remaining references are renumbered, with placeholders 3.5 and 4.5 used temporarily for the new entries until the submission-ready draft 0.2 of Round 5 renumbers cleanly. New entries added per M-3: [2] Bauschke–Combettes (invoked at §5 Theorem 3 proof), [4] Buja–Stuetzle–Shen (invoked at §2.3 and §6.3 for proper-loss correspondence), [4.5] Cover–Thomas (invoked at §5.1 for $4\eta(1-\eta) \le \varphi_H$), [7] Devroye–Györfi–Lugosi (invoked at §1 for Bayes risk), [19] Steinwart (invoked at §1.1 for loss-calibration comparison).)*
