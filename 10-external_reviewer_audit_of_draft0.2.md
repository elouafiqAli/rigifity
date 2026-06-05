# External Reviewer's Audit of Draft 0.2

*Stress-test of `03-t0-achievable_error_floor.md` at Draft 0.2 (HEAD = `75a80d3`) conducted as a fresh external review with no prior context. Severity codes match the established discipline of `05` and `07`: **C** critical, **M** major, **m** minor.*

> **Headline.** The paper is mostly in good shape, but a careful read uncovers **one critical defect** that was created in Draft 0.1 and survived the Draft 0.2 consolidation undetected: **Theorem 5 is referenced eight times throughout the manuscript but never stated.** This invalidates the Draft 0.1 closure claim on audit item C-2 (`05`) and undermines every architecture-sorting argument in §6 that cites "Theorem 5(a)". One internal contradiction between §3.2 and §4.2 (Major), one major presentational gap on the over-smoothing bound, and four minors are also present.

---

## 1. Findings

### Critical

**C-1. Theorem 5 is cited eight times but never stated.**

References to Theorem 5 in the current text:

| Location | Citation |
|---|---|
| §1.1 contributions, item 2 | *"the cross-architecture characterization of depth-monotonicity (Theorem 5)"* |
| §6 opening of architecture block | *"Theorem 5 applies to whichever depth sequence of partitions one cares about"* |
| §6 GIN case | *"Theorem 5(a) gives a non-increasing realized floor"* |
| §6 JK case | *"Theorem 5(a) applies"* |
| §6 GCN case | *"Theorem 5(a) applies at the WL level"* |
| §6 attention case (×2) | *"not statically classified by Theorem 5"* / *"Theorem 5 yields no static prediction"* |
| §8 closing | *"the over-smoothing floor-rise (Theorem 5)"* |

**Theorem 5 itself is nowhere in the manuscript.** Git archaeology confirms the regression:

- Commit `d21be23` (Draft 0.1 commit 7) *installed* the two-direction iff statement of Theorem 5, closing audit item C-2 of `05`.
- Commit `a7ce551` (Draft 0.1 commit 8, the §6 rewrite) *silently deleted* Theorem 5's statement and proof while restructuring the architecture-sorting body. The rewrite kept the *references* to Theorem 5 and Theorem 5(a)/(b) but excised the only place those references resolve to.

The Draft 0.1 closure note in §8 still asserts that C-2 was closed by the Thm 5 restatement, but the restatement no longer exists in the text. The Draft 0.2 consolidation did not touch §6 and so inherited the broken state.

*Impact.* A referee reading §6 cannot evaluate the architecture-sorting argument: every case cites Theorem 5(a) (the "refinement chain $\Rightarrow$ floor non-increasing" direction) as the load-bearing inference, and there is no theorem to evaluate. **C-2 of the Draft 0.1 audit `05` is *re-open*.**

*Fix.* Re-install the Theorem 5 statement and proof at the top of §6, before the "Three partitions at each depth" paragraph, in the form preserved in commit `d21be23`. Update the §8 closure note to acknowledge the regression and the re-installation as part of Draft 0.3.

### Major

**M-1. Internal contradiction between §3.2 and §4.2 on the structure of the rigidity proof.**

- §3.2 remark (post-`f556246` tightening): *"The two-cell affine-equality argument familiar from the simplex extension is unnecessary here: single-cell partitions already pin $\varphi$ pointwise, because in the binary case $\varphi$ is a function of the scalar $\eta$."*
- §4.2 closing remark: *"the argument is verbatim the binary proof of Theorem 2 (single cell pins $G$ on the range, two cells force affine, vertices fix the constant) transported to the simplex"*.

These two statements contradict each other. The binary proof uses only Step 1; the simplex proof uses all three steps. The "verbatim" framing in §4.2 is wrong.

*Fix.* Replace "verbatim" with an explicit acknowledgement: the simplex case *requires* Steps 2 and 3 *precisely because* $\varphi$ is no longer a function of the scalar $R$ on $\Delta^{k-1}$ — and that proof-structural difference *is* part of what makes the multiclass case interesting (the binary case's Step 1 alone collapsed the proof because of the symmetry §3.2 calls out).

**M-2. The over-smoothing bound $\delta^{(L)} \le C\lambda_2^L$ is stated like a derivation but is actually a citation-free assertion.**

§6 contractive-aggregation case reads: *"The aggregation is a linear operator whose non-constant spectrum has norm below 1 ... the informative component of the signal contracts at rate $\lambda_2^L := |\mu_2|^L$, and the minimum separating embedding distance $\delta^{(L)}$ shrinks geometrically: $\delta^{(L)} \le C\lambda_2^L$ for some architecture-dependent $C > 0$."*

The logical jump from "informative component contracts at rate $\lambda_2^L$" to "minimum separating distance shrinks at the same rate" is non-trivial — it requires that the worst-separated pair stays worst-separated through depth, which is itself a contraction argument. The over-smoothing literature (Oono–Suzuki 2020, Cai–Wang 2020, Rusch–Bronstein–Mishra 2023) has more careful versions. As written the inequality reads like a stated theorem; OP2 then says "make §6 precise", which acknowledges the gap globally but doesn't fix the local presentational claim.

*Fix.* Either cite Oono–Suzuki / Cai–Wang explicitly for the bound and the underlying contraction lemma, or qualify the statement as "we expect / it is reasonable to suppose / the standard over-smoothing analysis gives" and leave the constants for OP2. Either is acceptable; the current "X shrinks geometrically: X ≤ Cλ²ᴸ" framing is not.

### Minor

**m-1. Notational collision on $\delta$.**

- §2: $\delta := \min_{u \not\sim_{\mathrm{WL}} v}\|h(u) - h(v)\|$ (minimum separating distance under **WL-equivalence**).
- §6: $\delta^{(L)} := \min_{u \not\sim_{\mathcal A} v}\|h^{(L)}(u) - h^{(L)}(v)\|$ (same minimum under **architecture-equivalence**).

These coincide for WL-faithful architectures but differ for contractive ones — exactly the architectures §6 cares about. The drift is silent.

*Fix.* Either rename one of them ($\delta_{\mathrm{WL}}$ vs $\delta^{(L)}_{\mathcal A}$) or add a one-line note in §6 spelling out the change of equivalence relation.

**m-2. Notational collision on $\varepsilon$.**

§§2, 6 use $\varepsilon$ for partition resolution ($\Pi_\varepsilon$, $\delta^{(L)} < \varepsilon$). §7 Corollary 7 uses $\varepsilon$ for Hoeffding accuracy (*"$p_{\mathrm{dis}}$ is estimable to $\pm\varepsilon$"*). Two different quantities, same symbol, both alive in §6–§7.

*Fix.* Rename the statistical $\varepsilon$ in Corollary 7 to $\alpha$ or $\tau$ (and propagate to the Hoeffding $m$ formula).

**m-3. "Lipschitz/quantization bridge" promises more than the text delivers.**

§6 opener: *"we state it there and then transfer to the operational $\varepsilon$-partition $\Pi_\varepsilon^{(L)}$ from §2 via a Lipschitz/quantization bridge."* No named bridge lemma appears anywhere; the actual mechanism is the trivial Voronoi observation $\Pi_\varepsilon = \Pi_{\mathcal A}$ for $\varepsilon < \delta^{(L)}$.

*Fix.* Drop the named-thing language. Say "via the elementary comparison $\Pi^{(L)}_\varepsilon = \Pi^{(L)}_{\mathcal A}$ for $\varepsilon < \delta^{(L)}$".

**m-4. Bibliography alphabetical order broken.**

Pires (2016) appears *after* Provan (1983). Alphabetical order places **Pi** before **Pr**.

*Fix.* Move Pires between Morris and Provan.

**m-5. §1.1 contributions item 2 silently scopes Theorem 5 to binary.**

Item 2 cites Theorem 5 for depth-monotonicity; item 3 introduces the multiclass extension. Whether the depth-monotonicity result is binary-only or carries over via Theorem 1$'$ is not stated. (Strictly speaking, this is moot until C-1 is resolved, but the §4.4 "structural loop" paragraph claims the multiclass bracket sits on the same monotonicity scaffolding, implying multiclass-Theorem-5 lifts via Theorem 1$'$ — item 2 should acknowledge this.)

*Fix.* When re-installing Theorem 5 (per C-1), add a one-line "(also extends to multiclass via Theorem 1$'$)" remark and update item 2 to match.

**m-6. The join-residual notation conflates architecture variants.**

§6 JK case: $\Pi^{(L)}_{\mathcal A} = \bigvee_{\ell \le L}\Pi^{(\ell)}_{\mathcal A}$.

Read literally — same $\mathcal A$ on both sides — this is a trivial fixed-point identity. The intended statement is $\Pi^{(L)}_{\mathcal A^{JK}} = \bigvee_{\ell \le L}\Pi^{(\ell)}_{\mathcal A^{\rm base}}$: the JK architecture's depth-$L$ partition equals the join of the *base* architecture's per-layer partitions.

*Fix.* Disambiguate the two architectures by subscript/superscript ($\mathcal A^{JK}$ vs $\mathcal A^{\rm base}$, or $\mathcal A_{\rm JK}$ vs $\mathcal A$).

---

## 2. Strengths to record

1. The §4 consolidation is structurally clean — the four subsections (setup+bracket, rigidity, smoothness–slack, binary consistency + Theorem 1$'$) flow naturally into and out of binary §3 and GNN §5.
2. The hypothesis hygiene fixes from `07` (M-1 atomless realizability, M-2 $c_\varphi$ finiteness, m-4 bounded-Jensen) landed cleanly in Theorem 2$'$'s statement and proof.
3. The level-set characterization (m-1 fix from `07`) is substantively better than the original "coarsest concave functional" framing — it makes the §4.3 worked example *land* on a specific structural failure (Gini distinguishes distributions $R$ identifies), which is exactly the Step 1 obstruction.
4. The numbered-statement primed-extension convention (Theorem 1$'$, 2$'$, Corollary 3$'$) is the right choice and reads cleanly.
5. The closing draft note's audit-closure enumeration is exhaustive and accurate *modulo* the C-2 regression.
6. The PCP framing has been correctly demoted to analogy throughout (preserved from Draft 0.1).

---

## 3. Prioritized fix list

| Priority | Tag | Item | Effort | Scope |
|---|---|---|---|---|
| 1 | C-1 | Re-install Theorem 5 statement + proof; restore C-2 closure | medium | §6 opener |
| 2 | M-1 | Correct "verbatim" framing in §4.2 closing remark | small | §4.2 |
| 3 | M-2 | Cite or qualify the $\delta^{(L)} \le C\lambda_2^L$ bound | small | §6 GCN case |
| 4 | m-1 | Disambiguate $\delta$ scope | small | §6 |
| 5 | m-2 | Rename Cor 7's $\varepsilon$ to $\alpha$ | small | §7 |
| 6 | m-3 | Drop "Lipschitz/quantization bridge" jargon | small | §6 opener |
| 7 | m-4 | Move Pires into alphabetical position | trivial | references |
| 8 | m-5 | Note Theorem 5 + Theorem 1$'$ multiclass scope | small | §1.1 item 2 |
| 9 | m-6 | Disambiguate $\mathcal A^{JK}$ vs $\mathcal A^{\rm base}$ in join expression | small | §6 JK case |

**Total effort: one focused editing pass.** C-1 is the load-bearing blocker; M-1 and M-2 are real but small; the six minors are an editorial sweep.

---

## 4. Verdict

**Not ready to proceed to mechanization (per `09`) without a Draft 0.3 fix series.** Mechanizing Theorem 5 would expose the missing statement immediately — better to fix in prose first. C-1 is the single critical blocker. M-1 is a real internal inconsistency worth one focused commit. M-2 + the four minors are a single editorial pass.

**Promote to Draft 0.3 once all nine items are closed.** Execution plan and PERT in `11-draft0.3_commitology.md`.

---

*Audit owner: external reviewer (this audit). Follows the same severity / closure discipline as `05` and `07`.*
