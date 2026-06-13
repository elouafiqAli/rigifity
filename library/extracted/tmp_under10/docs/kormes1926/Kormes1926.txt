## ON THE FUNCTIONAL EQUATION f(x+y)=f(x)+f(y)*

## BY MARK KORMES

Fréchet,† and later Blumberg† and Sierpinski,§ have demonstrated that the solution of the functional equation (1)

which is measurable, has the form A · x, where A denotes a constant. In this note the following theorem is proved.

THEOREM I. Every solution of the functional equation (1) which is bounded on a set of positive measure is of the form A · x.

The proof depends on a theorem of Steinhaus¶ which can be stated as follows.

LEMMA. The set arising by arithmetic summation (addition of abscissas) of a set of positive measure, contains an interval.||

Since f(x) is bounded on a set of positive measure, f(x+y) is bounded on an interval, and therefore f(x) must be of the form A · x according to a theorem of Darboux.

THEOREM Ia. The statement of Theorem I remains true if f(x) is bounded on a set whose interior measure is positive.

If the interior measure of a set A is a&gt;0,then there exists** a measurable sub-set of A whose measure is equal to a (&gt;0).

* Presented to the Society October 31, 1925. † M. Frechet, L’Eseignement MatheMxique, vol. 15 (1913),p. 390. ‡ Blumberg, Convex functions, TRANSACTIONS OF THIS SOCIETY, vol. 20, p. 41.

§ W. Sierpinski, FUNDAMENTA MATHEMATICAE, vol. 1, p. 116.

¶ H. Steinhaus, FUNDAMENTA MATHEMATICAE, vol. 1, p. 99:

|| The proof of this lemma will be a part of a paper entitled On arithmetic summation of point sets.

** C. Carathéodory, Vorlesungen über Reelle Funktions, p. 261.

To this subset Theorem I can be applied and thus Theorem Ia is established.

Theorem I establishes a far more general condition than the one given by Fréchet, Blumberg, and Sierpinski. The following remarks show that this condition is incisive. The condition m(M)*&gt;0 is essential, since there exist nonmeasurable solutions of (1) which are continuous on a set H, where, for every interval 6,

Let B denote a hamelian basis-set of all real numbers. If b is a number of B, we define a solution of the functional equation (1) as follows:

f(x) = 0, for the numbers of the set

(B-b);

f(x) = 1, for x=b;

f(x+y) = f(x) + f(y), for all real numbers.

In this way f(x) is completely defined. Let us denote by H the set of all points where f(x) = 0. If we denote by H* the set of all numbers x+c, where x assumes all values of H we have then H=H*, where the symbol = means congruent, and a is a rational number. Then we have

(H*·H*') = 0,

if a=a', and

K = 1 H* ,

where K denotes the continuum. Therefore we must have, for every interval 6,

m(H·6) = 0, m(H·6) = 6.

The symbol m(M) shall signify the interior measure of M,m(M) the exterior measure of M.

For suppose m(H·6)&gt;0. There must exist then a measurable subset PCH so that m(P)&gt;0. We would have m(P*)=m(P)&gt;0. On the other hand it can be shown easily, that then there exists a rational number a, so that m(P*·P) = a&gt;0, but this is impossible, since P*·P =0 because PCH, P*·C H, and (H·H*) = 0. We must have therefore m(H·6) = 0. See also M. Kormes, Treatise on basis-sets (Columbia University dissertation, not yet published), Theorem VIII.

Since the function f(x) is everywhere 0 on the set H, it is bounded and continuous.

There exist non-measurable solutions of (1), which are continuous on a perfect set P, where m(P) = 0. Let P be the set of all numbers z of the form

$$x = \frac { x _ { 1 } } { 1 0 x _ { 1 } ! } + \frac { x _ { 2 } } { ( 1 0 x _ { 2 } + 1 0 x _ { 1 } ) ! } + \cdots \\$$

$$+ \frac { x _ { n } } { ( 1 0 ^ { n } x _ { n } + 1 0 ^ { n - 1 } x _ { n - 1 } + \cdots + 1 0 x _ { 1 } ) ! } + \cdots ,$$

where every x, is either 1 or 2. There cannot exist then any relation of the form

$$\sum _ { \lambda } n _ { \lambda } = 0$$

between the numbers z of the set P, where n, denotes a rational number, and in every case only a finite number of n, are different from 0. The numbers of P constitute a subset of a basis-set B of all real numbers. The existence of such basis-set was demonstrated in another paper.

We define now a solution of the functional equation (1) in the following way:

f(x) = 0, for all numbers of P;

f(x) = 1, for all numbers of B-P;

f(x+y) = f(x)+f(y) for all numbers of the continuum K. But this defines f(x) completely, and it is clear that f(x) is non-measurable and continuous on the perfect set B.

M. Kormes, Treatise on basis-sets.

To construct a basis-set B which has a given set P as a subset we proceed in the following way. We well-order the continuum K in such a way that the numbers of P precede all other numbers. The set (K-P) is not empty, and since the set P is not the entire basis-set of K, there must be a first number a1 of (K-P) which cannot be represented by numbers of P in a linear way. If we consider the set P1-P+a1 and reason in the same way as above, we obtain a basis-set B of the continuum K. See also M. Kormes, Treatise on basis-sets.

M. Kormes, loc. cit.

From Theorem I, the Fréchet-Sierpinski theorem* can be deduced immediately.

THEOREM II. Every solution of (1) which is measurable has the form A-x.

In fact, suppose that f(x) is a solution of (1), and that f(x) is measurable. Then there exists a perfect set P, where m(P)&gt;0, and f(x) is continuous on P. Being finite, f(x) must be bounded on P, and Theorem II is a simple consequence of Theorem I.

Theorem I can be generalized for functional equations in n variables. A proof for two variables will be given below and it is quite analogous for n(&gt;2) variables.

THEOREM III. Every solution of the functional equation

(2)

f(x+u,y+v) = f(x,y) + f(u,v)

where x, y, u, v denote real numbers, which has the property that f(x, 0) is bounded on a measurable set M, where m(Mx)&gt;0, and that f(0, y) is bounded on a measurable set M, where m(Mx)&gt;0, has the form A-x+B-y.†

We have

f(x,y) = f(x+0, 0+y) = f(x,0) + f(0,y),

where f(x, 0) is the solution of the functional equation

f(x+u, 0) = f(x,0) + f(u,0),

and f(0, y) is the solution of the functional equation

f(0, y+v) = f(0,y) + f(0,v).

According to Theorem I, f(x, 0) has the form A-x, where A=f(1, 0); and f(0, y) has the form B-y, where B=f(0, 1). Therefore f(x, y) has the form A-x+B-y.

* See second, third, and fourth footnotes on p. 689.

We can assume also that m(Mx) and m(My)&gt;0, and reason in a way similar to that indicated in the proof of Theorem In.

From Theorem III, the following theorem can easily be obtained.

THEOREM IV. Every solution of the functional equation (2) which is bounded on a measurable set Mx, whose square measure is m(2) (Mx)&gt;0, has the form A x+B y.

In order to prove this theorem let us suppose that

$$m ^ { ( 2 ) } ( M _ { x } ) = a > 0 .$$

According to a theorem of Fubini,* there must exist then a straight line y=b parallel to the X-axis, and a straight line x=a parallel to the Y-axis, so that m(Mx)&gt;0 and m(Mx)&gt;0. Then f(x, a) would be bounded on the set Mx, where m(Mx)&gt;0; and f(b, y) would be bounded on Mx, where m(Mx)&gt;0. Therefore f(x, y) must have the form

A

x+

B.y.

From Theorem IV, we may state the following theorem.

THEOREM V. Every solution of the functional equation (2) which is measurable has the form A x+B y.

If f(x, y) is a solution of (2) and it is measurable, then there exists a perfect set P, where m(P)&gt;0, and f(x, y) is measurable on P. Since f(x, y) is finite and P is closed, f(x, y) is bounded on P, and we can apply Theorem IV.

New York City

Theorem of Fubini-Lebesgue; see de la Vallée-Pousain, Courds d'Analyse Infinitésimale, vol. 2 (2d ed.), pp. 117-120.