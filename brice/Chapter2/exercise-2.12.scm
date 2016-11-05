#lang racket
(require "../utils.scm")
(require "../meta.scm")

(require "exercise-2.7.scm")
(require "exercise-2.8.scm")
(require "exercise-2.9.scm")

(provide (all-defined-out))

(title "Exercise 2.12")
(define (make-center-percent c tol)
	(let ((delta (* c (/ tol 100))))
		(make-interval
			(- c delta)
			(+ c delta))))


(define (percent i)
	(* (/ (width i) (center i)) 100.0))


(define (center i)
	(/ (+ (upper-bound i) (lower-bound i)) 2))



(let ((A (make-center-percent 100 10))
	  (B (make-interval 90 110)))

	(asserteq "Center interval lower bound matches normal interval"
		(lower-bound A) (lower-bound B))
	(asserteq "Center interval upper bound matches normal inteval"
		(upper-bound A) (upper-bound B))
	(asserteq "We can get the percent from an interval"
		(percent B) 10)
	)
