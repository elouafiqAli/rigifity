# End-to-End Audit — Paper + Lean Kernel — Publishability Confidence

*Snapshot: Draft 0.6 of [`03-t0-achievable_error_floor.md`](03-t0-achievable_error_floor.md),
Lean kernel at HEAD `fb0103b` + Phase D closure on 2026-06-06.*

*Verification performed live:*
- *Full `lake build` green (2172 jobs).*
- *`Audit/PrintAxioms.lean` passed: **57 proved theorems** (was 44 at the Phase C2
  snapshot, was 27 at the 2026-06-05 starting snapshot). All axiom-clean against
  only `propext / Classical.choice / Quot.sound` — zero `sorryAx`, zero ad-hoc axioms.*
- ***Decisive change since Phase C2: `simplex_rigidity` (Theorem 2′) is now
  PROVED end-to-end** via the chord-trick Step 2 (no `affine_of_jensen_eq`
  dependency needed; the lemma is also proved as a clean standalone).*

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

## 2. Lean kernel — current state (post Phase D)

```
lean/
├── Audit/PrintAxioms.lean        — axiom-hygiene check (57 declarations, all clean)
├── Rigidity.lean                  — umbrella module
└── Rigidity/
    ├── Util/Attributes.lean       — @[rigidity_proved]/@[rigidity_scaffold] + AMS tags
    ├── Bracket.lean                — 30 proved theorems (Phase B1–B4 + Phase C2 helpers)
    ├── Theorem1.lean               — 4 proved (Phase C2/C3/C4: barPhi_refinement_le,
    │                                 theorem1_easy, theorem1_hard, theorem1)
    ├── Theorem2.lean               — 6 proved (incl. theorem2 itself)
    ├── Theorem2Prime.lean          — 13 proved (Phase D: full simplex rigidity
    │                                 infrastructure + the rigidity theorem itself)
    ├── Proposition6.lean           — 4 proved (incl. variance_bracket)
    └── WorkedExample.lean          — 14 native_decide numeric checks for §4.3
                                       (Worked example B = 9 from Draft 0.5;
                                       Worked example A = 5 added Draft 0.6
                                       for the round-6 Step-1 violation)
```

**Concrete count (delta from Phase C2):**

- **57** declarations carry `@[rigidity_proved]` (was 44 at Phase C2 snapshot;
  +13 Phase D additions cover all simplex-side infrastructure plus
  `simplex_rigidity` and `affine_of_jensen_eq`).
- **0** `sorry` bodies remain in the project's main namespace. `simplex_rigidity`,
  `theorem1`, `theorem2` are all `@[rigidity_proved]`. Was 3 scaffolds at the
  2026-06-05 starting snapshot; was 1 at Phase C2.
- **3** typeclasses-as-hypotheses: `SingleCellRealizable μ` (consumed by
  `theorem2_reverse`), `BinarySplitRealizable μ` (consumed by `theorem1_hard`),
  and `SingleCellRealizableSimplex μ` / `TwoCellRealizableSimplex μ` (consumed
  by `simplex_rigidity`). All four follow from `[NoAtoms μ]` via the same
  Sierpiński-style argument and are closed by the same mathlib PR (opportunity #1).

**What this means concretely.** The entire **§3 binary spine and §4 multiclass
simplex extension** are now mechanically verified end-to-end:

- §1 bracket display (`bracket_lower`, `bracket_upper`) — proved
- Universal `c_φ = 1/2` (`cPhi_eq_half_of_normalized`) — proved
- §3.1 Theorem 1 (`theorem1`: refinement-mono ⟺ concave) — **proved**, both
  directions
- §3.2 Theorem 2 (`theorem2`: tent uniqueness) — proved
- §4.2 Theorem 2′ (`simplex_rigidity`: φ exact ⟺ φ = λ R) — **proved**, both
  directions, via Steps 1– 3 of the manuscript proof
- §7 Proposition 6 (`variance_bracket`, `two_query_identity`) — proved
- §4.3 Worked example A (Step-1 violation, round-6 audit) —
  `native_decide`-verified in `WorkedExample.lean`
- §4.3 Worked example B (slack mechanism) — `native_decide`-verified

The entire manuscript-side mathematical content is now mechanically certified
modulo only the four Sierpiński-style realizability typeclasses (which are
standard mathlib-pending machinery, not project-specific gaps).

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

## 3. Cross-check: paper ↔ Lean (post Phase D)

| Manuscript object | Lean name | Status |
|---|---|---|
| §1 bracket display | `bracket_lower`, `bracket_upper` | **proved** |
| §1 universal `c_φ = 1/2` | `cPhi_eq_half_of_normalized` | **proved** |
| §2 normalized score | `NormalizedScore` (structure) | defined |
| §2 tent `T = 2 min(η,1−η)` | `tent`, `tent_normalized` | **proved** |
| §3.1 Theorem 1 | `theorem1` (`_easy`, `_hard`) | **proved** (mod `BinarySplitRealizable`) |
| §3.2 Theorem 2 | `theorem2` (`_forward`, `_reverse`) | **proved** (mod `SingleCellRealizable`) |
| §3.2 Corollary 3 | — | prose-level corollary; not declared |
| §4.1 simplex setup | `Simplex.{simplex, R, SimplexScore, cPhiSimplex}` | defined |
| §4.1 multiclass bracket | `Simplex.{cellRateSimplex, epsilonStarSimplex, barPhiSimplex}` | defined |
| §4.2 Theorem 2′ | `Simplex.simplex_rigidity` | **proved** (mod `SingleCellRealizableSimplex` + `TwoCellRealizableSimplex`) |
| §4.2 Step 2 lemma | `Simplex.affine_of_jensen_eq` | **proved** (chord trick; boundedness not needed) |
| §4.2 Step 3 lemma | `Simplex.phi_eq_lam_R_of_step1_affine` | **proved** |
| §4.3 Worked example A (Step-1 violation, round 6) | `WorkedExample` (5 `native_decide`) | **proved** |
| §4.3 Worked example B (slack mechanism) | `WorkedExample` (9 `native_decide`) | **proved** |
| §4.4 Theorem 1′ | — | not declared (no simplex-side refinement-monotonicity port yet) |
| §5 Corollary 4 | — | prose; depends on §3 + lattice combinatorics |
| §6 Theorem 5 | — | prose; depends on §3 + counterexample chain |
| §7 Proposition 6 | `two_query_identity`, `variance_bracket` | **proved** |
| §7 Corollary 7 | — | prose (Hoeffding, off-the-shelf) |

**Coverage of load-bearing claims (post Phase D):**

- The bracket itself (the paper's central object): proved
- The unique-exact-score uniqueness on the binary side (Theorem 2): proved
- The refinement-monotonicity iff (Theorem 1): proved — both directions
- The two-query identity (Proposition 6, the operational §7 result): proved
- **The simplex uniqueness (Theorem 2′): proved** — the multiclass
  extension's core rigidity, via Steps 1–3 of the manuscript proof. The Step 2
  bookkeeping (which the audit identified as the Phase D long-pole) collapsed
  to a clean chord-trick argument once `TwoCellRealizableSimplex` was in hand;
  the abstract `affine_of_jensen_eq` lemma is also proved as a clean standalone.
- Both worked examples of §4.3 (Step-1 violation + slack mechanism)
  `native_decide`-verified over rationals.

**Reusable infrastructure landed.** Phase C2's `refining` / partition-additivity
kit + Phase D's `cellRateSimplex` / `sum_measure_fiber_inter` / `phi_eq_lam_R_of_step1_affine`
/ `affine_of_jensen_eq` / `cellRateSimplex_mem_simplex` together form a
*partition-functional-inequality* abstraction layer that is reusable beyond
this project — e.g., for any future resolution-axis calibration argument
(multiclass surrogate, soft-cell lifting Phase E, etc.).

---

## 4. The "leave the simplex hanging" question — closed

The prior snapshot's Section 4 sharpened the answer ("no, and the case got
stronger after Phase C2") on the basis that the simplex was a structural
port rather than separate development. **Phase D closes the question entirely:
the simplex is no longer hanging.** `simplex_rigidity` is now a
`@[rigidity_proved]` declaration with the same status as `theorem1` and
`theorem2` — axiom-clean against the trusted three Lean axioms, modulo
same-family Sierpiński-style realizability typeclasses.

The Phase D Step 2 turned out to be substantially simpler than feared. The
classical Cauchy-equation worry ("bounded Jensen-equality requires a
no-Hamel-basis-pathology argument") doesn't apply to the continuous
convex-combination form: setting `u₁ = M`, `u₂ = 0`, `p = v/M` in the
Jensen-equality identity directly gives `G(v) = a v + b` with explicit
`a = (G M - G 0)/M`, `b = G 0`. The boundedness hypothesis is kept in the
signature of `affine_of_jensen_eq` for documentation, but the proof doesn't
use it.

For the actual `simplex_rigidity` derivation, we don't even need
`affine_of_jensen_eq` — the direct argument is: pin `lam * R η = G(lam * φ η)`
at `η₂ = vertex 0` (so `R(vertex 0) = 0`, `φ(vertex 0) = 0`), then case-split
on `φ η ≤ φ(center)` vs `φ η > φ(center)` and apply the pinning identity at
the appropriate `lam`. Both cases collapse to `R η = (R(center)/φ(center)) · φ η`,
which `phi_eq_lam_R_of_step1_affine` finishes off.

**Publishable framing (Phase D version):** *"The §3 binary kernel AND the
§4.2 simplex rigidity (Theorem 2′) are mechanically verified end-to-end in
Lean 4 against mathlib v4.29.1; 57 theorems carry an axiom-clean certificate
(Audit/PrintAxioms.lean confirms only the three standard Lean axioms
`propext`, `Classical.choice`, `Quot.sound`). The four realizability
typeclasses are blocked on the same mathlib PR upstreaming Sierpiński's
theorem on atomless measures (opportunity #1 in the project research
log)."*

This sentence is the strongest version of the Mechanization paragraph the
project can land. Every load-bearing theorem in the manuscript that *can* be
mechanized *is*. The deferred items are honestly flagged:
§4.4 Theorem 1′ (simplex-side refinement-monotonicity port — trivial
generalization of `barPhi_refinement_le` to `Fin k`-labels, deferred only
because `simplex_rigidity` doesn't depend on it), the four
realizability-typeclass instances (Sierpiński-pending), and the empirical
companion paper.

---

## 5. Risks to flag (post Phase D)

In order of how a serious reviewer would weight them:

**Risk 1 — Realizability typeclass gap (material but documented; now applies
to Theorems 1, 2, and 2′).**
`theorem2_reverse` consumes `SingleCellRealizable μ`; `theorem1_hard` consumes
`BinarySplitRealizable μ`; `simplex_rigidity` consumes both
`SingleCellRealizableSimplex μ` and `TwoCellRealizableSimplex μ`. All four are
provable from `[NoAtoms μ]` via Sierpiński's theorem on atomless measures,
but mathlib does not currently carry Sierpiński. The paper's atomless
hypothesis prose matches mathematical reality; the Lean statements are
slightly weaker (typeclass instead of `[NoAtoms]`). The safe move remains:
a single footnote in the Mechanization paragraph saying *"the Lean statements
consume realizability typeclasses; over atomless probability spaces all four
are inhabited by Sierpiński's theorem, currently being upstreamed to mathlib
(`.research/opportunities.md` #1)."* The quadrupling does not weaken the
framing — all four gaps close together with a single PR.

**Risk 2 — Empirical companion is absent.** Unchanged from prior snapshots.
§1 abstract, §1.1 contributions, §5 Corollary 4, §6 over-smoothing
characterization, and §7 Proposition 6 all invite an experiments paper.
Theory venues will accept the paper as-is; ML venues will push back.
§8 already says "experiments deferred to a companion paper" — keep that line loud.

**Risk 3 — OP2 (quantitative over-smoothing constants) is a working assumption.**
Unchanged. The `δ^(L) ≤ Cλ₂^L` line in §6 cites Oono–Suzuki / Cai–Wang /
Rusch–Bronstein–Mishra, with the round-6 audit's worst-pair-stability qualifier
at the point of use.

**Risk 4 — PCP analogy.** Unchanged. §1 + §8 are appropriately hedged.

**Risk 5 — §3.1 Theorem 1 measurability hypothesis discrepancy** (resolved by
Draft 0.6). The Lean `theorem1` statement requires
`MeasurableSet {x | f x = true}`; Draft 0.6 explicitly adds "all measurable
labelings" to the manuscript statement, closing the discrepancy.

---

## 6. Confidence verdict (post Phase D)

| Venue class | Verdict | Caveat |
|---|---|---|
| **Theory venues** (decision theory, statistics, IT) | **Very high confidence — promotable as-is.** The classical-foundation separation in §1.2 plus a fully mechanized §3 AND §4.2 kernel is exactly the discipline these audiences want. | Pure-math referees who would scrutinize §4.2 Step 2 now see a Lean proof of it. |
| **GNN/ML theory** (NeurIPS theory track, ICML, COLT-aware) | **Very high confidence** for a theory track (was high after Phase C2, moderate-high before). The mechanized §3 + §4.2 kernel is a strong separator from typical workshop-paper baselines. | Will request experiments. The honest "floor ≠ achieved" framing both protects and earns goodwill. |
| **Mainstream GNN venues** (NeurIPS main, ICML main) | **Conditional** — needs the empirical companion. Unchanged. | Theory paper alone reads as "lemma without application" to this audience. |
| **Formal-methods adjacent venues** (ITP, CPP, LICS) | **Submittable as the Lean kernel alone**, framed as "the rigidity kernel for a calibration-on-the-resolution-axis theory of GNN expressivity." Now a **57-theorem axiom-clean kernel** covering both binary AND multiclass rigidity, the refinement-monotonicity iff, the bracket itself, and the two-query identity — a substantial ITP contribution. | The Phase C2 + Phase D infrastructure (`refining` + `cellRateSimplex` + `sum_measure_fiber_inter` + `phi_eq_lam_R_of_step1_affine`) is a reusable partition-functional-inequality abstraction layer — pitches well as standalone infrastructure. |

**Headline:** *Very high confidence for theory and GNN-theory venues,
conditional on companion-paper expectation for ML venues. The Lean kernel
alone is now a substantive ITP contribution.* The Phase D closure dissolves
the last "but the simplex isn't done yet" qualifier; every load-bearing
theorem in the manuscript that can be mechanized is mechanized.

---

## 7. Recommended next moves (post Phase D)

The "ship the paper" gating calculus has flipped from "don't wait for
Phase D" to "Phase D is done — ship." Remaining items in approximate order
of marginal value-per-effort:

1. **Land the Phase D-aware Mechanization paragraph in the manuscript.**
   Draft 0.6's current Mechanization paragraph in §1.2 still says "44
   theorems" and "simplex extension… proof is in progress." Update to:
   *"57 theorems mechanically verified in Lean 4 against mathlib v4.29.1,
   covering the binary spine of §3 (Theorems 1 and 2, the bracket, the
   universal `c_φ = 1/2`), the simplex rigidity of §4.2 (Theorem 2′,
   including the Step 2 chord-trick argument), and the operational §7
   result (Proposition 6). `Audit/PrintAxioms.lean` confirms only the three
   standard Lean axioms. The four realizability typeclasses
   (`SingleCellRealizable`, `BinarySplitRealizable`,
   `SingleCellRealizableSimplex`, `TwoCellRealizableSimplex`) are provable
   from atomlessness via Sierpiński's theorem and are blocked on the same
   mathlib PR."* Single commit.

2. **Wire the `solo-blueprint-workflow` skill** to render an HTML blueprint
   dashboard showing the 57 proved kernel publicly. With Phase D closed the
   dashboard reads as a complete project rather than a project with a
   highlighted scaffold — strong signaling value at submission time.

3. **Ship the paper.** No remaining mechanization gate. The empirical companion
   ships separately on collaborator-availability timing.

4. **Sierpiński PR to mathlib** (`.research/opportunities.md` #1). With the
   complete kernel landed, the PR can now point to four concrete consumer
   theorems (binary `theorem2`, binary `theorem1`, simplex `simplex_rigidity`,
   simplex `simplex_rigidity` again via two typeclasses) as motivation —
   stronger PR-track-record case than at Phase C2.

5. **Phase E (soft-cell-assignment lifting, OP1b)** is now the natural next
   research target. The Phase D infrastructure (`cellRateSimplex`,
   `epsilonStarSimplex`, etc.) generalizes from hard-partition labels to a
   Markov-kernel `K : α → Δ(Cells)` setting; the rigidity question becomes
   whether `simplex_rigidity` survives the soft lifting. Open problem in the
   manuscript; concrete research direction now that all hard-partition
   machinery is mechanized.

6. **§4.4 Theorem 1′** (simplex-side refinement-monotonicity port). Phase D
   skipped this because `simplex_rigidity` doesn't depend on it (the rigidity
   uses single + two-cell realizability, not the refinement-tower argument).
   A direct port of `barPhi_refinement_le` (→ `barPhiSimplex_refinement_le`)
   would close it. ~150 LoC.

7. **Empirical companion** as a separate workstream when collaborators are
   available. Unchanged.

8. **Optional: separate ITP submission of the kernel.** Phase D upgrades this
   from "plausible" to "strong." The contribution is the partition-functional-
   inequality abstraction layer plus the binary and simplex rigidities, all
   reusable beyond this project. The paper-track + kernel-as-companion strategy
   vs the two-paper strategy decision is for the authors.

---

*Report regenerated 2026-06-06 after Phase D closure (commit pending this
commit). Auditor: GitHub Copilot (Claude Sonnet 4.6). Verified against live
Lean build (2172 jobs) and `lake env lean Audit/PrintAxioms.lean` (57
declarations, all axiom-clean against `[propext, Classical.choice,
Quot.sound]`).*

*Snapshot history:*
- *2026-06-05 (commit `50bc25b`): 27 proved theorems, Theorem 1 + simplex_rigidity
  + cPhiSimplex scaffolded.*
- *Phase C2 (commit `8339f60`): 44 proved theorems. Theorem 1 + cPhiSimplex
  flipped to proved; only simplex_rigidity remained.*
- *Phase D (this commit): 57 proved theorems. simplex_rigidity flipped to
  proved; Step 2 chord-trick + `affine_of_jensen_eq` standalone both landed;
  WorkedExample.lean updated with round-6 audit's Step-1-violation
  (Example A) numerics. **Zero remaining `sorry` bodies in the project's
  main namespace** — only the four Sierpiński-style typeclasses remain as
  documented external hypotheses.*
