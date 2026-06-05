# Draft 0.3 → Draft 0.4 Commitology
### *Plan to close [`12-external_reviewer_second_audit_of_draft0.3.md`](12-external_reviewer_second_audit_of_draft0.3.md)*

> **Discipline.** Same as `06` / `08` / `11`: each commit (i) has a *single* scope, (ii) cites the audit item(s) it closes, (iii) is independently revertible, (iv) leaves the manuscript textually coherent. Severity codes from `12`: **C** critical, **M** major, **m** minor.
>
> **Convention.** `<type>(<scope>): <imperative summary>`. Types: `chore`, `fix`, `docs`. Scopes: paper section (`§N`, `thmK`, `corK`), document name.

---

## Strategy

Pure fix series. No new content beyond closing audit items from `12`. Three classes of commit:

- **Critical (1 commit):** restate Corollary 4 as a half-chain, with §5 setup + §1.1 item 2 + §1 abstract synced. This is the load-bearing fix — it touches three places in the manuscript where the mean–max chain was previously asserted.
- **Major (4 commits):** lift atomless hypothesis into Theorem 1 (M-1); same for Theorem 2 (M-2); replace §5 "same-distribution/same-support" labels (M-3); fix Theorem 2′ Step 2 $\varphi_{\max}$ over-assertion (M-4).
- **Minor (5 commits):** Step 3 "$a>0$" justification (m-1), §1 bracket normalization (m-2), §5 "sum is injective" (m-3), §8 OP1b citation (m-5), §2 dimension qualifier (m-6 — optional but cheap).

Then bump and finalize.

---

## Sequence

| # | Subject | Closes | Files | State | SHA |
|---|---|---|---|---|---|
| 1 | `chore(plan): track Draft 0.4 commitology as 13` | — | `13` | done | `300b7f5` |
| 2 | `fix(cor4+§5+§1.1+abstract): restate Cor 4 as half-chain; mean and max incomparable` | **C-1**, **M-3**, m-3, m-4 | `03` | done | `963fe94` |
| 3 | `fix(thm1): lift atomless realizability hypothesis into statement` | **M-1** | `03` | done | `23814f7` |
| 4 | `fix(thm2): lift atomless realizability hypothesis into statement` | **M-2** | `03` | done | `07ddde8` |
| 5 | `fix(thm2′): replace φ_max=φ(u) with Weierstrass max in Step 2` | **M-4** | `03` | done | `d6363f7` |
| 6 | `fix(thm2′): correct Step 3 "a>0" justification via non-constancy` | m-1 | `03` | done | `7219873` |
| 7 | `fix(§1): state normalized-score hypothesis on bracket display` | m-2 | `03` | done | `0a3e62c` |
| 8 | `fix(§8): OP1b citation "in 1a" → "Theorem 2′"` | m-5 | `03` | done | `475d8ea` |
| 9 | `fix(§2): note dimension/density dependence in O(ε) tube measure` | m-6 | `03` | done | `c03a4cf` |
| 10 | `docs: bump 03 from Draft 0.3 to Draft 0.4 with full audit-closure enumeration` | (also closes a missed §8 "ladder" reference flushed by final inspection) | `03` | done | `3d9990a` |
| 11 | `chore(plan): finalize 13 commitology with SHAs` | — | `13` | this commit | — |

**Plan-vs-execution delta.** The plan called for 13 commits; execution required 11. Three consolidations against the plan: (i) **M-3** (section 5 same-distribution/same-support label correction) was absorbed into the **C-1** commit because the section 5 setup rewrite for the half-chain was the natural place to land it — the §5 setup paragraph and the §5 counterexamples co-occur with the corrected labels in one coherent block; (ii) **m-3** (§5 "sum is injective" → "sum + injective MLP") was likewise absorbed into the **C-1** commit because the offending phrase lives in the same paragraph that the half-chain restatement was rewriting; (iii) **m-4** (vestigial "for every concave score" qualifier on Cor 4) was automatically resolved by the new Cor 4 statement omitting the qualifier. Net: 11 commits versus 13 planned. The religious-verification protocol of the plan was applied after each commit (re-read in context, grep cross-references, diff sanity check, commit body cites audit item) and the final inspection sweep BEFORE the docs bump caught a stale §8 opener "ladder" reference that was folded into commit 10 with its closure recorded in the commit body.

---

## Dependency graph (PERT — activity-on-node, S=1 / M=3 / L=5)

```
A(1·S) ──► B(2·M) ──► C(3·S) ──► D(4·S) ──► E(5·S) ──► F(6·S) ──► G(7·S) ──► H(8·S) ──► I(9·S) ──► J(10·S) ──► K(11·S) ──► L(12·S) ──► M(13·S)
```

**Critical path.** A → B → C → D → E → F → G → H → I → J → K → L → M.
Weights: 1+3+1+1+1+1+1+1+1+1+1+1+1 = **14 units**.

**Long-pole node: B (commit 2 — Corollary 4 restatement).** Three coordinated edits across §5 setup, §5 Corollary 4 statement+caveat, §1.1 item 2, and (lightly) the abstract — but each is short and the restatement is well-defined.

**Risk:**

| Risk | Node | Reason |
|---|---|---|
| Medium | B | Multi-location coordinated edit; must preserve the legitimate half-chain $\Pi_{\mathrm{sum}}$ refines each of $\Pi_{\mathrm{mean}}$, $\Pi_{\mathrm{max}}$ |
| Low | C–K | Each fix is a localized prose or notation edit |
| Trivial | A, L, M | Mechanical |

**Slack:** zero on the chain (every commit edits `03`; the manuscript is small enough that parallelizing wouldn't help). Order optimized for atomicity, not for parallelism.

**Dependency rationale:**
- `A → B`: plan under VCS before fixes
- `B → C → D`: theorem-hypothesis lifts after the headline restatement, in numerical order (Thm 1 then Thm 2)
- `D → E → F → G`: §5 labels (M-3), Thm 2′ Step 2 (M-4), Thm 2′ Step 3 (m-1) — proof-section edits clustered
- `G → H → I → J → K`: §1 / §5 / §8 / §2 prose tweaks
- `K → L`: draft note bump after all fixes
- `L → M`: SHA backfill last

---

## Religious-verification protocol

After each commit, before opening the next:

1. **Reread the edited paragraph in context.** Confirm the edit reads cleanly with its neighbors.
2. **Grep for cross-references.** If the commit touches a numbered statement (Theorem $k$, Corollary $k$), grep the manuscript for every reference to that statement and verify each still parses.
3. **Diff sanity check.** Run `git diff HEAD~1` and confirm only the intended lines changed.
4. **Commit body cites audit item.** Every commit body explicitly states which item(s) of `12` it closes.

After the full series (before commit 12 docs bump):

5. **Final inspection sweep.** Grep all theorem/corollary numbers, all `§N` references, all bibliography entries, all primed-extension marks (Theorem 1$'$, 2$'$, Corollary 3$'$) — verify each resolves to a real target in the manuscript.

---

## Post-mortem fields (filled after each commit)

| # | SHA | Files | Verification notes |
|---|---|---|---|
| 1 | `300b7f5` | `13` | Plan under VCS; cited by subsequent commits. |
| 2 | `963fe94` | `03` | Half-chain $\varepsilon^\ast(\Pi_{\mathrm{sum}})\le\min\{\varepsilon^\ast(\Pi_{\mathrm{mean}}),\varepsilon^\ast(\Pi_{\mathrm{max}})\}$ with two-line incomparability counterexamples ($\{0,2\}/\{1,1\}$ share mean not max; $\{1,2\}/\{0,2\}$ share max not mean); coordinated edits across abstract, §1.1, §5 setup, §5 Cor 4, §5 caveat, §8 opener; "sum is injective" → "sum + injective MLP" folded in; vestigial "for every concave score" qualifier dropped. Closes C-1, M-3 (label correction in setup), m-3, m-4. |
| 3 | `23814f7` | `03` | Thm 1 statement adds "Let $(\mathcal X,\mathcal F,\mathbb P)$ be atomless" plus general-space density extension; mirrors the `c8ef3e6` surgery on Thm 2$'$. |
| 4 | `07ddde8` | `03` | Same surgery on Thm 2; rigidity-class theorems (Thm 1, Thm 2, Thm 2$'$) now carry parallel hypothesis statements. |
| 5 | `d6363f7` | `03` | Step 2 of Thm 2$'$ now uses Weierstrass: $\varphi_{\max} := \max_{\Delta^{k-1}}\varphi$; drops the over-asserted $\varphi_{\max} = \varphi(\mathbf u)$ that required symmetry only *concluded*. |
| 6 | `7219873` | `03` | Step 3 of Thm 2$'$ "$a>0$" now via non-constancy ($a=0$ would force $R\equiv 0$ contradicting $R(\mathbf u)>0$); drops the unjustified "phi > 0 on interior" premise. |
| 7 | `0a3e62c` | `03` | §1 bracket display now names "normalized concave score" with the four-property definition inline; $\varphi^{-1}$ is now well-defined where used. |
| 8 | `475d8ea` | `03` | §8 OP1b now cites "Theorem 2$'$" directly instead of pointing back to 1a (which is itself the OP entry). |
| 9 | `c03a4cf` | `03` | §2 tube-measure clause adds "with constant depending on the embedding dimension and on the local density near the boundary". |
| 10 | `3d9990a` | `03` | Header Draft 0.3 → Draft 0.4; closing draft note rewritten to enumerate every closed item of `12` plus the prior `05`/`07`/`10` closures; final inspection caught a stale "ladder" reference in the §8 opener and folded its correction into this bump commit. |
| 11 | `cd48c76` | `13` | Sequence table SHAs backfilled; plan-vs-execution delta documented (11 commits vs 13 planned; M-3, m-3, m-4 absorbed into C-1; m-3 of plan was the inspection-sweep §8 "ladder" catch folded into the bump). |

---

## What Draft 0.4 does *not* add

After this series closes, the paper has retired every known audit item from `05`, `07`, `10`, and `12`. It does **not** add:

- Mechanization (deferred — see `09`; Lean 4 + mathlib kernel scheduled after 0.4 ships).
- OP1b construction (soft-cell-assignment lifting via Markov kernels — genuinely open).
- OP2 closure (quantitative over-smoothing rate, $\delta^{(L)} \le C\lambda_2^L$ as a theorem rather than a cited lemma).
- OP3 closure (gap amplification / hardness of approximation).
- Empirical companion paper.
- Closed-form $\ell_\varphi$ for entropy and Gini.

These remain marked in §8 after Draft 0.4 ships.

---

*Plan owner: PI. Execution: agent, atomically, with religious-verification protocol applied after every commit.*
