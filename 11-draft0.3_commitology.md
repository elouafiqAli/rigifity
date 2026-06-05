# Draft 0.2 → Draft 0.3 Commitology
### *Plan to close [`10-external_reviewer_audit_of_draft0.2.md`](10-external_reviewer_audit_of_draft0.2.md)*

> **Discipline.** Same as `06` / `08`: each commit (i) has a *single* scope, (ii) cites the audit item(s) it closes, (iii) is independently revertible, (iv) leaves the manuscript textually coherent. Severity codes from `10`: **C** critical, **M** major, **m** minor.
>
> **Convention.** `<type>(<scope>): <imperative summary>`; body cites audit items by tag and states verification. Types: `chore`, `fix`, `docs`. Scopes: paper sections (`§N`), document names.

---

## Strategy

Pure fix series. No new content beyond closing audit items from `10`. Three classes of commit:

- **Critical (1 commit):** re-install Theorem 5 statement and proof, restore Draft 0.1's C-2 closure. This is the load-bearing fix — every §6 architecture argument depends on it.
- **Major (2 commits):** correct §4.2 "verbatim" framing (M-1); cite-or-qualify the over-smoothing bound (M-2).
- **Minor (5 commits):** notation collisions, dropped jargon, refs alphabetization, scope qualifier, JK disambiguation.

Then bump and finalize.

---

## Sequence

| # | Subject | Closes | Files | State | SHA |
|---|---|---|---|---|---|
| 1 | `chore(plan): track Draft 0.3 commitology as 11` | — | `11` | — | — |
| 2 | `fix(§6): re-install Theorem 5 statement and proof; restore C-2 closure` | C-1 | `03` | — | — |
| 3 | `fix(§4.2): correct "verbatim" framing of simplex proof structure` | M-1 | `03` | — | — |
| 4 | `fix(§6): cite over-smoothing literature for δ^L bound` | M-2 | `03` | — | — |
| 5 | `fix(notation): disambiguate δ scope; rename Cor 7 ε → α` | m-1, m-2 | `03` | — | — |
| 6 | `fix(§6): drop "Lipschitz/quantization bridge" jargon` | m-3 | `03` | — | — |
| 7 | `fix(refs): move Pires into alphabetical position` | m-4 | `03` | — | — |
| 8 | `fix(§1.1): note Theorem 5 + 1′ multiclass scope` | m-5 | `03` | — | — |
| 9 | `fix(§6): disambiguate A^JK vs A^base in join expression` | m-6 | `03` | — | — |
| 10 | `docs: bump 03 → Draft 0.3; enumerate closed audit items` | — | `03` | — | — |
| 11 | `chore(plan): finalize 11 commitology with SHAs` | — | `11` | — | — |

(SHA column backfilled by commit 11.)

---

## Dependency graph (PERT — activity-on-node, S=1 / M=3 / L=5)

```
A(1·S) ──► B(2·M) ──┬──► C(3·S) ──► D(4·S) ──► E(5·S) ──► F(6·S) ──► G(7·S) ──► H(8·S) ──► I(9·S) ──► J(10·S) ──► K(11·S)
                    │
                    └──► H(8·S) reads Theorem 5 (parallelizable but kept sequential for simplicity)
```

**Critical path.** A → B → C → D → E → F → G → H → I → J → K. Weights: 1+3+1+1+1+1+1+1+1+1+1 = **13 units** (versus Draft 0.2's 20).

**Long-pole node: B (commit 2 — Theorem 5 re-installation).** Medium-effort commit; restores a previously-existing theorem statement plus proof from commit `d21be23` archaeology. All §6 references depend on it.

**Risk:**

| Risk | Node | Reason |
|---|---|---|
| Medium | B | Re-installing a deleted theorem; must preserve the iff structure with proper for-every-labeling quantifier per Draft 0.1 audit fix |
| Low | C–I | Each fix is a localized prose or notation edit |
| Trivial | A, J, K | Mechanical |

**Slack:** zero on B; H could parallelize with B since it's an item-2 wording fix that references Theorem 5, but kept sequential since the entire chain is short.

**Dependency rationale:**
- `A → B`: plan under VCS before fixes
- `B → C`: §4.2 closing remark should be edited *after* §6's Theorem 5 is back, so the reader knows the simplex-proof-structure remark refers to a well-defined object
- `C → D → E → F → G`: independent fixes, ordered for atomicity
- `G → H`: §1.1 item 2 note depends on Theorem 5 being present
- `H → I`: §6 JK fix touches the same paragraph cluster as the Theorem 5 area
- `I → J`: draft note enumeration after all fixes
- `J → K`: SHA backfill last

---

## Post-mortem fields (filled after each commit)

| # | SHA | Files | Verification notes |
|---|---|---|---|
| 1 | _to be filled_ | `11` | Plan under VCS; subsequent commits cite by SHA. |
| … | | | |

---

## What Draft 0.3 does *not* add

After this series closes, the paper has retired every known audit item from `05`, `07`, and `10`. It does **not** add:

- Mechanization (deferred — see `09`; Lean 4 + mathlib kernel scheduled after 0.3 ships).
- OP1b construction (soft-cell-assignment lifting via Markov kernels — genuinely open).
- OP2 closure (quantitative over-smoothing rate, $\delta^{(L)} \le C\lambda_2^L$ as a theorem rather than a cited lemma).
- OP3 closure (gap amplification / hardness of approximation).
- Empirical companion paper (Cor 4 ladder, over-smoothing onset curves, local test).
- Closed-form $\ell_\varphi$ for entropy and Gini (minor open thread noted in §4.1).

These remain marked in §8 after Draft 0.3 ships.

---

*Plan owner: PI. Execution: agent, atomically. Any deviation must be justified inline in the corresponding commit body.*
