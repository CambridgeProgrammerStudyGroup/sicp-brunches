#lang racket
(require "../utils.scm")
(require "../meta.scm")
(require "exercise-2.7.scm")
(require "exercise-2.8.scm")
(require "exercise-2.9.scm")

(title "Exercise 2.10")
(provide (all-defined-out))

(define (div-interval A B)
	(cond ((< (lower-bound B) 0 (upper-bound B)) (error "IntervalException: Cannot divide by interval over 0.")))
	(mul-interval A
		(make-interval
			(/ 1.0 (upper-bound B))
			(/ 1.0 (lower-bound B)))))




(assert-raises-error "Expect Exception when dividing by interval spanning 0."
	(div-interval
		(make-interval 3 5)
		(make-interval -1 1)))
