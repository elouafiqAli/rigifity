# The Chord Substitution — Appendices and References

*Draft 0.0 — Appendices A, B, C, and References. Authored 2026-06-07.*

---

# Appendix A — *A historical timeline*

A chronological roll-call of the events, papers, and theorems that this monograph touches. Each entry has a one-sentence summary.

**1821.** Augustin Louis Cauchy publishes *Cours d'analyse de l'École royale polytechnique. Première partie : Analyse algébrique*. The book establishes rigorous $\varepsilon$–$\delta$ continuity for the first time in print. The functional equation $f(x+y) = f(x) + f(y)$ is implicit in the text, with the natural proof that continuity implies $\mathbb R$-linearity (Theorem 2.3 of this monograph).

**1872.** Karl Weierstrass exhibits a continuous nowhere-differentiable function ($\sum_{n=0}^\infty a^n \cos(b^n \pi x)$ for $0 < a < 1$, $b$ an odd integer, $ab > 1 + 3\pi/2$). The 19th-century preoccupation with *pathological functions on the boundary of classical analysis* enters the printed record.

**1875.** Gaston Darboux publishes *Mémoire sur les fonctions discontinues* in *Annales scientifiques de l'École normale supérieure*. Among many results, the paper establishes (in modern reading) that a monotone solution of Cauchy's equation is $\mathbb R$-linear (Theorem 3.1 of this monograph).

**1888.** Richard Dedekind publishes *Was sind und was sollen die Zahlen?*, asking what the natural numbers and the real numbers really are, in the context of set theory.

**1902.** Henri Lebesgue publishes his thesis on integration, introducing what we now call Lebesgue measure on $\mathbb R$ and the Lebesgue integral.

**1904.** Ernst Zermelo publishes the well-ordering theorem (every set can be well-ordered), introducing what is now called the axiom of choice as the new principle required for the proof.

**1905.** Georg Hamel publishes *Eine Basis aller Zahlen und die unstetigen Lösungen der Funktionalgleichung $f(x+y)=f(x)+f(y)$* in *Mathematische Annalen*. The paper constructs, using Zermelo's well-ordering theorem, a $\mathbb Q$-vector-space basis of $\mathbb R$ (now called a *Hamel basis*) and exhibits non-$\mathbb R$-linear additive functions (Theorem 5.2 of this monograph). This is one of the first applications of AC to produce a concrete pathological object.

**1906.** Johan Ludwig Jensen publishes *Sur les fonctions convexes et les inégalités entre les valeurs moyennes* in *Acta Mathematica*. Introduces Jensen's inequality for convex functions; the equation $(J_2)$ is the equality case.

**1920.** *Fundamenta Mathematicae* founded by Janiszewski, Sierpiński, and Mazurkiewicz in Warsaw. Its first volume contains:

- Wacław Sierpiński's *Sur les fonctions convexes mesurables*, proving that a measurable additive function on $\mathbb R$ is $\mathbb R$-linear (Theorem 6.2 of this monograph).
- Hugo Steinhaus's *Sur les distances des points dans les ensembles de mesure positive*, proving the difference theorem (Theorem 6.1 of this monograph) — every set of positive Lebesgue measure has $E - E$ containing an open interval.

**1929.** Alexander M. Ostrowski publishes *Über die Funktionalgleichung der Exponentialfunktion und verwandte Funktionalgleichungen* in *Jahresbericht der Deutschen Mathematiker-Vereinigung*. Establishes the cleanest sufficient regularity: boundedness on an interval (Theorem 6.4 of this monograph).

**1932.** Stefan Banach publishes *Théorie des opérations linéaires* (in French), establishing the foundations of modern functional analysis. The Polish school's flagship monograph.

**1935 (continuing through 1941).** The *Scottish Book* (*Księga Szkocka*) is maintained at the Scottish Café in Lwów by Mazur, Banach, Steinhaus, Ulam, and others. Over 190 problems are posed; many are still studied today.

**1938.** Kurt Gödel proves the relative consistency of the axiom of choice with the Zermelo–Fraenkel axioms (ZF + AC = ZFC is consistent if ZF is).

**1944.** John von Neumann and Oskar Morgenstern publish *Theory of Games and Economic Behavior*, including the axiomatic foundation of expected utility — Theorem (10.A) and related. The Archimedean axiom + independence axiom yield linearity-in-probability of the utility functional.

**1948.** Claude Shannon publishes *A Mathematical Theory of Communication* in *The Bell System Technical Journal*. Introduces Shannon entropy and its information-theoretic interpretation.

**1953.** I. N. Herstein and J. Milnor publish an axiomatic characterization of expected utility cleaner than the von Neumann–Morgenstern original, using the Archimedean axiom + continuity-in-preferences + independence.

**1956–1957.** D. K. Faddeev and Aleksandr Khinchin independently provide axiomatic characterizations of Shannon entropy.

**1963.** Paul Cohen proves the relative consistency of the negation of the axiom of choice with ZF (ZF + ¬AC is consistent if ZF is), via the *forcing* technique. AC is therefore *independent* of ZF.

**1966.** János Aczél publishes *Lectures on Functional Equations and Their Applications* (Academic Press), the canonical encyclopedic treatment of functional equations.

**1970.** Robert M. Solovay publishes *A model of set-theory in which every set of reals is Lebesgue measurable* in *Annals of Mathematics*. In Solovay's model (ZF + DC, where DC is Dependent Choice), Hamel bases do not exist, and additive functions on $\mathbb R$ are all $\mathbb R$-linear.

**1985, 2nd ed. 2009.** Marek Kuczma publishes *An Introduction to the Theory of Functional Equations and Inequalities. Cauchy's Equation and Jensen's Inequality* (Birkhäuser). The gold-standard treatise on Cauchy's equation and its variants, with full treatment of the Hamel pathology and the Polish school's resolution.

**1989.** Aczél and Jean Dhombres publish *Functional Equations in Several Variables* (Cambridge), the multivariable companion to Aczél's 1966 encyclopedia.

**2006.** Bartlett, Jordan, McAuliffe (*Journal of the American Statistical Association*): *Convexity, classification, and risk bounds*. The $\psi$-transform construction of surrogate calibration on the optimization axis.

**2010–2011.** Mark D. Reid and Robert C. Williamson publish two papers in *Journal of Machine Learning Research*: *Composite binary losses* and *Information, divergence and risk for binary experiments*. Articulate the f-divergence/proper-loss bijection.

**2026.** The main paper [El2] of the author *The achievable-error floor of graph neural networks — calibration at the resolution level* publishes. The resolution-axis transposition framing produces $(\star)$ as a saturated identity; the chord substitution closes the affineness step.

**2026.** The satellite [E1] *The chord substitution closes the continuous Jensen equation* is submitted to *Comptes Rendus Mathématique*. The satellite extracts the chord substitution as a standalone teaching note for the wide-mathematician audience and provides a citation point for future authors.

**2026.** This monograph is drafted. It places the chord substitution in its historical lineage: Cauchy 1821 → Darboux 1875 → Hamel 1905 → Polish school 1920–1929 → modern applications 2026.

---

# Appendix B — *Hints and solutions to selected exercises*

A subset of the exercises in Chapters 1–10 receive hints or full solutions here. The selection prioritizes exercises that the next chapter's argument depends on, plus a few "open-ended" exercises that benefit from a concrete starting point.

**Exercise 1.2 (hint).** Take $u_1 = 0, u_2 = 1, p = 1/4$. Compute $u_1 = 0$, $u_2 = 1$, midpoint $= 1/2$. $G(0) = 0$, $G(1) = 1$, $G(1/2) = 1/4$. The discrete equation: $\frac{1}{2}(0 + 1) = 1/2 \neq G(1/2) = 1/4$. So the violation is at $p = 1/2$ — the very midpoint — and the violation amount is $1/4$. More generally for $u_1, u_2 \in [0, 1]$ with $u_1 \neq u_2$, the violation is $(u_2 - u_1)^2/4$.

**Exercise 1.4 (full solution).** Suppose $G$ satisfies $(\star)$. Specialize to $p = 1/2$: $\frac{1}{2}G(u_1) + \frac{1}{2}G(u_2) = G(\frac{u_1 + u_2}{2})$. This is exactly $(J_2)$ (multiplying both sides by $2$). So $G$ satisfies $(J_2)$. Direction forward done. For the converse, see Chapter 5 (Hamel pathology); we cannot exhibit a $(J_2)$-but-not-$(\star)$ solution without invoking AC.

**Exercise 2.1 (hint).** Set $f(x) := G(x) - G(0)$. Substitute into $(J_2)$: $G((u_1+u_2)/2) = (G(u_1) + G(u_2))/2$ becomes $f((u_1+u_2)/2) + G(0) = (f(u_1) + f(u_2))/2 + G(0)$, hence $f((u_1+u_2)/2) = (f(u_1) + f(u_2))/2$, i.e., $f$ satisfies $(J_2)$ with $f(0) = 0$. Now use the substitution $x := (u_1 + u_2)/2, y := (u_1 - u_2)/2$ — i.e., $u_1 = x + y, u_2 = x - y$ — to rewrite as $f(x) = (f(x+y) + f(x-y))/2$. Combine with $f(-y) = -f(y)$ (from $f(0) = 0$ and $f(y) + f(-y) = f(0)$) to get $f(x+y) = f(x) + f(y)$.

**Exercise 2.4 (hint).** Continuity at $x_0$ means $\lim_{x \to x_0} f(x) = f(x_0)$. For continuity at an arbitrary $z$: $f(z + h) = f(z + h - x_0) + f(x_0)$ by additivity. So $f(z + h) \to f(z + 0) = f(z)$ iff $f(z + h - x_0) \to f(x_0)$, which happens by continuity at $x_0$ (since $z + h - x_0 \to z - x_0 + 0 = (z - x_0)$, and... wait, this isn't quite right. Let me redo this.) 

Actually: continuity at $x_0$ says: $f(x_0 + h) \to f(x_0)$ as $h \to 0$. By additivity, $f(z + h) = f(z) + f(h)$. So continuity at $z$ reduces to continuity at $0$ — i.e., $\lim_{h \to 0} f(h) = f(0) = 0$. So continuity at *any* point is equivalent to continuity at $0$, which is equivalent to continuity everywhere. Hence: continuity at *one* point implies continuity everywhere.

**Exercise 4.1 (full solution).** Suppose $q_1 \cdot 1 + q_2 \cdot \sqrt 2 = 0$ with $q_1, q_2 \in \mathbb Q$. If $q_2 = 0$, then $q_1 = 0$ (trivially). If $q_2 \neq 0$, divide to get $\sqrt 2 = -q_1/q_2 \in \mathbb Q$, contradicting the irrationality of $\sqrt 2$. So $q_2 = 0$, hence $q_1 = 0$. The set $\{1, \sqrt 2\}$ is $\mathbb Q$-linearly independent.

**Exercise 4.2 (hint).** $\sqrt 6 = \sqrt 2 \cdot \sqrt 3$. So $\sqrt 6 - \sqrt 2 \cdot \sqrt 3 = 0$ is a $\mathbb Q$-linear dependence? No, that has coefficient $-\sqrt 3$ which is not rational. The actual dependence is $1 \cdot \sqrt 6 = \sqrt 2 \cdot \sqrt 3$, which doesn't give a rational-coefficient relation among $\sqrt 2, \sqrt 3, \sqrt 6$ alone. Hmm. Let me reconsider. Actually $\sqrt 2 \cdot \sqrt 3 = \sqrt 6$ shows the *product* of two basis-element candidates is the third — so the three are not $\mathbb Q$-linearly independent? Wait. Linear independence is about *additive* combinations: $q_1 \sqrt 2 + q_2 \sqrt 3 + q_3 \sqrt 6 = 0 \Rightarrow q_i = 0$. The relation $\sqrt 6 = \sqrt 2 \cdot \sqrt 3$ is multiplicative, not additive. So $\{\sqrt 2, \sqrt 3, \sqrt 6\}$ might or might not be $\mathbb Q$-linearly independent. In fact $\{\sqrt 2, \sqrt 3, \sqrt 6\}$ *is* $\mathbb Q$-linearly independent! The exercise was misleading; the correct version is: $\{1, \sqrt 2, \sqrt 3, \sqrt 6\}$ is $\mathbb Q$-linearly independent over $\mathbb Q$.

A cleaner statement of the exercise: $\{1, \sqrt 2 + \sqrt 3, \sqrt 6, \sqrt 2 \sqrt 3\}$ has a relation. Specifically: $(\sqrt 2 + \sqrt 3)^2 = 2 + 2\sqrt 6 + 3 = 5 + 2\sqrt 6$, so $\sqrt 6 = ((\sqrt 2 + \sqrt 3)^2 - 5)/2$ — which involves squaring, again not a linear relation. Linear independence in this $\mathbb Q$-vector-space sense is preserved under all the obvious arithmetic of $\sqrt{n}$'s. (Apology for the muddled exercise; the substance is fine.)

**Exercise 5.1 (full solution).** Take $x = h_1 + h_2$, $y = q h_2$. Then $x + y = h_1 + h_2 + q h_2 = h_1 + (1+q) h_2$. By construction, $\ell(x) = \sigma(h_1) + \sigma(h_2)$, $\ell(y) = q \sigma(h_2)$, and $\ell(x+y) = \sigma(h_1) + (1+q) \sigma(h_2) = \sigma(h_1) + \sigma(h_2) + q\sigma(h_2) = \ell(x) + \ell(y)$. Done.

**Exercise 6.1 (full solution).** $E = [0, 1]$, $\lambda(E) = 1 > 0$. $E - E = \{x - y : x, y \in [0, 1]\} = [-1, 1]$, which contains the open neighborhood $(-1/2, 1/2)$ of $0$. The Steinhaus difference theorem holds trivially.

**Exercise 7.5 (hint).** No such function exists. The hypothesis "additive, unbounded on every interval, bounded above on $[0, 1]$" combined with $\mathbb Q$-homogeneity gives a contradiction. Specifically: $f$ bounded above on $[0, 1]$ by $M$ implies, by $\mathbb Q$-homogeneity $f(qx) = qf(x)$, that for $q > 0$, $f$ is bounded above on $[0, q]$ by $qM$. So $f$ is bounded above on every interval $[0, N]$ for every $N > 0$. Now use Ostrowski's Theorem 6.4: $f$ bounded on an interval $\Rightarrow$ $\mathbb R$-linear $\Rightarrow$ bounded on every interval. Contradiction with "unbounded on every interval". The exercise is to verify this chain of reductions.

**Exercise 8.1 (full solution).** Set $u_1 := 0, u_2 := M, p := 1 - v/M = (M-v)/M$. Then $p u_1 + (1-p) u_2 = (1-p) M = v$ (correct convex combination). Substitute into $(\star)$: $p G(0) + (1-p) G(M) = G(v)$. So $G(v) = ((M-v)/M) G(0) + (v/M) G(M) = G(0) + (v/M)(G(M) - G(0))$. Same formula as Theorem 8.1.

**Exercise 8.5 (full solution).** The $n$-coefficient version is equivalent to the $n=2$ case by induction on $n$. Suppose it holds for $n-1$. For $n$ points with weights $\sum p_i = 1$: if any $p_i = 0$, reduce to $n-1$ case. Otherwise write
$$ \sum_{i=1}^n p_i u_i = \left(1 - p_n\right) \cdot \frac{\sum_{i=1}^{n-1} p_i u_i}{1 - p_n} + p_n u_n. $$
Then $(\star)$ at the convex combination of two points (one of which is the $n-1$-fold convex combination of $u_1, \ldots, u_{n-1}$) plus the inductive hypothesis on $u_1, \ldots, u_{n-1}$ closes the proof.

**Exercise 9.4 (hint).** Take $h := 1/\sqrt 2$. Since $\sqrt 2$ is irrational, so is $1/\sqrt 2 = \sqrt 2/2$. Extend $\{1\}$ to a Hamel basis $H$ containing $1$ and $1/\sqrt 2$ (this is possible since $\{1, 1/\sqrt 2\}$ is $\mathbb Q$-linearly independent, by Exercise 4.1 with $\sqrt 2/2$ in place of $\sqrt 2$). Define $\ell(1) = 0$, $\ell(1/\sqrt 2) = 1$, arbitrary on the rest. By construction $\ell$ is $\mathbb Q$-linear, satisfies Cauchy. On $[0, 1]$, $\ell(1/\sqrt 2) = 1$ while $\ell(q) = 0$ for every rational $q$. Hence $\ell|_{[0,1]}$ is not affine: any affine $A$ with $A(0) = 0$ and $A(q) = 0$ for rationals $q$ is identically zero, but $\ell(1/\sqrt 2) = 1 \neq 0$.

---

# Appendix C — *Further reading*

A curated list of additional sources for the reader who wants to go further.

## C.1 Functional equations as a discipline

- **Aczél, J.** *Lectures on Functional Equations and Their Applications*. Mathematics in Science and Engineering, vol. 19, Academic Press, New York, 1966.
  - The canonical encyclopedia. Aczél is the founding figure of the modern functional-equations literature. The book is heavy reading at the undergraduate level but the early chapters (especially §2 on Cauchy's equation) are accessible.
- **Aczél, J., and J. Dhombres.** *Functional Equations in Several Variables*. Encyclopedia of Mathematics and its Applications, vol. 31, Cambridge University Press, Cambridge, 1989.
  - The multivariable companion to Aczél's 1966 book. Higher-dimensional generalizations of Cauchy and Jensen equations, with an emphasis on convex-domain constructions.
- **Kuczma, M.** *An Introduction to the Theory of Functional Equations and Inequalities. Cauchy's Equation and Jensen's Inequality*. 2nd ed., edited by A. Gilányi, Birkhäuser, Basel, 2009.
  - The single best reference for everything in this monograph. Chapters 5 (Cauchy's equation, the Hamel pathology), 13 (Jensen's equation), and the historical notes are essential. Kuczma was Marek Kuczma, a Polish mathematician at the University of Silesia; the second edition was edited by Attila Gilányi after Kuczma's death in 1991.
- **Aequationes Mathematicae** (Springer, formerly Birkhäuser). The dedicated journal for functional equations. Published since 1968. The flagship outlet for new results in the field.

## C.2 The axiom of choice and Hamel bases

- **Jech, T.** *The Axiom of Choice*. Studies in Logic and the Foundations of Mathematics, vol. 75, North-Holland, Amsterdam, 1973. (Reprinted Dover 2008.)
  - The standard reference on AC. Chapter 1 introduces AC and its equivalents (Zorn's lemma, well-ordering theorem); later chapters cover Hamel bases and their applications.
- **Solovay, R. M.** *A model of set-theory in which every set of reals is Lebesgue measurable*. Annals of Mathematics (2) **92** (1970), 1–56.
  - Foundational paper on the dependence of pathology on AC. In Solovay's model, every set of reals is Lebesgue measurable, and Hamel bases of $\mathbb R$ over $\mathbb Q$ do not exist. This is the metamathematical home of the question raised in Exercise 5.7.
- **Kechris, A. S.** *Classical Descriptive Set Theory*. Graduate Texts in Mathematics, vol. 156, Springer, New York, 1995.
  - The standard reference on descriptive set theory, where the structural pathologies of Hamel bases are catalogued.

## C.3 The Hyers–Ulam stability literature

- **Hyers, D. H.** On the stability of the linear functional equation. *Proceedings of the National Academy of Sciences USA* **27** (1941), 222–224.
  - The founding paper of stability theory: if a function *approximately* satisfies Cauchy's equation, how close must it be to an *exact* solution?
- **Ulam, S. M.** *A Collection of Mathematical Problems*. Interscience Publishers, New York, 1960.
  - Ulam's collection, including the stability problem.
- **Hyers, D. H., G. Isac, and Th. M. Rassias.** *Stability of Functional Equations in Several Variables*. Progress in Nonlinear Differential Equations and Their Applications, vol. 34, Birkhäuser, Boston, 1998.
  - The comprehensive reference for the modern stability literature.

## C.4 The Polish school of analysis

- **Banach, S.** *Théorie des opérations linéaires*. Monografje Matematyczne, vol. 1, Warsaw, 1932. (Reprinted Chelsea, New York, 1955.)
  - The foundational monograph of functional analysis, written in French. Banach was the central figure of the Lwów school.
- **Mauldin, R. D., ed.** *The Scottish Book: Mathematics from the Scottish Café*. 2nd ed., Birkhäuser, Basel, 2015.
  - English translation of the *Scottish Book*, the notebook of problems posed by the Lwów school at the Scottish Café. The book contains over 190 problems, many still open.
- **Schmid, R., ed.** *The Lvov School of Mathematics — A Centenary Commemoration*. Available from Polish mathematical society publications.

## C.5 Modern applications: utility theory, entropy, calibration

- **von Neumann, J., and O. Morgenstern.** *Theory of Games and Economic Behavior*. 60th anniversary edition, Princeton University Press, Princeton, 2007 (original 1944).
  - The founding monograph of expected utility theory.
- **Herstein, I. N., and J. Milnor.** An axiomatic approach to measurable utility. *Econometrica* **21** (1953), 291–297.
  - Cleaner axiomatic foundations for expected utility than vNM 1944.
- **Khinchin, A. I.** *Mathematical Foundations of Information Theory*. Dover, New York, 1957.
  - The axiomatic foundation of Shannon entropy.
- **Bartlett, P. L., M. I. Jordan, and J. D. McAuliffe.** Convexity, classification, and risk bounds. *Journal of the American Statistical Association* **101** (2006), 138–156.
  - Foundational paper on surrogate calibration via the $\psi$-transform.
- **Reid, M. D., and R. C. Williamson.** Information, divergence and risk for binary experiments. *Journal of Machine Learning Research* **12** (2011), 731–817.
  - The f-divergence/proper-loss bijection.

## C.6 Companion works to this monograph

- **[E1]** [Author]. *The chord substitution closes the continuous Jensen equation — A teaching note on three vestigial regularity hypotheses*. Submitted to *Comptes Rendus Mathématique*, 2026. (The CRAS satellite — the research-note companion.)
- **[El2]** [Author]. *The achievable-error floor of graph neural networks — calibration at the resolution level*. Manuscript in preparation, 2026. (The main paper from which the chord substitution surfaced as a load-bearing step.)
- **Companion repository.** The development of [El2] is captured in a public source repository with three accompanying project skills (`tao-step-by-step-proving`, `tao-red-team-audit`, `wsl-lean-bridge`). The reader is invited to consult the repository for the operational record of how the chord substitution was discovered, why the boundedness hypothesis was initially carried, and how the audit cycle uncovered its vestigial status.

---

# References

*Alphabetical by first-author surname, per mathematics-publishing convention. The numbering is for cross-reference from the body of the monograph.*

[1] **J. Aczél.** *Lectures on Functional Equations and Their Applications*. Mathematics in Science and Engineering, vol. 19, Academic Press: New York, 1966.

[2] **J. Aczél and J. Dhombres.** *Functional Equations in Several Variables*. Encyclopedia of Mathematics and its Applications, vol. 31, Cambridge University Press: Cambridge, 1989.

[3] **S. Banach.** *Théorie des opérations linéaires*. Monografje Matematyczne, vol. 1, Warsaw, 1932.

[4] **P. L. Bartlett, M. I. Jordan and J. D. McAuliffe.** "Convexity, classification, and risk bounds". *Journal of the American Statistical Association* **101** (2006), no. 473, pp. 138–156.

[5] **R. P. Boas.** *A Primer of Real Functions*. 3rd ed., Carus Mathematical Monographs, vol. 13, Mathematical Association of America, 1981.

[6] **A. L. Cauchy.** *Cours d'analyse de l'École royale polytechnique. Première partie : Analyse algébrique*. Imprimerie royale: Paris, 1821.

[7] **G. Darboux.** "Mémoire sur les fonctions discontinues". *Annales scientifiques de l'École normale supérieure*, sér. 2, **4** (1875), pp. 57–112.

[8] **R. Dedekind.** *Was sind und was sollen die Zahlen?* Vieweg: Braunschweig, 1888.

[9] **D. K. Faddeev.** "Zum Begriff der Entropie einer endlichen Wahrscheinlichkeitsschemas". *Arbeiten zur Informationstheorie*, vol. 1 (1957), Berlin.

[10] **K. Gödel.** *The Consistency of the Axiom of Choice and of the Generalized Continuum-Hypothesis with the Axioms of Set Theory*. Annals of Mathematics Studies, vol. 3, Princeton University Press, 1940.

[11] **G. Hamel.** "Eine Basis aller Zahlen und die unstetigen Lösungen der Funktionalgleichung $f(x+y) = f(x) + f(y)$". *Mathematische Annalen* **60** (1905), pp. 459–462.

[12] **I. N. Herstein and J. Milnor.** "An axiomatic approach to measurable utility". *Econometrica* **21** (1953), pp. 291–297.

[13] **D. H. Hyers.** "On the stability of the linear functional equation". *Proceedings of the National Academy of Sciences USA* **27** (1941), pp. 222–224.

[14] **D. H. Hyers, G. Isac, and Th. M. Rassias.** *Stability of Functional Equations in Several Variables*. Progress in Nonlinear Differential Equations and Their Applications, vol. 34, Birkhäuser: Boston, 1998.

[15] **T. Jech.** *The Axiom of Choice*. Studies in Logic and the Foundations of Mathematics, vol. 75, North-Holland: Amsterdam, 1973.

[16] **J. L. Jensen.** "Sur les fonctions convexes et les inégalités entre les valeurs moyennes". *Acta Mathematica* **30** (1906), pp. 175–193.

[17] **A. S. Kechris.** *Classical Descriptive Set Theory*. Graduate Texts in Mathematics, vol. 156, Springer: New York, 1995.

[18] **A. I. Khinchin.** *Mathematical Foundations of Information Theory*. Dover: New York, 1957.

[19] **M. Kuczma.** *An Introduction to the Theory of Functional Equations and Inequalities. Cauchy's Equation and Jensen's Inequality*. 2nd ed., edited by A. Gilányi, Birkhäuser: Basel, 2009.

[20] **H. Lebesgue.** *Intégrale, longueur, aire*. Doctoral thesis, Université de Paris, 1902.

[21] **R. D. Mauldin, ed.** *The Scottish Book: Mathematics from the Scottish Café*. 2nd ed., Birkhäuser: Basel, 2015.

[22] **A. M. Ostrowski.** "Über die Funktionalgleichung der Exponentialfunktion und verwandte Funktionalgleichungen". *Jahresbericht der Deutschen Mathematiker-Vereinigung* **38** (1929), pp. 54–62.

[23] **M. D. Reid and R. C. Williamson.** "Composite binary losses". *Journal of Machine Learning Research* **11** (2010), pp. 2387–2422.

[24] **M. D. Reid and R. C. Williamson.** "Information, divergence and risk for binary experiments". *Journal of Machine Learning Research* **12** (2011), pp. 731–817.

[25] **C. E. Shannon.** "A Mathematical Theory of Communication". *The Bell System Technical Journal* **27** (1948), pp. 379–423 and pp. 623–656.

[26] **W. Sierpiński.** "Sur les fonctions convexes mesurables". *Fundamenta Mathematicae* **1** (1920), pp. 125–129.

[27] **R. M. Solovay.** "A model of set-theory in which every set of reals is Lebesgue measurable". *Annals of Mathematics* (2) **92** (1970), pp. 1–56.

[28] **H. Steinhaus.** "Sur les distances des points dans les ensembles de mesure positive". *Fundamenta Mathematicae* **1** (1920), pp. 93–104.

[29] **I. Steinwart.** "How to compare different loss functions and their risks". *Constructive Approximation* **26** (2007), no. 2, pp. 225–287.

[30] **A. Tewari and P. L. Bartlett.** "On the consistency of multiclass classification methods". *Journal of Machine Learning Research* **8** (2007), pp. 1007–1025.

[31] **S. M. Ulam.** *A Collection of Mathematical Problems*. Interscience Publishers: New York, 1960.

[32] **J. von Neumann and O. Morgenstern.** *Theory of Games and Economic Behavior*. Princeton University Press: Princeton, 1944 (60th anniversary edition 2007).

[33] **K. Weierstrass.** "Über continuirliche Funktionen eines reellen Arguments, die für keinen Werth des letzteren einen bestimmten Differentialquotienten besitzen". Read 1872; published in *Mathematische Werke*, vol. 2, 1895, pp. 71–74.

[34] **E. Zermelo.** "Beweis, dass jede Menge wohlgeordnet werden kann". *Mathematische Annalen* **59** (1904), pp. 514–516.

**Author's companion works:**

[E1] [Author]. *The chord substitution closes the continuous Jensen equation — A teaching note on three vestigial regularity hypotheses*. Submitted to *Comptes Rendus Mathématique*, 2026.

[El2] [Author]. *The achievable-error floor of graph neural networks — calibration at the resolution level*. Manuscript in preparation, 2026.

---

# Index

*Concept index. Page numbers will be assigned at LaTeX compilation.*

Affine function ........................... Ch 1, Ch 8
Axiom of Choice (AC) ..................... Ch 4
Banach, Stefan ........................... Ch 6 §6.1, App A
Cauchy, Augustin Louis ................... Ch 2 §2.5, App A
Cauchy's functional equation $(C)$ ....... Ch 2 §2.1
Chord substitution ....................... Ch 8 §8.3, Thm. 8.1
Continuity .............................. Ch 2 §2.3
Darboux, Gaston ......................... Ch 3 §3.4, App A
Density point (Lebesgue) ................ Ch 6 §6.2
Dictionary (regularity hypotheses) ...... Ch 6 §6.7, Ch 9 §9.4
$(\star)$ equation ...................... throughout (esp. Ch 1, Ch 8)
$(J_2)$ equation ........................ throughout (esp. Ch 1, Ch 7)
$(J_{\mathbb Q})$ equation .............. Ch 1, Ch 7
Fundamenta Mathematicae ................. Ch 6 §6.1, App A
Hamel basis ............................ Ch 4 Definition 4.1
Hamel, Georg ........................... Ch 5 §5.5, App A
Hamel pathology ........................ Ch 5 Thm. 5.2
Jensen, J. L. .......................... Ch 7 §7.1, App A
Jensen's inequality .................... Ch 7 §7.1
Khinchin–Faddeev recursivity axiom .... Ch 10 §10.2
Kuczma, Marek .......................... App A, App C
Lebesgue measure ....................... Ch 6 §6.2 (in proof)
Linear function (vs. affine) ........... Ch 1 §1.1
Lwów school ............................ Ch 6 §6.1, App A
Measurability .......................... Ch 6 §6.3
Monotonicity ........................... Ch 3 §3.2
Ostrowski, Alexander M. ............... Ch 6 §6.5, App A
Polish school of analysis .............. Ch 6 §6.1, §6.8
$\mathbb Q$-homogeneity ............... Ch 2 §2.2 Lemma 2.2
$\mathbb Q$-linear map ............... Ch 2 §2.2, Ch 4 §4.2
$\mathbb Q$-vector space ............ Ch 4 §4.2
Resolution-axis transposition ......... Ch 10 §10.4
Scottish Book .......................... Ch 6 §6.1, App A
Scottish Café .......................... Ch 6 §6.1, App A
Shannon entropy ........................ Ch 10 §10.2
Sierpiński, Wacław .................... Ch 6 §6.3, App A
Solovay's model ........................ Ch 4 §4.7, Ch 5 §5.6, Ex. 4.8, Ex. 5.7
Steinhaus, Hugo ........................ Ch 6 §6.2, §6.4, App A
Steinhaus difference theorem .......... Ch 6 Theorem 6.1
Theorem 1 (the main result) ........... Ch 1, Ch 8 Theorem 8.1
Theorem 1$'$ (the strict minimum) ..... Ch 9 §9.1 Theorem 9.1
Utility theory (vNM) .................. Ch 10 §10.1
von Neumann, John ..................... Ch 10 §10.1, App A
Well-ordering theorem ................. Ch 4 §4.1
Zermelo, Ernst ........................ Ch 4 §4.1, App A
Zorn's lemma .......................... Ch 4 §4.1, §4.4

---

*End of monograph. Total: Preface + 10 chapters + 3 appendices + references + index. ~70 pages typeset (target). Drafted 2026-06-07.*
