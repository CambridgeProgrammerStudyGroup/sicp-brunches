#lang racket
(require "../utils.scm")

(title "Exercise 2.17")

(define (last xs)
	(if (null? (cdr xs))
		(car xs)
		(last (cdr xs))))

(let* ((L (list 1 2 3 4 5)))
	(asserteq "Last element can be recovered." (last L) 5))
