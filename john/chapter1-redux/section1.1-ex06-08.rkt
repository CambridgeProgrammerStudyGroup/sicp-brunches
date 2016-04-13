#lang racket

; Section 1.1.7: Example: Square Roots by Newton's Method

(require "common.rkt")

;   Exercise 1.6
;   ============
;   
;   Alyssa P. Hacker doesn't see why if needs to be provided as a special
;   form.  "Why can't I just define it as an ordinary procedure in terms of
;   cond?" she asks. Alyssa's friend Eva Lu Ator claims this can indeed be
;   done, and she defines a new version of if:
;   
;   (define (new-if predicate then-clause else-clause)
;     (cond (predicate then-clause)
;           (else else-clause)))
;   
;   Eva demonstrates the program for Alyssa:
;   
;   (new-if (= 2 3) 0 5)
;   5
;   
;   (new-if (= 1 1) 0 5)
;   0
;   
;   Delighted, Alyssa uses new-if to rewrite the square-root program:
;   
;   (define (sqrt-iter guess x)
;     (new-if (good-enough? guess x)
;             guess
;             (sqrt-iter (improve guess x)
;                        x)))
;   
;   What happens when Alyssa attempts to use this to compute square roots?
;   Explain.
;   
;   ------------------------------------------------------------------------
;   [Exercise 1.6]:  http://sicp-book.com/book-Z-H-10.html#%_thm_1.6
;   1.1.7 Example: Square Roots by Newton's Method - p25
;   ------------------------------------------------------------------------

(-start- "1.6")



(--end-- "1.6")

;   ========================================================================
;   
;   Exercise 1.7
;   ============
;   
;   The good-enough? test used in computing square roots will not be very
;   effective for finding the square roots of very small numbers. Also, in
;   real computers, arithmetic operations are almost always performed with
;   limited precision.  This makes our test inadequate for very large
;   numbers.  Explain these statements, with examples showing how the test
;   fails for small and large numbers.  An alternative strategy for
;   implementing good-enough? is to watch how guess changes from one
;   iteration to the next and to stop when the change is a very small
;   fraction of the guess.  Design a square-root procedure that uses this
;   kind of end test.  Does this work better for small and large numbers?
;   
;   ------------------------------------------------------------------------
;   [Exercise 1.7]:  http://sicp-book.com/book-Z-H-10.html#%_thm_1.7
;   1.1.7 Example: Square Roots by Newton's Method - p25
;   ------------------------------------------------------------------------

(-start- "1.7")



(--end-- "1.7")

;   ========================================================================
;   
;   Exercise 1.8
;   ============
;   
;   Newton's method for cube roots is based on the fact that if y is an
;   approximation to the cube root of x, then a better approximation is
;   given by the value
;   
;   x/y² + 2y
;   ─────────
;       3
;   
;   Use this formula to implement a cube-root procedure analogous to the
;   square-root procedure.  (In section [1.3.4] we will see how to implement
;   Newton's method in general as an abstraction of these square-root and
;   cube-root procedures.)
;   
;   ------------------------------------------------------------------------
;   [Exercise 1.8]:  http://sicp-book.com/book-Z-H-10.html#%_thm_1.8
;   [Section 1.3.4]: http://sicp-book.com/book-Z-H-12.html#%_sec_1.3.4
;   1.1.7 Example: Square Roots by Newton's Method - p26
;   ------------------------------------------------------------------------

(-start- "1.8")



(--end-- "1.8")

