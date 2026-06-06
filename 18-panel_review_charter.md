# Panel of Theory Judges — Review Charter for Journal-Grade Scrutiny

*Subject: [`03-t0-achievable_error_floor.md`](03-t0-achievable_error_floor.md) Draft 0.7 (Final) and the Lean kernel at HEAD `4dcf5cd`. Charter authored 2026-06-06.*

---

## 0. Preamble — what this charter is, and what it isn't

This charter is the operating document for a **standing panel of five theory judges + one coordinator** who will subject the paper and its Lean kernel to a long-horizon multi-phase review aimed at **journal readiness at the highest standard of elegance and correctness**. The paper has already passed seven rounds of adversarial audit (rounds 1–7 archived in [`05`](05-pi_adversarial_audit_of_draft0.md), [`07`](07-pi_adversarial_audit_of_04.md), [`10`](10-external_reviewer_audit_of_draft0.2.md), [`12`](12-external_reviewer_second_audit_of_draft0.3.md), [`00-external.md`](00-external.md), and [`17-pi_adversarial_audit_of_draft0.6_post_phase_d.md`](17-pi_adversarial_audit_of_draft0.6_post_phase_d.md), with closures in `06`, `08`, `11`, `13`, and the Draft 0.5/0.6/0.7 revision history). The Lean kernel carries 57 axiom-clean theorems verified against mathlib v4.29.1.

**This charter starts where round 7 ended.** Its goal is not to repeat the seven rounds — those provide the baseline. The panel's job is to deliver the **eighth and definitive review**: a journal-grade, end-to-end re-evaluation of the manuscript and the kernel, run by domain experts each holding a specific veto, integrated by a coordinator into a single panel verdict.

The bar is **not** "is this defensible against a referee?" — the seven prior rounds already establish that. The bar is: **can this paper appear in the table of contents of a journal at the very top of its field, beside the canonical works in its area, without the editor regretting the decision in five years?** That bar requires a different review: more focused on elegance, on the precise wording of contribution claims, on the long-horizon mathematical health of the formalization, and on the strategic question of *which* journal and *which* companion deliverables.

The charter is written for the panel coordinator. The five judges receive their per-judge briefs (§1) and the per-phase task lists (§3). The coordinator runs the gate criteria (§5), severity bookkeeping (§4), closure rounds (§6), timeline (§7), and final verdict synthesis (§9).

---

## 1. Panel composition

Five voting judges, each with a defined domain, checklist, and **scope of veto**. One non-voting coordinator, who manages the process and produces the final verdict document but does not adjudicate technical disputes.

| Judge | Domain | Primary checklist | Scope of veto |
|---|---|---|---|
| **Judge T** (theory) | Decision theory, comparison-of-experiments, convex analysis | §3 (Theorems 1, 2, Cor 3); §4.1–§4.2 (simplex setup, Theorem 2′, Cor 3′); §4.4 (Theorem 1′ as a paper-side claim) | Mathematical correctness. A sustained T-veto blocks publication. |
| **Judge S** (statistics) | Surrogate calibration, scoring rules, BJM/Reid–Williamson lineage, Tewari–Bartlett / Ramaswamy–Agarwal multiclass calibration | §1.2 prior-art audit; the *resolution-level transposition* novelty claim; the Theorem 2′ / multiclass-calibration contrast in §1.2 | Originality and positioning vis-à-vis the calibration literature. |
| **Judge G** (graph ML / expressivity) | Weisfeiler–Leman theory, GIN/GCN/GAT architecture taxonomy, over-smoothing literature, locally-checkable property tests | §5 (Cor 4 aggregator half-chain); §6 (Theorem 5 + three-partition framing + over-smoothing); §7 (Prop 6, Cor 7, the local test) | GNN-side claims, the floor-vs-achieved distinction, the empirical-companion gate. |
| **Judge F** (formal methods) | Lean 4, mathlib measure-theoretic and convex-analysis substrate, ITP-grade exposition | Lean kernel (all of `lean/`); Appendix A cross-references; Appendix B reproducibility; the four realizability typeclasses and the Sierpiński PR plan | Mechanization integrity: every Lean cross-reference in Appendix A must hold; every paper hypothesis must have a Lean equivalent or a documented gap. |
| **Judge E** (editor / strategic) | Venue dynamics, paper-track sequencing, empirical-companion scoping, exposition pacing, the long-horizon question of what the paper *is* | Abstract; §1.1 contribution list; §8 open problems; Appendix B methodology paragraph; the publication-strategy recommendation | Publication-readiness final verdict: even if T/S/G/F all pass, E can withhold the journal-ready stamp on positioning grounds and require an additional round. |
| **Coordinator** | Charter execution, severity bookkeeping, closure-round assignment, panel-verdict synthesis | The charter itself; the audit trail; the gate-criteria checklist | None — the coordinator is non-voting and adjudicates process, not content. |

**Replacement and recusal.** If a judge cannot serve to the end of the panel's work, the coordinator names a replacement of equal seniority in the same domain and re-runs the prior phases through the new judge before the panel proceeds. A judge with a financial or reputational stake in any cited prior work must recuse and be replaced.

**Communication discipline.** Inter-judge communication during a phase is **explicitly prohibited** until the coordinator declares the phase deliverables complete. This prevents convergence on a shared frame before the independent re-derivations are done. Communication during the synthesis phase (Phase VI) is conducted via written memos with the coordinator as broker; in-person panel meetings are held only after each judge has delivered a written per-phase verdict.

---

## 2. Phase structure

The review is structured into **six phases**, each scoped to a single dimension. Phases I–IV run in **parallel** across the five judges (each judge does their own re-derivation independently). Phase V is sequential after IV. Phase VI is the synthesis. Phases never re-open once the coordinator certifies them; mid-phase findings against a closed phase trigger a new closure round (§6) rather than a re-opening.

| Phase | Theme | Pass criterion (one-sentence) |
|---|---|---|
| **I — Foundations** | Correctness of every theorem and proof against the §2 definitions, *de novo* | Each judge's independent re-derivation of every theorem returns ✓; zero [Critical] open. |
| **II — Originality** | Position vs prior art; what is new vs what is borrowed | Every novelty claim in §1.1 / §1.2 / §8 has a precise contrast against a specific prior result, and Judge S signs off that no closer precedent exists. |
| **III — Exposition** | Elegance, clarity, hypothesis precision, cross-reference integrity | Every theorem statement is at minimum-sufficient hypothesis strength, with no unused or unstated hypotheses; the abstract and §1.1 lead with the contribution, not the framing. |
| **IV — Mechanization** | Lean kernel integrity, Appendix A cross-reference verification, reproducibility | The harness `verify/run-all.ps1` exits 0 from a fresh clone; all 57 `PrintAxioms` entries are clean; every Appendix A row is verified row-by-row by Judge F. |
| **V — Strategic** | Venue, empirical companion, open-problem roadmap, paper-track sequencing | Judge E delivers a venue recommendation backed by Judges T/S/G/F's per-phase memos; the empirical companion has an explicit scope; the Sierpiński PR plan is concrete. |
| **VI — Synthesis** | Panel verdict | The coordinator produces a single panel-verdict document signed by all five judges, with a clear pass/fail/conditional-pass outcome, attached to a per-phase audit trail. |

**Phase ordering rationale.** I before II (correctness before originality), II before III (originality fixes the contribution claim before exposition is polished around it), III before IV (paper hypotheses pinned before Lean cross-reference is verified), IV before V (mechanization status known before venue recommendation), V before VI (all inputs in hand for synthesis). Phases I–IV are individually parallelizable across judges but must complete in the listed order at the panel level.

---

## 3. Per-phase task lists

Every task carries (a) the responsible judge, (b) a deliverable, (c) a pass criterion, (d) a list of **known failure modes** distilled from rounds 1–7. A judge may not declare a task ✓ without producing the listed deliverable.

### Phase I — Foundations (correctness floor)

| Task | Lead | Deliverable | Pass criterion | Known failure modes |
|---|---|---|---|---|
| I.1 — *De novo* re-derivation of every theorem from §2 definitions, without consulting the paper's proofs | T (primary), S, G, F (each independently for their domain) | Per-judge memo with the re-derivation worked out from scratch | All four judges' re-derivations agree with the paper's conclusions, **and** with each other on the proof structure | Misreading the upper-endpoint constraint in Theorem 2 as the lower (round 6 [Critical] precedent); confusing "exact" with "calibrated" |
| I.2 — Hypothesis-utilization audit | T | Table: each hypothesis × each theorem × where it is used in the proof | No unused hypothesis; no implicit hypothesis the proof uses but the statement omits | "$\varphi > 0$ on the interior" was over-stated for two drafts (round 7 [Positive 1]); measurability of $f$ was understated for two drafts (round 5 / round 7 [Material 1]) |
| I.3 — Conclusion-strength audit | T | For each theorem, a list of hypotheses one might *try* to weaken, with a counterexample or a proof sketch why they cannot be | Every "minimal hypothesis" claim has a recorded justification | Carrying redundant hypotheses (e.g. $\varphi > 0$ interior) without checking they are needed |
| I.4 — Boundary-case audit | T, G | $k = 2$ reduction of §4 to §3; atomless vs general space; vacuous-bracket cases ($c_\varphi = \infty$); single-cell vs degenerate partitions | Every boundary case either reduces correctly to the binary version or is explicitly out of scope | The §4.4 binary consistency claim is correct but the *recovery of the binary bracket from the simplex bracket* requires the level-set collapse argument, which a careless reader could miss |
| I.5 — Numerical re-verification of Worked Examples A and B | T, F | Independent re-derivation of every numerical claim in §4.3 (rationals for A, decimals for B); cross-check against `WorkedExample.lean` | Every paper-side number matches the Lean `native_decide` output | Worked Example B's lower-bracket-witness minimality was asserted without proof for two drafts (round 7 [Minor 3]) |
| I.6 — Theorem 2′ Step 2 chord-trick re-derivation | T, F | Independent verification that the chord substitution $u_1 = \varphi_{\max}, u_2 = 0, p = v/\varphi_{\max}$ in the Jensen-equality on $G$ yields $G(v) = av + b$ | T's re-derivation matches the paper's argument and the Lean term `affine_of_jensen_eq` (without needing the boundedness hypothesis) | Spurious appeal to the Cauchy-equation literature when the chord trick suffices (the round 7 round-up of Phase D's surprise) |
| I.7 — Theorem 5(b) positive-mass clause re-derivation | G | Verify the contrapositive's strict-positivity step depends on the straddling cell $C$ having $C \cap A$ and $C \cap B$ both of positive mass | The clause is necessary (constructed counter-example without it would invalidate the conclusion) and sufficient (clause closes the proof) | The clause was missing from drafts 0.4 and 0.5 (round 6 [Material M-1]) |
| I.8 — Refinement-tower argument re-derivation | T | Re-derive the (iii) ⟹ (i) direction of Theorem 1 (and the simplex analogue Theorem 1′) from the tower property + Jensen, without consulting `barPhi_refinement_le` | The re-derivation matches the structure of `barPhi_refinement_le` modulo the Phase C2 Lean-side filter-on-nonempty modeling decision | The Lean version filters empty cells (necessary for Lean's `Finset.sum_biUnion`); the paper-side argument needs to either match this or argue why empty cells don't matter |

**Phase I gate.** Phase I closes when all eight tasks are ✓ and zero [Critical] findings remain open. If a [Critical] surfaces, Phase I rolls into a closure round (§6) before any other phase begins.

### Phase II — Originality (prior-art audit)

| Task | Lead | Deliverable | Pass criterion | Known failure modes |
|---|---|---|---|---|
| II.1 — §1.2 prior-art audit | S | Per-citation memo: what each cited work proves, what we claim, what the gap is | Every citation in §1.2 supports its claim *and* is the closest precedent the literature has | Over-claiming Reid–Williamson or BJM as if our Theorem 2 were a new decision-theoretic fact (round 1 / round 4 / round 6 all touched this) |
| II.2 — Multiclass calibration literature search | S | Memo: a survey of Tewari–Bartlett, Ramaswamy–Agarwal, Pires–Szepesvári, and any post-2020 multiclass calibration result that *might* anticipate Theorem 2′ | No existing result states the *partition-functional aggregate determines $\varepsilon^\ast$* form of multiclass uniqueness | Framing Theorem 2′ as "the multiclass version of BJM" — Judge S must verify the contrast sentence in §1.2 is precise and accurate |
| II.3 — Resolution-axis transposition novelty | S, E | Memo: explicit one-paragraph statement of what the *resolution-axis transposition* contributes that *optimization-axis* surrogate calibration does not | The contribution is non-trivial, non-trivially novel, and non-derivable as a special case of any cited prior work | Demoting the transposition to "obvious reframing" or elevating it to "new decision theory" — both wrong (round 6 [Strategic S-2]) |
| II.4 — GNN-side novelty | G, E | Memo: are Cor 4 (half-chain), Theorem 5 (depth-monotonicity characterization), Prop 6 (two-query identity) genuinely new in the GNN-expressivity literature? | Each result either has no precedent or is precisely positioned against a precedent (e.g. Xu et al. for the GIN aggregator hierarchy) | Treating the half-chain as the *full* chain (round 4 [Critical C-1]); claiming over-smoothing characterization where the literature only has qualitative |
| II.5 — PCP-analogy hedging audit | S, E | Verify every PCP reference reads as analogy, never as claim | §1 and §8 all hedge; §7 is the locally-checkable half (proved); OP3 is the gap-amplification half (open) | Strengthening the analogy to a claim — would invalidate the FOCS submission strategy without OP3 |
| II.6 — Sierpiński / atomless realizability literature | S, F | Memo: every realizability hypothesis in the four typeclasses + every "atomless probability space" reference in the paper, traced to the closest mathlib-pending or classical-literature precedent | Each typeclass has a documented Sierpiński-derivation and a documented mathlib-PR strategy (opportunity #1) | Treating the typeclasses as project-specific axioms rather than as Sierpiński-pending instances (would weaken the kernel's standing) |
| II.7 — Mechanization-as-contribution positioning | F, E | Memo: where does a 57-theorem axiom-clean Lean kernel sit in the ITP literature? Is the *partition-functional-inequality abstraction layer* (Phase C2 + Phase D infrastructure) reusable beyond this project? | Judge F identifies at least three potential reusers in the mathlib/ITP ecosystem, or formally records that the kernel is project-specific | Over-claiming reusability (would set the bar too high for the ITP submission); under-claiming (would miss the two-paper opportunity) |

**Phase II gate.** Phase II closes when all seven tasks are ✓, every novelty claim has a precise contrast sentence in the paper, and Judge S has formally signed off that no closer precedent exists.

### Phase III — Exposition (elegance and clarity)

| Task | Lead | Deliverable | Pass criterion | Known failure modes |
|---|---|---|---|---|
| III.1 — Abstract audit | E | Read the abstract aloud (literally) and time it | Under 90 seconds aloud; lead paragraph contains the result, not the framing; scope/honesty paragraph is a single paragraph; mechanization sentence is one clause | Abstracts that bury the contribution under three classical citations (round 6 [Strategic S-2] precedent) |
| III.2 — §1.1 contribution-list ordering audit | E | Verify the four-item list leads with the GNN consequences (item 1) and ends with the methodology framing (item 4) | The casual page-2 reader sees the deliverables before the meta-frame | Lead-with-framing trap (item ordering reversed in earlier drafts) |
| III.3 — Theorem-statement precision audit | T | Each theorem statement: minimum-sufficient hypothesis set; conclusion crispness; explicit measurability/realizability clauses where Lean has them | No theorem requires the reader to infer a missing hypothesis from the proof | Theorem 1 missing "measurable labelings" for two drafts (round 5 / round 7); Theorem 2′ missing the same for one draft (round 7 [Material 1]) |
| III.4 — Worked-example audit | T, G | Verify Worked Example A is the minimum-complexity Step-1 violation and Worked Example B is the minimum-complexity slack mechanism | No simpler example exists that demonstrates the same point | Worked Example A's predecessor used decimal $(0.6, 0.373, 0.027)$ — Draft 0.6 replaced with rational $(2/3, 1/6, 1/6)$ as the cleanest minimum (round 6 [Critical C-1] closure) |
| III.5 — Cross-reference network audit | E | Map: every claim in §1 has a forward link to its proof; every theorem has backward links to the §1.1 contribution it supports | Every paper-side claim is locatable in two clicks | Forward-only or backward-only links isolate readers |
| III.6 — Hypothesis-name discipline | T, F | Audit: do the paper hypotheses use the same names as the Lean hypotheses? Where they differ, is the difference documented? | Every paper-Lean naming gap is in Appendix A's cross-reference table | "atomless probability space" vs four `*Realizable*` typeclasses — currently documented in Appendix A.7, must remain consistent |
| III.7 — Equation-display elegance | T, E | Audit: every $\boxed{\,\cdot\,}$ display, every multi-line $\bar\varphi$ derivation, every cell-rate inverse formula. Are they minimum-display? Do they read aloud? | Every displayed equation is read-aloud-able (no buried subscripts, no excessive nesting) | The §4.1 boxed bracket display is correctly framed; the §3 chord-argument equation should be checked for read-aloud-ability |
| III.8 — §6 three-axis classification audit | G, E | Verify the three-axis classification (lattice position × WL-faithfulness × quantization-collapse regime) is the minimum-sufficient taxonomy | No fourth axis is implicitly carried; each named architecture (GIN, GCN, GAT, GraphSAGE, JK, GCNII, transformers) has a unique coordinate | The taxonomy is the §6 climax — must be the cleanest possible cut |
| III.9 — Open-problem prose audit | E | Each of OP1b, OP2, OP3: is it stated as an open problem (not as a claim), is the deferral honest, is the partial progress (e.g. OP1a as solved by §4) clearly delineated? | No open problem is stated as if resolved; no resolved problem is stated as if open | OP1a was once flagged as open before §4 closed it (round 4 [Minor m-5]) |

**Phase III gate.** Phase III closes when all nine tasks are ✓, every theorem statement is at minimum-sufficient hypothesis strength, and the abstract reads under 90 seconds aloud.

### Phase IV — Mechanization (Lean kernel audit)

| Task | Lead | Deliverable | Pass criterion | Known failure modes |
|---|---|---|---|---|
| IV.1 — Fresh-clone reproducibility | F | Run the harness `verify/run-all.ps1` from a fresh clone of `https://github.com/elouafiqAli/rigifity.git` | Exit 0; `HARNESS: PASS`; build green; `PrintAxioms.lean` clean; numerics pass | Toolchain drift (Lean 4 toolchain pin must remain `v4.29.1`); WSL-only assumptions in the harness should fail gracefully |
| IV.2 — Axiom-clean verification | F | Run `lake env lean Audit/PrintAxioms.lean`; verify every output line ends in `[propext, Classical.choice, Quot.sound]` | Exactly 57 `depends on axioms` lines; zero non-trusted axioms; zero `sorryAx` | An accidental `sorry` in a non-`@[rigidity_proved]` declaration would not be caught by the audit harness — Judge F must `grep -rn "sorry" lean/Rigidity/` separately |
| IV.3 — Appendix A row-by-row cross-reference | F | For each of the ~50 rows in Appendix A.2/A.3/A.4, locate the named Lean declaration and verify (a) it exists, (b) its statement matches the paper's claim, (c) its hypothesis list matches Appendix A's | 100% match on all rows | A row claiming a Lean declaration that is no longer in the kernel; a row understating the actual Lean hypothesis list |
| IV.4 — Realizability-typeclass audit | F, T | For each of the four typeclasses: read the Lean statement, verify it captures the paper's "atomless realizability" hypothesis, check that the Sierpiński-derivation sketch in [`.research/2026-06-05-sierpinski-atomless-realizability.md`](.research/2026-06-05-sierpinski-atomless-realizability.md) is correct | All four typeclasses are consistent with each other, with the paper, and with the Sierpiński-PR plan | A typeclass that is *strictly stronger* than what Sierpiński gives — would invalidate the "single PR closes all four" claim |
| IV.5 — Lean term sizes vs paper claims | F | For each major Lean term (e.g. `theorem1`, `simplex_rigidity`, `barPhi_refinement_le`), compare the Lean proof structure against the paper's proof gloss | The Lean proof structure matches the paper's gloss (modulo Lean-specific bookkeeping like the empty-cell filter) | A Lean proof that takes a structurally different route than the paper would force a paper-side rewrite to match |
| IV.6 — Worked Example numerics audit | F | Verify the `WorkedExample.lean` `native_decide` checks for both Examples A and B, against an independent computation in `verify/numerics.py` | Lean and Python agree to the last digit; both match the paper | Decimal-vs-rational discrepancies; the original Worked Example A used decimals that didn't land at exactly $\varphi_G = 1/2$ |
| IV.7 — `affine_of_jensen_eq` independence verification | F | Verify that `simplex_rigidity` does **not** depend on `affine_of_jensen_eq` (the chord-trick standalone). The two were landed independently in Phase D for documentation, but `simplex_rigidity` proves Step 2 directly via `TwoCellRealizableSimplex` + chord pinning at vertex 0 | `lake build` of `simplex_rigidity` succeeds even if `affine_of_jensen_eq` were `sorry`'d (paper-side documented in Appendix A.3) | A mistaken Lean refactor that *introduces* a dependency from `simplex_rigidity` on `affine_of_jensen_eq` — would change the Phase D narrative |
| IV.8 — Mathlib-pin audit | F | Verify `lean/lean-toolchain` and `lean/lakefile.toml` both pin `v4.29.1`; verify `lean/lake-manifest.json` is committed and consistent | All three files agree on the toolchain pin | Drift between the toolchain pin and the mathlib pin will silently cause cache misses and forced builds (the [`wsl-lean-bridge`](.agents/skills/wsl-lean-bridge/SKILL.md) skill documents this) |
| IV.9 — Theorem 1′ Lean-status accuracy | F, E | Verify Appendix A.3 row "Theorem 1′" reads "*paper-side only; direct port of `barPhi_refinement_le` deferred*" and the Mechanization paragraph in §1.2 explicitly states the Theorem 1′ deferral | The paper does not mis-claim Theorem 1′ as mechanized | Round 7 [Material 2] precedent — the asymmetry was honest by selective listing but invited a referee question; Draft 0.7 closed it |

**Phase IV gate.** Phase IV closes when all nine tasks are ✓, the harness passes from a fresh clone, and Judge F formally signs off that the Lean kernel and Appendix A are in tightest possible reconciliation.

### Phase V — Strategic (venue, companion, robustness)

| Task | Lead | Deliverable | Pass criterion | Known failure modes |
|---|---|---|---|---|
| V.1 — Theory-venue analysis | E | Memo: ITCS, MFCS, COLT, JMLR, AoS, JR Stat. Soc. B. For each: estimated acceptance probability, fit with paper structure, expected referee profile | At least three theory venues are identified as "very high confidence" submissions | Treating ITCS as a venue for the empirical companion (wrong) or AoS for the GNN-consequence half (wrong) — venue/content mismatch |
| V.2 — GNN/ML-venue analysis | E, G | Memo: NeurIPS theory track, ICML theory track, COLT, ICLR. For each: empirical-companion expectation, fit with the floor-vs-achieved framing, expected referee profile | At least one ML-theory venue is identified as "high confidence" without an empirical companion attached | Treating NeurIPS-main as a venue for theory-only submissions (no longer plausible) |
| V.3 — ITP-venue analysis | E, F | Memo: ITP, CPP, LICS, JAR. For each: fit of the 57-theorem kernel as a standalone contribution, the partition-functional-inequality abstraction layer's framing | At least one ITP venue is identified as "high confidence" for the kernel as a standalone | Under-claiming the kernel ("niche") or over-claiming ("solves the entire calibration formalization gap" — wrong) |
| V.4 — Empirical-companion scope | G, E | Memo: what experiments belong in the empirical companion paper? Cor 4, Theorem 5, Prop 6 each suggest specific benchmarks (heterophilous node tasks, depth sweeps, label-complexity gauges); a paragraph stating which are minimum-viable for a companion submission | The companion paper has an explicit, honest scope statement | Promising experiments the paper cannot deliver, or under-promising ones the paper invites |
| V.5 — Sierpiński PR readiness | F | Memo: concrete plan to upstream Sierpiński's theorem on atomless measures to mathlib. Statement, proof sketch, target file, expected reviewer | The PR has a draft statement and a target mathlib file (probably `Mathlib/MeasureTheory/Measure/Typeclasses/NoAtoms.lean`) | A vague "we'll upstream eventually" plan — would weaken the Mechanization paragraph from "in flight" to "eventually" |
| V.6 — Open-problem-roadmap audit | E, T, G | Memo: each of OP1b, OP2, OP3 — what does the next paper look like? Is the deferral honest? Is the partial progress (Phase D for OP1a, Phase E preview for OP1b, OP2 working assumption, OP3 PCP-companion question) precisely scoped? | Each open problem has an honest scope and a plausible path to a follow-up paper | OP1b ("soft cell assignments") is the natural Phase E target — Judge G must verify this is the highest-leverage research direction |
| V.7 — Paper-track sequencing | E | Memo: one-paper, two-paper, or three-paper publication strategy. (Theory only / Theory + ITP / Theory + ITP + empirical companion.) Judge E recommends one. | A specific track is recommended with specific reasoning | Recommending "publish everything everywhere" — would dilute the contribution; recommending a single-paper track when the kernel is independently publishable would leave value on the table |
| V.8 — Long-horizon project state | E, F | Memo: where will this paper be in 2 years? In 5 years? Will the Lean kernel still build against mathlib of that era? Will the GNN literature still position this work as the floor characterization, or will it be superseded? | The 5-year mathematical relevance is non-trivial; the kernel has a documented forward-compatibility plan (e.g. `lake update` discipline) | Treating the paper as a one-shot deliverable rather than the seed of a research program |
| V.9 — Risk-register audit | E, G | Update [`16-end-to-end-audit-and-publishability.md`](16-end-to-end-audit-and-publishability.md) with Phase D + round 7 + Panel-charter findings | The risk register lists every open risk with its mitigation | Risks 1–5 of round 7 are the baseline; Phase V may surface new risks |

**Phase V gate.** Phase V closes when all nine tasks are ✓, Judge E delivers the venue recommendation, and the empirical companion has an explicit scope. If Judge E vetoes the publication-readiness verdict on positioning grounds (per §1's veto scope), Phase V rolls into a closure round.

### Phase VI — Synthesis (panel verdict)

| Task | Lead | Deliverable | Pass criterion |
|---|---|---|---|
| VI.1 — Per-judge verdict memos | T, S, G, F, E | Each judge writes a memo: per-task ✓ / [Material] / [Critical] / [Strategic] / [Positive] tags, with line-citations | Five memos delivered to the coordinator, sealed, no inter-judge consultation prior to delivery |
| VI.2 — Panel-verdict synthesis | Coordinator | Consolidated panel-verdict document (template in §9) | All five judges sign off on the synthesis (signing requires reviewing the consolidated document, not their own memo only) |
| VI.3 — Final pass / fail / conditional-pass decision | Panel (consensus) | Single-line verdict: **PASS** (journal-ready as-is), **CONDITIONAL PASS** (journal-ready after named items closed in a final closure round), **FAIL** (additional Phase rolled into a closure round, panel reconvenes) | Unanimous on PASS or FAIL; coordinator may break a single dissent on CONDITIONAL PASS, recording the dissent |
| VI.4 — If PASS: publication-strategy recommendation | E (lead), all judges sign | The recommended publication track (one-paper / two-paper / three-paper) with venue choices and a 12-month execution plan | Concrete venue + concrete submission deadline for each paper in the track |
| VI.5 — If CONDITIONAL PASS: closure-round assignment | Coordinator | Severity-tagged action list with assigned judge for each item | Every action has a deliverable and a deadline; the closure round is scoped (no scope creep into another phase) |
| VI.6 — If FAIL: phase rollback | Coordinator | A specific phase is re-opened with a new task list addressing the [Critical] findings | The re-opened phase has a clear pass criterion and a committed second-attempt deliverable |
| VI.7 — Archive | Coordinator | Add a `19-panel_verdict.md` (or successor) to the repo, with the full audit trail | The verdict is reproducible: any future reader can re-run the harness, re-read the per-judge memos, and reconstruct the decision |

---

## 4. Severity scheme

The panel uses the round-1-through-round-7 severity scheme, extended with the round-7 "Positive" tag.

| Tag | Definition | Phase impact | Closure expectation |
|---|---|---|---|
| **[Critical]** | Mathematical error, false theorem, or load-bearing wrong claim. Threatens publishability. | Blocks the phase. Must be closed before the phase passes. | Same-phase fix or phase rollback. |
| **[Material]** | Mathematically correct but expositionally defective: missing hypothesis, mis-stated conclusion, incorrect attribution. | Phase passes if and only if [Material] count ≤ 3 and each has a documented disposition (fix / accept-with-justification / defer). | Closure-round fix or formal documentation of the deferral. |
| **[Minor]** | Cleanup item: jargon, paragraph breaks, citation formatting, redundant text, unused variable. | Phase passes regardless; aggregated for end-of-phase polish. | Best-effort fix, optional formal closure. |
| **[Strategic]** | Positioning, venue fit, presentation order, contribution emphasis. | Phase V's domain. Other phases flag for E's attention. | Judge E adjudicates. |
| **[Positive]** | A finding where the paper or kernel is *stronger* than its own statement claims. (E.g. round-7 Positive 1: Lean proved Theorem 2′ under strictly weaker hypotheses than the §4.1 simplex-score definition imposed.) | Should be folded into the next draft, strengthening the paper. | Judge T or F drafts the strengthening clause. |

**Severity-escalation discipline.** A judge cannot escalate a tag in their domain (e.g. T cannot tag a [Material] in §3 as [Critical] without producing a counterexample to the theorem). Escalation requires either a counterexample (for [Material] → [Critical]) or a citation to a closer prior work (for an originality [Strategic] → [Material]).

---

## 5. Inter-phase gate criteria

A phase passes when all of the following hold:

1. **All listed tasks are ✓.** Every task in the phase's task list has its deliverable signed off by the lead judge.
2. **Zero [Critical] open.** No [Critical] finding from the phase remains unaddressed.
3. **[Material] count ≤ 3.** The phase has at most three open [Material] findings, each with a documented disposition.
4. **Lean build green.** Even in non-mechanization phases, every Lean change a fix introduces must keep the harness passing.
5. **Audit trail recorded.** All per-judge deliverables are committed to the repo (in the same numbering scheme as `05`, `07`, `10`, `12`, `00-external`, `17` — i.e., a per-round audit file plus a per-draft closure file).

A phase **fails** when:

- Any [Critical] finding is open at the phase deadline, **or**
- More than three [Material] findings are open at the phase deadline, **or**
- A judge formally invokes their veto scope (per §1).

A failed phase rolls into a **closure round** (§6). The phase does not proceed to the next phase until the closure round delivers a clean Phase Pass.

---

## 6. Closure round protocol

Closure rounds inherit the discipline of rounds 1–7. Each closure round produces:

1. **A round file** (e.g. `19-panel_round_a.md`, `20-panel_round_b.md`, …) following the template of [`17-pi_adversarial_audit_of_draft0.6_post_phase_d.md`](17-pi_adversarial_audit_of_draft0.6_post_phase_d.md):
    - 0. Assessment strategy (the lens used)
    - 1. Correctness pass — theorem by theorem (re-verified)
    - 2–7. Severity-tagged findings ([Critical], [Material], [Minor], [Strategic], [Positive])
    - 8. Prioritized action list

2. **A closure draft** of the affected paper sections or Lean modules, with a commit message summarizing the audit closure (see `Phase D close` commit `f3b0dd1` for the template).

3. **A panel re-vote** if the closure round was triggered by a [Critical] or veto. The vote is binary (closed / not-closed); the coordinator does not adjudicate.

**Closure-round scoping discipline.** A closure round addresses *exactly* the findings that opened it. Scope creep (using a closure round to fix unrelated items) is grounds for the coordinator to extend the round into a fresh phase.

**Closure-round limits.** If a single phase requires three or more closure rounds, the coordinator must escalate to a panel-level review of whether the phase scope was correctly defined. Recurring closure rounds are a process failure, not a content failure.

---

## 7. Long-horizon timeline

The panel's work is **not** a sprint. It is a long-horizon multi-month project. Realistic estimates:

| Phase | Estimated duration | Parallelization opportunity |
|---|---|---|
| **Phase I** (Foundations) | 2–3 weeks | Each judge re-derives independently; no inter-judge coordination until phase close |
| **Phase II** (Originality) | 1–2 weeks | S, E primarily; T, G, F provide domain inputs. Literature search dominates the timeline. |
| **Phase III** (Exposition) | 1–2 weeks | T, E primarily; multiple read-aloud passes |
| **Phase IV** (Mechanization) | 1 week | F primarily; T cross-checks Appendix A row-by-row |
| **Phase V** (Strategic) | 1 week | E synthesizes; T, S, G, F deliver per-domain venue inputs |
| **Phase VI** (Synthesis) | 1 week | All five judges + coordinator |
| **Closure rounds** (if any) | 1 week per round | Per-round, one judge primarily |

**Total nominal horizon: 8–12 weeks.** With one or two closure rounds (typical for a paper at this scale), 10–14 weeks is realistic.

**Holding patterns.** Between phases, the coordinator should *not* fill gaps with manuscript revisions. Phase boundaries are commit-able freezes: the manuscript does not change between Phase II close and Phase III open, even if a judge has a pet revision in mind. This ensures Phase III judges Phase II's output, not their own.

**Mid-phase work pattern.** Within a phase, judges work asynchronously. Each judge produces their per-task deliverables on a self-paced schedule; the coordinator monitors a Kanban-style task list. Inter-judge communication is via written memo (no Slack-style realtime — the writing discipline is part of the audit quality).

---

## 8. Tooling and reference baselines

The panel inherits the project's tooling. Each judge should familiarize themselves with the following, in this order:

### 8.1 Project skills (mandatory reading before Phase I)

- [`.agents/skills/lean-proof/SKILL.md`](.agents/skills/lean-proof/SKILL.md) — proof methodology (one tactic at a time, error priority, hardest case first)
- [`.agents/skills/tao-step-by-step-proving/SKILL.md`](.agents/skills/tao-step-by-step-proving/SKILL.md) — step-by-step skeletonization (origin of Phase D's chord-trick discovery)
- [`.agents/skills/tao-red-team-audit/SKILL.md`](.agents/skills/tao-red-team-audit/SKILL.md) — red-team audit workflow (the round-1-through-7 origin)
- [`.agents/skills/wsl-lean-bridge/SKILL.md`](.agents/skills/wsl-lean-bridge/SKILL.md) — toolchain pattern; Phase IV reproducibility prerequisite
- [`.agents/skills/solo-blueprint-workflow/SKILL.md`](.agents/skills/solo-blueprint-workflow/SKILL.md) — blueprint-workflow patterns relevant to Judge F's Phase IV work
- [`.agents/skills/rigidity-indexer/SKILL.md`](.agents/skills/rigidity-indexer/SKILL.md) — searching `.samples/` blueprint reference archive (Phase II prior-art search)

### 8.2 Audit harness (mandatory for Phase IV)

```powershell
git clone https://github.com/elouafiqAli/rigifity.git
cd rigifity
./verify/run-all.ps1
```

Expected output: `HARNESS: PASS` with build green (2172 jobs), `PrintAxioms.lean` showing all 57 declarations clean, Python numerics passing. See Appendix B §B.4 of the paper.

### 8.3 Reference baselines (audit trail)

The panel should treat the seven prior rounds as **evidence, not redundant work**. Each prior round's audit file is a completed independent re-derivation of every theorem; the panel's Phase I should *cross-check* against these, not redo them from scratch.

| Round | File | Severity profile | Closure |
|---|---|---|---|
| 1 | [`05-pi_adversarial_audit_of_draft0.md`](05-pi_adversarial_audit_of_draft0.md) | C×2 + M×5 | Draft 0.1 ([`06`](06-draft0.1_commitology.md)) |
| 2 | [`07-pi_adversarial_audit_of_04.md`](07-pi_adversarial_audit_of_04.md) | M×2 | Draft 0.2 ([`08`](08-draft0.2_commitology.md)) |
| 3 | [`10-external_reviewer_audit_of_draft0.2.md`](10-external_reviewer_audit_of_draft0.2.md) | M-class + presentational | Draft 0.3 ([`11`](11-draft0.3_commitology.md)) |
| 4 | [`12-external_reviewer_second_audit_of_draft0.3.md`](12-external_reviewer_second_audit_of_draft0.3.md) | C×1 + M×4 | Draft 0.4 ([`13`](13-draft0.4_commitology.md)) |
| 5 | (closing notes in [`03`](03-t0-achievable_error_floor.md) tail, Draft 0.5 entry) | M×1 + m×6 | Draft 0.5 |
| 6 | [`00-external.md`](00-external.md) | C×1 + M×3 + S×2 | Draft 0.6 |
| 7 | [`17-pi_adversarial_audit_of_draft0.6_post_phase_d.md`](17-pi_adversarial_audit_of_draft0.6_post_phase_d.md) | M×2 + m×3 + Positive×1 | Draft 0.7 |

The audit signal **converged** through round 7. The panel's job is not to re-converge it but to apply a different lens (panel-grade, multi-domain, journal-targeted) and verify that the convergence holds under that lens.

### 8.4 Strategic baselines

- [`16-end-to-end-audit-and-publishability.md`](16-end-to-end-audit-and-publishability.md) — publishability snapshot (post Phase D update)
- [`14-harness_and_reproduction.md`](14-harness_and_reproduction.md) — brick-DAG, reproducibility plan
- [`09-mechanization_strategy.md`](09-mechanization_strategy.md) — Lean-side strategy memo (predates Phase B–D execution; useful as a *what-was-promised* reference)
- [`.research/opportunities.md`](.research/opportunities.md) — open mathlib opportunities (#1: Sierpiński PR)

---

## 9. Final verdict template

The Phase VI panel-verdict document follows this template. The coordinator drafts it; the five judges sign.

```
# Panel Verdict — [paper ID, Draft 0.7 (Final), commit X]

## 0. Headline (one paragraph)

[The single sentence summary of the panel's recommendation.
PASS / CONDITIONAL PASS / FAIL.
Followed by the recommended publication track (one-paper / two-paper / three-paper)
with named venues and submission deadlines.]

## 1. Per-judge sign-off

| Judge | Verdict | Veto invoked? | Per-judge memo |
|---|---|---|---|
| T (theory) | ✓ / × | yes/no | [link to per-judge memo] |
| S (statistics) | ✓ / × | yes/no | [link] |
| G (graph ML) | ✓ / × | yes/no | [link] |
| F (formal methods) | ✓ / × | yes/no | [link] |
| E (editor) | ✓ / × | yes/no | [link] |

## 2. Per-phase summary

| Phase | Status | Open findings | Closure rounds run |
|---|---|---|---|
| I — Foundations | PASS / FAIL | [list] | [number] |
| II — Originality | PASS / FAIL | [list] | [number] |
| III — Exposition | PASS / FAIL | [list] | [number] |
| IV — Mechanization | PASS / FAIL | [list] | [number] |
| V — Strategic | PASS / FAIL | [list] | [number] |
| VI — Synthesis | (this document) | — | — |

## 3. Open action list (if CONDITIONAL PASS)

[Severity-tagged list. Each item has an owner, a deliverable, and a deadline.]

## 4. Risks and mitigations (acknowledged)

[The risks the panel is aware of and accepts as part of the PASS, with mitigations.
E.g.: Sierpiński PR is in flight and not yet merged; mitigation = Mechanization paragraph
flags the four typeclasses as Sierpiński-pending.]

## 5. Publication-strategy recommendation (if PASS)

[Specific venues for each paper in the track, with submission timing.
Example:
  - Paper 1 (theory): COLT 2026 deadline (April), AoS otherwise.
  - Paper 2 (ITP): CPP 2027 deadline (Sep 2026).
  - Paper 3 (empirical): NeurIPS 2026 deadline (May 2026), separate authorship.]

## 6. Strategic risks acknowledged

[Empirical companion is on a separate timeline; the theory paper does not gate on it.
The Sierpiński mathlib PR closes the kernel's typeclass gaps. The OP1b soft-cell-assignment
extension is the natural Phase E target.]

## 7. Audit trail

[Pointers to all seven prior rounds, the panel's Phase I–V deliverables, and the
final synthesized verdict commit.]

## 8. Sign-offs

[Per-judge signature lines. The coordinator countersigns as a process witness, not a vote.]
```

---

## 10. Non-negotiables

The panel cannot issue PASS unless every item below holds. These are the bar for "highest level of elegance and correctness."

1. **Zero [Critical] findings open at panel close.**
2. **Zero `sorry` bodies in the Lean kernel's main namespace** (currently `lean/Rigidity/`); the four Sierpiński-pending typeclasses are external hypotheses, not internal `sorry`s.
3. **All 57 `Audit/PrintAxioms.lean` entries clean** against `[propext, Classical.choice, Quot.sound]`.
4. **Reproducibility harness `verify/run-all.ps1` exits 0** from a fresh clone with no manual steps.
5. **Every theorem in the paper is at minimum-sufficient hypothesis strength** (as verified in Phase I.3 and III.3).
6. **Every novelty claim has a precise contrast against a specific prior result** (Phase II).
7. **Every load-bearing equation reads aloud** without syllable-counting (Phase III.7).
8. **The empirical companion has an explicit scope** (Phase V.4) — even if "no companion paper planned," that is an acceptable scope statement.
9. **The Sierpiński PR has a draft statement and a target mathlib file** (Phase V.5).
10. **The publication-strategy recommendation is concrete** — venue, deadline, and at least one fall-back venue per paper in the track (Phase V.7).

Items 1–4 are technical. Items 5–7 are mathematical-elegance. Items 8–10 are publication-strategic.

---

## 11. Conduct guidelines

The panel operates under the following conduct discipline. Violations are grounds for the coordinator to invalidate a deliverable and request re-submission.

1. **Adversarial, not collaborative.** Each judge reads the paper as a hostile referee would, not as a co-author or supportive editor. The seven prior rounds were adversarial; the panel must not soften.
2. **Specific over general.** Every finding cites a specific line, equation, or theorem name. "The paper is unclear" is not a finding; "Equation (3) in §4.1 buries the dependence on $c_\varphi < \infty$" is a finding.
3. **Severity tags only.** Every finding carries one of the five tags from §4. Untagged commentary is not a finding and does not block a phase.
4. **Scoped rounds, scoped phases.** A judge cannot use Phase III to re-litigate a Phase I conclusion. Cross-phase escalation is allowed only via the coordinator and only with new evidence (not new opinion).
5. **No collusion.** Inter-judge communication is forbidden during a phase. Judges deliver their per-task deliverables independently. Phase VI synthesis is the *only* phase where consensus-building communication is permitted, and even there, the per-judge memos are sealed before delivery.
6. **No comprehensive review requests.** "Please review the whole paper" is not a task. Every task in §3 is scoped to a specific dimension. The coordinator rejects any task expansion.
7. **Read aloud.** Several Phase III tasks require literal reading aloud (the abstract, the boxed bracket display, the §6 three-axis classification). This is not optional. Reading aloud catches paragraph-density issues that silent reading misses.
8. **Re-derive, do not re-use.** Phase I judges re-derive every theorem from §2 definitions independently. They may not cite the paper's proof in their re-derivation memo. Cross-checks against the paper come *after* the independent derivation.
9. **Cite the prior rounds.** When a finding overlaps with one closed in rounds 1–7, the judge must cite the round and verify the closure remains valid. Re-opening a closed round requires new evidence and a coordinator sign-off.
10. **Time-box the phases.** A phase that cannot close within the §7 nominal duration plus 50% slack is escalated to the coordinator for scope reduction. The horizon is months, not years.

---

## 12. Closing remarks (charter author)

This charter is the operating frame for an eighth-and-definitive review. Its design is informed by the seven rounds the paper has already passed: the audit signal converged, the [Critical] count went to zero by round 5, the Lean kernel is axiom-clean end-to-end, and the round-7 finding profile (two [Material] reconciliation defects + one positive surprise + zero [Critical]) is the canonical "ready to ship" signature.

The panel's purpose is to verify that this signature holds **under journal-grade scrutiny by domain experts each holding a specific veto**. If the seven rounds were the convergent self-audit, the panel is the external-grade certification.

The bar is high but reachable. The paper has earned the right to be evaluated at this level. The kernel has earned the right to be checked claim-by-claim. The audit trail has earned the right to be cited as evidence rather than redone from scratch.

The panel's verdict, when it lands, will be the basis on which the manuscript is submitted to its target journal. A PASS is the journal-ready signal. A CONDITIONAL PASS is a one-cycle delay. A FAIL would invalidate the seven rounds' convergence and require deeper revision than this charter is scoped for.

The coordinator should expect a PASS or a CONDITIONAL PASS. A FAIL at this stage would be a signal that the panel discovered something the seven rounds missed — possible, but unlikely given the audit-signal convergence. If FAIL, the discovery is itself a significant outcome and should be archived with full provenance.

*Charter v1, 2026-06-06. Review-cycle horizon: 8–12 weeks nominal; 10–14 weeks realistic with one or two closure rounds. Subject: Draft 0.7 (Final) at HEAD `4dcf5cd`. Coordinator-of-record: TBD.*
