#lang racket
(require "../utils.scm")
(require "../meta.scm")
(require "exercise-2.7.scm")

(title "Exercise 2.8")
(provide (all-defined-out))

(define (sub-interval a b)
	(make-interval
		(- (lower-bound a) (upper-bound b))
		(- (upper-bound a) (lower-bound b))))

(define TEST-NUM-A (make-interval 3 6))
(define TEST-NUM-B (make-interval 8 13))

(asserteq "Subtracting an interval gives the right lower bound"
	(lower-bound (sub-interval TEST-NUM-B TEST-NUM-A)) 2)

(asserteq "Subtracting an interval gives the right upper bound"
	(upper-bound (sub-interval TEST-NUM-B TEST-NUM-A)) 10)
