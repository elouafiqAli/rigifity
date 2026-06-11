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
<!-- STAGE-A-END -->
