# Monograph design memo — *The Chord Substitution*

*A senior-undergraduate monograph in the lineage of Cauchy's functional equation.*

*Designed 2026-06-07. Sibling artifact to the CRAS satellite at [`../../satellites/o3-chord-substitution/`](../../satellites/o3-chord-substitution/). Lives in [`monographs/o3-chord-substitution-monograph/`](.).*

---

## 0. One-paragraph pitch

A short, sharp senior-undergraduate monograph on the continuous-coefficient form of Jensen's functional equation $(\star)$ and on the century-long detour through Cauchy, Hamel, Sierpiński, and Steinhaus that the chord substitution renders unnecessary. The reader gets a complete first encounter with: Cauchy's functional equation; the axiom of choice as a *constructive* tool (a Hamel basis); the Polish school of analysis (Warsaw and Lwów, 1920s); and a structural reason a chapter's worth of regularity machinery turns out to be vestigial for the continuous-coefficient version. The punch line is the chord substitution itself — a one-line proof that closes the equation without any regularity hypothesis. The path to the punch line is the whole point: students leave knowing why the question was hard, how mathematicians attacked it, and how one substitution sidesteps it all.

---

## 1. Audience

**Primary:** a senior undergraduate (third or fourth year) in a mathematics degree at a research-active university. The reader has had:

- **Real analysis** — at the Spivak/Pugh/Rudin level: $\varepsilon$-$\delta$ continuity, sequences, series, the intermediate value theorem, the Weierstrass extreme value theorem, the Heine–Borel theorem. Lebesgue measure as a definition, even if integration theory is shallow.
- **Linear algebra** — vector spaces, bases, dimension, linear maps. Comfortable thinking of $\mathbb R$ as a $\mathbb Q$-vector space when prompted.
- **Some abstract algebra** — fields and field extensions at the level of seeing $\mathbb R/\mathbb Q$ as a transcendental extension; comfortable with the axiom of choice and Zorn's lemma, having met them once in a course on rings, groups, or topology.
- **Some topology** — open and closed sets in $\mathbb R$; the notion of density; continuity in the sequential sense.

**Not assumed:** functional analysis, descriptive set theory, model theory, advanced measure theory beyond the definition of Lebesgue measurable sets and the basic properties of Lebesgue measure on $\mathbb R$.

**Secondary:** a beginning graduate student who never met the Hamel-basis pathology head-on and would like a self-contained tour. A working analyst who has heard "the continuous Jensen equation is solved by a chord substitution" and wants the explicit derivation plus the historical context. A teacher of a senior seminar on classical analysis looking for a single self-contained reading.

---

## 2. Scope (what's in / what's out)

### In scope

- **Cauchy's functional equation** $f(x+y) = f(x) + f(y)$ on $\mathbb R$ — derivation from continuity, the inevitability of the classical proof, the natural intuition.
- **Jensen's discrete-coefficient functional equation** $(J_2)$, its equivalence to Cauchy via translation.
- **The full Hamel-basis construction** — what a Hamel basis is, why it exists (Zorn's lemma), the wildness of the resulting non-affine additive functions.
- **The Polish-school resolutions** — Sierpiński (measurability), Steinhaus (boundedness on a set of positive measure), Ostrowski (boundedness on an interval), each with proof.
- **The chord substitution itself** — Theorem 1 with full proof, the explicit affine formula, the corollary that affineness is the *conclusion*, not the hypothesis.
- **The dictionary** — six rows of regularity hypotheses, each separately verified to be unnecessary for $(\star)$.
- **The structural mechanism** — why the Hamel pathology fails at irrational $p$, and why the continuous-coefficient form forecloses on it there.
- **Variants** — Theorem 1$'$ (the strict-minimum hypothesis), the higher-dimensional remark, the contrast with $(J_{\mathbb Q})$.
- **A modest tour of applications** — utility theory (von Neumann–Morgenstern), Shannon entropy axiomatic characterization, surrogate calibration, the partition-Bayes-risk example from the main paper.
- **Historical narrative** — a coherent story arc from Cauchy 1821 through Hamel 1905 through the Polish school 1920s through the modern reframing.
- **Exercises** — at the end of each chapter, ~5–8 per chapter, with hints for a select few.

### Out of scope

- **General theory of functional equations** — Aczél's encyclopedia (1966), Kuczma's treatise (2009 2nd ed.) own this; we cite them as the canonical references but do not attempt to compete.
- **Hyers–Ulam stability** — interesting but tangential; mentioned in the "further reading" appendix only.
- **Functional equations on groups** — also tangential.
- **General convex analysis** — biconjugates, Fenchel duality, supporting hyperplanes are *not* needed for $(\star)$; we use Jensen's inequality but only at saturation.
- **Probability theory beyond elementary** — we touch the partition-Bayes-risk example at a glance, no measure-theoretic probability required.
- **Lean formalization** — the main paper handles this; we cite it.
- **Original research** — the monograph is *expository*. The technical contribution is the **packaging**: a self-contained, pedagogically structured account of a folkloric fact and its historical detour.

---

## 3. Narrative arc (the spine)

The monograph follows a deliberate three-act structure.

### Act I: the question (Chapters 1–3)

The reader meets the equation, sees that continuity gives an immediate answer, and feels the natural question: *is continuity really needed?* For 80 years (Cauchy 1821 to Hamel 1905) this question was open, and the chapter on Darboux 1875 shows the first refinement: monotonicity also suffices, but is monotonicity strictly weaker than continuity, or merely equivalent? The act ends with the reader understanding that *some* tameness hypothesis is needed, but the exact minimum is unknown — and the suspense is set.

### Act II: the pathology and the resolution (Chapters 4–6)

The axiom of choice enters the picture in 1904, and Hamel uses it in 1905 to construct a non-affine additive function. The reader carefully sees the construction: a Hamel basis, an arbitrary assignment of values on basis elements, the $\mathbb Q$-linear extension, the resulting wildness. This is the **first time** in many curricula that a student sees the axiom of choice deployed *constructively* (well, semi-constructively) to produce a concrete pathology rather than as a foundational scaffolding. It is a fundamental story to teach.

The Polish school in the 1920s then closes the question: any tameness hypothesis you might want — measurability (Sierpiński), boundedness on a positive-measure set (Steinhaus), boundedness on an interval (Ostrowski), monotonicity (Darboux, retrospectively cleaned up) — rescues affineness. The reader leaves Act II thinking the question is settled: $(J_2)$ admits exactly two solution classes (affines, plus the Hamel-pathological extension), and the regularity dictionary maps which tameness hypotheses kill the pathology.

### Act III: the escape and what it means (Chapters 7–10)

Then the punch line. The reader meets $(\star)$, the *continuous-coefficient* version with $p$ ranging over the full interval $[0, 1]$. The chord substitution is one line. The dictionary that took Chapters 5 and 6 to assemble is rendered *entirely irrelevant*: $(\star) \Rightarrow$ affine without any regularity hypothesis.

The reader's first reaction should be: "wait, then the entire 80-year detour was for the wrong question?" The next chapters explain *why*: the Hamel pathology lives at irrational $p$, exactly where the discrete- and rational-coefficient versions are silent. The continuous-coefficient form forecloses on the pathology *at exactly the points where the pathology lives*. This is the structural moral.

The final chapter tours applications and frontier — utility theory, Shannon entropy, surrogate calibration, the partition-Bayes-risk story — and shows the chord substitution at work as a *practitioner's tool*, retiring vestigial regularity hypotheses in modern applied analysis.

---

## 4. Learning outcomes

A student who reads this monograph cover-to-cover will be able to:

1. **State and prove** that a continuous additive function on $\mathbb R$ is $\mathbb R$-linear (Cauchy).
2. **Construct** a non-affine additive function on $\mathbb R$ using a Hamel basis, and **verify** that it fails $\mathbb R$-linearity.
3. **State and prove** the Sierpiński theorem: a measurable additive function on $\mathbb R$ is $\mathbb R$-linear.
4. **State and prove** the Steinhaus theorem on the difference set, and **derive** the Sierpiński theorem from it.
5. **State and prove** Theorem 1 of the monograph: a function $G : [0, M] \to \mathbb R$ satisfying $(\star)$ is affine, *without any regularity hypothesis*.
6. **Articulate the structural reason** the Hamel pathology fails for $(\star)$ — namely, that it lives at irrational $p$, where $(\star)$'s continuous coefficient rules it out.
7. **Recognize** the continuous-coefficient form of Jensen's equation when it arises in applied work (utility theory, calibration theory, entropy axiomatic characterization) and **apply** the chord substitution to close the affineness step without invoking unnecessary regularity hypotheses.
8. **Explain** the historical arc from Cauchy 1821 through Hamel 1905 through the Polish school of the 1920s, and **place** the modern reframing in this lineage.

---

## 5. Voice and pedagogical stance

### Voice

Third-person, present tense, narrative. *"We prove… / We construct… / Observe that… / This is the moment to pause."* Mild use of authorial first-person plural in the Bourbaki tradition. Occasional second-person ("the reader is invited to verify") for exercises and active-learning prompts.

### Stance

- **Concrete first, abstract second.** Every theorem is preceded by a concrete example or a worked computation. The Hamel-basis construction (Chapter 4) is preceded by warm-up computations with $\{1, \sqrt 2\}$-linear combinations before the basis structure is introduced.
- **Intuition explicit.** Every proof carries a "what's going on here" paragraph after the technical steps. The reader should never feel the result is a rabbit pulled out of a hat.
- **Historical embedding.** Each chapter opens with a one-paragraph historical placement and closes with a "where this fits" remark. This is not history-of-mathematics fluff; the history is part of *why* the result is interesting.
- **Honest about hard parts.** When a step is genuinely subtle (e.g., the Hamel basis construction depending on the axiom of choice, the Sierpiński proof's use of the Steinhaus difference theorem), we say so and slow down.
- **Exercises that teach.** Each chapter ends with ~5–8 exercises ranging from *direct verification* (warm-up) to *open-ended exploration* (capstone). A subset has hints in Appendix B; a few have full solutions. Exercises are numbered globally (Exercise 1.1, 1.2, …, 9.5) for cross-reference.
- **Forward-looking.** Each chapter signposts where its tools will be used later. The reader should always know *why* a section is in the book.

### Anti-stance

We do **not** lecture from inside the functional-equations specialist literature. The audience is undergraduates who may or may not pursue functional equations; the monograph should serve them whether they continue or move to topology or algebra or applied analysis.

We do **not** assume the reader has previously enjoyed functional equations. Several chapters' worth of intuition-building is dedicated to making the equation feel natural before we ask the reader to fight pathology.

---

## 6. Length, format, and target venue

### Length

**Target:** ~70 pages typeset (about 25,000 words of body + bibliography + index + appendices).

Per chapter:
- Preface: 2 pp
- Ch 1 (one equation, three faces): 5 pp
- Ch 2 (Cauchy and the natural proof): 6 pp
- Ch 3 (the 80-year question, Darboux 1875): 4 pp
- Ch 4 (axiom of choice and Hamel bases): 7 pp
- Ch 5 (Hamel's pathology): 6 pp
- Ch 6 (the Polish-school resolution): 8 pp
- Ch 7 (Jensen's equation: discrete and rational): 5 pp
- Ch 8 (the continuous-coefficient escape): 7 pp
- Ch 9 (variants and dimensions): 5 pp
- Ch 10 (where this matters: applications): 5 pp
- Appendix A (historical timeline): 2 pp
- Appendix B (hints/solutions): 5 pp
- Appendix C (further reading): 2 pp
- References + index: 5 pp

Total: ~74 pp.

### Format

LaTeX `book` document class (Springer compatible). Single-column, A5 or US-letter typeset, with theorem environments, exercise environments, marginal historical notes, an index.

### Venue (a sketch — to be finalized later)

This is **not on the satellite publication plan** ([`../../21-publication_plan.md`](../../21-publication_plan.md)) — it's a new artifact type. Suggested venue lanes:

1. **arXiv `math.HO` (History and Overview), cross-list `math.CA`** — primary deposit, no fees, citable. This is the immediate "ship" target.
2. **AMS Student Mathematical Library** — undergraduate monograph series (~150–300 pp). Our 70 pages is on the short end; would need a co-edited expansion to fit. Submission would be in 2027 at earliest.
3. **Springer Undergraduate Texts in Mathematics (UTM)** — undergraduate textbooks (~200+ pp). Too long for our 70 pages.
4. **Cambridge University Press undergraduate series** — similar.
5. **MAA Press** — *Anneli Lax New Mathematical Library*, *Carus Mathematical Monographs*. Carus is the right size and audience.
6. **Long expository article in *American Mathematical Monthly*** (MAA) — but truncated to ~25 pp.
7. **Long expository article in *Mathematical Intelligencer*** (Springer) — ~25 pp.

**Recommended:** arXiv-first (math.HO + math.CA cross-list), then evaluate venue based on author lane and review speed. The monograph itself is the asset; the venue is a publishing decision separable from the writing.

---

## 7. Relationship to the CRAS satellite and the main paper

The monograph is **not** a competitor to the CRAS satellite ([`../../satellites/o3-chord-substitution/`](../../satellites/o3-chord-substitution/)); the two artifacts target completely different audiences and play complementary roles in the publication ecosystem.

| | CRAS satellite | Senior-undergraduate monograph |
|---|---|---|
| **Audience** | Working researchers in analysis, decision theory, calibration | Undergraduates encountering the equation for the first time |
| **Length** | ~5 typeset pages | ~70 typeset pages |
| **Tone** | Declarative, compressed, citation-targeted | Narrative, expansive, intuition-building |
| **Goal** | A citable pointer for authors needing to retire Hamel concerns | An entry point for students into functional equations and the AC/Hamel story |
| **Proof depth** | One-line proof of Theorem 1, brief justification of the dictionary | Full proof of Theorem 1, complete construction of the Hamel pathology, full proofs of Cauchy/Sierpiński/Steinhaus/Ostrowski |
| **Exercises** | None | ~50 across 10 chapters |
| **History** | One sentence in the introduction | Full historical narrative throughout, dedicated chapters on the Polish school |
| **Modern applications** | One short paragraph (the partition-Bayes-risk recurrence) | A full chapter (utility, entropy, calibration, partition Bayes risk) |
| **Mathematical content** | Identical core result | Identical core result, extensively scaffolded |

The monograph **cites** the CRAS satellite and **cites** the main paper as the modern application. The CRAS satellite **cites** the monograph (in Round-2 revisions, when the monograph has an arXiv ID).

---

## 8. Authorship and acknowledgments

**Author:** the same author as the CRAS satellite and the main paper. The monograph carries the same author's name + institution (subject to the same G-1 affiliation gate as the CRAS satellite, which is operationally pending).

**Style note for AC mention.** Where the axiom of choice surfaces (Chapter 4), the monograph acknowledges its non-trivial logical status with a footnote pointing to Solovay (1970) — the model of ZF + DC in which all sets of reals are Lebesgue measurable, where Hamel bases do not exist and the pathology dissolves. The undergraduate reader is invited to think about the AC's role without being asked to formally study the metamathematics.

**Acknowledgments.** Three project skills documented in the source repository, the seven-round audit trail of the main paper, the multi-phase strategy of the CRAS satellite, the open project skills repository as a record of the methodology, plus the Polish-school mathematicians whose names the monograph carries forward.

---

## 9. Sign-off and hand-off to Plan phase

Design phase **closed**. Plan phase ([`01-plan.md`](01-plan.md)) consumes this memo to produce a chapter-by-chapter outline with section headers, exercise hooks, target page counts, and the narrative spine made explicit. Plan phase is the last write-only phase before drafting; once Plan is closed, Draft begins on Chapter 0 (preface).
