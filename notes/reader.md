# A From-Scratch Reader for *The Continuous-Coefficient Jensen Equation*, Sections 1–4 (through "Variants and limits")

> **Reader's guide** to *The Continuous-Coefficient Jensen Equation: How Real Mixing Weights Retire Regularity* (satellites/o3-maa).
> **Scope.** Section 1 (Introduction), Section 2 (the result and its proof), Section 3 (the dictionary of vestigial regularity hypotheses), and Section 4 (Variants and limits) **up to but not including** "Convex domains in higher dimensions."
> **Audience.** A returning student whose entire toolkit is **Analysis I and Algebra I** — and who earned an A in both, but a decade ago, so the grooves are dusty. No Hamel bases, no measure theory, no functional analysis are assumed. **Part R below re-cuts exactly the grooves this reader uses**, and nothing more.
> **Promise.** This note is self-contained. Everything the paper *cites* in this range — Cauchy's equation, $\mathbb{Q}$-homogeneity, the Hamel pathology, and *why each classical regularity hypothesis works* — is **reconstructed with full proofs** below. After reading it you should be able to rederive Sections 1–4 of the paper on a blank sheet of paper.
> **Sibling notes.** `notes/reader-higher-dim.md` (Theorem 6) and `notes/reader-section4.md` (all of Section 4) continue this reader; `notes/utility.md` and `notes/shannon.md` cover Section 5 applications.
> **How to use the back matter.** After the exposition come four training sections: **Part E** (extreme examples and traps), **Part X** (exercises), **Part S** (full solutions — try Part X first), and **Part D** (routines, recitations, and drills for oral-exam mastery). The intended loop is: read a Part, do its drills, attempt the matching exercises, then check Part S.

A remark on style: the paper is a piece of classical real analysis, so this reader is written in the language of real analysis. Prerequisites are kept to a minimum and proved as we go. Three of the five regularity struts (continuity, monotonicity, boundedness on the interval), the main theorem, and the whole mechanism are **pure Analysis I + Algebra I**. The only step that reaches past Analysis I is the pair of *measure-theoretic* struts (Steinhaus's difference-set theorem and Lusin's theorem); Part R.12 gives the one-screen primer you need for them, and they are clearly fenced off so you can skip them on a first pass without losing the main result.

---

## Part 0 — The whole paper in one paragraph

We study one functional equation in one unknown function $G$ on a real interval. The equation says: *Jensen's inequality holds with equality for every two-point distribution.* There are three versions, distinguished only by which mixing weights $p$ are allowed — dyadic/midpoint ($J_2$), rational ($J_\mathbb{Q}$), or all real $p\in[0,1]$ (the star equation $(\star)$). The first two versions are secretly **Cauchy's additive equation** in disguise, and Cauchy's equation has monstrous non-affine solutions built with the axiom of choice — *unless* you assume a regularity hypothesis (continuity, measurability, monotonicity, or boundedness) to tame them. The paper's one-line theorem is that the **third** version, $(\star)$, needs **no such hypothesis**: allowing *real* weights tests the unknown function at irrational points, which is exactly where the monsters live, and the equation kills them there for free. The rest of Sections 1–4 is (i) the precise dictionary of which classical hypotheses thereby become unnecessary, (ii) the structural reason it happens, and (iii) how little of the equation you actually need (a single endpoint configuration; even irrational weights alone; even just cell-by-cell).

Everything below is the expansion of that paragraph, with all background supplied.

---

## Part R — Prerequisite recall (for the returning A-student)

You aced Analysis I and Algebra I, but that was a decade ago and the muscle memory has gone quiet. This section re-cuts **exactly** the grooves this reader uses — no more. Each item is tagged with **[used in …]** so you can see why it earns its place. If a line feels obvious, that is the point; nod and move on. Nothing here is "new"; it is all first-year material, restated so you are never asked to recall something cold.

A meta-remark to calm the nerves: the *entire* main theorem of the paper (Part 5) and its mechanism (Part 6) use only R.1–R.11. The single place we step past first-year analysis is the two measure-theoretic struts, and R.12 is a self-contained primer for precisely those. So if R.12 ever feels heavy, remember it is optional scaffolding around two of five examples, not load-bearing for the headline result.

### R.1 Two sizes of infinity [used in Part 3.1, 6.4]
$\mathbb{N}\subset\mathbb{Z}\subset\mathbb{Q}\subset\mathbb{R}$. A set is **countable** if it can be listed $a_1,a_2,\dots$ in bijection with $\mathbb{N}$. Key facts you proved once and may reuse on faith:
- $\mathbb{Q}$ is **countable** (enumerate fractions by increasing $|p|+|q|$).
- A countable union of countable sets is countable.
- $\mathbb{R}$ is **uncountable** (Cantor's diagonal argument).
Consequence we lean on: since $\mathbb{R}$ is uncountable but $\mathbb{Q}$ is countable, the **irrationals $\mathbb{R}\setminus\mathbb{Q}$ are uncountable** — "almost every" real is irrational. (This is morally why a $\mathbb{Q}$-based pathology can hide from rational tests yet be exposed by an irrational one.)

### R.2 Completeness of $\mathbb{R}$: sup, inf, Archimedes [used in the killer lemma, Part 4.1]
The defining feature of $\mathbb{R}$ over $\mathbb{Q}$: **every nonempty set bounded above has a least upper bound** $\sup$ (and dually $\inf$). Two corollaries we use:
- **Archimedean property.** For every real $x$ there is an integer $n>x$; equivalently $\tfrac1n\to0$.
- A sequence that is bounded and monotone converges (to its sup or inf).
The killer lemma uses both: it takes a $\sup$ of $|g|$ over an interval, and it sends $\tfrac{B}{|n|}\to0$ by Archimedes.

### R.3 Density of $\mathbb{Q}$ and of the irrationals [used in Parts 3.4, 3.5, 4.1, 4.4, 6]
Between any two reals $a<b$ there lies
- a **rational** (take $\tfrac{m}{n}$ with $n$ large by Archimedes), and
- an **irrational** (e.g. a rational in $(a,b)$ shifted by a tiny multiple of $\sqrt2$).
So both $\mathbb{Q}$ and $\mathbb{R}\setminus\mathbb{Q}$ are **dense** in $\mathbb{R}$. The one consequence we use repeatedly: **a continuous function is determined by its values on a dense set** — if two continuous functions agree on $\mathbb{Q}$, they agree everywhere. (Contrapositive flavor in Part 3: a wildly discontinuous function can vanish on all of $\mathbb{Q}$ yet be nonzero off it.)

### R.4 Limits and continuity [used in Part 4.4]
$f$ is **continuous at $x_0$** if $x_n\to x_0\Rightarrow f(x_n)\to f(x_0)$ (equivalently the $\varepsilon$–$\delta$ form). Sums, products, and composites of continuous functions are continuous. That is all the continuity machinery we need.

### R.5 Compactness, packaged as two usable facts [used in Parts 4.4, 4.5]
You may have met compactness abstractly; here are the only two consequences we invoke:
- **Extreme Value Theorem.** A continuous function on a closed bounded interval $[a,b]$ is **bounded** and attains its max and min.
- A **monotone** function on $[a,b]$ is bounded: it lies between its two endpoint values $f(a)$ and $f(b)$.
Both deliver the same thing we want — "$g$ is bounded on an interval" — which the killer lemma converts to $g\equiv0$.

### R.6 Mathematical induction [used in Part 2.2]
To prove $P(n)$ for all $n\ge1$: show $P(1)$, then $P(n)\Rightarrow P(n+1)$. We use it once, to climb from $f(x)$ to $f(nx)=nf(x)$.

### R.7 A couple of concrete irrationalities [used in Part 7.2 and the exercises]
$\sqrt2,\sqrt3$ are irrational (if $\sqrt2=\tfrac mn$ in lowest terms then $2n^2=m^2$ forces $2\mid m$, then $2\mid n$, contradiction). A **rational plus a nonzero rational multiple of an irrational is irrational** (else subtract and divide to make the irrational rational). We will need that things like $\tfrac{v}{M}+\tfrac{2\sqrt3-\sqrt6}{2n}$ are irrational.

### R.8 Fields [used implicitly throughout; scalars in Part 3]
A **field** is a set with $+,\times$ obeying the usual laws, where every nonzero element has a multiplicative inverse. $\mathbb{Q}$ and $\mathbb{R}$ are fields. In Part 3 we deliberately demote $\mathbb{R}$: we keep only $+$ and multiplication by elements of the **smaller** field $\mathbb{Q}$.

### R.9 Vector spaces: span, independence, basis [used in Part 3.3]
A **vector space over a field $\mathbb{F}$** has vector addition and scaling by $\mathbb{F}$. Recall:
- **Span** of $S$ = all finite $\mathbb{F}$-linear combinations of elements of $S$.
- **Linearly independent**: the only finite combination equal to $0$ is the trivial one.
- **Basis** = independent spanning set; then **every vector has a unique finite coordinate expansion** in the basis.
- **A linear map is determined by — and may be assigned freely on — a basis.** (Define values on basis vectors arbitrarily, extend by linearity; well-defined by uniqueness of coordinates.) This "free assignment" is the engine that builds the monster.

### R.10 The deliberately strange vector space: $\mathbb{R}$ over $\mathbb{Q}$ [used in Part 3.1]
Treat real numbers as **vectors** and rationals as **scalars**. The vector-space axioms hold (they are inherited from $\mathbb{R}$'s field axioms). This space is infinite-dimensional: a finite (even countable) set has only countably many $\mathbb{Q}$-combinations (R.1), but $\mathbb{R}$ is uncountable, so no countable set can span. Its basis is the **Hamel basis** of Part 3.

### R.11 Zorn's lemma / the Axiom of Choice [used in Part 3.2]
The one heavy set-theoretic tool. **Zorn's lemma:** if every chain (totally ordered subset) in a partially ordered set has an upper bound, the set has a maximal element. Standard consequence: **every vector space has a basis** (take a maximal linearly independent set). For $\mathbb{R}$ over $\mathbb{Q}$ this yields the Hamel basis non-constructively — you can prove it exists but can never write it down. Worth remembering: this non-constructiveness is *exactly* why the classical theory needed a regularity hypothesis to banish the resulting monsters.

### R.12 One-screen primer: the two measure facts we borrow [used only in Parts 4.3, 4.6]
This is the **only** material past Analysis I, and it powers only two of the five struts. Skim it now; return when you reach Part 4.3.

- **Length and Lebesgue measure.** An interval $[a,b]$ has length $b-a$. Lebesgue **outer measure** of any $E\subseteq\mathbb{R}$ is $|E|=\inf\sum_k(b_k-a_k)$ over all coverings of $E$ by countably many intervals $(a_k,b_k)$. A set is **(Lebesgue-)measurable** when it splits every test set additively; intervals, open sets, and closed sets are measurable, and $|\cdot|$ matches length on intervals. "$|E|>0$" just means "$E$ is not negligibly thin."
- **Fact A (regularity).** A measurable set of positive measure can be **squeezed**: there is a compact $K\subseteq E$ with $|K|>0$ and an open $U\supseteq K$ with $|U|$ barely larger than $|K|$. (This is what makes Steinhaus's theorem work in Part 4.3.)
- **Fact B (a pigeonhole).** If $g$ is measurable, then $\mathbb{R}=\bigcup_{n}\{x:|g(x)|\le n\}$ is a countable union of measurable sets; were each of measure zero, so would be $\mathbb{R}$ (impossible). Hence **$g$ is bounded on some set of positive measure** — the input Lusin's theorem hands to Part 4.6.
- **If you skip this box:** the main theorem (Part 5), the mechanism (Part 6), and the struts of continuity / monotonicity / interval-boundedness (Parts 4.2, 4.4, 4.5) are entirely Analysis I + Algebra I and lose nothing.

> **Tag map.** Keep this index handy while reading: R.1/R.10/R.11 → the monster (Part 3); R.9 → free assignment (Part 3.3); R.2/R.3 → the killer lemma (Part 4.1); R.4/R.5 → the continuity & monotonicity struts (Parts 4.4–4.5); R.12 → the two measure struts (Parts 4.3, 4.6); R.6 → $\mathbb{Q}$-homogeneity (Part 2.2); R.7 → the irrational-weights variant (Part 7.2).

---

## Part 1 — Prerequisites, built from the ground up

### 1.1 Intervals and convex combinations

Let $I\subseteq\mathbb{R}$ be an **interval** (a set such that if $a,b\in I$ and $a<c<b$ then $c\in I$). The paper works on the closed interval $I=[0,M]$ for a fixed $M>0$.

For two points $u_1,u_2\in I$ and a **weight** $p\in[0,1]$, the point
$$
p\,u_1+(1-p)\,u_2
$$
is their **convex combination** with weights $p$ and $1-p$. As $p$ ranges over $[0,1]$, this traces the segment from $u_2$ (at $p=0$) to $u_1$ (at $p=1$). Because $I$ is an interval, every such combination stays in $I$: intervals are **convex sets**.

### 1.2 Convex and concave functions; the equality question

A function $G\colon I\to\mathbb{R}$ is **concave** if for all $u_1,u_2\in I$ and $p\in[0,1]$,
$$
p\,G(u_1)+(1-p)\,G(u_2)\ \le\ G\bigl(p\,u_1+(1-p)\,u_2\bigr),
$$
and **convex** if the reverse inequality holds. Geometrically, concave means *the chord lies on or below the graph*; convex means *the chord lies on or above the graph*.

The probabilistic packaging is **Jensen's inequality**. A **two-point distribution** places probability $p$ on the value $u_1$ and $1-p$ on $u_2$; a random variable $\xi$ with this law has expectation $\mathbb{E}[\xi]=p\,u_1+(1-p)\,u_2$, and $\mathbb{E}[G(\xi)]=p\,G(u_1)+(1-p)\,G(u_2)$. So for concave $G$, Jensen's inequality $\mathbb{E}[G(\xi)]\le G(\mathbb{E}[\xi])$ is *exactly* the displayed inequality above. (For general distributions Jensen's inequality is more, but two-point distributions are all we need.)

The paper's opening question is the **equality case**: *for which $G$ does equality hold for every two-point distribution on $I$?* Writing the equality out for all admissible $u_1,u_2,p$ gives the central object of the paper:
$$
p\,G(u_1)+(1-p)\,G(u_2)\;=\;G\bigl(p\,u_1+(1-p)\,u_2\bigr)
\qquad(u_1,u_2\in I,\ p\in[0,1]).
\tag{$\star$}
$$
We call a function satisfying $(\star)$ a **saturated** solution (Jensen's inequality is "saturated" — equality everywhere). The whole paper is about *what saturation forces $G$ to be*, and how the answer depends on which weights $p$ we demand it for.

### 1.3 Affine functions — the expected answer

A function $G\colon I\to\mathbb{R}$ is **affine** if $G(v)=av+b$ for constants $a,b\in\mathbb{R}$. Equivalently (and this is the form we will keep using), $G$ is affine iff it equals the straight line through its endpoint values: on $[0,M]$,
$$
G(v)=\frac{G(M)-G(0)}{M}\,v+G(0).
$$
A one-line check shows **every affine function satisfies $(\star)$**: substitute $G(u)=au+b$ into both sides of $(\star)$ and use $p+(1-p)=1$. So affine functions are *always* solutions. The content of the paper is the **converse** — when is an affine function the *only* solution? — and the surprise is how violently the answer depends on the allowed weights.

> Intuition (kept brief, as requested): a concave function is "domed." A two-point chord can only touch the dome along a flat stretch. Demanding that *every* chord lie *on* the graph says the graph has no curvature anywhere — it is a straight line. That is the affine conclusion we are trying to make rigorous, and to make rigorous *without secretly assuming smoothness*.

---

## Part 2 — The three forms of the equation

The equation $(\star)$ has three classical specializations, by restricting the weight set for $p$.

### 2.1 The discrete-coefficient (midpoint) form $(J_2)$

Take only $p=\tfrac12$:
$$
G\!\left(\frac{u_1+u_2}{2}\right)=\frac{G(u_1)+G(u_2)}{2}.
\tag{$J_2$}
$$
This is **Jensen's functional equation**. It looks weaker than $(\star)$ — and it is — but it is the historically central one.

**Reduction to Cauchy's equation.** Define $f(x):=G(x)-G(0)$, so $f(0)=0$. (We argue on a translate of $I$ so that $0$ is an interior reference point; on $[0,M]$ this is harmless for the algebra that follows, and the paper's actual proof in Part 5 will not even need this reduction.) Then $(J_2)$ for $G$ is equivalent to $(J_2)$ for $f$ with $f(0)=0$. Put $u_2=0$ in $(J_2)$ for $f$:
$$
f\!\left(\frac{x}{2}\right)=\frac{f(x)+f(0)}{2}=\frac{f(x)}{2}.
$$
Now apply this with argument $x+y$ in place of $x$, and compare with $(J_2)$:
$$
\frac{f(x+y)}{2}=f\!\left(\frac{x+y}{2}\right)=\frac{f(x)+f(y)}{2}
\ \Longrightarrow\
\boxed{f(x+y)=f(x)+f(y)}.
$$
This last equation is **Cauchy's additive functional equation**. So *solving $(J_2)$ is the same problem as solving Cauchy's equation* (up to the additive constant $G(0)$). Everything pathological about $(J_2)$ is inherited from Cauchy's equation, which we now mine.

### 2.2 Cauchy's equation forces $\mathbb{Q}$-homogeneity (full proof)

**Claim.** If $f\colon\mathbb{R}\to\mathbb{R}$ satisfies $f(x+y)=f(x)+f(y)$ for all $x,y$, then $f(qx)=q\,f(x)$ for every **rational** $q$ and every real $x$. (We say $f$ is **$\mathbb{Q}$-homogeneous**, or **$\mathbb{Q}$-linear** together with additivity.)

*Proof.* Four elementary steps.

1. **Zero.** $f(0)=f(0+0)=f(0)+f(0)$, so $f(0)=0$.
2. **Positive integers.** By induction, $f(nx)=n\,f(x)$: the base $n=1$ is trivial, and $f((n+1)x)=f(nx+x)=f(nx)+f(x)=n f(x)+f(x)=(n+1)f(x)$.
3. **Negatives.** $0=f(0)=f(x+(-x))=f(x)+f(-x)$, so $f(-x)=-f(x)$; combined with step 2, $f(nx)=n f(x)$ for **all** integers $n$.
4. **Reciprocals and fractions.** For a positive integer $n$, $f(x)=f\!\bigl(n\cdot\tfrac{x}{n}\bigr)=n\,f\!\bigl(\tfrac{x}{n}\bigr)$, hence $f\!\bigl(\tfrac{x}{n}\bigr)=\tfrac1n f(x)$. For a general rational $q=\tfrac{m}{n}$, combine with step 3: $f\!\bigl(\tfrac{m}{n}x\bigr)=m\,f\!\bigl(\tfrac{x}{n}\bigr)=\tfrac{m}{n}f(x)$. $\qquad\blacksquare$

Note what we did **not** get: $f(rx)=r\,f(x)$ for *irrational* $r$. Cauchy's equation says nothing about irrational scaling. That gap is the entire story.

### 2.3 The rational-coefficient form $(J_\mathbb{Q})$ collapses onto $(J_2)$ (full proof)

Now allow all **rational** weights $p\in[0,1]\cap\mathbb{Q}$:
$$
p\,G(u_1)+(1-p)\,G(u_2)=G\bigl(p\,u_1+(1-p)\,u_2\bigr)
\qquad(u_1,u_2\in I,\ p\in[0,1]\cap\mathbb{Q}).
\tag{$J_\mathbb{Q}$}
$$

**Claim.** $(J_\mathbb{Q})$, $(J_2)$, and Cauchy's equation have the *same* solution class (up to the constant $G(0)$).

*Proof.* $(J_\mathbb{Q})\Rightarrow(J_2)$ is immediate ($\tfrac12$ is rational). Conversely, take $f$ additive (the content of $(J_2)$, by 2.1). For rational $p$ and any $u_1,u_2$,
$$
f\bigl(p\,u_1+(1-p)\,u_2\bigr)
\overset{\text{additivity}}{=}f(p\,u_1)+f((1-p)u_2)
\overset{\mathbb{Q}\text{-hom.}}{=}p\,f(u_1)+(1-p)\,f(u_2),
$$
which is $(J_\mathbb{Q})$ for $f$, hence for $G=f+G(0)$. So additivity (equivalently $(J_2)$) already *implies* $(J_\mathbb{Q})$. The three are interchangeable. $\qquad\blacksquare$

**Moral.** Strengthening from "midpoint only" to "all rational weights" buys you **nothing**: $\mathbb{Q}$-homogeneity was free from additivity. The rational comb of weights is fully passed by any additive function — including the monsters we build next.

### 2.4 The continuous-coefficient form $(\star)$ — the claim of genuine difference

The third form is $(\star)$ itself, with *all real* $p\in[0,1]$. The paper's thesis is that the jump from $\mathbb{Q}$ to $\mathbb{R}$ in the weight is **not** cosmetic the way the jump from $\{\tfrac12\}$ to $\mathbb{Q}$ was: real weights test $G$ at irrational scalings, exactly where $\mathbb{Q}$-homogeneity is silent and the monsters live. Part 5 proves this; Part 6 explains the mechanism. But first we must build the monsters, or the claim is empty.

---

## Part 3 — The pathology: Hamel bases and a non-affine additive function

This part reconstructs, from the axiom of choice, a solution of $(J_2)$ and $(J_\mathbb{Q})$ that is **not** affine. Without it, the regularity dictionary of Part 4 would have nothing to defend against. This is the paper's Proposition (`prop:JQ-pathology`), built in full.

### 3.1 $\mathbb{R}$ as a vector space over $\mathbb{Q}$

Forget that you can multiply real numbers; keep only addition and multiplication **by rationals**. Then $\mathbb{R}$ is a **vector space over the field $\mathbb{Q}$**: vectors are real numbers, scalars are rationals, and the axioms (associativity, distributivity, etc.) hold because they hold in $\mathbb{R}$. This is a strange, enormous vector space — it is infinite-dimensional over $\mathbb{Q}$ (indeed uncountably so), because $\mathbb{Q}$ is countable but $\mathbb{R}$ is not, so no finite or countable $\mathbb{Q}$-combination can exhaust $\mathbb{R}$.

### 3.2 A Hamel basis exists (axiom of choice)

A **Hamel basis** is, by definition, a basis $H\subseteq\mathbb{R}$ of this $\mathbb{Q}$-vector space: a set such that every real $x$ has a **unique** representation as a *finite* rational combination
$$
x=q_1 h_1+\dots+q_k h_k,\qquad q_i\in\mathbb{Q}\setminus\{0\},\ h_i\in H\ \text{distinct}.
$$
Does such a basis exist? Yes — **every** vector space has a basis, by **Zorn's lemma** (equivalently, the axiom of choice). One takes a maximal $\mathbb{Q}$-linearly independent set; maximality forces it to span. This existence is *non-constructive*: you cannot write down a Hamel basis explicitly, and indeed Solovay showed it is consistent with the other axioms of set theory (ZF + dependent choice) that **no** non-affine solution of Cauchy's equation exists at all. So the monsters are precisely a product of the axiom of choice — this is worth internalizing, because it is the deep reason the classical theory needed a *regularity hypothesis* to exclude them.

### 3.3 Building a non-affine additive function

Once you have a Hamel basis $H$, you can define an additive function by **assigning its values on the basis completely freely** and extending by $\mathbb{Q}$-linearity. Concretely: choose any function $\varphi\colon H\to\mathbb{R}$, and define
$$
f\bigl(q_1h_1+\dots+q_kh_k\bigr):=q_1\varphi(h_1)+\dots+q_k\varphi(h_k).
$$
This is well-defined (representations are unique) and additive (add two finite combinations termwise). It is $\mathbb{Q}$-linear by construction.

**When is such an $f$ non-affine?** An affine $f$ with $f(0)=0$ is exactly $f(x)=cx$ for a constant $c$, i.e. $\varphi(h)=c\,h$ for *every* basis element. So to get a *non-affine* solution it suffices to pick $\varphi$ that is **not** proportional to the identity on $H$ — e.g. fix two basis elements $h_a,h_b$ and set $\varphi(h_a)/h_a\neq\varphi(h_b)/h_b$. Then $f$ satisfies Cauchy's equation, hence $(J_2)$ and $(J_\mathbb{Q})$, yet is not of the form $cx$. The monster exists.

### 3.4 The interval domain trap, and the paper's fix

The paper needs the pathology on the bounded interval $[0,1]$, not on all of $\mathbb{R}$, and here a subtle trap appears, which the paper flags explicitly. Restricting an additive $f\colon\mathbb{R}\to\mathbb{R}$ to $[0,1]$ gives a solution of $(J_\mathbb{Q})$ on $[0,1]$ (rational convex combinations of points of $[0,1]$ stay in $[0,1]$, and $f$ respects them). But to *exhibit* non-affineness inside $[0,1]$ you want a basis element to actually lie in $(0,1)$ — and **cardinality alone does not guarantee that**: one can rescale every basis element into $[1,2]$, producing a perfectly good Hamel basis that avoids $(0,1)$ entirely.

The paper's device (after Reem, after an idea of Boros): start from any Hamel basis $H_0$ containing $1$; pick $h'\in H_0\setminus\{1\}$ (necessarily irrational, since two distinct rationals are $\mathbb{Q}$-dependent); choose a positive rational $q$ with $h:=qh'\in(0,1)$; and replace $h'$ by $h$. **Rescaling a basis element by a nonzero rational preserves both independence and spanning**, so $H:=(H_0\setminus\{h'\})\cup\{h\}$ is again a Hamel basis, now containing both $1$ and an irrational $h\in(0,1)$.

Define $\ell\colon\mathbb{R}\to\mathbb{R}$ by $\ell(1)=0$, $\ell(h)=1$, and $\ell=$ anything $\mathbb{Q}$-linear on the rest. Set $G:=\ell|_{[0,1]}$. Then:

- $G$ satisfies $(J_\mathbb{Q})$ on $[0,1]$ (it is the restriction of a $\mathbb{Q}$-linear map).
- **$G$ is wildly non-affine.** For every rational $q\in[0,1]$, $\ell(q)=q\,\ell(1)=0$, so $G$ vanishes on the dense set $\mathbb{Q}\cap[0,1]$; yet $G(h)=\ell(h)=1\neq0$. Any affine map agreeing with $G$ on $\mathbb{Q}\cap[0,1]$ would be identically $0$ (it vanishes at the dense rationals), contradicting $G(h)=1$.

### 3.5 The monster violates *every* regularity hypothesis at once

The function $G$ just built has graph **dense in $[0,1]\times\mathbb{R}$**. (Sketch: the graph is a $\mathbb{Q}$-linear subspace of the plane that is not a single line; a standard fact is that such a subspace is dense. Concretely, $G$ takes the value $0$ on a dense set and the value $q$ on the dense set $q\cdot(\mathbb{Q}+\mathbb{Z}h)\cap[0,1]$ for every rational $q$, so the graph meets every open box.) A function with dense graph is:

- **not continuous** anywhere,
- **not monotone** on any subinterval,
- **not bounded** on any subinterval (it gets arbitrarily large and small on every interval),
- **not Lebesgue measurable** (we prove this is forced in Part 4.6).

So a single object simultaneously refutes the converse for $(J_2)$/$(J_\mathbb{Q})$ under *all* the classical hypotheses dropped. **This is the precise sense in which $(J_2)$ and $(J_\mathbb{Q})$ require a regularity hypothesis**: without one, this monster is a legitimate non-affine solution.

---

## Part 4 — The dictionary: why each classical hypothesis rescues $(J_2)$

We now reconstruct the **classical** half of the paper's central table: for the discrete/rational equation, *any one* of five regularity hypotheses on $G$ forces affineness. The unifying engine is a single lemma, after which each strut is a short corollary. Throughout, $g$ denotes the "defect"
$$
g(x):=f(x)-f(1)\,x,
$$
where $f$ is the additive function ($f=G-G(0)$). Note $g$ is additive (difference of additive functions), and $g$ **vanishes on $\mathbb{Q}$**: $g(q)=f(q)-f(1)q=q f(1)-f(1)q=0$ by $\mathbb{Q}$-homogeneity. Affineness of $G$ is exactly the statement $g\equiv0$.

### 4.1 The master lemma: local boundedness kills the defect

> **Lemma (the killer).** Let $g\colon\mathbb{R}\to\mathbb{R}$ be additive with $g|_\mathbb{Q}=0$. If $g$ is **bounded on some interval** $(a,b)$, then $g\equiv0$.

*Proof.* Let $B:=\sup_{(a,b)}|g|<\infty$. Because $g$ is additive and vanishes on $\mathbb{Q}$, it is **invariant under rational translation**: for $x\in\mathbb{R}$ and $q\in\mathbb{Q}$,
$$
g(x+q)=g(x)+g(q)=g(x).
$$
Now the rational translates $\{(a,b)+q : q\in\mathbb{Q}\}$ **cover all of $\mathbb{R}$** (translating an interval of positive length by a fine enough rational grid leaves no gaps). Since $g$ on $(a,b)+q$ equals $g$ on $(a,b)$, we get $|g|\le B$ on **all** of $\mathbb{R}$. Finally, additivity gives $g(nt)=n\,g(t)$ for every integer $n$, so
$$
|g(t)|=\frac{|g(nt)|}{|n|}\le\frac{B}{|n|}\xrightarrow[n\to\infty]{}0,
$$
forcing $g(t)=0$ for every $t$. $\qquad\blacksquare$

Everything in the dictionary now reduces to *"this hypothesis makes $g$ bounded on some interval."*

### 4.2 Boundedness on the interval $\Rightarrow$ affine (Darboux)

If $G$ is bounded on $I$, then $f$ is bounded on $I$, hence $g=f-f(1)x$ is bounded on $I$ (sum of a bounded function and a bounded linear function on a bounded interval). The killer lemma gives $g\equiv0$, i.e. $G$ affine. *Done — directly.*

### 4.3 Boundedness on a positive-measure set $\Rightarrow$ affine (Kormes; one-sided: Ostrowski, Kestelman)

Here we need one standard tool.

> **Steinhaus difference-set theorem.** If $E\subseteq\mathbb{R}$ is Lebesgue measurable with $|E|>0$, then the difference set $E-E=\{x-y:x,y\in E\}$ contains an open interval $(-\delta,\delta)$ around $0$.

*Proof sketch.* By inner regularity pick a compact $K\subseteq E$ with $|K|>0$, and by outer regularity an open $U\supseteq K$ with $|U|<2|K|$. For small $|t|$, the translate $K+t$ cannot be disjoint from $K$ (else $K\cup(K+t)\subseteq U$ would have measure $2|K|>|U|$), so $K$ and $K+t$ intersect, giving $t\in K-K\subseteq E-E$. Hence a whole interval of $t$ lies in $E-E$. $\square$

Now suppose $g$ (equivalently $G$) is bounded on a measurable set $E$ with $|E|>0$, say $|g|\le C$ on $E$. For $t\in E-E$, write $t=x-y$ with $x,y\in E$; then $|g(t)|=|g(x)-g(y)|\le 2C$. So $g$ is bounded (by $2C$) on $E-E\supseteq(-\delta,\delta)$ — i.e. bounded on an interval. The killer lemma finishes it. (The **one-sided** refinement — bounded *above* on a positive-measure set already suffices — follows because an additive function bounded above near $0$ is also bounded below there: $g(-t)=-g(t)$.) *Done.*

### 4.4 Continuity $\Rightarrow$ affine (Cauchy)

A continuous function on a closed bounded interval is bounded, so continuity on $[0,M]$ implies boundedness on $[0,M]$, and 4.2 applies. (Even more directly: $g$ continuous and $g|_\mathbb{Q}=0$ with $\mathbb{Q}$ dense gives $g\equiv0$ by continuity.) *Done.*

### 4.5 Monotonicity $\Rightarrow$ affine (Darboux)

If $G$ is monotone, it is bounded on the bounded interval $[0,M]$ (a monotone function on $[a,b]$ lies between its endpoint values), so 4.2 applies. *Done.* (Classically one argues directly: a monotone $g$ vanishing on the dense set $\mathbb{Q}$ is squeezed to $0$ everywhere.)

### 4.6 Measurability $\Rightarrow$ affine (Sierpiński)

Here we need the second standard tool.

> **Lusin's theorem (consequence used).** A Lebesgue-measurable function is **bounded on some set of positive measure**. (Indeed, $\mathbb{R}=\bigcup_n\{|g|\le n\}$ is a countable union of measurable sets; if all had measure zero so would $\mathbb{R}$. Hence some $\{|g|\le n\}$ has positive measure.)

So a measurable $g$ is bounded on a positive-measure set, and 4.3 (Steinhaus + killer lemma) gives $g\equiv0$. *Done.*

### 4.7 Summary of the classical column

Every strut routes through the same chokepoint:
$$
\text{strut}\ \Longrightarrow\ g\ \text{bounded on an interval}\ \Longrightarrow\ g\equiv0\ \Longrightarrow\ G\ \text{affine},
$$
with Steinhaus converting "positive measure" into "interval," and Lusin converting "measurable" into "positive measure." This is the entire left column of the paper's Table 1 (its Figure 1, panel (a): "any single strut suffices to hold the beam"), and **the monster of Part 3 shows the beam falls if you remove them all.** Crucially, *none* of these arguments can reach an irrational weight directly — they all work by squeezing the defect through density/measure of the **rationals**. Hold that thought for Part 6.

---

## Part 5 — The main theorem and its one-line proof (Sections 1.2, 2)

We now leave the classical world. The next result is the heart of the paper, and it dispenses with **every** strut of Part 4.

### 5.1 The theorem

> **Theorem 1 (`thm:main`).** Let $M>0$ and let $G\colon[0,M]\to\mathbb{R}$ satisfy $(\star)$ for *every* $u_1,u_2\in[0,M]$ and *every* $p\in[0,1]$. Then $G$ is affine:
> $$
> G(v)=\frac{G(M)-G(0)}{M}\,v+G(0),\qquad v\in[0,M].
> $$
> **No regularity hypothesis on $G$ is required** — not continuity, measurability, monotonicity, nor boundedness.

### 5.2 The proof (the "endpoint substitution")

*Proof.* Fix any $v\in[0,M]$. Choose the single configuration
$$
u_1:=M,\qquad u_2:=0,\qquad p:=\frac{v}{M}.
$$
These are admissible: $M,0\in[0,M]$ and $p=v/M\in[0,1]$ since $v\in[0,M]$. Substitute into $(\star)$:
$$
\frac{v}{M}\,G(M)+\left(1-\frac{v}{M}\right)G(0)
= G\!\left(\frac{v}{M}\cdot M+\left(1-\frac{v}{M}\right)\cdot 0\right)
= G(v).
$$
Rearranging,
$$
G(v)=G(0)+\bigl(G(M)-G(0)\bigr)\frac{v}{M}. \qquad\blacksquare
$$

That is the whole proof. The single weight $p=v/M$ **pins** the value $G(v)$ onto the chord through the two endpoint points $(0,G(0))$ and $(M,G(M))$. One weight per point, every point forced, the chord forced everywhere. This is the paper's Figure 2, panel (a).

### 5.3 Regularity is the *conclusion*, not the hypothesis

> **Corollary (`cor:regularity`).** Under the hypotheses of Theorem 1, $G$ is automatically continuous, monotone, locally Lipschitz, absolutely continuous, and Lebesgue measurable.

*Proof.* $G$ is affine, $G(v)=av+b$ with $a=(G(M)-G(0))/M$. Every affine function on a bounded interval is differentiable with constant derivative $a$ (hence continuous and locally Lipschitz with constant $|a|$), monotone (non-decreasing if $a\ge0$, else non-increasing), absolutely continuous, and Borel — hence Lebesgue — measurable. $\qquad\blacksquare$

**The order of inference is the entire point of the paper.** For $(J_2)$ a regularity property is an *input* you must assume to exclude the monster (Part 4). For $(\star)$ the very same properties are *outputs* — the equation manufactures its own regularity from within. Each hypothesis is therefore **vestigial**: classically required for $(J_2)$, naively expected for $(\star)$, but in fact unnecessary for $(\star)$. This is the paper's Figure 1, panel (b): the bare equation is the pedestal that holds the beam; every strut is redrawn as "removed," each one now a conclusion.

---

## Part 6 — The structural mechanism: why the monster dies under $(\star)$ (Section 3.2)

Part 5 *proves* affineness, but it does not yet *explain* why the monster of Part 3 — which sailed through $(J_2)$ and $(J_\mathbb{Q})$ — cannot also sail through $(\star)$. The explanation is the conceptual core of the paper, and it is one sentence.

### 6.1 The endpoint configuration as a linearity test

Specialize $(\star)$ to the configuration used in the proof, $u_1=M$, $u_2=0$:
$$
p\,G(M)+(1-p)\,G(0)=G(pM)
\qquad(p\in[0,1]).
\tag{$\star_0$}
$$
For a Hamel-pathological solution $f$ (so $f(0)=0$), $(\star_0)$ reads
$$
p\,f(M)=f(pM),
$$
which is **exactly the assertion that $f$ is $\mathbb{R}$-linear at the pair $(M,p)$** — i.e. that scaling the input by $p$ scales the output by $p$.

### 6.2 The rational comb versus the irrational weight

Recall the two facts we proved:

- By **$\mathbb{Q}$-homogeneity** (Part 2.2), $f(pM)=p\,f(M)$ holds for **every rational** $p$. So the monster satisfies $(\star_0)$ — and hence $(J_\mathbb{Q})$ — at every point of the **rational comb** of weights. *It passes every rational test.*
- By **construction** (Part 3.3–3.4), the monster is **not** $\mathbb{R}$-linear: there is some **irrational** $p$ (and a suitable point) at which $f(pM)\neq p\,f(M)$. So the monster **fails** $(\star_0)$ at that irrational weight.

Therefore: the monster satisfies $(J_\mathbb{Q})$ (rational weights only) but **violates $(\star)$** at the irrational weights where its $\mathbb{R}$-linearity defect lives. The continuous-coefficient equation tests $G$ at those irrational weights — and forecloses on the pathology there. In one sentence (the paper's display):

> **The Hamel pathology lives at irrational $p$; the continuous-coefficient equation $(\star)$ forecloses on it there.**

This is the paper's Figure 2, panel (b): $(J_\mathbb{Q})$ probes only the rational comb, where a $\mathbb{Q}$-linear monster passes every test; $(\star)$ additionally probes an irrational weight such as $1/\sqrt2$, and the monster dies.

### 6.3 Reading the classical program in hindsight

The whole classical effort of Part 4 — Cauchy 1821 through Kestelman 1947 — can now be reread as the search for a regularity hypothesis that could **substitute** for the one test that $(J_2)/(J_\mathbb{Q})$ cannot perform: the constraint at irrational weights. Continuity, measurability, monotonicity, boundedness are four different ways to *propagate* the rational-comb information to the irrationals by a limiting/density argument. The continuous-coefficient equation makes the irrational constraint **directly available**, so the entire substitution program becomes unnecessary — the dictionary collapses.

### 6.4 The rational version provably keeps the monster (the Proposition)

For completeness, the paper records that the collapse is genuinely due to the real weights, by exhibiting the monster as an explicit counterexample for the rational equation. This is the construction of Part 3.4 restated as a proposition:

> **Proposition (`prop:JQ-pathology`; folklore, cf. Kuczma §§5.2, 13.2).** There exists $G\colon[0,1]\to\mathbb{R}$ satisfying $(J_\mathbb{Q})$ (hence $(J_2)$) on $[0,1]$ that is not affine.

The witness is the function $G=\ell|_{[0,1]}$ of Part 3.4, with $\ell(1)=0$, $\ell(h)=1$ for an irrational $h\in(0,1)$: it vanishes on the dense rationals yet equals $1$ at $h$, so no affine function can agree with it, while $\mathbb{Q}$-linearity gives $(J_\mathbb{Q})$. This **sharpens the dictionary**: it is *not* that we merely failed to prove affineness for $(J_\mathbb{Q})$ without regularity — affineness is genuinely **false** there. Only the strengthening to real weights, $(\star)$, retires the regularity requirement.

---

## Part 7 — Variants and limits (Section 4, up to higher dimensions)

The endpoint-substitution proof is so frugal that three sharpenings follow immediately. Each tells you *how little* of $(\star)$ the conclusion actually consumes. (We stop exactly where the paper's "Convex domains in higher dimensions" begins.)

### 7.1 The strict-minimum hypothesis (Theorem 2)

The proof of Theorem 1 used $(\star)$ at the **single** configuration $u_1=M,u_2=0$. Isolating that:

> **Theorem 2 (`thm:weak`).** Let $M>0$ and let $G\colon[0,M]\to\mathbb{R}$ satisfy
> $$
> p\,G(M)+(1-p)\,G(0)=G(pM)\qquad\text{for all }p\in[0,1].
> $$
> Then $G(v)=G(0)+\bigl(G(M)-G(0)\bigr)v/M$ on $[0,M]$.

*Proof.* Set $p:=v/M\in[0,1]$; the hypothesis gives $p\,G(M)+(1-p)G(0)=G(pM)=G(v)$, and rearranging gives the affine formula. $\qquad\blacksquare$

This is *in principle* weaker than Theorem 1 — assuming the identity at one configuration does not, a priori, give the full $(\star)$ for all pairs $(u_1,u_2)$. (Once the conclusion holds, of course both are true, since affine functions satisfy full $(\star)$.) Theorem 2 is the right reference when you want to state **exactly** how much of the equation a derivation consumes. In practice an applied derivation usually produces full $(\star)$ anyway.

### 7.2 Irrational weights alone suffice (Remark)

Even the rational weights are dispensable — fitting, since Part 6 located the monster precisely at the irrationals.

> **Remark (`rem:irrational`).** Suppose $(\star)$ holds merely for every **irrational** $p\in(0,1)$. Then $G$ is still affine.

*Proof.* Let $L(v):=G(0)+\bigl(G(M)-G(0)\bigr)v/M$ be the endpoint interpolant. Two cases for a point $v\in(0,M)$.

- **$v/M$ irrational.** The endpoint substitution at the (now admissible) irrational weight $p=v/M$ gives $G(v)=L(v)$ directly.
- **$v/M$ rational.** We cannot use $p=v/M$, so we manufacture $v$ as an irrational mixture of two irrational-coordinate points. Fix the irrational weight $p=\tfrac{\sqrt2}{2}$. Choose $\varepsilon>0$ with $\varepsilon/M=\tfrac{\sqrt3}{n}$ for an integer $n$ large enough that
$$
u_1:=v+(1-p)\varepsilon,\qquad u_2:=v-p\varepsilon
$$
both lie in $[0,M]$. A short check shows $u_1/M$ and $u_2/M$ are irrational (each is the rational $v/M$ plus an irrational multiple of $\sqrt3/n$ and $\sqrt6/(2n)$). Hence by the first case $G(u_1)=L(u_1)$ and $G(u_2)=L(u_2)$ are already known. Since $p\,u_1+(1-p)u_2=v$ by design, applying $(\star)$ at the irrational weight $p$ to the pair $(u_1,u_2)$ gives
$$
G(v)=p\,G(u_1)+(1-p)G(u_2)=p\,L(u_1)+(1-p)L(u_2)=L(v),
$$
the last equality because $L$ is affine. $\qquad\blacksquare$

### 7.3 Piecewise saturation (Corollary)

Finally, $(\star)$ need only hold **cell by cell**.

> **Corollary (`cor:piecewise`).** Let $0=m_0<m_1<\dots<m_k=M$ and suppose $G\colon[0,M]\to\mathbb{R}$ satisfies $(\star)$ *separately on each cell* $[m_{i-1},m_i]$ (i.e. for all $u_1,u_2$ in a common cell and all $p\in[0,1]$). Then $G$ is affine on each cell, hence **piecewise affine** on $[0,M]$ and **automatically continuous** — with no regularity assumed. Global affineness need *not* follow: slopes may differ across knots.

*Proof.* On each cell apply Theorem 1 after the affine change of variable $v\mapsto(v-m_{i-1})/(m_i-m_{i-1})$ that maps the cell to $[0,1]$; this gives an affine formula on each cell. Continuity at an interior knot $m_i$ holds because the affine formulas of the two adjacent cells both evaluate at $m_i$ to the same number $G(m_i)$. $\qquad\blacksquare$

This is the exact form in which Theorem 1 is consumed by the calibration application of Section 5 (a surrogate score that aggregates exactly on each of $[0,\tfrac12]$ and $[\tfrac12,1]$ is forced into the "tent" shape — piecewise affine with a possible kink — assuming nothing at the kink). It is the natural bridge into the applications, which the sibling notes `utility.md` and `shannon.md` take up.

---

## Part 8 — A from-scratch reconstruction checklist

If you want to reproduce Sections 1–4 on a blank page, here is the dependency order. Each item is fully proved above.

1. **Definitions.** Interval, convex combination, concave/convex (chord vs. graph), Jensen's inequality for two-point laws, affine function, the three weight regimes. *(Part 1, 2.1, 2.4)*
2. **$(J_2)\Leftrightarrow$ Cauchy.** Substitute $f=G-G(0)$, set $u_2=0$, derive $f(x+y)=f(x)+f(y)$. *(Part 2.1)*
3. **$\mathbb{Q}$-homogeneity.** Induction + negatives + reciprocals: $f(qx)=qf(x)$ for rational $q$. *(Part 2.2)*
4. **$(J_\mathbb{Q})\equiv(J_2)$.** Additivity $+$ $\mathbb{Q}$-homogeneity reproduce the rational-weight identity. *(Part 2.3)*
5. **The monster.** $\mathbb{R}$ over $\mathbb{Q}$; Zorn $\Rightarrow$ Hamel basis; free assignment on the basis $\Rightarrow$ non-affine additive $f$; rational-rescaling fix to land in $(0,1)$; dense graph. *(Part 3)*
6. **The classical dictionary.** Killer lemma (rational-translation invariance $+$ $g(nt)=ng(t)$); Steinhaus; Lusin; deduce continuity / measurability / monotonicity / both boundedness hypotheses each force $g\equiv0$. *(Part 4)*
7. **Theorem 1.** Endpoint substitution $u_1=M,u_2=0,p=v/M$. *(Part 5.2)*
8. **Corollary.** Affine $\Rightarrow$ all five regularity properties — they are conclusions. *(Part 5.3)*
9. **Mechanism.** $(\star_0)$ is the $\mathbb{R}$-linearity test; monster passes the rational comb, fails at an irrational weight. *(Part 6)*
10. **$(J_\mathbb{Q})$ keeps the monster.** Explicit non-affine witness on $[0,1]$. *(Part 6.4)*
11. **Variants.** Strict-minimum (single configuration); irrational weights alone; piecewise saturation. *(Part 7)*

The logical spine is short: **steps 2–4 reduce the discrete problem to Cauchy; step 5 produces the obstruction; step 6 is the classical rescue; steps 7–9 are the paper's actual contribution — the real-weight equation needs no rescue because it tests the obstruction's home turf directly.**

---

## Part 9 — A 60-second recap

1. $(\star)$ asks Jensen's inequality to hold with **equality** for every two-point law on $[0,M]$. Affine functions always qualify; the question is whether they are the only ones.
2. The **midpoint** $(J_2)$ and **rational** $(J_\mathbb{Q})$ versions are Cauchy's equation in disguise; $\mathbb{Q}$-homogeneity is free, so the rational comb adds nothing.
3. Cauchy's equation has **non-affine monsters** built from a **Hamel basis** (axiom of choice). They are $\mathbb{Q}$-linear, dense-graphed, and violate every regularity property at once.
4. Classically, **any one** regularity hypothesis (continuity, measurability, monotonicity, boundedness on an interval, or on a positive-measure set) excludes the monsters — all via "local boundedness $\Rightarrow$ defect $\equiv0$," powered by Steinhaus and Lusin.
5. **Theorem 1:** the **real-weight** equation $(\star)$ forces affineness with **no** regularity hypothesis, by one substitution $u_1=M,u_2=0,p=v/M$ that pins each value onto the endpoint chord.
6. **Why:** the monster's defect is exactly its failure of $\mathbb{R}$-linearity, which lives at **irrational** weights; $(J_\mathbb{Q})$ never tests there, but $(\star)$ does, and kills it. So every classical hypothesis is **vestigial** for $(\star)$ — it reappears as a *conclusion* (the Corollary), not an assumption.
7. **Frugality:** one endpoint configuration suffices (Theorem 2); even irrational weights alone suffice (Remark); even cell-by-cell saturation suffices and yields piecewise-affine, automatically continuous solutions (Corollary) — the form the applications consume.

---

**Next:** `notes/utility.md` and `notes/shannon.md` apply this machinery to Section 5 (expected utility and Shannon entropy). The "Convex domains in higher dimensions" subsection (Theorem 11), deliberately omitted here, extends Theorem 1 from an interval to a convex subset of $\mathbb{R}^n$ and is the natural next reading.

---

## Part E — Extreme examples & common traps

These are the places a careful reader (or examiner) will try to make you stumble. Each trap states the **plausible-sounding false claim**, the **reason it is tempting**, and the **kill** (the precise reason it is wrong, with the witness). Internalize the kills; an oral examiner lives here.

> **Trap E1 — "$(J_2)$ forces $G$ affine; regularity is just for tidiness."** *Tempting because:* every example you can draw (and every continuous solution) is affine. *Kill:* the Hamel monster (Part 3) is a non-affine solution of $(J_2)$. Without a regularity hypothesis the implication is **false**. This is the single most important trap; the entire paper exists because of it.

> **Trap E2 — "$\mathbb{Q}$-homogeneous $\Rightarrow$ $\mathbb{R}$-homogeneous."** *Tempting because:* $f(qx)=qf(x)$ holds for a dense set of scalars $q$, and "dense ought to be enough." *Kill:* density is *not* enough without continuity. The monster has $f(q\cdot 1)=q f(1)$ for all rational $q$ but $f(h)\ne h f(1)$ at the irrational $h$. Scaling by an irrational is exactly the untested direction (Part 6).

> **Trap E3 — "Additive $\Rightarrow$ linear."** Same content as E2, phrased for Cauchy's equation. *Kill:* additive gives only $\mathbb{Q}$-linearity; $\mathbb{R}$-linearity needs one extra regularity input. Never write "$f$ additive, so $f(x)=cx$" without invoking continuity/measurability/etc.

> **Trap E4 — "$(\star)$ at the single weight $p=\tfrac12$, for all pairs, forces affine."** *Tempting because:* it looks like a lot of equations. *Kill:* that is *exactly* $(J_2)$, which the monster satisfies. You need the **continuum** of weights (or at least the irrational ones, Part 7.2), not one fixed weight across all pairs. Contrast with Theorem 2, which fixes the **pair** $(M,0)$ and varies the **weight** over all of $[0,1]$ — *that* works.

> **Trap E5 — "Midpoint-convex $\Rightarrow$ convex."** *Tempting because:* it is true for continuous functions. *Kill:* false in general (the additive monster is midpoint-affine, hence midpoint-convex, but not convex). The classical rescue (a measurability/boundedness hypothesis) is the same dictionary as in Part 4.

> **Trap E6 — "Any Hamel basis has an element in $(0,1)$, so just restrict."** *Tempting because:* a Hamel basis is uncountable, surely it meets $(0,1)$. *Kill:* cardinality says nothing about location — rescale every basis vector into $[1,2]$ and the basis misses $(0,1)$ entirely. You must *engineer* an element into $(0,1)$ by the rational-rescaling device (Part 3.4). This is the "interval-domain trap" the paper explicitly flags.

> **Trap E7 — "Piecewise saturation $\Rightarrow$ globally affine."** *Tempting because:* each piece is affine and the function is continuous. *Kill:* the tent $G(v)=\min(v,1-v)$ on $[0,1]$ satisfies $(\star)$ on $[0,\tfrac12]$ and on $[\tfrac12,1]$ separately, is continuous, yet is **not** affine on $[0,1]$ (the slopes are $+1$ and $-1$). Saturation is a *local* hypothesis here; global affineness needs a single cell (Corollary 5 / Part 7.3).

> **Trap E8 — "I verified $(\star)$ for rational weights, so Theorem 1 applies."** *Tempting because:* rationals are dense and "you can take limits." *Kill:* you cannot take limits without a regularity hypothesis — that is the whole point. Proposition 7 (Part 6.4) gives an explicit non-affine solution of the **rational** equation. Real (indeed irrational) weights are not optional.

> **Trap E9 — "The monster is bounded somewhere / measurable / has a few discontinuities."** *Tempting because:* most functions you meet are tame somewhere. *Kill:* the monster's graph is **dense in $[0,1]\times\mathbb{R}$** (Part 3.5), so it is unbounded on *every* subinterval, continuous *nowhere*, monotone on *no* subinterval, and non-measurable. It is uniformly pathological.

> **Trap E10 — "Jensen-equality for some distribution $\Rightarrow$ $G$ affine."** *Tempting because:* equality in Jensen feels special. *Kill:* a concave $G$ achieves equality on any chord lying in a flat stretch; one distribution, or even many, proves nothing. The hypothesis is equality for **every** two-point distribution on the interval (Part 1.2).

> **Trap E11 — "$G(0)=0$ without loss of generality, and I can divide by $M$ freely."** *Tempting because:* normalizations are usually harmless. *Kill:* the reduction $f=G-G(0)$ is fine, but watch the **domain**: the Cauchy reduction in Part 2.1 lives on a translate, and the endpoint substitution needs $M>0$ (the statement excludes the degenerate $M=0$). Always check $p=v/M\in[0,1]$ — it is what makes the substitution *legal*.

> **Trap E12 — "Zorn's lemma is avoidable; surely one can write down a monster."** *Tempting because:* mathematicians dislike non-constructive objects. *Kill:* Solovay's model (Part 3.2) shows it is **consistent** with ZF + dependent choice that *no* non-affine additive function exists. So the Axiom of Choice is genuinely necessary to build the monster — you provably *cannot* exhibit one explicitly.

> **Trap E13 — "In the $\mathbb{Q}$-homogeneity proof, $f(qx)=qf(x)$ is obvious."** *Tempting because:* it is "just linearity." *Kill:* the proof has four genuinely separate steps (zero, positive integers by induction, negatives, reciprocals/fractions). Skipping the reciprocal step ($f(x/n)=\tfrac1n f(x)$) is the usual gap. Reproduce all four (Part 2.2 / Exercise 6).

> **Trap E14 — "Continuity is obviously needed for $(\star)$; you can't pin a function with no assumptions."** *Tempting because:* every other rigidity theorem you know assumes regularity. *Kill:* this is the inverted intuition the paper corrects. $(\star)$ supplies its *own* regularity (Corollary 2 / Part 5.3): continuity is an **output**, not an input. Saying "we need continuity" reveals you have not absorbed the main point.

---

## Part X — Exercises

Twenty-four exercises, graded ★ (warm-up) to ★★★ (oral-exam level), grouped by theme and tagged with the Part they train. **Attempt before reading Part S.** A pencil-and-paper attempt at each is the difference between recognizing the paper and *owning* it.

### Group A — Definitions and first principles
- **X1 (★, Part 1.3).** Verify by direct substitution that every affine $G(v)=av+b$ satisfies $(\star)$ for all $u_1,u_2,p$.
- **X2 (★, Part 1.2).** Show that any $G$ satisfying $(\star)$ is *midpoint-affine*: $G\!\big(\tfrac{u_1+u_2}{2}\big)=\tfrac{G(u_1)+G(u_2)}{2}$.
- **X3 (★★, Part 1).** Prove that $G$ satisfies $(\star)$ **iff** for every pair $u_1,u_2$ the restriction of $G$ to the segment $[u_2,u_1]$ is the affine function matching $G$ at the two endpoints. (I.e. $(\star)$ = "affine on every chord.")
- **X4 (★★, Part 1.2).** Show a function that is *both convex and concave* on $I$ satisfies $(\star)$, and conversely. (No regularity — purely the inequalities.)

### Group B — Cauchy's equation and $\mathbb{Q}$-homogeneity
- **X5 (★, Part 2.2).** From additivity alone prove $f(0)=0$ and $f(-x)=-f(x)$.
- **X6 (★★, Part 2.2).** Prove $\mathbb{Q}$-homogeneity $f(qx)=qf(x)$ in full, all four steps. State precisely where each step is used.
- **X7 (★★, Part 2.1).** Carry out the reduction $(J_2)\Rightarrow$ Cauchy in detail, being explicit about the domain translate so that "$f(x+y)$" is defined.
- **X8 (★★★, Part 4.4).** Prove: an additive $f$ that is **continuous at a single point** $x_0$ is continuous everywhere, hence linear. (A classic strengthening of the continuity strut.)
- **X9 (★★, Part 2.3).** Show directly that additivity $+$ $\mathbb{Q}$-homogeneity imply $(J_\mathbb{Q})$, and conversely that $(J_\mathbb{Q})\Rightarrow$ additivity (on a translate). Conclude the three forms coincide.

### Group C — The Hamel monster
- **X10 (★, Part 3.4).** Prove two distinct rationals are $\mathbb{Q}$-linearly dependent. Deduce that any Hamel-basis element other than a rational multiple of $1$ is irrational.
- **X11 (★★, Part 3.4).** Prove that replacing a basis element $h'$ by $h=qh'$ ($q\in\mathbb{Q}\setminus\{0\}$) yields again a Hamel basis.
- **X12 (★★, Part 3.4).** With $\ell(1)=0,\ \ell(h)=1$, compute $\ell$ on $\mathbb{Q}$ and on $\{q_1+q_2h:q_i\in\mathbb{Q}\}$. Deduce $G=\ell|_{[0,1]}$ is non-affine.
- **X13 (★★★, Part 3.5).** Prove the graph of the monster $G$ is **dense** in $[0,1]\times\mathbb{R}$.
- **X14 (★★, Part 3.5).** Deduce from density that $G$ is unbounded on every subinterval, continuous nowhere, and monotone on no subinterval.

### Group D — The dictionary and the killer lemma
- **X15 (★★, Part 4.1).** Prove the killer lemma: additive $g$ with $g|_\mathbb{Q}=0$, bounded on some interval, is $\equiv0$. Identify the two facts from Part R it uses.
- **X16 (★★, Part 4.4).** Prove the continuity strut two ways: (a) via boundedness on $[0,M]$ + killer lemma; (b) directly, using density of $\mathbb{Q}$.
- **X17 (★★, Part 4.5).** Prove the monotonicity strut. Then give the *direct* squeeze argument (monotone $+$ vanishing on dense $\mathbb{Q}$).
- **X18 (★, Part 4.2).** Prove the interval-boundedness strut.
- **X19 (★★★, Parts 4.3, R.12).** Assuming Steinhaus's theorem, prove the positive-measure-boundedness strut. Then prove the **one-sided** refinement (bounded *above* on $E$, $|E|>0$, suffices).

### Group E — Main theorem, mechanism, variants
- **X20 (★, Part 5.2).** Reproduce the endpoint substitution from memory. State exactly which $(u_1,u_2,p)$ is used and verify admissibility.
- **X21 (★, Part 5.3).** Prove Corollary 2: an affine $G$ on $[0,M]$ is continuous, monotone, Lipschitz, and measurable. Explain why this makes the five struts "vestigial."
- **X22 (★★, Part 6).** Show $(\star_0)$ for an additive $f$ is exactly the assertion of $\mathbb{R}$-linearity. For the monster, exhibit a specific weight $p$ at which $(\star_0)$ fails.
- **X23 (★★, Part 7.1).** Prove Theorem 2 (single configuration). Then explain the subtlety: why it is "formally weaker" than Theorem 1 yet the conclusions coincide. Can you exhibit a $G$ satisfying the single-configuration hypothesis but *not* full $(\star)$? Justify.
- **X24 (★★★, Part 7).** (a) Verify the tent $G(v)=\min(v,1-v)$ satisfies $(\star)$ cell-wise on $[0,\tfrac12],[\tfrac12,1]$ but not globally. (b) Reproduce the *rational-$v/M$* case of the irrational-weights-alone Remark (Part 7.2), checking that $u_1/M,u_2/M$ are irrational.

---

## Part S — Full solutions

> Solutions are complete; if you only skimmed, the value is gone. Where a solution repeats a proof from the body, it is rewritten in exam-ready form (what you would actually put on the board).

**S1.** Substitute $G(u)=au+b$: LHS $=p(au_1+b)+(1-p)(au_2+b)=a\big(pu_1+(1-p)u_2\big)+b\,(p+(1-p))=a\big(pu_1+(1-p)u_2\big)+b=$ RHS. The only fact used is $p+(1-p)=1$. $\blacksquare$

**S2.** Put $p=\tfrac12$ in $(\star)$: $\tfrac12 G(u_1)+\tfrac12 G(u_2)=G\big(\tfrac12 u_1+\tfrac12 u_2\big)$, which is midpoint-affineness. $\blacksquare$

**S3.** ($\Rightarrow$) Fix $u_1,u_2$; for $v=pu_1+(1-p)u_2$ on the segment, $(\star)$ gives $G(v)=pG(u_1)+(1-p)G(u_2)$, the affine interpolant of the endpoint values in the parameter $p$. ($\Leftarrow$) If $G$ is the endpoint-affine function on every segment, then for any $u_1,u_2,p$ the value $G(pu_1+(1-p)u_2)$ equals $pG(u_1)+(1-p)G(u_2)$ by definition of that affine interpolant — i.e. $(\star)$. $\blacksquare$

**S4.** Convex: $pG(u_1)+(1-p)G(u_2)\ge G(pu_1+(1-p)u_2)$. Concave: $\le$. Both at once force equality for all $u_1,u_2,p$, i.e. $(\star)$. Conversely $(\star)$ (equality) trivially implies both inequalities, so $G$ is simultaneously convex and concave. (Note: this uses *no* regularity; affineness then follows from Theorem 1, not from this exercise.) $\blacksquare$

**S5.** $f(0)=f(0+0)=2f(0)\Rightarrow f(0)=0$. Then $0=f(0)=f(x+(-x))=f(x)+f(-x)\Rightarrow f(-x)=-f(x)$. $\blacksquare$

**S6.** (i) *Zero:* as in S5. (ii) *Positive integers:* induction; $f(1\cdot x)=f(x)$; $f((n{+}1)x)=f(nx)+f(x)=nf(x)+f(x)=(n{+}1)f(x)$ — uses additivity. (iii) *Negatives:* $f(-x)=-f(x)$ (S5), so $f(nx)=nf(x)$ for all $n\in\mathbb{Z}$. (iv) *Reciprocals/fractions:* $f(x)=f\big(n\cdot\tfrac xn\big)=nf\big(\tfrac xn\big)\Rightarrow f\big(\tfrac xn\big)=\tfrac1n f(x)$; then for $q=\tfrac mn$, $f(qx)=f\big(m\cdot\tfrac xn\big)=mf\big(\tfrac xn\big)=\tfrac mn f(x)$ — uses (ii)/(iii) and the reciprocal identity. $\blacksquare$

**S7.** Work on $I'=I-c$ for an interior point $c$ so $0\in I'$ and set $f(x)=G(x+c)-G(c)$; then $f(0)=0$ and $(J_2)$ transfers to $f$. For $x,y$ with $x,y,x+y$ small enough that all arguments stay in $I'$ (possible since $0$ is interior), midpoint-affineness with the point $0$ gives $f(x/2)=\tfrac12 f(x)$, and then $\tfrac12 f(x+y)=f\big(\tfrac{x+y}{2}\big)=\tfrac12(f(x)+f(y))$, i.e. $f(x+y)=f(x)+f(y)$ locally; additivity extends to all of $\mathbb{R}$ by the $\mathbb{Q}$-homogeneity/scaling bootstrap. The domain caveat — that $x+y$ must remain in $I'$ — is exactly why we centre at an interior point. $\blacksquare$

**S8.** Let $f$ be additive, continuous at $x_0$. For any $a$, write $x=a+(x_0+t)-x_0$... more cleanly: additivity gives $f(a+t)-f(a)=f(t)$ for all $a,t$. As $t\to0$, continuity at $x_0$ says $f(x_0+t)\to f(x_0)$, i.e. $f(t)=f(x_0+t)-f(x_0)\to0=f(0)$, so $f$ is continuous at $0$. Then $f(a+t)-f(a)=f(t)\to0$, so $f$ is continuous at every $a$. A continuous additive function satisfies $f(qx)=qf(x)$ for rational $q$, and by continuity in $q$ (approximating real $r$ by rationals) $f(rx)=rf(x)$; with $x=1$, $f(r)=rf(1)$, linear. $\blacksquare$

**S9.** ($\Rightarrow$) For rational $p$ and any $u_1,u_2$: $f(pu_1+(1-p)u_2)=f(pu_1)+f((1-p)u_2)=pf(u_1)+(1-p)f(u_2)$ by additivity then $\mathbb{Q}$-homogeneity; add back $G(0)$ to get $(J_\mathbb{Q})$ for $G$. ($\Leftarrow$) $(J_\mathbb{Q})$ at $p=\tfrac12$ is $(J_2)$, which gives additivity of $f=G-G(0)$ on a translate (S7). Hence all three forms share the solution class. $\blacksquare$

**S10.** If $q_1\ne q_2$ are rational, then $1\cdot q_1+(-1)\cdot q_2$... rather: $q_2\cdot(q_1)-q_1\cdot(q_2)=0$ is a nontrivial $\mathbb{Q}$-relation between the "vectors" $q_1,q_2$ (coefficients $q_2,-q_1$, not both zero), so they are dependent. A basis is independent, so it contains at most one rational multiple of $1$; any other element $h$, were it rational $=q$, would satisfy the dependency $1\cdot h-q\cdot 1=0$ with $1$ also in the basis — contradiction. Hence $h$ is irrational. $\blacksquare$

**S11.** Spanning: any $x=\sum q_i h_i$ using $h'$ can be rewritten with $h=qh'$ via $h'=q^{-1}h$, so $H$ still spans. Independence: a relation $\sum c_i h_i+c\,h=0$ becomes $\sum c_i h_i+(cq)h'=0$ in $H_0$; independence of $H_0$ forces all $c_i=0$ and $cq=0$, and $q\ne0\Rightarrow c=0$. So $H$ is independent. Hence $H$ is a basis. $\blacksquare$

**S12.** For rational $q$: $\ell(q)=\ell(q\cdot 1)=q\,\ell(1)=0$. For $q_1+q_2h$: $\ell(q_1+q_2h)=q_1\ell(1)+q_2\ell(h)=q_2$. So $G$ vanishes on $\mathbb{Q}\cap[0,1]$ but $G(h)=1\ne0$ with $h\in(0,1)$. An affine $A$ agreeing with $G$ on $\mathbb{Q}\cap[0,1]$ would have $A(0)=0,\ A(q)=0$ for dense $q$, so $A\equiv0\ne G$. Hence $G$ is non-affine. $\blacksquare$

**S13.** Fix an open box $(a,b)\times(c-\delta,c+\delta)\subseteq[0,1]\times\mathbb{R}$. Pick rational $q_2$ with $|q_2-c|<\delta$. As $q_1$ ranges over $\mathbb{Q}$, $x=q_1+q_2h$ ranges over a dense subset of $\mathbb{R}$ (a fixed shift of $\mathbb{Q}$), so some such $x\in(a,b)$; and $G(x)=q_2\in(c-\delta,c+\delta)$. Thus the graph meets every box: it is dense. $\blacksquare$

**S14.** *Unbounded on $(a,b)$:* by S13 with $c=N$ arbitrarily large, the graph meets $(a,b)\times(N-1,N+1)$, so $\sup_{(a,b)}G=+\infty$ (and similarly $-\infty$). *Nowhere continuous:* at any $x^\ast$, points $x_n\to x^\ast$ with $G(x_n)$ near any prescribed value exist (density), so $\lim_{x\to x^\ast}G$ does not exist. *Monotone on no subinterval:* a monotone function on $(a,b)$ is bounded there (R.5), contradicting unboundedness. $\blacksquare$

**S15.** Set $B=\sup_{(a,b)}|g|<\infty$. Additivity $+$ $g|_\mathbb{Q}=0$ give $g(x+q)=g(x)+g(q)=g(x)$ (rational-translation invariance). The translates $(a,b)+q$, $q\in\mathbb{Q}$, cover $\mathbb{R}$, and $g$ on each equals $g$ on $(a,b)$, so $|g|\le B$ on $\mathbb{R}$. Then $|g(t)|=\tfrac1{|n|}|g(nt)|\le \tfrac B{|n|}\to0$, so $g(t)=0$. Facts used: **R.2** ($\sup$ exists; $\tfrac B{|n|}\to0$ Archimedean) and **R.3** (rational translates of an interval cover $\mathbb{R}$, by density). $\blacksquare$

**S16.** (a) Continuous on the compact $[0,M]\Rightarrow$ bounded (EVT, R.5) $\Rightarrow g$ bounded there $\Rightarrow g\equiv0$ (S15). (b) Direct: $g$ continuous and $g=0$ on dense $\mathbb{Q}$ (R.3); for any $x$ pick $q_n\to x$, then $g(x)=\lim g(q_n)=0$. $\blacksquare$

**S17.** Monotone on $[0,M]\Rightarrow$ bounded by endpoint values (R.5) $\Rightarrow g\equiv0$ (S15). Direct squeeze: if $g$ is nondecreasing and $g(q)=0$ for dense $q$, then for any $x$ pick rationals $q_n\uparrow x\le q_n'\downarrow$... formally $q\le x\le q'$ with $q,q'$ rational gives $0=g(q)\le g(x)\le g(q')=0$, so $g(x)=0$. $\blacksquare$

**S18.** $G$ bounded on $I=[0,M]\Rightarrow f=G-G(0)$ bounded $\Rightarrow g=f-f(1)x$ bounded on the bounded interval (sum of bounded $f$ and the bounded linear term $f(1)x$ on $[0,M]$) $\Rightarrow g\equiv0$ (S15). $\blacksquare$

**S19.** Suppose $|g|\le C$ on measurable $E$, $|E|>0$. By Steinhaus $E-E\supseteq(-\delta,\delta)$. For $t=x-y$ with $x,y\in E$: $|g(t)|=|g(x)-g(y)|\le 2C$, so $g$ is bounded by $2C$ on $(-\delta,\delta)$, an interval; killer lemma $\Rightarrow g\equiv0$. *One-sided:* if $g\le C$ on $E$ (bounded above only), then for $t\in(-\delta,\delta)$, $g(t)=g(x)-g(y)\le C-\inf_E g$; but also $g(-t)=-g(t)$ gives a lower bound, so $g$ is bounded (two-sided) on $(-\delta,\delta)$. Killer lemma applies. $\blacksquare$

**S20.** Fix $v\in[0,M]$; take $u_1=M,\ u_2=0,\ p=v/M$. Admissible: $M,0\in[0,M]$ and $p\in[0,1]$ since $0\le v\le M$. Then $(\star)$ reads $\tfrac vM G(M)+(1-\tfrac vM)G(0)=G(v)$, i.e. $G(v)=G(0)+(G(M)-G(0))\tfrac vM$. $\blacksquare$

**S21.** $G(v)=av+b$. Differentiable with $G'\equiv a$, hence continuous and Lipschitz$(|a|)$; nondecreasing if $a\ge0$, else nonincreasing; Borel-, hence Lebesgue-, measurable. "Vestigial" means: each of the five struts is a *property the solution automatically has* (a conclusion), so assuming it adds nothing — unlike $(J_2)$, where the strut is needed to exclude the monster. $\blacksquare$

**S22.** With $u_1=M,u_2=0$ and $f$ additive ($f(0)=0$), $(\star_0)$: $pf(M)+(1-p)f(0)=f(pM)$ becomes $pf(M)=f(pM)$ — the statement $f(pM)=p\,f(M)$, i.e. $\mathbb{R}$-homogeneity at scalar $p$. For the monster with $\ell(1)=0,\ \ell(h)=1$: take $M=1$, $p=h$ (irrational, in $(0,1)$). Then $f(pM)=\ell(h)=1$ but $p\,f(M)=h\,\ell(1)=0$. So $(\star_0)$ fails at $p=h$. $\blacksquare$

**S23.** *Proof:* set $p=v/M$; hypothesis gives $pG(M)+(1-p)G(0)=G(pM)=G(v)$, the affine formula. *Subtlety:* the hypothesis only asserts the identity along the single segment $(M,0)$, which a priori is weaker than $(\star)$ for **all** pairs. But the conclusion is that $G$ equals the endpoint-affine $L$; and $L$ satisfies *full* $(\star)$ (S1). So *any* $G$ meeting the single-configuration hypothesis is forced to be $L$, hence also satisfies full $(\star)$. Therefore you **cannot** exhibit a $G$ satisfying the single configuration but not full $(\star)$: the two hypotheses are non-equivalent as *statements* but have the same *solution set*. $\blacksquare$

**S24.** (a) On $[0,\tfrac12]$, $G(v)=v$ is affine, so satisfies $(\star)$ (S1); on $[\tfrac12,1]$, $G(v)=1-v$ is affine, so satisfies $(\star)$. At the knot both give $G(\tfrac12)=\tfrac12$, so $G$ is continuous. But $G$ is not affine on $[0,1]$: slopes $+1\ne-1$. (Globally $(\star)$ fails, e.g. $u_1=0,u_2=1,p=\tfrac12$: LHS $=\tfrac12(0)+\tfrac12(0)=0$ but $G(\tfrac12)=\tfrac12$.) (b) For rational $v/M$, set $p=\tfrac{\sqrt2}{2}$, $\varepsilon/M=\tfrac{\sqrt3}{n}$, $u_1=v+(1-p)\varepsilon$, $u_2=v-p\varepsilon$. Then $u_1/M=\tfrac vM+\tfrac{2\sqrt3-\sqrt6}{2n}$ and $u_2/M=\tfrac vM-\tfrac{\sqrt6}{2n}$, each a rational plus a nonzero rational multiple of an irrational ($2\sqrt3-\sqrt6$ resp. $\sqrt6$), hence irrational (R.7). By the irrational case $G(u_i)=L(u_i)$; and $pu_1+(1-p)u_2=v$, so $(\star)$ at weight $p$ gives $G(v)=pL(u_1)+(1-p)L(u_2)=L(v)$ since $L$ is affine. $\blacksquare$

---

## Part D — Routines, recitations, and drills

The goal is an **oral examiner cannot rattle you**. These are designed to be redone until automatic. Time yourself; the targets assume a few cycles of practice.

### D.1 Speed drills (recite aloud, against a clock)
1. **The one-line proof (target 20 s).** "Fix $v$; set $u_1=M,u_2=0,p=v/M$; substitute; $G(v)=G(0)+(G(M)-G(0))v/M$." Redo until you can say it without looking.
2. **The five struts and their authors (target 25 s).** Continuity (Cauchy), measurability (Sierpiński), monotonicity (Darboux), boundedness on a positive-measure set (Kormes; one-sided Ostrowski/Kestelman), boundedness on the interval (Darboux). Then: "and *none* is needed for $(\star)$ — they are conclusions."
3. **$\mathbb{Q}$-homogeneity (target 40 s).** Four steps: zero; positive integers (induction); negatives; reciprocals/fractions. Speak each justification.
4. **The mechanism sentence (target 10 s).** "The Hamel pathology lives at irrational $p$; $(\star)$ forecloses on it there."
5. **The monster in six lines (target 90 s).** $\mathbb{R}$ over $\mathbb{Q}$; Zorn $\Rightarrow$ basis with $1$; swap in irrational $h\in(0,1)$ by rational rescale; set $\ell(1)=0,\ell(h)=1$; vanishes on dense $\mathbb{Q}$, $\ell(h)=1$; non-affine, dense graph.

### D.2 Blank-page reconstruction ladder (do in order, no notes)
- **Rung 1:** State $(\star)$, $(J_2)$, $(J_\mathbb{Q})$ and prove $(J_2)\Leftrightarrow$ Cauchy.
- **Rung 2:** Prove $\mathbb{Q}$-homogeneity and deduce the three forms coincide.
- **Rung 3:** Build the monster, including the interval-domain rescale, and prove its graph is dense.
- **Rung 4:** State and prove the killer lemma; derive all five struts from it (cite R.12 for the two measure ones).
- **Rung 5:** Prove Theorem 1 and Corollary 2; articulate "regularity is a conclusion."
- **Rung 6:** Prove the mechanism: $(\star_0)=\mathbb{R}$-linearity; monster passes $\mathbb{Q}$, fails at irrational $p$.
- **Rung 7:** State and prove Theorem 2, the irrational-weights Remark, and piecewise saturation.
Climb the whole ladder twice without notes and you can reconstruct the paper.

### D.3 Recitation script (mock oral exam — answer aloud, then check the Part)
- *"Why isn't continuity needed in Theorem 1?"* → Corollary 2 / Part 5.3 (it is an output).
- *"Where exactly does the monster fail $(\star)$ that it passes in $(J_\mathbb{Q})$?"* → at irrational weights; Part 6 / S22.
- *"Give a non-affine solution of the midpoint equation."* → the Hamel monster; Part 3.
- *"Does the rational equation force affineness?"* → no; Proposition 7 / Part 6.4.
- *"What breaks if a Hamel basis avoids $(0,1)$?"* → nothing breaks if you rescale; Part 3.4 / Trap E6.
- *"Is piecewise saturation enough for global affineness?"* → no; tent; Part 7.3 / S24.
- *"Why is the Axiom of Choice essential?"* → Solovay; Part 3.2 / Trap E12.
- *"State the killer lemma and the two facts it uses."* → S15.
- *"What is the role of irrational weights?"* → they alone suffice (Remark) and they are where the monster dies (mechanism).
- *"Decompose: which results need measure theory?"* → only the two struts in Parts 4.3, 4.6; everything else is Analysis I + Algebra I.

### D.4 Weekly maintenance routine (to keep the edge)
- **Day 1:** D.1 speed drills ×3 cycles; X1–X9.
- **Day 2:** D.2 rungs 1–3; X10–X14.
- **Day 3:** D.2 rungs 4–5; X15–X21.
- **Day 4:** D.2 rungs 6–7; X22–X24; all of Part E aloud.
- **Day 5:** full mock oral (D.3) with a partner or recorder; reattempt any exercise whose solution you needed to peek at.
Mastery check: you can deliver Rungs 1–7 cold, name every strut's author, and field all of Part E without hesitation.

