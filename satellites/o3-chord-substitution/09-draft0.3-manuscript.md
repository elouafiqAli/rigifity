# The chord substitution closes the continuous Jensen equation

### *A teaching note on three vestigial regularity hypotheses*

*Draft 0.3 (CRAS-ready, English) — Executor T. Closes all ten findings of [`08-judge-pi-rigor-audit.md`](08-judge-pi-rigor-audit.md): M-a (Hamel basis defined on first mention + Proposition 4 witness spelled out), M-b (§V rewritten for the wide-mathematician audience), M-c (Table 1 expanded to three columns), m-a (affine defined on first use), m-b (Corollary 2 simplified), m-d (MSC2020 reduced to 39B22 + 39B05), S-a (placeholder citations resolved), S-b (Roman top-level section numbers), plus G-7 (Declaration of interests) and G-8 (MSC). Submitted 2026-06-06.*

**Audit chain (full).** Round 0 extraction ([`00-extraction-and-context.md`](00-extraction-and-context.md)); Round 1 skeleton ([`01-draft0.0-manuscript.md`](01-draft0.0-manuscript.md)); Round 2 Judge π audit ([`02-judge-pi-audit.md`](02-judge-pi-audit.md), 4 [Material] + 4 [Minor] + 2 [Strategic] findings); Round 3 closure ([`03-draft0.1-manuscript.md`](03-draft0.1-manuscript.md)); Round 4 Judge S audit ([`04-judge-s-prior-art-audit.md`](04-judge-s-prior-art-audit.md), 2 [Minor] strengthenings); Round 5 closure ([`05-draft0.2-manuscript.md`](05-draft0.2-manuscript.md)); Phase A strategy ([`06-cras-strategy.md`](06-cras-strategy.md)); Phase B reconnaissance ([`07-cras-format-reconnaissance.md`](07-cras-format-reconnaissance.md)); Phase C Judge π rigor audit ([`08-judge-pi-rigor-audit.md`](08-judge-pi-rigor-audit.md)); Phase D this draft.

---

**Abstract.** *The continuous-coefficient form of the Jensen functional equation on a real interval — the form in which the coefficient varies over the full continuum $[0,1]$ rather than over a single value such as $\tfrac12$ — shares no Hamel-basis pathology with its discrete-coefficient sibling, and is solved in closed form by a one-line chord substitution. Concretely: for $G:[0,M]\to\mathbb R$ satisfying $pG(u_1)+(1-p)G(u_2)=G(pu_1+(1-p)u_2)$ for all $u_1,u_2\in[0,M]$ and all $p\in[0,1]$, $G$ is affine on $[0,M]$ — meaning $G(v)=av+b$ for some $a,b\in\mathbb R$ — with no measurability, boundedness, or continuity hypothesis on $G$. We give the proof, exhibit the explicit affine formula, articulate the dictionary of three classically required regularity hypotheses that become vestigial under the continuous-coefficient form, and document one recurrence of the trap in the surrogate-calibration literature together with the structural reason the trap is predictable to recur in any derivation that saturates Jensen's inequality across a wide class of two-point distributions.*

**Keywords.** Jensen equation; Cauchy equation; Hamel basis; functional equation; affine function; chord substitution.

**MSC 2020.** 39B22 (Functional equations on real intervals); 39B05 (General theory of functional equations).

---

## I. Introduction

The equation
$$
p\,G(u_1) + (1-p)\,G(u_2) \;=\; G\bigl(p\,u_1 + (1-p)\,u_2\bigr) \qquad (u_1,u_2\in I,\ p\in[0,1]) \tag{$\star$}
$$
on a real interval $I$ — where $G:I\to\mathbb R$ is the unknown and $u_1, u_2, p$ are the arguments and coefficient — has at least three faces in classical analysis, and they have been steadily conflated for over a century.

The **discrete-coefficient** Jensen equation,
$$
G\!\left(\tfrac{u_1+u_2}{2}\right) = \tfrac{G(u_1)+G(u_2)}{2}, \tag{$J_2$}
$$
is the $p=\tfrac12$ specialization of $(\star)$. Setting $f(x) := G(x) - G(0)$, $(J_2)$ is equivalent on a translate of $I$ to Cauchy's additive equation $f(x+y) = f(x)+f(y)$ (cf. Aczél [1, §2.1] or Kuczma [9, Ch. 5]). Cauchy additivity inherits a full pathological-solution apparatus: without measurability, monotonicity, boundedness on a set of positive measure, or another regularity hypothesis, the equation admits non-affine solutions constructed via a **Hamel basis** — i.e., a $\mathbb Q$-vector-space basis of $\mathbb R$, whose existence requires the axiom of choice — see Hamel [7]. The classical theorems of Cauchy [4], Darboux [5], Hamel [7], Ostrowski [10], Sierpiński [13], and Steinhaus [14] together delineate which regularity hypotheses are enough to recover affineness — *some* hypothesis is genuinely required, otherwise affineness fails.

The **rational-coefficient** Jensen equation,
$$
p\,G(u_1)+(1-p)\,G(u_2)=G(p\,u_1+(1-p)\,u_2) \qquad (u_1,u_2\in I,\ p\in[0,1]\cap\mathbb Q), \tag{$J_{\mathbb Q}$}
$$
sharpens $(J_2)$ but does not escape its pathology: Cauchy additivity yields $\mathbb Q$-homogeneity $f(qx) = qf(x)$ in the standard way ($G(nx)=nG(x)$ by induction, $G(x/n) = G(x)/n$ by substitution, $G(qx)=qG(x)$ for $q\in\mathbb Q$ by combination), and $\mathbb Q$-homogeneity returns $(J_{\mathbb Q})$ for $f$ and hence for $G$. So $(J_{\mathbb Q})$, $(J_2)$, and Cauchy's equation share the same solution class up to constants, and all three inherit the Hamel-basis pathology.

The **continuous-coefficient** form $(\star)$, by contrast, is fundamentally different. It is the subject of this note.

**Result.** Suppose $G:[0,M]\to\mathbb R$ satisfies $(\star)$ for all $u_1,u_2\in[0,M]$ and all $p\in[0,1]$. Then $G$ is affine on $[0,M]$ — i.e., of the form $G(v)=av+b$ with $a,b\in\mathbb R$ — explicitly,
$$
G(v) = a\,v + b, \qquad a = \frac{G(M)-G(0)}{M},\quad b=G(0).
$$
The proof is a single substitution: set $u_1=M$, $u_2=0$, $p=v/M$ in $(\star)$. No regularity hypothesis on $G$ is used.

This is folklore — at minimum Aczél [1, §2.1] and Kuczma [9, Ch. 13] articulate the underlying observation, and the result is standard in the functional-equations community. Nonetheless, an enduring confusion persists in applied work that encounters $(\star)$ outside the functional-equations literature: authors reach reflexively for the Cauchy-equation regularity machinery — continuity, boundedness, measurability — none of which the proof of affineness actually consumes. The present note is a teaching-and-citation note: we exhibit the proof and the dictionary of which hypotheses are vestigial for $(\star)$, and provide a one-line citation point for authors who encounter the equation in their own work and wish to retire the Hamel concern without re-deriving it.

The structure is as follows. Section II gives the theorem and its proof. Section III is the dictionary of three regularity hypotheses that are *not* needed, each with the corresponding pathology for $(J_2)$ that fails to arise for $(\star)$. Section IV collects variants — the weakest hypothesis the proof actually consumes; the higher-dimensional remark; the contrast with $(J_{\mathbb Q})$. Section V documents one recurrence of the trap in the surrogate-calibration literature, together with the structural reason the trap is predictable to recur in any derivation that pushes Jensen's inequality to saturation.

---

## II. The result

**Theorem 1.** *Let $M>0$ and let $G:[0,M]\to\mathbb R$ satisfy $(\star)$ for all $u_1,u_2\in[0,M]$ and all $p\in[0,1]$. Then $G$ is affine on $[0,M]$:*
$$
G(v) \;=\; \frac{G(M)-G(0)}{M}\,v \;+\; G(0) \qquad \text{for all } v\in[0,M].
$$
*No measurability, boundedness, or continuity hypothesis on $G$ is required.*

**Proof.** Fix $v\in[0,M]$. Setting $u_1=M$, $u_2=0$, $p=v/M\in[0,1]$ in $(\star)$,
$$
\frac{v}{M}\,G(M) + \left(1-\frac{v}{M}\right)G(0) \;=\; G\!\left(\frac{v}{M}\cdot M + \left(1-\frac{v}{M}\right)\cdot 0\right) \;=\; G(v).
$$
Rearranging, $G(v) = G(0) + \dfrac{G(M)-G(0)}{M}\,v$. $\square$

**Corollary 2.** *Under the hypotheses of Theorem 1, $G$ is in particular continuous, monotone, locally Lipschitz, absolutely continuous, and measurable on $[0, M]$.*

**Proof.** Affine functions are all of the above. $\square$

The order of inference matters and is worth stating explicitly: the *conclusion* of Theorem 1 is that $G$ has every regularity property one might have wished to *assume*. Each of those properties is therefore vestigial as a hypothesis — see Section III.

---

## III. The dictionary

Set side-by-side the discrete-coefficient equation $(J_2)$ and the continuous-coefficient equation $(\star)$. The first column of Table 1 names a regularity hypothesis that has been classically invoked for $(J_2)$ and gives a one-sentence definition; the second column records whether the hypothesis is required to force affineness for $(J_2)$, with the standard attribution; the third column records what becomes of the hypothesis under $(\star)$.

| **Hypothesis on $G$ (definition)** | **Required for $(J_2)\Rightarrow$ affine?** | **Required for $(\star)\Rightarrow$ affine?** |
|---|---|---|
| **Continuity on $I$** ($G$ is continuous at every $v\in I$). | Yes, suffices (Cauchy [4]). | **No** — affineness is the *conclusion*, not the hypothesis. |
| **Measurability on $I$** ($G$ is Lebesgue- or Borel-measurable). | Yes, suffices (Sierpiński [13]). | **No** — same. |
| **Monotonicity on $I$** ($G$ is non-decreasing or non-increasing). | Yes, suffices (Darboux [5]). | **No** — same. |
| **Boundedness on a set of positive measure** (there exists a Lebesgue-measurable $E\subseteq I$ with $|E|>0$ on which $G$ is bounded). | Yes, suffices (Steinhaus [14]; cf. Sierpiński [13]). | **No** — same. |
| **Boundedness on $I$** ($G$ is bounded on the whole interval $I$). | Yes, suffices (special case of Steinhaus [14]; Ostrowski [10]). | **No** — same. |
| **None** (no regularity hypothesis at all). | **Insufficient** — Hamel-basis pathology (Hamel [7]). | **Suffices** — Theorem 1. |

**Table 1.** *Regularity hypotheses on $G$. Column 2 records which hypotheses are classically required to force affineness for the discrete-coefficient equation $(J_2)$. Column 3 records what they become under the continuous-coefficient equation $(\star)$.*

The point of the table is the bottom row. **No regularity hypothesis** is enough for the discrete-coefficient equation: a non-affine, non-measurable, unbounded, additive function on $\mathbb R$ — the classical Hamel-basis pathology of [7] — supplies a non-affine solution of $(J_2)$. By contrast, **no regularity hypothesis** is *needed* for the continuous-coefficient equation: Theorem 1's chord substitution closes the proof at the level of the bare functional equation.

The mechanism is straightforward. A Hamel-basis pathological solution $G$ of Cauchy's equation on $\mathbb R$ is $\mathbb Q$-linear: $G(0) = 0$ and $G(qx) = q\,G(x)$ for every $q\in\mathbb Q$ and $x\in\mathbb R$. It is, by construction, *not* $\mathbb R$-linear — $G(rx) \neq r\,G(x)$ for some irrational $r$ and some $x\in\mathbb R$.

The chord identity at the configuration $u_1=M$, $u_2=0$ reads
$$
p\,G(M) + (1-p)\,G(0) \;=\; G(p\,M). \tag{$\star_0$}
$$
For $G$ a Hamel-pathological additive function ($G(0) = 0$), $(\star_0)$ is the assertion $p\,G(M) = G(p\,M)$ — which holds at $p\in\mathbb Q$ (by $\mathbb Q$-linearity) but fails at the irrational $p$ where $\mathbb R$-linearity is broken. So $G$ satisfies $(J_{\mathbb Q})$ on $[0,M]$ but violates $(\star)$ at *every* irrational $p\in(0,1)$ where the $\mathbb R$-linearity defect appears. The continuous-coefficient equation $(\star)$ rules the pathology out at exactly the points $p\in[0,1]\setminus\mathbb Q$ where the discrete- and rational-coefficient versions are silent. **The Hamel pathology lives at irrational $p$ — exactly where $(\star)$'s continuous coefficient closes the door.**

---

## IV. Variants and limits

### IV.1. The weakest hypothesis the proof consumes

The proof of Theorem 1 uses $(\star)$ at exactly one configuration: $u_1=M$, $u_2=0$, with $p\in[0,1]$ ranging freely. The full force of $(\star)$ — for *every* pair $(u_1,u_2)$ — is not consumed. We therefore record the strict minimum:

**Theorem 1$'$.** *Let $M>0$ and let $G:[0,M]\to\mathbb R$ satisfy*
$$
p\,G(M) + (1-p)\,G(0) \;=\; G(p\,M) \qquad \text{for all } p\in[0,1]. \tag{$\star_0$}
$$
*Then $G(v) = G(0) + \bigl(G(M)-G(0)\bigr)\, v/M$ on $[0,M]$.*

The proof is verbatim that of Theorem 1: set $p=v/M$. Theorem 1$'$ is in principle weaker than Theorem 1 — the hypothesis $(\star_0)$ does not a priori imply the full $(\star)$; under the conclusion (affineness) both hold. In practice an author who *derives* $(\star)$ from a richer setup (e.g., from a Jensen-equality identity in a Bayes-risk computation, see Section V) typically has $(\star)$ for all $(u_1,u_2,p)$. The narrower Theorem 1$'$ is the right reference for an author who wants to know how much of the equation the proof actually consumes.

### IV.2. Convex domains in higher dimensions

The chord substitution extends verbatim to any convex subset $C$ of a real vector space $V$: applying Theorem 1 along every chord shows that $G$ restricted to each segment of $C$ is affine in the segment parameter, and a standard inductive argument (cf. Aczél–Dhombres [2, Ch. 13]) lifts chord-affineness to convex-combination linearity on $C$, hence to an affine form $G(x) = a(x)+b$ for a linear $a$ on $\mathrm{span}(C-C)$ and a constant $b\in\mathbb R$. The structurally essential 1D step is Theorem 1.

### IV.3. The rational-coefficient version $(J_{\mathbb Q})$ does retain the pathology

The contrast across $\mathbb Q$ vs $\mathbb R$ is worth marking explicitly:

**Proposition 4 (folklore).** *There exists $G:[0,1]\to\mathbb R$ satisfying $(J_{\mathbb Q})$ (and hence $(J_2)$) on $[0,1]$ that is not affine.*

**Construction.** Choose a Hamel basis $H$ of $\mathbb R$ over $\mathbb Q$ containing $1$. Define a $\mathbb Q$-linear $\ell:\mathbb R\to\mathbb R$ by $\ell(1)=0$ and $\ell(h)=1$ for some basis element $h\in H\setminus\{1\}$, and arbitrarily on the remaining basis elements. By $\mathbb Q$-linearity, $\ell(x+y)=\ell(x)+\ell(y)$ for all $x,y\in\mathbb R$ (so $\ell$ satisfies Cauchy's equation) and $\ell(qx)=q\ell(x)$ for all $q\in\mathbb Q$ and $x\in\mathbb R$ ($\mathbb Q$-homogeneity). But $\ell$ is *not* $\mathbb R$-linear: $\ell(1)=0$ while $\ell(h)=1$, so the values of $\ell$ on the $\mathbb Q$-span of $\{1\}$ (namely $\mathbb Q$, on which $\ell\equiv 0$) and on the $\mathbb Q$-span of $\{h\}$ (where $\ell$ is nonzero) are incompatible with any $\mathbb R$-linear functional. Let $G := \ell|_{[0,1]}$. Then $G$ satisfies $(J_{\mathbb Q})$ on $[0,1]$, since $\mathbb Q$-rational convex combinations of points of $[0,1]$ stay in $[0,1]$ and $\ell$ respects $\mathbb Q$-linear combinations on all of $\mathbb R$.

Explicit witness that $G$ is not affine: choose $h\in H\setminus\{1\}$ with $h\in (0,1)$ (such a basis element exists, e.g., $1/\pi$ extended to a basis). Then $G(h)=\ell(h)=1\neq 0$, while $G(q)=\ell(q)=q\ell(1)=0$ for every rational $q\in[0,1]$. Any affine map $A:[0,1]\to\mathbb R$ agreeing with $G$ on $\mathbb Q\cap[0,1]$ would satisfy $A(0)=0$ and $A(q)=0$ for all rational $q\in[0,1]$, forcing $A\equiv 0$ — contradicting $G(h)=1$. So $G$ is not affine. $\square$

Proposition 4 sharpens Theorem 1's "no regularity hypothesis needed" by exhibiting that the strengthening from rational to continuous coefficients in $(\star)$ is doing real work. Without it (i.e., for $(J_{\mathbb Q})$), regularity hypotheses are genuinely required; with it, they are vestigial.

---

## V. Where the trap recurs

The chord substitution is — as we have noted — folklore. The regularity hypotheses it makes vestigial nonetheless reappear in applied work that derives $(\star)$ outside the functional-equations community. We document *one* such recurrence below — in our own work on the achievable error floor of partition-based classifiers — and articulate the *structural source* under which the recurrence is predictable in any sufficiently rich calibration-theory derivation. We invite extensions of the catalog from readers who encounter $(\star)$ in their own work.

### V.1. A recurrence: surrogate calibration on the resolution axis

In recent work [El1, El2], the equation $(\star)$ arises with $G$ the function expressing the *partition Bayes risk* of a measurable classifier in terms of a concave score functional aggregated over the partition's cells: $u_1, u_2$ are the per-cell score values and $p$ is the cell mass, which ranges freely over $[0, 1]$ on an atomless underlying probability space, so that $(\star)$ holds in full. In the Lean 4 formalization of [El2], the corresponding lemma was first declared with a boundedness hypothesis in its signature, in deference to the Cauchy/Hamel literature; the proof body then exhibited that the hypothesis was unused, by exactly the chord substitution of Theorem 1. The earlier drafts of the main text correspondingly invoked an apologetic *"$G$ is bounded so the bounded-Jensen-implies-affine theorem applies"* parenthetical — a parenthetical the present note's Theorem 1 retires.

### V.2. Structural source — why the trap is predictable to recur

The recurrence is predictable. Whenever a calibration-theory argument arrives at an identity of the form
$$
\mathbb E[g(\xi)] \;=\; g\bigl(\mathbb E[\xi]\bigr) \qquad (\xi \text{ a random variable on } I,\ g:I\to\mathbb R),
$$
*for a class of random variables $\xi$ wide enough that the marginal $\mathbb E[\xi]$ can be any point of $I$ and the support of $\xi$ can be any two-point subset of $I$ with any pair of masses $(p,1-p)$ with $p\in[0,1]$*, the identity is $(\star)$ with $g=G$, $\xi$ supported on $\{u_1,u_2\}$. Such an identity arises whenever Jensen's inequality is pushed to saturation. The standard surrogate-calibration literature — Bartlett–Jordan–McAuliffe [3], Tewari–Bartlett [15], Steinwart [16], Reid–Williamson [11, 12] — derives its calibration results via convex analysis (biconjugates, Fenchel duality, supporting hyperplanes), which keeps Jensen as an *inequality* with explicitly controlled slack and consequently never produces $(\star)$ as an equation; the resolution-axis derivation in [El2] pushes Jensen to equality directly and thereby produces $(\star)$. The chord substitution closes the resulting equation in one line. Other derivation styles that saturate Jensen's inequality across a wide class of two-point distributions should be expected to produce $(\star)$ similarly — at which point Theorem 1 retires the regularity-hypothesis question on the spot.

### V.3. Adjacent settings

Two adjacent settings where structurally similar equations arise and the chord substitution is the natural closure, although the *trap* (invoking Cauchy/Hamel regularity unnecessarily) is not, to our knowledge, recurrent in published work. First, **expected-utility representation theorems** in the von Neumann–Morgenstern tradition derive the linearity-in-probability of a utility functional $U(p\,L_1+(1-p)\,L_2)=p\,U(L_1)+(1-p)\,U(L_2)$ on lotteries; the Herstein–Milnor axiomatization closes this via the *Archimedean axiom* rather than via Cauchy/Hamel, but the chord substitution is the natural alternative closure. Second, **Shannon entropy's axiomatic characterization** (Khinchin–Faddeev recursivity axiom; cf. Aczél [1, Ch. 5] and Aczél–Dhombres [2, §22]) treats richer functional equations than $(\star)$, but several intermediate steps reduce to continuous-coefficient Jensen-type identities for which the chord substitution is part of the standard toolkit. We flag these settings as adjacent rather than as documented instances of the trap.

### V.4. An invitation to extend

We invite readers who have encountered $(\star)$ in their own work and have invoked a vestigial regularity hypothesis to extend the catalog with a one-line citation back to the relevant proof step in their paper.

---

## Declaration of interests

The author does not work for, advise, own shares in, or receive funds from any organisation that could benefit from this article, and has declared no affiliation other than his/her research organisation.

## Acknowledgements

The chord-substitution observation surfaced in the Lean 4 formalization track of [El2], during a phase of the proof development whose discipline is captured in three open project skills documented at the source code repository associated with [El2]. The author thanks the internal adversarial-review process described in the same source for surfacing the over-engineered boundedness hypothesis whose retirement motivated the present note.

---

## References

[1] J. Aczél, *Lectures on Functional Equations and Their Applications*, Mathematics in Science and Engineering, vol. 19, Academic Press: New York, 1966.

[2] J. Aczél and J. Dhombres, *Functional Equations in Several Variables*, Encyclopedia of Mathematics and its Applications, vol. 31, Cambridge University Press: Cambridge, 1989.

[3] Peter L. Bartlett, Michael I. Jordan and Jon D. McAuliffe, "Convexity, classification, and risk bounds", *Journal of the American Statistical Association* **101** (2006), no. 473, pp. 138–156, https://doi.org/10.1198/016214505000000907.

[4] Augustin Louis Cauchy, *Cours d'analyse de l'École royale polytechnique. Première partie : Analyse algébrique*, Imprimerie royale: Paris, 1821.

[5] Gaston Darboux, "Mémoire sur les fonctions discontinues", *Annales scientifiques de l'École normale supérieure*, sér. 2, **4** (1875), pp. 57–112.

[El1] [Author], in preparation, 2026; companion of [El2].

[El2] [Author], "The achievable-error floor of graph neural networks — calibration at the resolution level", manuscript in preparation, 2026.

[7] Georg Hamel, "Eine Basis aller Zahlen und die unstetigen Lösungen der Funktionalgleichung $f(x+y)=f(x)+f(y)$", *Mathematische Annalen* **60** (1905), pp. 459–462.

[9] Marek Kuczma, *An Introduction to the Theory of Functional Equations and Inequalities. Cauchy's Equation and Jensen's Inequality*, 2nd ed., edited by Attila Gilányi, Birkhäuser: Basel, 2009.

[10] Alexander M. Ostrowski, "Über die Funktionalgleichung der Exponentialfunktion und verwandte Funktionalgleichungen", *Jahresbericht der Deutschen Mathematiker-Vereinigung* **38** (1929), pp. 54–62.

[11] Mark D. Reid and Robert C. Williamson, "Composite binary losses", *Journal of Machine Learning Research* **11** (2010), pp. 2387–2422.

[12] Mark D. Reid and Robert C. Williamson, "Information, divergence and risk for binary experiments", *Journal of Machine Learning Research* **12** (2011), pp. 731–817.

[13] Wacław Sierpiński, "Sur les fonctions convexes mesurables", *Fundamenta Mathematicae* **1** (1920), pp. 125–129.

[14] Hugo Steinhaus, "Sur les distances des points dans les ensembles de mesure positive", *Fundamenta Mathematicae* **1** (1920), pp. 93–104.

[15] Ambuj Tewari and Peter L. Bartlett, "On the consistency of multiclass classification methods", *Journal of Machine Learning Research* **8** (2007), pp. 1007–1025.

[16] Ingo Steinwart, "How to compare different loss functions and their risks", *Constructive Approximation* **26** (2007), no. 2, pp. 225–287, https://doi.org/10.1007/s00365-006-0662-3.

---

*Reference numbering note for Phase I.* The list above is alphabetical by first-author surname (Aczél, Aczél–Dhombres, Bartlett–Jordan–McAuliffe, Cauchy, Darboux, [El1], [El2], Hamel, Kuczma, Ostrowski, Reid–Williamson 2010, Reid–Williamson 2011, Sierpiński, Steinhaus, Steinwart, Tewari–Bartlett). The placeholder labels `[El1]`, `[El2]` in this Markdown draft resolve to the actual author surname + year at BibTeX time; their alphabetical position will shift accordingly. The displayed numbers `[1]…[16]` will be re-assigned by the `crmath` BibTeX style — *the citations in the body of this draft use the numbers consistent with this list's current order*.

*Manuscript prepared for Comptes Rendus Mathématique (CRAS). Submission package: TeX source + compiled PDF + BibTeX file, per the Centre Mersenne `pack_author-crmath` class. Author affiliation, arXiv identifier, and Centre Mersenne DOI to be inserted at submission.*
