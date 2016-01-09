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

(title "Exercise 2.15")

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


; Exercise 2.15.  Eva Lu Ator, another user, has also noticed the different intervals 
; computed by different but algebraically equivalent expressions. She says that a formula 
; to compute with intervals using Alyssa's system will produce tighter error bounds if it 
; can be written in such a form that no variable that represents an uncertain number is 
; repeated. Thus, she says, par2 is a ``better'' program for parallel resistances than 
; par1. Is she right? Why?

; Will a formala written without duplicate terms be better than one with?
; Is this general? Why?

(let* (
	(A (make-center-percent 1000 1))
	)

	(assert 
		"Center of an interval divided by itself is not one"
		(not (equal? (center (div-interval A A)) 1.0))))

(prn 
"
Firstly, we can show that the center of an inteval divided by itself 
is not 1.0. This means that when the same term is used multiple times in 
a formula, we can introduce bias to the result.

Secondly, because when two terms are multiplied or divided, the resulting 
error is greater than the individual errors, the error of a formula with 
a term appearing twice will be greater than if the term appears once.

This however, does not make sense from a physical point of view, as the error
for a quantity or measurment does not change because the measurment is used 
multiple times in a formula. 

Therefore, formula with the same term appearing twice will have a greater error
than the equivalent formula with the term appearing once, and the tighter error
will be the correct one.

")


