# Round 2 — Judge π adversarial audit of `01-draft0.0-manuscript.md`

*Satellite O3 — "The chord substitution closes the continuous Jensen equation." Audit conducted 2026-06-06 by Judge π in hostile-referee mode against [`01-draft0.0-manuscript.md`](01-draft0.0-manuscript.md). Pattern per [`../../21-publication_plan.md`](../../21-publication_plan.md) §1.2 and consistent with [`../../17-pi_adversarial_audit_of_draft0.6_post_phase_d.md`](../../17-pi_adversarial_audit_of_draft0.6_post_phase_d.md).*

---

## 0. Headline

**CONDITIONAL PASS — close in one cycle.** The mathematics is correct — Theorem 1's chord substitution is bulletproof, Theorem 1$'$ articulates the actual proof-consumption point cleanly, and the contrast with the rational-coefficient version (Proposition 4) is exhibited correctly. Zero **[Critical]** findings. But four **[Material]** defects (M-1 historical/algebraic sloppiness in §1; M-2 muddled prose in §3; M-3 under-articulated Theorem 3 sketch in §4.2; M-4 recurrence catalog rests on a single (self-)citation), four **[Minor]** copy-edits, and two **[Strategic]** presentation issues block the submission to *Comptes Rendus Mathématique*. All ten close in one cycle of revision (≤2 hours of executor work).

---

## 1. Scope of this review

I re-derived Theorem 1, Theorem 1$'$, Theorem 3, Proposition 4, and Corollary 2 from scratch. I checked the dictionary Table 1 against the standard references (Aczél [1], Kuczma [13], Cauchy [4], Hamel [9], Sierpiński [17], Steinhaus [18]). I assessed the literature positioning of the note against the closest precedents in the functional-equations community. I did not (and could not) verify the cited page numbers of the references — that is a copy-editing pass.

I did **not** re-verify the §5.1 description of the main paper's use of the equation, taking it as given that the construct does appear in the main paper at §4.2 Step 2 (this has been verified separately, e.g., by the round-7 π audit and the panel verdict M-2).

---

## 2. Findings (line-cited, severity-tagged)

### [Material] M-1 — §1 paragraph 3 hand-waves the $(J_{\mathbb Q}) \Leftrightarrow (J_2)$ equivalence

Draft §1, third paragraph: *"The rational-coefficient Jensen equation $(J_{\mathbb Q})$ ... adds nothing — it is equivalent to $(J_2)$ by iterated bisection."*

**Defect.** Iterated bisection from $(J_2)$ — i.e., iterating $G((x+y)/2) = (G(x)+G(y))/2$ — only yields convex combinations with *dyadic*-rational coefficients ($p\in\{k/2^n : k,n\in\mathbb N_0,\ 0\le k\le 2^n\}$), not all rational coefficients. To obtain $(J_{\mathbb Q})$ from $(J_2)$ one must also use the additive structure, going through the Cauchy equation $G(x+y) = G(x)+G(y)$ (modulo a constant), and then deduce $\mathbb Q$-homogeneity in the standard way ($G(nx)=nG(x)$ from Cauchy + induction; $G(x/n) = G(x)/n$ from substitution; combine for $G(qx) = qG(x)$ for $q\in\mathbb Q$). The phrase "by iterated bisection" obscures this and a CRAS referee will catch it.

The substantive claim — that $(J_{\mathbb Q})$ and $(J_2)$ have *the same admissible solutions* up to an affine adjustment — is correct. The route to that claim is not "iterated bisection."

*Disposition:* re-write the paragraph. Suggested replacement:

> "The **rational-coefficient** Jensen equation
> $$ p\,G(u_1)+(1-p)\,G(u_2)=G(p\,u_1+(1-p)\,u_2) \qquad (u_1,u_2\in I,\ p\in[0,1]\cap\mathbb Q) \tag{$J_{\mathbb Q}$}$$
> sharpens $(J_2)$ but does not escape its pathology. Setting $f(x) := G(x)-G(0)$, the equation $(J_2)$ is equivalent on a translate of $I$ to Cauchy's additive equation $f(x+y) = f(x)+f(y)$ (cf. Aczél [1, §2.1] or Kuczma [13, Ch. 5]); Cauchy additivity yields $\mathbb Q$-homogeneity $f(qx) = qf(x)$ in the standard way; and $\mathbb Q$-homogeneity returns $(J_{\mathbb Q})$ for $f$ (and for $G$). So $(J_{\mathbb Q}), (J_2),$ and Cauchy's equation share the same solution class up to constants, and all three inherit the Hamel-basis pathology."

### [Material] M-2 — §3 closing prose conflates the coefficient $p$ with the argument $qx$

Draft §3, last two paragraphs before §4: the explanation of *why* Hamel-pathological $G$ violates $(\star)$ at irrational $p$ is correct in essence but the framing slips between "$G$ is $\mathbb Q$-linear" (a property of the *argument*, $G(qx) = qG(x)$) and "$(\star)$ requires the identity at irrational $p$" (a property of the *coefficient*). A careful referee will read this and pause; the two are linked, but the link is not articulated.

*Disposition:* re-write the closing prose of §3 to make the link explicit. Suggested replacement:

> "The mechanism is straightforward. A Hamel-basis pathological solution $G$ of Cauchy's equation on $\mathbb R$ is $\mathbb Q$-linear: $G(0)=0$ and $G(qx) = qG(x)$ for every $q\in\mathbb Q$ and $x\in\mathbb R$. It is, by construction, *not* $\mathbb R$-linear — $G(rx) \ne rG(x)$ for some irrational $r$ and some $x$.
>
> The chord identity $(\star_0)$ at the configuration $u_1=M$, $u_2=0$ reads
> $$ p\,G(M) + (1-p)\,G(0) \;=\; G(pM). $$
> For $G$ a Hamel-pathological additive function this identity is the assertion $p\,G(M) = G(pM)$, which holds at $p\in\mathbb Q$ (by $\mathbb Q$-linearity of $G$) but fails at the irrational $p$ where $\mathbb R$-linearity is broken. The continuous-coefficient equation $(\star)$ thus rules the pathology out at exactly the points $p\in [0,1]\setminus\mathbb Q$ where the discrete-coefficient versions $(J_2)$, $(J_{\mathbb Q})$ are silent. The Hamel pathology lives at irrational $p$ — exactly where $(\star)$'s continuous coefficient closes the door."

### [Material] M-3 — §4.2 Theorem 3 proof sketch is too compressed

Draft §4.2: *"Applying $(\star)$ in a 2D affine span of three points shows additivity of the increments."*

**Defect.** Under-articulated. The leap from "$G$ is affine on every chord" to "$G$ is affine on the convex set $C$" requires either (a) a clean induction on the number of points in a convex combination (yielding convex-combination linearity), and then a standard argument that convex-combination-linear $G$ on a convex set with affine hull $V$ is of the form $G(x) = a(x)+b$ for some linear $a:V\to\mathbb R$ and constant $b$; or (b) a direct application of Aczél–Dhombres [2, Ch. 13] or Rockafellar's *Convex Analysis* §1. The current sketch hand-waves the load-bearing step.

A second concern: Theorem 3 is not invoked by the main paper (which uses Theorem 1 in dimension 1). It is bonus content that, if sloppily done, lowers the note's overall quality bar.

*Disposition (one of two).*

**Option A (recommended for CRAS submission).** Drop Theorem 3 from the body and demote it to a *remark* with a one-line gesture: "The chord substitution extends verbatim to any convex $C \subseteq V$ (a real vector space): apply Theorem 1 along every chord, then a standard inductive argument (cf. Aczél–Dhombres [2, Ch. 13]) yields $G(x) = a(x)+b$ on $C$ for a linear $a$ and constant $b$." This keeps the note short and lets the load-bearing 1D content stand alone.

**Option B (for the *Expositiones Mathematicae* fallback or any longer-form version).** Rewrite Theorem 3 with a clean inductive proof. Probably ~10 extra lines; not appropriate for CRAS's 4–6 page envelope.

Recommend **A** for the CRAS submission.

### [Material] M-4 — §5.1 recurrence catalog rests on $n=1$ (the present author)

Draft §5.1 cites only [El1] and [El2], both by the present author and both "in preparation." A hostile referee — and CRAS gets hostile referees — will write *"the claim that 'the trap recurs in applied work' is supported by a single self-citation; the publication does not earn its standalone status on these grounds."*

This is the largest **non-mathematical** vulnerability in the manuscript. Two mitigations:

**Mitigation (a) — soften §5's framing in Round 3 (this round's closure).** Replace the present opening of §5 ("we collect a small recurrence catalog, biased to our own recent experience") with explicit scoping that does not over-claim:

> "The chord substitution is folklore; the regularity hypotheses it makes vestigial nonetheless reappear in applied work that derives $(\star)$ outside the functional-equations community. We document *one* such recurrence below — in our own work on the achievable error floor of partition-based classifiers — and articulate the *structural source* (§5.2) under which the recurrence is predictable in any sufficiently rich calibration-theory derivation. We invite extensions of the catalog from readers who encounter $(\star)$ in their own work."

**Mitigation (b) — Judge S audit in Round 4.** Assign Judge S (statistics/calibration specialist) to do a targeted literature search for one or two external recurrences. Specific places to check: the surrogate-loss calibration literature (BJM 2006, Tewari–Bartlett 2007, Reid–Williamson 2010), the property-elicitation literature (Lambert–Pennock–Shoham 2008, Gneiting 2011), the comparison-of-experiments literature (Le Cam 1986, Torgersen 1991), and the proper-scoring-rules literature (Savage 1971, Bickel 2007). If any of these papers derives an equation of the form $(\star)$ from a Jensen-equality setup, and invokes a Cauchy-equation-style hypothesis, the citation should land in §5.

*Disposition:* close Mitigation (a) in Round 3 (the closure draft below). Open Mitigation (b) as Judge S's mandate for Round 4.

### [Minor] m-1 — §2 Corollary 2 "monotone" is unqualified

Draft §2 Corollary 2: *"$G$ is continuous, monotone, and (in particular) measurable on $[0,M]$."*

An affine $G$ with slope $a\ge 0$ is non-decreasing; with slope $a\le 0$ is non-increasing; with $a=0$ is constant (both). All three are monotone in the *non-strict* sense. A finicky referee may object that constant functions are "trivially monotone" rather than properly so, and the word as written is ambiguous.

*Disposition:* "$G$ is continuous and weakly monotone on $[0,M]$; in particular measurable, locally Lipschitz, and absolutely continuous." (The added regularity is free and reinforces the dictionary's point.)

### [Minor] m-2 — bibliography contains uncited entries

[2] Aczél–Dhombres (1989) and [14] Ostrowski (1929) are listed but never invoked in the body.

*Disposition:* invoke [2] at the (re-written) §4.2 remark on convex domains (per M-3 disposition Option A); invoke [14] in §1 alongside Sierpiński/Steinhaus on the historical context of measurability/boundedness sufficing for Cauchy. Drop either if it cannot be invoked naturally.

### [Minor] m-3 — §4.3 Proposition 4 uses non-standard "$\mathbb Q$-affine / $\mathbb R$-affine" terminology

The terms are perfectly meaningful but not standard in the functional-equations literature.

*Disposition:* re-phrase: "$\ell$ is $\mathbb Q$-linear (additive and $\mathbb Q$-homogeneous on $\mathbb R$) but not $\mathbb R$-linear; its restriction to $[0,1]$ satisfies $(J_{\mathbb Q})$ on every triple $(x,y,p)\in[0,1]\times[0,1]\times(\mathbb Q\cap[0,1])$ with $px+(1-p)y\in[0,1]$, yet is not affine on $[0,1]$."

### [Minor] m-4 — Table 1 historical attributions need precision

Specifically: "Monotonicity on $I$: yes, suffices (Darboux)" — Darboux [5] (already in the bibliography) is the right paper, but the table cell should cite [5] explicitly rather than relying on attribution by name only. Similarly, "Boundedness on $I$" is attributed to "suffices (special case of Steinhaus)" — preferable to cite Sierpiński [17] alongside Steinhaus [18], since the bounded-measurable equivalence is a Sierpiński observation.

*Disposition:* add bracketed cites to every row of Table 1.

### [Strategic] S-1 — title ambiguity ("closes" can read as "ends" or "concludes")

The current title — *"The chord substitution closes the continuous Jensen equation"* — uses "closes" in the sense of *proves / solves / concludes*. A referee might read it as *terminates / kills off the theory of*. A clarifying subtitle would disambiguate.

*Disposition:* add a subtitle, *"A teaching note on three vestigial regularity hypotheses."* Final form: *"The chord substitution closes the continuous Jensen equation: a teaching note on three vestigial regularity hypotheses."*

### [Strategic] S-2 — abstract opens with a formula

CRAS abstracts traditionally open with prose orienting the reader; formula-first openings work for highly technical notes but lose the casual reader of a CRAS table of contents. The current draft front-loads the equation $pG(u_1)+(1-p)G(u_2)=G(pu_1+(1-p)u_2)$ in the first sentence.

*Disposition:* open with prose, then the formula. Suggested first two sentences:

> "The continuous-coefficient form of the Jensen functional equation on a real interval — the form in which the coefficient varies over the full continuum $[0,1]$ rather than over a single value such as $\tfrac12$ — shares no Hamel-basis pathology with its discrete-coefficient sibling, and is solved in closed form by a one-line chord substitution. Concretely: for $G:[0,M]\to\mathbb R$ satisfying $pG(u_1)+(1-p)G(u_2)=G(pu_1+(1-p)u_2)$ for all $u_1,u_2\in[0,M]$ and all $p\in[0,1]$, $G$ is affine on $[0,M]$ — with no measurability, boundedness, or continuity hypothesis required."

---

## 3. Positives (worth preserving as-is)

### [Positive] P-1 — Theorem 1$'$ is a genuine value-add over Aczél/Kuczma

§4.1 isolates the actual hypothesis the proof consumes — that $(\star)$ holds at the single configuration $u_1=M$, $u_2=0$, free $p\in[0,1]$. Neither Aczél [1] nor Kuczma [13] articulates this; both state the full $(\star)$. The weakening is genuinely useful for an author deriving $(\star_0)$ in a richer setup, who wants to know exactly how much of the equation is being consumed. **Keep this prominent.**

### [Positive] P-2 — Table 1 is the right visual for the dictionary

Compact, immediately readable, articulates the contribution. Keep with the small per-cell-citation upgrades from m-4.

### [Positive] P-3 — the structural source argument in §5.2

The two-sentence claim — *"whenever a calibration-theory argument arrives at an identity of the form $\mathbb E[g(\xi)]=g(\mathbb E[\xi])$ for a class of $\xi$ wide enough that $\mathbb E[\xi]$ ranges over $I$ and $\xi$ can be supported on any two-point subset, the identity is exactly $(\star)$"* — is the philosophical pivot of the note. It explains *why* the trap is predictable to recur, beyond the single instance in §5.1. Keep this prominent and consider promoting one sentence to the abstract.

---

## 4. Per-section summary

| Section | Status | Findings |
|---|---|---|
| Abstract | revise | S-2 |
| §1 Introduction | revise | M-1 |
| §2 Result | revise | m-1 |
| §3 Dictionary | revise | M-2, m-4 |
| §4 Variants | revise | M-3, m-3 |
| §5 Recurrence | revise | M-4 (Mitigation a) |
| References | tidy | m-2 |
| Title | revise | S-1 |

---

## 5. Closure round (Round 3) — owner: Executor T

| # | Owner | Action | Deliverable |
|---|---|---|---|
| M-1 | T | Re-write §1 paragraph 3 ($(J_{\mathbb Q}) \Leftrightarrow (J_2)$ via Cauchy, not via "iterated bisection") | §1 prose |
| M-2 | T | Re-write §3 closing prose (coefficient vs. argument) | §3 prose |
| M-3 | T | Drop Theorem 3, replace with one-paragraph remark + cite Aczél–Dhombres | revised §4.2 |
| M-4 | T | Soften §5 framing per Mitigation (a); flag Judge S for Mitigation (b) in Round 4 | §5 prose |
| m-1 | T | Re-phrase Corollary 2 ("weakly monotone, locally Lipschitz, abs. cont.") | §2 |
| m-2 | T | Invoke [2] in §4.2 remark; invoke or drop [14] | §1, §4.2, references |
| m-3 | T | Re-phrase Proposition 4 ("$\mathbb Q$-linear / $\mathbb R$-linear") | §4.3 |
| m-4 | T | Add per-cell citations to Table 1 | §3 |
| S-1 | T | Add subtitle to title | title |
| S-2 | T | Re-write abstract with prose-first first sentence | abstract |

All ten close in one revision pass. Closure draft deliverable: [`03-draft0.1-manuscript.md`](03-draft0.1-manuscript.md).

---

## 6. Hand-off to Round 4 (Judge S)

Judge S's mandate in Round 4: targeted literature search for at least one external recurrence of the chord-substitution trap, to strengthen the §5.1 catalog. Specific surveys:

- BJM 2006 (Bartlett–Jordan–McAuliffe): consistency of convex risk minimization. Does any step derive a $(\star)$-style equation and invoke a Cauchy-style hypothesis?
- Tewari–Bartlett 2007 / Steinwart 2007 / Reid–Williamson 2010: surrogate-loss / proper-loss calibration. Same question.
- Lambert–Pennock–Shoham 2008 / Gneiting 2011: property elicitation, proper scoring rules.
- Le Cam 1986 / Torgersen 1991: comparison of experiments.

A successful Round 4 outcome adds one external citation to §5.1, retiring M-4 Mitigation (b). A null Round 4 outcome (no external recurrence found in the surveyed literature) is also acceptable, provided the §5.1 framing is appropriately scoped to "we document one recurrence, the present author's; we predict the trap to recur structurally; we invite the community to extend the catalog."

Judge S audit memo deliverable: [`04-judge-s-prior-art-audit.md`](04-judge-s-prior-art-audit.md).

---

## 7. Sign-off

**Judge π.** *Conditional pass.* The mathematics is correct end-to-end. Two mitigations (M-3 Option A and M-4 Mitigation a) reduce the manuscript's surface area and tighten its claims; the remaining edits are copy-level. No further mathematical work is required of Executor T to reach the CRAS submission bar.
