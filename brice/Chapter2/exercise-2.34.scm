#lang racket
(require "../utils.scm")
(require "../meta.scm")

(title "Exercise 2.34")

; Exercise 2.34.  Evaluating a polynomial in x at a given 
; value of x can be formulated as an accumulation. We 
; evaluate the polynomial
;
;     ax^n + bx^(n-1) + cx^(n-2) + ... + zx + k
;
; using a well-known algorithm called Horner's rule, which 
; structures the computation as
; 
;     (... (ax+b)x + ... + z)x + k
;
; In other words, we start with an, multiply by x, add an-1, 
; multiply by x, and so on, until we reach a0. Fill in the 
; following template to produce a procedure that evaluates 
; a polynomial using Horner's rule. Assume that the 
; coefficients of the polynomial are arranged in a sequence, 
; from a0 (k) through an (a).

(define (horner-eval x coefficient-sequence)
  (foldr (lambda (this-coeff higher-terms) (+ this-coeff (* x higher-terms)))
              	0
              coefficient-sequence))

; For example, to compute 1 + 3x + 5x^3 + x^5 at x = 2 you 
; would evaluate

(let* (
	(A '(1 3 0 5 0 1))
	)
	(assert "We can use Horner's rule to evaluate polynomials" (equal? (horner-eval 2 '(1 3 0 5 0 1)) 79))
)