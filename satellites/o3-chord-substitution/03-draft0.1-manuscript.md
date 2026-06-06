# The chord substitution closes the continuous Jensen equation

### *A teaching note on three vestigial regularity hypotheses*

*Draft 0.1 (closure of [`02-judge-pi-audit.md`](02-judge-pi-audit.md)) — Executor T. CRAS-format short note, prepared for submission to* Comptes Rendus Mathématique. *Revised 2026-06-06.*

**Changelog from Draft 0.0.** Closes all ten findings from Judge π's Round 2 audit: M-1 (re-wrote §1 paragraph 3 to articulate the $(J_{\mathbb Q}) \Leftrightarrow (J_2)$ equivalence via Cauchy rather than via "iterated bisection"), M-2 (re-wrote §3 closing prose to separate coefficient from argument cleanly), M-3 (dropped Theorem 3, demoted to a one-paragraph remark with Aczél–Dhombres citation), M-4 (Mitigation a — softened §5 framing to "we document one recurrence" rather than "the trap recurs"), m-1 (Corollary 2 re-phrased), m-2 (Aczél–Dhombres and Ostrowski now invoked in body), m-3 (Proposition 4 prose tightened), m-4 (Table 1 per-cell citations added), S-1 (subtitle added), S-2 (abstract opens with prose).

---

**Abstract.** *The continuous-coefficient form of the Jensen functional equation on a real interval — the form in which the coefficient varies over the full continuum $[0,1]$ rather than over a single value such as $\tfrac12$ — shares no Hamel-basis pathology with its discrete-coefficient sibling, and is solved in closed form by a one-line chord substitution. Concretely: for $G:[0,M]\to\mathbb R$ satisfying $pG(u_1)+(1-p)G(u_2)=G(pu_1+(1-p)u_2)$ for all $u_1,u_2\in[0,M]$ and all $p\in[0,1]$, $G$ is affine on $[0,M]$ — with no measurability, boundedness, or continuity hypothesis required. We give the proof, exhibit the explicit affine formula, articulate the dictionary of three classically required regularity hypotheses that become vestigial under the continuous-coefficient form, and document one recurrence of the trap in the surrogate-calibration literature.*

**Keywords:** Jensen equation, Cauchy equation, Hamel basis, functional equation, affine function, chord substitution.

**MSC2020:** 39B22 (functional equations on real intervals); 39B05 (general functional equations); 26A51 (convexity of real functions in one variable).

---

## 1. Introduction

The equation
$$
p\,G(u_1) + (1-p)\,G(u_2) \;=\; G\bigl(p\,u_1 + (1-p)\,u_2\bigr) \qquad (u_1,u_2\in I,\ p\in[0,1]) \tag{$\star$}
$$
on a real interval $I$ has at least three faces in classical analysis, and they have been steadily conflated for over a century.

The **discrete-coefficient** Jensen equation,
$$
G\!\left(\tfrac{u_1+u_2}{2}\right) = \tfrac{G(u_1)+G(u_2)}{2}, \tag{$J_2$}
$$
is the $p=\tfrac12$ specialization of $(\star)$. Setting $f(x) := G(x) - G(0)$, $(J_2)$ is equivalent on a translate of $I$ to Cauchy's additive equation $f(x+y) = f(x)+f(y)$ (cf. Aczél [1, §2.1] or Kuczma [13, Ch. 5]). Cauchy additivity inherits a full pathological-solution apparatus: without measurability, monotonicity, boundedness on a set of positive measure, or another regularity hypothesis, the equation admits non-affine solutions constructed via a Hamel basis [9, 14, 17, 18]. The classical theorems of Cauchy [4], Darboux [5], Hamel [9], Ostrowski [14], Sierpiński [17], and Steinhaus [18] together delineate which regularity hypotheses are enough to recover affineness — *some* hypothesis is genuinely required, otherwise affineness fails.

The **rational-coefficient** Jensen equation,
$$
p\,G(u_1)+(1-p)\,G(u_2)=G(p\,u_1+(1-p)\,u_2) \qquad (u_1,u_2\in I,\ p\in[0,1]\cap\mathbb Q), \tag{$J_{\mathbb Q}$}
$$
sharpens $(J_2)$ but does not escape its pathology: Cauchy additivity yields $\mathbb Q$-homogeneity $f(qx) = qf(x)$ in the standard way ($G(nx)=nG(x)$ by induction, $G(x/n) = G(x)/n$ by substitution, $G(qx)=qG(x)$ for $q\in\mathbb Q$ by combination), and $\mathbb Q$-homogeneity returns $(J_{\mathbb Q})$ for $f$ and hence for $G$. So $(J_{\mathbb Q})$, $(J_2)$, and Cauchy's equation share the same solution class up to constants, and all three inherit the Hamel-basis pathology.

The **continuous-coefficient** form $(\star)$, by contrast, is fundamentally different. It is the subject of this note.

**Result.** Suppose $G:[0,M]\to\mathbb R$ satisfies $(\star)$ for all $u_1,u_2\in[0,M]$ and all $p\in[0,1]$. Then $G$ is affine on $[0,M]$:
$$
G(v) = a\,v + b, \qquad a = \frac{G(M)-G(0)}{M},\quad b=G(0).
$$
The proof is a single substitution: set $u_1=M$, $u_2=0$, $p=v/M$ in $(\star)$. No regularity hypothesis on $G$ is used.

This is folklore — at minimum Aczél [1, §2.1] and Kuczma [13, Ch. 13] articulate the underlying observation, and the result is standard in the functional-equations community. Nonetheless, an enduring confusion persists in applied work that encounters $(\star)$ outside the functional-equations literature: authors reach reflexively for the Cauchy-equation regularity machinery — continuity, boundedness, measurability — none of which the proof of affineness actually consumes. The present note is a teaching-and-citation note: we exhibit the proof and the dictionary of which hypotheses are vestigial for $(\star)$, and provide a one-line citation point for authors who encounter the equation in their own work and wish to retire the Hamel concern without re-deriving it.

The structure is as follows. Section 2 gives the theorem and its proof. Section 3 is the dictionary of three regularity hypotheses that are *not* needed, each with the corresponding pathology for $(J_2)$ that fails to arise for $(\star)$. Section 4 collects variants — the weakest hypothesis the proof actually consumes; the higher-dimensional remark; the contrast with $(J_{\mathbb Q})$. Section 5 documents one recurrence of the trap in the surrogate-calibration literature.

---

## 2. The result

**Theorem 1.** *Let $M>0$ and let $G:[0,M]\to\mathbb R$ satisfy $(\star)$ for all $u_1,u_2\in[0,M]$ and all $p\in[0,1]$. Then*
$$
G(v) \;=\; \frac{G(M)-G(0)}{M}\,v \;+\; G(0) \qquad \text{for all } v\in[0,M].
$$
*No measurability, boundedness, or continuity hypothesis on $G$ is required.*

**Proof.** Fix $v\in[0,M]$. Setting $u_1=M$, $u_2=0$, $p=v/M\in[0,1]$ in $(\star)$,
$$
\frac{v}{M}\,G(M) + \left(1-\frac{v}{M}\right)G(0) \;=\; G\!\left(\frac{v}{M}\cdot M + \left(1-\frac{v}{M}\right)\cdot 0\right) \;=\; G(v).
$$
Rearranging, $G(v) = G(0) + \dfrac{G(M)-G(0)}{M}\,v$. $\square$

**Corollary 2.** *Under the hypotheses of Theorem 1, $G$ is continuous and weakly monotone on $[0,M]$; in particular it is locally Lipschitz, absolutely continuous, and measurable.*

**Proof.** Affine functions are all of the above. $\square$

The order of inference matters and is worth stating explicitly: the *conclusion* of Theorem 1 is that $G$ has every regularity property one might have wished to *assume*. Each of those properties is therefore vestigial as a hypothesis — see §3 below.

---

## 3. The dictionary

Set side-by-side the discrete-coefficient equation $(J_2)$ and the continuous-coefficient equation $(\star)$. The first two columns of Table 1 record which regularity hypotheses on $G$ have been classically required to rule out pathological solutions of $(J_2)$, with the standard attributions. The third column records what becomes of those hypotheses under $(\star)$.

| Hypothesis on $G$ | Required for $(J_2)\Rightarrow$ affine? | Required for $(\star)\Rightarrow$ affine? |
|---|---|---|
| Continuity on $I$ | yes, suffices (Cauchy [4]) | **no** — affineness is the *conclusion*, not the hypothesis |
| Measurability on $I$ | yes, suffices (Sierpiński [17]) | **no** — same |
| Monotonicity on $I$ | yes, suffices (Darboux [5]) | **no** — same |
| Boundedness on a set of positive measure | yes, suffices (Steinhaus [18]; cf. Sierpiński [17]) | **no** — same |
| Boundedness on $I$ | suffices (special case of Steinhaus [18]; Ostrowski [14]) | **no** — same |
| **None** | **insufficient — Hamel-basis pathology** (Hamel [9]) | **suffices** — Theorem 1 |

**Table 1.** *Regularity hypotheses on $G$. Column 2 records which hypotheses are classically required to force affineness for the discrete-coefficient equation $(J_2)$. Column 3 records what they become under the continuous-coefficient equation $(\star)$.*

The point of the table is the bottom row. **No regularity hypothesis** is enough for the discrete-coefficient equation: a non-affine, non-measurable, unbounded, additive function on $\mathbb R$ — the classical Hamel-basis pathology of [9] — supplies a non-affine solution of $(J_2)$. By contrast, **no regularity hypothesis** is *needed* for the continuous-coefficient equation: Theorem 1's chord substitution closes the proof at the level of the bare functional equation.

The mechanism is straightforward. A Hamel-basis pathological solution $G$ of Cauchy's equation on $\mathbb R$ is $\mathbb Q$-linear: $G(0) = 0$ and $G(qx) = q\,G(x)$ for every $q\in\mathbb Q$ and $x\in\mathbb R$. It is, by construction, *not* $\mathbb R$-linear — $G(rx) \neq r\,G(x)$ for some irrational $r$ and some $x\in\mathbb R$.

The chord identity at the configuration $u_1=M$, $u_2=0$ reads
$$
p\,G(M) + (1-p)\,G(0) \;=\; G(p\,M). \tag{$\star_0$}
$$
For $G$ a Hamel-pathological additive function $(G(0) = 0)$, $(\star_0)$ is the assertion $p\,G(M) = G(p\,M)$ — which holds at $p\in\mathbb Q$ (by $\mathbb Q$-linearity) but fails at the irrational $p$ where $\mathbb R$-linearity is broken. So $G$ satisfies $(J_{\mathbb Q})$ on $[0,M]$ but violates $(\star)$ at *every* irrational $p\in(0,1)$ where the $\mathbb R$-linearity defect appears. The continuous-coefficient equation $(\star)$ rules the pathology out at exactly the points $p\in[0,1]\setminus\mathbb Q$ where the discrete- and rational-coefficient versions are silent. **The Hamel pathology lives at irrational $p$ — exactly where $(\star)$'s continuous coefficient closes the door.**

---

## 4. Variants and limits

### 4.1 The weakest hypothesis the proof consumes

The proof of Theorem 1 uses $(\star)$ at exactly one configuration: $u_1=M$, $u_2=0$, with $p\in[0,1]$ ranging freely. The full force of $(\star)$ — for *every* pair $(u_1,u_2)$ — is not consumed. We therefore record the strict minimum:

**Theorem 1$'$.** *Let $M>0$ and let $G:[0,M]\to\mathbb R$ satisfy*
$$
p\,G(M) + (1-p)\,G(0) \;=\; G(pM) \qquad \text{for all } p\in[0,1]. \tag{$\star_0$}
$$
*Then $G(v) = G(0) + \bigl(G(M)-G(0)\bigr) v/M$ on $[0,M]$.*

The proof is verbatim that of Theorem 1: set $p=v/M$. Theorem 1$'$ is in principle weaker than Theorem 1 — the hypothesis $(\star_0)$ does not a priori imply the full $(\star)$; under the conclusion (affineness) both hold. In practice an author who *derives* $(\star)$ from a richer setup (e.g., from a Jensen-equality identity in a Bayes-risk computation, see §5) typically has $(\star)$ for all $(u_1,u_2,p)$. The narrower Theorem 1$'$ is the right reference for an author who wants to know how much of the equation the proof actually consumes.

### 4.2 Convex domains in higher dimensions (remark)

The chord substitution extends verbatim to any convex subset $C$ of a real vector space $V$: applying Theorem 1 along every chord shows that $G$ restricted to each segment of $C$ is affine in the segment parameter, and a standard inductive argument (cf. Aczél–Dhombres [2, Ch. 13]) lifts chord-affineness to convex-combination linearity on $C$, hence to an affine form $G(x) = a(x)+b$ for a linear $a$ on $\mathrm{span}(C-C)$ and a constant $b\in\mathbb R$. The structurally essential 1D step is Theorem 1.

### 4.3 The rational-coefficient version $(J_{\mathbb Q})$ does retain the pathology

The contrast across $\mathbb Q$ vs $\mathbb R$ is worth marking explicitly:

**Proposition 4 (folklore).** *There exists $G:[0,1]\to\mathbb R$ satisfying $(J_{\mathbb Q})$ (and hence $(J_2)$) on $[0,1]$ that is not affine.*

**Construction.** Choose a Hamel basis $H$ of $\mathbb R$ over $\mathbb Q$ containing $1$. Define a $\mathbb Q$-linear $\ell:\mathbb R\to\mathbb R$ by $\ell(1)=0$ and $\ell(h)=1$ for some basis element $h\ne 1$ (and arbitrarily on the remaining basis elements). Then $\ell$ is additive and $\mathbb Q$-homogeneous on $\mathbb R$ (so satisfies Cauchy's equation), but is not $\mathbb R$-linear: $\ell(q\cdot 1)=0$ for every $q\in\mathbb Q$ while $\ell(h)=1\ne 0$. Its restriction $G := \ell|_{[0,1]}$ satisfies $(J_{\mathbb Q})$ on $[0,1]$ (Cauchy additivity restricts to convex combinations with rational weights on intervals) yet $G$ is not affine on $[0,1]$ — for example $G(1) = 0$ while $G(q)=0$ for every rational $q\in[0,1]$, but $G$ takes a nonzero value at $h - n$ for some integer $n$ such that $h-n\in[0,1]$. $\square$

Proposition 4 sharpens Theorem 1's "no regularity hypothesis needed" by exhibiting that the strengthening from rational to continuous coefficients in $(\star)$ is doing real work. Without it (i.e., for $(J_{\mathbb Q})$), regularity hypotheses are genuinely required; with it, they are vestigial.

---

## 5. Where the trap recurs

The chord substitution is — as we have noted — folklore. The regularity hypotheses it makes vestigial nonetheless reappear in applied work that derives $(\star)$ outside the functional-equations community. We document *one* such recurrence below — in our own work on the achievable error floor of partition-based classifiers — and articulate the *structural source* under which the recurrence is predictable in any sufficiently rich calibration-theory derivation. We invite extensions of the catalog from readers who encounter $(\star)$ in their own work.

### 5.1 One recurrence: surrogate calibration on the resolution axis

In a recent line of work on the achievable error floor of partition-based classifiers [El1, El2], the equation $(\star)$ arises in the rigidity proof for the Bayes risk: for $G:[0,\varphi_{\max}]\to\mathbb R$ defined as the unique function expressing the Bayes risk as a function of an aggregated score, a two-cell-partition computation forces $(\star)$ with $u_1,u_2$ the cell-conditional score values and $p$ the cell mass — and $p$ ranges freely over $[0,1]$ on an atomless underlying probability space. The Phase D mechanization (Lean 4) of [El2] produced the lemma `affine_of_jensen_eq` initially with a boundedness hypothesis in its signature, in deference to the Cauchy/Hamel literature; the proof body then exhibited that the hypothesis was unused, by the chord substitution. The earlier drafts of the main text correspondingly invoked an apologetic *"$G$ is bounded so the bounded-Jensen-implies-affine theorem applies"* parenthetical — a parenthetical the present note's Theorem 1 retires.

### 5.2 The structural source — why the trap is predictable to recur

The recurrence in §5.1 is not idiosyncratic. The structural source is the following: whenever a calibration-theory argument arrives at an identity of the form
$$
\mathbb E[g(\xi)] = g(\mathbb E[\xi]) \qquad (\xi \text{ a random variable taking values in } I,\ g:I\to\mathbb R),
$$
*for a class of random variables $\xi$ wide enough that the marginal $\mathbb E[\xi]$ can be any point of $I$ and the support of $\xi$ can be any two-point subset of $I$ with any pair of masses* $(p,1-p)$ *with* $p\in[0,1]$, the identity is exactly $(\star)$ with $g=G$, $\xi$ supported on $\{u_1,u_2\}$ with masses $\{p,1-p\}$. Calibration-theory arguments typically derive such identities from a *Jensen equality* — Jensen's inequality saturates, i.e., equality is achieved in $\mathbb E[g(\xi)] \le g(\mathbb E[\xi])$ for concave $g$ with all the wiggle room exhausted. The classical Cauchy/Hamel apparatus does not apply because the equation holds for the continuous-coefficient version, not merely the rational-coefficient version.

Authors who derive $(\star)$ in this way and then invoke a boundedness or measurability hypothesis on $g$ to get affineness are paying a hypothesis cost the equation does not charge. Theorem 1 supplies the citation that retires the cost.

### 5.3 An invitation to extend

We invite readers who have encountered $(\star)$ in their own work and have invoked a vestigial regularity hypothesis to extend the catalog with a one-line citation back to the relevant proof step in their paper.

---

## References

[1] J. Aczél. *Lectures on Functional Equations and Their Applications*. Academic Press, New York, 1966.

[2] J. Aczél, J. Dhombres. *Functional Equations in Several Variables*. Encyclopedia of Mathematics and its Applications, vol. 31, Cambridge University Press, 1989.

[3] R. P. Boas. *A Primer of Real Functions*. 3rd ed., Carus Mathematical Monographs 13, Mathematical Association of America, 1981.

[4] A. L. Cauchy. *Cours d'analyse de l'École royale polytechnique. Première partie: Analyse algébrique*. Imprimerie royale, Paris, 1821.

[5] G. Darboux. Mémoire sur les fonctions discontinues. *Annales scientifiques de l'École normale supérieure*, ser. 2, 4:57–112, 1875.

[El1] [Author]. (in preparation, 2026). Companion of [El2].

[El2] [Author]. The achievable-error floor of graph neural networks — calibration at the resolution level. Manuscript in preparation, 2026.

[9] G. Hamel. Eine Basis aller Zahlen und die unstetigen Lösungen der Funktionalgleichung $f(x+y)=f(x)+f(y)$. *Mathematische Annalen*, 60:459–462, 1905.

[13] M. Kuczma. *An Introduction to the Theory of Functional Equations and Inequalities. Cauchy's Equation and Jensen's Inequality*. 2nd ed., edited by A. Gilányi. Birkhäuser, Basel, 2009.

[14] A. M. Ostrowski. Über die Funktionalgleichung der Exponentialfunktion und verwandte Funktionalgleichungen. *Jahresbericht der Deutschen Mathematiker-Vereinigung*, 38:54–62, 1929.

[17] W. Sierpiński. Sur les fonctions convexes mesurables. *Fundamenta Mathematicae*, 1:125–129, 1920.

[18] H. Steinhaus. Sur les distances des points dans les ensembles de mesure positive. *Fundamenta Mathematicae*, 1:93–104, 1920.

---

*Manuscript prepared in CRAS short-note format. Bilingual French/English accepted; submitted in English.*
