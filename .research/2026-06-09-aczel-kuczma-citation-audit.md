# Citation audit — Aczél (1966), Aczél–Dhombres (1989), Kuczma (2009)

**Phase**: MAA satellite (`satellites/o3-maa/`)
**Status**: substantially verified — Kuczma §§5.2 and 13.2, Aczél §2.1
(all subsections), and the Aczél–Dhombres 1989 table of contents audited
2026-06-09 against PDF excerpts. Aczél 1966 Ch. 5 entropy claim and
Aczél–Dhombres Ch. 13 higher-dim claim disproven.
**First raised**: 2026-06-09
**Last updated**: 2026-06-09 (Aczél §2.1 and Aczél–Dhombres TOC verified)

## The question

The MAA Monthly manuscript [`satellites/o3-maa/latex/manuscript.tex`](../satellites/o3-maa/latex/manuscript.tex)
attributes its key results to "folklore" passages in three reference books:

- Aczél, *Lectures on Functional Equations and Their Applications* (1966) — `\cite{Aczel1966}`
- Aczél, Dhombres, *Functional Equations in Several Variables* (1989) — `\cite{AczelDhombres1989}`
- Kuczma, *An Introduction to the Theory of Functional Equations and Inequalities*, 2nd ed. (2009, edited by Gilányi) — `\cite{Kuczma2009}`

Several of the chapter/section pins are best-guess locator citations rather
than verified pin-cites. The author searched the books and could not locate
the exact reasoning the manuscript attributes to each. This file
**documents what the manuscript actually uses** for each citation, so that
the author can re-walk the books with a precise target in hand.

## Sources consulted

The audit below is based on:

1. The full text of [`manuscript.tex`](../satellites/o3-maa/latex/manuscript.tex)
   as of 2026-06-09 (post second-review pass).
2. **Kuczma 2009 §13.2 “Jensen equation”** — 4-page PDF excerpt at
   [`satellites/refs/kuczma.pdf`](../satellites/refs/kuczma.pdf), pages 351–354.
   Verified 2026-06-09.
3. **Kuczma 2009 §5.2 “Additive functions”** (with the tail of §5.1 and the
   start of §5.3 “Convex functions”) — 3-page PDF excerpt at
   [`satellites/refs/kuczma_5.pdf`](../satellites/refs/kuczma_5.pdf),
   pages 128–130. Verified 2026-06-09.
4. **Aczél 1966 Ch. 5** — author confirms (2026-06-09) that Ch. 5 contains
   **no entropy material**; only footnote pointers to Shannon 1948,
   Faddeev 1956/57, Kendall 1963, Kuczma 1964, etc., as examples of
   related-equation applications. The Khinchin–Faddeev entropy chapter is
   *not* Ch. 5 of Aczél 1966.
5. General knowledge of the structure of Aczél 1966 and Aczél–Dhombres 1989.
   The remaining pin-cites have **not been cross-verified against the
   physical books**.

## Kuczma 2009 §13.2 — verified content

§13.2 *“Jensen equation”* (in Ch. 13 *“Related Equations”*) covers:

| Result | Statement |
|---|---|
| Eq. (13.2.1) | The **discrete-coefficient** equation $J_2$: $f((x+y)/2) = (f(x)+f(y))/2$ on a convex $D \subseteq \mathbb{R}^N$ |
| Lemma 13.2.1 | $f(x/2^n) = f(x)/2^n$ when $f(0)=0$ |
| Lemma 13.2.2 | Unique extension $f_1\colon \mathbb{R}^N \to \mathbb{R}$ satisfying $J_2$, agreeing with $f-f(x_0)$ on $D-x_0$ |
| Lemma 13.2.3 | $J_2$ + $f(0)=0$ implies $f$ is additive |
| Theorem 13.2.1 | Every $J_2$ solution on $D$: $f(x)=g(x)+a$ for additive $g\colon \mathbb{R}^N \to \mathbb{R}$ |
| Theorem 13.2.2 | A **continuous** $J_2$ solution is $f(x)=cx+a$ |
| Theorem 13.2.3 | A **measurable** or **bounded** (above or below on a positive-measure set) $J_2$ solution is continuous (hence affine) |

What §13.2 does **NOT** contain:

- The continuous-coefficient form $(\star)$ with $p\in[0,1]$ ranging continuously.
- The endpoint substitution closure ($u_1:=M$, $u_2:=0$, $p:=v/M$).
- An explicit $J_\mathbb{Q}$ version of the equation.
- The Hamel-basis construction (which lives in §5.2).

**Conclusion for §13.2**: this section is **exactly column~2 of the
manuscript's Table~1** — the regularity catalog for $J_2 \Rightarrow$ affine.
It is **not** a source for the endpoint substitution or for Theorem~1
of the manuscript (which is the regularity-free closure of $(\star)$).

## Kuczma 2009 §5.2 — verified content

§5.2 *“Additive functions”* (in Ch. 5 *“Additive Functions and Convex
Functions”*) covers:

| Result | Statement |
|---|---|
| Eq. (5.2.1) | **Cauchy's equation** $f(x+y)=f(x)+f(y)$ on $\mathbb{R}^N$ |
| Theorem 5.2.1 | Every additive $f$ is $\mathbb{Q}$-homogeneous: $f(\lambda x)=\lambda f(x)$ for every $\lambda\in\mathbb{Q}$ |
| Theorem 5.2.2 | For any Hamel basis $H$ of $\mathbb{R}^N$ over $\mathbb{Q}$, every $g\colon H\to\mathbb{R}$ extends uniquely to an additive $f\colon\mathbb{R}^N\to\mathbb{R}$ |
| Corollary 5.2.1 | A Hamel-extension $f$ is continuous iff $g(x)/x = \mathrm{const}$ on $H$ |
| Corollary 5.2.2 | If $g$ takes only rational values and is non-zero, the extension $f$ is discontinuous |

§5.2 then names discontinuous additive functions “Hamel functions”.

What §5.2 contains that the manuscript's Proposition~5 uses:

- **The Hamel extension theorem** (Theorem 5.2.2) — the *exact* tool used
  in the manuscript's construction.
- **$\mathbb{Q}$-homogeneity of additive functions** (Theorem 5.2.1) — the
  bridge from “additive” to “Q-linear”.
- **Existence of discontinuous additive functions** — Corollary 5.2.2.

What §5.2 does **NOT** contain:

- The Hamel **basis existence** proof itself (this is Theorem 4.3.1 of
  Ch. 4 — “bases of vector spaces” — referenced but not reproduced in
  §5.2; §5.2 *uses* the basis as a given). For full pinpoint accuracy
  the Hamel-basis construction citation should be Ch. 4 (specifically
  Theorem 4.3.1), not Ch. 5.
- The $J_\mathbb{Q}$ form on $[0,1]$ (this is the manuscript's own
  restriction; not in §5.2).

**Conclusion for §5.2**: this section is the **right pin-cite** for the
“Hamel extension + $\mathbb{Q}$-homogeneity” half of Proposition~5's
construction. Combined with §13.2 (which gives the $J_2 \Rightarrow$
additive bridge), the citation `[\S\S5.2 and~13.2]{Kuczma2009}` is
fully verified for Proposition~5.

## Aczél 1966 Ch. 5 — entropy claim disproven

The manuscript's §5.3 currently cites `\cite[Ch.~5]{Aczel1966}` for
“the modern formalization” of the Khinchin–Faddeev entropy
axiomatization. The author has confirmed by direct inspection that
Aczél 1966 Ch. 5 **does not** discuss entropy at all. The only mention
of information-theoretic material in that chapter is a footnote listing
examples of related-equation applications: among others M. Lubin 1943,
J. Sade 1953/57/62, A. C. Lunn 1919, C. E. Shannon 1948,
M. P. Schützenberger 1951, D. K. Faddeev 1956/57, E. T. Jaynes 1957,
A. Feinstein 1958, etc.

**Conclusion**: the `[Ch.~5]{Aczel1966}` citation in §5.3 is wrong and
must be removed. The Khinchin–Faddeev entropy axiomatization is the
subject of separate works (Khinchin 1957, Faddeev 1957), both of which
are already cited in the manuscript. The Aczél–Dhombres 1989 reference
in the same paragraph is generic enough to stand.
## Citation map

Eight pin-cites to the three books. Each row of the table below points to
the exact manuscript line (current) and summarizes the role played by the
citation.

| Manuscript location | Pin-cite | Role |
|---|---|---|
| §1.3, line 246–247 | `[\S2.1]{Aczel1966}` + `[Ch.~13]{Kuczma2009}` | Theorem 1 is folklore |
| §1.4 *Terminology*, line 288 | `[\S2.1]{Aczel1966}` + `[Ch.~13]{Kuczma2009}` | Endpoint substitution is standard folklore |
| §4.2, line 527 | `[Ch.~13]{AczelDhombres1989}` | Higher-dimensional lifting is "standard bookkeeping" |
| §4.3, line 540 (Proposition 5) | `[Chs.~5 and~13]{Kuczma2009}` | Folklore for the $J_\mathbb{Q}$ pathology |
| §5 intro, line 579 | `[\S2.1]{Aczel1966}` + `[Ch.~13]{Kuczma2009}` | Both books articulate the underlying observation |
| §5.3, line 668 | `[Ch.~5]{Aczel1966}` | Modern formalization of Khinchin–Faddeev entropy axioms |
| §5.3, line 675 | `{AczelDhombres1989}` (no chapter) | Substitution is part of the standard entropy-functional-equations toolkit |
| §6 *Provenance*, line 765–766 | `[\S2.1]{Aczel1966}` + `[Ch.~13]{Kuczma2009}` | Substitution is folklore |

## Aczél 1966 §2.1 — verified content

§2.1 *“Cauchy's Equations and Jensen's Equation”* has four subsections:

| Subsection | Title (verified) | Content (summary) |
|---|---|---|
| §2.1.1 | Cauchy's basic equation $f(x+y)=f(x)+f(y)$ | Solution class with continuity / boundedness / measurability → affine; Hamel pathology without regularity. |
| §2.1.2 | The three remaining Cauchy equations | Exponential, logarithmic, multiplicative — reducible to §2.1.1. |
| §2.1.3 | Jensen's equation $f((x+y)/2) = (f(x)+f(y))/2$ on $\mathbb{R}$ | Reduces to Cauchy by setting $y=0$; closure requires regularity (continuity at a point, boundedness, etc.). Theorem 1 of §2.1.3 is the $J_2$ regularity story. |
| §2.1.4 | Jensen's equation and Cauchy's equations for an interval and for higher ranks | Proves $f(x)=a+x(b-a)$ for **dyadic** $x \in [0,1]$ by dyadic induction starting from $f(0)=a$, $f(1)=b$; then continuity upgrades dyadic to all $x \in [0,1]$. |

**Key finding for the manuscript**: §2.1.4 is the closest match to the
manuscript's endpoint substitution. It contains the **dyadic precursor**:
the same endpoint values $f(0)$, $f(1)$ pin $f$ along the line, but only
on the dyadic rationals; closure requires continuity to extend to the
full interval.

What §2.1 (across all four subsections) does **NOT** contain:

- The continuous-coefficient form $(\star)$ with $p \in [0,1]$ ranging
  continuously over the reals.
- The regularity-free closure: in §2.1.4 the dyadic substitution is
  closed by a **continuity hypothesis** to upgrade dyadic to all $x$.
- Any statement equivalent to the manuscript's Theorem~1
  ($(\star)$ with continuous $p$ $\Rightarrow$ affine, with no regularity
  hypothesis at all).

**Conclusion for §2.1**: the manuscript's `[\S2.1]{Aczel1966}` cite was
imprecise; the relevant subsection is **§2.1.4**. Even §2.1.4 is a
**weaker** result (uses dyadic + continuity), so the manuscript's
“Theorem 1 is folklore” attribution slightly overstates what is
literally in Aczél. The manuscript's contribution, on this evidence,
is to upgrade §2.1.4's dyadic-plus-continuity statement to the strict
strengthening $(\star)$-on-$[0,1]$-implies-affine with no regularity.
Whether the strengthening counts as “folklore” or “a genuine
observation” depends on whether it has been stated elsewhere; for now
the `Folklore; cf.~\cite[\S2.1.4]{Aczel1966}` hedge is conservative.

## Aczél–Dhombres 1989 — verified table of contents

TOC excerpt at [`satellites/refs/outline.pdf`](../satellites/refs/outline.pdf).
Verified chapters relevant to the manuscript:

| Ch. | Title | Relevant? |
|---|---|---|
| 2 | Cauchy's equation. Hamel basis | Yes — covers additive functions on vector spaces, Hamel-basis machinery. Most natural home for a multi-variable affine-extension result. |
| 3 | Three further Cauchy equations. An application to information theory | Possibly relevant for the entropy application (§5.3). |
| 4 | Generalizations of Cauchy's equations to several multiplace vector and matrix functions | Multi-variable Cauchy. |
| 5 | Cauchy's equations for complex functions. Applications to harmonic analysis and to information measures. *Subsection 5.4: Recursive entropies.* | The recursive-entropy material is here, not in Aczél 1966 Ch. 5. |
| 11 | Characterizations of inner product spaces | Orthogonal additivity. |
| **13** | **Equations for trigonometric and similar functions** | ❌ **NOT** the higher-dim convex / affine chapter. |
| 17 | Mean values, mediality and self-distributivity | Jensen-type equations on means — candidate home for a Jensen-form result. |
| 18 | Generalized mediality. Connection to webs and nomograms | Mean-value equations. |

**Conclusion**: the manuscript's `[Ch.~13]{AczelDhombres1989}` cite in
§4.2 is **wrong**. Ch. 13 is about trigonometric equations. The right
chapter for the higher-dim affine-extension claim is Ch. 2 (Cauchy on
vector spaces) — but without a verified excerpt of Ch. 2, the safest
fix is to drop the chapter pin and cite the book generically.

**Bonus finding**: Aczél–Dhombres **§5.4 “Recursive entropies”** is the
actual modern entropy chapter — the very content the manuscript's §5.3
was trying to attribute to Aczél 1966 Ch. 5. If the manuscript needs a
modern-treatment cite for Khinchin–Faddeev recursivity, this is the
correct pin: `\cite[\S5.4]{AczelDhombres1989}`. (Not edited into the
manuscript on this pass; recorded here as a follow-up option.)

## Per-citation audit

For each citation, this section records:

- **Manuscript reasoning**: the *exact* proof or argument the manuscript
  provides (which is self-contained — the citation is only for attribution).
- **Expected source content**: what the citation should match in the book.
- **Verification status**: whether the pin-cite has been confirmed.

### Cite #1 — Aczél (1966) §2.1.4 — dyadic precursor of the endpoint substitution

**Used at**: §1.3, §1.4 *Terminology*, §5 intro, §6 *Provenance*.

**Manuscript reasoning** (Theorem 1 proof, §2):
> Fix $v \in [0,M]$. Set $u_1 := M$, $u_2 := 0$, $p := v/M \in [0,1]$.
> Substitute into $(\star)$. Rearranging yields
> $G(v) = G(0) + (G(M) - G(0)) \cdot v/M$.

**Verified source content (§2.1.4)**: Aczél proves $f(x) = a + x(b-a)$
on $[0,1]$, where $a := f(0)$ and $b := f(1)$, by:

1. Showing $f(\tfrac{1}{2}) = \tfrac{a+b}{2}$ via the $J_2$ equation.
2. Showing $f(\tfrac{1}{4}) = a + \tfrac{1}{4}(b-a)$ similarly.
3. Inducting on dyadic rationals: if $f(x) = a + x(b-a)$ for all
   dyadic $x$ with denominator $2^n$, then it holds for $2^{n+1}$.
4. Using **continuity** to extend from dyadic-dense to all $x \in [0,1]$.

This is a **weaker** statement than the manuscript's Theorem~1, because
it uses $J_2$ (discrete coefficient) plus a continuity hypothesis.
The manuscript's $(\star)$ has continuous coefficients $p \in [0,1]$, so
the substitution closes in one step without dyadic induction and
without any continuity hypothesis.

**Verification status**: ⚠️ **Partial**. §2.1.4 contains the dyadic
precursor of the endpoint substitution; the manuscript's regularity-free
continuous-coefficient closure is one strict step beyond.

**Citation refined to**: `\cite[\S2.1.4]{Aczel1966}` (was `\cite[\S2.1]{Aczel1966}`).
The “Folklore; cf.” hedge is appropriate — the underlying substitution
technique is in Aczél; the regularity-free strengthening may be the
manuscript's own observation.

### Cite #2 — Kuczma (2009) Ch. 13 — Jensen's equation $J_2$

**Used at**: §1.3 line 247; §1.4 line 288; §5 intro line 579; §6 line 766.

**Manuscript reasoning**: Same as Cite #1 (the endpoint substitution).

**Verified source content (§13.2 only)**: Kuczma 2nd ed. §13.2 covers $J_2$
on a convex domain in $\mathbb{R}^N$ — see the table above. The chapter develops:

1. The reduction of $J_2$ to additive + constant (Lemma 13.2.3, Theorem 13.2.1).
2. The continuous, measurable, and bounded sufficiency theorems for
   $J_2 \Rightarrow$ affine (Theorems 13.2.2 and 13.2.3).
3. **No discussion of the continuous-coefficient form $(\star)$** in §13.2.
4. **No endpoint substitution** in §13.2.

**Verification status**: ⚠️ **Misleading citation**. The four manuscript
locations citing `[Ch.~13]{Kuczma2009}` for the endpoint substitution being
*folklore* are **not supported by §13.2**. The full Ch. 13 may contain
further sections (§13.1, §13.3, …) that discuss $(\star)$, but the section
closest to the chapter title (“Jensen equation”) does not.

**Recommended fix to the manuscript**:

- **Drop** `[Ch.~13]{Kuczma2009}` from the four “endpoint substitution is
  folklore” locations. Keep only `[§2.1]{Aczel1966}` (still pending
  verification, but at least we have not disproven it).
- **Add** `[§13.2]{Kuczma2009}` to the dictionary in §3.1 as the modern
  textbook treatment of column~2 ($J_2$ regularity catalog). §13.2's
  Theorems 13.2.1, 13.2.2, and 13.2.3 directly correspond to the rows of
  Table~1, column~2.
- This pivot leaves the manuscript honest about what each book actually
  does: Aczél §2.1 for the substitution, Kuczma §13.2 for the contrasting
  $J_2$-regularity story.

### Cite #3 — Aczél–Dhombres (1989) — higher-dimensional lifting

**Used at**: §4.2 line 527.

**Manuscript reasoning** (Theorem on higher-dimensional convex domains, §4.2):
> Apply Theorem 1 along every line segment in $C$: for each direction $v$
> with $x_0 + v \in C$, the map $\lambda \mapsto G(x_0 + \lambda v)$ is
> affine in $\lambda \in [0,1]$. Hence $G(x_0 + v) - G(x_0)$ depends
> linearly on $v$ in each direction; an inductive argument on the
> dimension of the affine span promotes this to a global linear
> functional $a$ on $\mathrm{span}(C - C)$.

**Verified TOC content**: Ch. 13 of Aczél–Dhombres 1989 is titled
*“Equations for trigonometric and similar functions”* and is **not** the
higher-dim convex / affine chapter. The chapter pin `[Ch.~13]{AczelDhombres1989}`
was wrong.

The right chapter for the higher-dim affine-extension result is most
likely **Ch. 2 “Cauchy's equation. Hamel basis”**, which covers additive
functions on vector spaces — but Ch. 2's content has not been verified
in detail (no excerpt was provided). **Ch. 17 “Mean values, mediality
and self-distributivity”** is also a candidate (Jensen-type equations
on means).

**Verification status**: ❌ **Wrong chapter** — corrected.

**Citation refined to**: `\cite{AczelDhombres1989}` (no chapter pin).
Safer than guessing Ch. 2 or Ch. 17 without verification; "the
bookkeeping is standard" reads honestly with a generic book reference.

### Cite #4 — Kuczma (2009) §§5.2 and~13.2 — Proposition 5 ($J_\mathbb{Q}$ pathology)

**Used at**: §4.3 line 540.

**Manuscript reasoning** (Proposition 5 construction):
> Choose a Hamel basis $H$ of $\mathbb{R}$ over $\mathbb{Q}$ containing 1.
> $H$ has cardinality $\mathfrak{c}$, so it contains an irrational $h \in (0,1)$.
> Define $\ell\colon\mathbb{R}\to\mathbb{R}$ $\mathbb{Q}$-linear with $\ell(1) = 0$, $\ell(h) = 1$.
> Then $\ell$ is additive (Cauchy) and $\mathbb{Q}$-homogeneous.
> Set $G := \ell|_{[0,1]}$. $G$ satisfies $J_\mathbb{Q}$ because $\ell$ respects $\mathbb{Q}$-linear combinations.
> $G$ is not affine: $G(h) = 1 \ne 0 = G(q)$ for every rational $q \in [0,1]$.

**Verified source content**: Two sections of Kuczma 2009 cover the
building blocks of Proposition~5:

- **§5.2 “Additive functions”** — provides exactly the Hamel-extension
  machinery: Theorem 5.2.2 gives the unique additive extension of any
  $g\colon H\to\mathbb{R}$ on a Hamel basis $H$, Theorem 5.2.1 gives
  $\mathbb{Q}$-homogeneity of any additive function, Corollary 5.2.2
  gives discontinuous additive functions (“Hamel functions”).
- **§13.2 “Jensen equation”** — provides the $J_2 \Rightarrow$ additive
  bridge (Lemma 13.2.3) and the additive+constant structure of $J_2$
  solutions (Theorem 13.2.1).

What is **not** in either section:

- The Hamel-basis **existence** proof (Zorn's lemma applied to
  $\mathbb{Q}$-linearly independent subsets of $\mathbb{R}$) — this is
  Theorem 4.3.1 of Ch. 4 (“Bases of vector spaces”), referenced from
  §5.2 but proved earlier in the book.
- The $J_\mathbb{Q}$ form on $[0,1]$ — the manuscript's specific
  restriction-to-$[0,1]$ statement is the author's own. The proof is
  self-contained.

**Verification status**: ✅ **Verified**. `[\S\S5.2 and~13.2]{Kuczma2009}`
is the most accurate pin-cite: §5.2 has the Hamel-extension theorem
(the key construction tool) and §13.2 has the $J_2$-to-additive
reduction. If the author wants to be maximally precise, the pin could
be `[\S\S4.3, 5.2, 13.2]{Kuczma2009}` (adding the Hamel-basis-existence
chapter), but this is over-pinning for a folklore attribution.

### Cite #5 — Aczél (1966) Ch. 5 — Khinchin–Faddeev entropy axiomatization

**Used at**: §5.3 line 668.

**Manuscript reasoning** (§5.3):
> In the modern formalization, the recursivity axiom reduces, in
> intermediate steps, to a system of functional equations on auxiliary
> functions $g,h$ on $[0,1]$. Several of these intermediate equations
> are of $(\star)$-form for the auxiliary functions, and the closure
> step uses continuity (the first Khinchin axiom). The endpoint
> substitution of Theorem 1 is the alternative closure that does not
> require continuity as a hypothesis.

**Verified source content**: ❌ **The claim is false**. Author has
confirmed by direct inspection that Aczél 1966 Ch. 5 contains no
entropy material. The only information-theoretic content in Ch. 5 is a
footnote pointer to other works (Shannon 1948, Faddeev 1956/57, etc.)

**Verification status**: ❌ **Disproven**.

**Recommended fix to the manuscript**:

Drop the Aczél Ch. 5 pin-cite. The Khinchin–Faddeev material in §5.3 of
the manuscript is already covered by the primary-source citations to
Khinchin 1957 and Faddeev 1957, which appear in the same paragraph.
The sentence “In the modern formalization…” can be reworded to attribute
the modern recursivity-axiom analysis to Faddeev directly, or to drop
the “modern formalization” framing and simply say “The Khinchin–Faddeev
recursivity axiom reduces, in intermediate steps, to…” — which is true
and needs no Aczél attribution.

### Cite #6 — Aczél–Dhombres (1989) — entropy toolkit

**Used at**: §5.3 line 675 (no chapter pin).

**Manuscript reasoning**:
> in Aczél–Dhombres [9] the substitution is part of the standard toolkit.

**Expected source content**: A general claim that the endpoint substitution appears throughout Aczél–Dhombres as a standard technique. No specific chapter is identified.

**Verification status**: ✅ Generic enough that no pin-cite is required. The phrase "part of the standard toolkit" is hedged — it does not claim a specific theorem.

**Recommended verification**: None required, but if the author wants a stronger claim, a specific chapter could be added.

## Strategic recommendation

The manuscript's citations are **honest in their hedging** ("folklore; cf.",
"part of the standard toolkit") but several pin-cites have not been
verified against the physical books. Before submission, the author should:

1. **Borrow / consult** physical or PDF copies of Aczél 1966, Aczél–Dhombres
   1989, and Kuczma 2009.
2. **Verify** each pin-cite against the actual chapter / section content.
3. **Adjust** any incorrect pin-cites; if a chapter is wrong, either find
   the right chapter or drop the chapter pin and cite the book generically.
4. **Defensively keep** the "Folklore; cf." attribution — this signals to
   the referee that the manuscript's proof is self-contained and the
   citation is for attribution, not for derivation.

## Action taken on 2026-06-09 (initial)

- Proposition 5's citation refined from `[Ch.~5]{Kuczma2009}` to
  `[Chs.~5 and~13]{Kuczma2009}` to flag both the Hamel-basis construction
  (Ch. 5) and the Jensen-form pathology (Ch. 13).
- This audit file created for the author to use as a verification checklist.

## Action taken on 2026-06-09 (fourth pass, after Aczél §2.1 and Aczél–Dhombres TOC verification)

Aczél 1966 §2.1 OCR'd from `satellites/refs/aczel69_2.1.pdf` (19 pages).
Aczél–Dhombres 1989 TOC OCR'd from `satellites/refs/outline.pdf` (3 pages).

Verified that:

- Aczél §2.1.4 contains the **dyadic precursor** of the endpoint
  substitution: $f(x) = a + x(b-a)$ on dyadic rationals in $[0,1]$,
  then continuity to extend to all $x$. This is a weaker statement than
  the manuscript's regularity-free Theorem~1.
- Aczél–Dhombres 1989 Ch. 13 is *“Equations for trigonometric and
  similar functions”*, **not** the higher-dim convex / affine chapter.
- Aczél–Dhombres 1989 §5.4 *“Recursive entropies”* is the actual modern
  entropy chapter — a candidate replacement for the dropped Aczél 1966
  Ch. 5 cite in §5.3 (not yet applied; logged as follow-up).

Manuscript edits applied as a result:

- Refined four `\cite[\S2.1]{Aczel1966}` cites to `\cite[\S2.1.4]{Aczel1966}`
  (in §1.3, §1.4 *Terminology*, §5 intro, §6 *Provenance*).
- Dropped wrong `[Ch.~13]{AczelDhombres1989}` pin in §4.2; now
  cites the book generically (`\cite{AczelDhombres1989}`).

## Action taken on 2026-06-09 (third pass, after §5.2 verification + Aczél Ch. 5 disproven)

Kuczma §5.2 PDF added to `satellites/refs/kuczma_5.pdf`. Verified that:

- §5.2 contains the Hamel-extension theorem (Theorem 5.2.2), ℚ-homogeneity
  of additive functions (Theorem 5.2.1), and the existence of
  discontinuous additive functions (Corollary 5.2.2).
- These are exactly the tools used in the manuscript's Proposition~5
  construction.

Author confirms Aczél 1966 Ch. 5 has no entropy material (only a footnote
pointer to Shannon / Faddeev / Jaynes / etc.).

Manuscript edits applied as a result:

- Refined Proposition~5 citation from `[Chs.~5 and~13]{Kuczma2009}` to
  `[\S\S5.2 and~13.2]{Kuczma2009}` — same chapters, but precise sections.
- Dropped `\cite[Ch.~5]{Aczel1966}` from §5.3 (entropy application).
  Reworded the paragraph to attribute the recursivity-axiom analysis to
  Khinchin and Faddeev directly (their primary sources are already cited).

## Open follow-ups

- [x] **Verify Kuczma 2009 §13.2** is the Jensen-equation chapter — done.
- [x] **Verify Kuczma 2009 §5.2** contains the Hamel extension — done.
- [x] **Verify Aczél 1966 Ch. 5** entropy claim — disproven; removed.
- [x] **Verify Aczél 1966 §2.1** contains the endpoint substitution
  — done. §2.1.4 contains the dyadic precursor; the strict
  regularity-free version in continuous coefficients is one step
  beyond.
- [x] **Verify Aczél–Dhombres 1989 Ch. 13** — done. Ch. 13 is
  trigonometric functions; pin was wrong and has been dropped.
- [ ] **(Optional) verify Aczél–Dhombres 1989 Ch. 2** (or Ch. 17) as
  the actual home for the higher-dim affine extension. If verified,
  could replace the dropped chapter pin with the right one.
- [ ] **(Optional) update §5.3 to cite Aczél–Dhombres §5.4** *“Recursive
  entropies”* alongside Khinchin and Faddeev. This is the modern
  textbook treatment of recursive entropies and is the natural
  replacement for the dropped Aczél 1966 Ch. 5 cite.
- [ ] **Verify Kuczma 2009 §4.3** (Hamel basis existence theorem,
  Theorem 4.3.1) if maximal pinpoint precision is needed for
  Proposition 5's construction. Current pin `[\S\S5.2 and 13.2]` is
  honest.
- [ ] **(Strategic) reconsider the “Folklore; cf.” framing in light of
  Aczél §2.1.4's weaker statement.** The continuous-coefficient
  regularity-free Theorem~1 may be a more original observation than
  the manuscript currently claims. Options: (a) keep the hedge as
  conservative (safer for refereeing); (b) strengthen the
  contribution claim in the abstract / intro / conclusion.
