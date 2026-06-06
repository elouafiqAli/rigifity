# Round 2 — Adversarial Audit of [`01-skeleton-draft0.md`](01-skeleton-draft0.md)

*Joint memo by Judge π (process / methodology auditor) and Judge S (statistics referee — calibration literature). Same hostile-referee discipline as the main-paper audits ([`../05-pi_adversarial_audit_of_draft0.md`](../05-pi_adversarial_audit_of_draft0.md), [`../07-pi_adversarial_audit_of_04.md`](../07-pi_adversarial_audit_of_04.md), [`../17-pi_adversarial_audit_of_draft0.6_post_phase_d.md`](../17-pi_adversarial_audit_of_draft0.6_post_phase_d.md)). Findings are severity-tagged ([C] critical / [M] material / [m] minor / [S] strategic), numbered globally, attributed to the issuing judge. The Executor E closure ([`03-closure-draft0.1.md`](03-closure-draft0.1.md)) addresses each finding with an atomic disposition.*

---

## 0. Executive verdict (jointly signed)

The Round 1 skeleton ([`01-skeleton-draft0.md`](01-skeleton-draft0.md)) **is fit-for-purpose with revisions**. The piece achieves what the [pre-flight](00-preflight.md) committed it to — naming the resolution-axis transposition, drawing the perpendicular-axes picture, instantiating the bracket on one worked example, pointing forward to applications without revealing them — and the prose is at magazine register throughout. Neither judge raised a [C] finding.

We do raise **one [M] finding** (jointly), **three [M] findings** (Judge S), **four [m] findings** (split), and **two [S] findings** (Judge E flagged before the audit handed back; both endorsed). The [M] joint finding is the most consequential: the §5 "locally testable" bullet leaks the *content* of Proposition 6 (the two-query identity) rather than only its *existence*. As written, the satellite reveals enough of O5 to permit a salami-slicing objection. Fix is straightforward: replace the mechanism sentence with a pointer.

Beyond that, the audit is what one would expect from a methodology note's first pass: a few sentences that over-claim or under-attribute, two BJM-precision corrections, one Reid–Williamson tightening, one normalization inconsistency in the worked-example table, and a handful of style observations.

The piece does **not** require a second audit round; the closure in Round 3 ([`03-closure-draft0.1.md`](03-closure-draft0.1.md)) is judged sufficient to deliver the manuscript to publication-ready state in [`04-manuscript-final.md`](04-manuscript-final.md). Judge S and Judge π both expect to sign off the closure without further revisions, conditional on the dispositions below being applied as stated.

---

## 1. Findings, in priority order

### 1.1 **[M-1] (Judge π + Judge S, joint) — §5 locally-testable bullet leaks Proposition 6**

The §5 paragraph "Reading aggregator design" and "Reading depth as a refinement order" hold the right discipline — gesture only, no theorem statement. The "Local testability of the bracket" bullet does not:

> *"The mechanism is a single identity: the probability that two uniform same-cell draws disagree on the label equals twice the cell-conditional variance averaged over cells, which sandwiches the bracket. See [Author, Information Processing Letters 2026]."*

This is **Proposition 6 of the main paper (and the headline of satellite O5)**, *stated in informal prose* — the identity $p_{\mathrm{dis}} = 2 \mathbb E[\mathrm{Var}(f \mid \Pi)]$ in English. A determined reader who has only the methodology note can extract O5's central result from this sentence alone. That is exactly the salami-slicing risk [Veto-π-2] of the [pre-flight](00-preflight.md).

**Fix.** Replace the offending sentence with a pure forward pointer. Recommended wording:

> *"The bracket admits an estimator using only $O(\alpha^{-2})$ uniform two-element same-cell label queries, with sample complexity independent of the underlying input space's cardinality. The mechanism — a single-line variance identity that exposes the bracket — is the subject of the companion satellite, [Author, Information Processing Letters 2026]."*

This preserves the *existence claim* and the *sample-complexity headline* (so the reader knows why the result is interesting) while withholding the identity itself.

**Severity.** [M] because as written, the salami-slicing objection a reviewer of O5 could raise — *the result is already in O2* — is *correct on the text*. The fix is one sentence.

**Disposition target.** [`03-closure-draft0.1.md`](03-closure-draft0.1.md) commit #5 (`fix(§5): pure forward pointer for Prop 6 in locally-testable bullet`).

### 1.2 **[M-2] (Judge S) — BJM "one and only one loss" over-claims**

§1 contains the line:

> *"The $\psi$-transform is the identity for one and only one loss — the $0$-$1$ loss itself."*

This is not literally the BJM theorem. The $0$-$1$ loss does give $\psi(t) = t$ on $[0, 1]$, but the *uniqueness* — "one and only one loss" — requires qualifiers (within the class of margin-based proper composite losses, modulo reparameterization, and ruling out trivial / degenerate cases). What BJM 2006 *do* prove is the inequality $\psi(R - R^*) \le R_\varphi - R_\varphi^*$ and the qualitative observation that strictly convex differentiable surrogates yield $\psi$ strictly above the identity near zero.

The natural parallel the methodology note wants to draw — *"on the optimization axis, $\psi$ is the identity for the $0$-$1$ loss; on the resolution axis, the bracket is exact for the tent"* — is correct as an analogy, but the absolutist "one and only one" framing on the optimization side is stronger than what BJM literally state. (It would be defensible after the appropriate qualifiers; better to state it qualitatively.)

**Fix.** Replace the offending sentence with:

> *"The $\psi$-transform is the identity for the $0$-$1$ loss; it is strictly above the identity at zero for any smooth surrogate (Bartlett–Jordan–McAuliffe 2006)."*

The methodology note can keep the parallel — the *Stat. Probab. Lett.* satellite's exactness theorem is the genuine one-and-only-one statement, and it is precisely the resolution-axis sibling of the qualitative BJM observation, which is the only point the methodology note needs.

**Severity.** [M] because the precision matters for the parallel the note is selling. The fix is one sentence.

**Disposition target.** Commit #2 (`fix(§1): tighten BJM uniqueness wording`).

### 1.3 **[M-3] (Judge S) — Reid–Williamson framing over-attributes**

§2 contains the line:

> *"Reid and Williamson (2011) unified the picture: every proper composite loss factors as a weighted integral of cost-weighted Bayes risks, the calibration question is the question of how this weighting interacts with the convexification, and the $\psi$-transform is the level-set gap of a particular Bregman-style functional."*

The first clause (integral representation of proper composite losses) is correctly attributed — this is RW 2011's central machinery. The second clause (calibration as weighting × convexification) is a fair reading. The third clause — *"the $\psi$-transform is the level-set gap of a particular Bregman-style functional"* — is **not** a literal theorem statement from RW 2011; it is an *interpretation* that uses the RW machinery to recast BJM, plausible but not verbatim. A close reader of RW would protest.

**Fix.** Replace the third clause with a wording that does not commit to a specific theorem statement in RW. Recommended:

> *"Reid and Williamson (2011) reorganize the analysis around proper composite losses and weight functions, exposing the convex-analytic structure that links surrogate calibration to $f$-divergence comparison of experiments and to Bregman geometry."*

This attributes the *reorganization* and the *structural connections* (both of which are in RW 2011 explicitly), without claiming a specific identification of the $\psi$-transform as a Bregman level-set gap.

**Severity.** [M] because a calibration-literature reviewer (= the EMS Magazine target audience) will spot the over-attribution and read it as careless.

**Disposition target.** Commit #3 (`fix(§2): soften RW framing to match RW's actual scope`).

### 1.4 **[M-4] (Judge S) — Worked-example table normalizes entropy in bits but should match the prose**

§4's table has entropy values $H(0.3) = 0.881$ and $H(0.5) = 1.000$ in *bits* (log base 2). The §3 definition says "$H(\eta) = -\eta\log_2\eta - (1-\eta)\log_2(1-\eta)$, normalized so $H(\tfrac12) = 1$." Good — log base 2 is the bits convention, $H(\tfrac12) = 1$ bit. **But** the lower endpoint computation $H^{-1}(0.941) = ?$ in the table assumes the same convention; the reader has to verify this. The point is fine but the table caption should make the bits convention explicit, and the prose around the table should refer to "$H$ in bits" once.

Adjacent observation: the **order** of scores in the §3 enumeration (tent, entropy, variance) does not match the §4 table (tent, variance, entropy). Choose one. The table's ordering — tent / variance / entropy in increasing slack — is the more pedagogically useful one; reorder the §3 enumeration to match.

**Fix.**

- In §3, reorder the running-example bullet from (tent, entropy, variance) to (tent, variance, entropy), aligning with the §4 table.
- In §4, add to the caption / preamble: *"(entropy values in bits, log base 2)."*
- Optionally, also state the symmetric $\eta_1 = 0.7$ check: $\min(0.7, 0.3) = 0.3 = \min(0.3, 0.7)$, so the labeling-orientation does not affect the example. (This is over-care; π is fine without it.)

**Severity.** [M] because consistency between prose and table is the kind of thing a working reader will trip on, even at magazine register; uncaught it would distract from the headline.

**Disposition target.** Commit #4 (`fix(§3 + §4): unify running-example order; explicit bits convention on entropy`).

### 1.5 **[m-1] (Judge π) — §1's first sentence is over-engineered**

§1 opens with:

> *"Surrogate calibration (Bartlett–Jordan–McAuliffe 2006, Reid–Williamson 2011) is a body of work that controls the excess risk of a learned predictor in terms of the convexification of the gap between the conditional Bayes risk and the score one is willing to compute."*

Grammatical and accurate, but two-and-a-half lines of subordinate clauses on opening. The EMS Magazine reader who has heard of *neither* BJM nor RW will lose the thread before the first period. **Tighten** to:

> *"Surrogate calibration asks a simple question: given a loss I cannot optimize, what loss can I optimize, and how much does that cost me?"*

This is in fact already the second sentence of §1, in italics. Promote it; demote the BJM/RW framing to the third sentence ("Modern surrogate calibration (Bartlett–Jordan–McAuliffe 2006, Reid–Williamson 2011) answers the question ...").

**Severity.** [m] — stylistic. Magazine prose lives or dies on opening lines.

**Disposition target.** Commit #1 (`fix(§1): promote question-first opening, demote citation framing`).

### 1.6 **[m-2] (Judge π) — "the mathematics was waiting; what is new is the asking"**

The §6 closing sentence:

> *"The mathematics was waiting; what is new is the asking."*

Has aesthetic merit but borders on the rhetorical "this isn't really new, the question is new" trope. A π reader allergic to that trope (= many statisticians) will read it as either coyness or self-aggrandizement, depending on the day. Recommend softening to a more concrete sentence:

> *"The mathematics — concave generalized entropies, Jensen's inequality, the convexification of level-set gaps — was assembled half a century ago. What is new is the question one asks against it: not which loss to optimize, but at which resolution to measure."*

This says the same thing in a paragraph rather than an aphorism. The aphoristic version can survive in conversation; for print, the paragraph is safer.

**Severity.** [m] — pure tone.

**Disposition target.** Commit #6 (`fix(§6): replace aphoristic closing with paragraph-length closing`).

### 1.7 **[m-3] (Judge S) — Bartlett–Jordan–McAuliffe pagination check**

Bibliography lists "*Convexity, classification, and risk bounds.* J. Amer. Statist. Assoc. **101** (2006), 138–156." Verify pagination — recollection is 138–156 but the venue is correct.

**Fix.** Confirm at submission time against the JASA archive (or replace with the standard citation tuple `JASA 101 (2006), pp. 138–156` if accurate).

**Severity.** [m] — bibliography hygiene.

**Disposition target.** Commit #7 (`docs: verify BJM 2006 pagination against JASA archive`).

### 1.8 **[m-4] (Judge π) — Acknowledgements and methodology placeholder needs concrete text by submission**

The Round-1 draft has *"[To be drafted at submission time]"* in the Acknowledgements block. Per the [`pre-flight`](00-preflight.md) Q1 commitment that the satellite stands alone, the Acknowledgements must include the methodology-disclosure paragraph required by [`../21-publication_plan.md`](../21-publication_plan.md) §7 risk-register row "Authorship attribution / coordination of personas." Draft for the manuscript:

> *"Methodology disclosure. The drafting and adversarial-audit cycles that produced this note follow the workflow described in the author's `agents/skills/` package and the companion satellite [Author, CICM 2026]. Reviewer findings, dispositions, and the diff log are maintained as a transparent audit trail; the author thanks two referees and the action editor for ... [filled at decision time]."*

The wording is precise about persona use (no anthropomorphizing) and points at O14 for readers who want the methodology paper itself.

**Severity.** [m] — administrative, but must be addressed before submission.

**Disposition target.** Commit #8 (`docs: draft acknowledgements + methodology disclosure for submission`).

### 1.9 **[S-1] (Judge π) — Salami-slicing footprint is acceptable but documentable**

The piece reproduces the *statement* (not the proof) of the bracket and the *statement* (not the proof) of bracket exactness for the tent, both of which are theorems of the satellite O1 (SPL) and the main paper. This is the minimum needed for the note to be intelligible; further reduction would gut the note. But it is also, technically, duplication.

**Recommendation.** Acknowledge in [`03-closure-draft0.1.md`](03-closure-draft0.1.md) (closure document, not in the manuscript itself) that the duplicated statements are *necessary for intelligibility* and that the proofs live in O1 / the main paper. Add to the arXiv preface a note: *"The bracket of §3 and the exactness theorem mentioned in §3 are proved in the companion paper [O1 arXiv ID]; this methodology note states them for context without re-proving them."*

The duplication is acceptable per editorial norms for an expository / methodology note, but documenting the decision protects against a later "redundant publication" challenge.

**Severity.** [S] — strategic, not a manuscript fix.

**Disposition target.** Acknowledged in [`03-closure-draft0.1.md`](03-closure-draft0.1.md); recorded in [`05-submission-package.md`](05-submission-package.md) §2 (cover letter) and §3 (arXiv preface).

### 1.10 **[S-2] (Judge S, endorsed by Judge E) — Snapshots fallback may suit better than the EMS Magazine primary**

This is a venue strategy observation, not a manuscript issue. The piece is calibrated for EMS Magazine's typical reader (working mathematician, broad audience). But the **Snapshots from Oberwolfach** series is a *stronger* expository home for this *particular* note, for three reasons:

1. *Speed.* Snapshots reviews are typically ~2–4 months; EMS Magazine is ~3–6 months. The faster venue lets the satellite be a citable pointer by the time the main paper enters review.
2. *Audience.* Snapshots is explicitly aimed at non-specialists and grad students. The methodology note's "perpendicular axes" picture, the worked example, and the forward pointers to active research areas (GNNs, property testing) are exactly the rhetoric Snapshots optimizes for.
3. *Open access.* Snapshots is OA by default; EMS Magazine is OA but with print-tier prestige overhead.

**Counterargument** (Judge S's own, weighed): EMS Magazine has higher visibility within the European mathematical community, which is the natural community for the BJM / Le Cam / Blackwell lineage the note inherits. Snapshots' broader audience is also a *less specialized* audience, which can be a disadvantage when the headline claim ("here is a transposition you should care about") needs to land with mathematicians who already speak the calibration vocabulary.

**Recommendation.** Submit to **EMS Magazine first**, with Snapshots as the *fast fallback* if EMS desk-rejects or asks for a more popular-audience rewrite. This preserves the higher-visibility primary while reserving the faster fallback for a one-step pivot.

**Severity.** [S] — strategic, not a manuscript fix. Re-confirms the [`pre-flight`](00-preflight.md) Q5 decision.

**Disposition target.** [`05-submission-package.md`](05-submission-package.md) §4 (venue intelligence) updates the fallback rationale; manuscript is unaffected.

---

## 2. Items the audit explicitly *did not* find

For completeness and to short-circuit re-litigation, the audit confirms the following — these are *non-findings*, i.e. things the audit looked for and did not raise as issues.

- **No over-claim of the transposition as new decision theory.** The §1 framing ("the same convex-analytic facts ... transfer mutatis mutandis"), the §3 framing ("the parallel to the optimization axis is exact"), and the §6 statement ("neither axis is mathematically more fundamental than the other") consistently position the methodology as a *reading*, not a new theorem of decision theory. [Veto-π-1] does not fire.
- **No PCP / locally-testable hedge violation.** The §5 "Local testability" bullet (modulo [M-1] above) and the prose around it do not invoke "PCP" or "property testing" as a theorem. [Veto-π-4] does not fire.
- **No stop-one-inch-short violation.** Apart from the §5 [M-1] leak, the GNN content is correctly restricted to single-bullet gestures with forward pointers. The depth-monotonicity bullet uses the correct quantifier ("some choice of label exhibits a floor rise"), matching the closure of [C-2] in the round-1 main-paper audit ([`../05-pi_adversarial_audit_of_draft0.md`](../05-pi_adversarial_audit_of_draft0.md) §1.2). [Veto-π-3] does not fire after [M-1] is closed.
- **The universal $c_\varphi = \tfrac12$ derivation is correct.** Chord-above-the-curve at $(0, 0)$ — $(\tfrac12, 1)$ for concave normalized $\varphi$. [Veto-S-3] does not fire.
- **Numerical worked example is correct.** Judge S re-derived independently: $\varepsilon^* = 0.40$; $\bar H \approx 0.941$, $H^{-1}(0.941) \approx 0.358$; $\bar V = 0.92$, $V^{-1}(0.92) = (1 - \sqrt{0.08})/2 \approx 0.359$; $\bar T = 0.8$, $T^{-1}(0.8) = 0.4$. All bracket inclusions hold. The §4 table values are accurate to the digits printed.
- **Bibliography is appropriately scoped.** 12 entries, all closing-line classical references plus the two forward-pointer satellites; no gratuitous self-citation, no over-citation of the main paper.

---

## 3. Aggregate findings list

| # | Severity | Judge | Locus | Subject | Fix size | Closure commit |
|---|---|---|---|---|---|---|
| **M-1** | [M] | π + S | §5 (Local testability bullet) | Leaks Proposition 6 mechanism — replace with pointer | 1 sentence | #5 |
| **M-2** | [M] | S | §1 (BJM "one and only one") | Over-claims uniqueness — soften | 1 sentence | #2 |
| **M-3** | [M] | S | §2 (RW unifying paragraph) | Over-attributes — recast as structural reorganization | 1–2 sentences | #3 |
| **M-4** | [M] | S | §3 / §4 (running-example order; entropy bits) | Order mismatch; bits convention not stated | 1 sentence + table caption | #4 |
| **m-1** | [m] | π | §1 (opening sentence) | Subordinate-clause-heavy opener — promote the question-first sentence | 1 paragraph reorder | #1 |
| **m-2** | [m] | π | §6 (closing sentence) | Aphoristic closer borders on trope — replace with paragraph | 1 sentence → 2 sentences | #6 |
| **m-3** | [m] | S | Bibliography (BJM 2006) | Verify pagination | bibliography check | #7 |
| **m-4** | [m] | π | Acknowledgements (placeholder) | Draft methodology-disclosure paragraph | 1 paragraph | #8 |
| **S-1** | [S] | π | Whole document | Acknowledge salami-slicing footprint in closure + arXiv preface | non-manuscript | acknowledged in [`03`](03-closure-draft0.1.md); recorded in [`05`](05-submission-package.md) |
| **S-2** | [S] | S + E | Venue strategy | Reconfirm EMS Magazine primary, Snapshots fast fallback | non-manuscript | [`05`](05-submission-package.md) §4 |

**Total manuscript edits:** 6 commit-sized fixes, all single-paragraph or smaller. No structural rewrite required.

**Audit verdict (jointly signed).** With the eight commits of [`03-closure-draft0.1.md`](03-closure-draft0.1.md) applied, the manuscript [`04-manuscript-final.md`](04-manuscript-final.md) is **publication-ready for EMS Magazine**. Round 3 closure suffices; no second audit round is required.

Judge π — sign-off conditional on commits #1–#8.
Judge S — sign-off conditional on commits #1–#8 and the pagination check in #7.
