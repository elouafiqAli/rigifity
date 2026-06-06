# Round 3 — Closure: Skeleton Draft 0 → Manuscript Draft 0.1

*Executor E response to the Round 2 audit ([`02-adversarial_audit.md`](02-adversarial_audit.md)). Atomic commitology, in the format of the main-paper closures [`../06-draft0.1_commitology.md`](../06-draft0.1_commitology.md), [`../08-draft0.2_commitology.md`](../08-draft0.2_commitology.md), [`../11-draft0.3_commitology.md`](../11-draft0.3_commitology.md), [`../13-draft0.4_commitology.md`](../13-draft0.4_commitology.md). Each commit (i) has a single scope, (ii) cites the audit item(s) it closes, (iii) is independently revertible, and (iv) leaves the manuscript in a textually coherent state.*

> **Convention.** Commit subjects follow `<type>(<scope>): <imperative summary>`. The body cites audit items by tag and states verification. Severity codes: **[M]** material, **[m]** minor, **[S]** strategic. The publishable manuscript that incorporates all eight commits lives in [`04-manuscript-final.md`](04-manuscript-final.md) — *not* in [`01-skeleton-draft0.md`](01-skeleton-draft0.md), which is preserved as the audit-history baseline.

---

## Sequence

| # | Subject | Closes | Severity | Manuscript locus | State |
|---|---|---|---|---|---|
| **1** | `fix(§1): promote question-first opening, demote citation framing` | m-1 | [m] | §1 (opening) | done |
| **2** | `fix(§1): tighten BJM uniqueness wording` | M-2 | [M] | §1 (BJM remark) | done |
| **3** | `fix(§2): soften RW framing to match RW's actual scope` | M-3 | [M] | §2 (RW paragraph) | done |
| **4** | `fix(§3 + §4): unify running-example order; explicit bits convention on entropy` | M-4 | [M] | §3 (examples enumeration), §4 (table caption) | done |
| **5** | `fix(§5): pure forward pointer for Prop 6 in locally-testable bullet` | M-1 | [M] | §5 (Local testability bullet) | done |
| **6** | `fix(§6): replace aphoristic closing with paragraph-length closing` | m-2 | [m] | §6 (closing) | done |
| **7** | `docs: verify BJM 2006 pagination against JASA archive` | m-3 | [m] | Bibliography | done — pagination confirmed `JASA 101 (2006), 138–156` |
| **8** | `docs: draft acknowledgements + methodology disclosure for submission` | m-4 | [m] | Acknowledgements block | done |
| **— ** | `meta: acknowledge salami-slicing footprint in closure + arXiv preface` | S-1 | [S] | non-manuscript — recorded here + in [`05`](05-submission-package.md) §2, §3 | done |
| **— ** | `meta: reconfirm EMS Magazine primary + Snapshots fast-fallback` | S-2 | [S] | non-manuscript — recorded in [`05`](05-submission-package.md) §4 | done |

---

## Dependency graph

```
1 ── 2 ── 3        (independent §1/§2 textual fixes, sequence
                    chosen so §1 prose stabilizes before §2's
                    RW paragraph re-citations rest on it)

4 ── 5             (§3/§4 ordering must settle before §5's bullet
                    rewrite, because §5 refers back to bar phi)

6                  (independent §6 cosmetic)

7  ── 8            (bibliography pagination + acknowledgements,
                    bottom-of-document changes)

────────────────── manuscript draft 0.1 emerges as
                   `04-manuscript-final.md` ────────────────

S-1, S-2           (strategic, non-manuscript; recorded in this file
                    and rolled into `05-submission-package.md`)
```

All commits target [`04-manuscript-final.md`](04-manuscript-final.md). The [`01-skeleton-draft0.md`](01-skeleton-draft0.md) baseline is **frozen** as the audit's input of record and is not edited.

---

## Commits — detail

### 1 · `fix(§1): promote question-first opening, demote citation framing`

**Closes.** [m-1] (audit §1.5).

**Scope.** §1, first three sentences.

**Old text (Round 1):**

> *"Surrogate calibration (Bartlett–Jordan–McAuliffe 2006, Reid–Williamson 2011) is a body of work that controls the excess risk of a learned predictor in terms of the convexification of the gap between the conditional Bayes risk and the score one is willing to compute. The classical calibration question is: given a loss I cannot optimize, what loss can I optimize, and how much does that cost me? The Bayes risk ..."*

**New text (Manuscript 0.1):**

> *"The classical calibration question is: given a loss I cannot optimize, what loss can I optimize, and how much does that cost me? Modern answers — Bartlett, Jordan, and McAuliffe (2006); Zhang (2004); Reid and Williamson (2011) — control the excess risk of a learned predictor through the convexification of a level-set gap on the conditional Bayes risk. This note observes that the same machinery answers a perpendicular question."*

**Verification.** Sentence reads aloud in under five seconds. Citation density unchanged. The italicized question now opens the article; the perpendicular-axis premise lands in the third sentence.

### 2 · `fix(§1): tighten BJM uniqueness wording`

**Closes.** [M-2] (audit §1.2).

**Scope.** §1, BJM-uniqueness remark (~one sentence in the new ordering).

**Old text (Round 1):**

> *"The $\psi$-transform is the identity for one and only one loss — the $0$-$1$ loss itself. Every smooth alternative pays for its differentiability with a calibration gap."*

**New text (Manuscript 0.1):**

> *"The $\psi$-transform is the identity for the $0$-$1$ loss; every smooth surrogate is strictly above the identity at zero, paying for its differentiability with a calibration gap (Bartlett–Jordan–McAuliffe 2006)."*

**Rationale.** "One and only one loss" requires class-restriction qualifiers (margin-based proper composite, modulo reparameterization) that are out of scope for a magazine note. The corrected wording captures the actual content of the BJM observation without over-claiming uniqueness. The genuine uniqueness statement — exactness only for the tent on the resolution axis — lives in the companion satellite O1; on the optimization axis the parallel is left at the level of qualitative "$\psi$ is the identity for the $0$-$1$ loss" without the absolute uniqueness clause.

**Verification.** Re-read the BJM 2006 abstract and the statement of their Theorem 1. The corrected wording matches what BJM literally state; the dropped "one and only one" matches what they do *not* state.

### 3 · `fix(§2): soften RW framing to match RW's actual scope`

**Closes.** [M-3] (audit §1.3).

**Scope.** §2, Reid–Williamson summary paragraph (final paragraph of §2).

**Old text (Round 1):**

> *"Reid and Williamson (2011) unified the picture: every proper composite loss factors as a weighted integral of cost-weighted Bayes risks, the calibration question is the question of how this weighting interacts with the convexification, and the $\psi$-transform is the level-set gap of a particular Bregman-style functional. **The variable being varied throughout is the predictor (equivalently, the loss).** The measurement is held fixed: the predictor sees $X$ in full."*

**New text (Manuscript 0.1):**

> *"Reid and Williamson (2011) reorganize the analysis around proper composite losses and weight functions, exposing the convex-analytic structure that links surrogate calibration to $f$-divergence comparison of experiments and to Bregman geometry on the simplex. **The variable being varied throughout is the predictor (equivalently, the loss).** The measurement is held fixed: the predictor sees $X$ in full."*

**Rationale.** The reworded paragraph attributes the *reorganization* and the *structural connections* (both explicit in RW 2011), without claiming a specific identification of the BJM $\psi$-transform as a Bregman level-set gap (which is an interpretation, not a verbatim RW theorem).

**Verification.** RW 2011 §§4–6 explicitly develop the proper-composite-loss + weight-function representation, and §§7–8 connect it to $f$-divergences and Bregman geometry. The new wording matches their stated scope.

### 4 · `fix(§3 + §4): unify running-example order; explicit bits convention on entropy`

**Closes.** [M-4] (audit §1.4).

**Scope.** §3 (running-examples enumeration); §4 (table caption + one prose sentence).

**Changes.**

- §3, change running-examples enumeration order from (tent, Shannon entropy, rescaled variance) to **(tent, rescaled variance, Shannon entropy)**. This matches the §4 table column order and the pedagogical "tent / variance / entropy in increasing bracket slack" arc.
- §4, modify the table caption to read: *"(Entropy values in bits, log base 2; the normalization $H(\tfrac12) = 1$ is the bit-rate convention.)"*
- §4, immediately before the table, add a single connecting sentence: *"We instantiate the bracket on the three running scores; entropy is reported in bits throughout."*

**Verification.** §3 enumeration and §4 table now agree on column order. The bits convention is explicit at first numerical use; the §3 definition already specified $\log_2$ but the table caption now makes it unmissable. Re-check: $H(0.3)$ in bits $\approx 0.881$; in nats it would be $\approx 0.611$. The table values are the bit values, consistent with $H(\tfrac12) = 1$.

### 5 · `fix(§5): pure forward pointer for Prop 6 in locally-testable bullet`

**Closes.** [M-1] (audit §1.1) — the joint π + S finding.

**Scope.** §5, third bullet ("Local testability of the bracket"), one sentence.

**Old text (Round 1):**

> *"Local testability of the bracket. The bracket admits an estimator using only $O(\alpha^{-2})$ uniform two-element same-cell label queries, independent of the underlying input space's cardinality. The mechanism is a single identity: the probability that two uniform same-cell draws disagree on the label equals twice the cell-conditional variance averaged over cells, which sandwiches the bracket. See [Author, Information Processing Letters 2026]."*

**New text (Manuscript 0.1):**

> *"Local testability of the bracket. The bracket admits an estimator using only $O(\alpha^{-2})$ uniform two-element same-cell label queries, with sample complexity independent of the underlying input space's cardinality. The mechanism — a single-line variance identity that exposes the bracket — is the subject of the companion satellite, [Author, Information Processing Letters 2026]."*

**Rationale.** The Round-1 version stated Proposition 6 (the two-query identity) in informal prose, which would let a salami-slicing objection against satellite O5 succeed. The corrected version withholds the identity itself but preserves the *existence claim* and the *sample-complexity headline* — exactly enough for the methodology note's reader to know the result exists and where to find it.

**Verification.** Re-read the bullet. The phrase "two-element same-cell label queries" remains — that is the *query model*, not the identity. The phrase "$O(\alpha^{-2})$" remains — that is the *sample-complexity headline*. The phrase "a single-line variance identity that exposes the bracket" gestures at the mechanism without disclosing it. Forward pointer to O5 unchanged. [Veto-π-2] (salami-slicing) and [Veto-π-3] (stop-one-inch-short) now both clear.

### 6 · `fix(§6): replace aphoristic closing with paragraph-length closing`

**Closes.** [m-2] (audit §1.6).

**Scope.** §6, final sentence of the second parting observation.

**Old text (Round 1):**

> *"The mathematics was waiting; what is new is the asking."*

**New text (Manuscript 0.1):**

> *"The mathematics — concave generalized entropies, Jensen's inequality, the convexification of level-set gaps — was assembled half a century ago, and the calibration literature has spent two decades refining it on the predictor axis. What is new is the question one asks against it: not which loss to optimize, but at which resolution to measure."*

**Verification.** The replaced text says the same thing in a paragraph rather than an aphorism. The substantive observation (the mathematics is classical; the question is new) is unchanged; the rhetorical register is dialed back from sales pitch to summary.

### 7 · `docs: verify BJM 2006 pagination against JASA archive`

**Closes.** [m-3] (audit §1.7).

**Scope.** Bibliography, BJM 2006 entry.

**Action.** Verified pagination — the official citation is:

> P. L. Bartlett, M. I. Jordan, J. D. McAuliffe. *Convexity, classification, and risk bounds.* Journal of the American Statistical Association **101** (2006), 138–156. (DOI: 10.1198/016214505000000907.)

Bibliography entry updated to the full form (with DOI) for the manuscript; arXiv version uses the same.

**Verification.** Pagination matches JASA archive metadata.

### 8 · `docs: draft acknowledgements + methodology disclosure for submission`

**Closes.** [m-4] (audit §1.8).

**Scope.** Acknowledgements block, full draft.

**New text (Manuscript 0.1):**

> *"**Acknowledgements.** The author thanks [two referees and the action editor — names filled at acceptance]. The drafting and adversarial-audit cycles that produced this note follow the workflow described in the author's `agents/skills/` package and the companion methodology paper [Author, CICM 2026]; the audit trail, reviewer findings, and atomic dispositions are maintained as a transparent record (see the project repository for the full sequence)."*

**Verification.** The disclosure paragraph is precise about persona use (no anthropomorphizing — "audit cycles," not "team of agents"), points at satellite O14 for readers interested in the methodology itself, and signals the existence of the project repository as the audit-trail backstop without naming individuals.

---

## Strategic dispositions (non-manuscript)

### S-1 · Salami-slicing footprint, acknowledged

The manuscript reproduces the *statement* of the bracket (§3) and the *statement* of bracket exactness for the tent (§3 closing), both of which are theorems of satellite O1 and of the main paper. The proofs are not reproduced. This duplication is necessary for the methodology note to be intelligible — without the bracket statement, the perpendicular-axes picture cannot be drawn; without the exactness pointer, the closing parallel "bracket exact iff tent" cannot be made. Further reduction would gut the note's intelligibility.

The duplication is **acknowledged here**, **recorded in [`05-submission-package.md`](05-submission-package.md) §2** (cover letter to EMS Magazine — paragraph 3, "relationship to companion submissions"), and **flagged in [`05-submission-package.md`](05-submission-package.md) §3** (arXiv preface — opening footnote: *"The bracket of §3 and the exactness theorem cited in §3 are proved in the companion paper [O1 arXiv:YYMM.NNNNN]; this methodology note states them for context without re-proving them."*).

Editorial precedent (cf. *Notices of the AMS* expository pieces, *EMS Magazine* archival): methodology / framing pieces routinely re-state without re-proving the theorems they comment on. The disclosure above suffices.

### S-2 · Venue strategy, reconfirmed

Audit [S-2] reopened the venue question: should the primary be EMS Magazine or *Snapshots of Modern Mathematics from Oberwolfach*? The reconfirmation is **EMS Magazine primary, Snapshots fast-fallback** — the decision matrix is:

| Criterion | EMS Magazine | Snapshots |
|---|---|---|
| Speed | ~3–6 months | ~2–4 months |
| Audience | working mathematician (BJM/Le Cam/Blackwell-fluent) | non-specialist + grad students |
| Open access | yes (with print tier) | yes (OA-only) |
| Prestige (in calibration lineage) | high | broad but less specialized |
| Cost of rewrite if Snapshots first | (n/a) | would need to rewrite for non-specialist register, lossy |
| Cost of pivot if EMS first | low — same prose, lighter technical register | minimal — Snapshots already favours the prose-style |

EMS Magazine is the correct primary because the note's natural reader is fluent in at least one of the two axes; the Snapshots audience would require softening the BJM/RW contrast paragraph in §1–§2, which is precisely what makes the note useful to a specialist. If EMS Magazine desk-rejects or asks for a popular-audience rewrite, *pivot at that point* — do not pre-rewrite for the wrong audience.

This decision is recorded in [`05-submission-package.md`](05-submission-package.md) §4 (venue intelligence ladder).

---

## Closure verdict

All eight commits applied. The publishable manuscript lives in [`04-manuscript-final.md`](04-manuscript-final.md). Round 2 audit findings [M-1] through [M-4] and [m-1] through [m-4] are closed; strategic findings [S-1] and [S-2] are recorded and routed to the submission package.

**Round 3 closed.** Round 4 (submission) is the operational next step; the package is in [`05-submission-package.md`](05-submission-package.md).
