#!/usr/bin/env python3
"""Session-2 surgery: figures replace Table 1; Section 5 rigorous expansion."""
import sys

def edit(t, old, new, tag):
    n = t.count(old)
    if n != 1:
        print(f"FAIL [{tag}]: anchor found {n} times"); sys.exit(1)
    print(f"OK   [{tag}]")
    return t.replace(old, new)

T = open("manuscript-anon-final.tex").read()

# ---------------------------------------------------------------- F0 preamble
T = edit(T,
"\\usepackage{tabularx}           % X column type for proportional-width tables",
"\\usepackage{tabularx}           % X column type for proportional-width tables\n\\usepackage{tikz}               % figures (load diagram, mechanism, resolution axis)",
"F0 tikz package")

# ---------------------------------------------------------------- F1 dictionary intro
T = edit(T,
"""for each. Table~\\ref{tab:dictionary} lists five classical hypotheses,
followed by a no-hypothesis row at the bottom. The first column names
the hypothesis; the second records its status for~\\eqref{eq:J2}, with
the standard historical attribution; the third records its status
for~\\eqref{eq:star}. (For a modern textbook treatment of
column~2\\,---\\,the regularity catalog for~\\eqref{eq:J2}\\,---\\,we refer
the reader to Kuczma~\\cite[\\S13.2]{Kuczma2009}.)""",
"""for each. Figure~\\ref{fig:dictionary} draws the comparison as a load
diagram: five classical hypotheses, each individually strong enough
to carry the conclusion for~\\eqref{eq:J2}, and the same conclusion
for~\\eqref{eq:star} carried by the bare equation, every strut
removed. The caption records the standard historical attribution of
each strut. (For a modern textbook treatment of the regularity
catalog for~\\eqref{eq:J2} we refer the reader to
Kuczma~\\cite[\\S13.2]{Kuczma2009}.)""",
"F1 dictionary intro")

# ---------------------------------------------------------------- F2 table -> figure
OLD_TABLE = """\\begin{table}[ht]
\\renewcommand{\\arraystretch}{1.4}
\\centering
\\begin{tabularx}{\\linewidth}{@{} >{\\raggedright\\arraybackslash}X |
  >{\\raggedright\\arraybackslash}X |
  >{\\raggedright\\arraybackslash}X @{}}
\\toprule
\\textbf{Hypothesis on $G$} &
\\textbf{For \\eqref{eq:J2}$\\Rightarrow$affine?} &
\\textbf{For \\eqref{eq:star}$\\Rightarrow$affine?} \\\\
\\midrule
\\textbf{Continuity on $I$}: $G$ is continuous at every $v\\in I$.
  & Yes, suffices (Cauchy~\\cite{Cauchy1821}).
  & \\textbf{No}---it is the \\emph{conclusion} (Corollary~\\ref{cor:regularity}). \\\\
\\midrule
\\textbf{Measurability on $I$}: $G$ is Lebesgue- or Borel-measurable on~$I$.
  & Yes, suffices (Sierpi\\'nski~\\cite{Sierpinski1920}).
  & \\textbf{No}---same. \\\\
\\midrule
\\textbf{Monotonicity on $I$}: $G$ is non-decreasing or non-increasing on~$I$.
  & Yes, suffices (Darboux~\\cite{Darboux1875}).
  & \\textbf{No}---same. \\\\
\\midrule
\\textbf{Boundedness on a set of positive measure}: $G$ is bounded on some
  Lebesgue-measurable $E\\subseteq I$ with $|E|>0$.
  & Yes, suffices (Kormes~\\cite{Kormes1926}; bounded on one side
    suffices, Ostrowski~\\cite{Ostrowski1929},
    Kestelman~\\cite{Kestelman1947}).
  & \\textbf{No}---same. \\\\
\\midrule
\\textbf{Boundedness on $I$}: $G$ is bounded on all of~$I$.
  & Yes, suffices (Darboux~\\cite{Darboux1880}).
  & \\textbf{No}---same. \\\\
\\midrule
\\textbf{None}: no regularity hypothesis at all.
  & \\textbf{Insufficient}---Hamel-basis pathology~\\cite{Hamel1905}.
  & \\textbf{Sufficient}---Theorem~\\ref{thm:main}. \\\\
\\bottomrule
\\end{tabularx}
\\caption{Regularity hypotheses on $G$. Column~2 records which hypotheses
are classically required to force affineness for the
discrete-coefficient equation~\\eqref{eq:J2}. Column~3 records their
status under the continuous-coefficient equation~\\eqref{eq:star}.
Steinhaus's difference-set theorem~\\cite{Steinhaus1920} powers the
modern proofs of the two measure-theoretic rows but is itself a tool
rather than a regularity result; for the historical catalog see
Reem~\\cite{Reem2017} and Kuczma~\\cite[\\S13.2]{Kuczma2009}.}
\\label{tab:dictionary}
\\end{table}"""

FIG1 = r"""\begin{figure}[ht]
\centering
\begin{tikzpicture}[x=1cm,y=1cm]
% ---------------- panel (a): (J_2), rational weights ----------------
\node at (2.95,4.62) {\small (a) discrete coefficients \eqref{eq:J2}};
\node at (2.95,4.22) {\scriptsize any single strut suffices to hold the beam};
\fill[black!12] (0.15,3.30) rectangle (5.75,3.95);
\draw (0.15,3.30) rectangle (5.75,3.95);
\node at (2.95,3.625) {\small $G$ is affine};
% struts
\foreach \cx/\lab in {0.62/{continuity}, 1.78/{measurability},
  2.95/{monotonicity}, 4.12/{bdd.\ on $E$, $|E|{>}0$}, 5.28/{bdd.\ on $I$}}{
  \fill[black!6] (\cx-0.23,0.90) rectangle (\cx+0.23,3.30);
  \draw (\cx-0.23,0.90) rectangle (\cx+0.23,3.30);
  \node[rotate=90] at (\cx,2.10) {\scriptsize \lab};
}
% ground + hatching
\draw[thick] (0,0.90) -- (5.9,0.90);
\foreach \x in {0.15,0.45,...,5.85}{\draw[black!60] (\x,0.90) -- (\x-0.16,0.70);}
\node[align=center] at (2.95,0.30)
  {\scriptsize remove every strut and the beam falls:\\[-1pt]
   \scriptsize Hamel pathology (Prop.~\ref{prop:JQ-pathology})};
% ---------------- divider ----------------
\draw[black!30] (6.32,0.05) -- (6.32,4.80);
% ---------------- panel (b): (star), real weights ----------------
\node at (9.65,4.62) {\small (b) continuous coefficients \eqref{eq:star}};
\node at (9.65,4.22) {\scriptsize no strut needed; each becomes a conclusion (Cor.~\ref{cor:regularity})};
\fill[black!12] (6.85,3.30) rectangle (12.45,3.95);
\draw (6.85,3.30) rectangle (12.45,3.95);
\node at (9.65,3.625) {\small $G$ is affine};
% ghost struts (removed)
\foreach \cx in {7.32, 8.48, 10.82, 11.98}{
  \draw[black!45, dash pattern=on 2pt off 2pt] (\cx-0.23,0.90) rectangle (\cx+0.23,3.30);
}
\node[black!55, rotate=90] at (8.48,2.10) {\scriptsize removed};
\node[black!55, rotate=90] at (10.82,2.10) {\scriptsize removed};
% pedestal: the equation itself
\fill[black!25] (9.22,0.90) rectangle (10.08,3.30);
\draw (9.22,0.90) rectangle (10.08,3.30);
\node[rotate=90] at (9.65,2.10) {\scriptsize Theorem~\ref{thm:main}};
% ground + hatching
\draw[thick] (6.7,0.90) -- (12.6,0.90);
\foreach \x in {6.85,7.15,...,12.55}{\draw[black!60] (\x,0.90) -- (\x-0.16,0.70);}
\node[align=center] at (9.65,0.30)
  {\scriptsize no pathology survives below ground:\\[-1pt]
   \scriptsize \eqref{eq:star} tests every irrational weight};
\end{tikzpicture}
\caption{The dictionary of vestigial regularity hypotheses, drawn as a
load diagram. (a)~Under the discrete-coefficient
equation~\eqref{eq:J2}, the conclusion ``$G$ is affine'' must be
carried by a regularity strut, and any single one suffices: continuity
(Cauchy~\cite{Cauchy1821}), measurability
(Sierpi\'nski~\cite{Sierpinski1920}), monotonicity
(Darboux~\cite{Darboux1875}), boundedness on a set of positive measure
(Kormes~\cite{Kormes1926}; one-sided bounds suffice,
Ostrowski~\cite{Ostrowski1929}, Kestelman~\cite{Kestelman1947}), or
boundedness on the interval (Darboux~\cite{Darboux1880}). Remove them
all and the beam falls: the Hamel-basis pathology~\cite{Hamel1905}
supplies a non-affine solution (Proposition~\ref{prop:JQ-pathology}).
Steinhaus's difference-set theorem~\cite{Steinhaus1920} powers the
modern proofs of the two measure-theoretic struts but is a tool, not a
strut; for the historical catalog see Reem~\cite{Reem2017} and
Kuczma~\cite[\S13.2]{Kuczma2009}. (b)~Under the continuous-coefficient
equation~\eqref{eq:star} the bare equation carries the load
(Theorem~\ref{thm:main}); every strut becomes a conclusion rather than
a hypothesis (Corollary~\ref{cor:regularity}), and no pathology
survives below ground, because~\eqref{eq:star} tests every irrational
weight.}
\label{fig:dictionary}
\end{figure}"""

COMMENTED = "\n".join("% " + ln for ln in OLD_TABLE.splitlines())
T = edit(T, OLD_TABLE,
FIG1 + "\n\n% --- Former Table 1 (superseded by Figure~\\ref{fig:dictionary}; kept for referee fallback) ---\n"
+ COMMENTED + "\n% --- end former Table 1 ---",
"F2 table replaced by load-diagram figure")

# ---------------------------------------------------------------- F3 post-table prose
T = edit(T,
"""The bottom row is the point of the table. \\textbf{No regularity
hypothesis} suffices for~\\eqref{eq:J2}: there exists a non-affine,
non-measurable, unbounded, additive function on~$\\R$---the classical
Hamel-basis pathology~\\cite{Hamel1905}---that supplies a non-affine
solution of~\\eqref{eq:J2}. Conversely, \\textbf{no regularity hypothesis}
is \\emph{needed} for~\\eqref{eq:star}: Theorem~\\ref{thm:main}'s endpoint
substitution closes the proof at the level of the bare functional
equation.

The five non-bottom rows tell a complementary story. For~\\eqref{eq:J2},
\\emph{some} hypothesis from these five is required; otherwise the Hamel
pathology survives. For~\\eqref{eq:star}, \\emph{none} of these is
required---and yet each is automatically satisfied by any solution
(Corollary~\\ref{cor:regularity}). Each hypothesis is, in the
dictionary's terminology, \\emph{vestigial}: classically required
for~\\eqref{eq:J2}, classically expected for~\\eqref{eq:star}, but in
fact unnecessary for~\\eqref{eq:star}.""",
"""The ground line is the point of the figure. With \\textbf{no
hypothesis at all}, the beam falls for~\\eqref{eq:J2}: there exists a
non-affine, non-measurable, unbounded additive function
on~$\\R$---the classical Hamel-basis pathology~\\cite{Hamel1905}---that
supplies a non-affine solution of~\\eqref{eq:J2}. Conversely,
\\textbf{no hypothesis is needed} for~\\eqref{eq:star}:
Theorem~\\ref{thm:main}'s endpoint substitution closes the proof at
the level of the bare functional equation.

The five struts tell a complementary story. For~\\eqref{eq:J2},
\\emph{some} strut is required; otherwise the Hamel pathology
survives. For~\\eqref{eq:star}, \\emph{none} is required---and yet each
is automatically satisfied by any solution
(Corollary~\\ref{cor:regularity}). Each hypothesis is, in the
dictionary's terminology, \\emph{vestigial}: classically required
for~\\eqref{eq:J2}, classically expected for~\\eqref{eq:star}, but in
fact unnecessary for~\\eqref{eq:star}.""",
"F3 post-table prose to figure language")

# ---------------------------------------------------------------- F4 rows-language fixes
T = edit(T,
"""very results recorded in the last two rows of
Table~\\ref{tab:dictionary}. Here a regularity hypothesis (boundedness)""",
"""very results recorded on the two boundedness struts of
Figure~\\ref{fig:dictionary}. Here a regularity hypothesis (boundedness)""",
"F4a boundedness rows -> struts")

T = edit(T,
"five rows of Table~\\ref{tab:dictionary}}. Faddeev assumed continuity",
"five struts of Figure~\\ref{fig:dictionary}}. Faddeev assumed continuity",
"F4b five rows -> struts")

T = edit(T,
"""Lebesgue measurable\\,---\\,the rows of Table~\\ref{tab:dictionary}
rediscovered inside physics.""",
"""Lebesgue measurable\\,---\\,the catalog of Figure~\\ref{fig:dictionary}
rediscovered inside physics.""",
"F4c quantum rows -> catalog")

# ---------------------------------------------------------------- F5 global sweep
n = T.count("Table~\\ref{tab:dictionary}")
T = T.replace("Table~\\ref{tab:dictionary}", "Figure~\\ref{fig:dictionary}")
print(f"OK   [F5 sweep: {n} remaining Table refs -> Figure refs]")

# ---------------------------------------------------------------- F6 mechanism figure
FIG2 = r"""
Figure~\ref{fig:mechanism} draws both halves of that sentence.

\begin{figure}[ht]
\centering
\begin{tikzpicture}[x=1cm,y=1cm]
% ---------------- panel (a): endpoint substitution ----------------
\node at (2.55,3.55) {\small (a) the endpoint substitution};
\draw[->] (0,0) -- (5.0,0);
\draw[->] (0,0) -- (0,3.2);
\draw (4.2,0.06) -- (4.2,-0.06) node[below] {\small $M$};
\draw (2.7,0.06) -- (2.7,-0.06) node[below] {\small $v$};
\node[below left] at (0.12,0) {\small $0$};
\draw[thick] (0,1.0) -- (4.2,2.9);
\fill (0,1.0) circle (1.6pt) node[left] {\small $G(0)$};
\fill (4.2,2.9) circle (1.6pt) node[right] {\small $G(M)$};
\draw[dash pattern=on 2pt off 2pt] (2.7,0) -- (2.7,2.22);
\fill (2.7,2.22) circle (1.6pt);
\node[above left] at (2.78,2.24) {\small $G(v)$};
\draw[|-|] (0,-0.62) -- (2.7,-0.62);
\node at (1.35,-0.95) {\small $p=v/M$};
\node[align=center] at (3.95,0.95)
  {\scriptsize one weight pins one value;\\[-1pt]\scriptsize the chord is forced};
% ---------------- divider ----------------
\draw[black!30] (5.65,-1.1) -- (5.65,3.7);
% ---------------- panel (b): the weight axis ----------------
\node at (9.5,3.55) {\small (b) the weight axis $p\in[0,1]$};
\draw (6.6,1.55) -- (12.4,1.55);
\draw (6.6,1.43) -- (6.6,1.67) node[below=7pt] {\small $0$};
\draw (12.4,1.43) -- (12.4,1.67) node[below=7pt] {\small $1$};
COMBTICKS
\node[align=center] at (9.5,2.55)
  {\scriptsize \eqref{eq:JQ} tests only this rational comb;\\[-1pt]
   \scriptsize a $\Q$-linear pathology passes every test on it};
\draw[very thick] (10.701,1.55) -- (10.701,1.06);
\fill (10.701,1.06) circle (1.5pt);
\node[align=center] at (9.5,0.45)
  {\scriptsize an irrational $p$ (here $1/\sqrt{2}$): \eqref{eq:star} tests here too,\\[-1pt]
   \scriptsize and the pathology dies (Section~\ref{ssec:mechanism})};
\draw[->,black!60] (9.95,0.78) -- (10.62,1.0);
\end{tikzpicture}
\caption{The mechanism. (a)~The endpoint substitution that proves
Theorem~\ref{thm:main}: at the configuration $u_1=M$, $u_2=0$, the
single weight $p=v/M$ pins $G(v)$ to the chord through $(0,G(0))$ and
$(M,G(M))$\,---\,one weight per point, the chord forced everywhere.
(b)~The weight axis on which the two equations live. The rational comb
is where~\eqref{eq:JQ} tests the identity, and a $\Q$-linear Hamel
pathology passes every test on the comb. The continuous-coefficient
equation~\eqref{eq:star} also tests the irrational weights, where the
$\R$-linearity defect must show itself, and forecloses on the
pathology there.}
\label{fig:mechanism}
\end{figure}
"""
# rational comb tick positions (k/q, q=2..9, deduplicated)
fracs = sorted({k/q for q in range(2,10) for k in range(1,q)})
ticks = "\n".join(
    f"\\draw[black!55] ({6.6+5.8*f:.3f},1.55) -- ({6.6+5.8*f:.3f},1.79);" for f in fracs)
FIG2 = FIG2.replace("COMBTICKS", ticks)

T = edit(T,
"""\\begin{quote}
\\textbf{The Hamel pathology lives at irrational $p$; the
continuous-coefficient equation~\\eqref{eq:star} forecloses on it there.}
\\end{quote}

The classical program from Cauchy (1821) through Kestelman (1947)""",
"""\\begin{quote}
\\textbf{The Hamel pathology lives at irrational $p$; the
continuous-coefficient equation~\\eqref{eq:star} forecloses on it there.}
\\end{quote}
""" + FIG2 + """
The classical program from Cauchy (1821) through Kestelman (1947)""",
"F6 mechanism figure inserted")

# ---------------------------------------------------------------- F7 Section 5 expansion
OLD_S5 = """\\paragraph{Surrogate calibration on the resolution axis.}
Pass from the canonical loss-axis formulation of surrogate
calibration~\\cite{BJM2006} to a \\emph{resolution-axis} framing, in
which risk is parametrized by the partition that aggregates the
feature space rather than by the surrogate loss, and let $G(p)$ be
the Bayes risk of a two-cell partition expressed in terms of the
mass $p\\in[0,1]$ of one cell on an atomless probability space. A
two-cell computation forces the saturated identity~\\eqref{eq:star}
on~$G$: because the partition Bayes risk is, by construction, the
mass-weighted average of the within-cell Bayes risks, the surrogate
gap that Jensen's inequality otherwise leaves is forced to zero
across the entire two-point family. Crucially, because the
probability space is atomless the cell mass~$p$ ranges over
\\emph{all} of $[0,1]$\\,---\\,every real value is the mass of some
event, by Sierpi\\'nski's intermediate-value theorem for atomless
measures~\\cite{Sierpinski1922}\\,---\\,while the within-cell values
are prescribed independently of the mass, so every triple
$(u_1,u_2,p)$ of values and weight is realized by some two-cell
instance. The identity is therefore asserted on the \\emph{entire}
domain of~\\eqref{eq:star}, not on a subfamily; and throughout, the
unknown~$G$ is only ever \\emph{evaluated} at points, never integrated,
so the probabilistic scaffolding smuggles no measurable structure
onto~$G$. Theorem~\\ref{thm:main} thus applies and forces~$G$ affine
with no continuity, measurability, monotonicity, or boundedness
assumed. This is the seductive misclassification of
Section~\\ref{ssec:diagnostic} in the flesh: the saturated identity
looks like a Cauchy problem and invites a defensive boundedness or
measurability hypothesis on~$G$, but the continuum of cell masses
makes it genuine~\\eqref{eq:star} and the hypothesis vestigial.

\\paragraph{A self-contained toy.}
The mechanism is transparent in miniature, and the miniature also
shows how thin the line is. Let $(\\Omega,\\mathcal{F},\\mu)$ be an
atomless probability space and let $g\\colon[m,M]\\to\\R$ be \\emph{any}
function. Given values $u_1,u_2\\in[m,M]$ and an event~$A$, let $\\xi$
be the two-valued random variable equal to~$u_1$ on~$A$ and~$u_2$ on
its complement, and write $p=\\mu(A)$. Because $\\mu$ is atomless, as
$A$ ranges over $\\mathcal{F}$ the mass~$p$ attains \\emph{every}
value in $[0,1]$ (Sierpi\\'nski's theorem again). Suppose $g$ is
mean-preserving across all such $\\xi$\\,---\\,that the average value
$\\E[g(\\xi)]=p\\,g(u_1)+(1-p)\\,g(u_2)$ always equals the value at the
average, $g(\\E[\\xi])=g(p\\,u_1+(1-p)\\,u_2)$. This is
exactly~\\eqref{eq:star}, now tested at every real~$p$, so $g$ is
affine by Theorem~\\ref{thm:main}, and nothing was assumed about its
regularity. Replace the atomless space by a single fair coin\\,---\\,%
build the mixtures by tossing it repeatedly\\,---\\,and the attainable
masses~$p$ collapse to the dyadic rationals; one is back in the
first source of Section~\\ref{ssec:diagnostic},
Proposition~\\ref{prop:JQ-pathology} returns a non-affine solution,
and a regularity hypothesis is once more required. The whole of
Sections~\\ref{sec:dictionary} and~\\ref{sec:recurrence} is visible in
the gap between an atomless measure and a coin."""

NEW_S5 = r"""\paragraph{Surrogate calibration on the resolution axis.}
We first fix the vocabulary, because the central object here travels
under many names. Let $(\Omega,\mathcal{F},\mu)$ be an atomless
probability space, let $Y$ be a binary outcome, and let
$\eta=\Pr(Y=1\mid\cdot)\in[0,1]$ be its posterior probability. For a
loss~$\ell$, the \emph{conditional Bayes risk} at posterior value~$u$
is $H(u):=\inf_{a}\E[\ell(a,Y)\mid \eta=u]$; the function $H$ is
variously called the Bayes envelope, the generalized entropy, or the
uncertainty function of the associated
score~\cite{Savage1971,DeGrootFienberg1983,GrunwaldDawid2004,GneitingRaftery2007}.
For the $0$--$1$ loss it is the tent, $H(u)=\min(u,1-u)$. We write
$G\colon[0,1]\to\R$ for a candidate uncertainty function and, for now,
let it be \emph{arbitrary}.

A sub-$\sigma$-algebra $\mathcal{G}\subseteq\mathcal{F}$ is a
\emph{resolution}: the coarser~$\mathcal{G}$, the less the forecast
distinguishes states of the world. Writing
$\eta_{\mathcal{G}}:=\E[\eta\mid\mathcal{G}]$, the risk attainable at
resolution~$\mathcal{G}$ is
\[
U_G(\mathcal{G})\;:=\;\E\bigl[G(\eta_{\mathcal{G}})\bigr],
\qquad\text{so that}\quad
U_G\bigl(\sigma(A)\bigr)\;=\;\mu(A)\,G(u_1)+\mu(A^{c})\,G(u_2)
\]
when $\eta$ takes the value $u_1$ on an event~$A$ and $u_2$ off it.
The classical theory runs along this axis with concavity in hand.
Every Bayes envelope is concave (an infimum of affine functions
of~$u$), and for concave~$G$ the functional $U_G$ decreases under
refinement\,---\,conditional Jensen plus the tower
property\,---\,which is Blackwell's comparison of
experiments~\cite{Blackwell1953} in this setting and the refinement
ordering of DeGroot and Fienberg~\cite{DeGrootFienberg1983}. The drop
it measures is the \emph{resolution} (or discrimination) term in the
decomposition of a proper score: Murphy's classical partition of the
Brier score~\cite{Murphy1973}, Br\"ocker's generalization to every
proper score via its entropy and divergence~\cite{Brocker2009}, and
the empirical form
$\bar S=\mathrm{MCB}-\mathrm{DSC}+\mathrm{UNC}$ of Dimitriadis,
Gneiting, and Jordan~\cite{DGJ2021}. Every statement in this
classical chain \emph{assumes} concavity of~$G$, and the empirical
theory adds measurability or smoothness besides.

The dictionary's contribution is the converse direction, and it needs
none of that.

\begin{proposition}[Resolution-blind uncertainty functions are affine]
\label{prop:resolution}
Let $(\Omega,\mathcal{F},\mu)$ be atomless and let
$G\colon[0,1]\to\R$ be arbitrary. Suppose the two-cell resolutions
are exact: for all $u_1,u_2\in[0,1]$ and every event~$A$,
\[
\mu(A)\,G(u_1)+\mu(A^{c})\,G(u_2)\;=\;G\bigl(\E[\eta]\bigr),
\qquad\text{where } \eta=u_1\mathbf{1}_A+u_2\mathbf{1}_{A^{c}}.
\]
Then $G$ is affine; consequently $U_G(\mathcal{G})=G(\E[\eta])$ for
\emph{every} $[0,1]$-valued posterior~$\eta$ and \emph{every}
sub-$\sigma$-algebra~$\mathcal{G}$, so $G$ is blind to resolution at
all scales. No continuity, measurability, monotonicity,
boundedness\,---\,or concavity\,---\,is assumed. The $k$-class case,
with $\eta$ valued in the probability simplex~$\Delta_k$ and $G$
arbitrary on~$\Delta_k$, holds verbatim with ``affine on the
simplex,'' by Theorem~\ref{thm:higher}.
\end{proposition}

\begin{proof}
Atomlessness realizes every mass $p=\mu(A)\in[0,1]$
(Sierpi\'nski~\cite{Sierpinski1922}), and the values $u_1,u_2$ are
prescribed independently of~$A$, so the hypothesis asserts
$p\,G(u_1)+(1-p)\,G(u_2)=G(p\,u_1+(1-p)\,u_2)$ at every
triple\,---\,the identity~\eqref{eq:star} on its entire domain, with
$G$ only ever \emph{evaluated} at points, never integrated.
Theorem~\ref{thm:main} gives affineness on~$[0,1]$;
Theorem~\ref{thm:higher} with $C=\Delta_k$ gives the simplex case.
Conversely, for affine~$G$ and any~$\mathcal{G}$, linearity of
expectation and the tower property give
$\E[G(\eta_{\mathcal{G}})]=G(\E[\eta_{\mathcal{G}}])=G(\E[\eta])$.
\end{proof}

This is the seductive misclassification of
Section~\ref{ssec:diagnostic} in the flesh: the saturated identity
looks like a Cauchy problem and invites a defensive boundedness or
measurability hypothesis on~$G$, but the continuum of cell masses
makes it genuine~\eqref{eq:star} and the hypothesis vestigial.

\paragraph{The benchmark partition and the tent.}
What survives when exactness holds only \emph{locally} is
Corollary~\ref{cor:piecewise}: a surrogate that aggregates exactly on
each cell of a fixed benchmark partition of the probability axis is
affine on each cell, with continuity at the knots for free. For the
canonical benchmark $\{[0,\tfrac12],[\tfrac12,1]\}$ the resulting
shape is the tent\,---\,and the tent is not merely an example.
$T_{1/2}(u)=\min(u,1-u)$ \emph{is} the $0$--$1$ conditional Bayes
risk, and more is true: the elementary scores of
Schervish~\cite{Schervish1989} and of Ehm, Gneiting, Jordan, and
Kr\"uger~\cite{EGJK2016} have as their uncertainty functions
precisely the tents $T_\theta$ with apex at~$\theta$, and the mixture
representation $S=\int_0^1 S_\theta\,dH(\theta)$ of every proper
score exhibits every admissible uncertainty function as a mixture of
tents, $G=\int_0^1 T_\theta\,dH(\theta)$\,---\,for instance
$\int_0^1 T_\theta\,d\theta=u(1-u)$, the Brier entropy. The tents are
the extreme rays of the cone of uncertainty functions, and piecewise
saturation pins exactly them. In learning-theoretic language,
cellwise exactness is tightness of the surrogate-risk bracket: the
$\psi$-transform of Bartlett, Jordan, and McAuliffe~\cite{BJM2006},
Steinwart's calibration functions~\cite{Steinwart2007}, and the
multiclass analysis of Tewari and
Bartlett~\cite{TewariBartlett2007} measure how far a surrogate's
floor sits from the true floor; exactness on a cell says the gap is
zero there, and Corollary~\ref{cor:piecewise} says the price of zero
gap is affineness on the cell. Figure~\ref{fig:resolution} draws
both halves.

\begin{figure}[ht]
\centering
\begin{tikzpicture}[x=1cm,y=1cm]
% ---------------- panel (a): the resolution axis ----------------
\node at (2.75,4.50) {\small (a) refining the partition};
\node[rotate=90] at (-0.30,1.30) {\scriptsize $U_G(\mathcal{G})$};
% partition boxes
\draw (0.10,2.70) rectangle (1.45,3.80);
\draw (2.15,2.70) rectangle (3.50,3.80); \draw (2.69,2.70) -- (2.69,3.80);
\draw (4.20,2.70) rectangle (5.55,3.80);
\draw (4.74,2.70) -- (4.74,3.80); \draw (4.20,3.25) -- (5.55,3.25);
\draw[->] (1.55,3.25) -- (2.05,3.25) node[midway,above] {\scriptsize refine};
\draw[->] (3.60,3.25) -- (4.10,3.25) node[midway,above] {\scriptsize refine};
% bars: concave (filled, falling) vs affine (open, flat)
\draw[black!40] (-0.05,0.55) -- (5.60,0.55);
\foreach \cx/\hc in {0.775/1.40, 2.825/1.00, 4.875/0.70}{
  \fill[black!55] (\cx-0.40,0.55) rectangle (\cx-0.06,0.55+\hc);
  \draw (\cx+0.06,0.55) rectangle (\cx+0.40,1.60);
}
\fill[black!55] (0.10,0.06) rectangle (0.26,0.22);
\node[anchor=west] at (0.32,0.14) {\scriptsize concave $G$: $U_G$ falls (resolution gained)};
\draw (0.10,-0.36) rectangle (0.26,-0.20);
\node[anchor=west] at (0.32,-0.28) {\scriptsize affine $G$: flat\,---\,resolution-blind (Prop.~\ref{prop:resolution})};
% ---------------- divider ----------------
\draw[black!30] (6.10,-0.5) -- (6.10,4.7);
% ---------------- panel (b): tents and the benchmark cells ----------------
\node at (9.70,4.50) {\small (b) tents, mixtures, and Corollary~\ref{cor:piecewise}};
% shaded benchmark cells under the bold tent
\fill[black!8]  (6.80,0.55) -- (9.60,3.15) -- (9.60,0.55) -- cycle;
\fill[black!16] (9.60,0.55) -- (9.60,3.15) -- (12.40,0.55) -- cycle;
% axes
\draw[->] (6.60,0.55) -- (12.70,0.55);
\draw (6.80,0.49) -- (6.80,0.61) node[below=4pt] {\scriptsize $0$};
\draw (9.60,0.49) -- (9.60,0.61) node[below=4pt] {\scriptsize $\tfrac12$};
\draw (12.40,0.49) -- (12.40,0.61) node[below=4pt] {\scriptsize $1$};
% faint tents
\draw[black!45] (6.80,0.55) -- (8.48,2.734) -- (12.40,0.55);
\draw[black!45] (6.80,0.55) -- (10.72,2.734) -- (12.40,0.55);
\node[black!55] at (7.62,2.30) {\scriptsize $T_{0.3}$};
\node[black!55] at (11.58,2.30) {\scriptsize $T_{0.7}$};
% Brier mixture
\draw[dash pattern=on 2.4pt off 2pt, domain=0:1, smooth, variable=\t]
  plot ({6.80+5.6*\t},{0.55+5.2*\t*(1-\t)});
\node at (11.62,1.12) {\scriptsize $u(1-u)=\int_0^1\!T_\theta\,d\theta$};
% bold tent
\draw[very thick] (6.80,0.55) -- (9.60,3.15) -- (12.40,0.55);
\node at (9.60,3.42) {\scriptsize $T_{1/2}(u)=\min(u,1-u)$: the $0$--$1$ Bayes envelope};
\node at (9.60,-0.02) {\scriptsize exact on each cell $\Rightarrow$ affine on each cell (Cor.~\ref{cor:piecewise})};
\end{tikzpicture}
\caption{Saturation along the resolution axis. (a)~Refining the
partition can only lower the uncertainty functional
$U_G(\mathcal{G})=\E[G(\eta_{\mathcal{G}})]$ when $G$ is concave
(conditional Jensen; Blackwell~\cite{Blackwell1953}); the drop is the
resolution term of the score
decompositions~\cite{Murphy1973,Brocker2009,DGJ2021}. By
Proposition~\ref{prop:resolution}, the only uncertainty functions
whose profile is flat\,---\,resolution-blind at every two-cell
comparison\,---\,are the affine ones, with no regularity assumed.
(b)~The tent $T_{1/2}(u)=\min(u,1-u)$ is the $0$--$1$ Bayes envelope;
the tents $T_\theta$ are the uncertainty functions of the elementary
scores~\cite{Schervish1989,EGJK2016}, and every admissible
uncertainty function is a mixture $\int_0^1 T_\theta\,dH(\theta)$;
the dashed curve is the Brier entropy $u(1-u)$, the uniform mixture.
Exactness on each cell of the benchmark partition
$\{[0,\tfrac12],[\tfrac12,1]\}$ forces affineness on each cell
(Corollary~\ref{cor:piecewise}): the tent shape, pinned with nothing
assumed at the kink.}
\label{fig:resolution}
\end{figure}

\paragraph{Two readings.}
The construction travels. In probabilistic graphical models, a clique
tree is \emph{calibrated} when neighboring cliques agree on their
sepset marginals~\cite{KollerFriedman2009}; this cellwise agreement
is the piecewise identity above, asserted over the sepset partition,
and $U_G$ is the natural uncertainty functional along the junction
tree's resolution order. In representation learning, an encoder~$R$
induces the resolution $\mathcal{G}=\sigma(R)$, and
$U_{T_{1/2}}(\sigma(R))$ is the smallest misclassification error
achievable from the representation\,---\,its error floor.
Proposition~\ref{prop:resolution} then says that the only uncertainty
functions blind to the choice of representation are the affine ones:
any genuinely concave~$G$ certifies, through a strict drop of~$U_G$,
that the representation gained resolution.

\paragraph{The thin line, in miniature.}
Replace the atomless space by a single fair coin\,---\,build the
mixtures by tossing it repeatedly\,---\,and the attainable masses~$p$
collapse to the dyadic rationals; one is back in the first source of
Section~\ref{ssec:diagnostic}, Proposition~\ref{prop:JQ-pathology}
returns a non-affine solution, and a regularity hypothesis is once
more required.\footnote{A terminological caution: the property tested
throughout is that $G$ \emph{commutes with expectation} over
two-point laws\,---\,we say the family is
\emph{expectation-exact}\,---\,rather than ``mean-preserving,'' a
term that already names mean-preserving spreads in economics.} The
whole of Sections~\ref{sec:dictionary} and~\ref{sec:recurrence} is
visible in the gap between an atomless measure and a coin."""

T = edit(T, OLD_S5, NEW_S5, "F7 Section 5 rigorous expansion")

open("manuscript-anon-final.tex","w").write(T)
print("--- manuscript surgery complete ---")

# ================================================================ refs.bib
B = open("refs.bib").read()
B += """
% --- Section 5 expansion (2026-06-11): scoring rules, decompositions,
% --- comparison of experiments, graphical models. Brocker, DGJ, Schervish,
% --- DeGroot--Fienberg verified by search this session; Savage, Murphy,
% --- Blackwell, Grunwald--Dawid, Gneiting--Raftery, Koller--Friedman are
% --- canonical (EGJK pages flagged for proof-stage check). ---

@article{Savage1971,
  author  = {Savage, L. J.},
  title   = {Elicitation of personal probabilities and expectations},
  journal = {J. Amer. Statist. Assoc.},
  volume  = {66},
  number  = {336},
  year    = {1971},
  pages   = {783--801},
}

@article{Murphy1973,
  author  = {Murphy, A. H.},
  title   = {A new vector partition of the probability score},
  journal = {J. Appl. Meteorol.},
  volume  = {12},
  year    = {1973},
  pages   = {595--600},
}

@article{DeGrootFienberg1983,
  author  = {DeGroot, M. H. and Fienberg, S. E.},
  title   = {The comparison and evaluation of forecasters},
  journal = {J. Roy. Statist. Soc. Ser. D (The Statistician)},
  volume  = {32},
  number  = {1--2},
  year    = {1983},
  pages   = {12--22},
}

@article{Blackwell1953,
  author  = {Blackwell, D.},
  title   = {Equivalent comparisons of experiments},
  journal = {Ann. Math. Statist.},
  volume  = {24},
  year    = {1953},
  pages   = {265--272},
}

@article{Schervish1989,
  author  = {Schervish, M. J.},
  title   = {A general method for comparing probability assessors},
  journal = {Ann. Statist.},
  volume  = {17},
  number  = {4},
  year    = {1989},
  pages   = {1856--1879},
  doi     = {10.1214/aos/1176347398},
}

@article{GrunwaldDawid2004,
  author  = {Gr{\\"u}nwald, P. D. and Dawid, A. P.},
  title   = {Game theory, maximum entropy, minimum discrepancy and robust {B}ayesian decision theory},
  journal = {Ann. Statist.},
  volume  = {32},
  number  = {4},
  year    = {2004},
  pages   = {1367--1433},
}

@article{GneitingRaftery2007,
  author  = {Gneiting, T. and Raftery, A. E.},
  title   = {Strictly proper scoring rules, prediction, and estimation},
  journal = {J. Amer. Statist. Assoc.},
  volume  = {102},
  number  = {477},
  year    = {2007},
  pages   = {359--378},
}

@article{Brocker2009,
  author  = {Br{\\"o}cker, J.},
  title   = {Reliability, sufficiency, and the decomposition of proper scores},
  journal = {Q. J. R. Meteorol. Soc.},
  volume  = {135},
  number  = {643},
  year    = {2009},
  pages   = {1512--1519},
  doi     = {10.1002/qj.456},
}

@article{EGJK2016,
  author  = {Ehm, W. and Gneiting, T. and Jordan, A. and Kr{\\"u}ger, F.},
  title   = {Of quantiles and expectiles: consistent scoring functions, {C}hoquet representations, and forecast rankings},
  journal = {J. R. Stat. Soc. Ser. B},
  volume  = {78},
  number  = {3},
  year    = {2016},
  pages   = {505--562},
  doi     = {10.1111/rssb.12154},
}

@article{DGJ2021,
  author  = {Dimitriadis, T. and Gneiting, T. and Jordan, A. I.},
  title   = {Stable reliability diagrams for probabilistic classifiers},
  journal = {Proc. Natl. Acad. Sci. USA},
  volume  = {118},
  number  = {8},
  year    = {2021},
  pages   = {e2016191118},
  doi     = {10.1073/pnas.2016191118},
}

@book{KollerFriedman2009,
  author    = {Koller, D. and Friedman, N.},
  title     = {Probabilistic Graphical Models: Principles and Techniques},
  publisher = {MIT Press},
  address   = {Cambridge, MA},
  year      = {2009},
}
"""
open("refs.bib","w").write(B)
print("--- refs.bib extended ---")
