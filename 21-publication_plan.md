# Publication Plan — Ontological Seeding Strategy

*Subject: [`03-t0-achievable_error_floor.md`](03-t0-achievable_error_floor.md) Draft 0.7 (Final) — building the citation graph that the main paper will land into. Authored 2026-06-06.*

---

## 0. Premise

The paper is correct end-to-end (panel verdict, [`19-panel_verdict.md`](19-panel_verdict.md)). Its kernel is axiom-clean. The judges signed off. The question is no longer "is it right" but **"what does the field need to have read before this lands?"**

The paper bridges three previously-separate idioms — surrogate calibration (statistics), Weisfeiler–Leman expressivity (graph ML), and Lean 4 mechanization (formal methods). A reviewer from any one of those communities will be missing two-thirds of the vocabulary. The strategy below is **not to split the paper** — the panel verdict explicitly recommends a *two-paper* split (theory + ITP) plus a separate empirical companion, and that recommendation stands. The strategy is to publish **ontology** in advance: small, self-contained pieces that establish vocabulary, prove single tools, state single open problems, and become citable references the main paper points to.

This is the strategy Tao used with his blog → expository pieces → big papers; the strategy Reid and Williamson used for *Information, Divergence and Risk for Binary Experiments*; the strategy Lurie used with the prelude to *Higher Topos Theory*. The main paper does not change — what changes is the **support structure** around it.

**Constraints (author-stated).**
- Lowest-prestige venues acceptable: workshops, letters, notes, expository — peer review required, arXiv is archival not primary.
- Workshops must be remote-friendly.
- Fast review: 6 months is fine, 9+ months is not.
- Author can write quickly — the bottleneck is **review turnaround**, not authoring time.
- Massive throughput target: June 2026 streak (next month).
- Goal: when the main paper drops at a conference, reviewers can locate every construct in a published, refereed pointer.

**Non-goals.**
- This plan does *not* schedule the main paper itself — that's Judge E's track (COLT 2027 / JMLR / *Ann. Statist.*) in [`19-panel_verdict.md`](19-panel_verdict.md) §5.
- This plan does *not* schedule the empirical companion — separate timeline, separate authorship lane.
- This plan does *not* schedule the Lean kernel ITP submission — that's Paper 2 in the panel verdict, ~CPP 2027 deadline Sep 2026.

---

## 1. Strategy & Discipline

### 1.1 The seeding principle

Each small publication contributes one of three things: **a directly citable construct** the main paper will reference (Star); **a tour around the construct's neighbourhood** that lowers the on-ramp for new readers (Bush); or **a paradigm-adjacent investigation** that populates the same intellectual neighbourhood without being cited by the main paper (Exploration). All three modes are valuable. Direct citability is the *star* mode (highest value to the main paper), but it is **not** a prerequisite — §1.4 below codifies the three modes explicitly.

Whatever its mode, the piece must be:

1. **Self-contained.** Defensible without the main paper. A reader who has *only* the small piece must get full value from it.
2. **Forward-pointing.** Ends with "this is a tool for X" or "this raises Q" — never mentions the main paper by title (the main paper hasn't dropped yet).
3. **Ontology-bearing.** Establishes a name, a notation, a proof technique, or a paradigm-level pattern that becomes vocabulary.
4. **Honestly scoped.** Does not over-claim. Cor 4 published standalone is "a half-chain in the multiset refinement lattice" — not "a hierarchy for GNNs."

### 1.2 The discipline

Per the user's framing — multi-round, multi-phase, multi-step, with adversarial audit and concurrent risky exploration. Each publication opportunity follows the same discipline that produced the main paper:

- **Round 1:** Skeleton draft (executor persona).
- **Round 2:** Adversarial audit (judge/auditor persona, hostile-referee mode).
- **Round 3:** Closure draft.
- **Round 4:** Concurrent exposure — submit to the *primary* venue and simultaneously deposit on arXiv with a tutorial preface. If the primary rejects, the arXiv version is the citable pointer until re-submission.

This is the same audit pattern as rounds 1–7 of the main paper ([`05`](05-pi_adversarial_audit_of_draft0.md), [`07`](07-pi_adversarial_audit_of_04.md), [`10`](10-external_reviewer_audit_of_draft0.2.md), [`12`](12-external_reviewer_second_audit_of_draft0.3.md), [`00-external.md`](00-external.md), [`17`](17-pi_adversarial_audit_of_draft0.6_post_phase_d.md), [`19`](19-panel_verdict.md)). The infrastructure is already proven; this plan reuses it.

### 1.3 The questioning-the-questioning discipline

For every proposed extraction below, ask **before drafting**:

- *Q1.* Does this construct stand alone, or does it implicitly rely on a downstream result the small piece cannot cite?
- *Q2.* What is the **one sentence** the main paper will be able to write because this exists? (If you can't write that sentence, don't publish the small piece.)
- *Q3.* Who is the hostile referee for this piece, and what is their veto? (Per-piece persona assignment, §4.)
- *Q4.* What is the closest existing precedent in the literature, and how does this piece position against it?
- *Q5.* If rejected by the primary venue, what is the fallback venue, and what is the arXiv-first plan?

A piece that cannot answer all five does not enter the queue.

### 1.4 Three modes of seeding (Star / Bush / Exploration)

Per the author's directive — the work need not be precisely citable to be worth publishing; "dwelling around the bush" and "exploring other constructs under the same paradigm" both produce ecosystem value. Three modes, each acceptable, with the star mode preferred when achievable.

**Mode S — Star (directly citable).** The piece extracts a precise construct from the main paper and re-publishes it with full proof and worked examples. The main paper then drops the inline derivation and writes *"by [Author, venue], ..."*. Star is the highest-value mode because it (a) shortens the main paper, (b) gives the construct a permanent peer-reviewed home, and (c) lets reviewers consult the construct in isolation.

**Mode B — Bush (around the concept).** The piece tackles the *neighbourhood* of a construct rather than the construct itself — expository walk-throughs, methodology notes, taxonomy papers, system descriptions of the formal-methods infrastructure. The main paper may cite it as background (*"see [Author, venue] for the methodology"*) but does not depend on it for any specific claim. Bush mode is the right mode for ideas too elementary or too meta to be a "theorem" in their own right but that significantly lower the on-ramp for new readers. The transposition methodology note (O2) and the audit-cycle methodology paper (O14) are the canonical Bush pieces in this plan.

**Mode E — Exploration (paradigm-adjacent).** The piece develops a *different* construct *under the same paradigm* the main paper inhabits — resolution-axis calibration, the refinement lattice, concave-score brackets, partition functionals, locally-testable property-test reductions. Exploration pieces are not cited by the main paper directly but they *populate the same conceptual neighbourhood* the main paper occupies, so when reviewers (or future authors) look around they find a coherent literature already there. Tier 5 (§4.5) is entirely Exploration. Exploration mode is the riskiest — no main-paper backstop justifying the piece — but also the most generative, because it identifies theorems that hadn't been thought through yet, and it actively *lowers* per-piece review risk: a hostile referee cannot do a five-second precedent search and dismiss a piece that has no obvious comparison point.

**Portfolio mix.** A healthy seeding portfolio runs Star-heavy at the top (high-value, precise main-paper backstop), Bush in the middle (broaden the on-ramp), and Exploration at the periphery (populate the paradigm). Approximately **11 Star + 3 Bush + 6 Exploration** is what §4 lays out, totaling 20 pieces across Tiers 1–5. Not all need to land; the goal is **breadth of ecosystem**, not exhaustive coverage. The asymmetry — Star easiest to write but most attackable on "incrementality" grounds; Exploration hardest to write but cleanest to defend on novelty grounds — is the reason to mix.

---

## 2. The Personas (Standing Cast)

Reuse the panel composition from [`18-panel_review_charter.md`](18-panel_review_charter.md) §1, recast for authoring + review of the satellite pieces.

| Persona | Domain | Role on small pieces |
|---|---|---|
| **Executor T** | Convex analysis, decision theory, Blackwell | Lead author on Tier 1 & Tier 2 mathematical pieces |
| **Executor S** | Surrogate calibration, scoring rules | Lead author on statistics-leaning pieces; co-audits Executor T's calibration framing |
| **Executor G** | Graph ML, WL theory, GNN architectures | Lead author on graph-flavored pieces (half-chain, three-partition, over-smoothing reframing) |
| **Executor F** | Lean 4, mathlib, ITP exposition | Lead author on formal-methods pieces (Sierpiński, partition-functional Jensen) |
| **Executor E** | Expository, *Notices*-style, *Snapshots*-style | Lead author on the ontology / methodology expository pieces |
| **Judge π** | Adversarial, hostile-referee, internal devil's advocate | Audits every piece before submission; written veto power |
| **Judge S** | Statistics referee | Audits prior-art positioning of any calibration-touching piece |
| **Judge G** | GNN referee | Audits any GNN-touching piece for floor-vs-achieved hygiene |
| **Judge F** | Formal methods referee | Audits any Lean-touching piece for kernel integrity and reproducibility |
| **Judge E** | Editor, venue strategist | Decides venue fit; vetos pieces that mis-position against the main paper |
| **Coordinator** | Process, sequencing, parallelism, dependency tracking | Runs the queue; non-voting |

Every opportunity in §4 names its executor and its primary judge. No piece submits without judge sign-off.

---

## 3. The Ontological Map

This is the inventory of **constructs** the seeding plan addresses — both those the main paper depends on (Star/Bush, C1–C16) and those that inhabit the same paradigm without being invoked by the main paper (Exploration, C17–C22). Mode column per §1.4: **S** = Star (directly citable), **B** = Bush (around the concept), **E** = Exploration (paradigm-adjacent, new construct not in the main paper). Hybrid mode tags (e.g. B/S) are allowed for constructs that span two modes.

| # | Construct | Lives in (paper §) | Mode | What a published satellite gives the ecosystem |
|---|---|---|---|---|
| **C1** | Bracket + universal $c_\varphi=\tfrac12$ | §1, §3.1 | **S** | main paper writes "by [Author, SPL], $c_\varphi=\tfrac12$..." |
| **C2** | Resolution-axis transposition (methodology) | §1.1, §1.2 | **B** | main paper writes "see methodology note [Author, EMS Magazine]" |
| **C3** | Single-cell pinning (binary rigidity proof) | §3.2 Theorem 2 proof | **S** | "by single-cell pinning [Author, CRAS]..." |
| **C4** | Chord substitution for continuous Jensen-equation | §4.2 Theorem 2′ Step 2 | **S** | "by the chord substitution [Author, CRAS]..." |
| **C5** | Level-set floor $\ell_\varphi$ and biconjugate envelope | §4.1 lower bound | **S** | "via the level-set floor of [Author, SPL]..." |
| **C6** | Two-query identity $p_{\mathrm{dis}}=2\mathbb E[\mathrm{Var}(f\mid\Pi)]$ | §7 Proposition 6 | **S** | "by the two-query identity [Author, IPL]..." |
| **C7** | Aggregator half-chain (multiset lattice incomparability) | §5 Corollary 4 | **S** | "the half-chain of [Author, LoG]..." |
| **C8** | Three-partition framing (WL / architecturally realized / operational) | §6 | **B/S** | "in the three-partition framing of [Author, NeurIPS workshop]..." |
| **C9** | Refinement-lattice converse to Blackwell (binary-split monotone ⟹ concave) | §3.1 Theorem 1 (ii)⟹(iii) | **S** | "by the refinement-lattice converse [Author, ECP]..." |
| **C10** | Partition-functional Jensen abstraction (Lean) | Appendix A.5 Phase C2 layer | **B** | "using the library of [Author, CICM]..." |
| **C11** | Sierpiński atomless realizability (mathlib PR + tutorial) | Appendix A.7, [`.research/sierpinski-pr/`](.research/sierpinski-pr/) | **S** | "by Sierpiński (Mathlib PR; tutorial [Author, CICM])..." |
| **C12** | Open Problem: quantitative over-smoothing (OP2) | §8 OP2, §6 | **S** | "see Open Problem [Author, COLT OP / ALT OP]..." |
| **C13** | Open Problem: gap amplification (OP3) | §8 OP3 | **S** | "see Open Problem [Author, COLT OP]..." |
| **C14** | Open Problem: soft cell assignments (OP1b) | §8 OP1b | **S** | "see Open Problem [Author, NeurIPS workshop OP]..." |
| **C15** | Adversarial-audit cycles as a workflow | Appendix B.3, [`.agents/skills/tao-red-team-audit/`](.agents/skills/tao-red-team-audit/SKILL.md) | **B** | "the audit-cycle methodology of [Author, CICM]..." |
| **C16** | Step-by-step skeletonization + WSL bridge | Appendix B.2, [`.agents/skills/tao-step-by-step-proving/`](.agents/skills/tao-step-by-step-proving/SKILL.md), [`.agents/skills/wsl-lean-bridge/`](.agents/skills/wsl-lean-bridge/SKILL.md) | **B** | "the step-by-step pattern of [Author, ITP tools track]..." |
| **C17** | f-divergence dual of the bracket (Reid–Williamson resolution-axis transposition) | *not in paper; sibling of §3.1* | **E** | populates the paradigm with the f-divergence partner of the bracket; sibling vocabulary for the information-theory community |
| **C18** | Le Cam deficiency between partition coarsenings | *not in paper; calibrates Blackwell's qualitative order* | **E** | gives the comparison-of-experiments community a calibrated refinement of the qualitative refinement order |
| **C19** | Sample-complexity / empirical $\bar\varphi$ concentration | *not in paper; §7's cost-accounting paragraph touches it without formalizing* | **E** | bridges the population-functional bracket and finite-sample estimation |
| **C20** | Distributionally-robust bracket under Wasserstein cell uncertainty | *not in paper* | **E** | extends the bracket to adversarial / DRO settings, bridges to the robust-optimization community |
| **C21** | Bregman brackets on the simplex of cell distributions | *not in paper; sibling of §4* | **E** | gives the information-geometric variant; lands the paradigm in the Amari / Nielsen community |
| **C22** | Mixing-time-corrected two-query bracket (non-IID sampling) | *not in paper; extends Prop 6* | **E** | extends the local test from IID to Markov-chain co-cell sampling (relevant for graph walks) |

**22 constructs total** — approximately 11 Star, 5 Bush (with C8 spanning Star/Bush), 6 Exploration. Not all need to be seeded — Judge E will triage in §4. The actionable target is **~15 satellite publications** across the seeding window, with Tier 5 (Exploration) as the **concurrent risky track** that runs in parallel with the Star/Bush rounds.

---

## 4. The Opportunities (paired: construct × venue × persona × purpose)

Each opportunity is tagged with **tier** (1 = high-priority ontology, 2 = useful tool, 3 = open problem, 4 = methodology/meta), **primary venue + fallback**, **executor + judge**, and **review-time bracket** (best estimate; verify before submission).

### Tier 1 — Core ontology seeders (write first, in June streak)

#### O1 — *"A bracket for the partition-restricted Bayes risk"*  *(C1, C9)*

**Mode:** Star (directly cited by §1, §3.1 of the main paper).

**Content.** Define $\bar\varphi$, $\varepsilon^*$, the bracket, and prove the universal $c_\varphi=\tfrac12$ for normalized concave scores. State Theorem 1 in its binary form as a refinement-lattice converse to Blackwell. **No GNN content** — pure decision theory. Approximately 6–10 pages.

**Why this first.** Establishes the *vocabulary* (bracket, $c_\varphi$, refinement lattice, normalized score) and the *core inequality* in a venue where it will be read by the statistics community. Without this, every GNN-flavored satellite will need to re-define $\bar\varphi$.

**Primary venue.** *Statistics & Probability Letters* (Elsevier).  *Fallback:* *Electronic Communications in Probability* (open access, peer-reviewed).
**Review-time bracket.** SPL ~2–4 months desk-to-decision typically; ECP ~3–6 months.
**Executor.** Executor T.  **Judge.** Judge S (prior-art audit, distinguishing from Reid–Williamson 2011).
**Forward-pointer the main paper gains.** "The bracket [Author, SPL] is the calibrated gap form of Blackwell's ordering; this paper applies it to GNN-induced partitions."

#### O2 — *"Calibration on the resolution axis: a methodology note"*  *(C2)*

**Mode:** Bush (methodology note, around the transposition concept; the main paper cites it as background framing, not for a specific theorem).

**Content.** Expository, ~6–8 pages. Contrast the *optimization-axis* surrogate calibration (BJM 2006, Reid–Williamson 2011) with the *resolution-axis* transposition. Two-cell worked example. No theorems beyond what is in O1; this is the conceptual framing piece. Stop one inch short of the main paper's GNN application.

**Why this matters.** The main paper claims the transposition is the methodological contribution. Without a published exposition of *what the transposition is*, every reviewer has to reconstruct it. This piece is the "transposition" entry in the ontology.

**Primary venue.** *EMS Magazine* (formerly EMS Newsletter) — short expository math for the European Mathematical Society.  *Alternative:* *Snapshots of Modern Mathematics from Oberwolfach* (peer-reviewed, short, fast, aimed at non-specialists). *Fallback:* *Mathematical Intelligencer* (Springer, ~3–6 months).
**Executor.** Executor E (expository voice).  **Judge.** Judge S + Judge π.
**Forward-pointer.** "The transposition framing — see [Author, EMS Magazine / Snapshots]."

#### O3 — *"The chord substitution closes the continuous Jensen-equation"*  *(C4)*

**Mode:** Star (directly cited by §4.2 Step 2 of the main paper, replaces the Hamel detour the panel verdict flagged in M-2).

**Content.** A short note, ~3–6 pages. Prove: if $G:[0,M]\to\mathbb R$ is continuous and satisfies $pG(u_1)+(1-p)G(u_2)=G(pu_1+(1-p)u_2)$ for all $u_1,u_2\in[0,M]$ and $p\in[0,1]$, then $G$ is affine — by a one-line chord substitution that bypasses Cauchy's equation, Hamel-basis machinery, and measurability hypotheses. Compare with the discrete Cauchy version. Position as a *teaching note* for the analysis curriculum.

**Why this matters.** This is the unsung hero of Theorem 2′ Step 2. The panel found that even the main paper accidentally invoked a "boundedness/Hamel" detour the proof didn't need (round-7 [Material M-2]). Publishing the chord substitution as a standalone retires that confusion and gives the main paper a one-line citation.

**Primary venue.** *American Mathematical Monthly* (MAA) — note section. *Caveat:* Monthly turnaround is historically slow (6–12 months); if author's 6-month bracket is hard, *Math. Mag.* (similar issue) or *College Math Journal* are alternatives, all MAA, similarly paced. **Faster alternatives that fit the constraint better:** *Expositiones Mathematicae* (Elsevier, ~3–6 months), or *Comptes Rendus Mathématique* (CRAS, ~2–4 months for short notes — the historical home of exactly this kind of one-page-classical-fact paper).
**Recommendation.** Submit to *Comptes Rendus Mathématique* first (fast, peer-reviewed, archival via Académie des sciences). Keep *Expositiones Mathematicae* as fallback.
**Executor.** Executor T.  **Judge.** Judge π.
**Forward-pointer.** "the chord substitution of [Author, CRAS 2026] closes the Jensen-equality in one line, replacing the Hamel-basis worry."

**Status (2026-06-07).** Two-lane preparation: O3 has both a CRAS submission and an Expositiones Mathematicae fallback fully prepared.

- *CRAS lane* — [`satellites/o3-chord-substitution/`](satellites/o3-chord-substitution/) — two-cycle audit + LaTeX harness package:
  - *Initial cycle (Rounds 0–5):* extraction → Draft 0.0 → Judge π audit → Draft 0.1 → Judge S prior-art audit → Draft 0.2 Markdown manuscript.
  - *CRAS-targeting cycle (Phases A–J):* multi-phase strategy memo with commitology + IO-1/IO-2/IO-3 intermediate objectives → CRAS format reconnaissance (9 hard gates) → Judge π rigor + wide-mathematician audit → English Draft 0.3 → French translation spec → French Draft 0.3 → Judge fr linguistic audit → French Draft 0.4 → LaTeX harness (en + fr + BibTeX + Windows/POSIX build scripts + README, with `crmath` and amsart-fallback configurations) → submission checklist + cover-letter draft + arXiv-first plan + fallback plan.
- *Expositiones lane* — [`satellites/o3-expositiones/`](satellites/o3-expositiones/) — parallel-prepared Elsevier Short Research Note (~9 typeset pages):
  - Strategy memo with 11 Elsevier-specific hard gates (G-AI declaration mandatory, G-COI declaration as separate `.docx`, G-FUND, G-HIGHLIGHTS, G-INCLUSIVE, etc.).
  - Reframed manuscript: §5 expanded from a single calibration-theory recurrence to a *structural pattern of saturated Jensen* with three example application areas treated symmetrically (utility theory, Shannon entropy axiomatic characterization, surrogate calibration); concluding remarks section added; bibliography re-ordered to Elsevier citation-order numerical style.
  - LaTeX harness uses Elsevier's `elsarticle` class with three build modes (reading / review-line-numbered / final-typeset preview); page-count gate warns if exceeding the 10-page Short Research Note limit.
  - Submission checklist + cover-letter draft + AI declaration draft + COI declaration template + fallback plan.

Recommended dispatch order: CRAS first (faster median review, Diamond Open Access, no fees), Expositiones as fallback if CRAS declines. The two lanes are substantively different framings (5-page citation point vs. 9-page self-contained pedagogical note), not the same paper; both are fully prepared and ready to dispatch.

Gates pending operational closure (common to both lanes): `[AUTHOR]` / `[INSTITUTION]` placeholders, arXiv-first deposit (optional). Lane-specific gates: CRAS — G-1 (affiliation), G-6 (`crmath` class install). Expositiones — G-AI declaration text decision, G-COI Word file creation, G-ETHICS-1 (no concurrent submission). See [`satellites/o3-chord-substitution/99-submission-checklist.md`](satellites/o3-chord-substitution/99-submission-checklist.md) (CRAS) and [`satellites/o3-expositiones/99-submission-checklist.md`](satellites/o3-expositiones/99-submission-checklist.md) (Expositiones) for the full pre-flight.

#### O4 — *"Single-cell pinning: the surprisingly short proof of tent uniqueness"*  *(C3)*

**Mode:** Star (directly cited by §3.2 Theorem 2 proof of the main paper).

**Content.** A short note, ~4–6 pages. State and prove Theorem 2 (tent is the unique normalized exact-bracket score) in its binary form, *emphasizing the single-cell-pinning step*: the lower endpoint $\varphi^{-1}\circ\varphi$ is automatically tight on single cells, so exactness on single cells reduces purely to upper-endpoint tightness, which pins $\varphi$ pointwise. This is a methodological observation worth one paper on its own — it is the reason the binary case is one paragraph while the simplex case is three steps.

**Why this matters.** Establishes "single-cell pinning" as a named proof technique. The simplex rigidity satellite (or the main paper) cites it as the binary-case skeleton.

**Primary venue.** *Comptes Rendus Mathématique* (CRAS).  *Fallback:* *Statistics & Probability Letters*.
**Executor.** Executor T.  **Judge.** Judge π + Judge S.
**Forward-pointer.** "by single-cell pinning [Author, CRAS], the binary case reduces to..."

### Tier 2 — Tools & lemmas

#### O5 — *"A two-query identity for the partition Bayes risk"*  *(C6)*

**Mode:** Star (directly cited by §7 Proposition 6 of the main paper).

**Content.** Proposition 6 standalone, ~5–8 pages. State the identity $p_{\mathrm{dis}}=2\mathbb E[\mathrm{Var}(f\mid\Pi)]$, derive the variance bracket from it, and discuss the property-testing reading (Corollary 7). Two-cell worked example. Include the honest cost-accounting (label complexity $O(\alpha^{-2})$ is independent of $n$; total work is not sublinear).

**Why this matters.** The two-query identity is *the* operationalizable piece of the framework. It is also the most accessible to a TCS / information-theory audience and stands on its own without any GNN context.

**Primary venue.** *Information Processing Letters* (Elsevier, ~2–4 months, TCS short notes). *Alternative:* *IEEE Transactions on Information Theory* correspondence/short paper track. *Workshop fallback:* a property-testing workshop at SODA/FOCS, or an information-theory workshop (ITA).
**Executor.** Executor T.  **Judge.** Judge π + Judge G (for the property-testing framing).
**Forward-pointer.** "by the two-query identity [Author, IPL 2026], the bracket is locally testable from $O(\alpha^{-2})$ label queries..."

#### O6 — *"The aggregator half-chain: mean and max are incomparable in the multiset refinement lattice"*  *(C7)*

**Mode:** Star (directly cited by §5 Corollary 4 of the main paper; this satellite inoculates against the round-4 [Critical] failure mode of over-claiming as a chain).

**Content.** A short workshop paper, ~6–8 pages. Prove that the partition induced by sum-equivalence on multisets refines both mean-equivalence and max-equivalence, while mean-equivalence and max-equivalence are incomparable. Concrete counterexamples (the ones already in §5). Lift to the bracket-floor consequence: $\varepsilon^*(\Pi_{\mathrm{sum}})\le\min\{\varepsilon^*(\Pi_{\mathrm{mean}}),\varepsilon^*(\Pi_{\mathrm{max}})\}$ with no comparison between mean and max in general. **Include the floor-vs-achieved caveat loudly** — this is exactly where Judge G's veto would land.

**Why this matters.** The main paper's Corollary 4 was a [Critical] failure mode in round 4 ([`12`](12-external_reviewer_second_audit_of_draft0.3.md) C-1) when it was over-claimed as a chain. Publishing the half-chain correctly framed inoculates the main paper.

**Primary venue.** Learning on Graphs (LoG) Conference — workshop track or "Extended Abstract" track. LoG is heavily remote-friendly and has fast review. *Fallback:* NeurIPS LoG workshop (parallel community) or *Information Processing Letters* (if rephrased as pure combinatorics).
**Executor.** Executor G.  **Judge.** Judge G (must veto if floor/achieved confusion creeps back).
**Forward-pointer.** "the half-chain of [Author, LoG 2026]..."

#### O7 — *"A level-set floor and its convex envelope: lower bracket for multiclass Bayes risk"*  *(C5)*

**Mode:** Star (directly cited by §4.1 of the main paper).

**Content.** A short paper, ~6–10 pages. Define $\ell_\varphi(v)=\inf\{R(\boldsymbol\eta):\varphi(\boldsymbol\eta)=v\}$ on the simplex, take its biconjugate $\ell_\varphi^{**}$, and prove the lower bracket $\ell_\varphi^{**}(\bar\varphi(\Pi))\le\varepsilon^*(\Pi)$. Include the binary collapse ($\ell_\varphi=\varphi^{-1}$, already convex, $\ell_\varphi^{**}=\varphi^{-1}$). Position as the resolution-axis analogue of the BJM $\psi$-transform.

**Why this matters.** The lower bracket in the simplex case is the one piece of §4.1 that is genuinely implicit (no closed form for $\ell_\varphi$ in general). Publishing this construction lets the main paper say "the lower bracket of §4.1 is the construction of [Author, ...]; here we apply it to..." rather than carrying the definitions inline.

**Primary venue.** *Statistics & Probability Letters* or *Optimization Letters* (Springer, short OR/convex-analysis notes). *Fallback:* *Electronic Journal of Statistics* (longer-form, ~moderate turnaround).
**Executor.** Executor T (with Executor S co-authoring on the BJM contrast).  **Judge.** Judge S + Judge π.
**Forward-pointer.** "the lower bracket [Author, SPL] specialises here to..."

#### O8 — *"Three partitions per depth: WL ceiling, architecturally realized, operationally observed"*  *(C8)*

**Mode:** Bush + Star (taxonomy paper plus a few results; cited by §6 of the main paper as the framing vocabulary).

**Content.** A short workshop paper, ~6–8 pages. Define the three partitions (Πᵂᴸ, Π_𝒜, Π_ε) and identify over-smoothing as the gap between Πᵂᴸ (monotone-refining) and Π_ε (coarsening past $L^*(\varepsilon)$). State Theorem 5(a) along the depth axis. **Do not claim quantitative bounds** — those are OP2 and belong to the open-problem satellite. Frame as a *taxonomy* / *organising-principle* paper.

**Why this matters.** The three-partition framing is the cleanest contribution of §6. Currently buried in the main paper; deserves its own pointer so the over-smoothing community can adopt the vocabulary.

**Primary venue.** NeurIPS workshop — either LoG workshop or a new GNN-theory workshop. *Alternative:* ICML workshop on Geometric Deep Learning / TAG-ML. *Fallback:* LoG conference workshop track.
**Executor.** Executor G.  **Judge.** Judge G + Judge π.
**Forward-pointer.** "in the three-partition framing of [Author, NeurIPS workshop 2026]..."

### Tier 3 — Open problems (cheap to write, high citation leverage)

#### O9 — *"Quantitative over-smoothing: minimum separating distance under spectral contraction"*  *(C12, OP2)*

**Mode:** Star (cited as Open Problem in §8 OP2 of the main paper).

**Content.** A short open-problem statement, ~2–4 pages. State OP2 precisely: prove (or refute) that under standard contractive-aggregator hypotheses (e.g., Oono–Suzuki 2020 + uniform contraction across the non-leading spectrum), $\delta^{(L)}\le C\lambda_2^L$ with explicit $C$. Survey what is known qualitatively (Rusch–Bronstein–Mishra 2023 survey, etc.). State the load-bearing "worst-pair stability" assumption and ask whether it is removable.

**Primary venue.** COLT Open Problems track. *Caveat:* COLT runs annually; the Open Problems track has a separate (usually shorter) deadline. Verify COLT 2027 OP deadline (typically Feb–Apr 2027 for July 2027 conference). *Earlier alternative:* a NeurIPS / ICML workshop with an "open problems" section (some workshops solicit these), or the *ALT (Algorithmic Learning Theory) Conference* Open Problems track.
**Executor.** Executor G.  **Judge.** Judge G.
**Forward-pointer.** "see Open Problem [Author, COLT OP 2027 / ALT OP 2027]."

#### O10 — *"Gap amplification for aggregator brackets: toward a PCP-style expressivity theorem"*  *(C13, OP3)*

**Mode:** Star (cited as Open Problem in §8 OP3 of the main paper).

**Content.** A short open-problem statement, ~3–5 pages. State OP3: is there a graph operation under which $\Delta(G)=\varepsilon^*(\Pi_{\mathrm{mean}})-\varepsilon^*(\Pi_{\mathrm{sum}})$ is driven from a small positive constant to a constant of order 1, while $\varepsilon^*(\Pi_{\mathrm{sum}})$ is preserved? Survey the PCP analogy honestly (locally-checkable half is done; amplification half is open). Note the standard amplification primitive (zig-zag / replacement product) is defined for regular graphs and may not act on the labeled aggregator-gap quantity as-is.

**Primary venue.** COLT Open Problems (paired with O9, possibly bundled as a single submission). *Alternative:* ITCS (deadline ~Sep 2026 for January 2027 conference) — ITCS does accept conceptual / open-problem-style papers.
**Executor.** Executor G + Executor T.  **Judge.** Judge G + Judge π.
**Forward-pointer.** "see Open Problem [Author, COLT OP 2027]."

#### O11 — *"Soft cell assignments: a Markov-kernel lifting question for partition-bracket calibration"*  *(C14, OP1b)*

**Mode:** Star (cited as Open Problem in §8 OP1b of the main paper).

**Content.** A short open-problem statement, ~3–5 pages. State OP1b: does the simplex rigidity (Theorem 2′ in the main paper, or a self-contained statement here) survive a soft-kernel lifting $K:\mathcal X\to\Delta(\mathrm{Cells})$? Motivate by attention / GAT / differentiable pooling / graph transformers. State the binary and simplex versions separately.

**Primary venue.** NeurIPS workshop on graph transformers / GNNs (open-problem session) or ICML workshop on Geometric Deep Learning. *Alternative:* LoG conference workshop.
**Executor.** Executor G.  **Judge.** Judge G + Judge π.
**Forward-pointer.** "see Open Problem [Author, NeurIPS workshop OP 2026]."

### Tier 4 — Methodology / meta / formal-methods

#### O12 — *"Partition-functional Jensen for finite partitions in Lean 4"*  *(C10)*

**Mode:** Bush (Lean library description; cited by main paper Appendix A.5 as the infrastructure layer the Phase C2 commit landed).

**Content.** A formal-methods short paper, ~8–12 pages. Describe the Phase C2 abstraction layer (`refining`, `sum_cellMass_refining_eq`, `cellRate_mul_cellMass_refining_sum`, `barPhi_refinement_le`). Argue it is *the* tool the wider Lean probability community needs while the full conditional-Jensen (Degenne `testing-lower-bounds` Sorry/Jensen.lean) remains open in mathlib. Include a worked port to a non-rigidity setting (e.g., an information-theoretic chain rule that fits the same abstraction).

**Primary venue.** CICM (Conferences on Intelligent Computer Mathematics) — system / library descriptions, ~3–4 month turnaround. *Alternative:* CPP 2027 (Certified Programs and Proofs; Sep 2026 deadline). *Workshop fallback:* ITP work-in-progress track (typically remote-friendly, fast review).
**Executor.** Executor F.  **Judge.** Judge F.
**Forward-pointer.** "using the partition-functional Jensen library of [Author, CICM 2026]..."

#### O13 — *"Sierpiński's theorem on atomless measures: a mathlib contribution and tutorial"*  *(C11)*

**Mode:** Star (mathlib PR + tutorial; cited by main paper Appendix A.7 as the discharger for all four realizability typeclasses).

**Content.** Paired deliverable: (a) the mathlib PR itself (already drafted at [`.research/sierpinski-pr/`](.research/sierpinski-pr/)), (b) a short tutorial / system description, ~6–10 pages. Statement (every $v\in[0,\mu(\mathcal X)]$ is realised by some measurable $S$, given $[\mathrm{NoAtoms}\,\mu]$ and σ-finiteness), IVT-via-MeasuredSets proof, four downstream consequences (the rigidity-local realizability typeclasses retired).

**Why this matters.** Closes the mathlib PR loop and gives every paper that uses atomless-realizability (this paper + future work) a clean citation. **High community value** (MathOverflow #222583, etc.).

**Primary venue.** CICM tutorial track or ITP system description. *Alternative:* *Journal of Automated Reasoning* short note. *Workshop fallback:* TYPES workshop (formal methods, usually remote-friendly).
**Executor.** Executor F.  **Judge.** Judge F + Judge T (mathematical correctness of the Sierpiński statement).
**Forward-pointer.** "by Sierpiński (Mathlib PR; tutorial [Author, CICM 2026])..."

#### O14 — *"Adversarial-audit cycles for mechanised mathematics: a development methodology"*  *(C15, C16)*

**Mode:** Bush (methodology paper; cited by main paper Appendix B.3 as the audit-cycle methodology behind the seven-round audit trail).

**Content.** A methodology paper, ~10–14 pages. Distil the workflow from rounds 1–7 of the main paper. Sections: (1) the seven-round audit cadence, (2) Tao-style step-by-step skeletonisation (with the Phase D Step-2 chord-trick discovery as a concrete case study), (3) the WSL bridge as a Windows-side toolchain pattern, (4) per-piece adversarial persona assignment, (5) reproducibility harness design. Reference the three skill files in [`.agents/skills/`](.agents/skills/).

**Why this matters.** A reusable workflow contribution that doesn't require the main paper's mathematical content. Establishes the user as having a *methodology* worth citing, independent of any one mathematical result.

**Primary venue.** CICM (formal mathematics, methodology track). *Alternative:* *Journal of Automated Reasoning* system description. *Workshop fallback:* LFMTP (Logical Frameworks and Meta-Languages) or HaTT.
**Executor.** Executor F + Executor E.  **Judge.** Judge F.
**Forward-pointer.** "the audit-cycle methodology of [Author, CICM 2026]..."

### Tier 5 — Exploration (paradigm-adjacent, not in the main paper)

The pieces below develop *new* constructs under the resolution-axis calibration paradigm — refinement lattices, concave-score brackets, partition functionals, locally-testable property-test reductions — that the main paper does *not* invoke. They are **Mode E** (Exploration): not citable by the main paper, but they populate the same intellectual neighbourhood, so reviewers and future authors will find a coherent literature already there. These are the **highest-risk, highest-novelty** pieces in the plan, in the spirit of the user's directive to do "aggressive risky concurrent exploration." Tier 5 pieces have no dependency on the main paper and no dependency on each other; they can be drafted at any point in the queue, in parallel with any Star or Bush piece.

#### O15 — *"f-divergence brackets on the refinement lattice"*  *(C17)*

**Mode:** Exploration (not in the main paper; the Reid–Williamson dual viewpoint on the resolution axis).

**Content.** A short paper, ~6–10 pages. Every normalized concave score $\varphi$ has a Reid–Williamson partner: an f-divergence $D_\varphi$ such that, for a binary classification with class-conditionals $\mathbb P_+,\mathbb P_-$ and marginal $\mathbb P$, the cell-conditional drop $\varphi(\eta_i) - \varphi(\mathbb P(f=1))$ equals (up to normalization) an f-divergence between the cell-conditional and the marginal. Aggregate: the *partition f-divergence* $\bar D_\varphi(\Pi) = \sum_i p_i D_\varphi(\boldsymbol{\eta}_i \| \boldsymbol{\eta}_{\text{marg}})$ is refinement-*increasing* (the dual sign of $\bar\varphi$'s refinement-decrease), and it sandwiches the achievable-floor *improvement* $\varepsilon^*(\Pi_{\text{coarse}}) - \varepsilon^*(\Pi)$ from below. The bracket bounds $\varepsilon^*$ in terms of $\bar\varphi$; this f-divergence sandwich bounds the *improvement* from coarsening to refining in terms of how much "information" the refinement adds.

**Why this matters.** Reid–Williamson 2011 give the bijection on the optimization axis (proper losses ↔ f-divergences); the resolution-axis dual is sitting there waiting. Companion to O1, same paradigm, different vocabulary. The information-theory community will read this far more naturally than the bracket itself.

**Primary venue.** *Statistics & Probability Letters* (SPL). *Alternative:* *Information Geometry* (Springer, peer-reviewed, fits the dual-of-bracket framing perfectly). *Fallback:* *Electronic Communications in Probability*.

**Executor.** Executor S.  **Judge.** Judge S + Judge π.

**Ecosystem value.** Populates the paradigm with the f-divergence partner; gives information-theory readers a familiar handle without requiring them to learn the bracket first.

#### O16 — *"Le Cam deficiency for partition coarsenings"*  *(C18)*

**Mode:** Exploration (not in the main paper; calibrates the qualitative Blackwell refinement order).

**Content.** A short paper, ~8–12 pages. Le Cam's deficiency $\delta(\mathcal E_1, \mathcal E_2)$ measures the cost of using experiment $\mathcal E_2$ in place of $\mathcal E_1$ for an arbitrary decision problem. Refinement of partitions is a special case: $\Pi \succeq \Pi_0 \Rightarrow \delta(\Pi, \Pi_0) = 0$ (the finer experiment dominates). The interesting reverse question: how much does *coarsening* cost? Define a coarsening-deficiency $\delta_{\text{coarsen}}(\Pi, \Pi_0)$ for $\Pi_0 \preceq \Pi$ and show it admits a calibrated bracket using normalized concave scores: $\delta_{\text{coarsen}}(\Pi, \Pi_0) \le c_\varphi \cdot (\bar\varphi(\Pi_0) - \bar\varphi(\Pi))$. So the *same* scoring functionals that govern the achievable floor also govern Le Cam deficiency on the refinement lattice.

**Why this matters.** Le Cam's theory is the canonical comparison-of-experiments machinery in statistics; connecting it to the bracket plants a flag in the statistical-decision-theory community for the paradigm. Independent value: a calibrated refinement of Blackwell's qualitative order — a long-standing wish on the comparison-of-experiments side.

**Primary venue.** *Bernoulli* (probability, accepts Le Cam-flavored work) or *Electronic Communications in Probability*. *Alternative:* *Statistical Science* (longer-form exposition, slower but high visibility for a paradigm piece). *Workshop fallback:* an IMS workshop session on comparison of experiments.

**Executor.** Executor T + Executor S.  **Judge.** Judge S.

**Ecosystem value.** Lands the paradigm in classical statistical decision theory; the Le Cam community gets a calibrated tool that is theirs (not the GNN-flavored bracket of the main paper).

#### O17 — *"Sample-complexity of the partition-functional bracket"*  *(C19)*

**Mode:** Exploration (not in the main paper; §7's honest-cost-accounting paragraph touches the question but does not formalize).

**Content.** A short paper, ~6–10 pages. The bracket is a *population* quantity: $\bar\varphi(\Pi) = \sum_i p_i \varphi(\eta_i)$ assumes exact knowledge of cell masses $p_i$ and cell rates $\eta_i$. In practice both are estimated. Give Bernstein / empirical-process bounds for $|\hat{\bar\varphi}(\Pi) - \bar\varphi(\Pi)|$ in terms of per-cell sample size $n_i$ and the modulus of continuity of $\varphi$. Identify when finite-sample $\hat{\bar\varphi}$ is a valid plug-in for the bracket's upper instrument. Cross-check with the §7 two-query identity (the empirical $\hat p_{\text{dis}}$ is itself a bracket-instrument estimator with Hoeffding control).

**Why this matters.** This is the practical-statistics paper the main paper avoids on purpose — it's about *floors*, not *estimation*. Publishing it as a satellite means anyone who tries to *apply* the bracket to data has a referee-tested concentration result to point at. Closes the most common "but how do you estimate it?" referee question without burdening the main paper.

**Primary venue.** *Statistics & Probability Letters* (SPL). *Alternative:* *Electronic Journal of Statistics* (longer-form, accepts methodology). *Workshop fallback:* AISTATS, *Bernoulli*.

**Executor.** Executor S.  **Judge.** Judge S.

**Ecosystem value.** Bridges the population-functional bracket (theory) and finite-sample estimation (practice); arms practitioners.

#### O18 — *"A distributionally-robust bracket under Wasserstein cell uncertainty"*  *(C20)*

**Mode:** Exploration (not in the main paper; lifts the bracket to adversarial / DRO settings).

**Content.** A short paper, ~6–10 pages. Suppose the cell distributions $\boldsymbol\eta_i$ are not known exactly but lie in a Wasserstein ball $W_p(\boldsymbol\eta_i, \hat{\boldsymbol\eta}_i) \le r_i$ around empirical estimates (the distributionally-robust optimization setup). Define the *robust bracket* as the min–max of $\bar\varphi$ over this uncertainty. Use the concavity of $\varphi$ to give a closed-form robust upper instrument. Compare with the nominal bracket; quantify the *cost of robustness* as a function of the radii $r_i$ and the Lipschitz constant of $\varphi$. Specialize to the entropy and Gini scores.

**Why this matters.** Distributionally-robust optimization is a major contemporary line in ML and statistics; the resolution-axis paradigm has not been imported there. This piece does the import without ever touching GNNs, so it stands on its own as a DRO contribution. Generates citations from a community the main paper would otherwise miss entirely.

**Primary venue.** *Operations Research Letters* (ORL). *Alternative:* SPL or *Optimization Letters*. *Workshop fallback:* AISTATS workshops, ICML workshops on DRO.

**Executor.** Executor T + Executor S.  **Judge.** Judge S + Judge π.

**Ecosystem value.** Bridges to robust optimization; gives the DRO community a new partition-functional inequality with a closed-form robust upper instrument.

#### O19 — *"Bregman brackets on the simplex of cell distributions"*  *(C21)*

**Mode:** Exploration (not in the main paper; the information-geometric sibling of §4).

**Content.** A short paper, ~6–10 pages. The simplex bracket of §4.1 in the main paper uses arbitrary continuous vertex-vanishing scores. In information geometry the natural choice is a Bregman divergence $D_\phi(\boldsymbol\eta_i \| \boldsymbol\eta_0)$ generated by a convex potential $\phi$. Specialize the simplex bracket to Bregman scores: $\bar D_\phi(\Pi) := \sum_i p_i D_\phi(\boldsymbol\eta_i \| \mathbf u)$ is refinement-monotone and brackets the achievable improvement from below. For specific $\phi$ — squared-norm (Euclidean), negative entropy (KL), $\tfrac12$-norm-squared restricted to the sphere (Fisher–Rao) — recover known information-geometric quantities. Position as the resolution-axis transposition of Amari's information geometry.

**Why this matters.** Information geometry has its own community (Amari, Ay, Jost, Nielsen) and they have not seen the partition-restricted setup. Publishing here puts the paradigm on their radar with a vocabulary they already speak fluently. Likely to attract citations from the Geometric Science of Information community.

**Primary venue.** *Information Geometry* (Springer, peer-reviewed). *Alternative:* SPL. *Workshop fallback:* Geometric Science of Information (GSI) conference (biennial; verify the next cycle).

**Executor.** Executor T.  **Judge.** Judge S + Judge π.

**Ecosystem value.** Lands the paradigm in information geometry; gives Amari/Nielsen-trained readers a partition-restricted Bregman bracket they will instantly recognize.

#### O20 — *"A mixing-time-corrected two-query bracket for Markov-chain co-cell sampling"*  *(C22)*

**Mode:** Exploration (not in the main paper; extends Prop 6 from IID to Markov-chain sampling).

**Content.** A short paper, ~6–10 pages. The two-query identity of §7 (Proposition 6) assumes IID same-cell pairs: $X$ uniform on nodes, $X'$ uniform on the cell $\Pi(X)$. In graph applications co-cell pairs are typically drawn from a graph random walk or a Markov chain that mixes inside each cell, not IID. Generalize Hoeffding (Corollary 7) to a Markov-chain Bernstein with a mixing-time correction: if the chain mixes in time $\tau$ on each cell, the sample-complexity bound for $\hat p_{\text{dis}}$ inflates by a factor of order $\tau$. Use Paulin 2015 (concentration for Markov chains with explicit mixing-time dependence) or Lezaud 1998 (Bernstein for chain MGFs).

**Why this matters.** Anyone applying the §7 local test to actual graph data is sampling co-cell pairs via walks, not IID. Publishing this satellite gives them a sound replacement for the IID Hoeffding. Independent value beyond the paradigm: Markov-chain Bernstein has uses across statistics, ML, and theoretical CS.

**Primary venue.** *Information Processing Letters* (IPL). *Alternative:* *Electronic Communications in Probability*. *Workshop fallback:* SODA/FOCS property-testing workshops, or ITCS.

**Executor.** Executor T + Executor G (Markov-chain expertise + graph-walk context).  **Judge.** Judge π.

**Ecosystem value.** Closes the IID-vs-walk gap for anyone deploying the local test; gives the graph-walk and Markov-chain communities a partition-functional concentration result.

---

## 5. The Venue Catalog

Verified-as-existing venues, with the turnaround estimate I'd plan against (each one should be sanity-checked by the user via the venue's current website before submission — turnaround claims drift). All venues marked **REMOTE OK** explicitly support remote presentation; venues without that tag should be verified.

### 5.1 Letters / Notes / Short-form journals (peer-reviewed)

| Venue | Publisher | Format | Est. review time | Notes |
|---|---|---|---|---|
| *Comptes Rendus Mathématique* (CRAS) | Académie des sciences (Elsevier hosting) | Short notes, ~4–8 pp | ~2–4 mo | Historical home of one-page classical-fact notes. Bilingual French/English accepted. **REMOTE OK** (no presentation). |
| *Statistics & Probability Letters* | Elsevier | Short papers, ~6–10 pp | ~2–4 mo (verify) | Standard fast venue for statistics short notes. |
| *Information Processing Letters* (IPL) | Elsevier | Short TCS notes, ~4–8 pp | ~2–4 mo | Algorithm/combinatorics/property-testing flavored notes. |
| *Operations Research Letters* | Elsevier | Short OR notes | ~2–4 mo | Optimization / OR flavor. |
| *Optimization Letters* | Springer | Short optimization notes | ~3–5 mo | Convex analysis adjacent. |
| *Electronic Communications in Probability* (ECP) | IMS / Bernoulli Society | Short probability notes, open access | ~3–6 mo | Sister of *Electronic Journal of Probability*. |
| *Bulletin of the London Mathematical Society* | LMS | Short papers | ~4–6 mo | General math, accepts short. |
| *Proceedings of the American Mathematical Society* (PAMS) | AMS | Short papers | ~4–9 mo | General math, slower than CRAS but more prestige. |
| *Canadian Mathematical Bulletin* | CMS | Short papers | ~moderate (verify) | Similar tier to PAMS. |

### 5.2 Expository / methodology venues

| Venue                                              | Publisher             | Format                               | Est. review time          | Notes                                                                                |
| -------------------------------------------------- | --------------------- | ------------------------------------ | ------------------------- | ------------------------------------------------------------------------------------ |
| *EMS Magazine* (formerly EMS Newsletter)           | European Math Society | Short expository ~4–8 pp             | ~3–6 mo                   | Methodology/expository pieces welcome.                                               |
| *Snapshots of Modern Mathematics from Oberwolfach* | MFO (open access)     | Short, accessible to non-specialists | ~2–4 mo                   | **Peer-reviewed.** Fast. Excellent for "the bracket" or "the transposition" framing. |
| *Mathematical Intelligencer*                       | Springer              | Expository, ~6–12 pp                 | ~3–6 mo                   | More popular tone.                                                                   |
| *Expositiones Mathematicae*                        | Elsevier              | Expository / surveys                 | ~3–6 mo                   | Technical expository, well-respected.                                                |
| *L'Enseignement Mathématique*                      | Suisse / EMS          | Expository + research                | ~moderate                 | International, bilingual.                                                            |
| *American Mathematical Monthly* (Monthly)          | MAA                   | Notes & articles                     | ~6–12 mo (slow)           | High visibility but slow — may not fit author's bracket.                             |
| *Math. Mag.* (Mathematics Magazine)                | MAA                   | Notes                                | ~6–12 mo (slow)           | Same caveat as Monthly.                                                              |
| *College Mathematics Journal*                      | MAA                   | Notes                                | ~6–12 mo                  | Same.                                                                                |
| *Notices of the AMS*                               | AMS                   | Expository, ~mostly invited          | ~3–6 mo when commissioned | Mostly invited; not a primary target.                                                |

### 5.3 Statistics / probability journals (longer-form, slower)

| Venue | Format | Est. review time | Notes |
|---|---|---|---|
| *Electronic Journal of Statistics* | Full papers, open access | ~moderate (3–6 mo first round) | Faster than *Annals*; accepts methodology. |
| *Stat* (Wiley) | Short stats papers | ~moderate | Faster sibling of *J. Roy. Stat. Soc.* |
| *Bernoulli* | Full papers | ~slow (6–12 mo) | Probability/statistics, prestigious. Le Cam-flavored work fits here. |
| *Statistical Science* | Long-form expository + review papers | ~moderate to slow (4–9 mo) | IMS, high-visibility expository venue. Good for paradigm-positioning Exploration pieces (e.g. O16). |
| *Annals of Statistics* | Full papers | ~slow (9–18 mo) | Top venue — likely too slow for satellite track. |
| *J. Mach. Learn. Res.* (JMLR) | Full papers + open access | ~moderate (4–9 mo) | Accepts methodology. Listed here for the main paper's fallback, not satellites. |
| *Information Geometry* (Springer) | Full + short papers | ~moderate (3–6 mo; verify) | Peer-reviewed, info-geometry focused. Natural home for Bregman/f-divergence/Fisher–Rao framings (O15, O19). |

### 5.4 ML conferences / workshops

| Venue | Track | Submission window | Decision time | Notes |
|---|---|---|---|---|
| **Learning on Graphs (LoG) Conference** | Main + workshops + extended abstracts | Sep–Oct typically | ~1–2 mo | **REMOTE / virtual-first** — perfect fit. |
| **NeurIPS workshops** | ~30+ workshops | Workshop deadlines Aug–Sep | ~1 mo | Many workshops **REMOTE-friendly**. Examples: LoG workshop, GLFrontiers, Math-AI. |
| **ICML workshops** | ~25+ workshops | Workshop deadlines May–Jun | ~1 mo | Many **REMOTE-friendly**. Examples: TAG-ML, ML4PS, Workshop on Geometric Deep Learning. |
| **ICLR workshops / TinyPapers** | Workshops + TinyPapers | Workshop deadlines Feb–Mar | ~1 mo | TinyPapers is 2–3 pp, **REMOTE OK**. |
| **AISTATS workshops** | Workshops | Workshop deadlines Oct–Nov | ~1 mo | **REMOTE-friendly**. |
| **GSI (Geometric Science of Information)** | Conference + proceedings | Biennial; verify cycle | ~2–3 mo | Information-geometry-focused; natural home for O15 / O19. |
| **COLT Open Problems track** | Open problems | Annual, ~Apr–May | ~1 mo | Separate from main COLT; designed for short open-problem statements. |
| **ALT Open Problems** | Open problems at ALT | Annual | ~1 mo | Algorithmic Learning Theory, similar to COLT OP. |
| **ITCS** | Innovations in TCS | Annual ~Sep deadline | ~2 mo | Accepts conceptual papers; less open-problem-specific. |
| **TMLR** (Transactions on ML Research) | Continuous submission | ~2–3 mo first decision | Open access, peer reviewed, **REMOTE / no conference**, fast — strong fit. |

### 5.5 Formal methods / ITP venues

| Venue | Format | Submission window | Notes |
|---|---|---|---|
| **CPP (Certified Programs and Proofs)** | Full + short | ~Sep deadline for Jan conference | Co-located with POPL; some remote support. |
| **ITP (Interactive Theorem Proving)** | Full + rough-diamonds + system descriptions | Annual (~Feb-Mar deadline) | **Hybrid usually OK.** |
| **CICM (Intelligent Computer Mathematics)** | Papers + system descriptions + tutorials | Annual | Methodology / tools well-fit; **hybrid usually OK**. |
| **LFMTP (Logical Frameworks)** | Workshop | Annual | Workshop, **REMOTE-friendly**. |
| **TYPES** | Workshop | Annual | **REMOTE-friendly**. |
| **IJCAR** | Conference | Biennial | International joint automated reasoning. |
| *Journal of Automated Reasoning* (JAR) | Full journal | ~6–12 mo | Long form. |
| *Logical Methods in Computer Science* (LMCS) | Open-access journal | ~moderate | Open access. |

---

## 6. Round Structure (batch order, not calendar)

**Timing note.** "Round" below labels *batch dependency order*, not calendar months. The author's writing speed is not the bottleneck — review turnaround and venue deadlines are. Calendar references in earlier drafts of this section have been replaced with venue-deadline references, which are the only timing constraints that actually matter.

**Exploration runs concurrent.** Tier 5 (§4.5) pieces (O15–O20) have no dependency on the main paper and no dependency on each other; they can be drafted at any point in the queue, in parallel with any Star or Bush piece. The recommended approach is to **interleave one or more Exploration pieces per Round**, so the portfolio grows in breadth (paradigm reach) as well as depth (main-paper backstop). This is what the round breakdowns below do.

### 6.1 Round 1 — first batch: the four Tier-1 pieces (+ one Exploration)

All four Tier-1 opportunities (O1, O2, O3, O4) drafted in parallel, plus one Exploration piece (O15 — f-divergence sibling of the bracket, natural pairing with O1).

**Phase 1.1 — Skeleton drafts (concurrent).**
- Executor T drafts O1 (bracket + $c_\varphi=\tfrac12$) and O4 (single-cell pinning).
- Executor T or co-author drafts O3 (chord substitution).
- Executor E drafts O2 (methodology note).
- Executor S drafts O15 (f-divergence sibling — Exploration; pairs with O1).
- Each draft: complete statement of every theorem, every example, every literature contrast. No proofs yet for any new lemma — only proofs that are direct ports from the main paper.

**Phase 1.2 — Adversarial audit (concurrent).**
- Judge π audits all five. Judge S audits O1, O2, O4, O15. Judge G audits if any GNN content creeps in (should not for this batch).
- Pattern: each judge produces a numbered findings memo (severity-tagged: [Critical] / [Material] / [Minor] / [Strategic]), same format as rounds 1–7 of the main paper.

**Phase 1.3 — Closure drafts (concurrent).**
- Each executor closes their judge's findings, produces draft 0.2, gets judge sign-off.

**Phase 1.4 — Submission (concurrent).**
- O1 → SPL.
- O2 → EMS Magazine (or Snapshots).
- O3 → CRAS.
- O4 → CRAS.
- O15 → SPL or *Information Geometry*.
- All five also deposited on arXiv simultaneously, with a single common ontology preface so they cross-reference each other.

### 6.2 Round 2 — second batch: Tier-2 tools (+ three Exploration pieces)

Phase 2.1–2.4 mirror Round 1, applied to:
- **Star/Bush:** O5 (two-query identity → IPL), O6 (half-chain → LoG), O7 (level-set floor → SPL / OptLett), O8 (three-partition → NeurIPS LoG workshop).
- **Exploration:** O16 (Le Cam deficiency → Bernoulli / ECP), O19 (Bregman brackets → *Information Geometry*), O20 (Markov-chain Bernstein → IPL).

**Concurrency.** O5, O6, O7, O16, O19, O20 are independent; O8 depends on O6 (the half-chain is invoked in §6 of the main paper, and the workshop draft of O8 will cite O6). Sequence: parallel batch except O8 follows O6. Workshop deadlines (LoG, NeurIPS workshops typically Aug–Sep) are the binding constraint, not author throughput.

### 6.3 Round 3 — third batch: open problems + formal methods (+ remaining Exploration)

Phase 3.1–3.4 for:
- **Open problems:** O9 (over-smoothing OP → ALT OP or workshop), O10 (gap amplification OP → COLT OP 2027 if deadline allows, else ITCS), O11 (soft kernels OP → NeurIPS workshop).
- **Formal methods:** O12 (partition-functional Jensen → CICM / CPP), O13 (Sierpiński → CICM tutorial + mathlib PR), O14 (audit-cycle methodology → CICM / JAR).
- **Exploration:** O17 (sample-complexity → SPL), O18 (DRO bracket → ORL).

**Concurrency.** O9, O10, O11 are independent open-problem statements (cheap). O12, O13, O14 are formal-methods pieces; O13 has a dependency on the mathlib PR being mergeable (or at least under review). O17, O18 are independent of everything else.

### 6.4 Round 4 — Main paper drop

Aligned with the main-paper submission (COLT 2027 or JMLR, per panel verdict §5). By Round 4 the main paper's bibliography contains 8–12 satellite citations (Star + Bush from Rounds 1–3, all peer-reviewed or under-review), plus a "see also" / "ecosystem" footnote pointing to the Exploration pieces (O15–O20) that populate the surrounding paradigm.

### 6.5 Per-round discipline

Every round runs the **same five-question pre-flight check** from §1.3 for every piece (Star, Bush, or Exploration). Every round produces a numbered findings memo (next number in the workspace's `22-...md`, `23-...md`, ... sequence). Every round closes only when the judge signs off in writing.

---

## 7. Risk Register

| Risk                                                                             | Likelihood                | Mitigation                                                                                                                                                                                                |
| -------------------------------------------------------------------------------- | ------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Salami-slicing accusation                                                        | Moderate                  | Each satellite is *not* a slice of the main paper — it stands alone (per §1.1 principle). Each satellite explicitly cites the *concepts* from the main paper without revealing the full GNN construction. |
| Main paper rejected on novelty grounds because satellites "already published it" | Low                       | Satellites are deliberately scoped to a *single construct each*, never the integration. The main paper's contribution is the integration, which no satellite duplicates.                                  |
| Venue turnaround drift (estimates above prove optimistic)                        | High                      | Every estimate above is "verify before submission" — author should check current websites. Fallback venues listed for each.                                                                               |
| MAA venues too slow for the 6-month bracket                                      | High for O3 if MAA chosen | Default O3 to CRAS, not Monthly.                                                                                                                                                                          |
| Workshop acceptance highly variable                                              | Moderate                  | Multiple workshops per ML cycle (NeurIPS / ICML / ICLR / LoG); resubmit.                                                                                                                                  |
| Sierpiński mathlib PR review > 6 months                                          | Moderate                  | Tutorial (O13) can publish before merge; cites the PR by number.                                                                                                                                          |
| Authorship attribution / coordination of personas                                | Low (single author)       | All "executors" and "judges" are roles played by the author + tooling. Stated in any acknowledgements: methodology per [`.agents/skills/`](.agents/skills/).                                              |
| Over-claiming in satellites (the round-4 / round-6 failure modes recurring)      | Moderate                  | Judge π and the per-piece judges have explicit veto. Same audit cadence as the main paper.                                                                                                                |
| Exploration piece (Tier 5) rejected for being "out of scope" of the chosen venue | Moderate                  | Each Exploration piece carries an explicit venue rationale in §4.5; fallbacks listed; arXiv deposit gives a citable pointer regardless of refereeing outcome.                                             |
| Exploration piece scooped (someone else publishes the same construct first)      | Low to moderate           | Exploration pieces are deliberately broad-paradigm; if scooped on the specific construct, the *paradigm population* value still accrues. The arXiv preprint claims priority.                              |

---

## 8. The Two Lists (deliverables)

### 8.1 List of Opportunities to Write

Compact form for project tracking. Tier / Mode / opportunity ID / one-sentence purpose / primary venue / fallback. **No calendar estimates** per the author's note — author authoring speed is not the bottleneck; venue deadlines and review turnaround are.

**Mode column:** **S** = Star (directly citable by main paper), **B** = Bush (around the concept, methodology / expository), **E** = Exploration (paradigm-adjacent, new construct not in main paper). Per §1.4.

| #       | Tier | Mode    | One-line description                                                             | Primary venue                                               | Fallback                                                    |
| ------- | ---- | ------- | -------------------------------------------------------------------------------- | ----------------------------------------------------------- | ----------------------------------------------------------- |
| **O1**  | 1    | **S**   | The bracket + universal $c_\varphi=\tfrac12$ for normalized concave scores       | *Statistics & Probability Letters*                          | *Electronic Communications in Probability*                  |
| **O2**  | 1    | **B**   | Calibration on the resolution axis — methodology note                            | *EMS Magazine*                                              | *Snapshots from Oberwolfach* / *Mathematical Intelligencer* |
| **O3**  | 1    | **S**   | The chord substitution closes the continuous Jensen-equation                     | *Comptes Rendus Mathématique*                               | *Expositiones Mathematicae*                                 |
| **O4**  | 1    | **S**   | Single-cell pinning — short proof of tent uniqueness                             | *Comptes Rendus Mathématique*                               | *Statistics & Probability Letters*                          |
| **O5**  | 2    | **S**   | A two-query identity for the partition Bayes risk                                | *Information Processing Letters*                            | TMLR / IEEE TIT correspondence                              |
| **O6**  | 2    | **S**   | The aggregator half-chain — mean/max incomparable in multiset refinement lattice | LoG Conference workshop / extended abstract                 | NeurIPS LoG workshop / IPL                                  |
| **O7**  | 2    | **S**   | Level-set floor and biconjugate envelope — lower bracket for multiclass          | *Statistics & Probability Letters* / *Optimization Letters* | *Electronic Journal of Statistics*                          |
| **O8**  | 2    | **B/S** | Three partitions per depth (WL / architecturally realized / operational)         | NeurIPS LoG workshop                                        | ICML TAG-ML / LoG conference workshop                       |
| **O9**  | 3    | **S**   | Open Problem: quantitative over-smoothing                                        | ALT Open Problems / COLT OP 2027                            | NeurIPS workshop OP session                                 |
| **O10** | 3    | **S**   | Open Problem: gap amplification for aggregator brackets (PCP-style)              | COLT Open Problems 2027                                     | ITCS 2027                                                   |
| **O11** | 3    | **S**   | Open Problem: soft cell assignments — Markov-kernel lifting                      | NeurIPS workshop OP session                                 | LoG conference workshop                                     |
| **O12** | 4    | **B**   | Partition-functional Jensen for finite partitions in Lean 4                      | CICM                                                        | CPP / ITP work-in-progress                                  |
| **O13** | 4    | **S**   | Sierpiński's theorem on atomless measures — mathlib PR + tutorial                | CICM tutorial track + mathlib PR                            | ITP system description / JAR note                           |
| **O14** | 4    | **B**   | Adversarial-audit cycles for mechanised mathematics — methodology                | CICM                                                        | JAR / LFMTP / HaTT                                          |
| **O15** | 5    | **E**   | f-divergence brackets on the refinement lattice (Reid–Williamson dual)           | *Statistics & Probability Letters*                          | *Information Geometry* / ECP                                |
| **O16** | 5    | **E**   | Le Cam deficiency for partition coarsenings                                      | *Bernoulli* / *Electronic Communications in Probability*    | *Statistical Science*                                       |
| **O17** | 5    | **E**   | Sample-complexity of the partition-functional bracket                            | *Statistics & Probability Letters*                          | *Electronic Journal of Statistics* / AISTATS                |
| **O18** | 5    | **E**   | Distributionally-robust bracket under Wasserstein cell uncertainty               | *Operations Research Letters*                               | SPL / *Optimization Letters* / AISTATS workshop             |
| **O19** | 5    | **E**   | Bregman brackets on the simplex of cell distributions                            | *Information Geometry* (Springer)                           | SPL / GSI conference                                        |
| **O20** | 5    | **E**   | Mixing-time-corrected two-query bracket for Markov-chain co-cell sampling        | *Information Processing Letters*                            | ECP / SODA-FOCS property-testing workshops                  |

**Portfolio totals.** 20 opportunities — 11 Star, 3 Bush (+ 1 Bush/Star hybrid O8), 6 Exploration.

**Recommended Round 1 target: O1, O2, O3, O4 (Tier 1) + O15 (Exploration paired with O1).** Five pieces, all fast-review peer-reviewed venues (SPL, EMS Magazine, CRAS × 2, SPL or *Information Geometry*).

**Recommended Round 2 target: O5, O6, O7, O8 (Tier 2) + O16, O19, O20 (Exploration).** Seven pieces, mix of letters and workshops + three Exploration imports.

**Recommended Round 3 target: O9, O10, O11 (open problems) + O12, O13, O14 (formal methods) + O17, O18 (Exploration).** Eight pieces, designed to align with COLT 2027 OP, CICM, and the main-paper submission window.

**Recommendation on prioritisation.** Star pieces (O1, O3, O4, O5, O6, O7, O9, O10, O11, O13) are the **main-paper backstop** — these are what makes the main paper's bibliography concrete. Bush pieces (O2, O8, O12, O14) are the **on-ramp** — they lower the cognitive cost for any reviewer entering the area. Exploration pieces (O15–O20) are the **paradigm population** — they make the surrounding intellectual neighbourhood look populated and active when the main paper drops. Drop pieces in order of star > bush > exploration *only* if forced to choose; the default is concurrent execution.

**The author's-perspective takeaway.** With 20 pieces in flight, the *median* review outcome (some accepts, some rejects, some R&Rs) populates the bibliography to roughly 8–14 published satellites by the main-paper submission. That is enough to land the main paper into a citation graph rather than into an empty page, which is the strategic goal of this plan.

### 8.2 List of Journals and Conferences

Compact form, sorted by **estimated review-time bracket** (fastest first). All venues are **peer-reviewed**. Workshops marked **REMOTE OK** explicitly support remote presentation.

#### Fast review (≤4 months target)

- *Comptes Rendus Mathématique* (CRAS) — Académie des sciences. Short notes. ~2–4 months. **REMOTE OK** (no presentation).
- *Information Processing Letters* (IPL) — Elsevier. TCS short notes. ~2–4 months.
- *Statistics & Probability Letters* (SPL) — Elsevier. Stats short papers. ~2–4 months.
- *Snapshots of Modern Mathematics from Oberwolfach* — MFO, open access, peer-reviewed expository. ~2–4 months.
- *Operations Research Letters* — Elsevier. ~2–4 months.
- *Optimization Letters* — Springer. ~3–5 months.
- TMLR (Transactions on Machine Learning Research) — continuous submission, open access. ~2–3 months. **REMOTE / no conference.**

#### Moderate review (4–6 months target)

- *Electronic Communications in Probability* (ECP) — IMS/Bernoulli, open access. ~3–6 months.
- *EMS Magazine* — European Math Society, expository. ~3–6 months.
- *Mathematical Intelligencer* — Springer. ~3–6 months.
- *Expositiones Mathematicae* — Elsevier. ~3–6 months.
- *Bulletin of the London Mathematical Society* — LMS. ~4–6 months.
- *Proceedings of the American Mathematical Society* (PAMS) — AMS. ~4–9 months.
- *Electronic Journal of Statistics* — open access. ~moderate.
- *Stat* (Wiley) — short stats. ~moderate.
- *Information Geometry* (Springer) — peer-reviewed info-geometry journal. ~moderate. Strong fit for O15 / O19.
- *Statistical Science* — IMS, long-form expository. ~moderate to slow. Strong fit for paradigm-positioning Exploration pieces (O16).

#### Workshops (≤2 months decision, deadline-driven)

- **Learning on Graphs (LoG) Conference** — main + workshops + extended abstracts. **REMOTE / virtual-first.** Annual, deadlines Sep–Oct.
- **NeurIPS workshops** (LoG workshop, GLFrontiers, Math-AI, Geometric DL, others) — many **REMOTE-friendly**. Deadlines Aug–Sep, decisions ~1 month.
- **ICML workshops** (TAG-ML, ML4PS, Geometric DL, others) — many **REMOTE-friendly**. Deadlines May–Jun, decisions ~1 month.
- **ICLR workshops + TinyPapers** — **REMOTE OK**. Deadlines Feb–Mar.
- **AISTATS workshops** — **REMOTE-friendly**.
- **GSI (Geometric Science of Information)** — biennial; information-geometry conference, natural home for O15 / O19.

#### Open-problem tracks (≤1 month decision)

- **COLT Open Problems** — annual, separate from main COLT. ~1 month decision after deadline.
- **ALT Open Problems** — annual, Algorithmic Learning Theory.

#### Formal methods (peer-reviewed, mostly hybrid)

- **CICM (Intelligent Computer Mathematics)** — papers + system descriptions + tutorials. **Hybrid usually OK.** ~3–4 months.
- **CPP (Certified Programs and Proofs)** — Sep deadline for Jan conference (co-located POPL).
- **ITP (Interactive Theorem Proving)** — main + rough-diamonds + system descriptions. **Hybrid usually OK.** Annual, ~Feb–Mar deadline.
- **LFMTP** — **REMOTE-friendly** workshop.
- **TYPES** — **REMOTE-friendly** workshop.
- *Journal of Automated Reasoning* (JAR) — long-form, ~6–12 months.
- *Logical Methods in Computer Science* (LMCS) — open access, ~moderate.

#### Slower venues (mentioned for context, not primary targets)

- *American Mathematical Monthly*, *Math. Mag.*, *College Math Journal* — MAA, ~6–12 months. Use only if 12-month bracket is acceptable for a given piece; default to CRAS instead.
- *Bernoulli*, *Annals of Statistics*, *JMLR* — primary candidates for the **main paper itself** (per panel verdict §5), not for satellites.

---

## Appendix: Cross-reference to the audit trail

This plan is the natural successor to:

- [`18-panel_review_charter.md`](18-panel_review_charter.md) — panel composition reused here as the persona cast (§2).
- [`19-panel_verdict.md`](19-panel_verdict.md) §5 — main-paper venue strategy (COLT/JMLR; CPP for ITP kernel; separate empirical timeline). This plan covers the **satellite** track that runs in parallel with all three.
- [`20-judge_f_harness_log.md`](20-judge_f_harness_log.md) — closure of the Phase IV harness items; the Sierpiński PR (O13) inherits its tutorial scope from here.
- [`.research/opportunities.md`](.research/opportunities.md) §1 — mathlib PR opportunities; O13 closes opportunity #1, O12 builds on the workaround in opportunity #4.
- [`.agents/skills/tao-step-by-step-proving/`](.agents/skills/tao-step-by-step-proving/SKILL.md), [`.agents/skills/tao-red-team-audit/`](.agents/skills/tao-red-team-audit/SKILL.md), [`.agents/skills/wsl-lean-bridge/`](.agents/skills/wsl-lean-bridge/SKILL.md) — workflow skills that O14 distils into a methodology paper.

The next workspace doc number is `22-`; the first round-1 piece's adversarial audit memo lands there. Tier 5 (Exploration) pieces use the same audit numbering — they don't get their own numbering scope, but their per-piece audit memos are marked **[E]** in the title to distinguish them from Star/Bush audit memos.

No file changes needed — this is an analysis question. Here is the ranking by **ease of writing × speed of venue**, from lowest-hanging to hardest.

---

### Tier A — Almost free (content is fully worked out in the main paper already)

**O3 — Chord substitution** *(CRAS, ~3–4 pages)*
The entire proof is one line, already articulated in Appendix B.6 of the main paper as the "Phase D surprise." No GNN content, no statistics prerequisites. Just a teaching note: state the continuous Jensen-equation, do the chord substitution, done. Fastest possible write.

**O9, O10, O11 — The three open problems** *(COLT OP / ALT OP / workshop, 2–5 pages each)*
§8 of the main paper already states all three with full motivation. The satellite is literally: copy §8's OP statement, add one survey paragraph of known partial results, add one "what the right approach might be" paragraph, format for the venue. Cheapest bang-for-buck in the whole plan because open-problem tracks have low bars and high citation leverage.

**O4 — Single-cell pinning** *(CRAS, ~4–5 pages)*
The full proof of Theorem 2 (binary) is in §3.2. The key observation — that the lower endpoint is automatically tight on single cells, so exactness reduces purely to upper-endpoint tightness — is already written out. Extract, give it a name, done.

---

### Tier B — Short extraction (proof exists, needs packaging)

**O5 — Two-query identity** *(IPL, ~5–7 pages)*
Proposition 6 + Corollary 7 are fully proved in §7. The honest cost-accounting paragraph is there. Add one concrete numerical worked example (a two-cell graph), cite Hoeffding for the sample-complexity, done.

**O2 — Methodology note** *(EMS Magazine / Snapshots, ~6–8 pages)*
§1.1–1.2 of the main paper already contain the conceptual framing in a condensed form. Expand the two paragraphs into a six-page expository note with a two-cell diagram. No new theorems — purely writing work in expository voice.

**O6 — Aggregator half-chain** *(LoG workshop, ~6 pages)*
Corollary 4 and the two-line counterexamples ($\{0,2\}$ vs $\{1,1\}$; $\{1,2\}$ vs $\{0,2\}$) are fully written in §5. The floor-vs-achieved caveat is already there and loud. Workshop format means no pressure to extend; the counterexamples plus the lattice incomparability theorem is enough.

---

### Tier C — Needs one new derivation

**O17 — Sample-complexity of the bracket** *(SPL, ~6–8 pages)*
Standard Bernstein / Hoeffding applied to $\hat{\bar\varphi}(\Pi) - \bar\varphi(\Pi)$. The §7 cost-accounting paragraph already points to this gap. The derivation is textbook empirical-process theory; the novelty is in the *object* (the bracket functional), not the technique. Medium effort but no conceptual risk.

**O1 — The full bracket paper** *(SPL, ~8–10 pages)*
Harder than O3/O4 because it needs to be fully self-contained with the Theorem 1 proof (both directions), the chord-lemma, and the $c_\varphi=\tfrac12$ argument — all of which exist in the main paper but need to be reassembled with §2 definitions re-introduced from scratch.

---

### Tier D — Requires genuinely new derivations (write last)

O7 (biconjugate of $\ell_\varphi$), O15 (f-divergence dual), O16 (Le Cam deficiency), O18 (Wasserstein DRO), O19 (Bregman brackets), O20 (Markov-chain Bernstein) all require working through constructions the main paper gestures at but does not develop. These are richer papers and worth doing, but they block on new mathematics, not just packaging.

---

### Recommended first-week queue

| Write first | Why |
|---|---|
| O3 | 1-page proof, CRAS, done in hours |
| O9 + O10 + O11 | Bundled, copy §8, 2 days total |
| O4 | CRAS, pairs naturally with O3 |
| O2 | Pure writing, no new math |
| O5 | Prop 6 already proved, IPL |
| O6 | Workshop, counterexamples already there |

That is six pieces with essentially zero new mathematics — all packaging and precision. Submit O3 and O4 to CRAS as a pair, O9/O10/O11 to whatever open-problem track deadline is nearest, O2 to EMS Magazine / Snapshots, O5 to IPL, O6 to the next LoG deadline. All six can be in submitted state before any of them have been reviewed.