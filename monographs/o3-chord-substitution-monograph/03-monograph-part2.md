# The Chord Substitution — Part II

## Act II — *The Pathology and the Resolution*

*Draft 0.0 — Chapters 4, 5, 6. Authored 2026-06-07.*

---

# Chapter 4 — *The axiom of choice and Hamel bases*

> *"The proof that every vector space has a basis is essentially the proof that the axiom of choice is true."* — folklore.

This chapter introduces the tool that will be used in Chapter 5 to construct the Hamel pathology: a *Hamel basis* of $\mathbb R$ over $\mathbb Q$. The construction requires the axiom of choice. We spend this chapter unpacking what a Hamel basis is, why it exists, what it looks like, and what is strange about it.

Many senior undergraduates have met the axiom of choice in passing — *every vector space has a basis*, *every set can be well-ordered*, *Tychonoff's theorem* — without ever wielding it constructively to build a concrete strange object. This chapter is one place where AC is deployed *to build something*, and that something is the engine of the Hamel pathology. The chapter slows down deliberately so the reader can absorb the construction.

## 4.1 Zermelo 1904: the well-ordering theorem and the axiom of choice

In 1904 Ernst Zermelo published a one-page proof of the **well-ordering theorem**: every set $X$ can be equipped with a well-ordering $\le_X$ — a linear order in which every nonempty subset has a least element. The proof relies on a previously-unstated principle, the **axiom of choice (AC)**:

> *For every family $\{A_i\}_{i \in I}$ of nonempty sets, there exists a choice function $f : I \to \bigcup_i A_i$ with $f(i) \in A_i$ for every $i \in I$.*

In words: from every collection of nonempty sets, one can simultaneously pick one element from each. For finite collections this is trivial (you just write down the choice). For countable collections it is plausible but already non-trivial. For uncountable collections — say, one set $A_x$ for each $x \in \mathbb R$ — it is a substantive axiom about set theory.

Zermelo's 1904 proof of the well-ordering theorem used AC essentially. The proof shows that *AC is equivalent to* the well-ordering theorem, in the sense that each implies the other within Zermelo–Fraenkel set theory (ZF). This pair of equivalent statements is, together with **Zorn's lemma**, the foundational axiom of modern set theory beyond the basic ZF axioms; we work in ZF + AC (= ZFC) throughout this monograph.

For this chapter we need only one consequence of AC:

> **Zorn's lemma (an equivalent form of AC).** *In a partially ordered set $(P, \le)$ in which every chain (totally ordered subset) has an upper bound, there exists a maximal element.*

Zorn's lemma is the form of AC used in linear algebra to prove "every vector space has a basis." We will use it in §4.4 below to prove that $\mathbb R$, viewed as a $\mathbb Q$-vector space, has a basis.

A historical aside. AC was controversial when first proposed. Mathematicians from Borel and Lebesgue (who founded measure theory in the same decade) were skeptical: they distrusted constructions that asserted the existence of objects no one could write down. The 1904 publication of Zermelo's theorem provoked a *cause célèbre* in the foundations community; mathematicians wrote pointed letters in the *Mathematische Annalen* and elsewhere. By the 1920s the controversy had largely subsided — the axiom was widely accepted as a useful tool, and Gödel's 1938 consistency proof (AC is consistent with ZF) and Cohen's 1963 independence proof (the negation of AC is also consistent with ZF) put the matter on firm metamathematical ground. But the Hamel pathology of 1905, which we construct in Chapter 5, is one of the first prominent examples of AC being used to construct a concrete object that is not constructible without it.

## 4.2 $\mathbb R$ as a $\mathbb Q$-vector space

We are about to use a structure on $\mathbb R$ that may be unfamiliar in this guise: the real line is a *vector space* over the rationals. Let us spell out what this means.

A vector space over a field $F$ is a set $V$ equipped with two operations:
- *vector addition* $V \times V \to V$, written $(u, v) \mapsto u + v$,
- *scalar multiplication* $F \times V \to V$, written $(\alpha, v) \mapsto \alpha v$,

satisfying the standard vector-space axioms (associativity, distributivity, identity, etc.).

Take $V := \mathbb R$ and $F := \mathbb Q$. Define vector addition as ordinary addition in $\mathbb R$, and scalar multiplication as ordinary multiplication of a rational by a real (which produces a real). All the vector-space axioms hold, because they all hold for $\mathbb R$ viewed as the standard real line. So $\mathbb R$ is a $\mathbb Q$-vector space.

What is the *dimension* of this $\mathbb Q$-vector space? The answer is striking: $\mathbb R$ has $\mathbb Q$-dimension equal to the cardinality of the continuum, $\mathfrak c = 2^{\aleph_0}$. This is uncountable. Compare with $\mathbb R$ as an $\mathbb R$-vector space, which has dimension $1$ (basis $\{1\}$). The $\mathbb Q$-structure is *vastly* richer than the $\mathbb R$-structure.

The intuition: $\mathbb R$, as a $\mathbb Q$-vector space, is enormous. Its $\mathbb Q$-bases are uncountable sets of reals, no two of which are rational multiples of each other. We cannot write down such a basis explicitly — but we can prove it exists via Zorn's lemma.

## 4.3 Definition of a Hamel basis

> **Definition 4.1.** A **Hamel basis** of $\mathbb R$ over $\mathbb Q$ is a subset $H \subseteq \mathbb R$ such that:
>
> 1. **($\mathbb Q$-linear independence)** *Whenever $h_1, h_2, \ldots, h_n$ are distinct elements of $H$ and $q_1, \ldots, q_n \in \mathbb Q$ satisfy $q_1 h_1 + q_2 h_2 + \cdots + q_n h_n = 0$, then $q_1 = q_2 = \cdots = q_n = 0$.*
>
> 2. **($\mathbb Q$-spanning)** *Every $x \in \mathbb R$ can be written as $x = q_1 h_1 + q_2 h_2 + \cdots + q_n h_n$ for some distinct $h_1, \ldots, h_n \in H$ and rationals $q_1, \ldots, q_n \in \mathbb Q$.*

A Hamel basis is therefore a $\mathbb Q$-linearly-independent generating set of $\mathbb R$. By the general theory of vector spaces, any element $x \in \mathbb R$ has a *unique* representation as a finite $\mathbb Q$-linear combination of basis elements (uniqueness up to the obvious permutation/relabeling).

Two important warnings:

- The representation is *finite*. Every $x \in \mathbb R$ uses only finitely many basis elements, even though the basis itself is uncountable.
- The basis is uncountable. We will see in §4.6 below that $|H| = \mathfrak c$.

A worked computation may help. Suppose we add the elements $1$ and $\sqrt 2$ to a hypothetical Hamel basis. Verify that $\{1, \sqrt 2\}$ is $\mathbb Q$-linearly independent in $\mathbb R$: a relation $q_1 \cdot 1 + q_2 \cdot \sqrt 2 = 0$ with $q_1, q_2 \in \mathbb Q$ and $q_2 \ne 0$ would give $\sqrt 2 = -q_1/q_2 \in \mathbb Q$, contradicting the irrationality of $\sqrt 2$. So $q_2 = 0$, hence $q_1 = 0$. Therefore $\{1, \sqrt 2\}$ is $\mathbb Q$-independent.

Similarly $\{1, \sqrt 2, \pi\}$ is $\mathbb Q$-independent — but this is harder to verify, because it requires showing $\pi$ is not in the $\mathbb Q$-span of $\{1, \sqrt 2\}$, i.e., $\pi \neq q_1 + q_2 \sqrt 2$ for any rationals $q_1, q_2$. The Lindemann–Weierstrass theorem (1882, proving $\pi$ is transcendental) implies this, but the proof is non-trivial.

A Hamel basis of $\mathbb R$ is, intuitively, a maximal $\mathbb Q$-independent set — a set so large that we cannot add another real number without breaking the independence, yet small enough that every real is a $\mathbb Q$-linear combination of finitely many of its elements.

## 4.4 Existence via Zorn's lemma

> **Theorem 4.2.** *$\mathbb R$ has a Hamel basis.*

**Proof.** Let $\mathcal P$ be the collection of all $\mathbb Q$-linearly-independent subsets of $\mathbb R$, partially ordered by inclusion.

$\mathcal P$ is nonempty: $\{1\} \in \mathcal P$.

Every chain in $\mathcal P$ has an upper bound. Indeed, let $\{S_\alpha\}_{\alpha \in A}$ be a chain in $\mathcal P$. Set $S := \bigcup_\alpha S_\alpha$. We claim $S$ is $\mathbb Q$-linearly independent: suppose $h_1, \ldots, h_n \in S$ are distinct and $q_1 h_1 + \cdots + q_n h_n = 0$ with $q_i \in \mathbb Q$. Each $h_i$ lies in some $S_{\alpha_i}$. Since the $S_\alpha$'s are totally ordered by inclusion, one of $S_{\alpha_1}, \ldots, S_{\alpha_n}$ contains all the others; call this maximal one $S_{\alpha^*}$. Then $h_1, \ldots, h_n \in S_{\alpha^*}$, and by $\mathbb Q$-linear independence of $S_{\alpha^*}$, $q_1 = \cdots = q_n = 0$. So $S$ is $\mathbb Q$-linearly independent and serves as the desired upper bound.

By Zorn's lemma, $\mathcal P$ contains a maximal element $H$.

It remains to show $H$ is $\mathbb Q$-spanning. Suppose $r \in \mathbb R$ is not in the $\mathbb Q$-span of $H$. Then $H \cup \{r\}$ is also $\mathbb Q$-linearly independent: a relation $q \cdot r + q_1 h_1 + \cdots + q_n h_n = 0$ with $q \neq 0$ would give $r = -q^{-1}(q_1 h_1 + \cdots + q_n h_n) \in \mathbb Q\text{-span}(H)$, a contradiction. So $q = 0$, and the rest of the relation forces $q_i = 0$ by $\mathbb Q$-linear independence of $H$.

Hence $H \cup \{r\} \in \mathcal P$ and strictly contains $H$, contradicting maximality of $H$. So $H$ is $\mathbb Q$-spanning, and $H$ is a Hamel basis. $\square$

The proof is one application of Zorn's lemma — exactly the *every vector space has a basis* proof in a standard linear algebra course, specialized to the $\mathbb Q$-vector space $\mathbb R$.

## 4.5 Some $\mathbb Q$-independent reals (which may or may not be in any specific basis)

It is helpful to have concrete examples of $\mathbb Q$-independent sets, even though we cannot exhibit a full Hamel basis.

**Examples 4.3.** Each of the following is a $\mathbb Q$-linearly-independent subset of $\mathbb R$:

- $\{1\}$ (trivially).
- $\{1, \sqrt 2\}$ (as in §4.3).
- $\{1, \sqrt 2, \pi\}$ (by Lindemann–Weierstrass: $\pi$ is transcendental, so not in $\mathbb Q[\sqrt 2]$).
- $\{1, \sqrt 2, \pi, e\}$ (Lindemann 1882: $e$ is transcendental; further independence by deeper transcendence theory).
- $\{\sqrt 2, \sqrt 3\}$ (a relation $q_1 \sqrt 2 + q_2 \sqrt 3 = 0$ with $q_i \in \mathbb Q$ forces $q_2 \sqrt 3 / \sqrt 2 = -q_1$, i.e., $q_2 \sqrt{3/2} = -q_1$, and $\sqrt{3/2}$ is irrational, so $q_2 = 0$, then $q_1 = 0$).
- $\{1, \log 2, \log 3\}$ (a theorem of Lindemann–Weierstrass plus some transcendence theory).

Each of these can in principle be extended to a Hamel basis via Zorn's lemma. But:

> *No explicit Hamel basis has ever been written down.*

The reason is fundamental. By Theorem 4.2 a Hamel basis exists, but the proof uses Zorn's lemma, which uses AC, which in turn does not specify *which* maximal element is produced. The construction is non-effective. There is no algorithm, no finite description, no formula, that produces a specific Hamel basis. A Hamel basis is one of the canonical objects that *exists* in mathematics but cannot be *exhibited*.

## 4.6 Cardinality: a Hamel basis is uncountable

> **Theorem 4.4.** *Every Hamel basis $H$ of $\mathbb R$ over $\mathbb Q$ is uncountable. In fact $|H| = \mathfrak c$, the cardinality of the continuum.*

**Proof.** Suppose for contradiction $H$ is countable. Then the $\mathbb Q$-span of $H$ is the union of countably many finite-$\mathbb Q$-dimensional subspaces of $\mathbb R$, each of which is countable. A countable union of countable sets is countable. So $\mathbb Q\text{-span}(H)$ is countable. But $\mathbb Q\text{-span}(H) = \mathbb R$ by the spanning property of $H$, and $\mathbb R$ is uncountable — contradiction.

So $H$ is uncountable. The full equality $|H| = \mathfrak c$ requires the Schröder–Bernstein theorem and a counting argument: $|H| \le \mathfrak c$ since $H \subseteq \mathbb R$, and $|H| \ge \mathfrak c$ by a similar union argument refining the above. $\square$

A Hamel basis is *very large*. It has the same cardinality as $\mathbb R$ itself.

## 4.7 The strangeness of a Hamel basis

We close this chapter by collecting the structural pathologies of any Hamel basis.

> **Theorem 4.5 (Sierpiński, descriptive set theory).** *Let $H$ be a Hamel basis of $\mathbb R$ over $\mathbb Q$. Then:*
>
> 1. *$H$ is not Lebesgue measurable.*
> 2. *$H$ does not have the property of Baire (i.e., is not the symmetric difference of an open set and a meager set).*
> 3. *$H$ is not analytic, not Borel, not in any of the standard "descriptively simple" classes.*

We will not prove this here — the proofs use the Steinhaus difference theorem of Chapter 6 (for part 1) plus the corresponding Baire-category analog (for part 2). We mention it because the *strangeness* of a Hamel basis is part of the story: this object exists by Zorn's lemma but resists every classical attempt to "see" it.

A heuristic for the strangeness: a Hamel basis is the universal generator of arithmetic on $\mathbb R$ from $\mathbb Q$. Once you have $H$ in hand, you can use it to define very wild functions — including, in Chapter 5, the wildest of all: non-affine additive functions. The wildness of those functions is *inherited* from the wildness of the basis.

A foundational footnote. The axiom of choice is responsible for the existence of Hamel bases. In a model of set theory where AC fails — for example, Solovay's 1970 model of ZF + DC (Dependent Choice) in which every set of reals is Lebesgue measurable — Hamel bases do not exist, and the construction of Chapter 5 dissolves. This is a profound metamathematical observation: the pathology depends essentially on AC, and dropping AC (while keeping enough choice to do classical analysis) erases the pathology. We will return to this in Chapter 5's exercises.

## Exercises for Chapter 4

**Exercise 4.1.** Verify directly that $\{1, \sqrt 2\}$ is $\mathbb Q$-independent in $\mathbb R$.

**Exercise 4.2.** Show that $\{\sqrt 2, \sqrt 3, \sqrt 6\}$ is *not* $\mathbb Q$-independent. Find the relation.

**Exercise 4.3.** Use Lindemann–Weierstrass (look it up if needed) to argue that $\{1, e, e^2\}$ is *not* $\mathbb Q$-independent — find the obvious relation — and contrast with $\{1, e, \pi\}$, which is $\mathbb Q$-independent.

**Exercise 4.4.** Prove that every countable subset of $\mathbb R$ has Lebesgue measure $0$. Use this to give a *non-Zorn* (impossible!) argument that $\mathbb R$ cannot be exhausted by the $\mathbb Q$-span of a countable set.

**Exercise 4.5.** Prove that any $\mathbb Q$-linearly independent subset of $\mathbb R$ can be extended to a Hamel basis. (Hint: apply Zorn's lemma to the collection of $\mathbb Q$-linearly independent subsets containing the given set.)

**Exercise 4.6.** Show that if $H$ is a Hamel basis containing $1$, and $h \in H$ with $h \neq 1$, then $H \setminus \{h\} \cup \{2h\}$ is also a Hamel basis. (This says Hamel bases are not unique up to scaling of individual elements.)

**Exercise 4.7.** Prove that every Hamel basis is uncountable. (Cf. Theorem 4.4.)

**Exercise 4.8 (frontier).** Look up Solovay 1970: there is a model of ZF + DC in which every set of reals is Lebesgue measurable. In this model, Hamel bases of $\mathbb R$ over $\mathbb Q$ do not exist. Speculate on what changes in our story (Chapters 5–6) if we work in Solovay's model instead of ZFC. Does the chord substitution of Chapter 8 survive? (Yes — it uses no choice.)

---

# Chapter 5 — *Hamel's pathology (1905)*

> *"Es existieren also unstetige Lösungen der Funktionalgleichung $f(x+y) = f(x) + f(y)$."* — Georg Hamel, *Mathematische Annalen* **60** (1905), p. 462.

In 1905 Georg Hamel published a one-and-a-half-page paper in *Mathematische Annalen* titled *Eine Basis aller Zahlen und die unstetigen Lösungen der Funktionalgleichung $f(x+y) = f(x) + f(y)$*. In English: *A basis of all numbers and the discontinuous solutions of the functional equation $f(x+y) = f(x) + f(y)$*. The paper does exactly two things. First, it observes that Zermelo's 1904 well-ordering theorem implies $\mathbb R$ has a $\mathbb Q$-vector-space basis. Second, it uses such a basis to construct a non-$\mathbb R$-linear solution of Cauchy's equation.

This chapter walks through Hamel's construction, verifies that the constructed function satisfies Cauchy, verifies that it is *not* $\mathbb R$-linear, surveys its wildness, and reflects on what the construction means.

## 5.1 The construction

Fix a Hamel basis $H$ of $\mathbb R$ over $\mathbb Q$, with the convention that $1 \in H$ (we can always arrange this by Exercise 4.5).

Pick *any* function $\sigma : H \to \mathbb R$. There is no constraint on $\sigma$ whatsoever — it is an arbitrary function from the (uncountable) set $H$ to the reals. The simplest choice for our purposes will be:

> $\sigma(1) := 0$, and $\sigma(h) := 1$ for every $h \in H \setminus \{1\}$.

But the construction works for *any* $\sigma$.

Now extend $\sigma$ to a function $\ell : \mathbb R \to \mathbb R$ as follows. For any $x \in \mathbb R$, write $x = q_1 h_1 + q_2 h_2 + \cdots + q_n h_n$ uniquely as a finite $\mathbb Q$-linear combination of basis elements (uniqueness up to permutation; this is the spanning property of $H$). Define
$$
\ell(x) \;:=\; q_1 \sigma(h_1) + q_2 \sigma(h_2) + \cdots + q_n \sigma(h_n).
$$
This is the unique $\mathbb Q$-linear extension of $\sigma$ from $H$ to $\mathbb R$. By the standard linear-algebra extension theorem (which holds in any vector space), $\ell$ is well-defined: the value $\ell(x)$ does not depend on the representation, since the representation is unique up to permutation.

We have constructed $\ell : \mathbb R \to \mathbb R$, $\mathbb Q$-linear by construction.

## 5.2 $\ell$ satisfies Cauchy's equation

> **Proposition 5.1.** *The function $\ell$ defined in §5.1 satisfies Cauchy's equation $\ell(x + y) = \ell(x) + \ell(y)$ for all $x, y \in \mathbb R$.*

**Proof.** Fix $x, y \in \mathbb R$. Write each as a $\mathbb Q$-linear combination of basis elements:
$$
x = \sum_i q_i^{(x)} h_i, \qquad y = \sum_i q_i^{(y)} h_i,
$$
where the sums range over a common finite set of basis elements (after enlarging both representations as needed — both are sums over finite subsets of $H$, and we can take the union of the supports).

Then $x + y = \sum_i (q_i^{(x)} + q_i^{(y)}) h_i$ by ordinary addition in $\mathbb R$. Apply $\ell$:
$$
\ell(x+y) = \sum_i (q_i^{(x)} + q_i^{(y)}) \sigma(h_i) = \sum_i q_i^{(x)} \sigma(h_i) + \sum_i q_i^{(y)} \sigma(h_i) = \ell(x) + \ell(y).
$$
$\square$

So $\ell$ is additive on $\mathbb R$. By Lemma 2.2 (which used only additivity, not continuity), $\ell$ is also $\mathbb Q$-homogeneous: $\ell(qx) = q \ell(x)$ for $q \in \mathbb Q$. This is consistent with the construction: $\ell$ was *defined* to be $\mathbb Q$-linear.

## 5.3 $\ell$ is not $\mathbb R$-linear

> **Proposition 5.2.** *With the specific choice $\sigma(1) = 0$ and $\sigma(h) = 1$ for $h \in H \setminus \{1\}$ (from §5.1), the function $\ell$ is not $\mathbb R$-linear. Equivalently, $\ell$ is not of the form $\ell(x) = ax$ for any $a \in \mathbb R$.*

**Proof.** Suppose for contradiction that $\ell(x) = ax$ for some $a \in \mathbb R$. Then $\ell(1) = a \cdot 1 = a$, but by construction $\ell(1) = \sigma(1) = 0$. So $a = 0$, meaning $\ell \equiv 0$.

But $\ell(h) = \sigma(h) = 1$ for any basis element $h \neq 1$ (such an $h$ exists since $H$ is uncountable). So $\ell$ is not identically zero. Contradiction. $\square$

So $\ell$ is a $\mathbb Q$-linear, additive function on $\mathbb R$ that is *not* $\mathbb R$-linear. This is the Hamel pathology.

A bit of book-keeping is in order. By Lemma 2.2, $\ell$ is $\mathbb Q$-linear. So in particular $\ell(q) = q \cdot \ell(1) = q \cdot 0 = 0$ for every rational $q$. The function $\ell$ vanishes identically on $\mathbb Q$. Yet $\ell$ is nonzero at $h$ (a basis element distinct from $1$). So $\ell$ takes the value $0$ on $\mathbb Q$ and the value $1$ at $h \in \mathbb R \setminus \mathbb Q$. Since $\mathbb Q$ is dense in $\mathbb R$, an arbitrarily small neighborhood of $0$ contains uncountably many points where $\ell$ is zero (the rationals) and also uncountably many points where $\ell$ is bounded away from zero (perturbations of $h$ by rationals — see Exercise 5.2). The graph of $\ell$ is dense in $\mathbb R^2$, as we'll prove next.

## 5.4 $\ell$ is wild

> **Proposition 5.3.** *The graph of $\ell$ is dense in $\mathbb R^2$. In particular:*
> 1. *$\ell$ is unbounded on every nontrivial interval $[a, b] \subseteq \mathbb R$.*
> 2. *$\ell$ has no points of continuity.*
> 3. *$\ell$ is not Lebesgue measurable.*

**Proof.** *Graph density.* Fix any point $(x_0, y_0) \in \mathbb R^2$ and any $\varepsilon > 0$. We show $\ell^{-1}(B_\varepsilon(y_0)) \cap B_\varepsilon(x_0) \neq \emptyset$.

Choose any basis element $h \in H$ with $\ell(h) = 1$ (such an $h$ exists since the basis is uncountable). For any rationals $p, q \in \mathbb Q$, the value $\ell(p + q h) = p \ell(1) + q \ell(h) = 0 \cdot p + 1 \cdot q = q$.

Choose $q \in \mathbb Q$ with $|q - y_0| < \varepsilon$ (possible by density of $\mathbb Q$). Choose $p \in \mathbb Q$ with $|p + q h - x_0| < \varepsilon$ (possible by density: pick $p$ approximating $x_0 - q h$).

Then the point $(p + q h, \ell(p + q h)) = (p + q h, q)$ is within $\varepsilon$ of $(x_0, y_0)$ in both coordinates. So the graph of $\ell$ is dense in $\mathbb R^2$.

*Conclusions.* Unboundedness on every interval follows from graph density (every neighborhood in the second coordinate contains points of the graph, in particular very large and very negative $y$-values). Non-continuity at every point follows from graph density (the function takes wildly different values in any open interval around any given $x_0$). Non-measurability is more subtle and uses the Steinhaus difference theorem of Chapter 6; we sketch it in Exercise 5.5.

A picture (which we cannot draw but the reader can imagine): the graph of $\ell$, projected onto $\mathbb R^2$, is a dense subset of $\mathbb R^2$. It is not the graph of any familiar function — not a curve, not a fractal, not a piecewise function. It is a wild dust that resists every classical attempt at visualization.

## 5.5 Hamel's 1905 paper

What did Hamel actually write?

The paper is short — one and a half pages of dense mathematics. It opens by noting that Zermelo's well-ordering theorem (1904) allows one to construct a basis of $\mathbb R$ over $\mathbb Q$, calling it (in German) *eine Basis aller Zahlen* — "a basis of all numbers". Hamel observes that this is a purely set-theoretic existence claim, with no constructive content. He then writes:

> *"Diese Basis liefert uns nun unmittelbar die unstetigen Lösungen der Funktionalgleichung $f(x+y) = f(x) + f(y)$ in folgender Weise…"*
>
> *"This basis now immediately gives us the discontinuous solutions of the functional equation $f(x+y) = f(x) + f(y)$ in the following way…"*

Hamel then does what we did in §§5.1–5.2: define $\ell$ arbitrarily on basis elements, extend $\mathbb Q$-linearly, verify additivity. He concludes that the additive functions on $\mathbb R$ form a vector space of $\mathbb Q$-dimension $\mathfrak c$ (the basis $H$ has cardinality $\mathfrak c$), and that only the one-dimensional sub-vector-space spanned by $\ell(x) = x$ corresponds to $\mathbb R$-linear solutions.

So *most* additive functions on $\mathbb R$ are non-$\mathbb R$-linear. The continuous ones form a vector space of dimension $1$; the additive ones form a vector space of dimension $\mathfrak c$.

Hamel's paper is a foundational moment in 20th-century analysis. It establishes that *the question of regularity matters*: without continuity (or some other regularity hypothesis), additivity is *not* enough to force $\mathbb R$-linearity. The 80-year question of Chapter 3 has its answer: continuity (or some regularity) is *necessary*, not just convenient.

## 5.6 The role of the axiom of choice

The Hamel pathology *requires* the axiom of choice. Without AC (or some equivalent — Zorn's lemma, well-ordering), the Hamel basis $H$ does not exist, and our construction collapses.

In a model of set theory without AC, the pathology may dissolve entirely. Solovay's 1970 theorem provides a precise such model: there is a model of ZF + DC (where DC is *Dependent Choice*, a much weaker fragment of AC) in which every set of reals is Lebesgue measurable. In this model, every additive function on $\mathbb R$ is Lebesgue measurable — and hence (by the Sierpiński 1920 theorem of Chapter 6) is $\mathbb R$-linear. So in Solovay's model, *the answer to Cauchy's 80-year question is yes*: continuity is automatic for additive functions.

This is a profound observation about the axiom of choice. The pathology we constructed in §5.1 is not an *intrinsic* feature of the real line; it is a feature of *the real line plus the axiom of choice*. Drop AC (while keeping enough choice for classical analysis), and the pathology evaporates.

For the rest of this monograph we work in ZFC, in which the pathology exists. The chord substitution of Chapter 8 — and this is the crucial point — does not use AC for *its* proof. It works in any model of ZF + DC, including Solovay's. The chord substitution closes the equation $(\star)$ regardless of whether AC is in play. So the punch line of the monograph is uniform across choice-axioms: $(\star) \Rightarrow$ affine, period.

## Exercises for Chapter 5

**Exercise 5.1.** Verify Proposition 5.1 by hand for $x = h_1 + h_2$ and $y = q h_2$, where $h_1, h_2 \in H$ are distinct basis elements and $q \in \mathbb Q$.

**Exercise 5.2.** Show that for any rational $q$ and any basis element $h \in H$ with $\ell(h) = 1$, $\ell(q + h) = 0 + 1 = 1$. Conclude that $\ell$ takes the value $1$ on the dense set $\{q + h : q \in \mathbb Q\}$.

**Exercise 5.3.** Verify graph density of $\ell$ in full detail, following the argument in Proposition 5.3.

**Exercise 5.4.** Show that $\ell$ has no points of continuity, by argueing from graph density.

**Exercise 5.5 (harder).** Sketch why $\ell$ is not Lebesgue measurable. (Hint: assume $\ell$ is measurable. Then $E := \ell^{-1}([0, 1])$ is measurable. Show that $E$ has positive measure. Apply the Steinhaus difference theorem of Chapter 6 to conclude $E - E$ contains an open interval $(-\delta, \delta)$. Derive a contradiction by considering $\ell$ on this interval.)

**Exercise 5.6.** Show that the additive functions on $\mathbb R$ form a $\mathbb Q$-vector space of $\mathbb Q$-dimension $\mathfrak c$.

**Exercise 5.7 (frontier).** Look up Solovay 1970. In Solovay's model of ZF + DC, every set of reals is Lebesgue measurable, and Hamel bases do not exist. Reread §5.6 and try to articulate, in your own words, what the axiom of choice "costs" us in classical analysis.

---

# Chapter 6 — *The Polish school answers (1920–1929)*

> *"L'école polonaise a montré que toute fonction additive mesurable de $\mathbb R$ dans $\mathbb R$ est linéaire."*

The Hamel pathology of 1905 raised a new question: *which regularity hypotheses on $f$ — short of full $\mathbb R$-linearity — are strong enough to force $f$ to be $\mathbb R$-linear?* In the 1920s, the Polish school of analysis answered this question comprehensively. Wacław Sierpiński proved in 1920 that *measurability* suffices. Hugo Steinhaus, in the same year, proved a remarkable theorem about the *difference set* of a set of positive measure, which gave a clean route to Sierpiński's theorem and to a fleet of related results. Alexander Ostrowski in 1929 completed the dictionary with the cleanest sufficient hypothesis: *boundedness on an interval*.

This chapter walks through the main resolutions. We prove the Steinhaus difference theorem first (a beautiful piece of measure theory in its own right), then derive Sierpiński's theorem and its companions. The chapter closes with a historical interlude on the Warsaw and Lwów schools, *Fundamenta Mathematicae*, and the Scottish Café.

## 6.1 The Polish school context

The Polish school of analysis emerged from two universities — Warsaw (Uniwersytet Warszawski) and Lwów (Uniwersytet Jana Kazimierza, now Lviv in Ukraine) — in the years after Poland regained independence in 1918. The Warsaw group was led by Sierpiński, Mazurkiewicz, and Kuratowski, working primarily in set theory and topology. The Lwów group was led by Banach, Steinhaus, Mazur, and Ulam, working in functional analysis, real analysis, and measure theory. The two groups were intellectually close and traded ideas freely.

The flagship publication of the Polish school was *Fundamenta Mathematicae*, founded in 1920 by Janiszewski, Sierpiński, and Mazurkiewicz. The first volume — published in 1920 — contained Sierpiński's *Sur les fonctions convexes mesurables* (the paper we discuss in §6.3) and Steinhaus's *Sur les distances des points dans les ensembles de mesure positive* (the paper we discuss in §6.2). Both papers were short, sharp, and foundational. The journal continues to be published today.

A famous element of the Lwów scene was the *Scottish Café* (*Kawiarnia Szkocka*) on Akademicka Street in Lwów. Banach, Steinhaus, Ulam, Kac, and others met there in the 1930s to discuss mathematics over coffee, writing problems on the marble tables and (eventually) in a notebook that Mazur kept for them — the *Scottish Book* (*Księga Szkocka*). The book contains over 190 problems posed by the Lwów school, many still open. (Problem 153, the *Mazur prize problem* about the dimensions of Banach spaces, was solved by Per Enflo in 1972 and Mazur — who had pledged a live goose as the prize in 1936 — kept his promise.) The Scottish Book is a primary historical document of the Lwów school's working style.

The chord substitution of this monograph, in the long perspective, owes its discoverability to the rigorous-analysis tradition the Polish school cultivated: a tradition of asking, *what is the minimum hypothesis?*

## 6.2 The Steinhaus difference theorem (1920)

> **Theorem 6.1 (Steinhaus 1920).** *Let $E \subseteq \mathbb R$ be a Lebesgue measurable set with $\lambda(E) > 0$, where $\lambda$ denotes Lebesgue measure. Then the difference set*
> $$ E - E \;:=\; \{x - y : x, y \in E\} $$
> *contains an open neighborhood of $0$, i.e., an open interval $(-\delta, \delta)$ for some $\delta > 0$.*

**Proof.** Without loss of generality $E$ has finite Lebesgue measure (replace $E$ with $E \cap [-N, N]$ for some $N$ with $\lambda(E \cap [-N, N]) > 0$, which exists by countable additivity).

The Lebesgue density theorem guarantees a *density point* of $E$: a point $x_0 \in E$ such that for every $\eta > 0$ there is some $r > 0$ with $\lambda(E \cap (x_0 - r, x_0 + r)) > (1 - \eta) \cdot 2r$.

Fix $\eta := 1/4$ in the density theorem; let $r > 0$ be such that $\lambda(E \cap (x_0 - r, x_0 + r)) > (3/2) r$.

Set $\delta := r$. For any $\xi \in (-\delta, \delta)$, define $E_\xi := E \cap (x_0 - r, x_0 + r)$ and consider its translation $E_\xi + \xi = \{e + \xi : e \in E_\xi\}$. Both $E_\xi$ and $E_\xi + \xi$ are subsets of the interval $(x_0 - r - |\xi|, x_0 + r + |\xi|)$, which has length $2r + 2|\xi| < 4r$ for $|\xi| < r$. Each of $E_\xi$ and $E_\xi + \xi$ has measure $> (3/2)r$, so their sum of measures is $> 3r > 4r$ only if $4r < 3r$ — but that's impossible. So $E_\xi$ and $E_\xi + \xi$ must overlap (or else they would fit disjointly in an interval of length $< 4r$, and that interval cannot accommodate two disjoint sets of total measure $> 3r$).

Hence there is some $e \in E_\xi$ with $e + \xi \in E_\xi \subseteq E$. So $\xi = (e + \xi) - e \in E - E$.

Since $\xi \in (-\delta, \delta)$ was arbitrary, $E - E \supseteq (-\delta, \delta)$. $\square$

The proof is a beautiful piece of elementary measure theory. The density point gives a local concentration of $E$; translating $E$ by a small amount $\xi$ produces an overlap (because the two copies are *both* concentrated near $x_0$ and cannot fit disjointly into a slightly larger interval).

## 6.3 Sierpiński 1920: measurability suffices

> **Theorem 6.2 (Sierpiński 1920).** *Let $f : \mathbb R \to \mathbb R$ be additive and Lebesgue measurable. Then $f$ is $\mathbb R$-linear.*

**Proof.** By Lemma 2.2, $f$ is $\mathbb Q$-homogeneous. We show $f$ is continuous at $0$; by Exercise 2.4, this extends to continuity everywhere; by Cauchy's Theorem 2.3, $f$ is then $\mathbb R$-linear.

Step 1: $f$ is bounded on some set of positive measure. Indeed, by countable additivity of Lebesgue measure, at least one of the sets $E_n := \{x : |f(x)| \le n\}$ has positive measure for some $n$. (If all $E_n$ had measure zero, then $\mathbb R = \bigcup_n E_n$ would have measure zero, absurd.) So fix $n$ with $\lambda(E_n) > 0$, and set $E := E_n$.

Step 2: by the Steinhaus difference theorem, there is $\delta > 0$ with $(-\delta, \delta) \subseteq E - E$.

Step 3: for any $\xi \in (-\delta, \delta)$, we have $\xi = e_1 - e_2$ for some $e_1, e_2 \in E$. By additivity, $f(\xi) = f(e_1) - f(e_2)$, and $|f(\xi)| \le |f(e_1)| + |f(e_2)| \le n + n = 2n$.

So $f$ is bounded on $(-\delta, \delta)$ by $2n$.

Step 4: continuity of $f$ at $0$. For any sequence $x_k \to 0$, the values $f(x_k)$ are bounded by $2n$ for $k$ large. We need to show $f(x_k) \to 0$.

Use $\mathbb Q$-homogeneity. For any integer $m \ge 1$, choose $x_k$ with $|x_k| < \delta/m$. Then $|m x_k| < \delta$, so $|f(m x_k)| \le 2n$, hence $|f(x_k)| = |f(m x_k)/m| \le 2n/m$.

Let $m \to \infty$: $|f(x_k)| \le 2n/m \to 0$. Since this holds for any choice of $x_k \to 0$ along $|x_k| < \delta/m$, and we can choose $m$ as large as we like, $f(x_k) \to 0$. So $f$ is continuous at $0$.

By Exercise 2.4 and Cauchy's Theorem 2.3, $f$ is $\mathbb R$-linear. $\square$

The proof has the structure of a *bootstrap*: measurability gives boundedness on a positive-measure set, which gives boundedness on an interval (via Steinhaus), which gives continuity (via $\mathbb Q$-homogeneity), which gives $\mathbb R$-linearity (via Cauchy). Each step is a clean reduction.

## 6.4 Steinhaus 1920: boundedness on a positive-measure set suffices

> **Theorem 6.3 (Steinhaus 1920).** *Let $f : \mathbb R \to \mathbb R$ be additive. If $f$ is bounded on some set $E \subseteq \mathbb R$ with $\lambda(E) > 0$, then $f$ is $\mathbb R$-linear.*

**Proof.** This is Steps 2–4 of the proof of Theorem 6.2, isolated. $\square$

Sierpiński's measurability theorem is a *consequence* of Steinhaus's bounded-on-positive-measure-set theorem (plus the elementary observation in Step 1 of the proof of Theorem 6.2 that measurable functions are bounded on positive-measure sets).

## 6.5 Ostrowski 1929: boundedness on an interval suffices

> **Theorem 6.4 (Ostrowski 1929).** *Let $f : \mathbb R \to \mathbb R$ be additive. If $f$ is bounded on some interval $(a, b) \subseteq \mathbb R$, then $f$ is $\mathbb R$-linear.*

**Proof.** Apply Theorem 6.3 with $E := (a, b)$, which has positive Lebesgue measure $b - a > 0$. $\square$

Ostrowski's theorem is the *cleanest* of the regularity-sufficient results, in the sense that *boundedness on an interval* is the most concrete regularity hypothesis. It is also the strongest in scope, since boundedness on an interval implies boundedness on a positive-measure set (trivially) which by Steinhaus implies $\mathbb R$-linearity.

Note that *unbounded* additive functions exist — the Hamel pathology of Chapter 5 is one. Ostrowski's theorem is sharp: bounded on an interval is enough, but bounded on a *single point* or *bounded on a countable set* is not.

## 6.6 Darboux retrospectively: monotonicity suffices

We can also re-prove Darboux's Theorem 3.1 (monotonicity suffices) by going through Steinhaus.

**Proof of Theorem 3.1 via Steinhaus.** Let $f$ be additive and monotone, say non-decreasing. Then $f$ is bounded on any bounded interval $[a, b]$ (by $f(a)$ from below and $f(b)$ from above). Apply Ostrowski's Theorem 6.4. $\square$

A much shorter argument than Darboux's original 1875 proof — which had to do everything from scratch without the Polish school's measure-theoretic apparatus. The Steinhaus–Sierpiński technology cleans up half a century of partial results into a one-paragraph corollary.

## 6.7 The summary table

We collect the regularity-implies-$\mathbb R$-linearity results in a compact dictionary.

| Hypothesis on additive $f$ | Suffices? | Reference |
|---|---|---|
| Continuous on $\mathbb R$ | yes | Cauchy 1821 (Thm. 2.3) |
| Continuous at a single point | yes | Exercise 2.4 + Thm. 2.3 |
| Monotone on $\mathbb R$ | yes | Darboux 1875 (Thm. 3.1) |
| Bounded on a set of positive Lebesgue measure | yes | Steinhaus 1920 (Thm. 6.3) |
| Lebesgue measurable | yes | Sierpiński 1920 (Thm. 6.2) |
| Bounded on an open interval | yes | Ostrowski 1929 (Thm. 6.4) |
| Borel measurable | yes (follows from Lebesgue measurability) | — |
| Bounded on a countable set | no, in general | — |
| No regularity hypothesis | **NO** — Hamel 1905 (Thm. 5.2) | Chapter 5 |

The dictionary is *complete* in the sense that almost any natural regularity hypothesis suffices — any hypothesis stronger than "bounded on a countable set". Conversely, no regularity hypothesis at all is insufficient: Hamel's construction supplies an additive non-affine function.

The dictionary settles the question of Chapters 1–3: *what is the minimum regularity for $(J_2) \Rightarrow$ affine?* The answer is *any tameness hypothesis that prevents the Hamel pathology rescues affineness*; and *no hypothesis is needed for $(\star)$* (which we will prove in Chapter 8).

## 6.8 Historical interlude

The Polish school's productivity in the 1920s and 1930s is one of the most remarkable concentrations of mathematical talent in 20th-century history. From a country that had just regained statehood after 123 years of partition, with limited resources, in a language no other European mathematical center spoke, the school produced foundational work in topology (Kuratowski, Sierpiński), functional analysis (Banach, Mazur, Steinhaus), real analysis (Sierpiński, Saks, Steinhaus), measure theory (Steinhaus, Saks), set theory (Sierpiński, Mostowski, Tarski), and mathematical logic (Tarski, Łukasiewicz, Łoś).

Many of the school's leaders died during World War II — Janiszewski (one of *Fundamenta Mathematicae*'s co-founders) died of the 1920 typhus epidemic; others were murdered by the Nazis (Schauder, Saks, others died in occupied Poland; Banach survived the war but died of lung cancer in 1945). The school as a coherent body of work ended in 1945, but its influence on 20th-century analysis is enormous.

The 1920 *Fundamenta Mathematicae* volume that opens the school's printed record contains both the Steinhaus difference theorem and the Sierpiński measurability theorem — two of the lemmas that close the question Cauchy raised in 1821. The proofs are short, the arguments are clean, and the consequences ripple forward for the next century.

## Exercises for Chapter 6

**Exercise 6.1.** Verify the Steinhaus difference theorem for the specific case $E = [0, 1]$. (Trivially $E - E = [-1, 1]$, which contains an open neighborhood of 0.)

**Exercise 6.2.** Verify Theorem 6.3 directly for the specific case of an additive $f$ that is bounded on $[0, 1]$ by $M$. Show explicitly that $f$ is bounded on $\mathbb R$ — well, no, that's false; show that $f$ is bounded on $(-1, 1)$ by $2M$. Conclude continuity at $0$.

**Exercise 6.3.** Sketch the proof of the Lebesgue density theorem used in Theorem 6.1. (Hint: standard real-analysis textbook material; e.g., Royden or Folland.)

**Exercise 6.4.** Apply Theorem 6.2 to the case where $f$ is additive and is *almost everywhere zero* (i.e., zero on a set of full measure). Conclude $f \equiv 0$.

**Exercise 6.5.** State and prove the Baire-category analog of the Steinhaus difference theorem: if $E$ is a non-meager set with the Baire property, then $E - E$ contains an open neighborhood of $0$. (Hint: replace the Lebesgue density theorem with the *Baire category theorem*.)

**Exercise 6.6.** Use Exercise 6.5 to prove the Baire-category analog of Theorem 6.2: every additive $f$ with the Baire property is $\mathbb R$-linear.

**Exercise 6.7 (harder).** Use the Steinhaus difference theorem to show: the set $\mathbb Q + h := \{q + h : q \in \mathbb Q\}$ has measure zero for any fixed $h \in \mathbb R \setminus \mathbb Q$, while the union $\bigcup_{h \in H} (\mathbb Q + h) = \mathbb R$ has full measure. Conclude that *individual cosets* of $\mathbb Q$ in $(\mathbb R, +)$ are measure-zero, but the *whole coset structure* exhausts $\mathbb R$.

**Exercise 6.8 (open-ended).** Why is monotonicity *equivalent* to continuity for additive functions, not just sufficient? (I.e., why is every continuous additive function monotone? You will need: $\mathbb R$-linear means $f(x) = ax$, so $f$ is monotone iff $a \ge 0$ or $a \le 0$, which is automatic.) This is a "look, the monotone case has the same conclusion" observation.

---
