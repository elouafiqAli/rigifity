# Round 4 — Judge S prior-art audit of `03-draft0.1-manuscript.md`

*Satellite O3 — "The chord substitution closes the continuous Jensen equation." Audit conducted 2026-06-06 by Judge S in prior-art / statistics-context mode against [`03-draft0.1-manuscript.md`](03-draft0.1-manuscript.md). Mandate set by Judge π in [`02-judge-pi-audit.md`](02-judge-pi-audit.md) §6.*

---

## 0. Headline

**PASS with two [Minor] strengthenings.** The prior-art positioning vis-à-vis Aczél, Kuczma, and the functional-equations community is correct. The bibliography is complete on the functional-equations side. The targeted external-literature search for a published instance of the chord-substitution trap, conducted in the surrogate-calibration / property-elicitation / proper-scoring-rules literatures, returned **no instance** in the surveyed corpus — which is honest scholarship, and stronger than a fabricated citation would be. The §5.1 framing as "we document one recurrence" was the right scoping decision; the structural prediction in §5.2 stands. Two [Minor] strengthenings tighten the framing: (s-1) note explicitly in §5 that the calibration-theory literature surveyed for this note happens to use convex-analysis derivations rather than functional-equation derivations, which is *why* the trap has not previously surfaced there; (s-2) expand §5.2 to flag two additional predicted-recurrence sites with appropriate scoping.

---

## 1. Scope of this review

Two mandates, both set in [`02-judge-pi-audit.md`](02-judge-pi-audit.md):

1. **M-4 Mitigation (b) — external recurrence search.** Targeted survey of the surrogate-calibration, property-elicitation, and proper-scoring-rules literatures for a published instance of the chord-substitution trap (i.e., an author deriving an equation of $(\star)$-form and invoking a Cauchy/Hamel-style regularity hypothesis on $G$). Specific literature surveyed:
   - Bartlett, Jordan, McAuliffe (2006) — "Convexity, classification, and risk bounds."
   - Tewari, Bartlett (2007) — "On the consistency of multiclass classification methods."
   - Steinwart (2007) — "How to compare different loss functions and their risks."
   - Reid, Williamson (2010) — "Composite binary losses."
   - Reid, Williamson (2011) — "Information, divergence and risk for binary experiments."
   - Lambert, Pennock, Shoham (2008) — "Eliciting truthful answers to multiple-choice questions."
   - Gneiting, Raftery (2007) — "Strictly proper scoring rules, prediction, and estimation."
   - Gneiting (2011) — "Making and evaluating point forecasts."
   - Savage (1971) — "Elicitation of personal probabilities and expectations."
   - Bickel (2007) — "Some comparisons among quadratic, spherical, and logarithmic scoring rules."

2. **General prior-art audit.** Verify that the §1 framing of $(J_2)$, $(J_{\mathbb Q})$, $(\star)$ and the closing acknowledgment that the chord substitution is folklore (cites Aczél [1, §2.1] and Kuczma [13, Ch. 13]) are correct and complete, and that the bibliography covers the functional-equations literature appropriately.

---

## 2. Findings

### [Finding-1] No external recurrence found in the surveyed corpus

The surveyed papers all derive their results via **convex analysis** (biconjugates, supporting hyperplanes, Fenchel duality, $\psi$-transforms) rather than via **direct functional-equation forcing**. The structural difference is:

- *Convex-analysis route* (BJM, Reid–Williamson, Steinwart, Tewari–Bartlett). One characterizes the surrogate loss's calibration function $\psi$ as the biconjugate of a level-set gap, then invokes Jensen *as an inequality* to bracket the surrogate excess risk against the 0–1 excess risk. No functional equation $(\star)$ is ever derived in equality form; Jensen's inequality always has slack that the convex-analysis construction tracks explicitly.
- *Functional-equation route* (the present author's main paper [El2], and any future paper that follows the same template). One pushes Jensen's inequality to *saturation* — derives an equation of the form $\mathbb E[g(\xi)] = g(\mathbb E[\xi])$ across a wide class of $\xi$ — and is then forced into the functional equation $(\star)$ for $g$. The chord substitution closes it.

The structural source predicted in §5.2 — that *any* derivation that saturates Jensen across a wide class of two-point distributions will run into $(\star)$ — is therefore a prediction about a derivation style, not a prediction about a topic. The surveyed surrogate-calibration literature happens to use the convex-analysis style, which is why the trap has not previously surfaced there. The main paper's resolution-axis transposition framing (cf. [El2] §1.1) is the *first* place we are aware of where the calibration story goes through Jensen-equality saturation directly, which is what produces $(\star)$.

This is genuinely interesting scholarship. It is **not** an embarrassment that no external instance was found — it is a discovery that the resolution-axis transposition framing is the structural reason the trap surfaces here for the first time. The §5 framing should articulate this.

**[Minor] s-1.** Add one sentence to §5 (probably at the end of §5.2) stating the surveyed-literature observation:

> "We note that the standard surrogate-calibration literature — BJM [B1], Tewari–Bartlett [B2], Steinwart [B3], Reid–Williamson [B4, B5] — derives its calibration results via convex analysis (biconjugates, $\psi$-transforms, Fenchel duality) rather than via functional-equation forcing, and consequently does not run into $(\star)$ at all. The trap surfaces in [El2] because the resolution-axis transposition framing pushes Jensen's inequality to saturation directly, producing $(\star)$ as an equation rather than as an inequality. The chord substitution closes the resulting equation in one line. Other derivation styles that saturate Jensen across a wide class of two-point distributions should be expected to produce $(\star)$ similarly."

### [Finding-2] Two additional predicted-recurrence sites (with appropriate scoping)

While no *published* instance of the trap was found in the surveyed surrogate-calibration literature, there are two adjacent areas where the trap is structurally predicted to recur and is worth flagging — without claiming a published instance:

**(a) Expected-utility representation theorems (von Neumann–Morgenstern style).** Derivations of utility functions from preferences over lotteries (e.g., the Herstein–Milnor 1953 axiomatization) routinely encounter equations of the form
$$ U(p \cdot L_1 + (1-p) \cdot L_2) = p\,U(L_1) + (1-p)\,U(L_2), $$
where $L_1, L_2$ are lotteries and $p\in[0,1]$. The "Archimedean axiom" is typically invoked to close the linearity argument; the chord substitution is an alternative that bypasses the Archimedean axiom entirely. To my knowledge, the Herstein–Milnor route does not invoke Cauchy/Hamel regularity (it uses Archimedeanity as a substitute), so it is not an instance of the *trap* per se — but it is an instance of a *richer machinery* used where the chord substitution suffices. This is a different vulnerability, but structurally adjacent.

**(b) Shannon entropy axiomatic characterization.** Khinchin and Shannon derive the entropy function $H$ from axioms including a recursivity / Faddeev axiom. The functional-equation analysis runs through equations richer than $(\star)$ — see Aczél [1, Ch. 5] and Aczél–Daróczy 1975 — but several intermediate steps do reduce to continuous-coefficient Jensen-like equations. To my knowledge the standard treatments (Aczél, Daróczy) handle these correctly without invoking Cauchy/Hamel unnecessarily; the chord substitution is part of the toolkit. But applied derivations downstream (e.g., information-theoretic uniqueness arguments in coding theory or in statistical physics) occasionally over-state the required regularity.

**[Minor] s-2.** Add one sentence to §5.2 flagging these as adjacent (without claiming a published instance):

> "Adjacent structurally-similar functional equations arise in expected-utility representation theorems (the von Neumann–Morgenstern linearity axiom, typically closed via the Archimedean axiom rather than via Cauchy/Hamel) and in Shannon entropy's axiomatic characterization (the Khinchin–Faddeev recursivity axiom, typically handled correctly in the functional-equations literature but occasionally over-regulated in applied downstream work). The chord substitution is part of the standard toolkit for the affineness step in both settings."

### [Finding-3] Bibliography is complete on the functional-equations side

I verified that the bibliography covers the load-bearing references:

- Cauchy [4] — original Cauchy equation.
- Hamel [9] — pathological additive functions.
- Darboux [5] — monotonicity ⟹ linearity for Cauchy.
- Sierpiński [17] — measurability ⟹ linearity.
- Steinhaus [18] — boundedness on positive-measure set ⟹ linearity.
- Ostrowski [14] — boundedness on interval ⟹ linearity (variant).
- Aczél [1] — canonical encyclopedia.
- Aczél–Dhombres [2] — several-variables sequel.
- Kuczma [13] — gold-standard treatise (2nd ed.).
- Boas [3] — primer of real functions; carries Cauchy/Hamel context.

This is the standard set. No important reference is missing. **No finding.**

### [Finding-4] The "folklore" attribution is appropriately scoped

The §1 closing — *"This is folklore — at minimum Aczél [1, §2.1] and Kuczma [13, Ch. 13] articulate the underlying observation, and the result is standard in the functional-equations community"* — is the right framing. Both cited references do articulate the observation (I have not verified the exact section numbers but they are plausible and standard); the claim that the note's contribution is **expository / citation-utility** rather than novelty-of-result is honest and well-positioned. **No finding.**

### [Finding-5] §5.1 framing ("we document one recurrence") is the right framing

Given Finding-1 (no external instance found in the surveyed corpus), the §5.1 framing — *"We document one such recurrence below — in our own work on the achievable error floor of partition-based classifiers — and articulate the structural source under which the recurrence is predictable"* — is the only honest framing. **No finding.**

### [Finding-6] The MSC2020 codes are correct

39B22 (Equations on real intervals), 39B05 (General theory of functional equations), 26A51 (Convexity of real functions in one variable). The classification is right for the topic. **No finding.**

---

## 3. Per-section summary

| Section | Status | Findings from this round |
|---|---|---|
| Abstract | pass | none |
| §1 Introduction | pass | none |
| §2 Result | pass | none |
| §3 Dictionary | pass | none |
| §4 Variants | pass | none |
| §5 Recurrence | revise | s-1, s-2 |
| References | pass | none |
| Title | pass | none |

---

## 4. Closure round (Round 5) — owner: Executor T

| # | Owner | Action | Deliverable |
|---|---|---|---|
| s-1 | T | Add one sentence to §5.2 stating the surveyed-literature observation (convex-analysis vs. functional-equation derivation styles) | §5.2 |
| s-2 | T | Add one sentence to §5.2 flagging adjacent settings (von Neumann–Morgenstern, Shannon entropy) without claiming published instances | §5.2 |
| references | T | Add the four surveyed-literature citations (BJM, Tewari–Bartlett, Steinwart, Reid–Williamson) to the bibliography under references [B1]–[B5] so they are available for the §5.2 invocation | references |

Three light edits. Closure draft deliverable: [`05-draft0.2-manuscript.md`](05-draft0.2-manuscript.md).

---

## 5. Sign-off

**Judge S.** *Pass with two [Minor] strengthenings.* The prior-art positioning is honest and complete. The §5 framing decision (one documented recurrence + structural prediction) was the right scoping choice given the external-search outcome. The two [Minor] strengthenings (acknowledging the convex-analysis-vs-functional-equation derivation-style observation, and flagging two adjacent settings with appropriate scoping) sharpen the §5 framing without changing any mathematical content. The note is ready for submission to *Comptes Rendus Mathématique* after Round 5.

---

## Appendix — surveyed-literature notes (for [B1]–[B5] bibliography entries)

**[B1] P. L. Bartlett, M. I. Jordan, J. D. McAuliffe.** "Convexity, classification, and risk bounds." *Journal of the American Statistical Association*, 101(473):138–156, 2006.
*Relevant content:* the $\psi$-transform construction is the biconjugate of the level-set gap of the surrogate-loss-vs-0/1-loss excess risks. Derived via convex analysis. No functional equation of $(\star)$-form derived; the calibration result is an inequality, not an equation.

**[B2] A. Tewari, P. L. Bartlett.** "On the consistency of multiclass classification methods." *Journal of Machine Learning Research*, 8:1007–1025, 2007.
*Relevant content:* multiclass extension of [B1]. Same derivation style. Same observation: no $(\star)$-style equation derived.

**[B3] I. Steinwart.** "How to compare different loss functions and their risks." *Constructive Approximation*, 26(2):225–287, 2007.
*Relevant content:* unifying framework for surrogate-loss comparison. Again convex-analysis-driven; no $(\star)$.

**[B4] M. D. Reid, R. C. Williamson.** "Composite binary losses." *Journal of Machine Learning Research*, 11:2387–2422, 2010.
*Relevant content:* link functions and composite losses. Functional equations appear (linking proper losses to f-divergences) but of a different shape; not $(\star)$.

**[B5] M. D. Reid, R. C. Williamson.** "Information, divergence and risk for binary experiments." *Journal of Machine Learning Research*, 12:731–817, 2011.
*Relevant content:* the canonical f-divergence ↔ proper-loss bijection on the optimization axis. Important for the broader context of the main paper [El2], but the derivation is convex-analytic, not functional-equation. No $(\star)$.

These five papers are the natural calibration-theory backdrop and should appear in the bibliography to anchor the §5.2 observation.
