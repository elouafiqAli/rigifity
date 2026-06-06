# Phase E — French translation specification

*Authored 2026-06-06 by Executor E. Single source of truth for the French-version manuscript ([`11-draft0.3-fr-manuscrit.md`](11-draft0.3-fr-manuscrit.md)). Every notation/idiom/typography decision is fixed here before drafting begins; no decisions are left to the translator at drafting time. To be approved by Judge fr before Phase F starts.*

---

## 0. Scope and stance

The French manuscript is a **native French mathematical text**, not a translation. It follows French academic mathematical conventions (typography, idiom, register), uses French theorem-environment names, and reads naturally to a French-speaking mathematician. Machine translation is *only* used as a starting scaffold (DeepL on Draft 0.3 English); the final draft is hand-revised against this specification.

The two manuscripts (English + French) carry identical mathematical content (Theorem 1, Corollary 2, Theorem 1$'$, Theorem 3 remark, Proposition 4) and identical bibliography. The differences are: section headings, theorem-environment names, idiomatic prose, notation conventions per §3 below, French quotation marks « », and the typographic conventions of §4 below.

---

## 1. Theorem-environment names (French)

| English | French | Abbreviation in body |
|---|---|---|
| Theorem | Théorème | Théorème |
| Corollary | Corollaire | Corollaire |
| Proposition | Proposition | Proposition |
| Lemma | Lemme | Lemme |
| Definition | Définition | Définition |
| Remark | Remarque | Remarque |
| Example | Exemple | Exemple |
| Proof | Démonstration | Démonstration |
| End-of-proof symbol | $\square$ | $\square$ (no change) |
| Abstract | Résumé (in French body); Abstract (in the bilingual metadata block) | both |
| Keywords | Mots-clés (fr) + Keywords (en, in bilingual metadata) | both |
| References | Références bibliographiques | Références bibliographiques |
| Section | Section (so "Section II" → "Section II") | Section |
| Acknowledgements | Remerciements | Remerciements |
| Declaration of interests | Déclaration d'intérêts | Déclaration d'intérêts |

**Convention.** Theorem-environment labels in the body use the full French word ("Théorème 1", not "Thm. 1"). The Centre Mersenne `crmath` class likely provides French language support automatically (`\usepackage[french]{babel}` + `crmath` should swap "Theorem" → "Théorème" in the auto-generated labels); we override manually if needed.

---

## 2. Mathematical idiom map (en → fr)

The right-hand column is the choice for this manuscript. Where multiple French phrasings are acceptable, the chosen one is the one that reads most natural in a *Comptes Rendus*-register mathematical paper (compact, declarative, third-person).

| English phrasing | French phrasing (chosen) |
|---|---|
| Let $x \in I$. | Soit $x \in I$. |
| Let $G : I \to \mathbb R$ be a function. | Soit $G : I \to \mathbb R$ une fonction. |
| Consider… | Considérons… |
| Set $f(x) := G(x) - G(0)$. | Posons $f(x) := G(x) - G(0)$. |
| We have | On a |
| It follows that… | Il s'ensuit que… (or: D'où…, or: Par conséquent…) |
| In particular… | En particulier… |
| Moreover… | De plus… |
| Conversely… | Réciproquement… |
| In fact… | En effet… |
| On the other hand… | D'autre part… |
| Note that… | Notons que… |
| Indeed… | En effet… |
| Now… (sentence-initial discourse marker) | Or… |
| Therefore… | Donc… |
| Hence… | D'où… |
| Suppose… | Supposons… |
| It is enough to prove… | Il suffit de démontrer… |
| The proof is verbatim that of Theorem 1. | La démonstration est mot pour mot celle du Théorème 1. |
| We give the proof. | Nous en donnons la démonstration. (*"Nous"* here is the standard editorial we; not informal.) |
| The contribution is… | La contribution est… |
| As noted above… | Comme indiqué ci-dessus… |
| In a recent line of work… | Dans un travail récent… |
| We invite readers to extend the catalog. | Nous invitons les lecteurs à compléter ce catalogue. |
| Such an identity arises whenever Jensen's inequality is pushed to saturation. | Une telle identité apparaît dès que l'inégalité de Jensen est poussée à saturation. |
| The chord substitution closes the equation. | La substitution par corde clôt l'équation. |
| (No regularity hypothesis is required.) | (Aucune hypothèse de régularité n'est requise.) |

**Voice.** Third-person, present tense indicative. Use *"on"* for the impersonal voice (most of the manuscript). Use *"nous"* sparingly — only for explicit editorial statements (*"nous démontrons", "nous invitons"*); never for first-person individual ("je") which is unacceptable in academic French mathematics.

**Tense.** Present indicative throughout. *"On démontre"* not *"on a démontré"*. The future is reserved for forward references (*"Nous verrons en Section V"*).

---

## 3. Mathematical notation conventions (fr-specific)

### 3.1 Decimal separator

**Choice: decimal comma** (`0,5`, `1,234`) in narrative text and in *displayed* values. In *symbolic* mathematics (LaTeX math mode), maintain the international convention with decimal point unless inside an explicit French numerical context. The manuscript has very few numerical values; only $\tfrac{1}{2}$ which is fractional notation (no comma issue).

**Verification.** Search the French manuscript for `0.`, `1.`, etc. inside text; convert to `0,`, `1,`. Math mode is unchanged.

### 3.2 Interval notation

**Choice: ISO/French notation $[0, M]$, $[0, 1]$ for closed; $(0, 1)$ for open.** The historical French notation for open intervals is $]a, b[$ (the *crochets renversés* convention introduced by Bourbaki). Current French *Comptes Rendus* practice accepts both ISO/American $(a,b)$ and Bourbaki $]a, b[$; we choose **ISO** for international readability.

Closed intervals are $[a, b]$ in both conventions — no decision needed.

Half-open intervals: $[0, 1)$ (ISO) preferred over $[0, 1[$ (Bourbaki) for consistency.

### 3.3 Standard sets

| English (math mode) | French (math mode) |
|---|---|
| $\mathbb R$ | $\mathbb R$ (no change) |
| $\mathbb Q$ | $\mathbb Q$ (no change) |
| $\mathbb Z$ | $\mathbb Z$ (no change) |
| $\mathbb N$ | $\mathbb N$ (no change) |

Standard math symbols are international.

### 3.4 Function-and-mapping notation

| English | French |
|---|---|
| $G : I \to \mathbb R$ | $G : I \to \mathbb R$ (no change) |
| $G(v) = av + b$ | $G(v) = av + b$ (no change) |
| $f \circ g$ | $f \circ g$ (no change) |
| $\mathbb E[\xi]$ | $\mathbb E[\xi]$ (no change) — "espérance" of $\xi$ |
| $\mathbb P$ | $\mathbb P$ (no change) — "probabilité" |

All math symbols are international and unchanged.

### 3.5 Named constants and operators

| English | French |
|---|---|
| $\exp$ | $\exp$ (no change) |
| $\log$ | $\log$ (no change) |
| $\max$ | $\max$ (no change) |
| $\inf$ | $\inf$ (no change) |
| $\sup$ | $\sup$ (no change) |
| $\lim$ | $\lim$ (no change) |

All international.

### 3.6 Quantifier abbreviations

**Avoid** $\forall$ and $\exists$ in narrative text (academic French math papers preferentially write *"pour tout"*, *"il existe"*); use $\forall$ and $\exists$ only inside displayed equations.

| Symbol | Spelled out (French) |
|---|---|
| $\forall x$ | pour tout $x$ |
| $\exists x$ | il existe $x$ |
| $\exists !$ | il existe un unique |
| $\Rightarrow$ | implique (in narrative); $\Rightarrow$ (in displayed) |
| $\Leftrightarrow$ | si et seulement si (in narrative); $\Leftrightarrow$ (in displayed) |
| $\in$ | dans / appartenant à (in narrative); $\in$ (in displayed) |

The current English Draft 0.3 already follows this pattern; the French version maintains it.

### 3.7 Mathematical abbreviations

| English | French |
|---|---|
| i.e. | c.-à-d. (c'est-à-dire) |
| e.g. | par ex. (par exemple) |
| cf. | cf. (no change — Latin) |
| viz. | à savoir |
| iff (informal) | ssi (very informal; spell out "si et seulement si") |
| s.t. | tel que (spell out) |

---

## 4. Typography (French academic conventions — these are NON-NEGOTIABLE)

### 4.1 Espace insécable (non-breaking space)

**Rule:** A non-breaking space (`~` in LaTeX, U+00A0 in Unicode, `&nbsp;` in HTML) precedes the high punctuation marks `: ; ? ! » %` and follows `«`. This is mandatory in French typography.

| Construct | Correct | Incorrect |
|---|---|---|
| Word colon | `mot~:` | `mot:` |
| Word semicolon | `mot~;` | `mot;` |
| Word exclamation | `mot~!` | `mot!` |
| Word question | `mot~?` | `mot?` |
| Quoted phrase | `«~phrase~»` | `«phrase»` |
| Word percent | `10~\%` | `10\%` |
| Author–year citation | `[Aczél~1966]` | `[Aczél 1966]` |
| Theorem ref | `Théorème~1` | `Théorème 1` (latter risks line break between word and number) |
| Section ref | `Section~II` | `Section II` |
| Equation ref | `équation~$(\star)$` | `équation $(\star)$` |

**In LaTeX:** every instance becomes `~` in the source. The `babel` package's `[french]` option may insert these automatically for some constructs (it does for `:`, `;`, `?`, `!` and for `«` `»` if `french` is active); verify on first compile that the spaces are present in the PDF output.

### 4.2 Quotation marks

**French uses « » (guillemets français)** for in-text quotations, not "" (English double quotes). The opening « is followed by an espace insécable, and the closing » is preceded by an espace insécable.

| Construct | French | English |
|---|---|---|
| Direct quotation | « citation » | "quotation" |
| Term being defined | « terme » | "term" or *term* |
| Scare quotes | « expression » | "expression" |
| Article title in references | « Titre de l'article » | "Title of the article" |

**In LaTeX:** use `\og` and `\fg` (from `babel` + `[french]` option) or `\guillemotleft` / `\guillemotright` (from `csquotes`). With `babel[french]`, type `<<` and `>>` and the macros expand automatically — verify on first compile.

### 4.3 Italics for emphasis

Same as English: italics for emphasis. *"L'élément de surprise"* not "*l'élément de surprise*".

### 4.4 Capitalization

**French academic prose convention:** sentence-initial capital, all subsequent words lowercase unless proper nouns. **Names of theorems and definitions are capitalized when used as labels** (*"par le Théorème~1"*) but not in narrative descriptive use (*"un théorème classique de Sierpiński"*).

**Titles of works:** in French, only the first word of a title is capitalized (and any proper nouns). E.g.:
- French: *"Sur les fonctions convexes mesurables"* (only "Sur" capitalized)
- English: *"On the Consistency of Multiclass Classification Methods"* (title case)

When citing foreign-language titles in the French manuscript, retain the original language's capitalization convention.

### 4.5 Footnote indicators

**French convention:** footnote indicator is *preceding* the punctuation, with no space.

| French | English |
|---|---|
| `mot¹.` | `mot.¹` (no — even in English the indicator follows the period) |
| `mot¹,` | `mot¹,` (consistent) |
| `mot¹)` | `mot¹)` (same in both) |

Note: in *English* mathematical typography the convention is also indicator-then-punctuation when the footnote refers to the word, not the sentence. So this is more uniform than other typography points.

### 4.6 Roman page-number convention

CRAS Mathématique uses Roman top-level section numbers (§I, §II, §III, …) — *same convention in both English and French manuscripts*.

---

## 5. Section heading translations (verbatim, for the manuscript)

| English | French |
|---|---|
| Abstract | Résumé |
| Keywords | Mots-clés |
| MSC 2020 | MSC~2020 |
| I. Introduction | I. Introduction |
| II. The result | II. Le résultat |
| III. The dictionary | III. Le dictionnaire |
| IV. Variants and limits | IV. Variantes et limites |
| IV.1. The weakest hypothesis the proof consumes | IV.1. L'hypothèse minimale que la démonstration consomme |
| IV.2. Convex domains in higher dimensions | IV.2. Domaines convexes en dimensions supérieures |
| IV.3. The rational-coefficient version $(J_{\mathbb Q})$ does retain the pathology | IV.3. La version à coefficients rationnels $(J_{\mathbb Q})$ conserve, elle, la pathologie |
| V. Where the trap recurs | V. Où le piège ressurgit |
| V.1. A recurrence: surrogate calibration on the resolution axis | V.1. Une occurrence~: calibration par perte de substitution sur l'axe de résolution |
| V.2. Structural source — why the trap is predictable to recur | V.2. Source structurelle~: pourquoi le piège est appelé à se répéter |
| V.3. Adjacent settings | V.3. Cadres adjacents |
| V.4. An invitation to extend | V.4. Une invitation à compléter |
| Declaration of interests | Déclaration d'intérêts |
| Acknowledgements | Remerciements |
| References | Références bibliographiques |

---

## 6. Bibliographical conventions (fr)

### 6.1 Reference language

Each reference is cited in the **language of original publication**. The bibliography is a single list (alphabetical, mathematics-series convention).

| Reference | Language at cite | Notes |
|---|---|---|
| Aczél [1] | English (the 1966 Academic Press monograph is English) | |
| Aczél–Dhombres [2] | English (1989 Cambridge UP) | |
| Bartlett–Jordan–McAuliffe [3] | English | |
| Cauchy [4] | French | *Cours d'analyse de l'École royale polytechnique. Première partie : Analyse algébrique* |
| Darboux [5] | French | "Mémoire sur les fonctions discontinues" |
| Hamel [7] | German (with gloss possible) | "Eine Basis aller Zahlen und die unstetigen Lösungen…" |
| Kuczma [9] | English (2nd ed. by Birkhäuser, edited by Gilányi) | |
| Ostrowski [10] | German | "Über die Funktionalgleichung der Exponentialfunktion…" |
| Reid–Williamson [11, 12] | English | |
| Sierpiński [13] | French (Polish author writing in French in *Fundamenta*) | "Sur les fonctions convexes mesurables" |
| Steinhaus [14] | French (Polish author writing in French in *Fundamenta*) | "Sur les distances des points dans les ensembles de mesure positive" |
| Steinwart [16] | English | |
| Tewari–Bartlett [15] | English | |

**No gloss is needed in the French manuscript** — French mathematical readers are comfortable with English/German titles in the bibliography.

### 6.2 In-text citation format

Same as English: `[N]` for a single reference, `[N~; M]` (with espace insécable) for multiple. Page-precise: `[N, p.~283]` (with espace insécable). The French convention spells *"voir"* or *"cf."* before the bracketed citation when appropriate (*"voir [9, Ch.~13]"* / *"cf.~[1, §2.1]"*).

### 6.3 Bibliography entry punctuation (French)

The Centre Mersenne BibTeX style for CR Mathématique handles language-specific punctuation automatically (`babel[french]` swaps "ed." → "éd.", "vol." → "vol.", commas/spaces, etc.). We do not hand-format; we use BibTeX and let the style file do the work.

For the Markdown version (which is the source for the LaTeX), bibliography entries follow the English Draft 0.3 format. The French manuscript's *prose* changes; the bibliography list itself stays in English-language entries (the *titles* in their original language as above).

---

## 7. Bilingual metadata block (mandatory per G-4)

Even though both English and French full manuscripts are being prepared, the OJS submission requires explicit metadata in both languages. To consolidate, the French manuscript carries the following bilingual block in its front matter:

```
Titre (fr) : La substitution par corde clôt l'équation de Jensen à coefficient continu
Title (en) : The chord substitution closes the continuous Jensen equation

Sous-titre (fr) : Une note pédagogique sur trois hypothèses de régularité vestigiales
Subtitle (en) : A teaching note on three vestigial regularity hypotheses

Résumé (fr) : [200 words, hand-translated from the English abstract]
Abstract (en) : [identical to Draft 0.3 abstract]

Mots-clés (fr) : équation de Jensen ; équation de Cauchy ; base de Hamel ; équation fonctionnelle ; fonction affine ; substitution par corde
Keywords (en) : Jensen equation; Cauchy equation; Hamel basis; functional equation; affine function; chord substitution

MSC 2020 : 39B22, 39B05
```

This block is *part of* the French manuscript front matter and is also typed into the OJS form at submission. The same block (with English first) appears in the English LaTeX file for consistency.

---

## 8. Translation quality gate (FR-DEPENDABLE-TRANSLATION)

The French manuscript must satisfy a round-trip stability check before Phase G:

1. Take the final French manuscript ([`13-draft0.4-fr-manuscrit.md`](13-draft0.4-fr-manuscrit.md)).
2. Run it through DeepL (`fr → en`).
3. Diff the result against the English Draft 0.3 ([`09-draft0.3-manuscript.md`](09-draft0.3-manuscript.md)).
4. Acceptable differences: synonyms, word ordering, article ("a"/"the"/"an") variations, light tense variations.
5. Unacceptable differences: any *mathematical drift* — a different theorem statement, a different hypothesis, a different sign, a different quantifier, a different example.

Mathematical drift between the two versions is the most dangerous failure mode of bilingual mathematical publishing. The round-trip check catches the worst of it; Judge fr's audit (Phase G) is the human-level check.

---

## 9. Closing the spec

Phase E exits when:

- ✅ Every theorem-environment name (§1) is fixed.
- ✅ The idiom dictionary (§2) is complete enough that Draft 0.3 fr can be assembled without ad-hoc decisions.
- ✅ Notation conventions (§3) are explicit, with the decimal-comma, interval-notation, quantifier-spelling, and abbreviation-style choices made.
- ✅ Typography (§4) is documented with the espace insécable rule and the « » convention.
- ✅ Section headings (§5) are translated verbatim.
- ✅ Bibliography conventions (§6) are documented.
- ✅ Bilingual metadata block (§7) is structured.
- ✅ The FR-DEPENDABLE-TRANSLATION gate (§8) is articulated.

Judge fr is invited to add objections in [`12-judge-fr-audit.md`](12-judge-fr-audit.md) at any time — including objections to *this* specification (Phase E itself can be reopened on a finding from Phase G if a decision here turns out to be wrong).

---

## 10. Hand-off to Phase F

Phase F (French native Draft 0.3) consumes this specification + the English Draft 0.3 and produces [`11-draft0.3-fr-manuscrit.md`](11-draft0.3-fr-manuscrit.md). The expected output is a French mathematical text that reads natively, holds the same mathematical content as the English version, and complies with the typography of §4.
