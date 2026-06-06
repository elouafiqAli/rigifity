# The chord substitution closes the continuous Jensen equation

*Draft 0.0 (skeleton) — Executor T. CRAS-format short note, prepared for submission to* Comptes Rendus Mathématique. *Authored 2026-06-06.*

---

**Abstract.** *The functional equation $pG(u_1)+(1-p)G(u_2)=G(pu_1+(1-p)u_2)$, imposed on a function $G:[0,M]\to\mathbb R$ for all $u_1,u_2\in[0,M]$ and all $p\in[0,1]$, forces $G$ affine — by a one-line substitution that pins $G$ along the chord through the endpoints. No measurability, no boundedness, and no continuity hypothesis is required. We give the proof, exhibit the explicit affine formula, and articulate the dictionary of three regularity hypotheses that the literature commonly invokes for this equation but which are in fact vestigial — historical artefacts of the discrete-coefficient version of the equation, where the corresponding Cauchy-equation pathologies do arise. We close with a short list of recurring instances in the applied calibration-theory literature where the trap has been invoked unnecessarily, and a one-line citation point such authors can use to retire the Hamel concern.*

**Keywords:** Jensen equation, Cauchy equation, Hamel basis, functional equation, affine function, chord substitution.

**MSC2020:** 39B22 (functional equations on real intervals); 39B05 (general functional equations); 26A51 (convex functions).

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
is the $p=\tfrac12$ specialization of $(\star)$. It is equivalent — under mild regularity — to Cauchy's functional equation $G(x+y)=G(x)+G(y)$, and inherits Cauchy's full pathological-solution apparatus: without measurability, monotonicity, boundedness on a set of positive measure, or another regularity hypothesis, $(J_2)$ admits non-affine solutions constructed via a Hamel basis [9, 14, 17]. The classical theorems of Cauchy [4], Hamel [9], Sierpiński [17], and Steinhaus [18] together delineate which regularity hypotheses are enough to recover affineness. *Some* hypothesis is genuinely required; otherwise affineness fails.

The **rational-coefficient** Jensen equation,
$$
p\,G(u_1)+(1-p)\,G(u_2)=G(p\,u_1+(1-p)\,u_2) \qquad (u_1,u_2\in I,\ p\in[0,1]\cap\mathbb Q), \tag{$J_{\mathbb Q}$}
$$
adds nothing — it is equivalent to $(J_2)$ by iterated bisection — and inherits the same pathology.

The **continuous-coefficient** form $(\star)$, by contrast, is fundamentally different. It is the subject of this note.

**Result.** Suppose $G:[0,M]\to\mathbb R$ satisfies $(\star)$ for all $u_1,u_2\in[0,M]$ and all $p\in[0,1]$. Then $G$ is affine on $[0,M]$:
$$
G(v) = a\,v + b, \qquad a = \frac{G(M)-G(0)}{M},\quad b=G(0).
$$
The proof is a single substitution: set $u_1=M$, $u_2=0$, $p=v/M$ in $(\star)$. No regularity hypothesis on $G$ is used.

This is folklore — at minimum Aczél [1, §2.1] and Kuczma [13, Ch. 13] articulate the underlying observation, and the result is standard in the functional-equations community. Nonetheless, an enduring confusion persists in applied work that encounters $(\star)$ outside the functional-equations literature: authors reach reflexively for the Cauchy-equation regularity machinery — continuity, boundedness, measurability — none of which the proof of affineness actually consumes. The present note is a teaching-and-citation note: we exhibit the proof and the dictionary of which hypotheses are vestigial for $(\star)$, and provide a one-line CRAS-citable pointer for authors who encounter the equation in their own work and wish to retire the Hamel concern without re-deriving it.

The structure is as follows. Section 2 gives the theorem and its proof. Section 3 is the dictionary of three regularity hypotheses that are *not* needed, each with the corresponding pathology for $(J_2)$ that fails to arise for $(\star)$. Section 4 collects variants — the weakest hypothesis the proof actually consumes; the higher-dimensional generalization; the contrast with $(J_{\mathbb Q})$. Section 5 documents recurring instances in the surrogate-calibration literature where the trap has been invoked unnecessarily.

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

**Corollary 2 (affineness of every point).** *Under the hypotheses of Theorem 1, $G$ is continuous, monotone, and (in particular) measurable on $[0,M]$.*

**Proof.** Affine functions are all three. $\square$

The order of inference matters and is worth stating explicitly: the *conclusion* of Theorem 1 is that $G$ has every regularity property one might have wished to *assume*. Each of those properties is therefore vestigial as a hypothesis — see §3 below.

---

## 3. The dictionary

Set side-by-side the discrete-coefficient equation $(J_2)$ and the continuous-coefficient equation $(\star)$. The first two columns of Table 1 record which regularity hypotheses on $G$ have been classically required to rule out pathological solutions of $(J_2)$. The third column records what becomes of those hypotheses under $(\star)$.

| Hypothesis on $G$ | Required for $(J_2)\Rightarrow$ affine? | Required for $(\star)\Rightarrow$ affine? |
|---|---|---|
| Continuity on $I$ | yes (Cauchy [4]) | **no** — affineness is the *conclusion*, not the hypothesis |
| Measurability on $I$ | yes, suffices (Sierpiński [17]) | **no** — same |
| Monotonicity on $I$ | yes, suffices (Darboux) | **no** — same |
| Boundedness on a set of positive measure | yes, suffices (Steinhaus [18]) | **no** — same |
| Boundedness on $I$ | suffices (special case of Steinhaus) | **no** — same |
| **None** | **insufficient — Hamel-basis pathology** [9] | **suffices** — Theorem 1 |

**Table 1.** *Regularity hypotheses on $G$. Column 2 records which hypotheses are classically required to force affineness for the discrete-coefficient equation $(J_2)$. Column 3 records what they become under the continuous-coefficient equation $(\star)$.*

The point of the table is the bottom row. **No regularity hypothesis** is enough for the discrete-coefficient equation: a non-affine, non-measurable, unbounded, additive function on $\mathbb R$ — the classical Hamel-basis pathology of [9] — supplies a non-affine solution of $(J_2)$. By contrast, **no regularity hypothesis** is *needed* for the continuous-coefficient equation: Theorem 1's chord substitution closes the proof at the level of the bare functional equation.

The mechanism is straightforward. Hamel-basis pathological solutions of Cauchy's equation are $\mathbb Q$-linear but not $\mathbb R$-linear: they satisfy $G(qx)=qG(x)$ for every rational $q$ and fail it for irrational $q$. The equation $(\star)$ requires the identity to hold for every $p\in[0,1]$, including irrational $p$ such as $p=v/M$ when $v\in[0,M]$ is irrational. The pathological solutions cannot deliver that.

A complementary observation: $(\star)$ for *all* $p\in[0,1]\cap\mathbb R$ is genuinely a stronger functional equation than $(J_2)$, $(J_{\mathbb Q})$, or Cauchy. The strengthening — from a single (or rational) coefficient to a continuum of coefficients — is exactly the strengthening that the chord substitution converts into pointwise affineness.

---

## 4. Variants and limits

### 4.1 The weakest hypothesis the proof consumes

The proof of Theorem 1 uses $(\star)$ at exactly one configuration: $u_1=M$, $u_2=0$, and $p\in[0,1]$ ranging freely. The full force of $(\star)$ — for *every* pair $(u_1,u_2)$ — is not consumed. We therefore record the strict minimum:

**Theorem 1$'$.** *Let $M>0$ and let $G:[0,M]\to\mathbb R$ satisfy*
$$
p\,G(M) + (1-p)\,G(0) \;=\; G(pM) \qquad \text{for all } p\in[0,1]. \tag{$\star_0$}
$$
*Then $G(v) = G(0) + \bigl(G(M)-G(0)\bigr) v/M$ on $[0,M]$.*

The proof is verbatim that of Theorem 1, set $p=v/M$. Theorem 1$'$ is in principle weaker than Theorem 1 — the hypothesis $(\star_0)$ does not imply the full $(\star)$ a priori; under the conclusion (affineness) both hold. In practice an author who *derives* $(\star)$ from a richer setup (e.g., from a Jensen-equality identity in a Bayes-risk computation, see §5) typically has $(\star)$ for all $(u_1,u_2,p)$. The narrower Theorem 1$'$ is the right reference for an author who wants to know how much of the equation the proof actually consumes.

### 4.2 Convex domains in higher dimensions

The same substitution closes the equation on every convex domain.

**Theorem 3.** *Let $V$ be a real vector space, let $C\subseteq V$ be convex, and let $G:C\to\mathbb R$ satisfy*
$$
p\,G(x_1)+(1-p)\,G(x_2) \;=\; G\bigl(p\,x_1+(1-p)\,x_2\bigr) \qquad (x_1,x_2\in C,\ p\in[0,1]).
$$
*Then $G$ is affine on $C$: there exist a linear functional $a:V\to\mathbb R$ (defined on $\mathrm{span}(C-C)$) and a constant $b\in\mathbb R$ such that $G(x)=a(x)+b$ on $C$.*

**Proof sketch.** Fix $x_0\in C$. For each direction $v$ with $x_0+v\in C$, Theorem 1 applied to the segment $\{x_0+\lambda v:\lambda\in[0,1]\}$ shows $\lambda\mapsto G(x_0+\lambda v)$ is affine in $\lambda$, hence $G(x_0+v)-G(x_0)$ depends linearly on the parameter at $v$. Applying $(\star)$ in a 2D affine span of three points shows additivity of the increments. Hence $a(v):=G(x_0+v)-G(x_0)$ extends to a linear functional on $\mathrm{span}(C-C)$, and $G(x)=a(x-x_0)+G(x_0)$. $\square$

In dimension $\ge 2$ the chord substitution does the heavy lifting (affineness on every chord); the bookkeeping turns chord-affineness into joint affineness. The 1D case (Theorem 1) is the structurally essential one.

### 4.3 The rational-coefficient version $(J_{\mathbb Q})$ does retain the pathology

The contrast across $\mathbb Q$ vs $\mathbb R$ is worth marking explicitly:

**Proposition 4 (folklore).** *There exists $G:[0,1]\to\mathbb R$ satisfying $(J_{\mathbb Q})$ (and hence $(J_2)$) on $[0,1]$ that is not affine.*

**Construction.** Extend $\mathbb Q$ to a Hamel basis $H$ of $\mathbb R$ over $\mathbb Q$; pick a $\mathbb Q$-linear functional $\ell:\mathbb R\to\mathbb R$ that is not $\mathbb R$-linear (set $\ell(1)=0$ and $\ell(h)=1$ for some irrational basis element $h$, say); restrict to $[0,1]$. The restriction is $\mathbb Q$-affine on $[0,1]$ but not $\mathbb R$-affine. $\square$

Proposition 4 sharpens Theorem 1's "no regularity hypothesis needed" by exhibiting that the strengthening from rational to continuous coefficients in $(\star)$ is doing real work. Without it (i.e., for $(J_{\mathbb Q})$), regularity hypotheses are genuinely required; with it, they are vestigial.

---

## 5. Where the trap recurs

The chord substitution is — as we have noted — folklore. Yet $(\star)$ continues to surface in applied work outside the functional-equations community, and is reflexively treated as if it were $(J_2)$. We collect a small recurrence catalog, biased to our own recent experience, and invite extensions.

### 5.1 Surrogate calibration on the resolution axis

In a recent line of work on the achievable error floor of partition-based classifiers [El1, El2], the equation $(\star)$ arises in the rigidity proof for the Bayes risk: for $G:[0,\varphi_{\max}]\to\mathbb R$ defined as the unique function expressing the Bayes risk as a function of an aggregated score, a two-cell-partition computation forces $(\star)$ with $u_1,u_2$ the cell-conditional score values and $p$ the cell mass — and $p$ ranges freely over $[0,1]$ on an atomless underlying probability space. The Phase D mechanization (Lean 4) of [El2] produced the lemma `affine_of_jensen_eq` initially with a boundedness hypothesis in its signature, in deference to the Cauchy/Hamel literature; the proof body then exhibited that the hypothesis was unused, by the chord substitution. The earlier drafts of the main text correspondingly invoked an apologetic *"$G$ is bounded so the bounded-Jensen-implies-affine theorem applies"* parenthetical — a parenthetical the present note's Theorem 1 retires.

### 5.2 The general pattern in calibration theory

The structural source of the recurrence is the following: whenever a calibration-theory argument arrives at an identity of the form
$$
\mathbb E[g(\xi)] = g(\mathbb E[\xi]) \qquad (\xi \text{ a random variable taking values in } I,\ g:I\to\mathbb R),
$$
*for a class of random variables $\xi$ wide enough that the marginal $\mathbb E[\xi]$ can be any point of $I$ and the support of $\xi$ can be any two-point subset of $I$*, the identity is exactly $(\star)$ with $g=G$, $\xi$ supported on $\{u_1,u_2\}$ with masses $\{p,1-p\}$. Calibration-theory arguments typically derive such identities from a "Jensen equality" — *Jensen's inequality saturates*, i.e., the achievability of equality in $\mathbb E[g(\xi)]\le g(\mathbb E[\xi])$ for concave $g$, with all the wiggle room exhausted. The classical Cauchy/Hamel apparatus does not apply because the equation holds for the continuous-coefficient version, not merely the rational-coefficient version.

Authors who derive $(\star)$ in this way and then invoke a boundedness or measurability hypothesis on $g$ to get affineness are paying a hypothesis cost the equation does not charge. Theorem 1 supplies the citation that retires the cost.

### 5.3 An invitation to extend

The catalog above is partial. Readers who have encountered $(\star)$ in their own work and have invoked a vestigial regularity hypothesis are invited to extend the catalog, ideally with a one-line citation back to the relevant proof step in their paper.

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
