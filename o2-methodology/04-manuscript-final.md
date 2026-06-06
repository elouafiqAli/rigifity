# Calibration on the resolution axis: a methodology note

*Manuscript draft 0.1. Post-Round 3 closure. Ready for submission to **EMS Magazine**; arXiv version (math.ST primary; cs.LG and math.PR secondary) deposited simultaneously. See [`05-submission-package.md`](05-submission-package.md) for the cover letter, the arXiv preface, and the venue ladder.*

*Audit history: skeleton [`01-skeleton-draft0.md`](01-skeleton-draft0.md) (Round 1, Executor E) → adversarial audit [`02-adversarial_audit.md`](02-adversarial_audit.md) (Round 2, Judge π + Judge S) → atomic closures [`03-closure-draft0.1.md`](03-closure-draft0.1.md) (Round 3, 8 commits) → this manuscript.*

---

## Abstract

Surrogate calibration controls the *excess risk of a learned predictor* in terms of the convexification of a level-set gap on the conditional Bayes risk. This note observes that the same convex-analytic machinery — concave generalized entropies, Jensen's inequality, level-set gaps — controls a *different* quantity along a *perpendicular* axis: the *partition-restricted Bayes risk* $\varepsilon^*(\Pi)$, the smallest error any classifier respecting a given measurement resolution $\Pi$ can achieve. We call this the *resolution-axis transposition*, give the two-sided bracket it produces (with universal upper constant $c_\varphi = \tfrac12$ for normalized concave scores), work out one two-cell numerical example end-to-end, and point at recent applications — to graph neural-network expressivity, to property testing, to refinement-lattice incomparability of aggregator architectures — that the transposition enables. The bracket itself, with proofs, is the subject of a companion paper.

**Keywords.** Surrogate calibration; comparison of experiments; refinement lattice; Bayes risk; concave generalized entropy; methodology.

**MSC2020.** Primary 62C05 (statistical decision theory), 62B15 (theory of statistical experiments); Secondary 68T05 (learning and adaptive systems).

---

## 1. Two axes through the same picture

The classical calibration question is: *given a loss I cannot optimize, what loss can I optimize, and how much does that cost me?* Modern answers — Bartlett, Jordan, and McAuliffe (2006); Zhang (2004); Reid and Williamson (2011) — control the excess risk of a learned predictor through the convexification of a level-set gap on the conditional Bayes risk. This note observes that the same machinery answers a perpendicular question.

The Bayes risk

$$
R^* := \inf_g \mathbb E\,\ell(Y, g(X)) ,\qquad \ell(y, a) := \mathbf 1\{y \ne a\},
$$

is the gold standard, but $\ell$ is non-convex, non-differentiable, discrete-valued, and refuses to play with gradient-based learning. So instead one optimizes a *surrogate* $\varphi$ — hinge, logistic, exponential, squared — and asks whether the minimizer of the surrogate risk is also a minimizer of the original. The answer, in its modern form, is the **$\psi$-transform inequality**

$$
\psi(R - R^*) \;\le\; R_\varphi - R_\varphi^* ,
$$

where $\psi$ is the convexification of the gap between the *conditional* Bayes risk and the conditional surrogate risk. The $\psi$-transform is the identity for the $0$-$1$ loss; every smooth surrogate is strictly above the identity at zero, paying for its differentiability with a calibration gap (Bartlett–Jordan–McAuliffe 2006). This is the **optimization axis** of the story: the measurement is fixed (we have full information on $X$), and the variable is the loss / the predictor. The convex-analytic gap is between the loss we *want* and the loss we *can*.

There is a perpendicular question. *Given a quantity I want to estimate, what is the smallest error I can achieve if I am allowed to see $X$ only through a coarser lens?* The lens is a partition $\Pi$ — equivalence classes of inputs that a constrained classifier cannot tell apart. The smallest error any classifier respecting that partition can achieve is the **partition-restricted Bayes risk**

$$
\varepsilon^*(\Pi) \;=\; \sum_i p_i\,\min(\eta_i, 1-\eta_i),
$$

where $p_i$ is the mass of the $i$-th cell and $\eta_i$ its conditional label rate. This is the *Bayes risk at resolution $\Pi$* — what is *representable* given the lens, before any classifier is trained.

The two axes meet at the same convex-analytic machinery. A concave score $\varphi$ on $[0,1]$ — Shannon entropy, the rescaled variance $4\eta(1-\eta)$, the tent $2\min(\eta, 1-\eta)$ — produces both:

- *On the optimization axis,* $\varphi$ plays the role of the surrogate's conditional risk, the BJM $\psi$-transform is its level-set gap above the chord, and the calibration question is about the predictor.
- *On the resolution axis,* $\varphi$ produces a **partition functional** $\bar\varphi(\Pi) = \sum_i p_i\varphi(\eta_i)$, the level-set gap is between $\bar\varphi(\Pi)$ and $\varepsilon^*(\Pi)$, and the question is about the resolution.

The methodology note's claim — and the conceptual move it advertises — is that the same convex-analytic facts that drove a decade of progress on the optimization axis transfer *mutatis mutandis* to the resolution axis, with concrete consequences (§5) that were not visible from the optimization-axis viewpoint alone.

## 2. Recalling the optimization axis

A quick recap, for readers who know the resolution axis better than the optimization one. Fix a probability space $(\mathcal X \times \{0,1\}, \mathbb P)$ and write $\eta(x) = \mathbb P(Y = 1 \mid X = x)$. For a loss $\ell : \{0,1\} \times \mathbb R \to \mathbb R_{\ge 0}$, the **conditional risk** at $x$ is $H_\ell(\eta(x)) = \inf_a\, \eta(x) \ell(1, a) + (1-\eta(x)) \ell(0, a)$, and the **Bayes risk** is $R_\ell^* = \mathbb E\, H_\ell(\eta)$. For the $0$-$1$ loss, $H(\eta) = \min(\eta, 1-\eta)$; for a surrogate margin loss $\varphi$, $H_\varphi$ is some other concave function (Savage 1971, DeGroot 1962, Grünwald–Dawid 2004).

Bartlett, Jordan and McAuliffe identified the convex object that governs how excess surrogate risk transfers to excess $0$-$1$ risk:

$$
\psi(t) \;=\; \tilde\psi^{**}(t),\qquad \tilde\psi(t) \;=\; H^-\!\Bigl(\tfrac{1 + t}{2}\Bigr) - H\Bigl(\tfrac{1+t}{2}\Bigr),
$$

where $H^-(\eta)$ is the conditional surrogate risk under the constraint that the prediction is forced to vote against the Bayes side, and the biconjugate $\tilde\psi^{**}$ convexifies $\tilde\psi$. The inequality

$$
\psi(R - R^*) \;\le\; R_\varphi - R_\varphi^*
$$

is then the BJM theorem. For the $0$-$1$ loss, $\tilde\psi(t) = t$ and $\psi$ is the identity; for a strictly convex smooth surrogate, $\tilde\psi$ is strictly above the chord and $\psi$ is strictly nonlinear at zero.

Reid and Williamson (2011) reorganize the analysis around proper composite losses and weight functions, exposing the convex-analytic structure that links surrogate calibration to $f$-divergence comparison of experiments and to Bregman geometry on the simplex. **The variable being varied throughout is the predictor (equivalently, the loss).** The measurement is held fixed: the predictor sees $X$ in full.

## 3. The transposition

The resolution-axis transposition holds the *loss* fixed (it is the $0$-$1$ loss, the quantity of practical interest) and varies the *measurement* — the partition $\Pi$ at which the classifier is allowed to operate. The resolution-axis analogue of the BJM gap is a two-sided **bracket** on $\varepsilon^*(\Pi)$.

Call $\varphi : [0,1] \to \mathbb R$ a **normalized score** if it is concave, continuous, symmetric ($\varphi(\eta) = \varphi(1-\eta)$), vanishes at $\{0, 1\}$, takes the value $1$ at $\tfrac12$, and is strictly increasing on $[0, \tfrac12]$ (so $\varphi^{-1} : [0, 1] \to [0, \tfrac12]$ exists). Three running examples:

- The **tent** $T(\eta) = 2\min(\eta, 1-\eta)$ — the normalized $0$-$1$ Bayes risk.
- The **rescaled variance** $V(\eta) = 4\eta(1-\eta)$.
- **Shannon entropy** $H(\eta) = -\eta\log_2\eta - (1-\eta)\log_2(1-\eta)$, normalized so $H(\tfrac12) = 1$ (the bit-rate convention).

For any such $\varphi$, the partition functional $\bar\varphi(\Pi) = \sum_i p_i \varphi(\eta_i)$ obeys a two-sided bracket:

$$
\boxed{\;\varphi^{-1}\!\bigl(\bar\varphi(\Pi)\bigr)\;\le\;\varepsilon^*(\Pi)\;\le\; c_\varphi\,\bar\varphi(\Pi),\qquad c_\varphi = \sup_{\eta \in (0, 1/2]} \frac{\eta}{\varphi(\eta)}.\;}
$$

The lower endpoint is Jensen's inequality applied to the concave $\varphi$ (or equivalently to the convex $\varphi^{-1}$, on the partition-averaged score); the upper endpoint is the pointwise bound $\min(\eta, 1-\eta) \le c_\varphi \varphi(\eta)$ on every cell, aggregated. The upper constant has a universal value: concavity above the chord through $(0, 0)$ and $(\tfrac12, 1)$ forces $\varphi(\eta) \ge 2\eta$ on $[0, \tfrac12]$, hence $c_\varphi = \tfrac12$ for every normalized score, attained at $\eta = \tfrac12$. So the bracket is, more concretely,

$$
\varphi^{-1}\!\bigl(\bar\varphi(\Pi)\bigr)\;\le\;\varepsilon^*(\Pi)\;\le\;\tfrac12\,\bar\varphi(\Pi).
$$

The two ingredients on the right — universal constant, score-specific average — make the comparison between different surrogates a comparison of their $\bar\varphi$ values alone. The pointwise domination $V \le H$ (a one-line calculation) lifts to $\bar V \le \bar H$ on every partition, so the variance is the tighter upper instrument among the smooth choices.

**The parallel to the optimization axis is exact.** Both axes carry a two-sided gap between a kinked target functional and a smooth surrogate; both gaps close to zero only for the kinked surrogate itself — on the optimization axis the $\psi$-transform is the identity for the $0$-$1$ loss (BJM 2006), and on the resolution axis the bracket is exact only for the tent (a theorem stated and proved separately as the companion satellite paper). Both gaps have the same convex-analytic origin: the level-set gap of $\varphi$ above the chord through the kinked target's piecewise-linear pieces. The diagram, with the two axes perpendicular through the same point, is the picture this note advertises:

```
                       optimization axis
                       (predictor / loss)
                              ▲
       smooth surrogate ──────┼──────  smooth surrogate
       on a fixed partition   │        at full resolution
                              │
                              │     [classical BJM territory]
                              │
                              │
   ──────────────────────────●●──────────────────────────►  resolution axis
                              │                            (partition Π)
            kinked target     │
            on a fixed
            partition         │     [transposition territory]
                              │
                              │
                              ▼
                              ε*(Π)
```

The vertical $\psi$-transform gap and the horizontal $c_\varphi$ bracket gap are reflections of one another. The methodology this note advertises is to **read off**, from any new question about *how much information a coarsening throws away*, the resolution-axis analogue of whatever the optimization-axis literature has established about *how much accuracy a smooth surrogate throws away*.

## 4. A worked example

The smallest example that exhibits the bracket and the perpendicular-axes picture is two cells of equal mass. Take $p_1 = p_2 = \tfrac12$ and label rates $\eta_1 = 0.3$, $\eta_2 = 0.5$. Then the partition Bayes risk is

$$
\varepsilon^*(\Pi) \;=\; \tfrac12\min(0.3, 0.7) + \tfrac12\min(0.5, 0.5) \;=\; 0.40.
$$

We instantiate the bracket on the three running scores; entropy is reported in bits throughout.

| Score $\varphi$ | $\varphi(0.3)$ | $\varphi(0.5)$ | $\bar\varphi(\Pi)$ | lower $\varphi^{-1}(\bar\varphi)$ | $\varepsilon^*(\Pi)$ | upper $\bar\varphi/2$ |
|---|---|---|---|---|---|---|
| Tent $T$ | $0.600$ | $1.000$ | $0.800$ | $\mathbf{0.400}$ | $0.400$ | $\mathbf{0.400}$ |
| Variance $V$ | $0.840$ | $1.000$ | $0.920$ | $0.359$ | $0.400$ | $0.460$ |
| Entropy $H$ (bits) | $0.881$ | $1.000$ | $0.941$ | $0.358$ | $0.400$ | $0.470$ |

*(Entropy values in bits, log base 2; the normalization $H(\tfrac12) = 1$ is the bit-rate convention. Lower endpoints computed by inverting $V$ and $H$ on $[0, \tfrac12]$: $V^{-1}(0.92) = (1 - \sqrt{0.08})/2 \approx 0.359$; $H^{-1}(0.941) \approx 0.358$.)*

Three things to read off the table.

- *The tent is exact.* The lower endpoint, the upper endpoint, and $\varepsilon^*$ all coincide at $0.400$. This is the resolution-axis counterpart of "the $\psi$-transform is the identity for the $0$-$1$ loss."
- *The smooth scores carry slack.* Variance places $\varepsilon^*$ in the interval $[0.359, 0.460]$ — a width of about a tenth. Entropy is wider still, $[0.358, 0.470]$. The width is the *bracket slack*. On the optimization axis, the analogue is the BJM $\psi$-transform being above the diagonal — a strictly convex function instead of the identity.
- *Variance is tighter than entropy as an upper instrument*, in agreement with the pointwise domination $V \le H$ that lifts to $\bar V \le \bar H$. This too has an optimization-axis cousin: among smooth surrogates, the one whose conditional risk is pointwise smallest gives the tighter excess-risk bound through the $\psi$-transform.

The reader can vary $\eta_1, \eta_2, p_1$ and watch the bracket open and close. Two limiting cases are instructive. If $\eta_1 = 0$ and $\eta_2 = 1$ — the cells are *pure* and the partition fully resolves the label — every score gives $\bar\varphi = 0$, both endpoints collapse to zero, and $\varepsilon^* = 0$. If $\eta_1 = \eta_2 = \tfrac12$ — the cells are *uninformative* and the partition is no better than guessing — every score gives $\bar\varphi = 1$, the lower endpoint is $\varphi^{-1}(1) = \tfrac12$, the upper is $\tfrac12$, and $\varepsilon^* = \tfrac12$ exactly. Both limits collapse to the tent's exactness — bracket slack lives in the interior.

## 5. What the transposition unlocks (forward pointers)

This methodology note stops here. The convex-analytic machinery established in §§3–4 is enough to recognize the transposition; the *uses* of the transposition belong to separate developments, each pointed at explicitly below so the interested reader knows where to look. None of the items in this section is claimed or proved here.

### Three immediate consequences in recent work

- *Reading depth as a refinement order.* When a measurement device is parameterized by a depth $L$ — successive iterations of a coarsening operation, layers of a feed-forward network, rounds of a color-refinement procedure — the resulting partition sequence $\Pi^{(L)}$ either refines monotonically (in which case the bracket lower endpoint monotonically falls, by Jensen) or fails to refine (in which case some choice of label exhibits a *floor rise* at some depth). The transposition is what makes this dichotomy quantitative; the recent over-smoothing literature on graph neural networks is its qualitative shadow. See [Author, main paper].
- *Reading aggregator design.* Combinatorial operations that combine multiple inputs — sum, mean, max, top-$k$ — refine each other (or fail to) on the multiset refinement lattice. Sum refines both mean and max; mean and max are incomparable. The bracket reads this off as a half-chain of floors: $\varepsilon^*(\Pi_{\mathrm{sum}}) \le \min(\varepsilon^*(\Pi_{\mathrm{mean}}), \varepsilon^*(\Pi_{\mathrm{max}}))$, with no general comparison between $\Pi_{\mathrm{mean}}$ and $\Pi_{\mathrm{max}}$. See [Author, *Learning on Graphs* 2026, workshop track].
- *Local testability of the bracket.* The bracket admits an estimator using only $O(\alpha^{-2})$ uniform two-element same-cell label queries, with sample complexity independent of the underlying input space's cardinality. The mechanism — a single-line variance identity that exposes the bracket — is the subject of the companion satellite, [Author, *Information Processing Letters* 2026].

### Methodological cousins waiting to be transposed

The convex-analytic catalog the optimization axis has assembled is rich, and only fragments have been moved across the transposition so far. The most natural candidates a working mathematician will recognize.

- *Le Cam's deficiency.* The optimization-axis analogue is the gap between two experiments' Bayes-risk profiles; the resolution-axis analogue is the cost of coarsening one partition into another, and admits the same bracket structure. See [Author, *Bernoulli*].
- *$f$-divergence dualities.* The Reid–Williamson bijection between proper losses and $f$-divergences has a resolution-axis sibling, in which $f$-divergence between cell-conditionals and the marginal aggregates to a refinement-monotone *partition $f$-divergence*. See [Author, *Information Geometry*].
- *Bregman geometry on the simplex.* The multiclass analogue of the transposition, for cells whose conditional class distributions live on $\Delta^{k-1}$, calibrates Bregman divergences against the multiclass Bayes risk $1 - \max_c \eta_c$. See [Author, *Information Geometry*].

The point of singling these out is that *the same mathematician* who already knows the optimization-axis treatment of any of them is the *natural author* of the resolution-axis sibling. The transposition is a productivity tool: it tells you, on inspection of an existing optimization-axis result, what theorem the resolution-axis literature is missing.

## 6. Closing observations

The methodology note has done four things. It has named the *resolution-axis transposition*. It has drawn the perpendicular-axes picture and shown that the convex-analytic gaps on the two axes are reflections of one another. It has written down the bracket and shown one numerical example in full. And it has pointed at three recent applications (graph-neural-network depth, aggregator-design hierarchies, locally-testable partition statistics) and three classical cousins (Le Cam deficiency, $f$-divergence dualities, Bregman geometry on the simplex) where the transposition either already has been or naturally invites itself to be carried out.

Two parting observations. First, *neither axis is mathematically more fundamental than the other*; what is special about the optimization axis is only that two decades of effort have been spent there. The resolution axis admits the same theorems with the same arguments, but the questions one asks at the start — *which loss can I optimize?* vs *which resolution can I represent?* — pick different answers as headline. The dictionary between the two is what this note proposes as a working tool.

Second, the historical reason the transposition has not been written down before is structural rather than mathematical: classical decision theory (Savage, DeGroot, Wald) parameterized everything by the *decision rule* — the predictor — and treated the experiment / measurement as a fixed input. Modern applications have changed which slot is held fixed: the lens through which $X$ is observed is now a designed object (a neural network architecture, a privacy mechanism, a communication channel), and its design choices are exactly what the resolution axis quantifies. The mathematics — concave generalized entropies, Jensen's inequality, the convexification of level-set gaps — was assembled half a century ago, and the calibration literature has spent two decades refining it on the predictor axis. What is new is the question one asks against it: not which loss to optimize, but at which resolution to measure.

---

## Acknowledgements

The author thanks [two referees and the action editor — names filled at acceptance]. The drafting and adversarial-audit cycles that produced this note follow the workflow described in the author's `agents/skills/` package and the companion methodology paper [Author, CICM 2026]; the audit trail, reviewer findings, and atomic dispositions are maintained as a transparent record (see the project repository for the full sequence).

---

## References

P. L. Bartlett, M. I. Jordan, J. D. McAuliffe. *Convexity, classification, and risk bounds.* Journal of the American Statistical Association **101** (2006), 138–156. DOI: [10.1198/016214505000000907](https://doi.org/10.1198/016214505000000907).

D. Blackwell. *Equivalent comparisons of experiments.* Annals of Mathematical Statistics **24** (1953), 265–272.

M. H. DeGroot. *Uncertainty, information, and sequential experiments.* Annals of Mathematical Statistics **33** (1962), 404–419.

P. D. Grünwald, A. P. Dawid. *Game theory, maximum entropy, minimum discrepancy, and robust Bayesian decision theory.* Annals of Statistics **32** (2004), 1367–1433.

L. Le Cam. *Asymptotic methods in statistical decision theory.* Springer, New York, 1986.

L. Le Cam, G. L. Yang. *Asymptotics in statistics: some basic concepts*, 2nd edition. Springer, New York, 2000.

M. D. Reid, R. C. Williamson. *Information, divergence and risk for binary experiments.* Journal of Machine Learning Research **12** (2011), 731–817.

L. J. Savage. *Elicitation of personal probabilities and expectations.* Journal of the American Statistical Association **66** (1971), 783–801.

E. Torgersen. *Comparison of statistical experiments.* Cambridge University Press, Cambridge, 1991.

T. Zhang. *Statistical behavior and consistency of classification methods based on convex risk minimization.* Annals of Statistics **32** (2004), 56–85.

[Author]. *A bracket for the partition-restricted Bayes risk.* arXiv:YYMM.NNNNN, 2026. Companion satellite (in submission to *Statistics & Probability Letters*).

[Author]. *The achievable-error floor of graph neural networks: calibration at the resolution level.* arXiv:YYMM.NNNNN, 2026. Main paper (in preparation); see also the companion satellites in *Information Processing Letters* and the *Learning on Graphs* 2026 workshop track.

---

*Manuscript word count: ~2,650 (body, excluding bibliography, acknowledgements, table caption). Estimated print-page count at EMS Magazine layout: 6–7 pp. Within budget per [`02-adversarial_audit.md`](02-adversarial_audit.md) §1 (no [C] findings) and the [`pre-flight`](00-preflight.md) commitment.*
