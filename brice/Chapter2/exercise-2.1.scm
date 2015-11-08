#lang racket
(require "../utils.scm")
(require "../rational.scm")


; Exercise 2.1: 
;
; Define a better version of make-rat that handles
; both positive and negative arguments. make-rat 
; should normalize the sign so that if the rational 
; number is positive, both the numerator and 
; denominator are positive, and if the rational 
; number is negative, only the numerator is negative.

(define (make-rat2 n d)
	(let ((g (gcd n d)))
		(cons 
			(* (/ n g) (sign (* n d)))
			(abs (/ d g)))))

(assert "numerator negative" 
	(equal? "-1/2" (string-rat (make-rat2 -1 2))))

(assert "denominator negative" 
	(equal? "-1/2" (string-rat (make-rat2 1 -2))))

(assert "all positive" 
	(equal? "1/2" (string-rat (make-rat2 1 2))))

(assert "all negative" 
	(equal? "1/2" (string-rat (make-rat2 -1 -2))))