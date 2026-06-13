## CHAPITRE VI.

Des SØries convergentes et divergentes. RØgles sur la convergence des SØries. Sommation de quelques SØries convergentes.

1. 1. Considerations gØncrales sur les SØries.

OØ appelle sØrie une suite indØfinie de quantitØs

$$u _ { \circ } , u _ { \circ } , u _ { \circ } , u _ { \circ } , \mathfrak { c } . \dots$$

qui dØrivent les unes des autres suivant une loi dØterminØe. Ces quantitØs elles-mØnØs sont les dØfØrŁns termes de la sØrie que on considŁre. Soit

$$s _ { \pi } = u _ { \pi } + u _ { \pi } + \dots + u _ { m \pi }$$

la somme des n premiers termes, n dØsignant un nombre entier quelconque. Si, pour des valeurs do n toujours croissantes, la somme s'approche indØfiniment d'une certaine limite s, la sØrie sera dØte convergente, et la limite en question s'appellera la somme de la sØre. Au contraire, si, taundis que n crot indØfiniment, la somme s, ne sØapproche d'aucune limite fixe, la sØrie sØra divergente, et n'aura plus de somme. Dans l'un et l'autre cas, le terme qui correspond à l'indice n, savoir u, sera ce qu'on nomme le terme gØnØral. Il suffit que l'on donne ce

124

Cours d'analyse.

terne général en fonction de l'indice n, pour que la série soit complètement déterminée.

L'une des séries les plus simples est la progres­ sion géométrique

$$1 , \, x , \, x ^ { \prime } , \, x ^ { 3 } , \, \& c . \dots$$

qui a pour terme général x, c'est-à-dire, la puis­ sance n. " de la quantité x. Si dans cette série on fait la somme des n premiers termes, on trouvera

$$1 + x + x ^ { \prime } + \dots + x ^ { \prime \prime } = \frac { 1 } { 1 - x } - \frac { 1 } { 1 - x } ;$$

et, comme pour des valeurs croissantes de n la valeur numérique de la fraction x' converge vers la limite zéro, ou croit au-delà de toute limite, suivant qu'on suppose la valeur numérique de x inférieure ou supérieure à l'unité, on doit conclure que dans la première hypothèse la progression

$$1 , \, x , \, x ^ { \prime } , \, x ^ { 3 } , \, \& c . \dots$$

est une série convergente qui a pour somme 1-x tandis que dans la seconde hypothèse la même pro­ gression est une série divergente qui n'a plus de somme.

D'après les principes ci-dessus établis, pour que la série

$$( 1 ) \ u _ { \cdot } , \, u _ { \cdot } , \, u _ { \cdot } , \, u _ { \cdot \cdot } , \, \& c . \dots$$

soit convergente, il est nécessaire et il suffit que des valeurs croissantes de n fassent converger indéfi­ ment la somme

$$s _ { _ { n } } = u _ { _ { n } } + u _ { _ { n } } + \tilde { c } _ { _ { n } } \dots + u _ { _ { n - 1 } }$$

vers une limite fixe s : en d'autres termes, il est nécessaire et il suffit que, pour des valeurs infiniment grandes du nombre n, les sommes

$$s _ { n } , \, s _ { n + 1 } , \, s _ { n + 2 } , \, \& c . \dots$$

difèrent de la limite s, et par conséquent entre elles, de quantités infiniment petites. D'ailleurs, les différences successives entre la première somme s, et chacune des suivantes sont respectivement déterminées par les équations

$$s _ { n + 1 } - s _ { n } & = u _ { n } , \\ s _ { n + 1 } - s _ { n } & = u _ { n } + u _ { n - 1 } \, , \\ s _ { n + 2 } - s _ { n } & = u _ { n } + u _ { n + 1 } + u _ { n + 2 } \, , \\ \& c . \dots$$

Donc, pour que la série (1) soit convergente, il est d'abord nécessaire que le terme général u, décroisse indéfiniment, tandis que n augmente; mais cette econdition ne suffit pas, et il faut encore que, pour des valeurs croissantes de n, les différentes sommes

$$u _ { n } + u _ { n + 1 } , \\ u _ { n } + u _ { n + 1 } + u _ { n + 1 } , \\ \& c . \dots$$

cest-à-dire, les sommes des quantités

$$u _ { n } , \, u _ { c + 1 } , \, u _ { n + 1 } , \, \& c . \dots$$

126

COURS D'ANALYSE.

prises, à partir de la première, en tel nombre que l'on voudra, finissent par obtenir constamment des valeurs numériques inférieures à toute limite assignable. Réciproquement, lorsque ces diverses conditions sont remplies, la convergence de la série est assurée.

Prenons pour exemple la progression géométrique

valeurs de n infiniment grandes; et par suite la série sera convergente, ce que l'on savait déjà.

Prenons pour second exemple la série numérique

$$( 3 ) \ \ 1 , \ \frac { 1 } { x } , \ \frac { 1 } { 3 } , \ \frac { 1 } { 4 } \ \dots \ \frac { 1 } { n } , \ \frac { 1 } { n + 1 } , \ \& c \dots$$

Le terme général de cette série, savoir, 1 1 1 décroit indéfiniment à mesure que n augmente, et cependant la série n'est pas convergente; car la somme faite du terme 1 1 1 et de ccux qui le suivent jusqu'au terme 1 1 1 inclusivement, savoir,

$$\frac { 1 } { n + 1 } + \frac { 1 } { n + 2 } + \dots + \frac { 1 } { n - 1 } + \frac { 1 } { 2 } ,$$

reste constaument supérieure, quel que soit n, au produit

$$n \times \frac { 1 } { 2 3 } = \frac { 1 } { 2 } ;$$

et par suite, cette somme ne décroit pas indéfiniment pour des valeurs croissantes de n, ainsi que cela aurait lieu si la série était convergente. Ajoutons que, si l'ordonnée par s la somme des n premiers termes de la série (3), et par 2 la plus haute puis-sancse de 2 renfermée dans n+1, on trouvera

$$s _ { \alpha } = 1 + \frac { 1 } { 3 } + \frac { 1 } { 3 } + \dots + \frac { 1 } { n + 1 } > 1 + \frac { 1 } { 2 } + ( \frac { 1 } { 3 } + \frac { 1 } { 4 } )$$

$$\left ( \frac { 1 } { 3 } + \frac { 1 } { 3 } + \frac { 1 } { 3 } + \frac { 1 } { 3 } \right ) + \dots + \left ( \frac { 1 } { 3 } + \frac { 1 } { 3 } + \frac { 1 } { 3 } + \frac { 1 } { 3 } + \dots + \frac { 1 } { 3 } \right ) ,$$

et à fortiori

$$s _ { m } > 1 + \frac { 1 } { 2 } + \frac { 1 } { 3 } + \frac { 1 } { 4 } + \dots + \frac { 1 } { 4 } = 1 + \frac { m } { 2 } \, .$$

On en conclura que la somme s , croit indéfiniment avec le nombre entier m, et par conséquent avec n, ce qui est une nouvelle preuve de la divergence de la série.

Considérons encore la série numérique,

de désigner par la lettre e la somme de cette série. En ajoutant les n premiers termes, on obtiendra pour valeur approchée du nombre:e

$$\begin{array} { r } { \quad + \frac { 1 } { 1 } + \frac { 1 } { 1 . 3 } + \frac { 1 } { 1 . 3 } + \dots + \frac { 1 } { 1 . a . j . ( n - 1 ) } \, ; } \end{array}$$

et, d'après ce qu'on vient de dire, Ferreur commise sera inférieure au produit du n.r' terme par n-1. Ainsi, par exemple, si Fon suppose n = 11, ou trouvera pour la valeur approchée de e

$$e = 2 . 7 1 8 2 8 1 \dots ;$$

130

COURS D'ANALYSE.

est convergente, la somme de cette série est reprØsentØ par

$$u _ { \ast } + u _ { \ast } + u _ { \ast } + \& c \dots .$$

En vertu de cette convention, la valeur du nombre se trouve dØterminØe par lØquation

$$( 6 ) \quad e = 1 + \frac { 1 } { i } + \frac { 1 } { i . 3 } + \frac { 1 } { i . 3 } + \frac { 1 } { i . 3 . 3 } + \frac { 1 } { i . 3 . 4 } + \& c \dots .$$

et, si Ton considŁre la progressiŁon gØomØtrique

$$1 , x , x ^ { 1 } , x ^ { 3 } , \& c . \dots ,$$

on aura, pour des valeurs numØriques de x infØ- rieures à l'unitØ,

$$1 + x + x ^ { \prime } + x ^ { 3 } + \& c . \dots = \frac { 1 } { 1 - x } .$$

La sØrie

$$u _ { \ast } , u _ { \ast } , u _ { \ast } , \, \& c . \dots$$

Øtant supposØe convergente, si l'on dØsigne sa somme par s, et par s la somme de ses n premiers termes, on trouvera

$$s = u _ { \ast } + u _ { \ast } + u _ { \ast } + \dots + u _ { \ast - i } + u _ { \ast } + u _ { \ast - i } + \& c . \dots \\ - s _ { \ast } + u _ { \ast } + u _ { \ast } + \& c . \dots ,$$

et par suite

$$s - s _ { n } = u _ { n } + u _ { n - 1 } + \& c . \dots .$$

De cette derniŁre Øquation il rØsulte que les quan- titØs

$$u _ { n } , u _ { n + 1 } , u _ { n - 1 } , \& c . \dots .$$

formeront une nouvelle série convergente dont la somme sera équivalente à s-s. Si l'on représente cette même somme par r,n, on aura

$$s = s _ { n } + r _ { n } ;$$

et r,n sera ce qu'on appelle le reste de la série (1) à partir du n.n' terme.

Lorsque, les termes de la série (1) renfermant une même variable x, cette série est convergente, et ses différents termes fonctions continues de x, dans le voisinage d'une valeur particulière attribuée à cette variable;

$$s _ { n } , \, r _ { n } \, e t s$$

sont encore trois fonctions de la variable x, dont la première est évidemment continue par rapport à x, dans le voisinage de la valeur particulière dont il s'agit. Cela posé, considérons les accroissements que recoivent ces trois fonctions, lorsqu'on fait croitre r,n'une quantité infiniment petite a. L'accroissement de s, sera, pour toutes les valeurs possibles de n, une quantité infiniment petite; et celui de r,n deviendra insensible en même temps que r,n, si l'on attribue à n une valeur très-considérable. Par suite, l'accroissement de la fonction s ne pourra être qu'une quantité infiniment petite. De cette remarque on déduit immédiatement la proposition suivante.

1. " THÈORÈME. Lorsque les différents termes de la série (1) sont des fonctions d'une même variable x,

continues par rapport à cette variable dans le voisinage d'une valeur particulière pour laquelle la série est convergente, la somme de la série est aussi, dans le voisinage de cette valeur particulière fonction continue de x.

En vertu de ce théorème, la somme de la série (2) devra rester fonction continue de la variable x, cutre les limites x=-1, x=1; ce qu'on peut vérifier à l'inspection de la valeur de s donnée par l'équation

$$s = \frac { 1 } { 1 - x } .$$

2. Des Séries dont tous les termes sont positif:

Lorsque la série

n venant à croitre au-delà de toute limite assignable, les plus grandes valeurs de (u) 1 2 ne pourront s'procholer indéfiniment de la limite k, sans finir par être constamment inférieures à U. Par suite, il sera possible d'attribuer au nombre entier n une valeur assez considérable, pour que, n obtenant cette même valeur ou une valeur plus grande encore, on ait constamment

$$( u _ { \pi } ) ^ { \frac { 1 } { 2 } }$$

Il en résulte que les termes de la série

$$u _ { \pi } , \, u _ { \pi } \dots u _ { \pi + \pi } , \, u _ { \pi + \pi } , \, \& c . \dots$$

finiront par être toujours inférieurs aux termes correspondants de la progression géométrique

$$1 , \, U , \, U ^ { \prime } , \, \dots \, U ^ { \prime \prime } , \, U ^ { \prime \prime \prime } , \, \& c \dots ;$$

et, comme cette progression est convergente (a cause de U

Supposons, en second lieu, k&gt;1; et plaçons encore entre les deux nombres et k un troisième nombre U, en sorte qu'on ait

$$k > U > 1 .$$

Si n vient à croitre au-delà de toute limite, les plus grandes valeurs de (u) 1 , en s'approchant indéfiniment de k, finiront par devenir supérieures à U

13'4 COURS D'ANALYSE. On pourra donc satisfaire à la condition

$$( u _ { n } ) ^ { \frac { 1 } { n } } > U ,$$

ou, ce qui revient au même, à la suivante

$$u _ { * } > U ^ { \prime \prime } ,$$

par des valeurs de n aussi considérables que l'on voudra; et par suite, on trouvera dans la série

convergente toutes les fois que l'on aura k 1. Concevons, par exemple, que l'on considère la s'erie

COURS F'ANALYSE.

u, = u,,

2u, = 2u,,

4u,

8u,

&amp;c...;

et par suite, la somme des termes de la série (2), pris en tel nombre que l'on voudra, sera inférieure à

u, + 2u, + 2u, + 2u, + &amp;c.... = 2 s-u..

Il en résulte que la série (2) sera convergente.

Supposons, en second lieu, la série (1) divergente. La somme de ses termes pris en très-grand nombre finira par surpasser toute limite assignable: et, comme on aura

u, = u,,

2u, &gt; u, + u,,

4u, &gt; u, + u, + u, + u,

C.ROLLAIRE. Si pour la série (1) on prend la suivante

$$( 3 ) \ \ 1 , \ \frac { 1 } { 2 ^ { n } } , \ \frac { 1 } { 3 ^ { n } } , \ \frac { 1 } { 4 ^ { n } } , \ \& c . \dots ,$$

µ désignant une quantité quelconque, la série (2) deviendra

$$1 , \, 2 ^ { \prime \prime } , \, 4 ^ { \prime \prime } , \, 8 ^ { \prime \prime } , \, \& c \dots .$$

Cette dernière est une progression géométrique, convergente lorsqu'on suppose µ&gt;1, et divergente dans le cas contraire. Par suite, la série (3) sera elle-méne convergente, si µ est un nombre supérieur à l'unité; et divergente, si fon a µ = 1 ou µ

$$( 4 ) \quad 1 , \ \frac { 1 } { 2 ^ { n } } , \ \frac { 1 } { 3 ^ { n } } , \ \frac { 1 } { 4 ^ { n } } , \ \& c \dots ,$$

$$( 5 ) \quad 1 , \ \frac { 1 } { 2 ^ { n } } , \ \frac { 1 } { 3 ^ { n } } , \ \frac { 1 } { 4 ^ { n } } , \ \& c \dots ,$$

$$( 6 ) \quad 1 , \ \frac { r } { 3 ^ { n } } , \ \frac { 1 } { 4 ^ { n } } , \ \frac { 1 } { 4 ^ { n } } , \ \& c \dots .$$

la première sera convergente, et les deux autres divergentes.

4.5 THÉORÈME. Supposons que l'on désigne par L la caractéristique des logarithmes dans un système quelconque, et que, pour des valeurs crois.santes de n, le rapport

$$\frac { L ( u _ { 2 } ) } { L \left ( \frac { 1 } { n } \right ) }$$

138 COURS D'ANALYSE.

converge vers une limite finie h. La série (1) sera convergente, si l'on a h&gt;1, et divergente, si l'on

a h1, et choisissons à volonté entre les deux quantités et 1, en sorte qu'on ait

$$h > a > 1 .$$

$$\text {Le rapport } \frac { L \left ( \frac { u _ { n } } { m } \right ) } { L \left ( \frac { u _ { n } } { m } \right ) } , \text { ou son égal} \\ \frac { L \left ( \frac { u _ { n } } { m } \right ) } { L \left ( \frac { u _ { n } } { m } \right ) } ,$$

finira par être, pour de très-grandes valeurs de n, constamment supérieur à la quantité a. En d'autres termes, n venant à croitre au-delà d'une certain limite, on aura toujours

$$\frac { L \left ( \frac { u _ { n } } { m _ { i } } \right ) } { L \left ( n _ { i } \right ) } > a ,$$

ou, ce qui revient au même,

$$L \left ( \frac { u _ { n } } { u _ { n } } \right ) > a \, L \left ( n \right )$$

et par suite,

$$\frac { 1 } { u _ { n } } > n ^ { * } ,$$

$$u _ { n }$$

I'en résulte que les termes de la série (1) finiont par être constamment inférieurs aux termes corres-

pondans de la suivante

140

Cours D'ANALYSE.

de a

Étant données deux séries convergentes dont tous les termes sont positifs, on peut, en ajoutant ou multiplier ces mémes termes, former une nouvelle série dont la somme résulte de l'addition ou de la multiplication des sommes des deux premières. Nous établions à ce sujet les deux théorèmes suivans :

5. THÉORÈME. Soient

$$\begin{cases} u _ { \varepsilon } , \, u _ { \varepsilon } , \, u _ { \varepsilon } \dots , \, \ddot { u } _ { \varepsilon } , \, \ddot { \varepsilon } \dots , \\ v _ { \varepsilon } , \, v _ { \varepsilon } \dots , \, v _ { \varepsilon } \dots , \end{cases}$$

deux séries convergentes, qui, uniquement compo- sées de termes positifs, aient respectivement pour sommes et s' :

(8)

u$\_{e}$+v$\_{e}$, u$\_{e}$+v$\_{e}$, u$\_{e}$+v$\_{e}$, u$\_{e}$+v$\_{e}$, &amp;c...

sera une nouvelle série convergente, qui aurapour sommes +s'.

DÉMONSTRATION. Si Fon fait

$$\begin{array} { r l } { s _ { \varepsilon } = u _ { \varepsilon } + u _ { \varepsilon } + u _ { \varepsilon } + \dots + u _ { \varepsilon - 1 } , } \\ { s _ { \varepsilon } = v _ { \varepsilon } + v _ { \varepsilon } + v _ { \varepsilon } + \dots + v _ { \varepsilon - 1 } , } \end{array}$$

s$\_{e}$ et s' convergeront respectivement, pour des valeurs croissantes de n, vers les limites s et s'. Par suite, s$\_{e}$+s' , c'est-à-dire, la somme des n premiers termes de la série (8), convergera vers la limite s+s'; ce qui suffit pour établir le théorème énonce.

6. ' THEORÈME. Les mØnes choses Øtant posØes que dans le thØorØme prØcØdent,

$$\begin{cases} u _ { v } , u _ { v } + u _ { v } , u _ { v } + u _ { v } , u _ { v } + u _ { v } , v _ { v } , v _ { v } + u _ { v } , v _ { v } , v _ { v } , v _ { v } + u _ { v } , \end{cases} .$$

sera une nouvelle sØrie convergente, qui aura pour somme ss.

DØMONSTRATION. Soient toujours s, s' les sommes des n premiers termes des deux sØries (7), et dØsignons en outre par s' la somme des n premiers termes de la sØrie (9). Si l'on reprØsente par m le plus grand nombre entier compris dans 1, 1, c'est-à-dire, 1 1 lorsque n est impair, et 1 1 dans le cas contraire, on aura Øvidemment

142 COUNS D'ANALYSE.

s'et s'convergeront vers la limite s'. Par suite, les deux produits s's, s's, s's, s's, et la somme s'comprise entre ces deux produits, convergeront vers la limite ss' : ce qui suffit pour établir le théorème 6."

3. 3. Des Series qui renferment des termes positifs et des termes négatifs.

Supposons que la série

(1) u, u, u, u, &amp;c. . . .

se compose de termes, tantôt positifs, tantôt néga- tifs : et soient respectivement

(2) P, P, P, P, &amp;c. . . .

les valeurs numériques de ces némées termes, en sorte qu'on ait

u, =±p, u, =±p, u, =±p, u, =±p, &amp;c. . . .

La valeur numérique de la somme

$$u _ { + } + u , + u , + \dots + u _ { - }$$

ne pouvant jamais surpasser

$$p _ { + } + p _ { - } + p _ { + } + \dots + p _ { - - } ,$$

il en consulte que la convergence de la série (2) en- trainera toujours celle de la série (1). On doit ajouter que la série (1) sera divergente, si quelques termes de la série (2) finissent par croite au-delà de toute

limite assignable. Ce dernier cas se prØsente lorsque les plus grandes valeurs de (p) 1 convergent, pour des valeurs croissantes de n, vers une limite supØ-ricure à l'unitØ. Au contraire, lorsque cette limite devient infØrieure à l'unitØ, la sØrie (2) est toujours convergente. On peut, en consØquence, Ønoncer le thØorŁme suivant:

- 1.°°' THØORŁME. Soit p n la valeur numØrique du terme gØnØral u n de la sØrie (1) et dØsignons par k la limite vers laquelle convergent, tandis que n croit indØfiniment, les plus grandes valeurs de

l'expression (p) 1. La sØrie (1) sera convergente, si l'on a k 1, et divergente, si l'on a k 1.

Lorsque la fraction p n 1, c'est-à-dire, la valeur numØrique du rapport u n 1, convergea vers une limite fixe, cette limite sera, en vertu du 4. th'o rŁme [chap. II, §. 3.], la valeur cherchØe de k. Cette remarque conduit à la proposition que je vais Øcrire.

2.°° THØORŁME. Si, pour des valeurs croissantes de n, la valeur numØrique du rapport

$$\frac { n _ { \ell } } { n _ { \ell } }$$

converge vers une limite fixe k, la sØrie (1) sera convergente, toutes les fois que l'on aura k 1, et divergente, toutes les fois que l'on aura k&gt;1.

Par exemple, si l'on considŁre la sØrie

$$\begin{array} { r l } { 1 , - 1 , + \frac { 1 } { 1 , 2 , - 1 , 1 , 2 , 3 , 3 , + \& c . . , } , } \end{array}$$

on trouvera

$$\frac { \mu _ { \mu \mu } } { \mu _ { \mu } } = - \frac { 1 } { \mu + 1 } , \, k = \frac { 1 } { \infty } = 0 \, ;$$

d'où il résulte que la série sera convergente.

Le premier des deux théorèmes qu'on vient d'établir ne laisse d'incertitude sur la convergence ou la divergence d'une série que dans le cas particulier où la quantité représentée par k devient égale à l'unité. Dans ce cas particulier, on peut quelquefois constater la convergence de la série proposée, soit en s'assurant que les valeurs numériques de ses différents termes forment unc série convergente, soit en ayant égard au théorème suivant.

3. 'Théorème. Si dans la série (1) la valeur nu- mérique du terme général « décroit constamment et indéfiniment, pour des valeurs croissantes de n, si de plus les différents termes sont alternativement positifs et negatifs, la série sera convergente.

Considérons, par exemple, la série

$$( 3 ) \, , \, - \frac { 1 } { 1 } , \, + \frac { 1 } { 3 } , \, - \frac { 1 } { 4 } , \, + \& c . \dots \, \pm \frac { 1 } { n + 1 } , \, \& \, , \, \& \, .$$

La somme des termes dont le rang surpasse n, si on les suppose pris en nombre égal à m, sera

$$\pm \left ( \frac { 1 } { n + 1 } - \frac { 1 } { n + 1 } + \frac { 1 } { n + 1 } - \frac { 1 } { n + 1 } + \frac { 1 } { n + 1 } \right ) \cdot$$

Or la valeur numérique de cette somme, savoir,

$$\frac { 1 } { n + 1 } - \frac { 1 } { n + 1 } + \frac { 1 } { n + 1 } - \frac { 1 } { n + 1 } + \& c . \dots \pm \frac { 1 } { n + 1 } \\ = \frac { 1 } { n + 1 } - \left ( \frac { 1 } { n + 1 } - \frac { 1 } { n + 1 } \right ) - \left ( \frac { 1 } { n + 1 } - \frac { 1 } { n + 1 } \right ) - \& c . \dots \\ = \frac { 1 } { n + 1 } - \frac { 1 } { n + 1 } + \left ( \frac { 1 } { n + 1 } - \frac { 1 } { n + 1 } \right ) + \left ( \frac { 1 } { n + 1 } - \frac { 1 } { n + 1 } \right ) + \& c . \dots ,$$

étant Øvidemment comprise entre

$$\frac { 1 } { n + 1 } \ e t \ \frac { 1 } { n + 1 } - \frac { 1 } { n + 1 } ,$$

decretaire indéfiniment pour des valeurs croissantes de n, quel que soit m, ce qui suffit pour établir la convergence de la série proposée. Les mêmes raisonnemens peuvent Øvidemment s'appliquer à toutes les séries de ce genre. Je citerai, entre autres, la suivante,

$$( 4 ) \, , \, - \frac { 1 } { 3 ^ { 2 } } , \, + \frac { 1 } { 3 ^ { 2 } } , \, - \frac { 1 } { 4 ^ { 2 } } , \, \& c . \dots ,$$

laquelle, en vertu du théorème 3.°, restera converge pour toutes les valeurs positives de µ.

Si dans la série (4) on supprime le signe - devant chacun des termes de rang pair, on obtiendra la série (3) du 2. 2.°, qui est divergente toutes les fois que l'on suppose µ=1 ou µ

Étant donnée une série convergente dont tous les termes sont positifs, on ne peut qu'augmenter la convergence en diminuant les valeurs numériques de ces mémes termes, et changeant les signes de quelques-uns. Il est bon d'observer qu'on produira ce double effect, si l'on multiplie chaque terme par un sinus ou par un cosinus; et cette observation suffit pour établir la proposition suivante.

## 4. THERÔREME. Lorsque la série

$$( 2 ) \ \mathfrak { P } _ { \mathfrak { P } } , \mathfrak { P } _ { \mathfrak { P } } , \dots \mathfrak { P } _ { \mathfrak { P } } , \mathfrak { C } _ { \mathfrak { C } } , \dots$$

uniquement formée de termes positifs, est convergente, chacune des suivantes

$$( 5 ) \begin{cases} \mathfrak { P } _ { \mathfrak { P } } \cos \mathfrak { P } _ { \mathfrak { P } } , \mathfrak { P } _ { \mathfrak { P } } \cos \mathfrak { P } _ { \mathfrak { P } } , \dots \mathfrak { P } _ { \mathfrak { P } } \cos \mathfrak { P } _ { \mathfrak { P } } , \mathfrak { C } _ { \mathfrak { P } } , \dots \\ \mathfrak { P } _ { \mathfrak { P } } \sin \mathfrak { P } _ { \mathfrak { P } } , \mathfrak { P } _ { \mathfrak { P } } \sin \mathfrak { P } _ { \mathfrak { P } } , \dots \mathfrak { P } _ { \mathfrak { P } } \sin \mathfrak { P } _ { \mathfrak { P } } , \mathfrak { C } _ { \mathfrak { P } } , \dots \end{cases}$$

Fest pareillement, quelles que soient les valeurs des arcs 0, 0, 0, 0, 0, &amp;c...

COROLAIRE. Si l'on suppose généralement

$$\theta _ { \cdot } = n \theta ,$$

0 désignant un arc quelconque, les séries (5) de viendront respectivement

$$( 6 ) \begin{cases} \mathfrak { P } _ { \mathfrak { P } } , \mathfrak { P } _ { \mathfrak { P } } \cos \mathfrak { P } _ { \mathfrak { P } } , \mathfrak { P } _ { \mathfrak { P } } \cos \mathfrak { P } _ { \mathfrak { P } } , \dots \mathfrak { P } _ { \mathfrak { P } } \cos \mathfrak { P } _ { \mathfrak { P } } , \mathfrak { C } _ { \mathfrak { P } } , \dots \\ \mathfrak { P } _ { \mathfrak { P } } \sin \mathfrak { P } _ { \mathfrak { P } } , \mathfrak { P } _ { \mathfrak { P } } \sin \mathfrak { P } _ { \mathfrak { P } } , \dots \mathfrak { P } _ { \mathfrak { P } } \sin \mathfrak { P } _ { \mathfrak { P } } , \mathfrak { C } _ { \mathfrak { P } } \dots \end{cases}$$

Ces deux dernières seront donc toujours convergentes en même temps que la série (2).

Si l'on considère à-la-fois deux séries dont cha-

eune renferme des termes positifs et des termes né› gatifs, on démontrera facilement à leur égard les théorèmes 5. et 6. du second paragraphe, ainsi qu'on va le faire voir.

5. THÉORÈME. Soient

$$( \begin{matrix} u _ { 0 } , & u _ { 1 } , & \dots & u _ { n } , & \& c . \dots , \\ v _ { 0 } , & v _ { 1 } , & \dots & v _ { n } , & \& c . \dots , \end{matrix} }$$

deux séries convergentes qui aient respectivement pour sommes s et s ;

(8) u+v+u, u+v, u+v, u+v, u+v, &amp; c. &amp;

sera une nouvelle série convergente, qui aurapour sommes s+s.

DÉMONSTRATION. Si Fon fait

$$s _ { \pi } = u _ { \pi } + u _ { \pi } + u _ { \pi } + \dots + u _ { n - 1 } , \\ s _ { \pi } ^ { \prime } = v _ { \pi } + v _ { \pi } + v _ { \pi } + \dots + v _ { n - 1 } ;$$

s, et s, convergeront respectivement, pour des va› leurs croissantes de n, vers les limites et s et s. Par suite, s+s+s, cest-dire, la somme des premiers termes de la série (8) convergera vers la limite s+s; ce qui suffit pour établir le théorème énoncé.

6. THÉORÈME. Les mémes choses étant possées que dans le théorème précédent, si chacune des séries (7) reste convergente, lorsqu'on réduit ses différens termes à leurs valeurs numériques,

sera une nouvelle série convergente, qui aura pour somme ss' .

DÉMONSTRATION. Soient toujours s$\_{s}$ , s$\_{s}$ les sommes des n premiers termes des deux séries (7), et désignons en outre par s$\_{s}$ , la somme des n premiers termes de la série (9). On trouvera

$$s _ { s } ^ { \prime } - s _ { s } ^ { \prime } = u _ { s _ { s } } v _ { s _ { s } } + ( u _ { s _ { s } } v _ { s _ { s } } + u _ { s _ { s } } v _ { s _ { s } } ) + \dots .$$

valeurs numériques, soient toutes deux conver­ gentes. En vertu de la remarque qu'on vient de faire, la somme

$$\begin{array} { r l } { f _ { a } \cdot \rho ^ { \prime } _ { - } + ( \rho _ { a } \cdot \rho ^ { \prime } _ { - } + \rho _ { a } \cdot \rho ^ { \prime } _ { - } ) + \dots + \dots } \\ { \dots + ( \rho _ { a } \cdot \rho ^ { \prime } _ { - } + \rho _ { a } \cdot \rho ^ { \prime } _ { - } + \dots + \dots + \rho _ { a } \cdot \rho ^ { \prime } _ { - } + \rho _ { a } \cdot \rho ^ { \prime } _ { - } ) } \end{array}$$

convergera, pour des valeurs croissantes de n, vers la limite zéro : et, comme la valeur numérique de cette somme sera évidemment supérieure à celle de la suivante

150

COURS D'ANALYSE.

$$\left ( \begin{matrix} 1 & 1 , & - \left ( \begin{matrix} 1 & \overline { \nu } & \overline { \nu } \\ \overline { \nu } & \overline { \nu } & \overline { \nu } \\ \overline { \nu } & \overline { \nu } & \overline { \nu } \end{matrix} \right ) , & + \left ( \begin{matrix} \overline { \nu } & \overline { \nu } & \overline { \nu } \\ \overline { \nu } & \overline { \nu } & \overline { \nu } \\ \overline { \nu } & \overline { \nu } & \overline { \nu } \end{matrix} \right ) , \end{matrix} \right ) ,$$

C'ette d'ernière est divergente. Car son terme géné. ral, savoir,

$$\pm \left ( \frac { \frac { 1 } { \nu } } { \nu } + \frac { \frac { 1 } { \nu } } { \nu } + \frac { \frac { 1 } { \nu } } { \nu } + \frac { \frac { 1 } { \nu } } { \nu } + \frac { \frac { 1 } { \nu } } { \nu } + \frac { \frac { 1 } { \nu } } { \nu } + \frac { \frac { 1 } { \nu } } { \nu } \right ) + \dots + \frac { \frac { 1 } { \nu } } { \frac { 1 } { \nu } ( \frac { 1 } { \nu } - 1 ) } \right )$$

a une valeur numérique évidemment supérieure à

une série ordonnée suivant les puissances entières 6: ascendantes de la variable x,

$$( 2 ) \ \ a _ { \circ } , \ a _ { \circ } , \ a _ { \circ } , \dots \ a _ { \circ } , \ & \& \ \mathfrak { c } \dots$$

désignant des coefficients constans positifs ou négatifs. Soit de plus A ce que devient pour la série (2) la quantité k du paragraphe précédent [voy. le 3, 2.1. théorème]. La même quantité, calculée pour la série (1), sera équivalente à la valeur numérique du produit

## Ax.

Par suite, la série (1) sera convergente, si cette valeur numérique est inférieure à l'unité, c'est-à-dire, en d'autres-termes, si la valeur numérique de la variable x est inférieure à 1. Au contraire, la série (i) sera divergente, si la valeur numérique de x surpasse 1. On peut donc énoncer la proposition suivante.

1.1. THÈORÈME. Soit A la limite vers laquelle converge, pour des valeurs croissantes de n, la ra- cine n." des plus grandes valeurs numériques de 1. La série (1) sera convergente pour toutes les valeurs de x comprises entre les limites

$$x = - \frac { 1 } { A } , \ x = + \frac { 1 } { A } ,$$

et divergente pour toutes les valeurs de x situées hors des mêmes limites.

Lorsque la valeur numérique du rapport 1.

converge vers une limite fixe, cette limite est [en vertu du 4.' théorème, chapitre II, §. 3] la valeur cherchee de A. Cette remarque conduit à uncou-velle proposition que je vais écrire.

2. THÉORÈME. Si, pour des valeurs croissantes de n, la valeur numérique du rapport

$$\frac { a _ { \circ } } { a _ { \circ } }$$

converge vers la limite A, la série (1) sera converge pour toutes les valeurs de x comprises entre les limites

$$- \frac { 1 } { A } , \, + \frac { 1 } { A } ,$$

et divergente pour toutes les valeurs de x situés hors des mêmes limites.

COURLAIRE 1." Prenons pour exemple la série

$$( 3 ) \ \ 1 , \ 2 \times r , \ 3 \times \dot { x } ^ { \prime } , \ 4 \times \dot { x } ^ { \prime } , \dots \ ( n + 1 ) \, \mathcal { E } ^ { \prime } , \ \mathcal { C } \dots .$$

Comme on trouvera dans cette hypothèse

$$\frac { a _ { \circ } + \dots } { a _ { \circ } } = \frac { n + 1 } { n + i } = 1 + \frac { 1 } { n + i } ,$$

et par suite,

$$A = 1 ,$$

on en conclura que la série (3) est convergente pour toutes les valeurs de x renfermées entre les limites

$$x = - 1 , \ x = + 1 ,$$

et divergente pour les valeurs de x situées hors de ces limites.

C OROLLAIRE 2. ' Prenons pour second exemple la sØrie

$$( 4 ) \ \frac { 1 } { x } , \ \frac { x ^ { 3 } } { x ^ { 3 } } , \ \frac { 1 } { x ^ { n } } , \ \frac { x ^ { n } } { x ^ { n } } , \ \& c . \dots$$

dans laquelle le terme constant est censØ réduit à zØro. On trouvera dans cette hypothØse

$$\frac { a _ { x + 1 } } { a _ { x } } = \frac { n } { n + 1 } = \frac { 1 } { 1 + \frac { 1 } { 2 } } ,$$

et par suite A = 1. La sØrie (4) sera donc encore convergente ou divergente, suivant que la valeur numØrique de x sera infØrieure ou supØrieure à fu-nite.

C OROLLAIRE 3. ' Si pour la sØrie (1) on prend la suivant,

$$( s ) \begin{cases} 1 , \ \frac { \mu } { x } , \ \frac { \mu ( \mu - 1 ) } { 1 . 2 } x ^ { \prime } , \ \dots \\ \frac { \mu ( \mu - 1 ) ( \mu - 2 ) , \dots ( \mu - n + 1 ) } { 1 . 2 . 3 . \dots , \dots } x ^ { \prime } , \ \& c . \dots , \end{cases}$$

µ dØsignant une quantitØ quelconque, on trouvera

154 COURB D'ANALYSE. que Fon attribue à la variable x une valeur numé-

rique inférieure ou supérieure à l'unité.

CORLLAIRE 4.' Considérons encore la série

$$( 6 ) \ \ 1 , \ \frac { x } { 1 } , \ \frac { x ^ { \prime } } { 1 . 1 . 3 } , \dots \frac { x ^ { \prime \prime } } { 1 . 1 . 2 . 1 . 2 } , \frac { \mathcal { C } } { \mathcal { C } } \dots$$

Commune on aura dans ce cas

$$\frac { a _ { n } } { a _ { n } } = \frac { t } { n + t } ,$$

et par suite,

$$A = \frac { 1 } { \infty } = 0 ,$$

on en conclura que la série est convergente entre les limites

$$x = - \frac { 1 } { 2 } = - \infty , \ x = + \frac { 1 } { 2 } = + \infty ,$$

c'est-à-dire, pour toutes les valeurs réelles possibles de la variable x.

CORLLAIRE 5. Considérons enfin la série

$$( 7 ) \ \ 1 , \ 1 . x , \ 1 . 2 . x ^ { 1 } , \ 1 . 2 . 3 . x ^ { 1 } , \ 1 . 2 . 3 \dots n . x ^ { * } , \ & \& \, \mathcal { C } \dots$$

En lui appliquant le théorème 2. , on trouvera

$$\frac { a _ { n } } { a _ { n } } = n + 1 , \ A = \infty \, ;$$

et l'on aura par suite,

$$\frac { 1 } { 4 } = 0 .$$

On en conclura que la série (7) est toujours diver­ gente, excepté lorsqu'on suppose x = 0, auquel cas, elle se réduit à son premier terme 1.

En examinant les résultats qu'on vient d'obtenir, on reconnaît immédiatement que, parmi les séries ordonnées suivant les puissances ascendantes et en tières de la variable x, les unes sont tantôt convergentes, tantôt divergentes, selon la valeur attribuée à cette variable, tandis que d'autres restent toujours convergentes, quel que soit x, et d'autres toujours divergentes, excepté pour x=0. On peut ajouter que le théorème 1. " ne laisse d'incertitude sur la convergence d'une semblable série que dans le cas où la valeur numérique de x devient égale à la constante positive représentée par 1, c'est-àdire, lorsqu'on suppose

$$x = \pm \frac { 1 } { A } .$$

Dans ce cas particulier, la série est tantôt convergente, tantôt divergente, et la convergence dépend quelques fois du signe de la variable x. Par exemple, si dans la série (4), pour laquelle A=1, on fait successivement

$$x = 1 , \ x = - 1 ,$$

on obtiendra les deux suivantes

$$( 8 ) \quad 1 , \ \frac { 1 } { 3 } , \ \frac { 1 } { 4 } , \ \dots , \ \frac { 1 } { n } , \ \& c \dots$$

$$( 9 ) \ - \ 1 , + \frac { 1 } { 2 } , - \frac { 1 } { 3 } , + \frac { 1 } { 4 } , \dots \pm \frac { 1 } { n } , \ \& c \dots ,$$

dont la première est divergente [voyez dans le 2 le corollaire du 3. théorème], et la seconde e'on

## 156 COURS D'ANALYSE.

gente, ainsi que cela résulte du 3. théorème [5. 3]. Il est encore essentiel de remarquer que par sui cu du premier théorème, lorsqu'une série ordonnée suivant les puissances ascendantes et cntières d'une variable x sera convergente pour une valeur nu- mérique de x différente de zéro, elle restera con- vergente, si l'on vient à diminuer cette valeur numé- rique, ou même à la faire décroitre indéfiniment.

Lorsque deux séries ordonnées suivant les puis- sances ascendantes et entières de la variable x sont convergentes pour une même valeur de la variable, on peut leur appliquer les théorèmes 5 et 6 du 5. 3. Cette remarque suffit pour établir les deux propo- sitions que je vais énoncer.

3. THÉORÈME. Supposons que les deux séries

$$( 1 0 ) \left \{ b _ { \cdot } , b _ { \cdot } x , a _ { \cdot } , a _ { \cdot } x ^ { \prime } , \dots a _ { \cdot } x ^ { \prime \prime } , \& c . \dots ,$$

étant à-la-fois convergentes, lorsqu'on attribue à la variable x une certaine valeur, aient alors pour sommes respectives s et s ;

$$( 1 1 ) \, a _ { + } b _ { + } , ( a _ { - } + b _ { - } ) x , ( a _ { + } + b _ { + } ) x ^ { \prime } , \dots \, \mathbb { m } { a } _ { + } b _ { + } ) x ^ { \prime } , \mathbb { m } { a } _ { - }$$

sera, dans le même cas, une nouvelle série conver- gente, qui aura pour somme s + + s .

Corollaire. On étendra facilement ce théo- rème à tant de séries que l'on voudra. Par exemple, si les trois séries

à développer dans cette hypothèse le produit des sommes des deux séries en une nouvelle série de même forme:

CROLLAIRE 2. ' En répétant plusieurs fois de suite l'opération indiquée par l'équation (13), on pourrait multiplier entre elles les sommes de trois ou dun plus grand nombre de séries semblables aux séries (10), et dont chacune resterait convergente après la réduction de ses différens termes à leurs valeurs numériques. Le produit obtenu serait la somme d'une nouvelle série convergente ordonnée suivant les puissances ascendants et entières de la variable x.

CROLLAIRE 3. ' Si dans les deux corollaires précède sèdens on suppose que toutes les séries dont on multiplie les sommes deviennent égales, on obtiennent pour produit une puissance entière de la somme de chacune d'elles; et cette puissance se trouve encore représentée par la somme d'une série du même genre. Par exemple, si dans l'équation (13) on fait a=b, a=b, a=b, a=b, &amp;c... , on en tirena

$$( 1 4 ) \left \{ \begin{array} { l } ( a _ { + } , a _ { + } , x + a _ { + } , x ^ { \prime } + \& c . \dots ) \\ a _ { + } ^ { \prime } + 2 a _ { + } a _ { + } x + ( 2 a _ { + } a _ { + } - a _ { + } ) x ^ { \prime } + & \& c . \dots \end{array}$$

CROLLAIRE 4. ' Si l'on prend pour termes gé néraux des séries (10)

µ, µ' désignant deux quantités quelconques, et la variable x étant renfermée entre les limites x =-1, x =-1, chacune des séries (10) restera convergente même l'ensqu'on réduira ses différens termes à leurs valeurs numériques, et le terine général de la série (12) deviendra

160 COURS D'ANALYSE. termes, on obtient une formule qui ne cesse jamais d'etre exacte, tant que la série

$$a _ { \bullet } , \, a _ { \bullet } x , \, a _ { \bullet } x ^ { \prime } , \, \& \cdots .$$

demeure convergente. C'est ce que nous allons prouver directement, en établissant le théorème qui suit.

5. THÉORÈME. Si, la série (1) étant convergente, on multiplie la somme de cette série par le polynôme

$$( 1 7 ) \ k x ^ { \prime \prime } + l x ^ { \prime \prime } - + \& c \dots + p x + q \, ,$$

dans lequel m désigne un nombre entier, on ob- tiendra pour produit la somme d'une nouvelle série convergente de même forme, dont le terme général sera

$$( q a _ { \cdot } + p a _ { \cdot - 1 } + \dots \, . \, l a _ { \cdot - m + 1 } + k a _ { \cdot - m } ) x ^ { m } ,$$

pourvu que l'on considère comme nulles dans les premiers termes celles des quantités

$$a _ { \cdot - 1 } , \, a _ { \cdot - \dots } \dots \, a _ { \cdot - m + 1 } , \, a _ { \cdot - m } ,$$

qui se trouveront affectées d'indices négatifs : en d'autres termes, on aura

DÉMONSTRATION. Pour multiplier la somme de la série (1) par le polynome (17), il suffira de la multiplier successivement par les différents termes de ce polynome. On aura donc

```

```

Tant que la série restera convergente, c'est-a-dire, tant que la valeur de x demeurera comprise entre les limites

$$- \frac { 1 } { A } , + \frac { 1 } { A } ,$$

la somme de la séric scra [en vertu du 1. " théo-rème, 1. ] une fonction continue de la variable x. Soit 1. (x) cette fonction continue. L'equation

$$\Phi ( x ) = a _ { \circ } + a _ { \circ } x + a _ { \circ } x ^ { \circ } + \& c \dots .$$

subsistera pour toutes les valeurs de x renfermées entre les limites -A, +A; ce que nous indiquons, en écrivant ces limites à côté de la série, comme on le voit ici

$$\Phi ( x ) = a _ { \ast } + a _ { \ast } x + a _ { \ast } x ^ { \ast } + \& c _ { \ast } \dots \begin{cases} x = - \frac { 1 } { A } \right \} , \\ x = + \frac { 1 } { A } \right \} .$$

Lorsque la série est supposée connue, on peut quelquefois en déduire la valeur de la fonction 1. (x) sous forme finie; et c'est-la ce qu'on appelle sommer la série. Mais le plus souvent la fonction 1. (x) est donnée, ct l'on se propose de revenir de cette fonction à la série, ou, en d'autres termes, de développer la fonction en série convergente ordonnée suivant les puissances ascendantes et entières de la variable x. Il est facile détablir à ce sujet la proposition que je vais énoncer.

6. T HÉORÈME. Une fonction continue de la variable x ne peut être développée que d'une seule manière en série convergente ordonnée suivant les

puissances ascendantes et entières de cette va-riablle.

DÉMONSTRATION. En effet, supposons qu'on ait développé par deux méthodes différentes la fonction (x); et soient

$$a _ { \bullet } , a _ { \bullet } x , a _ { \bullet } x ^ { \prime } , \dots a _ { \bullet } x ^ { \prime \prime } , \& c \dots , \\ b _ { \bullet } , b _ { \bullet } x , b _ { \bullet } x ^ { \prime } \dots b _ { \bullet } x ^ { \prime \prime } , \& c \dots ,$$

les deux développemens, c'est-à-dire, deux séries dont chacune, étant convergente pour des valeurs de x differentes de zéro, ait pour somme, tant qu'elle demeure convergente, la fonction (x). Ces deux séries étant constamment convergentes pour de très-pctites valeurs numériques de x, on aura, pour de semblables valeurs,

$$a _ { \bullet } + a _ { \bullet } x + a _ { \bullet } x ^ { \prime } + \& c \dots = b _ { \bullet } + b _ { \bullet } , x + b _ { \bullet } x ^ { \prime } + \& c \dots$$

Comme, en faisant évanouir x, on tire de l'équation précédente

$$a _ { \bullet } = b _ { \bullet } \, ,$$

il en résulte qu'on peut la réduire généralement à

$$a _ { \bullet } x + a _ { \bullet } x ^ { \prime } + \& \& c \dots = b _ { \bullet } x + b _ { \bullet } x ^ { \prime } + \& \& c \dots ,$$

oui, ce qui revient au même, a

$$x ( a _ { \bullet } + a _ { \bullet } x + \& c \dots ) = x ( b _ { \bullet } + b _ { \bullet } x + \& c \dots ) .$$

Si Ton multiplie par ' les deux membres de cette dernière équation, on obtiendra la suivante

$$a _ { \bullet } + a _ { \bullet } x + \& c \dots = b _ { \bullet } + b _ { \bullet } x + \& c \dots ,$$

qui devra encore subsister pour de très-petites la- leurs numériques de la variable x, et de laquelle on conclura, en posant x = 0,

$$a _ { i } = b _ { i } .$$

En continuant de même, on ferait voir que les constantes a, a, a, &amp;c... sont respectivement égales aux constantes b, b, b, &amp;c... ; d'où il suit que les deux développemens de la fonction (x) sont identiques.

Le calcul différentiel fournit des méthodes très-expédiives pour développer les fonctions en séries. Nous exposerons plus tard ces méthodes; et nous nous bornerons pour l'instant à faire connaitre, avec le développement de la fonction (1 + x) , dans laquelle µ désigne une quantité quelconque, deux autres développemens que l'on ramène facilement au premier, savoir, ceux des fonctions

$$A ^ { * } \, e t \, L ( \tau + x ) ,$$

A désignant une constante positive, et L la carac- téristique des logarithmes dans un système choisi à volonté. En conséquence, nous allons résoudre l'un après l'autre les trois problèmes qui suivent.

1. 'PROBLÈME. Développer, lorsque cela se peut, la fonction

$$( 1 + x ) ^ { * }$$

en série convergente ordonnée suivant les puis- sances ascendantes et entières de la variable x.

SOLUTION. Si'abord on suppose 1= m, m désignant un nombre entier quelconque, on aura, par la formule de Newton,

$$( 1 + x ) ^ { \mathfrak { m } } = 1 + \frac { m } { 1 } x + \frac { m ( m - 1 ) } { 1 . 3 } x + \& c \dots .$$

La série dont la somme constitue le second membre de cette formule est toujours composée dun nombre fini de termes : mais, si fon y remplace le nombre entier m par une quantité quelconque, la nouvelle série que fon obtiendra, savoir,

$$( \mathfrak { s } ) \quad 1 \, , \, \frac { \mu } { x } , \, \frac { \mu ( \mu - 1 ) } { 1 . 2 } x ^ { * } , \, \& c \dots .$$

se trouvera composée en général d'un nombre défini de termes, et sera convergente seulement pour des valeurs numériques de x inférieures à l'unité. Soit, dans cette hypothèse, 1(u) la somme de la nouvelle série; en sorte qu'on ait

$$( 1 5 ) \ \Phi ( \mu ) = 1 + \frac { \mu } { 1 . 3 } x + \frac { \mu ( \mu - 1 ) } { 1 . 3 } x ^ { * } + \& c \dots \left \{ \frac { x = - 1 } { x + 1 } \right \} .$$

En vertu du 1.1 théorème [§. 1.7], 1(u) sera fonction continue de la variable 1 entre des limites quelconques de cette variable, et fon aura [voyez le 3.1 théorème, corollaire 4]

$$( 1 6 ) \quad \Phi ( \mu ) . \Phi ( \mu ^ { \prime } ) = \Phi ( \mu + \mu ^ { \prime } ) .$$

Cette dernière équation, étant entièrement semblable à l'équation (2) du chapitre V [§. 1.1], se résoudra de la même manière; et fon en conclura

$$\Phi ( \mu ) = [ \Phi ( 1 ) ] ^ { * } = ( 1 + x ) ^ { * } .$$

La valeur de 1(1) étant ainsi déterminée, si on la substitue dans la formule (15), on trouvera, pour toutes les valeurs de x comprises entre les limites x=1, x=+1,

$$( 2 0 ) \, ( 1 + x ) ^ { * } = 1 + \frac { \mu } { 1 } x + \frac { \mu ( \mu - 1 ) } { 1 , 3 } x ^ { * } + \& \text {c.} \dots \, \left \{ \frac { x = - 1 } { x = + 1 } \right \}$$

Lorsque la valeur numérique de x devient périurec à l'unité, la série (5), n'étant plus convencente, cesse d'avoir une somme; en sorte que l'quation (20) ne subsiste plus. Dans la même hypothèse, cesse, il devient impossible, ainsi qu'on le prouvera plus tard à la d'eau du calcul infinitésimal, de dé-lopper la fonction (1 + x) en série convergente ordonnée suivant les puissances ascendantes et cntières de la variable x.

Corollaire 1." Si dans l'équation (20) on remplace µ par 1, et x par a.r, a désignant une quantité infiniment petite, on aura pour toutes les valeurs de a.x renfermées entre les limites -1, +1, ou, ce qui revient au même, pour toutes les valeurs de x renfermées entre les limites -1, +1,

Cette dernière équation devant subsister, quelque petite que soit la valeur numérique de a, si l'on désigne a'fordinaire, par fabréviation lim. placée devant une expression qui renferme la variable a, la limite vers faquelle converge cette expression, tandis que la valeur numérique de a décroit indéfiniment, on trouvera, en passant aux limites,

$$\left \{ \lim _ { \substack { ( 1 + a x ) ^ { 1 } = 1 + \frac { x } { t } + \frac { x } { 1 . 2 } + \frac { x } { 1 . 3 } + \frac { x } { 1 . 3 } + \frac { x } { 1 . 3 } } \right \} \frac { \left \{ x = - \infty \right \} } { x = + \infty } \right \} .$$

Il reste à chercher la limite de (1+a x) . Or, en premier lieu, on tirera de la formule précédente

168

Cours D'ANALYSE.

$$( 2 3 ) \ e ^ { \prime \prime } = 1 + \frac { x } { 1 } + \frac { x ^ { \prime } } { 1 . 3 } + \frac { x ^ { \prime } } { 1 . 3 } + \& c \dots \left \{ x = - \infty \right \} .$$

On pourrait arriver directement à l'équation (23), en observant que la série

$$1 , \ \frac { x } { 1 . 3 } , \ \frac { x ^ { \prime } } { 1 . 3 } , \ \frac { x ^ { \prime } } { 1 . 3 } , \ \& c \dots .$$

est convergente pour toutes les valeurs possibles de la variable x, et cherchant la fonction de x qui représente la somme de cette même série. En effet, soit (x) la somme de la série (6) qui a pour terme général

$$\frac { x ^ { \prime } } { 1 . 3 . 3 . . . m } \, ;$$

y (y) scra la somme de la série qui a pour terme général

$$\frac { y ^ { \prime } } { 1 . 3 . . . n } ,$$

et [en certu du 6. théorème, 3] le produit de ces deux sommes scra la somme d'une nouvelle série qui aura pour terme général

$$\frac { x ^ { * } } { 1 . 3 . 3 . . . n } + \frac { x ^ { * } - 1 } { 1 . 3 . 3 . . . ( n - 1 ) } \cdot \frac { y } { 1 . 3 . 3 . . . ( n - 1 ) } + \dots + \frac { y ^ { * } } { 1 . 3 . 3 . . . ( n - 1 ) } \\ + \frac { y ^ { * } } { 1 . 3 . . . n } = \frac { ( x + y ) ^ { * } } { 1 . 3 . 3 . . . n }$$

Ce produit sera donc égal à (x+y); et par suite, si Ton fait

$$\Phi ( x ) = 1 + \frac { x } { 1 } + \frac { x ^ { 2 } } { 1 . 3 } + \frac { x ^ { 3 } } { 1 . 3 . 3 } + \& c \dots ,$$

la fonction (x) vérifiera l'équation

$$\varphi ( x ) . \varphi ( y ) = \varphi ( x + y ) .$$

En résolvant cette équation, on en tirera

170

COURS D'ANALYSE.

et par suite

$$( 2 5 ) \quad l i m . \, \frac { ( 1 + x ) ^ { * } - 1 } { \mu } = l ( 1 + x ) .$$

Cela posé, la formule (24) deviendra

$$( 2 6 ) \quad l ( 1 + x ) = x - \frac { x } { 3 } + \frac { x ^ { 3 } } { 3 } - \& c \dots \left \{ \frac { x = - 1 } { x = + 1 } \right \} .$$

L'équation précédente subsiste tant que la valeur numérique de x reste inférieure à l'unité; et, dans ce cas, la série

$$( 2 7 ) \quad x , \, - \frac { x ^ { 3 } } { 3 } , \, + \frac { x ^ { 3 } } { 3 } , \, \dots \, + \frac { x ^ { 3 } } { n } , \, \& c \dots .$$

est convergente, aussi bien que la série (4), qui en diffère seulement par les signes des termes de rang impair. Les mêmes séries devenant divergentes, des qu'on suppose la valeur numérique de x supérieure à l'unité, équation (26) cesse d'avoir lieu dans cette hypothèse.

Dans le cas particulier où fon prend x = 1, la série (27) se réduit à la série (3) du troisième paragraphe, laquelle est convergente, comme on la fait voir. L'équation (26) doit donc alors subsister; en sorte qu'on

$$l ( 2 ) = 1 - \frac { 1 } { 3 } + \frac { 1 } { 3 } - \frac { 1 } { 4 } + \frac { 1 } { 4 } .$$

Si l'on prenatait au contraire x =-1, la série (27) deviendrait divergente, et n'aurait plus de somme.

On peut remarquer encore que, si, après avoir écrit -x au lieu de x dans la formule (26), on

change a-la-fois les signes des deux membres, on obtiendra la suivante

$$( 2 9 ) \ \ l \left ( \frac { 1 } { i - x } \right ) = x + \frac { x ^ { 1 } } { 3 } + \frac { x ^ { 1 } } { 3 } + \& c \dots \left \{ \frac { x ^ { 1 } - x } { x } \right \} .$$

2. PROBLÈME. Développer la fonction

$$A ^ { \prime } ,$$

dans laquelle A désigne un nombre quelconque, en série convergente ordonnée suivant les puissances ascendent et entières de la variable x.

Solution. Désignons toujours par la caractéristique l'les logarithmes népériens pris dans le système dont la base est e. On aura, d'après la définition même des logarithmes,

$$A = e ^ { l ( A ) } ,$$

et Fon en conclura

$$( 3 0 ) \quad A ^ { \circ } = \mathfrak { a } ^ { \circ } ( \mathfrak { a } ^ { \circ } ) .$$

Par suite, en ayant égard à l'équation (23), on trouvrera

$$\left ( \begin{array} { c } A ^ { \circ } = \mathfrak { t } + \frac { x A } { 1 } + \frac { x ^ { \prime } \left ( \mathfrak { A } \right ) } { 1 , 2 } + \frac { x ^ { \prime } \left ( \mathfrak { A } \right ) } { 1 , 3 } + \frac { x ^ { \prime } \left ( \mathfrak { A } \right ) } { 1 , 4 } + \mathfrak { c } \dots \\ \left ( \begin{array} { c } x = - \infty \\ x = + \infty \end{array} \right ) \right )$$

Cette dernière formule subsiste pour toutes les valeurs réelles possibles de la variable x.

3. PROBLÈME. La caractéristique l. désignant les logarithmes pris dans le système dont la base est A, développer, lorsque cela se peut, la fonction

$$L ( 1 + x )$$

en série convergente ordonnée suivant les pu-sances ascendantes et entières de la variable x.

SOLUTION. Désignons toujours par l la caracté-ristique des logarithmes népériens. On aura, en vertu des propriétés connes des logarithmes,

$$L ( \mathbf i + \mathbf x ) = \frac { L ( \mathbf i + \mathbf x ) } { L ( \mathbf A ) } = \frac { \mathbf i ( \mathbf i + \mathbf x ) } { \mathbf i ( \mathbf A ) } \, ;$$

et par suite, en ayant égard à l'équation (26), on trouvera, pour toutes les valeurs de x comprises entre les limites -1, +1,

$$( 3 2 ) \, L ( 1 + x ) = \frac { 1 } { i ( 4 ) } \left [ x - \frac { x ^ { 2 } } { 3 } + \frac { x ^ { 3 } } { 3 } - \& c . . \right ] \cdot \left \{ \begin{array} { l l } { x = - 1 } \\ { x = + 1 } \end{array} \right \} .$$

Cette dernière formule subsiste dans le cas même où l'on prend x = 1. Mais elle cesse d'avoir lieu, lorsqu'on suppose x = -1, ou x' &gt; 1.