# The continuous-coefficient Jensen equation

### *A note on three vestigial regularity hypotheses*

*Manuscript prepared for* Expositiones Mathematicae *as a Short Research Note (≤10 pages). Draft 0.1 — authored 2026-06-07. Sister to the CRAS satellite at [`../o3-chord-substitution/09-draft0.3-manuscript.md`](../o3-chord-substitution/09-draft0.3-manuscript.md); reframed for the Expositiones audience per [`00-strategy.md`](00-strategy.md) §4.*

---

**Highlights.**

- The continuous Jensen equation $(\star)$ has a one-line proof: an endpoint substitution.
- Three regularity hypotheses on $G$ become vestigial under continuous coefficients.
- The Hamel-basis pathology of Cauchy's equation lives only at irrational $p$.
- Trap recurs when Jensen's inequality is saturated; absent in convex analysis.
- The same one-line trick proves affineness on convex sets in higher dimensions.

**Abstract.** *The continuous-coefficient form of Jensen's functional equation on a real interval — the equation $p G(u_1) + (1-p) G(u_2) = G(p u_1 + (1-p) u_2)$ imposed for every $u_1, u_2$ and every $p \in [0,1]$ — has a one-line proof of affineness via a single substitution that pins $G$ along the chord through the endpoints, with no regularity hypothesis on $G$. This contrasts sharply with the classical theory of Cauchy's additive equation, where without a regularity hypothesis the Hamel-basis pathology supplies non-affine solutions: the Polish school of the 1920s (Sierpiński, Steinhaus, Ostrowski) classifies the regularity hypotheses (continuity, measurability, boundedness on a positive-measure set) that recover affineness. We give the substitution explicitly, articulate the dictionary of three classically required regularity hypotheses that become vestigial under the continuous-coefficient form, and identify the structural mechanism: the Hamel pathology lives at irrational coefficients $p$, precisely where the continuous-coefficient equation forecloses on it. We close by isolating the recurrence pattern of the trap — Jensen's inequality pushed to saturation — and surveying three example application areas (expected-utility theory, Shannon entropy's axiomatic characterization, surrogate calibration) where the substitution is the natural closure of the equation.*

**Keywords:** Jensen equation; Cauchy equation; Hamel basis; functional equation; affine function; regularity hypothesis.

**MSC 2020:** 39B22 (Functional equations on real intervals); 39B05 (General theory of functional equations).

---

## 1. Introduction

The equation
$$
p\, G(u_1) + (1-p)\, G(u_2) \;=\; G\bigl(p\, u_1 + (1-p)\, u_2\bigr) \qquad (u_1, u_2 \in I,\ p \in [0, 1]), \tag{$\star$}
$$
imposed on a function $G : I \to \mathbb R$ defined on a real interval $I$, has at least three faces in classical analysis. The faces have been steadily conflated for over a century, and the conflation has consequences for both the foundational theory and for the modern applied literature where the equation surfaces.

### 1.1. Three faces of the equation

The **discrete-coefficient** Jensen equation,
$$
G\!\left(\tfrac{u_1 + u_2}{2}\right) \;=\; \tfrac{G(u_1) + G(u_2)}{2}, \tag{$J_2$}
$$
is the $p = \tfrac12$ specialization of $(\star)$. Setting $f(x) := G(x) - G(0)$, the equation $(J_2)$ is equivalent on a translate of $I$ to Cauchy's additive equation $f(x + y) = f(x) + f(y)$. Cauchy's equation inherits a full apparatus of pathological solutions: without measurability, monotonicity, boundedness on a set of positive Lebesgue measure, or another regularity hypothesis, the equation admits non-affine solutions constructed via a **Hamel basis** — that is, a basis of $\mathbb R$ as a $\mathbb Q$-vector space, whose existence requires the axiom of choice. The classical pathological-solution apparatus is the work of Hamel [7]; the regularity hypotheses sufficient to recover affineness were catalogued by Cauchy [4], Darboux [5], Sierpiński [13], Steinhaus [14], and Ostrowski [10].

The **rational-coefficient** Jensen equation,
$$
p\, G(u_1) + (1-p)\, G(u_2) \;=\; G\bigl(p\, u_1 + (1-p)\, u_2\bigr) \qquad (u_1, u_2 \in I,\ p \in [0, 1] \cap \mathbb Q), \tag{$J_{\mathbb Q}$}
$$
strengthens $(J_2)$ but does not escape its pathology. Cauchy additivity entails $\mathbb Q$-homogeneity — $f(qx) = qf(x)$ for every $q \in \mathbb Q$ — by an elementary induction on positive integers, sign reversal for negatives, and the inverse-of-multiplication argument for $1/n$. Combining additivity with $\mathbb Q$-homogeneity returns $(J_{\mathbb Q})$ for $f$, hence for $G$. So $(J_{\mathbb Q})$, $(J_2)$, and Cauchy's equation share the same solution class up to constants, and all three inherit the Hamel-basis pathology.

The **continuous-coefficient** form $(\star)$, by contrast, is fundamentally different. The strengthening from $\mathbb Q$ to $\mathbb R$ in the range of $p$ is *genuine*. As we will see, $(\star)$ does not admit any Hamel pathology — the pathology cannot survive at irrational $p$, and the continuous-coefficient equation tests $G$ at every irrational. This is the subject of the note.

### 1.2. The main result

> **Theorem 1.1.** *Let $M > 0$ and let $G : [0, M] \to \mathbb R$ satisfy $(\star)$ for every $u_1, u_2 \in [0, M]$ and every $p \in [0, 1]$. Then $G$ is affine on $[0, M]$ — meaning $G(v) = av + b$ for some $a, b \in \mathbb R$ — and explicitly*
> $$
> G(v) \;=\; \frac{G(M) - G(0)}{M}\, v \;+\; G(0).
> $$
> *No regularity hypothesis on $G$ — continuity, measurability, monotonicity, boundedness — is required.*

The proof is one line: a substitution into $(\star)$ that pins $G(v)$ along the chord through the endpoints $(0, G(0))$ and $(M, G(M))$. We give it in §2 and use the remainder of the note to articulate what it means.

### 1.3. The historical detour and the structural moral

Theorem 1.1 is folklore (cf. Aczél [1, §2.1], Kuczma [9, Ch. 13]). It is *not* a new mathematical result. The contribution of the present note is in three parts:

- *The explicit dictionary* (§3) of three regularity hypotheses on $G$ — continuity, measurability, boundedness — that are required to force affineness for $(J_2)$ but become *vestigial* under the continuous-coefficient form $(\star)$, together with the structural mechanism (the Hamel pathology lives at irrational $p$, exactly where $(\star)$'s continuous coefficient closes the door).

- *The strict-minimum hypothesis* (§4.1) — the equation $(\star)$ at a single chord configuration (rather than the full two-parameter family) already suffices.

- *The recurrence pattern* (§5) — the trap of invoking unnecessary Cauchy-Hamel regularity recurs whenever a derivation pushes Jensen's inequality to saturation across a wide class of two-point distributions. We survey three example application areas where this pattern arises (expected-utility theory, Shannon entropy axiomatic characterization, surrogate calibration on the resolution axis) and observe that the one-line substitution of §2 is the natural closure of the equation in each case.

The 80-year detour through Hamel and the Polish school answered a perfectly natural question — *what regularity hypothesis suffices for $(J_2) \Rightarrow$ affine?* — but a *different* question from the one that matters for many modern applications. The applied derivation does not produce $(J_2)$ or $(J_{\mathbb Q})$; it produces $(\star)$ as a saturated identity, and the one-line substitution of §2 is the right closure tool. The dictionary of §3 is the explicit articulation of which classical regularity hypotheses become vestigial in this transition.

**Terminology.** Throughout the note we refer to the substitution $u_1 = M$, $u_2 = 0$, $p = v/M$ in $(\star)$ — by which $G$ is pinned along the chord through the endpoints $(0, G(0))$ and $(M, G(M))$ — as the *chord substitution*. The substitution itself is standard folklore in the functional-equations literature (cf. Aczél [1, §2.1], Kuczma [9, Ch. 13]); the descriptive label is our convenience, adopted for brevity in repeated reference rather than as a claim of established terminology.

---

## 2. The result and its proof

We treat Theorem 1.1 in full.

> **Theorem 2.1 (= Theorem 1.1).** *Let $M > 0$ and let $G : [0, M] \to \mathbb R$ satisfy $(\star)$ for every $u_1, u_2 \in [0, M]$ and every $p \in [0, 1]$. Then $G$ is affine on $[0, M]$:*
> $$
> G(v) \;=\; \frac{G(M) - G(0)}{M}\, v \;+\; G(0) \qquad \text{for all } v \in [0, M].
> $$
> *No measurability, boundedness, or continuity hypothesis on $G$ is required.*

**Proof.** Fix $v \in [0, M]$. Choose the substitution
$$
u_1 \;:=\; M, \qquad u_2 \;:=\; 0, \qquad p \;:=\; \frac{v}{M}.
$$
The constraints of $(\star)$ are satisfied: $u_1 = M \in [0, M]$, $u_2 = 0 \in [0, M]$, and $p = v/M \in [0, 1]$ since $v \in [0, M]$.

Substituting into $(\star)$,
$$
\frac{v}{M}\, G(M) + \left(1 - \frac{v}{M}\right) G(0) \;=\; G\!\left(\frac{v}{M} \cdot M + \left(1 - \frac{v}{M}\right) \cdot 0\right) \;=\; G(v).
$$
Rearranging gives the explicit affine formula $G(v) = G(0) + (G(M) - G(0))\, v/M$. $\square$

The chord substitution pins $G(v)$ along the straight chord from $(0, G(0))$ to $(M, G(M))$ for every $v \in [0, M]$. Since this determines $G(v)$ at *every* $v$, the function $G$ is fully determined by its values at the two endpoints — it is exactly the affine function joining them.

> **Corollary 2.2.** *Under the hypotheses of Theorem 2.1, $G$ is in particular continuous, monotone, locally Lipschitz, absolutely continuous, and Lebesgue measurable on $[0, M]$.*

**Proof.** Affine functions on bounded intervals have all of these properties: an affine function $G(v) = av + b$ is differentiable with continuous derivative $G'(v) = a$, hence continuous; non-decreasing if $a \ge 0$ and non-increasing if $a \le 0$; Lipschitz with constant $|a|$; absolutely continuous; and Borel-measurable, hence Lebesgue-measurable. $\square$

The order of inference matters and is worth stating explicitly. Under $(\star)$, the regularity properties of $G$ are the *conclusion*, not the hypothesis. Each of the regularity hypotheses one might be tempted to assume — continuity, monotonicity, boundedness, measurability — is *automatically satisfied* by any solution of $(\star)$. The continuous-coefficient equation $(\star)$ supplies its own regularity from within; no external regularity hypothesis is needed.

This is what makes the continuous-coefficient case structurally different from the discrete-coefficient case $(J_2)$, where some regularity hypothesis *is* required to rule out the Hamel pathology. We now examine the difference in detail.

---

## 3. The dictionary of vestigial regularity hypotheses

### 3.1. Six hypotheses and their fates

We place side-by-side the discrete-coefficient equation $(J_2)$ and the continuous-coefficient equation $(\star)$, and ask which regularity hypotheses on $G$ are *required* to force affineness for each. The first column of Table 1 names the hypothesis and gives a one-sentence reminder; the second column records the requirement for $(J_2)$ with the standard historical attribution; the third column records what becomes of the requirement under $(\star)$.

| **Hypothesis on $G$ (definition)** | **Required for $(J_2) \Rightarrow$ affine?** | **Required for $(\star) \Rightarrow$ affine?** |
|---|---|---|
| **Continuity on $I$**: $G$ is continuous at every $v \in I$. | Yes, suffices (Cauchy [4]). | **No** — continuity is the *conclusion* (Corollary 2.2). |
| **Measurability on $I$**: $G$ is Lebesgue- or Borel-measurable on $I$. | Yes, suffices (Sierpiński [13]). | **No** — same. |
| **Monotonicity on $I$**: $G$ is non-decreasing or non-increasing on $I$. | Yes, suffices (Darboux [5]). | **No** — same. |
| **Boundedness on a set of positive measure**: there exists Lebesgue-measurable $E \subseteq I$ with $|E| > 0$ on which $G$ is bounded. | Yes, suffices (Steinhaus [14]; cf. Sierpiński [13]). | **No** — same. |
| **Boundedness on $I$**: $G$ is bounded on the whole interval $I$. | Yes, suffices (special case of Steinhaus [14]; Ostrowski [10]). | **No** — same. |
| **None**: no regularity hypothesis at all. | **Insufficient** — Hamel-basis pathology (Hamel [7]). | **Sufficient** — Theorem 2.1. |

**Table 1.** *Regularity hypotheses on $G$. Column 2 records which hypotheses are classically required to force affineness for the discrete-coefficient equation $(J_2)$. Column 3 records what they become under the continuous-coefficient equation $(\star)$.*

The bottom row is the point of the table. **No regularity hypothesis** is enough for the discrete-coefficient equation $(J_2)$: there exists a non-affine, non-measurable, unbounded, additive function on $\mathbb R$ — the classical Hamel-basis pathology of Hamel [7] — that supplies a non-affine solution of $(J_2)$. Conversely, **no regularity hypothesis** is *needed* for the continuous-coefficient equation $(\star)$: Theorem 2.1's chord substitution closes the proof at the level of the bare functional equation.

The five non-bottom rows tell a complementary story. For $(J_2)$, *some* hypothesis from these five is required; otherwise the Hamel pathology survives. For $(\star)$, *none* of these is required — and yet each is *automatically satisfied* by any solution (Corollary 2.2). The hypothesis is, in the dictionary's terminology, **vestigial**: classically required for $(J_2)$, classically expected for $(\star)$, but in fact unnecessary for $(\star)$.

### 3.2. The structural mechanism

We now examine *why* the Hamel pathology fails to apply to $(\star)$. The mechanism is direct and illuminating.

A Hamel-basis pathological solution $G$ of Cauchy's equation on $\mathbb R$ is **$\mathbb Q$-linear**: by construction (or by induction from additivity), $G(0) = 0$ and $G(qx) = q\, G(x)$ for every $q \in \mathbb Q$ and every $x \in \mathbb R$. By design, $G$ is *not* $\mathbb R$-linear — there exists some irrational $r \in \mathbb R$ and some $x \in \mathbb R$ such that $G(rx) \neq r\, G(x)$.

The chord identity in $(\star)$ at the configuration $u_1 = M$, $u_2 = 0$ reads
$$
p\, G(M) + (1 - p)\, G(0) \;=\; G(p\, M). \tag{$\star_0$}
$$
For a Hamel-pathological $G$ (so $G(0) = 0$), $(\star_0)$ becomes the assertion
$$
p\, G(M) \;=\; G(p\, M). \tag{$\star_0^*$}
$$
This is exactly the $\mathbb R$-linearity assertion for $G$ at the specific pair $(M, p)$. By $\mathbb Q$-linearity of $G$, $(\star_0^*)$ holds for every $p \in \mathbb Q$. By the failure of $\mathbb R$-linearity, $(\star_0^*)$ *fails* at some irrational $p$. So the Hamel-pathological $G$ satisfies $(J_{\mathbb Q})$ (every rational coefficient is OK) but violates $(\star)$ at every irrational $p$ where the $\mathbb R$-linearity defect appears.

The point is structural and worth stating in one sentence.

> **The Hamel pathology lives at irrational $p$; the continuous-coefficient equation $(\star)$ forecloses on it there.**

The 80-year detour through Hamel and the Polish school — Cauchy 1821 to Ostrowski 1929 — was an investigation of what regularity hypothesis can substitute for the *unavailable* constraint at irrational $p$, when only the rational-coefficient version of the equation is in play. With the continuous-coefficient version, the irrational-coefficient constraint is *available*, and the entire dictionary collapses.

---

## 4. Variants and limits

### 4.1. The strict-minimum hypothesis

The proof of Theorem 2.1 uses $(\star)$ at exactly one configuration: $u_1 = M$, $u_2 = 0$, with $p \in [0, 1]$ ranging freely. The full force of $(\star)$ — for every pair $(u_1, u_2)$ — is not consumed. We record the strict minimum:

> **Theorem 4.1.** *Let $M > 0$ and let $G : [0, M] \to \mathbb R$ satisfy*
> $$
> p\, G(M) + (1 - p)\, G(0) \;=\; G(p\, M) \qquad \text{for all } p \in [0, 1]. \tag{$\star_0$}
> $$
> *Then $G(v) = G(0) + (G(M) - G(0))\, v/M$ on $[0, M]$.*

The proof is verbatim that of Theorem 2.1: set $p = v/M$. Theorem 4.1 is *in principle* weaker than Theorem 2.1 — the hypothesis $(\star_0)$ does not a priori imply the full $(\star)$, and *as standalone constraints on $G$* they are inequivalent. Under the conclusion (affineness), both hold; in practice, an author who derives $(\star)$ from a richer setup (e.g., from a Jensen-equality identity in a Bayes-risk computation, see §5) typically obtains $(\star)$ in full force. The narrower Theorem 4.1 is the right reference for an author who wants to know how much of the equation the proof actually consumes.

### 4.2. Convex domains in higher dimensions

The chord substitution extends to any convex subset of a real vector space.

> **Theorem 4.2.** *Let $V$ be a real vector space, let $C \subseteq V$ be a convex set, and let $G : C \to \mathbb R$ satisfy*
> $$
> p\, G(x_1) + (1 - p)\, G(x_2) \;=\; G\bigl(p\, x_1 + (1 - p)\, x_2\bigr) \qquad (x_1, x_2 \in C,\ p \in [0, 1]).
> $$
> *Then there is a linear functional $a : \mathrm{span}(C - C) \to \mathbb R$ and a constant $b \in \mathbb R$ such that $G(x) = a(x - x_0) + b$ on $C$ for any fixed $x_0 \in C$. Equivalently, $G$ is affine on $C$.*

**Proof sketch.** Apply Theorem 2.1 along every chord in $C$: for each direction $v$ with $x_0 + v \in C$, the map $\lambda \mapsto G(x_0 + \lambda v)$ is affine in the segment parameter $\lambda \in [0, 1]$. Hence the increment $G(x_0 + v) - G(x_0)$ depends linearly on $v$ in each direction; an inductive argument on the dimension of the affine span of the points involved promotes this directional linearity to a global linear functional $a$ on $\mathrm{span}(C - C)$. The bookkeeping is standard and is given in Aczél–Dhombres [2, Ch. 13]. $\square$

The structurally essential step is the one-dimensional chord substitution of Theorem 2.1. The higher-dimensional lifting is bookkeeping that transports the one-dimensional affineness into a multidimensional affineness on the convex set.

### 4.3. The rational-coefficient version $(J_{\mathbb Q})$ does retain the pathology

To sharpen Theorem 2.1's "no regularity hypothesis needed", we exhibit explicitly that the strengthening from rational to continuous coefficients in $(\star)$ is doing real work: the rational-coefficient version $(J_{\mathbb Q})$ retains the Hamel pathology.

> **Proposition 4.3 (Folklore).** *There exists $G : [0, 1] \to \mathbb R$ satisfying $(J_{\mathbb Q})$ (hence $(J_2)$) on $[0, 1]$ that is not affine.*

**Construction.** Choose a Hamel basis $H$ of $\mathbb R$ over $\mathbb Q$ containing $1$. Such a basis exists by Zorn's lemma applied to the partially ordered set of $\mathbb Q$-linearly independent subsets of $\mathbb R$. Define a $\mathbb Q$-linear map $\ell : \mathbb R \to \mathbb R$ by setting $\ell(1) = 0$, picking an irrational $h \in H \cap (0, 1)$ (which exists since $H$ has cardinality $\mathfrak c$ and the rationals plus $\{1\}$ are at most countable, so $H$ must contain irrationals throughout $\mathbb R$ — in particular in $(0, 1)$), setting $\ell(h) = 1$, and extending arbitrarily on the remaining basis elements.

By construction, $\ell$ is $\mathbb Q$-linear: $\ell(x + y) = \ell(x) + \ell(y)$ for all $x, y \in \mathbb R$ (so $\ell$ satisfies Cauchy's equation) and $\ell(qx) = q\, \ell(x)$ for all $q \in \mathbb Q$ and $x \in \mathbb R$ ($\mathbb Q$-homogeneity). But $\ell$ is *not* $\mathbb R$-linear: $\ell(1) = 0$ while $\ell(h) = 1$, so the values of $\ell$ on the $\mathbb Q$-span of $\{1\}$ (namely $\mathbb Q$, on which $\ell$ vanishes identically) and on the $\mathbb Q$-span of $\{h\}$ (where $\ell$ is nonzero) are incompatible with any $\mathbb R$-linear functional on $\mathbb R$.

Set $G := \ell|_{[0, 1]}$. Then $G$ satisfies $(J_{\mathbb Q})$ on $[0, 1]$ because $\mathbb Q$-rational convex combinations of points of $[0, 1]$ remain in $[0, 1]$ and $\ell$ respects $\mathbb Q$-linear combinations on all of $\mathbb R$.

Explicit witness that $G$ is not affine: $G(h) = \ell(h) = 1 \neq 0$, while $G(q) = \ell(q) = q\, \ell(1) = 0$ for every rational $q \in [0, 1]$. Any affine map $A : [0, 1] \to \mathbb R$ agreeing with $G$ on $\mathbb Q \cap [0, 1]$ would satisfy $A(0) = 0$ and $A(q) = 0$ for all rational $q$ — forcing $A \equiv 0$, contradicting $G(h) = 1$. So $G$ is not affine. $\square$

Proposition 4.3 affirms the dictionary: $(J_{\mathbb Q})$ on $[0, 1]$ admits non-affine solutions; only the strengthening to the *continuous*-coefficient $(\star)$ retires the regularity-hypothesis requirement.

---

## 5. Where the trap recurs: Jensen saturation as a structural pattern

The chord substitution of §2 is, as noted, folkloric — Aczél [1, §2.1] and Kuczma [9, Ch. 13] articulate the underlying observation, and the result is standard in the functional-equations community. Why, then, does this note exist?

Because the *vestigial regularity hypotheses* — continuity, measurability, boundedness — keep reappearing in applied derivations of $(\star)$ outside the functional-equations community. The trap is not a one-off oversight; it has a structural source. This section identifies the source and surveys three example application areas where it surfaces.

### 5.1. The structural source: saturated Jensen

The recurrence is predictable. Whenever a derivation in any field arrives at an identity of the form
$$
\mathbb E[g(\xi)] \;=\; g\bigl(\mathbb E[\xi]\bigr) \qquad (\xi \text{ a random variable on } I,\ g : I \to \mathbb R), \tag{$\dagger$}
$$
**for a class of random variables $\xi$ wide enough that the marginal $\mathbb E[\xi]$ can be any point of $I$ and the support of $\xi$ can be any two-point subset of $I$ with any pair of masses $(p, 1-p)$ with $p \in [0, 1]$**, the identity is exactly $(\star)$ with $g = G$ and $\xi$ supported on $\{u_1, u_2\}$ with respective masses $\{p, 1-p\}$. Such an identity arises whenever **Jensen's inequality is pushed to saturation** — that is, whenever equality is required in $\mathbb E[g(\xi)] \le g(\mathbb E[\xi])$ for concave $g$ across the full two-point family.

Jensen's inequality is the central tool in dozens of fields: convex analysis, information theory, statistical decision theory, mathematical economics, mathematical physics. In *most* of these fields, Jensen is used as an inequality with slack — the slack is explicitly tracked (in convex analysis via biconjugates and Fenchel duality; in calibration theory via the $\psi$-transform construction of Bartlett, Jordan, and McAuliffe [3]; in entropy via convexity arguments). Such derivations never produce $(\star)$ as a saturated identity.

In *some* fields, however, a derivation produces $(\dagger)$ as a saturated identity — the slack is forced to zero by a structural property of the setup (e.g., the class of $\xi$ is rich enough to exhaust the inequality's freedom). At that moment $(\star)$ appears, and the chord substitution is the natural closure. An author unfamiliar with the chord substitution will reach for the classical Cauchy-Hamel toolkit — continuity, measurability, boundedness — and find that the regularity hypothesis is unnecessary only after the fact.

### 5.2. Application: expected-utility representation theorems

The first application area is **expected-utility theory** in the von Neumann–Morgenstern tradition. The 1944 axiomatization of preferences over lotteries, sharpened by Herstein and Milnor in 1953 [12], derives a utility functional $U$ on a space of lotteries $\mathcal L$ that is **linear in probability**:
$$
U\bigl(p\, L_1 + (1-p)\, L_2\bigr) \;=\; p\, U(L_1) + (1-p)\, U(L_2) \qquad (L_1, L_2 \in \mathcal L,\ p \in [0, 1]).
$$
This is exactly $(\star)$ with the abstract lotteries $L_1, L_2$ as the points $u_1, u_2$ and $U$ as the function $G$. The classical closure of the linearity step in the Herstein–Milnor proof uses the **Archimedean axiom**: for any three lotteries $L_1 \succ L_2 \succ L_3$, there exist $p, q \in (0, 1)$ such that $p L_1 + (1-p) L_3 \succ L_2 \succ q L_1 + (1-q) L_3$. The Archimedean axiom forces the continuity-in-probability of preferences, which in turn forces continuity-in-probability of $U$.

But the chord substitution of Theorem 2.1 *also* closes the linearity step, without requiring any continuity hypothesis. Both routes work; the chord substitution is the algebraic alternative to the Archimedean axiom. The lesson: even where the Archimedean axiom is invoked (and rightly so, as it carries other preference-theoretic content), the closure of the linearity equation itself does not require it.

### 5.3. Application: Shannon entropy's axiomatic characterization

The second application area is the **axiomatic characterization of Shannon entropy** in the tradition of Khinchin and Faddeev. Shannon's 1948 paper introduced the entropy function $H(p_1, \ldots, p_n) = -\sum_i p_i \log p_i$; the question of which conditions on a continuous function on $\bigcup_n \Delta^{n-1}$ uniquely determine $H$ up to a multiplicative constant was answered by Khinchin (1957) and Faddeev (1956). Their axioms are: continuity in the arguments; maximum at the uniform distribution; and a **recursivity axiom** (Khinchin–Faddeev) that relates the entropy of a joint distribution to a marginal entropy plus a conditional.

In the modern formalization (Aczél [1, Ch. 5], Aczél–Dhombres [2, §22]), the recursivity axiom reduces, in intermediate steps, to a system of functional equations on auxiliary functions $g, h$ on $[0, 1]$. Several of these intermediate equations are of $(\star)$-form for the auxiliary functions, and the closure step in the modern axiomatic treatment uses continuity (the first Khinchin axiom). The chord substitution of Theorem 2.1 is the alternative closure that does not require continuity-as-hypothesis.

In Aczél–Dhombres the chord substitution is part of the standard toolkit; the present note's contribution to this area is to articulate it as a separable lemma worth citing.

### 5.4. Application: surrogate calibration on the resolution axis

The third application area is **surrogate calibration** in modern statistical decision theory. The foundational tradition is Bartlett, Jordan, and McAuliffe [3] (binary classification) and its multiclass extensions: Tewari and Bartlett [15], Steinwart [16], Reid and Williamson [11, 12]. These works study the question of how minimizing a convex surrogate loss (logistic, exponential, hinge) approximately minimizes the 0–1 loss in classification.

The standard derivation route in the surrogate-calibration literature uses **convex analysis** — biconjugates, supporting hyperplanes, Fenchel duality, the $\psi$-transform of Bartlett–Jordan–McAuliffe — and consequently tracks Jensen's inequality as an *inequality* with explicit slack. The slack is the calibration function $\psi$, and the construction never produces $(\star)$ as a saturated identity.

In a recent manuscript of the author [El2] on the achievable error floor of partition-based classifiers, the resolution-axis transposition framing of surrogate calibration produces $(\star)$ directly: a two-cell partition computation forces $(\star)$ on the function $G$ that expresses the partition Bayes risk in terms of an aggregated concave score, with the cell mass $p$ ranging freely over $[0, 1]$ on an atomless underlying probability space. In the Lean 4 formalization of [El2], the corresponding lemma `affine_of_jensen_eq` was initially declared with a boundedness hypothesis on $G$ in deference to the Cauchy-Hamel literature; the proof body then exhibited that the hypothesis was unused, by the chord substitution of Theorem 2.1.

The lesson generalizes beyond [El2]. Any derivation in any field that saturates Jensen across a wide class of two-point distributions should be expected to produce $(\star)$ similarly. At that moment, Theorem 2.1 closes the regularity-hypothesis question on the spot.

### 5.5. An invitation

The three application areas of §§5.2–5.4 are not exhaustive. We invite readers who have encountered $(\star)$ in their own work (in mathematical economics, in information theory, in statistical decision theory, in physics, or elsewhere) and who have invoked an unnecessary Cauchy-Hamel regularity hypothesis to extend the catalog. The structural pattern of saturated Jensen — and the chord substitution as its natural closure — is, we believe, recurrent enough to merit explicit articulation.

---

## 6. Concluding remarks

Theorem 2.1 is, mathematically, one line. The dictionary of §3 is six rows of a table. The structural argument of §3.2 is one sentence: *the Hamel pathology lives at irrational $p$; the continuous-coefficient equation $(\star)$ forecloses on it there.* Why does this material deserve a Short Research Note?

Two reasons. First, the 80-year detour through Hamel and the Polish school is a *foundational* result of classical analysis — and the dictionary of §3 articulates a precise sense in which the detour answered an adjacent question: not "what is the minimum hypothesis for $(\star) \Rightarrow$ affine?" (Theorem 2.1's answer: nothing), but "what is the minimum hypothesis for $(J_2) \Rightarrow$ affine?" (Polish school's answer: any of a dictionary of tameness conditions). Both questions are interesting; their answers are different.

Second, the recurrence pattern of §5 is, to our knowledge, not articulated explicitly elsewhere in the functional-equations literature. The pattern — saturated Jensen produces $(\star)$, and the chord substitution closes it — is recognizable in a number of modern application contexts (utility theory, entropy, calibration), and the explicit articulation may save other authors from carrying vestigial regularity hypotheses in their own work.

The chord substitution itself is the kind of one-line proof that, once seen, is hard to unsee — but that nonetheless takes some scaffolding to make visible. The present note is the scaffolding.

---

## Funding

This research did not receive any specific grant from funding agencies in the public, commercial, or not-for-profit sectors.

## Acknowledgements

The chord-substitution observation surfaced in the Lean 4 formalization track of the author's main paper [El2], during a development phase whose discipline is captured in three open project skills documented in the source code repository associated with [El2]. The author thanks the internal adversarial-review process described in the same source for surfacing the over-engineered boundedness hypothesis whose retirement motivated the present note.

## Declaration of competing interests

The author declares that they have no known competing financial interests or personal relationships that could have appeared to influence the work reported in this paper. The corresponding competing-interests declaration is provided in a separate file accompanying this submission.

## Declaration of generative AI and AI-assisted technologies in the manuscript preparation process

During the preparation of this work the author used GitHub Copilot (Anthropic Claude family of models) in the following capacities: (i) drafting and revising prose in the manuscript and the supporting materials; (ii) cross-referencing bibliographic entries and verifying citation formats against journal guidelines; (iii) structuring the multi-round adversarial-audit cycle documented in the source repository accompanying this work. The mathematical content — including all theorems, proofs, examples, the structural argument of §5, and the dictionary of regularity hypotheses in §3 — was reviewed, verified, and refined by the author through the audit cycle. The author has reviewed and edited the content as needed and takes full responsibility for the content of the published article.

---

## References

*Numerical style, references in order of first appearance in the text per Elsevier convention.*

[1] J. Aczél, *Lectures on Functional Equations and Their Applications*, Mathematics in Science and Engineering, vol. 19, Academic Press, New York, 1966.

[2] J. Aczél, J. Dhombres, *Functional Equations in Several Variables*, Encyclopedia of Mathematics and its Applications, vol. 31, Cambridge University Press, Cambridge, 1989.

[3] P.L. Bartlett, M.I. Jordan, J.D. McAuliffe, Convexity, classification, and risk bounds, J. Amer. Statist. Assoc. **101** (2006) 138–156. https://doi.org/10.1198/016214505000000907.

[4] A.L. Cauchy, *Cours d'analyse de l'École royale polytechnique. Première partie: Analyse algébrique*, Imprimerie royale, Paris, 1821.

[5] G. Darboux, Mémoire sur les fonctions discontinues, Ann. Sci. École Norm. Sup. (2) **4** (1875) 57–112.

[6] D.K. Faddeev, Zum Begriff der Entropie einer endlichen Wahrscheinlichkeitsschemas, in: *Arbeiten zur Informationstheorie*, vol. 1, Deutscher Verlag der Wissenschaften, Berlin, 1957.

[7] G. Hamel, Eine Basis aller Zahlen und die unstetigen Lösungen der Funktionalgleichung $f(x+y)=f(x)+f(y)$, Math. Ann. **60** (1905) 459–462.

[8] J.L. Jensen, Sur les fonctions convexes et les inégalités entre les valeurs moyennes, Acta Math. **30** (1906) 175–193.

[9] M. Kuczma, *An Introduction to the Theory of Functional Equations and Inequalities. Cauchy's Equation and Jensen's Inequality*, 2nd ed., A. Gilányi (Ed.), Birkhäuser, Basel, 2009.

[10] A.M. Ostrowski, Über die Funktionalgleichung der Exponentialfunktion und verwandte Funktionalgleichungen, Jahresber. Deutsch. Math.-Verein. **38** (1929) 54–62.

[11] M.D. Reid, R.C. Williamson, Composite binary losses, J. Mach. Learn. Res. **11** (2010) 2387–2422.

[12] I.N. Herstein, J. Milnor, An axiomatic approach to measurable utility, Econometrica **21** (1953) 291–297.

[13] W. Sierpiński, Sur les fonctions convexes mesurables, Fund. Math. **1** (1920) 125–129.

[14] H. Steinhaus, Sur les distances des points dans les ensembles de mesure positive, Fund. Math. **1** (1920) 93–104.

[15] A. Tewari, P.L. Bartlett, On the consistency of multiclass classification methods, J. Mach. Learn. Res. **8** (2007) 1007–1025.

[16] I. Steinwart, How to compare different loss functions and their risks, Constr. Approx. **26** (2007) 225–287. https://doi.org/10.1007/s00365-006-0662-3.

[17] A.I. Khinchin, *Mathematical Foundations of Information Theory*, Dover, New York, 1957.

[18] J. von Neumann, O. Morgenstern, *Theory of Games and Economic Behavior*, Princeton University Press, Princeton, 1944.

[19] M.D. Reid, R.C. Williamson, Information, divergence and risk for binary experiments, J. Mach. Learn. Res. **12** (2011) 731–817.

[El2] [Author], *The achievable-error floor of graph neural networks — calibration at the resolution level*, manuscript in preparation, 2026.

---

*Manuscript prepared for Expositiones Mathematicae as a Short Research Note. Author affiliation, arXiv identifier (if deposited), DOIs, and the date of submission are to be inserted at the EES submission step.*
