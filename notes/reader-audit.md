# Adversarial Audit & Constructive Review — the Reader Suite

> **Object.** The from-scratch reader suite for *The Continuous-Coefficient Jensen Equation: How Real Mixing Weights Retire Regularity*:
> [`notes/reader.md`](reader.md) (Sections 1–4, one-dimensional theory), [`notes/reader-higher-dim.md`](reader-higher-dim.md) (Theorem 6), [`notes/reader-section4.md`](reader-section4.md) (all of Section 4), with the application notes [`notes/utility.md`](utility.md) and [`notes/shannon.md`](shannon.md) in the background.
> **Object, Part II (added).** The Section 5 reader [`notes/reader-section5.md`](reader-section5.md) (all of Section 5, the *field guide to saturated Jensen*, housing **Proposition 8**), audited in **Part II** below. It targets a *different* audience and is held to a *different* bar (see §II.0).
> **Charge.** Audit adversarially for errors, gaps, inconsistencies, prerequisite violations, and pedagogical weak points; then deliver a constructive review with a verdict on exam-readiness.
> **Audience the Sections 1–4 suite targets.** A returning A-student: Analysis I + Algebra I, vaguely recalled, a decade out. The audit holds the suite to *that* bar — every step reproducible from those two courses. (The Section 5 reader's audience differs — see §II.0.)

---

## 0. Method

1. **Numbering ground truth.** Read the manuscript source `satellites/o3-maa/add/manuscript-anon-final.tex`: the theorem environments (`theorem`, and `proposition`/`lemma`/`corollary`/`definition`/`remark` declared `[theorem]`) share **one** counter. Listing every counter-advancing `\begin{…}` in order fixes the canonical numbering.
2. **Cross-reference sweep.** Grepped all three readers for every `Theorem n` / `Corollary n` / `Proposition n` / `Remark n` token and reconciled against ground truth.
3. **Solution spot-checks.** Re-derived a representative sample of solutions independently (the riskiest ones), and cross-checked claims shared between readers.
4. **Prerequisite discipline.** Verified each reader self-discloses exactly where (if anywhere) it leaves Analysis I + Algebra I.
5. **Attribution check.** Verified historical attributions in the drills against the manuscript.

**Canonical numbering (verified from source).**

| # | Label | Result |
|---|---|---|
| Theorem 1 | `thm:main` | interval theorem (endpoint substitution) |
| Corollary 2 | `cor:regularity` | automatic regularity |
| Theorem 3 | `thm:weak` | strict-minimum (single configuration) |
| Remark 4 | `rem:irrational` | irrational weights alone suffice |
| Corollary 5 | `cor:piecewise` | piecewise saturation |
| Theorem 6 | `thm:higher` | convex domains in any real vector space |
| Proposition 7 | `prop:JQ-pathology` | rational version keeps the pathology |
| Proposition 8 | `prop:resolution` | surrogate calibration is resolution-blind ⟺ affine |

(Proposition 8 — the Section 5 "resolution-blind" statement — was outside the suite's *original* scope; it is now covered by [`notes/reader-section5.md`](reader-section5.md) and audited in **Part II**. Re-derived from source, `prop:resolution` is the eighth counter-advancing environment, confirming **Proposition 8**.)

---

## 1. Defects found **and fixed** in this audit

### 1.1 `thm:weak` was mislabeled "Theorem 2" (correct: **Theorem 3**) — FIXED
- **Where:** [`reader.md`](reader.md) in 7 places (§7.1 heading, the boxed statement, the discussion, the §8 frugality line, Trap E4, exercise X23, drill Rung 7) and **2 cross-references** in [`reader-higher-dim.md`](reader-higher-dim.md) (X22, S22, "the analogue of Theorem 2's strict minimum").
- **Severity:** High. A reader sitting an oral with the paper open would cite the wrong number for the strict-minimum theorem.
- **Root cause:** `reader.md` was drafted on a *local* count (Theorem 1, then "Theorem 2" for the next theorem it discussed) while simultaneously importing the *shared-counter* numbers "Corollary 5" and "Proposition 7" from the manuscript — an internally inconsistent hybrid. The two sibling readers already used "Theorem 3" correctly.
- **Fix:** all nine occurrences renamed to **Theorem 3**.

### 1.2 `thm:higher` was mislabeled "Theorem 11" (correct: **Theorem 6**) — FIXED
- **Where:** [`reader.md`](reader.md) closing "Next" pointer.
- **Severity:** Medium, and self-contradictory: the same file's masthead (sibling-notes line) already called it "Theorem 6."
- **Fix:** renamed to **Theorem 6**; also corrected the scope phrase "a convex subset of $\mathbb{R}^n$" to "a convex subset of **any real vector space**," matching Theorem 6's actual generality (and the dedicated reader).

### 1.3 Hamel-rescaling sign gap — FIXED
- **Where:** the basis-rescaling step that lands a basis element in $(0,1)$: [`reader.md`](reader.md) §3.4 and [`reader-section4.md`](reader-section4.md) §6.4 (statement + parenthetical) and solution S20 — 4 instances.
- **The bug:** the text chose "a **positive** rational $q$" with $qh'\in(0,1)$. But a Hamel-basis element $h'$ may be **negative**, in which case no positive $q$ yields $qh'\in(0,1)$.
- **Severity:** Low (the construction still works), but it is a genuine logical gap a sharp examiner would catch.
- **Fix:** "a **nonzero** rational $q$ **of the same sign as $h'$**, small in magnitude," which lands $qh'\in(0,1)$ for either sign of $h'$.

---

## 2. Adversarial probes that **passed** (verification log)

These are claims I attacked and could not break; recording them so the "green" areas are explicit.

- **Shared counter / numbering.** Re-derived from source (§0 table). After §1 fixes, a full re-grep finds **no** stray `Theorem 2/4/5/7`, `Theorem 11`, `Corollary 3/4`, `Proposition 6/8`, or `Remark 3/5` tokens anywhere in the suite. ✅
- **Strut attributions** (drill D.1 of `reader.md`): "continuity (Cauchy), measurability (Sierpiński), monotonicity (Darboux), positive-measure boundedness (Kormes; one-sided Ostrowski/Kestelman), interval boundedness (Darboux)" — matches the manuscript figure caption **verbatim** (Cauchy 1821, Sierpiński 1920, Darboux 1875, Kormes 1926, Ostrowski 1929, Kestelman 1947, Darboux 1880). ✅
- **Cross-reader consistency of the witness.** The explicit point where the Hamel solution fails the real-weight equation is given identically as $p=h,\ u_1=1,\ u_2=0$ (LHS $\ell(h)=1$, RHS $0$) in `reader.md` S22 and `reader-section4.md` S23. The two readers corroborate rather than contradict. ✅
- **Solution spot-checks (re-derived independently):**
  - `reader-section4.md` S9 (alternative offset $\varepsilon/M=\sqrt5/n$): the irrationality of $2\sqrt5-\sqrt{10}$ and $\sqrt{10}$ checks out by the same squaring argument as the body's $\sqrt3,2\sqrt3-\sqrt6$ lemmas. ✅
  - `reader-section4.md` S13 (3-cell, slopes $1,-1,2$): the three affine pieces match values $\tfrac13,0$ at the knots; continuous, piecewise affine, non-affine. ✅
  - `reader-higher-dim.md` S11 ($\hat A$ well-defined via the $t$-scaling device) and S14 (cone of a disk with interior basepoint is all of $\mathbb{R}^2$; vertex basepoint gives a proper wedge with $D^{*}-D^{*}=\mathbb{R}^2$). ✅
  - `reader.md` S15 (killer lemma) and S19 (Steinhaus one-sided refinement). ✅
- **Prerequisite discipline.** `reader.md` confines measure theory to exactly two struts (§4.3 positive-measure, §4.6 measurability) and supplies the R.12 escape ("skip this box → main theorem, mechanism, and 3 of 5 struts are pure Analysis I + Algebra I"). `reader-section4.md` proves the pathology by **density** (no measure theory). `reader-higher-dim.md` is pure linear algebra. ✅
- **"Reproduce from scratch."** Each reader restates its own engine (Theorem 1) self-containedly, so none depends on the reader having another file open. ✅

---

## 3. Residual weaknesses (not errors — flagged for the review)

These do not affect correctness after §1, but a referee or a demanding student could raise them.

- **R1 — Triple-maintained Hamel construction.** The monster is built in `reader.md` §3, rebuilt in `reader-section4.md` §6, and invoked in `reader-higher-dim.md` X23/S23. The three are now consistent, but a future edit to one must be propagated by hand.
- **R2 — Optional-tool tension.** `reader.md` exercise X19/S19 require Steinhaus's theorem, while the masthead/R.12 tells the Analysis-I-only reader they may skip the measure-theoretic boxes. An honest reader is left unsure whether X19 is "in scope."
- **R3 — Unnumbered Corollary 2.** `reader.md` §5.3 states it as "Corollary (`cor:regularity`)" but refers to it as "Corollary 2" in Trap E14 and X21. Harmless, mildly inconsistent.
- **R4 — Under-justified equivalence.** `reader-section4.md` Trap E11 and the X24 remark assert "the midpoint equation is *equivalent* to $(J_\mathbb{Q})$, not weaker" via "the standard rational-weight argument." The claim is correct but the dyadic-to-rational bridge is not shown; a sharp examiner may demand it.
- **R5 — Terse global-additivity bootstrap.** `reader.md` S7 closes local additivity to global additivity by "the $\mathbb{Q}$-homogeneity/scaling bootstrap" in one clause. True, but the one explicit line (scale $x,y$ into the centered window, use additivity there, then rescale) would make it airtight on the board.

---

## 4. Constructive review

### Strengths
- **Genuinely self-contained.** The Part R recall in `reader.md` plus the per-file engine restatement deliver the "reproduce from scratch" promise for the stated audience. Nothing is hand-waved to "well-known."
- **The extreme-example traps are the strongest pedagogical asset.** They pre-empt the precise stumbles an oral examiner probes — `(J_2)\Rightarrow` affine without regularity (false), $\mathbb{Q}$- vs $\mathbb{R}$-homogeneity, the interval-domain trap, piecewise $\Rightarrow$ global affine (tent), rational-weights-suffice (false), AC essentiality, and "continuity is an output." Each is stated as *temptation → kill*, which is how misconceptions actually get corrected.
- **Exercises are well-graded and load-bearing.** ★–★★★ banding is honest; the ★★★ items (Steinhaus one-sided, dense-graph, $t$-scaling well-definedness, the explicit irrational-weight failure) are exactly the discriminating questions.
- **The drills operationalize mastery.** The blank-page reconstruction ladder and mock-oral script convert "I read it" into "I can deliver it cold."
- **Numbering now matches the manuscript**, so the suite is safe to study with the paper open.

### Recommended improvements (prioritized)
1. **(High)** Resolve **R2**: tag X19 (and any Steinhaus/Lusin exercise) as "*measure-theory track — optional*," mirroring the R.12 escape, so the Analysis-I-only path is unambiguous.
2. **(Medium)** Address **R4**: add a two-line lemma (midpoint $\Rightarrow$ dyadic $\Rightarrow$ all rational weights, purely algebraic) behind Trap E11, or cite it explicitly.
3. **(Medium)** Mitigate **R1**: designate `reader.md` §3 the canonical Hamel construction and have the others cite it for the well-definedness details, keeping only the locally-needed specialization inline.
4. **(Low)** Fix **R3**: print "Corollary 2" at its statement in `reader.md` §5.3.
5. **(Low)** Expand **R5**: one explicit line for the local-to-global additivity step in S7.

### Verdict
**Exam-ready.** With the numbering defects (§1.1–1.2) and the Hamel sign gap (§1.3) corrected, a returning A-student who climbs each reader's reconstruction ladder twice and fields every Part-E trap cold can reconstruct Sections 1–4 **and** Theorem 6 from the two prerequisite courses, and withstand an adversarial oral. The residual items in §3 are polish and presentation, not correctness — none blocks that outcome.

---

*Audit performed against `manuscript-anon-final.tex` and the three readers as committed. All §1 fixes are applied in the same commit series; §3/§4 items are left as recommendations.*

---

# Part II — Audit of the Section 5 reader (`reader-section5.md`)

> **Object.** [`notes/reader-section5.md`](reader-section5.md): the from-scratch reader for **all of Section 5** — the four structural **sources** of a saturated Jensen identity (§5.1), the load-bearing cases (expected utility, Shannon entropy, opinion pools; §5.2), the **vestigial** case (*surrogate calibration*, housing **Proposition 8**; §5.3), the mirrored dictionary and lesson (§5.4–5.5), and the quantum-state coda.
> **Charge.** Same as Part I: adversarial pass for errors/gaps/inconsistencies/over-claims, then a constructive review and a verdict.

## II.0 Method delta (different audience, different bar)

This reader does **not** target the Analysis-I+Algebra-I returning student of Part I. Its stated audience is a **CS-BSc A-student** unfamiliar with **learning theory, optimization/convex analysis, and the SVD**. So the bar shifts: the audit checks that those three fields are **built from scratch** (not assumed), that the *applied* objects (loss, posterior, Bayes risk, calibration, conjugate, SVD) are honestly defined, and — critically — that the reader does **not over-claim** which machinery the core actually needs. Method otherwise mirrors Part I §0: numbering re-derived from source; attributions checked; the riskiest solutions re-derived independently; KaTeX swept (`\ast` not `\*`; no `\emph`/`\textbf` inside `$…$`).

## II.1 Defect found **and fixed** in this audit

### II.1.1 Mis-attributed bounded-additive theorem (source 2) — FIXED
- **Where:** Part 3, "Source 2 — Additivity into a bounded codomain."
- **The bug:** the bounded-additive theorem (a bounded additive function is linear) was attributed to "**Steinhaus**/Ostrowski." Steinhaus's theorem is the *difference-set* result (the difference set of a positive-measure set contains an interval) — a **tool** used to prove the *measurable* case, not the bounded-additive theorem itself.
- **Severity:** Low (the classification and mechanism are correct), but a genuine attribution error a historian-minded examiner would flag — and it contradicts Part I's verified strut attributions.
- **Fix:** re-attributed to the boundedness struts proper — **Darboux** (interval-boundedness), **Kormes** (positive-measure boundedness), **Ostrowski/Kestelman** (one-sided) — matching Part I §2 and the manuscript figure caption.

No other correctness defects were found. In particular, because the reader was drafted **against the §0 numbering table** (verified before writing), the numbering bug that hit `reader.md` (Part I §1.1–1.2) **did not recur** — see II.2.

## II.2 Adversarial probes that **passed** (verification log)

- **Numbering chain.** Re-derived from source: `prop:resolution` is the **eighth** counter-advancing environment ⇒ **Proposition 8** (table in §0, now extended). A full sweep of `reader-section5.md` for stray `Theorem 2/4/5/7/8…`, `Corollary 1/3/4/6/7`, `Proposition 1–6/9`, `Remark 1/2/3/5` tokens returns **none**; every cross-reference (Theorem 1, Corollary 2, Theorem 3, Corollary 5, Theorem 6, Proposition 7, Proposition 8) matches the shared counter. ✅
- **Proposition 8, the four-line proof.** Re-derived independently: (i) atomlessness ⇒ every mass $p=\mu(A)\in[0,1]$ is realized (Sierpiński 1922 / Lyapunov 1940); (ii) the values $u_1,u_2$ are prescribed independently of $A$, so $(p,u_1,u_2)$ ranges over all of $[0,1]^3$; (iii) the hypothesis becomes $p\,G(u_1)+(1-p)\,G(u_2)=G(p\,u_1+(1-p)\,u_2)$ on the whole cube — exactly $(\star)$, $G$ only *evaluated*; (iv) Theorem 1 (Theorem 6 for the simplex) forces $G$ affine, **no** regularity used. Sound. ✅
- **Attributions** spot-checked against the manuscript and verbatim where claimed: the four sources (§5.1); the entropy struts (**Faddeev** continuity → **Tverberg** integrability → **Lee** measurability → **Diderrich** positive-measure boundedness → **Kendall/Borges** monotonicity); opinion pools (**McConway 1981**, **Aczél–Wagner 1980**); Bayes-envelope/proper-scoring names (**Savage**, **DeGroot–Fienberg**, **Schervish 1989**, **Gneiting–Raftery**, **Ehm–Gneiting–Jordan–Krüger 2016**); score decomposition MCB–DSC+UNC (**Murphy 1973**, **Bröcker 2009**); the $\psi$-transform (**Bartlett–Jordan–McAuliffe**, **Steinwart**, **Tewari–Bartlett**); refinement ordering (**Blackwell 1953**); quantum (**Gleason 1957** for $d\ge3$, **Busch 2003** POVM $d\ge2$, **Holevo**). ✅
- **Solutions re-derived independently (the riskiest):**
  - **S5/S6 (tents).** $0$–$1$ loss ⇒ $H(u)=\min(u,1-u)$; log loss ⇒ Shannon entropy; Brier ⇒ $u(1-u)$. Skew tent $H(u)=\min(1-u,cu)$: optimal-action switch at $u^\ast=\tfrac{1}{1+c}$, apex height $\tfrac{c}{1+c}$ — both confirmed ($1-u^\ast=cu^\ast=\tfrac{c}{1+c}$). ✅
  - **S12 (fundamental equation of information).** $f(x)+(1-x)\,f\!\big(\tfrac{y}{1-x}\big)$ with $f$ the binary entropy expands to $-x\log x-y\log y-(1-x-y)\log(1-x-y)$, **symmetric** in the three masses $(x,\,y,\,1-x-y)$ — so the equation holds. ✅
  - **S14 (resolution = variance).** The Brier score's resolution term equals $\operatorname{Var}(\eta)=p(1-p)(u_1-u_2)^2$ for the two-point posterior. ✅
  - **S16 (tent integral).** $\int_0^1 T_\theta(u)\,d\theta=u(1-u)$, via the switch of the $\min$ at $\theta=u$ (two triangular pieces summing to $u(1-u)$) — matches the Brier uncertainty function, confirming the mixture representation. ✅
  - **S18 (extreme rays).** Green's function $k(u,\theta)=\min\!\big(u(1-\theta),(1-u)\theta\big)=\tfrac12 T_\theta(u)$; $-\partial_u^2 T_\theta=2\delta_\theta$, so the tents are the Dirac-indexed extreme rays of the concave cone. Internally consistent (sketch-level on the measure side — see R-S4). ✅
  - **S20 (over-smoothing floor).** Contraction by the spectral gap gives a floor decaying as $|\mu_2|^{L}$ and required depth $L^\ast(\varepsilon)\approx \log(C/\varepsilon)/\log(1/|\mu_2|)$ — dimensionally and monotonically sane. ✅
- **The SVD-honesty claim.** The reader states three times (R.8 scope note, Trap E12, Part 8) that the SVD/spectral theorem is **not used to prove Proposition 8**. Verified against the four-line proof: the core uses only affine functions of a real variable. The SVD appears **only** in (a) the quantum coda via trace functionals $\operatorname{tr}(B\,\cdot)$ on Hermitians (genuine, finite-dim Riesz) and (b) the companion-paper over-smoothing reading. The disclaimer is **accurate** — the reader does not over-claim. ✅
- **Prerequisite discipline for the new audience.** Learning theory (R.7), convex analysis (R.6), and linear algebra/SVD (R.8) are each built from definitions; the two-point mean $p\,u_1+(1-p)\,u_2$ (R.3) is the explicit bridge to $(\star)$; the σ-algebra material (R.4) ships an escape hatch to the finite-partition picture. ✅
- **KaTeX.** Swept for `\*`, `\emph{`, `\textbf{` inside math and for stray build sentinels — none. ✅

## II.3 Residual weaknesses (not errors — flagged for the review)

- **R-S1 — Title vs manuscript term.** The reader is titled "*… on the Real Axis*" while §5.3 of the manuscript is "*… on the resolution axis*." The masthead discloses this, but a reader with the paper open meets two phrases for one object. Low.
- **R-S2 — SVD is the least load-bearing prerequisite.** R.8 is the largest block the **core does not need** (explicitly fenced with a skip note, justified only by the quantum coda and the companion reading). Honest, but a lean "Section 5 core" reader would carry less. Low–Medium.
- **R-S3 — $\psi$-transform stated at working level.** The constrained risk $H^{-}(\eta)$ (the "best surrogate risk subject to predicting the wrong side") is *described*, not formalized as the half-line-constrained infimum; S23 flags the $\psi$-transform↔Corollary 5 link as an **analogy**, not a theorem — correctly, but an examiner could push for the precise definition. Medium.
- **R-S4 — S18 uses the second-derivative measure at sketch level.** "Concave ⇒ $-G''$ is a nonnegative measure; its Diracs are the tents" is invoked without the one-line justification (concave functions admit a second-derivative measure). Rigorous in spirit. Low–Medium.
- **R-S5 — Companion-paper material is adjacent to, not inside, Section 5.** Part 8's over-smoothing reading and X20/S20 (spectral gap $|\mu_2|$, error floor) use companion-paper facts as black boxes. Clearly labeled "companion reading," but a strict Section-5-only reader would trim them. Low.
- **R-S6 — Quantum coda is not fully self-contained.** It cites Theorem 6's proof in [`reader-higher-dim.md`](reader-higher-dim.md) rather than reproving it — consistent with the suite's per-file-engine convention, but the coda leans on a sibling file. Low.

## II.4 Constructive review

### Strengths
- **The four-source taxonomy is the analytic spine, and it lands.** Source 1 (finite mixing → $(J_\mathbb{Q})$, Hamel survives) / source 2 (bounded additivity) / source 3 (Cauchy relative, Shannon) / source 4 (genuine continuum → $(\star)$, regularity vestigial), plus an **ordered diagnostic** and a **two-way misclassification trap**, is exactly the "which hypothesis is load-bearing vs vestigial" judgment the paper exists to teach.
- **Built from scratch for the actual audience.** Three unfamiliar fields (learning theory, convex analysis, SVD) are developed from definitions, with the two-point-mean bridge making the link to $(\star)$ concrete for a reader who has never seen Jensen's equation.
- **Proposition 8 is reduced to the chord substitution**, and the **seductive misclassification** (mistaking source 4 for a Cauchy problem and *adding* a defensive hypothesis) is foregrounded as the paper's origin story — the single most important conceptual takeaway.
- **Honest scoping is a feature, not a hedge.** The SVD disclaimer and the companion-paper fences mean the reader cannot be misled into thinking spectral machinery powers the core. That restraint is rare and correct.
- **Mastery scaffold matches the inherited bar:** 15 traps, 24 graded exercises, 24 full worked solutions, and a drills/recitation/mock-oral block.
- **Numbering verified before drafting** — the Part I bug did not recur.

### Recommended improvements (prioritized)
1. **(Medium)** R-S3: add one line formalizing $H^{-}(\eta)$ as the half-line-constrained infimum, so the $\psi$-transform box is examiner-proof and the "analogy" flag is backed by the precise object.
2. **(Low–Medium)** R-S2: split R.8 — keep "SVD as resolution analogy" in R.8, relocate "spectral theorem / trace functionals" next to the quantum coda (Part 9), sharpening the skippable boundary.
3. **(Low)** R-S1: promote the "(manuscript: *on the resolution axis*)" gloss from the masthead into Part 0, so a paper-in-hand reader maps the phrase instantly.
4. **(Low)** R-S4: append the "concave ⇒ second-derivative measure; Diracs are tents" one-liner to S18.
5. **(Low)** R-S5: tag X20/S20 and Part 8's over-smoothing reading "*companion-paper track — optional*," mirroring the suite's measure-theory-track convention.

### Verdict
**Exam-ready for its stated audience.** With the bounded-additive attribution corrected (§II.1), a CS-BSc A-student who works the four-source classification drill and the reconstruction ladder can **state and prove Proposition 8** from the chord substitution, **classify any saturated identity by source**, and **defend the load-bearing-vs-vestigial call** in an oral. The residuals (§II.3) are scope and polish, not correctness — none blocks that outcome. The reader's defining virtue is its honesty about machinery: it builds the SVD and learning theory the audience lacks, then states plainly that the headline theorem needs **neither** — only affine functions of a real variable, reached by the one-line substitution.

---

*Part II performed against `manuscript-anon-final.tex` and `reader-section5.md` as committed through Stage D. The §II.1 fix is applied in the same commit as this audit; §II.3/§II.4 items are left as recommendations.*
