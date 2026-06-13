# Monthly Patch Set — Continuous-Coefficient Jensen Equation

**Status of anchoring.** No `.tex` is in this session's uploads, so every patch is keyed to a quoted LOCATE anchor from the draft as established in our review. Upload the source file and these can be applied mechanically (and renumbered if the draft's proposition numbering differs — see Task T14).

**Citation discipline.** Every reference introduced by a patch is marked ✔ (verified this session, full data in §R) or ◻ (on the recheck list, expected data given). No ◻ citation should ship without clearing its task.

---

## P1 — Proposition 5: repair the basis-location step  *(correctness — mandatory)*

**LOCATE:** "Since $H$ has cardinality $\mathfrak{c}$ and $\mathbb{Q}\cup\{1\}$ is countable, $H$ contains an irrational $h\in(0,1)$."

**PROBLEM:** Invalid inference: cardinality does not control location. A Hamel basis can be rescaled element-by-element into $[1,2]$, containing no point of $(0,1)$.

**REPLACE WITH:**

```latex
Fix a Hamel basis $H_0$ containing $1$ and choose any $h'\in H_0\setminus\{1\}$;
since distinct rationals are $\mathbb{Q}$-dependent, $h'$ is irrational. Pick a
rational $q>0$ with $h:=qh'\in(0,1)$ and set
$H:=(H_0\setminus\{h'\})\cup\{h\}$. Replacing a basis vector by a nonzero
rational multiple preserves both independence and spanning, so $H$ is a Hamel
basis containing $1$ and the irrational $h\in(0,1)$.
```

*(Optional footnote, citable support for the rescaling device:)*
```latex
\footnote{Rescaling basis elements by rationals to place them in prescribed
intervals is a standard device; see, e.g., Reem~\cite{Reem2017}, Remark~3.4,
where it is used (after an idea of Z.~Boros) to produce a Hamel basis dense
in $\mathbb{R}$.}
```
✔ Reem 2017 verified, incl. the Remark 3.4 rescaling construction.

---

## P2 — Table 1: fix rows R4–R5 attributions  *(scholarship — mandatory)*

**LOCATE:** the Table 1 rows assigning "boundedness on a set of positive measure" to **Steinhaus** and "boundedness on an interval" to **Ostrowski**.

**REPLACE the two rows WITH:**

```latex
Boundedness on a measurable set of positive measure
  & Kormes (1926)\footnotemark[1] \\
Boundedness on an interval
  & Darboux (1875) \\
```
```latex
\footnotetext[1]{One-sided version (bounded above on a set of positive
measure): Ostrowski (1929), Kestelman (1947). Steinhaus's difference-set
theorem (1920) powers the modern proofs of the measure-theoretic rows but is
itself a tool, not a regularity theorem; see Reem~\cite{Reem2017} for the
historical catalogue and Kuczma~\cite{Kuczma}, \S 13.2.}
```

Catalogue basis (verified, Reem's survey): Cauchy — continuity; Darboux — monotone **or** bounded on an interval; Fréchet/Banach/Sierpiński — measurable; Kormes — bounded on positive measure; Ostrowski/Kestelman — bounded from one side on positive measure. ◻ exact biblio data for Kormes, Darboux×2, Kestelman: Tasks T1–T3.

**ALSO SWEEP:** any prose sentence near the table repeating the old attribution ("…due to Steinhaus", "Ostrowski's interval result") — align with the corrected rows.

---

## P3 — Theorem 4: replace the deferred sketch with the half-page proof  *(rigor — strongly recommended)*

**LOCATE:** the proof sketch of Theorem 4 ending in a deferral to [9] (Aczél–Dhombres).

**REPLACE WITH (or move to an appendix and point to it):**

```latex
\begin{proof}
Fix $x_0\in C$, set $D:=C-x_0$ (convex, $0\in D$) and
$A(v):=G(x_0+v)-G(x_0)$, so $A(0)=0$.

\emph{(i) Positive homogeneity.} For $v\in D$, $p\in[0,1]$, the hypothesis
with $x_1=x_0+v$, $x_2=x_0$ gives $A(pv)=p\,A(v)$.

\emph{(ii) Additivity where defined.} For $v,w\in D$, the hypothesis with
$x_1=x_0+v$, $x_2=x_0+w$, $p=\tfrac12$ gives
$A\!\bigl(\tfrac{v+w}{2}\bigr)=\tfrac12\bigl(A(v)+A(w)\bigr)$; by (i),
$A\!\bigl(\tfrac{v+w}{2}\bigr)=\tfrac12 A(v+w)$ whenever $v+w\in D$, whence
$A(v+w)=A(v)+A(w)$ whenever $v,w,v+w\in D$.

\emph{(iii) Extension.} On the cone $D^\ast:=\bigcup_{\lambda>0}\lambda D$
define $\hat A(\lambda v):=\lambda A(v)$ for $v\in D$, $\lambda>0$; this is
well defined by (i) (scale two representations of the same point into $D$
and compare) and additive on $D^\ast$ (scale a sum into $D$, apply (ii),
scale back). Every $u\in\operatorname{span}(C-C)=D^\ast-D^\ast$ is $u=v-w$
with $v,w\in D^\ast$; set $a(u):=\hat A(v)-\hat A(w)$, well defined and
additive by the additivity of $\hat A$, and $\mathbb{R}$-homogeneous because
homogeneity over the \emph{reals} is inherited from (i) --- this is where the
continuum of weights acts in dimension $>1$. Then
$G(x)=a(x-x_0)+G(x_0)$ on $C$.
\end{proof}
```

---

## P4 — Section 5: reclassify the vNM example as an existence-gate failure  *(taxonomy — mandatory; addresses the known misclassification)*

**LOCATE:** the paragraph classifying the expected-utility/vNM discussion as an instance "of the first kind" (finite mixing / rational weights).

**REPLACE the classification sentences WITH:**

```latex
This failure is not of the first kind: the independence axiom is stated at
every \emph{real} $p\in(0,1]$, so the weights are not the problem. It is
logically prior. Theorem~1 takes as input a real-valued function satisfying
$(\star)$ and reports its form; it cannot conjure the function. Absent the
Archimedean axiom no real-valued representation $U$ exists at all ---
lexicographic preferences are complete, transitive, and independent yet admit
no real-valued representation --- so $(\star)$ is vacuous rather than
rationally restricted. We therefore record a \emph{zeroth} entry of the
diagnostic, to be checked before the four sources: \emph{does a real-valued
solution provably exist?} Only after an existence axiom (here, Archimedean
continuity) clears that gate does the question ``which weights test the
identity?'' arise.
```

**ALSO:** update the diagnostic summary list/box (if present) to lead with the zeroth gate.

---

## P5 — Calibration paragraph: insert the realizability sentence  *(rigor — mandatory)*

**LOCATE:** the two-cell calibration passage, immediately before the displayed identity $p\,G(u_1)+(1-p)\,G(u_2)=G(pu_1+(1-p)u_2)$.

**INSERT:**

```latex
Because the underlying space is atomless, every triple
$(u_1,u_2,p)\in[m,M]^2\times[0,1]$ is realized by some two-cell instance:
masses sweep all of $[0,1]$ by Sierpi\'nski's intermediate-value theorem for
atomless measures \cite{Sierpinski1922}, and the within-cell values are
prescribed freely. The identity below is therefore asserted on the entire
domain of $G$, and $(\star)$ holds verbatim --- not merely on a subfamily.
```
✔ Sierpiński 1922 verified (Fund. Math. 3, 240–246; it is precisely the intermediate-value statement for additive continuous set functions).

---

## P6 — Scalar vs vector range theorem  *(citation precision — recommended)*

**LOCATE:** each invocation of Lyapunov's convexity theorem used only for "an atomless probability measure attains every value in $[0,1]$."

**ACTION:** cite Sierpiński \cite{Sierpinski1922} for the scalar statement; retain Lyapunov as a "see also" or wherever a genuinely vector-valued range is consumed.

---

## P7 — New worked example (Source 4, second instance): mixture-affine assignments on quantum states  *(impact — the Theorem 4 consumer)*

**LOCATE:** Section 5, after the calibration example.

**INSERT (≈0.75 page):**

```latex
\subsection*{Mixture-affine assignments on quantum states}
The density operators $\mathcal S_d$ on $\mathbb{C}^d$ form a convex set, and
the statistical mixture $p\rho_1+(1-p)\rho_2$ is \emph{operationally
primitive}: prepare $\rho_1$ with probability $p$ using a classical
randomizer, with $p$ ranging over a genuine continuum. Let
$v:\mathcal S_d\to\mathbb{R}$ be any assignment respecting mixtures,
\[
v\bigl(p\rho_1+(1-p)\rho_2\bigr)=p\,v(\rho_1)+(1-p)\,v(\rho_2)
\qquad(\rho_i\in\mathcal S_d,\ p\in[0,1]).
\]
This is the hypothesis of Theorem~4 on the convex set $\mathcal S_d$, so $v$
extends to an affine functional; by the self-duality of the Hermitian trace
pairing, $v(\rho)=\operatorname{tr}(A\rho)+b$ for a Hermitian $A$ --- with no
positivity, boundedness, continuity, or measurability assumed of $v$. The
affine representation itself is operational folklore (see, e.g.,
Holevo~\cite{Holevo}, Lemma~1.6.1); what the present dictionary adds is a
diagnosis of why the dual derivations must pay more. Gleason-type theorems
work on the \emph{measurement} side: a frame function on effects is additive
over coarse-grainings of POVMs, and coarse-graining is finite mixing --- the
first kind. Additivity therefore yields homogeneity only over the
nonnegative rationals, and the rational-to-real step must be purchased with a
regularity hypothesis: nonnegativity in Gleason~\cite{Gleason1957} and
Busch~\cite{Busch2003}, ``prove continuity'' or positivity-based homogeneity
in Caves, Fuchs, Manne, and Renes~\cite{CFMR2004}, and, in the explicit
Cauchy-equation treatment of Wright and Weigert~\cite{WrightWeigert2019},
the catalogue that nonlinear frame functions cannot be bounded from either
side, continuous at zero, or Lebesgue measurable --- the rows of Table~1
rediscovered inside physics. Preparation tests the identity at every real
$p$; coarse-graining tests it only at rationals. The dictionary predicts
exactly where each route must spend a hypothesis, and the derivations cited
above spend it exactly there.
```
✔ Busch 2003 (PRL **91**, 120403), CFMR 2004 (Found. Phys. **34**(2), 193–209), Wright–Weigert 2019 (Found. Phys., DOI 10.1007/s10701-019-00275-x; their Thm 1 covers exactly the listed hypotheses) all verified. ◻ Holevo Lemma 1.6.1: Busch's own PRL cites it for the state-side representation — confirm lemma number against the edition cited (Task T5). ◻ Gleason 1957 venue naming (Task T6).

---

## P8 — Piecewise saturation corollary + the tent sentence  *(impact — welds Example 5 to the broader program)*

**LOCATE:** immediately after Theorem 3 (or after the calibration example).

**INSERT:**

```latex
\begin{corollary}[Piecewise saturation]
Let $0=m_0<m_1<\dots<m_k=M$ and suppose $G:[0,M]\to\mathbb{R}$ satisfies
$(\star)$ separately on each cell $[m_{i-1},m_i]$. Then $G$ is affine on each
cell, hence piecewise affine and (being a single function whose affine pieces
share their endpoint values) continuous on $[0,M]$ --- with no regularity
hypothesis. Global affineness does not follow: the slopes may differ across
knots.
\end{corollary}
\begin{proof}
Apply Theorem~1 on each cell after the affine change of variable
$v\mapsto (v-m_{i-1})/(m_i-m_{i-1})$.
\end{proof}
\noindent For instance, a surrogate score on $[0,1]$ that aggregates exactly
on each of $[0,\tfrac12]$ and $[\tfrac12,1]$ is necessarily piecewise affine
--- the tent shape --- with nothing assumed at the kink or anywhere else.
```

*(Deliberately self-contained: no citation to unpublished companion work; the COLT/TMLR line can later cite this corollary.)*

---

## P9 — Introduction: the lineage sentence  *(positioning — recommended)*

**LOCATE:** end of the introduction's motivation paragraph.

**INSERT:**

```latex
The pattern --- atomlessness retiring a classical hypothesis --- has a
distinguished ancestor: in exchange economies with an atomless continuum of
traders, Aumann showed that convexity of preferences becomes unnecessary,
Lyapunov's theorem supplying for free what the hypothesis used to buy
\cite{Aumann1964}. The present note records the same phenomenon one level
down, at the level of a single functional equation.
```
◻ Aumann 1964, Econometrica **32**(1–2), 39–50 — standard; confirm pages (Task T7).

---

## P10 — Optional remark after Theorem 3: irrational weights alone suffice  *(Monthly flavor — optional but cheap)*

**INSERT:**

```latex
\begin{remark}
The weight set need not contain a single rational. Suppose the identity of
Theorem~3 (or $(\star)$ in full) holds merely for all \emph{irrational}
$p\in(0,1)$, and let $L$ be the affine interpolant of $G(0),G(M)$. If $v/M$
is irrational, the endpoint substitution at $p=v/M$ gives $G(v)=L(v)$
directly. If $v/M$ is rational with $0<v<M$, choose the irrational
$p=\tfrac{\sqrt2}{2}$ and $\varepsilon>0$ small with
$\varepsilon/M=\tfrac{\sqrt3}{n}$; then $u_1:=v+(1-p)\varepsilon$ and
$u_2:=v-p\varepsilon$ lie in $[0,M]$, the ratios $u_1/M$, $u_2/M$ are
irrational (each is rational plus irrational, since
$\sqrt3-\tfrac{\sqrt6}{2}$ and $\tfrac{\sqrt6}{2}$ are irrational), and
$pu_1+(1-p)u_2=v$. Applying the hypothesis at $(u_1,u_2,p)$ and using the
already-established $G(u_i)=L(u_i)$ yields
$G(v)=pL(u_1)+(1-p)L(u_2)=L(v)$. The Hamel pathologies live at irrational
weights; it is fitting that irrational weights alone suffice to exclude them.
\end{remark}
```
◻ Prior-art sweep before shipping (Daróczy–Páles single-weight Jensen literature): Task T9.

---

## P11 — Bibliography edits  *(mandatory)*

1. **[25] Aczél–Wagner:** DELETE the note "Title and venue verification pending." SET: *A characterization of weighted arithmetic means*, SIAM J. Algebraic Discrete Methods **1**(3) (1980), 259–260. ✔
2. **ADD (all consumed by patches above):**
   - W. Sierpiński, *Sur les fonctions d'ensemble additives et continues*, Fund. Math. **3** (1922), 240–246. ✔
   - P. Busch, *Quantum states and generalized observables: a simple proof of Gleason's theorem*, Phys. Rev. Lett. **91** (2003), 120403. ✔
   - C. M. Caves, C. A. Fuchs, K. K. Manne, J. M. Renes, *Gleason-type derivations of the quantum probability rule for generalized measurements*, Found. Phys. **34**(2) (2004), 193–209. ✔
   - V. J. Wright, S. Weigert, *Gleason-type theorems from Cauchy's functional equation*, Found. Phys. **49** (2019). ✔ (confirm volume/pages at proof: Task T10)
   - A. M. Gleason, *Measures on the closed subspaces of a Hilbert space*, J. Math. Mech. **6** (1957), 885–893. ◻ venue naming (T6)
   - A. S. Holevo, *Probabilistic and Statistical Aspects of Quantum Theory*, Lemma 1.6.1. ◻ edition/lemma no. (T5)
   - R. J. Aumann, *Markets with a continuum of traders*, Econometrica **32** (1964), 39–50. ◻ pages (T7)
   - D. Reem, *Remarks on the Cauchy functional equation and variations of it*, Aequationes Math. **91** (2017). ✔ (confirm vol/pages at proof)
   - M. Kormes (1926) ◻ T1; G. Darboux (1875), (1880) ◻ T2; H. Kestelman (1947) ◻ T3.

## P12 — Cross-reference and economy pass  *(editorial — mandatory)*

1. Fix self-referential pointers: occurrences of "(Section 5 below)" **inside** Section 5 → "(below)" or the specific subsection label.
2. **Section 5 economy** (per the relevance call): keep the calibration example and the new quantum example as the two Source-4 instances; keep the entropy characterization (it is what powers Table 2's load-bearing column — removing it collapses the contrast); compress the opinion-pools example to one sentence with citations ("…additivity into the bounded codomain $[0,1]$ supplies R5 for free, which is why every pool is a weighted average \cite{McConway1981, AczelWagner1980}."); replace the vNM paragraph per P4.
3. Add one sentence of humility to the diagnostic: "We do not claim the list of sources is exhaustive; countable ($\sigma$-)mixtures, for instance, assert a strictly stronger identity with its own theory."

---

## §R — Verified reference data (session log)

| Ref | Data | Status |
|---|---|---|
| Aczél–Wagner 1980 | SIAM JADM 1(3), 259–260 | ✔ |
| Ostrowski 1929 | Jber. DMV 38, 54–62 (one-sided positive-measure) | ✔ |
| Sierpiński 1922 | Fund. Math. 3, 240–246, DOI 10.4064/fm-3-1-240-246 | ✔ |
| Busch 2003 | PRL 91, 120403, DOI 10.1103/PhysRevLett.91.120403 | ✔ |
| Caves–Fuchs–Manne–Renes 2004 | Found. Phys. 34(2), 193–209 | ✔ |
| Wright–Weigert 2019 | Found. Phys., DOI 10.1007/s10701-019-00275-x; Thm 1: nonlinear frame functions not bounded above/below, not continuous at 0, not measurable | ✔ |
| Reem 2017 | Aequationes Math. (arXiv:1002.3721); regularity catalogue §1.1; Boros rescaling Rmk 3.4; Kuczma 13.2.1 local-to-global pointer | ✔ |
| Kuczma 2nd ed. | §13.2 = Jensen ch.; Thm 13.2.1 (extension), 13.2.3 | ✔ via Reem's pointers; page-check T4 |
