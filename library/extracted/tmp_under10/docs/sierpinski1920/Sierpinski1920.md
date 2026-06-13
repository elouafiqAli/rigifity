## Sur les fonctions convexes mesurables.

Par Waclaw Sierpiński (Warszawa).

Une fonction f(x) de variable réelle est dite convexe dans un intervalle , lorsqu'elle satisfait à l'inégalité

$$2 f \left ( \frac { x _ { 1 } + x _ { 2 } } { 2 } \right ) \leqslant f ( x _ { 1 } ) + f ( x _ { 2 } ) \ \text {pour } a \leqslant x _ { 1 } \leqslant b \ \text {et} \ a \leqslant x _ { 2 } \leqslant b .$$

Supposons que la fonction f(x) est discontinue au point x0, intérieur à l'intervalle . Il existe alors un 0&gt;0 tel que tout entourage de x0 contient un point x1 pour lequel

$$| f ( x _ { 1 } ) - f ( x _ { 0 } ) | \geqslant \delta .$$

Soit  un sous-intervalle quelconque de  ayant x0 pour centre. Tout entourage du point x0, donc en particulier l'intervalle , contient un point x1 satisfaisant à l'inégalité (1), donc à l'une des inégalités

$$f ( x _ { 1 } ) - f ( x _ { 0 } ) \geqslant \delta ,$$

$$f ( x _ { 1 } ) - f ( x _ { 0 } ) \leqslant - \delta .$$

Admettons que c'est l'inégalité (3) qui se présente et posons x'=2x0-x1. Comme x0-e. Or, x0=(x1+x')/2, d'où, la fonction f(x) étant convexe, 2f(x0)6, de sorte que le point x' satisfait à l'inégalité (2).

Tout entourage du point x0 contient ainsi en tout cas un point x1 pour lequel on a l'inégalité (2). Or, je dis que tout entourage de x0 contient alors nécessairement un point x2 satisfaisant à l'inégalité.

$$f ( x _ { 2 } ) - f ( x _ { 0 } ) \geqslant 2 \delta .$$

En effet, tout entourage du point x$\_{0}$, donc en particulier l'intervalle x$\_{0}$-e 2, x$\_{0}$+e 2 , contenant par hypothèse un point x$\_{1}$ qui satisfait à l'inégalité (2), posons x$\_{2}$=2x$\_{1}$-x$\_{0}$. Comme x$\_{0}$-(e/2) 6x$\_{1}$ 6x$\_{0}$ + (e/2), le point x$\_{2}$ appartient à l'intervalle . Or, x$\_{1}$=(x$\_{0}$+x$\_{2}$)/2, d'où, la fonction f(x) étant convexe, 2f(x$\_{1}$) 6f(x$\_{0}$)+f(x$\_{2}$) et par conséquent f(x$\_{2}$)-f(x$\_{0}$) 6f2[f(x$\_{1}$)-f(x$\_{0}$)], ce qui entraîne d'après (2) l'inégalité (4).

En s'appuyant sur l'inégalité (4) au lieu de (2), on peut montrer de la même manière que tout entourage de x$\_{0}$ contient un point x$\_{3}$ pour lequel on' a l'inégalité

$$f ( x _ { 3 } ) - f ( x _ { 0 } ) \geqslant 4 \delta ,$$

et, par l'itération de ce raisonnement, un point x$\_{n}$ pour lequel on a l'inégalité

$$f ( x _ { n } ) - f ( x _ { 0 } ) \geqslant 2 ^ { n - 1 } \delta .$$

Nous avons ainsi démontré ce

Théorème 1. Si une fonction f(x) convexe dans l'intervalle  est discontinue au point x$\_{0}$ interieur à cet intervalle, il existe pour tout nombre positif k et dans tout entourage du point x$\_{0}$ un point f(e) 6k.

Comme conséquence immédiate, nous en tirons le théorème suivant de M. Jensen 1), démontré d'ailleurs par une autre voie:

Toute fonction convexe dans l'intervalle  et bornée supérieurement dans cet intervalle est continue dans son intérieur.

Admettons maintenant que la fonction f(x) est dans l'inter-valle  convexe et mesurable (au sens de M. Lebesgue). Supposons qu'elle soit discontinue au point x$\_{0}$ intérieur à cet intervalle. Soit  un intervalle situé dans  et ayant x$\_{0}$ pour centre. D'après le th. 1, il existerait alors pour tout k naturel et dans tout entourage du point x$\_{0}$, donc, en particulier, dans l'intervalle , un point f pour lequel on aurait

$$( 5 ) \quad \ \ f ( \xi _ { k } ) \geq k .$$

1) L.Jensen, Sur les fonctions convexes etc., Acta Mathematica 30,p.189. Cf. F. Bernstein und G. Doetsch, Zur Theorie der konvexen Funktionen, Math. Ann. 76, p. 514; aussi F. Bernstein, Math. Ann. 64, p. 422.

Soit x un point quelconque de l'intervalle  Comme x$\_{0}$-o La fonction f(x) étant convexe, nous avons 2f(x$\_{k}$)k et f(2x$\_{k}$-x)k&gt;k se présente.

Donc, si x est un point de l'intervalle  et si l'inégalité

$$f ( x ) \geq k$$

est en défaut, le point x' de cet intervalle, symétrique à x par rapport au point x$\_{k}$, satisfait à l'inégalité f(x')&gt;k.

La fonction f(x) étant supposée mesurable, nous en concluons que l'ensemble de tous les points x de l'intervalle  pour lesquels on a l'inégalité (6) est de mesure au moins égale à la moitié de la longueur de cet inter- valle, donc de mesure &gt;o. L'intervalle  faisant partie de , donc aussi de , il en ré- sulte à plus forte raison que l'ensemble de tous les points x de l'intervalle  qui satisfont à l'inégalité (6) serait de mesure &gt;o. Or, cela est incompatible avec le théorème connu de M. E. Borel, d'après lequel, pour toute fonction mesurable f(x) et tout nombre positif o, il existe un k naturel tel que l'ensemble de tous les x satisfaisant à l'inégalité (6) est de mesure

Théorème 2. Toute fonction mesurable et convexe dans l'intervalle  est continue à l'intérieur de cet intervalle.

Un cas particulier des fonctions convexe est donné par les fonctions satisfaisant pour toutes les valeurs réelles de x et y à l'équation

$$f ( x + y ) = f ( x ) + f ( y ) .$$

1) La démonstration de ce théorème de M. Borel s'appuie sur l'axiome de M. Zermelo. Notre théorème pourrait d'ailleurs être démontré sans faire appel à cet axiome (cf. ma Note Sur l'équation fonctionnelle f(x+y)= =f(x)+f(y), ce volume, p. 116).

En effet, l'équation (7) entraîne pour y=x l'équation f(2x)=2f(x), donc, pour toutes les valeurs réels de x1 et x2, l'équation 2f(x1+x2 2) = f(x1+x2), d'où selon (7)

$$2 f \left ( \frac { x _ { 1 } + x _ { 2 } } { 2 } \right ) = f ( x _ { 1 } ) + f ( x _ { 2 } ) .$$

Toute fonction satisfaisant à l'équation fonctionnelle (7) satisfait donc (pour tous x1 et x2 réels) à l'équation fonctionnelle (8) 2).

Il en résulte d'après le th. 2 que toute fonction mesurable f(x) satisfaisant à l'équation fonctionnelle (7) est continue (done de la forme Ax, A étant une constante) 3).

Les fonctions discontinues satisfaisant à l'équation (7) (dont l'existence a été démontrée par M. G. Hamel) sont par conséquent non mesurables.

- 2) D'autre part, si la fonction f(x) satisfait à l'équation (8), la fonction φ(x)=f(x)-f(0) satisfait à l'équation (7). En effet, (8) entraîne

et

pour x1=2x, x2=0 l'équation 2f(x)=f(2x)+f(0)

pour x1=2y, x2=0 l'équation 2f(y)=f(2y)+f(0)

Les deux équations donnent en vertu de (8)

2f(x+y)=f(2x)+f(2y)=2f(x)+2f(y)-2f(0).

En posant φ(x)=f(x)-f(0), on en tire φ(x+y)=φ(x)+φ(y), c. q. f. d.

- 3) Cf. ma note oitée de ce volume Sur l'équation fonctionnelle f(x+y)=f(x)+f(y).