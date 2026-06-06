# The Chord Substitution — Part III

## Act III — *The Escape and What It Means*

*Draft 0.0 — Chapters 7, 8, 9, 10. Authored 2026-06-07.*

---

# Chapter 7 — *Jensen's equation: discrete and rational coefficients*

> *"Sur les fonctions convexes et les inégalités entre les valeurs moyennes."* — Johan Ludwig Jensen, *Acta Mathematica* **30** (1906), pp. 175–193.

We have spent five chapters on Cauchy's equation and the Hamel pathology. We now bring the discussion back to Jensen's equation, which is the equation we started with in Chapter 1. The point of this chapter is to consolidate: $(J_2)$ and $(J_{\mathbb Q})$ are *equivalent* to Cauchy's equation, both inherit the Hamel pathology, and the dictionary of Chapter 6 transfers to both. The chapter is short — much of the work is already done — and prepares the ground for Chapter 8, where we meet $(\star)$ and the chord substitution.

## 7.1 Jensen 1906: convexity and the equation

Johan Ludwig Jensen, a Danish telephone engineer and mathematician, published *Sur les fonctions convexes et les inégalités entre les valeurs moyennes* in *Acta Mathematica* in 1906. The paper introduced what we now call **Jensen's inequality**:

> If $G : I \to \mathbb R$ is concave on a real interval $I$, then for any probability distribution $\xi$ on $I$ (taking values $u_1, \ldots, u_n$ with probabilities $p_1, \ldots, p_n$, with $\sum p_i = 1$),
> $$ \mathbb E[G(\xi)] \;\le\; G(\mathbb E[\xi]). $$

Equality holds if either $G$ is affine, or $\xi$ is degenerate at a single point. The case $\xi$ takes only two values $u_1, u_2$ with probabilities $p, 1-p$ is exactly the equation $(\star)$ with the inequality replaced by equality — and Jensen's paper noted that equality in his inequality, *for every choice of $u_1, u_2, p$*, characterizes affine $G$.

Jensen's equation, in the *equality* version, was the equation $(\star)$, although he stated it for finite-coefficient distributions ($p \in \mathbb Q \cap [0, 1]$) rather than continuous ones. So Jensen's *original* equation was what we are calling $(J_{\mathbb Q})$, not $(\star)$. The strengthening to $(\star)$ has a more technical name in some literatures (sometimes called the *strong* Jensen equation), but for clarity we will keep our notation $(\star)$.

## 7.2 $(J_2) \leftrightarrow$ Cauchy via translation

We have already seen this reduction in Chapter 2 §2.1. We restate it here.

> **Proposition 7.1.** *On a real interval $I$ closed under midpoints (i.e., $u_1, u_2 \in I \Rightarrow (u_1+u_2)/2 \in I$), the equation*
> $$ G\!\left(\tfrac{u_1+u_2}{2}\right) \;=\; \tfrac{G(u_1)+G(u_2)}{2} $$
> *for $G : I \to \mathbb R$ is equivalent, via $f(x) := G(x) - G(0)$ (with $0 \in I$, after possibly translating), to Cauchy's additive equation*
> $$ f(x+y) \;=\; f(x) + f(y) $$
> *for $f$ on the translated interval $I - 0$.*

**Proof.** See Exercise 2.1. The forward direction sets $x = (u_1+u_2)/2$, $y = (u_1 - u_2)/2$; the backward direction reverses. $\square$

Consequently, the *solution class* of $(J_2)$ on $\mathbb R$ is exactly $\{f + \text{const} : f \text{ additive}\}$ — the affine functions plus the Hamel-pathological additive functions.

## 7.3 $(J_2)$ inherits the same pathology

We are now in a position to give a complete catalog of solutions of $(J_2)$ on $\mathbb R$ (or on any interval where $(J_2)$ makes sense).

> **Theorem 7.2.** *Let $G : \mathbb R \to \mathbb R$ be a solution of $(J_2)$. Then $G$ has the form $G(x) = f(x) + b$, where $b \in \mathbb R$ and $f$ is an additive function on $\mathbb R$ (i.e., a solution of Cauchy's equation $(C)$). Conversely, every such $G$ is a solution of $(J_2)$.*

**Proof.** Direct from Proposition 7.1. $\square$

In particular, the *affine* solutions $G(x) = ax + b$ are a *strict subset* of the general solutions, as long as we are in ZFC. The non-affine solutions are exactly $f + b$ for $f$ a Hamel-pathological additive function. By Theorem 4.4 and the construction of Chapter 5, the set of Hamel-pathological additive functions is a $\mathbb Q$-vector space of dimension $\mathfrak c$. So the solution set of $(J_2)$ on $\mathbb R$, modulo affines, has dimension $\mathfrak c - 1 = \mathfrak c$.

The dictionary of Chapter 6 applies. Any solution of $(J_2)$ that satisfies any of the regularity hypotheses in §6.7 is affine.

## 7.4 $(J_{\mathbb Q})$: rational coefficients give the same conclusion

The rational-coefficient version is *no* sharpening of $(J_2)$ as a constraint on $G$:

> **Proposition 7.3.** *Let $G : \mathbb R \to \mathbb R$. Then $G$ satisfies $(J_2)$ iff $G$ satisfies $(J_{\mathbb Q})$.*

**Proof.** Forward direction. Suppose $G$ satisfies $(J_2)$ on $\mathbb R$. Then $f := G - G(0)$ is additive. By Lemma 2.2, $f$ is $\mathbb Q$-homogeneous: $f(qx) = qf(x)$ for $q \in \mathbb Q$.

For any $u_1, u_2 \in \mathbb R$ and $p \in [0, 1] \cap \mathbb Q$,
\begin{align*}
p\, G(u_1) + (1-p)\, G(u_2) &= p (f(u_1) + G(0)) + (1-p) (f(u_2) + G(0)) \\
&= pf(u_1) + (1-p)f(u_2) + G(0) \\
&= f(p u_1) + f((1-p) u_2) + G(0) \qquad \text{(by $\mathbb Q$-homogeneity)} \\
&= f(p u_1 + (1-p) u_2) + G(0) \qquad \text{(by additivity)} \\
&= G(p u_1 + (1-p) u_2).
\end{align*}
So $G$ satisfies $(J_{\mathbb Q})$.

Reverse direction. $(J_{\mathbb Q})$ specializes to $(J_2)$ at $p = 1/2$. $\square$

So the rational-coefficient version $(J_{\mathbb Q})$ is *no constraint beyond* the midpoint version $(J_2)$. Both have the same solution class — affines plus Hamel pathologicals. Both have the same dictionary of regularity hypotheses that rescue affineness.

This is a key observation. The 80-year gap between Cauchy 1821 and Hamel 1905 was, in retrospect, a discussion about the *wrong* generalization of $(J_2)$. Adding rational coefficients does nothing; the *real* generalization, the one that breaks the Hamel pathology, is adding *irrational* coefficients — which is exactly what $(\star)$ does.

## 7.5 A complete catalog of solutions

> **Theorem 7.4.** *Let $G : \mathbb R \to \mathbb R$ be a solution of $(J_{\mathbb Q})$ (equivalently, $(J_2)$). Then exactly one of the following holds:*
>
> 1. *$G$ is affine: $G(x) = ax + b$ for some $a, b \in \mathbb R$.*
> 2. *$G$ is "Hamel-pathological": $G(x) = f(x) + b$ where $f$ is a non-$\mathbb R$-linear additive function (constructed via a Hamel basis as in Chapter 5).*

The affine solutions form a 2-parameter family. The Hamel-pathological solutions form (modulo affines) a $\mathbb Q$-vector space of dimension $\mathfrak c$. Most solutions of $(J_2)$ are Hamel-pathological.

The reader should now ask: *what about $(\star)$?* Does the strengthening from rational to continuous coefficients eliminate the Hamel pathology?

The answer is yes — and the proof is one line. This is the content of Chapter 8.

## 7.6 Where this leaves us

We have a complete picture of the discrete- and rational-coefficient story:

- *Cauchy 1821:* continuous additive ⟹ $\mathbb R$-linear, hence continuous solutions of $(J_2)$ are affine.
- *Darboux 1875:* monotone additive ⟹ $\mathbb R$-linear.
- *Hamel 1905:* without any regularity hypothesis, additive ⟸̸ $\mathbb R$-linear; counterexamples exist via Hamel bases (and AC).
- *Polish school 1920–1929:* the regularity dictionary — measurability, boundedness on a positive-measure set, boundedness on an interval, monotonicity, continuity-at-a-point all suffice.

The picture for $(\star)$ is *radically different*. We claim that no regularity hypothesis at all is needed: $(\star) \Rightarrow$ affine on its own. The pathology that lives in the additive equation has nowhere to live in $(\star)$.

We turn to the proof.

## Exercises for Chapter 7

**Exercise 7.1.** Verify Proposition 7.1 directly: take $G$ satisfying $(J_2)$, set $f := G - G(0)$, and verify $f(x+y) = f(x) + f(y)$ for all $x, y \in \mathbb R$ (with $0 \in I$ available).

**Exercise 7.2.** Use Theorem 7.4 to give a complete description of the solutions of $(J_2)$ that satisfy *each* of the following: (a) $G$ is continuous; (b) $G$ is Lebesgue measurable; (c) $G$ is monotone; (d) $G$ is bounded on $[0, 1]$.

**Exercise 7.3.** Let $f$ be a Hamel-pathological additive function. Construct a Hamel-pathological solution of $(J_{\mathbb Q})$ on $[0, 1]$ (not just on $\mathbb R$) by restricting $f$ to $[0, 1]$. Verify the construction.

**Exercise 7.4.** Verify Proposition 7.3 in both directions, paying attention to where $\mathbb Q$-homogeneity is used.

**Exercise 7.5 (harder).** Find an additive function on $\mathbb R$ (or a $(J_{\mathbb Q})$-solution on $[0, 1]$) that is *unbounded* on every interval but is *bounded above* on $[0, 1]$. (Hint: this is impossible by Ostrowski's Theorem 6.4. The exercise is to verify that — to articulate why no such function exists.)

---

# Chapter 8 — *The chord substitution: the main theorem*

> *"The simplest proof is sometimes the one no one expected."*

This chapter is the punch line of the monograph. We meet $(\star)$ in its full force, prove Theorem 1 by the chord substitution, examine the structural reason the Hamel pathology fails to apply to $(\star)$, and reflect on why the 80-year detour through regularity hypotheses was, with hindsight, a discussion of the wrong question.

## 8.1 The continuous-coefficient form $(\star)$, restated with care

> **Equation $(\star)$.** *For $G : I \to \mathbb R$ on a real interval $I$, the equation $(\star)$ requires*
> $$ p\, G(u_1) + (1-p)\, G(u_2) \;=\; G\bigl(p\, u_1 + (1-p)\, u_2\bigr) $$
> *to hold for **every** $u_1, u_2 \in I$ and **every** $p \in [0, 1]$.*

Compare with $(J_2)$, which only requires the identity at $p = \tfrac12$, and with $(J_{\mathbb Q})$, which requires it only at $p \in [0, 1] \cap \mathbb Q$.

The strengthening from $\mathbb Q$ to $\mathbb R$ in the range of $p$ is genuine. We know that $(J_2)$ and $(J_{\mathbb Q})$ have Hamel-pathological solutions (Theorem 7.4 plus Chapter 5). We will see that $(\star)$ does *not*.

## 8.2 Theorem 1 — the main result

> **Theorem 8.1 (The Chord Substitution Theorem).** *Let $M > 0$ and let $G : [0, M] \to \mathbb R$ satisfy $(\star)$ for every $u_1, u_2 \in [0, M]$ and every $p \in [0, 1]$. Then $G$ is affine on $[0, M]$:*
> $$ G(v) \;=\; \frac{G(M) - G(0)}{M}\, v \;+\; G(0) \qquad \text{for all } v \in [0, M]. $$
> *No regularity hypothesis on $G$ — continuity, measurability, boundedness, monotonicity — is needed.*

The conclusion is the strongest possible: $G$ is *explicitly* given as an affine function, with the slope and intercept determined by the values $G(0)$ and $G(M)$.

## 8.3 Proof — the chord substitution

The proof is one substitution.

**Proof of Theorem 8.1.** Fix $v \in [0, M]$. We will determine $G(v)$ by evaluating $(\star)$ at a specific choice of $(u_1, u_2, p)$.

*The chord substitution.* Set
$$
u_1 := M, \qquad u_2 := 0, \qquad p := \frac{v}{M}.
$$
Verify the constraints: $u_1 = M \in [0, M]$, $u_2 = 0 \in [0, M]$, and $p = v/M \in [0, 1]$ since $v \in [0, M]$. So this is a valid evaluation of $(\star)$.

Substitute into $(\star)$:
$$
p\, G(u_1) + (1-p)\, G(u_2) \;=\; G\bigl(p\, u_1 + (1-p)\, u_2\bigr)
$$
becomes
$$
\frac{v}{M}\, G(M) + \left(1 - \frac{v}{M}\right) G(0) \;=\; G\!\left(\frac{v}{M} \cdot M + \left(1 - \frac{v}{M}\right) \cdot 0\right) \;=\; G(v).
$$

Rearrange:
$$
G(v) \;=\; \frac{v}{M}\, G(M) + \left(1 - \frac{v}{M}\right) G(0) \;=\; G(0) + \frac{G(M) - G(0)}{M}\, v.
$$

Done. $G(v) = a v + b$ with $a = (G(M) - G(0))/M$ and $b = G(0)$. $\square$

The proof is complete. The chord substitution pins $G$ along the chord from $(0, G(0))$ to $(M, G(M))$ — and *every value of $G$ on $[0, M]$ is determined by this chord*. There is nothing else to check.

## 8.4 Corollary — $G$ is automatically regular

> **Corollary 8.2.** *Let $G : [0, M] \to \mathbb R$ satisfy $(\star)$. Then $G$ is:*
>
> 1. *Continuous on $[0, M]$;*
> 2. *Monotone on $[0, M]$ (non-decreasing if $G(M) \ge G(0)$; non-increasing otherwise);*
> 3. *Locally Lipschitz on $[0, M]$ (with Lipschitz constant $|G(M) - G(0)|/M$);*
> 4. *Absolutely continuous on $[0, M]$;*
> 5. *Lebesgue measurable on $[0, M]$.*

**Proof.** Affine functions on bounded intervals have all of these properties. $\square$

The order of inference is the point: under $(\star)$, regularity is the *conclusion*, not the hypothesis. Each of the regularity hypotheses we worked through in Chapters 2–6 is *automatically* satisfied by any solution of $(\star)$.

Therein lies the structural difference between $(J_2)$ and $(\star)$. In $(J_2)$, regularity must be *added as an extra hypothesis* (Cauchy's continuity, Darboux's monotonicity, Sierpiński's measurability) to rule out the Hamel pathology. In $(\star)$, no regularity hypothesis is added — and yet *all* the regularity properties follow.

## 8.5 Where does the Hamel pathology fail to apply?

We now investigate *why* the Hamel pathology, which kills uniqueness for $(J_2)$ and $(J_{\mathbb Q})$, does not kill uniqueness for $(\star)$.

Recall the structure of a Hamel-pathological solution $\ell : \mathbb R \to \mathbb R$ from Chapter 5: $\ell$ is $\mathbb Q$-linear, satisfies Cauchy, but is not $\mathbb R$-linear. So $\ell(qx) = q\, \ell(x)$ for $q \in \mathbb Q$, but $\ell(rx) \neq r\, \ell(x)$ for some irrational $r$.

The Hamel-pathological $\ell$ satisfies $(J_{\mathbb Q})$. Let us see what happens when we ask whether $\ell$ also satisfies $(\star)$ at an irrational $p$.

Restrict $\ell$ to $[0, M]$ — say $M = 1$, working with $G := \ell|_{[0, 1]}$ — and consider $(\star)$ at the chord configuration $u_1 = M = 1$, $u_2 = 0$, $p$ to be determined. The equation becomes
$$
p\, G(1) + (1-p)\, G(0) \;=\; G(p \cdot 1 + (1-p) \cdot 0) \;=\; G(p).
$$
That is:
$$
p\, \ell(1) + (1-p)\, \ell(0) \;=\; \ell(p),
$$
or equivalently (using $\ell(0) = 0$):
$$
p\, \ell(1) \;=\; \ell(p).
$$

This is the assertion that $\ell$ is $\mathbb R$-linear with slope $\ell(1)$ (i.e., $\ell(p) = p \ell(1)$). But by construction of the Hamel-pathological $\ell$, $\ell(p) \neq p \ell(1)$ for some irrational $p$. (For instance, $\ell(1) = 0$ but $\ell(h) = 1$ for some basis element $h$, with $h$ irrational. So at $p = h$ — which is in $[0, M] = [0, 1]$ if $h \in (0, 1)$ — the chord equation says $\ell(h) = h \cdot \ell(1) = 0$, contradicting $\ell(h) = 1$.)

So $\ell$ *violates* $(\star)$ at $p = h$, an irrational. Restricted to $[0, M]$, the Hamel pathology $\ell$ satisfies $(J_2)$ on $[0, M] \cap \mathbb R$, satisfies $(J_{\mathbb Q})$ on $[0, M] \cap \mathbb Q$, but *fails* $(\star)$ at every irrational $p$ where $\ell$ is not $\mathbb R$-linear (which is a dense set of irrationals).

> **Theorem 8.3.** *Let $\ell : \mathbb R \to \mathbb R$ be a Hamel-pathological additive function. Then on any nontrivial interval $[0, M] \subseteq \mathbb R_{> 0}$, the restriction $G := \ell|_{[0, M]}$ satisfies $(J_2)$ and $(J_{\mathbb Q})$ but fails $(\star)$ at every irrational $p \in (0, 1)$ where $\ell(pM) \neq p\, \ell(M)$.*

**Proof.** Direct from the discussion above. $\square$

## 8.6 The structural mechanism: the pathology lives at irrational $p$

The discussion of §8.5 is the *structural moral* of the monograph.

The Hamel pathology is built by giving an arbitrary value to $\ell$ on basis elements — including basis elements that are irrational reals — and extending $\mathbb Q$-linearly. The pathology *lives at the irrationals*: the $\mathbb Q$-rationals automatically inherit $\ell(q) = q \ell(1)$, but the irrationals can take arbitrary values inconsistent with $\mathbb R$-linearity.

Now look at the chord substitution. The choice $p = v/M$ in the proof of Theorem 8.1 ranges over $[0, 1]$ as $v$ ranges over $[0, M]$ — including *all the irrationals in $[0, 1]$*. The equation $(\star)$ then enforces an explicit pointwise value of $G$ at *every* point — rational or irrational — that is consistent with the chord from $(0, G(0))$ to $(M, G(M))$. Any Hamel pathology that tried to assign $G(p)$ differently at some irrational $p$ would *violate* $(\star)$ at that $p$, exactly as Theorem 8.3 shows.

So: the Hamel pathology lives at irrational $p$; the continuous-coefficient equation $(\star)$ rules out arbitrary behavior at irrational $p$; and the chord substitution is precisely the explicit consequence of this ruling-out.

> **The Hamel pathology lives at irrational $p$. The continuous-coefficient equation $(\star)$ forecloses on it there.**

That is the punch line. Equipped with this structural understanding, the chord substitution is no longer a clever trick; it is the *forced consequence* of the structure of the equation.

## 8.7 Why the 80-year detour was a wrong question

We can now look back at the historical arc with hindsight.

From 1821 to 1905, mathematicians asked: *is continuity necessary for Cauchy/Jensen affineness?* The answer turned out to be *yes, for the discrete-coefficient equation*. Hamel 1905 supplied the counterexample. The Polish school 1920–1929 supplied the dictionary of weaker regularity hypotheses that also suffice.

But the 80-year question was about $(J_2)$ — or equivalently $(J_{\mathbb Q})$ via Proposition 7.3. **No one was asking about $(\star)$**. Cauchy in 1821 did not write down $(\star)$; he wrote down $(J_2)$. Jensen in 1906 did not write down $(\star)$; he wrote down the rational-coefficient version $(J_{\mathbb Q})$. And in retrospect, this was the *wrong* equation to ask about.

The *right* equation is the continuous-coefficient one $(\star)$, and it solves itself trivially. The 80-year detour through Hamel and the Polish school is mathematically beautiful but is, strictly speaking, an answer to a question slightly different from the one that matters for applications.

This is not a criticism of Cauchy or Jensen or Hamel or Sierpiński. They were doing the mathematics that was askable at the time — and the discrete-coefficient version was the one that naturally arose in their applications (analysis of convex functions, the foundations of analysis). The *continuous-coefficient version* arises naturally in applications that came later (utility theory in the 1940s, surrogate calibration in the 1990s–2000s, the partition-Bayes-risk machinery of the main paper in the 2020s). The chord substitution becomes the canonical tool only for these later contexts — but it has always been one substitution away.

The lesson is in the broader pattern: when a famous classical question concerns the discrete or rational-coefficient version of a functional equation, *and the continuous-coefficient version arises naturally in a modern application*, ask whether the continuous-coefficient version trivializes. Often it does.

## Exercises for Chapter 8

**Exercise 8.1.** Re-prove Theorem 8.1 using the alternative chord: $u_1 := 0$, $u_2 := M$, $p := 1 - v/M$. Verify that the resulting formula agrees with the one in the theorem.

**Exercise 8.2.** Verify Corollary 8.2 in full: for each of the five regularity properties, give the explicit one-line proof from $G$ being affine.

**Exercise 8.3.** Let $\ell$ be the Hamel-pathological function constructed in Chapter 5 with $\sigma(1) = 0$ and $\sigma(h) = 1$ for $h \in H \setminus \{1\}$. Restrict $\ell$ to $[0, 1]$ and exhibit, by hand, an irrational $p \in (0, 1)$ at which $\ell$ violates $(\star)$. (Hint: pick $p = h$ for a basis element $h \in H \cap (0, 1)$.)

**Exercise 8.4.** Conclude from the proof of Theorem 8.1 that the *only* solutions of $(\star)$ on $[0, M]$ are the affines. Compare with Theorem 7.4 for $(J_2)$.

**Exercise 8.5.** Show that the *higher-coefficient* equation
$$ \sum_{i=1}^n p_i G(u_i) = G\!\left(\sum_{i=1}^n p_i u_i\right) \qquad \left(u_i \in I,\ p_i \in [0, 1],\ \sum p_i = 1\right) $$
for $n \ge 2$ is *equivalent* to $(\star)$ (= the $n = 2$ case). (Hint: any convex combination of $n$ points can be written iteratively as convex combinations of 2 points.)

**Exercise 8.6.** Show that the *strict-minimum* hypothesis
$$ p G(M) + (1-p) G(0) = G(p M) \qquad \text{for all } p \in [0, 1] $$
(the chord identity, *only* at $u_1 = M, u_2 = 0$) is *not* equivalent to $(\star)$ as an a priori hypothesis on $G$ — but is sufficient to conclude $G$ is affine on $[0, M]$. Cf. Theorem 1$'$ in Chapter 9 (= the satellite's Theorem 1$'$).

**Exercise 8.7 (frontier).** State and prove a chord substitution-style theorem for *concave* $G$: if $G$ is concave on $[0, M]$ and $(\star)$ holds with equality (as we have throughout), conclude $G$ is affine. (Hint: this is essentially Jensen's inequality with equality — which is the equation $(\star)$ in disguise.)

---

# Chapter 9 — *Variants and dimensions*

> *"Generality is sometimes the strongest form of insight."*

This chapter shows that the chord substitution of Chapter 8 is robust under three natural generalizations: a strict-minimum-hypothesis version of Theorem 1; a higher-dimensional version on convex subsets of $\mathbb R^n$; and the contrast with $(J_{\mathbb Q})$, which retains the Hamel pathology (Proposition 4 of the satellite). We treat each briefly.

## 9.1 Theorem 1$'$: the strict-minimum hypothesis

The proof of Theorem 8.1 uses $(\star)$ at *only one* configuration: $u_1 = M$, $u_2 = 0$, $p \in [0, 1]$ free. The full force of $(\star)$ — for every $(u_1, u_2)$ — is not consumed. We isolate the strict minimum.

> **Theorem 9.1 (Theorem 1$'$ of the satellite).** *Let $M > 0$ and let $G : [0, M] \to \mathbb R$ satisfy*
> $$ p\, G(M) + (1-p)\, G(0) \;=\; G(p M) \qquad \text{for all } p \in [0, 1]. \tag{$\star_0$} $$
> *Then $G(v) = G(0) + \bigl(G(M) - G(0)\bigr)\, v/M$ on $[0, M]$.*

**Proof.** Set $p = v/M$ in $(\star_0)$. The argument is identical to Theorem 8.1. $\square$

The equation $(\star_0)$ is in principle weaker than $(\star)$ — the hypothesis only specifies the chord through the endpoints, not the entire two-parameter family of convex combinations. Under the conclusion (affineness), both hold.

In practice, an author who *derives* $(\star)$ from a richer setup typically has access to the full equation (every $(u_1, u_2, p)$). The strict-minimum form $(\star_0)$ is the *cleanest reference* for an author who wants to know how much of $(\star)$ the proof consumes.

The point is pedagogical and stylistic: when you see a derivation that produces $(\star)$ from saturation of Jensen's inequality, you don't need the full equation — just the chord identity at the endpoint configuration. The two are equivalent under the conclusion.

## 9.2 Higher dimensions

Theorem 8.1 generalizes verbatim to convex subsets of real vector spaces.

> **Theorem 9.2 (Higher-dimensional chord substitution).** *Let $V$ be a real vector space, let $C \subseteq V$ be a convex set, and let $G : C \to \mathbb R$ satisfy*
> $$ p\, G(x_1) + (1-p)\, G(x_2) \;=\; G\bigl(p\, x_1 + (1-p)\, x_2\bigr) \qquad (x_1, x_2 \in C,\ p \in [0, 1]). $$
> *Then there is a linear functional $a : \mathrm{span}(C - C) \to \mathbb R$ and a constant $b \in \mathbb R$ such that $G(x) = a(x - x_0) + b$ on $C$, for any fixed $x_0 \in C$. Equivalently, $G$ is affine on $C$.*

**Proof sketch.** Fix $x_0 \in C$. For each direction $v$ with $x_0 + v \in C$, apply Theorem 8.1 to the chord $\{x_0 + \lambda v : \lambda \in [0, 1]\}$ — a segment in $C$ — to conclude that $\lambda \mapsto G(x_0 + \lambda v)$ is affine in $\lambda$. Hence $G(x_0 + v) - G(x_0)$ depends linearly on $v$ in each direction.

Then the additivity of these increments — that $G(x_0 + v_1 + v_2) - G(x_0) = (G(x_0 + v_1) - G(x_0)) + (G(x_0 + v_2) - G(x_0))$ — follows by applying $(\star)$ in a 2-dimensional affine span of $\{x_0, x_0 + v_1, x_0 + v_2\}$ and a careful bookkeeping.

A clean reference for the bookkeeping is Aczél–Dhombres [2, Ch. 13]. $\square$

The structural moral is the same: the chord substitution does the heavy lifting in dimension 1, and the higher-dimensional generalization is a bookkeeping exercise that turns chord-affineness into joint affineness on the convex set.

## 9.3 The rational-coefficient version $(J_{\mathbb Q})$ does retain the pathology

The chord substitution is unique to the *continuous-coefficient* form $(\star)$. The rational-coefficient form $(J_{\mathbb Q})$ retains the Hamel pathology, as we observed in Chapter 5 (Hamel pathologies satisfy $(J_{\mathbb Q})$ but not $(\star)$ at irrational $p$).

We give the explicit witness in §4.3 of the satellite as Proposition 4 (re-stated here as Proposition 9.3 for monograph completeness).

> **Proposition 9.3 (Folklore, Hamel-style pathology on $[0, 1]$).** *There exists $G : [0, 1] \to \mathbb R$ satisfying $(J_{\mathbb Q})$ (and hence $(J_2)$) on $[0, 1]$ that is not affine.*

**Construction.** Choose a Hamel basis $H$ of $\mathbb R$ over $\mathbb Q$ containing $1$ and an irrational $h \in (0, 1)$. Define a $\mathbb Q$-linear $\ell : \mathbb R \to \mathbb R$ by $\ell(1) := 0$, $\ell(h) := 1$, and arbitrarily on the remaining basis elements. By the same argument as in Chapter 5 §5.2, $\ell$ satisfies Cauchy's equation on $\mathbb R$, hence satisfies $(J_2)$ on $\mathbb R$, hence satisfies $(J_{\mathbb Q})$ on $\mathbb R$.

Restrict to $[0, 1]$: $G := \ell|_{[0, 1]}$. The restriction satisfies $(J_{\mathbb Q})$ on $[0, 1]$ since $\mathbb Q$-rational convex combinations of points in $[0, 1]$ remain in $[0, 1]$, and $\ell$ is $\mathbb Q$-linear on all of $\mathbb R$.

Witness that $G$ is not affine: $G(h) = \ell(h) = 1$, while $G(q) = \ell(q) = q \ell(1) = 0$ for every rational $q \in [0, 1]$. Any affine $A : [0, 1] \to \mathbb R$ with $A(0) = G(0) = 0$ and $A(q) = 0$ for all rationals $q \in [0, 1]$ would have to be $A \equiv 0$, contradicting $G(h) = 1$. So $G$ is not affine. $\square$

Proposition 9.3 sharpens the chord substitution theorem: the strengthening from $\mathbb Q$ to $\mathbb R$ in the coefficient range is *doing real work*. Without it, regularity hypotheses become necessary; with it, they are vestigial.

This is the contrast that makes the chord substitution a genuine result, not a trivial reformulation. The transition from $(J_{\mathbb Q})$ to $(\star)$ is the difference between "Hamel pathology survives, regularity required" and "no Hamel pathology, no regularity required". The 80-year detour was about the first regime; the chord substitution lives in the second.

## 9.4 The dictionary, with proofs

We close this chapter by collecting the satellite's Table 1 with the proofs we have now assembled.

| Hypothesis on $G$ | Required for $(J_2) \Rightarrow$ affine? | Required for $(\star) \Rightarrow$ affine? |
|---|---|---|
| **Continuity on $I$** | Yes — Cauchy 1821 (Thm. 2.3). | **No** — affineness is the conclusion (Cor. 8.2). |
| **Measurability on $I$** | Yes — Sierpiński 1920 (Thm. 6.2). | **No** — same. |
| **Monotonicity on $I$** | Yes — Darboux 1875 (Thm. 3.1). | **No** — same. |
| **Boundedness on a set of positive measure** | Yes — Steinhaus 1920 (Thm. 6.3). | **No** — same. |
| **Boundedness on $I$** | Yes — Ostrowski 1929 (Thm. 6.4). | **No** — same. |
| **None** (no regularity hypothesis at all) | **Insufficient** — Hamel pathology (Thm. 5.2). | **Sufficient** — Thm. 8.1. |

The dictionary is the central pedagogical artifact of the monograph. Every row of column 2 is proved in the monograph; every row of column 3 is a corollary of Theorem 8.1. The bottom row of column 2 is the Hamel pathology; the bottom row of column 3 is the punch line.

## Exercises for Chapter 9

**Exercise 9.1.** Prove Theorem 9.1 (= Theorem 1$'$) in full.

**Exercise 9.2.** Verify Theorem 9.2 in dimension 2: take $C = [0, 1]^2 \subseteq \mathbb R^2$, and verify that if $G : C \to \mathbb R$ satisfies the 2D version of $(\star)$, then $G(x_1, x_2) = a_1 x_1 + a_2 x_2 + b$ for some constants.

**Exercise 9.3 (harder).** State a higher-dimensional Hamel-style pathology: a $\mathbb Q$-linear function $f : \mathbb R^2 \to \mathbb R$ that is not $\mathbb R$-linear. (Hint: pick a $\mathbb Q$-basis of $\mathbb R^2 = \mathbb R \times \mathbb R$ as a $\mathbb Q$-vector space, define $f$ arbitrarily on basis elements, extend.)

**Exercise 9.4.** Verify Proposition 9.3's construction by hand: take $h := 1/\sqrt 2 \in (0, 1)$ — but $1/\sqrt 2$ is irrational, so this is OK. Define $\ell(1) = 0$, $\ell(1/\sqrt 2) = 1$, extend $\mathbb Q$-linearly. Verify that $\ell$ is not affine on $[0, 1]$.

**Exercise 9.5.** Use the table in §9.4 to argue: there is no regularity hypothesis weaker than "bounded on a positive-measure set" that suffices for $(J_2) \Rightarrow$ affine. (I.e., the Polish school's dictionary is essentially tight.)

---

# Chapter 10 — *Why this matters: a tour of applications*

> *"The substance of a theorem is not the proof but the chain of contexts in which it is invoked."*

The chord substitution is a one-line proof of a folkloric result. Yet, as we shall see, it surfaces in a number of *modern* contexts where the equation $(\star)$ arises naturally and where invoking the Hamel/Cauchy regularity machinery is unnecessary and distracting. This chapter tours four such contexts. They are: utility theory (von Neumann–Morgenstern 1944); Shannon entropy's axiomatic characterization (Khinchin 1957, Faddeev 1956); surrogate calibration in statistical decision theory (Bartlett–Jordan–McAuliffe 2006 and later); and the partition-Bayes-risk machinery from the main paper [El2] (2026). In each case, the chord substitution closes the relevant affineness step without invoking continuity, measurability, or boundedness as hypotheses.

The chapter is brief — five pages — and meant to whet the reader's appetite for the modern literature on applications. Detailed references are in Appendix C.

## 10.1 Von Neumann–Morgenstern utility theory

In their *Theory of Games and Economic Behavior* (1944), John von Neumann and Oskar Morgenstern axiomatized the conditions under which a rational agent's preferences over lotteries can be represented by a utility function with a specific structural property: *linearity in probability*. That is, if $L_1$ and $L_2$ are lotteries and $p \in [0, 1]$ is a probability, then the agent's utility for the mixed lottery $p L_1 + (1-p) L_2$ is
$$
U(p L_1 + (1-p) L_2) = p\, U(L_1) + (1-p)\, U(L_2). \tag{$\dagger$}
$$
This is the equation $(\star)$ with the lotteries playing the role of the points $u_1, u_2$. The von Neumann–Morgenstern axiomatization establishes that any preference relation over lotteries that satisfies certain axioms (completeness, transitivity, the *Archimedean axiom*, the *independence axiom*) is represented by a utility function $U$ satisfying $(\dagger)$.

The Archimedean axiom — *for any lotteries $L_1, L_2, L_3$ with $L_1 \succ L_2 \succ L_3$, there exist $p, q \in (0, 1)$ with $p L_1 + (1-p) L_3 \succ L_2 \succ q L_1 + (1-q) L_3$* — is exactly the "we can mix between best and worst to interpolate any intermediate level" condition that, in conjunction with the other axioms, forces $(\dagger)$.

The Herstein–Milnor axiomatization (1953) of expected utility, which sharpens von Neumann–Morgenstern, derives $(\dagger)$ from the Archimedean axiom + independence + a continuity-like axiom on preferences. The proof — in the classical 1953 presentation — invokes the Archimedean axiom to substitute for what would otherwise be a regularity hypothesis on $U$.

In retrospect, the *chord substitution* gives an alternative closure: the Archimedean axiom is one way to close the affineness step, and the chord substitution is another (cleaner) way. Both work; they are different paths to the same conclusion.

The lesson: in mid-20th-century utility theory, the affineness step in the proof of expected utility representation was closed by a separate axiom (Archimedean). With the chord substitution available, that step could in principle be closed without invoking an axiom of preferences — directly from the algebraic structure of $(\dagger)$.

## 10.2 Shannon entropy's axiomatic characterization

Claude Shannon's 1948 paper *A Mathematical Theory of Communication* introduced what we now call **Shannon entropy**, the function
$$
H(p_1, \ldots, p_n) = -\sum_{i=1}^n p_i \log p_i
$$
on probability distributions $(p_1, \ldots, p_n) \in \Delta^{n-1}$. Shannon proved (and Khinchin, Faddeev, and others later axiomatized rigorously) that $H$ is the *unique* continuous function on $\bigcup_n \Delta^{n-1}$ — up to a multiplicative constant — that satisfies three natural conditions:

1. **Continuity** in the arguments.
2. **Maximization at uniform distribution**: $H(1/n, \ldots, 1/n) = \log n$ is the maximum over $\Delta^{n-1}$.
3. **Recursivity** (the Khinchin–Faddeev axiom): a precise way of saying that the entropy of a joint distribution is the entropy of a marginal plus the conditional entropy of the rest.

In the modern axiomatic treatment (Aczél 1966, Aczél–Dhombres 1989), the recursivity axiom is reduced to a functional equation of a similar form to $(\star)$:
$$
H_2(p, 1-p) + (1-p) H_n(q_1/(1-p), \ldots, q_n/(1-p)) = H_{n+1}(p, q_1, \ldots, q_n)
$$
plus other axioms.

In the derivation, an intermediate step asks for the unique continuous function $g : [0, 1] \to \mathbb R$ satisfying a certain functional equation that reduces, in a 2-cell case, to $(\star)$ on $[0, 1]$. The standard treatment invokes continuity to close the equation; the chord substitution closes it without continuity.

The lesson: in the axiomatic foundations of information theory, the chord substitution can replace continuity in the closure of the functional equation, simplifying the foundational proof.

## 10.3 Surrogate calibration in statistical decision theory

Modern statistical decision theory studies *calibration* of surrogate loss functions: given a classification problem with the 0–1 loss, how should one choose a *surrogate* convex loss (logistic, exponential, hinge, etc.) so that minimizing the surrogate-loss expected risk approximately minimizes the 0–1 expected risk?

The foundational papers in this area are:

- Bartlett, Jordan, McAuliffe (2006), *Convexity, classification, and risk bounds*: the $\psi$-transform construction relating surrogate excess risk to 0–1 excess risk via the biconjugate of a level-set gap.
- Tewari, Bartlett (2007), multiclass extension.
- Steinwart (2007), unifying framework.
- Reid, Williamson (2010, 2011), composite binary losses and the information–divergence–risk picture.

All of these papers derive their calibration results via *convex analysis* — biconjugates, Fenchel duality, supporting hyperplanes — and never produce $(\star)$ as a saturated equation. The reason: convex-analysis derivations track Jensen's inequality with explicitly controlled slack and never push it to saturation.

In the *main paper* [El2] (2026), the chord substitution arises because the *resolution-axis transposition* framing of partition-based classifier calibration pushes Jensen's inequality to saturation directly. The equation $(\star)$ appears as a load-bearing step. The chord substitution closes it in one line.

The lesson: the chord substitution is the natural closure tool whenever a calibration-theory argument pushes Jensen to saturation. This is a structural property of the *derivation style*, not of the topic.

## 10.4 The partition-Bayes-risk story (main paper)

The application that motivated this monograph is the main paper [El2], which studies the achievable error floor of partition-based classifiers (graph neural networks, etc.) by transposing surrogate calibration from the optimization axis to the resolution axis.

In §4.2 Step 2 of [El2], the authors derive an identity of the form $(\star)$ for a function $G : [0, \varphi_{\max}] \to \mathbb R$ that expresses the Bayes risk of a partition-based classifier as a function of an aggregated concave score, where $u_1, u_2$ are the per-cell score values and $p$ is the cell mass. The cell mass is *free* on an atomless underlying probability space, so $(\star)$ holds in its full force.

In the original draft of [El2], the affineness step invoked an "$G$ is bounded so the bounded-Jensen-implies-affine theorem applies" parenthetical — a *vestigial* regularity hypothesis. In a Lean 4 mechanization, the corresponding lemma `affine_of_jensen_eq` was declared with a boundedness hypothesis in its signature; the proof body then showed that the hypothesis was *unused*, by the chord substitution.

The corresponding *Comptes Rendus Mathématique* satellite (the companion to this monograph) extracts the chord substitution as a standalone note, articulates the dictionary of vestigial regularity hypotheses, and provides a one-line citation point for any future author who derives $(\star)$ in their own work.

The lesson: in modern applied analysis, the chord substitution is a *practical* tool for retiring unnecessary regularity hypotheses in derivations that produce $(\star)$ as a saturated identity. The monograph is the pedagogical companion to the citation point.

## 10.5 A reading list for further exploration

For the reader who wants to go further, Appendix C provides an annotated bibliography. Highlights:

- **For the functional-equations literature**: Aczél (1966) is the encyclopedic starting point. Kuczma (2009 2nd ed.) is the gold standard for Cauchy/Jensen and the Hamel pathology. *Aequationes Mathematicae* is the dedicated journal.
- **For the Hamel pathology and descriptive set theory**: Solovay (1970) on models of ZF + DC; Kechris (1995) on descriptive set theory.
- **For Hyers–Ulam stability**: the question of *how close* a function that *almost* satisfies a functional equation must be to an *exact* solution. Hyers (1941), Ulam (1960), Hyers–Isac–Rassias (1998).
- **For the calibration applications**: Bartlett–Jordan–McAuliffe (2006), Reid–Williamson (2011), the main paper [El2] (2026), and the satellite (also 2026).

The functional-equations literature is alive and active. The chord substitution is a tiny piece of it. The reader is invited to explore.

## Exercises for Chapter 10

**Exercise 10.1.** Read the Herstein–Milnor (1953) axiomatization of expected utility. Identify the step where the Archimedean axiom is used to close the linearity equation, and articulate how the chord substitution offers an alternative closure.

**Exercise 10.2.** Read Khinchin's *Mathematical Foundations of Information Theory* (1957) Chapter 1. Identify the functional equation that arises in the derivation of Shannon entropy, and check whether the chord substitution applies.

**Exercise 10.3 (open-ended).** Find a calibration-theory paper that derives an equation of the form $(\star)$, and check whether they invoke a vestigial regularity hypothesis. If yes, articulate (in your own words) how the chord substitution would simplify their derivation.

**Exercise 10.4 (frontier).** Read the main paper [El2] §4.2 Step 2 (the satellite [E1] is a more accessible version). Verify that the equation $(\star)$ arises naturally from the resolution-axis transposition framing, and that the chord substitution closes the affineness step.

---
