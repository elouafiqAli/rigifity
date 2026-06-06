# Round 0 — Extraction, context, and pre-flight check

*Satellite O1, [`../../21-publication_plan.md`](../../21-publication_plan.md) §4 Tier 1. Constructs C1 + C9. Authored 2026-06-06 by Executor T.*

---

## 1. What we are extracting

Two interlocking facts of partition-restricted decision theory, plus the prior-art dictionary that pins their novelty.

**Fact A — the universal upper bracket constant.** Let $\varphi:[0,1]\to\mathbb R$ be a **normalized concave score** (concave, continuous, symmetric — $\varphi(\eta)=\varphi(1-\eta)$ — vanishing at $\{0,1\}$, normalized by $\varphi(\tfrac12)=1$, strictly increasing on $[0,\tfrac12]$). Then
$$
c_\varphi \;:=\; \sup_{\eta\in(0,1/2]}\frac{\eta}{\varphi(\eta)} \;=\; \tfrac12,
$$
uniformly across the class, attained at $\eta=\tfrac12$. The proof is one line: concavity puts $\varphi$ above its own chord through $(0,0)$ and $(\tfrac12,1)$, so $\varphi(\eta)\ge 2\eta$ on $[0,\tfrac12]$, equivalently $\eta/\varphi(\eta)\le\tfrac12$, with equality at $\eta=\tfrac12$.

**Fact B — refinement-monotonicity is concavity (binary form of Blackwell's converse).** Let $(\mathcal X,\mathcal F,\mathbb P)$ be atomless. For continuous $\varphi:[0,1]\to\mathbb R$, the following are equivalent over all finite measurable partitions $\Pi$ and all measurable labelings $f:\mathcal X\to\{0,1\}$:
$$
(\mathrm{i})\ \bar\varphi\text{ refinement-monotone}\ \Longleftrightarrow\ (\mathrm{ii})\ \bar\varphi\text{ binary-split-monotone}\ \Longleftrightarrow\ (\mathrm{iii})\ \varphi\text{ concave}.
$$
The forward direction $(\mathrm{iii})\Rightarrow(\mathrm{i})$ is Blackwell 1953 / Le Cam on the refinement lattice (a refinement of an experiment cannot raise the Bayes risk, for every loss). The **converse** $(\mathrm{ii})\Rightarrow(\mathrm{iii})$ — that binary-split monotonicity *forces* $\varphi$ concave — is the new piece. The proof: realise a cell of rate $\eta=\lambda a + (1-\lambda)b$ split into subcells of weights $\lambda,1-\lambda$ and rates $a,b$; binary monotonicity reads $\varphi(\lambda a+(1-\lambda)b)\ge\lambda\varphi(a)+(1-\lambda)\varphi(b)$, i.e. concavity. On a general (possibly atomic) space the equivalence holds by density of realizable splits and continuity of $\varphi$.

**The interlock.** Fact A is the upper instrument of the bracket; the lower instrument $\varphi^{-1}$ exists because of the normalisation and the strict-monotonicity-on-$[0,\tfrac12]$ clause; Fact B is what justifies the class (concave) within which the bracket has a clean upper constant. Together they give the **two-sided bracket**
$$
\varphi^{-1}\!\bigl(\bar\varphi(\Pi)\bigr) \;\le\; \varepsilon^\ast(\Pi) \;\le\; \tfrac12\,\bar\varphi(\Pi),
$$
which is the operational content of C1.

---

## 2. The trigger — why this satellite is being written now

The two constructs surface in the main paper as the load-bearing decision-theoretic spine on which the GNN consequences ride:

- **Main paper §1 — bracket and $c_\varphi$.** The bracket is stated, the supremum-vs-attained sub-remark is dispatched, and the universal $c_\varphi=\tfrac12$ is derived inline ("any normalized $\varphi$, concavity above the chord through $(0,0)$ and $(\tfrac12,1)$ gives $\varphi(\eta)\ge 2\eta$ on $[0,\tfrac12]$, so $c_\varphi=\tfrac12$ uniformly, attained at $\eta=\tfrac12$"). This block — ~10 lines of prose plus the bracket display — sits in §1 because the main paper's §3 then *uses* the bracket immediately to derive Theorem 2 (tent uniqueness). The placement is structurally awkward: a chunk of decision-theoretic derivation in §1 because §2–§3 already need its conclusion. ([`../../03-t0-achievable_error_floor.md`](../../03-t0-achievable_error_floor.md) lines 16–22, 53–55.)

- **Main paper §3.1 — Theorem 1.** Theorem 1's $(\mathrm{iii})\Leftrightarrow(\mathrm{i})\Leftrightarrow(\mathrm{ii})$ equivalence is stated with full atomless/general-space dichotomy and proven in a single paragraph that does all three directions. The forward direction is credited to Blackwell. The converse direction — the new piece — is buried inside the proof paragraph: *"for $a,b\in[0,1],\lambda\in[0,1]$ set $\eta=\lambda a+(1-\lambda)b$; on an atomless space, realize a cell of rate $\eta$ split into subcells of weights $\lambda,1-\lambda$ and rates $a,b$ ..."* with no headline marking it as a contribution. ([`../../03-t0-achievable_error_floor.md`](../../03-t0-achievable_error_floor.md) lines 82–86.)

- **Main paper §1.1 contributions list.** Under *"New (the contributions of this paper)"*, item 4 names "the methodology — calibration on the resolution axis" as the organising contribution. The bracket and the Theorem 1 converse are the two **mathematical** components of that methodology, but they are not separately credited there; they are folded into the *not-new* list as "the partition-restricted form of classical scoring-rule / Bayes-risk machinery." This is over-modest. The bracket with its universal $c_\varphi$, and the Theorem 1 converse, are not in the prior calibration-theory literature in this form, and the main paper's own appendix audit (Appendix A.5, Phase C2 commit) treats them as the *kernel* the Lean mechanization closes around. ([`../../03-t0-achievable_error_floor.md`](../../03-t0-achievable_error_floor.md) lines 28–37, 53–55.)

- **Main paper Appendix A — mechanization.** The 57-theorem axiom-clean Lean kernel includes `cPhi_eq_half`, `bracket_lower`, `bracket_upper`, and the full Theorem 1 forward and converse directions (`barPhi_refinement_le` and its companion `concave_of_barPhi_refinement_le`, with the Phase C2 `refining` / `sum_cellMass_refining_eq` / `cellRate_mul_cellMass_refining_sum` infrastructure). The Lean mechanization treats Facts A and B as standalone theorems with standalone names; the manuscript currently does not. This satellite closes that asymmetry — what the kernel treats as standalone theorems gets standalone publication.

- **Publication plan §4 Tier 1 O1.** The plan scopes this satellite explicitly: "Define $\bar\varphi$, $\varepsilon^*$, the bracket, and prove the universal $c_\varphi=\tfrac12$ for normalized concave scores. State Theorem 1 in its binary form as a refinement-lattice converse to Blackwell. **No GNN content** — pure decision theory. Approximately 6–10 pages."

The structural argument for extraction is therefore not "the main paper got something wrong" — it is "the main paper carries two standalone decision-theoretic results in compressed form because the GNN apparatus needs them immediately, and a refereed standalone home for those results is the cleanest way to (a) compress the main paper, (b) give the statistics-side community a vocabulary it can recognise and cite, and (c) inoculate against the most obvious referee veto on the main paper — *'these are old results from BJM / Reid–Williamson; what's new?'* — by having the bracket itself live in a venue where its decision-theoretic novelty has already been refereed and stated."

---

## 3. Five-question pre-flight check (per [`../../21-publication_plan.md`](../../21-publication_plan.md) §1.3)

### Q1. Does this construct stand alone, or does it implicitly rely on a downstream result the small piece cannot cite?

**Stands alone.** Facts A and B are self-contained statements about a normalized concave score on $[0,1]$ and a finite measurable partition of a probability space. They have no dependency on the resolution-axis transposition (which is the *interpretive* framing), the GNN-induced partitions, the simplex extension, the two-query identity, the aggregator half-chain, or any of the main paper's downstream consequences. A reader who has *only* the satellite gets full mathematical value from it — they have a peer-reviewed pointer for the bracket and for the Blackwell-converse, applicable to any partition-restricted classification setup, GNN or otherwise.

The forward references the satellite carries — "where the bracket is used" examples — are illustrative, not load-bearing. The bracket and the Theorem 1 converse stand on their own as pieces of decision theory.

### Q2. What is the one sentence the main paper will be able to write because this exists?

Two sentences, to be precise — one per main-paper section.

For main paper §1 (replacing the current ~10-line bracket-derivation block):

> *"For every normalized concave score $\varphi:[0,1]\to\mathbb R$ (Definition 2 of [Author, SPL 2026]), the partition functional $\bar\varphi$ brackets the partition-restricted Bayes risk as $\varphi^{-1}(\bar\varphi(\Pi)) \le \varepsilon^\ast(\Pi) \le \tfrac12\,\bar\varphi(\Pi)$ ([Author, SPL 2026, Theorem 3]); the upper constant $c_\varphi = \tfrac12$ is uniform across the class, attained at $\eta = \tfrac12$."*

For main paper §3.1 (replacing the current Theorem 1 statement-plus-proof block):

> *"For continuous $\varphi:[0,1]\to\mathbb R$, the partition functional $\bar\varphi$ is monotone under the refinement lattice over all finite measurable partitions and labelings if and only if $\varphi$ is concave (binary-split monotonicity is equivalent; see [Author, SPL 2026, Theorem 1] for the proof of the converse direction and a general-space density argument)."*

Two citations, both retiring substantive blocks of inline derivation, both pointing at named theorems in a venue (*Statistics & Probability Letters*) recognised by the calibration / scoring-rules community.

### Q3. Who is the hostile referee for this piece, and what is their veto?

**Primary hostile referee: Judge π** (internal devil's advocate; general adversarial). Veto criteria:

- *V-π1.* "The universal $c_\varphi=\tfrac12$ is a single-line chord argument; this is too thin for a standalone publication." Counter: the chord argument is a single line *because* of the normalisation $\varphi(\tfrac12)=1$ and the symmetry, and the contribution is articulating that an entire class of normalized concave scores has the *same* upper bracket constant, attained at the same point — a uniformity statement, not a per-$\varphi$ computation. The contribution must be defended by exhibiting (a) the calibration-theory literature's per-loss constants (BJM's $\psi$-transform, Reid–Williamson's loss-dependent calibrations), which all carry loss-dependent constants in their corresponding bounds; (b) the explicit dictionary of how the resolution-axis bracket replaces those loss-dependent transforms with one universal $\tfrac12$, which is a non-trivial benefit of the refinement-lattice framing.
- *V-π2.* "The Theorem 1 converse is folklore." Counter: the forward direction is Blackwell 1953 (and Le Cam) on the refinement lattice and is properly classical; the converse $(\mathrm{ii})\Rightarrow(\mathrm{iii})$ is *not* explicitly stated in Blackwell 1953, Le Cam 1986, or Torgersen 1991 — those works treat refinement-monotonicity as a *property* of the Bayes risk under a fixed loss, not as a *characterisation* of concave generators. A careful audit of these references is mandatory.
- *V-π3.* "The 'normalised' class is contrived to make $c_\varphi=\tfrac12$ come out clean — without normalisation, the constant is loss-dependent and the universality claim collapses." Counter: the normalisation is a choice of *units*, not a substantive restriction (any continuous symmetric concave score that vanishes at $\{0,1\}$ and is strictly positive in the interior can be rescaled to satisfy $\varphi(\tfrac12)=1$). The constant $c_\varphi=\tfrac12$ is universal *after* the units are fixed; in the un-normalised class the analogous statement is $c_\varphi=\tfrac1{2\varphi(\tfrac12)}$, which is still uniform in shape — a one-parameter universality. The note must articulate this.
- *V-π4.* "The atomless / general-space dichotomy is hand-wavey." Counter: this is exactly the dichotomy the main paper formalises (and Lean-verifies via the realizability typeclasses), and the satellite must carry the same precision — separately state the atomless version of Theorem 1 (clean equivalence), the general-space version (one direction via density of realizable splits + continuity), and the explicit Sierpiński / atomless lifting.

**Secondary referee: Judge S** (statistics-side; prior-art specialist for the BJM / Reid–Williamson / Zhang line). Veto criteria — these are the load-bearing audit for *this* satellite:

- *V-S1.* "Reid–Williamson 2011 already has this — read §6 of their paper." This is the most-likely referee response and the one to pre-empt completely. The honest answer is: Reid–Williamson 2011 develops a *unified Bregman / f-divergence* viewpoint on proper losses, in which the *conditional Bayes risk* $H(\eta)$ plays the role of our $\varphi$; their development is on the *single experiment, varying-predictor* axis (i.e., they study the $\psi$-transform between excess surrogate risk and excess $0$-$1$ risk for a *fixed* experiment). Our bracket is on the *fixed loss, varying-partition* axis. The objects coincide pointwise; the *direction of variation* is orthogonal. The satellite must articulate this distinction with a specific page-cite to Reid–Williamson where the optimization-axis vs. resolution-axis distinction becomes visible. Reid–Williamson's §3 / §4 develops the optimization-axis machinery; our bracket has no analogue there.
- *V-S2.* "BJM 2006's $\psi$-transform already controls $\varepsilon^\ast$ in terms of $\bar\varphi$ — your bracket is the $\psi$-transform in disguise." Counter: BJM's $\psi$ controls $R - R^\ast$ (excess risk of a learned predictor) in terms of $R_\varphi - R_\varphi^\ast$ (excess surrogate risk), via $\psi(R-R^\ast) \le R_\varphi - R_\varphi^\ast$ where $\psi$ is the convexification of $H^-(\eta) - H(\eta)$. The two-sided bracket of this satellite controls $\varepsilon^\ast(\Pi)$ (the *absolute* Bayes risk under the partition-induced experiment) in terms of $\bar\varphi(\Pi)$ (the *absolute* partition functional). These are different problems: BJM's controls a *gap*, ours controls an *absolute* value. The Lean kernel's `bracket_upper` and `bracket_lower` mechanise the absolute statement directly. The note must carry an explicit side-by-side §6 explaining this.
- *V-S3.* "Zhang 2004 has the same Bayes-risk inequalities." Counter: Zhang 2004 develops *statistical behaviour of classification methods based on convex risk minimization*; his Theorem 1 and Theorem 2 give convexification-based upper bounds on the $0$-$1$ excess risk in terms of the convex-loss excess risk — again, an optimization-axis result. Same distinction as V-S2.
- *V-S4.* "The DeGroot / Grünwald–Dawid generalized-entropy / Bregman-decomposition machinery already gives this." Counter: DeGroot 1962 / Grünwald–Dawid 2004 give the bijection between proper losses and concave generalized entropies, and they articulate $\sum_i p_i H(\eta_i)$ as the partition-restricted Bayes risk of the matched proper loss — that is the lower-half of our bracket *under the matched-loss specialisation*. Our bracket holds for every normalized concave $\varphi$, *not only* the one matched to $\varepsilon^\ast$ via the proper-loss correspondence — and the upper instrument $\tfrac12\bar\varphi$ has no analogue in DeGroot / Grünwald–Dawid. The note must articulate this.
- *V-S5.* "The realizability hypothesis (atomless or its density variant) is over-strong / restrictive in modern statistical applications." Counter: the atomless hypothesis is needed *only* for the converse direction of Theorem 1 — the forward direction (concave ⟹ refinement-monotone) is unconditional. For the converse, atomlessness is the natural minimal hypothesis under which arbitrary binary splits are realizable; a Sierpiński / Lyapunov argument lifts the realizability conclusion. The general-space version comes via density of realizable splits + continuity of $\varphi$. The note must give the full dichotomy and exhibit at least one concrete construction.

### Q4. What is the closest existing precedent in the literature, and how does this piece position against it?

**Closest precedents** (ranked by overlap):

1. **Reid & Williamson 2011, *Information, Divergence and Risk for Binary Experiments*, JMLR.** The single closest reference. Develops the Bregman / f-divergence / proper-loss bijection in unified form. Treats the *binary experiment* as a fixed object and asks how loss families relate via duality. Our bracket is for the *partition-induced experiment* and its image under the refinement lattice. The mathematical objects (concave generators, partition-restricted Bayes risk) are isomorphic; the *axis of variation* is different. Position: build on Reid–Williamson's analytic toolkit, transpose to the partition-lattice axis.
2. **Bartlett, Jordan, & McAuliffe 2006, *Convexity, Classification, and Risk Bounds*, JASA.** The $\psi$-transform. Optimization-axis result. Per V-S2 above.
3. **Zhang 2004, *Statistical Behaviour and Consistency of Classification Methods Based on Convex Risk Minimization*, Ann. Statist.** Similar optimization-axis convexification bound. Per V-S3.
4. **Blackwell 1953, *Equivalent Comparisons of Experiments*, Ann. Math. Statist.** The qualitative refinement-monotonicity direction. Our Theorem 1 (iii)⟹(i). We recall and credit.
5. **Le Cam 1986, *Asymptotic Methods in Statistical Decision Theory*, Springer.** Refines Blackwell with the deficiency framework. Same direction; we cite for completeness.
6. **Savage 1971, *Elicitation of Personal Probabilities and Expectations*, JASA; DeGroot 1962, *Uncertainty, Information and Sequential Experiments*, Ann. Math. Statist.** Bayes-risk / generalized-entropy correspondence under proper losses. We use the bijection; we do not claim it.
7. **Grünwald & Dawid 2004, *Game Theory, Maximum Entropy, Minimum Discrepancy, and Robust Bayesian Decision Theory*, Ann. Statist.** Unified treatment of generalized entropies as Bayes-risk functionals. We cite for the proper-loss-to-concave-score correspondence.

**Positioning** (the §6 of the satellite):

| Reference | Axis | Object controlled | Upper instrument |
|---|---|---|---|
| BJM 2006 | optimization (predictor) | excess risk $R - R^\ast$ | $\psi$-transform of $H^- - H$ |
| Reid–Williamson 2011 | optimization (predictor) | excess risk via Bregman duality | loss-dependent |
| Zhang 2004 | optimization (predictor) | excess risk via convexification | loss-dependent |
| Blackwell 1953 / Le Cam 1986 | resolution (experiment) | $H(\boldsymbol\eta)$ (qualitative) | n/a (qualitative only) |
| **This satellite** | **resolution (partition)** | **absolute $\varepsilon^\ast(\Pi)$** | **uniform $\tfrac12\,\bar\varphi(\Pi)$** |

The bracket lives at the intersection of two previously-separate lines: the Blackwell-Le Cam refinement-lattice tradition (qualitative; about more-vs-less-informative experiments) and the BJM-Reid–Williamson surrogate-calibration tradition (quantitative; about excess risk on the optimization axis). The contribution is the *quantitative absolute* statement in the *resolution-lattice* setting, with a universal upper constant.

### Q5. If rejected by the primary venue, what is the fallback venue, and what is the arXiv-first plan?

**Primary:** *Statistics & Probability Letters* (Elsevier). Estimated review time 2–4 months. Fits the note format (8–10 pages), audience (calibration / scoring-rules / Bayes-risk readers), and pace.

**Fallback 1:** *Electronic Communications in Probability* (IMS / Bernoulli Society; open access). Estimated 3–6 months. Slightly broader probability audience; the resolution-lattice framing reads cleanly as a probability note.

**Fallback 2:** *Stat* (Wiley, short-form). Estimated review time moderate.

**Fallback 3:** *Electronic Journal of Statistics* (open access, longer form). Estimated moderate. Suitable if the note grows to 12–15 pages with worked examples / a more elaborate §6 prior-art treatment.

**Defer fallback:** *Bernoulli* / *Annals of Statistics* / JMLR — those are venue targets for the main paper itself (per [`../../19-panel_verdict.md`](../../19-panel_verdict.md) §5), not for the satellite.

**arXiv-first plan.** Deposit on arXiv (`math.ST` Statistics Theory, cross-listed `stat.ML` Machine Learning, cross-listed `math.PR` Probability) at the moment of submission to SPL. The arXiv version carries a footnote *"submitted to Statistics & Probability Letters."* If SPL accepts, the arXiv version is replaced with the accepted version; if SPL declines, the arXiv version is the citable pointer until re-submission to ECP. The main paper's bibliography references the arXiv ID, replaced with the SPL DOI on acceptance.

---

## 4. Scoping decisions

### What is in

- The full definition stack — probability space, measurable labeling, partition, refinement, masses $p_i$, conditional rates $\eta_i$, partition-restricted Bayes risk $\varepsilon^\ast(\Pi)$, partition functional $\bar\varphi(\Pi)$.
- The **normalized concave score** class (continuous, symmetric, vanishing at $\{0,1\}$, $\varphi(\tfrac12)=1$, strictly increasing on $[0,\tfrac12]$), with the running members exhibited explicitly: Shannon entropy $\varphi_H(\eta) = -[\eta\log_2\eta + (1-\eta)\log_2(1-\eta)]$, rescaled variance $\varphi_{\mathrm{var}}(\eta) = 4\eta(1-\eta)$, the tent $T(\eta) = 2\min(\eta,1-\eta)$, and at least one strict-concave member that is *not* one of these (e.g., a power $\varphi_p(\eta) = (\text{const})\cdot[\eta(1-\eta)]^{1/2}$ rescaled to have $\varphi_p(\tfrac12)=1$).
- **Lemma (chord domination).** Any normalized concave $\varphi$ satisfies $\varphi(\eta)\ge 2\eta$ on $[0,\tfrac12]$ and $\varphi(\eta)\ge 2(1-\eta)$ on $[\tfrac12,1]$.
- **Theorem 1 (refinement-monotonicity ⟺ concavity).** Full equivalence (i)⟺(ii)⟺(iii), atomless statement and general-space dichotomy. Proof in full, with the realizability construction explicit.
- **Theorem 2 (universal $c_\varphi = \tfrac12$).** $c_\varphi := \sup_{\eta\in(0,1/2]} \eta/\varphi(\eta) = \tfrac12$, attained at $\eta=\tfrac12$, uniformly across the class. One-line proof from the chord lemma.
- **Theorem 3 (the bracket).** $\varphi^{-1}(\bar\varphi(\Pi)) \le \varepsilon^\ast(\Pi) \le \tfrac12\bar\varphi(\Pi)$ for every normalized concave $\varphi$ and every partition $\Pi$. Proof: Jensen via Theorem 1 for the lower endpoint; chord lemma applied pointwise then aggregated for the upper.
- **Examples worked.** Shannon, variance, tent: bracket explicit on a two-cell partition with given $(p_1,p_2,\eta_1,\eta_2)$.
- **§6 prior-art and positioning.** The table from Q4 above, expanded into prose. Explicit page-citations to Reid–Williamson 2011 §3 / §4 for the optimization-axis development; explicit citation to BJM 2006 for the $\psi$-transform; explicit citation to Blackwell 1953 for the forward direction of Theorem 1.
- **§7 mechanization note.** One paragraph: the kernel theorems `cPhi_eq_half`, `bracket_lower`, `bracket_upper`, `barPhi_refinement_le`, and the converse direction are axiom-clean in Lean 4 / mathlib v4.29.1; the standalone Lean files [`../../lean/Rigidity/Bracket.lean`](../../lean/Rigidity/Bracket.lean) and [`../../lean/Rigidity/Theorem1.lean`](../../lean/Rigidity/Theorem1.lean) provide the formalised statements; the four realizability typeclasses (`SingleCellRealizable`, `BinarySplitRealizable`, ...) provable from atomlessness via Sierpiński's theorem are the load-bearing hypotheses.
- **References.** Blackwell, Le Cam, DeGroot, Savage, Grünwald–Dawid, BJM, Zhang, Tewari–Bartlett, Reid–Williamson, Sierpiński (for the realizability remark in §7).

### What is out

- **No GNN content.** Not a word about graph neural networks, WL refinement, or any of the main paper's downstream consequences. Pure decision theory.
- **No simplex / multiclass extension.** That is the C5 (level-set floor) and the simplex-rigidity satellites' scope. This satellite is binary throughout — $\eta\in[0,1]$ everywhere.
- **No two-query identity, no aggregator half-chain, no depth/architecture theorem.** Those are the O5, O6, O8 satellites in the publication plan.
- **No quantitative excess-risk story.** The bracket controls absolute $\varepsilon^\ast(\Pi)$; the BJM $\psi$-transform controls excess risk. The note draws the distinction in §6 but does not develop the excess-risk side.
- **No new f-divergence / Bregman framing.** That is the C17 (f-divergence brackets) Exploration piece O15. This satellite is pure concave-functional / partition-bracket; the f-divergence dual is genuinely a different mathematical object.
- **No PCP / property-testing framing.** The C6 two-query identity satellite (O5) carries the property-testing reading; this satellite does not.
- **No long Lean appendix.** The §7 mechanization note is one paragraph plus a reference to the kernel files in [`../../lean/`](../../lean/); the satellite is a decision-theory note, not a Lean systems paper.

---

## 5. Risks and mitigations

| Risk | Likelihood | Mitigation |
|---|---|---|
| "Reid–Williamson 2011 §3 already has the universal upper constant for the proper-loss class — read §3." | high (this is the canonical reference and a hostile reviewer will cite it reflexively) | Read Reid–Williamson §3 / §4 carefully in Round 4 (Judge S audit); write the explicit page-cited side-by-side dictionary; demonstrate via a specific equation that the *axis of variation* is different — Reid–Williamson's results parametrise predictors at fixed experiment, ours parametrise partitions at fixed loss. |
| "The chord lemma $\varphi(\eta)\ge 2\eta$ is a one-line undergraduate exercise." | high | Embrace it — the contribution is *uniformity across the class*, not the inequality per se. The note must articulate that this is a statement *about the class of all normalized concave scores*, not about any one $\varphi$. |
| "Theorem 1 converse is folklore." | moderate | Defend with a specific search of Blackwell 1953, Le Cam 1986, Torgersen 1991 — none of them states the converse direction in this form. (The forward direction is theirs; the converse is implicit in any derivation of the Bayes risk from concavity of $H$, but is not, to our knowledge, articulated as a *characterisation of concave generators*.) The Judge S audit (Round 4) must do this literature check. |
| "The normalisation $\varphi(\tfrac12)=1$ is contrived." | moderate | State explicitly that normalisation is a choice of units (any positive scalar rescaling is admissible) and the universality is over the post-normalisation class. The un-normalised statement is $\eta/\varphi(\eta) \le 1/(2\varphi(\tfrac12))$, still uniform in shape. |
| "Atomless hypothesis is restrictive." | moderate | Give the general-space density argument explicitly; cite the Phase C2 (`refining` infrastructure) Lean mechanization where the dichotomy is verified end-to-end. |
| "The note is too thin — 6 pages is below SPL's lower bound." | low (SPL accepts 4–12 page notes routinely) | If reviewer flag arises, expand §6 prior-art table into a fuller prose section with more references; the worked examples (Shannon / variance / tent on a two-cell partition) can also expand. Target draft 0.0 is 8 pages, with room to grow to 10 if needed. |
| "Mechanization claim under-supported — only one paragraph." | low | SPL does not require mechanization; the §7 note is bonus content for the formal-methods-aware reviewer. The main paper's Appendix A is the load-bearing mechanization record; this satellite need not duplicate it. |
| Over-claim of priority on the chord lemma | low | Cite Hardy–Littlewood–Pólya 1934 and Roberts–Varberg 1973 *Convex Functions* as standard convex-analysis references for the chord-domination property; position our use of it as the *application* to the normalised score class. |

---

## 6. Cross-references

| Resource | Role in this satellite |
|---|---|
| [`../../03-t0-achievable_error_floor.md`](../../03-t0-achievable_error_floor.md) §1 (lines 13–55) | Source of C1 in context (the bracket and $c_\varphi=\tfrac12$, inline derivation block in the main paper's §1) |
| [`../../03-t0-achievable_error_floor.md`](../../03-t0-achievable_error_floor.md) §3.1 (lines 80–86) | Source of C9 in context (Theorem 1 forward and converse directions, inline proof paragraph) |
| [`../../03-t0-achievable_error_floor.md`](../../03-t0-achievable_error_floor.md) §2 (lines 57–67) | Definitions of partition, masses, rates, $\bar\varphi$, $\varepsilon^\ast$ — to be re-derived self-contained in the satellite's §2 |
| [`../../lean/Rigidity/Bracket.lean`](../../lean/Rigidity/Bracket.lean) | The Lean mechanization of $c_\varphi=\tfrac12$ (`cPhi_eq_half`), $\bar\varphi$ / $\varepsilon^\ast$ definitions, `bracket_lower`, `bracket_upper` |
| [`../../lean/Rigidity/Theorem1.lean`](../../lean/Rigidity/Theorem1.lean) | The Lean mechanization of Theorem 1, both directions |
| [`../../21-publication_plan.md`](../../21-publication_plan.md) §4 Tier 1 O1 | The publication-plan entry that scopes this satellite |
| [`../o3-chord-substitution/`](../o3-chord-substitution/README.md) | Sibling satellite — same Round 0 → Round 5 discipline, mirror layout |
| [`../../00-external.md`](../../00-external.md) | Earlier external-reviewer audit material (calibration-theory prior-art baseline) |
| [`../../19-panel_verdict.md`](../../19-panel_verdict.md) §5 | Panel verdict on main-paper venue strategy; this satellite is the citation backstop for the main paper's §1 and §3.1 |

---

## 7. Hand-off to Round 1

Executor T's task in Round 1: produce a ~8–10 page SPL-format manuscript ([`01-draft0.0-manuscript.md`](01-draft0.0-manuscript.md)) covering, in order:

1. **Title + author + abstract** (8–12 line SPL abstract, prose-first; final sentence of the abstract may include the bracket display).
2. **§1 Introduction** — the setup, the bracket, the two contributions (uniform $c_\varphi=\tfrac12$ and the Theorem 1 converse), the resolution-axis-vs-optimization-axis framing, the road map.
3. **§2 Preliminaries** — probability space, measurable labeling, partition, refinement, $\bar\varphi$, $\varepsilon^\ast$, normalized concave score class with running members listed.
4. **§3 The chord lemma** — Lemma 1: $\varphi(\eta) \ge 2\eta$ on $[0,\tfrac12]$ for any normalized concave $\varphi$, proof in one line, with the explicit chord-through-$(0,0)$-and-$(\tfrac12,1)$ display.
5. **§4 Refinement-monotonicity is concavity (Theorem 1)** — full equivalence (i)⟺(ii)⟺(iii), atomless statement, general-space dichotomy, proof.
6. **§5 The universal upper constant and the bracket (Theorems 2 and 3)** — $c_\varphi=\tfrac12$ uniformly attained; the two-sided bracket; worked examples (Shannon / variance / tent on a concrete two-cell partition).
7. **§6 Prior art and positioning** — the table from §3 Q4 above expanded into prose; explicit page-cites; the Blackwell-Le Cam / BJM-Reid–Williamson / Savage-DeGroot lines distinguished.
8. **§7 Mechanization note** — one paragraph plus references to the Lean kernel files.
9. **References** — full bibliography.

Target: 8 pages on the SPL template; up to 10 if §6 grows. Submission to SPL after Rounds 2–5 (π audit → closure → S audit → submission-ready draft) close in writing.
