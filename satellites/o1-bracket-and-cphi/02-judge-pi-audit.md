# Round 2 — Judge π adversarial audit of `01-draft0.0-manuscript.md`

*Satellite O1 — "A bracket for the partition-restricted Bayes risk." Audit conducted 2026-06-06 by Judge π in hostile-referee mode against [`01-draft0.0-manuscript.md`](01-draft0.0-manuscript.md). Pattern per [`../../21-publication_plan.md`](../../21-publication_plan.md) §1.2 and consistent with [`../../17-pi_adversarial_audit_of_draft0.6_post_phase_d.md`](../../17-pi_adversarial_audit_of_draft0.6_post_phase_d.md) and the sibling [`../o3-chord-substitution/02-judge-pi-audit.md`](../o3-chord-substitution/02-judge-pi-audit.md).*

---

## 0. Headline

**CONDITIONAL PASS — close in one cycle, then hand to Judge S for the prior-art audit.** The mathematics is correct end-to-end. Theorem 1's two directions and the atomless / general-space dichotomy are clean; the chord lemma → universal $c_\varphi = \tfrac12$ → bracket pipeline is the right ordering of dependence; the §6 prior-art positioning lays out the resolution-axis-vs-optimization-axis distinction at the right granularity for an SPL audience. Zero **[Critical]** findings. But four **[Material]** defects — M-1 arithmetic / units sloppiness in the §5.1 worked-example table; M-2 the §7 mechanization paragraph conflates realizability hypotheses for two different theorems; M-3 the reference list carries five-plus uncited entries; M-4 the converse-direction proof of Theorem 1 is correct but the universal quantifier interaction with $f$ needs one line of clarification — together with five **[Minor]** copy edits and two **[Strategic]** presentation issues block the submission. All eleven close in one revision pass. The **prior-art audit against Reid–Williamson 2011, BJM 2006, Zhang 2004, Blackwell 1953, Le Cam 1986, Torgersen 1991 is reserved for Round 4 (Judge S)** and is the gating concern for this satellite — the present audit notes the precedent landscape but defers verification.

---

## 1. Scope of this review

I re-derived Lemma 1, Theorems 1 (both directions, both general-space and atomless), 2, 3, and Corollary 1 from scratch against the definitions in §2. I checked all numerical entries in the §5.1 worked example. I verified the consistency between the manuscript's claims and the Lean kernel symbols cited in §7. I did **not** verify the citations on page-by-page basis against the cited works (that is Judge S's mandate in Round 4); I did, however, flag which §6 claims are most-likely to be challenged on prior-art grounds and which arguments the manuscript should pre-emptively articulate.

I did **not** re-verify the standard convex-analytic facts (Jensen, chord domination, inverse-of-concave-increasing-is-convex) — those are textbook (Hardy–Littlewood–Pólya, Roberts–Varberg) — but I checked that the manuscript's appeal to them is correct.

---

## 2. Findings (line-cited, severity-tagged)

### [Material] M-1 — §5.1 worked-example table contains an unparseable cell and a misplaced units parenthetical

The variance-row "lower bound" cell in the §5.1 table reads:

> *"$0.25 - \tfrac14(\sqrt{1-3/4}\,)$ recovers $\eta\in\{\tfrac14,\tfrac34\}$ with $\eta(1-\eta) = 3/16$, so $\varphi_{\mathrm{var}}^{-1}(\tfrac34) = \tfrac14$"*

**Defect.** The expression "$0.25 - \tfrac14(\sqrt{1-3/4}\,)$" is not the lower-bound value, it is a fragment of the quadratic solution. The cell should contain the single number `0.25` (the correct lower-bound value, which the rest of the cell verifies). The current cell is unparseable as a table entry.

*Correct calculation* (for the audit trail): $\bar\varphi_{\mathrm{var}}(\Pi) = \tfrac12\cdot\tfrac34 + \tfrac12\cdot\tfrac34 = \tfrac34$. Then $\varphi_{\mathrm{var}}^{-1}(\tfrac34)$ solves $4\eta(1-\eta) = \tfrac34$ on $[0,\tfrac12]$, i.e., $\eta^2 - \eta + 3/16 = 0$, with roots $\eta = (1\pm\tfrac12)/2 \in \{\tfrac14,\tfrac34\}$; the root in $[0,\tfrac12]$ is $\eta = \tfrac14 = 0.25$. The lower-bound cell value is **$0.25$**.

**Second defect** (same paragraph). The parenthetical after the table — *"Pointwise, $\varphi_{\mathrm{var}}\le\varphi_H$ on $[0,1]$ — the standard inequality $4\eta(1-\eta)\le H(\eta)$ in nats; in bits the inequality reads $4\eta(1-\eta)\le -[\eta\log_2\eta+(1-\eta)\log_2(1-\eta)]$"* — is in the wrong units. The manuscript's $\varphi_H$ is the bit-normalised entropy (so that $\varphi_H(\tfrac12) = 1$). The "standard inequality $4\eta(1-\eta) \le H(\eta)$ in nats" is *not* the inequality under our normalisation: in nats $H(\tfrac12) = \ln 2 \approx 0.693$, so the nat-version $4\eta(1-\eta)\le H_{\text{nats}}(\eta)$ would compare $4\eta(1-\eta)$ to a function whose maximum is $\ln 2 < 1$, i.e. *a stronger inequality* than what the manuscript wants. The bit-version $4\eta(1-\eta)\le\varphi_H(\eta)$ is the one we use, and it holds (sanity check: $4\cdot\tfrac14\cdot\tfrac34 = 0.75 \le \varphi_H(\tfrac14) \approx 0.8113$ ✓; $\eta = 0.1$: $0.36 \le 0.469$ ✓; equality at $\eta = \tfrac12$). The parenthetical should drop the nat detour and just state the bit-inequality with a citation.

*Disposition.* Rewrite the variance lower-bound cell to "$0.25$"; replace the parenthetical with: *"The standard inequality $4\eta(1-\eta)\le\varphi_H(\eta)$ holds on $[0,1]$ under the bit normalisation $\varphi_H(\tfrac12)=1$, with equality at $\eta\in\{0,\tfrac12,1\}$ (see Cover–Thomas [REF], or by the chord lemma applied separately to $\varphi_{\mathrm{var}}$ and $\varphi_H$, both of which are tangent to the chord at $\eta=\tfrac12$ and $\varphi_H$ is the more concave). Consequently $\bar\varphi_{\mathrm{var}}\le\bar\varphi_H$ on every partition, so among the three smooth members the variance gives the tighter upper bracket."*

### [Material] M-2 — §7 mechanization paragraph conflates the realizability hypotheses for two different theorems

Draft §7 second paragraph:

> *"The Lean development consumes two **realizability typeclasses** — `SingleCellRealizable` (atomless realization of a single-cell partition of arbitrary rate) and `BinarySplitRealizable` (atomless realization of a binary split with arbitrary subcell rates) — each provable from atomlessness via Sierpiński's theorem [22]."*

**Defect.** The §7 narrative does not distinguish which theorems consume which typeclass. In the Lean kernel:

- `bracket_upper` consumes neither typeclass — it is pointwise (chord lemma applied per cell, aggregated by summation), no realizability needed.
- `bracket_lower` consumes neither typeclass — it is Jensen on the convex $\varphi^{-1}$ applied to the existing partition, no realizability needed.
- `cPhi_eq_half_of_normalized` and `two_eta_le_of_normalized` consume neither typeclass — pointwise on $[0,1]$.
- `theorem1_easy` (the $(\mathrm{iii})\Rightarrow(\mathrm{i})$ direction) consumes neither typeclass — Jensen on the existing partition.
- `theorem1_hard` (the $(\mathrm{ii})\Rightarrow(\mathrm{iii})$ converse direction) consumes `BinarySplitRealizable` — to construct the witnessing partition.
- `SingleCellRealizable` is consumed by **Corollary 1 of this manuscript** (the binary single-cell-pinning argument for the tent-as-unique-exact-score statement), to construct the witnessing single-cell partition.

The current §7 implies that *both* typeclasses are needed for *all* the cited theorems, which over-states the dependency. A hostile referee with mathlib literacy will notice.

*Disposition.* Re-write the second paragraph of §7 to:

> *"Lemma 1, Theorem 2, Theorem 3, and the easy direction of Theorem 1 (`two_eta_le_of_normalized`, `cPhi_eq_half_of_normalized`, `bracket_lower`, `bracket_upper`, `theorem1_easy`) consume no realizability hypothesis — each is pointwise or summed-pointwise on the existing partition. The **converse direction of Theorem 1** (`theorem1_hard`) consumes the typeclass `BinarySplitRealizable`, which encodes the existence of a measurable binary split of a cell of arbitrary mass and conditional rate into subcells of arbitrary masses and arbitrary conditional rates — provable from atomlessness via Sierpiński's theorem [22]. **Corollary 1** (the binary single-cell-pinning argument) consumes the typeclass `SingleCellRealizable`, encoding the existence of a single-cell partition of arbitrary mass and arbitrary conditional rate — also provable from atomlessness via Sierpiński. The general-space density argument of §4 (after Theorem 1) recovers concavity from the atomless statement at the manuscript level; the Lean kernel verifies the atomless case directly."*

### [Material] M-3 — bibliography contains five-plus uncited entries

The reference list as written:

- [2] Bauschke–Combettes (convex analysis textbook) — not cited.
- [5] Buja–Stuetzle–Shen (loss functions for class probability estimation) — not cited.
- [7] DeGroot (1970 textbook) — not cited; only DeGroot [6] is invoked in §6.3.
- [8] Devroye–Györfi–Lugosi (pattern recognition textbook) — not cited.
- [13] Hu–Niu–Sato–Sugiyama (DRO ICML 2018) — cited only with an *ironic* parenthetical *"cited only as a reference application of ψ-transform thinking; not load-bearing for any claim here"* — this is dead-weight and creates the suspicion of citation padding.
- [15] Kullback (information theory textbook) — not cited.
- [23] Steinwart (loss-comparison paper) — not cited.
- [24] Tewari–Bartlett (multiclass consistency) — not cited (or marginally cited; the satellite is binary throughout, so multiclass references should not be in the bibliography).

A reviewer will read this as either citation padding or sloppy hygiene. The bibliography of an SPL note should be tight.

*Disposition.* Two options.

**Option A (recommended).** Invoke or drop. Specifically:
- Drop [13] (irrelevant to this note).
- Drop [24] (multiclass, out of scope here).
- Invoke [5] Buja–Stuetzle–Shen in §2.3 as a standard reference for normalised proper losses ("see, e.g., Buja, Stuetzle, and Shen [5] for a survey of the proper-loss / class-probability-estimation correspondence").
- Invoke [8] Devroye–Györfi–Lugosi in §2.2 as a textbook reference for the Bayes risk ("the partition-restricted Bayes risk is the natural specialisation of the standard Bayes risk to the resolution-restricted predictor class; see Devroye, Györfi, and Lugosi [8, Ch. 2] for the textbook treatment").
- Invoke [23] Steinwart in §6.2 as a refinement of the BJM line ("Steinwart [23] develops a related comparison of loss-induced calibration constants").
- Invoke [2] Bauschke–Combettes in §5 footnote for the inverse-of-concave-increasing convexity fact ("see Bauschke and Combettes [2, §8.2] for a reference treatment").
- Drop [7] DeGroot 1970 (textbook, superseded by [6] DeGroot 1962 for the result we use).
- Drop [15] Kullback (information-theory textbook; the bracket is not an information-theory result in the Kullback sense).

**Option B.** Drop all eight, leaving only the actually-invoked references. Tightest bibliography; risks under-citing the broader literature for a referee who wants more.

Recommend **Option A** — it keeps the bibliography respectfully broad while ensuring every entry has a body citation.

### [Material] M-4 — §4 converse-direction proof needs one line of clarification on the universal quantifier in $f$

Draft §4 converse-direction proof, opening:

> *"Fix $a,b\in[0,1]$ and $\lambda\in(0,1)$; set $\eta := \lambda a + (1-\lambda)b\in[0,1]$. We construct a partition $\Pi$ with a single cell of conditional rate $\eta$ and a binary split into subcells of conditional weights $\lambda,(1-\lambda)$ and conditional rates $a,b$, and apply (ii)."*

**Defect.** The theorem statement quantifies (ii) over "every finite measurable partition $\Pi$, every cell $S_i$ of $\Pi$, ... and every binary split ...", and *separately* the labeling $f$ is fixed for the partition-functional definition $\bar\varphi(\Pi) = \sum_i p_i\varphi(\eta_i)$. The converse-direction proof constructs *both* the partition *and* the labeling simultaneously, to realise the desired $(a,b,\lambda)$ at conditional rates $\eta_i$. This is correct — the theorem statement also quantifies over every measurable labeling $f$ — but the proof should *say so*, otherwise a careful reader will wonder whether the labeling can really be chosen freely.

*Disposition.* Insert before the construction:

> *"Theorem 1 quantifies separately over partitions $\Pi$ and labelings $f$ (both quantified universally in (i) and (ii)), so for the converse direction we are free to choose *both* simultaneously. We construct a specific $(\Pi, f)$ for which the binary-split inequality at $(a, b, \lambda)$ becomes the concavity inequality at $(a, b, \lambda)$ for $\varphi$; since $(a, b, \lambda)$ were arbitrary, $\varphi$ is concave."*

The remainder of the proof construction stands.

### [Minor] m-1 — §5 Theorem 3 lower-endpoint proof should cite the inverse-of-concave-increasing-is-convex fact

Draft §5, in the Theorem 3 proof:

> *"Then $\varphi^{-1}$ is monotone increasing on $[0,1]$ (since $\varphi$ is symmetric and concave with $\varphi(\tfrac12)=1$, its restriction to $[0,\tfrac12]$ is a strictly increasing continuous bijection onto $[0,1]$), and concavity of $\varphi$ on $[0,1]$ makes $\varphi^{-1}$ convex on $[0,1]$."*

**Defect.** The claim "concavity of $\varphi$ on $[0,1]$ makes $\varphi^{-1}$ convex on $[0,1]$" is true (the standard fact: the inverse of an increasing concave function is convex) but is invoked without citation. A careful reviewer will pause.

*Disposition.* Add the parenthetical citation: *"(the standard fact that the inverse of a strictly increasing concave function is convex; see, e.g., Bauschke–Combettes [2, §8.2] or Roberts–Varberg [20, §B])"*.

### [Minor] m-2 — §2.3 strict-monotonicity clause (6) needs a one-line motivation

Draft §2.3 lists clause (6) ("strictly increasing on $[0,\tfrac12]$") without explaining its role. A non-specialist reader will wonder why strictness — concavity plus $\varphi(\tfrac12) = 1$ does not force strict monotonicity in general (a flat plateau at height $1$ near $\tfrac12$ would still be concave and would still attain the normalisation).

*Disposition.* Append one sentence: *"The strict-monotonicity clause (6) is included for the existence of the inverse $\varphi^{-1}:[0,1]\to[0,\tfrac12]$, which the lower bracket of Theorem 3 invokes; without (6) the upper bracket of Theorem 3 still holds, but the lower one needs an inverse and so needs strict monotonicity."*

(The manuscript actually does have this sentence at the bottom of §2.3, but it should be moved up to immediately after the enumeration of clauses (1)–(6), so that the reader encountering clause (6) gets the motivation in the same breath.)

### [Minor] m-3 — §6.2 table "(typically not given)" cell is uninformative

Draft §6.2 table, "Lower instrument" row, "$\psi$-transform" column: *"(typically not given)"*.

**Defect.** This is dismissive and not quite right — BJM and Reid–Williamson *do* give lower bounds on excess risk in some specialisations, just not in a form parallel to our $\varphi^{-1}\circ\bar\varphi$. The phrasing should be more precise.

*Disposition.* Replace with: *"(no analogue: the $\psi$-transform parametrises predictors, not partitions; predictor lower-bound problems are governed by Vapnik-style risk decompositions instead)"*.

### [Minor] m-4 — §7 should quote the actual theorem count for the satellite's claims

Draft §7 opening: *"axiom-clean (the only axioms consumed are `propext`, `Classical.choice`, `Quot.sound`, the three standard axioms of dependent type theory)"*. **OK.** But the manuscript does not quote a theorem count for the *satellite's* claims; it leaves the reader to infer.

*Disposition.* After the opening paragraph, append: *"For the present satellite, the relevant Lean kernel comprises seven theorems and one structure — `NormalizedScore`, `tent_normalized`, `two_eta_le_of_normalized`, `cPhi_eq_half_of_normalized`, `barPhi_refinement_le`, `theorem1_easy`, `theorem1_hard`, `theorem1`, `bracket_lower`, `bracket_upper` — all axiom-clean."*

### [Minor] m-5 — §5.1 should note that the worked-example partition is realizable

Draft §5.1 opens with the partition $(p_1, p_2, \eta_1, \eta_2) = (\tfrac12, \tfrac12, \tfrac14, \tfrac34)$. A pedantic reviewer will ask: is this partition realizable on some atomless space? Trivially yes — take $\mathcal X = [0,1]$ with Lebesgue measure, $S_1 = [0, \tfrac12]$, $S_2 = [\tfrac12, 1]$, and $f(x) = \mathbb 1_{[0, 1/8] \cup [1/2, 7/8]}(x)$ — but the manuscript should note this in one line so the reader doesn't trip.

*Disposition.* Insert at the start of §5.1: *"(The partition is realizable on any atomless space — e.g., $\mathcal X = [0,1]$ with Lebesgue measure, $S_1 = [0,\tfrac12], S_2 = [\tfrac12,1]$, $f = \mathbb 1_{[0,1/8]\cup[1/2,7/8]}$ — so the example is well-defined.)"*

### [Strategic] S-1 — title is wordy

Current title: *"A bracket for the partition-restricted Bayes risk: refinement-lattice calibration via normalized concave scores."* Thirteen words. SPL titles cluster at 5–10 words.

*Disposition.* Drop the subtitle. Final title: *"A bracket for the partition-restricted Bayes risk."* The subtitle's content ("refinement-lattice calibration via normalized concave scores") is recoverable from the first sentence of the abstract; the punchier title is more SPL-conventional.

### [Strategic] S-2 — section ordering inverts the logical dependency

The manuscript reads §3 (chord lemma) → §4 (Theorem 1, characterising the class) → §5 (the bracket, using Theorem 1's class). This ordering is unusual because the bracket of §5 *uses* the concavity hypothesis on $\varphi$, while Theorem 1 of §4 *characterises* the concave class — so §4 logically *follows* §5 in the sense that it justifies the class used in §5. The manuscript could be re-ordered §3 → §5 (the bracket, assuming concavity) → §4 (characterising the class). Two readings are possible:

- *Current ordering* (§3 → §4 → §5): introduces the characterisation before its use. Pedagogically clean for a reader who wants to know "what scoring functionals are admissible" before seeing "what they buy us."
- *Re-ordered* (§3 → §5 → §4): puts the punchline (the bracket) before the characterisation, à la "here is the bracket; here is the class within which it holds."

*Disposition.* No mandatory change. The current ordering is defensible; I flag it because some referees will prefer the reverse, and the response should pre-empt the question by stating *why* the current ordering. Suggest: at the end of §1.2 (road map), add the sentence *"We assemble the class characterisation before the bracket because the bracket's class hypotheses (clauses (1)–(6) of §2.3, of which concavity is the load-bearing one) are themselves *justified* by Theorem 1 of §4 — refinement-monotonicity over the partition lattice forces precisely the concave-symmetric scoring functionals."*

---

## 3. Positives (worth preserving as-is)

### [Positive] P-1 — §6.2 axes-table is the right visual for the resolution-vs-optimization-axis distinction

The two-by-five table in §6.2 — *predictor vs. partition*, *excess vs. absolute*, *loss-dependent vs. uniform upper instrument*, lower-instrument presence, specialisation to $\varphi = T$, atomless-hypothesis — articulates the distinction at the right granularity for an SPL reader who has seen BJM but not the partition-restricted setup. Keep this prominent. (Subject to m-3's wording fix to one cell.)

### [Positive] P-2 — Corollary 1 forward-references the binary single-cell-pinning satellite [O4] cleanly

The Corollary 1 closing parenthetical — *"(Corollary 1 is the binary single-cell-pinning argument; the standalone treatment that names this technique and exhibits the binary uniqueness is in the companion satellite [O4] in the publication plan [`../../21-publication_plan.md`](../../21-publication_plan.md) §4.)"* — does the right thing: credits the technique, names it, and forward-points to the standalone treatment without claiming the technique as a contribution of this satellite. **This is exactly the cross-satellite hygiene the seeding strategy requires.**

### [Positive] P-3 — §5.1 worked example concretely shows the slack mechanism

After M-1's fixes, the worked example will exhibit four normalized scores on a single partition with concrete numerical brackets, demonstrating the universal upper constant $\tfrac12$ and the smooth-vs-tent slack mechanism in one display. **This is the right pedagogical anchor** for an SPL audience and should be expanded if room permits in §5.

### [Positive] P-4 — abstract is prose-first and ends with the bracket display

Per the lesson from sibling [`../o3-chord-substitution/02-judge-pi-audit.md`](../o3-chord-substitution/02-judge-pi-audit.md) S-2 (formula-first openings lose the casual table-of-contents reader). This satellite's abstract opens with prose and reserves the bracket display for the abstract's middle, which is the right balance for SPL.

---

## 4. Per-section summary

| Section | Status | Findings |
|---|---|---|
| Title | trim | S-1 |
| Abstract | keep | (P-4) |
| §1 Introduction | revise (road map) | S-2 |
| §2 Preliminaries | revise (re-order clause-(6) motivation) | m-2 |
| §3 Chord lemma | keep | — |
| §4 Theorem 1 | revise (one line of clarification) | M-4 |
| §5 Bracket + worked example | revise (table cell + units parenthetical + realizability note + inverse-citation) | M-1, m-1, m-5 |
| §6 Prior art | revise (one cell) | m-3 |
| §7 Mechanization | revise (split realizability claims; add theorem count) | M-2, m-4 |
| References | revise (trim or invoke) | M-3 |

---

## 5. Closure round (Round 3) — owner: Executor T

| # | Owner | Action | Deliverable |
|---|---|---|---|
| M-1 | T | Rewrite §5.1 variance lower-bound cell to "$0.25$"; rewrite entropy/variance parenthetical in bit-units; add Cover–Thomas (or equivalent) cite | §5.1 prose + table |
| M-2 | T | Split §7 second paragraph into (a) pointwise/Jensen theorems with no realizability and (b) converse-of-Theorem-1 + Corollary-1 with their specific typeclasses | §7 prose |
| M-3 | T | Option A: invoke [2], [5], [8], [23] in body; drop [7], [13], [15], [24] | §2, §5, §6, references |
| M-4 | T | Insert clarification on the joint $(\Pi, f)$ quantifier into §4 converse-direction proof | §4 prose |
| m-1 | T | Add Bauschke–Combettes [2] / Roberts–Varberg [20] cite for inverse-of-concave-increasing-is-convex | §5 prose |
| m-2 | T | Move strict-monotonicity motivation up to immediately after clause-(6) enumeration | §2.3 prose |
| m-3 | T | Rewrite "(typically not given)" cell to "(no analogue: $\psi$-transform parametrises predictors not partitions; predictor lower bounds are Vapnik-style)" | §6.2 table |
| m-4 | T | Add §7 paragraph with the explicit theorem count and the per-claim listing of Lean kernel symbols | §7 prose |
| m-5 | T | Insert realizability one-liner at the start of §5.1 | §5.1 prose |
| S-1 | T | Drop subtitle from title | title |
| S-2 | T | Add one sentence to §1.2 explaining the §3 → §4 → §5 ordering | §1.2 prose |

All eleven close in one revision pass. Closure draft deliverable: `03-draft0.1-manuscript.md` (queued).

---

## 6. Hand-off to Round 4 (Judge S)

Judge S's mandate in Round 4 is the **load-bearing prior-art audit** for this satellite, and the gating concern for SPL submission. Specific tasks:

**Task S-1 — Page-by-page verification of Reid–Williamson 2011 [19].** The §6.2 axes-table claims the BJM / Reid–Williamson framework parametrises *predictors* at fixed *experiment*, whereas our bracket parametrises *partitions* at fixed *loss*. Verify this distinction holds on a page-by-page reading of:

- **Reid–Williamson [19, §3]** — proper losses, scoring rules, partial losses. Check whether §3 develops anything resembling a partition-functional bracket on the partition lattice; the expectation is no, but the satellite should pre-empt the question by citing the specific §3 results that *do* parametrise the experiment (e.g., Reid–Williamson's notion of "binary experiment" is a single distribution, not a partition family).
- **Reid–Williamson [19, §4]** — calibration of binary losses. Same audit dimension.
- **Reid–Williamson [19, §6]** — *class probability estimation*. This is the section most likely to overlap. The satellite's §6.2 should cite specifically what §6 of [19] does and what it does not do with respect to the resolution-lattice axis.

A successful S-1 outcome produces one or two specific page-cites to Reid–Williamson that the satellite's §6.2 invokes; a null S-1 outcome (Reid–Williamson genuinely has nothing parallel to our bracket) means the §6.2 framing can be tightened.

**Task S-2 — Le Cam / Torgersen literature for the Theorem 1 converse direction.** Check:

- **Blackwell [3]** — primary reference for the forward direction. Verify that the converse direction (binary-split monotone ⟹ concave) is *not* explicitly stated.
- **Le Cam [16] *Asymptotic Methods*** — particularly Chapter 1 and Chapter 2 (deficiency theory). Same audit.
- **Le Cam and Yang [17]** — same audit.
- **Torgersen [25] *Comparison of Statistical Experiments*** — Chapter 1 (Blackwell ordering) and Chapter 2 (Le Cam deficiency).
- **Goel–DeGroot [9]** — comparison of experiments and information measures.

A successful S-2 outcome confirms the Theorem 1 converse direction is novel in the form stated, and identifies which existing references state the *closest precedent* (the manuscript should cite those precedents in §6.1).

**Task S-3 — BJM / Zhang derivation chase.** Specifically check BJM [1] Theorem 1's proof for whether the $\psi$-transform's convexification step is dual to our Theorem 3 lower-endpoint Jensen step. The expected answer is yes, formally, but on the dual axis; the manuscript's §6.2 should articulate this duality in one explicit sentence.

**Task S-4 — Buja–Stuetzle–Shen [5] / Steinwart [23] coverage.** Verify these references' content matches the §2 and §6 invocations after the M-3 closure. (These are the references being added to the body.)

**Task S-5 — Sierpiński [22] citation correctness.** Verify the bibliographic detail (year 1922, journal Fund. Math., volume 3, pages 240–246) and the relevance of Sierpiński's theorem on additive set functions to the atomless realizability typeclass.

A successful Round 4 outcome produces a 5–10 page Judge S audit memo that either (a) signs off prior art as audited and clean, or (b) identifies specific precedents the satellite must cite and the corresponding rewording of §6 / §6.1 / §6.2. The Judge S audit memo lands at [`04-judge-s-prior-art-audit.md`](04-judge-s-prior-art-audit.md).

---

## 7. Sign-off

**Judge π.** *Conditional pass.* The mathematics is correct end-to-end. Theorem 1's converse direction is the novel piece (subject to Judge S's Round-4 verification that it is not implicit in Blackwell / Le Cam / Torgersen); the universal $c_\varphi = \tfrac12$ is a clean uniformity statement once the chord lemma is articulated; the two-sided bracket assembles cleanly from the two halves. The §6 prior-art positioning makes the right distinctions; M-3's bibliography hygiene and M-2's mechanization-narrative split are the two material clean-ups beyond the one arithmetic / units defect of M-1 and the one quantifier-clarification of M-4. No further mathematical work is required of Executor T to reach the SPL submission bar after the Round 4 prior-art audit closes; the closure pass for the eleven items in §5 above is ~2 hours of revision.

The satellite is **on track** for submission to *Statistics & Probability Letters* with arXiv-first deposit at the moment of submission, with the same Round 0 → Round 5 cadence as the sibling [`../o3-chord-substitution/`](../o3-chord-substitution/README.md).
