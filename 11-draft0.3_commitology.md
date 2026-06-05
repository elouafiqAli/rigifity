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
| 1 | `chore(plan): track Draft 0.3 commitology as 11` | — | `11` | done | `feeb4e3` |
| 2 | `fix(§6): re-install Theorem 5 statement and proof; restore C-2 closure` | **C-1**, m-3, m-5 (§6 part) | `03` | done | `5df2299` |
| 3 | `fix(§4.2): correct "verbatim" framing of simplex proof structure` | **M-1** | `03` | done | `c2ed38f` |
| 4 | `fix(§6+refs): cite over-smoothing literature for δ^L bound` | **M-2** | `03` | done | `9f93828` |
| 5 | `fix(notation): disambiguate δ_WL vs δ^L; rename Cor 7 ε → α` | m-1, m-2 | `03` | done | `c5ad2d1` |
| 6 | `fix(refs): move Pires into alphabetical position` | m-4 | `03` | done | `612a287` |
| 7 | `fix(§1.1): note Theorem 5 + 1′ multiclass scope in item 2` | m-5 (§1.1 residual) | `03` | done | `361383c` |
| 8 | `fix(§6): disambiguate A^JK vs A^base in join-residual partition expression` | m-6 | `03` | done | `370f09e` |
| 9 | `docs: bump 03 from Draft 0.2 to Draft 0.3 with full audit-closure enumeration` | — | `03` | done | `c6dafd8` |
| 10 | `chore(plan): finalize 11 commitology with SHAs` | — | `11` | this commit | — |

**Plan-vs-execution delta.** The plan called for 11 commits; execution required 10. Two consolidations against the plan: (i) the C-1 commit (Theorem 5 re-install) naturally swept the §6 opener and so absorbed m-3 (Lipschitz/quantization bridge jargon) and the §6-side of m-5 (multiclass scope remark), eliminating the planned standalone m-3 commit; (ii) m-5's §1.1 residual fix happened to fall between m-4 (Pires) and m-6 (JK disambiguation), and is preserved as its own small commit. Net: 10 commits versus 11 planned. The primed-extension convention established in Draft 0.2 was used unchanged. No commits needed self-audit corrections this round.

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
| 1 | `feeb4e3` | `11` | Plan under VCS; cited by subsequent commits. |
| 2 | `5df2299` | `03` | Theorem 5 two-direction iff (with for-every-labeling quantifier on (b)) re-installed at top of §6 from `d21be23` archaeology; operational-reading remark added with multiclass-via-Theorem 1′ note; §6 opener Voronoi comparison replaces the 'Lipschitz/quantization bridge' jargon. Closes C-1 and incidentally m-3 + §6 side of m-5. |
| 3 | `c2ed38f` | `03` | §4.2 closing remark now explicitly says proof is *not* verbatim: binary collapses to Step 1 via symmetry, simplex genuinely uses all three steps because φ is no longer a function of R. Resolves the contradiction with §3.2's earlier remark. |
| 4 | `9f93828` | `03` | §6 GCN paragraph now cites Oono–Suzuki 2020 and Cai–Wang 2020 for the spectral contraction, frames δ^L ≤ Cλ₂^L as the standard analysis with explicit constants deferred to OP2. Three references added to bibliography in alphabetical order (Cai–Wang, Oono–Suzuki, Rusch–Bronstein–Mishra). |
| 5 | `c5ad2d1` | `03` | §2's δ renamed to δ_WL with cross-reference forward to §6's δ^L; Cor 7 ε → α throughout (statement + Hoeffding m + Honest-cost-accounting paragraph). The property-test threshold was already named α, so internal consistency preserved. |
| 6 | `612a287` | `03` | Pires moved between Oono and Provan in references. |
| 7 | `361383c` | `03` | §1.1 item 2 now reads 'Theorem 5, lifted to multiclass via Theorem 1′ of §4.4' matching the §6 Theorem 5 block. |
| 8 | `370f09e` | `03` | JK case now distinguishes 𝒜^base (underlying message-passing) and 𝒜^JK (join variant); join expression Π^L_𝒜^JK = ⋁ Π^l_𝒜^base reads as intended. |
| 9 | `c6dafd8` | `03` | Header bumped to Draft 0.3; closing draft note rewritten to enumerate all 10 audit items closed plus reaffirm 05/07 closures plus open-problem list. |
| 10 | `<this commit>` | `11` | Sequence table SHAs backfilled; plan-vs-execution delta documented (10 commits vs 11 planned, due to m-3 being absorbed into the C-1 commit §6-opener edit). |

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
