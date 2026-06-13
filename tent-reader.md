# The Tent at the Crossroads
### A self-contained reader on the continuous-coefficient Jensen equation, the Reid–Williamson tent, and the load-bearing/vestigial diagnostic

*Written for a first-year CS graduate student who has worked through, on their own, a first course in algebra (vectors, linear maps, bases) and a first course in real analysis (limits, continuity, the real line). Nothing beyond that is assumed. Everything else is built here.*

---

## How to read this

Each chapter has three layers.

**The spine** is the running argument. Read it straight through.

**Derive Drills** (marked ▶) are short exercises you should do *with pencil on paper before reading on*. They are not optional decoration; the whole point of this subject is that the proofs are short enough to own completely, and you only own them by re-deriving them. Full solutions are in Appendix S.

**Recitations** (Chapter 10) are longer, TA-section-style walkthroughs of synthesis problems that cut across chapters. Read them after you have done the drills.

A word on what we are chasing. There is a one-line theorem — call it the *endpoint substitution* — that says a certain functional equation forces a function to be a straight line, with no fine-print hypotheses at all. Sitting right next to it is a century of hard classical analysis (Cauchy, Hamel, the Polish school) proving that an *almost identical* equation needs fine print or it falls apart. The gap between these two is razor-thin, and a specific concrete object — the **tent function** from statistical decision theory — lives exactly in that gap. The tent is where the abstract equation meets a real machine-learning quantity (the Bayes risk of a binary classifier), and it is where you can watch a hypothesis be *essential* in one breath and *useless* in the next. That is the destination.

## Map of the argument

The reader has two halves that meet at the tent (Ch. 7) and pay off at the diagnostic (Ch. 9).

```
            THE EQUATION SIDE                         THE TENT SIDE
   ┌─────────────────────────────────┐   ┌──────────────────────────────────┐
   │ Ch.1  convex / concave / affine  │   │ Ch.5  atomless measures           │
   │ Ch.2  Jensen; the equation (★)   │   │        every mass p is realized   │
   │ Ch.3  one-line proof; regularity │   │ Ch.6  binary experiments;         │
   │        is a CONCLUSION            │   │        Bayes risk; derive the tent│
   │ Ch.4  why rationals fail:         │   │ Ch.8  every risk = pile of tents; │
   │        Cauchy, Hamel, the monster │   │        mixing weight w = −L″      │
   │        lives at irrational p      │   │                                   │
   └────────────────┬────────────────┘   └────────────────┬─────────────────┘
                    └──────────► Ch.7  THE TENT, two ways ◄┘
                                  content  +  rigidity
                                          │
                                          ▼
                       Ch.9  LOAD-BEARING vs VESTIGIAL
                  four sources · the zeroth gate · the seams
                  in Reid–Williamson · the mirror · coin vs atomless
                                          │
                          ┌───────────────┼───────────────┐
                          ▼               ▼               ▼
                   Ch.10 recitations  Ch.11 impact   Appendix S
                   (drill the proc.)  (why it matters) (all solutions)
```

The single sentence the whole structure exists to earn: *whether a regularity hypothesis is load-bearing or vestigial is decided not by the function but by whether the equation's mixing weights form a continuum.*

---

## Notation, all in one place

| Symbol | Meaning | First used |
|---|---|---|
| $I$ | a closed interval of real numbers, e.g. $[0,M]$ or $[0,1]$ | Ch. 1 |
| $\mathbb{R}, \mathbb{Q}, \mathbb{Z}$ | reals, rationals, integers | Ch. 1 |
| $G, f$ | a real-valued function on $I$; the unknown of our equation | Ch. 1 |
| affine | $G(x)=ax+b$ for constants $a,b$ — a straight line | Ch. 1 |
| $\xi, \eta$ | a random variable; later, a posterior probability | Ch. 2 |
| $\mathbb{E}[\cdot]$ | expectation (probabilistic average) | Ch. 2 |
| $p$ | a mixing weight / probability in $[0,1]$ | Ch. 2 |
| $(\star)$ | the continuous-coefficient Jensen equation | Ch. 2 |
| $(J_2), (J_\mathbb{Q})$ | its midpoint and rational-weight cousins | Ch. 4 |
| $\llbracket P \rrbracket$ | Iverson bracket: $1$ if $P$ is true, else $0$ | Ch. 6 |
| $Y$ | a binary outcome, $Y\in\{0,1\}$ | Ch. 6 |
| $\ell(a,y)$ | a loss: penalty for action $a$ when truth is $y$ | Ch. 6 |
| $L(\eta)$ | the (pointwise) Bayes risk at posterior $\eta$ — concave | Ch. 6 |
| $\ell_c$ | the cost-weighted loss with false-positive cost $c$ | Ch. 6 |
| $L_c(\eta)$ | the Bayes risk of $\ell_c$ — a **tent** | Ch. 6 |
| $T_\theta$ | the apexed tent in the manuscript's normalization | Ch. 7 |
| $w(c)$ | a mixing weight $=-L''(c)$ | Ch. 8 |
| $\mu$ | a probability measure on a space $\Omega$ | Ch. 5 |

A convention we keep throughout: **the same letter $G$ always denotes "the function our equation is talking about."** Sometimes we will *additionally* know $G$ is a Bayes risk (hence concave); sometimes we will know nothing about it. The theorems are careful to say which.

---

# Chapter 0. The puzzle, stated before we can solve it

Here is the whole subject in two sentences you will not fully understand yet. By the end you will.

> **There is a functional equation that pins a function to a straight line using nothing but the equation itself — no continuity, no measurability, no boundedness assumed.** And there is an almost-identical equation, differing only in whether a certain dial is allowed to be *every* real number or only the *rational* numbers, for which the same conclusion is false unless you bolt on one of five classical "tameness" hypotheses.

The five tameness hypotheses are:

1. **Continuity** — the graph has no jumps.
2. **Measurability** — the function is not set-theoretically monstrous.
3. **Monotonicity** — it only goes up, or only goes down.
4. **Boundedness on a fat set** — it stays finite on some set of positive size.
5. **Boundedness everywhere** — it stays finite on the whole interval.

The strange fact this reader is built around: *these same five hypotheses are sometimes absolutely indispensable and sometimes completely useless, and the two situations look almost identical on the page.* Worse, the boundary between "indispensable" and "useless" is not about the function — it is about **where the mixing weight $p$ is allowed to live.** Rational weights: useless conclusion, need the hypotheses. A genuine continuum of real weights: the hypotheses evaporate.

We will meet a concrete object — the **tent** $\min(u,\,1-u)$ — that is at once (a) a real quantity in machine learning (the error floor of a binary classifier), (b) the unique shape a certain "exactness" condition can produce, and (c) the place where you can stand and watch a hypothesis flip from load-bearing to vestigial. Reid and Williamson's 2011 monograph *Information, Divergence and Risk for Binary Experiments* derived the tent from the decision-theory side and built a whole calculus on it. Their derivation is correct. What it leaves implicit — and what the continuous-coefficient viewpoint makes explicit — is the seam between the part of their setup that is doing real work and the part that is free for the taking. Finding that seam is Chapter 9, the payoff.

Let us build the toolbox.

---

# Chapter 1. Functions, chords, and the meaning of "affine"

## 1.1 The objects

A **function** $G$ on an interval $I$ is a rule assigning to each number $x\in I$ exactly one real number $G(x)$. Picture its **graph**: the set of points $(x, G(x))$ in the plane. Everything in this reader is a statement about the *shape* of that graph.

Three numbers $x_1, x_2 \in I$ and a weight $p \in [0,1]$ produce a fourth number,
$$
p\,x_1 + (1-p)\,x_2,
$$
called a **convex combination** of $x_1$ and $x_2$. As $p$ slides from $0$ to $1$, this point slides along the segment from $x_2$ (at $p=0$) to $x_1$ (at $p=1$). Because $I$ is an interval, this point never leaves $I$. That last fact — intervals are closed under convex combination — is quietly the engine of the entire theory, so say it out loud once: *you can mix any two points of an interval in any proportion and stay inside.*

## 1.2 Affine functions: the straight lines

$G$ is **affine** if there are constants $a, b$ with
$$
G(x) = a\,x + b \qquad \text{for all } x \in I.
$$
The graph is a straight line; $a$ is the slope, $b$ the height at $x=0$. Affine functions have one magic property, and it is the property the whole reader is about:

> **An affine $G$ commutes with mixing.** For any $x_1, x_2$ and any $p$,
> $$
> G\big(p\,x_1+(1-p)\,x_2\big) = p\,G(x_1) + (1-p)\,G(x_2).
> $$

Check it: the left side is $a(px_1+(1-p)x_2)+b$. The right side is $p(ax_1+b)+(1-p)(ax_2+b) = a(px_1+(1-p)x_2) + b\,(p + 1-p) = a(px_1+(1-p)x_2)+b$. Same thing. The two sides are *forced* equal by the algebra of $ax+b$, for every choice of inputs. Hold onto this: it is the "easy direction" of our main theorem, and it is just bookkeeping.

## 1.3 Convex and concave: when mixing bends the value

Most functions are *not* straight. When you mix the inputs and ask what happens to the outputs, the value bends one way or the other.

$G$ is **convex** if its graph never rises above any of its chords:
$$
G\big(p\,x_1+(1-p)\,x_2\big) \;\le\; p\,G(x_1)+(1-p)\,G(x_2).
$$
(The right side is the height of the straight chord connecting $(x_1,G(x_1))$ and $(x_2,G(x_2))$, read off at the mixed point. "Below the chord" = convex = bowl-shaped, like $x^2$.)

$G$ is **concave** if the inequality flips — the graph never dips below its chords:
$$
G\big(p\,x_1+(1-p)\,x_2\big) \;\ge\; p\,G(x_1)+(1-p)\,G(x_2),
$$
dome-shaped, like $-x^2$ or $\sqrt{x}$. Equivalently, $G$ is concave exactly when $-G$ is convex.

Now stare at the three displayed inequalities — affine (equality), convex ($\le$), concave ($\ge$). They are the *same equation with three different relation symbols.* And affine is the razor's edge between convex and concave: a function that is **both convex and concave** satisfies the equation with $\le$ and $\ge$ simultaneously, i.e. with $=$. We will prove shortly that "both" forces "straight line." This is the first appearance of the reader's central drama: *equality in a mixing inequality is a rigidity condition.*

▶ **Drill 1.1.** Prove directly from the definition that $G(x)=x^2$ is convex on $\mathbb{R}$. (Hint: show $p\,x_1^2+(1-p)x_2^2 - (px_1+(1-p)x_2)^2 = p(1-p)(x_1-x_2)^2 \ge 0$.)

▶ **Drill 1.2.** Show that if $G$ is affine then $G$ is simultaneously convex and concave. (You essentially did this in §1.2 — state it as a clean implication.)

▶ **Drill 1.3.** Suppose $G$ is convex and $H(x) = G(x) + cx + d$ for constants $c,d$. Show $H$ is convex. (Moral: adding a straight line to a function does not change its convexity. This "affine-invariance" recurs everywhere.)

---

# Chapter 2. Jensen's inequality and the equation that forces equality

## 2.1 The simplest random variable

Forget general probability. We only ever need a coin. Fix two values $u_1, u_2 \in I$ and a bias $p \in [0,1]$. Let $\xi$ be the random variable that
$$
\text{equals } u_1 \text{ with probability } p, \qquad \text{equals } u_2 \text{ with probability } 1-p.
$$
Its **expectation** (average) is
$$
\mathbb{E}[\xi] = p\,u_1 + (1-p)\,u_2.
$$
That is just "value times probability, summed." And if we first apply $G$ and *then* average,
$$
\mathbb{E}[G(\xi)] = p\,G(u_1) + (1-p)\,G(u_2).
$$
So the two sides of every inequality in Chapter 1 are exactly $\mathbb{E}[G(\xi)]$ (the chord side) and $G(\mathbb{E}[\xi])$ (the curve side). The convexity definitions are *literally* statements comparing "average then transform" to "transform then average."

## 2.2 Jensen's inequality

Restated in this language, for **concave** $G$ and any two-point $\xi$:
$$
\boxed{\;\mathbb{E}[G(\xi)] \;\le\; G(\mathbb{E}[\xi]).\;}
$$
(Concave: the average of the values sits below the value of the average. For convex, flip.) This is **Jensen's inequality**. It is one of the most-used facts in all of applied mathematics — every "the average loss is at least the loss of the average" argument is Jensen.

## 2.3 The question of the reader

Jensen is an *inequality*. Our entire subject is the question:

> **When is it an equality? For which $G$ does $\mathbb{E}[G(\xi)] = G(\mathbb{E}[\xi])$ hold for *every* two-point $\xi$?**

Written out, "for every two-point $\xi$" means "for all $u_1, u_2 \in I$ and all $p \in [0,1]$." So the equality condition is the functional equation
$$
p\,G(u_1) + (1-p)\,G(u_2) \;=\; G\big(p\,u_1 + (1-p)\,u_2\big) \qquad (u_1, u_2 \in I,\; p \in [0,1]). \tag{$\star$}
$$
This is the **continuous-coefficient Jensen equation**. "Continuous-coefficient" because the coefficient $p$ ranges over the *continuum* $[0,1]$ — every real number in the unit interval, not just nice ones.

You already know one family of solutions: by §1.2, **every affine $G$ solves $(\star)$.** The content of the next chapter is the converse — and the shock is how cheaply it comes.

▶ **Drill 2.1.** A friend claims $G(x)=x^2$ solves $(\star)$ on $[0,1]$. Disprove it with a single explicit choice of $u_1, u_2, p$. (You are exhibiting Jensen's inequality being *strict*.)

▶ **Drill 2.2.** Show that if $G$ solves $(\star)$, then so does $\tilde G(x) = G(x) + cx + d$ for any constants $c,d$. (Same affine-invariance as Drill 1.3, now for the equation. This will let us "normalize" $G$ later without loss.)

▶ **Drill 2.3.** Convince yourself in words why "$(\star)$ for all two-point laws" is genuinely the equality case of Jensen, and not something weaker. (One sentence: every two-point law is some $(u_1,u_2,p)$, and conversely.)

---

# Chapter 3. The one-line proof

## 3.1 The theorem

> **Theorem (Endpoint substitution).** Let $M>0$ and let $G\colon[0,M]\to\mathbb{R}$ satisfy $(\star)$. Then $G$ is affine:
> $$
> G(v) = G(0) + \frac{G(M)-G(0)}{M}\,v, \qquad v\in[0,M].
> $$

Read the hypotheses again, slowly, because the *absence* of hypotheses is the headline. We assume $G$ solves the equation. We assume **nothing else**. Not that $G$ is continuous. Not that it is measurable, monotone, or bounded. Just the equation.

## 3.2 The proof

Fix any target point $v \in [0,M]$. We want to learn $G(v)$. Make this single substitution into $(\star)$:
$$
u_1 := M, \qquad u_2 := 0, \qquad p := \frac{v}{M}.
$$
First check the substitution is legal: $u_1 = M \in [0,M]$ ✓, $u_2 = 0 \in [0,M]$ ✓, and $p = v/M \in [0,1]$ because $0 \le v \le M$ ✓. Now $(\star)$ reads
$$
\underbrace{\frac{v}{M}\,G(M) + \Big(1-\frac{v}{M}\Big) G(0)}_{p\,G(u_1)+(1-p)\,G(u_2)}
\;=\;
G\Big(\underbrace{\tfrac{v}{M}\cdot M + (1-\tfrac{v}{M})\cdot 0}_{p\,u_1 + (1-p)\,u_2}\Big)
\;=\; G(v).
$$
The mixed point collapsed to exactly $v$. Rearranging the left side,
$$
G(v) = G(0) + \frac{v}{M}\big(G(M)-G(0)\big),
$$
which is the claimed affine formula. Done. $\;\blacksquare$

That is the whole thing. One substitution. The point $v$ was arbitrary, so the formula holds at every $v$, and a function equal to a fixed straight line at every point *is* that straight line.

## 3.3 The order of inference (the conceptual heart)

Now the corollary that flips your intuition.

> **Corollary.** Any $G$ satisfying $(\star)$ on $[0,M]$ is automatically continuous, monotone, Lipschitz, bounded, and measurable.

*Proof.* By the Theorem, $G(v)=av+b$ with $a = (G(M)-G(0))/M$. A straight line on a bounded interval is continuous (no jumps), monotone (up if $a\ge 0$, down if $a\le 0$), Lipschitz with constant $|a|$ (it never changes faster than slope $a$), bounded (it runs between its two endpoint values), and measurable (continuous functions are). $\;\blacksquare$

Here is the reversal. For the equation $(\star)$, the five tameness hypotheses of Chapter 0 are **not inputs you must supply** — they are **outputs you get for free.** Continuity is a *conclusion*. The equation manufactures its own regularity from the inside. We will call such a hypothesis **vestigial** with respect to $(\star)$: classically you might reach for it, but the equation already implies it, so assuming it adds nothing.

Contrast this with what is coming. For the *cousin* equation $(J_2)$ — same equation but with $p$ frozen at $\tfrac12$ — none of this works, and a tameness hypothesis is genuinely required. Understanding why is the next chapter, and it is the subtle one.

▶ **Drill 3.1.** Run the endpoint substitution on the interval $[2, 7]$ (so $M$ is not the right endpoint and the left endpoint is not $0$). State the change of variables that reduces this to the $[0,M]$ case. (Hint: $v \mapsto (v-2)/(7-2)$ sends $[2,7]$ to $[0,1]$.)

▶ **Drill 3.2.** The Theorem used $(\star)$ at *every* $(u_1,u_2,p)$, but the proof only touched the configuration $u_1=M, u_2=0$. State and prove the **strict-minimum** version: if $p\,G(M)+(1-p)G(0) = G(pM)$ holds for all $p\in[0,1]$ — and nothing else is assumed — then $G$ is affine. (This is one line; you have already written it.)

▶ **Drill 3.3 (subtle).** The strict-minimum version of Drill 3.2 is *in principle weaker* than full $(\star)$: it only constrains $G$ along combinations of the two endpoints. Yet its conclusion (affineness) is the same. Resolve the apparent tension. (Answer-shape: once you know $G$ is affine, full $(\star)$ holds as a *consequence*; the weaker hypothesis was already enough to force the strong conclusion, after which the strong hypothesis comes for free.)

---

# Chapter 4. Why rational weights are not enough: Cauchy, Hamel, and the pathology

This chapter is where the subject earns its depth. We show that if you weaken $(\star)$ by only allowing *rational* mixing weights, the one-line proof collapses and monstrous non-affine solutions reappear. Then we locate *exactly* where the monster hides — and see that the continuum of weights in $(\star)$ reaches into that hiding place.

## 4.1 The midpoint equation and Cauchy's equation

Freeze $p = \tfrac12$ in $(\star)$. You get the **midpoint (discrete-coefficient) Jensen equation**:
$$
G\Big(\frac{u_1+u_2}{2}\Big) = \frac{G(u_1)+G(u_2)}{2}. \tag{$J_2$}
$$
Set $f(x) := G(x) - G(0)$ to slide the graph so it passes through the origin ($f(0)=0$). A short computation (do it) turns $(J_2)$ for $G$ into **Cauchy's functional equation** for $f$:
$$
f(x+y) = f(x) + f(y). \tag{Cauchy}
$$
Cauchy's equation is the most famous functional equation in mathematics, and its solution set is a rabbit hole.

## 4.2 What Cauchy gives you for free: $\mathbb{Q}$-homogeneity

From additivity alone we can extract a great deal, but — crucially — only over the *rationals*. Step by step:

- **$f(0)=0$:** put $x=y=0$, so $f(0)=2f(0)$, hence $f(0)=0$.
- **$f(nx)=nf(x)$ for positive integers $n$:** induction. $f(2x)=f(x+x)=2f(x)$; if $f(nx)=nf(x)$ then $f((n{+}1)x)=f(nx{+}x)=nf(x)+f(x)=(n{+}1)f(x)$.
- **$f(-x)=-f(x)$:** $0=f(0)=f(x+(-x))=f(x)+f(-x)$.
- **$f(x/n)=f(x)/n$:** from $f(x)=f(n\cdot \tfrac{x}{n})=n f(\tfrac{x}{n})$.
- **Combine:** for any rational $q=m/n$, $\;f(qx)=q\,f(x)$.

So every additive $f$ is **$\mathbb{Q}$-homogeneous**: it scales correctly by rational factors. And $\mathbb{Q}$-homogeneity plus additivity is *exactly* the rational-weight Jensen equation
$$
p\,G(u_1)+(1-p)\,G(u_2) = G\big(p\,u_1+(1-p)\,u_2\big), \qquad p \in [0,1]\cap \mathbb{Q}. \tag{$J_\mathbb{Q}$}
$$
**Conclusion so far:** $(J_2)$, $(J_\mathbb{Q})$, and Cauchy's equation all have the *same solution set* (up to the additive constant $G(0)$). They stand or fall together.

## 4.3 The catch: $\mathbb{Q}$-homogeneity is not $\mathbb{R}$-homogeneity

Here is the entire problem in one line. Additivity hands you scaling by *rational* factors. It does **not** hand you scaling by *irrational* factors. An additive $f$ could perfectly well have
$$
f(\sqrt 2 \cdot x) \neq \sqrt 2 \cdot f(x)
$$
for some $x$. If $f$ scaled correctly by *every* real factor (i.e. were $\mathbb{R}$-homogeneous), then $f(x)=f(x\cdot 1)=x\,f(1)$ would be a straight line through the origin — affine, tame, done. The pathology is precisely the **failure of $\mathbb{R}$-homogeneity at irrational scales.** Remember this sentence; it is the key to the whole reader.

## 4.4 Building the monster: a Hamel basis

Does a non-$\mathbb{R}$-homogeneous additive $f$ actually exist? Yes — but constructing one requires viewing $\mathbb{R}$ through algebra.

Recall from your linear-algebra course: a **basis** of a vector space is a set of vectors such that every vector is a unique finite combination of them. Now make the unusual move of treating $\mathbb{R}$ itself as a vector space, but with **scalars drawn only from $\mathbb{Q}$.** A basis of $\mathbb{R}$ over $\mathbb{Q}$ is called a **Hamel basis** $H$: every real number $x$ is a *unique* finite combination
$$
x = q_1 h_1 + q_2 h_2 + \dots + q_k h_k, \qquad q_i \in \mathbb{Q},\; h_i \in H.
$$
Such a basis exists — this is a consequence of the **axiom of choice** (via Zorn's lemma). It cannot be written down explicitly; its existence is non-constructive. (This non-constructiveness is not a footnote: in Solovay's model of set theory, where the axiom of choice is weakened, *every* solution of Cauchy's equation is affine. The monster only exists because we admit choice.)

Now define $f$ by hand. Pick two distinct basis elements, say $h_1$ and $h_2$, and decree
$$
f(h_1) = 0, \qquad f(h_2) = 1, \qquad f(h)=\text{anything you like for other }h\in H,
$$
then **extend $\mathbb{Q}$-linearly**: $f(q_1 h_1 + \dots + q_k h_k) = q_1 f(h_1) + \dots + q_k f(h_k)$. This $f$ is additive by construction (it respects the unique-combination structure). But it is **not** $\mathbb{R}$-homogeneous: $h_1$ and $h_2$ are reals, and $f(h_2) = 1 \ne 0 = $ "$h_2$ times $f(h_1)$"-type scaling cannot be made consistent across all real factors. This $f$ is the monster.

## 4.5 How monstrous? The graph is *dense in the plane*

Let us see the pathology concretely. Take a Hamel basis containing $1$ and some irrational element $h\in(0,1)$ (one can always arrange this — see Drill 4.3). Define $\ell$ by $\ell(1)=0$, $\ell(h)=1$, extended $\mathbb{Q}$-linearly. Then for every rational $r$ and every rational $q$,
$$
\ell(q + r h) = q\,\ell(1) + r\,\ell(h) = r.
$$
The set $\{\,q + rh : q\in\mathbb{Q}\,\}$ is, for fixed $r$, a shifted copy of the rationals — **dense** in the real line. So $\ell$ takes the value $r$ on a dense set, *for every rational $r$.* That means the graph of $\ell$ comes arbitrarily close to every point $(x, y)$ in the plane: it is **dense in $\mathbb{R}^2$.** Such a function is nowhere continuous, unbounded on every subinterval, and non-measurable. It violates all five tameness hypotheses as hard as possible — and yet it solves $(J_2)$ and $(J_\mathbb{Q})$.

This is why $(J_2) \Rightarrow$ affine is **false** without a hypothesis. Any *one* of the five hypotheses, bolted on, kills the monster (the classical theorems of Cauchy, Sierpiński, Darboux, Kormes, Ostrowski, Kestelman each do this). Without one, the monster lives.

## 4.6 The mechanism: the monster lives at irrational weights

Now the punchline that ties Chapter 4 back to Chapter 3. Where, precisely, does the monster fail to satisfy $(\star)$?

Look at $(\star)$ at the endpoint configuration $u_1 = M$, $u_2 = 0$, for a monster $G$ (so $G(0)=0$):
$$
p\,G(M) = G(p\,M). \tag{$\star_0$}
$$
But $(\star_0)$ says exactly "$G$ scales by the factor $p$" — it is the $\mathbb{R}$-homogeneity assertion at the pair $(M, p)$. By §4.2 the monster satisfies this for every **rational** $p$. By §4.3 the monster *fails* it at some **irrational** $p$ — that failure is the very definition of being a monster.

So:

> **The Hamel monster passes every rational-weight test $(J_\mathbb{Q})$ and fails at the irrational weights — exactly the weights that $(\star)$ tests but $(J_\mathbb{Q})$ does not.**

The classical analysts, from Cauchy in 1821 to Kestelman in 1947, were in effect searching for a *tameness hypothesis to substitute for the missing irrational-weight constraint*, because the rational equation alone cannot exclude the monster. The continuous-coefficient equation $(\star)$ doesn't need a substitute: it *has* the irrational-weight constraint, applies it, and the monster dies on contact. That is why the one-line proof of Chapter 3 needs no fine print, and the century of analysis around $(J_2)$ does.

▶ **Drill 4.1.** Carry out the algebra promised in §4.1: with $f(x)=G(x)-G(0)$, show $(J_2)$ for $G$ is equivalent to $f\big(\tfrac{x+y}{2}\big)=\tfrac{f(x)+f(y)}{2}$, and then (using $f(0)=0$) to Cauchy additivity $f(x+y)=f(x)+f(y)$. (Hint for the last step: set one argument to $0$ cleverly, or use $f(x+y)=2f(\tfrac{x+y}{2})$.)

▶ **Drill 4.2.** Write out the induction for $f(nx)=nf(x)$ in full, then deduce $f(qx)=qf(x)$ for all $q\in\mathbb{Q}$. (You are proving $\mathbb{Q}$-homogeneity from scratch.)

▶ **Drill 4.3 (the domain subtlety).** A Hamel basis has the same cardinality as $\mathbb{R}$, but that alone does **not** guarantee a basis element lands in $(0,1)$ — you could rescale every element into $[1,2]$ and miss $(0,1)$ entirely. Show how to fix a basis so that it contains $1$ and an irrational element of $(0,1)$. (Hint: take any irrational basis element $h'$; rational multiples of $h'$ are dense, so some nonzero rational multiple $h=qh'$ lands in $(0,1)$; replacing $h'$ by $h$ keeps the basis a basis. This is the move the manuscript flags as easy to overlook.)

▶ **Drill 4.4 (capstone of the chapter).** Explain in three sentences, to an imagined classmate, why the *same* function can solve $(J_\mathbb{Q})$ but not $(\star)$, and why the one-line proof of Chapter 3 is therefore not "too good to be true." Use the phrase "the monster lives at irrational weights."

---

# Chapter 5. Where the continuum of weights actually comes from: atomless measures

Chapter 4 told us the magic of $(\star)$ is that it tests *every* real weight $p$, irrationals included. But in an application, who hands you every real weight? You do not get to choose $p$ freely; $p$ has to *arise* from the structure of the problem. This chapter identifies the structural source: an **atomless probability space**. It is the hinge between the abstract equation and the concrete tent.

## 5.1 Probability spaces in one page

A **probability space** is a triple $(\Omega, \mathcal{F}, \mu)$:

- $\Omega$ is a set of outcomes (the "sample space").
- $\mathcal{F}$ is a collection of subsets of $\Omega$ called **events** (closed under complement and countable union — the technical "$\sigma$-algebra" condition; you may take it on faith).
- $\mu$ assigns each event $A$ a number $\mu(A)\in[0,1]$, its probability, with $\mu(\Omega)=1$ and probabilities of disjoint events adding.

Example to keep in mind: $\Omega=[0,1]$, events are the reasonable subsets, $\mu(A)=$ the *length* of $A$. Then $\mu([0,1])=1$, $\mu([0,\tfrac13])=\tfrac13$, and so on. This is the **uniform** (Lebesgue) probability on $[0,1]$.

## 5.2 Atoms versus atomless

An **atom** is an event $A$ with $\mu(A)>0$ that cannot be split: every sub-event $B\subseteq A$ has either $\mu(B)=0$ or $\mu(B)=\mu(A)$. A single coin flip lives on an atomic space — the event "heads" has probability $\tfrac12$ and cannot be cut into two smaller positive-probability pieces inside itself.

A space is **atomless** (or non-atomic) if it has *no* atoms: every positive-probability event can be split into two strictly smaller ones. The uniform probability on $[0,1]$ is atomless: any interval of positive length splits into two shorter intervals.

## 5.3 The fact we need: atomless measures realize every mass

> **Theorem (Sierpiński's intermediate-value property for atomless measures).** If $(\Omega,\mathcal{F},\mu)$ is atomless, then for **every** target $p\in[0,1]$ there exists an event $A\in\mathcal{F}$ with $\mu(A)=p$.

In words: an atomless measure does not skip any value. You want an event of probability exactly $1/\sqrt{2}$? It exists. Exactly $\pi - 3$? It exists. *Every* real number in $[0,1]$, irrationals included, is the probability of some event. (The vector-valued descendant of this is Lyapunov's convexity theorem, which you may meet later; you do not need it here.)

The proof idea is exactly the bisection you would guess: start splitting, track the running mass, and a continuity argument lands you on any target. We take the statement as given.

## 5.4 Why this is the bridge

Here is the move that makes the entire reader cohere. Suppose you have an atomless space and you build a two-point random variable by choosing an event $A$ and setting
$$
\eta = u_1 \text{ on } A, \qquad \eta = u_2 \text{ on } A^c, \qquad p := \mu(A).
$$
By Sierpiński, **as you range over all events $A$, the weight $p=\mu(A)$ ranges over all of $[0,1]$** — irrationals included — while $u_1, u_2$ are yours to fix independently. So an identity asserted "for every event $A$ and every pair $u_1, u_2$" is *exactly* an identity asserted "for every $p\in[0,1]$ and every $u_1, u_2$" — which is *exactly* $(\star)$ on its full domain.

> **Atomlessness is what upgrades a finite-mixing statement into the genuine continuous-coefficient equation $(\star)$.** Replace the atomless space by a single coin (Chapter 9 does this) and the reachable weights collapse to the dyadic rationals; you fall back to $(J_\mathbb{Q})$, the monster returns, and a tameness hypothesis becomes mandatory again.

This is the difference between "useless hypothesis" and "indispensable hypothesis," and it is entirely about whether your weights form a continuum.

▶ **Drill 5.1.** On the uniform space $[0,1]$, exhibit an explicit event of probability $1/\sqrt 2$. (One line.)

▶ **Drill 5.2.** Explain why a single fair coin (the two-point space $\{H,T\}$ with $\mu(H)=\mu(T)=\tfrac12$) is *not* atomless, and list the masses $p$ reachable by events. Then list the masses reachable if you flip the coin $n$ independent times. (Answer-shape: dyadic rationals with denominator $2^n$; their union over all $n$ is the dyadic rationals — dense, but still only rationals.)

▶ **Drill 5.3.** State precisely the implication "atomless $\Rightarrow$ the resolution identity of Chapter 7 is genuine $(\star)$," matching the quantifiers on both sides. (You are rehearsing the bridge in your own words.)

---

# Chapter 6. Binary experiments and Bayes risk, from scratch (the Reid–Williamson setup)

We now build the decision-theory side. The goal is one concrete function — the Bayes risk of a binary classifier — and a clean derivation that it is a **tent**. Reid and Williamson develop this in their §4–5; we re-derive the piece we need with no prerequisites.

## 6.1 The binary prediction problem

There is a hidden binary label $Y\in\{0,1\}$ (say, "spam" vs "not spam"). You observe some features, summarized by a **posterior probability**
$$
\eta := \Pr(Y=1 \mid \text{features}) \in [0,1].
$$
$\eta$ is your honest belief that the label is $1$, given what you have seen. If $\eta = 0.9$ you are fairly sure it is $1$; if $\eta=0.5$ you are maximally uncertain.

You must take an **action** $a$ (e.g. "classify as $1$" or "classify as $0$"), and you pay a **loss** $\ell(a, y)$ depending on the action and the *true* label $y$.

## 6.2 Conditional risk and Bayes risk

At a given posterior $\eta$, the true label is still random: it is $1$ with probability $\eta$ and $0$ with probability $1-\eta$. So the **expected loss of action $a$ at posterior $\eta$** — the *conditional risk* — is
$$
L(\eta, a) := \mathbb{E}_{Y\sim\eta}[\ell(a, Y)] = (1-\eta)\,\ell(a, 0) + \eta\,\ell(a, 1).
$$
For each fixed action $a$, this is a **straight line in $\eta$** (a constant times $\eta$ plus a constant). Now you, being sensible, pick the *best* action — the one minimizing expected loss. The minimal achievable loss is the **(pointwise) Bayes risk**:
$$
\boxed{\;L(\eta) := \inf_{a} L(\eta, a).\;}
$$
This single function — the loss you are stuck with even after acting optimally — is the central object. It goes by many names in the literature: Bayes envelope, generalized entropy, *uncertainty function*. It measures the irreducible uncertainty at posterior $\eta$.

## 6.3 The Bayes risk is automatically concave

Here is a fact you get for free, and it matters in Chapter 9. $L(\eta)$ is an **infimum of straight lines** (one line $L(\eta,a)$ per action $a$). The infimum of any family of straight lines is a **concave** function — picture a bunch of lines and shade everything below all of them; the upper boundary of that region is a downward dome. So:

> **Every Bayes risk $L$ is concave. No assumption needed — concavity is a structural consequence of being a minimum over actions.**

This will be the quiet load-bearing fact that the continuous-coefficient theorem does *not* need but the classical decomposition theory *does* assume — we return to it.

## 6.4 The cost-weighted loss

To get the tent, we use the simplest interesting loss: the **cost-weighted misclassification loss**. Fix a cost parameter $c\in[0,1]$. The action is a threshold rule: predict $1$ if your estimate $\hat\eta \ge c$, else predict $0$. The loss charges
$$
\ell_c(y,\hat\eta) = c\,\llbracket y=0\rrbracket\,\llbracket \hat\eta \ge c\rrbracket \;+\; (1-c)\,\llbracket y=1\rrbracket\,\llbracket \hat\eta < c\rrbracket,
$$
using the Iverson bracket $\llbracket P\rrbracket = 1$ if $P$ true else $0$. In words: you pay $c$ for a **false positive** (truth $0$, you said $1$) and $1-c$ for a **false negative** (truth $1$, you said $0$); correct calls are free. The cost $c$ tunes how much you fear false positives relative to false negatives. (At $c=\tfrac12$ both errors cost $\tfrac12$ and this is, up to a factor, ordinary $0$–$1$ error.)

## 6.5 Deriving the tent (Reid–Williamson Theorem 14)

We now compute $L_c(\eta) = \inf_{\hat\eta} L_c(\eta,\hat\eta)$. First the conditional risk:
$$
L_c(\eta,\hat\eta) = (1-\eta)\,c\,\llbracket \hat\eta \ge c\rrbracket + \eta\,(1-c)\,\llbracket \hat\eta < c\rrbracket.
$$
Use $\llbracket \hat\eta < c\rrbracket = 1 - \llbracket \hat\eta \ge c\rrbracket$ and let $b := \llbracket\hat\eta\ge c\rrbracket \in\{0,1\}$ be the only thing you control:
$$
L_c(\eta,\hat\eta) = \eta(1-c)\,(1-b) + (1-\eta)c\,b
= \eta(1-c) + b\big[(1-\eta)c - \eta(1-c)\big].
$$
Simplify the bracket: $(1-\eta)c-\eta(1-c) = c - \eta c - \eta + \eta c = c-\eta$. So
$$
L_c(\eta,\hat\eta) = \eta(1-c) + b\,(c-\eta), \qquad b\in\{0,1\}.
$$
Now minimize over $b$:

- If $c - \eta < 0$ (i.e. $\eta > c$): choosing $b=1$ lowers the value. Result: $\eta(1-c) + (c-\eta) = c - \eta c = c(1-\eta)$.
- If $c-\eta > 0$ (i.e. $\eta < c$): choosing $b=0$ is best. Result: $\eta(1-c)$.

Both branches are "pick the smaller of the two linear pieces," so
$$
\boxed{\;L_c(\eta) = \min\big\{\,(1-\eta)\,c,\;\; (1-c)\,\eta\,\big\}.\;}
$$
This is a **tent function**: two straight lines meeting at a peak.

- The piece $(1-\eta)c$ starts at height $c$ (when $\eta=0$) and falls to $0$ (when $\eta=1$).
- The piece $(1-c)\eta$ starts at $0$ and rises to $1-c$.
- They cross where $(1-\eta)c = (1-c)\eta$, i.e. $c - \eta c = \eta - \eta c$, i.e. $\eta = c$. The **apex** sits at $\eta = c$, with height $c(1-c)$.

And it is concave (a minimum of two lines — consistent with §6.3). At $c=\tfrac12$: $L_{1/2}(\eta) = \tfrac12\min(\eta, 1-\eta)$. Since $0$–$1$ loss is $2\ell_{1/2}$, the **$0$–$1$ Bayes risk is $\min(\eta, 1-\eta)$** — the symmetric tent, peaking at $\eta=\tfrac12$ with height $\tfrac14$. This is *the error floor*: the smallest misclassification rate any predictor can achieve at posterior $\eta$.

▶ **Drill 6.1.** Redo the minimization of $L_c(\eta,\hat\eta)$ over $b\in\{0,1\}$ from the line $L_c(\eta,\hat\eta)=\eta(1-c)+b(c-\eta)$, and confirm the apex location and height independently of the text.

▶ **Drill 6.2.** Sketch $L_c$ for $c=\tfrac14$, $c=\tfrac12$, $c=\tfrac34$ on the same axes. Mark each apex $(c,\,c(1-c))$. Notice how the tent skews left or right as $c$ moves. (You are building the picture that Chapter 8 turns into a mixture.)

▶ **Drill 6.3.** Verify the claim that the conditional risk $L(\eta,a)$ is, for each fixed $a$, an affine function of $\eta$, and conclude from "infimum of affine functions" that $L(\eta)$ is concave — *without* computing $L$ explicitly. (You are proving §6.3 in general.)

---

# Chapter 7. The tent, derived a second way — and the reconciliation

We have the tent from the *decision-theory* side (minimize a loss). The continuous-coefficient theorem gives it from the *functional-equation* side (impose exactness). Watching the two derivations meet is the intellectual core of the connection between the two papers.

## 7.1 The tent as a forced shape

Suppose you do not know the loss. You only know that your uncertainty function $G$ is **exact on each half of the interval**: on $[0,\tfrac12]$ and on $[\tfrac12,1]$ separately, $G$ commutes with mixing — Jensen holds with equality there. Concretely, $(\star)$ holds for all $u_1,u_2$ lying in a common half, all $p\in[0,1]$.

> **Corollary (Piecewise saturation).** If $G$ satisfies $(\star)$ on each cell $[m_{i-1}, m_i]$ of a partition $0=m_0<\dots<m_k=M$, then $G$ is affine on each cell, hence **piecewise affine**, and automatically continuous at the knots — with no regularity assumed.

*Proof.* Apply the Endpoint-substitution Theorem on each cell (after rescaling that cell to $[0,1]$, as in Drill 3.1). At each interior knot $m_i$, the affine formulas from the two adjacent cells both evaluate to the same number $G(m_i)$, so the pieces join continuously. $\;\blacksquare$

For the partition $\{[0,\tfrac12],[\tfrac12,1]\}$, the result is a function made of two line segments meeting at $\tfrac12$ — a **tent**. The continuity at the apex is *free*: you did not assume it, the segments are forced to meet.

## 7.2 The reconciliation

So we have two tents:

| | source | result |
|---|---|---|
| **Decision theory** (Ch. 6) | minimize $\ell_c$ over actions | $L_c(\eta)=\min\{(1-\eta)c,(1-c)\eta\}$, apex at $\eta=c$ |
| **Functional equation** (Ch. 7) | impose exactness on each cell | piecewise-affine, apex at the knot, slopes free |

They agree, and the agreement is the point: the **shape** the functional equation forces (piecewise affine, continuous at the apex) is *exactly* the shape the decision problem produces. The decision-theory derivation tells you *which* tent (apex at $c$, height $c(1-c)$, the Bayes risk of a real loss); the functional-equation derivation tells you *why no other shape is possible* once exactness holds, and tells you so with **zero regularity hypotheses**. Each paper supplies what the other takes for granted:

- Reid–Williamson supply the **content**: the tent is not an arbitrary example, it is the error floor of a cost-weighted classifier.
- The continuous-coefficient theorem supplies the **rigidity**: exactness $\Rightarrow$ tent, and the apex continuity you would reflexively assume is a theorem, not an axiom.

## 7.3 The factor-of-2, stated once and for all (a genuine trap)

The two papers normalize the tent differently, and confusing the normalizations is the single most common error when porting results between them. The manuscript writes the apexed tent as
$$
T_\theta(u) := 2\,\min\big(u(1-\theta),\;(1-u)\theta\big), \qquad \text{apex at } u=\theta, \text{ height } 2\theta(1-\theta).
$$
Reid–Williamson's generator (Ch. 6) is $L_c(u)=\min\{(1-u)c,(1-c)u\}$, apex at $u=c$, height $c(1-c)$. Comparing apex locations ($\theta = c$) and heights, you find
$$
\boxed{\,T_\theta = 2\,L_\theta.\,}
$$
The factor of $2$ is **exactly** the relation $2\ell_{1/2}=\ell^{0\text{-}1}$ — the same $0$–$1$ normalization — promoted to the whole family. It is not an error in either paper; each is internally consistent. But if you take Reid's mixing formula (next chapter) and drop it into the manuscript's $T_\theta$ language without tracking the $2$, your mixing measure comes out off by a factor of $2$. We flag exactly where this bites in §8.3.

▶ **Drill 7.1.** Verify $T_\theta = 2L_\theta$ by computing both apex locations and both apex heights. Then verify the apex of $T_\theta$ is at $u=\theta$ by solving $u(1-\theta)=(1-u)\theta$.

▶ **Drill 7.2.** Prove the apex continuity in the Piecewise-saturation Corollary by hand for $k=2$: write the two affine formulas on $[0,\tfrac12]$ and $[\tfrac12,1]$ and check they agree at $\tfrac12$. (You are confirming "continuity is a conclusion" in the concrete tent case.)

▶ **Drill 7.3 (synthesis).** In one paragraph, state which paper provides "which tent" and which provides "why no other shape," using the words *content* and *rigidity*. This is the thesis of the whole connection; be able to write it cold.

---

# Chapter 8. Every uncertainty function is a pile of tents: the mixture representation

The tents are not just examples — they are the **atoms** out of which *every* uncertainty function is built. This is Reid–Williamson's integral-representation theorem, and it turns the abstract "cone of uncertainty functions" into something you can compute with a derivative.

## 8.1 The statement

> **Theorem (Choquet / integral representation, Reid–Williamson Thm 16).** Every (fair, proper) uncertainty function $L$ is a weighted mixture of cost-weighted tents:
> $$
> L(\eta) = \int_0^1 L_c(\eta)\, w(c)\, dc, \qquad \text{where } \; w(c) = -L''(c) \ge 0.
> $$

Two things to absorb. First, the **mixing weight is the curvature** of $L$: $w(c) = -L''(c)$, the negative second derivative. Since $L$ is concave (Ch. 6), $L''\le 0$, so $w \ge 0$ — the weights are genuinely nonnegative, as a mixing measure must be. Second, the integral runs over the cost parameter $c\in[0,1]$: you are sweeping the tent's apex across the whole interval and piling the tents up with weight $w(c)$ at apex location $c$.

Geometrically: a concave dome is the "lower envelope assembled from straight pieces," and $-L''$ measures how fast the slope is turning at each point — i.e. how much tent-mass is concentrated there. Where $L$ bends sharply, $w$ is large; where $L$ is already straight, $w=0$ (no tent needed).

## 8.2 The mixing measure is the curvature — worked examples

This is where you should compute, because the formula $w=-L''$ is only real once you have used it.

**Square loss (Brier).** The Brier uncertainty function is $L(\eta)=\eta(1-\eta)$. Then $L'(\eta)=1-2\eta$ and $L''(\eta)=-2$, so
$$
w(c) = -L''(c) = 2 \quad (\text{constant}).
$$
The Brier uncertainty function is the **uniform** mixture of tents — equal weight on every apex location. As a check, $\int_0^1 L_c(\eta)\cdot 2\,dc$ should return $\eta(1-\eta)$; we verify the underlying integral $\int_0^1 L_c(\eta)\,dc = \tfrac12\eta(1-\eta)$ in Appendix S (Drill 8.2). Times $2$: $\eta(1-\eta)$. ✓

**Log loss (cross-entropy).** The uncertainty function is the binary entropy $L(\eta) = -\eta\ln\eta - (1-\eta)\ln(1-\eta)$. Then
$$
L'(\eta) = \ln\frac{1-\eta}{\eta}, \qquad L''(\eta) = -\frac{1}{\eta(1-\eta)}, \qquad w(c) = \frac{1}{c(1-c)}.
$$
The log-loss mixing weight **blows up** at $c=0$ and $c=1$: log loss piles enormous tent-mass near the extreme costs. This is the analytic reason KL-divergence and log loss are *hard to estimate* — they put crushing weight on rare-event regimes (Reid–Williamson make exactly this remark).

## 8.3 The factor-of-2, returning to bite

In the manuscript's $T_\theta$ language the same theorem reads $G = \int_0^1 T_\theta\, d\nu(\theta)$. Because $T_\theta = 2L_\theta$ (§7.3), matching $\int L_c\,w\,dc = \int (T_c/2)\,w\,dc = \int T_c\,(w/2)\,dc$ shows the mixing measure in the *tent-normalized* language is
$$
d\nu(\theta) = \tfrac12\,w(\theta)\,d\theta = -\tfrac12 G''(\theta)\,d\theta.
$$
If a paper writes "$d\nu = -G''\,d\theta$" it is implicitly using a tent normalized so the factor is absorbed; if you simultaneously use Reid's $w=-L''$ *and* the $T_\theta=2L_\theta$ generator, you will double-count. **State your normalization before you write your mixing measure.** This is not pedantry — it is the exact spot where careless cross-citation between the two papers produces a wrong constant. (The honest fix in prose: say "$d\nu$ is the curvature measure of $G$, up to the $0$–$1$ normalization," which is true under both conventions.)

## 8.4 Why "pile of tents" is the right mental image

The upshot: the cone of all uncertainty functions is generated by the tents $\{L_c\}_{c\in[0,1]}$ — they are its **extreme rays**, the indecomposable atoms. Any concave $L$ you will ever meet is $\int L_c\,w(c)\,dc$ for its own curvature $w=-L''$. The continuous-coefficient theorem then says: the only $L$ for which **no** tents are needed — i.e. $w\equiv 0$, $L''\equiv 0$ — is an **affine** $L$, and that is precisely the "exactness everywhere" case of Chapter 3. Affine = flat = zero curvature = no tents = exact. The whole reader is one circle of ideas:

$$
\text{exact on the continuum} \iff \text{affine} \iff \text{zero curvature} \iff \text{no tent mass}.
$$

▶ **Drill 8.1.** Compute $w(c) = -L''(c)$ for the **boosting/exponential** uncertainty function $L(\eta) = 2\sqrt{\eta(1-\eta)}$. (Answer-shape: $w(c) = \tfrac12[c(1-c)]^{-3/2}$ — even more concentrated at the extremes than log loss.)

▶ **Drill 8.2.** Prove the integral identity $\int_0^1 L_c(\eta)\,dc = \tfrac12\,\eta(1-\eta)$ by splitting the integral at $c=\eta$ (where the $\min$ switches branches) and integrating each linear piece. (This is the computation that makes the Brier check in §8.2 honest; it is also the "$\int T_\theta\,d\theta = u(1-u)$" identity in disguise.)

▶ **Drill 8.3.** A function $L$ has $w(c)=-L''(c)=0$ on $[0,1]$. What are all such $L$, and how does this recover the Endpoint-substitution Theorem from the mixture viewpoint? (One line each.)

---

# Chapter 9. The edge cases: where a hypothesis is load-bearing, where it is vestigial

This is the chapter the reader was built for. We now hold both halves — the equation (Ch. 3–5) and the tent (Ch. 6–8) — and we can answer the puzzle of Chapter 0: *why are the same five hypotheses sometimes indispensable and sometimes useless?*

A point of intellectual honesty before we start. Reid and Williamson made **no mathematical errors**. Their derivations are correct and their framework is sound. What the continuous-coefficient viewpoint adds is not a correction but a *separation*: it pulls apart two things their setup bundles, and it makes explicit a load-bearing assumption their setup leaves silent. "Where Reid–Williamson missed" means "where the structure is implicit and a sharper lens makes it visible," not "where they were wrong." Keep that calibration; it is the difference between a useful critique and a cheap one.

## 9.1 The diagnostic: four sources of a saturated identity

A "saturated Jensen identity" — Jensen holding with equality — can arise from four structurally different places. Only one of them is the regularity-free situation of Chapter 3. Telling them apart is the whole skill.

**Source 1 — finite mixing.** If the only primitive is "combine two things in some proportion," and compounds are built by *finitely iterating* this, the reachable weights are the dyadic rationals, and after closure at most the rationals. Such a derivation licenses $(J_\mathbb{Q})$, **not** $(\star)$. By the Hamel pathology (Ch. 4), a regularity hypothesis is genuinely required, and the endpoint-substitution theorem does **not** apply.

**Source 2 — additivity into a bounded codomain.** If the derivation delivers additivity of $G$ *plus* the information that $G$ stays in a bounded set, then $G$ is affine by the classical "bounded additive $\Rightarrow$ linear" theorem (one of the five struts). Here a regularity hypothesis — boundedness — is **load-bearing**, but it is handed to you *for free by the codomain* rather than assumed by hand. The operative mechanism is not the endpoint substitution.

**Source 3 — a Cauchy relative with a non-affine target.** If the equation that actually appears is a relative of Cauchy's equation whose *intended solution is not affine* (it is concave, say), then a regularity hypothesis is needed to exclude Hamel-type pathologies, and $(\star)$ is simply not the equation in play. The Shannon-entropy characterization (§9.3) is the textbook case.

**Source 4 — a genuine continuum of real weights.** If the weight $p$ is a real parameter *realized inside the structure* — an atomless measure (Ch. 5) assigns every mass in $[0,1]$ — and the identity is asserted *directly* for that real $p$ with no detour through finite iteration, then the derivation licenses $(\star)$ at every real $p$, irrationals included. **Only now** does the endpoint-substitution theorem apply, and **only now** is a regularity hypothesis on $G$ vestigial.

## 9.2 The zeroth gate: does a solution even exist?

Logically *before* the four sources sits a question they all presuppose:

> **Zeroth gate: does a real-valued solution of the identity provably exist?**

The endpoint-substitution theorem takes a *function* as input and reports its shape. It cannot conjure the function. If the surrounding axioms fail to produce a real-valued unknown in the first place, the theorem is inapplicable *before any weight is examined* — and a hypothesis that secures existence is load-bearing one step earlier than the dictionary.

**The expected-utility example.** In the von Neumann–Morgenstern theory (sharpened by Herstein–Milnor), a preference over lotteries that is complete, transitive, **independent**, and **Archimedean** (mixture-continuous) is represented by a utility $U$ linear in probability:
$$
U\big(p\,L_1 + (1-p)\,L_2\big) = p\,U(L_1) + (1-p)\,U(L_2).
$$
It is tempting to read this as $(\star)$ and offer the endpoint-substitution theorem as a *continuity-free replacement for the Archimedean axiom*. **Resist.** The independence axiom is a condition on the *preference relation*; though stated at every real $p$, it does not by itself produce a real-valued functional equation. What produces a real-valued affine $U$ is the **Archimedean axiom** — it embeds the indifference classes into the real line — and it is genuinely indispensable: lexicographic preferences are complete, transitive, and independent, yet violate Archimedean and admit **no real-valued representation at all**. There is no $U$; the displayed identity, and with it $(\star)$, is vacuous. The theorem cannot replace the Archimedean axiom because the theorem *presupposes* the real-valued solution the Archimedean axiom is there to create. This is a failure at the zeroth gate, not a deficit of weights.

## 9.3 Load-bearing, in full: the Shannon-entropy characterization (Source 3)

This is the exact mirror of the tent, and the most important "where the struts are indispensable" example.

Shannon entropy $H(p_1,\dots,p_n) = -\sum_i p_i \log p_i$ is singled out (Khinchin, Faddeev) by symmetry, a normalization, and a **recursivity (grouping)** axiom. The recursivity axiom does **not** reduce to $(\star)$. For the information function $f(x) = H(x, 1-x)$ it reduces to the **fundamental equation of information**, on the domain $D=\{(x,y): x,y\ge 0,\; x+y\le 1\}$:
$$
f(x) + (1-x)\,f\!\left(\frac{y}{1-x}\right) \;=\; f(y) + (1-y)\,f\!\left(\frac{x}{1-y}\right).
$$
The unique solution under the axioms (with Faddeev's normalization $f(\tfrac12)=1$) is the **binary entropy**
$$
f(x) = -x\log_2 x - (1-x)\log_2(1-x),
$$
which is strictly **concave** — emphatically not affine ($f''(x) = -1/(x(1-x)\ln 2) < 0$). The fundamental equation of information is a **relative of Cauchy's equation**, and like Cauchy's equation it admits Hamel-type non-measurable solutions unless a regularity hypothesis excludes them. And here is the decisive sentence:

> **The hypotheses that have been used to exclude the entropy pathologies are *exactly the five struts*.** Faddeev assumed continuity; the requirement was then weakened one classical hypothesis at a time — to integrability (Tverberg), to measurability (Lee), to boundedness on a positive-measure set (Diderrich), to monotonicity on $[0,\tfrac12)$ (Kendall, Borges).

So the entropy characterization is the canonical place where the dictionary's five hypotheses reappear in an applied setting — and there they are **load-bearing**, because the equation is a Cauchy relative with a concave (non-affine) target. The monster genuinely lurks; a strut genuinely excludes it.

## 9.4 The mirror, side by side

| Hypothesis on the unknown function | Entropy characterization (a Cauchy relative) | Saturated $(\star)$ on an atomless space |
|---|---|---|
| Continuity | **Required** (Faddeev) | **Vestigial** — a conclusion (Ch. 3 Cor.) |
| Measurability | **Required** (Lee) | **Vestigial** — same |
| Monotonicity | **Required** (Kendall, Borges) | **Vestigial** — same |
| Bounded on a fat set | **Required** (Diderrich) | **Vestigial** — same |
| Bounded on the interval | **Required** (a fortiori) | **Vestigial** — same |
| **None** | **Insufficient** — Hamel solutions of the info equation | **Sufficient** — endpoint substitution |

Same five hypotheses. Opposite columns. The difference is *not the function* — it is whether the operative equation is a Cauchy relative (rational/additive structure, concave target, monster present) or genuine $(\star)$ (continuum of weights, affine target, monster foreclosed). **This table is the entire reader compressed into a grid.**

## 9.5 The seams in Reid–Williamson, stated precisely and fairly

Now the in-the-wild payoff. Reid–Williamson's tent and its mixture representation (Ch. 6–8) sit on the *vestigial* side — Source 4, an atomless feature space. But their setup carries two pieces of implicit structure that the continuous-coefficient lens makes explicit. These are the "where they missed" — in the precise sense of §9.0.

**Seam 1 — the word *fair* bundles a strut with a normalization.** Reid–Williamson call a loss *fair* if (a) $\eta\mapsto\ell(0,\eta)$ is right-continuous at $0$ and $\ell(1,\eta)$ is left-continuous at $1$, **and** (b) $\ell(0,0)=\ell(1,1)=0$. Stated together, this reads as one regularity condition. It is two different things:

- Clause (a), boundary continuity, is **a strut of the dictionary** — and on an atomless space it is **vestigial**: by the piecewise-saturation corollary, any uncertainty function arising from cellwise exactness is affine on each cell, hence continuous, so the continuity is a *conclusion*, not an input.
- Clause (b), zero loss at perfect prediction, is **not a regularity hypothesis at all** — it is a **normalization**. The endpoint-substitution theorem determines the uncertainty function only up to its two endpoint values $G(0)$ and $G(M)$; clause (b) is exactly what pins those two free constants. Dropping it does **not** readmit the Hamel monster — it merely unfixes an additive and a slope constant.

Tellingly, Reid–Williamson *use* clause (b) precisely as a normalization — in their Theorem 16 it is what lets them "get rid of the constants of integration." So their machinery already treats the two clauses differently in function; what the continuous-coefficient lens adds is the *vocabulary* to say so: one clause is regularity (and vestigial here), the other is normalization (and never Hamel-excluding). Conflating them is the seductive misclassification — and it runs in both directions (§9.6).

**Seam 2 — the continuum is assumed, never flagged.** Reid–Williamson work with actual losses and an integral representation $\int_0^1 L_c\, w(c)\, dc$ that silently presumes the cost parameter $c$ sweeps a *continuum*. This is Source 4, and it is doing real work: it is *why* the regularity-free conclusion is available. On a finite or atomic feature space the reachable cost masses collapse to a discrete set, the representation integral degenerates, and one is back in Source 1, where a strut is mandatory. The continuum is load-bearing — but invisible, because it is built into the ambient measure rather than stated as a hypothesis. The zeroth-gate / coin-versus-atomless discipline (§9.7) is what surfaces it.

**Seam 3 — the converse direction of inference is new.** Reid–Williamson assume (correctly, §6.3) that the Bayes risk is concave, and build their decomposition on *given* concavity: "here is a concave $L$, decompose it into tents." The continuous-coefficient theorem supplies the *reverse* arrow they do not state: the only uncertainty function *blind to resolution* — exact on every two-cell comparison — is **affine**, with no regularity and not even concavity assumed. Their theory consumes concavity; the rigidity statement *produces* affineness from exactness alone. Different direction, genuinely additive.

## 9.6 The trap runs both ways

The danger is **misclassification**, and it is symmetric.

- *Under-defending.* A Source-1, -2, or -3 derivation gets mistaken for Source 4, so an author **drops a hypothesis that was indispensable** — e.g. treats a coin-built (dyadic) mixture as a continuum and waves away the regularity that was actually holding the conclusion up. The Hamel monster walks back in unnoticed.
- *Over-defending.* The rarer, more seductive error: a Source-4 derivation gets mistaken for a Cauchy problem, so an author **adds a defensive hypothesis that was never needed** — bolts boundedness or measurability onto a genuine-$(\star)$ calibration computation where Chapter 3 already gives the conclusion for free. The continuous-coefficient manuscript exists because of an instance of *this* second error, surfaced by a formalization project that found a boundedness hypothesis going unused.

An analyst fluent in the Cauchy–Hamel toolkit is well defended against the first error and *peculiarly exposed* to the second — the toolkit trains the reflex to assume tameness, exactly the reflex $(\star)$ renders unnecessary.

## 9.7 The thin line in miniature: a coin versus an atomless space

The cleanest way to feel the whole chapter: take the Reid–Williamson calibration setup (atomless, Source 4, hypotheses vestigial) and **replace the atomless space by a single fair coin.** Build the mixtures by tossing it repeatedly. Now the attainable masses $p$ collapse to the dyadic rationals (Drill 5.2) — you are back in Source 1, the Hamel pathology returns (Ch. 4), and a regularity hypothesis is once more **required**. Nothing about the *function* changed. Nothing about the *outward form* of the identity changed. Only the **measure** changed — atomless to atomic — and with it the reachable weights flipped from a continuum to a sparse rational set, flipping every hypothesis from vestigial to load-bearing. The entire content of Chapters 4–9 lives in the gap between an atomless measure and a coin.

## 9.8 The same seam in physics: Gleason's theorem, preparation versus measurement

The asymmetry is not an artifact of one literature. In the foundations of quantum mechanics it appears as two routes to the same affine representation, paying different prices — and the dictionary predicts exactly where each spends a hypothesis.

The density operators (quantum states) form a convex set, and the mixture $p\rho_1 + (1-p)\rho_2$ is operationally primitive: prepare $\rho_1$ with probability $p$ via a classical randomizer, with $p$ a **genuine continuum**. A mixture-respecting assignment $v(p\rho_1+(1-p)\rho_2) = p\,v(\rho_1)+(1-p)\,v(\rho_2)$ is then **Source 4** — the higher-dimensional endpoint substitution gives $v(\rho)=\operatorname{tr}(A\rho)+b$ with **no** positivity, boundedness, continuity, or measurability assumed (this affine representation is operational folklore, e.g. Holevo). The **preparation** side pays nothing.

Gleason-type theorems instead work on the **measurement** side: a frame function on effects is only **finitely additive** over coarse-grainings of measurements — and coarse-graining is finite/rational mixing, **Source 1**. Finite additivity yields homogeneity only over the *nonnegative rationals*; the rational-to-real step must then be **purchased with a regularity hypothesis** — nonnegativity in Gleason's original projection theorem (for dimension $d\ge 3$), in Busch's POVM version (all $d\ge 2$), positivity or an explicit continuity proof in Caves–Fuchs–Manne–Renes, and — in Wright–Weigert's finite-dimensional Cauchy-equation treatment — the explicit result that a nonlinear finitely-additive frame function built on a *Hamel basis* can be neither bounded on either side, nor continuous at zero, nor measurable. That is **the catalog of Chapter 4 rediscovered inside physics.** Preparation tests the identity directly at every real weight; measurement tests it only through additivity, leaving room for dense Hamel oscillations unless boundedness or positivity intervenes. Same dictionary, two routes, prices predicted exactly.

▶ **Drill 9.1.** A colleague derives a "saturated Jensen identity" by mixing two outcomes with a biased coin and iterating. They invoke the endpoint-substitution theorem to conclude affineness with no further hypotheses. Identify the source, the error, and the minimal repair. (Answer-shape: Source 1; weights are only dyadic so the theorem does not apply; repair by either assuming a strut or replacing the coin with an atomless randomizer.)

▶ **Drill 9.2.** Explain, in the language of the four sources and the zeroth gate, why the Archimedean axiom in expected-utility theory cannot be replaced by the endpoint-substitution theorem. (Two sentences.)

▶ **Drill 9.3.** Take Reid–Williamson's "fair" condition apart into its regularity clause and its normalization clause, and state what each *does* to the affine solution guaranteed by Chapter 3. (You are reproducing Seam 1 from memory — this is the in-the-wild example you should be able to deliver cold.)

▶ **Drill 9.4 (the mirror).** Binary entropy and the symmetric tent are both concave functions on $[0,1]$ that vanish at the endpoints. For one of them, a continuity hypothesis on the characterizing equation is indispensable; for the other, it is vestigial. Say which is which and *why the difference has nothing to do with the two functions themselves.* (Answer-shape: entropy's equation is a Cauchy relative — Source 3, monster present, continuity load-bearing; the tent's exactness identity is genuine $(\star)$ on an atomless space — Source 4, monster foreclosed, continuity vestigial. The functions are incidental; the *equations and their weight sets* differ.)

---

# Chapter 10. Recitations

These are TA-section walkthroughs. Each is a synthesis problem with a *complete* solution, modeling the reasoning you should be able to reproduce. Work the problem yourself first; then read the solution as a check on your method, not a substitute for it.

## Recitation A — A decision procedure for "is this hypothesis vestigial?"

**Problem.** You are handed a manuscript whose key lemma reads: *"Let $G\colon[0,1]\to\mathbb{R}$ be a bounded function satisfying $G(p u_1 + (1-p)u_2) = pG(u_1)+(1-p)G(u_2)$ for all admissible $p$. Then $G$ is affine."* The author flags boundedness as essential. Is it?

**Solution (the four-question procedure).**

1. *Zeroth gate — does a real-valued $G$ exist?* The lemma takes $G$ as given, so yes; proceed.
2. *What are the admissible $p$?* This is the only question that matters, and the manuscript's phrase "all admissible $p$" is doing all the hiding. Read the surrounding derivation. Two cases:
   - **If $p$ ranges over a continuum** (e.g. it is a cell mass under an atomless measure): the lemma is **Source 4**. By the endpoint-substitution theorem, affineness follows from the equation alone. **Boundedness is vestigial** — and worse, it is *also implied* (Ch. 3 Cor.), so flagging it as essential is the over-defending error of §9.6.
   - **If $p$ ranges only over rationals** (e.g. the mixtures are built by finite iteration of a binary operation): the lemma is **Source 1 or 3**. Now boundedness is **load-bearing** — it is the strut that kills the Hamel monster, and it is supplied here *by hand* (not by a codomain), so the author is right to flag it.
3. *Is boundedness supplied by the structure or assumed?* If the continuum case holds, neither — it is redundant. If the rational case holds and $G$'s codomain is intrinsically bounded (e.g. probabilities in $[0,1]$), it is **Source 2** and the hypothesis is free.
4. *Verdict.* The honest answer is **"it depends entirely on the weight set, which the manuscript has not made explicit."** The correct revision is not to keep or drop the hypothesis blindly but to *state the source*: "$p$ ranges over a continuum, so boundedness is unnecessary (and automatic)," or "$p$ is dyadic, so boundedness is required."

**Takeaway.** "Is the hypothesis vestigial?" is never answered by looking at the *function* or the *outward form of the equation*. It is answered by locating the *weight set*. Train yourself to find the weights first.

## Recitation B — Derive the tent and its mixing weight for a new loss

**Problem.** Define a loss whose uncertainty function is $L(\eta) = \eta(1-\eta)\,(1 + \eta(1-\eta))$ on $[0,1]$ — a "sharpened Brier." (i) Confirm it is a legitimate uncertainty function. (ii) Find its tent-mixing weight $w(c)$. (iii) Interpret where the tent mass concentrates.

**Solution.**

(i) *Legitimacy = concavity* (Ch. 6.3). Compute $L(\eta) = \eta(1-\eta) + [\eta(1-\eta)]^2$. Let $s := \eta(1-\eta)$, so $s\in[0,\tfrac14]$ and $L = s + s^2$. We need $L'' \le 0$. With $s' = 1-2\eta$ and $s'' = -2$:
$$
L' = (1+2s)\,s', \qquad L'' = 2(s')^2 + (1+2s)\,s'' = 2(1-2\eta)^2 - 2(1+2s).
$$
At $\eta=\tfrac12$: $s'=0$, $s=\tfrac14$, so $L'' = 0 - 2(1+\tfrac12) = -3 < 0$. At $\eta=0$: $s'=1$, $s=0$, $L'' = 2 - 2 = 0$. In between $L''\le 0$ (the $-2(1+2s)$ term dominates wherever $(1-2\eta)^2$ is not maximal). So $L$ is concave — a legitimate uncertainty function. *(Always check concavity before trusting a mixing weight; a non-concave "uncertainty function" has signed mixing mass and is not a pile of tents.)*

(ii) *Mixing weight* (Ch. 8): $w(c) = -L''(c)$. From above,
$$
w(c) = -\big[\,2(1-2c)^2 - 2(1 + 2c(1-c))\,\big] = 2\big(1 + 2c(1-c)\big) - 2(1-2c)^2.
$$
Expand: $2 + 4c - 4c^2 - 2(1 - 4c + 4c^2) = 2 + 4c - 4c^2 - 2 + 8c - 8c^2 = 12c - 12c^2 = 12\,c(1-c)$.
So
$$
\boxed{\,w(c) = 12\,c(1-c).\,}
$$

(iii) *Interpretation.* Brier alone had $w \equiv 2$ (uniform — flat tent mass). The sharpening multiplies the weight by $6c(1-c)$, which **vanishes at the extremes $c=0,1$ and peaks at $c=\tfrac12$.** So "sharpened Brier" concentrates its tent mass on the *balanced* cost regime and removes mass from the extreme-cost regimes — the opposite of log loss, which piles mass at the extremes. The shape of $w$ is a direct readout of which decision thresholds the score cares about.

**Takeaway.** The pipeline is mechanical: (1) check concavity, (2) differentiate twice, (3) $w=-L''$, (4) read the concentration off the shape of $w$. The factor-of-2 caution (§7.3, §8.3) only enters if you re-express in the $T_\theta$ normalization, where you would halve $w$.

## Recitation C — Spot the bug (both directions)

**Problem.** Two short arguments. Each has exactly one flaw of the kind §9.6 warns about. Find it.

> **Argument I.** "Our recommender mixes two candidate rankings by flipping a fair coin, and recursively builds deeper mixtures the same way. The induced quality functional $Q$ satisfies $Q(p A + (1-p)B) = pQ(A)+(1-p)Q(B)$ for the mixing weights that arise. By the endpoint-substitution theorem, $Q$ is affine in the mixture, *with no regularity assumed*."

> **Argument II.** "Our calibration target $G$ on $[0,1]$ is the uncertainty function attained over an atomless feature space, so it satisfies the saturated identity at every cell mass. To be safe, we additionally assume $G$ is measurable, since the identity resembles Cauchy's equation, whose solutions can be pathological."

**Solution.**

*Argument I — under-defending (the §9.6 first error).* The coin-and-recursion construction reaches only **dyadic** weights (Drill 5.2): this is **Source 1**, not Source 4. The endpoint-substitution theorem requires a *continuum* of weights; here $(\star)$ is never tested at irrationals, so the Hamel monster is not excluded and the "no regularity assumed" claim is **false**. The conclusion may still be true, but it needs a strut (a regularity hypothesis on $Q$) or a genuinely atomless randomizer. The author dropped an indispensable hypothesis by mistaking dyadic mixing for a continuum.

*Argument II — over-defending (the §9.6 second, seductive error).* The atomless feature space realizes **every** cell mass (Sierpiński, Ch. 5), so the identity is genuine $(\star)$ — **Source 4**. By Chapter 3 the conclusion (affineness) follows *from the identity alone*, and measurability is not only unnecessary but *automatically implied* (Ch. 3 Cor.). The defensive measurability hypothesis is **vestigial**; assuming it betrays the Cauchy-trained reflex the manuscript warns against. The fix is to delete the hypothesis and cite the continuum of weights.

**Takeaway.** The two errors are mirror images and both are diagnosed by the *same* question: *what is the weight set?* Dyadic → you need the strut (I forgot it). Continuum → the strut is free (II added it needlessly).

## Recitation D — The mirror, end to end

**Problem.** Write a one-paragraph briefing for a reading group explaining why binary entropy's characterization needs continuity but the tent's exactness characterization does not — and why this is *not* a fact about entropy versus tents.

**Solution (model paragraph).** Both binary entropy $-x\log_2 x-(1-x)\log_2(1-x)$ and the symmetric tent $\min(x,1-x)$ are concave functions on $[0,1]$ vanishing at the endpoints, so the contrast cannot be about the functions. It is about the *equations that characterize them and the weights those equations test.* Entropy is pinned by the **fundamental equation of information**, a relative of Cauchy's equation built on rational/additive structure with a **concave (non-affine) target**: this is Source 3, the Hamel monster genuinely lurks, and a regularity hypothesis — continuity (Faddeev), later weakened to measurability, boundedness, or monotonicity — is **load-bearing** to exclude it. The tent is pinned by **cellwise exactness on an atomless space**, which by Sierpiński's theorem is the genuine continuous-coefficient equation $(\star)$ with an **affine target on each cell**: this is Source 4, the endpoint substitution excludes the monster *using only the continuum of weights*, and continuity is **vestigial** — indeed a conclusion. Same five hypotheses, opposite verdicts, decided entirely by whether the weight set is a sparse rational structure (entropy) or a continuum (tent). The lesson is portable: before deciding whether a regularity hypothesis earns its keep, find the weights.

---

# Chapter 11. Why this matters

## 11.1 For machine-learning theory

The tent is the **error floor** of a binary classifier (Ch. 6), and its mixture representation (Ch. 8) is the backbone of *surrogate-risk calibration* — the theory that tells you what you lose by optimizing a convenient surrogate loss (logistic, hinge, exponential) instead of the intractable $0$–$1$ loss. The $\psi$-transform of Bartlett–Jordan–McAuliffe, Steinwart's calibration functions, and the multiclass analysis of Tewari–Bartlett all measure how far a surrogate's floor sits from the true floor; *exactness on a cell* says that gap is zero there, and the piecewise-saturation corollary says the price of a zero gap is **affineness on the cell — the tent**. The continuous-coefficient lens contributes the precise statement that this rigidity needs **no regularity** and the precise vocabulary (Seam 1) to separate the regularity content of a calibration hypothesis from its normalization content.

In representation learning the same object is the **resolution** of an encoder: $U_{T_{1/2}}(\sigma(R))$ is the smallest misclassification error achievable from a representation $R$, and the only uncertainty functions *blind to the choice of representation* are the affine ones — any genuinely concave $G$ certifies, through a strict drop in $U_G$ under refinement, that the representation gained resolution. This is Blackwell's comparison of experiments in modern dress, and it is the link from the tent to the broader partition-theoretic / achievable-error-floor program (refinement-monotonicity, the cone of uncertainty functions, the tent as its extreme rays) that targets venues like COLT and TMLR.

## 11.2 For the foundations literature

The diagnostic of Chapter 9 is *not* confined to learning theory. The same line — Source 4 (vestigial) versus Sources 1–3 (load-bearing) — runs through:

- **Information theory** (the Shannon-entropy characterization, §9.3): a Cauchy relative, continuity load-bearing.
- **Decision theory** (expected utility, §9.2): the zeroth gate, the Archimedean axiom load-bearing for *existence*.
- **Quantum foundations** (Gleason's theorem, §9.8): preparation pays nothing, measurement buys the rational-to-real step with positivity — the dictionary's catalog rediscovered inside physics.
- **Opinion pooling** (McConway; Aczél–Wagner): boundedness from the codomain, Source 2.

In every case the *same five hypotheses* appear, and the *same question* — what is the weight set, and does a solution exist? — decides their status.

## 11.3 The general moral

> **A defensive regularity hypothesis is not free.** It can hide the real structure of an argument, and it can be exactly backwards — assumed where it is vestigial, dropped where it is load-bearing.

The continuous-coefficient manuscript reached this moral through a **formalization project**: a lemma was stated with a defensive boundedness hypothesis "in deference to the Cauchy–Hamel literature," and when the proof was written out in a proof assistant the hypothesis went *unused* — the endpoint substitution closed the proof on its own. Formalization surfaces such hypotheses precisely because a formal system demands that *every clause of a statement be used*. This is a quiet but real argument for mechanized proof as an instrument of mathematical *taste*, not just correctness: it tells you which of your hypotheses you never needed.

## 11.4 Where to go next

- The **rigidity** thread (exactness $\Rightarrow$ affine $\Rightarrow$ tent) generalizes to the simplex (the $k$-class case, via the higher-dimensional endpoint substitution) and connects to *tent-uniqueness* and *simplex-rigidity* results in the partition-theoretic calibration program.
- The **approximate** thread: Chapter 3 is the *exact* case ($w\equiv 0$); Reid–Williamson's surrogate regret bounds (their Theorem 25) are the *quantitative* completion — if the cellwise gap is $\alpha$ rather than $0$, the surrogate regret is bounded by an explicit function of $\alpha$. Exactness is the boundary case of a whole inequality theory.
- The **estimation** thread: the mixing weight $w=-L''$ explains why some divergences (KL, log loss) are hard to estimate — their tent mass concentrates at the extremes (Ch. 8.2) — and suggests regularized estimators that simply truncate the divergent weight.

---

# A quick-reference card (memorize these)

1. **The one-line theorem.** $(\star)$ on $[0,M]$, no regularity $\Rightarrow$ $G$ affine, via $u_1=M,\,u_2=0,\,p=v/M$.
2. **Regularity is a conclusion, not a hypothesis** — for $(\star)$. (Ch. 3 Cor.)
3. **The monster lives at irrational weights.** $(J_\mathbb{Q})$ keeps it; $(\star)$ tests every irrational and kills it. (Ch. 4)
4. **Atomless $\Rightarrow$ every mass realized $\Rightarrow$ genuine $(\star)$.** A coin gives only dyadics $\Rightarrow$ $(J_\mathbb{Q})$. (Ch. 5)
5. **The tent two ways.** Bayes risk of $\ell_c$ is $\min\{(1-\eta)c,(1-c)\eta\}$ (content); cellwise exactness forces piecewise-affine with free apex continuity (rigidity). (Ch. 6–7)
6. **Mixing weight = curvature:** $w(c)=-L''(c)$; Brier $\to 2$, log loss $\to 1/(c(1-c))$. (Ch. 8) — mind the $T_\theta=2L_\theta$ factor.
7. **Four sources + zeroth gate.** Finite mixing / bounded codomain / Cauchy relative / continuum; existence first. Only the continuum makes the struts vestigial. (Ch. 9)
8. **Find the weights.** Vestigial-or-load-bearing is decided by the weight set, never by the function. (Ch. 9–10)

---

# Appendix S. Solutions to the drills

**1.1.** $p x_1^2 + (1-p)x_2^2 - (px_1+(1-p)x_2)^2$. Expand the square: $p^2x_1^2 + 2p(1-p)x_1x_2 + (1-p)^2 x_2^2$. Subtract: $px_1^2 - p^2x_1^2 + (1-p)x_2^2-(1-p)^2x_2^2 - 2p(1-p)x_1x_2 = p(1-p)x_1^2 + (1-p)p\,x_2^2 - 2p(1-p)x_1x_2 = p(1-p)(x_1-x_2)^2 \ge 0$. So $\le$ holds: convex.

**1.2.** If $G(x)=ax+b$ then by §1.2 $G(px_1+(1-p)x_2) = pG(x_1)+(1-p)G(x_2)$ — equality. Equality implies both $\le$ (convex) and $\ge$ (concave).

**1.3.** $H(px_1+(1-p)x_2) = G(\cdot) + c(px_1+(1-p)x_2)+d$. The $G(\cdot)$ part is $\le pG(x_1)+(1-p)G(x_2)$ by convexity; the affine part equals its own mixture exactly (§1.2). Adding, $H(\cdot)\le pH(x_1)+(1-p)H(x_2)$. Convex.

**2.1.** $u_1=0,u_2=1,p=\tfrac12$: chord side $\tfrac12\cdot0+\tfrac12\cdot1=\tfrac12$; curve side $G(\tfrac12)=\tfrac14$. $\tfrac12\ne\tfrac14$, and indeed $\tfrac12 > \tfrac14$ — strict convexity, the *opposite* of equality. So $x^2$ does not solve $(\star)$.

**2.2.** Substitute $\tilde G = G + cx + d$ into both sides of $(\star)$. The $G$-parts match because $G$ solves $(\star)$; the affine parts match by §1.2. Hence $\tilde G$ solves $(\star)$.

**2.3.** Every two-point law is determined by $(u_1,u_2,p)$ and conversely every such triple defines a two-point law; "for all two-point laws" and "for all $(u_1,u_2,p)$" are the same quantifier, so $(\star)$ is exactly Jensen-with-equality.

**3.1.** Let $\phi(t) = G(2 + 5t)$ for $t\in[0,1]$. If $G$ solves $(\star)$ on $[2,7]$ then $\phi$ solves $(\star)$ on $[0,1]$ (mixing commutes with the affine reparametrization $t\mapsto 2+5t$). Apply the theorem to $\phi$, then substitute back $t=(v-2)/5$.

**3.2.** Set $p=v/M\in[0,1]$. Hypothesis: $\tfrac{v}{M}G(M)+(1-\tfrac vM)G(0)=G(\tfrac vM\cdot M)=G(v)$. Rearrange: $G(v)=G(0)+(G(M)-G(0))v/M$. Affine. (Identical to the main proof; this is all the main proof actually used.)

**3.3.** The one-configuration hypothesis is *a priori* weaker (it constrains $G$ only along endpoint-mixtures). But it already forces $G$ to equal the endpoint chord at every $v$, i.e. forces affineness. Once $G$ is affine, *full* $(\star)$ holds for it (Drill 1.2/2.2). So the weak hypothesis $\Rightarrow$ affine $\Rightarrow$ full $(\star)$: the strong equation is a free consequence, dissolving the tension.

**4.1.** With $f=G-G(0)$, $(J_2)$ becomes $f(\tfrac{x+y}{2})=\tfrac{f(x)+f(y)}2$ (the constants $G(0)$ cancel). Put $y=0$: $f(\tfrac x2)=\tfrac{f(x)}2$ (using $f(0)=0$). Then $f(\tfrac{x+y}2)=\tfrac12 f(x+y)$ by this relation applied to $x+y$, so $\tfrac12 f(x+y)=\tfrac12(f(x)+f(y))$, giving $f(x+y)=f(x)+f(y)$.

**4.2.** $f(2x)=f(x+x)=2f(x)$; assume $f(nx)=nf(x)$, then $f((n{+}1)x)=f(nx{+}x)=nf(x)+f(x)=(n{+}1)f(x)$ — induction complete for $n\ge1$. $f(-x)=-f(x)$ from $f(0)=0$. $f(x/n)=f(x)/n$ from $f(x)=nf(x/n)$. For $q=m/n>0$: $f(qx)=f(m\cdot\tfrac xn)=mf(\tfrac xn)=\tfrac mn f(x)=qf(x)$; sign handles $q<0$; $q=0$ trivial.

**4.3.** Take any irrational basis element $h'$ of a Hamel basis. The rationals are dense, so $\{q h': q\in\mathbb{Q}\setminus\{0\}\}$ is dense in $\mathbb{R}$; pick $q$ with $h:=qh'\in(0,1)$. Replacing $h'$ by $h=qh'$ preserves $\mathbb{Q}$-linear independence and spanning (rescaling one basis vector by a nonzero scalar keeps a basis a basis), so the new set is a Hamel basis containing the irrational $h\in(0,1)$ (and, after a similar normalization, $1$).

**4.4 (model).** A $\mathbb{Q}$-linear (Hamel) function scales correctly by every rational factor but not by some irrational factor; the rational equation $(J_\mathbb{Q})$ only ever tests rational scalings, so the monster passes every test on it, whereas $(\star)$ tests irrational scalings too, where the monster's defect is exposed and the equation fails for it. The one-line proof is not too good to be true precisely because *the monster lives at irrational weights*, and $(\star)$ — unlike $(J_\mathbb{Q})$ — reaches there.

**5.1.** $A=[0,\,1/\sqrt2\,]$ has length $1/\sqrt2$, so $\mu(A)=1/\sqrt2$ under the uniform measure.

**5.2.** A single fair coin's only events are $\varnothing,\{H\},\{T\},\{H,T\}$ with masses $0,\tfrac12,\tfrac12,1$ — and $\{H\}$ cannot be split into smaller positive-mass sub-events, so $\{H\}$ is an atom; the space is atomic. With $n$ independent flips, events are unions of the $2^n$ equally-likely outcomes, so reachable masses are $\{k/2^n: 0\le k\le 2^n\}$. Over all $n$, the union is the dyadic rationals in $[0,1]$ — dense, but every one of them rational.

**5.3.** Atomlessness $\Rightarrow$ (Sierpiński) for every $p\in[0,1]$ there is an event of mass $p$; so the family $\{(u_1\mathbf 1_A+u_2\mathbf 1_{A^c}): A,\,u_1,u_2\}$ realizes every triple $(u_1,u_2,p)$ with $p\in[0,1]$; hence asserting the resolution identity over all $(A,u_1,u_2)$ is identical to asserting $(\star)$ over all $(u_1,u_2,p)$ — its full domain.

**6.1.** From $L_c(\eta,\hat\eta)=\eta(1-c)+b(c-\eta)$, the minimizing $b\in\{0,1\}$ is $b=1$ iff $c-\eta<0$. Values: $\eta>c\Rightarrow c(1-\eta)$; $\eta<c\Rightarrow \eta(1-c)$; equal at $\eta=c$ giving $c(1-c)$. So apex $(c,c(1-c))$, matching the text.

**6.2.** Three tents peaking at $(\tfrac14,\tfrac{3}{16}),(\tfrac12,\tfrac14),(\tfrac34,\tfrac3{16})$; left-skewed for $c=\tfrac14$, symmetric for $c=\tfrac12$, right-skewed for $c=\tfrac34$. (Sketch check: each is two line segments from $(0,c)$... careful — left endpoint height is the value of the *active* branch at $\eta=0$, which is $\min\{c,0\}=0$; both tents start and end at $0$ and peak at $c(1-c)$.)

**6.3.** For fixed $a$, $L(\eta,a)=(1-\eta)\ell(a,0)+\eta\ell(a,1)=\ell(a,0)+\eta(\ell(a,1)-\ell(a,0))$ — affine in $\eta$. $L(\eta)=\inf_a L(\eta,a)$ is an infimum of affine functions; for any $\eta_1,\eta_2,p$, $L(p\eta_1+(1-p)\eta_2)=\inf_a[\,p\,L(\eta_1,a)+(1-p)L(\eta_2,a)\,]\ge p\inf_aL(\eta_1,a)+(1-p)\inf_aL(\eta_2,a)=pL(\eta_1)+(1-p)L(\eta_2)$, i.e. concave (the inf of the sum is $\ge$ the sum of the infs).

**7.1.** $T_\theta$ apex: solve $u(1-\theta)=(1-u)\theta\Rightarrow u-u\theta=\theta-u\theta\Rightarrow u=\theta$; height $T_\theta(\theta)=2\theta(1-\theta)$. $L_\theta$ apex at $\theta$, height $\theta(1-\theta)$. Ratio of heights $2$, same apex, same two linear branches up to scale $\Rightarrow T_\theta=2L_\theta$.

**7.2.** On $[0,\tfrac12]$, $G(\eta)=a_1\eta+b_1$; on $[\tfrac12,1]$, $G(\eta)=a_2\eta+b_2$. Both are *defined to pass through the data at the cell endpoints*; in particular both equal $G(\tfrac12)$ at $\eta=\tfrac12$ (the shared knot value the construction assigns), so $a_1\tfrac12+b_1=a_2\tfrac12+b_2=G(\tfrac12)$ — continuous at the apex with nothing assumed.

**7.3 (model).** Reid–Williamson supply *which* tent — $L_c$ is the Bayes risk of the cost-weighted loss $\ell_c$, apex at $c$, height $c(1-c)$, a real decision-theoretic quantity (**content**). The continuous-coefficient theorem supplies *why no other shape survives* once exactness holds — cellwise $(\star)$ forces piecewise-affine with free apex continuity, with **no** regularity hypothesis (**rigidity**). Content says what the object is; rigidity says it could be nothing else.

**8.1.** $L(\eta)=2\sqrt{\eta(1-\eta)} = 2(\eta-\eta^2)^{1/2}$. $L' = (1-2\eta)(\eta-\eta^2)^{-1/2}$. Differentiate again (product rule): $L''=-2(\eta-\eta^2)^{-1/2} + (1-2\eta)\cdot(-\tfrac12)(\eta-\eta^2)^{-3/2}(1-2\eta)$. Simplify over $(\eta-\eta^2)^{-3/2}$: $L'' = (\eta-\eta^2)^{-3/2}\big[-2(\eta-\eta^2) - \tfrac12(1-2\eta)^2\big]$. The bracket $=-2\eta+2\eta^2 -\tfrac12+2\eta-2\eta^2 = -\tfrac12$. So $L''=-\tfrac12[\eta(1-\eta)]^{-3/2}$ and $w(c)=-L''(c)=\tfrac12[c(1-c)]^{-3/2}$ — diverges like $c^{-3/2}$ at the extremes, even more concentrated than log loss.

**8.2.** Split at $c=\eta$. For $c<\eta$: $\min\{(1-\eta)c,(1-c)\eta\}$ — compare $(1-\eta)c$ vs $(1-c)\eta$; difference $(1-\eta)c-(1-c)\eta=c-\eta<0$, so the min is $(1-\eta)c$. For $c>\eta$ the min is $(1-c)\eta$. Hence $\int_0^1 L_c\,dc=\int_0^\eta (1-\eta)c\,dc + \int_\eta^1(1-c)\eta\,dc = (1-\eta)\tfrac{\eta^2}{2}+\eta\big[(c-\tfrac{c^2}2)\big]_\eta^1 = (1-\eta)\tfrac{\eta^2}2 + \eta(\tfrac12 - \eta + \tfrac{\eta^2}2) = \tfrac{\eta^2}2-\tfrac{\eta^3}2+\tfrac\eta2-\eta^2+\tfrac{\eta^3}2 = \tfrac\eta2-\tfrac{\eta^2}2 = \tfrac12\eta(1-\eta)$.

**8.3.** $L''\equiv0$ on an interval means $L$ has constant slope, i.e. $L$ is affine: $L(\eta)=a\eta+b$. From the mixture view, zero curvature $\Rightarrow$ zero tent mass $\Rightarrow$ $L=\int L_c\cdot 0\,dc + (\text{affine part}) $ is purely affine — which is exactly the endpoint-substitution conclusion recovered through the weight $w=-L''$.

**9.1.** Source 1 (finite/dyadic mixing). Error: the endpoint-substitution theorem needs a continuum, so it does not apply and "no further hypotheses" is false; the Hamel monster is not excluded. Minimal repair: either assume one of the five struts on $G$, or replace the iterated coin with an atomless randomizer so the weights form a continuum (Source 4), after which the theorem applies and the strut becomes vestigial.

**9.2 (model).** Independence is a condition on the *preference relation*, stated at every real $p$ but not by itself yielding a real-valued functional equation; the Archimedean axiom is what embeds indifference classes into $\mathbb{R}$ and thereby *creates* a real-valued $U$. The endpoint-substitution theorem presupposes a real-valued solution (the zeroth gate), so it cannot replace the very axiom that produces one — witness lexicographic preferences, which satisfy independence but, lacking Archimedean, have no real $U$ at all.

**9.3 (model).** Reid–Williamson's "fair" = clause (a) boundary continuity + clause (b) $\ell(0,0)=\ell(1,1)=0$. Clause (a) is a regularity strut; under genuine $(\star)$ on an atomless space it is **vestigial** (a conclusion of the affineness theorem). Clause (b) is a **normalization**: Chapter 3 fixes $G$ only up to its two endpoint values $G(0),G(M)$, and (b) is exactly what pins them to $0$; dropping (b) unfixes those two constants but does **not** readmit the Hamel monster. One clause governs *regularity* (and is free here), the other governs *which* affine function you land on (and is never Hamel-excluding).

**9.4 (model).** Indispensable for binary entropy; vestigial for the tent. The difference is not the functions — both are concave and vanish at the endpoints. It is the equations: entropy's fundamental equation of information is a Cauchy relative (Source 3) with a concave target, so a strut is needed to exclude Hamel solutions; the tent's cellwise-exactness identity on an atomless space is genuine $(\star)$ (Source 4) with an affine-per-cell target, so the continuum of weights excludes the monster and the strut is free. The verdict is set by the *weight sets of the two equations*, not by the two functions.
