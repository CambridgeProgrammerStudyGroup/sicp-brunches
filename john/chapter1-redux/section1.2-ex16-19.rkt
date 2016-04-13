#lang racket

; Section 1.2.4: Exponentiation

(require "common.rkt")

;   Exercise 1.16
;   =============
;   
;   Design a procedure that evolves an iterative exponentiation process that
;   uses successive squaring and uses a logarithmic number of steps, as does
;   fast-expt.  (Hint: Using the observation that (b^(n/2))² = (b²)^(n/2),
;   keep, along with the exponent n and the base b, an additional state
;   variable a, and define the state transformation in such a way that the
;   product a bⁿ is unchanged from state to state.  At the beginning of the
;   process a is taken to be 1, and the answer is given by the value of a at
;   the end of the process.  In general, the technique of defining an
;   invariant quantity that remains unchanged from state to state is a
;   powerful way to think about the design of iterative algorithms.)
;   
;   ------------------------------------------------------------------------
;   [Exercise 1.16]: http://sicp-book.com/book-Z-H-11.html#%_thm_1.16
;   1.2.4 Exponentiation - p46
;   ------------------------------------------------------------------------

(-start- "1.16")



(--end-- "1.16")

;   ========================================================================
;   
;   Exercise 1.17
;   =============
;   
;   The exponentiation algorithms in this section are based on performing
;   exponentiation by means of repeated multiplication.  In a similar way,
;   one can perform integer multiplication by means of repeated addition.
;   The following multiplication procedure (in which it is assumed that our
;   language can only add, not multiply) is analogous to the expt procedure:
;   
;   (define (* a b)
;     (if (= b 0)
;         0
;         (+ a (* a (- b 1)))))
;   
;   This algorithm takes a number of steps that is linear in b. Now suppose
;   we include, together with addition, operations double, which doubles an
;   integer, and halve, which divides an (even) integer by 2.  Using these,
;   design a multiplication procedure analogous to fast-expt that uses a
;   logarithmic number of steps.
;   
;   ------------------------------------------------------------------------
;   [Exercise 1.17]: http://sicp-book.com/book-Z-H-11.html#%_thm_1.17
;   1.2.4 Exponentiation - p46
;   ------------------------------------------------------------------------

(-start- "1.17")



(--end-- "1.17")

;   ========================================================================
;   
;   Exercise 1.18
;   =============
;   
;   Using the results of exercises [1.16] and [1.17], devise a procedure
;   that generates an iterative process for multiplying two integers in
;   terms of adding, doubling, and halving and uses a logarithmic number of
;   steps.⁽⁴⁰⁾
;   
;   ------------------------------------------------------------------------
;   [Exercise 1.18]: http://sicp-book.com/book-Z-H-11.html#%_thm_1.18
;   [Exercise 1.16]: http://sicp-book.com/book-Z-H-11.html#%_thm_1.16
;   [Exercise 1.17]: http://sicp-book.com/book-Z-H-11.html#%_thm_1.17
;   [Footnote 40]:   http://sicp-book.com/book-Z-H-11.html#footnote_Temp_68
;   1.2.4 Exponentiation - p47
;   ------------------------------------------------------------------------

(-start- "1.18")



(--end-- "1.18")

;   ========================================================================
;   
;   Exercise 1.19
;   =============
;   
;   There is a clever algorithm for computing the Fibonacci numbers in a
;   logarithmic number of steps. Recall the transformation of the state
;   variables a and b in the fib-iter process of section [1.2.2]: a ← a + b
;   and b ← a.  Call this transformation T, and observe that applying T over
;   and over again n times, starting with 1 and 0, produces the pair Fib(n +
;   1) and Fib(n).  In other words, the Fibonacci numbers are produced by
;   applying Tⁿ, the nth power of the transformation T, starting with the
;   pair (1,0).  Now consider T to be the special case of p = 0 and q = 1 in
;   a family of transformations T_(pq), where T_(pq) transforms the pair
;   (a,b) according to a ← bq + aq + ap and b ← bp + aq.  Show that if we
;   apply such a transformation T_(pq) twice, the effect is the same as
;   using a single transformation T_(p'q') of the same form, and compute p'
;   and q' in terms of p and q.  This gives us an explicit way to square
;   these transformations, and thus we can compute Tⁿ using successive
;   squaring, as in the fast-expt procedure.  Put this all together to
;   complete the following procedure, which runs in a logarithmic number of
;   steps:⁽⁴¹⁾
;   
;   (define (fib n)
;     (fib-iter 1 0 0 1 n))
;   (define (fib-iter a b p q count)
;     (cond ((= count 0) b)
;           ((even? count)
;            (fib-iter a
;                      b
;                      <??>      ; compute p'
;                      <??>      ; compute q'
;                      (/ count 2)))
;           (else (fib-iter (+ (* b q) (* a q) (* a p))
;                           (+ (* b p) (* a q))
;                           p
;                           q
;                           (- count 1)))))
;   
;   ------------------------------------------------------------------------
;   [Exercise 1.19]: http://sicp-book.com/book-Z-H-11.html#%_thm_1.19
;   [Section 1.2.2]: http://sicp-book.com/book-Z-H-11.html#%_sec_1.2.2
;   [Footnote 41]:   http://sicp-book.com/book-Z-H-11.html#footnote_Temp_70
;   1.2.4 Exponentiation - p47
;   ------------------------------------------------------------------------

(-start- "1.19")



(--end-- "1.19")

