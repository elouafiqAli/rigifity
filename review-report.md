# Review Panel Report — *The Continuous-Coefficient Jensen Equation: How Real Mixing Weights Retire Regularity*

**Manuscript under review:** `manuscript-anon.tex` (primary focus), with `manuscript.tex`, `refs.bib`, `cover-letter.tex` synchronized afterward.
**Target venue:** *The American Mathematical Monthly* (Article, double-anonymous).
**Date:** 12 June 2026.

> **Framing note.** This is a *simulated* panel: three reviewer personas channeling
> the public mathematical sensibilities of John Horton Conway (1937–2020, reviewed
> here *in memoriam* and in spirit), Roger Penrose, and Paul Seidel. Nothing below
> is a quotation of, or endorsement by, any real person. The personas were chosen
> to force three genuinely different reading protocols onto the same text:
> play/concreteness, geometry/illustration, and rigor/literature-precision.

---

## 0. Verdict

**Accept direction: revise and submit.** The mathematics is correct (every proof
was re-derived and checked line by line; see §5), the expository architecture is
genuinely Monthly-shaped (one-line theorem → dictionary → mechanism → field
guide), and the figures are unusually good. The panel found **no false theorem**
but did find: one sign bug in a proof, one invalid inference (dense graph ⇒
non-measurable), one mis-stated normalization (Shannon entropy), one redundant
axiom list (vNM), one imprecise set-theoretic claim (Solovay), a garbled key
sentence (Wright–Weigert), a notation clash (H as Bayes envelope *and* as mixing
measure), an over-long abstract, an identity leak in the anonymous file's header,
a wrong reference style ("Vancouver, as required by the Monthly" — the Monthly
does **not** use Vancouver), an uncited Jensen (1906) in a paper about Jensen's
equation, and a cover letter whose page/word counts were off by ~60%. All fixed;
changelog in §4.

---

## 1. Reviewer A — *in the spirit of J. H. Conway* (copy, concreteness, play)

**Overall.** The paper passes the Conway test: there is a real toy at the center
(one substitution, visible in the abstract), the prose plays fair with the
reader, and the section titles ("a field guide to saturated Jensen") earn their
whimsy. The reviewer insisted the abstract *keep the proof in it* — an abstract
that proves its own theorem is the rarest of pleasures — and the trim performed
for the 250-word limit preserves it.

Specific findings (all addressed):

1. **Sign bug, Proposition 7 (Hamel construction).** "Choose a rational $q>0$
   with $h:=qh'\in(0,1)$" silently assumes $h'>0$; a Hamel basis element can be
   negative. Fixed to *nonzero* rational $q$, with the one-line reason
   (rational multiples of $h'$ are dense in $\mathbb{R}$). A wrong sign in a
   construction is exactly the thing a bright student will catch and a referee
   will tut about.
2. **Unjustified irrationality, Remark 5.** The remark asserts
   $\tfrac{\sqrt3}{n}-\tfrac{\sqrt6}{2n}$ is irrational without saying why. Now
   carries the cute witness: $(2\sqrt3-\sqrt6)^2 = 18-12\sqrt2 \notin \mathbb{Q}$.
   (Checked: $12+6-4\sqrt{18} = 18 - 12\sqrt2$. Correct.)
3. **Endpoint cases, Remark 5.** The two trivial cases $v\in\{0,M\}$ were
   silently skipped; one clause now covers them.
4. **Concrete witness for the dense graph.** Rather than asserting "oscillates
   wildly", the proof now exhibits it: $G$ takes the value $r$ on the dense set
   $(q+rh)_{q\in\mathbb{Q}}\cap[0,1]$ for every rational $r$. A pathology you
   can point at.
5. **Tone.** "Standard interval-domain constructions often overlook this domain
   trap" reads as a dig at colleagues; softened to "It is easy to overlook this
   domain point." Likewise "have been steadily conflated for over a century"
   softened — the paper's own §5 concedes the conflation claim is subtler.
6. **Approved as-is:** the title's alliteration; "Why does this material deserve
   an article in the Monthly?" as a section-opening question; the footnoted
   coinage *expectation-exact*; the closing line "The present paper is the
   scaffolding."

## 2. Reviewer B — *in the spirit of R. Penrose* (illustrations, geometry, the quantum section)

**Overall.** The three figures are the paper's secret weapon and they are
*arithmetically honest* — the reviewer recomputed every coordinate:

- **Fig. 2(b), the weight axis:** the marked irrational $1/\sqrt2$ is plotted at
  $6.6 + 5.8\cdot 0.7071\ldots = 10.701$ — exactly where the source puts it. The
  rational comb is a fixed, believable comb.
- **Fig. 3(b), tents:** apex of $T_\theta$ at $u=\theta$ (since
  $u(1-\theta)=(1-u)\theta \iff u=\theta$); plotted apex heights
  $0.55+5.2\cdot 2\theta(1-\theta)$ give $2.734$ for $\theta\in\{0.3,0.7\}$ and
  $3.15$ for $\theta=\tfrac12$ — matching the drawn coordinates. The dashed
  Brier curve $0.55+5.2\,t(1-t)$ uses the *same* vertical scale, so the picture
  is quantitatively, not just qualitatively, true.
- **The mixture identity in the label** was verified:
  $\int_0^1 T_\theta(u)\,d\theta = 2\big[(1-u)\int_0^u \theta\,d\theta +
  u\int_u^1 (1-\theta)\,d\theta\big] = u(1-u)$. Correct.

Changes required (all made):

1. **Figures overflowed the text block** by ≈25 pt (two of three). The Monthly's
   revised figure instructions want figures inside the measure; all three are
   now wrapped in `\resizebox{\linewidth}{!}` (uniform ≈95% shrink; labels
   remain crisply legible). Compile shows zero overfull boxes.
2. **Fig. 1(b) ghost struts:** four dashed "removed" struts, only two labeled —
   visually it read as if two struts had a different status. All four now carry
   the rotated "removed" label, restoring the symmetry with panel (a)'s five
   labeled struts (the fifth position being the solid "Theorem 1" pedestal: a
   lovely touch, kept).
3. **Tables fought their own typography:** booktabs rules *and* vertical bars.
   Verticals removed from both tables (booktabs doctrine; matches Monthly
   practice).
4. **The quantum paragraph** — checked with care, since this is where a physics
   reviewer lives: Gleason's theorem correctly restricted to $d\ge3$; Busch's
   POVM version correctly stated for all $d\ge2$; the
   measurement-side/preparation-side asymmetry is a *correct and genuinely
   illuminating* reading of that literature. But the key sentence about
   Wright–Weigert was garbled English ("can be bounded on neither side,
   continuous at zero, nor Lebesgue measurable"); repaired to "can be *neither*
   bounded on either side, *nor* continuous at zero, *nor* Lebesgue
   measurable", and "tests it only additivity-wise" / "classical analog mixing"
   replaced with "tests it only through additivity" / "the classical
   randomizer" (the paper's own earlier term).
5. **Flag, not fix:** Wright & Weigert published a **Correction**
   (*Found. Phys.* **50**(5): 511–514, 2020). The author must check the
   correction against every claim attributed to the 2019 paper. → PI list, P0.

## 3. Reviewer C — *in the spirit of P. Seidel* (rigor, precision, literature)

**Overall.** The mathematics survives a hostile read. The reviewer re-derived
Theorem 4 (convex domains) in full: well-definedness of $\hat A$ on the cone
$D^{*}=\bigcup_{\lambda>0}\lambda D$ (uses $sD\subseteq D$, $s\in[0,1]$, which
holds since $0\in D$ and $D$ convex — stated), the upgrade of midpoint
additivity to additivity on $D^{*}$, and the identity
$\operatorname{span}(C-C)=D^{*}-D^{*}$ (a convex cone minus itself is a
subspace; both inclusions check). Proposition 8's hypothesis quantification and
the Sierpiński atomless intermediate-value step are correct. The Faddeev
functional-equation domain $\{(x,y)\in[0,1)^2 : x+y\le 1\}$ keeps
$y/(1-x)\in[0,1]$ — correct.

Errors and imprecisions found (all fixed):

1. **Invalid inference, Proposition 7.** "Graph dense in $[0,1]\times\mathbb{R}$,
   violating every single regularity condition of Table 1 simultaneously" — a
   dense graph rules out continuity, monotonicity, and boundedness, but **not**
   measurability or boundedness-on-a-positive-measure-set (a function equal to
   0 a.e. can have dense graph). The conclusion is true but needs the table
   itself: any hypothesis of column 1 would, by column 2, force affineness —
   contradiction. Rewritten exactly so. This is the difference between a
   *Monthly* proof and hand-waving.
2. **Solovay, stated precisely.** "Without [choice]… one cannot prove the
   existence of non-affine solutions" overstates (and hides the inaccessible-
   cardinal subtlety). Replaced by the model-level statement that is plainly
   true as written: *in Solovay's model of* ZF+DC *every set of reals is
   Lebesgue measurable, so there every solution of the Cauchy or Jensen
   equations is affine.*
3. **Shannon-entropy normalization.** "Normalized such that $f(0)=f(1)=0$" does
   not pin the scale (every multiple satisfies it). Replaced by Faddeev's
   actual normalization $f(\tfrac12)=1$.
4. **vNM axiom list.** "Complete, transitive, independent, mixture-continuous,
   *and* Archimedean … these five conditions" double-counts the continuity
   axiom (mixture continuity *is* the Archimedean-type condition in this
   tradition). Now: "…independent, and continuous in the Archimedean
   (mixture-continuity) sense", with "these conditions"; the long parenthetical
   on the Archimedean axiom trimmed. The lexicographic counterexample and the
   zeroth-gate analysis — the paragraph's real content — are correct and kept.
5. **Edition error.** The expected-utility axiomatization is in the **appendix
   added to the 1947 second edition** of von Neumann–Morgenstern, not the 1944
   first edition. Bibliography entry corrected (year 1947, 2nd ed., with an
   explanatory note); verify the printing on file → PI list.
6. **Notation clash.** $H$ was simultaneously the conditional Bayes envelope
   $H(u)$ and the mixing measure in $\int T_\theta\,dH(\theta)$, in the *same
   subsection*. Mixing measure renamed $\nu$ (text + figure caption).
7. **Theorem statement hygiene.** "No regularity hypothesis … is required" is
   commentary, not mathematics; moved out of Theorem 1's statement into the
   following sentence ("The hypothesis list deserves a second look: …").
8. **Corollary 2:** an affine function on $[0,M]$ is globally Lipschitz;
   "locally Lipschitz" weakened the (already proven) conclusion. Fixed.
9. **Abstract:** 285 words against the template's ≤250 guideline; rewritten to
   ≈240 while *keeping* the proof and the entropy/calibration pair.
10. **MSC inconsistency:** manuscript said "39B22, 39B05"; cover letter said
    "Primary 39B22; Secondary 26B25, 91B16, 94A17". Harmonized to the latter
    (richer and accurate) in both.
11. **Reference style.** The source claimed "NLM Vancouver style, as required
    by the Monthly". The Monthly has **never** used Vancouver. The MAA's own
    formatting guide prescribes bracketed numbers and encourages DOIs; current
    (Taylor & Francis–era) Monthly issues use **alphabetical, numbered**
    entries of the form `Surname, I. I. (Year). Title. Journal. Vol(issue):
    pp–pp.` The bibliography was rebuilt by hand in exactly that style
    (53 entries, alphabetical, `thebibliography` typeset by `maa-monthly.sty`'s
    own `[n]` machinery); `vancouver.bst` removed from the build; `refs.bib`
    retained as corrected canonical data. One residual check (entry punctuation
    vs. the README in the official templates zip) → PI list.
12. **Citation hygiene.** Jensen (1906) was in the database but *never cited* —
    in a paper about Jensen's equation. Now cited at the first mention of
    Jensen's inequality. Reid–Williamson (2011) added to the
    uncertainty-function naming list, where it belongs; Reid–Williamson (2010)
    remains deliberately uncited (noted in `refs.bib`).
13. **Repetition.** The "Aczél §2.1.4 dyadic precursor" parenthetical appeared
    three times in the body; the Terminology-paragraph copy trimmed (the claim
    survives, twice, where it is load-bearing).
14. **Double-anonymity leak.** The *anonymous* file's comment header named the
    author and an internal path (`satellites/o3-maa/...`). Scrubbed from
    `manuscript-anon.tex` (author line retained in `manuscript.tex` only;
    internal path removed from both). `\author{Double Blind No Name}` would
    have *printed a placeholder name* under the title; replaced with
    `\author{}` (verified safe: the class prints `\@author\strut`).
15. **Disclosure naming.** No Anthropic model was publicly released as
    "Claude Opus 3.7". The panel does not know what the author's records say,
    so the text is unchanged, but a `TODO(author)` comment now sits beside the
    line and the item is **P0** on the PI list. The cover letter now defers AI
    specifics to the manuscript's Acknowledgments so a possibly-wrong name is
    not duplicated.

## 4. Consensus changelog (applied; all asserted-unique replacements)

**Body (both `manuscript-anon.tex` and `manuscript.tex`):**
abstract rewritten (≈240 w); MSC line harmonized; Jensen 1906 cited;
"steadily conflated" softened; Theorem 1 meta-sentence moved out;
Cor. 2 "locally Lipschitz"→"Lipschitz"; Remark 5 endpoint clause +
irrationality witness; Prop. 7 Solovay precision, nonzero-$q$ fix,
footnote tone, dense-graph/column-2 argument; Faddeev normalization
$f(\tfrac12)=1$; vNM axiom list + "five"→— + Archimedean parenthetical
trimmed; $dH(\theta)\to d\nu(\theta)$ (text + caption);
Reid–Williamson 2011 cited; Wright–Weigert sentence repaired
("neither…nor…nor", "through additivity", "classical randomizer");
Terminology repetition trimmed; AI-disclosure TODO comment;
**bibliography replaced** with 53-entry Monthly-style
`thebibliography`; build comments updated (no BibTeX).
**Figures/tables:** all three TikZ figures wrapped in
`\resizebox{\linewidth}{!}` (overfull boxes: 3 → 0); fig. 1(b) ghost
struts all labeled; vertical rules removed from both tables.
**Anonymity:** anon header scrubbed of author + internal path;
`\author{}`.
**`refs.bib` (canonical data):** Faddeev "einer"→"eines"; vNM →
1947 2nd ed. + note; Jensen → J. L. W. V.; Wright–Weigert + (6):
594–606 **(verified)** + 2020-Correction note; Reem + 91(2): 237–264
(flagged to verify); Reid–Williamson 2010 marked uncited; header no
longer claims Vancouver.
**`cover-letter.tex`:** addressed to Professor Annalisa Crannell
(current Editor — verified 2026-06-12); page count corrected to 18
(anon) / 19 (with title page); word count corrected to ≈7,000 (was
4,200); figures/tables and reference-style lines added; AI specifics
deferred to the manuscript; date 12 June 2026; vector Times.

## 5. Verified-correct ledger (panel re-derivations; **no change needed**)

Theorem 1 and Theorem 3 (endpoint substitution; constraints checked);
Corollary 2; Remark 5's mass-balance $p\,u_1+(1-p)\,u_2=v$;
Corollary 6 (knot continuity); Theorem 4 in full (homogeneity →
midpoint additivity → cone extension → $D^{*}-D^{*}=
\operatorname{span}(C-C)$ → linear $a$; converse); Proposition 7's
$\mathbb{Q}$-linear $\ell$ and the witness $\ell(h)=1,\ \ell|_{\mathbb{Q}}=0$;
Proposition 8 (incl. the $k$-class simplex case via Theorem 4);
the mechanism $(\star_0)$ ⇔ $\mathbb{R}$-homogeneity at $(M,p)$;
$\int_0^1 T_\theta\,d\theta = u(1-u)$; $T_{1/2}=\min(u,1-u)$;
$\bar S = \mathrm{MCB}-\mathrm{DSC}+\mathrm{UNC}$ matches DGJ;
Faddeev-equation domain; Gleason $d\ge3$ / Busch $d\ge2$;
$v(\rho)=\operatorname{tr}(A\rho)+b$ from Theorem 4 +
finite-dimensional duality; all figure coordinates (§2 above).

## 6. Compile facts & residual template behavior

`manuscript-anon.pdf`: **18 pages**, 0 errors, 0 undefined references/
citations, 0 overfull boxes. `manuscript.pdf`: **19 pages** (title page
+ identical body). `cover-letter.pdf`: 3 pages. Main text ≈ **7,000
words** (excl. figures, tables, references). References: **53**,
alphabetical, `[n]`-cited. The running header "American Mathematical
Monthly 0:0" and footer "0]" are the template's volume/issue
*placeholders* — they are filled by MAA production and require no
author action.

## 7. Deliberation notes — what the panel chose *not* to change

The length (18 template pages is at the upper-comfortable end for a
Monthly Article; the field-guide section earns its space and the cover
letter now states the true count); the playful register; the
first-person plural; the provenance note (all three reviewers liked it
— it is the paper's honest origin story and the Monthly's readership
will too); the *expectation-exact* coinage (clearly labeled as a
convenience); the figure 2 comb density (legible at 95% scale). The
"0]" footer and "0:0" header placeholders (production-side).
The Sierpiński 1920 pagination was left at the author's 125–129
*pending* the fulltext check (the panel's recollection is 125–128;
overwriting one unverified number with another helps no one) — P0 on
the PI list.
