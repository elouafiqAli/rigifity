# External Reviewer's Second Audit of Draft 0.3

*Stress-test of `03-t0-achievable_error_floor.md` at Draft 0.3 (HEAD = `8157009`), conducted as a fresh adversarial read with no prior context. Severity codes match `05`, `07`, `10`: **C** critical, **M** major, **m** minor.*

> **Headline.** Draft 0.3 cleanly retired every item from `10`. A deeper read of the rest of the manuscript, however, uncovers **one new critical finding** (Corollary 4's aggregator chain is mathematically wrong as stated — $\Pi_{\mathrm{mean}}$ and $\Pi_{\mathrm{max}}$ are not comparable), **four majors** (two consistency gaps from `07` not propagated to Theorems 1 and 2, one §5 labeling error, one Step-2 over-assertion in Theorem 2′), and **six minors**.

---

## 1. Findings

### Critical

**C-1. Corollary 4's chain $\Pi_{\mathrm{sum}} \succeq \Pi_{\mathrm{mean}} \succeq \Pi_{\mathrm{max}}$ is mathematically false.**

§5 sets up the aggregator hierarchy as *"Sum is injective and induces the finest $\Pi_{\mathrm{sum}}$; mean induces the same-distribution coarsening $\Pi_{\mathrm{mean}}$; max the same-support coarsening $\Pi_{\mathrm{max}}$, forming a refinement chain."* Corollary 4 then asserts $\varepsilon^\ast(\Pi_{\mathrm{sum}}) \le \varepsilon^\ast(\Pi_{\mathrm{mean}}) \le \varepsilon^\ast(\Pi_{\mathrm{max}})$.

The second inequality requires $\Pi_{\mathrm{mean}} \succeq \Pi_{\mathrm{max}}$ (mean-equivalence implies max-equivalence). **This is false.** Two counterexamples:

| Multiset $A$ | Multiset $B$ | mean$(A) = $ mean$(B)$? | max$(A) = $ max$(B)$? |
|---|---|---|---|
| $\{0, 2\}$ | $\{1, 1\}$ | yes (both 1) | no (2 vs 1) |
| $\{1, 2\}$ | $\{0, 2\}$ | no (1.5 vs 1) | yes (both 2) |

Row 1 shows max distinguishes neighborhoods that mean identifies; row 2 shows mean distinguishes neighborhoods that max identifies. Neither $\sim_{\mathrm{mean}} \Rightarrow \sim_{\mathrm{max}}$ nor $\sim_{\mathrm{max}} \Rightarrow \sim_{\mathrm{mean}}$ holds, so $\Pi_{\mathrm{mean}}$ and $\Pi_{\mathrm{max}}$ are **incomparable** in the refinement lattice.

The Xu et al.\ [2019] result the paper cites is "sum > {mean, max}" with sum strictly more powerful than each, but does **not** establish a linear order between mean and max. The original GIN paper treats mean and max as *complementary* rather than nested ("sum learns distributions, mean learns averages, max learns sets").

*Impact.* The aggregator floor "ladder" — highlighted in §1.1 (item 2 of contributions) as a canonical GNN consequence — is mathematically wrong as stated. A referee verifies the failure in two lines.

*Fix.* Restate as a half-chain: $\varepsilon^\ast(\Pi_{\mathrm{sum}}) \le \min\{\varepsilon^\ast(\Pi_{\mathrm{mean}}), \varepsilon^\ast(\Pi_{\mathrm{max}})\}$, with an explicit caveat that $\Pi_{\mathrm{mean}}$ and $\Pi_{\mathrm{max}}$ are incomparable (give the two-line counterexample). The §5 "forming a refinement chain" sentence becomes "with $\Pi_{\mathrm{sum}}$ refining both, while $\Pi_{\mathrm{mean}}$ and $\Pi_{\mathrm{max}}$ are incomparable". §1.1 item 2's "one-line refinement-chain corollary" needs the same correction.

### Major

**M-1. Atomless realizability hypothesis missing from Theorem 1's statement.**

`07` M-1 closed this defect for Theorem 2′ by lifting the atomless hypothesis from a parenthetical proof aside into the theorem's hypotheses. The same defect was not fixed for Theorem 1, even though the (ii)⇒(iii) direction of Theorem 1's proof carries the **exact same** parenthetical aside ("…on an atomless space, realize a cell of rate $\eta$…") with the same general-space density hand-off. The statement is silent about both the atomless hypothesis and the general-space extension.

*Fix.* Apply the Theorem 2′ pattern to Theorem 1: add "Let $(\mathcal X, \mathcal F, \mathbb P)$ be atomless (so that arbitrary cell-rate splits are realizable)" to the hypothesis, with the same density-extension clause.

**M-2. Same hypothesis-hygiene gap for Theorem 2.**

Theorem 2's proof says *"Apply this to the single-cell partition of rate $\eta \in [0, \tfrac12]$…"* which invokes a single-cell partition for **every** $\eta \in [0, \tfrac12]$, requiring atomless realizability (on a finite atomic space only rates that arise as cell-restricted averages are reachable). The statement does not say atomless.

Together with M-1 this is a consistency issue: Draft 0.2's commit `c8ef3e6` was right to lift this hypothesis for Theorem 2′, but the parallel surgery on Theorems 1 and 2 was missed because `07` was scoped narrowly to `04`.

*Fix.* Same pattern as M-1.

**M-3. §5's aggregator partition labels are imprecise.**

§5 introduces $\Pi_{\mathrm{mean}}$ as "*same-distribution coarsening*" and $\Pi_{\mathrm{max}}$ as "*same-support coarsening*". Both are wrong:

- "Same-distribution coarsening" for $\Pi_{\mathrm{mean}}$ is confused: if "same distribution" means same multiset histogram, that is the *multiset-equality* partition (which is $\Pi_{\mathrm{sum}}$ via the injective sum+MLP, not a coarsening of it).
- "Same-support coarsening" for $\Pi_{\mathrm{max}}$ is incorrect: $\{1, 2\}$ and $\{0, 2\}$ have *different* supports but the *same* max; $\{1, 2, 3\}$ and $\{1, 2\}$ have the *same* support but different maxes.

*Fix.* Replace with precise definitions: $\Pi_{\mathrm{mean}}$ is the partition by neighbourhood-mean equivalence; $\Pi_{\mathrm{max}}$ is the partition by neighbourhood-max equivalence. Drop the "same-distribution / same-support" framings.

**M-4. Theorem 2′ Step 2 over-asserts $\varphi_{\max} = \varphi(\mathbf u)$.**

Step 2 reads *"…ranges from $0$ (vertices) to $\varphi_{\max} = \varphi(\mathbf u)$, by the intermediate value theorem…"*. The claim $\varphi_{\max} = \varphi(\mathbf u)$ requires $\varphi$ to attain its maximum at the simplex centre — true for permutation-symmetric concave $\varphi$, but Theorem 2′'s hypothesis is only "continuous and vanishing at the vertices" (concavity and symmetry are *conclusions*).

The proof's logical content only needs $\varphi_{\max} := \max_{\Delta^{k-1}} \varphi > 0$ (Weierstrass on the compact simplex; positive because $\varphi > 0$ somewhere in the interior). IVT then gives that every value in $[0, \varphi_{\max}]$ is attained.

*Fix.* Replace "$\varphi_{\max} = \varphi(\mathbf u)$" with "$\varphi_{\max} := \max_{\boldsymbol\eta \in \Delta^{k-1}} \varphi(\boldsymbol\eta)$, attained by compactness". One-character edit.

### Minor

**m-1. Theorem 2′ Step 3 uses a non-hypothesized premise.**

Step 3 concludes $a > 0$ from "*$R, \varphi$ are positive on the interior of the simplex*". $R > 0$ on the interior is true. But "$\varphi > 0$ on the interior" is *not* in the theorem's hypothesis. The correct justification: from $R = a\varphi + b$ with $b = 0$, if $a = 0$ then $R \equiv 0$, contradicting $R(\mathbf u) = 1 - 1/k > 0$; hence $a \ne 0$, and the sign of $R$ and $\varphi$ on a single interior point pins $a > 0$.

*Fix.* Replace the premise-citation with the non-constancy argument.

**m-2. §1 bracket display silently assumes normalization.**

The §1 bracket display is introduced as holding "for a concave score functional $\varphi$" but the formula's $\varphi^{-1}$ requires strict monotonicity and inverse existence that are part of *normalization* (only defined in §2).

*Fix.* Insert "for any normalized concave score $\varphi$ (defined in §2)" before the display.

**m-3. §5 "sum is injective" is informally wrong.**

Multiset sum is *not* injective on multisets of reals — $\{1,2\}$ and $\{0,3\}$ both sum to 3. The GIN result (Xu et al.\ Lemma 5) is that sum composed with an injective MLP is multiset-injective. §6's GIN paragraph says this correctly; §5 elides it.

*Fix.* Replace with "Sum composed with an injective MLP (the GIN construction) is multiset-injective on the relevant class".

**m-4. Corollary 4's "for every concave score and task" qualifier is vestigial.**

$\varepsilon^\ast$ depends on the partition and the task but **not** on any concave score. The qualifier is irrelevant.

*Fix.* Drop "for every concave score and"; keep "for every task". (Automatically addressed by the C-1 restatement.)

**m-5. §8 OP1b citation typo.**

OP1b reads *"…and ask whether the rigidity of Theorem 2 (or its multiclass companion in 1a) survives the lifting"*. The phrase "in 1a" should cite Theorem 2′ directly — OP1a is itself the open-problem entry, not the theorem.

*Fix.* "(or its multiclass companion **Theorem 2′**)".

**m-6. §2 "set of measure $O(\varepsilon)$" is dimension-blind (optional).**

For a $d$-dimensional embedding distribution with bounded density, the tube around a Voronoi boundary has volume $\varepsilon \cdot \mathrm{Vol}_{d-1}(\text{boundary})$ — $O(\varepsilon)$ in $\varepsilon$ but with a dimension- and density-dependent constant.

*Fix.* Either qualify ("with constant depending on embedding dimension and local density") or accept as informal — borderline minor.

---

## 2. Strengths to record

1. **Theorem 5 is back** with the proper two-direction iff and the for-every-labeling quantifier on (b). The operational-reading remark cleanly explains why direction (a) is what matters on a fixed task.
2. **§4.2 closing remark** now correctly distinguishes binary and simplex proof structures — the "verbatim" framing was internally contradictory in Draft 0.2 and is now sharpened to "same three-step skeleton, but the binary case collapses to Step 1 alone because of symmetry".
3. **Over-smoothing bound** now properly cites Oono–Suzuki, Cai–Wang, Rusch et al., with explicit constants deferred to OP2.
4. **Notational collisions resolved**: $\delta_{\mathrm{WL}}$ vs $\delta^{(L)}$; $\varepsilon$ vs $\alpha$. Clean.
5. **JK partition expression** now distinguishes $\mathcal A^{\rm base}$ from $\mathcal A^{JK}$.
6. **References list** is well-curated and alphabetically clean.
7. **Closing draft note** continues the discipline of enumerating every audit item closed plus the open-problem list.

---

## 3. Prioritized fix list

| Priority | Tag | Item | Effort |
|---|---|---|---|
| 1 | **C-1** | Restate Corollary 4 as half-chain; correct §5 setup + §1.1 item 2 | medium |
| 2 | **M-1** | Lift atomless hypothesis into Theorem 1 statement | small |
| 3 | **M-2** | Lift atomless hypothesis into Theorem 2 statement | small |
| 4 | **M-3** | Replace "same-distribution / same-support" with "same-mean / same-max" | small |
| 5 | **M-4** | Fix Theorem 2′ Step 2 $\varphi_{\max}$ via Weierstrass | trivial |
| 6 | m-1 | Fix Theorem 2′ Step 3 "$a > 0$" justification | trivial |
| 7 | m-2 | §1 bracket display: state normalization | trivial |
| 8 | m-3 | §5 "sum is injective" → "sum + injective MLP" | trivial |
| 9 | m-4 | Automatic with C-1 | — |
| 10 | m-5 | §8 OP1b "1a" → "Theorem 2′" | trivial |
| 11 | m-6 | §2 dimension/density qualifier (optional) | trivial |

**Total effort: one focused editing pass plus the Corollary 4 restatement.**

---

## 4. Meta-observation: the audit discipline is converging

Three rounds (`05` → `07` → `10` → this) have each surfaced a distinct class of issue, and the severity is *converging* not diverging:

- `05`: load-bearing modeling errors (§6 at wrong abstraction; Thm 5 quantifier).
- `07`: hypothesis-hygiene gaps in the multiclass extension.
- `10`: a Draft-0.1-era regression (Theorem 5 silently deleted) plus presentational debts.
- **this**: a propagation gap (the `07` hypothesis lifting wasn't applied to Theorems 1/2) plus a long-standing modeling error in §5's aggregator chain that survived three drafts.

Each fresh adversarial read finds something more *local* than the last. C-1 here is the last "deep" finding I'd expect; further rounds will likely surface only m-class polish.

---

## 5. Verdict

**Draft 0.3 is not promotable without a Draft 0.4 fix series.** Corollary 4's chain error is the most serious finding of any of the three audits to date — a mathematical falsity in the framework's headline GNN application. Two minutes with a counterexample finds it; a careful referee will not miss it. The fix is, however, short and isolates a known-good corner of the literature (Xu et al.'s actual claim, not the chain version).

**Promote to Draft 0.4 once all eleven items are closed.** Execution plan and PERT in `13-draft0.4_commitology.md`.

---

*Audit owner: external reviewer (this audit, second pass). Follows the same severity/closure discipline as `05`, `07`, `10`.*
