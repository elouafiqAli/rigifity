# Adversarial Review of the Patched Manuscript
## (constructive close) — plus the consolidated recheck list

Reviewer stance: hostile Monthly referee with a functional-equations background, then a constructive turn. Each attack is run against the draft **as amended by patches P1–P12**.

---

## Round 1 — Attacks

**A1. "Theorem 1 is folklore; why does this merit publication?"**
True, and the paper says so. But the referee will check whether the all-real-weights case is *stated* in the standard sources or merely derivable. Pressure point: Aczél–Dhombres and Kuczma treat Jensen's equation with regularity (and Reem's 2017 survey — Theorem 5.1 — still assumes a measurability-type condition for the Jensen conclusion). If the precise regularity-free statement is absent from all three at the cited loci, that absence is itself the justification sentence the introduction should carry: *"the statement is folklore yet, so far as we can find, unrecorded in the standard references at exactly the point where applied derivations need it."* **Verdict: survivable, but only with the locus check done (Task T8). Do not assert absence without the check.**

**A2. "The quantum subsection is scope creep for the Monthly."**
The Monthly prints cross-field bridges constantly; the risk is not topic but *length and tone*. P7 as written is ~0.75 page, fully cited, and concedes folklore where folklore is due (Holevo). Pressure point: the closing flourish "the derivations cited above spend it exactly there" is checkable against three papers and is true for all three; keep it, but only because it is checkable. **Verdict: keep, at current length, no equations beyond the one display.**

**A3. "You claim novelty for the state-side affinity."**
The patched text does not — it cites Holevo Lemma 1.6.1 and locates the contribution in the *diagnosis of the asymmetry* between preparation-side and measurement-side derivations. This survives **only if** the Holevo lemma number is right (T5) and the sentence "operational folklore" stays. If T5 fails to confirm, fall back to citing Busch's own PRL, which cites the lemma. **Verdict: safe with T5 cleared.**

**A4. "The piecewise corollary is trivial."**
It is — and the original dossier even misstated it (claiming knot-continuity "is not implied"; in fact a single function affine on abutting cells is automatically continuous at the shared knots, and the patch states this correctly; what fails is global affineness). Trivial-but-illuminating is a Monthly genre, and the tent sentence is the payload: it shows the main theorem doing work *inside* a live research question without citing unpublished material. **Verdict: keep; the self-contained phrasing in P8 is the right exposure level.**

**A5. "The irrational-weights remark (P10) may be known."**
Adjacent literature exists: the single-fixed-weight Jensen equation (Daróczy–Páles line; Kuczma) studies which weight *sets* force what. The remark's two-step patching argument is elementary and possibly unrecorded, but "possibly" is not a citation. **Verdict: ship only after the sweep (T9); otherwise cut — the paper loses nothing essential.**

**A6. "Your four (now five) sources — is the taxonomy exhaustive?"**
No, and claiming so would be false: countable (σ-)mixtures assert a strictly stronger identity with its own automatic-regularity phenomena; restricted-pair domains (Reem §6's subtractive spanning) are another axis. P12.3's humility sentence forecloses the attack at the cost of one line. **Verdict: resolved by P12.3.**

**A7. "Attribution table: are you sure *this time*?"**
The corrected rows now match Reem's catalogue verbatim (Cauchy / Darboux ×2 / Fréchet–Banach–Sierpiński / Kormes / Ostrowski–Kestelman) and demote Steinhaus to the tool he supplied. Residual exposure: exact bibliographic data for Kormes, Darboux 1875 & 1880, Kestelman are expected-but-unpinned (T1–T3); and Kuczma's own table should be eyeballed for any divergence from Reem (T4). **Verdict: correct in substance; page-level checks outstanding.**

**A8. "Proposition 5: is the rescaling fix airtight?"**
Yes: replacing a basis vector by a nonzero rational multiple is the standard exchange argument, and the patched text proves the two properties (independence, spanning) it needs in one clause; the optional Reem/Boros footnote shows the device is standard. One residual: the draft must also *use* $h\in(0,1)$ and $1$ consistently downstream (the deathbed computation at $u_1=1,u_2=0,p=h$ needs $h\in(0,1)$ — it has it). **Verdict: closed.**

**A9. "P5's realizability sentence smuggles in a measurable structure."**
The sentence asserts only that masses sweep $[0,1]$ (Sierpiński) and that within-cell values are *prescribed* — which the construction does by fiat. No measurability of $G$ is used anywhere; the unknown function is probed, never integrated. A careful referee will check that the paper never takes an expectation of $G(\xi)$ over more than two atoms of $\xi$'s law — it doesn't; the two-point family is the whole hypothesis. **Verdict: closed, and worth one clarifying clause if space permits ("the unknown is evaluated, never integrated").**

**A10. "The vNM reclassification creates an asymmetry: the zeroth gate is about relations, the other four about functions."**
Correct, and that *is* the point: the gates are ordered by logical priority, and the reclassification makes the order visible (existence → codomain → equation-type → weight-richness). The diagnostic gains, not loses, by the asymmetry. One improvement the referee would accept gladly: a single-line schematic of the five gates in order. **Verdict: closed; optional one-line schematic.**

**A11. Numbering hazard.**
Earlier review notes referenced a "Proposition 9" rigor gap while the present patch targets "Proposition 5." Either the draft was renumbered between versions or two different gaps exist. **Verdict: must reconcile against the actual `.tex` before applying P1 (Task T14). If two gaps exist, P1's fix pattern applies to both, but verify.**

---

## Round 2 — Constructive close

The patched paper is now a different and better object than the draft we started from:

1. **Every theorem is proved at Monthly standard** — Theorem 4's bookkeeping is in (P3), Proposition 5 is repaired (P1), and the calibration argument states its realizability premise (P5).
2. **The scholarship is load-tested** — the attribution table now matches the survey literature it cites, and the one pending bibliography note is resolved with verified data (P2, P11).
3. **The taxonomy is sharper than before the review** — the vNM example, formerly a misfiled liability, is now the zeroth gate and arguably the most instructive paragraph in Section 5 (P4).
4. **The paper gained a second field where the dictionary demonstrably bites** — and not a hypothetical one: three quantum-foundations papers are cited spending regularity hypotheses at exactly the step the dictionary predicts, with one of them (Wright–Weigert) having independently rebuilt Table 1 (P7). Theorem 4 is no longer idle.
5. **The bridge to the broader research program is laid without overclaiming** — the piecewise corollary plus the tent sentence let a future COLT/TMLR paper cite this note as its rigidity engine (P8), and the Aumann sentence tells the referee what genre the result belongs to (P9).

**Recommendation: minor revision.** Priority order before resubmission: T14 (numbering) → P1, P2, P5, P11 (mandatory correctness/scholarship) → T5, T8 (the two checks that gate new prose) → P7, P4, P3 → P8, P9, P12 → P10 only if T9 clears.

---

# Cautious-Work Recheck List

Items that must be verified before the corresponding text ships. Expected values are stated so each check is a 5-minute confirm/deny, not research.

| # | Item | Expected / where to check | Gates |
|---|---|---|---|
| T1 | Kormes, bounded-on-positive-measure | M. Kormes, *On the functional equation $f(x+y)=f(x)+f(y)$*, Bull. Amer. Math. Soc. ~32 (1926); confirm via Reem's bibliography entry [65] or zbMATH | P2, P11 |
| T2 | Darboux 1875 & 1880 exact citations | 1875: Bull. Sci. Math. (composition des forces); 1880: Math. Ann. 17 (théorème fondamental de la géométrie projective); Reem [29],[28] | P2, P11 |
| T3 | Kestelman exact citation | H. Kestelman, Fund. Math. ~34 (1947), 144–147; Reem [64] | P2, P11 |
| T4 | Kuczma §13.2 page-level cross-check | attribution table + local-to-global extension (Thm 13.2.1, p. 353 per Reem) — book in hand | P2, P3 |
| T5 | Holevo Lemma 1.6.1 | *Probabilistic and Statistical Aspects of Quantum Theory*; Busch's PRL cites "Lemma 1.6.1" — confirm number against the edition cited | P7 |
| T6 | Gleason 1957 venue naming | J. Math. Mech. 6, 885–893 (journal later renamed Indiana Univ. Math. J.; some cite the latter) — pick one form, footnote if needed | P7, P11 |
| T7 | Aumann 1964 pages | Econometrica 32(1–2), 39–50 | P9, P11 |
| T8 | Folklore locus check | Aczél–Dhombres (Jensen ch., ~Prop. 3 p. 243), Kuczma §13.2, Aczél 1966 §2.1: is the **regularity-free all-real-weights** affinity statement printed anywhere? Drives the introduction's "unrecorded" sentence | A1, Intro |
| T9 | Prior-art sweep for the irrational-weights remark | Daróczy–Páles single/fixed-weight Jensen equations; Kuczma's weight-set results | P10 |
| T10 | Wright–Weigert volume/pages + Theorem 1 hypothesis list verbatim | Found. Phys. 49 (2019); PDF in hand from this session's search | P7, P11 |
| T11 | arXiv 2603.06211 ("Summing to Uncertainty") publication status | cite as preprint if still unpublished; currently *not* cited in any patch — only relevant if the quantum subsection later expands | — |
| T12 | Entropy chain citations (Tverberg/Lee/Diderrich/Kendall/Borges/Faddeev) | re-verify against Aczél–Daróczy 1975 bibliography; these predate the patches but survive the Section 5 economy pass | P12.2 |
| T13 | McConway 1981 pages | JASA 76(374), 410–414 | P12.2 |
| T14 | Proposition numbering reconciliation | earlier notes say "Proposition 9," this session's draft anchor says "Proposition 5" — diff against the actual `.tex`; if two gaps exist, apply P1's pattern to both | P1 |
| T15 | Lexicographic non-representability citation | Fishburn 1970 or Kreps 1988 (standard counterexample) — add to P4's paragraph if the draft lacks a citation there | P4 |
| T16 | Reem 2017 volume/pages | Aequationes Math. 91 (2017) — confirm at proof stage | P1 fn, P2 fn |

**Standing rule** (the paper's own ethic, enforced on itself): no vestigiality claim about a named work ships without its task cleared; the note cannot afford to commit the misclassification it diagnoses.
