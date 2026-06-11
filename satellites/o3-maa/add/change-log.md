# Change Log — Final Monthly Manuscript Build (2026-06-11)

Source: `manuscript-anon.tex` / `refs.bib` (uploaded 2026-06-10 build) →
`manuscript-anon-final.tex` / `refs.bib` / `manuscript-anon-final.bbl` / PDF.
All 24 edits applied with single-anchor verification; final build compiles with
zero errors, zero undefined references, zero `??`.

## A. Correctness repairs

1. **Proposition 7 (was 5) — Hamel construction.** The invalid inference
   "cardinality 𝔠 ⇒ basis element in (0,1)" is replaced by the rational-rescaling
   exchange: pick any non-unit basis element h′ (necessarily irrational), replace
   it by qh′ ∈ (0,1). A footnote records why cardinality alone fails and cites
   Reem, Remark 3.4 (after Z. Boros) for the standard rescaling device.
2. **Theorem 6 (was 4) — convex domains.** The proof sketch deferring to
   Aczél–Dhombres is replaced by the full half-page bookkeeping proof
   (real homogeneity → restricted additivity → cone extension → linear
   functional on span(C−C)), with the continuum-of-weights step flagged as the
   only non-bookkeeping step. The Aczél–Dhombres/Kuczma citations survive as a
   "compare the regularity-laden treatments" pointer.
3. **Calibration example — realizability.** New sentences: masses sweep [0,1]
   by Sierpiński's intermediate-value theorem, within-cell values are prescribed
   independently, so every triple (u₁,u₂,p) is realized — (⋆) is asserted on its
   entire domain; and G is only ever evaluated, never integrated, so the
   probabilistic scaffolding smuggles no measurable structure onto G.

## B. Attribution repairs (Table 1 + intro + abstract)

4. **Positive-measure row:** Steinhaus → **Kormes (1926)** [Bull. AMS 32,
   689–693, Theorem I — verified from the uploaded PDF]; one-sided version
   credited to Ostrowski (1929) and Kestelman (1947).
5. **Bounded-on-interval row:** Ostrowski → **Darboux (1880)** [Math. Ann. 17,
   55–61 — verified from the uploaded PDF; the monotonicity row's Darboux (1875)
   was already correct].
6. **Steinhaus** demoted to what he supplied: the difference-set theorem as the
   *tool* behind the measure-theoretic rows (caption note + intro sentence),
   with Reem (2017) cited as the historical survey.
7. **`Darboux1875` BibTeX entry corrected** — it pointed at the wrong paper
   ("Mémoire sur les fonctions discontinues", Ann. Sci. ÉNS). Now: *Sur la
   composition des forces en statique*, Bull. Sci. Math. Astron. 9 (1875),
   281–288 (verified from the uploaded PDF).
8. Abstract and §3.2 date ranges updated: "Cauchy (1821) to Ostrowski (1929)" →
   "to Kestelman (1947)".

## C. Taxonomy repair (the Section 5 misclassification)

9. **vNM/expected-utility example reclassified.** No longer "of the first
   kind": the failure is at a new **zeroth gate** — absent the Archimedean
   axiom no real-valued U exists, so (⋆) is vacuous, not rationally restricted.
10. **Diagnostic restructured** into an ordered two-step (zeroth: existence;
    then: which weights), subsection retitled "…and the questions that separate
    them", intro bullet 3 and §5.5 updated to match, plus an explicit
    non-exhaustiveness sentence (σ-mixtures named).

## D. New mathematical content

11. **Remark 4 (Irrational weights alone suffice)** — full proof via the
    p=√2/2, ε/M=√3/n patching argument; no novelty claim made.
12. **Corollary 5 (Piecewise saturation)** — (⋆) per cell ⇒ piecewise affine
    and automatically continuous (single function, shared knot values), global
    affineness failing; closes with the self-contained tent-shape sentence that
    welds the note to the calibration program without citing unpublished work.
13. **Quantum example (§5.3)** — mixture-affine assignments on density
    operators as a second Source-4 instance consuming Theorem 6. Honest
    framing: the affine representation is folklore (Holevo, Lemma 1.6.1, as
    cited by Busch's own PRL); the contribution is the diagnosis that
    measurement-side Gleason-type routes (finite mixing → rational homogeneity)
    must purchase rational→real with positivity (Gleason; Busch; CFMR) or, per
    Wright–Weigert's explicit Cauchy treatment, the rows of Table 1 —
    "rediscovered inside physics."

## E. Positioning

14. **Aumann lineage sentence** (§1.3): atomless continuum of traders retiring
    preference convexity (Econometrica 32, 39–50 — verified from uploaded PDF)
    as the distinguished ancestor of the paper's pattern.
15. **Conclusion**: the dictionary's asymmetry shown live in the Gleason-type
    literature ("the two columns of Table 2, alive in a single literature").
16. **Citation precision**: scalar atomless-range uses now cite Sierpiński 1922
    (Fund. Math. 3, 240–246 — verified, incl. in the toy's "Sierpiński's theorem
    again"), with Lyapunov retained as the vector-valued descendant.

## F. Bibliography & build

17. Added (all data verified except where flagged): Darboux1880, Kormes1926,
    Kestelman1947, Sierpinski1922, Reem2017, Aumann1964, Gleason1957,
    Holevo1982, Busch2003, CFMR2004, WrightWeigert2019. Removed the
    AczelWagner1980 "verification pending" note (SIAM JADM 1(3), 259–260
    confirmed). Header updated (was still labeled "Expositiones Mathematicae").
18. Hand-maintained `manuscript-anon-final.bbl` in the existing Vancouver
    format, 37 entries in first-citation order (the official `vancouver.bst`
    is not in this TeX installation; regenerating via BibTeX at submission
    will reproduce it).
19. `maa-monthly.sty` here is a **local compilation shim** (loudly labeled in
    its header) loading the package set the real style declares; swap in the
    official MAA file for the submission build. Shim build: 18 pp;
    official-style estimate ≈ 11 pp body (word count 3.4k → ≈4.2k).
20. Cover letter: date, counts, and one quantum-example sentence updated.

## G. Remaining proof-stage tasks (do not gate submission)

- **T16** Reem 2017 volume/pages: vol. 91 confirmed; add page range at proof.
- **T10** Wright–Weigert 2019: vol. 49 + DOI cited; add pages at proof.
- **T5** Holevo Lemma 1.6.1: cited as Busch's own PRL cites it; confirm the
  lemma number against the 1982 North-Holland edition at proof.
- **T4** Kuczma §13.2 page-level cross-check (book in hand).
- **T8** Folklore-locus check (Aczél–Dhombres Prop. 3 p. 243 vicinity) backing
  the intro's hedged "does not appear in this exact form" sentence — current
  wording already survives either outcome.
- **T9** Optional sweep of Daróczy–Páles fixed-weight literature for Remark 4 —
  the remark claims no novelty, so a hit costs only a citation, not a retraction.
- Gleason 1957 cited as J. Math. Mech. 6, 885–893 (journal later renamed
  Indiana Univ. Math. J.; some venues prefer the latter form).
