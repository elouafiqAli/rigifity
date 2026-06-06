# Monograph plan — chapter-by-chapter outline

*Plan phase deliverable. Authored 2026-06-07 from [`00-design.md`](00-design.md). The drafting phase consumes this outline directly: each chapter has its target page count, its narrative job, its section structure, its exercise hooks, and its forward-looking handoff.*

---

## Front matter

### Preface — *How to read this book* (~2 pp)

**Job:** orient the reader.

**Sections:**
1. *Who this book is for* — senior undergraduates plus secondary audiences.
2. *Prerequisites* — explicit list with course names.
3. *How to use this book* — read linearly; chapters depend on previous ones; exercises are integral; Appendix B has hints.
4. *A note on the axiom of choice* — flag Chapter 4 as the moment AC enters constructively.
5. *Acknowledgments.*

**Exit:** the reader knows whether the book is for them.

---

## Part I — The question (Chapters 1–3)

### Chapter 1 — *One equation, three faces* (~5 pp)

**Job:** introduce the equation, the three forms, and the central puzzle.

**Sections:**
1.1. *The opening puzzle* — when is a real-valued function "linear"?
1.2. *Three equations side-by-side* — $(J_2)$, $(J_{\mathbb Q})$, $(\star)$, with worked examples.
1.3. *The first surprise* — the chord substitution closes $(\star)$ in one line (statement only; proof in Ch 8).
1.4. *Roadmap.*

**Exercises 1.1–1.6:**
- Verify $G(x) = ax + b$ satisfies all three equations.
- Find the smallest $p \in [0,1]$ at which one can distinguish $G_1(x) = x^2$ from an affine on $[0,1]$ via $(J_2)$.
- Verify that $G(x) = \lfloor x \rfloor$ violates $(J_2)$.
- (Open-ended) Suggest a function that satisfies $(J_2)$ but not $(\star)$ — then read Chapter 5 for the answer.

**Hand-off:** Chapter 2 picks up Cauchy's natural proof.

### Chapter 2 — *Cauchy 1821: the natural proof* (~6 pp)

**Job:** show that continuity gives Cauchy/Jensen affineness, by the textbook route.

**Sections:**
2.1. *Cauchy's equation* — $f(x+y) = f(x) + f(y)$, and its equivalence with $(J_2)$ via translation.
2.2. *Step 1: continuity ⟹ $\mathbb Q$-homogeneity* — $f(qx) = qf(x)$ for $q \in \mathbb Q$.
2.3. *Step 2: $\mathbb Q$-homogeneity + continuity ⟹ $\mathbb R$-homogeneity* — approximate irrationals by rationals.
2.4. *Why the proof feels inevitable* — continuity is the natural smoothing tool of 19th-century analysis.
2.5. *Historical placement* — Cauchy's *Cours d'analyse* (1821), the rigorization of analysis after Lagrange.

**Exercises 2.1–2.7:**
- Verify Step 1 by induction.
- Verify Step 2 by sequence approximation.
- (Slightly harder) Show that monotone $f$ satisfying Cauchy is also $\mathbb R$-linear (preview of Darboux 1875, Ch 3).
- (Harder) What goes wrong if we replace continuity with continuity at a single point?

**Hand-off:** Chapter 3 asks the question: was continuity *necessary*?

### Chapter 3 — *The 80-year question and Darboux's first refinement (1875)* (~4 pp)

**Job:** raise the central question and present the first refinement.

**Sections:**
3.1. *Was continuity necessary?* — the 19th-century intuition that *some* tameness is needed.
3.2. *Darboux 1875: monotonicity suffices* — proof sketch.
3.3. *What's the minimum?* — the question that drives Chapters 4–6.
3.4. *Historical placement* — Darboux's broader project on pathological functions; the 19th-century preoccupation with "Was sind und was sollen die Zahlen?" (Dedekind 1888).

**Exercises 3.1–3.5:**
- Sketch Darboux's proof.
- Construct a non-affine $f$ satisfying $(J_2)$ that has dense graph (the answer comes in Ch 5).
- (Open-ended) Why is monotonicity *natural* but maybe not *minimal*?

**Hand-off:** Chapter 4 introduces the tool that will both create the pathology and force the regularity question.

---

## Part II — The pathology and the resolution (Chapters 4–6)

### Chapter 4 — *The axiom of choice and Hamel bases* (~7 pp)

**Job:** introduce a tool the reader will use to construct the Hamel pathology in Ch 5.

**Sections:**
4.1. *Zermelo 1904* — the well-ordering theorem and AC; the controversy.
4.2. *$\mathbb R$ as a $\mathbb Q$-vector space* — the structural observation.
4.3. *A Hamel basis: definition* — $\mathbb Q$-linearly independent generating set of $\mathbb R$.
4.4. *Existence via Zorn's lemma* — the standard "every vector space has a basis" argument.
4.5. *Some $\mathbb Q$-independent reals* — $1, \sqrt 2, \pi, e, \log 2$ — never proven to extend to a basis with all the others, but each pair is independent.
4.6. *Cardinality* — $|H| = \mathfrak c$ (continuum).
4.7. *The strangeness* — a Hamel basis is uncountable, no Hamel basis is Lebesgue measurable, no Hamel basis has the Baire property.

**Exercises 4.1–4.8:**
- Verify $\{1, \sqrt 2\}$ is $\mathbb Q$-independent.
- Show that any countable subset of $\mathbb R$ is $\mathbb Q$-independent only if its cardinality is $\le 1$ (negative — give the right statement).
- (Harder) Prove Zorn-lemma existence of a Hamel basis containing any fixed $\mathbb Q$-independent set.
- (Frontier) Look up Solovay 1970: a model of ZF + DC in which all sets of reals are measurable and Hamel bases do not exist. *What changes in our story?*

**Hand-off:** Chapter 5 uses the Hamel basis to construct the pathology.

### Chapter 5 — *Hamel's pathology (1905)* (~6 pp)

**Job:** construct a wild additive function and verify its wildness.

**Sections:**
5.1. *The construction* — pick a Hamel basis $H$ containing $1$, define $\ell$ on $H$ arbitrarily, extend $\mathbb Q$-linearly.
5.2. *Verification: $\ell$ satisfies Cauchy* — by construction.
5.3. *$\ell$ is not $\mathbb R$-linear* — if $\ell(1) = 0$ but $\ell(h) = 1$ for some basis element $h \neq 1$, then $\ell$ is not a scalar multiple of any affine.
5.4. *$\ell$ is wild* — graph dense in $\mathbb R^2$, not bounded on any interval, not measurable, no points of continuity.
5.5. *Hamel's 1905 paper* — what he wrote, what it meant, why it mattered.
5.6. *The role of the axiom of choice* — without AC, the pathology dissolves; the moral.

**Exercises 5.1–5.7:**
- Verify that $\ell$ satisfies Cauchy directly from the $\mathbb Q$-linear extension.
- Verify the graph of $\ell$ is dense in $\mathbb R^2$.
- (Harder) Show $\ell$ has no points of continuity.
- (Frontier) Read Solovay 1970 again — does the moral change?

**Hand-off:** Chapter 6 resolves the question by showing what *does* suffice.

### Chapter 6 — *The Polish school answers (1920–1929)* (~8 pp)

**Job:** present the Sierpiński, Steinhaus, and Ostrowski resolutions, with proofs.

**Sections:**
6.1. *The Polish school context* — Warsaw and Lwów in the 1920s, the founding of *Fundamenta Mathematicae*, the Scottish Café.
6.2. *The Steinhaus difference theorem (1920)* — if $E \subseteq \mathbb R$ has positive Lebesgue measure, then $E - E$ contains an open interval. Full proof.
6.3. *Sierpiński 1920: measurability suffices* — proof via Steinhaus difference theorem.
6.4. *Steinhaus 1920: boundedness on a positive-measure set suffices* — proof.
6.5. *Ostrowski 1929: boundedness on an interval suffices* — proof.
6.6. *Darboux retrospectively: monotonicity suffices* — proof via Steinhaus difference (cleaner than Darboux's 1875 original).
6.7. *The summary table* — six rows of regularity hypotheses, each suffices, each insufficient without (next chapter's preview).

**Exercises 6.1–6.8:**
- Verify the Steinhaus difference theorem in dimension 1.
- Apply Sierpiński to a measurable solution of Cauchy.
- (Harder) Use Steinhaus to show: every additive measurable function on $\mathbb R$ is bounded on $[-1,1]$.
- (Open-ended) Why is monotonicity *equivalent* to continuity for additive functions, not just *sufficient*?

**Hand-off:** Chapter 7 cleans up the discrete-coefficient story and shows $(J_{\mathbb Q})$ inherits the same pathology.

---

## Part III — The escape and what it means (Chapters 7–10)

### Chapter 7 — *Jensen's equation: discrete and rational coefficients* (~5 pp)

**Job:** consolidate the discrete and rational coefficient stories.

**Sections:**
7.1. *Jensen 1906: convexity and the equation* — the place of Jensen's inequality in classical analysis.
7.2. *$(J_2)$ ↔ Cauchy via translation* — $f(x) = G(x) - G(0)$.
7.3. *Inherits the same pathology* — Hamel construction gives non-affine $(J_2)$-solutions.
7.4. *$(J_{\mathbb Q})$: rational coefficients give the same conclusion* — Cauchy additivity + $\mathbb Q$-homogeneity returns $(J_{\mathbb Q})$.
7.5. *A complete catalog of solutions* — affines + Hamel-pathological extensions.
7.6. *Where this leaves us* — *some* regularity is needed for the rational-coefficient form; what about the continuous-coefficient form?

**Exercises 7.1–7.5:**
- Verify the equivalence $(J_2) \leftrightarrow$ Cauchy via translation.
- Verify the Hamel pathology for $(J_{\mathbb Q})$.
- (Harder) Find an additive function that satisfies $(J_{\mathbb Q})$ on $[0,1]$ but is not affine on $[0,1]$ (= Proposition 4 from the satellite).

**Hand-off:** Chapter 8 is the punch line.

### Chapter 8 — *The chord substitution (the main theorem)* (~7 pp)

**Job:** present Theorem 1 and the structural moral.

**Sections:**
8.1. *The continuous-coefficient form $(\star)$* — restated with care.
8.2. *Theorem 1 (the main result)* — full statement.
8.3. *Proof: the chord substitution* — one line of algebra, $p = v/M$.
8.4. *Corollary: $G$ inherits every regularity* — continuity, monotonicity, etc., as consequences not hypotheses.
8.5. *Where does the pathology fail?* — the Hamel pathology is $\mathbb Q$-linear but not $\mathbb R$-linear; $(\star)$ at irrational $p$ catches the defect.
8.6. *The structural mechanism* — the Hamel pathology lives at irrational $p$, exactly where the continuous coefficient rules it out.
8.7. *Why the 80-year detour was a wrong question* — Cauchy never had access to (★)'s coefficient range; Darboux didn't either; Sierpiński didn't either. (★) is genuinely a different functional equation.

**Exercises 8.1–8.7:**
- Verify Theorem 1 from a different chord (pin at $u_1 = 0$, $u_2 = M$).
- Verify Corollary 2: affine functions are continuous, monotone, locally Lipschitz, etc.
- (Harder) Find the explicit Hamel-pathological violation of (★) at an irrational $p$.
- (Frontier) State and prove an analogue of (★) on a convex subset of $\mathbb R^n$ (preview of Ch 9).

**Hand-off:** Chapter 9 generalizes.

### Chapter 9 — *Variants and dimensions* (~5 pp)

**Job:** show the chord substitution is robust under modest generalization.

**Sections:**
9.1. *Theorem 1$'$: the strict-minimum hypothesis* — only the chord configuration needed.
9.2. *Higher dimensions* — convex subsets of $\mathbb R^n$ or of a real vector space.
9.3. *Sketch of Aczél–Dhombres-style induction.*
9.4. *Counterexample: the rational-coefficient version $(J_{\mathbb Q})$ still has the pathology* — Proposition 4 restated and re-proven.
9.5. *The dictionary* — Table 1 from the CRAS satellite, redrawn with proofs of each row.

**Exercises 9.1–9.5:**
- Verify Theorem 1$'$ proof.
- Sketch the induction for $\mathbb R^2$.
- (Harder) State a higher-dimensional Hamel-style pathology.

**Hand-off:** Chapter 10 takes the result outside.

### Chapter 10 — *Why this matters: a tour of applications* (~5 pp)

**Job:** show where the chord substitution actually saves work in modern applied analysis.

**Sections:**
10.1. *Von Neumann–Morgenstern utility theory* — the Archimedean axiom vs. the chord substitution.
10.2. *Shannon entropy's axiomatic characterization* — Khinchin–Faddeev recursivity.
10.3. *Surrogate calibration on the resolution axis* — Bartlett–Jordan–McAuliffe, Reid–Williamson, and where the chord substitution sits.
10.4. *Partition Bayes risk* — the main paper's recurrence (cite the satellite).
10.5. *A reading list for further exploration.*

**Exercises 10.1–10.4:**
- Verify the chord substitution closes the von Neumann–Morgenstern linearity step.
- (Open-ended) Find a calibration-theory paper that derives $(\star)$ and check whether they invoke an unnecessary regularity hypothesis.
- (Frontier) Read the main paper [El2] §4.2 Step 2.

**Hand-off:** Appendices.

---

## Back matter

### Appendix A — *Historical timeline* (~2 pp)

A chronological list with a one-line summary per entry:
- **1821** Cauchy, *Cours d'analyse*.
- **1875** Darboux, *Mémoire sur les fonctions discontinues*.
- **1888** Dedekind, *Was sind und was sollen die Zahlen?*
- **1904** Zermelo, well-ordering theorem.
- **1905** Hamel, *Eine Basis aller Zahlen…*.
- **1906** Jensen, the inequality.
- **1920** Sierpiński; Steinhaus; founding of *Fundamenta Mathematicae*.
- **1929** Ostrowski.
- **1932** Banach, *Théorie des opérations linéaires*.
- **1966** Aczél, *Lectures on Functional Equations*.
- **1970** Solovay, "A model of set-theory in which every set of reals is Lebesgue measurable."
- **1985, 2009 (2nd ed.)** Kuczma, *An Introduction to the Theory of Functional Equations and Inequalities*.
- **2026** The chord substitution as a one-line note (CRAS satellite); the resolution-axis transposition framing (main paper).

### Appendix B — *Hints and solutions to selected exercises* (~5 pp)

Per chapter, a subset of exercises receives a *hint* (one paragraph) or a *full solution* (worked through). The pedagogical principle: hints for medium-difficulty exercises, full solutions for the keystone exercises that the next chapter assumes.

### Appendix C — *Further reading* (~2 pp)

Annotated bibliography of further study:
- **Functional equations:** Aczél 1966, Kuczma 2009, *Aequationes Mathematicae* journal.
- **The Hamel pathology:** Sierpiński 1920, Steinhaus 1920, Banach 1932, Solovay 1970, descriptive set theory (Kechris 1995, Solecki & Steprans 2010s).
- **Hyers–Ulam stability:** Hyers 1941, Ulam 1960, Hyers–Isac–Rassias 1998.
- **Modern applications:** Bartlett–Jordan–McAuliffe 2006, Reid–Williamson 2010+2011, the main paper [El2].

### References (~5 pp)

Full bibliography, alphabetical by first-author surname.

### Index (~1 pp)

Concept index — affine function, axiom of choice, Cauchy's equation, chord substitution, Hamel basis, Jensen's equation, measurable function, monotone function, Polish school, Sierpiński, Steinhaus, etc.

---

## Cross-chapter dependencies

```
Preface
  ↓
Ch 1 (three faces) ──────────────────────────────────┐
  ↓                                                   │
Ch 2 (Cauchy, continuity) ──────┐                    │
  ↓                              │                    │
Ch 3 (Darboux, monotonicity)     │                    │
  ↓                              │                    │
Ch 4 (Hamel bases) ─────────────┴── (used in Ch 5 and Ch 7)
  ↓
Ch 5 (Hamel pathology)
  ↓
Ch 6 (Polish school)
  ↓
Ch 7 (Jensen / rational coefficients) ─── (uses Ch 5)
  ↓
Ch 8 (chord substitution) ─── (the main theorem; uses Ch 7)
  ↓
Ch 9 (variants / dimensions) ─── (uses Ch 8)
  ↓
Ch 10 (applications)
  ↓
Appendix A (timeline)
Appendix B (solutions)
Appendix C (further reading)
References / Index
```

Chapters 1, 2, 3 form Act I. Chapters 4, 5, 6 form Act II. Chapters 7, 8, 9, 10 form Act III.

---

## Exercise hooks (preview)

A select subset of "capstone" exercises — those that reach forward into later chapters or out to the working literature:

- **Exercise 1.6 (open-ended).** Suggest a function that satisfies $(J_2)$ but not $(\star)$ — answered in Ch 5.
- **Exercise 2.7 (frontier).** What goes wrong if continuity is replaced by continuity at a single point? — preview of Sierpiński 1920.
- **Exercise 4.8 (frontier).** Look up Solovay 1970 and Solovay's model of ZF+DC.
- **Exercise 5.7 (frontier).** Read Solovay 1970 — does the moral change?
- **Exercise 6.8 (open-ended).** Why is monotonicity equivalent to continuity for additive functions?
- **Exercise 7.5 (harder).** Find an additive $f$ that satisfies $(J_{\mathbb Q})$ on $[0,1]$ but is not affine on $[0,1]$.
- **Exercise 8.7 (frontier).** State and prove an analogue of $(\star)$ on a convex subset of $\mathbb R^n$.
- **Exercise 9.3 (harder).** State a higher-dimensional Hamel-style pathology.
- **Exercise 10.3 (open-ended).** Find a calibration-theory paper that derives $(\star)$ and check whether they invoke a vestigial hypothesis.

These exercises form the "active reading" backbone of the monograph; a student who works through them along with the body is doing the project.

---

## Hand-off to Drafting phase

Plan is **complete**. Drafting begins on the Preface and proceeds linearly through Chapter 10 + Appendices, with the LaTeX harness assembled after the Markdown drafts are stable.

The drafting phase produces:

- [`02-monograph.md`](02-monograph.md) — the full monograph in one Markdown file (chapters concatenated), source for the LaTeX.
- [`latex/`](latex/) — LaTeX `book`-class harness with build scripts (Phase Ship).
- [`README.md`](README.md) — overview, status, hand-off back to the publication plan.

The first drafting pass aims for **complete coverage**, not polished prose; a second pass polishes voice and verifies cross-references. Audit phase (Judge π pedagogical audit) happens after the first complete draft lands.
