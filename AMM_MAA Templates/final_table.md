# Dictionary of Cited Examples — *The Continuous-Coefficient Jensen Equation*

This is a master reference table cataloguing every applied example in the manuscript, classified by which side of the line it falls on: whether the classical regularity hypotheses are **load-bearing** (genuinely needed) or **vestigial** (carried by habit, retired by the continuous-coefficient mechanism).

## Table A — The Field Guide of Examples (by mechanism)

| # | Example | Domain | Operative equation | Why that equation | Regularity verdict | What does the work | Key sources |
|---|---------|--------|--------------------|--------------------|--------------------|--------------------|-------------|
| 1 | **Expected-utility representation** | Decision theory | None reaches (★) | Independence is stated at every real *p*, but yields no cardinal equation until a real-valued *U* exists | **Load-bearing** — *prior to* the dictionary | **Archimedean (mixture-continuity) axiom** — produces the real-valued *U* in the first place; lexicographic preferences satisfy independence yet have no representation | vNM 1947; Herstein–Milnor 1953; Fishburn 1970; Kreps 1988 |
| 2 | **Shannon entropy, binary (*n*=2)** | Information theory | Fundamental equation of information (a Cauchy relative) | Recursivity axiom reduces to it at *rational* weights; target is the *concave* binary entropy, not affine | **Load-bearing** | One of the five struts: continuity (Faddeev), integrability (Tverberg), measurability (Lee), bounded-on-positive-measure (Diderrich), monotonicity (Kendall, Borges) | Khinchin 1957; Faddeev 1957; Tverberg 1958; Lee 1964; Kendall 1964; Borges 1967; Diderrich 1975; Baez–Fritz–Leinster 2011 |
| 3 | **Shannon entropy, *n* > 2** | Information theory | Grouping equations over the full simplex | For any fixed *n* > 2 the axiom constrains *f* at *all* probability vectors, irrationals included → a genuine continuum | **Vestigial** (Fischer) — regularity-free | The continuum of weights itself (same mechanism as Theorem 1) | Aczél–Daróczy 1975 (recording Fischer 1972) |
| 4 | **Linear opinion pools** | Aggregation / probability | Cauchy additivity into a bounded codomain | Aggregation commutes with marginalization → additive across disjoint events; outputs lie in [0,1] | **Load-bearing** | **Boundedness**, supplied by the codomain (the bounded-additive theorem), not a continuum of weights | McConway 1981; Aczél–Wagner 1980 |
| 5 | **Surrogate-loss calibration (atomless)** | Statistical learning | (★) genuinely, via cellwise-exact aggregation | Atomlessness realizes every mixing mass *p* ∈ [0,1] (Sierpiński / Lyapunov convexity) | **Vestigial** | The continuum of cell masses; affineness and endpoint continuity are *conclusions*, not inputs | Reid–Williamson 2011; Schervish 1989; EGJK 2016; (BJM 2006; Steinwart 2007; Tewari–Bartlett 2007) |
| 6 | **Reid–Williamson "fairness" condition** | Statistical learning | Splits under (★) | One published hypothesis, two clauses pulled apart by the dictionary | **Mixed (one clause each way)** | *Boundary-continuity clause* → **vestigial** (a conclusion of cellwise-exact aggregation); *zero-loss clause* ℓ(0,0)=ℓ(1,1)=0 → **load-bearing** but a **normalization**, not a Hamel-excluding hypothesis | Reid–Williamson 2011 [Thm 14, Thm 16] |
| 7 | **The benchmark partition and tent** | Scoring rules | (★) on each cell (Corollary 5 converse) | Cost-weighted Bayes risk *L_c*(u) = min{(1−u)c, (1−c)u}; *G* = ∫ T_θ dν, dν = −G″dθ | **Vestigial** | Piecewise saturation pins the tent shape; continuity at the apex obtained for free | Reid–Williamson 2011 [Thm 14, 16]; Schervish 1989; EGJK 2016 |
| 8 | **Mixture-affine assignments on quantum states (preparation side)** | Quantum foundations | (★) genuinely, via Theorem (higher-dim) on the convex set 𝒮_d | Statistical mixture *p*ρ₁+(1−p)ρ₂ is operationally primitive, *p* a true continuum from a classical randomizer | **Vestigial** | The convex-domain form of the theorem; *v*(ρ)=tr(Aρ)+b with no positivity/boundedness/continuity/measurability | Holevo 1982 [Lemma 1.6.1] |
| 9 | **Gleason-type derivations (measurement side)** | Quantum foundations | First source — finite additivity over coarse-grainings | Coarse-graining gives homogeneity only over nonnegative *rationals*; the rational→real step must be purchased | **Load-bearing** | Positivity / nonnegativity (Gleason *d* ≥ 3; Busch *d* ≥ 2), positivity or explicit continuity (CFMR), or the Hamel-catalog bound (Wright–Weigert) | Gleason 1957; Busch 2003; CFMR 2004; Wright–Weigert 2019 + Correction 2020 |

## Table B — The Four Sources of a Saturated Identity (the diagnostic)

The **zeroth question** (a gate prior to the four sources): *does a real-valued solution of the identity provably exist?* If not (Example 1), the dictionary is never reached.

| Source | The identity actually reaches… | Regularity verdict | Diagnostic signature | Manuscript examples |
|--------|-------------------------------|--------------------|---------------------|---------------------|
| **1. Rational-coefficient relative** | Only the rational weights (finite iteration, coarse-graining) | **Load-bearing** | Homogeneity over ℚ₊ only; a rational→real bridge is required | Shannon *n*=2 (#2); Gleason measurement side (#9) |
| **2. Additive into a bounded codomain** | A Cauchy equation whose range is bounded | **Load-bearing** | Boundedness supplied by the codomain | Linear opinion pools (#4) |
| **3. Cauchy relative, non-affine target** | A Cauchy-type equation whose intended solution is not affine | **Load-bearing** | Target is concave/non-linear (e.g. entropy) | Shannon *n*=2 (#2) |
| **4. Genuine continuum of real weights** | (★) at *every* real *p*, irrationals included | **Vestigial** | A real parameter realizes every mixing mass in [0,1] | Shannon *n*>2 (#3); calibration (#5–7); quantum preparation (#8) |

## Table 2 (rewritten) — The Dictionary, Mirrored

The same five regularity hypotheses sit on opposite sides of the line depending on the source of the identity: **load-bearing** when the operative equation is a Cauchy relative tested only at rational weights (the binary entropy characterization), and **vestigial** when a genuine continuum of weights makes the operative equation the continuous-coefficient (★) (the atomless calibration computation).

| Hypothesis on *G* | Under a Cauchy relative at rational weights (entropy *n*=2) | Under (★) with a continuum of weights (calibration / quantum prep) |
|---|---|---|
| **Continuity** (at a point, or on the interval) | **Load-bearing** — excludes Hamel solutions | **Vestigial** — a *conclusion* (affine on each cell ⇒ continuous) |
| **Measurability** (Lebesgue or Borel) | **Load-bearing** | **Vestigial** — same |
| **Monotonicity** (on the interval) | **Load-bearing** | **Vestigial** — same |
| **Boundedness on a positive-measure set** | **Load-bearing** | **Vestigial** — same |
| **Boundedness on the interval** | **Load-bearing** (*a fortiori*) | **Vestigial** — same |
| **None** | **Insufficient** — Hamel-type solutions of the binary (*n*=2) fundamental equation of information; for *n*>2, Fischer (1972) showed none exist | **Sufficient** — Theorem 1 (the one-line endpoint substitution) |

**Reading the table.** Column 2 is the classical regularity catalog for the discrete/rational-weight Jensen equation, where Hamel's pathology is real and every hypothesis earns its place. Column 3 is the same list under the continuous-coefficient equation, where each hypothesis is a theorem rather than an assumption — the pathology has nowhere to live because (★) tests *G* at the irrational weights too. The single structural fact behind the whole mirror: **Hamel-basis solutions survive every rational test and are exposed by the irrational ones.**