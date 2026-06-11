# A From-Scratch Reader: Convex Domains in Higher Dimensions (Theorem 6, `thm:higher`)

> **Reader's guide** to the subsection *"Convex domains in higher dimensions"* of *The Continuous-Coefficient Jensen Equation: How Real Mixing Weights Retire Regularity* (satellites/o3-maa).
> **Scope.** Exactly one result: **Theorem 6** (`thm:higher`), the lifting of the interval theorem (Theorem 1, `thm:main`) to a convex subset of an arbitrary real vector space.
> **Audience.** A returning student whose toolkit is **Analysis I and Algebra I** — A grades, but a decade ago. You are *not* assumed to know measure theory, functional analysis, topology beyond Analysis I, or Hamel bases; everything is built here. If your linear algebra (span, basis, linear functional, quotient-style constructions) feels rusty, skim **Part R of `notes/reader.md`** first — it re-cuts exactly those grooves.
> **Promise.** Pure mathematics, no analogies. Every object is defined and every step is proved, so you can reproduce the subsection on a blank page.
> **Companions.** `notes/reader.md` (Sections 1–3 and the one-dimensional theory); `notes/reader-section4.md` (all of Section 4, including this result in context).
> **Back matter.** After the exposition: **Part E** (extreme examples and traps), **Part X** (24 exercises), **Part S** (full solutions), **Part D** (routines and drills for oral-exam mastery). Do the exercises before reading the solutions.

A word on what makes this result striking, stated before we begin so you know what to watch for: the proof uses **no topology and no measure theory at all** — it is *pure linear algebra* driven by a single substitution. That is the whole point. In the classical literature the Jensen equation on convex domains is proved *with* regularity hypotheses (continuity, measurability); here the continuum of mixing weights does all the work and the hypotheses never appear. Watch for the exact line where the continuum is used (Step (i) below); everything after it is bookkeeping.

---

## Part 0 — The result in one paragraph

We proved on an interval $[0,M]$ that a function satisfying Jensen's equation with **all real weights** is forced to be affine, with no regularity hypothesis (Theorem 1). Theorem 6 says the same on **any convex set $C$** inside **any real vector space $V$** (finite-dimensional like $\mathbb{R}^n$, or infinite-dimensional): if
$$
p\,G(x_1)+(1-p)\,G(x_2)=G\bigl(p\,x_1+(1-p)\,x_2\bigr)\qquad(x_1,x_2\in C,\ p\in[0,1]),
$$
then $G(x)=a(x-x_0)+b$ for a **linear functional** $a$ and a constant $b$ — i.e. $G$ is affine on $C$. The proof restricts the equation to one-dimensional segments inside $C$, applies the interval theorem along each segment to get **real homogeneity**, then glues the segment-data into a single linear functional by elementary linear algebra. No continuity, no measurability, no completeness — just the vector-space axioms and the one substitution.

Everything below expands this paragraph.

---

## Part 1 — Prerequisites, recalled and fixed

Nothing here goes beyond Algebra I, but we fix notation precisely.

### 1.1 Real vector space (Algebra I)
A **real vector space** $V$ is a set with addition $V\times V\to V$ and scalar multiplication $\mathbb{R}\times V\to V$ satisfying the usual axioms (associativity and commutativity of $+$, a zero vector $0$, additive inverses, and $1\cdot v=v$, $c(d v)=(cd)v$, $(c+d)v=cv+dv$, $c(v+w)=cv+cw$). The leading example is $V=\mathbb{R}^n$ with coordinatewise operations; but we never use coordinates, so the proof works verbatim for any $V$, including infinite-dimensional ones (e.g. spaces of functions).

### 1.2 Convex set and convex combination
A subset $C\subseteq V$ is **convex** if for all $x_1,x_2\in C$ and every $p\in[0,1]$,
$$
p\,x_1+(1-p)\,x_2\in C.
$$
The expression $p\,x_1+(1-p)\,x_2$ is the **convex combination** of $x_1,x_2$ with weights $p,1-p$. As $p$ runs over $[0,1]$ it traces the **segment** $[x_2,x_1]:=\{p x_1+(1-p)x_2:p\in[0,1]\}$, which by convexity lies entirely in $C$. (In $\mathbb{R}^2$: triangles, disks, half-planes are convex; a star shape is not.)

### 1.3 Linear functional and affine map (Algebra I)
A **linear functional** on a subspace $W\subseteq V$ is a map $a\colon W\to\mathbb{R}$ with
$$
a(u+u')=a(u)+a(u'),\qquad a(c\,u)=c\,a(u)\quad(c\in\mathbb{R},\ u,u'\in W).
$$
A map $G\colon C\to\mathbb{R}$ is **affine** if, for some fixed $x_0\in C$, some linear functional $a$, and some constant $b\in\mathbb{R}$,
$$
G(x)=a(x-x_0)+b\qquad(x\in C).
$$
Equivalently (the property we will actually verify), $G$ respects convex combinations:
$$
G\bigl(p x_1+(1-p)x_2\bigr)=p\,G(x_1)+(1-p)\,G(x_2)\qquad(p\in[0,1]).
$$
One direction is a one-line check: if $G(x)=a(x-x_0)+b$ then, using linearity of $a$ and $p+(1-p)=1$,
$$
G(px_1+(1-p)x_2)=a(px_1+(1-p)x_2-x_0)+b=p\,a(x_1-x_0)+(1-p)a(x_2-x_0)+b=p\,G(x_1)+(1-p)G(x_2).
$$
So **affine $\Rightarrow$ solution** is automatic; the theorem is the converse.

### 1.4 The parallel subspace $W=\operatorname{span}(C-C)$
Two pieces of vocabulary used in the statement.

- $C-C:=\{x-y:x,y\in C\}$ is the set of all difference vectors of $C$.
- $\operatorname{span}(S)$ is the set of all **finite** real linear combinations of elements of $S$ (the smallest subspace containing $S$ — Algebra I).

The subspace $W:=\operatorname{span}(C-C)$ is called the **parallel subspace** (or *direction space*) of $C$: it is the linear subspace parallel to the smallest affine set containing $C$ (the **affine hull**). Intuition in $\mathbb{R}^3$: if $C$ is a (flat) triangle floating in space, its affine hull is the plane through it, and $W$ is the parallel plane through the origin — the directions in which you can move while staying "within the flat of $C$." The linear functional $a$ in the theorem will live on exactly this $W$, because $G$ can only ever be probed in directions inside $W$.

---

## Part 2 — The statement

> **Theorem 6 (`thm:higher`).** Let $V$ be a real vector space (any dimension), $C\subseteq V$ a convex set, and $G\colon C\to\mathbb{R}$ a function satisfying
> $$
> p\,G(x_1)+(1-p)\,G(x_2)=G\bigl(p\,x_1+(1-p)\,x_2\bigr)\qquad(x_1,x_2\in C,\ p\in[0,1]).
> \tag{$\star_C$}
> $$
> Then there is a **linear functional** $a\colon W\to\mathbb{R}$ on the parallel subspace $W=\operatorname{span}(C-C)$ and a constant $b\in\mathbb{R}$ with
> $$
> G(x)=a(x-x_0)+b\qquad(x\in C)
> $$
> for any fixed $x_0\in C$. Equivalently, **$G$ is affine on $C$ — with no regularity hypothesis.**

The hypothesis $(\star_C)$ is literally "Jensen's equation with all real weights $p\in[0,1]$, on the convex set $C$." Note we demand it for *every* pair and *every* real weight; Part 5 explains why the real weights are exactly what removes the need for any regularity assumption.

---

## Part 3 — The one-dimensional engine, recalled with proof

The proof of Theorem 6 calls the interval theorem along segments. So we restate it self-containedly. (This is Theorem 1 / `thm:main`, the subject of `notes/reader.md`.)

> **Lemma (endpoint substitution; the engine).** Let $g\colon[0,1]\to\mathbb{R}$ satisfy $g(p)=p\,g(1)+(1-p)\,g(0)$ for all $p\in[0,1]$. Then $g$ is the affine function $g(p)=g(0)+(g(1)-g(0))p$.

That is the hypothesis restated; the content we actually use is the following packaging, obtained by feeding the equation a single configuration.

> **Engine, working form.** Suppose $h\colon[0,1]\to\mathbb{R}$ arises as $h(p):=G(p\,x_1+(1-p)\,x_2)$ for two points $x_1,x_2\in C$, where $G$ satisfies $(\star_C)$. Then for all $p\in[0,1]$,
> $$
> h(p)=p\,G(x_1)+(1-p)\,G(x_2).
> $$

*Proof.* This is just $(\star_C)$ read at the pair $(x_1,x_2)$ and weight $p$. $\qquad\blacksquare$

In words: **restricted to any segment of $C$, the function $G$ is affine in the segment parameter $p$**, immediately, because $(\star_C)$ says so at every real $p$. This single fact is the entire analytic input. Everything else is algebra.

---

## Part 4 — The proof of Theorem 6, in full

Fix once and for all a basepoint $x_0\in C$. Define the **shifted set** and the **shifted function**
$$
D:=C-x_0=\{x-x_0:x\in C\},\qquad A(v):=G(x_0+v)-G(x_0)\ \ (v\in D).
$$
Then $0\in D$ (take $x=x_0$), $A(0)=0$, and $D$ is convex (a translate of a convex set is convex). Proving "$G$ affine" is the same as proving "$A$ is the restriction of a linear functional," because $G(x)=A(x-x_0)+G(x_0)$.

A fact we use repeatedly:

> **(Shrink)** For $s\in[0,1]$ and $v\in D$, we have $s v\in D$.

*Proof.* $sv=s\,v+(1-s)\,0$ is a convex combination of $v\in D$ and $0\in D$, so it lies in $D$ by convexity. $\qquad\blacksquare$

### Step 0 — The fundamental relation on $D$
Translate $(\star_C)$ through the definition of $A$. For $v,w\in D$ and $p\in[0,1]$, apply $(\star_C)$ at $x_1=x_0+v$, $x_2=x_0+w$:
$$
p\,G(x_0+v)+(1-p)G(x_0+w)=G\bigl(x_0+pv+(1-p)w\bigr).
$$
Subtract $G(x_0)$ from both sides and use $p+(1-p)=1$:
$$
\boxed{\,A\bigl(p v+(1-p)w\bigr)=p\,A(v)+(1-p)\,A(w)\,}\qquad(v,w\in D,\ p\in[0,1]).
\tag{R}
$$
(Note $pv+(1-p)w\in D$ by convexity, so the left side is defined.) Relation (R) is the workhorse.

### Step (i) — Real homogeneity on $D$
Put $w=0$ in (R) (legal since $0\in D$, and $A(0)=0$):
$$
A(p v)=p\,A(v)\qquad(v\in D,\ p\in[0,1]).
\tag{i}
$$
**This is the only place the continuum of weights is used.** It is exactly the engine of Part 3 along the segment $[x_0,x_0+v]$: scaling the displacement $v$ by $p$ scales the value $A$ by $p$, for *every real* $p\in[0,1]$. From here on, $\mathbb{Q}$ versus $\mathbb{R}$ plays no role — it is pure bookkeeping.

### Step (ii) — Additivity where the sum stays in $D$
Take $p=\tfrac12$ in (R):
$$
A\!\left(\tfrac{v+w}{2}\right)=\tfrac12\bigl(A(v)+A(w)\bigr)\qquad(v,w\in D).
$$
If moreover $v+w\in D$, then by (i) with $p=\tfrac12$ applied to the vector $v+w$, the left side equals $\tfrac12 A(v+w)$. Comparing,
$$
A(v+w)=A(v)+A(w)\qquad\text{whenever }v,w,\,v+w\in D.
\tag{ii}
$$

### Step (iii) — Extend to the cone $D^{*}$
The trouble with (ii) is the proviso "$v+w\in D$": $D$ is generally not closed under addition (e.g. a bounded convex set). We enlarge $D$ to the smallest set on which scaling is unrestricted.

Define the **cone generated by $D$**:
$$
D^{*}:=\bigcup_{\lambda>0}\lambda D=\{\lambda v:\lambda>0,\ v\in D\}.
$$

> **$D^{*}$ is a convex cone** (closed under positive scaling and under addition).
>
> *Proof.* Positive scaling: if $u=\lambda v\in D^{*}$ and $c>0$ then $cu=(c\lambda)v\in D^{*}$. Addition: let $u_1=\lambda_1 v_1$, $u_2=\lambda_2 v_2$ with $v_i\in D$, $\lambda_i>0$, and set $\lambda:=\lambda_1+\lambda_2$. Then
> $$
> u_1+u_2=\lambda\Bigl(\tfrac{\lambda_1}{\lambda}v_1+\tfrac{\lambda_2}{\lambda}v_2\Bigr),
> $$
> and the bracket is a convex combination of $v_1,v_2\in D$ (weights $\tfrac{\lambda_1}{\lambda},\tfrac{\lambda_2}{\lambda}\ge0$ summing to $1$), hence lies in $D$. So $u_1+u_2\in\lambda D\subseteq D^{*}$. $\qquad\square$

Now define $\hat A\colon D^{*}\to\mathbb{R}$ by
$$
\hat A(\lambda v):=\lambda\,A(v)\qquad(v\in D,\ \lambda>0).
$$

> **$\hat A$ is well defined.** Suppose $\lambda v=\mu w$ with $v,w\in D$, $\lambda,\mu>0$. Pick $t>0$ small enough that $t\lambda\le1$ and $t\mu\le1$. Then $t\lambda\in(0,1]$ and $v\in D$ give $(t\lambda)v\in D$ by (Shrink); likewise $(t\mu)w\in D$; and $(t\lambda)v=t(\lambda v)=t(\mu w)=(t\mu)w$. Apply (i) twice:
> $$
> A\bigl((t\lambda)v\bigr)=t\lambda\,A(v),\qquad A\bigl((t\mu)w\bigr)=t\mu\,A(w).
> $$
> The left sides are equal (same vector), so $t\lambda A(v)=t\mu A(w)$, and dividing by $t>0$ gives $\lambda A(v)=\mu A(w)$, i.e. the two formulas for $\hat A$ agree. $\qquad\square$

Two properties of $\hat A$ extend Steps (i)–(ii) to the cone.

> **$\hat A$ is additive on $D^{*}$ and positively homogeneous.**
>
> *Additivity.* With $u_1=\lambda_1 v_1$, $u_2=\lambda_2 v_2$ and $\lambda=\lambda_1+\lambda_2$ as above, $\tfrac1\lambda(u_1+u_2)=\tfrac{\lambda_1}{\lambda}v_1+\tfrac{\lambda_2}{\lambda}v_2\in D$, so by the definition of $\hat A$ and then relation (R) (with $p=\lambda_1/\lambda$),
> $$
> \hat A(u_1+u_2)=\lambda\,A\!\Bigl(\tfrac{\lambda_1}{\lambda}v_1+\tfrac{\lambda_2}{\lambda}v_2\Bigr)=\lambda\Bigl(\tfrac{\lambda_1}{\lambda}A(v_1)+\tfrac{\lambda_2}{\lambda}A(v_2)\Bigr)=\lambda_1 A(v_1)+\lambda_2 A(v_2)=\hat A(u_1)+\hat A(u_2).
> $$
> *Positive homogeneity.* For $c>0$ and $u=\lambda v\in D^{*}$: $\hat A(cu)=\hat A((c\lambda)v)=c\lambda A(v)=c\,\hat A(u)$. $\qquad\square$

### Step (iv) — Extend to the subspace $W$ and finish
Set $W:=D^{*}-D^{*}=\{v-w:v,w\in D^{*}\}$.

> **$W$ is a subspace, and $W=\operatorname{span}(C-C)$.**
>
> *Subspace.* $0=v-v\in W$. Closed under addition: $(v-w)+(v'-w')=(v+v')-(w+w')\in W$ since $D^{*}$ is closed under $+$. Closed under negation: $-(v-w)=w-v\in W$. Closed under positive scaling: $c(v-w)=cv-cw\in W$ (cone), and under negative scaling via negation. So $W$ is a subspace.
> *Identification.* Since $0\in D\subseteq D^{*}$, we have $D=D-0\subseteq W$, hence $C-C=D-D\subseteq W$, so $\operatorname{span}(C-C)\subseteq W$ (a subspace containing a set contains its span). Conversely each element $v-w$ of $W$ has $v,w\in D^{*}$, i.e. $v=\lambda_1 v_1$, $w=\lambda_2 v_2$ with $v_i\in D\subseteq C-C$, so $v-w\in\operatorname{span}(C-C)$. Thus $W=\operatorname{span}(C-C)$. $\qquad\square$

Define $a\colon W\to\mathbb{R}$ by
$$
a(v-w):=\hat A(v)-\hat A(w)\qquad(v,w\in D^{*}).
$$

> **$a$ is a well-defined linear functional.**
>
> *Well defined.* If $v-w=v'-w'$ then $v+w'=v'+w$ in $D^{*}$; additivity of $\hat A$ gives $\hat A(v)+\hat A(w')=\hat A(v')+\hat A(w)$, i.e. $\hat A(v)-\hat A(w)=\hat A(v')-\hat A(w')$.
> *Additive.* $a\bigl((v-w)+(v'-w')\bigr)=\hat A(v+v')-\hat A(w+w')=\hat A(v)+\hat A(v')-\hat A(w)-\hat A(w')=a(v-w)+a(v'-w')$.
> *Homogeneous.* For $c>0$: $a(c(v-w))=\hat A(cv)-\hat A(cw)=c(\hat A(v)-\hat A(w))=c\,a(v-w)$. Also $a(-(v-w))=a(w-v)=\hat A(w)-\hat A(v)=-a(v-w)$, which upgrades positive to full real homogeneity (the case $c<0$ is $c=-|c|$, and $c=0$ is trivial since $a(0)=0$). So $a$ is linear. $\qquad\square$

**Conclusion.** For $x\in C$ we have $x-x_0\in D\subseteq D^{*}$, and $0\in D^{*}$ with $\hat A(0)=0$ (as $0=\lambda\cdot 0$ and $A(0)=0$). Hence
$$
a(x-x_0)=\hat A(x-x_0)-\hat A(0)=\hat A(x-x_0)=A(x-x_0)=G(x)-G(x_0).
$$
Therefore, with $b:=G(x_0)$,
$$
G(x)=a(x-x_0)+b\qquad(x\in C),
$$
which is exactly affineness. And by the one-line check of §1.3, any such $G$ does satisfy $(\star_C)$, so the description is exact. $\qquad\blacksquare$

---

## Part 5 — Why no regularity hypothesis is needed (and where the continuum acted)

Re-read the proof and locate the analytic content. It is a **single line: Step (i)**, $A(pv)=pA(v)$ for *all real* $p\in[0,1]$. That is the one-dimensional endpoint substitution applied along each segment $[x_0,x_0+v]$, and it is precisely the place where "the equation holds at every real weight" is consumed. Steps (ii)–(iv) are pure linear algebra: closure of a cone, well-definedness of a quotient-type construction, extension by additivity. **No limits, no continuity, no measurability, no completeness of $V$ are ever invoked.** The vector space $V$ is not even assumed finite-dimensional or normed.

This is the higher-dimensional echo of the paper's central message. For the *rational-weight* Jensen equation on a convex domain, the classical proofs must impose a regularity hypothesis to rule out pathological additive functions (built with the axiom of choice; see `notes/reader-section4.md`, Part 6). Those treatments — e.g. Kuczma's monograph and Aczél–Dhombres — are "regularity-laden." Here, because the equation is asserted at **every real weight**, Step (i) furnishes real homogeneity *directly*, and the pathology has no room to exist: a non-affine additive map fails real homogeneity at some real scalar, but Step (i) forces real homogeneity at *every* scalar in $[0,1]$. The hypotheses are **vestigial** for the same structural reason as in one dimension; the multidimensional statement adds only the linear-algebraic gluing.

> **One-sentence takeaway.** The only mathematics in Theorem 6 is the one-dimensional substitution applied segment-by-segment (Step (i)); the dimension-raising is bookkeeping with a cone and a difference space, so regularity hypotheses never enter.

---

## Part 6 — A worked example, and the infinite-dimensional case

### 6.1 The triangle in $\mathbb{R}^2$
Let $C$ be the closed triangle with vertices $e_0=(0,0)$, $e_1=(1,0)$, $e_2=(0,1)$ — a convex set. Suppose $G\colon C\to\mathbb{R}$ satisfies $(\star_C)$. Take $x_0=e_0$, so $D=C$ and $A=G-G(e_0)$.

- Step (i) along the edge toward $e_1$: $A(p\,e_1)=p\,A(e_1)$ for all $p\in[0,1]$ — $G$ is affine along the bottom edge.
- Step (i) along the edge toward $e_2$: $A(p\,e_2)=p\,A(e_2)$ — affine up the left edge.
- Step (ii)/(R) at an interior point $p\,e_1+(1-p)\,e_2$ ties the two edges together: $A(pe_1+(1-p)e_2)=pA(e_1)+(1-p)A(e_2)$.
- The cone $D^{*}$ generated by the triangle is the whole first quadrant's span — in fact $W=\operatorname{span}(C-C)=\mathbb{R}^2$ here (the triangle is "full-dimensional"). The functional is $a(s,t)=s\,A(e_1)+t\,A(e_2)$, so $G(s,t)=s\,A(e_1)+t\,A(e_2)+G(e_0)$ — a plane through the three vertex values. As expected: the only solutions are the planes pinned by the values at the three vertices.

### 6.2 A lower-dimensional $C$
If instead $C$ is a *segment* inside $\mathbb{R}^2$ (a degenerate "triangle"), then $W=\operatorname{span}(C-C)$ is one-dimensional — a line through the origin — and $a$ is only determined on that line. This is why the theorem phrases the functional on $W$ rather than all of $V$: $G$ is only ever tested in directions you can actually move within $C$. Off $W$, $G$ simply is not defined, so nothing is claimed there.

### 6.3 Infinite dimensions
Nothing in Part 4 used finite dimension. If $V$ is, say, the space of real polynomials and $C$ a convex set of polynomials, the identical proof shows any $(\star_C)$-solution is $G(f)=a(f-f_0)+b$ for a linear functional $a$ on $\operatorname{span}(C-C)$. The cone construction $D^{*}$ and the difference space $D^{*}-D^{*}$ are algebraic and indifferent to dimension. This breadth is a direct consequence of the proof using no topology.

---

## Part 7 — From-scratch reconstruction checklist

To reproduce the subsection on a blank page:

1. **Definitions.** Real vector space, convex set, convex combination, segment, linear functional, affine map, $\operatorname{span}(C-C)$ (parallel subspace). *(Part 1)*
2. **Statement.** $(\star_C)$ on $C$; conclusion $G(x)=a(x-x_0)+b$. Verify affine $\Rightarrow$ solution. *(Part 2, §1.3)*
3. **Engine.** Restricting $(\star_C)$ to a segment gives affineness in the segment parameter — the one-dimensional endpoint substitution. *(Part 3)*
4. **Setup.** Fix $x_0$; put $D=C-x_0$, $A=G(x_0+\cdot)-G(x_0)$; note $A(0)=0$ and (Shrink) $sD\subseteq D$. *(Part 4, top)*
5. **Relation (R).** Translate $(\star_C)$ to $A(pv+(1-p)w)=pA(v)+(1-p)A(w)$. *(Step 0)*
6. **(i) Real homogeneity** $A(pv)=pA(v)$ (set $w=0$) — the only analytic step. *(Step i)*
7. **(ii) Additivity** when $v,w,v+w\in D$ (set $p=\tfrac12$, then use (i)). *(Step ii)*
8. **(iii) Cone $D^{*}$:** it is a convex cone; $\hat A(\lambda v)=\lambda A(v)$ is well defined, additive, positively homogeneous. *(Step iii)*
9. **(iv) Difference space $W=D^{*}-D^{*}$:** a subspace equal to $\operatorname{span}(C-C)$; $a(v-w)=\hat A(v)-\hat A(w)$ is a well-defined linear functional; conclude $G(x)=a(x-x_0)+G(x_0)$. *(Step iv)*
10. **Moral.** Only Step (i) uses the continuum of weights; the rest is linear algebra, so no regularity hypothesis is needed. *(Part 5)*

---

## Part 8 — 60-second recap

1. **Claim.** On any convex $C$ in any real vector space, Jensen's equation **at all real weights** forces $G(x)=a(x-x_0)+b$ with $a$ a linear functional on $W=\operatorname{span}(C-C)$ — affine, no regularity assumed. *(Theorem 6, `thm:higher`)*
2. **Shift.** Replace $G$ by $A(v)=G(x_0+v)-G(x_0)$ on $D=C-x_0$ (so $A(0)=0$, $D$ convex, $sD\subseteq D$).
3. **Relation (R).** $A(pv+(1-p)w)=pA(v)+(1-p)A(w)$ on $D$ — a verbatim translation of the hypothesis.
4. **(i)** $w=0\Rightarrow A(pv)=pA(v)$ for all real $p\in[0,1]$: **real homogeneity**, the single analytic input (the one-dimensional substitution along segments).
5. **(ii)** $p=\tfrac12$ plus (i) $\Rightarrow$ additivity when the sum stays in $D$.
6. **(iii)** Pass to the cone $D^{*}=\bigcup_{\lambda>0}\lambda D$; define $\hat A(\lambda v)=\lambda A(v)$ — well defined, additive, positively homogeneous.
7. **(iv)** On $W=D^{*}-D^{*}=\operatorname{span}(C-C)$, set $a(v-w)=\hat A(v)-\hat A(w)$ — a linear functional; then $G(x)=a(x-x_0)+G(x_0)$.
8. **Why no regularity:** every step after (i) is pure linear algebra; the continuum of weights does all the work in (i), exactly as in one dimension. The classical regularity hypotheses are vestigial.

---

**Next:** `notes/reader-section4.md` places this theorem inside all of Section 4 (strict-minimum hypothesis, irrational weights alone, piecewise saturation, and the proof that the *rational*-weight version genuinely keeps the pathology).

---

## Part E — Extreme examples & common traps

The traps for Theorem 6 are mostly *linear-algebra hygiene* and *scope* errors. Each states the plausible false claim, why it tempts, and the kill.

> **Trap E1 — "$a$ is a linear functional on all of $V$."** *Tempting:* the conclusion "$G$ affine" sounds global. *Kill:* $a$ is forced only on $W=\operatorname{span}(C-C)$. If $C$ is lower-dimensional (e.g. a segment in $\mathbb{R}^2$), $G$ is never probed off $W$, so $a$ is *not* determined there — many functionals on $V$ restrict to the same forced $a$ on $W$ (Exercise X19).

> **Trap E2 — "$\hat A(\lambda v):=\lambda A(v)$ is obviously well defined."** *Tempting:* it is a formula. *Kill:* the *same* cone element can be written $\lambda v=\mu w$ with $v\ne w$; you must prove $\lambda A(v)=\mu A(w)$. That is the $t$-scaling device (Step iii). Skipping it is the most common gap in this proof.

> **Trap E3 — "$D$ is closed under addition, so additivity is immediate."** *Tempting:* $D$ is convex and contains $0$. *Kill:* a bounded convex $D$ is *not* closed under $+$: with $C=[0,1]$, $x_0=0$, $v=w=0.6\in D$ but $v+w=1.2\notin D$. This is exactly why Step (ii) carries the proviso "$v+w\in D$" and why the cone $D^{*}$ is needed (Exercise X8).

> **Trap E4 — "The cone of a disk is the disk."** *Tempting:* picturing the disk as "its own region." *Kill:* $D^{*}=\bigcup_{\lambda>0}\lambda D$ is all of $\mathbb{R}^2$ when $0$ is interior to $D$ (every vector lies in some scaled disk). The cone *opens up*; it is not the disk (Exercise X14).

> **Trap E5 — "Step (i), real homogeneity, surely needs continuity along the segment."** *Tempting:* it is a statement about all real $p$. *Kill:* it is precisely the one-dimensional Theorem 1, which needs **no** regularity. This is the entire point of the result; continuity is an output, not an input.

> **Trap E6 — "Theorem 6 needs finite dimension (or a norm/topology)."** *Tempting:* higher-dimensional convexity evokes $\mathbb{R}^n$ and geometry. *Kill:* the proof never uses dimension, a norm, or a topology — only the vector-space axioms and Step (i). It holds verbatim in infinite dimensions (Part 6.3, Exercise X20).

> **Trap E7 — "Convexity of $C$ is a convenience; the result holds for general $C$."** *Tempting:* the formula $a(x-x_0)+b$ makes sense on any set. *Kill:* without convexity the segment $[x_0,x]$ may leave $C$, so $(\star_C)$ does not even constrain $G$ there. Take $C=[0,1]\cup[2,3]\subset\mathbb{R}$: $G$ can be one affine map on $[0,1]$ and a *different* one on $[2,3]$ — non-affine globally (Exercise X21).

> **Trap E8 — "Rational weights would do; the reals are overkill."** *Tempting:* the gluing is algebraic. *Kill:* with only rational $p$, Step (i) gives merely $\mathbb{Q}$-homogeneity along each ray, and a Hamel monster survives on a line through $x_0$. The conclusion is then **false** (Exercise X23; cf. `reader-section4.md`, Proposition 7).

> **Trap E9 — "$b$ is a canonical constant."** *Tempting:* it appears in the formula like $a$. *Kill:* $b=G(x_0)$ depends on the chosen basepoint $x_0$; only the functional $a$ on $W$ is basepoint-independent (Exercise X17).

> **Trap E10 — "Additivity holds globally on $D$ once we have (ii)."** *Tempting:* (ii) looks like additivity. *Kill:* (ii) holds only when $v,w,v+w\in D$. Genuine, unrestricted additivity is achieved only after passing to $D^{*}$, which is closed under addition (Step iii). Conflating the two skips the heart of the proof.

> **Trap E11 — "$D^{*}$ might miss $0$, breaking the difference space."** *Tempting:* $D^{*}=\bigcup_{\lambda>0}\lambda D$ excludes $\lambda=0$. *Kill:* $0\in D$ (since $x_0\in C$), so $0=\lambda\cdot 0\in D^{*}$ already; and $\hat A(0)=0$. The difference-space step is safe (Exercise X11).

---

## Part X — Exercises

Twenty-four exercises, ★ (warm-up) to ★★★ (oral-exam level), tagged with the Part they train. **Attempt before Part S.**

### Group A — Vector-space, convex, affine foundations
- **X1 (★, Part 1.2).** Prove that a translate $C-x_0$ of a convex set is convex.
- **X2 (★, Part 4).** Prove (Shrink): if $0\in D$ and $D$ is convex, then $sD\subseteq D$ for all $s\in[0,1]$.
- **X3 (★, Part 1.3).** Prove in full the one-line check that an affine $G(x)=a(x-x_0)+b$ satisfies $(\star_C)$.
- **X4 (★★, Part 1.4).** Prove $\operatorname{span}(C-C)$ is the smallest subspace containing $C-C$, and explain why it is the direction space of the affine hull of $C$.
- **X5 (★★, Part 1.2).** Prove by induction that a convex combination $\sum_{i=1}^n p_i x_i$ ($p_i\ge0,\ \sum p_i=1$) of points of a convex $C$ lies in $C$.

### Group B — The relation (R) and Steps (i), (ii)
- **X6 (★★, Step 0).** Derive relation (R) from $(\star_C)$, justifying that the argument $pv+(1-p)w$ stays in $D$.
- **X7 (★★, Step i).** Prove Step (i), $A(pv)=pA(v)$ for all real $p\in[0,1]$, and explain why it is the *only* analytic step.
- **X8 (★★, Step ii).** Prove Step (ii). Then exhibit a convex $D$ and $v,w\in D$ with $v+w\notin D$, showing the proviso is genuinely needed.
- **X9 (★★, Steps i–ii).** Suppose $D$ happens to be a convex cone (closed under $+$ and positive scaling, $0\in D$). Show directly that $A$ is the restriction of a linear functional, *without* introducing $D^{*}$.

### Group C — The cone $D^{*}$
- **X10 (★★, Step iii).** Prove $D^{*}=\bigcup_{\lambda>0}\lambda D$ is closed under positive scaling and under addition.
- **X11 (★★★, Step iii).** Prove $\hat A(\lambda v)=\lambda A(v)$ is well defined (the $t$-scaling device). Pinpoint where (Shrink) and Step (i) are used.
- **X12 (★★, Step iii).** Prove $\hat A$ is additive and positively homogeneous on $D^{*}$.
- **X13 (★★, Step iii).** Show $D^{*}$ is the smallest convex cone containing $D$.
- **X14 (★★, Part 6).** Compute $D^{*}$ and $W$ for: (a) $C$ the closed unit disk in $\mathbb{R}^2$, $x_0=0$; (b) $C$ a triangle, $x_0$ a vertex; (c) $C$ a segment in $\mathbb{R}^2$. Note when $D^{*}$ is a wedge versus all of $W$.

### Group D — The subspace $W$ and the functional $a$
- **X15 (★★, Step iv).** Prove $W=D^{*}-D^{*}$ is a subspace and equals $\operatorname{span}(C-C)$.
- **X16 (★★★, Step iv).** Prove $a(v-w):=\hat A(v)-\hat A(w)$ is well defined and linear (additivity *and* full real homogeneity).
- **X17 (★★, Conclusion).** Prove the forced functional $a$ on $W$ is **independent of the basepoint** $x_0$, while $b=G(x_0)$ is not.

### Group E — Examples, scope, sharpness
- **X18 (★★, Part 6.1).** For the triangle with vertices $e_0,e_1,e_2$, derive $a$ and $G$ explicitly from the three vertex values; verify $(\star_C)$.
- **X19 (★★, Part 6.2 / Trap E1).** For $C$ a segment in $\mathbb{R}^2$, show two *different* linear functionals on $\mathbb{R}^2$ restrict to the *same* forced $a$ on $W$. Conclude $a$ is determined only on $W$.
- **X20 (★★, Part 6.3).** Let $V$ be the real polynomials and $C=\{f:\deg f\le 2,\ f(0)\in[0,1]\}$ (or any convex $C$). Exhibit a concrete $(\star_C)$-solution as $a(f-f_0)+b$ with $a$ linear (e.g. $a(f)=f'(0)$ or $a(f)=\int_0^1 f$).
- **X21 (★★, Trap E7).** Show Theorem 6 fails without convexity: build a non-affine $G$ on $C=[0,1]\cup[2,3]$ satisfying $(\star_C)$ wherever the convex combination lands in $C$.
- **X22 (★★★, Frugality).** Identify the minimal sub-collection of instances of $(\star_C)$ the proof actually consumes (the higher-dimensional analogue of Theorem 3's strict minimum).
- **X23 (★★★, Trap E8).** Show that if $(\star_C)$ is assumed only for rational $p$, the conclusion fails: construct a non-affine $G$ on a line $\subseteq C$ satisfying the rational-weight equation.
- **X24 (★★, Synthesis).** Audit the proof line by line and state every place dimension, a norm, completeness, or a topology *could* have entered — and confirm none did. Name the classical treatments that instead assume regularity, and say why they needed to.

---

## Part S — Full solutions

**S1.** If $x_1,x_2\in C-x_0$ then $x_1=c_1-x_0,\ x_2=c_2-x_0$ with $c_i\in C$. For $p\in[0,1]$, $px_1+(1-p)x_2=\big(pc_1+(1-p)c_2\big)-x_0$, and $pc_1+(1-p)c_2\in C$ by convexity, so the combination lies in $C-x_0$. $\blacksquare$

**S2.** $sv=s\,v+(1-s)\,0$ is a convex combination of $v\in D$ and $0\in D$; convexity gives $sv\in D$. $\blacksquare$

**S3.** $G(px_1+(1-p)x_2)=a\big(px_1+(1-p)x_2-x_0\big)+b$. Write $px_1+(1-p)x_2-x_0=p(x_1-x_0)+(1-p)(x_2-x_0)$ (uses $p+(1-p)=1$). Linearity of $a$: $=p\,a(x_1-x_0)+(1-p)a(x_2-x_0)$. Add $b=pb+(1-p)b$: $=p\,G(x_1)+(1-p)G(x_2)$. $\blacksquare$

**S4.** $\operatorname{span}(C-C)$ is a subspace containing $C-C$; any subspace containing $C-C$ contains all finite linear combinations of its elements, i.e. contains $\operatorname{span}(C-C)$ — so it is the smallest. The affine hull of $C$ is $x_0+\operatorname{span}(C-C)$ for any $x_0\in C$ (translating $C$ to the origin and spanning), so $\operatorname{span}(C-C)$ is its direction space. $\blacksquare$

**S5.** Induction on $n$. $n=1$ trivial; $n=2$ is the definition of convex. For the step, with $\sum_{i=1}^{n+1}p_i=1$ and (WLOG) $p_{n+1}<1$, write $\sum_{i=1}^{n+1}p_i x_i=(1-p_{n+1})\Big(\sum_{i=1}^{n}\tfrac{p_i}{1-p_{n+1}}x_i\Big)+p_{n+1}x_{n+1}$. The inner sum has nonnegative weights summing to $1$, so by the inductive hypothesis it lies in $C$; the outer expression is then a $2$-point convex combination of two points of $C$, hence in $C$. $\blacksquare$

**S6.** Apply $(\star_C)$ to $x_1=x_0+v,\ x_2=x_0+w\in C$ (since $v,w\in D=C-x_0$) at weight $p$: the argument $p x_1+(1-p)x_2=x_0+\big(pv+(1-p)w\big)$, and $pv+(1-p)w\in D$ by convexity of $D$, so $G$ is defined there. Subtract $G(x_0)$ from $p G(x_1)+(1-p)G(x_2)=G(x_0+pv+(1-p)w)$ and use $A=G(x_0+\cdot)-G(x_0)$ to get (R). $\blacksquare$

**S7.** Put $w=0$ in (R); $A(0)=0$ gives $A(pv)=pA(v)$. It is the *only* analytic step because it is the one-dimensional Theorem 1 along the segment $[x_0,x_0+v]$ — the single place the *continuum* of weights $p\in[0,1]$ is consumed. Steps (ii)–(iv) only ever use finitely many algebraic manipulations of values already pinned by (i). $\blacksquare$

**S8.** From (R) at $p=\tfrac12$: $A(\tfrac{v+w}{2})=\tfrac12(A(v)+A(w))$. If $v+w\in D$, apply (i) to the vector $v+w$ with $p=\tfrac12$: $A(\tfrac{v+w}{2})=\tfrac12 A(v+w)$. Equate: $A(v+w)=A(v)+A(w)$. *Proviso needed:* $C=[0,1]$, $x_0=0$, $D=[0,1]$; $v=w=0.6\in D$ but $v+w=1.2\notin D$, so $A(1.2)$ is not even defined on $D$ — additivity is unavailable without enlarging to $D^{*}$. $\blacksquare$

**S9.** If $D$ is a convex cone with $0\in D$: (i) gives $A(pv)=pA(v)$ for $p\in[0,1]$; for $\lambda>1$, $v\in D\Rightarrow \lambda v\in D$ (cone), and applying (i) to $\lambda v$ with $p=1/\lambda$ gives $A(v)=\tfrac1\lambda A(\lambda v)$, i.e. $A(\lambda v)=\lambda A(v)$ for all $\lambda>0$. Additivity: $v,w\in D\Rightarrow v+w\in D$ (cone), so (ii) applies unconditionally. Thus $A$ is additive and positively homogeneous on $D$; extend to $\operatorname{span}(D)$ by $a(v-w)=A(v)-A(w)$ as in Step (iv). $\blacksquare$

**S10.** Positive scaling: $u=\lambda v$, $c>0\Rightarrow cu=(c\lambda)v\in D^{*}$. Addition: $u_1=\lambda_1v_1,\ u_2=\lambda_2v_2$, $\lambda=\lambda_1+\lambda_2$; then $u_1+u_2=\lambda\big(\tfrac{\lambda_1}{\lambda}v_1+\tfrac{\lambda_2}{\lambda}v_2\big)$ with the bracket a convex combination of $v_1,v_2\in D$, hence in $D$, so $u_1+u_2\in\lambda D\subseteq D^{*}$. $\blacksquare$

**S11.** Suppose $\lambda v=\mu w$, $v,w\in D$, $\lambda,\mu>0$. Choose $t>0$ with $t\lambda\le1,\ t\mu\le1$. By (Shrink), $(t\lambda)v\in D$ and $(t\mu)w\in D$, and they are the *same* vector since $(t\lambda)v=t(\lambda v)=t(\mu w)=(t\mu)w$. Apply Step (i) (legal because $t\lambda,t\mu\in[0,1]$): $A((t\lambda)v)=t\lambda A(v)$ and $A((t\mu)w)=t\mu A(w)$. Left sides equal $\Rightarrow t\lambda A(v)=t\mu A(w)\Rightarrow \lambda A(v)=\mu A(w)$. So $\hat A(\lambda v)=\lambda A(v)$ is unambiguous. (Shrink lands the scaled vectors back in $D$; Step (i) evaluates $A$ there.) $\blacksquare$

**S12.** *Additivity:* with $u_i=\lambda_iv_i$, $\lambda=\lambda_1+\lambda_2$, $\tfrac1\lambda(u_1+u_2)=\tfrac{\lambda_1}\lambda v_1+\tfrac{\lambda_2}\lambda v_2\in D$, so $\hat A(u_1+u_2)=\lambda A\big(\tfrac{\lambda_1}\lambda v_1+\tfrac{\lambda_2}\lambda v_2\big)\overset{(R)}{=}\lambda\big(\tfrac{\lambda_1}\lambda A(v_1)+\tfrac{\lambda_2}\lambda A(v_2)\big)=\lambda_1A(v_1)+\lambda_2A(v_2)=\hat A(u_1)+\hat A(u_2)$. *Homogeneity:* $\hat A(cu)=\hat A((c\lambda)v)=c\lambda A(v)=c\hat A(u)$ for $c>0$. $\blacksquare$

**S13.** Any convex cone $K\supseteq D$ must contain $\lambda v$ for all $\lambda>0,\ v\in D$ (scaling), hence $K\supseteq D^{*}$. And $D^{*}$ is itself a convex cone containing $D$ (S10, with $D=1\cdot D\subseteq D^{*}$). So $D^{*}$ is the smallest. $\blacksquare$

**S14.** (a) $0$ interior to the disk $D$: every $u\in\mathbb{R}^2$ satisfies $u\in\lambda D$ for $\lambda$ large, so $D^{*}=\mathbb{R}^2=W$. (b) Vertex $x_0$: $D$ is the triangle shifted to have a vertex at $0$; $D^{*}$ is the **wedge** (convex cone) spanned by the two edge directions — a proper cone — yet $D^{*}-D^{*}=\mathbb{R}^2=W$. (c) Segment: $D$ is an interval on a line $\ell$ through $0$; $D^{*}=\ell$ (or a ray, if $0$ is an endpoint, whose difference space is still $\ell$), and $W=\ell$, one-dimensional. $\blacksquare$

**S15.** *Subspace:* $0=v-v$; $(v-w)+(v'-w')=(v+v')-(w+w')\in D^{*}-D^{*}$ (closure under $+$); $-(v-w)=w-v$; $c(v-w)=(cv)-(cw)$ for $c>0$, and negatives via negation; so $W$ is closed under all operations. *Equality:* $0\in D\subseteq D^{*}$ gives $D\subseteq W$, so $C-C=D-D\subseteq W$ and $\operatorname{span}(C-C)\subseteq W$. Conversely $v-w$ with $v=\lambda_1v_1,w=\lambda_2v_2$, $v_i\in D\subseteq C-C$, lies in $\operatorname{span}(C-C)$. $\blacksquare$

**S16.** *Well defined:* $v-w=v'-w'\Rightarrow v+w'=v'+w$; additivity of $\hat A$ (S12) gives $\hat A(v)+\hat A(w')=\hat A(v')+\hat A(w)$, i.e. $\hat A(v)-\hat A(w)=\hat A(v')-\hat A(w')$. *Additive:* immediate from additivity of $\hat A$. *Homogeneous:* for $c>0$, $a(c(v-w))=\hat A(cv)-\hat A(cw)=c\,a(v-w)$; $a(-(v-w))=\hat A(w)-\hat A(v)=-a(v-w)$ handles $c<0$, and $c=0$ gives $a(0)=0$. So $a$ is linear on $W$. $\blacksquare$

**S17.** From $G(x)=a(x-x_0)+G(x_0)$ with $a$ linear: for another basepoint $x_0'\in C$, $G(x)=a(x-x_0)+G(x_0)=a(x-x_0')+\big[a(x_0'-x_0)+G(x_0)\big]$, and $a(x_0'-x_0)+G(x_0)=G(x_0')$ (apply the formula at $x=x_0'$). So the *same* $a$ works with new constant $b'=G(x_0')$. Hence $a$ is basepoint-independent on $W$; $b$ changes with $x_0$. $\blacksquare$

**S18.** $x_0=e_0$, $D=C$, $A=G-G(e_0)$. Step (i) on edges: $A(p e_1)=pA(e_1)$, $A(pe_2)=pA(e_2)$. A point of the triangle is $s e_1+t e_2$ with $s,t\ge0,\ s+t\le1$; (R)/(ii) give $A(se_1+te_2)=sA(e_1)+tA(e_2)$ (write it as a convex combination of $0,e_1,e_2$ and use S5-style decomposition). So $a(s,t)=sA(e_1)+tA(e_2)$ and $G(s,t)=sA(e_1)+tA(e_2)+G(e_0)$, the affine plane through the three vertex values $G(e_0),G(e_1)=A(e_1)+G(e_0),G(e_2)=A(e_2)+G(e_0)$. It satisfies $(\star_C)$ by S3. $\blacksquare$

**S19.** Let $C=\{(s,0):s\in[0,1]\}$, so $W=\operatorname{span}(C-C)=\mathbb{R}\times\{0\}$. A solution is forced to be $G(s,0)=\alpha s+\beta$; the forced functional on $W$ is $a(s,0)=\alpha s$. Now $a_1(s,t)=\alpha s+\gamma t$ and $a_2(s,t)=\alpha s+\gamma' t$ ($\gamma\ne\gamma'$) are two different linear functionals on $\mathbb{R}^2$ that both restrict to $a$ on $W$ (since $t=0$ there). So the extension off $W$ is non-unique; only the restriction to $W$ is determined. $\blacksquare$

**S20.** Take $a(f)=\int_0^1 f$ (linear in $f$) and $f_0=0$, $b=0$: then $G(f)=\int_0^1 f$ satisfies $(\star_C)$ on any convex $C$ of polynomials because $a$ is linear (S3). Equally $a(f)=f'(0)$ works. The proof of Theorem 6 produces exactly such functionals; nothing used finite dimension. $\blacksquare$

**S21.** On $C=[0,1]\cup[2,3]$, a convex combination $px_1+(1-p)x_2$ lands in $C$ only when $x_1,x_2$ lie in the *same* sub-interval (cross combinations fall in the gap $(1,2)$ or beyond, outside $C$, where $(\star_C)$ imposes nothing). So $(\star_C)$ only forces $G$ affine on each sub-interval *separately*. Define $G=0$ on $[0,1]$ and $G(x)=x-2$ on $[2,3]$: it satisfies every in-$C$ instance of $(\star_C)$ but is not the restriction of a single affine map. Convexity is essential. $\blacksquare$

**S22.** Inspecting the proof: Step (i) uses $(\star_C)$ at pairs $(x_0+v,\ x_0)$ for every $v\in D$ and every $p\in[0,1]$ — i.e. *all segments emanating from the single basepoint $x_0$, at all real weights*. Step (ii) and the cone computations use $(\star_C)$ at $p=\tfrac12$ for pairs $(x_0+v,\ x_0+w)$. Nothing else is consumed. So the strict minimum is: "$(\star_C)$ along every ray from one fixed $x_0$ (all real $p$), plus midpoint instances between arbitrary pairs." This is the multidimensional analogue of Theorem 3. $\blacksquare$

**S23.** Restrict attention to a line $\ell=\{x_0+t e:t\in\mathbb{R}\}\cap C$ with $e\ne0$. With only rational $p$, Step (i) yields $A(qt\,e)=q\,A(te)$ for rational $q$ only — i.e. $t\mapsto A(te)$ is merely $\mathbb{Q}$-homogeneous (additive). Let $\phi\colon\mathbb{R}\to\mathbb{R}$ be a non-$\mathbb{R}$-linear additive function (a Hamel monster; see `reader-section4.md`, Part 6) and set $A(te)=\phi(t)$ along $\ell$. Then $G(x_0+te)=\phi(t)+G(x_0)$ satisfies the rational-weight $(\star_C)$ on $\ell$ but is non-affine. Hence rational weights do **not** suffice. $\blacksquare$

**S24.** Walk the proof: definitions (vector-space axioms only); (Shrink) (convexity); (R) (convexity, the hypothesis); Step (i) (the 1-D substitution — no regularity); Steps (ii)–(iv) (finite algebra: convex-combination identities, the $t$-scaling well-definedness, difference-space linearity). **At no point** are dimension, a norm, completeness, limits, continuity, or measurability invoked. The classical treatments (Kuczma's monograph; Aczél–Dhombres) instead assume continuity/measurability because they work with the *rational*-coefficient equation, where Step (i) yields only $\mathbb{Q}$-homogeneity and a regularity hypothesis is needed to exclude the Hamel pathology (S23). $\blacksquare$

---

## Part D — Routines, recitations, and drills

### D.1 Speed drills (recite against a clock)
1. **State Theorem 6 (target 20 s):** convex $C$ in any real vector space; $(\star_C)$ at all real $p$ $\Rightarrow$ $G(x)=a(x-x_0)+b$, $a$ linear on $W=\operatorname{span}(C-C)$.
2. **The proof spine (target 30 s):** shift to $A$ on $D$; relation (R); (i) real homogeneity; (ii) additivity-where-defined; (iii) cone $D^{*}$, define $\hat A$; (iv) difference space $W$, define $a$.
3. **The one analytic line (target 10 s):** "Only Step (i) uses the continuum — it is the 1-D theorem along a segment; the rest is linear algebra."
4. **The well-definedness device (target 25 s):** to show $\hat A(\lambda v)=\lambda A(v)$ unambiguous, scale by small $t$ into $D$ and apply Step (i) twice.

### D.2 Blank-page reconstruction ladder (no notes)
- **Rung 1:** Definitions + the affine$\Rightarrow$solution check.
- **Rung 2:** Shift to $A$; prove (Shrink) and derive (R).
- **Rung 3:** Prove (i) and (ii); state where the proviso bites.
- **Rung 4:** Build $D^{*}$; prove it is a convex cone; define $\hat A$ and prove well-defined + additive + positively homogeneous.
- **Rung 5:** Build $W=D^{*}-D^{*}=\operatorname{span}(C-C)$; define $a$; prove linear; conclude.
Climb twice cold and you own the proof.

### D.3 Recitation script (mock oral — answer aloud, then check)
- *"Where does the continuum of weights act?"* → Step (i) only.
- *"Why is $a$ on $W$, not $V$?"* → $G$ is probed only in directions within $C$; Trap E1 / X19.
- *"Why must $C$ be convex?"* → else segments leave $C$ and $(\star_C)$ does not constrain; X21.
- *"Why introduce $D^{*}$ at all?"* → $D$ is not closed under $+$; additivity needs a cone; Trap E3 / X8.
- *"How is $\hat A$ shown well defined?"* → $t$-scaling device; X11.
- *"Does the proof use finite dimension or a norm?"* → no; X24, Part 6.3.
- *"What if only rational weights are assumed?"* → conclusion fails; Hamel monster on a line; X23.
- *"Is $b$ canonical?"* → no; $b=G(x_0)$ depends on basepoint; only $a$ is forced; X17.

### D.4 Maintenance routine
- **Pass 1:** D.1 drills ×3; X1–X9.
- **Pass 2:** D.2 rungs 1–3; X10–X17.
- **Pass 3:** D.2 rungs 4–5; X18–X24; all of Part E aloud.
- **Pass 4:** full mock oral (D.3); redo any exercise you had to peek at.
Mastery check: deliver the five-step spine cold, justify "only Step (i) is analytic," and field every trap in Part E without hesitation.
