# Adversarial Audit & Constructive Review — the Reader Suite

> **Object.** The from-scratch reader suite for *The Continuous-Coefficient Jensen Equation: How Real Mixing Weights Retire Regularity*:
> [`notes/reader.md`](reader.md) (Sections 1–4, one-dimensional theory), [`notes/reader-higher-dim.md`](reader-higher-dim.md) (Theorem 6), [`notes/reader-section4.md`](reader-section4.md) (all of Section 4), with the application notes [`notes/utility.md`](utility.md) and [`notes/shannon.md`](shannon.md) in the background.
> **Charge.** Audit adversarially for errors, gaps, inconsistencies, prerequisite violations, and pedagogical weak points; then deliver a constructive review with a verdict on exam-readiness.
> **Audience the suite targets.** A returning A-student: Analysis I + Algebra I, vaguely recalled, a decade out. The audit holds the suite to *that* bar — every step reproducible from those two courses.

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

(Proposition 8 — the Section 5 "resolution-blind" statement — is outside the suite's scope.)

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
