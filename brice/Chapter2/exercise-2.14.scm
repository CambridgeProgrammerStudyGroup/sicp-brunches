#lang racket
(require "../utils.scm")
(require "../meta.scm")

; Let's find the approximate tolerance of a product of two intervals given the assumptions that the 
; intervals are small.


(require "exercise-2.7.scm")
(require "exercise-2.8.scm")
(require "exercise-2.9.scm")
(require "exercise-2.10.scm")
(require "exercise-2.11.scm")
(require "exercise-2.12.scm")

(title "Exercise 2.14")

; make-interval 
; lower-bound
; upper-bound
; sub-interval
; add-interval
; mul-interval
; div-interval
; smart-mul-interval
; make-center-percent
; percent
; center
; width

(define (par1 r1 r2)
	(div-interval (mul-interval r1 r2) (add-interval r1 r2)))

(define (par2 r1 r2)
	(let ((one (make-interval 1 1)))
		(div-interval one 
			(add-interval 
				(div-interval one r1)
				(div-interval one r2)))))

(let* (
	(A (make-center-percent 10000 1))
	(B (make-center-percent 40000 4))
	(AA (div-interval A A))
	(AB (div-interval A B)))

	; Demonstrate Lem is right
	(assert 
		"Two different formulae will return different intervals with the same input" 
		(not (equal? (par1 A B) (par2 A B))))

	; investigate the behaviour on a variety of expressions
	; Make some intervals A and B and use thme in computing expressions A/A and A/B
	; most insight with small proportional errors 
	; examine result in center percent

	; (show "")
	; (show (str "A: " A "\tA%: " (percent A)))
	; (show (str "B: " B "\tB%: " (percent B)))

	; (show (str AA " (A/A)%: " (percent (div-interval A A)) " center(A/A): " (center AA) ))
	; (show (str AB " (A/B)%: " (percent AB) " center(A/B): " (center AB)))

	)




