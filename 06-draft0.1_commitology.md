# Draft 0 → Draft 0.1 Commitology
### *Plan of atomic commits that resolve the [PI audit](05-pi_adversarial_audit_of_draft0.md)*

> **Discipline.** Each commit (i) has a *single* scope, (ii) cites the audit item(s) it closes, (iii) is independently revertible, and (iv) leaves the manuscript in a textually coherent state (no dangling references, no inconsistent notation). The sequence respects dependencies — proof tightenings before quantifier fixes, quantifier fixes before the §6 rewrite, §6 rewrite before §7 cleanup. Audit severity codes: **C** (critical), **M** (major), **m** (minor).
>
> **Convention.** Commit subjects follow `<type>(<scope>): <imperative summary>`; the body cites audit items by tag and states verification (what was checked after the edit). Types: `chore`, `fix`, `docs`. Scopes are paper sections (`§N`, `thmK`, `propK`, `corK`, `04`) or document names.

---

## Sequence

| # | Subject | Closes | Files | State |
|---|---|---|---|---|
| 1 | `chore(plan): track PI audit and Draft 0.1 commit plan` | — | `05`, `06` | done |
| 2 | `fix(thm2): tighten exactness proof via single-cell argument` | M-4 | `03` | done |
| 3 | `fix(bracket): note c_φ=½ universal for normalized scores` | m-2 | `03` | done |
| 4 | `fix(§1.1): drop decorative σ-algebra parenthetical` | m-6 | `03` | done |
| 5 | `fix(§2): grid-invariant ε-net partition; WL-faithful limit` | M-2, m-1 | `03` | done |
| 6 | `fix(§5): re-attach PCP analogy caveat; idealized-aggregator qualifier on Cor 4` | m-5, M-5 | `03` | done |
| 7 | `fix(thm5): restate iff with proper for-every-labeling quantifier` | C-2 | `03` | done |
| 8 | `fix(§6): rewrite depth-architecture sorting at WL level; demote Π_ε to estimator; flag attention` | C-1, m-4 | `03` | done |
| 9 | `fix(§7): remove undefined lossy-bracket paragraph` | M-1 | `03` | done |
| 10 | `fix(prop6): use consistent normalized variance in proof` | m-3 | `03` | done |
| 11 | `fix(§8): split Open Problem 1 into multiclass (resolved) and soft kernels (open)` | M-3a | `03` | done |
| 12 | `fix(04): remove T9 forward-reference; soft kernels marked separately open` | M-3b | `04` | done |
| 13 | `docs: bump draft note → 0.1; finalize commitology` | — | `03`, `06` | done |

---

## Dependency graph

```
1 ──┐
    ├── 2,3,4,5,6   (independent textual fixes, any order)
    │
    ├── 7  ── 8     (Thm 5 restated, then §6 rewrite uses the new statement)
    │
    ├── 9  ── 10    (§7 lossy removal, then Prop 6 normalization cleanup)
    │
    ├── 11 ── 12    (split OP1 in 03, then update 04 to match)
    │
    └── 13          (final draft-note bump and this file's "done" markers)
```

---

## Commits — detail

### 1 · `chore(plan): track PI audit and Draft 0.1 commit plan`
**Scope.** Bring `05-pi_adversarial_audit_of_draft0.md` and `06-draft0.1_commitology.md` under version control. No content changes.
**Why first.** The audit and plan must be in history so subsequent commits can cite them by hash if needed.
**Verification.** `git log --oneline` shows the two files in the commit; `git status` clean afterwards.

### 2 · `fix(thm2): tighten exactness proof via single-cell argument`
**Closes.** Audit §1.6 (M-4).
**Scope.** §3.2 / Theorem 2 proof. Replace the two-cell affine-equality detour with the direct single-cell argument: exactness $\Leftrightarrow$ both endpoints agree pointwise $\Rightarrow$ $\eta = c_\varphi \varphi(\eta)$ on $[0,\tfrac12]$ $\Rightarrow$ $\varphi = T$.
**Rationale.** The two-cell affine-equality argument is the right one in the simplex (cf. `04`) where $\varphi$ is not a function of $R$; in the binary case it is redundant. Tightening here is **not** a weakening — the conclusion is identical.
**Out of scope.** No change to Theorem 2 *statement* or Corollary 3.
**Verification.** Read the new proof; the implication $\eta = c_\varphi \varphi(\eta)$ on $[0,\tfrac12]$ + $\varphi(\tfrac12)=1$ + symmetry uniquely gives $\varphi(\eta) = 2\eta$ for $\eta \in [0,\tfrac12]$, hence $\varphi = T$. Identical conclusion as before.

### 3 · `fix(bracket): note c_φ=½ universal for normalized scores`
**Closes.** Audit §1.8 (m-2).
**Scope.** §1 bracket display + §3.2 bracket display + §3.3 "tighter upper bound" sentence. Add a one-line remark: for any normalized concave $\varphi$ (concave on $[0,1]$, $\varphi(0)=0$, $\varphi(\tfrac12)=1$), concavity above the chord through $(0,0)$ and $(\tfrac12,1)$ forces $\varphi(\eta) \ge 2\eta$ on $[0,\tfrac12]$, hence $c_\varphi = \tfrac12$ uniformly, attained at $\eta = \tfrac12$. The upper endpoint is therefore $\bar\varphi(\Pi)/2$ for every member; tightness is governed entirely by $\bar\varphi$. Adjust §3.3's "variance gives a tighter upper bound than entropy" to attribute the tightness to $\bar\varphi_{\mathrm{var}} \le \bar\varphi_H$ (via $4\eta(1-\eta) \le H(\eta)$), not to $c_\varphi$.
**Out of scope.** No change to the proof of Theorem 2 (handled in #2).
**Verification.** Re-derive: for $\varphi = T$, $c_\varphi = \tfrac12$; for $\varphi_{\mathrm{var}} = 4\eta(1-\eta)$, $\varphi(\tfrac12) = 1$ and chord gives $c = \tfrac12$ (attained at $\tfrac12$); for entropy, $c = \tfrac12$ likewise.

### 4 · `fix(§1.1): drop decorative σ-algebra parenthetical`
**Closes.** Audit §2.3 (m-6).
**Scope.** §1.1 contribution list, item 1. Remove "(σ-algebra)" — the paper restricts to finite partitions, the gloss adds no content. Keep the rest of the sentence.
**Out of scope.** No engagement with Blackwell's experiment-comparison framework (would be a separate framing exercise).
**Verification.** Sentence still parses; finite-partition restriction in §2 unaffected.

### 5 · `fix(§2): grid-invariant ε-net partition; WL-faithful limit`
**Closes.** Audit §1.4 (M-2), §1.7 (m-1).
**Scope.** §2 "induced partition" paragraph. Three changes:
1. Commit to the **Voronoi-of-ε-net** formulation as primary (the parenthetical "equivalently, to the nearest point of a fixed ε-net" is promoted to the definition; the dyadic grid is mentioned as a special case).
2. Replace "qualitative conclusions are independent of the particular grid" with the *correct* monotonicity-in-ε statement: along a *nested* ε-net family, $\Pi_\varepsilon$ is coarser-as-$\varepsilon$-grows and the floor non-decreasing; dependence on the specific net is bounded by cells of $O(\varepsilon)$ diameter.
3. Replace "$\Pi_{\mathrm{WL}}$ is the $\varepsilon \to 0$ limit on discrete colours" with the WL-faithful conditional: for a WL-faithful GNN (distinct WL classes mapped to distinct embeddings), $\Pi_\varepsilon = \Pi_{\mathrm{WL}}$ for all $\varepsilon$ smaller than the minimum separating embedding distance; in general $\Pi_\varepsilon$ is a coarsening of the exact-embedding partition.
**Out of scope.** No change to §6's architecture sorting (deferred to #8).
**Verification.** Re-check that §6's references to $\Pi_\varepsilon$ remain compatible (they will, after #8).

### 6 · `fix(§5): re-attach PCP analogy caveat; idealized-aggregator qualifier on Cor 4`
**Closes.** Audit §2.2 (m-5), §2.1 (M-5).
**Scope.** §5. Two changes:
1. The sentence "This is the calibrated, locally checkable gap version of the WL test" → "This is the calibrated, locally checkable gap version of the WL test (the PCP framing of §1 remains an analogy until Open Problem 3 is resolved)."
2. Corollary 4: add a parenthetical "(here $\Pi_{\mathrm{sum}}$, $\Pi_{\mathrm{mean}}$, $\Pi_{\mathrm{max}}$ denote the finest partitions induced by an injective-update GNN with the respective aggregator class — the information-theoretic ceiling; a specific trained GNN's realized partition is at most as fine)."
**Out of scope.** The §5 "Caveat (floor, not achieved)" box is untouched.
**Verification.** Cor 4 still reads as the information-theoretic ladder; the qualifier separates it from claims about specific trained architectures.

### 7 · `fix(thm5): restate iff with proper for-every-labeling quantifier`
**Closes.** Audit §1.2 (C-2).
**Scope.** §6 Theorem 5 statement. Restate as a two-part theorem:
> (a) If $(\Pi^{(L)})_L$ is a refinement chain, then for every concave score and every labeling, $\varepsilon^\ast(\Pi^{(L)})$ is non-increasing in $L$.
> (b) Conversely, if for every labeling the floor is non-increasing in $L$, then $(\Pi^{(L)})_L$ is a refinement chain.

Add a one-sentence remark that on a fixed task only (a) is operative; (b) gives the contrapositive diagnostic.
**Why before #8.** The §6 rewrite refers to this restated form.
**Verification.** Counterexample on 4 points (audit §1.2) shows the old single-task iff is false; new statement holds.

### 8 · `fix(§6): rewrite depth-architecture sorting at WL level; demote Π_ε to estimator; flag attention`
**Closes.** Audit §1.1 (C-1), §1.10 (m-4).
**Scope.** §6 body after Theorem 5. Full rewrite. Key moves:
- Distinguish three quantities: WL ceiling $\Pi^{(L)}_{\mathrm{WL}}$ (the partition the architecture's combinatorial WL step refines to), the architecture's exact-embedding partition, and the operational $\Pi^{(L)}_\varepsilon$.
- State Theorem 5 about $\Pi^{(L)}_{\mathrm{WL}}$ (or the architecture's exact equivalence). The architecture-sorting argument lives at this level.
- GIN: WL-faithful, $\Pi^{(L+1)}_{\mathrm{WL}} \succeq \Pi^{(L)}_{\mathrm{WL}}$ until WL-stability; for $\varepsilon$ smaller than minimum separating distance, $\Pi^{(L)}_\varepsilon = \Pi^{(L)}_{\mathrm{WL}}$ and the realized floor falls.
- JK / residual: $\Pi^{(L)}_{\mathrm{WL}} = \bigvee_{\ell \le L} \Pi^{(\ell)}_{\mathrm{WL}}$ at the WL level; the operational join carries the monotonicity for $\varepsilon$ smaller than the minimum layerwise separating distance.
- GCN: WL ceiling refines (it always does), but the *realized* partition fails to reach the ceiling — contraction shrinks the minimum separating distance $\delta^{(L)}$ at rate $\lambda_2^L$, and at any fixed $\varepsilon$ past a critical depth $L^\ast(\varepsilon) \approx \log(1/\varepsilon) / \log(1/\lambda_2)$, $\Pi^{(L)}_\varepsilon$ coarsens and the realized floor rises. **Over-smoothing is the operational gap between the (monotone) ceiling and the (non-monotone) realized $\varepsilon$-partition.**
- Attention: explicitly flagged as *not* classified by Theorem 5; reduced to a measurement by the bracket.

**Why this matters.** The audit's finite-$\varepsilon$ counterexample (injectivity preserves equality, not grid-cell membership) is fatal for the original §6 framing. The rewrite keeps the architecture-sorting story intact at the right level of abstraction and is honest about where over-smoothing lives.

**Out of scope.** Quantitative dependence of the number of $\varepsilon$-distinguishable cells on $\lambda_2^L$ — remains Open Problem 2.

**Verification.** Re-check each architecture claim against the audit's counterexamples; ensure the three-axis classification at the end of §6 reflects the new statement.

### 9 · `fix(§7): remove undefined lossy-bracket paragraph`
**Closes.** Audit §1.3 (M-1).
**Scope.** §7 "The computational picture (corrected)" paragraph. Remove the lossy/soft-kernel / junction-tree / Glauber-chain content (the "lossy bracket" was never defined in the paper). Keep the deterministic statement: given the partition, the bracket is $O(n)$; with WL polynomial, the deterministic bracket is polynomial-time. Add one sentence: "Generalizations to randomized/lossy variants — where each message survives independently with probability $q$ and the bracket is averaged over the random partition — are deferred to a companion work, where the corresponding $\#$P-hardness, treewidth-tractability, and approximation questions are properly stated."
**Why before #10.** Localizes the §7 changes so the Prop 6 normalization cleanup is a separate diff.
**Verification.** No remaining reference to "lossy" or "junction-tree" in §7; references to Provan–Ball / Lauritzen–Spiegelhalter / Pearl / Arnborg–Lagergren–Seese moved out of §7 (kept in reference list only if cited elsewhere; if not, removed in #13).

### 10 · `fix(prop6): use consistent normalized variance in proof`
**Closes.** Audit §1.9 (m-3).
**Scope.** §7 Proposition 6 proof. Rewrite using the normalized variance $\varphi_{\mathrm{var}}(\eta) = 4\eta(1-\eta)$ throughout (from §2): $c_\varphi = \tfrac12$ (per #3), $\bar\varphi_{\mathrm{var}} = 2 p_{\mathrm{dis}}$, upper endpoint $\bar\varphi_{\mathrm{var}}/2 = p_{\mathrm{dis}}$. Final bracket unchanged.
**Out of scope.** Statement of Proposition 6 unchanged.
**Verification.** Final answer $p_{\mathrm{dis}}$ identical; convention now matches §2 and #3.

### 11 · `fix(§8): split Open Problem 1 into multiclass (resolved) and soft kernels (open)`
**Closes.** Audit §1.5 (M-3a).
**Scope.** §8 Open Problem 1. Split into:
- **1a (multiclass labels).** Theorem 2 extends to the probability simplex with $R(\boldsymbol\eta) = 1 - \max_c \eta_c$ as the unique exact functional. *Resolved by the companion `04-t1_1_simplex_rigidity.md`*; cite and briefly summarize. Note that this extends §3.2 to multiclass node/graph tasks at the *label* level.
- **1b (soft cell assignments).** The hard-partition theory does not directly cover architectures whose cell assignment is itself stochastic (GAT, differentiable pooling, graph transformers). This requires a separate construction — a "soft-kernel" lifting that expresses the architecture as a Markov kernel from inputs to cells, with the bracket averaged over the kernel. This extension *remains open*.
**Out of scope.** Open Problems 2 (quantitative over-smoothing) and 3 (gap amplification) untouched.
**Verification.** Cross-check with `04` that the multiclass claim cited is the one `04` actually proves (§3 of `04`).

### 12 · `fix(04): remove T9 forward-reference; soft kernels marked separately open`
**Closes.** Audit §1.5 (M-3b) and §3.1 cross-doc note.
**Scope.** `04` §6 "soft and attention architectures" paragraph. Replace "Combined with the soft-kernel (T9) lifting" with an explicit statement that the soft-kernel extension is a separate open problem (matching Open Problem 1b of `03`). Also update `04`'s abstract / preamble where it claims reach to "soft/attention architectures via the soft-kernel lifting".
**Why after #11.** Both halves of M-3 — `03` Open Problem 1 split, then `04` updated to match.
**Verification.** No remaining mention of "T9" in `04`; the soft-kernel claim is honestly downgraded.

### 13 · `docs: bump draft note → 0.1; finalize commitology`
**Scope.** Two parts:
- `03` closing draft note: bump "Draft 0" to "Draft 0.1"; rewrite the note to enumerate which audit items are now closed (M-4, m-2, m-6, M-2, m-1, m-5, M-5, C-2, C-1, m-4, M-1, m-3, M-3) and which remain (Open Problems 1b, 2, 3; experiments; soft-kernel construction).
- `06` (this file): mark all rows "done" and record the SHAs of each commit at the bottom for traceability.
**Verification.** `03` still claims as Draft 0.1 only what it has earned; `06` is internally consistent.

---

## Post-mortem fields (filled after each commit)

| # | SHA | Files | Verification notes |
|---|---|---|---|
| 1 | `c8ea4c7` | `05`, `06` | Two new files under VCS; subsequent commits cite them by name and tag. |
| 2 | `f556246` | `03` | Single-cell argument gives $\varphi=T$ on $[0,\tfrac12]$ + symmetry; identical conclusion to old proof. |
| 3 | `779d533` | `03` | Chord-above-graph for normalized concave $\varphi$ forces $c_\varphi=\tfrac12$ universally; entropy / variance / tent all consistent. |
| 4 | `e0a17f1` | `03` | Sentence parses cleanly; finite-partition restriction of §2 unaffected. |
| 5 | `6a86ffd` | `03` | Voronoi-of-ε-net primary; coarsening-in-$\varepsilon$ stated; WL-faithful $\Pi_\varepsilon=\Pi_{\mathrm{WL}}$ below minimum separating distance. |
| 6 | `f65b838` | `03` | Cor 4 carries "idealized aggregator" qualifier; PCP analogy re-attached to OP3 caveat. |
| 7 | `d21be23` | `03` | Two-part iff with explicit "for every labeling" quantifier on (b); fixed-task reading restricted to (a). |
| 8 | `a7ce551` | `03` | Three-partition treatment ($\Pi_{\mathrm{WL}}$ / $\Pi_{\mathcal A}$ / $\Pi_\varepsilon$); GIN, JK, GCN, attention each sorted by WL-faithfulness and quantization regime; over-smoothing localized at the $\Pi_{\mathcal A}\to\Pi_\varepsilon$ gap for contractive architectures. |
| 9 | `b02a214` | `03` | Lossy paragraph removed; deterministic claim retained as polynomial-time; randomized variants deferred to companion with three references kept as pointers. |
| 10 | `15729f6` | `03` | Normalized variance $\varphi_{\mathrm{var}}=4\eta(1-\eta)$ throughout, $c_\varphi=\tfrac12$ (per #3); upper $=p_{\mathrm{dis}}$ identical to old. |
| 11 | `d0f175b` | `03` | OP1 split into 1a (cite `04`) and 1b (soft cells, open); scope sentence in §8 updated; OP2 now references $L^\ast(\varepsilon)$ from §6. |
| 12 | `027ba89` | `04` | Three locations rephrased (abstract, §6 soft-arch paragraph, §7 summary); no remaining "T9"; soft-kernel claim downgraded and cross-referenced to `03` OP1b. |
| 13 | `8ecc9b6` | `03`, `06` | Draft note bumped to 0.1 with full audit-closure enumeration; orphan refs (Pearl, Valiant) pruned; commitology post-mortem table populated. |

---

*Plan owner: PI. Execution: agent, atomically. Any deviation must be justified inline in the corresponding commit body.*
