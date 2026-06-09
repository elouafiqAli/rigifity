# Section 6 redesign — research memo (intermittent deliverable)

**Task:** rebuild "Where the trap recurs" so its rhetoric is right-side-up, its examples are honest, and its spine is a usable idea rather than a list of alleged errors.
**Status:** Phases A (spine), B (re-audit), C (example hunt) executed. Phases D (architecture) and E (LaTeX draft) proposed at the end, pending your sign-off.
**Convention:** **[proven]** checked and holds · **[verify]** needs the physical source · **[lit]** established in the cited literature, locator to confirm.

---

## The headline, in three sentences

The current Section 6 asserts that applied derivations produce the continuous-coefficient equation (⋆), so the classical regularity hypotheses are vestigial there. The honest finding is the reverse for two of your three examples and *exactly backwards* for entropy: the Shannon-entropy characterization runs on the **fundamental equation of information** (a Cauchy relative, concave target), where your *own five Table-1 hypotheses* reappear and are **load-bearing**. The phenomenon you found is real but **narrow** — it needs a genuine continuum of real weights in the structure — and the true contribution is a **diagnostic** that separates the rare vestigial case from the common load-bearing ones, together with the observation that misclassification runs in *both* directions (your provenance note is a case of the rarer direction).

This is a stronger paper than the current draft, not a weaker one: a sharp dividing line plus a two-sided dictionary beats a one-sided "people keep erring."

---

## Phase A — The spine: a four-way diagnostic

A "saturated Jensen" identity `G(p·u₁+(1−p)·u₂) = p·G(u₁)+(1−p)·G(u₂)` is a *family* of assertions indexed by `p`. Its entire content is the **set of `p` for which the derivation actually licenses the assertion**. Four sources of such identities occur in practice; only the fourth is your "vestigial" side.

**Source 1 — finite binary mixing → (J_Q), regularity needed.** If the primitive is a binary mixture iterated finitely, the achievable weights are the dyadic rationals, and with cancellation at most ℚ∩[0,1]. The derivation licenses (J_Q), not (⋆); by your Proposition 5 a regularity hypothesis is then genuinely required. *(Archetype: vNM independence — see B.1.)*

**Source 2 — additivity into a bounded codomain → Cauchy + boundedness.** If the derivation yields additivity of `G` with `G` valued in a bounded set, linearity follows from the classical *bounded-additive ⇒ linear* theorem (Ostrowski/Steinhaus), not from the endpoint substitution. Regularity (boundedness) is load-bearing, merely supplied free by the codomain. *(Archetype: linear opinion pools — see C.1.)*

**Source 3 — a Cauchy relative with a non-affine target → regularity needed.** If the operative equation is a Cauchy relative whose intended solution is non-affine, regularity rules out the Hamel-type pathology and (⋆) is not in play at all. *(Archetype: the fundamental equation of information / entropy — see B.2.)*

**Source 4 — a genuine continuum of real weights → (⋆), regularity vestigial.** If `p` is a real parameter *realized in the structure* (an atomless measure assigns an event any mass `p∈[0,1]`; Lyapunov's convexity theorem guarantees realizability), and the saturated identity is asserted *directly* for that real `p` (not built by iteration), then the derivation licenses (⋆) at **every** real `p`, irrationals included, and Theorem 1 forces affineness with no regularity. *(Archetype: atomless Bayes-risk / calibration — see B.3 and C.2.)*

**The diagnostic, in one question:** *Does your derivation assert the identity at every real weight because the weights form a genuine continuum in the structure (Source 4 → (⋆), drop the hypothesis), or does it reach only rational weights, or rely on the codomain's boundedness, or solve a Cauchy relative with a non-affine target (Sources 1–3 → keep the hypothesis)?*

**The trap, stated correctly:** it is *misclassification*, and it cuts both ways. Sources 1–3 look like they might be Source 4, so an author drops a hypothesis that was load-bearing; or — your own case — a Source 4 derivation looks like a Cauchy problem, so an author *adds* a hypothesis that was vestigial. The paper should own both directions.

---

## Phase B — Re-audit of the current three examples

### B.1 Expected utility — **Source 1, regularity load-bearing** (currently misclassified) [lit, high confidence]

What the draft claims: vNM/Herstein–Milnor linearity "for all `p∈[0,1]`" is (⋆), and the endpoint substitution is "the algebraic alternative to the Archimedean axiom."

What is true: the mixture-set representation theorem requires **completeness, transitivity, independence, mixture-continuity, and Archimedean** as necessary and sufficient (vNM 1944; Herstein–Milnor 1953; Fishburn 1970; Kreps 1988). Independence alone is *ordinal* (it constrains preference, not a cardinal functional equation); the **Archimedean axiom is what produces a real-valued affine representation** in the first place. Drapeau–Kupper make the layering explicit: independence + Archimedean give an *affine* `U` (unique up to affine maps); weak continuity is the *further* condition that upgrades affine to expected-utility (integral) form.

The clean witness: **lexicographic preferences** satisfy completeness, transitivity, and independence, fail Archimedean, and admit **no real-valued representation at all** — hence no `U`, hence (⋆) is vacuous. So Theorem 1 cannot replace the Archimedean axiom: Theorem 1 *presupposes* a real `G` satisfying (⋆), and the Archimedean axiom is exactly what is needed to produce such a `G`. The logical dependence runs opposite to the draft's claim.

**Verdict:** demote to a Source-1 example. Honest framing: "Here it looks as though saturated linearity would invite Theorem 1; in fact the pre-continuity content is rational-coefficient (Source 1), the Archimedean axiom is load-bearing, and lexicographic preferences show it cannot be dropped." That contrast *teaches the diagnostic*.
New citations to add (and verify): Fishburn, *Utility Theory for Decision Making* (1970); Kreps, *Notes on the Theory of Choice* (1988); the lexicographic counterexample is standard in both.

### B.2 Shannon entropy — **Source 3, regularity load-bearing** (currently *backwards*) [lit, high confidence]

What the draft claims: the recursivity analysis reduces to (⋆)-form equations closed by continuity, and the endpoint substitution is the continuity-free alternative.

What is true: the operative equation is the **fundamental equation of information (FEI)**,
`f(x) + (1−x)·f(y/(1−x)) = f(y) + (1−y)·f(x/(1−y))`,
a Cauchy relative whose intended solution is the **Shannon information function `S(x) = −x log x −(1−x)log(1−x)`** — strictly *concave*, not affine. Faddeev's theorem assumes **continuity** of `f(x)=I₂(x,1−x)` outright (Faddeev 1956/1957; clean statement in Baez–Fritz–Leinster, *Entropy* 13 (2011) 1945–1957). The post-Faddeev history is the decisive point: the regularity was weakened step by step — **Tverberg** (integrability), **Lee** (measurability), **Daróczy** (continuity at 0 / "small for small probabilities"), **Diderrich** (boundedness on a set of positive measure), **Kendall** and **Borges** (monotonicity on `[0,½)`). These are *literally the five rows of your Table 1*, arising in the wild, and they are **load-bearing**: without one of them the FEI admits Hamel-type non-measurable solutions, exactly as Cauchy's equation does (Aczél–Daróczy, *On Measures of Information and Their Characterizations*, 1975).

**Verdict:** this is your **best** example — but for the opposite thesis. Reframed: "The Shannon-entropy characterization is the canonical place where the five hypotheses of Table 1 reappear in an applied setting — and there they are *load-bearing*, because the operative equation is the FEI (a Cauchy relative with a concave target), not (⋆). This is the mirror image of the calibration case in B.3, where the same-looking saturated identity is genuinely (⋆)." It directly demonstrates that the dictionary's left column is not a museum piece.
New citations to add (and verify): Faddeev (already in refs); Baez–Fritz–Leinster (2011); Diderrich (1975, "The role of boundedness in characterizing Shannon entropy", *Inform. and Control*); Lee (1964); Kendall (1964); Borges (1967); Aczél–Daróczy (1975).

### B.3 Surrogate calibration (resolution axis) — **Source 4, genuinely (⋆)** (the only right-side case) [proven mechanism; support currently missing]

What is true: on an **atomless** probability space a two-cell partition realizes a cell of mass `p` for *every* real `p∈[0,1]` (Lyapunov convexity), so the saturated Bayes-risk identity is tested at every real `p` — genuine (⋆), Theorem 1 applies, regularity vestigial. This is the real thing and it is the lead positive example.

Two fixes it still needs (from Round 1):
1. **Support.** The self-citation was stripped for blinding, leaving the claim bare. Restore in an anonymized form the Monthly permits — "[Author, manuscript under review]" or a neutral "in a partition-theoretic framework developed elsewhere."
2. **The saturation step.** Bayes risk is generically *concave* in `p`; say in one sentence *why the slack vanishes across the whole two-point family* here (the structural reason the inequality saturates), or the reader cannot distinguish (⋆) from ordinary Jensen.

**Bonus from B.2:** B.2 and B.3 are *both information theory*, on opposite sides of the line. Pairing them is the section's sharpest moment: "Information theory supplies a textbook left-side case (entropy characterization, FEI) and a genuine right-side case (Bayes-risk calibration, atomless ⇒ (⋆)); distinguishing them *is* the diagnostic."

---

## Phase C — Hunt for additional examples

### C.1 Linear opinion pooling (McConway) — **Source 2, not a right-side example** [lit]

I checked this as a candidate right-side case; it is not. McConway (1981, *JASA* 76:410–414) and Aczél–Wagner (1980) show that commuting with marginalization (the weak setwise function property) forces a **linear** pool when the space has ≥3 points. But the pooling function maps into `[0,1]` (probability-valued, hence **bounded**) and is additive, so linearity comes from the classical *bounded-additive ⇒ linear* theorem — Source 2, not the endpoint substitution. Useful as an optional **third left-side** case: it shows yet another mechanism (boundedness from the codomain) that does the work people might wrongly attribute to (⋆).

### C.2 A self-contained right-side toy — **recommended** [proven]

Genuine classical right-side examples are scarce precisely because Source 4 needs a continuum of real weights in the structure, which is special. Rather than stretch for a famous theorem, give a transparent three-line toy the reader can verify, then point to where the mechanism lives in the wild:

> *Toy (atomless split).* Let `(Ω,𝓕,μ)` be atomless with `μ(Ω)=1`, and let `Φ` assign to each measurable `A` a real `Φ(A)` depending only on `μ(A)`, say `Φ(A)=G(μ(A))`. Suppose splitting is mean-preserving: for every partition `A = A₁⊔A₂`, `Φ(A) = (μ(A₁)/μ(A))·Φ(A₁∪…)`… [precise saturated identity to be written so it reduces to (⋆) on `G`]. Because `μ` is atomless, `μ(A₁)/μ(A)` ranges over **all** of `[0,1]` (Lyapunov), so `G` satisfies (⋆) and is affine by Theorem 1 — with no continuity assumed on `Φ`.

The "in the wild" pointer: anywhere an extensive quantity is mean-preserving under continuous subdivision of a non-atomic carrier (mass/charge on a continuum; a value functional on a non-atomic measure space; the calibration Bayes risk of B.3). Lyapunov's convexity theorem is the single citation that explains *why* every real fraction is realizable.

### C.3 Examined and set aside
- **Quasi-arithmetic mean comparison** (`M_φ=M_ψ ⇒ ψ=aφ+b`; Hardy–Littlewood–Pólya, Aczél): the generators are *assumed continuous* from the start, so regularity is not vestigial; the endpoint substitution is the right closure tool for the φ–ψ relation, but it doesn't illustrate "vestigial." Mention only in passing if at all.
- **Harsanyi utilitarian aggregation:** inherits the vNM Archimedean dependence (Source 1); redundant with B.1.

---

## Phase D — Proposed architecture for the new Section 6

A spine + two-sided dictionary, organized by the diagnostic:

1. **§6.1 The diagnostic (the spine).** State the four sources and the one-question test. This is the contribution; lead with it, not with examples.
2. **§6.2 When regularity is load-bearing (Sources 1–3).** Three short subsections, each naming the *mechanism* that does the work:
   - Utility (Source 1 — rational iteration; Archimedean; lexicographic witness).
   - Entropy (Source 3 — the FEI; the five Table-1 hypotheses reappearing, load-bearing). *This is the showpiece.*
   - Opinion pooling (Source 2 — boundedness from the codomain). *Optional, keeps it to two if space is tight.*
3. **§6.3 When regularity is vestigial (Source 4).** The calibration case (properly supported) + the atomless toy. Close the loop to your provenance note: the rarer misclassification direction (adding a hypothesis you didn't need) is exactly what happened to you.
4. **§6.4 A companion table.** Mirror Table 1: the *same five hypotheses*, with a column "appears in entropy characterization (load-bearing)" beside "appears under (⋆) (vestigial)." This visually makes the both-directions point and ties Section 6 back to Section 4.

### Ripple effects to decide (flagging, not fixing yet)
- **Thesis/abstract:** the abstract currently surveys "three application areas where the same vestigial hypotheses recur." Under the reframing, two of the three are *load-bearing* cases. The abstract's third paragraph and the intro's bullet (iii) need rewording toward "a diagnostic separating vestigial from load-bearing, with the same hypotheses on both sides." Net effect on the paper's appeal: positive, but it is a real edit.
- **Cover letter:** "modern applied work … carries defensive regularity assumptions that are unnecessary" overstates it under the honest finding; soften to the diagnostic framing (and it dovetails with the provenance anecdote, which the letter already highlights).
- **Title:** "vestigial regularity hypotheses" still fits (the phenomenon is real), but the paper is now as much about *telling vestigial from load-bearing*. Optional subtitle tweak; not required.

---

## Phase E — What I draft next (on your go)

Replacement LaTeX for Section 6 implementing §6.1–§6.4: the diagnostic prose, the three load-bearing subsections with one-paragraph mechanisms and correct citations, the calibration subsection rewritten with the saturation sentence and an anonymized self-reference, the fully-worked atomless toy, and the companion table. I will also draft the abstract/intro edits the reframing forces, so you can see the whole thing cohere before committing.

## New references this introduces (add to your Round-1 verification checklist)
Fishburn (1970); Kreps (1988); Baez–Fritz–Leinster, *Entropy* 13 (2011) 1945–1957; Diderrich (1975, *Inform. and Control*); Lee (1964); Kendall (1964); Borges (1967); Aczél–Daróczy (1975); McConway (1981, *JASA* 76:410–414); Aczél–Wagner (1980); Lyapunov convexity theorem (1940). Same rule as before: confirm each against the primary source, not a snippet.