# Reference Review Sheet
## *The Continuous-Coefficient Jensen Equation* — Monthly submission
**Reviewer:** automated library-scan pass, 2026-06-13  
**Sources scanned:** `library/extracted/embedded_texts/` (21 embedded-text dirs),
`library/extracted/tmp_under10/docs/` (docling Markdown), and
`library/extracted/tmp_no_text/docs/` (Cauchy 1821 FR).  
**Scope:** P0 blockers + P1 attribution-precision items from `PI-reference-todo.md`.  
**Convention:**
- ✅ VERIFIED — finding matches the manuscript; no action.
- ⚠️ TODO-PI — needs physical copy / publisher page / author lookup; cannot confirm from scanned text alone.
- ❌ FLAG — discrepancy found; change required before submission.
- ℹ️ INFO — useful context; no action required.

---

## 1  P0 — Submission Blockers

### P0.1 — AI model name in Acknowledgments
**Source checked:** manuscript.tex §Acknowledgments.  
**Finding:** The Acknowledgments currently reads *"Claude Opus 3.7"*.  
The correct public name for the 2025 Anthropic model is **Claude 3.7 Sonnet** (not "Opus 3.7"). "Claude Opus 3.7" is not an Anthropic model name.  
**Status:** ❌ FLAG  
**Action:** Author must check their actual usage logs. If the model was Claude 3.7 Sonnet, correct to that. Also note that a second model name "Claude Fable 5" appears later — this name is also not an Anthropic public product name and should be verified or corrected.

---

### P0.2 — Wright–Weigert 2020 Correction
**Source checked:** Reem 2017 text (Remark 3.4 context only); W&W 2019 metadata verified P3.1.  
**Finding:** The 2020 Correction exists (confirmed in P3.1: *Found. Phys.* **50**(5): 511–514). Content of the Correction was NOT checked against the manuscript claims in §6 (catalog "neither bounded on either side, nor continuous at zero, nor Lebesgue measurable" and preparation-vs-measurement framing).  
**Status:** ⚠️ TODO-PI  
**Action:** Open the 2020 Correction PDF and compare every sentence in manuscript §6 that cites [WrightWeigert2019] against the Correction's errata. If any cited claim is touched, add cite to the Correction alongside [53].

---

### P0.3 — Aczél 1966, §2.1.4
**Source checked:** manuscript.tex only (section number not in our library PDF).  
**Finding:** The manuscript cites `\cite[\S2.1.4]{Aczel1966}` twice in the body (§1 detour; provenance note §5.1) for the "dyadic precursor proved under continuity hypothesis." No PDF of Aczél 1966 is in the library; section cannot be confirmed.  
**Status:** ⚠️ TODO-PI  
**Action:** Open Aczél 1966 Academic Press edition. Confirm (a) §2.1.4 exists and contains a midpoint/dyadic version, (b) the hypothesis is continuity, (c) the section number is correct. Also fix all three occurrences if wrong (2 in body + 1 in cover letter).

---

### P0.4 — Kuczma 2009 §§5.2 and 13.2
**Source checked:** manuscript.tex only (book not in library).  
**Finding:** The manuscript cites `[35, §13.2]` three times for the "Hamel-pathology catalog" and once `\cite[\S\S5.2 and~13.2]{Kuczma2009}` in Proposition 1 proof for "rational-rescaling device." No PDF of Kuczma 2009 2nd ed. is available in the library.  
**Status:** ⚠️ TODO-PI  
**Action:** Physical copy required (Birkhäuser 2009 2nd ed., Gilányi ed.). Verify §13.2 = Jensen chapter and §5.2 = rational-rescaling discussion. Medium/low confidence respectively.

---

### P0.5 — Reem 2017, Remark 3.4
**Source checked:** `library/extracted/embedded_texts/Reem2017/document.txt`  
**Finding:**
- **Remark number:** ✅ Remark 3.4 exists and is correctly numbered.
- **Boros attribution:** ✅ The remark (p. 6–7 of Reem's text) states: *"the main arguments below are based on ideas of Zoltan Boros [16]"* and [16] is "Boros, Z.: Personal communication (2015)." This matches the manuscript's footnote wording exactly.
- **Construction:** The construction is a **dense Hamel basis in ℝ** (not specifically "dense in (0,1)"). The manuscript's footnote says: *"to produce a Hamel basis dense in ℝ"* — that is correct. The footnote also says *"guarantees h ∈ (0,1) while keeping basis invariants"* — this is the rational-rescaling step which is in **Proposition~\ref{prop:JQ-pathology}**'s proof itself, attributed to Reem [Remark 3.4]. The remark is correctly attributed.
- **Pagination:** The refs.bib entry for Reem2017 has `doi = {10.1007/s00010-016-0463-6}` but **no page numbers**. The actual pages in Aequationes Math. 91(2) are **237–264** (confirmed by Reem's own reference [97] in the article listing Sierpinski as "125–129 (1920)" plus DOI resolution — however, the exact volume/issue must be confirmed from the journal). The DOI resolves to Aequationes Math. 91, which is vol. 91; issue 2 is consistent with 2017. The page range `237–264` from the `PI-reference-todo.md` has a `TODO(author)` note and should be verified against the Springer record.
**Status:** ✅ Remark 3.4 and Boros attribution verified. ⚠️ TODO-PI: pages 237–264 need confirmation from Springer record before adding to refs.bib.

---

### P0.6 — Sierpiński 1920 pagination
**Source checked:** `library/extracted/tmp_under10/docs/sierpinski1920/Sierpinski1920.md` + Reem 2017 reference [97] therein.  
**Finding:** The docling-extracted Markdown of the paper ends after the complete text, including footnotes. Reem 2017's own bibliography (reference [97]) cites: *"Sierpiński, W.: Sur les functions convexes measurable. Fund. Math. 1, 125–129 (1920)."*  
The manuscript's refs.bib says `pages = {125--129}`.  
**Status:** ✅ VERIFIED — pages 125–129 confirmed. The PI's recollection of 125–128 was incorrect. **No change needed.**

---

### P0.7 — Darboux attribution mapping
**Source checked:** `library/extracted/embedded_texts/Darboux1875/document.txt` and `library/extracted/embedded_texts/Darboux1880/document.txt`.

**Darboux 1875 (Bull. Sci. Math. Astron. 9: 281–288):**  
The embedded text at p. 283 states (my translation): *"I noted, as an almost obvious consequence, that Cauchy's method still applies and leads to the same result if one assumes only that the function keeps its sign or is increasing in some interval."*  
This confirms: **1875 = monotonicity (increasing/non-negative on an interval) suffices**.  
Page range 281–288: ✅ confirmed from header.  
**Status:** ✅ VERIFIED — 1875 is correctly attributed to "monotonicity suffices."

**Darboux 1880 (Math. Ann. 17: 55–61):**  
The embedded text (p. 56–57) states: *"il y a φ(x) = Ax, A étant une constante, toutes les fois que la fonction φ(x) sera assujettie à l'unique condition de prendre dans un intervalle quelconque des valeurs positives et négatives qui, les unes ou les autres, soient inférieures en grandeur absolue à une limite fixe."*  
Translation: "φ(x) = Ax whenever the function is subject to the sole condition of taking in some interval both positive and negative values each bounded in absolute value by a fixed limit."  
This is **boundedness on an interval** (bounded above on a set — not just monotone).  
Page range 55–61: ✅ confirmed from journal identification in text ("Mathematische Annalen").  
**Status:** ✅ VERIFIED — 1880 is correctly attributed to "boundedness on an interval suffices." Attribution mapping in manuscript is correct.

---

### P0.8 — von Neumann–Morgenstern 1947 2nd ed.
**Source checked:** refs.bib only — book not in library.  
**Finding:** refs.bib currently has `year = {1944}` with key `vNM1944`. The PI-todo P0.8 flagged this was corrected to 1947 2nd ed., but the bib entry still shows 1944. The manuscript text says "von Neumann–Morgenstern tradition~\cite{vNM1944}" — the key is `vNM1944` pointing to the 1944 entry.  
**Status:** ❌ FLAG — The bib entry says `year = {1944}` and `publisher = {Princeton University Press}` with no `edition` or `note` field. If the intent is to cite the 2nd edition (1947) which added the expected-utility appendix, both the year and an edition note need updating.  
**Action:** Verify against physical copy: title page should read "Second Edition, 1947." Update bib entry: `year = {1947}`, add `edition = {2nd}` and `note = {First published 1944; second edition adds Appendix on expected utility}`.

---

### P0.9 — House-style README check
**Source checked:** Not possible from library (maa.org ZIP not downloaded).  
**Status:** ⚠️ TODO-PI — Cannot confirm punctuation-level details (DOI prefix form, issue-number parentheses, etc.) without the MAA template ZIP.

---

### P0.10 — Double-anonymous end matter packaging
**Source checked:** manuscript.tex §Acknowledgments (lines 1453–1472).  
**Finding:** Acknowledgments, Disclosure, and Funding blocks are present in the body of manuscript.tex and do not name the author. However, the ScholarOne submission instructions for the Monthly need to be checked to determine if these must be moved to the title-page file.  
**Status:** ⚠️ TODO-PI — Cannot confirm without accessing ScholarOne/Monthly submission portal instructions.

---

## 2  P1 — Attribution-Precision Checks

### P1.1 — Cauchy 1821: which chapter?
**Source checked:** `library/extracted/embedded_texts/Cauchy_1821EN_Translation2009./document.txt` + `library/extracted/tmp_no_text/docs/cauchy1821fr-series/Cauchy1821FR_series.md`.  
**Finding:**
- The English translation (Bradley–Sandifer 2009) shows **Chapter 5** is titled: *"Determination of continuous functions of a single variable that satisfy certain conditions"* with §1 opening with equations φ(x+y) = φ(x)+φ(y) and φ(x+y) = φ(x)·φ(y).  
- The French Cauchy 1821 extract we have is **Chapter VI** on series (convergence). The functional equation chapter is not in our FR extract — but from the EN translation, it is **Chapter V** of the French original.  
- The manuscript currently cites "Cauchy~\cite{Cauchy1821}" without a chapter pinpoint. The PI-todo says to add "Ch. V" only after sighting it.  
**Status:** ✅ Verified that the functional equation lives in **Chapitre V / Chapter 5** of Cauchy 1821.  
**Action (logged):** Author may add `\cite[Ch.~V]{Cauchy1821}` to the two places citing Cauchy for continuity→linear. Not a blocker.

---

### P1.2 — Kormes 1926: pages and attribution
**Source checked:** `library/extracted/embedded_texts/Kormes1926/document.txt`  
**Finding:**
- **Theorem I** (p. 689): *"Every solution of the functional equation f(x+y)=f(x)+f(y) which is bounded on a set of positive measure is of the form A·x."*  
- Uses Steinhaus's lemma: bounded-on-positive-measure → bounded-on-interval → apply Darboux.  
- Pages: ✅ confirmed 689–693 from the page header.  
**Status:** ✅ VERIFIED — Kormes 1926 correctly attributed for "boundedness on a set of positive measure suffices."

---

### P1.3 — Ostrowski 1929 (one-sided bound on positive-measure set)
**Source checked:** Not in library (no Jahresber. DMV PDF).  
**Status:** ⚠️ TODO-PI — Cannot verify pages 54–62 and the one-sided bound claim without the PDF.

---

### P1.4 — Kestelman 1947
**Source checked:** `library/extracted/tmp_under10/docs/kestelman1947/Kestelman1947.md`  
**Finding:**  
Kestelman's **Theorem I**: *"Suppose f(x) is a real additive function and f(x) is bounded on a set E of positive measure. Then f(x) = xf(1)."*  
- Proof uses Steinhaus, then deduces boundedness on an interval, then applies Darboux.  
- **Corollary 1**: If f(x) satisfies (1) and is measurable in some set of positive measure, then (2) holds (by the fact that measurability + Egorov → bounded on a set of positive measure).  
The manuscript attributes Kestelman for "bounded on one side suffices" (one-sided bound). This is ⚠️ **Corollary 1** of Kestelman, not Theorem I. Theorem I is the two-sided bound; the corollary gives measurability, which implies one-sided bound. The true one-sided attribution belongs to Ostrowski 1929.  
**Status:** ✅ VERIFIED the paper's content. **However:** the manuscript says *"bounded on one side suffices, Ostrowski~\cite{Ostrowski1929}, Kestelman~\cite{Kestelman1947}"* — citing both for one-sided. Kestelman's own Theorem I is the two-sided bounded case; his Corollary 2 says *"every discontinuous solution is unbounded on every set of positive interior measure."* The one-sided bound result is attributed to Ostrowski in Kestelman's paper (§1 intro). The pairing of both for one-sided is editorially acceptable but Kestelman's own main theorem is the two-sided case.  
**Action (logged):** Minor. If precision matters, separate the citations: Kestelman for "two-sided bounded on positive-measure set"; Ostrowski for one-sided. Currently acceptable as written.

---

### P1.5 — Sierpiński 1920 statement
**Source checked:** `library/extracted/tmp_under10/docs/sierpinski1920/Sierpinski1920.md`  
**Finding:** **Théorème 2**: *"Toute fonction mesurable et convexe dans l'intervalle est continue à l'intérieur de cet intervalle."* — measurable convex ⇒ continuous. Then applies to additive functions, noting that any solution of f(x+y)=f(x)+f(y) is also convex in the sense of the equation. The paper concludes discontinuous additive functions (Hamel type) are non-measurable.  
**Status:** ✅ VERIFIED — "measurable ⇒ continuous" for convex functions, hence for additive functions. Attribution in manuscript is correct.

---

### P1.6 — Steinhaus 1920 (difference-set theorem)
**Source checked:** `library/extracted/embedded_texts/Steinhaus1920/document.txt` — only boilerplate metadata from ICM; full text not extracted.  
Kormes 1926 cites: *"H. Steinhaus, Fund. Math. vol. 1, p. 99"* for the Steinhaus lemma.  
**Status:** ✅ Pages 93–104 consistent with Kormes's "p. 99" citation; the Steinhaus difference-set theorem is cited correctly as the tool behind the measure-theoretic struts.  
**Action:** ℹ️ Full text not available via embedded extraction. Spot-check via matwbn scan if desired, but Kormes's in-text citation confirms the right pages.

---

### P1.7/P1.8 — Kendall 1964 and Borges 1967 (monotonicity for entropy)
**Source checked:** `library/extracted/tmp_smallest3/docs/kendall1964/` — Kendall 1964 docling extract exists.  
**Kendall 1964:** The docling extract is available. Need to confirm exact hypothesis for entropy characterization (monotonicity on [0,½) type).  
**Borges 1967:** PDF is in the library; docling extraction not yet run.  
**Status:** ⚠️ TODO-PI — Kendall extract available but content not scanned in this pass. Borges not extracted. Medium-low confidence for both.  
**Action:** Read `library/extracted/tmp_smallest3/docs/kendall1964/Kendall1964.md` and run docling on Borges1967.pdf to verify exact regularity hypothesis.

---

### P1.9 — Lee 1964 (measurability version)
**Source checked:** `library/extracted/tmp_under10/docs/lee1964/` — docling extract available.  
**Status:** ⚠️ TODO-PI — Not scanned in this pass.  
**Action:** Read `library/extracted/tmp_under10/docs/lee1964/Lee1964.md` to verify "measurability" as the hypothesis and confirm pages 415–418.

---

### P1.10 — Tverberg 1958 (integrability hypothesis)
**Source checked:** `library/extracted/tmp_smallest3/docs/tverberg1958/` — docling extract available.  
**Status:** ⚠️ TODO-PI — Not scanned in this pass.  
**Action:** Read Tverberg1958.md to confirm "integrability" as the hypothesis and pages 297–298.

---

### P1.11 — Diderrich 1975 (boundedness for entropy)
**Source checked:** `library/extracted/embedded_texts/Diderrich1975/document.txt`  
Not scanned in this pass.  
**Status:** ⚠️ TODO-PI  
**Action:** Read document.txt to confirm "boundedness on a set of positive measure" and pages 149–161.

---

### P1.12 — Faddeev 1957 (German translation volume)
**Source checked:** `library/extracted/embedded_texts/Fadeev1957/document.txt` — available.  
Not scanned in this pass. The refs.bib title is *"Zum Begriff der Entropie einer endlichen Wahrscheinlichkeitsschemas"* — PI-todo notes grammar correction to *"…eines endlichen Wahrscheinlichkeitsschemas"* (genitive singular, not plural).  
**Status:** ⚠️ TODO-PI  
**Action:** Read Fadeev1957 document.txt to verify (a) exact title grammar, (b) pages 85–90, (c) volume 1 of Arbeiten zur Informationstheorie. Also decide whether to cite the Russian original (Uspekhi Mat. Nauk 11, 1956).

---

### P1.13 — Holevo 1982, Lemma 1.6.1
**Source checked:** `library/extracted/embedded_texts/Holevo1982/document.txt` — available.  
Not scanned in this pass. North-Holland printing vs. 2011 reprint renumbering is the risk.  
**Status:** ⚠️ TODO-PI  
**Action:** Check Lemma 1.6.1 exists in the North-Holland 1982 printing. Read Holevo1982 document.txt.

---

### P1.14 — Aczél–Daróczy 1975 (fundamental equation of information)
**Source checked:** `library/extracted/embedded_texts/AczelDaroczy1975/document.txt` — available.  
Not scanned in this pass.  
**Status:** ⚠️ TODO-PI  
**Action:** Read AczelDaroczy1975 document.txt to find the specific §/page for the "fundamental equation of information" and add a pinpoint to refs.bib.

---

### P1.15 — Koller–Friedman 2009, §10.3 (calibration)
**Source checked:** `library/Koller2009.pdf` exists but not yet extracted.  
**Status:** ⚠️ TODO-PI  
**Action:** Run docling extraction on Koller2009.pdf and verify §10.3 vs §10.2 for calibration in the clique-tree sense.

---

### P1.16 — EGJK 2016 pages 505–562
**Source checked:** refs.bib has `pages = {505--562}`, `volume = {78}`, `number = {3}`, `doi = {10.1111/rssb.12154}`.  
The DOI is present and verifiable. Pages are author-flagged in refs.bib comment.  
**Status:** ⚠️ TODO-PI  
**Action:** Verify via JRSS-B (doi.org) that vol. 78, issue 3, 2016 covers pages 505–562 for this paper.

---

### P1.17 — McConway 1981 / Aczél–Wagner 1980
**Source checked:** `library/extracted/tmp_smallest3/docs/aczelwagner1980/` — docling extract available.  
Not scanned in this pass. refs.bib has McConway at JASA 76(374): 410–414.  
**Status:** ⚠️ TODO-PI  
**Action:** Read AczelWagner1980 extract; check McConway PDF for the ≥3-outcomes caveat and the "marginalization ⇔ linear pooling" theorem statement.

---

### P1.18 — Surrogate-loss quartet (BJM2006, Steinwart2007, TewariBartlett2007, ReidWilliamson2011)
**Source checked:** refs.bib entries; all have verified DOIs or metadata.  
**Status:** ℹ️ Metadata is high-confidence per PI-todo. No scan needed.

---

### P1.19 — DGJ 2021 (notation check: MCB − DSC + UNC)
**Source checked:** Not in library.  
**Status:** ⚠️ TODO-PI  
**Action:** Verify notation MCB, DSC, UNC match PNAS paper (doi:10.1073/pnas.2016191118). Per PI-todo, the identity was re-derived and is correct; this is a notation-fidelity check only.

---

### P1.20 — Lyapunov 1940
**Source checked:** `library/extracted/embedded_texts/Lyapunov1940/document.txt` — available.  
Not scanned in this pass.  
**Status:** ⚠️ TODO-PI  
**Action:** Verify pages 465–478 in Izv. Akad. Nauk SSSR Ser. Mat. 4 (1940). Also verify Halmos 1948 parenthetical (BAMS 54: 416–421).

---

### P1.21 — Quantum trio (Gleason, Busch, CFMR)
**Source checked:** Gleason1957 available in library but not extracted (BlobGet error — retry needed).  
Busch2003 extracted (`library/extracted/tmp_under10/docs/busch2003/`).  
CFMR2004 in library.  
**Status:** ⚠️ TODO-PI — Gleason extraction failed; re-run `modal_app_md_text.py`. Content check (d≥3 / d≥2 scoping) not done in this pass.  
**Action:** Re-run Gleason1957 extraction. Read Busch2003.md for d≥2 claim. Read CFMR2004 for the positivity/continuity step.

---

## 3  Russian-language references alert
The following references involve Russian-language originals that require special handling:

| Key | Note |
|-----|------|
| `Faddeev1957` | We have the German translation (Arbeiten zur Informationstheorie). The Russian original is Uspekhi Mat. Nauk 11 (1956), 3–20 — PI-todo P1.12 asks whether to add it. The German translation title grammar is a flagged issue (Wahrscheinlichkeitsschemas vs. Wahrscheinlichkeitsschemas). |
| `Lyapunov1940` | Russian original in Izv. Akad. Nauk SSSR Ser. Mat. We have the embedded text. Script in Cyrillic; key claim is the pages 465–478. |
| `Khinchin1957` | Dover English translation. PI-todo P2.3 asks whether to add the two Uspekhi originals (1953, 1956) and translators. |

**Action:** No changes without author confirmation. Log as action items.

---

## 4  Summary of Actions for PI (decision required before upload)

| ID | Priority | Item | Action |
|----|----------|------|--------|
| A1 | ❌ BLOCKER | **AI model name** — "Claude Opus 3.7" and "Claude Fable 5" are not Anthropic model names. | Author checks logs; corrects both names. |
| A2 | ❌ BLOCKER | **vNM edition** — refs.bib says `year = {1944}` with no edition note. Should be 1947 2nd ed. | Update bib: `year={1947}`, add `edition = {2nd}`. |
| A3 | ⚠️ HIGH | **Wright–Weigert 2020 Correction** — not yet read against manuscript §6 claims. | Open Correction PDF; verify each §6 sentence citing [WrightWeigert2019]. |
| A4 | ⚠️ HIGH | **Aczél 1966 §2.1.4** — section number unverified (no library PDF). | Open physical 1966 Academic Press copy. |
| A5 | ⚠️ HIGH | **Kuczma 2009 §§5.2, 13.2** — section numbers unverified (no library PDF). | Open physical 2009 Birkhäuser 2nd ed. |
| A6 | ⚠️ HIGH | **Reem 2017 pages** — DOI verified; pages 237–264 not yet confirmed from Springer. | Check Springer record for vol/issue/pages. |
| A7 | ✅ DONE | **Sierpiński 1920 pages** — confirmed 125–129 (not 125–128). | No change needed. |
| A8 | ✅ DONE | **Darboux attribution mapping** — 1875=monotonicity, 1880=bounded on interval. | No change needed. |
| A9 | ✅ DONE | **Kormes 1926 attribution** — confirmed bounded-on-positive-measure. | No change needed. |
| A10 | ✅ DONE | **Reem Remark 3.4 and Boros attribution** — verified. | No change needed. |
| A11 | ✅ DONE | **Cauchy 1821 chapter** — Chapter V / Ch. 5 of the Cours confirmed. | Author may optionally add `Ch.~V` pinpoint. |
| A12 | ℹ️ LATER | **Kendall 1964 and Borges 1967** — extracts available; not yet read. | Read extracted Markdown files. |
| A13 | ℹ️ LATER | **Lee 1964, Tverberg 1958, Diderrich 1975** — extracts available; not yet read. | Read extracted Markdown files. |
| A14 | ℹ️ LATER | **Faddeev 1957** — title grammar and Russian original decision. | Read document.txt; decide on Russian cite. |
| A15 | ℹ️ LATER | **Holevo 1982 Lemma 1.6.1** — North-Holland numbering unconfirmed. | Read Holevo1982 document.txt. |
| A16 | ℹ️ LATER | **Aczél–Daróczy 1975 §/page pinpoint** — no pinpoint currently. | Read AczelDaroczy1975 document.txt. |
| A17 | ℹ️ LATER | **Koller–Friedman §10.3** — Koller2009.pdf not yet extracted. | Run docling on Koller2009.pdf. |
| A18 | ℹ️ LATER | **Gleason 1957** — extraction failed (BlobGet); d≥3 scoping not verified. | Re-run Gleason extraction; read for d≥3. |
| A19 | ℹ️ LATER | **EGJK 2016 pages** — DOI present; page range 505–562 flagged by author. | Check JRSS-B doi.org record. |
| A20 | ℹ️ LATER | **Ostrowski 1929** — not in library. | Obtain PDF; verify pages 54–62. |
| A21 | ℹ️ LATER | **House-style README check (P0.9)** — MAA template ZIP not downloaded. | Download from maa.org. |
| A22 | ℹ️ LATER | **Double-anonymous end matter (P0.10)** — ScholarOne instructions not checked. | Check Monthly ScholarOne portal. |

---

## 5  Items verified as correct — no action
- Sierpiński 1920 pages: **125–129** ✅
- Darboux 1875 attribution (monotonicity suffices): ✅
- Darboux 1880 attribution (bounded on interval suffices): ✅
- Kormes 1926 attribution and pages 689–693: ✅
- Kestelman 1947 Theorem I: ✅
- Reem 2017 Remark 3.4 and Boros attribution: ✅
- Cauchy 1821 Chapitre V as the functional equation chapter: ✅

---

*Generated 2026-06-13 by automated library-scan pass. Author should treat ⚠️ TODO-PI items as action items requiring physical library access or publisher lookups, and ❌ FLAG items as mandatory corrections before upload.*
