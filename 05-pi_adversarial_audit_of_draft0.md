# PI Adversarial Audit of Draft 0
### *"The Achievable-Error Floor of Graph Neural Networks" (`03-t0-achievable_error_floor.md`)*

> *Audit voice: senior PI reading the manuscript with a red pen, two days before the lab sends it out. The mathematics is the priority; framing comes second; presentation third. Every claim is treated as guilty until verified. Severity rating per finding: **C** (critical — blocks correctness or submission), **M** (major — must be fixed for the paper to be honest), **m** (minor — polish). At the end: a verdict and a prioritized fix list.*

---

## 0. Executive verdict

Draft 0 is a **substantial improvement over Draft 01** on the four axes the [02 review](02-adversarial_review_and_task_list.md) flagged. Tasks T0.1–T0.5 have been engaged genuinely, not papered over: the prior-work audit in §1.2 is honest, the $\Pi_\varepsilon$ definition is operational, the floor-vs-achieved distinction is loud in the abstract and §1 and §5, and the complexity claims have been corrected (FPRAS downgraded to "suggests, do not claim"; Provan–Ball attributed correctly as a series-parallel instance; #P-hardness localized to the lossy variant). Corollary 4's caveat is the kind of paragraph that pre-empts a graph-ML reviewer.

**But the draft is not yet correct.** I have two findings rated **C** and four rated **M**. The most serious is a **mathematical error in the Theorem 5 / §6 depth-monotonicity argument at finite $\varepsilon$**: GIN injectivity preserves *exact* equivalence but does *not* preserve $\varepsilon$-grid-cell membership, so $\Pi_\varepsilon^{(L+1)}\succeq\Pi_\varepsilon^{(L)}$ is *false in general* and the headline architecture-sorting story is only valid in the WL ($\varepsilon\to 0$) limit. The paper builds §5–§6 on this and asserts it as a theorem. This must be fixed before any version goes anywhere.

The second critical finding is that **Theorem 5's "if and only if" is mis-quantified**: the converse direction requires "for every labeling," but the paper invokes it operationally on a single task. The honest statement is one direction (refinement chain $\Rightarrow$ floor non-increasing) plus a contrapositive remark.

Beyond these two, four **M**-level issues: the **"lossy/soft-kernel bracket" is referenced in §7 without ever being defined** (so the entire $\#$P-hardness / treewidth dichotomy is a black box); the **operational $\Pi_\varepsilon$ has a grid-orientation dependence** that the "qualitative conclusions are independent of the particular grid" sentence quietly elides; the **simplex paper [`04`](04-t1_1_simplex_rigidity.md) supersedes Open Problem 1** but the draft still lists it as open and conflates "multiclass labels" with "soft cell assignments"; and the **Theorem 2 proof is correct but suboptimal** (single-cell partitions alone pin $\varphi=T$; the two-cell argument is redundant).

The remaining items are stylistic. Final verdict at the bottom.

---

## 1. Mathematical findings, in priority order

### 1.1 **[C-1] The finite-$\varepsilon$ refinement-chain argument is false for GIN, GCN, and JK alike**

This is the most serious finding. §6 fixes a resolution $\varepsilon$, defines $\Pi_\varepsilon^{(L)}$ as the grid-cell partition of depth-$L$ embeddings, states Theorem 5 in those terms, and then sorts architectures by whether $(\Pi_\varepsilon^{(L)})_L$ is a refinement chain. The sorting rests on three sub-claims, *all three of which are false at finite $\varepsilon$*:

- *GIN claim.* "Injective aggregation never merges and the WL step splits, so $\Pi^{(L+1)}\succeq\Pi^{(L)}$." This is true for the **WL partition** (the partition by *exact equality* of representations), because an injective update preserves exact equivalence relations. **It is false for $\Pi_\varepsilon$ at any $\varepsilon>0$.** Concrete counterexample: take $h^{(L)}(x)=0$, $h^{(L)}(y)=1.5\varepsilon$, so $x$ and $y$ are in different grid cells at depth $L$. An injective MLP at the next layer can map these to $h^{(L+1)}(x)=0.4\varepsilon$ and $h^{(L+1)}(y)=0.6\varepsilon$, both in the cell $[0,\varepsilon)$. Now $x,y$ are in the *same* cell at depth $L+1$ and different cells at depth $L$, so $\Pi_\varepsilon^{(L+1)}\not\succeq\Pi_\varepsilon^{(L)}$. Injectivity preserves the equivalence relation "equal embedding," not the equivalence relation "same $\varepsilon$-grid cell." The grid quantization breaks the algebra.

- *JK / residual claim.* "$\Pi_\varepsilon^{(L)}=\bigvee_{\ell\le L}\Pi_\varepsilon^{(\ell)}$, monotone by construction." For the **WL** join-over-layers this is fine. For the **$\varepsilon$-grid-quantized** concatenation it is *not*: two nodes whose concatenated representation $(h^{(1)},\ldots,h^{(L)})$ falls in the same product grid cell need not have agreed in the same per-layer grid cells; the product grid in $\mathbb{R}^{dL}$ is finer along each axis than any layer-individual grid, but a concatenated cell can straddle (in the per-layer projection) what would have been a layer-grid boundary if you re-quantized after projecting. The clean lattice identity $\bigvee$ holds only in the exact-equality, $\varepsilon\to 0$ limit.

- *GCN claim.* "$\Pi_\varepsilon^{(L)}$ coarsens past a critical depth." The qualitative picture (over-smoothing) is right and is the over-smoothing literature's content. But the paper invokes Theorem 5 to say "the floor rises iff the partitions are not a refinement chain," and *coarsening is not the same as not-refining*. In over-smoothing, generic pairwise distances shrink toward zero; the order in which two pairs cross grid boundaries depends on the embeddings' initial positions and the grid alignment, and there is no reason the partition sequence is a *coarsening chain* (it can interleave). The sequence might be neither refining nor coarsening — just changing — yet the floor still rises on average.

**What is actually true.** All three sub-claims are correct for the **WL/exact-equality partition** (call it $\Pi^{(L)}_{\mathrm{WL}}$): for an injective GIN it strictly refines until stability, for a residual/JK architecture it is the join of layer WL-partitions, and for a contracting GCN it eventually collapses to a coarse partition. The right framing is therefore:

- State Theorem 5 about $\Pi^{(L)}_{\mathrm{WL}}$ (or the exact-equality partition of the architecture's continuous embeddings), not about $\Pi_\varepsilon^{(L)}$.
- Treat $\Pi_\varepsilon^{(L)}$ as an *estimator* of $\Pi^{(L)}_{\mathrm{WL}}$ whose discrepancy is bounded by an embedding-distance-to-grid gap (e.g., for $\varepsilon$ smaller than the minimum pairwise embedding distance, the two coincide; otherwise the $\varepsilon$-partition is a coarsening of the exact partition by Lipschitz-type bounds).
- Make §6's architecture sorting a statement about the *ideal* refinement chain at the WL level, with a separate paragraph (or proposition) bounding how this transfers to the realized $\varepsilon$-partition.

**This is not a cosmetic fix** — it touches the abstract ("characterization of when the floor is monotone in network depth (it is, exactly for *refining* architectures…)") and the §2 promise that $\Pi_\varepsilon\to\Pi_{\mathrm{WL}}$ as $\varepsilon\to 0$ on which the whole §6 chain implicitly relies. The right rewrite is to *separate the two partitions cleanly* throughout §5–§6, prove the architecture story at the WL level, and add a quantitative bridge to $\Pi_\varepsilon$ as a small lemma or as part of Open Problem 2.

### 1.2 **[C-2] Theorem 5's "if and only if" is mis-quantified**

> *"The realized floor $\varepsilon^\ast(\Pi_\varepsilon^{(L)})$ is non-increasing in $L$ if and only if $(\Pi_\varepsilon^{(L)})_L$ is a refinement chain. (Theorem 1 along the depth sequence.)"*

The **forward** direction (refinement chain $\Rightarrow$ floor non-increasing) is Theorem 1 along the depth axis, for *any* labeling. Good.

The **converse** direction (floor non-increasing $\Rightarrow$ refinement chain) requires "non-increasing *for every labeling*". For a *fixed* task, it is false. Quick counterexample, $X\sim\mathrm{Unif}\{1,2,3,4\}$, $f=(0,1,1,0)$:

- $\Pi^{(1)}=\{\{1\},\{2,3\},\{4\}\}$: cell rates $0,1,0$; $\varepsilon^\ast=0$.
- $\Pi^{(2)}=\{\{1,4\},\{2,3\}\}$: cell rates $0,1$; $\varepsilon^\ast=0$.

Floor is non-increasing ($0\le 0$), but $\Pi^{(2)}\not\succeq\Pi^{(1)}$ (the cell $\{1,4\}$ straddles two cells of $\Pi^{(1)}$). The task happens to be "easy enough" that even a non-refining transition does not raise the floor.

Re-label as $f=(0,0,1,1)$: $\varepsilon^\ast(\Pi^{(1)})=1/4$ but $\varepsilon^\ast(\Pi^{(2)})=1/2$, so the floor *does* rise on this labeling. The right statement is "for every labeling, non-increasing $\Rightarrow$ chain" (contrapositive: not-chain $\Rightarrow$ some labeling makes it strictly increase). This is correct but is a *different* quantifier from what the paper writes.

**Fix.** Restate as:

> Theorem 5 (depth-monotonicity, two directions). *(a) If $(\Pi^{(L)})_L$ is a refinement chain, then for every concave score and every labeling the floor is non-increasing in $L$. (b) Conversely, if for **every** labeling the floor is non-increasing in $L$, then $(\Pi^{(L)})_L$ is a refinement chain.*

Then add a remark that on a *fixed* task only direction (a) is operative, and the diagnostic value is contrapositive: observing the floor rise on a task certifies that the depth sequence is not a refinement chain there. This is honest and still useful.

This finding is **C** because the paper uses Theorem 5 as the conceptual hinge of §6 ("the criterion sorts the architectures") and the iff direction is what gives it its bite. Without re-quantification it is wrong as stated.

### 1.3 **[M-1] The "lossy/soft-kernel bracket" is never defined**

§7's complexity paragraph reads:

> "Hardness arises only for the *lossy/soft-kernel* variant, in which independent message-survival makes the partition random and the expected bracket a sum over exponentially many outcomes: this contains, as a special case, the two-terminal network-reliability probability, which is $\#$P-complete… On **bounded-treewidth** graphs the lossy bracket is computable exactly in $O(n\,k^{w+1})$ by the junction-tree algorithm…"

There is no prior definition in the paper of "the lossy variant," "independent message-survival," or "the lossy bracket." A reader has no way to verify the $\#$P-hardness reduction (which random object is the WL partition? which event corresponds to two-terminal connectivity?), or the junction-tree complexity (over what graphical model are we doing belief propagation?), or even what the *deterministic* counterpart to "lossy" is.

This is a real flaw, not just a definitional omission. The whole computational dichotomy of §7 hangs on it: "deterministic bracket = polynomial; lossy bracket = $\#$P-hard with a treewidth exception." If "lossy bracket" cannot be pinned down, the dichotomy cannot be assessed.

**Fix.** Either:
- *(preferred)* Add a §7.0 micro-section: "Definition. The *lossy bracket* is $\mathbb{E}_\Pi[\varepsilon^\ast(\Pi)]$ (or the corresponding bracket endpoints), where each edge of $G$ is independently retained with probability $q\in[0,1]$ before WL is run; equivalently, each message of round $\ell$ survives independently with probability $q$." Then state the reduction precisely: two-terminal network reliability on $(G,s,t)$ is the special case where the label is the indicator of $s$-$t$ connectivity and $q$ is the per-edge retention. Then $\#$P-hardness follows directly from Provan–Ball.
- *(if you don't want to develop it here)* Cut the lossy paragraph entirely and limit §7 to the deterministic bracket and the local test. The paper survives, and you do not have to defend an undefined object.

I would do the latter for Draft 0 — the lossy variant is genuinely a separate paper. Keep §7 to what you have built.

### 1.4 **[M-2] Grid-orientation dependence quietly elided in §2**

> *"We therefore fix a nested dyadic family of grids of side $\varepsilon>0$ … by Theorem 1 the floor is non-decreasing in $\varepsilon$, so qualitative conclusions are independent of the particular grid."*

Theorem 1 says the floor is non-decreasing as the partition *coarsens*. As $\varepsilon$ grows on a *fixed* grid family, the partition does coarsen (and the floor does rise non-strictly). That is a defensible monotonicity-in-$\varepsilon$ statement.

But the sentence "qualitative conclusions are independent of the particular grid" is a different statement and does *not* follow from Theorem 1. Two different grids of the same $\varepsilon$ (different origins, different orientations) produce *different* partitions; the floor depends on the grid, not just on $\varepsilon$. Theorem 1 says nothing across grids. For example, a single pair of nearby embeddings can land in the same cell under one grid and adjacent cells under a shifted one, changing the floor.

**Fix.** Either replace the sentence with the correct one ("monotone in $\varepsilon$ for any fixed grid family"), or **upgrade** the construction to a grid-invariant one — average over a small group of grid translations, or use a Voronoi partition of a fixed $\varepsilon$-net (with the orientation absorbed into the net), and state that the partition is well-defined up to the net's symmetry group. The latter is more honest if you want to claim a canonical $\Pi_\varepsilon$.

This is **M** rather than **C** because the qualitative story is robust: any reasonable grid family will give similar conclusions, and the dependence on orientation is bounded by the cell volume. But the current sentence is technically false and a referee will catch it.

### 1.5 **[M-3] Open Problem 1 conflates two unrelated extensions, and is partially superseded by `04`**

§8 frames the simplex rigidity as the route to "multiclass tasks and to the architectures the field now uses." This conflates two extensions that should be separated:

- **(a) Multiclass labels.** Labels in $\{1,\ldots,k\}$ instead of $\{0,1\}$. The conditional class distribution $\boldsymbol\eta\in\Delta^{k-1}$. This is the simplex you described, and [`04-t1_1_simplex_rigidity.md`](04-t1_1_simplex_rigidity.md) appears to resolve it: the multiclass Bayes risk $1-\max_c\eta_c$ is the unique exact functional among continuous vertex-vanishing scores. So this half is **done** (modulo audit, see §1.7 below), and Open Problem 1 should be updated to reference Draft `04`.

- **(b) Soft cell assignments.** GAT, differentiable pooling, attention — these architectures do not induce a hard partition but a probability over cells per input (a "soft kernel"). The relevant simplex here parameterizes a distribution over *cells*, not over *classes*. Establishing rigidity for soft kernels requires a separate construction — averaging the bracket over the kernel, or lifting to a stochastic partition — that the multiclass-label rigidity does not deliver. Draft `04` §6 hand-waves this with "Combined with the soft-kernel (T9) lifting…" but T9 is **nowhere in the [02 task list](02-adversarial_review_and_task_list.md)** and is not defined anywhere I can see. So (b) remains genuinely open.

**Fix.** Split Open Problem 1 into two cleanly-stated extensions: multiclass labels (resolved by `04`, cite and integrate), and soft cell assignments (still open, do not over-claim reach to attention / GAT / transformers). Add the second to the open-problem list as its own bullet.

### 1.6 **[M-4] The Theorem 2 proof is correct but takes a redundant detour**

The proof reads:
> "Conversely, exactness forces $\varepsilon^\ast(\Pi)=G(\bar\varphi(\Pi))$ for some $G$; single-cell partitions give $G=\varphi^{-1}$; two-cell partitions give … so $\varphi^{-1}$ is affine; … this gives $\varphi^{-1}(t)=t/2$, i.e. $\varphi=T$."

The **single-cell step alone forces $\varphi=T$**. Exactness means both endpoints coincide:
$$\varphi^{-1}(\bar\varphi(\Pi))\;=\;c_\varphi\,\bar\varphi(\Pi)\qquad\text{for every }\Pi.$$
On a single cell of rate $\eta\in[0,\tfrac12]$, $\bar\varphi(\Pi)=\varphi(\eta)$ and $\varepsilon^\ast(\Pi)=\eta$. The two endpoints become $\eta=c_\varphi\varphi(\eta)$ for every $\eta\in[0,\tfrac12]$, so $\varphi(\eta)=\eta/c_\varphi$ on $[0,\tfrac12]$. Normalization $\varphi(\tfrac12)=1$ forces $c_\varphi=\tfrac12$, hence $\varphi(\eta)=2\eta$ on $[0,\tfrac12]$, and symmetry gives $\varphi=T$.

The two-cell affine-equality argument is not wrong, but it is **unnecessary** for the proof and adds a step the reader has to verify (and a quantifier — "for all $u,v\in[0,1]$ and $p_1+p_2=1$" — that should be justified by surjectivity of $\varphi$ on $[0,\tfrac12]$).

**Fix.** Replace the converse direction of the Theorem 2 proof with the four-line single-cell argument above. The two-cell version is the natural one in higher dimensions (where single-cell information is no longer enough, because $\varphi$ is not a function of $R$); keep the two-cell argument in the **simplex paper** where it earns its keep, and use the single-cell version here. Cleaner exposition, same content.

This is **M** because it is a proof-style issue, not a correctness one. But it matters because Theorem 2 is the headline rigidity statement; the proof should be the tightest the paper can produce.

### 1.7 **[m-1] The "Pi_WL is the ε→0 limit on discrete colours" sentence is sloppy**

> *"Then $\Pi_\varepsilon$ is a genuine partition, it is monotone — coarser as $\varepsilon$ grows — and $\Pi_{\mathrm{WL}}$ is the $\varepsilon\to0$ limit on discrete colours."*

WL colours *are* discrete equivalence classes. The "$\varepsilon\to 0$ limit" of $\Pi_\varepsilon$ on continuous embeddings is the partition by *exact equality* of the embeddings, not the WL partition. They coincide *only* if the GNN embeds WL-equivalent nodes to identical points and WL-distinguishable nodes to distinct points. For real (finite-width) GINs this is approximate, not exact.

**Fix.** Replace with: "for a GNN that is WL-faithful (mapping WL-equivalent nodes to identical embeddings), $\Pi_\varepsilon=\Pi_{\mathrm{WL}}$ for all sufficiently small $\varepsilon$; in general $\Pi_\varepsilon$ is a coarsening of the exact-embedding partition by Lipschitz arguments." This is honest and admits the gap that real implementations will have.

### 1.8 **[m-2] $c_\varphi=\tfrac12$ is universal for normalized concave scores; the notation $c_\varphi$ hides this**

For any normalized concave score (concave on $[0,1]$, $\varphi(0)=0$, $\varphi(\tfrac12)=1$), concavity above the chord through $(0,0)$ and $(\tfrac12,1)$ gives $\varphi(\eta)\ge 2\eta$ on $[0,\tfrac12]$, so $\eta/\varphi(\eta)\le\tfrac12$ on $(0,\tfrac12]$, attained at $\eta=\tfrac12$. So $c_\varphi=\tfrac12$ for *every* normalized score in the class you defined.

The upper bracket endpoint is therefore *always* $\bar\varphi/2$. The score-dependence of the upper bound lives entirely in $\bar\varphi$, not in $c_\varphi$. The current notation $c_\varphi$ suggests a score-dependent constant when in fact it is a fixed constant whose value is forced by the normalization.

**Fix.** Add one sentence after the bracket display in §1/§3.2: "For any normalized concave score, $c_\varphi=\tfrac12$ by concavity above the chord; the upper endpoint is therefore $\bar\varphi(\Pi)/2$, and the variance member sharpens the *lower* endpoint relative to entropy via $\varphi^{-1}_{\mathrm{var}}\ge\varphi^{-1}_H$ at equal $\bar\varphi$." Cleans up §3.3's "variance member gives a tighter upper bound" sentence (the upper bound is uniformly $\bar\varphi/2$; the tighter instrument is on the lower endpoint, or equivalently on $\bar\varphi$ itself via the pointwise domination $4\eta(1-\eta)\le H(\eta)$).

### 1.9 **[m-3] Proposition 6 proof switches normalization conventions silently**

§2 defines the variance member as the **normalized** $4\eta(1-\eta)$. The proof of Prop 6 writes:
> "The variance member has upper constant $c=2$ and bracket $[\tfrac12(1-\sqrt{1-4\bar\varphi_{\mathrm{var}}}),\,2\bar\varphi_{\mathrm{var}}]$ with $\bar\varphi_{\mathrm{var}}=\mathbb E[\mathrm{Var}]=p_{\mathrm{dis}}/2$"

The $c=2$ and $\bar\varphi_{\mathrm{var}}=p_{\mathrm{dis}}/2$ relations use the **unnormalized** $\varphi(\eta)=\eta(1-\eta)$ (with $\varphi(\tfrac12)=1/4$, $c_\varphi=2$). The final answer $\varepsilon^\ast\le p_{\mathrm{dis}}$ is correct either way, but the convention switch is a foot-gun for a careful reader.

**Fix.** Use the normalized convention everywhere ($\varphi=4\eta(1-\eta)$, $c_\varphi=\tfrac12$, $\bar\varphi=2p_{\mathrm{dis}}$, upper endpoint $\bar\varphi/2=p_{\mathrm{dis}}$), or use the unnormalized one everywhere — but commit. Half a line saved, several seconds of reader reconciliation saved per proof.

### 1.10 **[m-4] "Attention refines if it sharpens and contracts if it uniformizes" is not a theorem**

§6's attention paragraph is a heuristic ("data-dependent and measurable by the bracket"). That is acceptable as a forward pointer, but the §6 introduction sets up Theorem 5 as the "criterion that sorts the architectures." The attention case is not sorted — it is left for the bracket to measure post-hoc. Be explicit that attention is *not classified by Theorem 5*, only diagnosed by the bracket, so that the three-axis taxonomy of the §6 closer is not over-promising.

**Fix.** One sentence: "Attention is not classified statically by Theorem 5; the bracket diagnoses its regime per task and depth." Then the three-axis classification of the §6 closer reads honestly as "for the architectures Theorem 5 classifies; attention is reduced to a measurement."

---

## 2. Conceptual / honest-accounting findings

### 2.1 **[M-5] Corollary 4 needs an explicit "idealized aggregator" qualifier**

The corollary states $\varepsilon^\ast(\Pi_{\mathrm{sum}})\le\varepsilon^\ast(\Pi_{\mathrm{mean}})\le\varepsilon^\ast(\Pi_{\mathrm{max}})$. The chain holds when the partitions are the *finest* induced by each aggregator with an *injective update* — i.e., the multiset partition vs the distribution partition vs the support partition. A specific GCN at fixed weights induces a *coarsening* of the mean partition (because the linear layer can collapse information further), and the claim "GCN $\succeq$ a max GNN" is *not* a corollary of Theorem 1 — it requires comparing two specific architectures' realized partitions, which is a stronger claim.

The §5 prose alludes to this ("Sum is injective and induces the finest $\Pi_{\mathrm{sum}}$"), but the corollary's reach should be made explicit: it orders the *information-theoretic upper bounds* of the three aggregator classes, not arbitrary trained-architecture instances. The §5 "Caveat (floor, not achieved)" paragraph addresses the trained-accuracy direction but not the *induced-partition* direction (a real GCN's realized partition can be far coarser than $\Pi_{\mathrm{mean}}$, so the bound on the GCN's floor is weaker than the corollary suggests).

**Fix.** Add one clause: "Here $\Pi_{\mathrm{sum}},\Pi_{\mathrm{mean}},\Pi_{\mathrm{max}}$ denote the finest partitions induced by an injective-update GNN with the respective aggregator (the WL-style information-theoretic ceiling for each class); a specific GNN's realized partition is at most as fine."

### 2.2 **[m-5] §5's PCP-as-analogy paragraph is now honest, but §1's repetition is borderline**

§1 paragraph 4 reads:
> *"This is, in spirit, the relationship a PCP bears to satisfiability […], with the caveat (§8) that we have the locally-checkable half but not yet a gap-amplification theorem, so we use the PCP framing as an analogy and not a claim."*

This is fine. But the next-to-last paragraph of §5 still says: "This is the calibrated, locally checkable gap version of the WL test." That sentence on its own re-borrows the PCP gravitas without the caveat being reattached. Either re-attach the "analogy not a claim" qualifier in §5 too, or drop the §5 sentence and let §1's careful version be the only place the PCP framing appears.

### 2.3 **[m-6] The "$\sigma$-algebra" gloss in §1.1**

> *"… the achievable floor as a function of the resolution — the partition (σ-algebra) the model can access — over the refinement lattice."*

A partition does generate a $\sigma$-algebra, but for *finite* partitions (which this paper restricts to) the $\sigma$-algebra is just the power set of cells — the gloss adds nothing. If you want the $\sigma$-algebra language, commit to it (you'll need to discuss measurability, and arguably reach for Blackwell's experiment-comparison framework where $\sigma$-algebras genuinely matter). If you don't, drop the parenthetical — it is decorative.

---

## 3. Cross-document consistency

### 3.1 **Coordination with [`04-t1_1_simplex_rigidity.md`](04-t1_1_simplex_rigidity.md)**

The simplex paper is a separate manuscript that resolves the *multiclass* half of Open Problem 1 cleanly. It should be either:

- **integrated** into the main draft as a §3.4 (post-Theorem 2, extending the rigidity to $k$ classes), with the simplex IVT-on-connected-domain step and the worked $k=3$ example imported, **or**
- **kept separate** as a companion paper, with the main draft's Open Problem 1 explicitly citing it and reducing to "the soft-kernel extension remains open."

The current state — Open Problem 1 of Draft 0 lists the simplex rigidity as conjecture, while `04` claims to prove it — is internally inconsistent. Pick one.

**Note** that `04`'s §6 ("via the soft-kernel lifting (T9)") forward-references a task `T9` that is not in the [02 task list](02-adversarial_review_and_task_list.md). Before integrating `04`, either define T9 (the soft-kernel construction) or remove the forward-reference and state clearly that soft kernels are a separate open problem.

### 3.2 **Improvements relative to [`01-refinement_is_concavity_paper.md`](01-refinement_is_concavity_paper.md)**

For balance, what Draft 0 does *right* relative to Draft 01:

- **Honest novelty audit (§1.2)** — the BJM / Zhang / Reid–Williamson lineage is acknowledged, and the contribution is repositioned as the *resolution-axis transposition*. This is the single biggest improvement and addresses Wigderson's adversarial point 1 head-on.
- **Operational $\Pi_\varepsilon$ (§2)** — gives the partition a definition you can reproduce, addressing Leskovec's point 2 (modulo the grid-orientation issue, §1.4 above).
- **Floor-vs-achieved framing in the abstract and §1** — pre-empts the "Corollary 4 is empirically false" misreading, addressing both Leskovec and LeCun.
- **PCP downgraded to analogy, lossy / FPRAS claims honestly accounted** — addresses Wigderson's points 3–4. The §7 paragraph "we note … but do not claim one, as we have not exhibited the chain or proved its mixing" is exactly the register a referee will respect.
- **Corollary 4's "Caveat (floor, not achieved)" paragraph** — the loudest, clearest pre-emption in the paper. Worth keeping verbatim.

The mathematics that *was* correct in Draft 01 (Theorems 1, 2, Corollary 3, Proposition 6) remains correct in Draft 0. The new errors introduced by the §2 quantization and §6 architecture sorting at finite $\varepsilon$ are flaws of the *improvement attempt*, not of the original theorems.

---

## 4. Tier-0 coverage assessment

Verbatim against the [02 task list](02-adversarial_review_and_task_list.md):

| Task | Required | Draft 0 status | My grade |
|---|---|---|---|
| T0.1 | Settle novelty vs surrogate-loss theory | §1.2 explicitly addresses BJM, Zhang, Reid–Williamson, Savage, DeGroot, Grünwald–Dawid; states the partition-bracket counterpart explicitly | **A** |
| T0.2 | Reposition contribution to what survives T0.1 | §1.1 has a "what is new / what is not" structure and the abstract is rewritten accordingly | **A** |
| T0.3 | Operationalize the partition | §2 introduces $\Pi_\varepsilon$ via dyadic grids | **B** (grid-orientation issue, §1.4) |
| T0.4 | Floor-vs-achieved distinction in abstract / §1 | Stated in abstract, §1, and prominently in §5's caveat box | **A** |
| T0.5 | Fix complexity claims | FPRAS downgraded; Provan–Ball cited as series-parallel instance; treewidth attributed to Lauritzen–Spiegelhalter / Arnborg–Lagergren–Seese; local-test cost honestly accounted | **B+** (lossy variant still undefined, §1.3) |

Tier-0 is **substantially complete**. The remaining gaps (one **C**, one **M** on the T0 path, plus the §6 finite-$\varepsilon$ flaw which is logically *not* in T0 but is the most serious finding in the audit) are concrete and fixable.

---

## 5. What is good — worth protecting

- **Corollary 3 and its surrounding prose** ("the moment smoothness is demanded, exactness is lost, by the same phenomenon that makes the $\psi$-transform nontrivial"). This is the most insightful sentence in the paper.
- **The Corollary 4 caveat box.** Exactly the right register for a graph-ML audience.
- **The "Honest cost accounting" paragraph in §7.** Names the linear WL pass and the bucketing pass, claims only the label-complexity saving. Refereeable.
- **The "we do not claim Theorem 2 as a new decision-theoretic fact" sentence in §1.2.** The single biggest credibility-saver in the manuscript.
- **The §8 "we caution that the standard amplification primitive (the zig-zag/replacement product) is defined for regular graphs and may not act on the labeled, irregular aggregator-gap quantity as-is" caveat.** Addresses Wigderson's type-checking objection precisely.

---

## 6. Prioritized fix list (what I want to see in Draft 0.1)

**Must (blocks submission anywhere):**

1. **[C-1] Rewrite §5–§6 to work at the WL/exact-equality level**, not at the $\varepsilon$-grid level. Either restate Theorem 5 about $\Pi^{(L)}_{\mathrm{WL}}$ and demote $\Pi_\varepsilon$ to an estimator (with a small lemma bounding the discrepancy), or restrict the architecture-sorting claims to the $\varepsilon\to 0$ regime explicitly. The current finite-$\varepsilon$ statement is mathematically false for GIN and for JK, and overstated for GCN.
2. **[C-2] Re-quantify Theorem 5** into "(a) chain $\Rightarrow$ monotone for every labeling" (one direction) and "(b) monotone for every labeling $\Rightarrow$ chain" (converse), with a remark that on a fixed task only (a) is operative.

**Should (must be fixed for the paper to be honest):**

3. **[M-1] Either define the lossy bracket precisely or remove the lossy paragraph from §7.** My recommendation: remove it for Draft 0; develop it in a companion.
4. **[M-2] Replace the "qualitative conclusions are independent of the particular grid" sentence** with a correct monotonicity-in-$\varepsilon$ statement, or upgrade to a grid-invariant Voronoi/symmetrized partition.
5. **[M-3] Split Open Problem 1** into (a) multiclass labels (resolved by `04`, cite) and (b) soft cell assignments (still open; do not claim reach to attention).
6. **[M-4] Tighten the Theorem 2 proof** to the single-cell argument.
7. **[M-5] Add the "idealized aggregator" qualifier to Corollary 4** to separate it from claims about specific trained architectures' realized partitions.

**Nice (polish):**

8. **[m-1] Replace "$\Pi_{\mathrm{WL}}$ is the $\varepsilon\to 0$ limit"** with the WL-faithful conditional version.
9. **[m-2] Add the "$c_\varphi=\tfrac12$ universally" remark** to clean up §3.3.
10. **[m-3] Pick one variance normalization** and use it everywhere.
11. **[m-4] Flag attention as not-Theorem-5-classifiable** in §6.
12. **[m-5] Re-attach the "PCP as analogy" caveat in §5** or remove the §5 PCP sentence.
13. **[m-6] Drop the parenthetical "(σ-algebra)" in §1.1** unless committing to that language elsewhere.

**Cross-document:**

14. **Decide whether to integrate `04` into the main draft** or keep it as a companion, and update Open Problem 1 accordingly. Either way, eliminate the `04` forward-reference to the undefined T9.

---

## 7. Verdict

Draft 0 is *much closer to publishable* than Draft 01 — the Tier-0 work has been done in earnest and the framing is now honest. **It is not yet correct**, because the §6 finite-$\varepsilon$ argument and Theorem 5's iff have errors that the Tier-0 rewrite quietly introduced when it operationalized the partition. These are not stylistic issues; they are mathematical ones.

After items 1–7 of §6 above are addressed, my expected verdict on the resulting Draft 0.1 is:

- **Theory venue (after addressing items 1–7)**: weak accept conditional on a referee with patience for the resolution-axis re-framing; the contribution is honest, the rigidity-of-the-Bayes-risk corner is genuinely new in the resolution-lattice statement, and the prior-work audit is unimpeachable. Tier-2 experiments are not needed for a theory venue.
- **Graph-ML venue**: not yet, even after items 1–7. The empirical predictions (aggregator ladder as floor ordering, over-smoothing floor-rise on GCN, JK monotone-by-design) are now precisely stated and falsifiable, but un-tested. This is the [02 task list's](02-adversarial_review_and_task_list.md) Tier-2 work, and it is the obvious next milestone. The split-the-paper recommendation in T4.1 of the task list is sound and I would follow it.

The single most valuable next item, after items 1–7, is **T2.4** from the [02 list](02-adversarial_review_and_task_list.md): predict the GIN learning curves on PROTEINS / NCI1 / PTC / IMDB-B / REDDIT-B training-free, by computing the graph-level bracket and confirming it reproduces the sum/mean/max ordering. That single experiment converts the paper from "a clean theory we hope is relevant" to "a theory that predicts a published figure without training a model." Worth the effort.

---

*Audit by the lab's PI. The math in Draft 0 is mostly correct; the two correctness errors are localized and fixable in a day. The honest-accounting work to date is genuinely good. Do not submit until items 1–7 are addressed; after that, send the theory version out and start the experiments for the graph-ML companion.*
