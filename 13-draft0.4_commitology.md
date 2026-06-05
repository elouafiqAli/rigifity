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
| 1 | `chore(plan): track Draft 0.4 commitology as 13` | — | `13` | — | — |
| 2 | `fix(cor4+§5+§1.1): restate Corollary 4 as half-chain; mean and max incomparable` | **C-1**, m-4 | `03` | — | — |
| 3 | `fix(thm1): lift atomless hypothesis into statement` | **M-1** | `03` | — | — |
| 4 | `fix(thm2): lift atomless hypothesis into statement` | **M-2** | `03` | — | — |
| 5 | `fix(§5): replace same-distribution/same-support labels with same-mean/same-max` | **M-3** | `03` | — | — |
| 6 | `fix(thm2'): replace φ_max=φ(u) with Weierstrass max in Step 2` | **M-4** | `03` | — | — |
| 7 | `fix(thm2'): correct Step 3 "a>0" justification via non-constancy` | m-1 | `03` | — | — |
| 8 | `fix(§1): state normalized-score hypothesis on bracket display` | m-2 | `03` | — | — |
| 9 | `fix(§5): "sum is injective" → "sum + injective MLP"` | m-3 | `03` | — | — |
| 10 | `fix(§8): OP1b "1a" → "Theorem 2′"` | m-5 | `03` | — | — |
| 11 | `fix(§2): note dimension/density dependence in O(ε) tube measure` | m-6 | `03` | — | — |
| 12 | `docs: bump 03 → Draft 0.4; enumerate closed audit items` | — | `03` | — | — |
| 13 | `chore(plan): finalize 13 commitology with SHAs` | — | `13` | — | — |

(SHA column backfilled by commit 13.)

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
| 1 | _to be filled_ | `13` | Plan under VCS. |
| … | | | |

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
