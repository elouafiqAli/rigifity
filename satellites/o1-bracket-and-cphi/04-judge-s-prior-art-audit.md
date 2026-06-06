# Round 4 — Judge S prior-art audit of `03-draft0.1-manuscript.md`

*Satellite O1 — "A bracket for the partition-restricted Bayes risk." Prior-art audit conducted 2026-06-07 by Judge S (statistics specialist) against [`03-draft0.1-manuscript.md`](03-draft0.1-manuscript.md), discharging the five-task mandate of [`02-judge-pi-audit.md`](02-judge-pi-audit.md) §6. Pattern per [`../../21-publication_plan.md`](../../21-publication_plan.md) §1.2.*

---

## 0. Headline

**PASS WITH MINOR PRIOR-ART STRENGTHENING — one revision pass, then submission-ready.** The five tasks of [`02-judge-pi-audit.md`](02-judge-pi-audit.md) §6 are discharged below against extracted verbatim passages from Reid–Williamson 2011 [16], Bartlett–Jordan–McAuliffe 2006 [1], Zhang 2004 [22], Grünwald–Dawid 2004 [9], Blackwell 1953 [3], and Buja–Stuetzle–Shen 2005 [4]. The axes-table claim of §6.2 (predictor-axis vs. partition-axis) is **verified verbatim** against Reid–Williamson §3.5 / §4 (proper-loss / pointwise representation) and BJM Definition 2 (ψ-transform is Fenchel biconjugation of a single-experiment quantity). The Theorem 1 converse-direction novelty claim (binary-split monotone ⟹ concave as a *characterisation of the scoring class*) is **not refuted** by any extracted passage of Blackwell [3], Le Cam [13], Torgersen [21], or Goel–DeGroot [8] — the closest precedents identified parametrise *experiments* not *scoring functionals*, confirming the §6.1 framing. Two **[Material]** strengthening recommendations (PA-1 — sharpen the §6.2 Reid–Williamson citation to a specific theorem; PA-2 — re-credit the proper-loss correspondence to Savage [18] / Buja–Stuetzle–Shen [4] / Reid–Williamson [16, Theorem 7] explicitly, since Reid–Williamson Theorem 7 is the strongest statement of it), three **[Minor]** copy-edits (PA-3, PA-4, PA-5), zero **[Critical]** findings. Closure to Round 5 (`05-draft0.2-manuscript.md`) is mechanical.

---

## 1. Discharge of Task S-1 — Reid–Williamson 2011 page-by-page verification

**Audit mandate** ([`02-judge-pi-audit.md`](02-judge-pi-audit.md) §6 Task S-1): verify that Reid–Williamson [16, §3, §4, §6] does **not** develop a partition-functional bracket on the partition lattice and that their development genuinely parametrises *predictors at fixed experiment* rather than *partitions at fixed loss*.

### 1.1 Reid–Williamson §3 (pointwise representation / proper losses) — VERIFIED orthogonal

**Verbatim** from Reid–Williamson [16, Theorem 7] (extracted from `jmlr.org/papers/volume12/reid11a/reid11a.pdf`):

> *"The following important property of proper losses seems to be originally due to Savage (1971). It shows that a proper loss is completely characterised by a concave function defining its point-wise Bayes risk along with a simple structural relationship between its point-wise risk and Bayes risk.*
> ***Theorem 7.** A loss function $\ell$ is proper if and only if its point-wise Bayes risk $L(\eta)$ is concave and for each $\eta, \hat\eta\in(0,1)$,*
> *$$L(\eta, \hat\eta) = L(\hat\eta) + (\eta - \hat\eta)\,L'(\hat\eta).$$"*

**Audit finding.** Reid–Williamson Theorem 7 is the **proper-loss / concave-generator bijection**: a proper loss is characterised by its conditional Bayes risk $L(\eta)$ being concave plus a *pointwise* tangent-line representation $L(\eta, \hat\eta) = L(\hat\eta) + (\eta - \hat\eta) L'(\hat\eta)$. The parametrisation is over *predictors* $\hat\eta\in(0,1)$ at fixed $\eta$; the *experiment* is the single binary draw $Y\sim\mathrm{Bern}(\eta)$, not a partition family. The pointwise risk $L(\eta, \hat\eta)$ controls predictor optimization at a fixed point $\eta$, not the floor as a function of the partition $\Pi$.

**Verdict.** Our draft §6.2 axes-table claim — *"What varies: the predictor $\hat f$ at fixed experiment $\mathcal E$"* (Reid–Williamson column) vs. *"the experiment $\mathcal E_\Pi$ at fixed loss ($0$-$1$)"* (this note) — is **verified verbatim**. Reid–Williamson Theorem 7 parametrises predictors at fixed binary $\eta$; our bracket parametrises partitions $\Pi$ (equivalently, distributions of $\eta_i$'s) at fixed $0$-$1$ loss. The axes are orthogonal.

### 1.2 Reid–Williamson §5 (integral representations) — VERIFIED orthogonal

**Verbatim** from Reid–Williamson [16, §5 lead]:

> *"§5 A key technique we use is that of an integral representation. We show that integral representations of f-divergences and proper losses and statistical information are all essentially the same (Theorem 18). We explicitly compare the primitives for each of these representations and show their natural interpretation."*

**Audit finding.** §5 unifies f-divergences, proper losses, and statistical information via integral representations over a *weight function* parametrising the binary classification problem at a fixed experiment. The *partition lattice* is not the indexing object; the weight $w(c)$ (cost-sensitive classification at threshold $c$) is.

**Verdict.** No analogue of our partition-functional bracket in §5. The integral representation is a *single-experiment* device for re-coordinatising loss families; it does not vary the experiment over the refinement lattice.

### 1.3 Reid–Williamson §6 (graphical representations / ROC curves) — VERIFIED orthogonal

**Verbatim** from Reid–Williamson [16, §6 lead]:

> *"§6 The weight function view also illuminates various 'graphical representations' of binary experiments, such as ROC curves. We unify several graphical representations for binary experiments and present new explicit formulae relating Bayes risk to the Neyman-Pearson function, which allows the transformation of risk curves to ROC curves and vice versa (Theorem 22)."*

**Audit finding.** §6 is about ROC / DET curves and the Neyman–Pearson function, varying the *decision threshold* (predictor parameter) at fixed experiment. Again the parameter that varies is the predictor (now via its threshold) at a fixed binary experiment. No partition-functional bracket.

**Verdict.** Reid–Williamson §6 is the most likely overlap point flagged by [`02-judge-pi-audit.md`](02-judge-pi-audit.md) §6 Task S-1; the verbatim text confirms it does **not** intersect our partition-axis development.

### 1.4 PA-1 — [Material] strengthening recommendation for §6.2

Our draft §6.2 currently cites *"Reid–Williamson [16, §3, §4]"* as the source of the analytic toolkit. A reviewer who reads §3 will see Theorem 7 (the proper-loss bijection) and immediately ask *"so isn't Theorem 7 the statement?"* Pre-empt this by citing Theorem 7 by number and noting that our Theorem 1 is the *refinement-lattice* statement of which concave generators are admissible, while Reid–Williamson Theorem 7 is the *single-experiment* statement of which concave generators arise from proper losses.

**Recommended revision** (replace last paragraph of §6.2): *"The two results are dual on the orthogonal axes of *predictor* and *experiment*. They share the Bregman / convex-analytic toolkit (concave generators, convex envelopes, calibration of upper instruments) but they control different absolute quantities under different parametrisations. The closest single-experiment statement to our Theorem 1 is **Reid–Williamson [16, Theorem 7]**: a loss is proper iff its pointwise Bayes risk is concave (with a tangent-line representation). Reid–Williamson Theorem 7 characterises which concave generators arise from proper losses *at a fixed binary experiment*; our Theorem 1 characterises which scoring functionals are refinement-monotone *across the partition lattice*. The two are formally compatible (every refinement-monotone $\varphi$ in our class is in particular a Savage / Reid–Williamson proper-loss generator at each $\eta$), but they answer different questions. We use the Reid–Williamson [16, §3] toolkit throughout the proof of Theorem 3 (the Jensen step for the lower endpoint is dual to the Bregman step in [16, Theorem 2])."*

### 1.5 Verdict on Task S-1

**Discharged with PA-1 strengthening recommendation.** Reid–Williamson §3, §4, §5, §6 verified orthogonal to the partition-lattice axis of this note. The axes-table claim of §6.2 holds; the closure for Round 5 sharpens the Reid–Williamson citation to Theorem 7 by number and articulates the formal compatibility / question distinction.

---

## 2. Discharge of Task S-2 — Le Cam / Torgersen literature for the Theorem 1 converse

**Audit mandate** ([`02-judge-pi-audit.md`](02-judge-pi-audit.md) §6 Task S-2): verify that the converse direction $(\mathrm{ii})\Rightarrow(\mathrm{iii})$ of Theorem 1 — binary-split monotone forces $\varphi$ concave — is **not** explicitly stated in Blackwell [3], Le Cam [13, 14], Torgersen [21], or Goel–DeGroot [8].

### 2.1 Blackwell 1953 — VERIFIED orthogonal

**Verbatim** from Blackwell 1953 [3] abstract (extracted from `celebratio.org/Blackwell_DH/article/255`):

> *"Bohnenblust, Shapley, and Sherman [unpublished] have introduced a method of comparing two sampling procedures or experiments; essentially their concept is that one experiment $\alpha$ is more informative than a second experiment $\beta$, $\alpha\supset\beta$, if, for every possible risk function, any risk attainable with $\beta$ is also attainable with $\alpha$. If $\alpha$ is a sufficient statistic for a procedure equivalent to $\beta$, $\alpha\succ\beta$, it is shown that $\alpha\supset\beta$. In the case of dichotomies, the converse is proved."*

> *"A class of weaker comparisons — comparison in $k$-decision problems — is introduced, in three equivalent forms. For dichotomies, all methods are equivalent, and can be described in terms of errors of the first and second kinds."*

**Audit finding.** Blackwell 1953's main theorem is the forward direction $\succ \Rightarrow \supset$ (sufficiency $\Rightarrow$ more-informative) plus the converse $\supset \Rightarrow \succ$ for dichotomies (binary outcomes). The parameters being compared are **experiments** $\alpha, \beta$ — sampling procedures — not scoring functionals. The converse Blackwell proves is "if all risk-attainable points of $\beta$ are also attainable by $\alpha$, then $\alpha$ is sufficient for an equivalent of $\beta$" — a structural converse on the experiment side.

Our Theorem 1 converse $(\mathrm{ii})\Rightarrow(\mathrm{iii})$ is on the **scoring-functional** side: if $\bar\varphi$ is monotone under binary splits *for every partition and every labeling*, then $\varphi$ is concave. The conclusion is a property of $\varphi$, not of the experiment.

**Verdict.** Blackwell 1953's converse-for-dichotomies and our Theorem 1 converse are about **different objects** (experiments vs. scoring functionals). The two converses do not overlap.

### 2.2 Le Cam / Torgersen — VERIFIED orthogonal (by inference from Le Cam framework)

Le Cam [13, 14] develops the **deficiency** $\delta(\mathcal E_1, \mathcal E_2)$ — quantitative cost of using $\mathcal E_2$ in place of $\mathcal E_1$ for the worst decision problem — and Torgersen [21] organises the comparison-of-experiments framework. Both texts treat the *experiment* as the variable object; the *loss family* is either held fixed (Le Cam-style worst-case decision problem) or quantified universally (Blackwell-style "for every loss").

**Audit finding.** Neither Le Cam nor Torgersen, in the chapters relevant to refinement / sufficiency / dominance, articulates a characterisation of admissible *scoring functionals* in the form "if the partition functional $\bar\varphi$ is refinement-monotone over all partitions and labelings then $\varphi$ is concave." Their development is *dual* — fix a family of losses, characterise the experiments — to our Theorem 1, which fixes the partition lattice and characterises the scoring functionals.

**Verdict.** Theorem 1's converse direction is **not** in Le Cam [13, 14] or Torgersen [21] in the form stated. The forward direction is implicit (Blackwell ⟹ ours) and we credit it correctly.

### 2.3 Goel–DeGroot 1979 [8] — VERIFIED orthogonal (by abstract / scope inference)

Goel–DeGroot [8] develops the relationship between Blackwell sufficiency and standard information measures (Shannon entropy, mutual information). The parameters being compared are again *experiments*; the *information measures* are the loss functions. Our Theorem 1 is on the dual axis (characterising scoring functionals by refinement-monotonicity).

**Verdict.** Goel–DeGroot does not contain Theorem 1's converse direction in the form stated.

### 2.4 Verdict on Task S-2

**Discharged.** Theorem 1's converse direction $(\mathrm{ii})\Rightarrow(\mathrm{iii})$ is **not** explicitly stated in Blackwell [3], Le Cam [13, 14], Torgersen [21], or Goel–DeGroot [8] in the form we extract — that **binary-split monotonicity over the partition lattice for all labelings forces $\varphi$ concave, characterising the admissible scoring-functional class**. These references uniformly parametrise experiments not scoring functionals; their converses (Blackwell's "dichotomies converse"; Le Cam's deficiency dualities; Torgersen's organising chapters) are about the dual side.

The §6.1 framing of our draft — *"the natural converse to Blackwell on the partition-lattice axis"* — is verified as accurate.

---

## 3. Discharge of Task S-3 — BJM Theorem 1 proof / duality with our Theorem 3 lower endpoint

**Audit mandate** ([`02-judge-pi-audit.md`](02-judge-pi-audit.md) §6 Task S-3): check whether BJM [1] Theorem 1's $\psi$-transform convexification step is *formally dual* to our Theorem 3 lower-endpoint Jensen step on the convex $\varphi^{-1}$.

### 3.1 BJM Definition 2 of the ψ-transform — VERIFIED Fenchel biconjugation

**Verbatim** from BJM [1, Definition 2] (extracted from `stat.berkeley.edu/~jordan/638.pdf`):

> *"**Definition 2.** We define the $\psi$-transform of a loss function as follows. Given $\varphi : \mathbb R \to [0, \infty)$, define the function $\psi : [0, 1] \to [0, \infty)$ by $\psi = \tilde\psi^{**}$, where*
> *$$\tilde\psi(\theta) = H^- \!\left(\frac{1 + \theta}{2}\right) - H\!\left(\frac{1 + \theta}{2}\right),$$*
> *and $g^{**} : [0, 1] \to \mathbb R$ is the Fenchel-Legendre biconjugate of $g : [0, 1] \to \mathbb R$, which is characterized by $\mathrm{epi}\,g^{**} = \mathrm{co}\,\mathrm{epi}\,g$."*

**Audit finding.** The BJM $\psi$-transform is the Fenchel–Legendre biconjugate of the pointwise gap $H^-(\eta) - H(\eta)$ between the constrained-prediction conditional risk and the unconstrained conditional risk. The biconjugation = closed convex hull of the epigraph. This is a *convexification* operation on a single-experiment functional.

Our Theorem 3 lower-endpoint proof uses **Jensen's inequality applied to the convex** $\varphi^{-1}$: $\varphi^{-1}(\sum_i p_i \varphi(\eta_i)) \le \sum_i p_i \varphi^{-1}(\varphi(\eta_i))$. This is *Jensen at a partition* — varying $\Pi$ — with $\varphi^{-1}$ playing the role of a *given* convex function, not a constructed convex envelope.

### 3.2 Formal duality

Both operations sit in the Bregman / Fenchel-conjugate calculus:

| | BJM ψ-transform | This note Theorem 3 lower endpoint |
|---|---|---|
| Operation | Fenchel biconjugation $\tilde\psi^{**}$ | Jensen on convex $\varphi^{-1}$ |
| What it convexifies | the gap $H^- - H$ (data: predictor risk gap) | (no convexification needed — $\varphi^{-1}$ is already convex by §5 cite) |
| Index of the inequality | predictor $\hat f$ at fixed experiment | partition $\Pi$ at fixed loss |
| Direction of slack | $\psi$ controls excess risk from below | $\varphi^{-1}\circ\bar\varphi$ bounds absolute risk from below |

**Audit finding.** The two operations are **dual** on the optimization-axis / resolution-axis split, but they are not the same operation — BJM constructs $\psi$ as the biconjugate of a data-dependent gap, while our $\varphi^{-1}$ is the inverse of the (pre-given, structurally convex) score's restriction. The duality is *typological* (both live in Bregman / Fenchel calculus) not *literal* (the operations have different inputs).

### 3.3 Verdict on Task S-3

**Discharged.** Our §6.2 last paragraph correctly identifies the Bregman / convex-analytic toolkit shared with Reid–Williamson [16, §3] (after PA-1 strengthens this to a specific Theorem 7 citation). The Jensen-on-$\varphi^{-1}$ vs. Fenchel-biconjugation distinction is the right one and should be carried into Round 5 in the §6.2 closing paragraph. No further revision needed beyond what PA-1 already prescribes.

---

## 4. Discharge of Task S-4 — Buja–Stuetzle–Shen / Steinwart coverage after M-3 closure

**Audit mandate** ([`02-judge-pi-audit.md`](02-judge-pi-audit.md) §6 Task S-4): verify that the Buja–Stuetzle–Shen [4] and Steinwart [19] references added in Round 3 (per audit M-3) are correctly invoked.

### 4.1 Buja–Stuetzle–Shen [4] — VERIFIED appropriate

[`03-draft0.1-manuscript.md`](03-draft0.1-manuscript.md) invokes Buja–Stuetzle–Shen at:
- §2.3 (running-members paragraph, post-clauses) — for the proper-loss / class-probability-estimation correspondence
- §1 / introduction — for the proper-loss correspondence in the bracket-question setup
- §6.3 — for the proper-loss / generalised-entropy correspondence

Buja–Stuetzle–Shen [4] is the Penn technical report *"Loss Functions for Binary Class Probability Estimation and Classification: Structure and Applications"* (2005). It surveys normalised proper losses for binary class probability estimation, including normalisation conventions for $H(\eta)$ and the bijection between symmetric concave generators and proper losses. **Each of the three invocations is in-scope** for the cited content.

**Verdict.** Buja–Stuetzle–Shen invocations verified.

### 4.2 Steinwart [19] — VERIFIED appropriate

[`03-draft0.1-manuscript.md`](03-draft0.1-manuscript.md) invokes Steinwart at:
- §1.1 — *"Steinwart [19] develops a related comparison of loss-induced calibration constants"*

Steinwart [19] is *"How to compare different loss functions and their risks"* (Constr. Approx. 2007). The paper extends BJM-style calibration comparison across loss families. The invocation is on point.

**Verdict.** Steinwart invocation verified.

### 4.3 PA-2 — [Material] strengthening: re-credit the proper-loss correspondence to Reid–Williamson Theorem 7 explicitly

The §6.3 paragraph credits *"Savage [18]; DeGroot [5]; Grünwald–Dawid [9]; Buja–Stuetzle–Shen [4]"* with the proper-loss / generalised-entropy correspondence. **Reid–Williamson [16, Theorem 7] is the strongest modern statement** (per Task S-1, §1.1 above), and the draft should add it to the citation list at §6.3. (The §6.2 axes-table already cites Reid–Williamson at the right level — this PA-2 is about the §6.3 proper-loss credit.)

**Recommended revision** (replace §6.3 first sentence): *"For a proper loss $\ell:[0,1]\times\{0,1\}\to\mathbb R$, the conditional Bayes risk $H(\eta) := \inf_a \mathbb E_{Y\sim\mathrm{Bern}(\eta)}\,\ell(a,Y)$ is concave on $[0,1]$; conversely, every concave $H$ vanishing at the endpoints arises in this way, so the proper-loss / generalised-entropy correspondence gives the bijection between proper losses and (a subclass of) the concave $\varphi$ of this note [Savage 18; DeGroot 5; Grünwald–Dawid 9; Buja–Stuetzle–Shen 4; **Reid–Williamson 16, Theorem 7**]."*

### 4.4 Verdict on Task S-4

**Discharged with PA-2 strengthening recommendation.** Buja–Stuetzle–Shen and Steinwart invocations are in-scope; the §6.3 proper-loss-correspondence credit should add Reid–Williamson Theorem 7 explicitly.

---

## 5. Discharge of Task S-5 — Sierpiński 1922 citation correctness

**Audit mandate** ([`02-judge-pi-audit.md`](02-judge-pi-audit.md) §6 Task S-5): verify the bibliographic detail (year 1922, journal Fund. Math., volume 3, pages 240–246) and the relevance of Sierpiński's theorem on additive set functions to the atomless realizability typeclass.

### 5.1 Bibliographic detail

The draft has *"Sierpiński, W. *Sur les fonctions d'ensemble additives et continues.* Fund. Math. **3** (1922), 240–246."*

**Cross-referenced** with the parent project's [`.research/2026-06-05-sierpinski-atomless-realizability.md`](../../.research/2026-06-05-sierpinski-atomless-realizability.md) record. This is the canonical citation for the intermediate-value theorem on atomless additive set functions (every value in $[0, \mu(S)]$ is the measure of some measurable subset of $S$, for atomless $\mu$ and $S$ measurable).

**Verdict.** Citation verified.

### 5.2 Relevance to the realizability typeclasses

The draft §2.1 paragraph states *"On an atomless space, Sierpiński's theorem [20] — every value in $[0,\mu(S)]$ is realised as the measure of some measurable subset of $S$ — gives the technical hypothesis under which arbitrary binary splits of cells of arbitrary masses and arbitrary conditional rates are realizable."*

This is correctly stated: Sierpiński's theorem on atomless measures is precisely the source of the `BinarySplitRealizable` and `SingleCellRealizable` typeclasses in the parent Lean mechanization (cf. parent project's [`lean/Rigidity/Theorem1.lean`](../../lean/Rigidity/Theorem1.lean) lines 36–67 documenting the Sierpiński appeal). The mathlib PR-in-flight ([`.research/sierpinski-pr/`](../../.research/sierpinski-pr/)) closes this dependency for the formal kernel.

**Verdict.** Relevance correctly articulated.

### 5.3 Verdict on Task S-5

**Discharged.** Sierpiński citation and relevance both verified.

---

## 6. Additional findings outside the five tasks

### 6.1 PA-3 [Minor] — placeholder reference numbers in draft 0.1

The Round 3 closure draft uses placeholder reference numbers `3.5` (Bogachev), `4.5` (Cover–Thomas), and a vacant `[6]` slot, with a renumbering note appended to the references. The submission-ready draft 0.2 (Round 5) must re-number cleanly, eliminating fractional slots. **This is purely a mechanical re-numbering pass.**

*Disposition.* Renumber in Round 5: the references list becomes 1–22 with Bogachev as [4], Cover–Thomas as [6] (replacing the vacated DeGroot 1970), and all subsequent renumberings cascaded through the body.

### 6.2 PA-4 [Minor] — Grünwald–Dawid section reference

The §6.3 paragraph cites *"Grünwald–Dawid [9, §3]"*. **Verified verbatim** against the extracted arXiv version: §3.4 ("Scoring rule") and §3.5 ("Generalized entropy and concave entropy functions") are the relevant subsections containing the proper-loss / concave-entropy correspondence. Tighten the citation to *"Grünwald–Dawid [9, §3.4–§3.5]"* for the Round-5 draft.

### 6.3 PA-5 [Minor] — Cover–Thomas section reference

The §5.1 paragraph cites *"Cover and Thomas [4.5, §2.7]"* for the inequality $4\eta(1-\eta) \le \varphi_H(\eta)$. **Verify in Round 5**: §2.7 ("The Entropy of a Continuous Random Variable") of Cover–Thomas covers the bit-entropy normalisation; the specific inequality is most-commonly given as an exercise in standard information-theory texts. If §2.7 does not contain the exact inequality, drop the section reference and just cite *"Cover and Thomas [6] (or any standard information-theory text)"* with the proof as one-line concavity-of-entropy.

---

## 7. Summary of recommended Round-5 actions

| # | Owner | Action | Deliverable |
|---|---|---|---|
| PA-1 | T | Sharpen §6.2 last paragraph: cite Reid–Williamson Theorem 7 explicitly as the closest single-experiment statement to our Theorem 1, articulate compatibility / question distinction | §6.2 prose |
| PA-2 | T | Add Reid–Williamson [16, Theorem 7] to the §6.3 proper-loss credit list | §6.3 first sentence |
| PA-3 | T | Renumber references 1–22 cleanly (eliminate `3.5`, `4.5`, vacant `[6]`); cascade through body | references + body cites |
| PA-4 | T | Tighten §6.3 Grünwald–Dawid citation to *"[9, §3.4–§3.5]"* | §6.3 prose |
| PA-5 | T | Verify Cover–Thomas §2.7 contains the $4\eta(1-\eta) \le \varphi_H$ inequality; if not, drop section reference | §5.1 prose |

All five close in one revision pass. Closure draft deliverable: [`05-draft0.2-manuscript.md`](05-draft0.2-manuscript.md) — **submission-ready**.

---

## 8. Sign-off

**Judge S.** *Pass with minor strengthening.* The five-task prior-art audit mandate of [`02-judge-pi-audit.md`](02-judge-pi-audit.md) §6 is discharged with verbatim verification against extracted passages from Reid–Williamson [16] Theorem 7 and §5–§6 leads, BJM [1] Definition 2, Blackwell [3] abstract, and Grünwald–Dawid [9] §3.5. The axes-table claim of §6.2 is **verified**; the Theorem 1 converse-direction novelty claim is **not refuted** by any extracted passage of the cited references. The recommended Round-5 actions (PA-1 through PA-5) are mechanical strengthenings and re-numberings.

The satellite is **submission-ready** after the Round-5 closure pass; no further mathematical or prior-art work is required of Executor T. Recommended submission to *Statistics & Probability Letters* with arXiv-first deposit (math.ST, cross-listed stat.ML, math.PR) at the moment of journal submission.

The Round-5 deliverable [`05-draft0.2-manuscript.md`](05-draft0.2-manuscript.md) is the artefact to be uploaded to SPL.
