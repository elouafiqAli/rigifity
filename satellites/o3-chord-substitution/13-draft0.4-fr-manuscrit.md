# La substitution par corde clôt l'équation de Jensen à coefficient continu

### *Une note pédagogique sur trois hypothèses de régularité vestigiales*

*Manuscrit (Brouillon 0.4, français, prêt pour LaTeX) — Exécutant E. Clôt les sept conclusions de [`12-judge-fr-audit.md`](12-judge-fr-audit.md)~: M-fr-a (passé simple → passé composé en §V.1), M-fr-b (correction de *« sont attendus produire »*), m-fr-a (sœur → analogue), m-fr-b (force entière → pleine force), m-fr-c (parenthèse $1/\pi$ retirée), m-fr-d (parenthèse d'excuse → remarque d'excuse), S-fr-a (Résumé paragraphé en trois phrases). À soumettre à Comptes Rendus Mathématique (CRAS). Date~: 2026-06-06.*

---

**Métadonnées bilingues.**

- **Titre (fr) :** La substitution par corde clôt l'équation de Jensen à coefficient continu — Une note pédagogique sur trois hypothèses de régularité vestigiales.
- **Title (en):** The chord substitution closes the continuous Jensen equation — A teaching note on three vestigial regularity hypotheses.
- **Mots-clés (fr) :** équation de Jensen~; équation de Cauchy~; base de Hamel~; équation fonctionnelle~; fonction affine~; substitution par corde.
- **Keywords (en):** Jensen equation; Cauchy equation; Hamel basis; functional equation; affine function; chord substitution.
- **MSC 2020 :** 39B22 (Functional equations on real intervals)~; 39B05 (General theory of functional equations).

---

**Résumé.** *La forme à coefficient continu de l'équation fonctionnelle de Jensen sur un intervalle réel — celle où le coefficient parcourt tout le continuum $[0, 1]$ plutôt qu'une valeur unique telle que $\tfrac12$ — ne partage aucune pathologie de type base de Hamel avec son analogue à coefficient discret, et se résout en forme close par une substitution par corde tenant en une ligne.*

*Plus précisément~: pour $G : [0, M] \to \mathbb R$ satisfaisant $p\, G(u_1) + (1-p)\, G(u_2) = G(p\, u_1 + (1-p)\, u_2)$ pour tous $u_1, u_2 \in [0, M]$ et tout $p \in [0, 1]$, la fonction $G$ est affine sur $[0, M]$ — c.-à-d. de la forme $G(v) = av + b$ avec $a, b \in \mathbb R$ — sans qu'aucune hypothèse de mesurabilité, de bornitude ou de continuité ne soit requise.*

*Nous en donnons la démonstration, exhibons la formule affine explicite, articulons le dictionnaire des trois hypothèses de régularité classiquement requises qui deviennent vestigiales sous la forme à coefficient continu, et documentons une occurrence du piège dans la littérature sur la calibration par perte de substitution, ainsi que la raison structurelle pour laquelle il est appelé à se répéter dans toute dérivation qui pousse l'inégalité de Jensen à saturation sur une classe assez large de distributions bipoints.*

**Abstract.** *The continuous-coefficient form of the Jensen functional equation on a real interval — the form in which the coefficient varies over the full continuum $[0,1]$ rather than over a single value such as $\tfrac12$ — shares no Hamel-basis pathology with its discrete-coefficient sibling, and is solved in closed form by a one-line chord substitution. Concretely: for $G:[0,M]\to\mathbb R$ satisfying $pG(u_1)+(1-p)G(u_2)=G(pu_1+(1-p)u_2)$ for all $u_1,u_2\in[0,M]$ and all $p\in[0,1]$, $G$ is affine on $[0,M]$ — meaning $G(v)=av+b$ for some $a,b\in\mathbb R$ — with no measurability, boundedness, or continuity hypothesis on $G$. We give the proof, exhibit the explicit affine formula, articulate the dictionary of three classically required regularity hypotheses that become vestigial under the continuous-coefficient form, and document one recurrence of the trap in the surrogate-calibration literature together with the structural reason the trap is predictable to recur in any derivation that saturates Jensen's inequality across a wide class of two-point distributions.*

---

## I. Introduction

L'équation
$$
p\, G(u_1) + (1-p)\, G(u_2) \;=\; G\bigl(p\, u_1 + (1-p)\, u_2\bigr) \qquad (u_1, u_2 \in I,\ p \in [0, 1]) \tag{$\star$}
$$
sur un intervalle réel $I$ — où $G : I \to \mathbb R$ est l'inconnue et $u_1, u_2, p$ sont les arguments et le coefficient — a au moins trois visages en analyse classique, et ces visages ont été confondus sans relâche depuis plus d'un siècle.

L'**équation de Jensen à coefficient discret**,
$$
G\!\left(\tfrac{u_1 + u_2}{2}\right) \;=\; \tfrac{G(u_1) + G(u_2)}{2}, \tag{$J_2$}
$$
est la spécialisation de $(\star)$ au cas $p = \tfrac12$. En posant $f(x) := G(x) - G(0)$, l'équation $(J_2)$ équivaut, sur un translaté de $I$, à l'équation additive de Cauchy $f(x + y) = f(x) + f(y)$ (cf.~[1, §2.1] ou [9, ch.~5]). L'additivité de Cauchy hérite alors d'un appareil complet de solutions pathologiques~: en l'absence de mesurabilité, de monotonie, de bornitude sur un ensemble de mesure positive ou de toute autre hypothèse de régularité, l'équation admet des solutions non affines construites au moyen d'une **base de Hamel** — c.-à-d. d'une base de $\mathbb R$ en tant que $\mathbb Q$-espace vectoriel, dont l'existence requiert l'axiome du choix — voir Hamel~[7]. Les théorèmes classiques de Cauchy~[4], Darboux~[5], Hamel~[7], Ostrowski~[10], Sierpiński~[13] et Steinhaus~[14] délimitent ensemble les hypothèses de régularité suffisantes pour récupérer l'affinité — *une* hypothèse au moins est véritablement nécessaire, faute de quoi l'affinité échoue.

L'**équation de Jensen à coefficient rationnel**,
$$
p\, G(u_1) + (1-p)\, G(u_2) \;=\; G(p\, u_1 + (1-p)\, u_2) \qquad (u_1, u_2 \in I,\ p \in [0, 1] \cap \mathbb Q), \tag{$J_{\mathbb Q}$}
$$
raffine $(J_2)$ sans pour autant échapper à sa pathologie~: l'additivité de Cauchy entraîne la $\mathbb Q$-homogénéité $f(qx) = q\, f(x)$ par les arguments standard ($G(nx) = n\, G(x)$ par récurrence, $G(x/n) = G(x)/n$ par substitution, $G(qx) = q\, G(x)$ pour $q \in \mathbb Q$ par combinaison), et la $\mathbb Q$-homogénéité restitue $(J_{\mathbb Q})$ pour $f$, donc pour $G$. Ainsi $(J_{\mathbb Q})$, $(J_2)$ et l'équation de Cauchy partagent la même classe de solutions à une constante près, et toutes trois héritent de la pathologie de Hamel.

La **forme à coefficient continu** $(\star)$, en revanche, est fondamentalement différente. C'est l'objet de cette note.

**Résultat.** Supposons que $G : [0, M] \to \mathbb R$ vérifie $(\star)$ pour tous $u_1, u_2 \in [0, M]$ et tout $p \in [0, 1]$. Alors $G$ est affine sur $[0, M]$ — c.-à-d. de la forme $G(v) = av + b$ avec $a, b \in \mathbb R$ — et plus précisément
$$
G(v) \;=\; a\, v + b, \qquad a = \frac{G(M) - G(0)}{M},\quad b = G(0).
$$
La démonstration consiste en une unique substitution~: poser $u_1 = M$, $u_2 = 0$, $p = v/M$ dans $(\star)$. Aucune hypothèse de régularité sur $G$ n'est consommée.

Il s'agit là d'un résultat folklorique — Aczél~[1, §2.1] et Kuczma~[9, ch.~13] articulent au moins l'observation sous-jacente, et le résultat est standard dans la communauté des équations fonctionnelles. Une confusion durable persiste cependant dans les travaux appliqués qui rencontrent $(\star)$ en dehors de la littérature dédiée~: les auteurs invoquent par réflexe la machinerie de régularité de l'équation de Cauchy — continuité, bornitude, mesurabilité — alors qu'aucune de ces hypothèses n'intervient effectivement dans la démonstration de l'affinité. La présente note est une note pédagogique et de citation~: nous exhibons la démonstration ainsi que le dictionnaire des hypothèses vestigiales pour $(\star)$, et fournissons un point de citation court permettant aux auteurs qui rencontrent l'équation dans leurs propres travaux de retirer la préoccupation Hamel sans avoir à la redériver.

La suite est organisée comme suit. La Section~II énonce le théorème et sa démonstration. La Section~III est le dictionnaire des trois hypothèses de régularité qui *ne sont pas* requises, chacune accompagnée de la pathologie correspondante pour $(J_2)$ qui échoue à se manifester pour $(\star)$. La Section~IV collecte les variantes — l'hypothèse minimale que la démonstration consomme effectivement~; la remarque dimensionnelle~; le contraste avec $(J_{\mathbb Q})$. La Section~V documente une occurrence du piège dans la littérature sur la calibration par perte de substitution, et énonce la raison structurelle qui rend le piège appelé à se répéter dans toute dérivation qui pousse l'inégalité de Jensen à saturation.

---

## II. Le résultat

**Théorème~1.** *Soient $M > 0$ et $G : [0, M] \to \mathbb R$ vérifiant $(\star)$ pour tous $u_1, u_2 \in [0, M]$ et tout $p \in [0, 1]$. Alors $G$ est affine sur $[0, M]$~:*
$$
G(v) \;=\; \frac{G(M) - G(0)}{M}\, v \;+\; G(0) \qquad \text{pour tout } v \in [0, M].
$$
*Aucune hypothèse de mesurabilité, de bornitude ou de continuité sur $G$ n'est requise.*

**Démonstration.** Fixons $v \in [0, M]$. En posant $u_1 = M$, $u_2 = 0$ et $p = v/M \in [0, 1]$ dans $(\star)$,
$$
\frac{v}{M}\, G(M) \;+\; \left(1 - \frac{v}{M}\right) G(0) \;=\; G\!\left(\frac{v}{M} \cdot M + \left(1 - \frac{v}{M}\right) \cdot 0\right) \;=\; G(v).
$$
En réarrangeant, $G(v) = G(0) + \dfrac{G(M) - G(0)}{M}\, v$. $\square$

**Corollaire~2.** *Sous les hypothèses du Théorème~1, $G$ est en particulier continue, monotone, localement lipschitzienne, absolument continue et mesurable sur $[0, M]$.*

**Démonstration.** Les fonctions affines vérifient toutes ces propriétés. $\square$

L'ordre d'inférence importe et mérite d'être souligné~: la *conclusion* du Théorème~1 est que $G$ possède toutes les propriétés de régularité que l'on aurait pu vouloir *supposer*. Chacune de ces propriétés est donc vestigiale en tant qu'hypothèse — voir la Section~III.

---

## III. Le dictionnaire

Plaçons côte à côte l'équation à coefficient discret $(J_2)$ et l'équation à coefficient continu $(\star)$. La première colonne du Tableau~I nomme une hypothèse de régularité classiquement invoquée pour $(J_2)$ et en donne une définition en une phrase~; la deuxième colonne indique si l'hypothèse est requise pour forcer l'affinité dans le cas $(J_2)$, avec l'attribution standard~; la troisième colonne indique ce qu'il advient de l'hypothèse sous $(\star)$.

| **Hypothèse sur $G$ (définition)** | **Requise pour $(J_2) \Rightarrow$ affine~?** | **Requise pour $(\star) \Rightarrow$ affine~?** |
|---|---|---|
| **Continuité sur $I$** ($G$ est continue en tout $v \in I$). | Oui, suffisante (Cauchy~[4]). | **Non** — l'affinité est la *conclusion*, non l'hypothèse. |
| **Mesurabilité sur $I$** ($G$ est mesurable au sens de Lebesgue ou de Borel). | Oui, suffisante (Sierpiński~[13]). | **Non** — idem. |
| **Monotonie sur $I$** ($G$ est croissante ou décroissante au sens large). | Oui, suffisante (Darboux~[5]). | **Non** — idem. |
| **Bornitude sur un ensemble de mesure positive** (il existe un borélien $E \subseteq I$ avec $|E| > 0$ sur lequel $G$ est bornée). | Oui, suffisante (Steinhaus~[14]~; cf.~Sierpiński~[13]). | **Non** — idem. |
| **Bornitude sur $I$** ($G$ est bornée sur l'intervalle $I$ entier). | Oui, suffisante (cas particulier de Steinhaus~[14]~; Ostrowski~[10]). | **Non** — idem. |
| **Aucune** (pas d'hypothèse de régularité du tout). | **Insuffisante** — pathologie de la base de Hamel (Hamel~[7]). | **Suffisante** — Théorème~1. |

**Tableau I.** *Hypothèses de régularité sur $G$. La colonne~2 indique quelles hypothèses sont classiquement requises pour forcer l'affinité dans le cas de l'équation à coefficient discret $(J_2)$. La colonne~3 indique ce qu'il en advient sous l'équation à coefficient continu $(\star)$.*

Le point essentiel du tableau est sa dernière ligne. **Aucune hypothèse de régularité** ne suffit pour l'équation à coefficient discret~: une fonction additive sur $\mathbb R$, non affine, non mesurable et non bornée — la pathologie classique de la base de Hamel de [7] — fournit une solution non affine de $(J_2)$. Inversement, **aucune hypothèse de régularité** n'est *requise* pour l'équation à coefficient continu~: la substitution par corde du Théorème~1 clôt la démonstration au niveau de l'équation fonctionnelle nue.

Le mécanisme est direct. Une solution pathologique de type base de Hamel $G$ de l'équation de Cauchy sur $\mathbb R$ est $\mathbb Q$-linéaire~: $G(0) = 0$ et $G(qx) = q\, G(x)$ pour tout $q \in \mathbb Q$ et tout $x \in \mathbb R$. Par construction, elle n'est *pas* $\mathbb R$-linéaire — $G(rx) \neq r\, G(x)$ pour un certain irrationnel $r$ et un certain $x \in \mathbb R$.

L'identité de corde à la configuration $u_1 = M$, $u_2 = 0$ s'écrit
$$
p\, G(M) + (1 - p)\, G(0) \;=\; G(p\, M). \tag{$\star_0$}
$$
Pour $G$ une fonction additive Hamel-pathologique ($G(0) = 0$), $(\star_0)$ équivaut à l'assertion $p\, G(M) = G(p\, M)$ — vraie en $p \in \mathbb Q$ (par $\mathbb Q$-linéarité) mais fausse aux irrationnels $p$ où la $\mathbb R$-linéarité est rompue. Ainsi $G$ vérifie $(J_{\mathbb Q})$ sur $[0, M]$ mais viole $(\star)$ en *tout* irrationnel $p \in (0, 1)$ où le défaut de $\mathbb R$-linéarité apparaît. L'équation à coefficient continu $(\star)$ écarte la pathologie précisément aux points $p \in [0, 1] \setminus \mathbb Q$ sur lesquels les versions à coefficient discret et rationnel restent muettes. **La pathologie de Hamel vit aux irrationnels $p$ — précisément là où le coefficient continu de $(\star)$ referme la porte.**

---

## IV. Variantes et limites

### IV.1. L'hypothèse minimale que la démonstration consomme

La démonstration du Théorème~1 consomme $(\star)$ en une unique configuration~: $u_1 = M$, $u_2 = 0$, avec $p \in [0, 1]$ libre. La pleine force de $(\star)$ — pour *tout* couple $(u_1, u_2)$ — n'est pas mobilisée. Nous enregistrons donc le minimum strict~:

**Théorème~1$'$.** *Soient $M > 0$ et $G : [0, M] \to \mathbb R$ vérifiant*
$$
p\, G(M) + (1 - p)\, G(0) \;=\; G(p\, M) \qquad \text{pour tout } p \in [0, 1]. \tag{$\star_0$}
$$
*Alors $G(v) = G(0) + \bigl(G(M) - G(0)\bigr)\, v / M$ sur $[0, M]$.*

La démonstration est mot pour mot celle du Théorème~1~: poser $p = v/M$. Le Théorème~1$'$ est en principe plus faible que le Théorème~1 — l'hypothèse $(\star_0)$ n'entraîne pas a priori $(\star)$ dans sa totalité~; sous la conclusion (affinité), les deux sont vérifiées. En pratique, un auteur qui *dérive* $(\star)$ d'un dispositif plus riche (par ex. d'une identité d'égalité dans Jensen pour un calcul de risque bayésien, voir Section~V) dispose typiquement de $(\star)$ pour tous les triplets $(u_1, u_2, p)$. Le Théorème~1$'$, plus restreint, est la bonne référence pour un auteur qui souhaite mesurer la part exacte de l'équation que la démonstration mobilise.

### IV.2. Domaines convexes en dimensions supérieures

La substitution par corde s'étend mot pour mot à tout sous-ensemble convexe $C$ d'un espace vectoriel réel $V$~: en appliquant le Théorème~1 le long de chaque corde, on montre que la restriction de $G$ à chaque segment de $C$ est affine en le paramètre du segment, et un argument inductif standard (cf.~[2, ch.~13]) relève l'affinité-corde-par-corde en linéarité par combinaisons convexes sur $C$, donc en une forme affine $G(x) = a(x) + b$ pour une forme linéaire $a$ sur $\mathrm{vect}(C - C)$ et une constante $b \in \mathbb R$. L'étape structurellement essentielle, en dimension~1, est le Théorème~1.

### IV.3. La version à coefficients rationnels $(J_{\mathbb Q})$ conserve, elle, la pathologie

Le contraste $\mathbb Q$ vs $\mathbb R$ mérite d'être marqué explicitement~:

**Proposition~4 (folklorique).** *Il existe $G : [0, 1] \to \mathbb R$ vérifiant $(J_{\mathbb Q})$ (et donc $(J_2)$) sur $[0, 1]$, sans être affine.*

**Construction.** Choisissons une base de Hamel $H$ de $\mathbb R$ sur $\mathbb Q$ contenant $1$. Définissons une application $\mathbb Q$-linéaire $\ell : \mathbb R \to \mathbb R$ en posant $\ell(1) = 0$ et $\ell(h) = 1$ pour un certain élément de base $h \in H \setminus \{1\}$, et arbitrairement sur les autres éléments de base. Par $\mathbb Q$-linéarité, $\ell(x + y) = \ell(x) + \ell(y)$ pour tous $x, y \in \mathbb R$ (donc $\ell$ vérifie l'équation de Cauchy) et $\ell(qx) = q\, \ell(x)$ pour tous $q \in \mathbb Q$ et $x \in \mathbb R$ ($\mathbb Q$-homogénéité). Mais $\ell$ n'est *pas* $\mathbb R$-linéaire~: $\ell(1) = 0$ tandis que $\ell(h) = 1$, de sorte que les valeurs de $\ell$ sur l'enveloppe $\mathbb Q$-linéaire de $\{1\}$ (à savoir $\mathbb Q$, sur laquelle $\ell \equiv 0$) et sur l'enveloppe $\mathbb Q$-linéaire de $\{h\}$ (où $\ell$ est non nulle) sont incompatibles avec toute forme $\mathbb R$-linéaire. Posons $G := \ell|_{[0, 1]}$. Alors $G$ vérifie $(J_{\mathbb Q})$ sur $[0, 1]$ — car les combinaisons convexes à coefficients rationnels de points de $[0, 1]$ restent dans $[0, 1]$ et $\ell$ respecte les combinaisons $\mathbb Q$-linéaires sur $\mathbb R$ entier.

Témoin explicite de la non-affinité de $G$~: choisissons $h \in H \setminus \{1\}$ avec $h \in (0, 1)$ — un tel élément de base existe, l'extension de tout irrationnel de $(0, 1)$ en une base de Hamel étant immédiate. Alors $G(h) = \ell(h) = 1 \neq 0$, tandis que $G(q) = \ell(q) = q\, \ell(1) = 0$ pour tout rationnel $q \in [0, 1]$. Toute application affine $A : [0, 1] \to \mathbb R$ coïncidant avec $G$ sur $\mathbb Q \cap [0, 1]$ vérifierait $A(0) = 0$ et $A(q) = 0$ pour tout rationnel $q \in [0, 1]$, ce qui force $A \equiv 0$ — en contradiction avec $G(h) = 1$. Donc $G$ n'est pas affine. $\square$

La Proposition~4 affine l'énoncé du Théorème~1 — *« aucune hypothèse de régularité n'est requise »* — en exhibant que le renforcement, du rationnel au continu dans $(\star)$, accomplit un travail effectif. Sans ce renforcement (i.e., pour $(J_{\mathbb Q})$), des hypothèses de régularité sont véritablement nécessaires~; avec lui, elles sont vestigiales.

---

## V. Où le piège ressurgit

La substitution par corde est — comme nous l'avons noté — folklorique. Les hypothèses de régularité qu'elle rend vestigiales reparaissent néanmoins dans les travaux appliqués qui dérivent $(\star)$ en dehors de la communauté des équations fonctionnelles. Nous documentons *une* telle occurrence ci-dessous — dans nos propres travaux sur le seuil d'erreur atteignable des classifieurs fondés sur des partitions — et articulons la *source structurelle* sous laquelle l'occurrence est prévisible dans toute dérivation de calibration suffisamment riche. Nous invitons les lecteurs qui rencontrent $(\star)$ dans leurs propres travaux à compléter ce catalogue.

### V.1. Une occurrence : calibration par perte de substitution sur l'axe de résolution

Dans un travail récent~[El1, El2], l'équation $(\star)$ surgit avec $G$ la fonction qui exprime le *risque bayésien partitionnel* d'un classifieur mesurable en fonction d'une fonctionnelle de score concave agrégée sur les cellules de la partition~: $u_1, u_2$ sont les valeurs du score par cellule et $p$ est la masse de la cellule, qui parcourt librement $[0, 1]$ sur un espace de probabilité sous-jacent non atomique~; ainsi $(\star)$ est vérifiée dans toute sa généralité. Dans la formalisation Lean~4 de~[El2], le lemme correspondant a d'abord été déclaré avec une hypothèse de bornitude dans sa signature, par déférence à la littérature de Cauchy/Hamel~; le corps de la démonstration a ensuite mis en évidence que cette hypothèse n'était pas mobilisée, précisément par la substitution par corde du Théorème~1. Les versions antérieures du texte principal invoquaient en conséquence la remarque d'excuse *« $G$ est bornée, donc le théorème de Jensen-borné-implique-affine s'applique »* — remarque que le Théorème~1 de la présente note retire.

### V.2. Source structurelle : pourquoi le piège est appelé à se répéter

L'occurrence est prévisible. Dès qu'un argument de théorie de la calibration aboutit à une identité de la forme
$$
\mathbb E[g(\xi)] \;=\; g\bigl(\mathbb E[\xi]\bigr) \qquad (\xi \text{ variable aléatoire à valeurs dans } I,\ g : I \to \mathbb R),
$$
*pour une classe de variables aléatoires $\xi$ assez large pour que l'espérance marginale $\mathbb E[\xi]$ puisse être en tout point de $I$ et que le support de $\xi$ puisse être tout sous-ensemble à deux points de $I$ avec n'importe quelle paire de masses $(p, 1-p)$ avec $p \in [0, 1]$*, l'identité est $(\star)$ avec $g = G$ et $\xi$ supportée par $\{u_1, u_2\}$. Une telle identité apparaît dès que l'inégalité de Jensen est poussée à saturation. La littérature standard de la calibration par perte de substitution — Bartlett–Jordan–McAuliffe~[3], Tewari–Bartlett~[15], Steinwart~[16], Reid–Williamson~[11, 12] — dérive ses résultats de calibration par voie d'analyse convexe (biconjuguées, dualité de Fenchel, hyperplans d'appui), qui maintient Jensen comme *inégalité* avec un défaut explicitement contrôlé et, par conséquent, ne produit jamais $(\star)$ comme égalité~; la dérivation par axe de résolution de [El2] pousse Jensen jusqu'à l'égalité et produit ainsi $(\star)$ directement. La substitution par corde clôt l'équation résultante en une ligne. D'autres styles de dérivation qui saturent l'inégalité de Jensen sur une classe assez large de distributions bipoints devraient produire $(\star)$ de manière analogue — moment où le Théorème~1 retire instantanément la question des hypothèses de régularité.

### V.3. Cadres adjacents

Deux cadres adjacents où des équations structurellement similaires surgissent et où la substitution par corde constitue la fermeture naturelle, sans pour autant que le *piège* (l'invocation inutile de la régularité de Cauchy/Hamel) soit, à notre connaissance, récurrent dans la littérature publiée. Premièrement, les **théorèmes de représentation de l'utilité espérée** dans la tradition de von~Neumann–Morgenstern dérivent la linéarité-en-probabilité d'une fonctionnelle d'utilité $U(p\, L_1 + (1-p)\, L_2) = p\, U(L_1) + (1-p)\, U(L_2)$ sur les loteries~; l'axiomatisation de Herstein–Milnor clôt cette équation par l'*axiome d'Archimède* plutôt que par Cauchy/Hamel, mais la substitution par corde est l'alternative naturelle. Deuxièmement, la **caractérisation axiomatique de l'entropie de Shannon** (axiome de récursivité de Khinchin–Faddeev~; cf.~[1, ch.~5] et [2, §22]) traite des équations fonctionnelles plus riches que $(\star)$, mais plusieurs étapes intermédiaires se ramènent à des identités de type Jensen à coefficient continu pour lesquelles la substitution par corde fait partie de la boîte à outils standard. Nous signalons ces cadres comme adjacents plutôt que comme instances documentées du piège.

### V.4. Une invitation à compléter

Nous invitons les lecteurs ayant rencontré $(\star)$ dans leurs propres travaux et ayant invoqué une hypothèse de régularité vestigiale à compléter ce catalogue par une référence d'une ligne renvoyant à l'étape pertinente de leur article.

---

## Déclaration d'intérêts

L'auteur ne travaille pas pour, ne conseille pas, ne possède pas de parts dans, et ne reçoit pas de financements d'une organisation qui pourrait bénéficier de cet article, et n'a déclaré aucune affiliation autre que son organisme de recherche.

## Remerciements

L'observation par substitution par corde a émergé dans le volet de formalisation Lean~4 de [El2], durant une phase du développement de la démonstration dont la discipline est consignée dans trois compétences-projet publiquement documentées au sein du dépôt-source associé à~[El2]. L'auteur remercie le processus de relecture adversariale interne, décrit dans la même source, pour avoir mis en évidence l'hypothèse de bornitude sur-engagée dont le retrait a motivé la présente note.

---

## Références bibliographiques

[1] J.~Aczél, *Lectures on Functional Equations and Their Applications*, Mathematics in Science and Engineering, vol.~19, Academic Press~: New York, 1966.

[2] J.~Aczél et J.~Dhombres, *Functional Equations in Several Variables*, Encyclopedia of Mathematics and its Applications, vol.~31, Cambridge University Press~: Cambridge, 1989.

[3] Peter~L.~Bartlett, Michael~I.~Jordan et Jon~D.~McAuliffe, « Convexity, classification, and risk bounds », *Journal of the American Statistical Association*~**101** (2006), n°~473, p.~138–156, https://doi.org/10.1198/016214505000000907.

[4] Augustin~Louis~Cauchy, *Cours d'analyse de l'École royale polytechnique. Première partie~: Analyse algébrique*, Imprimerie royale~: Paris, 1821.

[5] Gaston~Darboux, « Mémoire sur les fonctions discontinues », *Annales scientifiques de l'École normale supérieure*, sér.~2, **4** (1875), p.~57–112.

[El1] [Auteur], en préparation, 2026~; complément de~[El2].

[El2] [Auteur], « The achievable-error floor of graph neural networks — calibration at the resolution level », manuscrit en préparation, 2026.

[7] Georg~Hamel, « Eine Basis aller Zahlen und die unstetigen Lösungen der Funktionalgleichung $f(x+y) = f(x) + f(y)$ », *Mathematische Annalen*~**60** (1905), p.~459–462.

[9] Marek~Kuczma, *An Introduction to the Theory of Functional Equations and Inequalities. Cauchy's Equation and Jensen's Inequality*, 2$^\text{e}$~éd., revue par Attila~Gilányi, Birkhäuser~: Bâle, 2009.

[10] Alexander~M.~Ostrowski, « Über die Funktionalgleichung der Exponentialfunktion und verwandte Funktionalgleichungen », *Jahresbericht der Deutschen Mathematiker-Vereinigung*~**38** (1929), p.~54–62.

[11] Mark~D.~Reid et Robert~C.~Williamson, « Composite binary losses », *Journal of Machine Learning Research*~**11** (2010), p.~2387–2422.

[12] Mark~D.~Reid et Robert~C.~Williamson, « Information, divergence and risk for binary experiments », *Journal of Machine Learning Research*~**12** (2011), p.~731–817.

[13] Wacław~Sierpiński, « Sur les fonctions convexes mesurables », *Fundamenta Mathematicae*~**1** (1920), p.~125–129.

[14] Hugo~Steinhaus, « Sur les distances des points dans les ensembles de mesure positive », *Fundamenta Mathematicae*~**1** (1920), p.~93–104.

[15] Ambuj~Tewari et Peter~L.~Bartlett, « On the consistency of multiclass classification methods », *Journal of Machine Learning Research*~**8** (2007), p.~1007–1025.

[16] Ingo~Steinwart, « How to compare different loss functions and their risks », *Constructive Approximation*~**26** (2007), n°~2, p.~225–287, https://doi.org/10.1007/s00365-006-0662-3.

---

*Manuscrit préparé pour les Comptes Rendus Mathématique de l'Académie des sciences. Soumission~: source TeX + PDF compilé + bibliographie BibTeX, conformément à la classe Centre Mersenne `crmath`. Affiliation de l'auteur, identifiant arXiv et DOI Centre Mersenne à insérer au moment de la soumission.*
