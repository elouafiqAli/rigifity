# Mechanization Strategy

*Decision document for adding machine-checked verification to the rigidity manuscripts. Written at the gate between Draft 0.1 (`03` audit closed via `06`) and Draft 0.2 (consolidation per `08`), with the audit of `04` (`07`) on the record.*

> **Headline.** Yes, add mechanization, but as a **verified rigidity kernel** (≈750 LoC in Lean 4 + mathlib covering Theorem 1, Theorem 2, the consolidated §4.2 simplex rigidity, and Proposition 6) — not as full paper mechanization. Sequence **after Draft 0.2 ships**. Use **Lean 4 + mathlib**; the workspace's registered `lean-proof` skill at `.agents/skills/lean-proof/SKILL.md` confirms prior tooling commitment.

---

## 1. Three filters for the decision

1. **Is the claim load-bearing and contestable?** *Yes* for rigidity theorems (uniqueness *up to scalar* — the strongest kind of universality claim, exactly where hidden counterexamples sting hardest). *No* for §6 architecture sorting (qualitative modeling claim) or §7 complexity statements (algorithmic, not pure math).

2. **Does it fit existing tooling?** Mathlib has the simplex, Jensen's inequality, convex biconjugates, the refinement order on σ-algebras, atomless measures via `Measure.NoAtoms`, and finite-partition expectations. The rigidity proofs are short functional-equation arguments that map directly onto these. Mechanizing WL refinement, spectral-gap bounds, or attention weights would require building entire libraries that do not exist.

3. **What would mechanization have caught?** Honest counterfactual against the two audits:

| Audit item | Lean would have caught? | Why |
|---|---|---|
| `03` C-1 (§6 partition object) | **No** | Wrong modeling object, not wrong proof |
| `03` C-2 (Thm 5 missing quantifier) | **Yes** | Classic Lean win — quantifiers cannot be silently dropped |
| `03` M-1 (lossy bracket undefined) | **No** | Nothing to verify; the object did not exist |
| `03` M-2 (grid-dependence) | Partial | Forces explicit ε-net hypothesis |
| `03` M-3 (OP1 conflation) | **No** | Cross-document framing issue |
| `03` M-4 (Thm 2 proof tightening) | **Yes** | The two-cell detour would surface as redundant in Lean |
| `03` M-5 (Cor 4 qualifier) | **No** | Modeling claim |
| `04` M-1 (atomless hypothesis) | **Yes** | Type system forces hypothesis declaration |
| `04` M-2 ($c_\varphi$ finiteness) | **Yes** | Division-by-zero must be explicit premise |
| `04` m-4 (bounded-Jensen) | **Yes** | Bounded-Jensen-implies-affine needs explicit regularity premise |
| All other minors | **No** | Presentation, framing, cross-references |

Mechanization catches roughly half of audit-class errors. Significant, but does not replace adversarial audit + commit discipline.

---

## 2. Scope: the verified rigidity kernel

| Component | Verify? | Why | Est. LoC |
|---|---|---|---|
| Theorem 1 (refinement monotonicity) | **YES** | Pure measure-theoretic Jensen; foundational; every other result rests on it | ~100 |
| Theorem 2 (binary rigidity) | **YES** | Single-cell argument; load-bearing binary uniqueness | ~200 |
| Simplex rigidity (consolidated §4.2) | **YES** | Functional equation in three clean steps; multiclass universality | ~400 |
| Proposition 6 (two-query identity) | **YES** (cheap) | Structural sanity; trivial once Thm 1 is in place | ~50 |
| Theorem 5 (depth iff) | OPTIONAL | Counterexample-based; mechanizable but lower payoff | ~150 |
| §6 architecture sorting | NO | Modeling claim, not theorem |
| §7 complexity | NO | Algorithmic; would need a model of computation |

**Total for the kernel: ≈750 LoC** (≈900 with Theorem 5).

---

## 3. What this buys, and what it does not

**Buys.**
- *Defensibility.* "The two rigidity theorems are mechanically verified in Lean 4 against mathlib; the formalization is at [URL]." One sentence retires a class of referee objections.
- *Hypothesis hygiene ex ante.* `04` M-1 and M-2 would have been impossible to land. Audit caught them post hoc; Lean prevents them entirely.
- *Distinction in the literature.* The multiclass surrogate-calibration literature (Tewari–Bartlett, Ramaswamy–Agarwal, Pires–Szepesvári) is not mechanized. A verified rigidity result is a credentialed claim where everyone else is on paper.
- *Optionality.* A verified kernel sits permanently in a public repo (or, with enough polish, in mathlib upstream). The paper can be revised; the kernel cannot regress.

**Does not buy.**
- *Stronger GNN claims.* §§5–7 depend on modeling choices, not proof tightness.
- *§6-class errors.* Wrong-mathematical-object failures are caught by adversarial review, not by typecheckers.
- *Presentation/framing.* m-1, m-5, "honest positioning" sentences are unaffected.
- *Substitute for experiments.* The empirical companion is still required for the GNN community.

---

## 4. Sequencing options

| Option | Description | Verdict |
|---|---|---|
| **A. Sequential (recommended)** | Ship Draft 0.2 first per `08` PERT. Open `lean/` subdirectory afterward as a separate workstream. Paper cites the formalization once complete. | Recommended — no critical-path coupling between writing and verification. |
| **B. Parallel from Draft 0.2 commit D** | Commit D (§4.2 rigidity import) is the long-pole node and the most error-prone. Drafting D in Lean first and writing prose from the verified statement is the most disciplined order. | Acceptable. Adds 2–3 weeks to Draft 0.2 timeline but ships consolidated paper with core already mechanized. |
| **C. Block on full mechanization** | Wait until kernel verified before further writing. | Not recommended — paper is in publishable state. Optimizes for a perfection the audience does not require. |

---

## 5. Proof assistant choice

| Assistant | Fit | Notes |
|---|---|---|
| **Lean 4 + mathlib** | **Best** | Jensen, simplex (`Std.Convex.simplex`), biconjugate (`ConvexAnalysis.Conjugate`), refinement of measurable spaces, atomless measures all present. Workspace has `lean-proof` skill at `.agents/skills/lean-proof/SKILL.md`. |
| Rocq (Coq) + MathComp / Coquelicot | Possible | Coquelicot measure-theory coverage thinner; refinement order on σ-algebras would need building from primitives. |
| Isabelle/HOL | Strong measure theory | Hölzl's library is excellent, but decision-theoretic side and simplex less developed. |

**Recommendation: Lean 4 + mathlib.**

---

## 6. Decision and forward plan

**Decision.** Adopt the verified rigidity kernel scope (Thm 1, Thm 2, simplex rigidity, Prop 6 ≈ 750 LoC), sequencing option A (after Draft 0.2 ships), Lean 4 + mathlib.

**Forward plan.**
1. Complete Draft 0.2 per `08-draft0.2_commitology.md`.
2. After Draft 0.2 ships: open `lean/` subdirectory. Scaffold `lakefile.lean`, mathlib pin, the four target theorem statements as `sorry` placeholders with fully-typed hypotheses. (The scaffold alone is a useful artifact — it forces the precise statement of the hypotheses that `04` M-1 and M-2 were imprecise about.)
3. Verify Theorem 1 first (smallest, foundation for the rest).
4. Verify Theorem 2 second (binary case, half the multiclass machinery).
5. Verify simplex rigidity third (the long-pole proof).
6. Verify Proposition 6 fourth (cheap, sanity-check the framework).
7. Optional: Theorem 5 (depth iff) as a separate fifth deliverable.
8. Once the kernel compiles green: add a one-paragraph "Mechanization" subsection to `03` §1 with the repository link.

**Out of scope at any stage.** §§5–7 GNN content, §6 architecture sorting, §7 complexity, the WL refinement step itself.

---

*Strategy owner: PI. Execution scheduled after Draft 0.2 closure.*
