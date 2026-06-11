# A From-Scratch Reader: Section 4, *"Variants and Limits"*

> **Reader's guide** to **Section 4** of *The Continuous-Coefficient Jensen Equation: How Real Mixing Weights Retire Regularity* (satellites/o3-maa).
> **Scope.** All of Section 4: the strict-minimum hypothesis (**Theorem 3**, `thm:weak`), irrational weights alone (**Remark 4**, `rem:irrational`), piecewise saturation (**Corollary 5**, `cor:piecewise`), convex domains in higher dimensions (**Theorem 6**, `thm:higher`), and the rational-coefficient version retaining the pathology (**Proposition 7**, `prop:JQ-pathology`).
> **Audience.** A returning student whose toolkit is **Analysis I and Algebra I** — A grades, but a decade ago. **No measure theory is used anywhere** (no Lebesgue measure, no Steinhaus, no Lusin); the one set-theoretic tool, the existence of a basis of a vector space, is exactly the Algebra I basis theorem and is recalled in full. If your foundations (countability, density of $\mathbb{Q}$, fields, vector spaces, Zorn) feel rusty, skim **Part R of `notes/reader.md`** first.
> **Promise.** Pure mathematics, no analogies, every object defined and every step proved, so you can reproduce Section 4 on a blank page.
> **Companions.** `notes/reader.md` (Sections 1–3); `notes/reader-higher-dim.md` (the full proof of Theorem 6, summarized here).
> **Back matter.** After the exposition: **Part E** (extreme examples and traps), **Part X** (24 exercises spanning Theorems 3 and 6, Remark 4, Corollary 5, Proposition 7), **Part S** (full solutions), **Part D** (routines and drills for oral-exam mastery). Do the exercises before reading the solutions.
>
> *Numbering note.* The manuscript uses one shared counter for all numbered results, so they run $1,2,3,\dots$ across theorems, corollaries, remarks, and propositions: Theorem 1 (`thm:main`), Corollary 2 (`cor:regularity`), Theorem 3 (`thm:weak`), Remark 4 (`rem:irrational`), Corollary 5 (`cor:piecewise`), Theorem 6 (`thm:higher`), Proposition 7 (`prop:JQ-pathology`). We refer to results by both number and label.

Section 4 has two complementary jobs. The first three results (Theorem 3, Remark 4, Corollary 5) show **how little** of the equation the affineness conclusion actually needs — a single configuration, or only irrational weights, or only cell-by-cell. The last two (Theorem 6, Proposition 7) test the **boundaries** — the conclusion survives raising the dimension, but **fails** if you weaken the weights from real to rational. Together they pin down exactly which ingredient is essential: *the real weights, and nothing else.*

---

## Part 0 — Section 4 in one paragraph

The interval theorem (Theorem 1) says: a function on $[0,M]$ satisfying Jensen's equation at **all real weights** is affine, no regularity needed. Section 4 stress-tests this. (a) The proof used the equation at *one* endpoint configuration, so that alone suffices (Theorem 3). (b) Even the rational weights are dispensable: the equation at *irrational* weights only is still enough (Remark 4). (c) The equation need only hold *separately on each piece* of a subdivision; then $G$ is piecewise affine and automatically continuous across the joints (Corollary 5). (d) The whole thing lifts from an interval to any convex set in any real vector space, by pure linear algebra (Theorem 6). (e) Finally, the strengthening from rational to real weights is genuinely necessary: the **rational**-weight equation provably keeps a non-affine pathological solution, built with a basis of $\mathbb{R}$ over $\mathbb{Q}$ (Proposition 7). So real weights are exactly the dividing line.

Everything below expands this paragraph.

---

## Part 1 — The engine, recalled with proof

So that this reader stands alone, we restate the result Section 4 builds on. Let $M>0$, $I=[0,M]$, and call $G\colon I\to\mathbb{R}$ a **saturated** solution if it satisfies
$$
p\,G(u_1)+(1-p)\,G(u_2)=G\bigl(p\,u_1+(1-p)\,u_2\bigr)\qquad(u_1,u_2\in[0,M],\ p\in[0,1]).
\tag{$\star$}
$$
A function $G$ is **affine** if $G(v)=\alpha v+\beta$ for constants $\alpha,\beta$; on $[0,M]$ the affine function through the endpoint values is
$$
L(v):=G(0)+\frac{G(M)-G(0)}{M}\,v.
$$

> **Theorem 1 (`thm:main`).** Every saturated solution on $[0,M]$ equals $L$; in particular it is affine, with **no regularity hypothesis** (continuity, monotonicity, boundedness, measurability).

*Proof (the endpoint substitution).* Fix $v\in[0,M]$ and choose $u_1=M$, $u_2=0$, $p=v/M\in[0,1]$. Substituting into $(\star)$,
$$
\frac{v}{M}G(M)+\Bigl(1-\frac{v}{M}\Bigr)G(0)=G\Bigl(\frac{v}{M}\cdot M+\Bigl(1-\frac{v}{M}\Bigr)\cdot 0\Bigr)=G(v),
$$
so $G(v)=G(0)+\bigl(G(M)-G(0)\bigr)v/M=L(v)$. $\qquad\blacksquare$

The single weight $p=v/M$ pins $G(v)$ onto the chord through $(0,G(0))$ and $(M,G(M))$. Keep this proof in mind; Section 4 is a sequence of refinements of it.

---

## Part 2 — The strict-minimum hypothesis (Theorem 3, `thm:weak`)

The proof of Theorem 1 used $(\star)$ at **exactly one** configuration of points, $u_1=M$, $u_2=0$, letting only $p$ vary. The full force of $(\star)$ — every pair $(u_1,u_2)$ — was never consumed. We isolate the minimum.

> **Theorem 3 (`thm:weak`).** Let $M>0$ and let $G\colon[0,M]\to\mathbb{R}$ satisfy the single-configuration identity
> $$
> p\,G(M)+(1-p)\,G(0)=G(pM)\qquad\text{for all }p\in[0,1].
> $$
> Then $G(v)=L(v)$ on $[0,M]$.

*Proof.* Given $v\in[0,M]$, set $p:=v/M\in[0,1]$. The hypothesis at this $p$ reads
$$
\frac{v}{M}G(M)+\Bigl(1-\frac{v}{M}\Bigr)G(0)=G(pM)=G(v),
$$
and rearranging gives $G(v)=G(0)+\bigl(G(M)-G(0)\bigr)v/M=L(v)$. $\qquad\blacksquare$

**Discussion — how much of $(\star)$ is really used.** Theorem 3 is *formally weaker* than Theorem 1: assuming the identity at the one configuration $u_1=M$, $u_2=0$ does **not**, a priori, imply $(\star)$ for all pairs $(u_1,u_2)$. (Once the conclusion holds, both are true, since affine functions satisfy full $(\star)$ — but that is a *consequence*, not an assumption.) Theorem 3 is the right reference when you want to state precisely how little input a derivation needs: just the behavior along the single segment from $0$ to $M$. In practice a derivation that produces $(\star)$ from a richer setup usually produces it in full force, so Theorem 1 is the convenient statement and Theorem 3 the sharp one.

---

## Part 3 — Irrational weights alone suffice (Remark 4, `rem:irrational`)

Theorem 1 used the weight $p=v/M$, which may be rational. One might fear the conclusion secretly relies on rational weights. The opposite is true: **the rational weights are entirely dispensable.** This is fitting — the obstruction to affineness lives at irrational weights (Part 6), so it is exactly the irrational weights that exclude it.

We need two elementary irrationality facts (Algebra I level).

> **Irrationality Lemma.**
> (a) $\sqrt 3$ is irrational. (b) $2\sqrt3-\sqrt6$ is irrational.

*Proof.* (a) Standard: if $\sqrt3=m/n$ in lowest terms then $3n^2=m^2$, so $3\mid m$, write $m=3k$, then $3n^2=9k^2$, $n^2=3k^2$, so $3\mid n$ — contradicting lowest terms. (b) Suppose $2\sqrt3-\sqrt6=q\in\mathbb{Q}$. Then $\sqrt6=2\sqrt3-q$; squaring, $6=12-4q\sqrt3+q^2$, so $4q\sqrt3=6+q^2$. If $q\ne0$ this gives $\sqrt3=(6+q^2)/(4q)\in\mathbb{Q}$, contradicting (a); if $q=0$ then $2\sqrt3=\sqrt6$, i.e. $12=6$, false. $\qquad\square$

> **Remark 4 (`rem:irrational`).** Suppose $G\colon[0,M]\to\mathbb{R}$ satisfies $(\star)$ **only for every irrational $p\in(0,1)$** (and arbitrary $u_1,u_2$). Then $G=L$, hence $G$ is affine.

*Proof.* The endpoints give $G(0)=L(0)$, $G(M)=L(M)$ trivially. Fix $v\in(0,M)$; two cases.

**Case 1: $v/M$ irrational.** Then $p:=v/M$ is an admissible (irrational) weight in $(0,1)$. The endpoint substitution $u_1=M$, $u_2=0$ at this $p$ gives, exactly as in Part 1, $G(v)=L(v)$.

**Case 2: $v/M$ rational.** Now $p=v/M$ is *not* admissible, so we manufacture $v$ as an irrational mixture of two points whose coordinates are irrational (so Case 1 already determined $G$ there). Fix the irrational weight
$$
p:=\frac{\sqrt2}{2}\in(0,1).
$$
Choose $\varepsilon>0$ of the form $\varepsilon/M=\sqrt3/n$ for an integer $n$ taken large enough that
$$
u_1:=v+(1-p)\varepsilon,\qquad u_2:=v-p\,\varepsilon
$$
both lie in $[0,M]$ (possible since $0<v<M$ leaves room, and $\varepsilon\to0$ as $n\to\infty$). Then:

- **$u_1/M$ is irrational.** Indeed
$$
\frac{u_1}{M}=\frac{v}{M}+(1-p)\frac{\varepsilon}{M}=\underbrace{\frac{v}{M}}_{\in\mathbb{Q}}+\Bigl(1-\tfrac{\sqrt2}{2}\Bigr)\frac{\sqrt3}{n}=\frac{v}{M}+\frac{2\sqrt3-\sqrt6}{2n},
$$
a rational plus a nonzero rational multiple of the irrational $2\sqrt3-\sqrt6$ (Irrationality Lemma (b)); hence irrational.
- **$u_2/M$ is irrational.** Similarly $\dfrac{u_2}{M}=\dfrac{v}{M}-\dfrac{\sqrt2}{2}\cdot\dfrac{\sqrt3}{n}=\dfrac{v}{M}-\dfrac{\sqrt6}{2n}$, a rational plus an irrational, hence irrational.

By **Case 1**, $G(u_1)=L(u_1)$ and $G(u_2)=L(u_2)$. A direct computation shows the mixture recovers $v$:
$$
p\,u_1+(1-p)\,u_2=p\bigl(v+(1-p)\varepsilon\bigr)+(1-p)\bigl(v-p\varepsilon\bigr)=v+\bigl(p(1-p)-(1-p)p\bigr)\varepsilon=v.
$$
Apply the hypothesis $(\star)$ at the admissible irrational weight $p=\tfrac{\sqrt2}{2}$ to the pair $(u_1,u_2)$:
$$
G(v)=G\bigl(p u_1+(1-p)u_2\bigr)=p\,G(u_1)+(1-p)\,G(u_2)=p\,L(u_1)+(1-p)\,L(u_2)=L\bigl(pu_1+(1-p)u_2\bigr)=L(v),
$$
the penultimate equality because $L$ is affine (so it commutes with the convex combination). Hence $G(v)=L(v)$ in Case 2 as well. $\qquad\blacksquare$

**Why this is the right sharpening.** Part 6 will show that the only non-affine solutions of the *rational*-weight equation are functions failing real homogeneity at irrational scalars. Remark 4 says: testing the equation **only** at irrational weights already destroys those solutions. The irrational weights are not just sufficient — they are the active ingredient.

---

## Part 4 — Piecewise saturation (Corollary 5, `cor:piecewise`)

The equation need not hold across the whole interval at once; **cell by cell** is enough, and then continuity at the joints is automatic.

> **Corollary 5 (`cor:piecewise`).** Let $0=m_0<m_1<\dots<m_k=M$ be a subdivision, and suppose $G\colon[0,M]\to\mathbb{R}$ satisfies $(\star)$ **separately on each cell** $[m_{i-1},m_i]$ — that is, for all $u_1,u_2$ lying in one common cell and all $p\in[0,1]$. Then $G$ is affine on each cell, hence **piecewise affine** on $[0,M]$, and **automatically continuous** on $[0,M]$ with no regularity hypothesis. Global affineness need **not** hold: the slopes on different cells may differ.

*Proof.* Fix a cell $[m_{i-1},m_i]$ of length $h_i:=m_i-m_{i-1}>0$. The affine change of variable
$$
\phi_i\colon[0,1]\to[m_{i-1},m_i],\qquad \phi_i(s)=m_{i-1}+h_i\,s
$$
is a bijection that maps convex combinations to convex combinations: $\phi_i(p s_1+(1-p)s_2)=p\,\phi_i(s_1)+(1-p)\phi_i(s_2)$ (because $\phi_i$ is affine). Hence $\tilde G:=G\circ\phi_i\colon[0,1]\to\mathbb{R}$ satisfies $(\star)$ on $[0,1]$:
$$
\tilde G(ps_1+(1-p)s_2)=G\bigl(\phi_i(ps_1+(1-p)s_2)\bigr)=G\bigl(p\phi_i(s_1)+(1-p)\phi_i(s_2)\bigr)=p\tilde G(s_1)+(1-p)\tilde G(s_2),
$$
the last step using $(\star)$ for $G$ on the cell (the two points $\phi_i(s_1),\phi_i(s_2)$ lie in the common cell). By **Theorem 1**, $\tilde G$ is affine on $[0,1]$, so $G=\tilde G\circ\phi_i^{-1}$ is affine on $[m_{i-1},m_i]$. This holds for every cell, so $G$ is piecewise affine.

**Continuity at a knot $m_i$ (interior).** $m_i$ is the right endpoint of cell $i$ and the left endpoint of cell $i+1$. The affine formula on cell $i$ evaluated at $m_i$ gives the value $G(m_i)$ (it is defined there); the affine formula on cell $i+1$ evaluated at $m_i$ also gives $G(m_i)$. Since both one-sided affine pieces take the common value $G(m_i)$ at $m_i$, the two pieces agree there, so $G$ has matching one-sided limits equal to $G(m_i)$: $G$ is continuous at $m_i$. Affine pieces are continuous on the interiors of their cells, so $G$ is continuous on all of $[0,M]$.

**No global affineness.** Nothing forces equal slopes across a knot; e.g. on $[0,1]$ with knot $\tfrac12$, the "tent" $G(v)=v$ on $[0,\tfrac12]$ and $G(v)=1-v$ on $[\tfrac12,1]$ satisfies $(\star)$ on each cell, is continuous, but is not affine on $[0,1]$. $\qquad\blacksquare$

**Where this is used.** This is the exact form in which the interval theorem enters the calibration application of Section 5: a surrogate score on $[0,1]$ that aggregates **exactly** on each of $[0,\tfrac12]$ and $[\tfrac12,1]$ is necessarily piecewise affine — the "tent" shape — with **nothing assumed at the kink or anywhere else.** Continuity is delivered for free by the knot-matching argument.

---

## Part 5 — Convex domains in higher dimensions (Theorem 6, `thm:higher`)

The interval theorem lifts to any convex set in any real vector space, by linear algebra alone. The full proof is the subject of the companion reader `notes/reader-higher-dim.md`; here is the statement and the skeleton, at the level Section 4 needs.

> **Theorem 6 (`thm:higher`).** Let $V$ be a real vector space, $C\subseteq V$ convex, and $G\colon C\to\mathbb{R}$ satisfy
> $$
> p\,G(x_1)+(1-p)\,G(x_2)=G\bigl(px_1+(1-p)x_2\bigr)\qquad(x_1,x_2\in C,\ p\in[0,1]).
> $$
> Then $G(x)=a(x-x_0)+b$ for a linear functional $a$ on the parallel subspace $W=\operatorname{span}(C-C)$, a constant $b$, and any fixed $x_0\in C$. That is, $G$ is affine on $C$, with no regularity hypothesis.

*Proof skeleton.* Fix $x_0\in C$; put $D=C-x_0$ (convex, $0\in D$, and $sD\subseteq D$ for $s\in[0,1]$) and $A(v)=G(x_0+v)-G(x_0)$. Translating the hypothesis gives the relation
$$
A(pv+(1-p)w)=pA(v)+(1-p)A(w)\qquad(v,w\in D,\ p\in[0,1]).
\tag{R}
$$
Four steps:
1. **(i) Real homogeneity** $A(pv)=pA(v)$ for all real $p\in[0,1]$ (set $w=0$ in (R)) — this is Theorem 1 applied along the segment $[x_0,x_0+v]$, and is the **only** place the continuum of weights is used.
2. **(ii) Additivity** $A(v+w)=A(v)+A(w)$ whenever $v,w,v+w\in D$ (set $p=\tfrac12$ in (R), then apply (i)).
3. **(iii) Cone extension:** on $D^{*}=\bigcup_{\lambda>0}\lambda D$ (a convex cone), $\hat A(\lambda v):=\lambda A(v)$ is well defined, additive, and positively homogeneous.
4. **(iv) Subspace extension:** on $W=D^{*}-D^{*}=\operatorname{span}(C-C)$, $a(v-w):=\hat A(v)-\hat A(w)$ is a well-defined linear functional, and $G(x)=a(x-x_0)+G(x_0)$.

No topology or measure theory appears; only Step (i) is "analytic," and it is the one-dimensional substitution. See `notes/reader-higher-dim.md` for every well-definedness check. $\qquad\blacksquare$

**Reading.** The dimension-raising contributes only bookkeeping (a cone and a difference space). The classical Jensen-on-convex-domains theorems carry regularity hypotheses precisely because they use the *rational*-weight equation; the real-weight version makes Step (i) free, so the hypotheses are vestigial here too.

---

## Part 6 — The rational version retains the pathology (Proposition 7, `prop:JQ-pathology`)

So far every result has *removed* hypotheses. This one explains why we cannot remove the most important one — **real** weights — by exhibiting a non-affine solution of the **rational**-weight equation. This is where the strengthening from $\mathbb{Q}$ to $\mathbb{R}$ in $(\star)$ does irreplaceable work. We build everything from Algebra I (the basis theorem) and Analysis I (density of $\mathbb{Q}$); **no measure theory is used.**

### 6.1 The rational-weight equation
Define the **rational-coefficient Jensen equation** on $[0,1]$:
$$
p\,G(u_1)+(1-p)\,G(u_2)=G\bigl(pu_1+(1-p)u_2\bigr)\qquad(u_1,u_2\in[0,1],\ p\in[0,1]\cap\mathbb{Q}).
\tag{$J_\mathbb{Q}$}
$$
This is $(\star)$ with the weight $p$ restricted to **rationals**. We will produce a $G$ satisfying $(J_\mathbb{Q})$ that is **not** affine. By Theorem 1, no such $G$ exists for real weights; so the proposition shows the $\mathbb{Q}\to\mathbb{R}$ strengthening is genuine.

### 6.2 $\mathbb{R}$ as a vector space over $\mathbb{Q}$, and a basis (Algebra I)
Since $\mathbb{Q}\subseteq\mathbb{R}$ is a subfield, $\mathbb{R}$ is a **vector space over the field $\mathbb{Q}$**: the "vectors" are real numbers, the "scalars" are rationals, and the vector-space axioms hold because they hold in the field $\mathbb{R}$. This space is huge — it cannot be spanned by countably many vectors, since finite $\mathbb{Q}$-combinations of a countable set form a countable set, while $\mathbb{R}$ is uncountable (Analysis I: $\mathbb{Q}$ is countable, $\mathbb{R}$ is not).

A **Hamel basis** is, by definition, a basis $H\subseteq\mathbb{R}$ of this $\mathbb{Q}$-vector space: a $\mathbb{Q}$-linearly independent set such that every real number is a **unique finite** $\mathbb{Q}$-combination of elements of $H$. We invoke the Algebra I theorem:

> **Basis Theorem (Algebra I).** Every vector space has a basis.

For infinite-dimensional spaces this is proved with **Zorn's lemma** (equivalently the axiom of choice): the family of $\mathbb{Q}$-linearly independent subsets of $\mathbb{R}$, ordered by inclusion, has the property that every chain has an upper bound (its union), so Zorn yields a maximal independent set; maximality forces it to span. Thus a Hamel basis $H$ of $\mathbb{R}$ over $\mathbb{Q}$ **exists**. (It cannot be written down explicitly; its existence is genuinely non-constructive. This is the deep reason the classical theory needed a regularity hypothesis to *exclude* the objects we are about to build.)

### 6.3 Free assignment on a basis gives $\mathbb{Q}$-linear maps
Once $H$ is a basis, a $\mathbb{Q}$-linear map $\ell\colon\mathbb{R}\to\mathbb{R}$ may be defined by **assigning its values on $H$ completely freely** and extending: if $x=q_1h_1+\dots+q_kh_k$ (the unique representation, $q_i\in\mathbb{Q}$, $h_i\in H$), set
$$
\ell(x):=q_1\,\ell(h_1)+\dots+q_k\,\ell(h_k).
$$
Uniqueness of the representation makes $\ell$ well defined, and adding representations termwise shows
$$
\ell(x+y)=\ell(x)+\ell(y),\qquad \ell(qx)=q\,\ell(x)\quad(q\in\mathbb{Q}).
\tag{$\mathbb{Q}$-lin}
$$
This is ordinary linear algebra over the field $\mathbb{Q}$: a linear map is determined by, and free on, its values on a basis.

### 6.4 The interval-domain trap, and the rational-rescaling fix
We want the pathology to *show* on $[0,1]$, so we want a basis element lying in the open interval $(0,1)$. **Cardinality alone does not give this:** one could rescale every basis element into $[1,2]$ and obtain a perfectly good basis that avoids $(0,1)$ entirely. So we engineer one element into $(0,1)$.

Start from any Hamel basis $H_0$ that contains $1$ (if a given basis does not contain $1$, replace one of its elements appropriately; concretely, expand $1$ in the basis and swap in $1$ for a basis element appearing with nonzero coefficient — a standard basis-exchange, Algebra I). Pick any $h'\in H_0\setminus\{1\}$. Then $h'$ is **irrational**: two distinct elements of a basis are $\mathbb{Q}$-linearly independent, and any rational would be $\mathbb{Q}$-dependent with $1$. Choose a nonzero rational $q$ with
$$
h:=q\,h'\in(0,1)
$$
(possible since $h'\ne0$: take $q$ of the same sign as $h'$ with $|q|$ small enough that $q\,h'$ lands in $(0,1)$). Replace $h'$ by $h$:
$$
H:=(H_0\setminus\{h'\})\cup\{h\}.
$$

> **$H$ is again a Hamel basis.** Replacing a basis vector $h'$ by a **nonzero scalar multiple** $h=qh'$ preserves both independence and spanning: any $\mathbb{Q}$-combination using $h'$ can be rewritten using $h=qh'$ (divide that coefficient by $q$), and conversely. So $H$ spans and is independent. $\qquad\square$

Now $H$ is a basis containing both $1$ and the irrational $h\in(0,1)$.

### 6.5 The pathological witness
Define a $\mathbb{Q}$-linear map $\ell\colon\mathbb{R}\to\mathbb{R}$ by free assignment on $H$:
$$
\ell(1):=0,\qquad \ell(h):=1,\qquad \ell:=\text{anything }\mathbb{Q}\text{-linear on the remaining basis elements.}
$$
Let
$$
G:=\ell\big|_{[0,1]}.
$$

> **$G$ satisfies $(J_\mathbb{Q})$.** For $u_1,u_2\in[0,1]$ and rational $p\in[0,1]$, the point $pu_1+(1-p)u_2$ lies in $[0,1]$, and by ($\mathbb{Q}$-lin) (with $p,1-p\in\mathbb{Q}$),
> $$
> \ell\bigl(pu_1+(1-p)u_2\bigr)=p\,\ell(u_1)+(1-p)\,\ell(u_2),
> $$
> i.e. $G(pu_1+(1-p)u_2)=pG(u_1)+(1-p)G(u_2)$. $\qquad\square$

> **$G$ is not affine.** For every rational $q\in[0,1]$, ($\mathbb{Q}$-lin) gives $G(q)=\ell(q\cdot 1)=q\,\ell(1)=0$. But $G(h)=\ell(h)=1\ne0$, with $h\in(0,1)$. If some affine $A(v)=\alpha v+\beta$ agreed with $G$ on $\mathbb{Q}\cap[0,1]$, then $A(0)=0\Rightarrow\beta=0$ and $A(q)=\alpha q=0$ for all rational $q\Rightarrow\alpha=0$, so $A\equiv0$; this contradicts the fact that $G$ would have to equal $A$ on the dense set yet $G(h)=1$. Hence no affine function equals $G$. $\qquad\square$

### 6.6 The witness violates every Analysis I regularity property
We show $G$ is not just non-affine but maximally irregular, using only Analysis I. The key computation: on the set $\{q_1+q_2 h:q_1,q_2\in\mathbb{Q}\}$, ($\mathbb{Q}$-lin) gives
$$
\ell(q_1+q_2 h)=q_1\,\ell(1)+q_2\,\ell(h)=q_2.
\tag{$\dagger$}
$$

> **The graph of $G$ is dense in $[0,1]\times\mathbb{R}$.** Fix any subinterval $(a,b)\subseteq[0,1]$ and any target value $c\in\mathbb{R}$ and tolerance $\delta>0$. Pick a rational $q_2$ with $|q_2-c|<\delta$. As $q_1$ ranges over $\mathbb{Q}$, the number $q_1+q_2 h$ ranges over a dense subset of $\mathbb{R}$ (a fixed real shift of the dense set $\mathbb{Q}$), so some choice lands $x:=q_1+q_2h\in(a,b)$. By $(\dagger)$, $G(x)=q_2$, so $|G(x)-c|<\delta$ with $x\in(a,b)$. Thus the graph meets every open box $(a,b)\times(c-\delta,c+\delta)$ — it is dense. $\qquad\square$

A function with dense graph fails every Analysis I regularity property at once:

- **Not continuous anywhere.** At any $x^\ast$, rationals $q_n\to x^\ast$ have $G(q_n)=0$, while other points $y_n\to x^\ast$ can be chosen (by density of the graph) with $G(y_n)\to$ any value $\ne G(x^\ast)$; so $G$ has no limit at $x^\ast$. (Concretely at $x^\ast=h$: $G(q_n)=0\not\to1=G(h)$.)
- **Not monotone on any subinterval.** On any $(a,b)$ the dense graph forces $G$ to take values both above and below any level, in every order, so it cannot be non-decreasing or non-increasing there.
- **Not bounded on any subinterval.** By $(\dagger)$ with $q_2$ arbitrarily large, $G$ takes arbitrarily large values in every $(a,b)$.

(The function also fails to be Lebesgue measurable, which is the remaining row of the paper's regularity table; that notion is beyond Analysis I, so we only record it — it is **not** needed for the proposition, since non-affineness is already established above by density alone.)

### 6.7 The proposition, and what it sharpens
> **Proposition 7 (`prop:JQ-pathology`; folklore, cf. Kuczma §§5.2, 13.2).** There exists $G\colon[0,1]\to\mathbb{R}$ satisfying $(J_\mathbb{Q})$ (hence the midpoint equation, the case $p=\tfrac12$) that is **not** affine.

The construction of §6.4–§6.5 is the proof. The consequence sharpens the whole paper's dictionary:

- It is **not** merely that we failed to *prove* affineness for $(J_\mathbb{Q})$ without a regularity hypothesis — affineness is genuinely **false** there (the witness $G$ is a counterexample).
- Therefore the regularity hypotheses (continuity, monotonicity, boundedness) are **load-bearing** for the rational-weight equation: drop them and a non-affine solution appears.
- Only the strengthening to **real** weights, $(\star)$, retires the regularity requirement (Theorem 1), because — as the structural mechanism shows — the witness is $\mathbb{Q}$-linear but **not** $\mathbb{R}$-linear, so it satisfies the identity at every rational weight yet **fails** it at the irrational weights, exactly where $(\star)$ tests and $(J_\mathbb{Q})$ does not.

This closes the loop with Remark 4 (Part 3): the irrational weights are precisely the ones that kill this witness, which is why testing $(\star)$ at irrational weights alone already suffices for affineness.

---

## Part 7 — How the five results fit together

Section 4 brackets Theorem 1 from both sides.

| Result | Direction | Content |
|---|---|---|
| **Theorem 3** (`thm:weak`) | *minimize input* | the identity at one endpoint configuration suffices |
| **Remark 4** (`rem:irrational`) | *minimize input* | irrational weights alone suffice (rationals dispensable) |
| **Corollary 5** (`cor:piecewise`) | *localize input* | cell-by-cell saturation $\Rightarrow$ piecewise affine + automatic continuity |
| **Theorem 6** (`thm:higher`) | *raise dimension* | same conclusion on any convex set in any real vector space (pure linear algebra) |
| **Proposition 7** (`prop:JQ-pathology`) | *find the boundary* | **rational** weights are **not** enough: a non-affine pathology survives |

The narrative: Theorem 1 already needs very little (Theorem 3), and even less than "rational weights" — it needs *irrational* weights (Remark 4), can be applied locally (Corollary 5), and survives to arbitrary convex domains (Theorem 6). But it does **not** survive weakening the weights from real to rational (Proposition 7). So among all the ingredients, the **real (indeed irrational) weights** are the one essential thing. That is the precise sense in which "real mixing weights retire regularity."

---

## Part 8 — From-scratch reconstruction checklist

1. **Recall the engine.** Theorem 1 via the endpoint substitution $u_1=M,u_2=0,p=v/M$. *(Part 1)*
2. **Theorem 3.** Keep only the one configuration; set $p=v/M$. *(Part 2)*
3. **Remark 4.** Irrationality Lemma ($\sqrt3$, $2\sqrt3-\sqrt6$ irrational); Case 1 ($v/M$ irrational, direct); Case 2 ($v/M$ rational, build $u_1,u_2$ with irrational ratios via $p=\tfrac{\sqrt2}{2}$, $\varepsilon/M=\sqrt3/n$; check $pu_1+(1-p)u_2=v$). *(Part 3)*
4. **Corollary 5.** Affine reparametrization $\phi_i$ of each cell to $[0,1]$; apply Theorem 1; knot-matching gives continuity; tent example shows global affineness fails. *(Part 4)*
5. **Theorem 6.** Shift to $A$ on $D=C-x_0$; relation (R); (i) homogeneity, (ii) additivity, (iii) cone $D^{*}$, (iv) difference space $W$; full details in `notes/reader-higher-dim.md`. *(Part 5)*
6. **Proposition 7.** $\mathbb{R}$ as a $\mathbb{Q}$-vector space; Basis Theorem (Zorn) $\Rightarrow$ Hamel basis; rational-rescaling fix to put $h\in(0,1)$; define $\ell(1)=0,\ \ell(h)=1$; $G=\ell|_{[0,1]}$ solves $(J_\mathbb{Q})$, vanishes on dense $\mathbb{Q}$, $G(h)=1$ $\Rightarrow$ non-affine; identity $(\dagger)$ $\Rightarrow$ dense graph $\Rightarrow$ nowhere continuous / non-monotone / unbounded. *(Part 6)*

The logical spine: **Parts 2–4 squeeze the hypothesis of Theorem 1 to its minimum; Part 5 raises its dimension for free; Part 6 proves the boundary is real-vs-rational, by an explicit pathology that lives at the irrational weights.**

---

## Part 9 — 60-second recap

1. **Theorem 3** (`thm:weak`): the affineness conclusion needs $(\star)$ at only **one** endpoint configuration, $u_1=M,u_2=0$.
2. **Remark 4** (`rem:irrational`): it needs only **irrational** weights — rationals are dispensable; if $v/M$ is rational, route through two auxiliary points with irrational ratios using $p=\tfrac{\sqrt2}{2}$.
3. **Corollary 5** (`cor:piecewise`): $(\star)$ **cell by cell** $\Rightarrow$ piecewise affine, and the pieces automatically agree at the knots, so $G$ is continuous (the "tent" is the typical non-globally-affine solution).
4. **Theorem 6** (`thm:higher`): the same holds on **any convex set** in **any real vector space**, by pure linear algebra — only the one-dimensional substitution is "analytic," the rest is a cone-and-difference-space construction.
5. **Proposition 7** (`prop:JQ-pathology`): the strengthening from rational to real weights is **necessary** — using a basis of $\mathbb{R}$ over $\mathbb{Q}$ (Algebra I + Zorn), one builds $G$ solving the **rational**-weight equation that is non-affine, with graph dense in $[0,1]\times\mathbb{R}$ (so nowhere continuous, non-monotone, unbounded — all shown via density, no measure theory).
6. **Synthesis:** real (in fact irrational) mixing weights are exactly the essential ingredient; everything else can be minimized, localized, or generalized, but the weights cannot be weakened to $\mathbb{Q}$.

---

**Companions:** `notes/reader.md` (Sections 1–3, the one-dimensional theory and the regularity dictionary); `notes/reader-higher-dim.md` (the complete proof of Theorem 6).

---

## Part E — Extreme examples & common traps

Each trap states a plausible false belief, why it tempts, and the kill. These are the errors that sink an oral exam on Section 4.

> **Trap E1 — "Theorem 3 is equivalent to Theorem 1."** *Tempting:* both conclude $G=L$. *Kill:* Theorem 3 is *formally weaker* — assuming the identity at the single configuration $(u_1,u_2)=(M,0)$ does **not** a priori give $(\star)$ for all pairs. The full equation becomes true only *after* you conclude affineness; that is a consequence, not a hypothesis (Exercise X2, X3).

> **Trap E2 — "Remark 4 (irrational weights) is a *stronger* hypothesis than Theorem 1."** *Tempting:* "irrational" sounds like more. *Kill:* it is **weaker** — you assume $(\star)$ at *fewer* weights (only irrational $p$). The surprise is that this still forces affineness, because the obstruction lives precisely at irrational weights (Exercise X9; Part 6).

> **Trap E3 — "If $v/M$ is rational, Remark 4 is stuck, since $p=v/M$ is not an allowed weight."** *Tempting:* the direct substitution fails. *Kill:* route $v$ through two auxiliary points $u_1,u_2$ with **irrational** ratios $u_i/M$, mixed by the irrational weight $p=\tfrac{\sqrt2}{2}$; Case 1 pins $G$ at $u_1,u_2$ and the irrational-weight equation transports it to $v$ (Exercise X7, X8).

> **Trap E4 — "Corollary 5 yields global affineness."** *Tempting:* each cell is affine. *Kill:* the slopes can differ across knots. The **tent** $G(v)=v$ on $[0,\tfrac12]$, $G(v)=1-v$ on $[\tfrac12,1]$ is piecewise affine, continuous, **not** affine (Exercise X12).

> **Trap E5 — "Piecewise saturation gives smoothness (or at least differentiability) at the knots."** *Tempting:* continuity is automatic, so why not more? *Kill:* the tent has a corner at $\tfrac12$. Continuity is the **ceiling**, delivered by value-matching; derivatives need not match (Exercise X14).

> **Trap E6 — "Continuity in Corollary 5 is an extra hypothesis."** *Tempting:* continuity usually must be assumed. *Kill:* here it is an **output**: the two one-sided affine pieces share the value $G(m_i)$ at each interior knot, so they agree there — no regularity is assumed anywhere (Exercise X11).

> **Trap E7 — "Proposition 7's pathological $G$ also satisfies the real-weight equation $(\star)$."** *Tempting:* it satisfies $(J_\mathbb{Q})$ and looks like a Jensen solution. *Kill:* it is $\mathbb{Q}$-linear but **not** $\mathbb{R}$-linear, so it **fails** $(\star)$ at irrational weights — explicitly at $p=h$, $u_1=1$, $u_2=0$ (Exercise X23). This is the whole point: it separates $\mathbb{Q}$ from $\mathbb{R}$.

> **Trap E8 — "A Hamel basis can be written down explicitly."** *Tempting:* bases of $\mathbb{R}^n$ are explicit. *Kill:* a Hamel basis of $\mathbb{R}$ over $\mathbb{Q}$ requires Zorn / the axiom of choice and is genuinely non-constructive; no formula exists. This is *why* the classical theory needed a regularity hypothesis to exclude the witness (Part 6.2).

> **Trap E9 — "Cardinality alone puts a basis element in $(0,1)$."** *Tempting:* a Hamel basis is uncountable, surely some element lands in $(0,1)$. *Kill:* one can rescale every basis element into $[1,2]$ and still have a basis — so $(0,1)$ can be avoided. You must **engineer** $h\in(0,1)$ by a rational rescaling (Exercise X20; Part 6.4).

> **Trap E10 — "The witness is non-affine *because* it is non-measurable."** *Tempting:* non-measurability is the famous pathology. *Kill:* non-affineness is established by the **dense-graph** argument alone (Analysis I) — $G$ vanishes on $\mathbb{Q}$ yet $G(h)=1$. Measurability is never invoked and lies beyond Analysis I (Exercise X22; Part 6.6).

> **Trap E11 — "The midpoint equation ($p=\tfrac12$ only) is strictly weaker than $(J_\mathbb{Q})$."** *Tempting:* one weight versus all rationals. *Kill:* for real-valued functions the midpoint identity, iterated, generates the identity at **every** dyadic and then every rational weight — so it is *equivalent* to $(J_\mathbb{Q})$. The proposition's witness therefore also solves the midpoint equation (Exercise X24 remark).

---

## Part X — Exercises

Twenty-four exercises, ★ (warm-up) to ★★★ (oral-exam level), tagged by Part. **No measure theory.** Attempt before Part S.

### Group A — The engine and Theorem 3 (strict minimum)
- **X1 (★, Part 1).** Reprove Theorem 1 from scratch by the endpoint substitution $u_1=M,\ u_2=0,\ p=v/M$.
- **X2 (★★, Part 2).** Prove Theorem 3, and explain precisely why it is *formally weaker* than Theorem 1.
- **X3 (★★, Part 2).** Show the converse direction: an affine $G$ satisfies the full $(\star)$. Deduce that "single-configuration identity + affine" recovers full $(\star)$ as a *consequence*.
- **X4 (★★, Part 2).** Show the symmetric single configuration $u_1=0,\ u_2=M$ (weight $1-v/M$) also suffices to force $G=L$.

### Group B — Remark 4 (irrational weights alone)
- **X5 (★, Part 3).** Prove $\sqrt3$ is irrational.
- **X6 (★★, Part 3).** Prove $2\sqrt3-\sqrt6$ is irrational.
- **X7 (★★, Part 3).** In Case 2, verify the mixture identity $p\,u_1+(1-p)\,u_2=v$ for $u_1=v+(1-p)\varepsilon,\ u_2=v-p\varepsilon$.
- **X8 (★★, Part 3).** With $p=\tfrac{\sqrt2}{2}$ and $\varepsilon/M=\sqrt3/n$, prove $u_1/M$ and $u_2/M$ are both irrational.
- **X9 (★★★, Part 3).** Design an alternative admissible weight/offset (e.g. $\varepsilon/M=\sqrt5/n$) making Case 2 work, proving the needed irrationality. State the two structural requirements the construction must satisfy.

### Group C — Corollary 5 (piecewise saturation)
- **X10 (★, Part 4).** Prove the reparametrization $\phi_i(s)=m_{i-1}+h_i s$ maps convex combinations to convex combinations.
- **X11 (★★, Part 4).** Prove continuity at an interior knot $m_i$ in full detail (value-matching).
- **X12 (★, Part 4).** Verify the tent $G(v)=v$ on $[0,\tfrac12]$, $G(v)=1-v$ on $[\tfrac12,1]$ satisfies $(\star)$ on each cell but is not affine on $[0,1]$.
- **X13 (★★, Part 4).** Build a 3-cell continuous piecewise-affine solution with three *different* slopes; verify cell-wise $(\star)$ and continuity.
- **X14 (★★, Part 4 / Trap E5).** Show piecewise saturation does **not** force differentiability at a knot: the tent's corner persists. Argue continuity is the sharp conclusion.

### Group D — Theorem 6 (higher dimensions, as summarized here)
- **X15 (★★, Part 5).** State Theorem 6 and write the four-step skeleton; name the single analytic step.
- **X16 (★★, Part 5).** Derive relation (R), $A(pv+(1-p)w)=pA(v)+(1-p)A(w)$, from the hypothesis.
- **X17 (★★, Part 5).** Prove Steps (i) and (ii) as stated here; cite `reader-higher-dim.md` for (iii)–(iv).

### Group E — Proposition 7 (rational version keeps the pathology)
- **X18 (★★, Part 6.2).** Prove $\mathbb{R}$ is a vector space over $\mathbb{Q}$ and is **not** spanned by any countable set.
- **X19 (★★, Part 6.3).** Prove that free assignment of values on a Hamel basis yields a well-defined $\mathbb{Q}$-linear map (use uniqueness of representation).
- **X20 (★★, Part 6.4).** Prove that replacing a basis element $h'$ by a nonzero rational multiple $h=qh'\in(0,1)$ yields again a Hamel basis.
- **X21 (★★, Part 6.5).** Prove $G=\ell|_{[0,1]}$ satisfies $(J_\mathbb{Q})$ and is not affine.
- **X22 (★★★, Part 6.6).** Prove identity $(\dagger)$, deduce the graph of $G$ is dense in $[0,1]\times\mathbb{R}$, and conclude $G$ is nowhere continuous, non-monotone on every subinterval, and unbounded on every subinterval — using only Analysis I.
- **X23 (★★★, Part 6 / Trap E7).** Exhibit an explicit irrational weight $p$ and points $u_1,u_2\in[0,1]$ at which the witness $G$ **fails** $(\star)$. Reconcile with Remark 4.

### Group F — Synthesis
- **X24 (★★, Part 7).** Reconstruct the five-results table from memory and articulate, in one paragraph, the precise sense in which "real (indeed irrational) mixing weights retire regularity," tying Remark 4 to Proposition 7. (Remark: explain why the midpoint equation is equivalent to $(J_\mathbb{Q})$, not weaker.)

---

## Part S — Full solutions

**S1.** Fix $v\in[0,M]$; set $p=v/M\in[0,1]$, $u_1=M$, $u_2=0$. Then $pu_1+(1-p)u_2=v$, and $(\star)$ reads $G(v)=\tfrac{v}{M}G(M)+(1-\tfrac{v}{M})G(0)=G(0)+\tfrac{G(M)-G(0)}{M}v=L(v)$. $\blacksquare$

**S2.** The proof of S1 used $(\star)$ at the *single* pair $(M,0)$, varying only $p$. Theorem 3 assumes exactly that one configuration. It is formally weaker because assuming $p\,G(M)+(1-p)G(0)=G(pM)$ for all $p$ says nothing directly about $(\star)$ at other pairs $(u_1,u_2)$ — those instances are simply not hypothesized. (They become true post hoc, once $G=L$ is known, since affine functions satisfy full $(\star)$.) $\blacksquare$

**S3.** If $G(v)=\alpha v+\beta$ then for any $u_1,u_2,p$: $pG(u_1)+(1-p)G(u_2)=p(\alpha u_1+\beta)+(1-p)(\alpha u_2+\beta)=\alpha(pu_1+(1-p)u_2)+\beta=G(pu_1+(1-p)u_2)$, using $p+(1-p)=1$. So affine $\Rightarrow$ full $(\star)$. Hence if $G$ satisfies the single-configuration identity *and* is affine, it satisfies full $(\star)$ — but the affineness is the content (from Theorem 3), and full $(\star)$ is then a corollary, not an input. $\blacksquare$

**S4.** With $u_1=0,\ u_2=M$ and weight $p'=1-v/M\in[0,1]$: $p'u_1+(1-p')u_2=(1-p')M=\tfrac{v}{M}M=v$, and $(\star)$ gives $G(v)=p'G(0)+(1-p')G(M)=(1-\tfrac vM)G(0)+\tfrac vM G(M)=L(v)$. Same conclusion via the mirror configuration. $\blacksquare$

**S5.** If $\sqrt3=m/n$ in lowest terms, $3n^2=m^2$, so $3\mid m^2$, hence $3\mid m$ (3 prime); write $m=3k$: $3n^2=9k^2\Rightarrow n^2=3k^2\Rightarrow 3\mid n$, contradicting lowest terms. $\blacksquare$

**S6.** Suppose $2\sqrt3-\sqrt6=q\in\mathbb{Q}$. Then $\sqrt6=2\sqrt3-q$; squaring, $6=12-4q\sqrt3+q^2$, so $4q\sqrt3=6+q^2$. If $q\ne0$, $\sqrt3=(6+q^2)/(4q)\in\mathbb{Q}$, contradicting S5. If $q=0$, $2\sqrt3=\sqrt6\Rightarrow12=6$, false. $\blacksquare$

**S7.** $p\,u_1+(1-p)u_2=p(v+(1-p)\varepsilon)+(1-p)(v-p\varepsilon)=v\big(p+(1-p)\big)+\varepsilon\big(p(1-p)-(1-p)p\big)=v+0=v$. $\blacksquare$

**S8.** $\dfrac{u_1}{M}=\dfrac vM+(1-p)\dfrac\varepsilon M=\dfrac vM+\big(1-\tfrac{\sqrt2}{2}\big)\dfrac{\sqrt3}{n}=\dfrac vM+\dfrac{2\sqrt3-\sqrt6}{2n}$: a rational plus a nonzero rational multiple of the irrational $2\sqrt3-\sqrt6$ (S6), hence irrational. $\dfrac{u_2}{M}=\dfrac vM-\tfrac{\sqrt2}{2}\cdot\dfrac{\sqrt3}{n}=\dfrac vM-\dfrac{\sqrt6}{2n}$: rational plus irrational ($\sqrt6$ irrational, same proof as S5), hence irrational. $\blacksquare$

**S9.** Keep $p=\tfrac{\sqrt2}{2}$ but take $\varepsilon/M=\sqrt5/n$. Then $\dfrac{u_1}{M}=\dfrac vM+\dfrac{2\sqrt5-\sqrt{10}}{2n}$ and $\dfrac{u_2}{M}=\dfrac vM-\dfrac{\sqrt{10}}{2n}$. *Irrationality of $2\sqrt5-\sqrt{10}$:* if $=q$, then $\sqrt{10}=2\sqrt5-q\Rightarrow10=20-4q\sqrt5+q^2\Rightarrow4q\sqrt5=10+q^2$; $q\ne0\Rightarrow\sqrt5\in\mathbb{Q}$ (false), $q=0\Rightarrow20=10$ (false). And $\sqrt{10}$ is irrational similarly. So both ratios are irrational. **Two requirements:** (a) the weight $p$ must be irrational and in $(0,1)$ (so $(\star)$ is admissible at $p$ and the mixture is a genuine interior combination); (b) both auxiliary ratios $u_1/M,u_2/M$ must be irrational (so Case 1 already determines $G(u_1),G(u_2)$). The mixture identity (S7) holds for any $p,\varepsilon$, so only (a),(b) need engineering. $\blacksquare$

**S10.** $\phi_i(ps_1+(1-p)s_2)=m_{i-1}+h_i(ps_1+(1-p)s_2)=p(m_{i-1}+h_is_1)+(1-p)(m_{i-1}+h_is_2)=p\,\phi_i(s_1)+(1-p)\phi_i(s_2)$, using $p+(1-p)=1$ to split $m_{i-1}$. $\blacksquare$

**S11.** On cell $i$, $G$ is affine: $G(v)=\alpha_i v+\beta_i$ on $[m_{i-1},m_i]$. On cell $i+1$, $G(v)=\alpha_{i+1}v+\beta_{i+1}$ on $[m_i,m_{i+1}]$. The point $m_i$ lies in **both** closed cells, and $G(m_i)$ is a single well-defined number, so $\alpha_i m_i+\beta_i=G(m_i)=\alpha_{i+1}m_i+\beta_{i+1}$. Thus the left piece's limit as $v\uparrow m_i$ is $\alpha_i m_i+\beta_i=G(m_i)$ and the right piece's limit as $v\downarrow m_i$ is $\alpha_{i+1}m_i+\beta_{i+1}=G(m_i)$; both one-sided limits equal $G(m_i)$, so $G$ is continuous at $m_i$. Interiors are continuous (affine), so $G$ is continuous on $[0,M]$. $\blacksquare$

**S12.** On $[0,\tfrac12]$, $G(v)=v$ is affine, so it satisfies $(\star)$ there (S3); on $[\tfrac12,1]$, $G(v)=1-v$ is affine, so $(\star)$ holds there. At $v=\tfrac12$ both give $\tfrac12$, so $G$ is continuous. It is not affine on $[0,1]$: an affine function through $(0,0)$ and $(1,0)$ is $\equiv0$, but $G(\tfrac12)=\tfrac12\ne0$. $\blacksquare$

**S13.** Subdivision $0<\tfrac13<\tfrac23<1$. Define $G(v)=v$ on $[0,\tfrac13]$ (so $G(\tfrac13)=\tfrac13$); $G(v)=\tfrac23-v$ on $[\tfrac13,\tfrac23]$ (slope $-1$; $G(\tfrac13)=\tfrac13$ matches, $G(\tfrac23)=0$); $G(v)=2v-\tfrac43$ on $[\tfrac23,1]$ (slope $2$; $G(\tfrac23)=0$ matches, $G(1)=\tfrac23$). Each piece is affine, hence satisfies $(\star)$ on its cell (S3); values match at both knots, so $G$ is continuous (S11); slopes $1,-1,2$ differ, so $G$ is not affine. $\blacksquare$

**S14.** The tent (S12) is continuous but its left slope at $\tfrac12$ is $+1$ and right slope $-1$; the difference quotient $\tfrac{G(\tfrac12+t)-G(\tfrac12)}{t}$ tends to $-1$ as $t\downarrow0$ and $+1$ as $t\uparrow0$, so $G'(\tfrac12)$ does not exist. Piecewise saturation therefore cannot deliver differentiability at knots; value-matching (S11) gives continuity and nothing more, so continuity is sharp. $\blacksquare$

**S15.** *Statement:* see Part 5. *Skeleton:* (R) $\to$ (i) real homogeneity $A(pv)=pA(v)$ $\to$ (ii) additivity where $v,w,v+w\in D$ $\to$ (iii) cone $D^{*}$ with $\hat A(\lambda v)=\lambda A(v)$ $\to$ (iv) difference space $W=\operatorname{span}(C-C)$ with $a(v-w)=\hat A(v)-\hat A(w)$. **The only analytic step is (i)** — the one-dimensional substitution along a segment. $\blacksquare$

**S16.** Apply the hypothesis at $x_1=x_0+v,\ x_2=x_0+w$ (both in $C$ since $v,w\in D$), weight $p$: $pG(x_0+v)+(1-p)G(x_0+w)=G(x_0+pv+(1-p)w)$. Subtract $G(x_0)$ and use $A=G(x_0+\cdot)-G(x_0)$, $p+(1-p)=1$: $A(pv+(1-p)w)=pA(v)+(1-p)A(w)$. $\blacksquare$

**S17.** *(i)* Put $w=0$ in (R) ($0\in D$, $A(0)=0$): $A(pv)=pA(v)$ for all $p\in[0,1]$. *(ii)* Put $p=\tfrac12$ in (R): $A(\tfrac{v+w}2)=\tfrac12(A(v)+A(w))$; if $v+w\in D$, (i) applied to $v+w$ with $p=\tfrac12$ gives $A(\tfrac{v+w}2)=\tfrac12A(v+w)$, so $A(v+w)=A(v)+A(w)$. Steps (iii)–(iv) are in `reader-higher-dim.md`. $\blacksquare$

**S18.** $\mathbb{R}$ is closed under $+$ and under multiplication by rationals, and the vector-space axioms hold because they hold in the field $\mathbb{R}$; so $\mathbb{R}$ is a $\mathbb{Q}$-vector space. If a countable set $S$ spanned it, then $\mathbb{R}=\{$finite $\mathbb{Q}$-combinations of $S\}$; but finite $\mathbb{Q}$-combinations of a countable set form a countable union of countable sets, hence countable, contradicting the uncountability of $\mathbb{R}$ (Analysis I). $\blacksquare$

**S19.** Each $x\in\mathbb{R}$ has a *unique* representation $x=\sum_i q_i h_i$ ($q_i\in\mathbb{Q}$, $h_i\in H$ distinct, finitely many). Defining $\ell(x)=\sum_i q_i\ell(h_i)$ is unambiguous by uniqueness. For $x=\sum q_ih_i$, $y=\sum r_ih_i$ (pad with zero coefficients to a common finite support), $x+y=\sum(q_i+r_i)h_i$, so $\ell(x+y)=\sum(q_i+r_i)\ell(h_i)=\ell(x)+\ell(y)$; and $qx=\sum(qq_i)h_i$ gives $\ell(qx)=q\ell(x)$ for $q\in\mathbb{Q}$. $\blacksquare$

**S20.** Independence: a $\mathbb{Q}$-relation among $H=(H_0\setminus\{h'\})\cup\{h\}$ using $h=qh'$ rewrites as a $\mathbb{Q}$-relation among $H_0$ (replace $h$ by $qh'$); independence of $H_0$ forces all coefficients zero. Spanning: any $x$ is a $\mathbb{Q}$-combination over $H_0$; replace the $h'$-term $c\,h'$ by $(c/q)h$, giving a combination over $H$. So $H$ is a basis. Since $h'\ne0$, a nonzero rational $q$ of the same sign as $h'$ and small enough in magnitude has $qh'\in(0,1)$. $\blacksquare$

**S21.** *Solves $(J_\mathbb{Q})$:* for $u_1,u_2\in[0,1]$ and rational $p$, $pu_1+(1-p)u_2\in[0,1]$ and $\mathbb{Q}$-linearity gives $\ell(pu_1+(1-p)u_2)=p\ell(u_1)+(1-p)\ell(u_2)$, i.e. $G(pu_1+(1-p)u_2)=pG(u_1)+(1-p)G(u_2)$. *Non-affine:* for rational $q\in[0,1]$, $G(q)=\ell(q\cdot1)=q\ell(1)=0$; but $G(h)=\ell(h)=1$ with $h\in(0,1)$. Any affine $A=\alpha v+\beta$ agreeing with $G$ on $\mathbb{Q}\cap[0,1]$ forces $\beta=0,\alpha=0$, so $A\equiv0\ne G$ (as $G(h)=1$). $\blacksquare$

**S22.** $(\dagger)$: $\ell(q_1+q_2h)=q_1\ell(1)+q_2\ell(h)=q_2$ by $\mathbb{Q}$-linearity. *Dense graph:* given a box $(a,b)\times(c-\delta,c+\delta)$ with $(a,b)\subseteq[0,1]$, pick rational $q_2$ with $|q_2-c|<\delta$; as $q_1$ ranges over $\mathbb{Q}$, $q_1+q_2h$ ranges over a dense subset of $\mathbb{R}$ (a fixed shift of $\mathbb{Q}$), so some $x=q_1+q_2h\in(a,b)$, and $G(x)=q_2\in(c-\delta,c+\delta)$. *Consequences:* (i) *nowhere continuous* — rationals $q_n\to x^\ast$ give $G(q_n)=0$ while density supplies $y_n\to x^\ast$ with $G(y_n)\to$ any other value, so no limit exists (at $x^\ast=h$: $G(q_n)=0\not\to1$); (ii) *non-monotone on every $(a,b)$* — the graph is dense, so values above and below any level occur in every order; (iii) *unbounded on every $(a,b)$* — take $q_2$ arbitrarily large in $(\dagger)$. All by density, no measure theory. $\blacksquare$

**S23.** Take the irrational weight $p=h\in(0,1)$ and points $u_1=1,\ u_2=0$. Then $pu_1+(1-p)u_2=h\cdot1+(1-h)\cdot0=h$, so the left side of $(\star)$ is $G(h)=\ell(h)=1$. The right side is $p\,G(1)+(1-p)G(0)=h\,\ell(1)+(1-h)\ell(0)=h\cdot0+0=0$. Since $1\ne0$, $(\star)$ **fails** at this irrational weight. *Reconciliation with Remark 4:* the witness satisfies $(\star)$ at every rational weight (that is $(J_\mathbb{Q})$, S21) but fails it at an irrational weight — exactly the weights Remark 4 says are decisive. The irrational weights both *destroy* this pathology (Remark 4) and are *where it is detectable* (here): two faces of the same fact. $\blacksquare$

**S24.** *Table:* Theorem 3 (minimize input — one configuration); Remark 4 (minimize input — irrational weights alone); Corollary 5 (localize — cell-by-cell $\Rightarrow$ piecewise affine + automatic continuity); Theorem 6 (raise dimension — any convex set in any real vector space); Proposition 7 (find the boundary — rational weights keep a non-affine pathology). *Thesis:* every hypothesis of Theorem 1 except the *real* weights can be minimized, localized, or generalized away; but weakening real to rational weights provably reintroduces a non-affine solution (Prop 7), and that solution is killed precisely by the irrational weights (Remark 4). So the real (indeed irrational) mixing weights are the unique essential ingredient that "retires regularity." *Midpoint remark:* iterating the $p=\tfrac12$ identity produces the identity at all dyadic rationals, then (by the standard rational-weight argument) at all rational weights, so the midpoint equation is **equivalent** to $(J_\mathbb{Q})$ — not weaker; hence the witness solves the midpoint equation too. $\blacksquare$

---

## Part D — Routines, recitations, and drills

### D.1 Speed drills (recite against a clock)
1. **The five results in order (target 30 s):** Thm 3 = one configuration; Rem 4 = irrational weights alone; Cor 5 = cell-by-cell $\Rightarrow$ piecewise affine + free continuity; Thm 6 = any convex set, pure linear algebra; Prop 7 = rational weights keep the pathology.
2. **Remark 4 routing (target 25 s):** if $v/M$ rational, mix two points with irrational ratios $u_i/M$ by the irrational weight $p=\tfrac{\sqrt2}{2}$; Case 1 pins their values, the equation transports to $v$.
3. **Prop 7 spine (target 30 s):** $\mathbb{R}$ over $\mathbb{Q}$ $\to$ Hamel basis (Zorn) $\to$ rescale $h\in(0,1)$ $\to$ $\ell(1)=0,\ell(h)=1$ $\to$ solves $(J_\mathbb{Q})$, vanishes on $\mathbb{Q}$, $G(h)=1$ $\to$ dense graph $\to$ nowhere regular.
4. **The one-line thesis (target 10 s):** "Everything but the real weights can be removed; the real (irrational) weights are exactly what retires regularity."

### D.2 Blank-page reconstruction ladder (no notes)
- **Rung 1:** Theorem 1 by endpoint substitution; Theorem 3 (strip to one configuration).
- **Rung 2:** Remark 4 — the two irrationality lemmas, Case 1, Case 2 routing.
- **Rung 3:** Corollary 5 — reparametrize each cell, knot-matching continuity, tent counterexample.
- **Rung 4:** Theorem 6 — (R), Steps (i)–(iv) skeleton.
- **Rung 5:** Proposition 7 — full construction and the dense-graph irregularity.
Climb twice cold and Section 4 is yours.

### D.3 Recitation script (mock oral — answer aloud, then check)
- *"How little of $(\star)$ does affineness need?"* → one endpoint configuration (Thm 3).
- *"Are rational weights needed?"* → no; irrational weights alone suffice (Rem 4).
- *"What if $v/M$ is rational?"* → route through irrational-ratio auxiliary points; X7–X8.
- *"Does cell-by-cell give global affineness?"* → no; tent; only piecewise + continuity (Cor 5).
- *"Where does continuity in Cor 5 come from?"* → value-matching at knots, for free.
- *"Why can't we weaken real to rational weights?"* → Prop 7 builds a non-affine $(J_\mathbb{Q})$-solution.
- *"Why is that witness non-affine — measure theory?"* → no; dense-graph argument, Analysis I only.
- *"Where does the witness fail $(\star)$?"* → at the irrational weight $p=h$, $u_1=1,u_2=0$; X23.
- *"Is a Hamel basis explicit?"* → no; Zorn / choice, non-constructive.

### D.4 Maintenance routine
- **Pass 1:** D.1 drills ×3; X1–X9.
- **Pass 2:** D.2 rungs 1–3; X10–X17.
- **Pass 3:** D.2 rungs 4–5; X18–X24; all of Part E aloud.
- **Pass 4:** full mock oral (D.3); redo any exercise you peeked at.
Mastery check: deliver the five results with their *directions*, reproduce the Prop 7 witness and its dense-graph irregularity, and pinpoint the irrational weight where it fails $(\star)$ — all without notes.
