# High-Impact Applications of (⋆)

## A dossier: where the continuous-coefficient Jensen equation retires regularity hypotheses that currently cost real money

Companion to the *Monthly* draft and to the reconstruction monograph. Each entry is scored against the paper's own diagnostic (five-gate version, per the monograph §8.6): a candidate qualifies only if (G0) a real-valued unknown provably exists, and (G4) the weight $p$ is realized as a **genuine continuum inside the structure** — not reached by finite mixing, not secretly a bounded-codomain additivity argument, not a Cauchy relative with a non-affine target.

Verdicts are marked **[verified]** (checked against sources), **[derivation]** (proved here or in the monograph), or **[audit target]** (plausible, must be checked before claiming in print). The bonus column — existing work struggling with the hypotheses — is integrated per entry and summarized in §B.

---

## Tier 1 — Game-changing

### A1. Quantum foundations: mixture-affine functionals on state space — *the natural consumer of Theorem 4*

**The structure.** The density operators on $\mathbb{C}^d$ form a convex set $\mathcal{S}_d$. The mixture $p\rho_1+(1-p)\rho_2$ is operationally primitive: prepare $\rho_1$ with probability $p$ using a classical atomless randomizer. The weight $p$ is a *physically realized continuum* — gate G4 passes by construction, not by argument.

**The unknown.** Any assignment $v:\mathcal{S}_d\to\mathbb{R}$ that respects statistical mixing:
$$v\bigl(p\rho_1+(1-p)\rho_2\bigr)=p\,v(\rho_1)+(1-p)\,v(\rho_2)\qquad(\forall \rho_i\in\mathcal S_d,\ \forall p\in[0,1]).$$
This is exactly the vector form (⋆) on a convex domain. **Theorem 4 of the paper applies verbatim**: $v$ is the restriction of an affine functional, hence (by self-duality of Hermitian trace pairing) $v(\rho)=\mathrm{tr}(A\rho)+b$ for some Hermitian $A$ — with **no positivity, boundedness, continuity, or measurability assumed on $v$.**

**Why this is game-changing.** The entire Gleason-type literature reaches linearity from the *measurement* side — frame functions on effects — and there it genuinely fights the Hamel monster. The field's own words: additivity of a frame function "only guarantees linearity for rational coefficients," pathological discontinuous unbounded additive functions threaten, and the rational→real step is closed by invoking non-negativity/boundedness (Gleason; Busch 2003; Caves–Fuchs–Manne–Renes 2004, who offer the reader a choice of "proving continuity" or Busch's homogeneity-from-positivity) **[verified]**. Wright–Weigert (Found. Phys. 2019, "Gleason-Type Theorems from Cauchy's Functional Equation") make the connection to Cauchy's equation explicit and prove that nonlinear frame functions cannot be bounded, continuous at zero, or measurable — i.e., they independently rediscover the paper's Table 1 inside physics **[verified]**.

The diagnostic sorts this instantly and explains the whole landscape:

- *Effect-side route (the literature's):* additivity over coarse-grainings of POVMs is **finite mixing** → rational homogeneity only → Source 1 collapses into Source 2 (codomain $[0,1]$ supplies boundedness) → positivity is **load-bearing**, and necessarily so. The diagnostic predicts — correctly — that every proof on this route must invoke positivity/continuity at exactly the rational→real step.
- *State-side route (the proposal):* operational mixing supplies a **continuum of weights** → Source 4 → Theorem 4 closes it with nothing. Regularity hypotheses are **vestigial**. Even *signed, unbounded, non-physical* assignments respecting mixtures are forced affine — strictly stronger than what the effect route delivers, and directly relevant to the active necessity-analysis literature on Born-rule derivations (e.g., the 2026 "Summing to Uncertainty" line, which audits precisely which assumptions each derivation consumes).

**Deliverable for the paper.** A half-page subsection: "Preparation-side Gleason lemmas: where positivity is vestigial." It (i) gives Theorem 4 its missing application, (ii) cites a physics literature that is *demonstrably* wrestling with the exact regularity catalogue of Table 1 today, (iii) positions Wright–Weigert as the Source-2 mirror of your Source-4 statement. **Bonus payoff: maximal** — this is a field caught in the act, with quotable struggle.

**Caution (honesty clause).** Hardy's GPT "continuity axiom" and similar axioms in operational reconstructions are **not** vestigial: there continuity does a *different* job (separating quantum from classical reversible dynamics). Citing them as vestigial would be the paper's own second-kind misclassification, inverted. Flag the distinction explicitly — it is itself a live demonstration of the diagnostic. **[verified as to Hardy's axiom existing; its role: audit before print]**

---

### A2. Axiomatic thermodynamics: entropy calibration along mixing lines (Lieb–Yngvason)

**The structure.** In the Lieb–Yngvason framework, the scaling and splitting axioms manipulate a body of substance in **any real mass fraction** $\lambda\in[0,1]$ — you can divide a gas into proportions $\lambda:(1-\lambda)$ for every real $\lambda$. The continuum of weights is physical, primitive, and atomless in the relevant sense. Gate G4 passes.

**The unknown.** The entropy function $S$ restricted to a mixing line, calibrated by the canonical construction $S(X)=\sup\{\lambda: ((1-\lambda)X_0,\lambda X_1)\prec X\}$. The splitting/recombination identity asserts exact mass-weighted additivity at every real $\lambda$ — a saturated (⋆) along each line of states.

**Why game-changing.** Theorem 1 says the affine calibration of $S$ along mixing lines requires *no* continuity or monotonicity input: **continuity of entropy in composition is a conclusion of saturation, not an axiom.** Lieb–Yngvason themselves are famously careful (their stability axiom A6 handles limiting behavior), but the surrounding literature routinely *assumes* continuity of $S$ in mole fractions outright. The sharp question for an audit: which invocations of stability/continuity in the L–Y development and its successors serve only the affine-calibration step — and are therefore vestigial — versus those serving genuine limit arguments (load-bearing). **[audit target — high value: a "vestigial hypotheses in axiomatic thermodynamics" note is publishable on its own, plausibly in J. Stat. Phys. or SIGMA]**

---

### A3. Information design: saturated segments of the concavification (Aumann–Maschler; Kamenica–Gentzkow)

**The structure.** Bayesian persuasion's splitting lemma: a prior $\mu_0$ can be split into posteriors $\{\mu_1,\mu_2\}$ with weights $(p,1-p)$ for **every real $p$** consistent with Bayes-plausibility $p\mu_1+(1-p)\mu_2=\mu_0$ — signal devices on atomless randomness realize all of them. Gate G4 passes; the continuum is the feasibility set itself.

**The unknown.** The sender's value $v$ on a *saturated segment* — a face of the belief simplex where the concavification $\operatorname{cav} v$ coincides with the chord, i.e., where every splitting yields exactly the mixture of endpoint values.

**The result.** On any saturated segment, $v$ satisfies (⋆) along the segment at every real weight, hence is **affine there with no upper-semicontinuity or measurability assumed.** This yields a clean internal split of one of economics' most-cited theorems: in Kamenica–Gentzkow, u.s.c. of $v$ is **load-bearing for attainment** of the concavification supremum, and **vestigial for the structure of $v$ on saturated faces.** Nobody (to my knowledge — verify) has drawn that line inside the theorem; it sharpens indifference-set arguments throughout the persuasion literature, where affinity-on-indifference-regions is currently derived under blanket regularity. **[derivation; literature gap: audit target]**

---

### A4. Probabilistic program semantics: mixture-linearity vs. fixpoint continuity (pGCL / expectation transformers)

**The structure.** In probabilistic guarded-command languages, the binary choice $P\;{}_p\!\oplus\;Q$ carries a **syntactic real parameter** $p\in[0,1]$. The continuum of weights is part of the language; no measure theory needed to realize it. Gate G4 passes trivially.

**The unknown.** A candidate semantic functional $w$ (an "expectation transformer") required to satisfy exact mixture-linearity on probabilistic choice: $w(P\;{}_p\!\oplus\;Q)=p\,w(P)+(1-p)\,w(Q)$ for all real $p$.

**The result and the split.** Theorem 1 forces $w$ affine on every choice-line with no healthiness conditions consumed. Meanwhile (ω-)**continuity remains load-bearing for loops** — it is what makes Kleene fixpoint iteration converge. So the healthiness catalogue of McIver–Morgan splits exactly along the paper's line: *continuity is a fixpoint hypothesis, not a mixture hypothesis.* **[derivation; the split as an explicit observation in the verification literature: audit target]**

**Why game-changing for you specifically.** In a mechanized semantics (Lean/Coq/Isabelle), every healthiness condition is a proof obligation threaded through every lemma. Discharging the regularity obligations on the loop-free fragment — *provably unnecessary by Theorem 1* — shrinks formalization debt in exactly the way the paper's provenance note describes, now at ecosystem scale. This is the CPP/ITP-shaped application, adjacent to the Fourreau verification stack, and the one where "the formal system requires every clause to be used" stops being an anecdote and becomes a methodology.

---

## Tier 2 — Strong, with caveats

### A5. Fair division on atomless cakes (Steinhaus; Dubins–Spanier)

Utilities in cake-cutting are atomless measures; Dubins–Spanier runs on Lyapunov. Any *division value* asserted to aggregate exactly mass-linearly across all real splits satisfies (⋆); characterizations of such values currently assume continuity. The irony is publishable in itself: **Steinhaus authored both the taming theorem of the classical catalogue and the atomless setting where no taming is needed.** His own subject sits on both sides of his own line. **[derivation + rhetorical asset]**

### A6. Comparison of experiments / your own program: the tent as a piecewise-(⋆) corollary

Blackwell-ordering equality cases on atomless spaces realize all real prior weights — Source 4. More pointedly: in the achievable-error-floor framework, **tent-function uniqueness is plausibly a piecewise instance of Theorem 1**: surrogate exactness forces saturation of (⋆) on each side of $\tfrac12$ separately, and regularity-free affinity on $[0,\tfrac12]$ and $[\tfrac12,1]$ pins the tent as the unique exact surrogate with no continuity assumed at the kink or anywhere else.

**Recommended addition to the paper (one corollary, three lines):**
> *Corollary (piecewise saturation).* If $[0,M]=\bigcup_{i}[m_{i},m_{i+1}]$ is a finite partition and $G$ satisfies (⋆) on each cell, then $G$ is piecewise affine, with no regularity hypothesis; continuity at the knots is *not* implied and must come (only if true) from the cells' shared endpoints, where it is automatic since adjacent cells share the endpoint value.

This upgrades Example 5 from illustration to **engine of the flagship theorem** of the broader program, and gives COLT/TMLR reviewers a forward pointer. **[derivation — immediate from Theorem 1 cell-by-cell]**

### A7. Savage-style subjective probability and standard-gamble measurement

Savage's P6 forces the subjective state space to be atomless — events of every real likelihood exist *inside the axioms*; this is where decision theory legitimately stands on Source-4 ground. Downstream, the **standard gamble** (health economics, QALY calibration): $u(x)$ is defined by the indifference probability against a (best, worst) lottery, and mixture-saturation is asserted at every real $p$. The measurement literature carries continuity of $u$ as a hypothesis; given the gamble continuum, it is vestigial — while the *existence* gate (Archimedean) remains the genuine load-bearer, per the corrected vNM classification. **[audit target — applied-economics venues take such notes]**

### A8. The historical precedent: Aumann's continuum economies

Not an application — an ancestor. Aumann (1964): in an exchange economy with an **atomless continuum of traders**, *convexity of preferences becomes unnecessary* — Lyapunov convexifies aggregate demand for free. This is the most celebrated prior instance of the paper's exact thesis-shape: **atomlessness retires a classical hypothesis.** One sentence in the introduction placing (⋆) in the lineage Lyapunov → Aumann → Theorem 1 tells referees precisely what genre the paper belongs to, and that the genre has a distinguished history. **[verified, standard]**

---

## §B. Bonus ledger: existing work and its struggles

| Literature | Hypothesis carried | Verdict under the diagnostic |
|---|---|---|
| Gleason 1957; Busch 2003; Caves–Fuchs–Manne–Renes 2004 | positivity / boundedness / "prove continuity" at the rational→real step | **Load-bearing on their route** (effect additivity = finite mixing → Source 2); **avoidable** by switching primitive to state-mixing (Source 4, Theorem 4). The diagnostic *predicts* where their proofs must spend positivity — and they do, exactly there. |
| Wright–Weigert 2019 (Found. Phys.) | catalogue: nonlinear frame functions can't be bounded/continuous/measurable | Independent physics rediscovery of Table 1, Source-2 side. **Must be cited as prior art**; it strengthens the paper (the dictionary is being re-derived ad hoc in other fields) while leaving the Source-4 statement and the diagnostic untouched as contributions. |
| Hardy 2001 and GPT reconstructions | a "continuity" axiom | **Load-bearing for a different job** (excluding classical theory). A live specimen of why the diagnostic must run *both* directions — do not claim vestigial. |
| Kamenica–Gentzkow 2011 and successors | u.s.c./measurability of the value function | **Split**: load-bearing for sup-attainment of cav; vestigial for affinity on saturated faces. The split itself appears to be unremarked. |
| McIver–Morgan pGCL healthiness conditions | (ω-)continuity | **Split**: load-bearing for loop fixpoints; vestigial for mixture-linearity of $_p\oplus$. Formalization payoff. |
| Standard-gamble utility measurement (health economics) | continuity of the utility index | Plausibly **vestigial** given the gamble continuum; the genuine gate is existence (Archimedean). Audit before claiming. |
| Lieb–Yngvason and successors | stability/continuity in composition | **Audit**: separate the limit-theoretic uses (load-bearing) from affine-calibration uses (vestigial). |

## §C. Recommendation for the manuscript

1. **Swap in A1** as the second worked "vestigial" example beside the calibration computation: it consumes Theorem 4 (currently idle), imports a documented, ongoing struggle with exactly Table 1's hypotheses, and adds the Wright–Weigert citation the related-work section needs anyway.
2. **Add the piecewise corollary of A6** and one sentence noting it is the rigidity engine behind tent-uniqueness in the resolution-axis program — this welds the *Monthly* note to the COLT/TMLR line without overclaiming.
3. **Add the Aumann sentence of A8** to the introduction as lineage.
4. Keep A2–A4, A7 out of the *Monthly* paper; each is a self-contained short note for its own venue (J. Stat. Phys. / EC or TEAC / CPP–ITP / a health-economics methods journal), i.e., a serialization plan, not padding.
5. Run the audits marked above **before** any vestigiality claim about a named work goes to print; the paper's credibility rests on never committing the misclassification it diagnoses.
