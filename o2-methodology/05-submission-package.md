# Round 4 — Submission Package

*Cover letter, arXiv preface, venue intelligence, and decision log for the manuscript [`04-manuscript-final.md`](04-manuscript-final.md). Round 4 of the satellite-publication discipline ([`../21-publication_plan.md`](../21-publication_plan.md) §1.2): concurrent exposure on arXiv and at the primary peer-reviewed venue.*

*Status, 2026-06-06:* package assembled, awaiting author's go-ahead to submit. No content edits in this document trigger manuscript edits — those go through the audit/closure cycle in [`02-adversarial_audit.md`](02-adversarial_audit.md) / [`03-closure-draft0.1.md`](03-closure-draft0.1.md).

---

## 1. Submission timeline

| Step | Action | Owner | State |
|---|---|---|---|
| 1 | Author personalizes the cover letter (§2) with title, contact details, conflict-of-interest declaration | Author | *pending* |
| 2 | Author personalizes the arXiv preface (§3) — fills the two `YYMM.NNNNN` placeholders for satellites O1 and the main paper *if* their arXiv IDs are already reserved; otherwise leaves as `[to be filled in v2]` | Author | *pending* |
| 3 | Submit to **EMS Magazine** via the EMS Magazine submission portal (or via the editor-in-chief if portal access requires it). Include: manuscript [`04-manuscript-final.md`](04-manuscript-final.md) as PDF, cover letter (§2), suggested reviewers (§5) | Author | *pending* |
| 4 | Deposit on **arXiv** with the tutorial preface (§3) as the abstract preamble (or, if arXiv's abstract field is too short, as a "Preface" §0 of the manuscript itself). Categories: `math.ST` primary, `cs.LG` and `math.PR` secondary | Author | *pending* |
| 5 | Acknowledge EMS Magazine receipt; record the submission ID and the editor handling the manuscript in §6 (decision log) | Author | *pending* |
| 6 | Acknowledge arXiv receipt; record the arXiv ID in §6 and back-fill it into the references of [`04-manuscript-final.md`](04-manuscript-final.md) (commit `docs: add arXiv ID to references after deposit`) | Author | *pending* |

The author is the sole executor of steps 1–6; the package below provides the text and the discipline. No additional internal review required — the [`02-adversarial_audit.md`](02-adversarial_audit.md) sign-off was conditional only on the eight closure commits, all applied.

---

## 2. Cover letter to *EMS Magazine*

The letter below is in the standard "letter to the editor-in-chief" format. Personalize the bracketed placeholders before sending.

---

> *[Author affiliation, address, email]*
>
> *[Date of submission]*
>
> To the Editor-in-Chief, *EMS Magazine*
>
> Re: Submission of *"Calibration on the resolution axis: a methodology note"*
>
> Dear Editor,
>
> I am pleased to submit the enclosed methodology note, *"Calibration on the resolution axis: a methodology note,"* for consideration in *EMS Magazine.* The note (approximately 6–7 printed pages at the magazine's standard layout) is an expository / methodological piece aimed at the working mathematician fluent in either surrogate calibration or comparison of experiments, but not necessarily both.
>
> **Contribution.** The note observes that the convex-analytic machinery the calibration literature has refined for two decades on the *optimization axis* (predictor varied, measurement fixed) transfers *mutatis mutandis* to a perpendicular *resolution axis* (measurement varied, predictor optimized cell-wise). I call this the *resolution-axis transposition*, draw the perpendicular-axes picture, exhibit the two-sided bracket it produces — with universal upper constant $c_\varphi = \tfrac12$ for normalized concave scores — and work out one two-cell numerical example end-to-end. The note ends with forward pointers to three recent applications (graph neural-network expressivity, refinement-lattice incomparability of aggregator architectures, locally-testable partition statistics) and three classical cousins (Le Cam deficiency, $f$-divergence dualities, Bregman geometry on the simplex).
>
> **Relationship to companion submissions.** The bracket of §3 and the bracket-exactness theorem cited in §3 are *proved* in a companion paper [Author, in submission to *Statistics & Probability Letters*]; this methodology note states them for context without re-proving them. The two notes are deliberately scoped to be useful independently: a reader of the methodology note who wants the proofs follows the *Statistics & Probability Letters* citation; a reader of the *Statistics & Probability Letters* paper who wants the methodological framing follows the citation to this note. I judge the partial duplication of *statements* (not proofs) to be standard editorial practice for expository / methodology pieces; I am happy to add or remove forward citations as the editor judges appropriate.
>
> **Audience fit.** *EMS Magazine* is the natural primary venue for this note: the bridge between the optimization-axis literature (Bartlett–Jordan–McAuliffe; Reid–Williamson) and the comparison-of-experiments tradition (Blackwell; Le Cam; Torgersen) sits squarely in the European mathematical-statistics community the magazine serves. The note's tone is calibrated for the magazine's working-mathematician reader.
>
> **No conflicts of interest.** I declare no financial or personal conflicts of interest with respect to the work or its referees.
>
> **Suggested reviewers and exclusions.** See the accompanying list (Submission Portal field, or attached as §5 of the submission package on request).
>
> **Concurrent arXiv deposit.** A copy of the manuscript is deposited concurrently on arXiv (primary `math.ST`; secondary `cs.LG`, `math.PR`), with a brief tutorial preface for non-magazine readers. The arXiv version is identical to the submitted manuscript modulo the preface.
>
> I look forward to the magazine's consideration. Please contact me at [author email] with any questions.
>
> Sincerely,
>
> [Author name]

---

## 3. arXiv tutorial preface

The arXiv deposit carries a brief preface that orients the reader who arrived from a search engine or a citation rather than from *EMS Magazine* directly. The preface is **inserted as §0 of the arXiv version** (before the abstract), is **not** part of the EMS Magazine submission, and **expires** when the EMS Magazine version goes to print (at which point the arXiv version is re-versioned with the preface removed or replaced by a "published as" line).

---

> ### §0 — Preface (arXiv version)
>
> *This note appears, in its peer-reviewed form, in **EMS Magazine** [issue / pp. — filled at acceptance]. The arXiv version carries this preface and is otherwise identical to the EMS Magazine version. The preface is included so that the note is fully self-contained for an arXiv reader without access to the magazine.*
>
> *Three pieces of accompanying work are referred to inside the note and are listed here for one-click access.*
>
> - *The **bracket** of §3 and the **bracket-exactness theorem** cited at the end of §3 are proved in the companion paper:* [Author], *A bracket for the partition-restricted Bayes risk,* arXiv:`[YYMM.NNNNN, to be filled in v2]`. *This methodology note states those results for context without re-proving them.*
> - *The three "consequences in recent work" of §5 — depth-as-refinement, aggregator half-chain, locally-testable bracket — are developed in:* [Author], *The achievable-error floor of graph neural networks,* arXiv:`[YYMM.NNNNN, to be filled in v2]` *(main paper, in preparation), with the two-query identity for the bracket in* [Author], *A two-query identity for the partition Bayes risk* (*Information Processing Letters*, in submission), *and the aggregator half-chain in* [Author], *The aggregator half-chain* (*Learning on Graphs* 2026 workshop track, in submission).
> - *The three "methodological cousins" of §5 — Le Cam deficiency, f-divergence dualities, Bregman geometry — are independent papers under separate development and not cited from a specific submission yet.*
>
> *The note has no proofs of its own. Its contribution is the named methodology, the perpendicular-axes picture, the worked example, and the literature-positioning prose.*
>
> *— [Author], [date of deposit]*

---

## 4. Venue intelligence — primary, fallback ladder, decision criteria

### 4.1 Primary: *EMS Magazine*

- **Status.** European Mathematical Society publication, peer-reviewed (since the 2021 transition from *EMS Newsletter*), open access with print tier.
- **Editorial board.** Verify the current editor-in-chief and the methodology-paper section editor against the magazine's masthead at submission time. Address the cover letter to the editor-in-chief unless the methodology-paper section is staffed.
- **Format.** ~6–8 printed pages preferred for methodology / expository pieces. The current manuscript is calibrated to this budget.
- **Estimated turnaround.** ~3–6 months desk-to-decision based on recent issues' "received / accepted" date pairs. Verify against the magazine's most recent issue at submission time.
- **Decision criteria the editor will apply.** (Inferred from recent issues; verify at submission.) (a) Is the methodological observation precise and named? (b) Is the audience the magazine's working-mathematician reader? (c) Is the prose at magazine register? (d) Does the note avoid duplicating a recent piece in the magazine? (e) Is the contribution honestly scoped — not over-claiming theorem-level novelty? **All five answer affirmatively for the current manuscript.**
- **Acceptance probability estimate.** Moderate-to-good. The note is precisely the kind of "bridge piece" between two literatures that magazine editors actively solicit, and the prose has passed two rounds of internal audit. A desk rejection on "out of scope for the magazine" grounds is the principal risk; the cover-letter framing in §2 addresses this directly.

### 4.2 Fast fallback: *Snapshots of Modern Mathematics from Oberwolfach*

- **Status.** Mathematisches Forschungsinstitut Oberwolfach publication, peer-reviewed, open access only (no print).
- **Format.** ~10–15 minutes' reading time; aimed at non-specialists and graduate students.
- **Estimated turnaround.** ~2–4 months desk-to-decision.
- **Rewrite cost from EMS Magazine version.** Moderate. The §1 BJM/RW framing paragraph and the §2 recap would need to soften for a non-specialist audience; the §3 bracket statement, §4 worked example, and §5 forward pointers transfer essentially unchanged. The closing §6 stays as-is.
- **Acceptance probability estimate.** High after the rewrite, conditional on the rewrite landing the non-specialist register correctly.
- **Pivot trigger.** Use Snapshots as fallback **only** if EMS Magazine desk-rejects on audience-fit grounds or asks for a non-specialist rewrite. Do *not* pre-rewrite for Snapshots' audience while the EMS Magazine version is the natural primary.

### 4.3 Slower fallback: *Mathematical Intelligencer*

- **Status.** Springer publication, peer-reviewed, mixed-prestige (popular-mathematics expository).
- **Format.** ~6–12 printed pages; more journalistic register than EMS Magazine.
- **Estimated turnaround.** ~3–6 months desk-to-decision.
- **Rewrite cost.** Higher — the *Intelligencer* leans popular-science and the BJM/RW machinery would need explanation almost from scratch.
- **Pivot trigger.** Use only if both EMS Magazine and Snapshots reject.

### 4.4 Last-resort fallback: *Expositiones Mathematicae*

- **Status.** Elsevier publication, peer-reviewed, technical expository / survey.
- **Format.** Longer-form (~15–30 pp. typical) than the methodology note's natural scope; would require expansion.
- **Estimated turnaround.** ~3–6 months desk-to-decision.
- **Rewrite cost.** Substantial — the note's six pages would not fit *Expo. Math.*'s typical scope, and expansion would either require pulling proofs back in from O1 (defeats the satellite design) or expanding the literature contrast paragraphs (changes the headline).
- **Pivot trigger.** Use only if all three above reject.

### 4.5 Archival pointer regardless of refereeing outcome: arXiv

The arXiv deposit is the **citable pointer the main paper uses regardless of which venue ultimately accepts**. If all four peer-review venues reject, the arXiv version is the citable artifact and the main paper cites it as `[Author, arXiv:YYMM.NNNNN]`. The arXiv version is updated to the latest reviewed text whenever a venue's reviews materially improve the manuscript; the version history on arXiv preserves the audit trail.

### 4.6 Decision discipline

Per the [`pre-flight`](00-preflight.md) Q5 commitment and the [`../21-publication_plan.md`](../21-publication_plan.md) §1.2 round-4 discipline:

- **No silent vanishing.** Each rejection (or desk-rejection, or R&R with terms the author chooses not to accept) triggers a one-paragraph entry in §6 (decision log) with the reviewer's stated objection and the author's response (revise-and-resubmit at the next venue, or accept the rejection and proceed to the fallback).
- **No pre-emptive rewrite.** The manuscript is the manuscript; do not pre-rewrite for a fallback audience while a higher-priority venue is in play.
- **arXiv tracks the best version.** When a venue's review materially improves the manuscript, push the improved version to arXiv (a new arXiv version, not a replacement). Reference the arXiv version history in any future correspondence about provenance.

---

## 5. Suggested reviewers and exclusions

*(For the EMS Magazine submission portal. The author should personalize this list against the magazine's own editorial process — some venues invite the author to suggest reviewers, others prohibit it.)*

**Suggested reviewers** (knowledgeable in either calibration or comparison-of-experiments, and broad-audience enough to evaluate a magazine piece):

- A senior figure in the BJM / Reid–Williamson calibration lineage (the author should name a specific person at submission time, e.g., a senior statistician who has published in *Annals of Statistics* / JMLR on surrogate calibration).
- A senior figure in the Le Cam / Torgersen / Blackwell comparison-of-experiments lineage (the author should name a specific person at submission time, e.g., a senior statistician in mathematical statistics with comparison-of-experiments work).
- A statistical-decision-theorist with expository chops (someone whose own published work shows willingness to read across the calibration / comparison-of-experiments divide).

**Exclusions** (declared conflicts of interest, recent collaborators, etc.): the author should declare none unless specific situations apply, and should consult the magazine's COI policy at submission time.

---

## 6. Decision log

*Append a one-paragraph entry per submission step. State date, venue, action, outcome (if known), and the next step.*

### 6.1 EMS Magazine

*Pending submission. After submission, fill: arXiv ID of the deposited version, EMS Magazine submission ID, handling-editor name, expected first-decision window.*

### 6.2 arXiv

*Pending deposit. After deposit, fill: arXiv ID, deposit date, version (v1), categories selected, and any cross-listings.*

### 6.3 Outcomes

*Pending. Append per decision: date received, venue's verdict (accept / minor revise / major revise / reject / desk-reject), one-paragraph summary of the reviewer's principal objection or endorsement, and the author's next-step disposition (revise-and-resubmit at the same venue, revise-and-resubmit at the next-venue-down, accept rejection and pivot to fallback). Cross-reference any manuscript changes triggered by the decision back to [`03-closure-draft0.1.md`](03-closure-draft0.1.md) (which may need to be re-opened for a "Closure 0.2" if the venue's review requires substantive edits).*

---

## 7. Closure of the satellite-publication discipline

Once steps 1–6 of §1 are complete and the manuscript is in EMS Magazine review (or on arXiv as the archival pointer), the O2 satellite enters **pending review** state. The next action is **wait** — no further authoring or audit work is required until the decision returns. When the decision returns:

- *Accept (with or without minor revisions).* Apply revisions, ship final, mark satellite O2 **closed**. Update the main paper's bibliography to cite the magazine version. Update the arXiv version (v2) with the magazine's "published as" line.
- *R&R (revise-and-resubmit, substantive).* Open Round 5: revisit the audit/closure cycle for the changed sections; produce a `04-manuscript-revised.md`; respond to reviewers in a new file `06-response-to-reviewers.md`; resubmit.
- *Reject.* Apply the fallback ladder (§4.2 → §4.3 → §4.4). The arXiv version remains the citable pointer.

The discipline is now self-running. The author's role in Round 4 is to execute the submission steps in §1; the audit trail in [`01-skeleton-draft0.md`](01-skeleton-draft0.md), [`02-adversarial_audit.md`](02-adversarial_audit.md), [`03-closure-draft0.1.md`](03-closure-draft0.1.md), [`04-manuscript-final.md`](04-manuscript-final.md), and this submission package is the record of how the manuscript came to be — sufficient for the main paper's eventual reference to this work, sufficient for any later replication of the methodology, and sufficient as the template for satellites O3, O4, and onward.

---

*End of O2 satellite package. Status: ready to submit.*
