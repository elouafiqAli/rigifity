# Adversarial audit — Draft 0.6 + Lean kernel at HEAD `f3b0dd1` (post Phase D)

*Round 7. Internal adversarial review by GitHub Copilot (Claude Sonnet 4.6), acting as a hostile referee. Same lens and severity scheme as `00-external.md`. Performed against the live Lean build (2172 jobs green) and a re-derivation of every theorem from the §2 definitions.*

Severity tags: **[Critical]** (must fix before submission), **[Material]** (should fix), **[Minor]** (cleanup), **[Strategic]** (positioning).

---

## 0. Assessment strategy (the lens used)

The previous round (`00-external.md`) found one [Critical] (Theorem 2′ Step-1 headline inversion, fixed in Draft 0.6) plus three [Minor] and two [Strategic] items. Draft 0.6 closes all six. Then **Phase D landed: `simplex_rigidity` PROVED end-to-end in Lean**, with `affine_of_jensen_eq` as a standalone lemma. The kernel now sits at 57 axiom-clean theorems with zero remaining `sorry` bodies in the main namespace.

This round looks for what the prior six audits missed *and* what Phase D might have introduced. The lens:

1. **Re-derive every claim independently** from the §2 definitions, including the §4.2 Step 2 that Phase D mechanized via the chord trick (Cauchy-equation worry was the prior audit's headline mathematical concern; Phase D collapsed it — confirm independently).
2. **Audit Lean–paper hypothesis discrepancies.** Phase D is a fresh attack surface. The Lean statement of `simplex_rigidity` carries hypotheses the manuscript might not state; the manuscript might claim things the Lean version doesn't capture. Both directions need explicit auditing.
3. **Stress-test the Mechanization paragraph** for over-claim. After Phase D this paragraph now claims 57 axiom-clean theorems covering Theorems 1, 2, 2′, Proposition 6, both worked examples. Verify the paragraph against `Audit/PrintAxioms.lean`'s actual output and `lake build`'s exit code.
4. **Re-numerify Worked Example A** (new in Draft 0.6) and **Worked Example B** (existing, now correctly relabeled), independently from the Lean `native_decide` checks.
5. **Cross-check whether any manuscript-level theorem is *stated* without being either *proved-in-paper* or *proved-in-Lean*.** Phase D added an "asymmetry" between the multiclass Theorem 2′ (mechanized) and the multiclass Theorem 1′ (manuscript-claimed only). Audit whether the manuscript's claim status is fully honest.

**Headline verdict.** The mathematics is sound. Every theorem checks out on re-derivation. The Phase D mechanization is correct; the chord-trick Step 2 actually proves the claim cleanly (and reveals that the paper's classical "no-Hamel-basis-pathology" worry was over-engineered — the continuous convex-combination form of Jensen's equation doesn't need boundedness). The new Worked Example A numerics are exact and the same-Gini-different-R demonstration is unambiguous.

**Two [Material] findings** for round 7:

1. **Theorem 2′ inherits Risk 5** (the measurable-labeling discrepancy). Draft 0.6 fixed Theorem 1's wording but did not propagate the fix to Theorem 2′. The Lean statement of `simplex_rigidity` quantifies over measurable labelings `f : α → Fin k`; the manuscript statement does not, even though the Phase D commit landed the same week as the Risk 5 round-5 followup. Trivial fix: one parenthetical clause.

2. **Theorem 1′ asymmetry**. §4.4 *states* Theorem 1′ (simplex refinement-monotone ⟺ concave) as a theorem with a one-paragraph proof. The Lean kernel does **not** declare it (deliberately — `simplex_rigidity` doesn't depend on it). The Mechanization paragraph correctly omits Theorem 1′ from its list, so the paragraph itself is *honest by selective listing*; but a hostile referee comparing "what's in §4 with proofs" to "what's mechanized" will spot that Theorem 1′ is stated as proved (in the manuscript) without a Lean counterpart, while Theorem 2′ (the deeper result) has both. The simplest remedy is one footnote in the Mechanization paragraph explicitly noting that Theorem 1′ is paper-side only, by design, because its proof is a verbatim port of the (mechanized) Theorem 1 argument with the dimension-agnostic tower property.

Plus three [Minor] items (cleanup), one [Strategic] item (positioning improvement), and one [Positive] finding worth recording.

---

## 1. Correctness pass — theorem by theorem

All re-derived from the §2 definitions. ✓ = verified correct on re-derivation. **L** = also verified against the live Lean term.

| Result | Status | Note |
|---|---|---|
| Bracket (§1): $\varphi^{-1}(\bar\varphi)\le\varepsilon^\ast\le c_\varphi\bar\varphi$ | ✓ **L** | Lean: `bracket_lower`, `bracket_upper`. |
| Universal $c_\varphi=\tfrac12$ | ✓ **L** | Chord through $(0,0)$ and $(\tfrac12,1)$; Lean: `cPhi_eq_half_of_normalized`. |
| §3.1 Theorem 1 (monotone ⟺ concave) | ✓ **L** | Lean: `theorem1`, `theorem1_easy`, `theorem1_hard`. The Lean hypothesis "all measurable labelings" matches Draft 0.6's manuscript wording (round-5 followup). |
| §3.2 Theorem 2 (tent is unique exact score) | ✓ **L** | Lean: `theorem2`, `theorem2_forward`, `theorem2_reverse`. |
| §3.2 single-cell tightness of lower endpoint (M-3 of round 6) | ✓ | $\varphi^{-1}(\varphi(\eta))=\eta$ for any normalized $\varphi$ and $\eta\in[0,\tfrac12]$ (since $\varphi^{-1}$ is the inverse on the principal $[0,\tfrac12]$ branch by `strict_mono`). The §3.2 proof now correctly attributes exactness-on-single-cells to the upper-endpoint constraint $c_\varphi\,\varphi(\eta)=\eta$. |
| Cor 3 (smoothness forces slack, binary) | ✓ | |
| §4.1 multiclass upper bound, Gini $c_{\varphi_G}=1$ | ✓ | Same as round 6. |
| §4.1 lower bound via $\ell_\varphi^{\ast\ast}$ | ✓ | Same as round 6. |
| §4.2 Theorem 2′ Step 1 (R = G ∘ φ) | ✓ **L** | The round-6 [Critical] fix landed correctly: paper headline now matches the derivation. Lean: derivation lives inside `simplex_rigidity`'s hard direction, lines 519–534 of `Theorem2Prime.lean`. |
| §4.2 Theorem 2′ Step 2 (G affine) | ✓ **L** | Phase D landed two independent proofs: (a) the standalone `affine_of_jensen_eq` via the chord trick (`u₁ = M, u₂ = 0, p = v/M`), no boundedness needed; (b) the direct argument inside `simplex_rigidity` that bypasses `affine_of_jensen_eq` entirely by pinning the Jensen-equality at `η₂ = vertex 0`. **The paper's §4.2 proof gloss ("Jensen-equality identity forces G affine — no measurable pathology in the Hamel-basis sense") is correct but oversells the difficulty.** The continuous convex-combination form has no Hamel-basis pathology because the chord trick gives an explicit closed-form. The paper's framing is defensible (classical caution about Cauchy's equation) but historically motivated rather than mathematically necessary. |
| §4.2 Theorem 2′ Step 3 (vertices pin φ = λR) | ✓ **L** | Lean: `phi_eq_lam_R_of_step1_affine` as a standalone reusable lemma. The Lean derivation reveals (positively — see §5 [Positive] below) that the paper's "φ > 0 on interior" hypothesis from §4.1's simplex-score definition is **not** needed for Theorem 2′: Lean derives `0 < φ(center k)` from `R(center) > 0` + `G(0) = 0` (the latter follows from `R(vertex) = 0 + φ(vertex) = 0` + Step 1). The Lean `SimplexScore` field set is just continuous + nonneg_on + vertex_vanishing — strictly weaker than the manuscript's "simplex score" definition. |
| §4.2 Theorem 2′ (assembled) | ✓ **L** | Lean: `simplex_rigidity`, axiom-clean modulo `SingleCellRealizableSimplex` + `TwoCellRealizableSimplex`. **[Material 1]** below: Lean carries a measurable-labeling hypothesis the paper omits. |
| §4.3 Worked example A (Step-1 violation, NEW Draft 0.6) | ✓ **L** | Re-verified by hand below; Lean: `native_decide` checks at the file tail. |
| §4.3 Worked example B (slack mechanism) | ✓ **L** | Re-verified by hand below. The lower-bracket witness claim is correct (see §1.A). |
| §4.4 Theorem 1′ (refinement transfer to simplex) | ✓ (paper-only) | Not mechanized. **[Material 2]** below: the Mechanization paragraph honestly omits it, but the §4.4 text presents it as a fully-proved theorem; this paper-side asymmetry deserves a one-clause flag. |
| §5 Cor 4 (aggregator half-chain) | ✓ | Counterexamples for mean⇎max: $\{0,2\}$ vs $\{1,1\}$ (same mean, different max); $\{1,2\}$ vs $\{0,2\}$ (same max, different mean). |
| §6 Thm 5 (both directions, with M-1 positive-mass clause) | ✓ | The round-6 positive-mass clause correctly handles the contrapositive's strict-positivity step. |
| §6 contractive δ bound (with M-2 worst-pair-stability qualifier) | ✓ | Qualifier promoted to point of use. |
| §7 Prop 6 (two-query identity + variance bracket) | ✓ **L** | $p_{\text{dis}} = 2\mathbb{E}[\text{Var}(f|\Pi)] = \bar\varphi_{\text{var}}/2 \cdot 2$; bracket endpoints re-derived: lower $(1-\sqrt{1-2p_{\text{dis}}})/2$ (lower root of $4\eta^2 - 4\eta + 2p_{\text{dis}} = 0$ on $[0,\tfrac12]$), upper $p_{\text{dis}}$. Lean: `two_query_identity`, `variance_bracket`. |
| §7 Cor 7 (label complexity) | ✓ | Hoeffding. |

### 1.A — Worked Example numerics (independent re-derivation)

**Worked Example A (Step-1 violation, Draft 0.6, $k=3$).** Take $\boldsymbol\eta_A=(2/3,1/6,1/6)$ and $\boldsymbol\eta_A'=(1/2,1/2,0)$.

- *Simplex membership:* $\sum_c (\boldsymbol\eta_A)_c = 2/3 + 1/6 + 1/6 = 4/6 + 1/6 + 1/6 = 1$. ✓ $\sum_c (\boldsymbol\eta_A')_c = 1/2 + 1/2 + 0 = 1$. ✓
- *Gini scores:* $\sum_c (\boldsymbol\eta_A)_c^2 = 4/9 + 1/36 + 1/36 = 16/36 + 1/36 + 1/36 = 18/36 = 1/2$, so $\varphi_G(\boldsymbol\eta_A) = 1 - 1/2 = 1/2$. ✓ $\sum_c (\boldsymbol\eta_A')_c^2 = 1/4 + 1/4 + 0 = 1/2$, so $\varphi_G(\boldsymbol\eta_A') = 1/2$. ✓ **Equal.**
- *Bayes risks:* $R(\boldsymbol\eta_A) = 1 - \max_c (\boldsymbol\eta_A)_c = 1 - 2/3 = 1/3$. ✓ $R(\boldsymbol\eta_A') = 1 - 1/2 = 1/2$. ✓ **Unequal.**
- *Step-1 violation:* same $\varphi_G$ (=1/2), different $R$ (1/3 vs 1/2). $G$ would have to send $1/2$ to both $1/3$ and $1/2$ — impossible. So Gini fails Step 1 directly. **Example A is correct.**

**Worked Example B (slack mechanism, original §4.3).** Take $\boldsymbol\eta=(0.5,0.3,0.2)$ and $\boldsymbol\eta'=(0.5,0.5,0)$.

- *Same R:* $R(\boldsymbol\eta) = 1 - 0.5 = 0.5$; $R(\boldsymbol\eta') = 1 - 0.5 = 0.5$. ✓
- *Different Gini:* $\varphi_G(\boldsymbol\eta) = 1 - (0.25 + 0.09 + 0.04) = 1 - 0.38 = 0.62$. $\varphi_G(\boldsymbol\eta') = 1 - (0.25 + 0.25 + 0) = 0.5$. ✓
- *Two-cell aggregate:* $\varepsilon^\ast = (1/2)(0.5) + (1/2)(0.5) = 0.5$; $\bar\varphi_G = (1/2)(0.62) + (1/2)(0.5) = 0.56$. Slack = $0.56 - 0.5 = 0.06$. ✓
- *Lower bracket witness claim:* "$\boldsymbol\eta = (0.6, 0.2, 0.2)$ with $R = 0.4$ minimizes $R$ over $\{\varphi_G = 0.56\}$." Let me verify this is indeed the minimum. For fixed Gini = 0.56 (i.e. $\sum_c \eta_c^2 = 0.44$) and $\sum_c \eta_c = 1$ with $\eta_c \ge 0$, minimizing $R = 1 - \max_c \eta_c$ means *maximizing* $\max_c \eta_c$. By symmetry of the smaller components, the maximum-max distribution has the form $(a, b, b)$ with $a + 2b = 1$, $a^2 + 2b^2 = 0.44$. Substituting $b = (1-a)/2$: $a^2 + (1-a)^2/2 = 0.44$, giving $3a^2 - 2a + 0.12 = 0$, so $a = (2 \pm \sqrt{4 - 1.44})/6 = (2 \pm 1.6)/6 = 0.6$ or $0.0667$. The max is $a = 0.6$, giving $\boldsymbol\eta = (0.6, 0.2, 0.2)$ with $R = 0.4$. ✓ **The witness is correct, but the paper asserts the minimization conclusion without verification.** See [Minor 3] below.

---

## 2. [Critical] findings

**None.** All previously-flagged Critical items (round 6's C-1) remain closed; no new Critical items emerged.

---

## 3. [Material] findings

### Material 1 — Theorem 2′ inherits Risk 5 (measurable-labeling discrepancy)

**Where.** §4.2 Theorem 2′ statement (paper line 144); `simplex_rigidity` (Lean line 494+).

**The discrepancy.** The Lean statement of `simplex_rigidity` quantifies over `(f : α → Fin k)` with the explicit hypothesis `(∀ i, MeasurableSet {x | f x = i})`. The paper's Theorem 2′ statement does not mention measurability of the labeling; the exactness predicate "$\varepsilon^\ast(\Pi)=G(\bar\varphi(\Pi))$ for every finite partition" implicitly assumes the per-cell conditional distributions $\boldsymbol\eta_i$ are well-defined, which requires the labeling that determines "class membership" to be measurable on every class-fiber.

**Why it matters.** This is the same defect that round 5 found on Theorem 1 (Risk 5 of `16-end-to-end-audit-and-publishability.md`) and that Draft 0.6 fixed by changing "all finite measurable partitions and labels" to "all finite measurable partitions and all measurable labelings $f:\mathcal X\to\{0,1\}$" in Theorem 1's statement. The fix did **not** propagate to Theorem 2′.

A hostile referee comparing Theorem 1's statement to Theorem 2′'s will spot the inconsistency immediately and ask why Theorem 1 carries the explicit measurability clause but Theorem 2′ does not, when the Lean proof of Theorem 2′ also requires it.

**Fix.** One parenthetical clause in Theorem 2′'s statement, mirroring Theorem 1:

> "...there exists $G:\mathbb R\to\mathbb R$ such that $\varepsilon^\ast(\Pi)=G(\bar\varphi(\Pi))$ for every finite measurable partition **and every measurable labeling $f:\mathcal X\to\{1,\dots,k\}$** ..."

(Or fold into the exactness predicate's preamble. Same defense as for Theorem 1: "measurable labeling" is what the manuscript means by "labeling" in the §4.1 setup; making it explicit costs nothing and pre-empts the question.)

### Material 2 — Theorem 1′ stated in paper but not in Lean; the asymmetry is honest but invites a referee question

**Where.** §4.4 Theorem 1′ (paper line 192); Mechanization paragraph (paper line 53); `Theorem2Prime.lean` (does not declare `T1′`).

**The status.** §4.4 *states* Theorem 1′ as a theorem with a one-paragraph proof: *"The proof is the same tower-property + Jensen argument of Theorem 1; the simplex playing the role of $[0,1]$ does not change the structure, since concavity and the tower property are dimension-agnostic for the cell-conditional class distribution $\boldsymbol\eta_i$."*

The Lean kernel deliberately does **not** declare this theorem. Phase D's commit message explains: `simplex_rigidity` does not depend on Theorem 1′, so the port wasn't needed for the rigidity proof. The Mechanization paragraph correctly lists Theorems 1, 2, 2′ and Proposition 6 — not Theorem 1′ — so the paragraph is *honest by selective listing.*

**The defect.** A referee reading §4 in order encounters:
- §4.2: Theorem 2′ (full proof; Mechanization paragraph confirms mechanized)
- §4.4: Theorem 1′ (one-paragraph proof-by-port; Mechanization paragraph silent)

The referee infers: "if Theorem 2′ is mechanized but Theorem 1′ isn't, what is special about Theorem 1′ that prevents mechanization?" The honest answer ("nothing; we just didn't port it because nothing else depends on it") deserves to be stated, not left for the referee to deduce.

**Fix.** One footnote at the end of the Mechanization paragraph, or one clause in §4.4's proof gloss:

> "Theorem 1′'s proof is a direct port of Theorem 1's tower + Jensen argument with the simplex playing the role of $[0,1]$; the Lean kernel does not currently declare the multiclass `barPhiSimplex_refinement_le` (the simplex analogue of the mechanized `barPhi_refinement_le`), because `simplex_rigidity` does not depend on it. This is a clean ~150-LoC port deferred to a future commit."

This is purely defensive — Theorem 1′'s proof is correct regardless of the Lean status. The footnote pre-empts the asymmetry question without taking ground.

---

## 4. [Minor] findings

### Minor 1 — "Chord trick" jargon in the Mechanization paragraph

**Where.** Paper line 53: *"...Theorem 2′ (simplex rigidity, both directions, via the chord-trick Step 2)..."*

**Issue.** "Chord trick" is project-internal terminology (introduced in the Phase D commit message). A referee will not recognize the term and will either skip it or ask what's special about it. The argument itself — set $u_1=M, u_2=0, p=v/M$ in the Jensen-equality and read off $G(v) = a v + b$ explicitly — is a standard observation, not a novel technique.

**Fix.** Either drop "chord-trick" entirely (the Mechanization paragraph doesn't need to advertise the proof technique) or replace with a more descriptive phrase: *"...via the standard chord-substitution form of Jensen's equation, which sidesteps the classical Cauchy-equation worry."*

Recommended: drop entirely. The Mechanization paragraph is for the *audit trail*, not for explaining proofs.

### Minor 2 — `simplex_rigidity` does not formalize the "automatically concave and permutation-symmetric" corollary

**Where.** §4.2 Theorem 2′ statement ends with: *"Moreover every exact $\varphi$ is automatically concave and permutation-symmetric."* Lean: `simplex_rigidity`'s conclusion is just `∃ lam > 0, φ = lam * R on simplex k`.

**Issue.** The paper's "automatically concave and permutation-symmetric" is a trivial corollary of `φ = λR` (positive scalar multiple of `R` inherits concavity from `R`'s concavity, inherits permutation-symmetry from `R`'s by-construction symmetry). A hostile reader comparing the paper's conclusion to the Lean conclusion will notice that the "moreover" clause is unmechanized.

**Fix.** Two-line standalone Lean lemmas: `simplex_rigidity_concave` and `simplex_rigidity_perm_symm`, derived from `simplex_rigidity` via concavity and permutation-symmetry of `R`. Or fold into the Lean `simplex_rigidity` conclusion as an additional `∧` clause. Either way, ~10 LoC. Optional polish; the paper's claim is mathematically obvious.

### Minor 3 — Worked Example B's lower-bracket witness claim is asserted without verification

**Where.** Paper §4.3 (Worked example B): *"the lower bracket is strictly below 0.5 as well (minimizing $R$ over $\{\varphi_G = 0.56\}$ gives $\boldsymbol\eta = (0.6, 0.2, 0.2)$ with $R = 0.4$)..."*

**Issue.** The claim *"$(0.6, 0.2, 0.2)$ is the minimizer of $R$ over $\{\varphi_G = 0.56\}$"* is asserted without proof. I verified it correctly above via Lagrangian analysis on $(a, b, b)$ with $a + 2b = 1$, $a^2 + 2b^2 = 0.44$, but the paper provides only the final values. A careful referee will want either:
- (a) A one-sentence justification: *"By symmetry the minimizer has the form $(a, b, b)$ with $a + 2b = 1$, $a^2 + 2b^2 = 0.44$, giving $a = 0.6$ as the larger root of the resulting quadratic."*
- (b) A `native_decide`-style numerical witness in Lean (Lean already verifies $\varphi_G(0.6, 0.2, 0.2) = 0.56$ and $R(0.6, 0.2, 0.2) = 0.4$, just not the *minimality*).

Recommended: (a), one sentence. The minimality claim is conceptually important (it tells the reader the lower bracket is non-vacuously below 0.5, not just that *some* point witnesses both 0.56 and a sub-0.5 R-value).

---

## 5. [Positive] findings

### Positive 1 — Lean proved a strictly stronger Theorem 2′ than the paper claims

**Where.** Paper §4.1 defines "simplex score" as *"continuous $\varphi:\Delta^{k-1}\to\mathbb R_{\ge 0}$ with $\varphi(\mathbf e_c)=0$ at the vertices **and $\varphi>0$ on the interior**"* (emphasis added). Paper §4.2 Theorem 2′ assumes φ is "continuous and vanish at the vertices" — already weaker than the simplex-score definition, but still doesn't drop interior positivity from the definition.

The Lean `SimplexScore` structure has only three fields: `continuous`, `nonneg_on`, `vertex_vanishing`. No interior-positivity field.

**Why this is positive.** The Lean proof of `simplex_rigidity` *derives* `0 < φ(center k)` from:
1. $R(\text{center}) > 0$ (because $k \ge 2$).
2. Step 1 gives $R(\text{center}) = G(\varphi(\text{center}))$.
3. $G(0) = 0$ (from pinning Step 1 at any vertex).
4. So if $\varphi(\text{center}) = 0$, then $G(\varphi(\text{center})) = G(0) = 0$, contradicting $R(\text{center}) > 0$.

The conclusion: **the manuscript's interior-positivity condition is not needed for Theorem 2′.** Lean proves the rigidity under strictly weaker hypotheses. The paper's definition is over-specified for the theorem's needs.

**Suggested action.** Either (a) drop "$\varphi > 0$ on the interior" from the §4.1 simplex-score definition entirely (with a one-line remark that interior positivity *follows from* exactness on a non-trivial space), or (b) leave it in as a defensive convention and note that Theorem 2′ only uses it at the center. (a) is cleaner but rewrites a paragraph the reader is already familiar with; (b) is the safer edit.

This is the kind of discovery that strengthens a paper: the formalization revealed that a hypothesis we had baked into our definition was *unused* by the deep theorem. Worth landing.

---

## 6. Assumptions & models — audit

**Atomless realizability (Lean: realizability typeclasses).** Lean abstracts the paper's "atomless" hypothesis into four typeclasses (`SingleCellRealizable`, `BinarySplitRealizable`, `SingleCellRealizableSimplex`, `TwoCellRealizableSimplex`). All four are inhabited by `[NoAtoms μ]` via Sierpiński's theorem, which mathlib currently lacks (opportunity #1 of `.research/opportunities.md`). This is the same structural gap as in round 6 (then 2 typeclasses; now 4). The doubling does not weaken the framing — all four close together under one mathlib PR. The paper's Mechanization paragraph correctly lists all four. ✓

**Measurable cell-fibers (Lean: explicit hypothesis).** Lean's `simplex_rigidity` takes `(∀ i, MeasurableSet {x | f x = i})` as an explicit hypothesis. This is the multiclass analogue of Theorem 1's `MeasurableSet {x | f x = true}`. See [Material 1] above.

**Hard cell assignments throughout.** Scope is stated honestly. The OP1b open problem flags the soft-cell extension. Unchanged from round 6.

**WL-faithfulness / three partitions.** Cleanest part of the modeling. Unchanged from round 6.

**Contractivity (OP2).** Working assumption; M-2 of round 6 promoted the worst-pair-stability qualifier to the point of use. ✓

No assumption is silently load-bearing. The two assumption-side concerns are [Material 1] (Theorem 2′ measurability) and the positive finding that Lean weakens the paper's "$\varphi > 0$ on interior" requirement.

---

## 7. [Strategic] — positioning and venue fit

**The Phase D closure changes the venue argument substantively.** The prior round's recommendation (`16-end-to-end-audit-and-publishability.md` §6) noted that the ITP-venue verdict had upgraded from "niche kernel" to "substantive contribution" after Phase C2 made Theorem 1 mechanized. Phase D upgrades the verdict again: now the kernel includes *both* the binary rigidity (Theorem 2) *and* the multiclass rigidity (Theorem 2′), plus the refinement-monotonicity iff (Theorem 1), plus the operational §7 result (Proposition 6) — a 57-theorem axiom-clean kernel covering essentially all decision-theoretic content of the manuscript.

**Two strategic considerations the prior audits did not have:**

### Strategic 1 — The two-paper split is now genuinely on the table

Phase D removes the "the simplex is in progress" qualifier that previously made the kernel feel like a *companion* to the manuscript rather than a standalone contribution. With the multiclass rigidity proved, the kernel is:
- A reusable partition-functional-inequality abstraction layer (`refining`, `cellRateSimplex`, `sum_measure_fiber_inter`, `phi_eq_lam_R_of_step1_affine`, `affine_of_jensen_eq`, `cellRateSimplex_mem_simplex`).
- Two completed rigidity theorems (`theorem2` binary; `simplex_rigidity` multiclass).
- One refinement-monotonicity iff (`theorem1`).
- One operational identity (`variance_bracket`).

This is the substance of an ITP submission *by itself*, framed as "the rigidity kernel for a calibration-on-the-resolution-axis theory of GNN expressivity."

The two-paper strategy (theory paper + ITP note) vs the one-paper strategy (theory paper with kernel as auxiliary appendix) is a real choice the authors need to make. This audit does not pick — both are defensible — but flags that the choice is no longer mandatory either way.

### Strategic 2 — Phase E (OP1b soft-cell lifting) is now the natural next research direction

With the hard-partition machinery complete in Lean, the open question "does `simplex_rigidity` survive the soft-kernel lifting?" (OP1b) becomes the next research target. The Phase D infrastructure (`cellRateSimplex`, `epsilonStarSimplex`, etc.) generalizes from hard partitions to a Markov-kernel `K : α → Δ(Cells)` setting; the rigidity question rewrites in terms of integrals against the random cell assignment. This is the genuinely novel research line that follows from Phase D's closure — and it's the prerequisite for reaching soft / attention-based architectures.

Phase D's commit message and `16-end-to-end-audit-and-publishability.md` §7 both flag this. The prioritization is consistent: the empirical companion is the highest-impact next deliverable for ML venues; Phase E is the highest-impact next deliverable for theory venues.

---

## 8. Prioritized action list

In approximate order of marginal value-per-effort.

1. **[Material 1]** Add "every measurable labeling" to Theorem 2′'s statement. One parenthetical clause. Mirrors Theorem 1's round-5 fix.

2. **[Material 2]** Add a one-clause footnote to either the Mechanization paragraph or §4.4 Theorem 1′ noting that Theorem 1′ is paper-side only by design (because `simplex_rigidity` doesn't depend on it; the simplex `barPhiSimplex_refinement_le` port is a clean ~150-LoC follow-up). Pre-empts the asymmetry question.

3. **[Minor 3]** One-sentence verification of Worked Example B's lower-bracket-witness minimality claim: *"By symmetry the minimizer has the form $(a, b, b)$ with $a + 2b = 1$, $a^2 + 2b^2 = 0.44$, giving $a = 0.6$."*

4. **[Minor 1]** Drop "chord-trick" jargon from the Mechanization paragraph. The paragraph is for the audit trail, not for explaining proofs.

5. **[Positive 1]** Optional but strengthens the paper: drop "$\varphi > 0$ on the interior" from the §4.1 simplex-score definition (Lean proves Theorem 2′ without it) and add a one-line remark that interior positivity is a consequence, not a hypothesis. The Lean version's strictly weaker hypotheses are a discovery worth advertising.

6. **[Minor 2]** Optional: add two-line Lean corollaries `simplex_rigidity_concave` and `simplex_rigidity_perm_symm` to formalize the "automatically concave and permutation-symmetric" clause of Theorem 2′. ~10 LoC. Pure polish.

7. **[Strategic]** The two-paper-vs-one-paper decision is now a real choice. Both are defensible; this audit does not pick.

---

**No item in this round threatens a mathematical result.** Every theorem checks out on re-derivation, the Phase D mechanization is correct (and reveals one positive surprise about the simplex-score definition), and the Worked Example A numerics are exact. The two [Material] items are paper-Lean reconciliation defects that mirror the round-5 Risk 5 issue; both are one-paragraph fixes.

**Verdict.** Draft 0.6 + Lean kernel at `f3b0dd1` is in better mathematical health than any prior round. The Phase D closure dissolves the "but the simplex isn't done yet" qualifier and upgrades the kernel to a substantive ITP-grade contribution in its own right. The two [Material] items should be folded into a Draft 0.7 polish pass.

*Round 7 generated 2026-06-06 against HEAD `f3b0dd1`. Verified against live Lean build (2172 jobs) and `lake env lean Audit/PrintAxioms.lean` (57 declarations, all axiom-clean against `[propext, Classical.choice, Quot.sound]`).*
