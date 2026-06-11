# A From-Scratch Reader: Section 5, *"Telling $(\star)$ from its relatives"* — Surrogate Calibration on the Real Axis

> **Reader's guide** to **Section 5** of *The Continuous-Coefficient Jensen Equation: How Real Mixing Weights Retire Regularity* (satellites/o3-maa).
> **Scope.** All of Section 5, the *field guide to saturated Jensen*: the four structural **sources** of a saturated identity and the questions that separate them (§5.1); the cases where the classical hypotheses are **load-bearing** — expected-utility representation, the axiomatic characterization of Shannon entropy, linear opinion pools (§5.2); the case where they are **vestigial** — *surrogate calibration on the resolution axis*, which houses **Proposition 8** (`prop:resolution`) (§5.3); the **mirrored dictionary** (§5.4) and the lesson (§5.5); plus the quantum-state coda.
> **Centerpiece.** Surrogate calibration. The phrase *"on the real axis"* is the whole point: an atomless probability space realizes **every real mixing weight** $p\in[0,1]$, so the saturated identity is asserted at a genuine continuum of reals — and *that* is what makes the classical regularity hypotheses vestigial. The rival "loss-axis" calibration story tracks Jensen as an *inequality* with slack; the resolution-axis story saturates it to an *equality*.
> **Audience.** A returning student who earned **A grades in a Bachelor of Science in Computer Science** — comfortable with discrete math, induction, basic probability, algorithms, and reading proofs — but who has **not** met **(i) statistical learning theory** (Bayes risk, surrogate losses, calibration, proper scoring rules), **(ii) convex optimization / convex analysis** (Jensen's inequality as an optimization fact, conjugate duality, convexification), or **(iii) the singular value decomposition** and the spectral side of linear algebra. **Part R below builds all three from the ground up**, plus the small amount of measure theory (conditional expectation, atomless spaces) the section genuinely uses.
> **Promise.** Every object is defined, every prerequisite proved or carefully stated, and the headline result — Proposition 8 — is reduced to the **one-line chord substitution** of Theorem 1. You should be able to reproduce Section 5 on a blank page and defend every step in an oral exam.
> **Companions.** `notes/reader.md` (Sections 1–3, the engine and the dictionary); `notes/reader-section4.md` (Section 4, the variants — Theorems 3 and 6, Corollary 5, Proposition 7); `notes/reader-higher-dim.md` (the full proof of Theorem 6, used here for the multiclass and quantum cases).
> **Back matter.** After the exposition: **Part E** (extreme examples and traps), **Part X** (24 graded exercises), **Part S** (full solutions), **Part D** (routines, recitations, and drills for oral-exam mastery). Do the exercises before reading the solutions.
>
> *Numbering note.* The manuscript uses **one shared counter** for all numbered results, running $1,2,3,\dots$ across theorems, corollaries, remarks, and propositions: Theorem 1 (`thm:main`), Corollary 2 (`cor:regularity`), Theorem 3 (`thm:weak`), Remark 4 (`rem:irrational`), Corollary 5 (`cor:piecewise`), Theorem 6 (`thm:higher`), Proposition 7 (`prop:JQ-pathology`), and **Proposition 8** (`prop:resolution`), the resolution-blindness result of §5.3. Section 5 itself is titled *"Telling $(\star)$ from its relatives: a field guide to saturated Jensen"*; "surrogate calibration on the resolution axis" is its central subsection §5.3. We refer to results by both number and label.
>
> *Three-field note (read this once).* You are about to meet three new vocabularies. Here is what each is **for**, and — crucially — what the headline result needs:
> - **Learning theory** (R.7) supplies the *objects*: the Bayes risk, the uncertainty function $G$, the resolution of a representation. It is where the equation comes *from*.
> - **Optimization / convex analysis** (R.5–R.6) supplies the *contrast*: the classical theory tracks Jensen as an inequality (concavity, conjugate duality, the $\psi$-transform). Section 5's point is that on the real axis the inequality becomes an *equality*, and then no convexity is needed at all.
> - **The SVD and the spectral theorem** (R.8) are **not used to prove Proposition 8** — the core needs nothing beyond affine functions of a real variable. They are built here because (a) the multiclass and **quantum-state** codas use the spectral theorem and *trace functionals* on Hermitian operators, and (b) the *representation-learning* reading (Part 8) connects $G$'s resolution drop to the **spectral-gap over-smoothing** story of the companion paper, where singular values govern the error floor. **If R.8 ever feels heavy, you may skip it on a first pass and lose nothing of Proposition 8.**

Section 5 has one organizing question. A derivation in an applied field pushes Jensen's inequality to *equality* — a *saturated* identity $p\,G(u_1)+(1-p)\,G(u_2)=G(p\,u_1+(1-p)\,u_2)$. Does that identity need a regularity hypothesis on $G$, or not? The answer depends entirely on **why** the identity holds, and Section 5 sorts the "why" into four structurally different **sources**. Three of them genuinely require a classical hypothesis; only the fourth — a *genuine continuum of real weights*, realized by an atomless measure — makes the identity the continuous-coefficient equation $(\star)$ of Theorem 1, where every regularity hypothesis is vestigial. Surrogate calibration is the clean instance of the fourth source, and Proposition 8 is the theorem that cashes it out.

---

## Part 0 — Section 5 in one paragraph

A saturated Jensen identity is a *family* of equations indexed by the weight $p$; its real content is the set of weights at which the surrounding derivation actually licenses it. Four sources recur. **(1) Finite mixing** reaches only the rational weights, so it licenses the rational-coefficient equation $(J_{\mathbb{Q}})$, where Hamel pathology survives (Proposition 7) and a regularity hypothesis is genuinely required. **(2) Additivity into a bounded codomain** forces affineness by the classical bounded-additive theorem — a regularity property (boundedness) supplied free by the codomain, not the endpoint substitution. **(3) A Cauchy relative with a non-affine target** (the Shannon-entropy characterization) needs a hypothesis to exclude Hamel solutions; $(\star)$ is simply not the equation in play. **(4) A genuine continuum of real weights** — an atomless measure assigns every mass $p\in[0,1]$ (Sierpiński), and the identity is asserted *directly* at each real $p$ — makes the equation $(\star)$, and *only now* is a regularity hypothesis on $G$ vestigial. Surrogate calibration on the resolution axis is the clean fourth-source instance: with $G$ the uncertainty function (Bayes risk profile) and the cell mass $p$ ranging over the real interval, two-cell exactness at every $p$ forces $G$ affine with **no** continuity, measurability, monotonicity, boundedness, or even concavity assumed (**Proposition 8**). Locally, cellwise exactness on the benchmark partition $\{[0,\tfrac12],[\tfrac12,1]\}$ pins the **tent** $\min(u,1-u)$ — the $0$–$1$ Bayes risk — by Corollary 5. The trap is **misclassification**: mistaking a source-1/2/3 derivation for source 4 (and dropping a needed hypothesis), or — the seductive error that birthed this paper — mistaking a source-4 derivation for a Cauchy problem and *adding* a defensive hypothesis that was never needed.

Everything below expands this paragraph, after Part R rebuilds the prerequisites.

---

## Part R — Prerequisite recall (for the returning CS A-student)

> **Meta-remark to calm the nerves.** The headline result, Proposition 8, is proved in *four lines* from Theorem 1, and Theorem 1's proof is the one-line chord substitution you already know from `reader.md`. Everything in Part R is there to let you (a) understand *where the equation comes from* (R.3–R.4, R.7), (b) appreciate *what the classical theory pays that Section 5 does not* (R.5–R.6), and (c) follow the codas (R.8). The minimal load-bearing core is R.3 (expectation), R.4 (conditional expectation and atomless spaces), and R.5 (Jensen). The rest is context and contrast.

> **Tag map** (keep handy): R.3/R.4 → the calibration setup and Proposition 8 (Parts 5–6); R.5 → why every Bayes risk is concave and what "saturation" means; R.6 → the loss-axis $\psi$-transform you are being contrasted *against* (Part 7); R.7 → all the vocabulary (Bayes risk, proper scores, comparison of experiments) of Parts 5–8; R.8 → the quantum coda (Part 9) and the over-smoothing reading (Part 8).

### R.1 Orientation: what you already have, and what is new

From a CS degree you reliably own: sets, functions, relations; induction and recursion; asymptotics; elementary probability (sample spaces, independence, expectation of discrete random variables); linear algebra at the level of matrix multiplication, Gaussian elimination, determinants, and eigenvalues of small matrices; and fluency reading $\varepsilon$–$\delta$ proofs even if you would not produce one cold. We lean on all of this.

What is new, and what Part R supplies: (i) **conditional expectation** and the idea of a $\sigma$-algebra as a *quantity of information* (R.3–R.4); (ii) **convexity** as the central inequality of the subject, and the conjugate-duality machinery the classical theory runs on (R.5–R.6); (iii) the **decision-theoretic** vocabulary — loss, risk, Bayes optimality, surrogate, calibration, proper scoring rule (R.7); and (iv) the **spectral** picture of linear maps culminating in the SVD (R.8), used only in the codas.

### R.2 The real continuum, supremum, infimum

The reals $\mathbb{R}$ are the complete ordered field: every nonempty set bounded above has a least upper bound, the **supremum** $\sup$, and dually a greatest lower bound, the **infimum** $\inf$. We use $\inf$ constantly: the Bayes risk is "the best you can do," an infimum over actions. Two facts we will reuse: $\inf$ of a family of functions that are each **affine in a parameter** is **concave** in that parameter (R.5); and on a closed bounded set a continuous function attains its $\inf$ (so "inf" may be read "min"). The continuum matters in one decisive way: between any two reals lie *uncountably* many reals, and — unlike the rationals — the weights $p\in[0,1]$ form a set that an atomless measure can realize *in full* (R.4). That fullness is the engine of Section 5.

### R.3 Probability you can lean on: space, random variable, expectation

A **probability space** is a triple $(\Omega,\mathcal{F},\mu)$: a set of outcomes $\Omega$, a collection $\mathcal{F}$ of **events** (subsets of $\Omega$) closed under complement and countable union — a **$\sigma$-algebra** — and a **probability measure** $\mu\colon\mathcal{F}\to[0,1]$ with $\mu(\Omega)=1$ that is countably additive on disjoint events. Think of $\mathcal{F}$ as "the questions you are allowed to ask." A **random variable** $X$ is a function $\Omega\to\mathbb{R}$ measurable with respect to $\mathcal{F}$ (preimages of intervals are events). Its **expectation** $\mathbb{E}[X]=\int_\Omega X\,d\mu$ is the average value; for a variable taking value $x_i$ on event $A_i$ in a finite partition, $\mathbb{E}[X]=\sum_i x_i\,\mu(A_i)$, which is all we will need concretely.

The one indicator identity we reuse: for an event $A$, the **indicator** $\mathbf{1}_A$ equals $1$ on $A$ and $0$ off it, and $\mathbb{E}[\mathbf{1}_A]=\mu(A)$. If a random variable $\eta$ takes value $u_1$ on $A$ and $u_2$ on $A^{c}$, then $\eta=u_1\mathbf{1}_A+u_2\mathbf{1}_{A^c}$ and
$$
\mathbb{E}[\eta]=u_1\,\mu(A)+u_2\,\mu(A^c)=p\,u_1+(1-p)\,u_2,\qquad p:=\mu(A).
$$
This two-point average — a convex combination with weight $p=\mu(A)$ — is literally the left mixing weight of $(\star)$. *Hold onto it: it is the whole bridge from probability to the functional equation.*

### R.4 Information as a $\sigma$-algebra; conditional expectation; atomless spaces

> **Escape hatch.** If measure theory is rusty, read every "$\sigma$-algebra" below as "**partition** of $\Omega$ into events," and every "$\mathbb{E}[X\mid\mathcal{G}]$" as "**the function that is constant on each block of the partition, equal to the average of $X$ over that block**." The two-cell case — a partition $\{A,A^c\}$ — is all Proposition 8 actually uses, and there the picture is elementary.

**A $\sigma$-algebra is a resolution.** A sub-$\sigma$-algebra $\mathcal{G}\subseteq\mathcal{F}$ is the information you can resolve: the finer $\mathcal{G}$, the more events you can distinguish. The coarsest is $\{\emptyset,\Omega\}$ (you know nothing); the finest is $\mathcal{F}$ (you know everything askable). "Refining" $\mathcal{G}$ means enlarging it. This is the **resolution axis** of the title: we vary *how much the observer can tell apart*, not *which loss they pay*.

**Conditional expectation.** Given $\mathcal{G}\subseteq\mathcal{F}$, the conditional expectation $\mathbb{E}[X\mid\mathcal{G}]$ is the **best $\mathcal{G}$-measurable approximation to $X$**: the unique (up to null sets) $\mathcal{G}$-measurable random variable $Z$ with $\mathbb{E}[Z\mathbf{1}_B]=\mathbb{E}[X\mathbf{1}_B]$ for every $B\in\mathcal{G}$. For a partition $\mathcal{G}=\sigma(\{B_j\})$ it is concrete: $\mathbb{E}[X\mid\mathcal{G}]$ equals the average $\mathbb{E}[X\mathbf{1}_{B_j}]/\mu(B_j)$ on each block $B_j$. Two properties we use:
- **Tower property:** $\mathbb{E}\big[\mathbb{E}[X\mid\mathcal{G}]\big]=\mathbb{E}[X]$ (averaging the block-averages recovers the grand average), and more generally $\mathbb{E}[\mathbb{E}[X\mid\mathcal{F}_0]\mid\mathcal{G}]=\mathbb{E}[X\mid\mathcal{G}]$ for $\mathcal{G}\subseteq\mathcal{F}_0$ (coarsening in one step or two gives the same thing).
- **Linearity:** $\mathbb{E}[aX+bY\mid\mathcal{G}]=a\,\mathbb{E}[X\mid\mathcal{G}]+b\,\mathbb{E}[Y\mid\mathcal{G}]$.

**Atomless spaces — the source of the continuum.** An **atom** is an event $A$ with $\mu(A)>0$ that cannot be split into two events of strictly smaller positive measure. A space is **atomless** (or *non-atomic*) if it has no atoms — e.g., the unit interval $[0,1]$ with length measure, or any space carrying a uniform-on-an-interval random variable. The decisive consequence:

> **Sierpiński's theorem (intermediate value for atomless measures).** If $(\Omega,\mathcal{F},\mu)$ is atomless, then for every $t\in[0,1]$ there is an event $A\in\mathcal{F}$ with $\mu(A)=t$. *(Its vector-valued descendant is Lyapunov's convexity theorem.)*

So on an atomless space **the attainable masses $\mu(A)$ fill the entire real interval $[0,1]$** — every real $p$, not merely the dyadic or rational ones you would get by tossing a coin finitely often. This single fact is why surrogate calibration lands in *source 4* (genuine continuum) and not *source 1* (finite mixing). Keep the contrast sharp: **atomless $\Rightarrow$ all real $p$; a coin $\Rightarrow$ only dyadic $p$.**

### R.5 Convexity, concavity, and Jensen's inequality (optimization I)

A function $G\colon C\to\mathbb{R}$ on a convex set $C$ (an interval, say) is **convex** if its graph lies below its chords:
$$
G\big(p\,u_1+(1-p)\,u_2\big)\;\le\;p\,G(u_1)+(1-p)\,G(u_2)\qquad(u_1,u_2\in C,\ p\in[0,1]),
$$
and **concave** if the reverse inequality holds (equivalently, $-G$ is convex). It is **affine** iff it is both — $G(v)=\alpha v+\beta$ — and exactly then the inequality is an **equality for every** $p,u_1,u_2$. This last sentence is the hinge of the whole paper: *affine $\iff$ Jensen saturates identically.*

**Jensen's inequality** is the same statement for a random variable: if $G$ is convex then $G(\mathbb{E}[\eta])\le\mathbb{E}[G(\eta)]$, with the inequality reversed for concave $G$. The **slack** $\mathbb{E}[G(\eta)]-G(\mathbb{E}[\eta])$ (the "Jensen gap") measures how far $G$ is from affine *as seen by the law of $\eta$*. The entire subject of Section 5 lives in the question: *when is this slack identically zero?* — for the classical theory it is positive (strict concavity) and is the quantity of interest; for Proposition 8 the hypothesis is that it is zero at every two-point law, and the conclusion is that $G$ must be affine.

**Equality case (the fact we will weaponize).** For a *strictly* convex $G$, $G(p u_1+(1-p)u_2)=p G(u_1)+(1-p)G(u_2)$ with $p\in(0,1)$ forces $u_1=u_2$. So if a *non-degenerate* two-point identity holds for all $u_1\ne u_2$, strict convexity is impossible — $G$ has *no* strict curvature anywhere — which is the intuition behind "saturation $\Rightarrow$ affine." Theorem 1 makes this rigorous without assuming $G$ is even continuous.

### R.6 Infimum of affine functions, supporting lines, conjugates, convexification (optimization II)

This subsection is the machinery the **classical** calibration theory runs on. Section 5's punchline is that the resolution-axis story needs *none* of it; you read it to know what you are being spared.

**Infimum of affine functions is concave.** If $G(u)=\inf_{a\in\mathcal{A}}\big(\alpha_a u+\beta_a\big)$ is a pointwise infimum of affine functions of $u$, then $G$ is concave (an inf of concave functions is concave). *This is exactly why every Bayes risk is concave* (R.7): it is an infimum, over actions, of the expected loss, which is affine in the posterior $u$.

**Supporting lines and subgradients.** A concave $G$ on an interval has, at each interior point $u_0$, a **supporting line** lying above the graph and touching at $u_0$; its slope is a **supergradient**. Convex functions have supporting lines below (subgradients). Existence of supporting lines is the geometric form of convexity and the source of every duality statement below.

**The Legendre–Fenchel conjugate.** For $f\colon\mathbb{R}\to\mathbb{R}\cup\{+\infty\}$ the **conjugate** is $f^\ast(s):=\sup_u\big(su-f(u)\big)$. It is always convex (a sup of affine functions of $s$). The **biconjugate** $f^{\ast\ast}=(f^\ast)^\ast$ is the **largest convex lower bound** of $f$ — the **convex envelope** $\operatorname{conv} f$. Taking the convex envelope is **convexification**: it replaces $f$ by the highest convex function under it (geometrically, the lower boundary of the convex hull of the region above the graph). When $f$ is already convex and lower-semicontinuous, $f^{\ast\ast}=f$ (Fenchel–Moreau).

**Why this is here: the $\psi$-transform preview.** In binary classification (R.7) one compares the **conditional Bayes risk** $H(\eta)$ (best achievable) with the **minimal conditional surrogate risk subject to predicting the wrong side**, $H^{-}(\eta)$. Bartlett–Jordan–McAuliffe define the **calibration function** as the convexification of the gap,
$$
\psi:=\operatorname{conv}\big(H^{-}-H\big),
$$
and prove the **comparison inequality** $\psi(R-R^\ast)\le R_\varphi-R_\varphi^\ast$: excess $0$–$1$ risk is controlled by excess surrogate risk through $\psi$. The surrogate is **classification-calibrated** iff $\psi(\theta)>0$ for $\theta>0$ (minimizing the surrogate drives the $0$–$1$ risk to its floor). The $0$–$1$ loss gives $\psi=\mathrm{id}$; smooth surrogates give a *strictly convex* $\psi$ — a *positive* Jensen slack. Section 5 will show the resolution-axis transposition makes the analogous gap **identically zero**, turning the inequality into the equation $(\star)$. *That is the entire contrast: conjugate-duality slack on the loss axis vs. saturation on the resolution axis.*

### R.7 Statistical learning theory, built from scratch

**Classification and the $0$–$1$ loss.** Predict a binary label $Y\in\{0,1\}$ from features $X$. A predictor's quality is its **risk** $R(\text{rule})=\mathbb{P}(\text{rule}(X)\ne Y)=\mathbb{E}[\mathbf{1}\{\text{rule}(X)\ne Y\}]$ — the expected **$0$–$1$ loss** $\ell_{01}(a,y)=\mathbf{1}\{a\ne y\}$.

**The posterior and the Bayes rule.** Let $\eta(x):=\mathbb{P}(Y=1\mid X=x)$ be the **posterior probability**. The risk-minimizing (**Bayes-optimal**) rule predicts $1$ where $\eta>\tfrac12$ and $0$ where $\eta<\tfrac12$; its risk is the **Bayes risk** $R^\ast$, the floor below which no rule can go. Pointwise, the best achievable conditional risk at posterior value $u$ is
$$
H(u)\;=\;\min\big(u,\,1-u\big)\qquad(\text{0–1 loss, binary actions}),
$$
the **tent**: if the true chance of label $1$ is $u$, the best you can do is bet on the majority and be wrong with probability $\min(u,1-u)$. The **excess risk** $R-R^\ast\ge0$ is how far a rule sits above the floor.

**Surrogate losses and the calibration question.** The $0$–$1$ loss is non-convex and computationally awful to minimize, so one minimizes a **convex surrogate** $\varphi$ instead — **logistic** $\varphi(m)=\log(1+e^{-m})$, **exponential** $e^{-m}$, **hinge** $\max(0,1-m)$, as functions of the *margin* $m$. The **calibration question** of Bartlett–Jordan–McAuliffe (2006), Zhang (2004), Steinwart, Tewari–Bartlett, Reid–Williamson: *does minimizing the surrogate risk also (approximately) minimize the $0$–$1$ risk?* The answer is governed by the $\psi$-transform of R.6: the surrogate is **calibrated** iff $\psi(\theta)>0$ for $\theta>0$, and the *price* of using it is the strictly positive slack $\psi$ (the convexified gap). **This is the "loss axis": the variable being optimized is the predictor (equivalently, the loss).**

**Proper scoring rules and the uncertainty function.** Generalize: an **action space** $\mathcal{A}$ and a **loss** $\ell\colon\mathcal{A}\times\{0,1\}\to\mathbb{R}$. The **conditional Bayes risk** at posterior value $u$,
$$
H(u)\;:=\;\inf_{a\in\mathcal{A}}\mathbb{E}\big[\ell(a,Y)\mid\eta=u\big]\;=\;\inf_{a\in\mathcal{A}}\big(u\,\ell(a,1)+(1-u)\,\ell(a,0)\big),
$$
is an **infimum of affine functions of $u$**, hence **concave** (R.6). This $H$ travels under many names — the **Bayes envelope**, the **generalized entropy**, the **uncertainty function**, the **entropy of a proper scoring rule** (Savage; DeGroot–Fienberg; Grünwald–Dawid; Gneiting–Raftery). The $0$–$1$ loss gives the tent $H(u)=\min(u,1-u)$; the **log loss** gives Shannon entropy $-u\log u-(1-u)\log(1-u)$; the **Brier (squared) loss** gives $u(1-u)$. *Every uncertainty function is concave, vanishes appropriately at the certain points $u\in\{0,1\}$, and the question Section 5 asks is what happens when one assumes it is "blind to information."*

**Comparison of experiments (Blackwell) and refinement.** An experiment (a $\sigma$-algebra $\mathcal{G}$, a representation, a measurement) is **more informative** than another if every decision problem does at least as well under it — equivalently, the coarser one is a **garbling** (a stochastic post-processing) of the finer (Blackwell, 1953). On the resolution axis this is exactly **refinement** of $\sigma$-algebras: refining can only *help*, so the residual uncertainty $\mathbb{E}[G(\eta_{\mathcal{G}})]$ can only *fall*. The amount it falls is the **resolution** (or discrimination) term in the decomposition of a proper score: Murphy's partition of the Brier score; Bröcker's generalization to every proper score; the empirical $\bar S=\mathrm{MCB}-\mathrm{DSC}+\mathrm{UNC}$ (miscalibration $-$ discrimination $+$ uncertainty) of Dimitriadis–Gneiting–Jordan. **Every classical statement in this chain assumes $G$ concave.** Section 5's converse — *resolution-blind $\Rightarrow$ affine* — assumes nothing.

### R.8 Linear algebra and the singular value decomposition (codas only)

> **Scope reminder.** Nothing in R.8 is used to prove Proposition 8. It powers the **quantum-state coda** (trace functionals on Hermitian operators, Part 9) and the **representation-learning reading** (spectral-gap over-smoothing, Part 8). Skip on a first pass if pressed.

**Vector spaces and linear maps.** A real vector space has vectors that add and scale; a **linear map** $T\colon V\to W$ respects both. In coordinates $T$ is a **matrix** $M$. An **eigenvector** $v\ne0$ of a square $M$ satisfies $Mv=\lambda v$ for a scalar **eigenvalue** $\lambda$; eigenvalues are the roots of $\det(M-\lambda I)=0$.

**Symmetric/Hermitian matrices and the spectral theorem.** A real matrix is **symmetric** if $M=M^{\mathsf T}$; a complex one is **Hermitian** if $M=M^{\ast}$ (conjugate transpose). The **spectral theorem** says every Hermitian $M$ has an **orthonormal basis of eigenvectors** with *real* eigenvalues: $M=\sum_i\lambda_i\,q_iq_i^{\ast}=Q\Lambda Q^{\ast}$, with $Q$ unitary and $\Lambda$ real diagonal. $M$ is **positive semidefinite (PSD)** iff all $\lambda_i\ge0$ iff $v^{\ast}Mv\ge0$ for all $v$. **Density operators** (quantum states) are exactly the PSD Hermitian matrices of trace $1$; their convex combinations are again states — the *statistical mixtures* of Part 9.

**The trace and trace functionals.** The **trace** $\operatorname{tr}(M)=\sum_i M_{ii}=\sum_i\lambda_i$ is linear and basis-independent. On the real vector space of $d\times d$ Hermitian matrices, the bilinear form $\langle A,B\rangle:=\operatorname{tr}(AB)$ is an inner product, and **every linear functional** $v$ on that space has the unique form $v(u)=\operatorname{tr}(Bu)$ for some Hermitian $B$ (Riesz representation in finite dimensions). *This is the one linear-algebra fact the quantum coda needs:* an affine-on-mixtures assignment $v(\rho)$ is, by Theorem 6 plus this representation, exactly $\operatorname{tr}(A\rho)+b$.

**The singular value decomposition.** Any real (or complex) $m\times n$ matrix $M$ factors as
$$
M\;=\;U\,\Sigma\,V^{\mathsf T},\qquad \Sigma=\operatorname{diag}(\sigma_1\ge\sigma_2\ge\cdots\ge0),
$$
with $U,V$ orthogonal/unitary. The $\sigma_i\ge0$ are the **singular values** — the square roots of the eigenvalues of $M^{\mathsf T}M$, i.e. the lengths of the semi-axes into which $M$ stretches the unit sphere. Geometry: $M$ = (rotate) $\circ$ (scale axes by $\sigma_i$) $\circ$ (rotate). The **spectral (operator) norm** is $\|M\|=\sigma_1$, the largest stretch. **Low-rank approximation (Eckart–Young):** truncating to the top $k$ singular values gives the best rank-$k$ approximation in operator and Frobenius norm — the mathematics of **PCA** and of dimensionality reduction. *Conceptual bridge to keep:* discarding small singular values is a **resolution reduction** — a low-rank projection is a coarser "view," exactly parallel to coarsening a $\sigma$-algebra on the resolution axis. The directions with large $\sigma_i$ carry the resolution; those with small $\sigma_i$ are what coarsening throws away.

**The spectral gap and over-smoothing (forward pointer to Part 8).** A graph-convolution (GCN-style) aggregation acts as a linear operator whose eigenvalues satisfy $1=\mu_1>|\mu_2|\ge\cdots$. The **spectral gap** is $1-|\mu_2|$, and the informative (non-constant) part of a signal contracts under $L$ layers at rate $|\mu_2|^L$. Beyond a critical depth, distinct representations collapse toward the dominant eigenvector and the achievable error floor *rises* — **over-smoothing**. Singular/eigen-values govern *how fast resolution is lost*; Proposition 8 governs *which uncertainty functions can detect any loss at all*. They meet in Part 8.

### R.9 The bridge: how the prerequisites meet the one-line theorem

Here is the whole chain, so you can see why Part R was assembled the way it is.
1. (R.3) A two-point posterior $\eta=u_1\mathbf{1}_A+u_2\mathbf{1}_{A^c}$ has mean $p u_1+(1-p)u_2$ with $p=\mu(A)$.
2. (R.4) On an **atomless** space, $p$ ranges over **all** of $[0,1]$ (Sierpiński).
3. (R.7) The uncertainty function $G$ is the Bayes-risk profile; "resolution-blind" means $\mathbb{E}[G(\eta)]=G(\mathbb{E}[\eta])$ for every two-cell $\eta$ — Jensen saturates.
4. (R.5) Saturation at all $p,u_1,u_2$ *is* the continuous-coefficient equation $(\star)$.
5. (Theorem 1) $(\star)$ on a real continuum forces $G$ affine — **no regularity** — by the chord substitution $u_1:=M,\ u_2:=0,\ p:=v/M$.
6. (R.6) The classical theory instead keeps the Jensen *slack* and studies it via convexification (the $\psi$-transform); Section 5's point is that the slack is identically zero here, so the duality machinery is idle.

That is Proposition 8 in six lines, and everything else in Section 5 is the field guide that tells you when steps 2 and 3 actually hold — and when they only appear to.

---

## Part 1 — The engine, recalled with proof

Section 5 is an application of two earlier results. We restate them so this reader stands alone.

Let $M>0$, $I=[0,M]$. Call $G\colon I\to\mathbb{R}$ a **saturated** solution if
$$
p\,G(u_1)+(1-p)\,G(u_2)=G\big(p\,u_1+(1-p)\,u_2\big)\qquad(u_1,u_2\in[0,M],\ p\in[0,1]).
\tag{$\star$}
$$
A function is **affine** if $G(v)=\alpha v+\beta$; the affine function through the endpoint values is $L(v):=G(0)+\dfrac{G(M)-G(0)}{M}\,v$.

> **Theorem 1 (`thm:main`).** Every saturated solution on $[0,M]$ equals $L$; in particular it is affine, with **no regularity hypothesis** (no continuity, monotonicity, boundedness, or measurability).

*Proof (the chord/endpoint substitution).* Fix $v\in[0,M]$ and take $u_1=M$, $u_2=0$, $p=v/M\in[0,1]$ in $(\star)$:
$$
\tfrac{v}{M}G(M)+\big(1-\tfrac{v}{M}\big)G(0)=G\big(\tfrac{v}{M}\cdot M+(1-\tfrac{v}{M})\cdot 0\big)=G(v),
$$
so $G(v)=G(0)+\big(G(M)-G(0)\big)v/M=L(v)$. $\qquad\blacksquare$

One real weight $p=v/M$ pins $G(v)$ onto the chord. *That single line is the entire mechanism of Proposition 8.* The multiclass and quantum cases need the vector-space version:

> **Theorem 6 (`thm:higher`).** Let $C$ be a convex subset of a real vector space $V$, and let $G\colon C\to\mathbb{R}$ satisfy $G(p\,u_1+(1-p)\,u_2)=p\,G(u_1)+(1-p)\,G(u_2)$ for all $u_1,u_2\in C$ and all $p\in[0,1]$. Then $G$ is **affine on $C$**: $G$ agrees with $\ell+b$ for a linear functional $\ell$ on $V$ and a constant $b$. **No regularity hypothesis.**

The proof (in `reader-higher-dim.md`) fixes a basepoint $u_0\in C$, sets $g(w):=G(u_0+w)-G(u_0)$ on the directions $w$ into $C$, and shows $g$ is additive and $\mathbb{R}$-homogeneous *directly from the real-weighted identity* — the same endpoint trick, now along every segment in $C$. For $C=[0,1]$ it is Theorem 1; for $C=\Delta_k$ (the probability simplex) it gives "affine on the simplex," used in the $k$-class calibration and the quantum codas.

> **The one thing to carry forward.** Both theorems convert *a real continuum of mixing weights* into *affineness*, with nothing else assumed. Section 5 is the study of exactly when an applied derivation hands you that real continuum — and when it only seems to.

---

## Part 2 — A saturated identity is a family indexed by the weight

Before the four sources, internalize the reframing that makes the whole section work. A saturated Jensen identity
$$
p\,G(u_1)+(1-p)\,G(u_2)=G\big(p\,u_1+(1-p)\,u_2\big)
$$
is, before anything else, a **family of assertions indexed by the weight $p$**. Its genuine mathematical content is *precisely the set of weights $p$ for which the surrounding derivation actually licenses the assertion.* Two derivations that write the same display on the page can mean different theorems: one may license it for all real $p$, another only for $p$ rational, a third only "additively" (for integer combinations). **The first question to ask of any saturated identity is therefore: at which weights is it actually asserted?**

**The zeroth gate (logically prior to everything).** Theorem 1 takes a *function* as input and reports its *form*; it cannot conjure the function. So before asking *which weights*, ask: **does a real-valued solution of the identity provably exist at all?** An axiom system whose representation theorem fails has no $G$ for Theorem 1 to constrain, and the identity is vacuous. We will see this gate fail in the expected-utility example (Part 4.1) — the failure there is not a deficit of weights but the absence of any real-valued unknown. Only once the gate is cleared does the four-way classification by weights begin.

---

## Part 3 — Four sources of a saturated identity (the diagnostic)

A saturated identity arises from at least four structurally different sources. **Only one** is the regularity-free situation of Theorem 1; the four are easy to mistake for one another, and that mistake is the subject of the section.

> **Source 1 — Finite mixing.** If the only primitive is a binary mixture ("combine two objects in proportion $p$") and compound objects are built by *finitely iterating* it, the reachable weights are the **dyadic rationals**, and after closure under the operation at most the **rationals** $\mathbb{Q}\cap[0,1]$. Such a derivation licenses the rational-coefficient equation $(J_{\mathbb{Q}})$, **not** $(\star)$. By **Proposition 7** (`prop:JQ-pathology`), $(J_{\mathbb{Q}})$ admits non-affine Hamel solutions, so a regularity hypothesis is **genuinely required**, and Theorem 1 does **not** apply.

> **Source 2 — Additivity into a bounded codomain.** If the derivation delivers *additivity* of $G$ together with the information that $G$ takes values in a **bounded** set, then $G$ is affine by the classical theorem that a bounded additive function is linear (Steinhaus/Ostrowski — the boundedness struts of the dictionary). Here a regularity hypothesis (boundedness) is load-bearing, but it is **supplied free by the codomain**, not assumed by hand; the operative mechanism is not the endpoint substitution.

> **Source 3 — A Cauchy relative with a non-affine target.** If the equation that actually appears is a relative of Cauchy's equation whose intended solution is **not affine** (e.g. the concave Shannon entropy), a regularity hypothesis is needed to exclude Hamel-type pathological solutions, and $(\star)$ is *simply not the equation in play*.

> **Source 4 — A genuine continuum of real weights.** If the weight $p$ is a **real parameter realized inside the structure** — an atomless measure assigns every mass $p\in[0,1]$ (Sierpiński; Lyapunov in the vector case) — and the identity is asserted **directly** for that real $p$, with no detour through finite iteration, then the derivation licenses $(\star)$ at **every** real $p$, irrationals included. **Only now** does Theorem 1 apply, and only now is a regularity hypothesis on $G$ **vestigial**.

**The ordered diagnostic.** After the zeroth gate (does a solution exist?), the separating question is: *does the derivation assert the identity at **every real** weight because the weights form a genuine continuum in the structure* — or does it merely reach the **rationals** (source 1), lean on **boundedness of the codomain** (source 2), or solve a **Cauchy relative** whose answer is not affine (source 3)? In the continuum case the regularity hypotheses are vestigial and should be dropped; in the other three they are load-bearing and must be kept. (The taxonomy is not claimed exhaustive — countable $\sigma$-additive mixtures assert a strictly stronger identity with its own theory — but it covers the derivations one meets.)

**The trap is misclassification, and it runs both ways.** A source-1/2/3 derivation mistaken for source 4 makes an author **drop a hypothesis that was indispensable**. Conversely — the rarer, more seductive error — a source-4 derivation mistaken for a Cauchy problem makes an author **add a defensive hypothesis that was never needed.** *This paper exists because of an instance of the second error* (Part 10).

---

## Part 4 — Where the classical hypotheses are load-bearing

We start on the side of the line where the classical hypotheses earn their keep — which, against first intuition, is where *most* familiar "saturated Jensen" derivations live.

### 4.1 Expected-utility representation (a continuum that is only apparent) — the zeroth gate fails

In the von Neumann–Morgenstern tradition, a preference relation over lotteries that is complete, transitive, **independent**, mixture-continuous, and **Archimedean** is represented by a utility functional **linear in probability**:
$$
U\big(p\,L_1+(1-p)\,L_2\big)=p\,U(L_1)+(1-p)\,U(L_2).
$$
It is tempting to read this as $(\star)$ and offer Theorem 1 as a *continuity-free substitute for the Archimedean axiom*. **Resist.** The independence axiom is a condition on the *preference relation*; though stated for every real mixing weight, it does not by itself deliver a cardinal functional equation for a real-valued $U$. What produces a real-valued affine $U$ in the first place is the **Archimedean axiom** (acting as a topological mixture-continuity condition that embeds the indifference-class quotient into $\mathbb{R}$), and it is genuinely indispensable: **lexicographic preferences** are complete, transitive, and independent yet violate the Archimedean axiom and admit **no real-valued representation whatsoever**. So there is no $U$, and the displayed identity — and with it $(\star)$ — is *vacuous*. Theorem 1 cannot replace the Archimedean axiom because Theorem 1 **presupposes** a real-valued solution of $(\star)$, and the Archimedean axiom is exactly what produces one. In the language of Part 2, this is a **zeroth-gate failure**: not a deficit of weights (independence is stated at every real $p$) but the absence of any real-valued unknown for the equation to constrain.

### 4.2 The axiomatic characterization of Shannon entropy (a Cauchy relative) — source 3

In the Khinchin–Faddeev tradition, the entropy $H(p_1,\dots,p_n)=-\sum_i p_i\log p_i$ is singled out by symmetry, a normalization, and a **recursivity (grouping)** axiom. The recursivity axiom does **not** reduce to $(\star)$. It reduces to the **fundamental equation of information**, on the domain $D=\{(x,y)\in[0,1)^2:x+y\le1\}$,
$$
f(x)+(1-x)\,f\!\Big(\tfrac{y}{1-x}\Big)=f(y)+(1-y)\,f\!\Big(\tfrac{x}{1-y}\Big),
$$
for the information function $f(x)=H(x,1-x)$, whose unique physical solution is the **strictly concave** $f(x)=-x\log_2 x-(1-x)\log_2(1-x)$ (normalized $f(0)=f(1)=0$) — *emphatically not affine*. Being a Cauchy relative, it admits Hamel-type non-measurable solutions **unless a regularity hypothesis excludes them**. And the hypotheses historically used to exclude them are **exactly the five struts of the dictionary**, weakened one classical hypothesis at a time:
- **Continuity** — Faddeev (1957);
- **Integrability** — Tverberg (1958);
- **Measurability** — Lee (1964);
- **Boundedness on a set of positive measure** — Diderrich (1975);
- **Monotonicity on $[0,\tfrac12)$** — Kendall (1964), Borges (1967).

So the entropy characterization is the canonical place where the dictionary reappears in an applied setting — and there the hypotheses are **load-bearing**, because the equation is a Cauchy relative with a non-affine target. *It is the exact mirror of the calibration computation of Part 5, where a saturated identity of the same outward shape is genuinely $(\star)$.* (This contrast is the "mirrored dictionary" of Part 9.)

### 4.3 Linear opinion pools (boundedness from the codomain) — source 2

If several experts' probability assignments are aggregated by a rule that **commutes with marginalization**, the rule must be a weighted average — a **linear opinion pool** — as soon as the space has at least three points (McConway 1981; Aczél–Wagner 1980). The aggregation function is **additive** across disjoint events and takes values in $[0,1]$ because its outputs are probabilities; **linearity then follows from the bounded-additive theorem**, not from the endpoint substitution. As in the utility case the saturated identity is real, but the work is done by a classical regularity property — here **boundedness, supplied by the codomain** — rather than by a continuum of weights.

---

## Part 5 — Surrogate calibration on the resolution axis: the vocabulary

Now the other side of the line, where the continuum of weights is real and Theorem 1 does its work. The central object travels under many names, so we fix vocabulary first.

**The setup.** Let $(\Omega,\mathcal{F},\mu)$ be an **atomless** probability space (R.4), $Y\in\{0,1\}$ a binary outcome, and $\mathcal{F}_0\subseteq\mathcal{F}$ a sub-$\sigma$-algebra of **features**. The **posterior probability profile** is the $\mathcal{F}_0$-measurable random variable
$$
\eta:=\mathbb{E}[Y\mid\mathcal{F}_0]=\mathbb{P}(Y=1\mid\mathcal{F}_0)\in[0,1].
$$
For an action space $\mathcal{A}$ and loss $\ell\colon\mathcal{A}\times\{0,1\}\to\mathbb{R}$, the **conditional Bayes risk** at posterior value $u\in[0,1]$ is
$$
H(u):=\inf_{a\in\mathcal{A}}\mathbb{E}\big[\ell(a,Y)\mid\eta=u\big],
$$
the **Bayes envelope / generalized entropy / uncertainty function** of the score (Savage; DeGroot–Fienberg; Grünwald–Dawid; Gneiting–Raftery). For $0$–$1$ loss with $\mathcal{A}=\{0,1\}$ it is the symmetric **tent** $H(u)=\min(u,1-u)$. Write $G\colon[0,1]\to\mathbb{R}$ for a *candidate* uncertainty function — and, for now, let it be **arbitrary** (no concavity, no anything).

**Resolution.** A sub-$\sigma$-algebra $\mathcal{G}\subseteq\mathcal{F}_0$ is a **resolution**: the coarser $\mathcal{G}$, the less the forecast distinguishes states. Writing $\eta_{\mathcal{G}}:=\mathbb{E}[\eta\mid\mathcal{G}]=\mathbb{E}[Y\mid\mathcal{G}]$ (tower property, R.4), the **risk attainable at resolution $\mathcal{G}$** is
$$
U_G(\mathcal{G}):=\mathbb{E}\big[G(\eta_{\mathcal{G}})\big],\qquad\text{so}\quad U_G\big(\sigma(A)\big)=\mu(A)\,G(u_1)+\mu(A^c)\,G(u_2)
$$
when $\eta$ takes value $u_1$ on an event $A\in\mathcal{F}_0$ and $u_2$ on $A^c$. **This two-cell expression is exactly the left side of $(\star)$ with weight $p=\mu(A)$** (R.3). That is the whole bridge.

**The classical theory runs with concavity in hand.** Every Bayes envelope is concave (an infimum of affine functions of $u$, R.6), and for concave $G$ the functional $U_G$ **decreases under refinement** — conditional Jensen plus the tower property — which is **Blackwell's comparison of experiments** in this setting and the **refinement ordering** of DeGroot–Fienberg. The drop it measures is the **resolution** term in the decomposition of a proper score: Murphy's partition of the Brier score, Bröcker's generalization to every proper score, and the empirical $\bar S=\mathrm{MCB}-\mathrm{DSC}+\mathrm{UNC}$ of Dimitriadis–Gneiting–Jordan. **Every statement in this chain assumes $G$ concave**; the empirical theory adds measurability or smoothness besides.

The dictionary's contribution is the **converse**, and it needs **none** of that.

---

## Part 6 — Proposition 8: resolution-blind uncertainty functions are affine

> **Proposition 8 (`prop:resolution`).** Let $(\Omega,\mathcal{F},\mu)$ be atomless and $G\colon[0,1]\to\mathbb{R}$ **arbitrary**. Suppose the two-cell resolutions are exact: for all $u_1,u_2\in[0,1]$ and every event $A$,
> $$
> \mu(A)\,G(u_1)+\mu(A^c)\,G(u_2)=G\big(\mathbb{E}[\eta]\big),\qquad \eta=u_1\mathbf{1}_A+u_2\mathbf{1}_{A^c}.
> $$
> Then $G$ is **affine**; consequently $U_G(\mathcal{G})=G(\mathbb{E}[\eta])$ for **every** $[0,1]$-valued posterior $\eta$ and **every** sub-$\sigma$-algebra $\mathcal{G}$, so $G$ is **blind to resolution at all scales**. **No continuity, measurability, monotonicity, boundedness — or concavity — is assumed.** The $k$-class case ($\eta$ valued in the simplex $\Delta_k$, $G$ arbitrary on $\Delta_k$) holds verbatim with "affine on the simplex," by Theorem 6.

*Proof.* Atomlessness realizes **every** mass $p=\mu(A)\in[0,1]$ (Sierpiński, R.4), and the values $u_1,u_2$ are prescribed **independently of $A$**. So as $A$ ranges over events of every mass and $u_1,u_2$ range over $[0,1]$, the hypothesis asserts
$$
p\,G(u_1)+(1-p)\,G(u_2)=G\big(p\,u_1+(1-p)\,u_2\big)\qquad\text{at every triple }(p,u_1,u_2)
$$
— this is $(\star)$ on its entire domain, with $G$ only ever **evaluated at points, never integrated**. Theorem 1 gives affineness on $[0,1]$; Theorem 6 with $C=\Delta_k$ gives the simplex case. Conversely, for affine $G$ and any $\mathcal{G}$, linearity of expectation and the tower property give $\mathbb{E}[G(\eta_{\mathcal{G}})]=G(\mathbb{E}[\eta_{\mathcal{G}}])=G(\mathbb{E}[\eta])$. $\qquad\blacksquare$

**The seductive misclassification, in the flesh.** The saturated identity *looks* like a Cauchy problem and invites a defensive boundedness or measurability hypothesis on $G$ — exactly the reflex that Cauchy/Hamel training instills. But the **continuum of cell masses** (atomlessness) makes it genuine $(\star)$ — *source 4*, not source 3 — and the hypothesis is **vestigial**. The contrast with §4.2 is total: there the equation is a Cauchy relative whose solution is concave, so the same five hypotheses are indispensable; here the equation is $(\star)$, so they are conclusions, not assumptions.

**What the proof did and did not use.** It used (i) atomlessness, to get *all real $p$*; (ii) that $u_1,u_2$ are free of $A$, so the triple ranges fully; (iii) the chord substitution. It did **not** use any property of $G$. Remove atomlessness and you fall to a coin (Part 9) — dyadic $p$ only, source 1, pathology back. Tie $u_1,u_2$ to $A$ and the triple no longer ranges freely. *Both failure modes are live exam questions.*

---

## Part 7 — The benchmark partition and the tent (Corollary 5)

What survives when exactness holds only **locally**? Corollary 5 (`cor:piecewise`): a surrogate that aggregates exactly on **each cell** of a fixed benchmark partition of the probability axis is **affine on each cell**, with **continuity at the knots for free** (no hypothesis). For the canonical benchmark $\{[0,\tfrac12],[\tfrac12,1]\}$ the resulting shape is the **tent** — and the tent is not merely an example:

- $T_{1/2}(u)=\min(u,1-u)$ **is** the $0$–$1$ conditional Bayes risk (R.7).
- The **elementary scores** of Schervish (1989) and Ehm–Gneiting–Jordan–Krüger (2016) have as their uncertainty functions precisely the **tents with apex at $\theta\in(0,1)$**,
$$
T_\theta(u):=2\min\big(u(1-\theta),\,(1-u)\theta\big),
$$
and the **mixture representation** $S=\int_0^1 S_\theta\,dH(\theta)$ of every proper score exhibits every admissible uncertainty function as a mixture of tents, $G=\int_0^1 T_\theta\,dH(\theta)$. For instance $\int_0^1 T_\theta\,d\theta=u(1-u)$, the **Brier entropy** (a one-line integral worth doing once — Exercise X16).
- The tents are the **extreme rays** of the convex cone of uncertainty functions; piecewise saturation pins exactly them.

**Learning-theoretic reading (the bracket).** Cellwise exactness is *tightness of the surrogate-risk bracket*: the $\psi$-transform of Bartlett–Jordan–McAuliffe, Steinwart's calibration functions, and the multiclass analysis of Tewari–Bartlett all measure how far a surrogate's floor sits from the true floor (R.6–R.7). **Exactness on a cell says the gap is zero there**, and Corollary 5 says the *price of zero gap is affineness on the cell*. This is the precise meeting point of the loss axis (where the gap $\psi$ is the object of study) and the resolution axis (where its vanishing forces structure).

> **Figure (manuscript `fig:resolution`), in words.** *Panel (a):* refining the partition can only lower $U_G(\mathcal{G})=\mathbb{E}[G(\eta_{\mathcal{G}})]$ when $G$ is concave (conditional Jensen; Blackwell); the drop is the resolution term of the score decompositions. By Proposition 8 the only uncertainty functions with a **flat** profile — resolution-blind at every two-cell comparison — are the **affine** ones, with nothing assumed. *Panel (b):* the bold tent $T_{1/2}=\min(u,1-u)$ is the $0$–$1$ Bayes envelope; faint tents $T_{0.3},T_{0.7}$ are elementary-score uncertainty functions; the dashed parabola $u(1-u)=\int_0^1 T_\theta\,d\theta$ is the Brier entropy (uniform mixture); exactness on each benchmark cell forces affineness on each cell (Corollary 5), pinning the tent with nothing assumed at the kink.

---

## Part 8 — Two readings (and where the SVD enters)

The construction travels into two CS-adjacent settings.

**Probabilistic graphical models.** A clique tree is **calibrated** when neighboring cliques agree on their sepset marginals (Koller–Friedman). This cellwise agreement *is* the piecewise identity of Part 7, asserted over the sepset partition, and $U_G$ is the natural uncertainty functional along the junction tree's resolution order. Belief propagation is, in this light, a march along the resolution axis.

**Representation learning and the error floor.** An encoder $R$ induces the resolution $\mathcal{G}=\sigma(R)$ (the $\sigma$-algebra of "what $R$ can tell apart"), and $U_{T_{1/2}}(\sigma(R))$ is the **smallest misclassification error achievable from the representation** — its **error floor**. Proposition 8 then says: **the only uncertainty functions blind to the choice of representation are the affine ones.** Any genuinely concave $G$ certifies, through a strict drop of $U_G$, that the representation *gained resolution*. Affine $G$ is the degenerate score that can never tell two encoders apart.

> **Where the SVD and the spectral gap enter (companion-paper reading; not needed for Proposition 8).** In a graph neural network the layer-wise aggregation is a **linear operator** whose eigenvalues satisfy $1=\mu_1>|\mu_2|\ge\cdots$ (R.8). For *contractive* aggregators (GCN, mean, symmetric-normalized) the informative (non-constant) component of the signal contracts under $L$ layers at rate $|\mu_2|^L$; past a critical depth $L^\ast(\varepsilon)\approx\log(C/\varepsilon)/\log(1/|\mu_2|)$ distinct representations collapse toward the dominant eigenvector, the realized resolution $\sigma(R)$ **coarsens**, and the error floor $U_{T_{1/2}}(\sigma(R))$ **rises** — this is **over-smoothing**. The **spectral gap** $1-|\mu_2|$ sets its onset; singular/eigen-values govern **how fast resolution is lost**. Proposition 8 is the orthogonal statement: it governs **which uncertainty functions can detect any loss of resolution at all** (answer: exactly the non-affine ones). The SVD picture (low-rank truncation = resolution reduction, R.8) is the linear-algebra avatar of coarsening a $\sigma$-algebra: discarding small singular directions is discarding resolution, and the size of the discarded $\sigma_i$ is the resolution lost.

---

## Part 9 — The thin line in miniature; quantum states; the mirrored dictionary

### 9.1 Atomless vs. a single coin — the whole section in one contrast

Replace the atomless space by **a single fair coin**, building mixtures by tossing it repeatedly. Then the attainable masses $p$ collapse to the **dyadic rationals**, and one is back in **source 1**: Proposition 7 returns a non-affine (Hamel) solution, and a regularity hypothesis is once more required. *The entire content of the dictionary and of Section 5 is visible in the gap between an atomless measure and a coin.* Atomless $\Rightarrow$ all real $p$ $\Rightarrow$ $(\star)$ $\Rightarrow$ regularity vestigial; coin $\Rightarrow$ dyadic $p$ $\Rightarrow$ $(J_{\mathbb{Q}})$ $\Rightarrow$ regularity essential.

> **Terminology caution.** The property tested throughout is that $G$ **commutes with expectation** over two-point laws — we call the family **expectation-exact** — rather than "mean-preserving," a term already taken by mean-preserving spreads in economics.

### 9.2 Mixture-affine assignments on quantum states (a second source-4 instance, via Theorem 6)

The density operators $\mathcal{S}_d$ on $\mathbb{C}^d$ form a convex set (R.8), and the statistical mixture $p\,\rho_1+(1-p)\,\rho_2$ is **operationally primitive**: prepare $\rho_1$ with probability $p$ using a classical randomizer, with $p$ a **genuine continuum**. Let $v\colon\mathcal{S}_d\to\mathbb{R}$ respect mixtures,
$$
v\big(p\,\rho_1+(1-p)\,\rho_2\big)=p\,v(\rho_1)+(1-p)\,v(\rho_2)\qquad(p\in[0,1]).
$$
This is exactly the hypothesis of **Theorem 6** on $C=\mathcal{S}_d$, so $v$ extends to linear-plus-constant; since every linear functional on the real space of Hermitian operators is $u\mapsto\operatorname{tr}(Bu)$ (R.8), we get
$$
v(\rho)=\operatorname{tr}(A\rho)+b\qquad(A\text{ Hermitian}),
$$
with **no positivity, boundedness, continuity, or measurability** assumed of $v$.

**The measurement side pays more (Gleason).** Gleason-type theorems work not on state preparation but on **measurement**: a frame function on effects is additive over **coarse-grainings** of measurements (grouping disjoint outcomes = operator addition, $E_1+E_2\le I$), and coarse-graining is **finite/rational mixing — source 1**. Additivity yields homogeneity only over the **nonnegative rationals**, and the rational-to-real step must be purchased with a regularity hypothesis: **nonnegativity** in Gleason's projection theorem ($d\ge3$), in Busch's POVM version ($d\ge2$), **positivity or explicit continuity** in Caves–Fuchs–Manne–Renes, and the Hamel-pathology catalog of Wright–Weigert (non-measurable frame functions, bounded on neither side, discontinuous). *State preparation tests the identity directly at every real $p$ via analog mixing (source 4); measurement coarse-graining tests it only additivity-wise (source 1), allowing dense Hamel oscillations unless bounded or positive.* The dictionary predicts exactly where each route must spend a hypothesis.

### 9.3 The mirrored dictionary and the lesson

The same five hypotheses sit on **opposite sides** depending on the source. Placed side by side:

| Hypothesis on the unknown $G$ | Entropy characterization (a **Cauchy relative**, source 3) | Saturated $(\star)$ on an **atomless** space (source 4) |
|---|---|---|
| Continuity | **Required** (Faddeev) | **Vestigial** — a conclusion (Corollary 2) |
| Measurability | **Required** (Lee) | **Vestigial** — same |
| Monotonicity | **Required** (Kendall, Borges) | **Vestigial** — same |
| Boundedness on a positive-measure set | **Required** (Diderrich) | **Vestigial** — same |
| Boundedness on the interval | **Required** (a fortiori) | **Vestigial** — same |
| **None** | **Insufficient** — Hamel solutions | **Sufficient** — Theorem 1 |

**The lesson.** The outward shape of a saturated Jensen identity tells you *nothing* about whether it needs a regularity hypothesis. The source does. Ask the zeroth-gate question (does a solution exist?), then ask the separating question (real continuum, or only rationals / bounded codomain / Cauchy relative?). Get the source right and the hypothesis question answers itself; get it wrong and you either lose a theorem or carry dead weight.

---

## Part 10 — Reconstruction checklist, provenance, and 60-second recap

### 10.1 From-scratch reconstruction checklist

You can rebuild Section 5 on a blank page if you can produce, in order:
1. The reframing: a saturated identity is a **family indexed by $p$**; its content is *which weights are licensed* (Part 2).
2. The **zeroth gate**: does a real-valued solution exist? (Part 2; expected-utility failure, 4.1.)
3. The **four sources** and the **ordered diagnostic** (Part 3).
4. The three **load-bearing** cases — utility (gate), entropy (Cauchy relative + five struts), opinion pools (bounded codomain) (Part 4).
5. The calibration **vocabulary**: atomless space, posterior $\eta$, Bayes envelope $H$, resolution $\mathcal{G}$, $U_G$, the two-cell identity $=$ left side of $(\star)$ (Part 5).
6. **Proposition 8** and its four-line proof via Theorem 1; what it does *not* assume (Part 6).
7. The **tent** via Corollary 5; tents as extreme rays; the bracket reading (Part 7).
8. The **coin contrast** and the **quantum** instance via Theorem 6 (Part 9).

### 10.2 Provenance (the second-error story, briefly)

The chord substitution surfaced while formalizing the companion paper [El2] in **Lean 4 / Mathlib**. The relevant lemma — "$(\star)$ on $[0,M]$ $\Rightarrow$ affine" — was first written **with a defensive boundedness hypothesis on $G$**, in deference to the Cauchy–Hamel literature. The proof body instantiated $(\star)$ at $u_1=M,u_2=0,p=v/M$ and closed in two lines; the boundedness witness was **never referenced**. Removing it, the assistant re-checked: Theorem 1 holds with **no regularity hypothesis at all**. Going back to Aczél and Kuczma confirmed the chord closure is **folkloric** in the functional-equations community; what is new is the **packaging** — the dictionary, the four-source field guide, and the recognition that the trap recurs in modern applications. *The honest order was: proof assistant first, books second.* The moral: a defensive hypothesis is not free (every user must later verify it), and mechanized proof forces precision about *which* hypotheses are load-bearing.

### 10.3 Sixty-second recap

A saturated Jensen identity is a family indexed by the weight $p$. **First** ask whether a real-valued solution exists (the zeroth gate; expected utility fails here). **Then** ask *why* the identity holds: finite mixing (rationals → pathology survives → hypothesis needed), additivity into a bounded codomain (boundedness load-bearing), a Cauchy relative with a non-affine target (Shannon entropy → hypothesis needed), or a **genuine continuum of real weights** (atomless measure → $(\star)$ → **hypothesis vestigial**). Surrogate calibration on the resolution axis is the clean continuum case: with $G$ the uncertainty function and the cell mass $p$ ranging over the **real** interval, two-cell exactness at every $p$ forces $G$ affine — no continuity, measurability, monotonicity, boundedness, or concavity (**Proposition 8**, four lines from Theorem 1). Locally it pins the tent (Corollary 5). The same five hypotheses that are *vestigial* here are *load-bearing* for the entropy characterization — same shape, opposite source. The whole section is the gap between an atomless measure and a coin.

---

## Part E — Extreme examples & common traps

Each trap states the **tempting** wrong move and the **kill**. These are exactly the slips a strong CS reader makes on first contact. Cross-references point to the exercises that drill them.

> **Trap E1 — "Surrogate calibration needs $G$ concave (or bounded, or measurable) — it's a Bayes risk."** *Tempting:* the whole classical chain (Blackwell, score decompositions) assumes concavity, so surely the result does too. *Kill:* Proposition 8 assumes **nothing** about $G$. The atomless continuum of cell masses makes the hypothesis the genuine equation $(\star)$, and Theorem 1 supplies affineness with no regularity. Concavity is the classical *input*; here it is not even an output — *affineness* is (the degenerate concave). (X7, X24.)

> **Trap E2 — "The resolution axis and the loss axis are the same calibration story."** *Tempting:* both are "surrogate calibration." *Kill:* the **loss axis** varies the predictor/loss and tracks Jensen as an **inequality** with slack — the $\psi$-transform, a *strictly positive* calibration function for smooth surrogates. The **resolution axis** varies the $\sigma$-algebra and **saturates** Jensen to an equality. Slack vs. saturation; conjugate duality vs. the chord substitution. (X23.)

> **Trap E3 — "Any continuous random variable gives all weights $p$, so atomlessness is automatic."** *Tempting:* "atomless ≈ continuous." *Kill:* atomless means *no atoms*; the operative consequence is **Sierpiński**: every mass $t\in[0,1]$ is realized by some event. A **fair coin** has an atom of mass $\tfrac12$ and yields only masses $\{0,\tfrac12,1\}$; $n$ tosses give only **dyadic** $k/2^n$. The continuum is what separates source 4 from source 1. (X3, X8.)

> **Trap E4 — "Proposition 8 proves $G$ is concave."** *Tempting:* Bayes risks are concave, and Prop 8 is about Bayes risks. *Kill:* "every Bayes envelope is concave" (an inf of affine functions, R.6) is a **separate** fact about *genuine* Bayes risks. Proposition 8 takes an **arbitrary** $G$ and concludes it is **affine** — not merely concave — *from the saturation hypothesis*. Don't import concavity into a theorem that assumes none. (X4, X5, X24.)

> **Trap E5 — "Expected utility is a fourth-source (continuum) example, since independence holds at every real $p$."** *Tempting:* the mixing weight in vNM is a real number. *Kill:* it is a **zeroth-gate failure**, *prior to* the four-source classification. Independence constrains the *preference relation*, not a real-valued $U$; **lexicographic preferences** are complete, transitive, independent yet have **no** real-valued representation, so there is no $U$ and $(\star)$ is vacuous. (X11.)

> **Trap E6 — "Shannon entropy is a saturated-Jensen example, so its regularity hypotheses are vestigial too."** *Tempting:* the entropy derivation also pushes Jensen around. *Kill:* the operative equation is the **fundamental equation of information**, a **Cauchy relative** whose solution is the **strictly concave** entropy — *not affine*. That is **source 3**: a regularity hypothesis is **load-bearing**, exactly as in the mirrored dictionary. Same outward shape, opposite source. (X12, X10.)

> **Trap E7 — "The tower property $\mathbb{E}[\mathbb{E}[\eta\mid\mathcal{G}]]=\mathbb{E}[\eta]$ needs independence or concavity."** *Tempting:* it looks like it should need *something*. *Kill:* the tower property and linearity of conditional expectation hold on **any** probability space, unconditionally. This is why the **converse** half of Proposition 8 (affine $\Rightarrow$ resolution-blind) needs **no** atomlessness. (X9.)

> **Trap E8 — "Refining the partition always lowers $U_G$."** *Tempting:* "more information is better." *Kill:* $U_G$ decreases under refinement **only for concave $G$** (conditional Jensen). For *convex* $G$ it **increases**; for *affine* $G$ it is **constant** — that constancy is precisely resolution-blindness, the hypothesis of Proposition 8. (X13.)

> **Trap E9 — "Proposition 8 and its converse both need the atomless space."** *Tempting:* symmetry. *Kill:* the **forward** direction (resolution-blind $\Rightarrow$ affine) needs the continuum of masses; the **converse** (affine $\Rightarrow$ resolution-blind) is pure tower property and holds on a coin, a die, anything. Know which half uses which hypothesis. (X9.)

> **Trap E10 — "Cellwise exactness on the benchmark partition makes $G$ globally affine."** *Tempting:* affine on each piece, so affine overall. *Kill:* Corollary 5 gives **piecewise** affine with **automatic continuity at the knots**, *not* global affineness — the slopes on $[0,\tfrac12]$ and $[\tfrac12,1]$ may differ. The tent itself is the example: two different slopes, continuous at $\tfrac12$, not globally affine. (X17.)

> **Trap E11 — "The tent is just one illustrative uncertainty function."** *Tempting:* it's a cute piecewise-linear example. *Kill:* $T_{1/2}(u)=\min(u,1-u)$ **is** the $0$–$1$ Bayes risk; the tents $T_\theta$ are the **extreme rays** of the cone of uncertainty functions; and **every** admissible uncertainty function is a mixture $\int_0^1 T_\theta\,dH(\theta)$ (e.g. Brier $u(1-u)=\int_0^1 T_\theta\,d\theta$). The tent is the generator, not an anecdote. (X16, X18.)

> **Trap E12 — "The SVD / spectral gap is part of the proof of Proposition 8."** *Tempting:* the reader builds the SVD, so it must be used. *Kill:* Proposition 8 uses **nothing beyond affine functions of a real variable**. The SVD and the spectral gap appear only in the **companion-paper reading** (over-smoothing: the *rate* at which resolution is lost, $|\mu_2|^L$) and the **quantum coda** (trace functionals). Rate of loss $\ne$ which $G$ detects loss. (X12 is *not* this; see X20.)

> **Trap E13 — "$v(\rho)=\operatorname{tr}(A\rho)+b$ needs $A$ positive semidefinite or $v$ bounded."** *Tempting:* quantum observables are usually PSD. *Kill:* Theorem 6 delivers the affine form with **no positivity, boundedness, continuity, or measurability**; $A$ is merely **Hermitian**. The state-preparation route tests the identity at every real $p$ (source 4), so the regularity is vestigial. (X21.)

> **Trap E14 — "Gleason's theorem is a continuum (source-4) result like state preparation."** *Tempting:* both are 'quantum probability'. *Kill:* Gleason works on the **measurement** side: frame functions are additive over **coarse-grainings**, which is **finite/rational mixing — source 1**. Additivity gives only rational homogeneity, so the rational-to-real step must buy a hypothesis (nonnegativity/positivity/continuity). State *preparation* is source 4; *measurement* is source 1. (X22.)

> **Trap E15 — "Expectation-exact is the same as mean-preserving."** *Tempting:* both mention means. *Kill:* "mean-preserving" already names *mean-preserving spreads* in economics. The property here — $G$ **commutes with expectation** over two-point laws — is called **expectation-exact** to avoid the clash. A naming trap, but graders notice. (X14.)

---

## Part X — Exercises (24)

> Difficulty: ★ routine · ★★ standard · ★★★ challenging. Attempt before reading Part S. Many are phrased the way an oral examiner would ask.

**X1 (★).** Let $\eta=u_1\mathbf{1}_A+u_2\mathbf{1}_{A^c}$ on a probability space, with $p:=\mu(A)$. Show $\mathbb{E}[\eta]=p\,u_1+(1-p)\,u_2$, and identify this with the left mixing weight of $(\star)$.

**X2 (★).** For a two-block partition $\mathcal{G}=\sigma(\{B,B^c\})$, write $\mathbb{E}[X\mid\mathcal{G}]$ explicitly and verify the tower property $\mathbb{E}[\mathbb{E}[X\mid\mathcal{G}]]=\mathbb{E}[X]$ by direct computation.

**X3 (★★).** On $([0,1],\text{Lebesgue})$ exhibit, for each $t\in[0,1]$, an event of mass exactly $t$ (so the space is atomless and Sierpiński holds constructively). Then show that the $\sigma$-algebra generated by a single fair coin yields only masses in $\{0,\tfrac12,1\}$, and that $n$ independent tosses yield only the dyadics $k/2^n$. State the moral for sources 1 vs. 4.

**X4 (★).** Prove the strict-convexity equality case: if $G$ is strictly convex and $G(p u_1+(1-p)u_2)=p\,G(u_1)+(1-p)\,G(u_2)$ for some $p\in(0,1)$, then $u_1=u_2$. Deduce that a function satisfying the *non-degenerate* two-point identity for all $u_1\ne u_2$ can have no strict convexity anywhere.

**X5 (★★).** Show $H(u)=\inf_{a\in\mathcal{A}}\big(u\,\ell(a,1)+(1-u)\,\ell(a,0)\big)$ is concave on $[0,1]$. Compute $H$ for (a) $0$–$1$ loss with $\mathcal{A}=\{0,1\}$, (b) log loss, (c) Brier loss, and identify the tent, Shannon entropy, and $u(1-u)$.

**X6 (★★).** Asymmetric $0$–$1$ loss: $\mathcal{A}=\{0,1\}$, $\ell(1,0)=1$, $\ell(0,1)=c>0$, else $0$. Find the conditional Bayes risk $H(u)$, the threshold where the optimal action switches, and the apex of the resulting (skew) tent.

**X7 (★).** State Proposition 8 precisely and give its complete four-line proof, citing exactly where atomlessness, the freedom of $u_1,u_2$, and Theorem 1 are used.

**X8 (★★).** Pinpoint the single step of the Proposition 8 proof that fails on a fair coin. Using Proposition 7 (`prop:JQ-pathology`) as a black box, explain why the conclusion is *false* there: exhibit (in words) a non-affine $G$ satisfying the dyadic-weight identity.

**X9 (★★).** Prove the converse half of Proposition 8: if $G$ is affine then $U_G(\mathcal{G})=G(\mathbb{E}[\eta])$ for every $\mathcal{G}$ and every $\eta$. Show your proof uses only linearity and the tower property — never atomlessness — and state on which spaces it holds.

**X10 (★★).** Classify by source (1–4) and say whether a regularity hypothesis is load-bearing or vestigial: (a) a linear opinion pool commuting with marginalization; (b) the Khinchin–Faddeev entropy characterization; (c) two-cell calibration exactness on an atomless space; (d) compound lotteries built by finitely mixing two prizes.

**X11 (★★).** Explain why Theorem 1 cannot serve as a continuity-free replacement for the Archimedean axiom. Use lexicographic preferences on $[0,1]^2$ to show a complete, transitive, independent preference with no real-valued representation, and connect this to the zeroth gate.

**X12 (★★★).** Verify that $f(x)=-x\log_2 x-(1-x)\log_2(1-x)$ (with $f(0)=f(1)=0$) satisfies the fundamental equation of information $f(x)+(1-x)f\!\big(\tfrac{y}{1-x}\big)=f(y)+(1-y)f\!\big(\tfrac{x}{1-y}\big)$ on its domain. Then explain in one paragraph why this equation is **not** $(\star)$ and why, consequently, a regularity hypothesis is load-bearing here (source 3) while being vestigial in Proposition 8 (source 4).

**X13 (★★).** Prove that for **concave** $G$ and $\mathcal{G}\subseteq\mathcal{F}_0$, $U_G(\mathcal{F}_0)\le U_G(\mathcal{G})$ (refining lowers the uncertainty functional), using conditional Jensen and the tower property. State precisely what happens for convex $G$ and for affine $G$, and connect the affine case to resolution-blindness.

**X14 (★★).** With $\eta=u_1$ on $A$ and $u_2$ on $A^c$, $p=\mu(A)$, compute the resolution drop $U_G(\sigma(A))-U_G(\text{trivial})$ for the Brier entropy $G(u)=u(1-u)$. Show it equals $p(1-p)(u_1-u_2)^2\ge0$, with equality iff $u_1=u_2$, and interpret. (Mind the "expectation-exact vs. mean-preserving" naming, Trap E15.)

**X15 (★★).** Show $T_{1/2}(u)=\min(u,1-u)$ equals the $0$–$1$ conditional Bayes risk, is concave, has its only kink at $u=\tfrac12$, and is affine (slope $\pm1$) on each benchmark cell — so it is the canonical witness that Corollary 5 gives *piecewise*, not global, affineness.

**X16 (★★).** Compute $\int_0^1 T_\theta(u)\,d\theta$ where $T_\theta(u)=2\min\big(u(1-\theta),(1-u)\theta\big)$, and confirm it equals the Brier entropy $u(1-u)$. (Hint: the inner $\min$ switches at $\theta=u$.)

**X17 (★★).** Let $G$ satisfy $(\star)$ separately on $[0,\tfrac12]$ and on $[\tfrac12,1]$. Prove $G$ is affine on each cell and continuous at $\tfrac12$ with no extra hypothesis, but exhibit a concrete $G$ (e.g. the tent) whose two slopes differ, so $G$ is not globally affine.

**X18 (★★).** Argue that the tents $T_\theta$ are the extreme rays of the convex cone of (concave, vertex-vanishing) uncertainty functions: every such $G$ is a mixture $\int_0^1 T_\theta\,dH(\theta)$, and a tent cannot be written as a nontrivial mixture of distinct uncertainty functions. (Sketch the mixture-representation direction carefully; the indecomposability direction in one line.)

**X19 (★★).** Define the resolution $\sigma(R)$ induced by an encoder $R$, and explain why $U_{T_{1/2}}(\sigma(R))$ is the smallest misclassification error achievable from $R$ (the error floor). Then use Proposition 8 to explain why an **affine** uncertainty function can never certify that one encoder is better than another.

**X20 (★★★).** A contractive aggregation operator has eigenvalues $1=\mu_1>|\mu_2|\ge\cdots$. Show the informative (non-constant) component of a signal contracts at rate $|\mu_2|^L$ under $L$ layers, and that the critical depth is $L^\ast(\varepsilon)\approx\log(C/\varepsilon)/\log(1/|\mu_2|)$. Explain carefully why this governs the **rate** at which the resolution $\sigma(R)$ coarsens (over-smoothing) — and why this is **orthogonal** to Proposition 8, which governs **which** uncertainty functions detect any coarsening at all.

**X21 (★★).** Let $v\colon\mathcal{S}_d\to\mathbb{R}$ be affine on mixtures of density operators. Derive $v(\rho)=\operatorname{tr}(A\rho)+b$ for a Hermitian $A$, citing Theorem 6 and the Riesz representation of linear functionals on Hermitian matrices. State precisely which regularity hypotheses you did **not** use, and why (source 4).

**X22 (★★★).** Explain why a Gleason-type frame function, being additive over measurement coarse-grainings, satisfies only **rational** homogeneity, placing it in source 1 — so that the rational-to-real step must purchase nonnegativity/positivity/continuity (Gleason $d\ge3$; Busch $d\ge2$; CFMR). Contrast with state preparation (source 4), and explain why the *same* physical theory spends a regularity hypothesis on one route but not the other.

**X23 (★★).** Define the calibration function $\psi=\operatorname{conv}(H^{-}-H)$ and state the BJM comparison inequality $\psi(R-R^\ast)\le R_\varphi-R_\varphi^\ast$. Show the $0$–$1$ loss gives $\psi=\mathrm{id}$. Then explain the slogan "exactness on a cell $=$ the $\psi$-gap is zero there," and connect it to Corollary 5's conclusion that zero gap forces affineness on the cell.

**X24 (★★★).** *Mock qualifier.* A referee writes: *"Proposition 8 secretly assumes $G$ is a Bayes risk, hence concave, so the affineness conclusion is trivial."* Write a complete rebuttal: (a) what $G$ is assumed to be in the statement; (b) why concavity is the classical input and is *not* assumed here; (c) what the genuine content is (the converse, with no regularity); (d) where the referee has confused source 3 (Cauchy relative) with source 4 (genuine continuum). Keep it to a paragraph you could say aloud.

---
<!-- STAGE-C-END -->
