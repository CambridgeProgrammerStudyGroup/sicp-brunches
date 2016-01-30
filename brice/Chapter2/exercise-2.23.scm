#lang racket
(require "../utils.scm")
(require "../meta.scm")

(title "Exercise 2.23")

(define (for-each-1 fn xs)
	(map fn xs)
	nil)

(define (for-each-2	fn xs)
	(if (empty? xs)
		nil
		(and
			(fn (first xs))
			(for-each-2 fn (rest xs)))))

(let* (
	(A '(1 2 3 4))
	(c1 0)
	(c2 0)
	(fn1 (lambda (x) (set! c1 (inc c1)) 123))
	(fn2 (lambda (x) (set! c2 (inc c2)) 123))
	(res1 (for-each-1 fn1 A))
	(res2 (for-each-2 fn2 A)))

(assert "foreach with map return nothing" (equal? res1 nil))
(assert "foreach with map runs side effects" (not (equal? c1 0)))

(assert "Recursive foreach return nothing" (equal? res2 nil))
(assert "Recursive foreach runs side effects" (not (equal? c2 0)))
)