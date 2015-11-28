#lang racket
(require "../utils.scm")
(require "../meta.scm")

; Exercise 1.46: 
;
; Several of the numerical methods described in this
; chapter are instances of an extremely general 
; computational strategy known as iterative improvement. 
; Iterative improvement says that, to compute something, 
; we start with an initial guess for the answer, test if 
; the guess is good enough, and otherwise improve the 
; guess and continue the process using the improved guess 
; as the new guess. 
;
; Write a procedure iterative-improve that takes two
; procedures as arguments: a method for telling whether a
; guess is good enough and a method for improving a guess. 
; iterative-improve should return as its value a procedure 
; that takes a guess as argument and keeps improving the 
; guess until it is good enough. 
;
; Rewrite the sqrt procedure of Section 1.1.7 and the 
; fixed-point procedure of Section 1.3.3 in terms of 
; iterative-improve.

(define (iterative-improve good-enough? improve)
	(lambda (guess)

		(define (recur k)
			(if (good-enough? k)
				k
				(recur (improve k))))

		(recur guess)))


(define (sqrt x)
	
	(define (good-enough? guess)
		(< (abs (- (square guess) x)) 0.001))

	(define (improve y) (average y (/ x y)))

	((iterative-improve good-enough? improve) x))

(asserteq "sqrt 9" 3 (sqrt 9))
(asserteq "sqrt 6.25" 2.5 (sqrt 6.25))


(define (fixed-point-ii f guess)
	
	(define (good-enough? guess) 
		(< (abs (- guess (f guess))) 0.0001))

	(define (improve guess)
		(f guess))

	((iterative-improve good-enough? improve) guess))

(define (sqrt-1 x) (fixed-point (average-damp (lambda (y) (/ x y))) 1.0))
(define (sqrt-2 x) (fixed-point-ii (average-damp (lambda (y) (/ x y))) 1.0))

(asserteq "fixed point through square root of 4.3" (sqrt-2 4.3) (sqrt-1 4.3))
(asserteq "fixed point through square root of 4.0" (sqrt-2 4.0) (sqrt-1 4.0))
(asserteq "fixed point through square root of 16.0" (sqrt-2 16.0) (sqrt-1 16.0))






