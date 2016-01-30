#lang racket
(require "../utils.scm")
(require "../meta.scm")

(title "Exercise 2.20")

(define (filter pred xs)
	(define (inner res ys)
		(if (empty? ys) 
			res
			(if (pred (first ys))
				(cons (first ys) (inner res (rest ys)))
				(inner res (rest ys)))))
	(inner '() xs))


(assert "Filtering on even works" (equal? (filter even? '(1 2 3 4 5 6)) '(2 4 6)))
(assert "Filtering on odds works" (equal? (filter odd? '(1 2 3 4 5 6)) '(1 3 5)))

(define (same-parity . xs)
	(let* 
		((elem (first xs))
		 (checker (if (even? elem) even? odd?)))
		(filter checker xs)))

(assert "same-parity works with even" (equal? (same-parity 1 2 3 4 5 6) '(1 3 5)))
(assert "same-parity works with odd" (equal? (same-parity 2 3 4 5 6) '(2 4 6)))