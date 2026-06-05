# Adversarial Review and Path to Maturity
### "Refinement Is Concavity" — three referees, a synthesis, and a prioritized task list

> *Three reviewers were asked to audit the paper adversarially and then to be constructive. Avi Wigderson reviews the theory and complexity claims; Jure Leskovec reviews the graph-ML relevance and the empirical burden; Yann LeCun audits the framing and the premise. Each is written in their register. A synthesis and a tiered task list follow. Reviews are pointed by design; the goal is a mature paper, and the task list is the deliverable.*

---

## Review 1 — Avi Wigderson (theory, complexity, novelty)

**Summary of the contribution as I read it.** The paper claims a rigidity: refinement-monotonicity of a partition functional is equivalent to concavity of the score (Theorem 1), and the Bayes-risk integrand is the unique concave score whose two-sided bracket on the achievable error is exact (Theorem 2), so smoothness forces slack (Corollary 3). It frames this as a calibrated, locally testable "gap test" for Weisfeiler–Leman expressivity, by analogy with the PCP theorem, and derives the aggregator hierarchy and a depth characterization.

**What is genuinely good.** The smoothness–slack statement (Corollary 3) is clarifying and honest: identifying the bracket gap as the forced image of the Bayes risk's single non-differentiable point is the kind of "the limitation is intrinsic" result I value. The conceptual move from a binary verdict to a calibrated gap is ambitious and correctly aimed. The two-query identity (Proposition 6) is clean.

**Adversarial point 1 — the novelty of Theorem 2 is not established, and I suspect it is known.** This is my central concern, and it is existential for the paper's framing. The relationship between a "generalized entropy" (concave uncertainty functional) and the 0-1 Bayes risk is the subject of a mature literature you do not cite: proper scoring rules and their Savage representation; DeGroot's uncertainty functions; and crucially the **surrogate-loss / classification-calibration** theory of Bartlett, Jordan, and McAuliffe, and of Zhang. That theory studies exactly when a surrogate's excess risk bounds the 0-1 excess risk, through the **$\psi$-transform**; the statement "the 0-1 loss is the only self-calibrated loss with identity transform" is, I would wager, equivalent to your Theorem 2 modulo translation. If so, your "rigidity" is a repackaging of the $\psi$-transform being the identity only for the hinge-at-$\tfrac12$ loss. You must settle this before submission. Either Theorem 2 is new — in which case say precisely how it differs from the $\psi$-transform characterization — or it is not, in which case the paper's novelty repositions onto the GNN application, the depth characterization, and the local test, and the framing must change accordingly. **Do not submit a "fundamental rigidity" claim without this audit.**

**Adversarial point 2 — Theorem 1 is, by your own proof, Jensen and its converse.** That is fine as a lemma, but it is folklore (it is the concavity of Bayes risk in the prior, and information-monotonicity of $f$-divergences in disguise; see also Schur-concavity and majorization). Lead with Theorem 2 only if it survives point 1; otherwise the theoretical core is thin.

**Adversarial point 3 — the PCP analogy is unearned.** I am as fond of the PCP theorem as anyone, but calling your construction "the PCP of WL-expressivity" requires a **gap-amplification theorem**, and you have only a conjecture. Worse, the conjecture as stated may not type-check: the **zig-zag product is defined for regular graphs and yields regular graphs**; your aggregator-gap quantity $\Delta(G)$ is a property of an irregular, labeled graph with a task, and it is not obvious the zig-zag (or replacement) product even acts on it, let alone amplifies it. Either make the amplification statement precise with the correct graph operation and prove a lemma, or **downgrade "PCP" to an explicit analogy** and let the local test (Proposition 6–7) carry the "locally checkable" half honestly. As written, the PCP framing is the kind of borrowed gravitas a referee will resent.

**Adversarial point 4 — the complexity claims are loose.** The FPRAS-on-expanders remark names no Markov chain and no state space; an FPRAS is a theorem, not a vibe (which chain mixes, and what is it sampling — the survival coins?). Provan–Ball is **series-parallel** ($w\le 2$); the bounded-treewidth statement is the junction-tree result and should be attributed to Lauritzen–Spiegelhalter / Arnborg–Lagergren–Seese, with Provan–Ball as the reliability instance only. And the "$\#$P-hard" object must be named with a precise reduction — exactly which quantity, from which problem.

**Adversarial point 5 — what does this buy complexity theory?** A rigidity with no downstream hardness consequence, no separation, no reduction, is a characterization, not a theorem with teeth. If the simplex rigidity or the amplification gave a hardness-of-approximation statement for some natural GNN-design problem, that would be a contribution to my field. As is, it is decision theory applied to graphs.

**Recommendation.** *Weak reject as a theory paper in current form; strong potential conditional on the related-work audit (point 1) and either proving or honestly demoting the amplification (point 3).* The mathematics is correct; the question is whether it is new and whether the framing is earned. Settle the surrogate-loss question first — everything else is downstream of it.

---

## Review 2 — Jure Leskovec (graph machine learning, relevance, experiments)

**Summary.** A clean theory that turns the WL expressivity verdict into a certified achievable-error interval, recovers the GIN sum $\succ$ mean $\succ$ max hierarchy as a corollary, and characterizes when the floor is monotone in depth (refining vs contractive vs residual). A two-query local test estimates the measure cheaply.

**What I genuinely like.** The depth-monotonicity characterization is a nice lens, and the observation that residual/jumping-knowledge architectures are depth-monotone *because they take the join over layers* is a satisfying explanation for why they fix over-smoothing — that's the kind of "the theory explains a thing practitioners discovered empirically" result I want from theory. The aggregator ladder as a one-line corollary is elegant.

**Adversarial point 1 — there are no experiments, and this is sold as a GNN paper.** You make at least three falsifiable predictions — the aggregator floor ladder, the over-smoothing floor-rise on deep GCN versus flat on GIN/residual, and (implicitly) that the floor ordering predicts the GIN training-curve ordering. **None is run.** I co-wrote GIN; the learning-curve figure you lean on is graph classification on PROTEINS/NCI1/PTC/IMDB-B/REDDIT-B. Compute your bracket on those datasets and on node benchmarks (Cora, CiteSeer, PubMed, ogbn-arxiv) and show me the predictions hold. Without this, it is a math paper wearing a GNN title, and my community will not cite it.

**Adversarial point 2 — the "realized partition" is not operationally defined.** "Nodes equivalent iff the same representation up to resolution" is hand-waving. GNN embeddings are continuous; there is no clean finite partition. You need an explicit quantization (an $\varepsilon$-net on the embedding space) or to work with the soft kernel directly and report how the bracket depends on the resolution $\varepsilon$. As stated, I cannot reproduce your partition, so I cannot reproduce your floor.

**Adversarial point 3 — the floor ordering does not match trained-accuracy ordering, and you must address this.** Here is the inconvenient fact: on many *node* tasks, mean/GCN *outperforms* sum, because real graphs are homophilous and mean is a better inductive bias even though its floor is higher. Your Corollary 4 certifies $\varepsilon^\ast_{\mathrm{sum}}\le\varepsilon^\ast_{\mathrm{mean}}$, but trained accuracy often goes the other way. You must explain — clearly and early — that the floor is what is *achievable*, not what is *achieved*, and that the gap between them is governed by optimization and inductive bias, which your theory does not touch. Otherwise practitioners will (correctly) say your central prediction is empirically false, when in fact you are predicting a different quantity.

**Adversarial point 4 — homophily/heterophily is missing.** Whether WL colours align with task labels depends entirely on homophily. On heterophilous graphs the WL partition can be nearly orthogonal to the labels and your bracket is loose and uninformative. The framework should at least *diagnose* this — your bracket width is itself a homophily signal — and you should test on heterophilous benchmarks (Chameleon, Squirrel, Actor), where I expect the story to be different and more interesting.

**Adversarial point 5 — node vs graph level.** Your bracket partitions nodes; GIN's headline result is graph classification. The readout/graph-level extension is a sentence, not a section. The single most convincing experiment (predicting the GIN learning curves) *requires* the graph-level bracket. Develop it.

**Recommendation.** *Major revision.* The theory is worth publishing once it earns its GNN claim. Add the operational partition definition, run the three predictions on standard node and graph benchmarks including heterophilous ones, develop the graph-level bracket, and state the floor-versus-achieved distinction up front. Do that and I would champion it at a graph-ML venue; without experiments it belongs at a theory venue with the GNN framing toned down.

---

## Review 3 — Yann LeCun (premise, framing, the real bottleneck)

**Blunt summary.** This is a clean mathematical result about the partition-restricted Bayes risk, dressed as a theory of graph neural network power. The mathematics is fine. The framing is overclaimed, and I am not convinced it addresses the right problem.

**The premise problem — expressivity is rarely the bottleneck.** The whole WL-expressivity program measures *worst-case distinguishability*: can the architecture, in principle, tell two graphs apart. In practice, GNNs almost never fail because they cannot distinguish the relevant structures; they fail because of optimization, data, and inductive bias. A more refined measure of an idealized achievable floor is elegant, but you may be polishing a quantity that is not what limits real systems. Your own Theorem 5 admits the *realized* floor diverges from the *ceiling* — which is to say, the quantity your first four sections analyze (the ceiling) is **not** the quantity that determines performance (the realized error under SGD on finite data). You have precisely characterized the wrong thing, and then noted in §5 that it is the wrong thing.

**The overclaiming problem.** "Refinement is concavity" is Jensen's inequality, known since 1906. Calling the package "the rigid core of GNN expressivity" is grandiose. Strip the grandeur. If Theorem 2 is new (Wigderson doubts it), state it as a clean characterization of the Bayes risk among generalized entropies, with a GNN application — not as a foundational law.

**The scope problem.** Binary classification is a toy. Modern graph learning is multiclass at minimum, and increasingly regression, self-supervised, and generative. Your simplex extension — which would reach multiclass and the soft/attention architectures that actually dominate — is an unproven open problem. Until it is proven, the paper is about a setting the field has largely moved past.

**What I will credit.** The two-query local test is a genuinely computable object, and I like things that compute; if it is actually useful for diagnosing a real model, that is worth something. And the intellectual honesty of Corollary 3 — admitting the slack is a forced consequence rather than pretending it away — is the right scientific instinct; more theory papers should be that honest about their limitations.

**What would change my mind.** Show me one thing this measure tells us about a *trained* GNN that we did not already know and that *matters* — for instance, that the bracket width predicts which architectures will benefit from more data versus more capacity, or that it diagnoses a failure on a real task that practitioners misattributed. Connect the floor to something about *learning*, not just *representation*. Right now you measure what is representable; tell me something about what is *learnable*.

**Recommendation.** *Reject as "a theory of GNN power"; reconsider, reframed, as "a rigid characterization of the partition-restricted Bayes risk, with a graph-neural-network application."* Be honest about scope: an idealized floor for binary tasks, not a theory of why GNNs work or fail. Earn the relevance by connecting the measure to learning, or accept that it is a clean decision-theory result and present it as such.

---

## Synthesis — where the three converge

The reviewers disagree on venue and on how much the paper matters, but they converge sharply on four points, and convergence among a complexity theorist, a graph-ML leader, and a deep-learning skeptic is the signal to act on.

1. **The novelty of Theorem 2 is unestablished and at risk.** Wigderson names the threat precisely (surrogate-loss / $\psi$-transform theory); LeCun and Leskovec both implicitly assume it may be known. This is the single existential issue: resolve it before anything else, because it determines whether the paper is "a new rigidity" or "a clean application."

2. **The central quantity is the achievable floor, not achieved performance, and the paper conflates them.** All three raise this. The floor is what is representable in principle; trained GNNs are governed by optimization and inductive bias. The paper must state this distinction up front, not in §5, and must explain why the floor ordering (Corollary 4) need not match trained-accuracy ordering.

3. **The GNN framing is not yet earned — by experiments (Leskovec), by an honest premise (LeCun), or by a real complexity consequence (Wigderson).** Either earn it on each axis or tone it down to "a decision-theoretic result with a GNN application."

4. **The two open problems are not optional decoration — they are load-bearing.** The simplex rigidity is what reaches the architectures and tasks the field uses (Leskovec, LeCun); the gap amplification is what would earn the PCP framing and give a complexity consequence (Wigderson). Until they are proven, the corresponding claims must be stated as conjectures and the framing scoped accordingly.

The consensus *strengths* worth protecting: Corollary 3 (the smoothness–slack honesty), the depth-monotonicity characterization with the residual-as-join explanation, and the two-query local test as a computable diagnostic.

---

## Path to maturity — a prioritized task list

Tiered. **Tier 0 is blocking** — the paper should not be submitted anywhere until it is done. Tiers 1–4 mature it toward a strong paper, and they also determine the venue split.

### Tier 0 — Correctness, novelty, and honesty (blocking)

- **T0.1 — Settle the novelty of Theorem 2 against surrogate-loss theory.** Read Bartlett–Jordan–McAuliffe (classification-calibration, the $\psi$-transform), Zhang (statistical behavior of surrogate losses), Reid–Williamson, Savage's representation, and DeGroot's uncertainty functions. Determine *exactly* what in Theorems 1–2 is new versus a translation. Write a related-work section that states this precisely. This task gates the paper's entire framing.
- **T0.2 — Reposition the contribution to whatever survives T0.1.** If Theorem 2 is known: relocate novelty onto (a) the GNN gap-test framing, (b) the depth-monotonicity characterization, (c) the two-query local test, (d) the unification. If it is new: state the precise delta from the $\psi$-transform. Either way, rewrite the abstract and intro to claim only what is earned.
- **T0.3 — Make the realized partition operationally rigorous.** Replace "up to resolution" with an explicit $\varepsilon$-quantization of the embedding space (or define the measure on the soft kernel directly), and report the bracket's dependence on $\varepsilon$. Without this the floor is not reproducible.
- **T0.4 — State the floor-vs-achieved distinction in the abstract and §1.** Define clearly that the measure is the *achievable* floor (population, optimal classifier), not trained error, and that the gap is governed by optimization/inductive bias outside the theory's scope. Pre-empt the "Corollary 4 is empirically false" misreading.
- **T0.5 — Fix the complexity claims.** Name the Markov chain and state space for any FPRAS claim or remove it; attribute the treewidth result correctly (Lauritzen–Spiegelhalter / Arnborg–Lagergren–Seese; Provan–Ball for series-parallel only); name the $\#$P-hard quantity with an explicit reduction. Account honestly for the local test's end-to-end cost, including WL-colour computation and same-cell pairing, and restate "sublinear" with that cost included.

### Tier 1 — Close the theory (turns conjectures into results)

- **T1.1 — Prove the simplex rigidity.** Extend Theorem 2 to the probability simplex: show the multiclass Bayes risk $1-\max_c\eta_c$ is the unique exact functional among concave symmetric simplex scores, redoing the affine-equality argument on simplex-valued arguments. This is the result that reaches multiclass and the soft/attention architectures, and it answers Leskovec and LeCun on scope.
- **T1.2 — Make the over-smoothing floor-rise quantitative.** Prove a theorem relating the spectral gap $\lambda_2$ to the rate at which the number of $\varepsilon$-distinguishable cells shrinks (hence the floor rises) with depth, replacing the current qualitative coarsening statement. This converts §5's headline from a claim to a theorem.
- **T1.3 — Decide the PCP framing: prove or demote.** Either state a precise gap-amplification lemma with the *correct* graph operation (and verify it acts on the labeled aggregator-gap quantity — the zig-zag/replacement product likely does not apply as-is) and prove a base case, or downgrade "PCP" to an explicit analogy and let the local test carry the local-checkability claim. Address Wigderson's type-checking objection head-on.

### Tier 2 — Earn the GNN claim (experiments)

- **T2.1 — Build the measurement pipeline** that computes WL partitions and brackets (with the T0.3 quantization) on standard datasets: node — Cora, CiteSeer, PubMed, ogbn-arxiv; graph — PROTEINS, NCI1, PTC, IMDB-B, REDDIT-B; heterophilous — Chameleon, Squirrel, Actor.
- **T2.2 — Test the aggregator ladder** (Corollary 4) empirically: confirm $\varepsilon^\ast_{\mathrm{sum}}\le\varepsilon^\ast_{\mathrm{mean}}\le\varepsilon^\ast_{\mathrm{max}}$ as a *floor* ordering, and explicitly contrast it with the *trained-accuracy* ordering (which may invert on homophilous node tasks) — turning Leskovec's objection into a reported finding.
- **T2.3 — Test the depth prediction** (Theorem 5): show the realized floor rises with depth for GCN/mean and stays flat for GIN and residual/JK architectures, and correlate the onset with the spectral gap (T1.2).
- **T2.4 — Predict the GIN learning curves training-free:** with the graph-level bracket (T3.1), check that the certified floor ordering reproduces the sum/mean/max ordering in the GIN training-fit figure on the five TU datasets. This is the single most persuasive experiment for the graph-ML audience.
- **T2.5 — Validate the local test** (Proposition 6–7) against the exact bracket and report its empirical sample complexity and the realized end-to-end cost (per T0.5).

### Tier 3 — Scope and framing (close the audits)

- **T3.1 — Develop the graph-level (readout) bracket** as a full subsection so the GIN-curve experiment (T2.4) is in scope.
- **T3.2 — Add a homophily/heterophily section:** show the bracket width is itself a homophily diagnostic, and report the heterophilous-benchmark behavior from T2.1.
- **T3.3 — Connect the floor to learning (the LeCun challenge):** test whether the bracket width predicts something about *learnability* — e.g., which architectures benefit from more data versus more capacity, or which trained models leave the most floor on the table. Even a modest positive result here changes the paper's standing with the deep-learning audience.
- **T3.4 — Reframe abstract/intro** to the scope that survives T0–T1: a rigid characterization of the partition-restricted Bayes risk (or its precise novel delta), with consequences for GNN expressivity, honestly distinguishing floor from achieved error, and claiming the simplex/multiclass reach only once T1.1 is done.

### Tier 4 — Positioning and venue

- **T4.1 — Split the paper along the reviews' fault line.** The reviewers point to a natural division: a *theory paper* (the rigidity, the complexity dichotomy, the simplex result — for a theory venue, addressing Wigderson) and an *empirical/architecture paper* (the depth characterization, the experiments, the local test as a diagnostic — for a graph-ML venue, addressing Leskovec). Keep each honest to its audience; do not send the experiment-free version to a graph-ML venue or the framing-heavy version to a theory venue.
- **T4.2 — If the surrogate-loss comparison is favorable, position against Le Cam / Blackwell** comparison-of-experiments explicitly, which strengthens the theory paper's lineage and pre-empts the "this is known" reflex.

---

### The one-line verdict from each chair

- **Wigderson:** *Settle the surrogate-loss novelty question and either prove or demote amplification; then it may be a theory paper with teeth.*
- **Leskovec:** *Run the predictions on real graphs and define the partition operationally; then I will champion it.*
- **LeCun:** *Stop overclaiming, admit you measure the achievable floor and not performance, and connect it to learning — or present it honestly as a clean decision-theory result.*

The critical path is **T0.1 → T0.2/T0.4 → T1.1 → T2.\* → T4.1**: resolve the novelty, reframe honestly, prove the simplex result that reaches the real setting, run the experiments that earn the GNN claim, and split for the right venues. Tasks T0.\* are blocking; the paper is not ready to submit until they are complete.

---

*Adversarial review with constructive intent. The mathematics in the paper is correct; the work to maturity is establishing novelty against the right literature, scoping the claims honestly, proving the two load-bearing extensions, and earning the graph-ML framing with experiments.*
