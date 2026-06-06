# Phase C — Judge π rigor + wide-mathematician-audience audit of Draft 0.2

*Audit conducted 2026-06-06 by Judge π against [`05-draft0.2-manuscript.md`](05-draft0.2-manuscript.md), using the audit dimensions set by [`06-cras-strategy.md`](06-cras-strategy.md) §3 Phase C and informed by the CRAS editorial direction in [`07-cras-format-reconnaissance.md`](07-cras-format-reconnaissance.md) §1.*

---

## 0. Headline

**CONDITIONAL PASS — close in one cycle.** The mathematics is unchanged from the post-Round-2 / post-Round-4 verdict: bulletproof. The wide-mathematician-audience standard surfaces seven new defects: three **[Material]** (M-a hand-off of Hamel basis as "the construction" is opaque for a non-analyst; M-b §5.2 calibration-theory pivot reads only for someone who already knows the BJM literature; M-c the dictionary's right-most column "**no** — same" is correct but the reader's first encounter with the deflation needs more scaffolding), and four **[Minor]** copy/style edits. Two **[Strategic]** issues (S-a in-text references to "Round 7", "Phase D", "[El2]" that won't make sense for a CRAS reader; S-b CRAS Mathématique uses Roman section numbers, current draft uses Arabic). All nine close in Phase D Draft 0.3.

---

## 1. Per-dimension verdict

### RIGOR-1 — Every notation introduced before use

| Notation | Introduced where in Draft 0.2 | Used where (first) | Verdict |
|---|---|---|---|
| $I$ (real interval) | §1 first sentence | §1 first sentence | **PASS** |
| $M > 0$ | §2 statement of Theorem 1 | §2 | **PASS** |
| $G : [0, M] \to \mathbb R$ | §2 statement of Theorem 1 | §1 (as the unknown of $(\star)$) | **MARGINAL** — $G$ appears in $(\star)$ before §2 fixes its codomain. A wide-mathematics audience needs the codomain $\mathbb R$ stated when $G$ is first introduced (§1, first occurrence of $(\star)$). |
| $(\star)$, $(J_2)$, $(J_{\mathbb Q})$ | §1 paragraphs 1, 2, 3 | throughout | **PASS** |
| $f(x) := G(x) - G(0)$ | §1 paragraph 2 | §1 paragraph 3 | **PASS** — the local convention |
| $\mathbb Q$-linear, $\mathbb R$-linear | §3 closing paragraphs | §4.3 (Proposition 4 construction) | **PASS** but see RIGOR-3 |
| Hamel basis $H$ | §3 closing prose (mentioned), §4.3 (construction) | §1 paragraph 2 ("classical pathological-solution apparatus") | **FAIL** — first mention of "Hamel-basis pathology" in §1 §3 is unsupported by a definition. See [Material] M-a below. |
| $\eta$, $\varphi_{\max}$, "cell-conditional score" | §5.1 (forward reference to main paper) | §5.1 | **FAIL** — these are main-paper-specific notations imported without local definition. See [Material] M-b below. |
| BJM / $\psi$-transform / Reid–Williamson | §5.2 paragraph 2 | §5.2 paragraph 2 | **FAIL** — these are calibration-theory references unfamiliar to a topologist / number theorist / probabilist. See [Material] M-b below. |

### RIGOR-2 — "Affine" defined explicitly

The draft uses "affine" four times before the conclusion of Theorem 1 explicitly writes out $G(v) = av + b$:

- §1 paragraph 2: *"affineness follows from $(J_2)$"* — used but undefined.
- §1 paragraph 3: *"affine"* — same.
- §1 last paragraph: *"$G$ is affine on $[0, M]$"* — same.
- §1 last paragraph: *"$G(v) = av + b$"* — first instance where the definition is *implicit* in the formula.

**Verdict:** **MARGINAL.** For a wide-mathematician audience (e.g., a topologist), "affine" should be defined on first use, even by parenthetical: *"$G$ is affine — meaning of the form $G(v) = av + b$ for some $a, b \in \mathbb R$ — …"*. See [Minor] m-a below.

### RIGOR-3 — The Hamel-basis pathology is tangible

§4.3 Proposition 4's construction reads: *"Choose a Hamel basis $H$ of $\mathbb R$ over $\mathbb Q$ containing 1. Define a $\mathbb Q$-linear $\ell:\mathbb R \to \mathbb R$ by $\ell(1) = 0$ and $\ell(h) = 1$ for some basis element $h \ne 1$ (and arbitrarily on the remaining basis elements). Then $\ell$ is additive and $\mathbb Q$-homogeneous on $\mathbb R$ (so satisfies Cauchy's equation)…"*

For a functional-equations specialist this is impeccable. For a wide-mathematician audience, three things need to be made explicit:

1. *What a Hamel basis is.* A one-clause reminder: *"a $\mathbb Q$-vector-space basis of $\mathbb R$ — existence is by the axiom of choice"*.
2. *Why a $\mathbb Q$-linear $\ell$ satisfies Cauchy.* The link from "$\mathbb Q$-linear" (a property of $\ell$ on $\mathbb R$ as a $\mathbb Q$-vector space) to "$\ell$ satisfies Cauchy's equation $\ell(x+y) = \ell(x) + \ell(y)$" (a property of $\ell$ as a function on $\mathbb R$) is one line that the draft elides.
3. *That the conclusion (the restriction $G$ is not affine) is visible.* Current prose: *"$G$ takes a nonzero value at $h - n$ for some integer $n$ such that $h - n \in [0, 1]$."* For a reader following along this is correct but takes a second pass — make the choice of $n$ explicit: $n = \lfloor h \rfloor$ if $h > 0$, hence $h - n \in [0, 1)$ and $G(h - n) = \ell(h - n) = \ell(h) - n \ell(1) = 1 - 0 = 1 \ne 0$ — versus an affine restriction $G(v) = av + b$ with $b = G(0) = \ell(0) = 0$ would need to satisfy $G(q) = aq$ for every rational $q$ but $G(q) = \ell(q) = q \cdot \ell(1) = 0$, so $a = 0$ and $G \equiv 0$ on $\mathbb Q \cap [0, 1]$, contradicting $G(h - n) = 1$.

See [Material] M-a below.

### RIGOR-4 — Each regularity hypothesis in Table 1 glossed

Table 1's left column lists six hypotheses by name only. A specialist knows what "boundedness on a set of positive measure" means and what its precedent is; a topologist or a combinatorist may not. The table should carry a *terse* one-line gloss in a third column, or use footnotes for the less-elementary entries.

**Verdict:** **MARGINAL.** Suggested fix: add a third column "*one-sentence definition*" to Table 1, even if it makes the table wider:
- Continuity on $I$: $G$ is continuous at every $v \in I$.
- Measurability on $I$: $G$ is Lebesgue-measurable (or Borel-measurable; either suffices).
- Monotonicity on $I$: $G$ is non-decreasing or non-increasing on $I$.
- Boundedness on a set of positive measure: there exists a Lebesgue-measurable set $E \subseteq I$ with $|E| > 0$ on which $G$ is bounded.
- Boundedness on $I$: $G$ is bounded on the whole interval $I$.
- None: no regularity hypothesis at all.

This costs one column-width and lands the table for any reader. See [Material] M-c below.

### RIGOR-5 — §5.2 calibration-theory pivot reads for a non-specialist

Current §5.2 paragraph 2 reads: *"The standard surrogate-calibration literature — BJM [B1], Tewari–Bartlett [B2], Steinwart [B3], Reid–Williamson [B4, B5] — derives its calibration results via convex analysis (biconjugates, $\psi$-transforms, Fenchel duality, supporting hyperplanes) rather than via functional-equation forcing, and consequently does not run into $(\star)$ at all: those derivations track Jensen as an inequality with explicitly-controlled slack, never as a saturated equation."*

For a topologist / number theorist this reads: *"the standard X literature — refs — does Y, not Z, and consequently doesn't run into our equation."* — without ever defining what Y is, what Z is, what the question is.

**Verdict:** **FAIL.** The §5.2 pivot needs to be intelligible *without* the reader already knowing what "surrogate calibration" is. Suggested re-frame: lead with the *structural observation* (the two-line sentence already at the top of §5.2), then say *"this equation never previously surfaced in the surrogate-calibration literature [cite BJM, Tewari–Bartlett, Steinwart, Reid–Williamson] because that literature's standard derivation route uses convex analysis (Fenchel duality, biconjugates) which keeps Jensen as an inequality with explicit slack; the resolution-axis derivation in [El2] pushes Jensen to equality and thereby produces $(\star)$ directly."* See [Material] M-b below.

### RIGOR-6 — MSC2020 correctness

Current: 39B22 (functional equations on real intervals), 39B05 (general functional equations), 26A51 (convexity of real functions in one variable).

- **39B22** ✓ — exactly the right primary classification.
- **39B05** ✓ — appropriate secondary (the general theory of functional equations is invoked via Hamel/Cauchy/Sierpiński).
- **26A51** ⚠ — *"convexity of real functions in one variable"*. The note treats Jensen's equation as a functional equation, not as a result about convex functions per se. **More appropriate alternative:** **26A30** (*Singular functions, Cantor functions, functions with other special properties*) — covers the Hamel-basis pathological functions. **Even better:** **26A99** (*Functions of a real variable, none of the above*) as a generic catch-all. **Best alternative:** **39A30** (*Stability of functional equations*) — *"Hyers–Ulam stability"* of $(\star)$ is exactly the question of whether near-solutions are close to affine, which is the content of the dictionary.

**Recommendation:** Replace 26A51 with **26A03** *(Foundations: limits and generalizations, elementary topology of the line)* if a "definitely correct" entry is needed, OR drop the third entry and use only 39B22 + 39B05 (mathematics articles routinely have just two MSC codes).

See [Minor] m-d below.

### STYLE-1 — CRAS-Mathématique register

The current prose has a *teaching-note* register: it explains, it apologizes for over-engineering, it invites the reader to extend a catalog. This is appropriate for *Expositiones Mathematicae* but slightly *too* warm for CRAS Mathématique, which favors declarative compactness even for the more accessible category-2 articles.

**Verdict:** **MARGINAL.** Suggested fix: tighten the §1 introduction (remove the "we will" / "we invite" softeners), keep the warmth in §5 (where it belongs).

### STYLE-2 — No undefined acronyms; no in-jokes

Current draft contains:

- *"[El1, El2]"* — placeholder citations to a not-yet-published main paper. A CRAS reader doesn't know what this is; *Manuscript in preparation* is acceptable, but the references must read as standard `[Author]. Manuscript in preparation, 2026.` not as the codenames `[El1]` / `[El2]` (which leak the development-time naming).
- *"Phase D mechanization (Lean 4)"* — references a private development concept (Phase D). For CRAS this should read: *"In our Lean 4 formalization of [El2], the lemma `affine_of_jensen_eq` was initially declared with a boundedness hypothesis, in deference to the Cauchy/Hamel literature; the proof body then exhibited that the hypothesis was unused, by the chord substitution."* — same content, without the in-house Phase-D vocabulary.
- *"Round 7"* — does not appear in Draft 0.2 (good).

See [Strategic] S-a below.

### STYLE-3 — §5 intelligible without prior knowledge of [El1, El2]

Current §5.1 paragraph 1: *"In a recent line of work on the achievable error floor of partition-based classifiers [El1, El2], the equation $(\star)$ arises in the rigidity proof for the Bayes risk: for $G:[0,\varphi_{\max}]\to\mathbb R$ defined as the unique function expressing the Bayes risk as a function of an aggregated score, …"*

For a CRAS reader who has not seen [El2] this is opaque: *"recent line of work"* — what line? *"the achievable error floor of partition-based classifiers"* — partition of what, by whom? *"the Bayes risk"* — the Bayes risk of what classifier? *"an aggregated score"* — what scoring rule, aggregated how? *"$\varphi_{\max}$"* — what is $\varphi$?

The §5.1 paragraph either needs to either (a) define enough of the setting that the recurrence is intelligible (~5 extra lines), or (b) be radically compressed to: *"In recent work on the error floor of partition-based classifiers [El2], the equation $(\star)$ arises with $G$ the function expressing the partition Bayes risk via an aggregated concave score $\bar\varphi$, $u_1, u_2$ the per-cell score values, and $p$ the cell mass — which ranges freely over $[0, 1]$ on an atomless underlying probability space, forcing $(\star)$ in full."* Option (b) is the right choice for CRAS — see [Material] M-b below.

---

## 2. Findings (line-cited, severity-tagged, in priority order)

### [Material] M-a — Hamel basis needs a one-clause definition before §3's first mention

**Defect.** §1 paragraph 2 references *"Hamel-basis pathology"* with no prior definition. §3 paragraph 6 references *"a Hamel-basis pathological solution $G$ of Cauchy's equation on $\mathbb R$"* with no definition. §4.3 Proposition 4 finally defines a Hamel basis implicitly in the construction. A wide-mathematician reader without functional-equations background is left guessing for two pages.

**Disposition.** In §1, at the first mention, insert a one-clause parenthetical: *"…admits non-affine solutions constructed via a Hamel basis [9, 14, 17] (i.e., a $\mathbb Q$-vector-space basis of $\mathbb R$, whose existence requires the axiom of choice)."*. Then §3 and §4.3 can read with full force without slowing the reader.

Additionally in §4.3 Proposition 4: spell out the witness explicitly. Current: *"$G$ takes a nonzero value at $h - n$ for some integer $n$ such that $h - n \in [0, 1]$"*. Suggested: *"With $n := \lfloor h \rfloor$ if $h > 1$ (and $n := 0$ if $h \in (0, 1)$), the point $\tilde h := h - n \in [0, 1)$ satisfies $G(\tilde h) = \ell(\tilde h) = \ell(h) - n \ell(1) = 1 - 0 = 1$. Any affine $A : [0,1] \to \mathbb R$ with $A(0) = G(0) = 0$ and $A(q) = G(q) = 0$ for every rational $q \in [0,1]$ (since $\ell$ kills $\mathbb Q$) is forced to be $A \equiv 0$ — contradicting $G(\tilde h) = 1$. Hence $G$ is not affine."*

### [Material] M-b — §5 forward-references to the main paper need radical compression for a CRAS reader

**Defect.** Current §5.1 paragraph 1 imports five main-paper-specific notations ($\eta$, $\varphi_{\max}$, "partition-based classifier", "Bayes risk", "aggregated score") with no local definition. §5.2 paragraph 2 imports four calibration-theory references (BJM, Tewari–Bartlett, Steinwart, Reid–Williamson) with no context.

**Disposition.** Rewrite §5.1 + §5.2 in CRAS-compressed form:

> "**5.1 A recurrence: surrogate calibration on the resolution axis.** In recent work [El1, El2], the equation $(\star)$ arises with $G$ the function expressing the partition Bayes risk of a measurable classifier in terms of a concave score functional aggregated over partition cells; $u_1, u_2$ are the per-cell score values and $p$ is the cell mass, which ranges freely over $[0, 1]$ on an atomless underlying probability space, so that $(\star)$ holds in full. In the Lean 4 formalization of [El2], the corresponding lemma was first declared with a boundedness hypothesis in its signature, in deference to the Cauchy/Hamel literature; the proof body then exhibited that the hypothesis was unused, by exactly the chord substitution of Theorem 1.
>
> **5.2 Structural source.** The recurrence is predictable. Whenever a calibration-theory argument arrives at an identity of the form $\mathbb E[g(\xi)] = g(\mathbb E[\xi])$ for a class of random variables $\xi$ wide enough that the marginal $\mathbb E[\xi]$ can be any point of $I$ and the support of $\xi$ can be any two-point subset of $I$ with any pair of masses $(p, 1-p)$ with $p \in [0, 1]$, the identity is $(\star)$ with $g = G$, $\xi$ supported on $\{u_1, u_2\}$. Such an identity arises whenever Jensen's inequality is pushed to saturation. The standard surrogate-calibration literature — Bartlett–Jordan–McAuliffe [B1], Tewari–Bartlett [B2], Steinwart [B3], Reid–Williamson [B4, B5] — derives its calibration results via convex analysis (biconjugates, Fenchel duality, supporting hyperplanes), which keeps Jensen as an inequality with explicitly-controlled slack and consequently never produces $(\star)$ as an equation; the resolution-axis derivation in [El2] pushes Jensen to equality directly and thereby produces $(\star)$. The chord substitution closes the resulting equation in one line.
>
> **5.3 Adjacent settings.** Two adjacent settings where structurally similar equations arise and the chord substitution is the natural closure: expected-utility representation theorems (von Neumann–Morgenstern linearity over lotteries; the classical Herstein–Milnor axiomatization closes the equation via the Archimedean axiom, but the chord substitution is the natural alternative); and Shannon entropy's axiomatic characterization (Khinchin–Faddeev recursivity; intermediate steps reduce to continuous-coefficient Jensen-type identities, treated correctly in the standard references but occasionally over-regulated in applied downstream work).
>
> **5.4 An invitation to extend.** We invite readers who have encountered $(\star)$ in their own work and have invoked a vestigial regularity hypothesis to extend the catalog."

This is shorter, denser, and reads for a non-specialist.

### [Material] M-c — Table 1 needs the third "definition" column for the wide-mathematician reader

**Defect.** Table 1's left column ("Hypothesis on $G$") lists hypotheses by name only. A reader unfamiliar with the analysis literature reads "boundedness on a set of positive measure" without parsing it.

**Disposition.** Insert a third column "*one-sentence definition*" before the second column. The table becomes wider; either rotate landscape in LaTeX or break into two paired sub-tables. Recommended: one wider table with three columns, optionally landscape-oriented in the LaTeX render.

The new column content is verbatim from the RIGOR-4 verdict above.

### [Minor] m-a — Define "affine" on first use

**Defect.** §1 first uses "affine" without definition; §1 third paragraph uses *"$\mathbb R$-linear"* without definition; §2 statement of Theorem 1 finally writes the affine form $G(v) = av + b$.

**Disposition.** §1 last paragraph: *"Then $G$ is affine on $[0, M]$ — i.e., $G(v) = av + b$ for some $a, b \in \mathbb R$ — :"*. Use the same parenthetical pattern at the first occurrence of *"affineness"* (§1 paragraph 2).

### [Minor] m-b — §2 Corollary 2 list of regularity consequences could be sharper

**Defect.** Current: *"$G$ is continuous and weakly monotone on $[0,M]$; in particular it is locally Lipschitz, absolutely continuous, and measurable."* Five properties listed, with one ("weakly monotone") qualified.

**Disposition.** Simplify: *"$G$ is in particular continuous, monotone, locally Lipschitz, absolutely continuous, and measurable on $[0, M]$."* "Monotone" without "weakly" is standard usage for affine functions (slope can be zero); the qualification is fussy.

### [Minor] m-c — §4.2 (convex domains remark) over-cites

**Defect.** *"…lifts chord-affineness to convex-combination linearity on $C$, hence to an affine form $G(x) = a(x) + b$ for a linear $a$ on $\mathrm{span}(C-C)$ and a constant $b \in \mathbb R$. The structurally essential 1D step is Theorem 1."* — single reference to Aczél–Dhombres [2, Ch. 13] is fine.

**Disposition.** **No change** — the over-citation worry is mine; on re-read this is appropriately tight.

### [Minor] m-d — MSC2020 third code

**Defect.** Current 26A51 (convexity of real functions in one variable) is not quite the right hook; the note is about a functional equation, not about convex functions.

**Disposition.** Either drop the third code (two MSC codes are standard for short notes) or replace with **26A03** (Foundations: limits and generalizations, elementary topology of the real line) — which captures the regularity-properties dictionary in §3. Recommendation: keep 39B22 and 39B05 only.

### [Strategic] S-a — In-text placeholder names ([El1], [El2], "Phase D")

**Defect.** The names `[El1]`, `[El2]`, and "Phase D" are project-internal nomenclature, not appropriate for a CRAS submission.

**Disposition.** In LaTeX manuscript (Phase I), `[El1]` and `[El2]` resolve to the actual author surname + year (or "Manuscript in preparation" placeholder). "Phase D" gets replaced with "the Lean 4 formalization in [El2]" or "the formalization phase that closed simplex rigidity" — the latter is too detailed for CRAS; first is cleaner. The Markdown draft 0.3 can flag these with `[AUTHOR]` placeholders.

### [Strategic] S-b — Section numbering: Roman not Arabic

**Defect.** CRAS Mathématique mandates top-level sections numbered in Roman numerals: §I, §II, §III, …, with sub-sections in decimal (1.1, 1.1.1). Draft 0.2 uses §1, §2, §3, §4, §5.

**Disposition.** Conversion happens automatically in LaTeX (`\section{}` numbering controlled by `crmath` class). Markdown draft 0.3 can keep §1, §2 if it improves Markdown readability, with a footnote that conversion is automatic; or pre-emptively use §I, §II, …. Recommended: pre-emptively use Roman numerals in Markdown draft 0.3 to make the en/fr/LaTeX trio consistent.

---

## 3. Positives (preserve as-is in Draft 0.3)

### [Positive] P-1 — The abstract is the right length and the right shape

The Draft 0.2 abstract is ~150 words, well under the CRAS 250-word ceiling. Opens with prose, lands the result with the explicit formula, articulates the contribution (the dictionary), and signals the §5 framing. **Keep as-is**.

### [Positive] P-2 — The dictionary table is the right visual

Even after the M-c expansion to three columns, the table remains the right visual: it states the contribution at a glance. **Keep, just expand**.

### [Positive] P-3 — Theorem 1$'$ is preserved

The articulation of the "weakest hypothesis the proof consumes" — at the single configuration $u_1 = M$, $u_2 = 0$, $p \in [0, 1]$ free — is preserved by all the rewrites. This is the genuine value-add of the note over the encyclopedic references [1, 13]. **Keep prominent**.

### [Positive] P-4 — The §3 mechanism prose (the "Hamel pathology lives at irrational $p$" punch line)

The two-paragraph explanation of *why* the chord substitution sidesteps the pathology (the pathology fails at irrational $p$ where $(\star)$'s continuous coefficient does its work) lands. **Keep verbatim** in Draft 0.3.

---

## 4. Per-section summary

| Section | Status | Findings to close in Draft 0.3 |
|---|---|---|
| Abstract | PASS | none |
| §1 Introduction | revise | M-a (Hamel definition), m-a (affine definition) |
| §2 Result | revise | m-b (Corollary 2 sharper), m-a (apply at conclusion of Theorem 1) |
| §3 Dictionary | revise | M-c (three-column table) |
| §4 Variants | revise | M-a (Proposition 4 witness spelled out), m-c (no change) |
| §5 Recurrence | rewrite | M-b (compressed for CRAS reader) |
| References | revise | m-d (MSC code reconsideration), S-a (resolve placeholders in LaTeX) |
| Section numbering | revise | S-b (Roman top-level, decimal sub) |
| Declaration of interests | add | new section per G-7 |
| Acknowledgements | add | optional but recommended |

---

## 5. Closure round (Phase D) — owner: Executor T

| # | Action | Section |
|---|---|---|
| M-a | Hamel basis defined on first mention; Proposition 4 witness spelled out | §1, §4.3 |
| M-b | §5 rewritten to be intelligible without prior knowledge of [El1, El2] | §5 |
| M-c | Table 1 expanded with third "one-sentence definition" column | §3 |
| m-a | "Affine" defined parenthetically on first use | §1, §2 |
| m-b | Corollary 2 simplified | §2 |
| m-d | MSC2020 reduced to 39B22 + 39B05 (drop 26A51) | header |
| S-a | [El1] / [El2] / "Phase D" replaced with neutral phrasings; placeholders in LaTeX | §5, references |
| S-b | Section numbering: Roman top-level (§I…§V) | all |
| G-7 | Declaration of interests added before bibliography | new section |
| G-9 | Confirm MSC + no copyright issues | header + body |

All ten close in one revision pass. Closure draft deliverable: [`09-draft0.3-manuscript.md`](09-draft0.3-manuscript.md).

---

## 6. Sign-off

**Judge π.** *Conditional pass on Draft 0.2 with respect to the CRAS-Mathématique-wide-audience standard.* The mathematics is unchanged from the post-Round-4 verdict. The wide-mathematician adjustments are mostly scaffolding (one-clause definitions, table expansion, compressed §5). Closure in Phase D produces Draft 0.3 ready for French translation (Phase E onwards) and LaTeX harness (Phase I).
