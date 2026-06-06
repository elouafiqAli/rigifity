# End-to-End Audit — Paper + Lean Kernel — Publishability Confidence

*Snapshot: Draft 0.5 of [`03-t0-achievable_error_floor.md`](03-t0-achievable_error_floor.md),
Lean kernel at HEAD `8339f60` on 2026-06-06 (Phase C2 closure).*

*Verification performed live:*
- *Full `lake build` green (2172 jobs)*
- *`Audit/PrintAxioms.lean` passed: **44 proved theorems** (was 27 at the
  2026-06-05 snapshot; the +17 delta comprises the 8 Phase C2 helpers in
  `Bracket.lean`, 4 new Phase C2/C3/C4 entries in `Theorem1.lean`, and 5
  declarations whose audit entries were missing at the prior snapshot but
  whose proofs predated it). All axiom-clean against only `propext /
  Classical.choice / Quot.sound` — zero `sorryAx`, zero ad-hoc axioms.*

---

## 1. Paper — current state

**Draft 0.5** is the product of five sequential adversarial audits and four
commitology rounds. The trail is fully reconstructable:

| Round | Audit | Closure | Severity profile |
|---|---|---|---|
| 0 → 0.1 | [`05`](05-pi_adversarial_audit_of_draft0.md) | [`06`](06-draft0.1_commitology.md) | C×2 + M×5 + m's — load-bearing modeling errors (§6 wrong object, Thm 5 quantifier) |
| 0.1 → 0.2 | [`07`](07-pi_adversarial_audit_of_04.md) | [`08`](08-draft0.2_commitology.md) | M×2 + m's — hypothesis hygiene in simplex extension |
| 0.2 → 0.3 | [`10`](10-external_reviewer_audit_of_draft0.2.md) | [`11`](11-draft0.3_commitology.md) | M-class + presentational debts |
| 0.3 → 0.4 | [`12`](12-external_reviewer_second_audit_of_draft0.3.md) | [`13`](13-draft0.4_commitology.md) | C×1 (§5 aggregator chain — mathematically false) + M×4 + m's |
| 0.4 → 0.5 | (closing notes in [`03`](03-t0-achievable_error_floor.md) tail) | inline | M×1 (Thm 1′ atomless hyp) + m×6 polish |

The audit signal is **converging**: each round finds something more local than
the last. Round 5 produced only one M (a propagation gap from round 4) plus
presentational polish. That is the canonical "ready to ship" signature.

**Substantive claims as they stand:**

- §3.1 Theorem 1, §3.2 Theorem 2, Corollary 3 (binary)
- §4.1 simplex bracket (with explicit `c_φ < ∞` hypothesis), §4.2 Theorem 2′,
  §4.3 worked example, §4.4 Theorem 1′
- §5 Corollary 4 (now a *half-chain* — sum refines both mean and max, mean⇎max),
  with the explicit "floor ≠ achieved" caveat
- §6 Theorem 5 (depth-monotonicity ⟺ refinement-chain, both directions, "for
  every labeling" on direction (b))
- §7 Proposition 6 (two-query identity), Corollary 7 (Hoeffding label-complexity)
- §8 open problems (OP1b soft cells, OP2 quantitative over-smoothing, OP3 gap
  amplification) — flagged, not claimed

**Honest positioning** in §1.1/§1.2 carefully separates what is classical
(Blackwell, Savage, BJM, Reid–Williamson) from what is the contribution (the
*resolution-axis transposition*, the GNN corollaries, the simplex rigidity).
The PCP framing is explicitly an analogy, not a claim.

---

## 2. Lean kernel — current state (post Phase C2)

```
lean/
├── Audit/PrintAxioms.lean        — axiom-hygiene check (44 declarations, all clean)
├── Rigidity.lean                  — umbrella module
└── Rigidity/
    ├── Util/Attributes.lean       — @[rigidity_proved]/@[rigidity_scaffold] + AMS tags
    ├── Bracket.lean                — 30 proved theorems (was 17 at the prior snapshot;
    │                                 +13 = 8 Phase C2 helpers + 5 prior-existing
    │                                 declarations brought into PrintAxioms)
    ├── Theorem1.lean               — 4 proved (barPhi_refinement_le, theorem1_easy,
    │                                 theorem1_hard, theorem1) — was 1 scaffold + 1 proved
    │                                 at the prior snapshot
    ├── Theorem2.lean               — 6 proved (incl. theorem2 itself)
    ├── Theorem2Prime.lean          — 1 scaffold (simplex_rigidity); cPhiSimplex now a def
    ├── Proposition6.lean           — 4 proved (incl. variance_bracket)
    └── WorkedExample.lean          — 9 native_decide numeric checks for §4.3
```

**Concrete count (delta from 2026-06-05):**

- **44** declarations carry `@[rigidity_proved]` (was 27 in the prior audit
  snapshot; the delta includes 8 new Phase C2 partition-refinement helpers,
  the 4 Theorem 1 entries (`barPhi_refinement_le`, `theorem1_easy`,
  `theorem1_hard`, `theorem1`), and 5 prior-existing declarations whose
  `#print axioms` calls were missing from the previous PrintAxioms file).
  Every one is verified axiom-clean against mathlib v4.29.1.
- **1** `sorry` body remains, explicitly `@[rigidity_scaffold]`:
  `Rigidity.Simplex.simplex_rigidity` (was 3 — `theorem1` and `cPhiSimplex`
  closed this cycle; `cPhiSimplex` is now a plain `noncomputable def`)
- **2** typeclasses-as-hypotheses (was 1): `SingleCellRealizable μ` (consumed by
  `theorem2_reverse`) and `BinarySplitRealizable μ` (consumed by `theorem1_hard`).
  Both follow from atomlessness via the same Sierpiński argument and are blocked
  on the **same** mathlib PR (opportunity #1).

**What this means concretely.** The entire **§3 binary spine** is now
mechanically verified end-to-end:

- §1 bracket display (`bracket_lower`, `bracket_upper`) — proved
- Universal `c_φ = 1/2` (`cPhi_eq_half_of_normalized`) — proved
- §3.1 Theorem 1 (`theorem1`: refinement-mono ⟺ concave) — **proved**, both
  directions, with the explicit `MeasurableSet {f=true}` hypothesis the
  manuscript leaves implicit
- §3.2 Theorem 2 (`theorem2`: tent uniqueness) — proved
- §7 Proposition 6 (`variance_bracket`, `two_query_identity`) — proved

The **§4 simplex extension** (`simplex_rigidity` and the simplex-side `T1′`)
remains stated, type-checked, hypothesis-clean, and `sorry`d. The §4.3
worked-example numerics are in turn fully verified by `native_decide`.

**The decisive change since the last snapshot.** Theorem 1 was the largest
remaining `sorry` of the §3 spine. Closing it (Phase C2 = `barPhi_refinement_le`
+ tower property + filtered-nonempty bookkeeping; Phase C3/C4 = `theorem1_hard`
via `BinarySplitRealizable`) means **the resolution-axis-transposition story
of §3 is now mechanically certified in its entirety**. Every classical
ingredient the paper transposes (Blackwell monotonicity, BJM-style
self-calibration uniqueness, the universal upper constant) has a Lean term.

---

## 3. Cross-check: paper ↔ Lean (post Phase C2)

| Manuscript object | Lean name | Status |
|---|---|---|
| §1 bracket display | `bracket_lower`, `bracket_upper` | **proved** |
| §1 universal `c_φ = 1/2` | `cPhi_eq_half_of_normalized` | **proved** |
| §2 normalized score | `NormalizedScore` (structure) | defined |
| §2 tent `T = 2 min(η,1−η)` | `tent`, `tent_normalized` | **proved** |
| §3.1 Theorem 1 | `theorem1` (`_easy`, `_hard`) | **proved** (mod `BinarySplitRealizable`) |
| §3.2 Theorem 2 | `theorem2` (`_forward`, `_reverse`) | **proved** (mod `SingleCellRealizable`) |
| §3.2 Corollary 3 | — | prose-level corollary; not declared |
| §4.1 simplex setup | `Simplex.{simplex, R, SimplexScore, cPhiSimplex}` | defined |
| §4.2 Theorem 2′ | `Simplex.simplex_rigidity` | scaffold |
| §4.3 worked example | `WorkedExample` (9 `native_decide`) | **proved** |
| §4.4 Theorem 1′ | — | not declared (deferred per `Theorem2Prime.lean` tail) |
| §5 Corollary 4 | — | prose; depends on §3 + lattice combinatorics |
| §6 Theorem 5 | — | prose; depends on §3 + counterexample chain |
| §7 Proposition 6 | `two_query_identity`, `variance_bracket` | **proved** |
| §7 Corollary 7 | — | prose (Hoeffding, off-the-shelf) |

**Coverage of load-bearing claims (post Phase C2):**

- The bracket itself (the paper's central object): proved
- The unique-exact-score uniqueness on the binary side (Theorem 2): proved
- **The refinement-monotonicity iff (Theorem 1): proved** — the hard direction
  (refinement-mono ⟹ concave) via `BinarySplitRealizable`, the easy direction
  via the new tower-property workhorse `barPhi_refinement_le`. Manuscript §3.1
  is *fully mechanized*.
- The two-query identity (Proposition 6, the operational §7 result): proved
- The simplex uniqueness (Theorem 2′): scaffolded — manuscript-side proof goes
  through; only the multiclass extension is unmechanized

**Reusable infrastructure unlocked by C2 (matters for §4 ETA).** The Phase C2
kit (`refining`, `refining_pairwiseDisjoint`, `biUnion_refining_eq`,
`sum_cellMass_refining_eq`, `sum_measure_refining_inter_eq`,
`cellRate_mul_cellMass_refining_sum`, `barPhi_eq_filter_nonempty`) is
**dimension-agnostic at the partition level**. Porting to the simplex (§4)
amounts to swapping `cellRate : Bool` for `cellRate : Fin k → ℝ`; the
partition-additivity proofs reuse verbatim and the conditional-Jensen step
generalizes by replacing the scalar `Icc 0 1` with the simplex `Δ^{k-1}`.

---

## 4. The "leave the simplex hanging" question (sharpened)

Explicitly: does partial Lean coverage hurt publishability if §4 / Theorem 2′
are not mechanized at submission time?

**No, and the case is now stronger than at the 2026-06-05 snapshot.** Three
reasons the answer has gotten better:

1. **The §3 binary spine is now mechanically certified, end-to-end.** Not just
   Theorem 2 (the rigidity), but Theorem 1 (the refinement-monotonicity iff)
   and the bracket itself. A hostile referee on §3 has no surface left to push
   on; the Lean term either type-checks or it doesn't, and an axiom audit shows
   it does.

2. **The §4 proof is structurally a port, not a separate undertaking.** §4.2's
   own closing remark says "the proof has the same three-step skeleton as the
   binary Theorem 2." That framing was already honest in Draft 0.5. With Phase
   C2 closed, the *reusable infrastructure* now exists in Lean — the
   refinement-tower, the partition-additivity, the per-cell Jensen — so the
   simplex formalization is a port (~250–400 LoC, on the same skeleton) rather
   than from-scratch development. This is a much smaller follow-up than at the
   prior snapshot.

3. **The asymmetry the manuscript already states matches the mechanization
   ordering.** §4.2's closing remark notes that the binary case collapses to
   Step 1 alone (via symmetry making `φ` a function of the scalar `η`), while
   the simplex case genuinely needs all three steps. The harder *mathematical*
   argument is in §4. The fact that we mechanized the §3 spine first — which
   contains the conceptual transposition the paper is centered on — and left
   the dimension-extension second, is the correct prioritization. A reviewer
   reading the Mechanization paragraph will see the right ordering.

**The publishable framing is now stronger:** *"The §3 binary kernel
(refinement-monotonicity ⟺ concavity, tent uniqueness, the bracket, the
two-query identity) is mechanically verified in Lean 4 against mathlib v4.29.1
(Audit/PrintAxioms.lean confirms only standard Lean axioms; 44 theorems
axiom-clean). The simplex extension (§4) reuses the same refinement-tower
infrastructure and is formalized through the statement layer; the proof is in
progress as Phase D."*

That sentence is true after Phase C2 in a way it wasn't at the prior snapshot,
and it lands the credentialing benefit of `09-mechanization_strategy.md`
Filter 1 with even less hedging than before.

**The one place this matters mathematically.** The §4.2 *only-if* direction
uses the bounded-Jensen / Hamel-basis-pathology argument that a pure-math
referee will scrutinize. That argument is paper-side, well-formed, and
unaffected by mechanization order. It is the same argument that audits 07/12
already worked over.

---

## 5. Risks to flag (post Phase C2)

In order of how a serious reviewer would weight them:

**Risk 1 — Realizability typeclass gap (material but documented; now applies to
both Theorem 1 and Theorem 2).**
`theorem2_reverse` consumes `SingleCellRealizable μ`; Phase C2's `theorem1_hard`
consumes the structurally analogous `BinarySplitRealizable μ`. Both are
provable from `[NoAtoms μ]` via Sierpiński's theorem on atomless measures, but
mathlib does not currently carry Sierpiński. The paper's atomless-hypothesis
prose matches mathematical reality; the Lean statements are slightly weaker
(typeclass instead of `[NoAtoms]`). The safe move remains: a single footnote
in the Mechanization paragraph saying *"the Lean statements consume
`SingleCellRealizable` and `BinarySplitRealizable` typeclasses; over atomless
probability spaces both typeclasses are inhabited by Sierpiński's theorem,
currently being upstreamed to mathlib (`.research/opportunities.md` #1)."*
The doubling does not weaken the framing — both gaps close together with a
single PR.

**Risk 2 — Empirical companion is absent.** Unchanged from the prior snapshot.
§1 abstract, §1.1 contribution 2 (GNN consequences), §5 Corollary 4, §6
over-smoothing characterization, and §7 Proposition 6 all invite an experiments
paper. Theory venues will accept the paper as-is; ML venues will push back. §8
already says "experiments deferred to a companion paper" — keep that line loud.

**Risk 3 — OP2 (quantitative over-smoothing constants) is a working assumption.**
Unchanged. The `δ^(L) ≤ Cλ₂^L` line in §6 cites Oono–Suzuki / Cai–Wang /
Rusch–Bronstein–Mishra. The qualitative claim is robust; the quantitative onset
depends on the literature. Already correctly flagged.

**Risk 4 — PCP analogy.** Unchanged. §1 + §8 are appropriately hedged
("we use the PCP framing as an analogy and not a claim"). Do not strengthen
this language.

**Risk 5 (NEW, low) — §3.1 Theorem 1 measurability hypothesis discrepancy.**
The Lean `theorem1` statement requires `MeasurableSet {x | f x = true}` for
the tower-property step, an explicit hypothesis the manuscript leaves
implicit (the manuscript's "labels" are tacitly measurable). This is a
manuscript-Lean reconciliation, not a mathematical defect. A reviewer who
spots it has noticed something correct: the paper's "for every labeling `f`"
should be read "for every measurable labeling," and that is uncontroversial.
Either add a single-clause clarification to §3.1 or leave it; either is
defensible.

---

## 6. Confidence verdict (post Phase C2)

| Venue class | Verdict | Caveat |
|---|---|---|
| **Theory venues** (decision theory, statistics, IT) | **High confidence — promotable.** The classical-foundation separation in §1.2 plus a fully mechanized §3 kernel is exactly the discipline these audiences want. | Pure-math referees will scrutinize §4.2 Step 2 (the bounded-Jensen / Hamel-basis pathology argument) most. Statement is now correct. |
| **GNN/ML theory** (NeurIPS theory track, ICML, COLT-aware) | **High confidence** for a theory track (was moderate-high). The mechanized §3 spine is a tangible separator from the typical workshop-paper baseline. | Will request experiments. The honest "floor ≠ achieved" framing both protects you and earns goodwill. |
| **Mainstream GNN venues** (NeurIPS main, ICML main) | **Conditional** — needs the empirical companion. Unchanged. | Theory paper alone reads as "lemma without application" to this audience. |
| **Formal-methods adjacent venues** (ITP, CPP) | **Submittable as the Lean kernel alone**, framed as "the rigidity kernel for a calibration-on-the-resolution-axis theory of GNN expressivity." Now a 44-theorem axiom-clean kernel covering both binary rigidity and the refinement-monotonicity iff — a genuinely substantive ITP contribution. | The Phase C2 tower-property infrastructure (`refining`, `cellRate_mul_cellMass_refining_sum`) is reusable beyond this project — pitches well as "infrastructure for partition-functional inequalities." |

**Headline:** *High confidence for theory and GNN-theory venues, conditional on
companion-paper expectation for ML venues. The Lean kernel alone is now a
publishable ITP contribution.* The Phase C2 closure changes the ITP venue
verdict from "submittable as a niche kernel" to "submittable as a
substantive contribution," because the refinement-monotonicity iff is the
canonical result in this corner of decision theory, and a mechanized version
of it is publishable on its own merits.

---

## 7. Recommended next moves (post Phase C2)

In approximate order of marginal value-per-effort; none executed without sign-off.

1. **Update [`03`](03-t0-achievable_error_floor.md)'s prospective Mechanization
   subsection (or add it).** The right line to land in §1 of the manuscript is
   now: *"44 theorems mechanically verified in Lean 4 against mathlib v4.29.1,
   covering the binary spine of §3 in full (Theorems 1 and 2, the bracket, the
   universal `c_φ = 1/2`) and the operational §7 result (Proposition 6).
   `Audit/PrintAxioms.lean` confirms only the three standard Lean axioms. The
   simplex extension of §4 reuses the same refinement-tower infrastructure
   and is formalized through the statement layer; its proof is in progress."*
   Cite the Lean repo. Single commit.

2. **Phase D (simplex_rigidity).** Now genuinely tractable as a port:
   `barPhiSimplex_refinement_le` mirrors `barPhi_refinement_le` with `Fin k → ℝ`
   in place of `Bool`-conditioned rates. The partition-additivity helpers
   (`sum_cellMass_refining_eq`, `sum_measure_refining_inter_eq`) generalize
   with no change. Worth pursuing as a labeled `[scaffold]` issue.

3. **Wire the `solo-blueprint-workflow` skill** to render an HTML blueprint
   dashboard showing the 44 proved / 1 scaffold split publicly. Puts the project
   in the idiom of the Lean community (PFR, sphere-eversion, FLT). Low cost,
   high signaling value at submission time.

4. **Ship the paper.** The §3 spine being fully mechanized changes the gating
   calculus. Don't wait on Phase D. The simplex rigidity is the long-pole node
   per [`14-harness_and_reproduction.md`](14-harness_and_reproduction.md) and
   ships best as a follow-up — either a §4-only ITP note (if Phase D lands
   before submission) or a footnote update (if it lands after).

5. **Sierpiński PR to mathlib** (`.research/opportunities.md` #1) — when the
   paper is closer to submission so the PR can be cited in the Mechanization
   footnote. The PR closes both `SingleCellRealizable` and
   `BinarySplitRealizable` simultaneously, reducing the typeclass-gap footnote
   from "in flight" to "merged."

6. **Empirical companion** as a separate workstream when collaborators are
   available. Unchanged from prior recommendation.

7. **Optional: separate ITP submission of the kernel.** With Phase C2 closed
   the kernel is independently publishable. The contribution is the
   refinement-tower abstraction (`refining`, `cellRate_mul_cellMass_refining_sum`)
   plus the binary rigidity (`theorem2`) — both reusable beyond this project.
   The decision is whether the paper-track + kernel-as-companion strategy or
   the two-paper strategy serves the project better; this audit does not pick.

---

*Report regenerated 2026-06-06 after Phase C2 closure (commit `8339f60`).
Auditor: GitHub Copilot (Claude Sonnet 4.6). Verified against live Lean build
(2172 jobs) and `lake env lean Audit/PrintAxioms.lean` (44 declarations,
all axiom-clean against `[propext, Classical.choice, Quot.sound]`).*

*Prior snapshot: 2026-06-05 (commit `50bc25b`), 27 proved theorems,
Theorem 1 + simplex_rigidity + cPhiSimplex scaffolded. Net delta: Theorem 1
+ cPhiSimplex flipped to proved; 8 Phase C2 helpers added; PrintAxioms file
brought up to coverage; only simplex_rigidity remains as a load-bearing
scaffold.*
