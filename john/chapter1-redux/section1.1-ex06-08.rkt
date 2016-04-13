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


(prn "'new-if' will recurse infinitely trying to eval sqr-iter.

The first time 'new-if' is called it will attempt to evaluate all the
operands.  The third operand is a recursive call to sqr-iter, as this is
evaluated a second call is made to 'new-if' which in turn attempts to
evaluate its operands, ...")

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

(define (sqrt-iter guess x)
  (if (good-enough? guess x)
      guess
      (sqrt-iter (improve guess x)
                 x)))

(define (improve guess x)
  (average guess (/ x guess)))

(define (average x y)
  (/ (+ x y) 2))

(define (square x) (* x x ))

(define (dist a b) (abs (- a b)))

(define (good-enough? guess x)
  (< (dist (square guess) x) 0.001))

(prn "Lets get the square root of 10, 0.0001 and 10000000000.01:
")

(present sqrt-iter
         '( (1. 100) 10)
         '( (1. 0.0001) 0.01)
         '( (1. 10000000000.01) 100000))
         
(prn
 "For 100 there's no big problem

For 0.0001 we get an answer that has an error > %300.  This is because
the good-enough threshold is relatively large compared to the sqrt. As
the number gets smaller our answer will only reflect the size of the
threshold not the correct sqrt.

For 10000000000 the answer is correct, but it may be unnecessarily
precise. As the number grows the precision (relative to the sqrt)
increases proportionately. As the number gets bigger this will
potentially waste more increasingly more computing resource.
")

(define (good-enough-new? guess x)
  (< (dist 1. (/ (square guess) x)) 0.001))

(define (sqrt-iter-new guess x)
  (if (good-enough-new? guess x)
      guess
      (sqrt-iter-new (improve guess x)
                 x)))

(present sqrt-iter-new
         '( (1. 100) 10)
         '( (1. 0.0001) 0.01)
         '( (1. 10000000000.01) 100000))

(prn
 "With sqrt-iter-new we see a consistent level of accuracy so with small
numbers we get a 'correct' answer and with large numbers we are not spending
time/resources on calculating unneeded levels of accuracy.")

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

(define (cube n) (* n n n))

(define (improve-cube guess x)
  (/
   (+
    (/ x (square guess))
    (* 2 guess))
   3))

(define (good-enough-cube? guess x)
  (< (dist 1 (/ (cube guess) x)) 0.001))

(define (cube-root-iter guess x)
  (if (good-enough-cube? guess x)
      guess
      (cube-root-iter (improve-cube guess x)
                 x)))

(present cube-root-iter
         '((1. 27) 3)
         '((1. 3250) 14.812480342))

(--end-- "1.8")

