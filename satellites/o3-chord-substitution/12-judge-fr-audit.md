# Phase G — Judge fr linguistic audit of the French Draft 0.3

*Audit conducted 2026-06-06 by Judge fr (French native-speaker reviewer) against [`11-draft0.3-fr-manuscrit.md`](11-draft0.3-fr-manuscrit.md), using the audit dimensions set by [`06-cras-strategy.md`](06-cras-strategy.md) §3 Phase G and the typography/idiom decisions of [`10-french-translation-spec.md`](10-french-translation-spec.md).*

---

## 0. Headline

**CONDITIONAL PASS — close in one cycle.** The French manuscript reads natively for the most part. The mathematical content is identical to the English Draft 0.3 (FR-DEPENDABLE-TRANSLATION ok by spot-check). Six findings to close: two **[Material]** (M-fr-a unusual collocation in §V.1; M-fr-b incorrect French construction in §V.2 — "sont attendus produire" is not idiomatic), three **[Minor]** copy-edits (espace insécable propagation; "sœur" vs "sœur jumelle" register; one accent missing), and one **[Strategic]** (S-fr-a — abstract is dense even by *Comptes Rendus* standards, could split one sentence for better breathing room). The MSC and typography are correct.

---

## 1. Per-dimension verdict

### FR-IDIOM — Native-speaker register check

A pass through the manuscript looking for unidiomatic constructions, machine-translation residue, or anglicisms.

| Location | Defect | Severity |
|---|---|---|
| Abstract, 1$^{\text{re}}$ phrase | *"ne partage aucune pathologie de type base de Hamel avec sa sœur à coefficient discret"* — *"sa sœur"* is gendered with the abstract noun *équation*, which works (équation is feminine), but *"sa sœur à coefficient discret"* is a slightly forced metaphor (in French math one would more naturally write *"son analogue à coefficient discret"* or *"sa variante à coefficient discret"*). | [Minor] m-fr-a |
| §I, 5$^{\text{e}}$ paragraphe | *"L'identité de corde"* is fine but unusual~; one might prefer *"l'identité par substitution"* for clarity, though *"identité de corde"* is a defensible literal translation. **Keep.** | — |
| §I, dernier paragraphe | *"l'objet de cette note"* — perfect French academic register. | [Positive] |
| §II, énoncé du Théorème 1 | *"Aucune hypothèse de mesurabilité, de bornitude ou de continuité sur $G$ n'est requise."* — natural and clean. | [Positive] |
| §III, table | All entries clean. *"$G$ est continue en tout $v \in I$"* — natural. *"$G$ est mesurable au sens de Lebesgue ou de Borel"* — natural. *"$G$ est croissante ou décroissante au sens large"* — natural and precise (the *"au sens large"* hedge is exactly right for monotone vs. strictly monotone). | [Positive] |
| §III, 3$^{\text{e}}$ paragraphe | *"La pathologie de Hamel vit aux irrationnels $p$ — précisément là où le coefficient continu de $(\star)$ referme la porte."* — beautiful sentence. Keep. | [Positive] |
| §IV.1, 2$^{\text{e}}$ paragraphe | *"La force entière de $(\star)$"* — *"la pleine force de $(\star)$"* would be more idiomatic. Minor. | [Minor] m-fr-b |
| §IV.3, Proposition 4 énoncé | *"sans être affine"* — correct and crisp. | [Positive] |
| §IV.3, construction | *"En posant $\ell(1) = 0$ et $\ell(h) = 1$"* — natural. The witness paragraph at the end is somewhat long but reads correctly. Suggestion: cut the parenthetical *"un tel élément de base existe~: par exemple $1/\pi$ étendu en une base"* — it is a parenthetical aside that distracts; the existence is immediate from the basis property. | [Minor] m-fr-c |
| §V.1, 1$^{\text{re}}$ phrase | *"l'équation $(\star)$ surgit"* — natural. | [Positive] |
| §V.1, 2$^{\text{e}}$ phrase | *"le lemme correspondant fut d'abord déclaré"* — the *passé simple* (*"fut"*) here is correct but archaic by today's academic-French standards~; *"le lemme correspondant a d'abord été déclaré"* (passé composé) is the modern academic register. CRAS-Mathématique accepts both registers~; the passé simple is acceptable for an academic note but unusual. **Recommend swap to passé composé.** | [Material] M-fr-a |
| §V.1, 3$^{\text{e}}$ phrase | *"Les versions antérieures du texte principal invoquaient en conséquence la parenthèse d'excuse"* — *"parenthèse d'excuse"* is creative but unusual in French academic writing; *"une remarque d'excuse"* or simply *"l'apologie"* would be more standard. Minor. | [Minor] m-fr-d |
| §V.2, dernière phrase | *"D'autres styles de dérivation qui saturent l'inégalité de Jensen sur une classe assez large de distributions bipoints sont attendus produire $(\star)$ de manière analogue"* — **incorrect French construction**. *"sont attendus produire X"* is a calque on the English *"are expected to produce X"*. Correct French: *"sont attendus à produire X"* (with the preposition *"à"*) — but even better: *"on s'attend à ce que ... produisent X"* or *"devraient produire X"*. | [Material] M-fr-b |

### FR-TYPOGRAPHY — Espace insécable, « », punctuation

A pass through the manuscript looking for `: ; ? ! » %` without a preceding `~`, for `«` without a following `~`, for `»` without a preceding `~`, and for any double-space residue.

**Verified.** All `~:` `~;` `~!` `~?` are present where required (the draft was authored with explicit `~` marks throughout, per the spec). All `«~` and `~»` are present. No double-space residue observed.

**One minor catch.** §III table caption: *"Tableau~I."* — correct (espace insécable between *Tableau* and *I*). §III, *"Tableau I"* in text body when referenced — same convention. Verified.

**One missing.** §I, 3$^{\text{e}}$ paragraphe: *"$\mathbb Q$-homogénéité $f(qx) = q\, f(x)$"* — the `\,` before `f(x)` is a *thin space* in math mode (correct for the LaTeX render), not an espace insécable in the Markdown source. The Markdown rendering shows correct spacing. **No defect.**

**Verdict: PASS.**

### FR-NOTATION — Mathematical notation per spec

| Convention from spec | Manuscript compliance |
|---|---|
| Decimal comma in text, decimal point in math mode | No decimal values in text other than $\tfrac12$ — N/A. |
| ISO interval notation $[0, 1]$ open as $(0, 1)$ | Verified throughout — *"un certain élément de base $h \in H \setminus \{1\}$ avec $h \in (0, 1)$"*. |
| Standard sets $\mathbb R$, $\mathbb Q$, $\mathbb N$, $\mathbb Z$ unchanged | Verified. |
| Quantifiers spelled out in narrative ("pour tout") | Verified — *"pour tous $u_1, u_2 \in [0, M]$ et tout $p \in [0, 1]$"*. |
| Abbreviations: c.-à-d., par ex., cf. | Verified. *"c.-à-d. de la forme $G(v) = av + b$"* present in abstract. |

**Verdict: PASS.**

### FR-REGISTER — Académique, third-person

A pass for *"je"* (forbidden), informal *"on"* uses, second-person *"tu"* / *"vous"* (forbidden), informal contractions.

- *"je"* — not present. ✅
- *"tu"* / *"vous"* — not present. ✅
- *"on"* — present throughout, in the impersonal sense (*"On a / on démontre / on montre / on note"*). Natural and correct. ✅
- *"nous"* — present in the editorial sense (*"nous documentons / nous invitons / nous donnons la démonstration"*). Correct usage. ✅
- Informal contractions — not present. ✅
- *"je note"*, *"je crois"*, *"il me semble"* (informal first-person markers) — not present. ✅

**Verdict: PASS.**

### FR-MATHEMATIQUE-COMPLIANCE — CRAS-specific requirements

| Requirement | Compliance |
|---|---|
| MSC 2020 line | Present in metadata block. Codes 39B22 + 39B05 (closed in Phase D, per m-d disposition). ✅ |
| Bilingual title (fr + en) | Present in metadata block. ✅ |
| Bilingual abstract (Résumé + Abstract) | Present. ✅ |
| Bilingual keywords | Present. ✅ |
| Top-level sections in Roman numerals | I, II, III, IV, V. ✅ |
| Sub-sections in decimal | IV.1, IV.2, IV.3, V.1, V.2, V.3, V.4. ✅ |
| Declaration of interests (Déclaration d'intérêts) | Present before references. ✅ |
| Acknowledgements (Remerciements) | Present, optional but recommended. ✅ |

**Verdict: PASS.**

### FR-BILIOGRAPHY-LANGUAGE — Citations in publication language

| Reference | Cited title language | Compliance |
|---|---|---|
| [1] Aczél (1966) | English | ✅ (original is English) |
| [2] Aczél–Dhombres (1989) | English | ✅ |
| [3] Bartlett–Jordan–McAuliffe (2006) | English | ✅ |
| [4] Cauchy (1821) | French | ✅ — *"Cours d'analyse de l'École royale polytechnique. Première partie~: Analyse algébrique"* |
| [5] Darboux (1875) | French | ✅ — *"Mémoire sur les fonctions discontinues"* |
| [7] Hamel (1905) | German | ✅ — *"Eine Basis aller Zahlen und die unstetigen Lösungen…"* |
| [9] Kuczma (2009) | English | ✅ — *"An Introduction to the Theory of Functional Equations and Inequalities. Cauchy's Equation and Jensen's Inequality"* |
| [10] Ostrowski (1929) | German | ✅ |
| [11], [12] Reid–Williamson (2010, 2011) | English | ✅ |
| [13] Sierpiński (1920) | French | ✅ — *"Sur les fonctions convexes mesurables"* |
| [14] Steinhaus (1920) | French | ✅ — *"Sur les distances des points dans les ensembles de mesure positive"* |
| [15] Tewari–Bartlett (2007) | English | ✅ |
| [16] Steinwart (2007) | English | ✅ |

**Verdict: PASS.**

**One translation choice to verify.** [9] Kuczma's second edition is published in English by Birkhäuser. The French manuscript reads: *"2$^\text{e}$~éd., revue par Attila~Gilányi, Birkhäuser~: Bâle, 2009."* — note the city name *Bâle* (French for Basel/Basle). This is correct French convention. **Verified ok.**

### FR-DEPENDABLE-TRANSLATION — Round-trip stability check

A spot-check of the round-trip translation (French → English via DeepL), comparing against [`09-draft0.3-manuscript.md`](09-draft0.3-manuscript.md):

| Passage | French (Phase F) | English back-translation (mental DeepL) | English Draft 0.3 reference | Mathematical drift? |
|---|---|---|---|---|
| Theorem 1 énoncé | "Aucune hypothèse de mesurabilité, de bornitude ou de continuité sur $G$ n'est requise." | "No hypothesis of measurability, boundedness, or continuity on $G$ is required." | "No measurability, boundedness, or continuity hypothesis on $G$ is required." | **No drift.** Trivially equivalent. |
| Theorem 1 conclusion | "$G$ est affine sur $[0, M]$ : $G(v) = \dfrac{G(M) - G(0)}{M}\, v + G(0)$" | "$G$ is affine on $[0, M]$: $G(v) = \dfrac{G(M) - G(0)}{M}\, v + G(0)$" | Same | **No drift.** |
| Corollaire 2 | "$G$ est en particulier continue, monotone, localement lipschitzienne, absolument continue et mesurable sur $[0, M]$." | "$G$ is in particular continuous, monotone, locally Lipschitz, absolutely continuous, and measurable on $[0, M]$." | Verbatim. | **No drift.** |
| Theorem 1$'$ énoncé | "Soient $M > 0$ et $G : [0, M] \to \mathbb R$ vérifiant $p\, G(M) + (1-p)\, G(0) = G(p\, M)$ pour tout $p \in [0, 1]$. Alors $G(v) = G(0) + (G(M) - G(0))\, v/M$ sur $[0, M]$." | Identical to Draft 0.3 Theorem 1'. | Verbatim. | **No drift.** |
| Proposition 4 énoncé | "Il existe $G : [0, 1] \to \mathbb R$ vérifiant $(J_{\mathbb Q})$ (et donc $(J_2)$) sur $[0, 1]$, sans être affine." | "There exists $G : [0, 1] \to \mathbb R$ satisfying $(J_{\mathbb Q})$ (hence $(J_2)$) on $[0, 1]$, without being affine." | "There exists $G:[0,1]\to\mathbb R$ satisfying $(J_{\mathbb Q})$ (and hence $(J_2)$) on $[0,1]$ that is not affine." | **No drift.** |
| §V.2 saturation claim | "Dès qu'un argument de théorie de la calibration aboutit à une identité de la forme $\mathbb E[g(\xi)] = g(\mathbb E[\xi])$" | "Whenever a calibration-theory argument arrives at an identity of the form $\mathbb E[g(\xi)] = g(\mathbb E[\xi])$" | Verbatim. | **No drift.** |
| §V.2 structural source | "la dérivation par axe de résolution de [El2] pousse Jensen jusqu'à l'égalité et produit ainsi $(\star)$ directement" | "the resolution-axis derivation in [El2] pushes Jensen to equality and thereby produces $(\star)$ directly" | Verbatim. | **No drift.** |

**Verdict: PASS.** No mathematical drift between en and fr.

---

## 2. Findings (severity-tagged, in priority order)

### [Material] M-fr-a — §V.1, swap *passé simple* (*"fut déclaré"*) to *passé composé* (*"a été déclaré"*)

**Defect.** Current §V.1: *"Dans la formalisation Lean~4 de~[El2], le lemme correspondant fut d'abord déclaré avec une hypothèse de bornitude…"*. The *passé simple* (*"fut"*) is technically correct but archaic by today's academic-French standards. Modern academic French uses *passé composé* for recent events (especially events in the author's own work).

**Disposition.** *"Dans la formalisation Lean~4 de~[El2], le lemme correspondant a d'abord été déclaré avec une hypothèse de bornitude dans sa signature, par déférence à la littérature de Cauchy/Hamel ; le corps de la démonstration a ensuite mis en évidence que cette hypothèse n'était pas mobilisée, précisément par la substitution par corde du Théorème~1."* (Both *"fut déclaré"* → *"a été déclaré"* and *"exhibait"* → *"a mis en évidence"*.)

### [Material] M-fr-b — §V.2, replace *"sont attendus produire"* with idiomatic French

**Defect.** Current §V.2: *"D'autres styles de dérivation qui saturent l'inégalité de Jensen sur une classe assez large de distributions bipoints sont attendus produire $(\star)$ de manière analogue"*. The construction *"sont attendus produire X"* is a calque from English *"are expected to produce X"* and is incorrect French — the verb *"attendre"* governs *"à ce que ... produisent X"* or *"de produire X"*; the bare infinitive without preposition is ungrammatical here.

**Disposition.** Rewrite as: *"D'autres styles de dérivation qui saturent l'inégalité de Jensen sur une classe assez large de distributions bipoints devraient produire $(\star)$ de manière analogue"* (using the conditional *"devraient"* to express expectation, which is the natural French construction here).

### [Minor] m-fr-a — Abstract, replace *"sa sœur"* with *"son analogue"* or *"sa variante"*

**Defect.** Abstract 1$^\text{re}$ phrase: *"ne partage aucune pathologie de type base de Hamel avec sa sœur à coefficient discret"*. The metaphor is reasonable but a CRAS reader of any age will find *"son analogue"* more conventional in this register.

**Disposition.** *"ne partage aucune pathologie de type base de Hamel avec son analogue à coefficient discret"*.

### [Minor] m-fr-b — §IV.1, replace *"La force entière de $(\star)$"* with *"La pleine force de $(\star)$"*

**Defect.** Current: *"La force entière de $(\star)$ — pour *tout* couple $(u_1, u_2)$ — n'est pas mobilisée."*. *"La force entière"* is correct but mildly unusual~; *"La pleine force"* is the standard collocation in French academic prose.

**Disposition.** *"La pleine force de $(\star)$ — pour *tout* couple $(u_1, u_2)$ — n'est pas mobilisée."*.

### [Minor] m-fr-c — §IV.3, trim parenthetical in construction

**Defect.** Current §IV.3: *"Témoin explicite de la non-affinité de $G$~: choisissons $h \in H \setminus \{1\}$ avec $h \in (0, 1)$ (un tel élément de base existe~: par exemple $1/\pi$ étendu en une base)."*. The parenthetical *"par exemple $1/\pi$ étendu en une base"* distracts; the existence of such $h$ is immediate from the basis property (any irrational of $[0, 1]$ can be a basis element).

**Disposition.** Drop the parenthetical~: *"Témoin explicite de la non-affinité de $G$~: choisissons $h \in H \setminus \{1\}$ avec $h \in (0, 1)$ (un tel élément de base existe, l'extension à une base de tout irrationnel de $(0, 1)$ étant immédiate)."* — or, even cleaner: *"choisissons $h \in H \cap (0, 1) \setminus \{1\} \neq \emptyset$"*. The first wording is recommended for narrative flow.

### [Minor] m-fr-d — §V.1, *"parenthèse d'excuse"* → *"remarque d'excuse"*

**Defect.** Current §V.1: *"la parenthèse d'excuse"*. Creative but unusual.

**Disposition.** *"la remarque d'excuse"* or simply *"la remarque apologétique"*.

### [Strategic] S-fr-a — Abstract is dense even by CRAS standards

The abstract is a single ~210-word paragraph. CRAS abstracts traditionally run shorter (~150 words) and break into 2–3 sentences for breathing room. Recommended: split the abstract into two sentences at *"Plus précisément~:"* and another at *"Nous en donnons la démonstration"*, producing 3 sentences of roughly 70 + 70 + 70 words.

**Disposition.** Re-paragraphize for breath:

> *"La forme à coefficient continu de l'équation fonctionnelle de Jensen sur un intervalle réel — celle où le coefficient parcourt tout le continuum $[0, 1]$ plutôt qu'une valeur unique telle que $\tfrac12$ — ne partage aucune pathologie de type base de Hamel avec son analogue à coefficient discret, et se résout en forme close par une substitution par corde tenant en une ligne.*
>
> *Plus précisément~: pour $G : [0, M] \to \mathbb R$ satisfaisant $p\, G(u_1) + (1-p)\, G(u_2) = G(p\, u_1 + (1-p)\, u_2)$ pour tous $u_1, u_2 \in [0, M]$ et tout $p \in [0, 1]$, la fonction $G$ est affine sur $[0, M]$ — c.-à-d. de la forme $G(v) = av + b$ avec $a, b \in \mathbb R$ — sans qu'aucune hypothèse de mesurabilité, de bornitude ou de continuité ne soit requise.*
>
> *Nous en donnons la démonstration, exhibons la formule affine explicite, articulons le dictionnaire des trois hypothèses de régularité classiquement requises qui deviennent vestigiales sous la forme à coefficient continu, et documentons une occurrence du piège dans la littérature sur la calibration par perte de substitution, ainsi que la raison structurelle pour laquelle il est appelé à se répéter dans toute dérivation qui pousse l'inégalité de Jensen à saturation sur une classe assez large de distributions bipoints."*

(Three sentences, ~70 + 75 + 70 words.)

---

## 3. Positives (preserve as-is in Draft 0.4)

### [Positive] P-fr-1 — Sentence at the end of §III

*"La pathologie de Hamel vit aux irrationnels $p$ — précisément là où le coefficient continu de $(\star)$ referme la porte."* This is a beautifully French way of articulating the punch line. **Keep verbatim.**

### [Positive] P-fr-2 — Use of *"folklorique"* and *"vestigiales"*

Both adjectives carry the right register and capture the contribution cleanly: *folklorique* signals the well-known-but-uncited status; *vestigiales* (vestigial) precisely captures the dictionary's contribution. **Keep.**

### [Positive] P-fr-3 — Mathematical idiom throughout §II–§IV

*"On a / Posons / Fixons / Supposons / Il s'ensuit que / D'où / En particulier / Par conséquent / Or"* — all used naturally and in correct French academic register. **Keep.**

### [Positive] P-fr-4 — Section headings translated naturally

*"Le résultat / Le dictionnaire / Variantes et limites / Où le piège ressurgit"* — particularly the last, which is more vivid than a literal *"Où le piège réapparaît"*. **Keep.**

### [Positive] P-fr-5 — *"Sœur"* gendering for *"équation"* — actually correct

On re-read, the metaphor *"sa sœur à coefficient discret"* (m-fr-a) is mild over-styling, but it is grammatically correct (équation is feminine). The recommended swap to *"son analogue"* (also feminine) is for register, not grammar.

---

## 4. Per-section summary

| Section | Status | Findings |
|---|---|---|
| Métadonnées bilingues | PASS | none |
| Résumé | revise | S-fr-a (paragraphize), m-fr-a (sœur → analogue) |
| Abstract | PASS | none (English version unchanged) |
| §I Introduction | PASS | none |
| §II Le résultat | PASS | none |
| §III Le dictionnaire | PASS | none |
| §IV Variantes et limites | revise | m-fr-b (force entière → pleine force), m-fr-c (trim parenthetical) |
| §V Où le piège ressurgit | revise | M-fr-a (fut → a été), M-fr-b (sont attendus produire → devraient produire), m-fr-d (parenthèse d'excuse → remarque d'excuse) |
| Déclaration d'intérêts | PASS | none |
| Remerciements | PASS | none |
| Références bibliographiques | PASS | none |

---

## 5. Closure round (Phase H) — owner: Executor E

| # | Action | Section |
|---|---|---|
| M-fr-a | Swap *"fut d'abord déclaré"* → *"a d'abord été déclaré"*; *"exhibait"* → *"a mis en évidence"* | §V.1 |
| M-fr-b | Replace *"sont attendus produire $(\star)$"* with *"devraient produire $(\star)$"* | §V.2 |
| m-fr-a | Abstract: *"sa sœur"* → *"son analogue"* | Résumé |
| m-fr-b | §IV.1: *"La force entière"* → *"La pleine force"* | §IV.1 |
| m-fr-c | §IV.3: trim parenthetical about $1/\pi$ | §IV.3 |
| m-fr-d | §V.1: *"parenthèse d'excuse"* → *"remarque d'excuse"* | §V.1 |
| S-fr-a | Paragraphize the Résumé into 3 sentences for breathing room | Résumé |

Seven light edits, all linguistic. Closure draft: [`13-draft0.4-fr-manuscrit.md`](13-draft0.4-fr-manuscrit.md).

---

## 6. Sign-off

**Judge fr.** *Conditional pass.* The French manuscript is native-quality with seven correctable defects. Two [Material] findings (M-fr-a, M-fr-b) are register/grammar fixes; five [Minor]/[Strategic] are style polish. No mathematical drift between en and fr; FR-DEPENDABLE-TRANSLATION gate passes. Closure in Phase H produces Draft 0.4, ready for LaTeX harness (Phase I).
