## A NEW DERIVATION OF THE INFORMATION FUNCTION

## HELGE TYERBERG

The purpose of this note is to prove the following

THEOREM. Let a function, H, satisfy the conditions

- (i) H is defined for any set of non-negative arguments with sum 1, and it is symmetric in all arguments.
- (ii) H(x, x2, ..., x-n, u, v) = H(x1, x2, ..., xn) + xnH(u x, v x, n ) , whenever all terms of the equation have a meaning.
- (iii) H(x, 1-x) is integrable, in the sense of Lebesgue, on the interval 0 1.

Then H is determined up to a multiplicative constant.

Weaker forms of this theorem have been proved by Fadiev [1] and Khintchine [2]. They both assume, beside conditions (i) and (ii), the continuity of H(x, 1-x). In addition, Khintchine assumes that

$$H ( x _ { 1 } , x _ { 2 } , \dots , x _ { n } ) \leq H \left ( \frac { 1 } { n } , \frac { 1 } { n } , \dots , \frac { 1 } { n } \right ) .$$

In Shannon and Weaver [3] can be found a simple derivation of the form of H, the assumptions being those of Fadiev, and further that

$$H \left ( \frac { 1 } { n } , \frac { 1 } { n } , \dots , \frac { 1 } { n } \right )$$

is an increasing function of n.

If my weakening of the conditions is insignificant from an information-theoretic point of view, I do not think that it is so from a purely mathematical one.

The proof of the theorem is direct, by deducing the form of H: Conditions (i) and (ii) give

$$( 1 ) \quad H ( x , u , v ) = H ( x , u + v ) + ( u + v ) \, H \left ( \frac { u } { u + v } , \frac { v } { u + v } \right )$$

H(u, x+v) + (x+v)H(x, v x+v) , v x+v ) ,

$$1 2 8 \, \text {HEGE TVERBERG}$$

for 0

$$f ( x ) + ( 1 - x ) f \left ( \frac { u } { 1 - x } \right ) = f ( u ) + ( 1 - u ) f \left ( \frac { x } { 1 - u } \right ) .$$

Condition (iii) allows us to integrate (2) with respect to u between the limits 0 and 1-x, and also to perform an appropriate change of variable in two of the integrals. The result is:

$$( 3 ) \quad ( 1 - x ) f ( x ) + ( 1 - x ) ^ { 2 } \int _ { 0 } ^ { 1 } f ( t ) d t = \int _ { 0 } ^ { 1 - x } f ( t ) d t + x ^ { 2 } \int _ { x } ^ { 1 - 3 } f ( t ) d t \, .$$

Condition (iii) assures the continuity in x of all terms of this equation, except the first one, for 0

$$( 4 ) \, ( 1 - x ) f ^ { \prime } ( x ) - f ( x ) - 2 ( 1 - x ) \, \underset { 0 } { \overset { 1 } { \int } } f ( t ) d t = - f ( 1 - x ) + 2 x \, \underset { x } { \overset { 1 } { \int } } t ^ { - 3 } f ( t ) d t - x ^ { - 1 } f ( x ) \, .$$

Note that f(1-x) cancels against f(x), by condition (i). Then (4) shows the existence of f''(x), and by differentiating (4) and then eliminating (1-t-3f(t)dt, one gets

$$f ^ { \prime \prime } ( x ) = - 2 x ^ { - 1 } ( 1 - x ) ^ { - 1 } \int _ { 0 } ^ { 1 } f ( t ) d t \, ,$$

whence

$$f ( x ) = a x + b - 2 [ x \log x + ( 1 - x ) \log ( 1 - x ) ] \, \underset { 0 } { \overset { 1 } { \int } } f ( t ) d t \, .$$

Symmetry shows that a=0, and integration from 0 to 1 then gives b=0.

Finally, one finds that f(0)=f(1)=0 by letting u=1-x in equation (2), and (6) is seen to yield the general form of H(x, x2). By induction and use of conditions (i) and (ii), (6) is immediately extended to

$$H ( x _ { 1 } , x _ { 2 } , \dots , x _ { n } ) = c \left ( x _ { 1 } \log x _ { 1 } + \dots + x _ { n } \log x _ { n } \right ) \, .$$

## REFERENCES

- 1. D. A. Fadiev, On the notion of entropy of a finite probability space (in Russian), Uspekhi Mat. Nauk. 11 (1956), no. 1 (67), 227-231. English translation in A. Feinstein, Foundations of information theory, New York, 1958.
- 2. A. Ia. Khintchine, The concept of entropy in probability theory (in Russian), Uspekhi Mat. Nauk. 8 (1953), no. 3 (55), 3-20. English translation in Mathematical foundations of information theory, New York, 1958.
- 3. C. G. Shannon and W. Weaver, The mathematical theory of communication, Urbana, III., 1949.

UNIVERSITY OF BERGEN, NORWAY