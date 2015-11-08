#lang racket
(require "../utils.scm")
(require "../meta.scm")



(define (sqrt-fixed x)
	(fixed-point (average-damp (lambda (y) (/ x y))) 1.0))

(define (sqrt-newton x) 
	(newtons-method
		(lambda (y) (- (square y) x)) 1.0))

(define (sqrt-fixed-avg x) 
	(fixed-point-of-transform (lambda (y) (/ x y))          	average-damp 		1.0))

(define (sqrt-fixed-newton x) 
	(fixed-point-of-transform (lambda (y) (- (square y) x)) 	newton-transform 	1.0))

; Exercise 1.40: 
;
; Define a procedure cubic that can be used together 
; with the newtons-method procedure in expressions of the form
;      (newtons-method (cubic a b c) 1)
; to approximate zeros of the cubic x³ + ax² + bx + c.

(define (cubic a b c)
	(lambda (x)
		(+ 
			(* x x x)
			(* a x x)
			(* b x)
			c)))



