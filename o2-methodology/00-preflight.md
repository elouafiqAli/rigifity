# O2 — Pre-flight check

*Round 0. Required by the publication-plan discipline ([`../21-publication_plan.md`](../21-publication_plan.md) §1.3). A satellite that cannot answer all five questions does not enter the queue.*

---

## Q1 — Does this construct stand alone, or does it implicitly rely on a downstream result the small piece cannot cite?

**Stands alone.** The methodology note's job is to *name and explain* the resolution-axis transposition. It depends on three pieces of mathematics that are individually citable to canonical literature:

1. **Blackwell's comparison-of-experiments order** ([Blackwell 1953], [Le Cam 1986]) — used to say that refinement of partitions cannot raise the Bayes risk. Cited; no derivation needed.
2. **Surrogate-calibration on the optimization axis** ([Bartlett–Jordan–McAuliffe 2006], [Zhang 2004], [Reid–Williamson 2011]) — used as the *contrast object*. Cited; no derivation needed.
3. **The bracket itself**: $\varphi^{-1}(\bar\varphi(\Pi)) \le \varepsilon^*(\Pi) \le c_\varphi \bar\varphi(\Pi)$ with $c_\varphi = \tfrac12$ for normalized concave scores. **This is the satellite O1's headline result** — the methodology note presents the bracket as a "result to be proved in [O1]" and cites it forward as `[Author, SPL]`, exactly as the main paper will cite both pieces.

The note does **not** depend on Theorem 2 (the bracket-exactness rigidity), the multiclass Theorem 2′, the two-query identity (Proposition 6), the aggregator half-chain (Corollary 4), the over-smoothing characterization (Theorem 5), or the Lean mechanization. Each of those is mentioned only as a *forward pointer* in §5 ("the transposition unlocks ..."), tagged with `[see Author, ...]`.

**No salami-slicing risk.** The piece duplicates no theorem of the main paper or of any other satellite — it states the *vocabulary* (perpendicular axes, the named transposition, the worked example), not the proofs. The main paper's bibliography will cite it for the framing, not for any particular theorem.

**Forward-citation discipline.** The arXiv version (see [`05-submission-package.md`](05-submission-package.md)) carries a tutorial preface explicitly cross-referencing O1 by arXiv ID, so the bracket's proof is one click away even before the SPL version exists.

---

## Q2 — What is the one sentence the main paper will be able to write because this exists?

> *"The methodology — calibration on the resolution axis — is a transposition of classical surrogate calibration ([BJM 2006; Reid–Williamson 2011]) from the predictor axis to the partition (resolution) axis; see [Author, EMS Magazine 2026] for the methodological framing and [Author, SPL] for the bracket itself."*

In the current draft of the main paper, [`../03-t0-achievable_error_floor.md`](../03-t0-achievable_error_floor.md) §1.1 item 4 carries the inline equivalent of this sentence. Once O2 is published, that inline framing is replaced by the citation — saving ~half a page of prose and giving the methodological claim a peer-reviewed home.

---

## Q3 — Who is the hostile referee for this piece, and what is their veto?

**Two hostile-referee personae, per [`../21-publication_plan.md`](../21-publication_plan.md) §2.**

### Judge π (process / methodology auditor)

Vetos available to π:
- **[Veto-π-1] Over-claiming the transposition as a new decision-theoretic technique.** The transposition is *a way of reading* existing convex-analytic facts on the resolution axis instead of the predictor axis; π will reject any sentence that frames it as a new theorem of decision theory.
- **[Veto-π-2] Salami-slicing.** π will reject the piece if any new theorem of the main paper is reproved here in a way that lets the satellite be cited *instead of* the main paper.
- **[Veto-π-3] Stop-one-inch-short discipline.** π will reject any explicit GNN application that should be deferred to the main paper / O5–O11 satellites.
- **[Veto-π-4] Hedging discipline.** π will reject "PCP" or "locally testable" framings unless they read as analogy, never as theorem.

### Judge S (statistics referee — calibration literature)

Vetos available to S:
- **[Veto-S-1] Mis-attribution to BJM / Zhang / RW.** S will reject any sentence that reads as if those works did the resolution-axis transposition. The contrast must be precise: BJM bound *excess risk of a predictor* (optimization axis); the transposition bounds the *absolute Bayes risk of a partition* (resolution axis). Two formal differences — *excess vs absolute*, *one-sided vs two-sided* — must be in the prose.
- **[Veto-S-2] Hidden reliance on a Reid–Williamson identity that the note does not state.** RW 2011's machinery is the *closest* precedent; S will check that everything used is either stated or cited correctly.
- **[Veto-S-3] Mis-statement of the universal constant.** $c_\varphi = \tfrac12$ holds for normalized concave $\varphi$ with $\varphi(\tfrac12) = 1$; S will reject any drift from "normalized" in the statement.

The audit in [`02-adversarial_audit.md`](02-adversarial_audit.md) is structured around these seven veto points plus whatever findings each judge raises in their independent reading.

---

## Q4 — What is the closest existing precedent in the literature, and how does this piece position against it?

**Closest precedents, sorted by distance:**

1. **Reid–Williamson, *J. Mach. Learn. Res.* 2011 (proper losses, divergences, binary experiments).** Closest analytic kin. Unifies scoring rules, $f$-divergences, and the Bayes risk of binary experiments through the proper-loss / weighted-integral representation. **But always with the predictor in focus** — the variable being optimized over is the predictor's action / decision rule, and the loss is what gets compared (BJM-style). The resolution-axis transposition fixes the loss (the $0$-$1$ loss, the quantity of practical interest), takes the partition as the free variable, and applies the same machinery to the *partition functional*. **No section of Reid–Williamson 2011 reads this off.** The transposition is, in their vocabulary, an exchange of which slot in $(\text{predictor}, \text{measurement}, \text{loss})$ is held fixed.

2. **Blackwell 1953 / Le Cam 1986 / Le Cam & Yang 2000 (comparison of experiments).** Establishes that refinement of experiments cannot raise the Bayes risk. **Qualitative, not calibrated.** The transposition replaces the qualitative ordering with a calibrated bracket — the same way BJM replaced "consistent surrogate ⇒ Bayes-consistent predictor" with "$\psi(R - R^*) \le R_\varphi - R_\varphi^*$." The methodology note's job is to make this *parallel* explicit and named.

3. **Bartlett, Jordan, McAuliffe, *J. Amer. Statist. Assoc.* 2006 (calibration of margin losses) and Zhang, *Ann. Statist.* 2004 (statistical convergence of large-margin classification).** The optimization-axis benchmark. The methodology note's *contrast object*. Position: the transposition gives a partition-axis analogue of the BJM $\psi$-transform, where the role of the surrogate's $\psi$ is played by the bracket's $c_\varphi$ constant and the role of "the $\psi$-transform is the identity only for the $0$-$1$ loss" is played by "the bracket is exact only for the tent" — but the latter is satellite O1's theorem, not this note's claim.

4. **Tewari–Bartlett 2007 / Ramaswamy–Agarwal 2012 / Pires–Szepesvári 2016 (multiclass calibration).** Not directly relevant to the methodology note — those address calibration of *multiclass surrogates* on the predictor axis; the simplex analogue of the transposition lives in the main paper and O7, not here.

5. **Recent expository pieces on Blackwell / comparison of experiments — e.g. Le Cam–Yang's textbook, Torgersen 1991.** None state the transposition.

**Position.** The transposition has been hovering in the air since BJM 2006 and Reid–Williamson 2011 — the same machinery, applied at the other slot — but to my knowledge nobody has written it down as a named methodology. The methodology note's contribution is precisely that naming + a worked example + the perpendicular-axes picture, suitable for a working mathematician who knows one of the two axes and wants to import results across.

---

## Q5 — If rejected by the primary venue, what is the fallback venue, and what is the arXiv-first plan?

**Primary venue.** *EMS Magazine* (European Mathematical Society; formerly the EMS Newsletter). Expository, peer-reviewed, ~3–6 month decision turnaround. Fits a methodology / framing note of this scope perfectly.

**Fallback ladder.**

1. **Snapshots of Modern Mathematics from Oberwolfach** — peer-reviewed, open access, fast turnaround (~2–4 months), aimed at non-specialists. Strong fit; the constraint is that Snapshots leans more general-audience than EMS Magazine, so the BJM-vs-RW level of technical contrast would need to be relaxed. Acceptable.
2. **Mathematical Intelligencer** (Springer) — popular-mathematics expository. Slower (~3–6 months) and more journalistic. Acceptable.
3. **Expositiones Mathematicae** (Elsevier) — technical expository / surveys. Slower (~3–6 months) and longer-form than the note's natural scope. Last resort.

**arXiv-first plan.** Simultaneous with the EMS Magazine submission, deposit the manuscript on arXiv (`math.ST` primary, `cs.LG` and `math.PR` secondary) with a brief tutorial preface (see [`05-submission-package.md`](05-submission-package.md) §3) that re-states the satellite's three forward pointers (O1, O5–O11, O15–O20) with arXiv IDs once those are available. The arXiv deposit is the citable pointer the main paper uses regardless of which venue ultimately accepts. If all four peer-review venues reject, the arXiv version is the citable artifact and the main paper cites it as `[Author, arXiv:YYMM.NNNNN]`.

**Decision discipline (per round 4 of the publication-plan workflow, [`../21-publication_plan.md`](../21-publication_plan.md) §1.2).** No silent vanishing. Each rejection triggers a one-paragraph entry in [`05-submission-package.md`](05-submission-package.md) §5 (decision log) with the reviewer's stated objection and the response (revise-and-resubmit at the next venue, or accept the rejection and proceed to the fallback). The arXiv version is updated to the latest reviewed text whenever a venue's reviews materially improve the manuscript.

---

## Verdict

All five questions answered. The piece **enters the queue**. Round 1 proceeds: [`01-skeleton-draft0.md`](01-skeleton-draft0.md).
