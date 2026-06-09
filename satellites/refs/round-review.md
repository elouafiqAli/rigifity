# Editorial review — Round 1

**Manuscript:** *The continuous-coefficient Jensen equation: A note on vestigial regularity hypotheses*
**Target:** *The American Mathematical Monthly* (MAA / Taylor & Francis), submitted as an Article (expository)
**Files reviewed:** `manuscript-anon.tex`, `cover-letter.tex`, `refs.bib`, `manuscript-anon.bbl`, `.aux`
**Review mode:** adversarial referee pass. Distinctions are kept explicit: **[proven]** = I checked it and it holds; **[error]** = I checked it and it fails; **[conjecture]** = my reasoned suspicion, needs your confirmation; **[verify]** = cannot be settled without the physical source.

This is Round 1 of a multi-round review. It deliberately leads with the one issue that, if I am right, reshapes the paper, then descends to mathematics, citations, and prose. A copy-edit-only pass and a post-fetch citation reconciliation are scoped at the end as Rounds 2 and 3.

---

## Phase 0 — What I confirmed about the Monthly (decides three of your choices)

1. **Double-anonymous review is correct and required.** The Monthly's policy is double-anonymous, so the anonymization machinery in the source (suppressed title page, "Double Blind No Name", removed self-citation) is *right*, not over-engineering. Keep it. One consequence matters below: the self-citation you stripped from the calibration application was load-bearing, and its removal now leaves a claim dangling (see Phase 1, §C).

2. **The reference style is almost certainly wrong. [verify — high priority]** The source declares `\bibliographystyle{vancouver}` and a header comment asserting "NLM Vancouver style, as required by the Monthly." I can find no basis for that. The Monthly defines its house style through the MAA LaTeX Style File + "README Author Instructions" (downloadable via the journal's *Templates and Styleguide*), and the published Monthly reference format is **not** NLM Vancouver (it does not render authors as "Hamel G." or volumes as "1905;60:459-62"). Implication: the entire bibliography likely needs reformatting to the MAA template's bib style before submission. Do not trust third-party aggregators here (one claims "unsrt", another "AMS"); pull the actual style file. **This is a hard blocker — fix before submission.**

3. **A title page + cover letter are mandatory, which you have.** For double-anonymous review the *review copy* must be the anonymous PDF and the title page must be uploadable as a separate item. Your cover letter describes the title page as "page 1" of a combined `manuscript.pdf`. That combined file is fine as the non-anonymous version, but confirm the portal wants (i) anonymous body, (ii) separate title page, (iii) cover letter — three artifacts — and that the file sent to referees carries no identifying page. **[verify]**

A fourth, optional point: the Editor-in-Chief is Annalisa Crannell. "Dear Editor" is perfectly acceptable and arguably safer; naming her is a nice touch but not necessary.

---

## Phase 1 — The dominant issue: the three applications may argue *against* your thesis

This is the part to read first. The core mathematics is fine (Phase 2). The risk is in Section 6 ("Where the trap recurs"), and it is not cosmetic — it goes to whether the paper's central empirical claim is true.

### The thesis, stated precisely

Your argument has two clean halves:

- **(J₂) / (J_Q):** discrete- and rational-coefficient Jensen needs a regularity hypothesis; without one, the Hamel pathology survives. **[proven in the paper — Prop. 5 is correct]**
- **(⋆):** continuous-coefficient Jensen needs *nothing*; the endpoint substitution closes it. **[proven — Thm. 1 is correct]**

The applied payoff — your reason the Monthly should care — is the claim that *real applied derivations produce **(⋆)**, not (J₂)/(J_Q)*, so the regularity hypotheses those authors carry are vestigial. **Everything hinges on the applied derivations actually delivering the continuous-coefficient object.** If an application only delivers the *rational*-coefficient object before its regularity step, then by your own Proposition 5 the regularity hypothesis there is *load-bearing, not vestigial* — and the example refutes your thesis instead of illustrating it.

I believe two of your three examples are on the wrong side of this line.

### A. Expected-utility theory — likely misclassified **[conjecture, high confidence]**

You write that the vNM/Herstein–Milnor derivation produces a utility functional "linear in probability … for all `p ∈ [0,1]`," call that exactly (⋆), and say the endpoint substitution is "the algebraic alternative to the Archimedean axiom."

The problem: in the standard mixture-space derivation, what the independence axiom delivers *before* continuity is linearity over **rational** mixtures only — finitely-iterated mixing reaches dyadic/rational coefficients, i.e. your (J_Q). The **Archimedean / continuity axiom is exactly what upgrades rational-coefficient linearity to real-coefficient linearity.** So:

- Pre-continuity you have (J_Q), not (⋆).
- Theorem 1 *requires* (⋆) — the equation at irrational `p` — as a hypothesis.
- Therefore Theorem 1 **cannot** substitute for the Archimedean axiom; the Archimedean axiom is what *produces* Theorem 1's hypothesis.
- And by your own Prop. 5, at the (J_Q) stage the continuity hypothesis is genuinely needed.

If that reading is right, the paragraph is close to circular: it calls the *thing to be proved* (real-`p` linearity) the *thing you have*, then announces it can be closed without continuity. Either (a) name the precise stage of the Herstein–Milnor argument at which real-coefficient (⋆) is available *without* a continuity/Archimedean axiom — I do not think there is one — or (b) reclassify utility as a case where regularity is **not** vestigial, which would be an honest and still-interesting entry in the dictionary, just with the opposite sign.

### B. Shannon entropy (Khinchin–Faddeev) — likely misclassified **[conjecture, high confidence]**

You claim the recursivity-axiom analysis reduces "in intermediate steps" to functional equations "of (⋆)-form," closed classically by the continuity axiom, and that the endpoint substitution is the continuity-free alternative.

Two objections:

1. **The operative equations in the Faddeev/Khinchin derivation are not (⋆).** The load-bearing steps are (i) `L(n) := H(1/n,…,1/n)` satisfies `L(mn) = L(m)+L(n)`, a *logarithmic Cauchy-type* equation closed by **monotonicity** to give `L(n)=c log n`; and (ii) the "fundamental equation of information." Neither is the affine Jensen equation, and their solutions are *logarithmic/entropic*, not affine.
2. **The target is concave, not affine.** Shannon entropy `−p log p −(1−p)log(1−p)` is strictly concave. An endpoint substitution whose conclusion is *affineness* cannot be the closure tool for a step whose answer is the entropy function. If a genuinely (⋆)-form, genuinely-affine sub-equation appears somewhere in Aczél–Dhombres's treatment, you must point to it by exact location; as written this reads as pattern-matching ("there are functional equations here, continuity is used somewhere, therefore my substitution applies").

A reader with any information-theory background — the Monthly has many — will stop here. Either pin the exact equation + citation, or cut entropy.

### C. Surrogate calibration (resolution axis) — the only genuine (⋆) case, but unverifiable and now unsupported

This is the one application where the structure can actually produce continuous-coefficient (⋆): on an **atomless** probability space the cell mass `p` ranges over *all* of `[0,1]`, so the Bayes-risk identity is tested at every real `p`. Good — that is the real thing. But:

- It is **your own framework**, and the supporting reference was deleted for anonymization (`refs.bib` line 193, "Self-citation entry intentionally removed"). The claim "a two-cell partition computation forces (⋆)" now floats with no citation and no in-paper proof.
- "Forces (⋆)" needs a one-line justification: Bayes risk is generically *concave* in `p`; you must say *why the slack is identically zero* across the whole two-point family here (your "structural property of the setup"), or the reader cannot tell saturation from ordinary Jensen.

Fix: restore support in an anonymized form the Monthly allows — "[Author, manuscript under review]" or a neutral third-person "in a forthcoming partition-theoretic framework" — and add the one sentence that explains the saturation. Do not leave it bare.

### The upshot for Section 6

As currently arranged the rhetoric is upside down: the two famous, checkable examples (utility, entropy) are the weak/misclassified ones, and the single solid example (calibration) is the unverifiable self-referential one. A referee will notice the asymmetry and read it as motivated. **Strongest fix:** demote utility and entropy to a candid "where the trap looks like it should appear but the classical derivation in fact only yields (J_Q), so regularity is *not* vestigial" — that contrast is genuinely illuminating and defends the paper — and build the positive case on calibration (properly supported) plus a clean toy example you can write out in full (a saturated two-point Bayes-risk computation in three lines). That also resolves the long-standing "Section 5/recurrence misclassification" you and I have circled before.

---

## Phase 2 — Mathematical soundness, statement by statement

- **Theorem 1 (main).** **[proven].** Substitution `u₁=M, u₂=0, p=v/M` is valid (`p∈[0,1] ⇔ v∈[0,M]`) and yields `G(v)=G(0)+(G(M)−G(0))v/M`. Genuinely one line, genuinely regularity-free.
- **Corollary 2 (regularity is a conclusion).** **[proven].** Affine ⇒ continuous, monotone, Lipschitz, AC, measurable. Fine.
- **Theorem 3 (strict minimum).** **[proven].** Uses only the single configuration; correct, and the honest note that it is "in principle weaker" than Thm 1 is the right level of care.
- **Theorem 4 (convex domains).** **[proven, but the proof sketch mis-describes itself].** The conclusion is true. But "an inductive argument on the dimension of the affine span … promotes this to a global linear functional" misnames the actual work. Segment-wise affineness gives positive homogeneity; additivity comes from the midpoint case (`p=½`) combined with homogeneity (`φ(v+w)=φ(v)+φ(w)`), and linearity then follows **dimension-free**. The real subtlety is not dimension — it is that `C` need not be a cone, so `φ(v)=G(x₀+v)−G(x₀)` is only defined where `x₀+v∈C`, and extending additivity off that domain is the "bookkeeping." Rewrite the sketch to name *that*, and give a precise locator in Aczél–Dhombres rather than the whole book (see Phase 3, item 9).
- **Proposition 5 (J_Q retains pathology).** **[proven].** Construction is correct: `ℓ(1)=0, ℓ(h)=1` for irrational `h∈(0,1)`, `G=ℓ|_{[0,1]}`; `G` solves (J_Q) by ℚ-linearity, `G(h)=1≠0=G(q)` kills affineness. One nit: "`H` has cardinality `𝔠` and `ℚ∪{1}` is countable" — `1∈ℚ`, so `ℚ∪{1}=ℚ`; drop "`∪{1}`". And you should note in one clause that any basis element can be rescaled by a rational into `(0,1)` while remaining a basis, which is what licenses "contains an irrational `h∈(0,1)`."
- **§5.2 structural mechanism.** **[proven, wording imprecise].** Correct that a Hamel-pathological `G` satisfies (J_Q) but fails (⋆) at the irrationals where ℝ-linearity breaks. The sentence at line 451–454 ("fails at some irrational `p`. So … violates (⋆) at every irrational `p` where the ℝ-linearity defect appears") is logically fine but reads as a slither from "some" to "every"; tighten.

**Net:** the theory is sound. Two expository repairs (Thm 4 sketch, Prop 5 nit), no corrections to any *statement*.

---

## Phase 3 — The citation challenge (per-source, with a fetch protocol)

Context that raises the stakes: your own Acknowledgments disclose that the bibliography was constructed with LLM assistance. LLM-built bibliographies are exactly where fabricated page ranges, wrong section numbers, and plausible-but-false attributions appear. So every locator below must be checked against the physical source, not against another model and not against a search snippet. I could not fetch these (classical papers and three monographs, none on reachable/open domains), so this phase is the **book-by-book, article-by-article checklist with implications** you asked for.

Two kinds of claim are at issue. **(i) Attribution claims** — "hypothesis X suffices, due to [Author Year]." **(ii) Locator claims** — "[§2.1.4]", "[§13.2]", "[§§5.2 and 13.2]". The paper makes *no verbatim quotations* of these sources, so there are no quoted strings to match; the risk is mis-attribution and mis-location, which is subtler and easier to miss.

### Highest-risk items first

**1. Steinhaus 1920 vs. Ostrowski 1929 — probable crossed/duplicated attribution. [conjecture, high]**
The table credits "bounded on a set of positive measure ⇒ affine" to **Steinhaus 1920** and "bounded on `I` ⇒ affine" to **Ostrowski 1929**. But the classically named result *is* the **Ostrowski** theorem: an additive function bounded above on a set of positive measure is linear. Steinhaus 1920 proves the *difference-set* theorem (`E−E` contains an interval when `|E|>0`) — a **tool** used in the proof, not the functional-equation statement. And "bounded on `I`" is a *special case* of "bounded on a positive-measure set" (`I` has positive measure), so it is not an independent classical theorem deserving its own row/author. **Implication if confirmed:** rows 4–5 of Table 1 collapse or get re-labelled — Ostrowski 1929 for the positive-measure result, Steinhaus 1920 cited as the lemma it supplies, and the "bounded on `I`" row folded in as a corollary. This is the citation error most likely to be caught by a referee.

**2. Aczél 1966, "[§2.1.4]" — central to your prior-art positioning. [verify, high]**
You lean on "Aczél's [§2.1.4] contains a dyadic precursor proved with a continuity hypothesis" **four times** (lines 247–249, 294–296, 588–589, 774). If the section number is wrong, your whole "this is folklore, here is exactly where" stance wobbles. Confirm: (a) §2.1.4 exists and concerns the Jensen/affine equation; (b) it really proves the *dyadic* precursor; (c) it really assumes continuity. **Implication if wrong:** re-locate or restate as "Aczél treats the dyadic case (loc. cit.)" without a false pinpoint.

**3. Kuczma 2009, "[§13.2]" and "[§§5.2 and 13.2]". [verify, high]**
Used as the modern textbook anchor for the (J₂) regularity catalogue and for Prop. 5's pathology. Plausible (Kuczma Ch. 13 = convex functions / Jensen convexity; Ch. 5 = Cauchy's equation), but the *exact* subsection numbers must be checked against the 2nd edition (Gilányi), whose numbering differs from the 1985 1st edition. **Implication if wrong:** wrong pinpoints in two places, including the one supporting your only fully-worked pathology.

### Attribution items (verify the statement, not just the existence)

**4. Cauchy 1821 — continuity. [verify, medium].** Cauchy's *Cours d'analyse* establishes that *continuous* solutions of `f(x+y)=f(x)+f(y)` are linear. The table attaches this to the *Jensen* equation (J₂). Defensible via the (J₂)⇔Cauchy reduction you give, but a functional-equations referee may note Cauchy's object was additivity (and the midpoint-convexity framing is Jensen 1906, not Cauchy). Consider a half-sentence acknowledging the reduction.

**5. Darboux 1875 — monotonicity. [verify, medium].** Darboux's "Mémoire sur les fonctions discontinues" treats additive functions that are continuous at a point / monotone / bounded on one side. Confirm the *monotonicity* sufficiency is in fact Darboux's and in this 1875 paper, not a later attribution that Kuczma assigns differently.

**6. Sierpiński 1920 — measurability. [verify, medium-low].** "Sur les fonctions convexes mesurables", Fund. Math. 1 (1920) — measurable additive/convex ⇒ continuous ⇒ linear. This one I am fairly confident is correct, including the convexity framing that matches your context. Still confirm pages 125–129.

**7. Hamel 1905 — the pathology. [verify, low].** Math. Ann. 60 (1905) 459–462, the Hamel-basis construction. Canonical; almost certainly correct. Confirm the page range only.

### Vague or thin locators

**8. Aczél–Dhombres 1989 — cited twice with no locator.** Once for the higher-dimensional "bookkeeping" (Thm 4) and once for the entropy "standard toolkit." Both need a section/page. The entropy one is doubly important because it is currently the *only* support for the contested entropy claim (Phase 1.B).

**9. The application-domain references** (BJM 2006, Tewari–Bartlett 2007, Steinwart 2007, Reid–Williamson 2010/2011, vNM 1944, Herstein–Milnor 1953, Khinchin 1957, Faddeev 1957). The bibliographic data look standard and internally consistent in the `.bbl`. The risk here is not the entries but the *claims made around them* — see Phase 1. Verify Herstein–Milnor is Econometrica **21** (1953) 291–297 and Faddeev's pagination (85–90).

**10. Jensen 1906 is in `refs.bib` but uncited** — so it never reaches the bibliography. A paper centered on Jensen's inequality/equation that never cites Jensen's 1906 original is a small but real gap; cite it at first mention of Jensen's inequality, or delete the dead entry.

### Fetch-and-verify checklist (work through in this order)

| # | Source | Exact claim in the paper | What to check | If it fails |
|---|--------|--------------------------|---------------|-------------|
| 1 | Ostrowski 1929; Steinhaus 1920 | pos.-measure boundedness ⇒ affine (Steinhaus); bounded-on-`I` ⇒ affine (Ostrowski) | Who proved the *functional-equation* result vs. who supplied the *difference-set lemma*; is "bounded on `I`" independent? | Re-attribute to Ostrowski; cite Steinhaus as the lemma; fold/merge rows 4–5 |
| 2 | Aczél 1966 | "[§2.1.4]" = dyadic precursor, continuity hypothesis | Section number, that it is the Jensen/affine eq., dyadic, continuity-assumed | Re-locate or drop the pinpoint; soften all four mentions |
| 3 | Kuczma 2009 (2nd ed.) | "[§13.2]"; "[§§5.2 and 13.2]" | Subsection numbers in the **Gilányi** edition | Fix pinpoints in Table 1 caption and Prop. 5 header |
| 4 | Cauchy 1821 | continuity ⇒ affine | That the result is there and is about additivity | Add the (J₂)⇔Cauchy half-sentence |
| 5 | Darboux 1875 | monotonicity ⇒ affine | Monotonicity sufficiency, this paper, this year | Re-attribute per Kuczma's historical notes |
| 6 | Sierpiński 1920 | measurability ⇒ affine | pp. 125–129; statement | Adjust pages/statement |
| 7 | Hamel 1905 | pathology exists | pp. 459–462 | Adjust pages |
| 8 | Aczél–Dhombres 1989 | higher-dim bookkeeping; entropy toolkit | Precise §/pp. for *each* use | Add locators; if entropy locator absent, this compounds Phase 1.B |
| 9 | Herstein–Milnor 1953; Faddeev 1957 | utility linearity; entropy axioms | vol/pages; that the cited result is the one you invoke | Fix metadata; re-examine the surrounding claim |
| 10 | Jensen 1906 | (uncited) | n/a | Cite at first mention or delete entry |

Where to find them: Aczél (1966), Aczél–Dhombres (1989), Kuczma (2009) — a university library or the publishers (Academic Press / Cambridge / Birkhäuser); check the 2nd-edition numbering for Kuczma specifically. Hamel, Sierpiński, Steinhaus, Ostrowski, Darboux — GDZ (Göttinger Digitalisierungszentrum) and the Polish Fundamenta Mathematica archive hold open scans; Cauchy's *Cours d'analyse* is on Gallica. Kuczma's historical notes (Ch. 13) are the single best cross-check for items 1, 4, 5, 6 at once — read those notes first; they will settle four rows in one sitting.

---

## Phase 4 — Deep prose / wording / chaining pass

The writing is good — controlled, confident, well-paced. The issues are over-hedging, a few garbled sentences, and some terminology exposure.

**Concrete errors**

- **Doubled word, lines 772–773:** "…closed the proof on its own. A / A literature search then confirmed…" — stray "A A". Delete one. (Copy-edit, but it is in the provenance note an editor will read closely.)
- **Garbled claim, lines 413–414:** "**No regularity hypothesis** suffices for (J₂): there exists a non-affine … function …". As written this reads as "none of the regularity hypotheses suffice", contradicting your own table (each *does* suffice). You mean: "*Without any* regularity hypothesis, (J₂) does not force affineness." Rewrite — this is the kind of sentence a referee quotes back at you.
- **MSC mismatch:** manuscript (line 158) lists `39B22, 39B05`; cover letter lists primary `39B22`, secondary `26B25, 91B16, 94A17` (no `39B05`). Reconcile. The cover letter's richer set is better and matches your applications; bring the manuscript into line.

**Over-hedging and repetition (chaining)**

- The "this is folklore / Aczél §2.1.4 / no novelty claimed" point appears at least **four** times (intro detour, Terminology paragraph, §6 opening, provenance note). State it once, cleanly, early, and stop relitigating. The repeated insistence reads as anxiety and, paradoxically, *raises* the reader's doubt about novelty.
- "Why does this material deserve an article in the Monthly?" (concluding remarks) and "Why, then, does this paper exist?" (§6 opening) are the same rhetorical move twice. Keep one. The Monthly likes confidence; a note that asks twice whether it should exist invites the answer.
- "Vestigial" carries the paper and is well-chosen, but it appears in title, abstract (×2), and throughout; thin it slightly so it stays a scalpel rather than a tic.

**Terminology exposure (a real referee risk)**

- In the standard functional-equations literature, **"Jensen's equation" *is* the midpoint form** — your (J₂). Calling (⋆) "the continuous-coefficient Jensen equation" in the *title* stakes idiosyncratic terminology. You half-acknowledge this by naming (J₂) the "discrete-coefficient" form, but add one explicit sentence early: "classically, *Jensen's equation* denotes the midpoint form (J₂); we use *continuous-coefficient Jensen equation* for (⋆) to mark the contrast." This costs one sentence and disarms an otherwise certain referee comment.

**Abstract**

- It mixes author-year ("Hamel, 1905", "Cauchy (1821)") while the body is numeric `[n]`. Abstracts often avoid `[n]`, so this is tolerable, but be deliberate and consistent.
- "the *minimal* tameness conditions" slightly overclaims — they are each *sufficient*; there is no canonical minimal one. "the tameness conditions" is safer.
- Notation load is at the edge of the Monthly's "minimize notation" guidance for abstracts; consider stating the equation in words and keeping only `E[G(ξ)] ≤ G(E[ξ])` as symbols.

**Smaller wording**

- "ℚ∪{1}" (line 559): redundant, drop (see Phase 2).
- The `\,---\,` thin-spaced em dashes are used heavily; check against the MAA template (the Monthly typically sets em dashes unspaced). Cosmetic, but pervasive.

---

## Phase 5 — Mechanics, compliance, and the cover letter

- **`refs.bib` header is from a different journal.** Lines 1–6 say "Expositiones Mathematicae submission" and "Style: `elsarticle-num`", dated 2026-06-07. The manuscript is for the Monthly with `vancouver`, dated 2026-06-09. Leftover. Clean it — and it is a small tell that the bibliography was ported, which reinforces Phase 3's "verify everything."
- **`\bibliographystyle{vancouver}`** — see Phase 0.2. Replace with the MAA template's style.
- **Article vs. Note.** Your core result is, by your own description, "one line." The Monthly runs a Notes section for exactly such gems. The surrounding dictionary + applications give it Article heft, so "Article" is defensible — but decide consciously, and if the applications shrink (Phase 1), "Note" may become the stronger, more honest framing and an easier acceptance.
- **Cover letter is well-built.** It is candid about novelty (good), states the AI disclosure (good and increasingly expected), and gives clean submission metadata. Three tweaks: (i) fix the MSC to match the manuscript once reconciled; (ii) the AI disclosure says the model did "bibliography construction" — given Phase 3, make sure that by submission time you can honestly add "all references were independently verified against primary sources," because an editor reading "LLM built the bibliography" will weight the reference list more skeptically, not less; (iii) consider softening "consistently missed in practice" → the claim is strong and rests on the applications you may be about to demote.
- **`.aux`/`.bbl`** are consistent with the source; nothing structurally broken in compilation. (I did not recompile; if you want, Round 2 can do a clean `pdflatex→bibtex→pdflatex×2` against the actual MAA `.sty` once you drop it in.)

---

## What Rounds 2 and 3 cover

- **Round 2 — line-level copy-edit and template compliance.** Full sentence-by-sentence pass for rhythm and redundancy; reconcile to the MAA LaTeX template (margins, theorem styles, bib style, em-dash convention); clean recompile; abstract word-count check against the 250-word guidance.
- **Round 3 — citation reconciliation.** After you work the Phase 3 checklist, I fold your findings back in: re-attribute rows 4–5, fix the Aczél/Kuczma pinpoints, repair or remove the entropy/utility claims, and re-anchor the calibration support. This is the round that closes out the referee-bait.

## Priority order for your next pass

1. Decide the Section 6 question (Phase 1) — this is the paper's spine and everything else is downstream.
2. Pull the MAA style file; fix the bibliography style and the `refs.bib` header (Phase 0.2, 5).
3. Work the citation checklist, Kuczma Ch. 13 notes first (Phase 3, items 1/4/5/6 in one sitting).
4. Fix the three concrete errors: "A A", the garbled line 413, the MSC mismatch (Phase 4).
5. Add the one terminology sentence and the Thm 4 sketch rewrite (Phases 2, 4).