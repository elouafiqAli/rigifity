# PI Reference-Scrutiny Brief — pre-submission verification todo

**Manuscript:** *The Continuous-Coefficient Jensen Equation* (Monthly submission).
**Prepared by:** the review panel, 12 June 2026.
**Scope:** every one of the 53 references, graded for confidence, with the
specific verification action required. Grep the sources for `TODO(author)` —
three such comments are embedded at the exact spots in
`manuscript-anon.tex` / `manuscript.tex` / `refs.bib`.

**Ground rules for this pass.**
1. A citation with a pinpoint (`\cite[§…]{…}`) must be checked against the
   *exact edition* named in the bibliography — section numbering moves between
   editions (Kuczma 1st ed. 1985 vs. 2nd ed. 2009 is the live risk here).
2. A reference that attributes a *hypothesis* ("monotonicity suffices",
   "boundedness on a set of positive measure") must be checked against the
   paper's actual theorem statement, not a survey's paraphrase. The
   dictionary's column 3 is the paper's most checkable — and most attackable —
   surface.
3. Where the panel verified something this session, it is recorded in P3 so
   you do not redo it.

**Verification sources, by venue.** MathSciNet / zbMATH for all journal
metadata; **matwbn.icm.edu.pl** (ICM digital library) for *Fund. Math.*
vols. 1, 3, 34 (Sierpiński ×2, Steinhaus, Kestelman) — full PDFs, settles
pagination in minutes; **GDZ Göttingen / EuDML** for *Math. Ann.* (Hamel 1905,
Darboux 1880) and *Math. Z.* (Borges); **Gallica (BnF)** for *Bull. Sci. Math.
Astron.* (Darboux 1875) and Cauchy 1821 (cross-check against the
Bradley–Sandifer English translation); **SpringerLink** for *Aequationes
Math.* (Reem) and *Found. Phys.* (Wright–Weigert + Correction, CFMR);
publisher pages for PNAS, JRSS-B, JASA, Ann. Statist., PRL; **physical/library
copies** for Aczél 1966, Aczél–Daróczy 1975, Kuczma 2009 (2nd ed.), Holevo
1982 (North-Holland printing), Koller–Friedman 2009, von Neumann–Morgenstern
1947.

---

## P0 — submission blockers (resolve before upload)

**P0.1 — "Claude Opus 3.7" (Acknowledgments).** No Anthropic model was
publicly released under this name; public names from the relevant period are
*Claude 3 Opus* (2024), *Claude 3.7 Sonnet* (2025), *Claude Opus 4* (2025).
Check the project's own logs/records for the exact model string and correct
the Acknowledgments. The cover letter now deliberately defers to the
manuscript so the name lives in exactly one place. A wrong model name in an
AI-disclosure statement is the kind of detail a referee will notice and it
taints trust in everything else. `TODO(author)` comment sits on the line.

**P0.2 — Wright–Weigert Correction.** A published correction exists:
Wright, V. J., Weigert, S. (2020). Correction to: Gleason-type theorems from
Cauchy's functional equation. *Found. Phys.* 50(5): 511–514. Read it against
**every** claim §6 attributes to the 2019 paper — specifically the catalog
"neither bounded on either side, nor continuous at zero, nor Lebesgue
measurable" and the preparation-vs-measurement framing. If the correction
touches any cited claim, cite the correction alongside [53]. (2019 metadata
itself is verified — see P3.1.)

**P0.3 — Aczél 1966, §2.1.4.** Cited twice in the body (§1 detour; provenance
note) and in the cover letter as the *dyadic precursor proved under
continuity*. Confidence in the section number: **low** (plausible but
unverified). Open the 1966 Academic Press edition; confirm (a) the section
number, (b) that the statement there is the dyadic/midpoint version, (c) that
the hypothesis used is continuity. If the result lives elsewhere (e.g.,
§2.1.3 or Ch. 3), fix all three occurrences plus the cover letter.

**P0.4 — Kuczma 2009 pinpoints.** Two distinct pinpoints ride on this book:
`[35, §13.2]` for the Hamel-pathology catalog (3 mentions) and the
Prop. 7 attribution "the rational-rescaling device … is standard
\cite[§§5.2, 13.2]{Kuczma2009}". The bibliography names the **2nd edition
(Gilányi, ed., Birkhäuser 2009)**; section numbers must be checked against
*that* edition, not the 1985 PWN first edition many libraries carry.
Confidence: **medium** for §13.2 (Jensen chapter is plausibly 13), **low** for
§5.2.

**P0.5 — Reem 2017, Remark 3.4.** The manuscript credits "Remark 3.4
(attributing the idea to Z. Boros)" for the dense-Hamel-basis-in-(0,1)
construction. Verify the remark number, the Boros attribution, and the newly
added pagination 91(2): 237–264 (DOI verified; pages from memory —
`TODO(author)` in refs.bib).

**P0.6 — Sierpiński 1920 pagination.** Manuscript says *Fund. Math.* 1:
125–129; the panel's recollection is 125–128. Settle it from the
matwbn.icm.edu.pl scan of vol. 1 (two minutes). `TODO(author)` comment sits
in the inline bibliography.

**P0.7 — Darboux attribution mapping.** The dictionary credits **1875** with
"monotonicity suffices" and **1880** with "boundedness on an interval". Parts
of the survey literature instead credit 1875 with *continuity at a single
point*. The refs.bib comments claim the PDFs were checked — re-verify
directly against Bull. Sci. Math. Astron. 9: 281–288 (Gallica) and Math. Ann.
17: 55–61 (GDZ), because the dictionary's column 3 stakes a historical claim
on this mapping.

**P0.8 — von Neumann–Morgenstern, 1947 2nd ed.** The panel corrected the
entry from 1944 to the 2nd (1947) edition, whose added appendix contains the
expected-utility axiomatization. Confirm against the copy you actually own
(title page: "Second edition", Princeton 1947; appendix "The Axiomatic
Treatment of Utility") so the bibliography matches a physical object.

**P0.9 — house-style README check.** The reference list was rebuilt in
Monthly (T&F-era) house style from observed practice and the MAA Formatting
Reference Guide. Download `American_Math_Monthly_Templates.zip` from maa.org
(the panel's sandbox could not fetch it) and diff the README's reference
examples against ours for punctuation-level details: DOI prefix form
(`doi.org/…` vs `https://doi.org/…`), issue-number parentheses, "ed."
placement, translator credits.

**P0.10 — double-anonymous packaging of end matter.** Acknowledgments
(including the AI disclosure and thanks), the provenance note, and the
Funding/Disclosure block currently sit in the body of **both** files. They do
not name the author, but T&F double-anonymous checklists sometimes require
*all* acknowledgments moved to the title-page file. Check the Monthly's
ScholarOne instructions; if required, cut the Acknowledgments block from
`manuscript-anon.tex` only (one `%`-region is already isolated for this).

---

## P1 — attribution-precision checks (the dictionary's load-bearing column)

Each item: open the source, match the *exact hypothesis* to the manuscript's
claim.

- **P1.1 Cauchy 1821** — continuity ⇒ additive is linear. Verify the chapter
  (the body says "Cauchy (1821)" without pinpoint; consider adding
  "Ch. V" only after sighting it — Cours d'analyse, Première partie, the
  functional-equations chapter).✅ ]
- **P1.2 Kormes 1926** — *boundedness on a set of positive measure* suffices.
  Verify statement + pages 689–693 (BAMS 32).✅ ]
- **P1.3 Ostrowski 1929** — *one-sided* bound on a positive-measure set.
  Verify in Jahresber. DMV 38: 54–62.✅ ]
- **P1.4 Kestelman 1947** — verify which refinement the paper actually proves
  (Fund. Math. 34: 144–147; matwbn scan) and that the dictionary cites it for
  that and nothing stronger.✅ ]
- **P1.5 Sierpiński 1920** — *measurable convex ⇒ continuous*; confirm the
  statement form used (ties into P0.6).✅ ]
- **P1.6 Steinhaus 1920** — difference-set theorem; pages 93–104; cited as the
  engine behind the two measure-theoretic struts. Standard, but sight it.✅
- **P1.7 Kendall 1964** and **P1.8 Borges 1967** — the entropy table credits
  monotonicity-on-[0,½)-type weakenings. Verify each paper's precise
  hypothesis (Z. Wahrsch. 2: 225–229; Math. Z. 96: 282–287) — these two are✅
  paraphrased from the secondary literature. Confidence: **medium-low**.
- **P1.9 Lee 1964** — measurability version of Faddeev's axiomatization (Ann.
  Math. Statist. 35: 415–418). Verify the exact regularity hypothesis.
- **P1.10 Tverberg 1958** — integrability hypothesis (Math. Scand. 6:
  297–298).✅ 
- **P1.11 Diderrich 1975** — boundedness's role (Inform. and Control 29(2):
  149–161).✅ 
- **P1.12 Faddeev 1957** — the German translation volume (*Arbeiten zur
  Informationstheorie I*, pp. 85–90). Verify the volume data and decide
  whether to also cite the Russian original (Uspekhi Mat. Nauk 11 (1956)).
  The corrected title grammar ("…eines endlichen Wahrscheinlichkeitsschemas")
  should be checked against the printed page.✅ 
- **P1.13 Holevo 1982, Lemma 1.6.1** — verify the lemma number in the
  North-Holland printing; the 2011 reprint renumbers. Confidence in "1.6.1":
  **medium**.✅ 
- **P1.14 Aczél–Daróczy 1975** — the "fundamental equation of information"
  cite is chapterless; add a §/page pinpoint after sighting.✅ ]
- **P1.15 Koller–Friedman 2009** — "calibration" in the clique-tree sense,
  cited as §10.3; verify (10.2 vs 10.3 in the MIT Press printing). [✅ ]
- **P1.16 Ehm–Gneiting–Jordan–Krüger 2016** — pages 505–562 and part/issue
  78(3) were already flagged in refs.bib by the author; verify against the
  JRSS-B record (discussion-paper page spans are easy to get wrong).✅ 
- **P1.17 McConway 1981 / Aczél–Wagner 1980** — verify the exact theorems the
  opinion-pool paragraph attributes (marginalization ⇔ linear pooling;
  the ≥3-outcomes caveat) and SIAM JADM 1(3): 259–260. ✅
- **P1.18 Surrogate-loss quartet** — BJM 2006 (classification calibration)✅ ,
  Steinwart 2007 (loss comparison)✅ , Tewari–Bartlett 2007 (multiclass)✅ ,
  Reid–Williamson 2011 (uncertainty-function naming, now cited)✅ . Verify each
  is cited for its actual result; metadata is high-confidence.
- **P1.19 DGJ 2021** — confirm the MCB − DSC + UNC notation matches the PNAS
  paper's (the manuscript's identity was re-derived and is correct; this is a
  notation-fidelity check only).
- **P1.20 Lyapunov 1940** — Izv. Akad. Nauk SSSR Ser. Mat. 4: 465–478,✅ plus
  the parenthetical Halmos 1948 exposition (BAMS 54: 416–421). Verify both.
- **P1.21 Quantum trio** — Gleason 1957 (J. Math. Mech. 6: 885–893)✅ , Busch
  2003 (PRL 91: 120403)✅ , CFMR 2004 )✅(Found. Phys. 34(2): 193–209): metadata
  standard; confirm the d ≥ 3 / d ≥ 2 scoping sentences against the papers
  (the panel checked the mathematics; this is citation-fidelity).

## P2 — bibliographic completeness (polish, not blockers)

- **P2.1** Missing issue numbers, to add *only if verified*: Blackwell 1953
  (Ann. Math. Statist. 24(?)), Herstein–Milnor 1953 (Econometrica 21(?)),
  Murphy 1973 (J. Appl. Meteorol. 12(?)), Lee 1964 (35(?)), Kendall 1964
  (2(?)), Borges 1967 (Math. Z. 96(?)), Kormes 1926 (BAMS 32(?)), Gleason
  1957 (6(?)). House style tolerates volume-only; do not guess.
- **P2.2** DOIs: the Monthly encourages them. Verified DOIs are already on 13
  entries. Candidates to add after lookup: Jensen 1906 (Acta Math.), Hamel
  1905 (Math. Ann.), Steinwart/Busch already done, Savage 1971,
  GneitingRaftery 2007, McConway 1981 (JASA), Aumann 1964, Herstein–Milnor
  (Econometrica/JSTOR), Tverberg (Math. Scand.), Kendall (Z. Wahrsch.).
- **P2.3** Khinchin 1957 (Dover): optionally credit the translators and the
  two Uspekhi originals (1953, 1956) per Monthly practice for translated
  collections.
- **P2.4** Cauchy 1821: optionally add the Bradley–Sandifer 2009 English
  translation as a reader convenience.
- **P2.5** Darboux page ranges (281–288; 55–61): confirm while doing P0.7.
- **P2.6** `ReidWilliamson2010` remains deliberately uncited in refs.bib
  (marked). Delete before archiving the project, or leave — it does not print.

## P3 — verified this session (audit trail; no action)

- **P3.1** Wright–Weigert 2019 = *Found. Phys.* **49**(6): 594–606,
  DOI 10.1007/s10701-019-00275-x (Springer record), and the existence of the
  2020 Correction at **50**(5): 511–514. (Content check of the correction is
  P0.2.)
- **P3.2** Current Monthly Editor: **Annalisa Crannell** (cover letter
  re-addressed accordingly).
- **P3.3** Monthly reference style is alphabetical bracketed-number house
  style, **not** NLM/Vancouver (MAA Formatting Reference Guide + current
  issues); `vancouver.bst` removed from the build.
- **P3.4** Double-anonymous submission requirement, the official templates
  zip, and the revised figure instructions (figures embedded in source;
  monochrome) — all per maa.org, reflected in the cover letter.
- **P3.5** Compile state: both manuscripts build clean (0 errors,
  0 undefined citations, 0 overfull boxes); 18 pp anon / 19 pp full;
  ≈7,000 words; 53 references.

---

## Full reference ledger (53 entries)

Confidence: **H** = high (standard/verified), **M** = medium (plausible,
sight the record), **L** = low (must verify before submission).
"Pin" = a chapter/§/page/remark pinpoint is load-bearing in the text.

| #   | Key                    | Conf                                      | Pin                 | Action                   |
| --- | ---------------------- | ----------------------------------------- | ------------------- | ------------------------ |
| 1   | Aczel1966              | H(book) / **L(§2.1.4)**                   | yes                 | P0.3 ✅                   |
| 2   | AczelDaroczy1975       | H(book) / M(claim)                        | yes                 | P1.14 add §✅             |
| 3   | AczelDhombres1989      | H                                         | no                  | none                     |
| 4   | AczelWagner1980        | H                                         | no                  | P1.17 theorem check ✅    |
| 5   | Aumann1964             | H                                         | no                  | P2.2 DOI optional        |
| 6   | BaezFritzLeinster2011  | H                                         | no                  | none (open access)       |
| 7   | BJM2006                | H                                         | no                  | P1.18                    |
| 8   | Blackwell1953          | H                                         | no                  | P2.1 issue optional      |
| 9   | Borges1967             | **M**                                     | claim               | P1.8 hypothesis⚠️        |
| 10  | Brocker2009            | H                                         | no                  | none                     |
| 11  | Busch2003              | H                                         | no                  | P1.21                    |
| 12  | Cauchy1821             | H(book) / M(claim)                        | desirable           | P1.1⚠️                   |
| 13  | CFMR2004               | H                                         | no                  | P1.21                    |
| 14  | Darboux1875            | **M (attribution)**                       | claim               | P0.7✅                    |
| 15  | Darboux1880            | **M (attribution)**                       | claim               | P0.7✅                    |
| 16  | DeGrootFienberg1983    | H                                         | no                  | none                     |
| 17  | Diderrich1975          | M                                         | claim               | P1.11⚠️                  |
| 18  | DGJ2021                | H                                         | no                  | P1.19 notation           |
| 19  | EGJK2016               | M(pages)                                  | no                  | P1.16 (author-flagged)   |
| 20  | Faddeev1957            | M                                         | pages               | P1.12⚠️                  |
| 21  | Fishburn1970           | H                                         | no                  | none                     |
| 22  | Gleason1957            | H                                         | no                  | P2.1 issue optional      |
| 23  | GneitingRaftery2007    | H                                         | no                  | P2.2 DOI optional        |
| 24  | GrunwaldDawid2004      | H                                         | no                  | none                     |
| 25  | Hamel1905              | H                                         | no                  | P2.2 DOI optional        |
| 26  | HersteinMilnor1953     | H                                         | no                  | P2.1 issue optional      |
| 27  | Holevo1982             | H(book) / **M(Lemma 1.6.1)**              | yes                 | P1.13⚠️                  |
| 28  | Jensen1906             | H                                         | no                  | P2.2 DOI optional        |
| 29  | Kendall1964            | **M**                                     | claim               | P1.7 hypothesis          |
| 30  | Kestelman1947          | M                                         | claim               | P1.4                     |
| 31  | Khinchin1957           | H                                         | no                  | P2.3 optional            |
| 32  | KollerFriedman2009     | H(book) / M(§10.3)                        | yes                 | P1.15 ⚠️                 |
| 33  | Kormes1926             | **M**                                     | claim+pages         | P1.2 / P2.1 ⚠️           |
| 34  | Kreps1988              | H                                         | no                  | none                     |
| 35  | Kuczma2009             | H(book) / **L(§5.2, §13.2)**              | yes                 | P0.4 ✅                   |
| 36  | Lee1964                | M                                         | claim               | P1.9⚠️                   |
| 37  | Lyapunov1940           | M                                         | no                  | P1.20                    |
| 38  | McConway1981           | H                                         | no                  | P1.17                    |
| 39  | Murphy1973             | H                                         | no                  | P2.1 issue optional      |
| 40  | Ostrowski1929          | M                                         | claim               | P1.3                     |
| 41  | Reem2017               | H(DOI) / **M(pages)** / **L(Remark 3.4)** | yes                 | P0.5 ⚠️                  |
| 42  | ReidWilliamson2011     | H                                         | no                  | P1.18                    |
| 43  | Savage1971             | H                                         | no                  | P2.2 DOI optional        |
| 44  | Schervish1989          | H                                         | no                  | none                     |
| 45  | Sierpinski1920         | H(work) / **M(pages)**                    | claim               | P0.6 / P1.5 ⚠️           |
| 46  | Sierpinski1922         | H                                         | no                  | none                     |
| 47  | Solovay1970            | H                                         | no                  | none (verified standard) |
| 48  | Steinhaus1920          | H                                         | no                  | P1.6 sight               |
| 49  | Steinwart2007          | H                                         | no                  | P1.18                    |
| 50  | TewariBartlett2007     | H                                         | no                  | P1.18                    |
| 51  | Tverberg1958           | M                                         | claim               | P1.10 ⚠️                 |
| 52  | vNM1944 (1947 2nd ed.) | H(fact) / M(printing)                     | edition             | P0.8 ⚠️                  |
| 53  | WrightWeigert2019      | **H (verified)**                          | claim vs Correction | P0.2 ⚠️                  |

**Bottom line for the PI.** Ten P0 items stand between this manuscript and
the upload button; the heaviest are the four *pinpoint* verifications
(Aczél §2.1.4, Kuczma §§5.2/13.2, Reem Remark 3.4, Sierpiński pagination),
the two *attribution* checks (Darboux mapping, Wright–Weigert Correction),
and the *disclosure* fix (model name). Everything in P1 is a half-day in a
good library plus matwbn/GDZ/Gallica; nothing in P2 blocks submission.
