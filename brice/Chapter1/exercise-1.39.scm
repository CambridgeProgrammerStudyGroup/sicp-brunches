#lang racket
(require "../utils.scm")


; Exercise 1.39:
;
; A continued fraction representation of the tangent 
; function was published in 1770 by the German 
; mathematician J.H. Lambert:
;
; f =          x 
;     ---------------------
;     1 - ⎧      x²       ⎫
;         |---------------|
;         ⎩ 3 - ⎧   x²   ⎫⎭
;               |--------|
;               ⎩ 5 - ...⎭
;
; where x is in radians. Define a procedure (tan-cf x k) 
; that computes an approximation to the tangent function 
; based on Lambert’s formula. k specifies the number of 
; terms to compute, as in Exercise 1.37.

;         1 3 5 7 9 11
;     i:  0 1 2 3 4 5 
;  2i+1:  1 3 5 7 9 11

; from 1.37
(define (cont-frac-neg n d k x)

	(define (intern i x)
		(if (> k i) 
			(/ (n i x) (- (d i x) (intern (inc i) x)))
			(/ (n i x) (d i x))))

	(intern 0 x))

(define (n i x) 
	(if (= i 0) 
		x 
		(* x x)))

(define (d i x)
	(+ 1 (* 2 i)))


(define (tan-cf x k)
	(cont-frac-neg n d k x))

(define (close-enough? v1 v2) 
		(< (abs (- v1 v2)) 0.0001))

(asserteq "tan 0.5" (tan-cf 0.5 10) (tan 0.5))
(asserteq "tan 1.0" (tan-cf 1.0 10) (tan 1.0))
(asserteq "tan 3.14" (tan-cf 3.14 10) (tan 3.14))
(asserteq "tan 6.28" (tan-cf 6.28 10) (tan 6.28))




