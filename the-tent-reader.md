# The Tent
### A long-form reader for total mastery of the cost-weighted Bayes-risk tent — its rigidity, its mixture calculus, its surrogate-regret bounds, and its geometry

*Read this on trains. Read it twice. Read it five times. Nothing in it asks you to stop and prove something yourself — every proof is written out, every example unrolled, every edge case walked. The work happens in your reading, not in a margin. When you have read it enough times that the catechism in the back answers itself in your own voice, you will be able to stand at a chalkboard and derive the entire tent calculus of Reid and Williamson in front of experts in surrogate calibration, probability, and functional analysis, and answer their hardest questions without flinching.*

---

## Preface: what this document is, and how it is built to be remembered

There is one object in the theory of binary learning that everything else hangs from. It is humble — two straight lines meeting at a peak, the graph of
$$
\min\{(1-\eta)c,\ (1-c)\eta\}.
$$
We call it the **tent**. It is the irreducible error of a binary classifier; it is the extreme ray from which every loss function is built; it is the place where a deep functional equation becomes rigid; it is the kernel of a surrogate-regret bound; and it is, literally, a Green's function. Master the tent in all of these faces and you have mastered the spine of the field.

This reader is organized for **retention under repetition**, using techniques that cognitive science and good teaching agree on:

- **Layered spiral.** Each major result appears three times — once as a one-breath slogan, once as a fully worked derivation, once as a chalkboard script. Repetition at increasing depth is how things move from recognition to recall to reconstruction.
- **Concrete before abstract.** Every abstract claim is preceded by a numerical instance you can picture. The tent for $c=\tfrac13$ is drawn before the general tent is discussed.
- **Everything proved.** You are never asked to "check" or "verify." The check is done for you, in full, so re-reading deepens the groove rather than stalling at a gap. This is deliberate: a transit reader who hits an unproved step stops reading; a reader who is carried through every step keeps going and absorbs by immersion.
- **Memory hooks.** Mnemonics, slogans, and "say-it-out-loud" cues are placed at exactly the points experts find most slippery (the factor of two, the direction of the regret monotonicity, which weight blows up where).
- **Recall ladders.** Each part ends with *"You can now say…"* — a list of sentences you should be able to produce cold, each followed immediately by its answer, so the box doubles as flashcards.
- **The adversary in the room.** Part VIII is a transcript of experts attacking the material. Reading their questions *with the answers already written* trains the reflexes you will need when the questions come live.

A promise and a warning. The promise: if you read this until the catechism is automatic, you will be, in the precise and narrow domain of the binary tent, an elite — able to reconstruct Reid–Williamson's Theorems 14–18 and 25, every entry of their Table 2, and the rigidity theorem behind them, from scratch. The warning: this only works if you *re-read*. One pass teaches recognition; recognition is not mastery. Plan to return.

---

## How to navigate

- **Part I — Jensen, the bedrock.** Convexity, the equality case, the one-line rigidity theorem. The functional-equation engine, told completely.
- **Part II — The tent itself.** The cost-weighted loss, its Bayes risk, every structural property, the apex, the symmetries, the regret formula. The centerpiece.
- **Part III — The mixture calculus.** Every uncertainty function is a pile of tents; $w=-L''$; every entry of Reid's Table 2 derived by hand.
- **Part IV — Surrogate regret bounds.** The bound, its full proof, its inversion, its second-order form, and worked examples (exponential, truncated quadratic, and more).
- **Part V — Geometry.** Risk curves, the tent as the prior baseline, realizability, point-line duality with ROC.
- **Part VI — Functional-analysis depth.** Choquet, extreme rays, distributional second derivatives, the Green's-function identity.
- **Part VII — The edge-case bestiary.** Twenty edge cases, each walked to its resolution.
- **Part VIII — The adversary.** Expert challenges with full answers.
- **Back matter — The Tent Catechism** (recite-from-memory) and **Chalkboard Scripts** (board-by-board presentation).

---

## Notation, fixed once

| Symbol | Reading | |
|---|---|---|
| $\eta \in [0,1]$ | posterior probability that the label is $1$ | "how sure we are it's positive" |
| $\hat\eta \in [0,1]$ | an estimate / prediction of $\eta$ | |
| $Y \in \{0,1\}$ | the true binary label | |
| $c \in [0,1]$ | a cost parameter (false-positive cost) | the tent's "dial" |
| $\ell(y,\hat\eta)$ | loss when truth is $y$ and we said $\hat\eta$ | |
| $L(\eta,\hat\eta)$ | conditional (pointwise) risk $=\mathbb E_{Y\sim\eta}\ell(Y,\hat\eta)$ | |
| $L(\eta)$ | pointwise **Bayes risk** $=\inf_{\hat\eta}L(\eta,\hat\eta)$ — concave | "uncertainty function" |
| $\ell_c$ | cost-weighted misclassification loss | the **primitive** |
| $L_c(\eta)$ | Bayes risk of $\ell_c$ — the **tent** | $\min\{(1-\eta)c,(1-c)\eta\}$ |
| $B(\eta,\hat\eta)$ | regret $=L(\eta,\hat\eta)-L(\eta)\ge 0$ | a Bregman divergence |
| $B_c(\eta,\hat\eta)$ | cost-weighted regret | |
| $w(c)$ | mixing weight $=-L''(c)\ge 0$ | "curvature is mass" |
| $T_\theta$ | apexed tent, manuscript normalization $=2L_\theta$ | mind the **2** |
| $\llbracket P\rrbracket$ | $1$ if $P$ true, else $0$ (Iverson bracket) | |
| $a\wedge b,\ a\vee b$ | $\min(a,b)$, $\max(a,b)$ | |
| $\Delta L$ | statistical information $=L(\pi)-L(\eta\text{-averaged})$ | DeGroot |
| $(\star)$ | the continuous-coefficient Jensen equation | the rigidity engine |

**The single most important convention, stated now and repeated whenever it bites:** Reid–Williamson's tent is $L_c=\min\{(1-\eta)c,(1-c)\eta\}$ (apex height $c(1-c)$), while the manuscript's normalized tent is $T_\theta = 2L_\theta$ (apex height $2\theta(1-\theta)$). The factor of two is exactly the relation $2\ell_{1/2}=\ell^{0\text{-}1}$. *Write down your normalization before you write your mixing measure.* This sentence will save you from the single most common error in the subject.

---

# PART I — JENSEN, THE BEDROCK

The tent is a Bayes risk, and a Bayes risk is a concave function, and the deep fact about concave functions is *when their defining inequality becomes an equality*. So we begin with convexity and Jensen, told completely, because the rigidity of the tent is a corollary of one short theorem you will own by the end of this part.

## I.1 Convex, concave, affine — the three relation symbols

**One-breath slogan.** *A function's chord is above it (convex), below it (concave), or on it (affine); affine is the razor's edge, and "both convex and concave" forces a straight line.*

Fix an interval $I\subseteq\mathbb R$ — a set with no gaps, like $[0,1]$. The crucial structural fact, the one quietly powering everything: if $x_1,x_2\in I$ and $p\in[0,1]$, the **mixture** $px_1+(1-p)x_2$ stays in $I$. You can blend any two points in any ratio and not leave the interval. Say it out loud: *intervals are closed under mixing.*

A function $G:I\to\mathbb R$ is:

- **convex** if $\ G(px_1+(1-p)x_2)\le pG(x_1)+(1-p)G(x_2)$ for all $x_1,x_2,p$ — the graph never rises above the straight chord joining $(x_1,G(x_1))$ and $(x_2,G(x_2))$. Bowl-shaped. Example: $x^2$.
- **concave** if the inequality flips, $\ge$ — the graph never dips below its chords. Dome-shaped. Example: $\sqrt x$, or $-x^2$, or the tent.
- **affine** if $G(x)=ax+b$ — a straight line. Both convex and concave at once.

Stare at the three displayed lines. They are *the same equation with three different relation symbols* ($\le$, $\ge$, $=$). That single observation is the seed of the whole subject: **equality in Jensen's inequality is a rigidity condition**, and rigidity is what manufactures the tent.

**Worked instance (convexity of $x^2$, fully).** Take $G(x)=x^2$. We show $pG(x_1)+(1-p)G(x_2)-G(px_1+(1-p)x_2)\ge 0$. Expand:
$$
px_1^2+(1-p)x_2^2-\big(px_1+(1-p)x_2\big)^2.
$$
The square is $p^2x_1^2+2p(1-p)x_1x_2+(1-p)^2x_2^2$. Subtracting,
$$
=\big(p-p^2\big)x_1^2+\big((1-p)-(1-p)^2\big)x_2^2-2p(1-p)x_1x_2
=p(1-p)\big(x_1^2-2x_1x_2+x_2^2\big)=p(1-p)(x_1-x_2)^2.
$$
Since $p\in[0,1]$ gives $p(1-p)\ge 0$, and a square is $\ge 0$, the whole thing is $\ge 0$: $x^2$ is convex, *strictly* unless $x_1=x_2$ or $p\in\{0,1\}$. **Memory hook:** "convexity gap $=p(1-p)\,(\text{spread})^2$." The gap is the *variance* of the two-point distribution times nothing else — a fact we will reuse.

**Worked instance (affine ⇒ both, fully).** If $G(x)=ax+b$, then
$$
G(px_1+(1-p)x_2)=a\big(px_1+(1-p)x_2\big)+b,
$$
while
$$
pG(x_1)+(1-p)G(x_2)=p(ax_1+b)+(1-p)(ax_2+b)=a\big(px_1+(1-p)x_2\big)+b(p+1-p).
$$
The two are identical because $p+(1-p)=1$. So an affine $G$ turns the inequality into an *equality* for every choice of inputs. This "commutes with mixing" property is the easy half of the rigidity theorem; hold it close.

**Edge case — adding a line changes nothing.** If $G$ is convex and $H(x)=G(x)+cx+d$, then $H$ is convex too: the $G$-part obeys $\le$, the affine part obeys $=$, and adding $\le$ to $=$ gives $\le$. **Slogan:** *convexity is blind to affine shifts.* Equivalently, the "interesting" content of a convex function is its *nonlinear part*. This is why, again and again, we will identify functions "up to an additive line" — the affine part carries no information about curvature, risk, or divergence.

## I.2 Jensen's inequality, in the only generality we need

**One-breath slogan.** *Average-then-transform sits below transform-then-average, for concave functions.*

We never need general probability. We need a **coin**. Fix $u_1,u_2\in I$ and a bias $p\in[0,1]$, and let $\xi$ be the random variable equal to $u_1$ with probability $p$ and $u_2$ with probability $1-p$. Its average is $\mathbb E[\xi]=pu_1+(1-p)u_2$. Apply $G$ first, then average: $\mathbb E[G(\xi)]=pG(u_1)+(1-p)G(u_2)$.

These are *exactly* the two sides of the convexity inequality. So convexity says $\mathbb E[G(\xi)]\ge G(\mathbb E[\xi])$ and concavity says
$$
\boxed{\ \mathbb E[G(\xi)]\ \le\ G(\mathbb E[\xi]).\ }
$$
This is **Jensen's inequality** (concave version). Every "the expected uncertainty is at most the uncertainty of the average" statement in this reader is this one line. **Memory hook:** picture a dome; the chord connecting two points on a dome lies *under* the dome, so the averaged value (on the chord) is below the dome value (at the average). *Concave = dome = average below.*

**Worked instance ($\sqrt{\cdot}$, fully).** Let $G(x)=\sqrt x$ on $[0,1]$, $u_1=0$, $u_2=1$, $p=\tfrac12$. Then $\mathbb E[G(\xi)]=\tfrac12\sqrt0+\tfrac12\sqrt1=\tfrac12$, while $G(\mathbb E[\xi])=\sqrt{\tfrac12}\approx0.707$. Indeed $0.5\le0.707$ — Jensen, strictly, because $\sqrt{}$ is strictly concave. The gap $0.207$ is "how much the dome bulges above its chord at the midpoint."

## I.3 The equality question and the equation $(\star)$

Jensen is an inequality. The entire engine of the tent is the question: **for which $G$ is it an equality, for *every* two-point distribution?** Written out, "for every two-point distribution" means "for all $u_1,u_2\in I$ and all $p\in[0,1]$," so the equality condition is the functional equation
$$
pG(u_1)+(1-p)G(u_2)=G\big(pu_1+(1-p)u_2\big)\qquad(u_1,u_2\in I,\ p\in[0,1]).\tag{$\star$}
$$
This is the **continuous-coefficient Jensen equation**: "continuous-coefficient" because $p$ ranges over the whole continuum $[0,1]$, every real number, not just nice fractions. By I.1 you already know every affine $G$ solves $(\star)$. The depth is in the converse, and the converse is one line.

## I.4 The one-line rigidity theorem (the engine)

**One-breath slogan.** *Plug in the two endpoints; the mixture lands exactly on your target; $G$ is forced to be the endpoint chord — with no fine print.*

> **Theorem I.1 (Endpoint substitution).** Let $M>0$ and $G:[0,M]\to\mathbb R$ satisfy $(\star)$. Then $G$ is affine:
> $$
> G(v)=G(0)+\frac{G(M)-G(0)}{M}\,v,\qquad v\in[0,M].
> $$
> No continuity, measurability, monotonicity, or boundedness is assumed. They are all *conclusions*.

**Proof, in full.** Fix any target $v\in[0,M]$. Make the single substitution
$$
u_1:=M,\qquad u_2:=0,\qquad p:=\frac{v}{M}.
$$
Legality: $M\in[0,M]$, $0\in[0,M]$, and $p=v/M\in[0,1]$ because $0\le v\le M$. Now $(\star)$ reads
$$
\underbrace{\tfrac{v}{M}\,G(M)+\big(1-\tfrac{v}{M}\big)G(0)}_{pG(u_1)+(1-p)G(u_2)}=G\Big(\underbrace{\tfrac{v}{M}\cdot M+\big(1-\tfrac{v}{M}\big)\cdot 0}_{pu_1+(1-p)u_2}\Big)=G(v).
$$
The mixture collapsed to exactly $v$. Rearranging the left side,
$$
G(v)=G(0)+\frac{v}{M}\big(G(M)-G(0)\big).
$$
Since $v$ was arbitrary, $G$ equals this fixed straight line everywhere, hence *is* that line. $\blacksquare$

**Why the absence of hypotheses is the headline (proved).** A straight line $G(v)=av+b$ on a bounded interval is automatically continuous (no jumps), monotone (up if $a\ge0$, down if $a\le0$), Lipschitz with constant $|a|$, bounded (it runs between its two endpoint values), and measurable (continuous functions are). So:

> **Corollary I.2.** Any solution of $(\star)$ is automatically continuous, monotone, Lipschitz, bounded, and measurable. For the equation $(\star)$, these five "regularity" properties are *free outputs*, never required inputs.

This reversal — regularity as conclusion, not hypothesis — is the conceptual heart, and it is exactly what makes the tent's apex-continuity free (Part II). **Slogan to memorize:** *for $(\star)$, regularity is a conclusion.*

**The strict-minimum refinement (proved, and worth internalizing).** The proof touched only the configuration $u_1=M,u_2=0$. So the *weaker* hypothesis "$pG(M)+(1-p)G(0)=G(pM)$ for all $p\in[0,1]$" already forces affineness — identical one line. And once $G$ is affine, *full* $(\star)$ holds as a consequence. So the weak hypothesis implies the strong conclusion implies the strong hypothesis: there is no slack. **Edge case worth flagging:** people sometimes worry the theorem is "too strong." It is not — it is just that the endpoint configuration is already maximally informative, because the endpoints' mixtures sweep the entire interval.

## I.5 Why the *continuum* of weights is essential — the cousin that fails

**One-breath slogan.** *Freeze $p$ at a half and you get Cauchy's equation, whose monsters are dense in the plane; the continuum of real weights is exactly what slays them.*

We must understand why $(\star)$ is special, or we will misuse it (Part VII). Freeze $p=\tfrac12$ in $(\star)$:
$$
G\Big(\frac{u_1+u_2}{2}\Big)=\frac{G(u_1)+G(u_2)}{2}.\tag{$J_2$}
$$
Set $f(x):=G(x)-G(0)$ (slide the graph through the origin). A short computation turns $(J_2)$ into **Cauchy's functional equation**
$$
f(x+y)=f(x)+f(y).\tag{Cauchy}
$$
(Derivation, in full: $(J_2)$ for $G$ becomes $f(\tfrac{x+y}2)=\tfrac{f(x)+f(y)}2$ after the constants cancel; setting $y=0$ gives $f(\tfrac x2)=\tfrac{f(x)}2$ using $f(0)=0$; then $f(\tfrac{x+y}2)=\tfrac12 f(x+y)$, so $\tfrac12 f(x+y)=\tfrac12(f(x)+f(y))$, i.e. $f(x+y)=f(x)+f(y)$.)

From additivity alone you can extract scaling by **rationals** — and only rationals. Step by step (all proved):
- $f(0)=2f(0)\Rightarrow f(0)=0$.
- $f(nx)=nf(x)$ for positive integers by induction: $f(2x)=2f(x)$, and $f((n{+}1)x)=f(nx)+f(x)=(n{+}1)f(x)$.
- $f(-x)=-f(x)$ from $f(x)+f(-x)=f(0)=0$.
- $f(x/n)=f(x)/n$ from $f(x)=nf(x/n)$.
- Hence for every rational $q=m/n$: $f(qx)=qf(x)$. This is **$\mathbb Q$-homogeneity**.

But $\mathbb Q$-homogeneity is **not** $\mathbb R$-homogeneity. An additive $f$ may fail to satisfy $f(\sqrt2\,x)=\sqrt2\,f(x)$. If it scaled by *every* real factor, then $f(x)=f(x\cdot1)=x\,f(1)$ would be a straight line — tame, done. The entire pathology is the *failure of scaling at irrational factors*. **Memorize this sentence:** *the monster lives at irrational weights.*

**The monster, constructed (told completely).** View $\mathbb R$ as a vector space over the scalar field $\mathbb Q$. A basis of this space — a **Hamel basis** $H$ — exists by the axiom of choice; every real is a unique *finite* $\mathbb Q$-combination of basis elements. Pick a basis containing $1$ and an irrational $h\in(0,1)$ (always arrangeable: take any irrational basis vector $h'$; some nonzero rational multiple $h=qh'$ lands in $(0,1)$, and rescaling one basis vector keeps it a basis). Define $\ell$ on the basis by $\ell(1)=0$, $\ell(h)=1$, anything elsewhere, and extend $\mathbb Q$-linearly. Then for every rational $r$ and $q$,
$$
\ell(q+rh)=q\cdot 0+r\cdot 1=r.
$$
For fixed $r$, the set $\{q+rh:q\in\mathbb Q\}$ is a shifted copy of $\mathbb Q$ — **dense** in $\mathbb R$. So $\ell$ equals $r$ on a dense set, *for every rational $r$*: the graph of $\ell$ is **dense in the entire plane**. Such $\ell$ is nowhere continuous, unbounded on every subinterval, non-measurable — it violates all five regularity properties maximally, yet it solves $(J_2)$ and the rational-weight Jensen equation. **This is why $(J_2)\Rightarrow$ affine is false without a hypothesis**, and why the classical theorems of Cauchy, Darboux, Sierpiński, Ostrowski, and Kestelman each bolt on one regularity property to kill it.

**Where, precisely, the monster fails $(\star)$ (the punchline).** Put $u_1=M$, $u_2=0$ into $(\star)$ for a monster $G$ with $G(0)=0$:
$$
pG(M)=G(pM).\tag{$\star_0$}
$$
This says "$G$ scales by the real factor $p$." The monster satisfies it for every *rational* $p$ but *fails* it at some *irrational* $p$ — that failure is the very definition of being a monster. So:

> The continuum equation $(\star)$ tests the identity at irrational weights, exactly the weights the rational equation cannot reach, and the monster dies on contact. **That is why Theorem I.1 needs no fine print and a century of analysis around $(J_2)$ does.**

**Edge case (the deepest one in Part I).** The monster exists *only because we admit the axiom of choice*. In Solovay's model of set theory, where choice is weakened so that "all sets are measurable," every solution of Cauchy's equation is automatically affine. So the necessity of a regularity hypothesis for $(J_2)$ is, at bottom, a fact about set theory — whereas Theorem I.1 needs nothing set-theoretic, because it never relies on a basis. This is worth carrying: the tent's rigidity is *more elementary* than the Cauchy pathology it sidesteps.

---

### You can now say… (Part I recall ladder — each statement is a flashcard; the answer follows it)

- *"State Jensen for a two-point law."* — For concave $G$ and $\xi$ taking $u_1,u_2$ with weights $p,1-p$: $pG(u_1)+(1-p)G(u_2)\le G(pu_1+(1-p)u_2)$.
- *"What is the convexity gap of $x^2$ on a two-point law?"* — $p(1-p)(x_1-x_2)^2$ — the variance.
- *"State and prove the rigidity theorem in one line."* — $(\star)\Rightarrow$ affine, via $u_1=M,u_2=0,p=v/M$, giving $G(v)=G(0)+\frac{G(M)-G(0)}M v$.
- *"Why is regularity not needed?"* — Because affineness is concluded, and a line on a bounded interval is automatically continuous, monotone, Lipschitz, bounded, measurable (Cor. I.2).
- *"Why does the rational cousin $(J_2)$ fail?"* — It reduces to Cauchy's equation, whose Hamel solutions are dense in the plane; $\mathbb Q$-homogeneity is not $\mathbb R$-homogeneity, and the monster lives at irrational weights.
- *"What single feature of $(\star)$ kills the monster?"* — It tests the scaling identity at irrational weights, which the rational equation never reaches.

**Carry one sentence out of Part I:** *Equality in Jensen, asserted at every real weight, forces a straight line — for free.* The tent is what happens when you assert equality only on *pieces* of the interval. That is Part II.

---

# PART II — THE TENT ITSELF

This is the centerpiece. By the end you can draw the tent, name its apex, height, and slopes from memory, derive its regret with a margin interpretation, prove its switching symmetry, see why its endpoints collapse, and — the crown — see that *exactness on pieces forces the tent and nothing else*, with apex-continuity free of charge.

## II.1 The cost-weighted loss — the primitive

**One-breath slogan.** *Threshold the prediction at $c$; pay $c$ for a false alarm, $1-c$ for a miss, nothing for a correct call.*

The simplest interesting loss in binary decision-making fixes a cost dial $c\in[0,1]$ and uses the threshold rule "predict $1$ iff your number $\hat\eta\ge c$." Its loss is
$$
\ell_c(y,\hat\eta)=c\,\llbracket y=0\rrbracket\,\llbracket\hat\eta\ge c\rrbracket\;+\;(1-c)\,\llbracket y=1\rrbracket\,\llbracket\hat\eta<c\rrbracket.
$$
Read the two terms. The first fires only when the truth is $0$ but you predicted $1$ (a **false positive**), and charges $c$. The second fires only when the truth is $1$ but you predicted $0$ (a **false negative**), and charges $1-c$. Correct calls cost nothing. The dial $c$ encodes *how much you fear a false alarm relative to a miss*. **Memory hook:** "$c$ is the price of crying wolf." When $c$ is large you are reluctant to predict $1$ (a false alarm is expensive); when $c$ is small you predict $1$ readily.

Why is this *the* primitive and not just one loss among many? Because — Part III — *every* proper loss is a weighted pile of these, and *nothing simpler* can express them. The $\ell_c$ are the atoms.

## II.2 Conditional risk of the cost-weighted loss

**One-breath slogan.** *Average the loss over the true label: a single line in $\eta$, with a switch at the threshold.*

At posterior $\eta$, the truth is $1$ with probability $\eta$ and $0$ with probability $1-\eta$. So the expected loss of predicting via $\hat\eta$ is
$$
L_c(\eta,\hat\eta)=\mathbb E_{Y\sim\eta}\,\ell_c(Y,\hat\eta)=(1-\eta)\,c\,\llbracket\hat\eta\ge c\rrbracket+\eta\,(1-c)\,\llbracket\hat\eta<c\rrbracket.
$$
For a *fixed* decision $\llbracket\hat\eta\ge c\rrbracket$, this is affine in $\eta$ (a constant plus a constant times $\eta$). Only the binary decision matters, not the exact value of $\hat\eta$.

## II.3 The Bayes risk — the tent, derived in full

**One-breath slogan.** *Pick the cheaper of two lines; their lower envelope is a tent peaking at $\eta=c$.*

The Bayes risk is the smallest achievable conditional risk: $L_c(\eta)=\inf_{\hat\eta}L_c(\eta,\hat\eta)$. Write $b:=\llbracket\hat\eta\ge c\rrbracket\in\{0,1\}$, the only thing under your control. Using $\llbracket\hat\eta<c\rrbracket=1-b$,
$$
L_c(\eta,\hat\eta)=\eta(1-c)(1-b)+(1-\eta)c\,b=\eta(1-c)+b\big[(1-\eta)c-\eta(1-c)\big].
$$
Simplify the bracket: $(1-\eta)c-\eta(1-c)=c-\eta c-\eta+\eta c=c-\eta$. So
$$
L_c(\eta,\hat\eta)=\eta(1-c)+b\,(c-\eta),\qquad b\in\{0,1\}.
$$
Minimize over $b$:
- If $c-\eta<0$ (i.e. $\eta>c$): choose $b=1$. Value $=\eta(1-c)+(c-\eta)=c-\eta c=c(1-\eta)$.
- If $c-\eta>0$ (i.e. $\eta<c$): choose $b=0$. Value $=\eta(1-c)$.

Both cases are "take the smaller piece," so
$$
\boxed{\;L_c(\eta)=\min\{(1-\eta)\,c,\ (1-c)\,\eta\}.\;}
$$
This is the **tent**. **(Reid–Williamson Theorem 14.)**

## II.4 Apex, height, slopes — the three numbers to know cold

**One-breath slogan.** *Apex at $\eta=c$, height $c(1-c)$; rises with slope $1-c$, falls with slope $-c$.*

Read everything off the two linear pieces:

- The **rising** piece $(1-c)\eta$ starts at $0$ (when $\eta=0$) and climbs with **slope $1-c$**.
- The **falling** piece $(1-\eta)c=c-c\eta$ starts at $c$ (when $\eta=0$), ends at $0$ (when $\eta=1$), and descends with **slope $-c$**.
- They cross where $(1-\eta)c=(1-c)\eta$, i.e. $c-c\eta=\eta-c\eta$, i.e. $\eta=c$. The **apex** sits at $\eta=c$, with **height** $L_c(c)=(1-c)c=c(1-c)$.
- It is **concave** — a minimum of two lines is always concave (a downward kink).

**Mnemonic (say it):** "*Apex at the cost, height cost-times-co-cost, rise by co-cost, fall by cost*," where "co-cost" $=1-c$. The asymmetry of the slopes ($1-c$ up, $c$ down) is what tilts the tent; only at $c=\tfrac12$ are they equal and the tent symmetric.

**Three worked tents (unrolled).**

*Balanced, $c=\tfrac12$:* $L_{1/2}(\eta)=\min\{\tfrac12(1-\eta),\tfrac12\eta\}=\tfrac12\min(\eta,1-\eta)$. Apex $(\tfrac12,\tfrac14)$, slopes $+\tfrac12$ then $-\tfrac12$. Symmetric.

*Cheap false alarms, $c=\tfrac13$:* $L_{1/3}(\eta)=\min\{\tfrac13(1-\eta),\tfrac23\eta\}$. Apex at $\eta=\tfrac13$, height $\tfrac13\cdot\tfrac23=\tfrac29$. Rises steeply (slope $\tfrac23$) until $\tfrac13$, then falls gently (slope $-\tfrac13$). Left-leaning peak.

*Expensive false alarms, $c=\tfrac34$:* $L_{3/4}(\eta)=\min\{\tfrac34(1-\eta),\tfrac14\eta\}$. Apex at $\eta=\tfrac34$, height $\tfrac34\cdot\tfrac14=\tfrac3{16}$. Rises gently (slope $\tfrac14$), falls steeply (slope $-\tfrac34$). Right-leaning peak.

## II.5 The $0$–$1$ normalization — and the factor of two, again

**One-breath slogan.** *Doubling the balanced tent gives the $0$–$1$ error floor $\min(\eta,1-\eta)$; that doubling is the factor of two that haunts the subject.*

Ordinary misclassification ($0$–$1$) loss charges $1$ for any error, $0$ for a correct call. Comparing to $\ell_{1/2}$, which charges $\tfrac12$ for either error, we have $\ell^{0\text{-}1}=2\,\ell_{1/2}$, hence the $0$–$1$ Bayes risk is
$$
2\,L_{1/2}(\eta)=2\cdot\tfrac12\min(\eta,1-\eta)=\min(\eta,1-\eta).
$$
This is the **error floor**: the smallest misclassification rate any predictor can achieve at posterior $\eta$. Its apex is $(\tfrac12,\tfrac14)$ — at maximal uncertainty $\eta=\tfrac12$ you are wrong a quarter of the time no matter what (you guess the majority class, which is right with probability $\tfrac12$... and the floor is $\tfrac14$ after the $2\ell_{1/2}$ scaling versus $\tfrac12$ before; this scaling discipline is exactly the trap).

**The trap, stated as a standing order.** The manuscript writes the apexed tent as $T_\theta(u)=2\min(u(1-\theta),(1-u)\theta)$, apex $(\theta,\,2\theta(1-\theta))$. Comparing apexes and heights with $L_c$ gives
$$
\boxed{\,T_\theta=2\,L_\theta.\,}
$$
The $2$ is *exactly* the $\ell^{0\text{-}1}=2\ell_{1/2}$ relation promoted to the whole family. Neither convention is wrong; they are different units. When you carry a mixing weight from one paper into the other (Part III), the $2$ rescales it. **Say it before every mixture computation:** "*Which tent — Reid's $L_c$ or the doubled $T_\theta$?*"

## II.6 The regret of the cost-weighted loss — a margin you only pay at a flip

**One-breath slogan.** *You pay cost-weighted regret only when your estimate and the truth fall on opposite sides of the threshold, and then the price is the margin $|\eta-c|$.*

The **regret** of an estimate $\hat\eta$ against truth $\eta$ is the excess over the Bayes risk: $B_c(\eta,\hat\eta)=L_c(\eta,\hat\eta)-L_c(\eta)$. Here is the clean formula and its complete proof.

> **Lemma II.1 (Reid–Williamson Lemma 26).**
> $$
> B_c(\eta,\hat\eta)=|\eta-c|\cdot\llbracket\,\eta\wedge\hat\eta<c\le\eta\vee\hat\eta\,\rrbracket.
> $$
> In words: zero unless $c$ separates $\eta$ and $\hat\eta$; if it does, the regret is the margin $|\eta-c|$.

**Proof, in full.** Recall the Bayes risk picks the smaller line: since $(1-\eta)c-(1-c)\eta=c-\eta$, we have $(1-\eta)c\le(1-c)\eta\iff c\le\eta$, so
$$
L_c(\eta)=(1-\eta)c\,\llbracket\eta\ge c\rrbracket+(1-c)\eta\,\llbracket\eta<c\rrbracket.
$$
The conditional risk is $L_c(\eta,\hat\eta)=(1-\eta)c\,\llbracket\hat\eta\ge c\rrbracket+(1-c)\eta\,\llbracket\hat\eta<c\rrbracket$. Subtract:
$$
B_c(\eta,\hat\eta)=(1-\eta)c\big(\llbracket\hat\eta\ge c\rrbracket-\llbracket\eta\ge c\rrbracket\big)+(1-c)\eta\big(\llbracket\hat\eta<c\rrbracket-\llbracket\eta<c\rrbracket\big).
$$
The two parenthesized differences are negatives of each other. Each is $+1$, $-1$, or $0$:
- **$\hat\eta\ge c>\eta$** (so $\eta<c\le\hat\eta$): first difference $=+1$, second $=-1$. Then $B_c=(1-\eta)c-(1-c)\eta=c-\eta=|\eta-c|$ (since $\eta<c$).
- **$\eta\ge c>\hat\eta$** (so $\hat\eta<c\le\eta$): first difference $=-1$, second $=+1$. Then $B_c=-(1-\eta)c+(1-c)\eta=\eta-c=|\eta-c|$ (since $\eta\ge c$).
- **Otherwise** (both on the same side of $c$): both differences $0$, so $B_c=0$.

The two nonzero cases are exactly "$c$ lies strictly above the smaller of $\eta,\hat\eta$ and at-or-below the larger," i.e. $\eta\wedge\hat\eta<c\le\eta\vee\hat\eta$. $\blacksquare$

**The intuition you must internalize.** Cost-weighted regret is a *decision* quantity, not an *estimation* quantity. If your estimate $\hat\eta$ is on the same side of the threshold $c$ as the truth $\eta$, you make the *same decision* the oracle makes, and you pay nothing — even if $\hat\eta$ is wildly off as a *number*. You only pay when you *flip the decision*, and then you pay the margin by which the truth sat from the boundary. **Slogan:** *no flip, no regret; on a flip, you pay the margin.* This is the single most clarifying fact about why $0$–$1$-type losses are insensitive to calibration and why surrogate losses (Part IV) are needed to control the *number* $\hat\eta$.

## II.7 The switching symmetry — proved

**One-breath slogan.** *Reflecting the posterior and swapping the cost leave the tent unchanged: $L_c(1-\eta)=L_{1-c}(\eta)$.*

> **Lemma II.2 (Reid–Williamson Theorem 15, pointwise form).** For all $\eta,c\in[0,1]$,
> $$
> L_c(1-\eta)=L_{1-c}(\eta).
> $$

**Proof, in full.** Compute both sides as a min of two numbers.
$$
L_c(1-\eta)=\min\{(1-(1-\eta))\,c,\ (1-c)(1-\eta)\}=\min\{\eta c,\ (1-c)(1-\eta)\}.
$$
$$
L_{1-c}(\eta)=\min\{(1-\eta)(1-c),\ (1-(1-c))\,\eta\}=\min\{(1-\eta)(1-c),\ c\eta\}.
$$
Both are the minimum of the *same two numbers* $\{c\eta,\ (1-c)(1-\eta)\}$. Equal. $\blacksquare$

**Consequence (population form).** For the statistical information $\Delta L_c$ (defined in II.9) this lifts to $\Delta L_c(1-\eta,M)=\Delta L_{1-c}(\eta,M)$: relabeling the classes ($\eta\leftrightarrow1-\eta$) and the cost ($c\leftrightarrow1-c$) is a symmetry of the whole theory. **Memory hook:** "*flip the coin, flip the price, nothing changes.*" There is a second interchange (prior $\pi\leftrightarrow1-c$) of the same flavor; both express that the tent family is invariant under the obvious relabelings, which is why one can always normalize to $c=\tfrac12$ or $\pi=\tfrac12$ in proofs.

## II.8 The degenerate endpoints — an edge case that explains the whole mixture theory

**One-breath slogan.** *At $c=0$ and $c=1$ the tent collapses to the zero function — the costs with no decision — and that collapse is exactly why the mixing weight can blow up at the ends harmlessly.*

Plug in the extreme costs:
$$
L_0(\eta)=\min\{(1-\eta)\cdot0,\ 1\cdot\eta\}=\min\{0,\eta\}=0,\qquad
L_1(\eta)=\min\{(1-\eta)\cdot1,\ 0\cdot\eta\}=\min\{1-\eta,0\}=0.
$$
Both are identically zero. At $c=0$ a false positive is free, so you always predict $1$ and never regret; at $c=1$ a false negative is free, so you always predict $0$. There is no decision to make; the irreducible loss is zero. **Why this matters for everything downstream:** the tents *fade to nothing* as $c\to0$ or $c\to1$. So when we write a loss as a pile of tents $\int_0^1 L_c\,w(c)\,dc$ (Part III), the weight $w(c)$ may *diverge* at the endpoints (as it does for log loss, $w=1/(c(1-c))$) and the integral can still converge, because it is multiplying a vanishing tent. The endpoints are where mass piles up *because* the tents there are weightless. Hold this; it is the secret behind "KL-divergence is hard to estimate" (Part III).

## II.9 Statistical information — the tent as a baseline you improve on

**One-breath slogan.** *Statistical information is how much expected tent-risk you remove by knowing the data-dependent posterior instead of the flat prior.*

Let $\pi=\mathbb E[\eta]$ be the prior (the average posterior). DeGroot's **statistical information** is the expected drop in Bayes risk from prior to posterior,
$$
\Delta L(\eta,M):=L(\pi)-\mathbb E\,[L(\eta)]\ \ge\ 0,
$$
nonnegative by Jensen (concave $L$, so the average of $L(\eta)$ is below $L$ of the average $\pi$). For the cost-weighted tent, $\Delta L_c$ is the expected reduction in cost-$c$ misclassification risk you gain from a feature that moves $\eta$ away from $\pi$. **Picture:** the flat-prior predictor sits *on the tent* at $\eta=\pi$; a useful feature pulls the operating point *below* the tent; the gap is the information. We will see in Part V that the tent is literally the *upper boundary* of achievable risk curves — the "no information" ceiling — and that everything realizable lives under it.

## II.10 The rigidity — exactness on pieces forces the tent (the crown)

**One-breath slogan.** *If Jensen holds with equality on each half of the interval, the only possible shape is a tent, and its apex-continuity is free.*

Now the result that ties the tent to Part I. Suppose an uncertainty function $G$ is **resolution-blind on each cell**: it satisfies $(\star)$ for all $u_1,u_2$ in a common piece of a partition. Then:

> **Theorem II.3 (Piecewise saturation).** If $G$ satisfies $(\star)$ on each cell $[m_{i-1},m_i]$ of a partition $0=m_0<\dots<m_k=1$, then $G$ is affine on each cell — hence **piecewise linear** — and **automatically continuous at every knot**, with no regularity assumed.

**Proof, in full.** On a single cell $[m_{i-1},m_i]$, rescale by the affine map $t\mapsto m_{i-1}+(m_i-m_{i-1})t$ sending $[0,1]$ onto the cell. Mixing commutes with this affine reparametrization, so the rescaled $G$ satisfies $(\star)$ on $[0,1]$; by Theorem I.1 it is affine there, hence $G$ is affine on the cell. At an interior knot $m_i$, the two affine formulas from the adjacent cells are each pinned to pass through the cell's endpoint data, so both evaluate to the same number $G(m_i)$ — they meet. Continuity at the knot is therefore a *consequence*, not a hypothesis. $\blacksquare$

For the two-cell partition $\{[0,\tfrac12],[\tfrac12,1]\}$, the forced shape is two line segments meeting at $\tfrac12$ — **a tent**. The apex continuity you would reflexively assume is delivered by the theorem. So:

> **The tent is not an example; it is the *unique* shape that cellwise exactness permits.** Reid–Williamson tell you *which* tent (the cost-weighted Bayes risk, apex at $c$, height $c(1-c)$ — the *content*); the rigidity theorem tells you *why no other shape is possible* and that its continuity is free (the *rigidity*).

**Edge case (why "blind on each cell" and not "blind everywhere").** If $G$ were blind on the *whole* interval (one cell), Theorem I.1 forces it fully affine — a single straight line, no apex, no tent. The tent appears precisely because exactness holds *within* pieces but is allowed to *break at the seam*. The break at the seam is the apex; the curvature of the world lives entirely at the seams. This is the seed of the mixture calculus: a general uncertainty function is "exact between its kinks," and its kinks (its curvature) are where all the information sits. Part III turns "kinks" into the measure $w=-L''$.

---

### You can now say… (Part II recall ladder)

- *"Write the tent and its three numbers."* — $L_c(\eta)=\min\{(1-\eta)c,(1-c)\eta\}$; apex $(c,\,c(1-c))$; slopes $+(1-c)$ then $-c$.
- *"Derive the tent from the cost-weighted loss."* — $L_c(\eta,\hat\eta)=\eta(1-c)+b(c-\eta)$, minimize the binary $b$, get the lower envelope of two lines.
- *"State the cost-weighted regret and its meaning."* — $B_c=|\eta-c|\,\llbracket c \text{ separates } \eta,\hat\eta\rrbracket$; no flip, no regret; on a flip, pay the margin.
- *"Prove the switching symmetry."* — $L_c(1-\eta)$ and $L_{1-c}(\eta)$ are both $\min\{c\eta,(1-c)(1-\eta)\}$.
- *"What happens at $c=0,1$ and why does it matter?"* — The tent is identically $0$; this lets the mixing weight diverge at the ends harmlessly (Part III).
- *"State the rigidity that forces the tent."* — Cellwise $(\star)$ forces piecewise-affine with free apex-continuity (Thm II.3); the two-cell case is a tent.
- *"What is the factor of two?"* — $T_\theta=2L_\theta$, the $\ell^{0\text{-}1}=2\ell_{1/2}$ relation; rescales any mixing measure carried between conventions.

**Carry one sentence out of Part II:** *The tent is the cost-weighted error floor and simultaneously the unique shape cellwise exactness allows; its curvature lives entirely at its apex.* Part III makes "curvature lives at the kinks" into a precise calculus — and shows every loss in the textbook is a pile of tents.

---

# PART III — THE MIXTURE CALCULUS: EVERY LOSS IS A PILE OF TENTS

The tents are the atoms. This part proves that *every* proper loss is a weighted superposition of tents, identifies the weight as the curvature $-L''$, runs a gallery of standard losses with their weights derived in full, and explains — as a corollary of "curvature is mass" — exactly why some divergences are statistically hard. It closes with the bridge to $f$-divergences, where the tent turns out to be the shared primitive of *two* theories.

## III.1 The integral representation — curvature is mass

**One-breath slogan.** *Stack the tents with weight equal to the negative second derivative of the Bayes risk: $L(\eta)=\int_0^1 L_c(\eta)\,w(c)\,dc$, $w=-L''\ge0$.*

> **Theorem III.1 (Reid–Williamson Theorem 16, Bayes-risk form).** For a fair proper loss with concave Bayes risk $L$,
> $$
> L(\eta)=\int_0^1 L_c(\eta)\,w(c)\,dc,\qquad w(c)=-L''(c)\ \ge 0.
> $$
> Equivalently, at the level of the loss itself, $\ell(y,\hat\eta)=\int_0^1 \ell_c(y,\hat\eta)\,w(c)\,dc$.

Two facts to lock in. First, **the weight is the curvature**: $w(c)=-L''(c)$. Because $L$ is concave (Part II.3, a min of lines; in general a Bayes risk is an inf of lines), $L''\le 0$, so $w\ge 0$ — the weights are nonnegative, as any genuine mixing measure must be. Second, **where $L$ bends, tents pile up**; where $L$ is already straight, $w=0$ and no tent is needed. A straight stretch of an uncertainty function is "free of decisions"; the curvature marks where decisions cost something.

**Why it is true (the honest sketch, then two airtight checks).** A concave $L$ on $[0,1]$ that vanishes at the endpoints is reconstructed from its curvature by the second-order Taylor/Green's-function identity (Part VI makes the Green's function explicit): $L(\eta) = -\int_0^1 \psi(\eta,c)\,L''(c)\,dc$ where $\psi(\eta,c)=\min\{(1-c)\eta,(1-\eta)c\}$ is exactly the (unnormalized) tent. Since $\psi(\eta,c)=L_c(\eta)$ and $-L''=w$, this is the claim. Rather than belabor the general identity, we **verify it on the two losses every expert will ask about**, in full.

*Check 1 — square loss.* $L(\eta)=\eta(1-\eta)$, so $L'(\eta)=1-2\eta$, $L''(\eta)=-2$, hence $w(c)=2$ (uniform). We need $\int_0^1 L_c(\eta)\cdot 2\,dc=\eta(1-\eta)$. Compute the base integral by splitting at $c=\eta$ (where the tent's $\min$ switches: for $c<\eta$, $(1-\eta)c\le(1-c)\eta$, so $L_c=(1-\eta)c$; for $c>\eta$, $L_c=(1-c)\eta$):
$$
\int_0^1 L_c(\eta)\,dc=\int_0^\eta(1-\eta)c\,dc+\int_\eta^1(1-c)\eta\,dc
=(1-\eta)\tfrac{\eta^2}{2}+\eta\Big[c-\tfrac{c^2}{2}\Big]_\eta^1.
$$
The second bracket is $(1-\tfrac12)-(\eta-\tfrac{\eta^2}2)=\tfrac12-\eta+\tfrac{\eta^2}2$. So the sum is $\tfrac{\eta^2}2-\tfrac{\eta^3}2+\tfrac\eta2-\eta^2+\tfrac{\eta^3}2=\tfrac\eta2-\tfrac{\eta^2}2=\tfrac12\eta(1-\eta)$. Times the weight $2$: $\eta(1-\eta)=L(\eta)$. ✓

*Check 2 — log loss.* $L(\eta)=-\eta\ln\eta-(1-\eta)\ln(1-\eta)$ (binary entropy), so $L'(\eta)=\ln\frac{1-\eta}{\eta}$ and $L''(\eta)=-\frac1{1-\eta}-\frac1\eta=-\frac1{\eta(1-\eta)}$, hence $w(c)=\frac1{c(1-c)}$. We need $\int_0^1 L_c(\eta)\frac{dc}{c(1-c)}=L(\eta)$. Split at $c=\eta$ again:
$$
\int_0^\eta\frac{(1-\eta)c}{c(1-c)}dc+\int_\eta^1\frac{(1-c)\eta}{c(1-c)}dc
=(1-\eta)\int_0^\eta\frac{dc}{1-c}+\eta\int_\eta^1\frac{dc}{c}
=(1-\eta)[-\ln(1-c)]_0^\eta+\eta[\ln c]_\eta^1.
$$
This is $(1-\eta)(-\ln(1-\eta))+\eta(-\ln\eta)=-(1-\eta)\ln(1-\eta)-\eta\ln\eta=L(\eta)$. ✓

So the formula holds, the tents are the building blocks, and the weight is the curvature. **Memorize the slogan and the two checks** — they are the fastest way to convince a skeptic at the board.

## III.2 The extreme case — $0$–$1$ loss is a single tent

**One-breath slogan.** *The $0$–$1$ error floor is one tent at $c=\tfrac12$; its weight is a point mass $w=2\,\delta_{1/2}$.*

The $0$–$1$ Bayes risk is $L^{0\text{-}1}(\eta)=\min(\eta,1-\eta)=2L_{1/2}(\eta)$ (Part II.5). As a pile of tents this is concentrated entirely at $c=\tfrac12$:
$$
w^{0\text{-}1}(c)=2\,\delta(c-\tfrac12).
$$
Its "curvature" is a single spike — $L^{0\text{-}1}$ is straight on $[0,\tfrac12)$ and $(\tfrac12,1]$ with a kink at $\tfrac12$, so $-L''$ is a Dirac mass there (the slope drops by $1$, and the doubling makes it $2$). **This is the cleanest possible illustration that the tent is the atom:** the most fundamental loss is *exactly one* atom. Everything else is a smear of atoms across the cost axis. (We treat such point-mass and divergent weights rigorously as distributions in Part VI; for now, "a spike of mass" is the right picture.)

## III.3 The gallery of weights — derived, not quoted

**One-breath slogan.** *Each classical loss is a tent-smear; the shape of $w=-L''$ tells you which decision thresholds the loss cares about.*

For each loss we write the Bayes risk $L$, compute $w=-L''$, and read off where the mass concentrates. This is Reid–Williamson's Table 2, rebuilt by hand.

| Loss | Bayes risk $L(\eta)$ | Weight $w(c)=-L''(c)$ | Mass concentrates… |
|---|---|---|---|
| $0$–$1$ | $\min(\eta,1-\eta)$ | $2\,\delta(c-\tfrac12)$ | a spike at $\tfrac12$ |
| Square (Brier) | $\eta(1-\eta)$ | $2$ | uniform |
| Log / cross-entropy | $-\eta\ln\eta-(1-\eta)\ln(1-\eta)$ | $\dfrac{1}{c(1-c)}$ | diverges at $0,1$ |
| Exponential / boosting | $2\sqrt{\eta(1-\eta)}$ | $\dfrac12[c(1-c)]^{-3/2}$ | diverges $\sim c^{-3/2}$ at $0,1$ |
| "Sharpened Brier" $\eta(1-\eta)+[\eta(1-\eta)]^2$ | as written | $12\,c(1-c)$ | peaks at $\tfrac12$, vanishes at ends |

**Derivation — exponential/boosting, in full.** $L(\eta)=2\sqrt{\eta(1-\eta)}=2(\eta-\eta^2)^{1/2}$. Then $L'(\eta)=(1-2\eta)(\eta-\eta^2)^{-1/2}$. Differentiate again with the product rule:
$$
L''(\eta)=-2(\eta-\eta^2)^{-1/2}+(1-2\eta)\cdot\Big(-\tfrac12\Big)(\eta-\eta^2)^{-3/2}(1-2\eta).
$$
Factor out $(\eta-\eta^2)^{-3/2}$:
$$
L''(\eta)=(\eta-\eta^2)^{-3/2}\Big[-2(\eta-\eta^2)-\tfrac12(1-2\eta)^2\Big].
$$
The bracket: $-2\eta+2\eta^2-\tfrac12(1-4\eta+4\eta^2)=-2\eta+2\eta^2-\tfrac12+2\eta-2\eta^2=-\tfrac12$. So $L''(\eta)=-\tfrac12[\eta(1-\eta)]^{-3/2}$ and
$$
w(c)=-L''(c)=\tfrac12[c(1-c)]^{-3/2}.
$$
This blows up at the endpoints even faster than log loss — boosting cares *intensely* about extreme-cost decisions. ✓

**Derivation — "sharpened Brier," in full (and an edge-case check).** Let $s:=\eta(1-\eta)$, so $s'=1-2\eta$, $s''=-2$, and $L=s+s^2$. Then $L'=(1+2s)s'$ and
$$
L''=2(s')^2+(1+2s)s''=2(1-2\eta)^2-2(1+2s).
$$
So $w(c)=-L''=2(1+2s)-2(1-2\eta)^2$. With $s=\eta-\eta^2$: $w=2+4\eta-4\eta^2-2(1-4\eta+4\eta^2)=2+4\eta-4\eta^2-2+8\eta-8\eta^2=12\eta-12\eta^2=12\,\eta(1-\eta)$, i.e. $w(c)=12\,c(1-c)$. **Edge-case check (is it even a legal loss?):** a weight must be $\ge0$, equivalently $L$ must be concave. Here $w=12c(1-c)\ge0$ on $[0,1]$ ✓; and directly, $L''\le0\iff(1-2\eta)^2\le1+2s\iff 1-4\eta+4\eta^2\le1+2\eta-2\eta^2\iff 6\eta^2-6\eta\le0\iff 6\eta(\eta-1)\le0$, true on $[0,1]$. ✓ So "sharpened Brier" is a genuine uncertainty function whose tent mass is *removed* from the extremes and *piled* at the center — the precise opposite of log loss. **Lesson (say it):** *the shape of $w$ is a dial for which decision thresholds a loss rewards; reading $w$ off $-L''$ is reading the loss's priorities.*

## III.4 Why "curvature is mass" explains that KL is hard to estimate

**One-breath slogan.** *Log loss and KL pile their tent mass at the extreme costs, where the tents are weightless and the data are scarce, so the integral is dominated by the hardest-to-estimate region.*

Recall (Part II.8) the tents *vanish* at $c=0,1$. Log loss has weight $w(c)=1/(c(1-c))$, which *diverges* there. So the log-loss Bayes risk integral $\int_0^1 L_c\,w\,dc$ has enormous weight multiplying vanishing tents near the endpoints — the contribution near $c\approx0,1$ is delicate, and estimating it requires resolving the behavior of the posterior in the rare-event regimes (very small or very large $\eta$). This is exactly the analytic content of the folklore that **KL-divergence and log loss are hard to estimate from modest samples**: the estimator must nail the tails, where data are sparse. The fix that the weight picture suggests is equally clean — *truncate the divergent weight*: replace $w(c)=1/(c(1-c))$ by $1/(c(1-c))\cdot\llbracket\varepsilon\le c\le1-\varepsilon\rrbracket$, obtaining a regularized divergence that ignores the unestimable extremes. **This is a real method, read straight off the tent picture** — and it is the kind of remark that makes a surrogate-calibration expert nod: you are explaining a statistical phenomenon by the *geometry of where the tents pile up*.

## III.5 The reconstruction theorem — build the loss from the weight

**One-breath slogan.** *Integrate the weight twice and you recover the loss; the constants of integration are fixed by fairness.*

The mixture map is invertible: from a weight you can reconstruct the loss explicitly.

> **Theorem III.2 (Reid–Williamson Theorem 17).** Given a weight $w:[0,1]\to\mathbb R^+$, set $W(t)=\int^t w$ and $\overline W(t)=\int^t W$. Then
> $$
> \ell_w(y,\hat\eta)=-\overline W(\hat\eta)-(y-\hat\eta)\,W(\hat\eta)
> $$
> is a proper loss. If $\overline W(0),\overline W(1)$ are finite, then $\ell_w(y,\hat\eta)+(\overline W(1)-\overline W(0))\,y+\overline W(0)$ is a *fair* proper loss.

**Why it works (the mechanism, in full).** By the fundamental theorem of calculus, $W'=w=-L''$, so $W=-L'+a$ and $\overline W=-L+a\,t+b$ for constants $a,b$. Substituting into the Savage representation of a proper loss, $L(\eta,\hat\eta)=L(\hat\eta)+(\eta-\hat\eta)L'(\hat\eta)$ (the structural identity every proper loss obeys), gives
$$
L(\eta,\hat\eta)=-\overline W(\hat\eta)+a\hat\eta+b+(\eta-\hat\eta)(-W(\hat\eta)+a)=-\overline W(\hat\eta)-(\eta-\hat\eta)W(\hat\eta)+a\eta+b.
$$
Reading off $\ell_w(y,\hat\eta)=L(y,\hat\eta)$ for $y\in\{0,1\}$ and choosing $a=b=0$ yields the stated loss; the fairness shift chooses $a=\overline W(1)-\overline W(0)$, $b=\overline W(0)$ to force $L(0)=L(1)=0$. $\blacksquare$

**Worked reconstruction — square loss from $w\equiv1$.** $W(t)=t$, $\overline W(t)=t^2/2$. Then, using $y^2=y$ for $y\in\{0,1\}$,
$$
\ell_w(y,\hat\eta)=-\tfrac12\hat\eta^2-(y-\hat\eta)\hat\eta+\tfrac12 y=-\tfrac12\hat\eta^2-y\hat\eta+\hat\eta^2+\tfrac12 y=\tfrac12\hat\eta^2-y\hat\eta+\tfrac12 y=\tfrac12(\hat\eta-y)^2.
$$
That is squared loss. ✓ (Note $w\equiv1$ here gives squared loss $\tfrac12(\hat\eta-y)^2$ whose Bayes risk is $\tfrac12\eta(1-\eta)$; the "Brier" $w\equiv2$ doubles to $\eta(1-\eta)$. The factor-of-two discipline again — read your normalization.)

**Worked reconstruction — log loss from $w(c)=\frac1{(1-c)c}$.** $W(t)=\ln\frac{t}{1-t}$, $\overline W(t)=(1-t)\ln(1-t)+t\ln t$ (with $0\ln0:=0$, so $\overline W(0)=\overline W(1)=0$, fairness automatic). Then
$$
\ell_w(y,\hat\eta)=-\big[(1-\hat\eta)\ln(1-\hat\eta)+\hat\eta\ln\hat\eta\big]-(y-\hat\eta)\ln\tfrac{\hat\eta}{1-\hat\eta}=-(1-y)\ln(1-\hat\eta)-y\ln\hat\eta,
$$
which is cross-entropy (log) loss. ✓ The algebra: distribute the $-(y-\hat\eta)\ln\frac{\hat\eta}{1-\hat\eta}=-(y-\hat\eta)\ln\hat\eta+(y-\hat\eta)\ln(1-\hat\eta)$ and collect the $\ln\hat\eta$ and $\ln(1-\hat\eta)$ coefficients; the $\hat\eta$-cross terms cancel, leaving $-(1-y)\ln(1-\hat\eta)-y\ln\hat\eta$.

**Edge case — when is the reconstructed loss *definite* (finite Bayes risk at the ends)?** Reid's criterion: $w$ must be $o(c^{-2})$ as $c\to0$ and $o((1-c)^{-2})$ as $c\to1$. Log loss ($w\sim1/c$) and exponential ($w\sim c^{-3/2}$) both pass — they diverge, but *slower* than $c^{-2}$ — so their losses are definite. A weight diverging like $c^{-2}$ or faster yields an *indefinite* loss with infinite Bayes risk at an endpoint (several rows of Reid's full table are exactly these unnamed, indefinite losses). **Slogan:** *a weight may blow up at the ends, but slower than $c^{-2}$, or the loss stops being finite.*

## III.6 The picture: the cone of uncertainty functions and its extreme rays

**One-breath slogan.** *The uncertainty functions form a convex cone; the tents are its extreme rays; "no tents" means affine means exact.*

Collect all concave $L:[0,1]\to\mathbb R$ vanishing at the endpoints. They form a **convex cone**: add two, scale by a positive number, you stay inside (the sum of concaves is concave). The tents $\{L_c\}_{c\in(0,1)}$ are its **extreme rays** — the indecomposable directions, the ones that cannot themselves be written as a nontrivial pile of others. Theorem III.1 says every member of the cone is $\int L_c\,w(c)\,dc$ for its own curvature $w=-L''$. And the *only* member needing **no** tents — $w\equiv0$, $L''\equiv0$ — is **affine**, which by Part I is the "exact everywhere" case. So the whole reader closes into a single equivalence you should be able to chant:
$$
\boxed{\ \text{exact on the continuum}\iff\text{affine}\iff\text{zero curvature}\iff\text{no tent mass}.\ }
$$
(The rigorous statement that "extreme rays = tents" is a Choquet theorem; Part VI gives the functional-analytic backing. For memory, the picture suffices.)

## III.7 The bridge: the tent is the shared primitive of losses *and* divergences

**One-breath slogan.** *The same tents that generate every loss also generate every $f$-divergence; choosing a loss and choosing a divergence are the same choice of tent-weights.*

This is where surrogate-calibration and information theory meet, and an expert will probe it, so carry the map. An **$f$-divergence** $I_f(P,Q)=\int f(\tfrac{dP}{dQ})\,dQ$ measures the separation of two distributions. Reid–Williamson show ($\S$5.1, Theorem 12; the $\ddot{\text O}$sterreicher–Vajda representation) that every $f$-divergence is *also* a weighted pile of tents — but of the *statistical-information* tents $\Delta L^{0\text{-}1}(\pi,P,Q)$ across the prior $\pi$:
$$
I_f(P,Q)=\int_0^1 \Delta L^{0\text{-}1}(\pi,P,Q)\,\gamma(\pi)\,d\pi,\qquad \gamma(\pi)=\frac1{\pi^3}f''\!\Big(\frac{1-\pi}{\pi}\Big).
$$
So **the cost axis $c$ (for losses) and the prior axis $\pi$ (for divergences) carry the same tents**, and there is a clean change of variables between the loss weight $w$ and the divergence weight $\gamma$ (Reid Theorem 18). At the symmetric point it reads simply
$$
w_{1/2}(c)=2\,\gamma(1-c),
$$
because $\nu(\tfrac12,c)=\tfrac12$ collapses the general transformation. **Worked instance (square loss ↔ triangular discrimination).** Square loss has $w_{1/2}=2$; the change of variables gives $\gamma$ constant, which is the weight of the *triangular-discrimination* $f$-divergence $\Delta(P,Q)=\int\frac{(dP-dQ)^2}{dP+dQ}$. So "squared loss" and "triangular discrimination" are the *same tent-weights* seen from the two sides. Likewise log loss ↔ KL, exponential ↔ Hellinger, $0$–$1$ ↔ variational divergence $V$ (a single tent at $\pi=\tfrac12$, the unique $f$-divergence that is a metric).

**Why this matters for the tent.** It elevates the tent from "a fact about losses" to "the universal primitive of binary comparison." Pinsker's inequality, surrogate regret bounds, and the calibration of losses are *all* statements about how tent-weights on one axis constrain tent-weights on another. The tent is the common currency. **Memory hook:** "*one tent, two axes: cost $c$ for losses, prior $\pi$ for divergences.*"

---

### You can now say… (Part III recall ladder)

- *"State the integral representation and the weight."* — $L(\eta)=\int_0^1 L_c(\eta)w(c)dc$, $w(c)=-L''(c)\ge0$ — curvature is mass.
- *"Prove it for square and log loss."* — $w=2$ resp. $1/(c(1-c))$; split the tent integral at $c=\eta$ and integrate the two linear pieces; recover $\eta(1-\eta)$ resp. binary entropy.
- *"What is the weight of $0$–$1$ loss?"* — A point mass $2\delta_{1/2}$ — the floor is a single tent.
- *"Derive the exponential-loss weight."* — From $L=2\sqrt{\eta(1-\eta)}$, $L''=-\tfrac12[\eta(1-\eta)]^{-3/2}$, so $w=\tfrac12[c(1-c)]^{-3/2}$.
- *"Why is KL hard to estimate?"* — Its weight $1/(c(1-c))$ piles mass at the extremes, where tents vanish and data are scarce; truncating the weight regularizes it.
- *"Reconstruct a loss from its weight."* — Integrate twice: $W=\int w$, $\overline W=\int W$, $\ell_w=-\overline W(\hat\eta)-(y-\hat\eta)W(\hat\eta)$; fairness fixes the constants. ($w\equiv1\to$ squared loss; $w=1/((1-c)c)\to$ log loss.)
- *"How do losses and $f$-divergences share the tent?"* — Both are tent-piles, on the cost axis ($w$) and prior axis ($\gamma$) respectively, related by $w_{1/2}(c)=2\gamma(1-c)$.

**Carry one sentence out of Part III:** *Every loss and every $f$-divergence is a pile of tents weighted by curvature; the tent is the universal primitive of binary comparison.* Part IV turns the tent into a guarantee — the surrogate regret bound — and proves it in full.

---

# PART IV — SURROGATE REGRET BOUNDS: THE TENT AS A GUARANTEE

The tent is not only a representation device; it is a *guarantee generator*. The central practical question of surrogate learning is: *I minimized a convenient surrogate loss; how much have I lost on the misclassification loss I actually care about?* The answer — a **surrogate regret bound** — falls out of the tent and one fact about Bregman divergences. This part proves the bound completely, inverts it, gives its second-order form, and works every standard example to the number. It is the part an expert will press, so every step is here.

## IV.1 Regret is a Bregman divergence that shrinks as the gap shrinks

**One-breath slogan.** *The regret of a proper loss is a Bregman divergence in $(\eta,\hat\eta)$; for fixed truth, it decreases monotonically as the estimate moves toward the truth.*

Every proper loss obeys the **Savage representation** (the structural identity proved from properness): its conditional risk is the Bayes risk plus a tangent correction,
$$
L(\eta,\hat\eta)=L(\hat\eta)+(\eta-\hat\eta)\,L'(\hat\eta).
$$
Hence the **regret** is
$$
B(\eta,\hat\eta)=L(\eta,\hat\eta)-L(\eta)=L(\hat\eta)+(\eta-\hat\eta)L'(\hat\eta)-L(\eta).
$$
Set $\varphi=-L$ (convex, since $L$ is concave). Then $B(\eta,\hat\eta)=\varphi(\eta)-\varphi(\hat\eta)-(\eta-\hat\eta)\varphi'(\hat\eta)$ — *exactly* a **Bregman divergence**: the gap between $\varphi$ at $\eta$ and its tangent line drawn at $\hat\eta$. Two consequences we will lean on:

- **Nonnegativity:** $B(\eta,\hat\eta)\ge 0$ with equality iff $\eta=\hat\eta$ (a convex function lies above its tangents). So a proper loss is minimized by telling the truth — the definition of properness, recovered.
- **Monotonicity in the gap (proved):** differentiate $B$ in $\hat\eta$ for fixed $\eta$:
$$
\frac{\partial B}{\partial\hat\eta}=-\varphi'(\hat\eta)-\big[-\varphi'(\hat\eta)+(\eta-\hat\eta)\varphi''(\hat\eta)\big]=-(\eta-\hat\eta)\,\varphi''(\hat\eta).
$$
Since $\varphi''\ge0$: if $\hat\eta<\eta$ then $\partial B/\partial\hat\eta<0$ (raising $\hat\eta$ toward $\eta$ lowers $B$); if $\hat\eta>\eta$ then $\partial B/\partial\hat\eta>0$ (lowering $\hat\eta$ toward $\eta$ lowers $B$). So **$B(\eta,\hat\eta)$ decreases as $|\eta-\hat\eta|$ decreases.** **Memory hook:** "*the closer your estimate, the smaller your regret — monotonically.*" This single monotonicity is the lever of the whole bound.

## IV.2 The surrogate regret bound — statement and complete proof

**One-breath slogan.** *Knowing the cost-weighted regret pins the truth a margin $\alpha$ from the threshold; push the surrogate regret's estimate to the threshold and read off the worst case.*

**Setup.** You have a proper "surrogate" loss with regret $B$ (logistic, exponential, squared — anything proper). You care about the cost-weighted loss $\ell_{c_0}$ with regret $B_{c_0}$. You are told the cost-weighted regret equals $\alpha$. How small can the surrogate regret be? Define the **calibration function**
$$
\psi(c_0,\alpha):=L(c_0)+\alpha\,L'(c_0)-L(c_0+\alpha),
$$
which is exactly the surrogate regret $B(c_0+\alpha,\,c_0)$ of using the *threshold value* $\hat\eta=c_0$ when the truth is $\eta=c_0+\alpha$ (read it off the Savage formula: $B(c_0+\alpha,c_0)=L(c_0)+(c_0+\alpha-c_0)L'(c_0)-L(c_0+\alpha)$). **This identification — $\psi$ is "the regret of guessing exactly the threshold" — is the heart of the bound; say it out loud, because the direction is easy to get backwards.**

> **Theorem IV.1 (Reid–Williamson Theorem 25).** Fix $c_0\in(0,1)$ and suppose $B_{c_0}(\eta,\hat\eta)=\alpha$. Then for the regret $B$ of any proper surrogate,
> $$
> B(\eta,\hat\eta)\ \ge\ \psi(c_0,\alpha)\vee\psi(c_0,-\alpha),
> $$
> and the bound is **tight**.

**Proof, in full.** Suppose $\alpha>0$ (if $\alpha=0$ the bound is $0$, trivially true). By the cost-weighted regret formula (Lemma II.1), $B_{c_0}(\eta,\hat\eta)=\alpha>0$ forces $c_0$ to *separate* $\eta$ and $\hat\eta$, with $|\eta-c_0|=\alpha$. Exactly two configurations:

**Case A: $\hat\eta\le c_0<\eta$,** so $\eta=c_0+\alpha$. The estimate sits on the low side, $\hat\eta\le c_0$. By the monotonicity of IV.1, for fixed truth $\eta=c_0+\alpha$ the surrogate regret $B(\eta,\hat\eta)$ *decreases* as $\hat\eta$ rises toward $\eta$; over the allowed range $\hat\eta\le c_0$ the smallest value is attained at the largest allowed estimate, $\hat\eta=c_0$. Therefore
$$
B(\eta,\hat\eta)\ \ge\ B(c_0+\alpha,\,c_0)=\psi(c_0,\alpha).
$$

**Case B: $\eta\le c_0<\hat\eta$,** so $\eta=c_0-\alpha$. Symmetrically, the surrogate regret is minimized over the allowed high-side estimates at $\hat\eta=c_0$, giving
$$
B(\eta,\hat\eta)\ \ge\ B(c_0-\alpha,\,c_0)=\psi(c_0,-\alpha).
$$

We are told only $\alpha=|\eta-c_0|$, not which case occurred, so the bound valid in *both* is the larger: $B\ge\psi(c_0,\alpha)\vee\psi(c_0,-\alpha)$. **Tightness:** in each case equality holds when $\hat\eta=c_0$ exactly (the worst surrogate estimate consistent with the data). So the bound is achieved and cannot be improved. $\blacksquare$

**Picture to carry.** You know the *decision* was wrong by margin $\alpha$ (the truth sat $\alpha$ past the threshold). The adversary, trying to make the surrogate regret look small, places the estimate *right at the threshold* $c_0$ — as close to the truth as a wrong decision allows. The resulting surrogate regret is $\psi(c_0,\alpha)$, and nothing the adversary does can make it smaller. **Slogan:** *worst case = guess the threshold; the bound is the regret of that guess.*

## IV.3 The symmetric special case — the clean formula

**One-breath slogan.** *For a symmetric loss at the balanced threshold, the bound is just the height the Bayes risk loses over a margin: $L(\tfrac12)-L(\tfrac12+\alpha)$.*

> **Corollary IV.2 (Reid–Williamson Corollary 27).** If $L$ is symmetric — $L(\tfrac12-x)=L(\tfrac12+x)$ — and $B_{1/2}(\eta,\hat\eta)=\alpha$, then
> $$
> B(\eta,\hat\eta)\ \ge\ L(\tfrac12)-L(\tfrac12+\alpha).
> $$

**Proof, in full.** Symmetry gives $L'(\tfrac12)=0$ (the peak is at the center). So $\psi(\tfrac12,\alpha)=L(\tfrac12)+\alpha\cdot0-L(\tfrac12+\alpha)=L(\tfrac12)-L(\tfrac12+\alpha)$, and $\psi(\tfrac12,-\alpha)=L(\tfrac12)-L(\tfrac12-\alpha)=L(\tfrac12)-L(\tfrac12+\alpha)$ by symmetry — the two are equal, so their max is that common value. $\blacksquare$

Note $B_{1/2}$ is, up to the factor of two, *half the $0$–$1$ regret* (since $2\ell_{1/2}=\ell^{0\text{-}1}$). This corollary is the cleanest statement of "how a surrogate controls misclassification," and it is the form that matches the classification-calibration literature (next).

## IV.4 Worked examples — to the number

**One-breath slogan.** *Plug the Bayes risk into $L(\tfrac12)-L(\tfrac12+\alpha)$ and turn the crank.*

**Squared loss (Brier).** $L(\eta)=\eta(1-\eta)$, symmetric. $L(\tfrac12)=\tfrac14$, and $L(\tfrac12+\alpha)=(\tfrac12+\alpha)(\tfrac12-\alpha)=\tfrac14-\alpha^2$. So
$$
B(\eta,\hat\eta)\ \ge\ \tfrac14-(\tfrac14-\alpha^2)=\alpha^2.
$$
The Brier surrogate regret is at least the *square* of the cost-weighted regret. Exactly quadratic — no higher-order terms, because $L$ is a degree-two polynomial.

**Truncated quadratic loss.** Its Bayes risk is $L(\eta)=4\eta(1-\eta)$ (the "$4$" from the margin convention). $L(\tfrac12)=1$, $L(\tfrac12+\alpha)=4(\tfrac14-\alpha^2)=1-4\alpha^2$. So
$$
B(\eta,\hat\eta)\ \ge\ 1-(1-4\alpha^2)=4\alpha^2.
$$

**Exponential / boosting loss.** $L(\eta)=2\sqrt{\eta(1-\eta)}$, symmetric. $L(\tfrac12)=2\sqrt{\tfrac14}=1$, and
$$
L(\tfrac12+\alpha)=2\sqrt{(\tfrac12+\alpha)(\tfrac12-\alpha)}=2\sqrt{\tfrac14-\alpha^2}=\sqrt{1-4\alpha^2}.
$$
So
$$
B(\eta,\hat\eta)\ \ge\ 1-\sqrt{1-4\alpha^2}.
$$
For small $\alpha$, $\sqrt{1-4\alpha^2}\approx1-2\alpha^2$, so $B\gtrsim2\alpha^2$ — the same leading behavior the second-order form predicts (IV.6). These match Bartlett–Jordan–McAuliffe's results once one notes they used $\ell^{0\text{-}1}=2\ell_{1/2}$, so their margin-regret is twice our $\alpha$.

**Log loss.** $L(\eta)=-\eta\ln\eta-(1-\eta)\ln(1-\eta)$ (nats), symmetric, $L(\tfrac12)=\ln2$. So
$$
B(\eta,\hat\eta)\ \ge\ \ln 2+\big(\tfrac12+\alpha\big)\ln\big(\tfrac12+\alpha\big)+\big(\tfrac12-\alpha\big)\ln\big(\tfrac12-\alpha\big).
$$
For small $\alpha$, this is $\approx 2\alpha^2$ (since $w(\tfrac12)=1/((\tfrac12)(\tfrac12))=4$, and the second-order coefficient is $w(\tfrac12)/2=2$).

## IV.5 Inversion — minimizing the surrogate minimizes the true-regret bound

**One-breath slogan.** *The calibration function is increasing in the margin, so driving the surrogate regret down drives the guaranteed cost-weighted regret down too.*

A bound is only useful if it goes the right way: does making the surrogate small *force* the misclassification regret small? Yes.

> **Corollary IV.3 (Reid–Williamson Corollary 28).** $\alpha\mapsto\psi(c_0,\alpha)$ is non-decreasing for $\alpha\ge0$; hence it is invertible, and minimizing $B(\eta,\hat\eta)$ over $\hat\eta$ minimizes the resulting bound on $B_{c_0}(\eta,\hat\eta)$ for every $c_0$.

**Proof, in full.** Differentiate the calibration function in its margin: $\partial_\alpha\psi(c_0,\alpha)=L'(c_0)-L'(c_0+\alpha)$. Since $L$ is concave, $L'$ is non-increasing, so $L'(c_0+\alpha)\le L'(c_0)$ for $\alpha\ge0$, giving $\partial_\alpha\psi\ge0$. A non-decreasing function is invertible (modulo flat stretches), so the relation "$B\ge\psi(c_0,\alpha)$" can be turned around into "$\alpha\le\psi^{-1}(c_0,\cdot)$ applied to $B$," i.e. controlling $B$ controls $\alpha=B_{c_0}$. $\blacksquare$

**Why this is the linchpin of surrogate learning (say it).** The whole point of using a convex surrogate (logistic, hinge, exponential) instead of the non-convex $0$–$1$ loss is tractability. The inversion guarantees that this substitution is *safe*: a learning algorithm that drives the surrogate regret to zero drives the misclassification regret to zero, and the calibration function $\psi$ tells you the *exchange rate*. The shape of $\psi$ near $\alpha=0$ (next) governs *how fast*.

## IV.6 The second-order form — the exchange rate near zero

**One-breath slogan.** *Near zero the surrogate regret is at least half the central curvature times the squared cost-weighted regret: $B_w\ge\tfrac{w(1/2)}2\,B_{1/2}^2$.*

> **Corollary IV.4 (Reid–Williamson Corollary 29).** For a symmetric proper loss with weight $w$,
> $$
> B_w(\eta,\hat\eta)\ \ge\ \frac{w(\tfrac12)}{2}\,\big[B_{1/2}(\eta,\hat\eta)\big]^2.
> $$

**Proof, in full.** Taylor-expand the clean bound $L(\tfrac12)-L(\tfrac12+\alpha)$ about $\alpha=0$:
$$
L(\tfrac12+\alpha)=L(\tfrac12)+\alpha L'(\tfrac12)+\tfrac{\alpha^2}{2}L''(\tfrac12)+\tfrac{\alpha^3}{6}L'''(\tfrac12)+\cdots.
$$
Symmetry kills the odd derivatives at $\tfrac12$: $L'(\tfrac12)=0$, and $L'''(\tfrac12)=0$ (equivalently, $w=-L''$ is symmetric, so $w'(\tfrac12)=0$, so $L'''(\tfrac12)=-w'(\tfrac12)=0$). Hence
$$
L(\tfrac12)-L(\tfrac12+\alpha)=-\tfrac{\alpha^2}{2}L''(\tfrac12)+O(\alpha^4)=\frac{w(\tfrac12)}{2}\alpha^2+O(\alpha^4),
$$
since $-L''(\tfrac12)=w(\tfrac12)$. Setting $\alpha=B_{1/2}(\eta,\hat\eta)$ gives the bound. $\blacksquare$

**The exchange rate, read off.** The leading constant is *half the tent mass at the center*, $w(\tfrac12)/2$. For Brier, $w(\tfrac12)=2$, so $B\ge\alpha^2$ (and we saw it is exact). For exponential, $w(\tfrac12)=4$, so $B\gtrsim2\alpha^2$. For log loss, $w(\tfrac12)=4$, so $B\gtrsim2\alpha^2$. **A loss with more central curvature gives a stronger quadratic guarantee** — it punishes near-boundary mistakes harder, so a small surrogate regret certifies a smaller misclassification regret. This is the precise sense in which "curvature at $\tfrac12$ = calibration strength." **Memory hook:** "*the bound's quadratic constant is the tent mass at the middle.*"

## IV.7 Where this sits in the literature — and why the tent framework wins

**One-breath slogan.** *Bartlett–Jordan–McAuliffe's $\psi$-transform is the symmetric-margin special case; the tent/cost framework covers all proper losses and all costs.*

The classification-calibration theory of **Bartlett, Jordan, and McAuliffe (2006)** introduced the $\psi$-transform $\psi(\theta)=\tilde\psi^{\star\star}(\theta)$ (a Fenchel biconjugate) bounding the $0$–$1$ excess risk by the surrogate excess risk for **margin losses** $\phi(yf)$. Theorem IV.1 *contains* this as the symmetric case $c_0=\tfrac12$ and generalizes it in two directions at once: (i) to **arbitrary costs** $c_0$, not just balanced $0$–$1$; (ii) to **all proper losses**, not just margin losses. The reason the generalization is genuine, not cosmetic, is a structural limitation of margin losses, noted by Buja–Stuetzle–Shen: a margin loss $\phi(yf)$ *treats the two classes symmetrically by construction*, so it cannot represent an asymmetric proper loss. The cost-weighted tent has no such restriction — the cost $c$ tilts the tent freely (Part II.4) — so the tent framework captures proper losses that *no* margin loss can. **This is exactly the kind of point an expert will raise, and the answer is one sentence:** *margin losses are the symmetric slice; tents span the whole proper-loss world, asymmetries included.*

**The composite-loss bridge.** A general proper loss composed with an invertible **link function** $\psi:[0,1]\to\mathbb R$ (mapping probabilities to real "scores") gives a **composite loss**; margin losses are the special case where the link and the loss conspire into a function of $yf$ alone. Reid–Williamson's companion paper *Composite Binary Losses* (2010) develops this, and the upshot for us is that the tent decomposition (Part III) plus the link is enough to reconstruct *any* practically used classification loss — logistic regression is log loss with the logit link, boosting is exponential loss with the logit link, and so on. The tent is underneath all of them.

---

### You can now say… (Part IV recall ladder)

- *"Why is regret a Bregman divergence, and why does that matter?"* — $B(\eta,\hat\eta)=\varphi(\eta)-\varphi(\hat\eta)-(\eta-\hat\eta)\varphi'(\hat\eta)$ with $\varphi=-L$; it is $\ge0$ and decreases as $|\eta-\hat\eta|$ shrinks ($\partial_{\hat\eta}B=-(\eta-\hat\eta)\varphi''$).
- *"State and prove the surrogate regret bound."* — $B\ge\psi(c_0,\alpha)\vee\psi(c_0,-\alpha)$, $\psi(c_0,\alpha)=L(c_0)+\alpha L'(c_0)-L(c_0+\alpha)=B(c_0+\alpha,c_0)$; proof: $B_{c_0}=\alpha$ forces a margin-$\alpha$ flip, monotonicity pushes the worst estimate to $\hat\eta=c_0$.
- *"Give the symmetric clean form and three examples."* — $B\ge L(\tfrac12)-L(\tfrac12+\alpha)$; Brier $\alpha^2$, truncated quadratic $4\alpha^2$, exponential $1-\sqrt{1-4\alpha^2}$.
- *"Why is the bound useful (inversion)?"* — $\psi$ is increasing in $\alpha$, so minimizing the surrogate forces the misclassification regret down; $\psi$ is the exchange rate.
- *"Give the second-order constant."* — $w(\tfrac12)/2$: $B\ge\tfrac{w(1/2)}2 B_{1/2}^2$; more central curvature = stronger guarantee.
- *"How does this relate to Bartlett–Jordan–McAuliffe?"* — Their $\psi$-transform is the symmetric-margin case; the tent framework generalizes to all costs and all proper losses, including asymmetric ones margin losses cannot represent.

**Carry one sentence out of Part IV:** *The tent converts a known misclassification margin into a worst-case surrogate regret by pushing the estimate to the threshold; the exchange rate near zero is the tent mass at the center.* Part V draws all of this — the tents become curves you can see.

---

# PART V — GEOMETRY: THE TENT AS A CURVE YOU CAN SEE

Everything proved so far becomes a picture. The tent is the *ceiling* of all achievable risk curves, statistical information is an *area*, and the whole theory is dual to ROC analysis by a point-line correspondence. Pictures are the strongest memory aid there is; draw these and they stay.

## V.1 Risk curves and the tent as the prior baseline

**One-breath slogan.** *Plot Bayes risk against cost; the "always guess the prior" predictor traces the tent, and every real predictor's curve lies underneath.*

Fix a binary experiment. For each cost $c$, the best achievable cost-$c$ risk is a number; plotting it against $c\in[0,1]$ gives a **risk curve**. The predictor that ignores the data and always reports the prior $\pi$ has, at cost $c$, risk equal to the tent value $\min\{(1-\pi)c,(1-c)\pi\}$ — read it straight off Part II.3 with $\eta\equiv\pi$. So:

> **The tent $c\mapsto\min\{(1-\pi)c,(1-c)\pi\}$ is the risk curve of the "no information" (prior) predictor — the ceiling.** Any predictor that actually uses features has a risk curve lying weakly below the tent, because using information can only lower the Bayes risk.

**Statistical information is an area.** The drop from the tent (prior predictor) down to a predictor's risk curve, integrated against the cost weighting, is exactly the statistical information $\Delta L$ of Part II.9. Picture the tent on top, the data-driven curve below, and the **shaded region between them is the information the features carry**. A useless feature: the curve hugs the tent, area $\approx0$. A perfectly separating feature: the curve drops to the axis, area maximal. **Memory hook:** "*information is the area you carve out below the tent.*"

## V.2 Realizability — every concave curve under the tent is some experiment

**One-breath slogan.** *The achievable Bayes-risk curves are exactly the concave functions sitting under the tent; the tent is the ceiling and zero is the floor.*

This is the theorem that lets you reason about *all* binary experiments purely geometrically.

> **Theorem V.1 (Reid–Williamson Corollary 24).** Suppose the feature space contains a connected component. A function $\psi:[0,1]\to[0,1]$ is the $0$–$1$ Bayes-risk curve $L(\cdot,P,Q)$ of *some* experiment $(P,Q)$ **if and only if** $\psi$ is concave and $0\le\psi(\pi)\le\pi\wedge(1-\pi)$ for all $\pi$.

So the set of achievable risk curves is *precisely* "concave and under the tent." The two extremes:
- $\psi(\pi)=\pi\wedge(1-\pi)$, the **tent itself**, is achieved by $P=Q$ (the classes are identical — no information; the posterior never moves off the prior).
- $\psi\equiv0$, the **axis**, is achieved by perfectly separated $P,Q$ (the classes are distinguishable with certainty).

Everything concave in between is *some* experiment. **Why this is powerful (say it):** questions like "can a divergence bound hold for all experiments?" become "does an inequality hold for all concave curves under the tent?" — a clean geometric question, no probability left. This is exactly the engine behind the general Pinsker inequalities (bounding one $f$-divergence by another reduces to optimizing over concave curves under the tent), and it is why the tent is the right primitive: it is literally the boundary of the achievable region. **Memory hook:** "*tent on top, axis on the bottom, every concave curve between is real.*"

**Edge case — why the connected component.** The "if" direction *constructs* $P,Q$ realizing a given curve by embedding the unit interval into the feature space; that embedding needs a connected piece to vary the posterior continuously. On a *finite* feature space the posterior takes only finitely many values, so only *piecewise-linear* risk curves with finitely many facets are achievable — the realizability is partial. This is the same atomic-versus-atomless seam that governs whether the rigidity theorem applies (Part VII): a continuum in the feature space is what makes the full geometric picture exact.

## V.3 Point-line duality with ROC curves

**One-breath slogan.** *A point in risk space is a line in ROC space and vice versa; the tent (lower envelope of risk lines) is dual to the maximal ROC (upper envelope of its lines).*

ROC analysis plots true-positive rate against false-positive rate. Risk-curve analysis plots Bayes risk against cost. They are two views of the *same* experiment, related by a **point-line duality**.

> **Theorem V.2 (Reid–Williamson Proposition 20).** For a point $(\mathrm{FP},\mathrm{TP})$ in ROC space, the corresponding line in risk space is
> $$
> L_c=(1-\pi)\,c\,\mathrm{FP}+\pi\,(1-c)\,(1-\mathrm{TP}),\qquad c\in[0,1].
> $$
> Conversely, the point $(c,L_c)$ in risk space corresponds to the line in ROC space
> $$
> \mathrm{TP}=\frac{(1-\pi)c}{\pi(1-c)}\,\mathrm{FP}+\frac{(1-\pi)c-L_c}{\pi(1-c)},\qquad \mathrm{FP}\in[0,1].
> $$

The content: a single *operating point* of a classifier (one FP/TP pair) determines its cost-$c$ risk for *every* $c$ — a whole line in risk space. Dually, fixing a cost and reading the best risk picks out a *supporting line* of the ROC curve. Under this duality:

- The **maximal ROC curve** (the Neyman–Pearson upper envelope, achieved by thresholding the likelihood ratio) corresponds to the **minimal risk curve** (the Bayes-optimal lower envelope).
- The **tent** (the prior predictor's risk curve, the *ceiling*) corresponds to the **diagonal** of ROC space (the uninformative classifier, $\mathrm{TP}=\mathrm{FP}$).

So "Bayes optimality" and "dominant ROC" are the *same fact* seen through dual lenses, and the tent — the worst, no-information risk curve — is dual to the worst, no-information ROC diagonal. **Memory hook:** "*risk points ↔ ROC lines; the tent ↔ the diagonal; Bayes-optimal ↔ Neyman–Pearson.*" This duality is why everything provable about cost curves transfers to ROC curves and back, and it is the reason the tent calculus subsumes the classical ROC/AUC machinery.

---

### You can now say… (Part V recall ladder)

- *"What curve does the tent trace, geometrically?"* — The risk curve of the prior (no-information) predictor — the ceiling of all achievable risk curves.
- *"What is statistical information, as a picture?"* — The (weighted) area between the tent and a predictor's risk curve.
- *"Characterize all achievable Bayes-risk curves."* — Exactly the concave functions $\psi$ with $0\le\psi\le\pi\wedge(1-\pi)$ (Thm V.1); tent on top, axis on bottom.
- *"State the risk–ROC duality."* — Points in risk space ↔ lines in ROC space (Thm V.2); tent ↔ diagonal; Bayes-optimal ↔ Neyman–Pearson maximal ROC.

**Carry one sentence out of Part V:** *The tent is the boundary of the achievable region — the no-information ceiling — and reasoning about all binary experiments is reasoning about concave curves beneath it.*

---

# PART VI — FUNCTIONAL-ANALYSIS DEPTH

Here we earn the right to say the tent is "the atom," rigorously, and we uncover the deepest identity in the subject: the tent is the **Green's function of the second derivative on an interval**. This is the part a functional analyst will probe; every claim is made precise.

## VI.1 The cone, its extreme rays, and Choquet representation

**One-breath slogan.** *Uncertainty functions form a convex cone; the tents are its extreme rays; the integral representation is a Choquet integral over them.*

Let $\mathcal C$ be the set of concave $L:[0,1]\to\mathbb R$ with $L(0)=L(1)=0$. It is a **convex cone**: closed under addition and multiplication by nonnegative scalars (sums and positive scalings of concave functions are concave; the endpoint conditions persist). A nonzero element $r\in\mathcal C$ spans an **extreme ray** if it cannot be written as $r=r_1+r_2$ with $r_1,r_2\in\mathcal C$ pointing in different directions — i.e. $r$ is *indecomposable*.

> **The extreme rays of $\mathcal C$ are exactly the tents $\{L_c\}_{c\in(0,1)}$.** Every $L\in\mathcal C$ has a unique representation as a "continuous convex combination" of tents, $L(\eta)=\int_0^1 L_c(\eta)\,w(c)\,dc$ with $w\ge0$ — this is a **Choquet representation** (after Choquet's 1953 theory of representing points of a compact convex set by measures on its extreme points).

Why the tents and nothing else are extreme: a tent $L_c$ has its entire curvature concentrated at the single point $c$ (its only kink). A function with curvature spread over two distinct points is the sum of two tents — decomposable. Only single-kink functions resist decomposition, and those are the tents. **This is the rigorous form of "the tent is the atom"** (Part III.6): the atoms of a convex cone are its extreme rays, and here they are precisely the tents. **Memory hook:** "*extreme ray = single kink = one tent.*" The integral representation is then the statement that every uncertainty function is its own curvature poured over the extreme rays.

## VI.2 Making $w=-L''$ rigorous when $L''$ is not a function

**One-breath slogan.** *The weight is a measure, not a function: the Lebesgue–Stieltjes measure of the slope; point masses and divergences are handled uniformly.*

The formula $w=-L''$ is suspicious for two of our flagship cases: $0$–$1$ loss has a *kink* (no second derivative at $\tfrac12$ in the ordinary sense), and log loss has a second derivative that *diverges* at the ends. Both are handled by reading the "second derivative" as a **measure**.

A concave $L$ has a non-increasing right-derivative $L'_+$ that exists everywhere (a standard fact about concave functions — the slope only ever decreases). Define the **curvature measure** on intervals by
$$
\lambda_L\big((a,b]\big):=-\big(L'_+(b)-L'_+(a)\big)\ \ge 0
$$
(nonnegative because the slope decreases). This is a **Lebesgue–Stieltjes measure**, and "$\int f(c)\,(-L''(c))\,dc$" is shorthand for the Stieltjes integral $\int f\,d\lambda_L$. Two payoffs:

- For $0$–$1$ loss, $L^{0\text{-}1}$ has slope $+1$ on $[0,\tfrac12)$ and $-1$ on $(\tfrac12,1]$; the slope drops by $2$ at $\tfrac12$, so $\lambda_L=2\,\delta_{1/2}$ — a **point mass** (Part III.2), now rigorous.
- For log loss, $\lambda_L$ has density $1/(c(1-c))$, a genuine (if divergent) density.

Because all our operations on $w$ are *linear* (we only ever integrate it against tents), we may treat these curvature measures as **Schwartz distributions** — add them, scale them, and integrate them — exactly as Reid–Williamson do ($\S$2.4). **Slogan:** *the weight is the curvature measure; kinks are point masses, smoothness is a density, and both live in the same integral.* This is the functional-analytic reason the gallery of Part III could include a Dirac mass and a divergent density in the same table without apology.

## VI.3 The deep identity — the tent is a Green's function

**One-breath slogan.** *Recovering an uncertainty function from its curvature is solving $-u''=w$ with $u(0)=u(1)=0$, and the tent is exactly the Green's function that does it.*

Here is the identity that unifies the whole reader. Consider the simplest boundary-value problem on the interval:
$$
-u''(s)=w(s)\ \text{ on }[0,1],\qquad u(0)=u(1)=0.
$$
Its solution is given by the **Green's function** $G(s,t)$ — the response at $s$ to a unit source at $t$ — via $u(s)=\int_0^1 G(s,t)\,w(t)\,dt$. The Green's function is determined by $-\partial_s^2 G=\delta(s-t)$ with $G(0,t)=G(1,t)=0$, and the classical answer is
$$
G(s,t)=\begin{cases} s(1-t), & s\le t,\\ t(1-s), & s\ge t,\end{cases}
$$
which is precisely
$$
G(s,t)=\min\{(1-t)s,\ (1-s)t\}=\psi(s,t)=L_t(s)\quad\text{— the (unnormalized) tent!}
$$
(Check the pieces: for $s\le t$, $s(1-t)$; for $s\ge t$, $t(1-s)$; and $\min\{(1-t)s,(1-s)t\}$ switches branch exactly at $s=t$ — Part II.4.) Therefore the integral representation of Part III is *literally* the Green's-function solution of the interval Laplacian:
$$
L(\eta)=\int_0^1 L_t(\eta)\,w(t)\,dt=\int_0^1 G(\eta,t)\,\big(-L''(t)\big)\,dt\quad\Longleftrightarrow\quad -L''=w,\ L(0)=L(1)=0.
$$
**Read what this says.** The cone of uncertainty functions is exactly the image of the cone of nonnegative measures $w$ under the Green's operator of $-d^2/dt^2$ on $[0,1]$ with Dirichlet boundary conditions. The tents are the Green's-function kernel — the elementary responses to point sources. Concavity of $L$ corresponds to nonnegativity of the source $w$; vanishing at the endpoints corresponds to the Dirichlet conditions. **This is the single most unifying fact in the subject, and it explains everything at once:**

- *Why tents are the atoms* — they are the responses to point sources (delta functions), the building blocks of any source.
- *Why $w=-L''$* — inverting the Green's operator is applying $-d^2/dt^2$.
- *Why $0$–$1$ loss is one tent* — its source is a single delta at $\tfrac12$.
- *Why the rigidity theorem gives affine* — zero source $w\equiv0$ with Dirichlet conditions forces $u\equiv0$ on the nonlinear part, i.e. $L$ affine.
- *Why Temple (1954) is cited* — he is the one who first noted $\psi(s,t)$ is the Green's function for $\psi''=0$ with $\psi(0)=\psi(1)=0$.

**Memory hook (the keystone sentence):** *"The tent is the Green's function of the interval; every uncertainty function is its curvature run through that Green's function."* If you remember one sentence from Part VI, remember this; it regenerates the rest.

## VI.4 Uniqueness of the representation — up to an affine part

**One-breath slogan.** *The weight determines the uncertainty function up to a straight line, because the affine functions are exactly the kernel of the curvature operator.*

Is the tent representation unique? The curvature operator $L\mapsto-L''$ kills exactly the affine functions ($(-L'')=0\iff L$ affine). So $w=-L''$ determines $L$ **up to an additive affine function**, and the Dirichlet endpoint normalization $L(0)=L(1)=0$ pins that affine part uniquely within $\mathcal C$. Outside $\mathcal C$ (without the endpoint conditions), two losses with the same weight $w$ differ by a line — and a line carries *no curvature, no divergence, no regret, no information* (Part I.1's affine-invariance, all the way back). **Slogan:** *the weight is the whole story; the affine part is bookkeeping.* This closes the loop with Part I: affine functions are the kernel everywhere — of Jensen's gap, of Bregman divergence, of $f$-divergence, and now of the Green's operator.

---

### You can now say… (Part VI recall ladder)

- *"In what precise sense is the tent the atom?"* — It is an extreme ray of the convex cone of uncertainty functions (single kink, indecomposable); the integral representation is a Choquet representation over the extreme rays.
- *"How is $w=-L''$ legitimate for $0$–$1$ and log loss?"* — As the Lebesgue–Stieltjes curvature measure $\lambda_L$ (slope decrement); point mass $2\delta_{1/2}$ for $0$–$1$, divergent density $1/(c(1-c))$ for log; treated as distributions since used only linearly.
- *"State and justify the Green's-function identity."* — The tent $\min\{(1-t)s,(1-s)t\}$ is the Green's function of $-u''=w$, $u(0)=u(1)=0$; the integral representation is its solution, $-L''=w$.
- *"Is the representation unique?"* — Up to an additive affine function; the endpoint normalization fixes it; the affine part carries no curvature/divergence/regret.

**Carry one sentence out of Part VI:** *The tent is the Green's function of the interval Laplacian, and the entire theory — atoms, curvature, rigidity, uniqueness — is the spectral story of that one operator.*

---

# PART VII — THE EDGE-CASE BESTIARY

Mastery is edge cases. Here are the boundary situations that trip people, each walked to its resolution. Read them as a catalog; they are where experts aim.

**1. The cost extremes $c=0,1$.** The tent collapses: $L_0\equiv L_1\equiv0$ (Part II.8). No decision exists when an error type is free. *Resolution:* the endpoints contribute nothing to any mixture; weights may diverge there harmlessly because the tents vanish. *Why it matters:* this is the mechanism behind "KL is hard to estimate" and behind definiteness ($w$ must be $o(c^{-2})$ at the ends, Part III.5).

**2. The posterior extremes $\eta=0,1$.** $L_c(0)=\min\{c,0\}=0$ and $L_c(1)=\min\{0,1-c\}=0$: a certain posterior has zero irreducible loss, for every cost. *Resolution:* the tent vanishes at the posterior endpoints too — certainty is free. The whole tent lives strictly inside the square.

**3. The apex tie $c=\eta$.** At the apex the two linear branches are equal; the Bayes-optimal decision is indifferent. *Resolution:* both $b=0$ and $b=1$ achieve $L_c(c)=c(1-c)$; the infimum is attained on a tie. In the regret formula, the Iverson bracket $\llbracket\eta\wedge\hat\eta<c\le\eta\vee\hat\eta\rrbracket$ uses a strict $<$ on the low side and $\le$ on the high side precisely to handle the boundary cleanly: a prediction *exactly at* the threshold incurs no regret against a truth on the high side. Mind the asymmetry of the inequalities.

**4. Non-differentiable Bayes risk ($0$–$1$ loss).** $L^{0\text{-}1}$ has a kink at $\tfrac12$; $L''$ does not exist there classically. *Resolution:* use the right-derivative and the Lebesgue–Stieltjes curvature measure (Part VI.2); $w=2\delta_{1/2}$. The Savage representation uses one-sided derivatives, so every formula survives.

**5. Indefinite losses (weight too singular).** If $w(c)\sim c^{-2}$ or worse as $c\to0$, the Bayes risk at the endpoint is $+\infty$ — the loss is *indefinite*. *Resolution:* such weights are legal as mixing measures but the reconstructed loss is not fair/definite; several unnamed rows of Reid's Table 2 are exactly these. The cutoff for definiteness is $o(c^{-2})$; log ($c^{-1}$) and exponential ($c^{-3/2}$) pass.

**6. Asymmetric losses.** If $L'(\tfrac12)\ne0$ the clean bound $L(\tfrac12)-L(\tfrac12+\alpha)$ is *wrong*; you must use the full $\psi(c_0,\alpha)\vee\psi(c_0,-\alpha)$ with the linear term $\alpha L'(c_0)$ retained (Part IV.2). *Resolution:* the symmetric corollary is a special case; never apply it to a tilted tent. This is a common slip.

**7. The factor-of-two collision.** Using Reid's generator $L_c$ together with the manuscript's $T_\theta=2L_\theta$ in one computation double-counts the mixing measure by $2$. *Resolution:* fix your normalization first (Part II.5). The $0$–$1$ weight is $\delta_{1/2}$ in $T$-units but $2\delta_{1/2}$ in $L$-units.

**8. Non-integrable weight.** If $\int_0^1 L_c(\eta)\,w(c)\,dc$ diverges for some $\eta$, the "loss" has infinite Bayes risk there. *Resolution:* this is just edge case 5 stated for the integral; the tent vanishing at the ends (edge 1) is what usually saves convergence.

**9. The dyadic collapse (finite mixing).** Build mixtures by iterating a binary operation and the reachable weights are only dyadic rationals — *not* a continuum. *Resolution:* the rigidity theorem (Part I.4) does **not** apply; the Hamel monster (Part I.5) is not excluded; a regularity hypothesis becomes mandatory. This is the difference between a coin and an atomless space (and the deepest seam in the whole subject).

**10. Atoms in the feature space.** If the posterior $\eta$ takes a value with positive probability (an atom), the achievable risk curves are restricted to finitely-faceted ones, and the realizability theorem (Part V.2) needs its "connected component" hypothesis. *Resolution:* atomlessness (Sierpiński: every mass in $[0,1]$ is realized) is what makes the geometry exact; on atomic spaces it is only piecewise.

**11. Flat stretches of $\psi$ (non-unique inversion).** The calibration function $\psi(c_0,\cdot)$ is non-decreasing but may be *constant* on a stretch, so the inversion of the regret bound (Part IV.5) is set-valued there. *Resolution:* this happens where $L'$ is locally constant (a linear stretch of the Bayes risk); the bound still holds, but "the" inverse is a range, not a point.

**12. A proposed "loss" with $w<0$ somewhere.** If someone writes a candidate uncertainty function that is not concave, $w=-L''$ goes negative — signed tent mass. *Resolution:* there is no proper loss with that Bayes risk; it is not a pile of tents. Concavity of $L$ ($\iff w\ge0$) is the membership test for the cone (Part VI.1). Always check concavity before trusting a weight (Part III.3, the sharpened-Brier check).

**13. Fairness clause (a): boundary continuity.** Reid's "fair" requires the partial losses to be one-sidedly continuous at the endpoints. *Resolution:* on an atomless space this is **vestigial** — a *conclusion* of the rigidity theorem (continuity at the apex is free, Part II.10), not an assumption. On atomic spaces it can be load-bearing.

**14. Fairness clause (b): the zero-loss normalization.** Reid's "fair" also requires $\ell(0,0)=\ell(1,1)=0$. *Resolution:* this is **not regularity** — it is a *normalization* fixing the two endpoint constants $L(0),L(1)$ of the affine freedom (Part VI.4). Dropping it does not readmit any pathology; it just unfixes a line. Do not conflate clauses (a) and (b): one is (vestigial) regularity, the other is normalization.

**15. The link-function singularity.** Composite losses apply a link $\psi:[0,1]\to\mathbb R$ (e.g. the logit $\ln\frac{\eta}{1-\eta}$) that blows up at the endpoints. *Resolution:* the singularity is in the *score* coordinate, not the *probability* coordinate; the tent decomposition lives in probability space and is unaffected. Logistic regression = log loss + logit link; boosting = exponential loss + logit link.

**16. Multiclass / the simplex.** The binary tent is the $2$-simplex case. *Resolution:* the cost-weighted primitives generalize to the probability simplex, and the rigidity theorem generalizes via the higher-dimensional endpoint substitution; what survives is the extreme-ray structure (now over a higher-dimensional cone), what gets subtler is that the "tents" become more varied. The binary case is the clean prototype; do not assume every binary identity ports verbatim.

**17. Correct decision, wrong number (the calibration gap).** An estimate $\hat\eta$ on the right side of the threshold but far from $\eta$ has $B_c=0$ yet positive log-loss regret. *Resolution:* this is the whole reason surrogates exist — $0$–$1$/cost regret is decision-blind to the *value*; proper surrogates with curvature (Part IV.6) control the value. The gap *is* the value of calibration.

**18. The "very strong zero" in dual constructions.** When manipulating Legendre–Fenchel duals of the tent's $f$ (variational divergence, $f(t)=|t-1|$), one adopts $\llbracket\text{false}\rrbracket\cdot\infty=0$. *Resolution:* a bookkeeping convention (Knuth's strong zero) ensuring the conjugate is finite on $[-1,1]$ and $+\infty$ outside; harmless once stated.

**19. Cost outside $[0,1]$.** A "cost" $c\notin[0,1]$ is meaningless — the tent requires $c$ to be a convex-combination weight. *Resolution:* the cost axis *is* $[0,1]$; values outside are not in the domain.

**20. The metric edge fact.** Among all $f$-divergences, only the variational divergence $V$ (the tent at $\pi=\tfrac12$, $f(t)=|t-1|$) is a true metric. *Resolution:* a useful boundary fact connecting the tent to the divergence side (Part III.7); the single-tent divergence is the unique metric one.

---

# PART VIII — THE ADVERSARY: EXPERT CHALLENGES WITH FULL ANSWERS

Read these *with the answers already written* until the answers are yours. When the questions come live — at a board, in a defense — the reflex will be there.

## VIII.1 The surrogate-calibration expert

**Q. "Your bound is stated for proper losses, but everyone trains with margin losses $\phi(yf)$. Is your theory even relevant?"**
A. Margin losses are the *symmetric slice* of proper losses. A margin loss $\phi(yf)$ treats the two classes identically by construction (Buja–Stuetzle–Shen), so it cannot represent an asymmetric proper loss; the cost-weighted tent, with its tilt parameter $c$, can. Every practical margin loss is a proper loss composed with an invertible link — logistic regression is log loss with the logit link, boosting is exponential loss with the logit link — so my decomposition sits *underneath* yours, and Theorem IV.1 reduces to Bartlett–Jordan–McAuliffe's $\psi$-transform exactly at $c_0=\tfrac12$. I gain all costs and all asymmetries for free.

**Q. "Is the regret bound tight, and what attains it?"**
A. Tight, and attained when the estimate sits *exactly at the threshold*, $\hat\eta=c_0$ — the closest a wrong decision can come to the truth. The proof builds the worst case explicitly (Part IV.2): given a margin-$\alpha$ flip, Bregman monotonicity drives the surrogate regret to its minimum at $\hat\eta=c_0$, and that minimum is $\psi(c_0,\alpha)$.

**Q. "How does this connect to classification-consistency and rates (Steinwart)?"**
A. The calibration function $\psi(c_0,\cdot)$ *is* the consistency certificate: the surrogate is classification-calibrated iff $\psi(c_0,\alpha)>0$ for $\alpha>0$, equivalently iff $L$ is strictly concave at $c_0$ (positive tent mass there). The *rate* is governed by the behavior of $\psi$ near $0$, which by Part IV.6 is $\tfrac{w(c_0)}{2}\alpha^2+\cdots$ in the symmetric case — a quadratic exchange rate with constant equal to the central tent mass. Inverting $\psi$ (Part IV.5) turns a surrogate-regret rate into a misclassification-regret rate.

**Q. "Why insist on the cost-weighted family as primitive rather than just analyzing $0$–$1$?"**
A. Because $0$–$1$ is a *single atom* — the tent at $\tfrac12$ (Part III.2) — and a single atom cannot express the cost-sensitive problems that real applications pose (fraud, medical screening), nor can it generate the surrogate losses by mixture. The cost-weighted tents are a *basis* (extreme rays of the cone, Part VI.1); $0$–$1$ is one basis vector. You analyze the basis, not one vector, if you want the whole space.

## VIII.2 The probabilist

**Q. "Where exactly does the atomless assumption enter, and what breaks without it?"**
A. It enters through Sierpiński's theorem (every mass in $[0,1]$ is realized by some event), which is what turns "the identity holds for every event" into "the identity holds for every real weight $p$" — the genuine continuous-coefficient equation. Without it (a coin, a finite space), the reachable weights collapse to dyadic rationals (Part VII.9): the rigidity theorem fails, the realizability theorem (Part V.2) holds only piecewise, and a regularity hypothesis becomes necessary. The whole vestigial-versus-load-bearing distinction is exactly the atomless-versus-atomic distinction.

**Q. "You assert the Bayes risk is concave. Is that automatic or assumed?"**
A. Automatic. The conditional risk $L(\eta,a)=(1-\eta)\ell(a,0)+\eta\ell(a,1)$ is *affine in $\eta$* for each fixed action $a$, and the Bayes risk is the *infimum over actions*. An infimum of affine functions is concave — no assumption on the loss is needed (Part II.3, general form). Concavity is structural.

**Q. "How does your statistical information relate to mutual information?"**
A. Statistical information $\Delta L=L(\pi)-\mathbb E[L(\eta)]$ is a *Bregman* (DeGroot) information — the expected drop in Bayes risk from prior to posterior — and it is loss-dependent. For *log loss* it equals (binary) mutual information; for other losses it is a different "information," and the family across all losses is in bijection with the $f$-divergences (Part III.7). So mutual information is the log-loss member of a whole family the tents generate; there is no single privileged information, only a tent-weight choice.

**Q. "What is the relationship to Blackwell's comparison of experiments?"**
A. Experiment $A$ Blackwell-dominates $B$ iff $A$ has *at least as small a Bayes risk as $B$ for every loss* — equivalently, by the tent decomposition, *for every cost-weighted tent*, equivalently, *the risk curve of $A$ lies under that of $B$ for all $c$*. So the cost-weighted family is the sufficient statistic for Blackwell dominance, and the realizability theorem (Part V.2) says the achievable risk curves are exactly the concave functions under the tent. The tent is the boundary of Blackwell's order.

## VIII.3 The functional analyst

**Q. "In what precise sense are the tents 'extreme rays', and is the representation a genuine Choquet theorem?"**
A. In the convex cone $\mathcal C$ of concave functions on $[0,1]$ vanishing at the endpoints, a tent $L_c$ has all its curvature at a single point $c$, hence is indecomposable — it spans an extreme ray. Any element with curvature at two points splits as a sum of two tents. The representation $L=\int L_c\,w(c)\,dc$ with $w\ge0$ is the Choquet representation of $L$ by a measure ($w$) on the extreme rays, and it is unique up to the affine kernel (Part VI.4). So yes: genuine Choquet, with the tents as the extreme structure.

**Q. "You write $w=-L''$ even when $L''$ is a measure. Make that rigorous."**
A. $L$ concave has a non-increasing right-derivative $L'_+$ everywhere; the curvature measure $\lambda_L((a,b])=-(L'_+(b)-L'_+(a))\ge0$ is a Lebesgue–Stieltjes measure, and $\int f\,(-L'')\,dc$ denotes $\int f\,d\lambda_L$. For $0$–$1$ loss the slope drops by $2$ at $\tfrac12$, giving $\lambda_L=2\delta_{1/2}$; for log loss the density is $1/(c(1-c))$. Since the weight is only ever paired linearly with the bounded continuous tents, treating it as a Schwartz distribution is well-defined.

**Q. "Justify the Green's-function claim concretely."**
A. The Green's function $G(s,t)$ for $-u''=w$, $u(0)=u(1)=0$ satisfies $-\partial_s^2 G=\delta(s-t)$ with Dirichlet conditions; solving on each side of $t$ and matching the unit-jump in the derivative gives $G(s,t)=s(1-t)$ for $s\le t$ and $t(1-s)$ for $s\ge t$, which is $\min\{(1-t)s,(1-s)t\}$ — the tent. Hence $L(\eta)=\int_0^1 G(\eta,t)w(t)\,dt$ is the solution of $-L''=w$ with $L(0)=L(1)=0$, i.e. the integral representation is the Green's-function inversion of the interval Laplacian. Temple (1954) is the original reference.

**Q. "Is the affine-invariance you keep invoking a coincidence, or is there one reason for it?"**
A. One reason: affine functions are the *kernel of $-d^2/dt^2$*. Every object in the theory that is "blind to the affine part" — the Jensen gap, the Bregman divergence, the $f$-divergence, the regret, the statistical information — is built from the *curvature* of its generating convex function, and curvature annihilates affine functions. So affine-invariance everywhere is the single statement "these are all curvature functionals," and the Green's-function identity is the operator form of that statement.

---

# BACK MATTER

## The Tent Catechism — recite until automatic

Cover the answers. Speak each aloud. Mastery is when your phrasing matches without looking.

1. *What is the tent?* — $L_c(\eta)=\min\{(1-\eta)c,(1-c)\eta\}$, the Bayes risk of the cost-weighted loss $\ell_c$.
2. *Its three numbers?* — Apex at $\eta=c$; height $c(1-c)$; slopes $+(1-c)$ then $-c$.
3. *Derive it.* — $L_c(\eta,\hat\eta)=\eta(1-c)+b(c-\eta)$, $b\in\{0,1\}$; minimize the binary $b$; lower envelope of two lines.
4. *The $0$–$1$ floor?* — $\min(\eta,1-\eta)=2L_{1/2}$; the factor $2$ is $\ell^{0\text{-}1}=2\ell_{1/2}$.
5. *Cost-weighted regret?* — $B_c=|\eta-c|\,\llbracket c \text{ separates } \eta,\hat\eta\rrbracket$; no flip, no regret; on a flip, pay the margin.
6. *Switching symmetry?* — $L_c(1-\eta)=L_{1-c}(\eta)$; both are $\min\{c\eta,(1-c)(1-\eta)\}$.
7. *Integral representation?* — $L(\eta)=\int_0^1 L_c(\eta)w(c)\,dc$, $w=-L''\ge0$; curvature is mass.
8. *Weights of square / log / exponential / $0$–$1$?* — $2$ ; $\tfrac1{c(1-c)}$ ; $\tfrac12[c(1-c)]^{-3/2}$ ; $2\delta_{1/2}$.
9. *Why is KL hard to estimate?* — Its weight piles mass at the extremes where tents vanish and data are scarce; truncate to regularize.
10. *Reconstruct a loss from $w$?* — Integrate twice: $W=\int w$, $\overline W=\int W$, $\ell_w=-\overline W(\hat\eta)-(y-\hat\eta)W(\hat\eta)$; fairness fixes the constants.
11. *Surrogate regret bound?* — $B\ge\psi(c_0,\alpha)\vee\psi(c_0,-\alpha)$, $\psi(c_0,\alpha)=L(c_0)+\alpha L'(c_0)-L(c_0+\alpha)$ = regret of guessing the threshold.
12. *Symmetric clean form + three examples?* — $B\ge L(\tfrac12)-L(\tfrac12+\alpha)$; Brier $\alpha^2$, truncated quadratic $4\alpha^2$, exponential $1-\sqrt{1-4\alpha^2}$.
13. *Second-order constant?* — $w(\tfrac12)/2$: $B\ge\tfrac{w(1/2)}2 B_{1/2}^2$; central curvature = calibration strength.
14. *Why does the bound invert?* — $\psi$ is increasing in the margin; minimizing the surrogate forces the misclassification regret down.
15. *The realizability picture?* — Achievable Bayes-risk curves are exactly the concave functions under the tent; tent on top (no info), axis on bottom (perfect info).
16. *Risk–ROC duality?* — Points in risk space ↔ lines in ROC space; tent ↔ diagonal; Bayes-optimal ↔ Neyman–Pearson.
17. *In what sense is the tent the atom?* — Extreme ray of the cone of uncertainty functions (single kink); the representation is Choquet.
18. *The Green's-function identity?* — The tent is the Green's function of $-u''=w$, $u(0)=u(1)=0$; the representation is its inversion; $-L''=w$.
19. *Why is everything affine-invariant?* — Affine functions are the kernel of $-d^2/dt^2$; all the objects are curvature functionals.
20. *The rigidity in one line?* — Cellwise exactness of Jensen forces piecewise-affine with free apex-continuity; the two-cell case is a tent — content from decision theory, rigidity from the functional equation.

## Chalkboard Scripts — board by board

**Board 1 — Draw the tent.** Axes $\eta\in[0,1]$ horizontal, risk vertical. Plot the rising line $(1-c)\eta$ from $(0,0)$ and the falling line $(1-\eta)c$ from $(0,c)$; they cross at $(c,c(1-c))$. Shade the lower envelope. Label apex, height, slopes. Say: *"the cost-weighted Bayes risk; apex at the cost, height cost-times-cocost."*

**Board 2 — Derive the tent.** Write $\ell_c$, take expectation to $L_c(\eta,\hat\eta)=\eta(1-c)+b(c-\eta)$, minimize $b\in\{0,1\}$, box the result. Say: *"pick the cheaper of two lines."*

**Board 3 — Curvature is mass.** Write $L(\eta)=\int_0^1 L_c(\eta)w(c)\,dc$, $w=-L''$. Demonstrate on square loss ($w=2$) and log loss ($w=1/(c(1-c))$) by splitting the tent integral at $c=\eta$. Box both recoveries. Say: *"every loss is a pile of tents weighted by curvature."*

**Board 4 — The surrogate bound.** Draw the tent for $c_0$, mark the truth at $c_0+\alpha$, the worst estimate at the threshold $c_0$. Write $\psi(c_0,\alpha)=L(c_0)+\alpha L'(c_0)-L(c_0+\alpha)$ and the bound $B\ge\psi(c_0,\alpha)\vee\psi(c_0,-\alpha)$. Specialize to symmetric: $B\ge L(\tfrac12)-L(\tfrac12+\alpha)$. Compute the exponential example to $1-\sqrt{1-4\alpha^2}$. Say: *"worst case is guessing the threshold."*

**Board 5 — The Green's function.** Write $-u''=w$, $u(0)=u(1)=0$; derive $G(s,t)=s(1-t)$ for $s\le t$, $t(1-s)$ for $s\ge t$; identify it as the tent. Conclude $L=\int G(\eta,t)(-L''(t))\,dt$. Say: *"the tent is the Green's function of the interval; everything is the spectral story of one operator."*

**Board 6 — Rigidity and the punchline.** State $(\star)$, do the endpoint substitution ($u_1=M,u_2=0,p=v/M$) to get affine; note continuity is a conclusion; apply cellwise to force the tent. Contrast with the dyadic collapse (coin → rationals → Hamel monster → regularity needed). Say: *"on a continuum the tent's shape is forced and its smoothness is free; on a coin, neither."*

---

## Coda — what you now hold

You can draw the tent and name its apex, height, and slopes without thinking. You can derive it from the cost-weighted loss, prove its regret formula and switching symmetry, and explain why its endpoints collapse. You can state and prove that every loss is a pile of tents weighted by curvature, derive the weight of any standard loss, and reconstruct the loss from the weight. You can prove the surrogate regret bound, invert it, give its second-order constant, and work the examples to the number. You can place the tent geometrically as the realizability ceiling and dualize it to ROC. And you can say, with the Green's function in hand, *why* the tent is the atom of the whole theory — because it is the elementary response of the interval Laplacian, and every uncertainty function is its curvature run through that one operator.

Read it again on the next train. The third reading is where recognition becomes reconstruction, and reconstruction is what an elite does at the board while the experts ask their hardest questions.
