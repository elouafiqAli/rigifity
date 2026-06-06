# The Chord Substitution — Part I

## Act I — *The Question*

*Draft 0.0 — Preface + Chapters 1, 2, 3. Authored 2026-06-07.*

---

# Preface — *How to read this book*

This monograph is a sustained encounter with a single functional equation,
$$
p\, G(u_1) + (1-p)\, G(u_2) \;=\; G\bigl(p\, u_1 + (1-p)\, u_2\bigr),
$$
imposed on a function $G : [0, M] \to \mathbb R$ for every $u_1, u_2 \in [0, M]$ and every $p \in [0, 1]$. The reader will discover that the equation has a one-line proof — but also that it took mathematics nearly a hundred years to reach the form in which that proof becomes one line. The path between the two ideas runs through Cauchy's *Cours d'analyse* (1821), through the axiom of choice (1904), through Georg Hamel's construction of a wild additive function (1905), through the Polish school of analysis in the 1920s, and through several distinct ways of asking what *regularity* means for a real-valued function. The monograph tells that story in full.

The intended reader is a senior undergraduate in mathematics — third or fourth year of a major degree at a research-active university. We assume real analysis at the level of Rudin or Pugh: $\varepsilon$–$\delta$ continuity, sequences, the intermediate value theorem, the Heine–Borel theorem, and the definition of Lebesgue measure on $\mathbb R$. We assume linear algebra at the level of one full course: vector spaces, bases, dimension, and the willingness to think of $\mathbb R$ as a $\mathbb Q$-vector space. We assume abstract algebra and topology at the level of one course each: Zorn's lemma is met (or re-met) in Chapter 4, the axiom of choice is discussed there, and the topology used throughout is the standard topology of the real line.

We do **not** assume previous acquaintance with functional equations. Several chapters are devoted to building the intuition slowly. If the reader has met Cauchy's equation before in a problem-solving olympiad or a graduate course, those chapters will be a pleasant reorientation; if not, they are a self-contained first encounter.

**How to use the book.** Read the chapters in order. Each chapter ends with five to eight exercises. The exercises are not optional and they are not decorative — they are the way the reader earns the mathematics. Approximately a third of them have hints or full solutions in Appendix B; the others are left for the reader to wrestle with. A subset of capstone exercises (marked *frontier* in the chapter exercise sets) point forward to questions the monograph does not answer — Solovay's model, descriptive set theory, the *Aequationes Mathematicae* literature.

**A note on the axiom of choice.** Chapter 4 is the moment when the axiom of choice enters the story constructively. For many undergraduate readers, this is the first time they see AC deployed to *build a concrete object* (a Hamel basis) rather than as a foundational axiom invoked in proofs of, say, Tychonoff's theorem. The chapter slows down here. The reader who is new to AC is encouraged to read Chapter 4 twice — once for the construction, once for the meta-mathematical placement.

**Acknowledgments.** This monograph grew out of two companion works of the author: a one-line research note on the chord substitution submitted to *Comptes Rendus Mathématique* (the satellite paper), and a longer research manuscript on the achievable error floor of partition-based classifiers (the main paper) in which the equation surfaced as a load-bearing step. Three project skills documented in the source repository — the step-by-step proving discipline, the adversarial-audit cycle, and the WSL bridge for Lean-based formalization — shaped the development of both companion works and indirectly this monograph. The seven-round audit trail of the main paper, the multi-phase strategy of the satellite, and the open project-skills repository are part of the record.

The author thanks the Polish school of analysis — Sierpiński, Steinhaus, Banach — whose names this monograph carries forward, and Marek Kuczma, whose treatise [9] is the canonical source for everything we say about Hamel bases and functional equations. Any pedagogical infelicity is the author's responsibility; the mathematics is theirs.

— *The author, 2026*

---

# Chapter 1 — *One equation, three faces*

> *"A great deal of mathematics consists of looking at a single object until it dissolves into a more general one."* — *(an aphorism in the spirit of Bourbaki)*

This chapter introduces the equation that the rest of the monograph studies, and the central puzzle it raises. We meet three forms of the equation, distinguish them carefully, and state — without proof — the punch line that the monograph spends nine more chapters earning.

## 1.1 The opening puzzle

When is a real-valued function "linear"?

The question is more delicate than it sounds. In a course on linear algebra, a *linear* function from $\mathbb R$ to $\mathbb R$ is one of the form $f(x) = ax$ for some constant $a \in \mathbb R$. In a course on real analysis, by contrast, the word "linear" is often used loosely for *affine* — a function of the form $G(x) = ax + b$ with both $a$ and $b$ in $\mathbb R$. The two notions differ exactly by the constant $b$.

For the rest of this monograph we use the convention that **affine** means $G(x) = ax + b$, and **linear** means $f(x) = ax$. (A function is linear in our sense iff it is affine and passes through the origin.)

Given this terminology, we ask: *what condition on a function $G$ forces $G$ to be affine?* There are many sufficient conditions one could think of:

- $G$ is continuously differentiable with $G''(x) \equiv 0$.
- $G$ is twice differentiable with $G''(x) \equiv 0$ almost everywhere.
- $G$ is convex and concave on $\mathbb R$.
- $G$ has graph contained in a straight line.

Each of these would force $G$ affine in a way that uses *smoothness* (differentiability) or *geometric structure* (graph in a line) as the hammer. We will instead pursue a different, much weaker, *purely algebraic* sufficient condition: $G$ satisfies a single functional equation. The question is which functional equation, and how much algebra it can do without help from regularity.

## 1.2 Three equations side-by-side

We meet the equation in three forms, increasingly demanding on the coefficient~$p$.

The first form is **discrete-coefficient**: the coefficient is fixed at $p = \tfrac12$.

> **Equation $(J_2)$.** For all $u_1, u_2 \in I$,
> $$ G\!\left(\tfrac{u_1 + u_2}{2}\right) \;=\; \tfrac{G(u_1) + G(u_2)}{2}. $$

This equation says that $G$ commutes with the binary operation "take the midpoint of two real numbers." It is the equation Johan Jensen wrote down in 1906 in his celebrated paper on concavity; equivalently (set $f(x) := G(x) - G(0)$), it is the additive Cauchy equation $f(x+y) = f(x) + f(y)$. We shall meet both formulations.

The second form is **rational-coefficient**: $p$ ranges over rationals in $[0, 1]$.

> **Equation $(J_{\mathbb Q})$.** For all $u_1, u_2 \in I$ and all $p \in [0, 1] \cap \mathbb Q$,
> $$ p\, G(u_1) + (1-p)\, G(u_2) \;=\; G\bigl(p\, u_1 + (1-p)\, u_2\bigr). $$

This equation strengthens $(J_2)$: instead of just the midpoint, it asks that *every* rational convex combination of two points be mapped to the rational convex combination of their images. We shall see in Chapter 7 that $(J_{\mathbb Q})$ is in fact equivalent to $(J_2)$ as a set of constraints on $G$ — the strengthening is illusory, the same pathology survives.

The third form is **continuous-coefficient**: $p$ ranges over all of $[0, 1]$.

> **Equation $(\star)$.** For all $u_1, u_2 \in I$ and all $p \in [0, 1]$,
> $$ p\, G(u_1) + (1-p)\, G(u_2) \;=\; G\bigl(p\, u_1 + (1-p)\, u_2\bigr). $$

This equation strengthens $(J_{\mathbb Q})$ by asking the identity to hold at every $p \in [0, 1]$, including the irrational ones. *This strengthening is genuine* — it is the strongest of the three. And, the punch line of the monograph, it is the one that solves itself without any regularity assumption on $G$.

## 1.3 The first surprise — and a deferred proof

Here is the main result of the monograph.

> **Theorem.** *Let $M > 0$ and let $G : [0, M] \to \mathbb R$ satisfy $(\star)$ for every $u_1, u_2 \in [0, M]$ and every $p \in [0, 1]$. Then $G$ is affine on $[0, M]$, of the form*
> $$ G(v) \;=\; \frac{G(M) - G(0)}{M}\, v \;+\; G(0). $$
> *No regularity hypothesis on $G$ is needed.*

The proof is short enough to fit in a single paragraph. Fix $v \in [0, M]$. Set $u_1 := M$, $u_2 := 0$, and $p := v/M \in [0, 1]$ in $(\star)$:
$$
\frac{v}{M}\, G(M) + \left(1 - \frac{v}{M}\right) G(0) \;=\; G\!\left(\frac{v}{M} \cdot M + \left(1 - \frac{v}{M}\right) \cdot 0\right) \;=\; G(v).
$$
Rearranging, $G(v) = G(0) + (G(M) - G(0))\, v/M$. $\square$

That is the entire proof. We will redo it carefully in Chapter 8, with full attention to what is *not* being used (continuity? measurability? boundedness?), but the proof itself is already done.

So why does this monograph have ten chapters and three appendices?

Because the corresponding result for the discrete-coefficient equation $(J_2)$ is *false* without a regularity hypothesis. There exist non-affine functions on $\mathbb R$ that satisfy $(J_2)$ everywhere. They are wild — graphs dense in $\mathbb R^2$, not measurable, not continuous at a single point — and constructing them requires the axiom of choice. The first such construction is Hamel's, in 1905, and the appearance of his pathology in print was a small earthquake in classical analysis.

The remainder of the monograph is the story of how mathematics learned, slowly and painfully, that the natural form of Jensen's equation — the *continuous-coefficient* form $(\star)$ — is a different equation from the discrete-coefficient form $(J_2)$, and that the former does not admit the pathology that the latter does.

## 1.4 Roadmap

The monograph is structured as a three-act narrative.

- **Act I (Chapters 1–3).** We meet the question, see Cauchy's natural proof from continuity (Chapter 2), and watch Darboux refine the regularity hypothesis to monotonicity in 1875 (Chapter 3). At the end of Act I, the question is sharp: *what is the minimum regularity hypothesis that forces affineness?*
- **Act II (Chapters 4–6).** We meet the tool that creates the pathology (Hamel basis, Chapter 4), construct the pathology itself (Chapter 5), and survey the Polish school's 1920s resolution: any tameness hypothesis you can name suffices (Chapter 6). At the end of Act II, the question is *answered* — for the discrete- and rational-coefficient versions $(J_2)$, $(J_{\mathbb Q})$.
- **Act III (Chapters 7–10).** We treat the rational-coefficient version $(J_{\mathbb Q})$ (Chapter 7), meet the continuous-coefficient version $(\star)$ and prove the theorem (Chapter 8), survey variants and dimensions (Chapter 9), and tour applications outside pure analysis (Chapter 10).

The three appendices are: a historical timeline (Appendix A), hints and solutions to selected exercises (Appendix B), and a curated reading list for further exploration (Appendix C).

The reader who wants the result and not the story can read Chapter 8 in isolation — but will leave thinking the chord substitution is a clever trick. The reader who wants to understand *why* the chord substitution is the right tool, and *what 19th- and 20th-century analysis was trying to do*, must read the monograph from the beginning.

## Exercises for Chapter 1

> *Exercises are central to the monograph. Approximately a third of them have hints or full solutions in Appendix B; the others are for the reader to wrestle with.*

**Exercise 1.1.** Let $G(x) = ax + b$. Verify directly that $G$ satisfies $(J_2)$, $(J_{\mathbb Q})$, and $(\star)$ on any interval $I \subseteq \mathbb R$.

**Exercise 1.2.** Let $G(x) = x^2$ on $I = [0, 1]$. Find an $(u_1, u_2)$ and a $p \in (0, 1)$ at which $G$ violates $(J_2)$. (You will find that the violation is by a positive amount, proportional to $(u_1 - u_2)^2$.)

**Exercise 1.3.** Let $G(x) = \lfloor x \rfloor$ on $I = [0, 2]$. Find an $(u_1, u_2)$ at which $G$ violates $(J_2)$.

**Exercise 1.4.** Show that $(\star)$ is strictly stronger than $(J_2)$, in the sense that any solution of $(\star)$ is a solution of $(J_2)$ but not necessarily conversely. (For *not necessarily conversely*, you will need to wait until Chapter 5; for now, just establish the *any solution of $(\star)$* direction.)

**Exercise 1.5.** Suppose $G : \mathbb R \to \mathbb R$ satisfies $(\star)$ on every interval $I = [0, M]$ for every $M > 0$. Show that $G$ is affine on the entirety of $[0, \infty)$. Extend to $\mathbb R$ — what additional structure is needed?

**Exercise 1.6.** *(Open-ended.)* Suggest a function $G : \mathbb R \to \mathbb R$ that satisfies $(J_2)$ everywhere but does *not* satisfy $(\star)$ at every $p$. (You may not be able to write down such a function explicitly. Chapter 5 explains why, and how to construct one using the axiom of choice.)

---

# Chapter 2 — *Cauchy 1821: the natural proof*

> *"Quoi qu'il en soit, et bien que je n'aie publié sur ce sujet que ce traité…"* — Augustin Louis Cauchy, *Cours d'analyse*, Préface, 1821.

We open with the equation Augustin Louis Cauchy wrote down in 1821 in his *Cours d'analyse de l'École royale polytechnique*, and the proof — which any 19th-century analyst would have called *natural* — that a continuous solution is affine. The proof is in two steps, both of which use continuity. The chapter ends with the historical context: why Cauchy was asking the question, what it meant in 1821, and what tools he had at his disposal.

## 2.1 Cauchy's equation

Set $f(x) := G(x) - G(0)$. The equation $(J_2)$ at $u_1 = x$, $u_2 = y$ becomes
$$
f\!\left(\tfrac{x + y}{2}\right) \;=\; \tfrac{f(x) + f(y)}{2},
$$
which (by the substitution $\tilde x = x + y$, $\tilde y = x - y$, after some algebra; see Exercise 2.1) is equivalent on $\mathbb R$ to the *additive* Cauchy equation
$$
f(x + y) \;=\; f(x) + f(y) \qquad \text{for all } x, y \in \mathbb R. \tag{$C$}
$$

So studying $(J_2)$ on $\mathbb R$ is equivalent to studying $(C)$ on $\mathbb R$, with the connection $G(x) = f(x) + G(0) = f(x) + b$. Solutions of $(C)$ are called **additive functions**; the original Cauchy equation is the additive one. If $f$ is additive and we want $G$ from $f$, just add the constant $b = G(0)$.

The same reduction works on any interval $I$ that is closed under the operations $(x, y) \mapsto (x+y)/2$ and $(x, y) \mapsto x + y$ — e.g., a translate of $I = [0, M]$ to $[-M/2, M/2]$ centered at the origin.

Throughout this chapter we work with $(C)$ on $\mathbb R$. We will say *additive function* when we mean a solution of $(C)$ and *affine function* when we mean an $\mathbb R$-linear plus a constant — i.e., a $G$ of the form $G(x) = ax + b$.

## 2.2 Step 1: continuity implies $\mathbb Q$-homogeneity

Assume $f : \mathbb R \to \mathbb R$ is additive: $f(x + y) = f(x) + f(y)$ for all $x, y$. From the additivity alone, with no continuity, we extract first the most basic structural consequence.

**Lemma 2.1.** *If $f$ is additive on $\mathbb R$, then $f(0) = 0$ and $f(-x) = -f(x)$ for every $x \in \mathbb R$.*

**Proof.** Set $x = y = 0$: $f(0) = f(0 + 0) = f(0) + f(0) = 2f(0)$, so $f(0) = 0$. Set $y = -x$: $0 = f(0) = f(x + (-x)) = f(x) + f(-x)$, so $f(-x) = -f(x)$. $\square$

**Lemma 2.2 ($\mathbb Q$-homogeneity).** *If $f$ is additive on $\mathbb R$, then for every $q \in \mathbb Q$ and every $x \in \mathbb R$,*
$$ f(q x) \;=\; q\, f(x). $$

**Proof.** Three steps.

*First*, for $n \in \mathbb N_0$, induction on $n$ gives $f(nx) = nf(x)$: trivially $f(0 \cdot x) = f(0) = 0 = 0 \cdot f(x)$, and $f((n+1)x) = f(nx + x) = f(nx) + f(x) = nf(x) + f(x) = (n+1)f(x)$.

*Second*, for $n \in \mathbb Z$ negative, $f(nx) = -f((-n)x) = -((-n) f(x)) = n f(x)$, by Lemma 2.1.

*Third*, for $n \in \mathbb N$ positive and $y \in \mathbb R$, $n \cdot f(y/n) = f(n \cdot (y/n)) = f(y)$, so $f(y/n) = f(y)/n$.

Combine: for $q = m/n$ with $m \in \mathbb Z$, $n \in \mathbb N$, $f(qx) = f(mx/n) = m f(x/n) = (m/n) f(x) = q f(x)$. $\square$

Lemma 2.2 says exactly that $f$ is **$\mathbb Q$-linear** on $\mathbb R$ as a $\mathbb Q$-vector space: $f$ respects rational scalar multiplication. Combined with additivity (which is exactly $\mathbb Q$-vector-space additivity), this says $f$ is a **$\mathbb Q$-linear map** from $\mathbb R$ (a $\mathbb Q$-vector space) to $\mathbb R$ (also a $\mathbb Q$-vector space, with the obvious structure).

A $\mathbb Q$-linear map is determined by its values on a $\mathbb Q$-basis of the domain — and the domain $\mathbb R$ has, as $\mathbb Q$-vector space, a basis. We will say much more about this basis (and its existence) in Chapter 4. For now, observe that Lemma 2.2 *did not use continuity at all*. Every additive function is automatically $\mathbb Q$-linear. The pathological additive functions of Chapter 5 will be $\mathbb Q$-linear but not $\mathbb R$-linear; they exist precisely because $\mathbb R$ is *not* a one-dimensional $\mathbb Q$-vector space.

## 2.3 Step 2: continuity plus $\mathbb Q$-homogeneity implies $\mathbb R$-homogeneity

Now assume $f$ is additive *and continuous* on $\mathbb R$. We show $f$ is $\mathbb R$-linear.

Fix $r \in \mathbb R$ and $x \in \mathbb R$. By density of $\mathbb Q$ in $\mathbb R$, choose a sequence $q_n \in \mathbb Q$ with $q_n \to r$ as $n \to \infty$. By Lemma 2.2, $f(q_n x) = q_n f(x)$ for every $n$.

The left-hand side converges to $f(r x)$ by continuity of $f$ at $r x$: $q_n x \to r x$, and $f$ is continuous, so $f(q_n x) \to f(rx)$.

The right-hand side converges to $r f(x)$ by ordinary multiplication continuity in $\mathbb R$: $q_n \to r$ implies $q_n f(x) \to r f(x)$.

Hence $f(rx) = r f(x)$. Since $r$ was arbitrary, $f$ is $\mathbb R$-linear: $f(x) = f(1) \cdot x = a x$, with $a := f(1)$.

We have proved:

> **Theorem 2.3 (Cauchy 1821).** *Let $f : \mathbb R \to \mathbb R$ be additive and continuous. Then $f$ is $\mathbb R$-linear: $f(x) = ax$ for $a = f(1)$.*

By Lemma 2.1 plus the translation $G(x) = f(x) + G(0)$, this implies: every continuous solution $G$ of $(J_2)$ is affine.

## 2.4 Why the proof feels inevitable

The proof of Theorem 2.3 is two steps, both of which feel forced. Step 1 (Lemma 2.2) is *algebraic*: additivity gives $\mathbb Q$-linearity by induction on rationals, no analytic input required. Step 2 (the limit argument) is *analytic*: density of $\mathbb Q$ in $\mathbb R$ plus continuity transmutes $\mathbb Q$-linearity into $\mathbb R$-linearity, by exactly the "approximate-and-take-limits" template that defines 19th-century rigorous analysis.

The student should pause to appreciate how *natural* both steps are:

- Step 1 is forced by the equation. There is no creative move; one just iterates the additive identity and watches $\mathbb Q$-homogeneity fall out.
- Step 2 is forced by continuity. Once continuity is on the table, the limit of $f(q_n x)$ along *any* sequence $q_n \to r$ must agree with $f(rx)$. The argument is the same one that proves: a continuous function on $\mathbb R$ is determined by its values on $\mathbb Q$.

The naturalness of the proof is what makes the question of Chapter 3 so striking: *what if we drop the continuity hypothesis in Step 2?* If $f$ is merely additive, with no other assumption, must $f$ be $\mathbb R$-linear? We will see that the answer is *no* — and that the construction of a counterexample requires a tool that did not exist in 1821 and that, for that reason, no one could have asked the question and gotten an answer in Cauchy's lifetime.

## 2.5 Historical placement

The *Cours d'analyse de l'École royale polytechnique* of 1821 is the foundational text of rigorous 19th-century analysis. Before Cauchy, the calculus of Newton, Leibniz, Euler, and Lagrange operated on a somewhat informal foundation: continuity was assumed by visual intuition, the meaning of $\sum_{n=1}^\infty a_n$ was contested, the relationship between differentiability and continuity was muddy. Cauchy's *Cours* set out, for the first time in print, a rigorous treatment of these notions: $\varepsilon$–$\delta$ continuity in essentially the modern form, a rigorous definition of the integral as a limit of Riemann sums (Cauchy gave the construction; Riemann later generalized), the modern definition of convergence of a series.

In this context, Cauchy's functional equation $(C)$ — implicit in the *Cours* but not given its modern name until later — is a *natural object*: it asks for the smallest possible algebraic constraint on a function that, *together with the new tool of continuity*, forces the function to be linear. The 1821 reader took for granted that continuity was the *minimal* regularity assumption, because in 1821 there was no other regularity worth discussing. Lebesgue measure (1902) lay 81 years in the future. Hamel's pathological construction (1905) lay 84 years in the future. The axiom of choice (1904), the tool that would eventually make the pathological construction possible, lay 83 years in the future.

The 19th century would spend its 80 years between Cauchy and Hamel asking: *is continuity really the minimum?* The answer, when it came, would be much more surprising than anyone in 1821 anticipated.

## Exercises for Chapter 2

**Exercise 2.1.** Show that on $\mathbb R$, the equation $(J_2)$ is equivalent to $(C)$ via the substitution $f(x) := G(x) - G(0)$. (Hint: write $G(x) = f(x) + G(0)$, substitute into $(J_2)$, and use Lemma 2.1.)

**Exercise 2.2.** Verify Lemma 2.2 directly for $f(x) = ax$.

**Exercise 2.3.** Let $f$ be additive. Verify that $f((p+q)x) = f(px) + f(qx)$ for $p, q \in \mathbb Q$ and $x \in \mathbb R$ — i.e., that $f$ is $\mathbb Q$-linear in the joint argument $px$ as well.

**Exercise 2.4 (continuity at a single point).** Suppose $f$ is additive and continuous *at a single point* $x_0 \in \mathbb R$. Show that $f$ is continuous *everywhere*. (Hint: use $f(x) = f(x - x_0) + f(x_0)$ and the additivity.)

**Exercise 2.5.** Sketch the proof of Theorem 2.3 in full, including all $\varepsilon$–$\delta$ details.

**Exercise 2.6.** Suppose $f$ is additive on $\mathbb R$ and continuous at $0$. Use Exercise 2.4 to conclude $f$ is continuous everywhere, then apply Theorem 2.3 to conclude $f$ is $\mathbb R$-linear.

**Exercise 2.7 (frontier).** Suppose $f$ is additive on $\mathbb R$ and *Lebesgue measurable*. Can you (informally) sketch why $f$ should be continuous? You will not be able to fully prove this until Chapter 6 (Sierpiński 1920), but a heuristic argument is possible.

---

# Chapter 3 — *The 80-year question and Darboux's first refinement (1875)*

> *"Une fonction continue est-elle la fonction la plus générale satisfaisant à l'équation fonctionnelle de Cauchy ?"* — paraphrasing the central question of 19th-century French analysis after 1821.

Cauchy's theorem of 1821 left a question hanging: was continuity *necessary*, or merely *sufficient*? For 80 years, no one had a definitive answer. The question was hard because no tool existed to construct a counterexample. The first chip away at it came from Gaston Darboux in 1875, who proved that monotonicity also suffices — a strictly weaker hypothesis than continuity (since monotone functions need not be continuous), but strictly stronger than mere additivity.

This chapter presents Darboux's contribution and articulates the question that the next three chapters answer.

## 3.1 Was continuity necessary?

Cauchy's Theorem 2.3 establishes that *continuity is sufficient* for an additive function to be $\mathbb R$-linear. The natural next question is: *is continuity necessary?*

A 19th-century analyst — say, around 1850, well after Cauchy's death but before Darboux's 1875 paper — could attempt the question in several ways:

1. *Show that every additive function is automatically continuous.* This would settle the question affirmatively: $\mathbb R$-linearity is the *unique* class of additive functions, so continuity is automatic.
2. *Construct an additive function that is not continuous.* This would settle the question negatively: continuity is not automatic; it is a real hypothesis.
3. *Refine the hypothesis: show that some weaker regularity (monotonicity, boundedness, measurability) also suffices.* This would tell us continuity is not minimal but does not pin down the minimum.

In 1850 only the third route was tractable. The first route (every additive function is continuous) is now known to be false — but proving it false requires constructing a pathological counterexample, which requires the axiom of choice (1904) and a Hamel basis (1905), neither of which existed in 1850.

The second route was therefore unavailable. Mathematicians in the second half of the 19th century pursued the third route, and Darboux's 1875 paper is the most famous result in this lineage.

## 3.2 Darboux 1875: monotonicity suffices

Gaston Darboux published his *Mémoire sur les fonctions discontinues* in the *Annales scientifiques de l'École normale supérieure* in 1875. Among many other things, the paper establishes the following.

> **Theorem 3.1 (Darboux 1875).** *Let $f : \mathbb R \to \mathbb R$ be additive and monotone (non-decreasing or non-increasing) on $\mathbb R$. Then $f$ is $\mathbb R$-linear.*

The original proof is somewhat lengthy. A cleaner modern proof goes via the Steinhaus difference theorem (Chapter 6), but here is a direct argument that uses only Lemma 2.2 ($\mathbb Q$-homogeneity) plus monotonicity.

**Proof.** Without loss of generality assume $f$ is non-decreasing. By Lemma 2.2, $f(q) = q f(1)$ for every $q \in \mathbb Q$. Set $a := f(1)$.

Fix $r \in \mathbb R$. Choose two sequences of rationals $q_n^- \uparrow r$ and $q_n^+ \downarrow r$ (e.g., decimal truncations from below and above). By monotonicity, $f(q_n^-) \le f(r) \le f(q_n^+)$ for every $n$.

But $f(q_n^-) = q_n^- a \to ra$ and $f(q_n^+) = q_n^+ a \to ra$, so the sandwich gives $f(r) = ra$. Hence $f$ is $\mathbb R$-linear. $\square$

Notice how the proof works: monotonicity bounds the value of $f(r)$ between the values of $f$ at two rational sequences converging to $r$. Both bounds converge to the same limit $ra$, so $f(r)$ is pinched at $ra$. Compare this with Theorem 2.3's proof, which used continuity in essentially the same role: to relate the value of $f$ at an irrational to its values at rationals approaching that irrational.

What does monotonicity buy us, then, over continuity? At first glance: nothing. Both hypotheses give the same conclusion via essentially the same sandwich/limit argument. But monotonicity is *strictly weaker* than continuity (e.g., monotone functions can have jumps), and in fact every monotone function is *continuous except at countably many points* (a theorem of Darboux himself, in the same paper). So Theorem 3.1 is a refinement.

Modern Darboux-style results — *every additive function continuous on a non-trivial subset is $\mathbb R$-linear, every additive function bounded on a non-trivial subset is $\mathbb R$-linear,* etc. — all refine the regularity hypothesis in the same direction: weaker and weaker conditions on $f$ that all suffice. We will catalog these in Chapter 6.

## 3.3 What's the minimum?

Theorems 2.3 and 3.1 leave us with a sharper version of the original question:

> *What is the minimum regularity hypothesis that, together with additivity, forces $\mathbb R$-linearity?*

In 1875 the answer was not obviously *no hypothesis at all*. It seemed plausible that with sufficient cleverness one might find an additive function that fails $\mathbb R$-linearity in a wild way — but no one knew how to construct one. The conjecture that "every additive function is $\mathbb R$-linear" was alive, in the sense that no counterexample existed in print.

The conjecture remained alive for 30 more years. In 1904 Zermelo proved the well-ordering theorem (Chapter 4), which Hamel in 1905 used as a tool to construct an additive function that is not $\mathbb R$-linear, settling the question negatively. From 1905 onwards mathematicians worked the other direction: they catalogued which weakest regularity hypotheses suffice, and the Polish school of the 1920s (Chapter 6) ultimately drew a complete dictionary.

## 3.4 Historical placement

Gaston Darboux (1842–1917) was professor at the Faculté des sciences de Paris and one of the dominant figures of 19th-century French analysis. His *Mémoire sur les fonctions discontinues* of 1875 is part of a broader 19th-century project to understand the *boundary* between continuity and pathology — what kinds of functions exist, what their possible singularities are, how they relate to integrability and measurability. The same era produced the Weierstrass nowhere-differentiable continuous function (1872), the Volterra function (1881), Lebesgue measure (Lebesgue 1902), and the foundational debates about what a "function" is (Dedekind's *Was sind und was sollen die Zahlen?* of 1888 is a key text).

The contemporary intuition was that *some* regularity was needed for any classical-analysis result to hold — that pathologies existed at the margins, but that anyone wanting to do real analysis would always assume the tameness needed for their argument to go through. Hamel's 1905 paper would shatter that intuition by exhibiting that the *additive* equation, the very simplest functional equation one can write, admits pathological solutions whose construction is forced upon us by the axiom of choice itself.

We now turn to that axiom and that pathology.

## Exercises for Chapter 3

**Exercise 3.1.** Sketch Darboux's proof of Theorem 3.1 in your own words, paying attention to where monotonicity is used and where $\mathbb Q$-homogeneity is used.

**Exercise 3.2.** Suppose $f$ is additive and *bounded above* on $[0, 1]$ by some $M < \infty$. Use $\mathbb Q$-homogeneity to show $f$ is bounded above by $|x| M$ on $\mathbb R$ for every $x$ — and conclude $f$ is bounded on every compact set.

**Exercise 3.3.** Suppose $f$ is additive and *bounded* on $[0, 1]$. Use Exercise 3.2 and a limiting argument to conclude $f$ is continuous. (You will need to be careful: bounded on $[0, 1]$ alone is not enough to deduce continuity directly; you need the Steinhaus difference theorem of Chapter 6 for the full argument.)

**Exercise 3.4.** Suppose $f$ is additive and *measurable* in the Lebesgue sense on $\mathbb R$. Without proof, look up Sierpiński's theorem (Chapter 6) and state what it implies for $f$.

**Exercise 3.5.** *(Open-ended.)* Speculate: what would be a *weaker* regularity hypothesis than measurability that might still suffice? Look up *Baire's category theorem* and consider the relationship.

---
