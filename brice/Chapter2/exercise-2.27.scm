#lang racket
(require "../utils.scm")
(require "../meta.scm")

(title "Exercise 2.27")

(define (reverse xs)
	(define (inner ret xs)
		(if (null? xs)
			ret
			(let* (
				(elem (car xs))
				(newelem (if (pair? elem) (reverse elem) elem)))
				(inner 
					(cons newelem ret) 
					(cdr xs)))))
	(inner '() xs))

(let* (
	(A '(1 2 3))
	(B '(3 2 1))
	(C '(1 2 (3 4) 5))
	(D '(5 (4 3) 2 1))
	(E '(1 (2 (3 4) 5) 6))
	(F '(6 (5 (4 3) 2) 1))
	(G '((1 2) (3 4)))
	(H '((4 3) (2 1)))
	)
	(assert "Deep reverse will reverse a normal list as expected" (equal? (reverse A) B))
	(assert "Deep reverse will reverse a nested list" (equal? (reverse C) D))
	(assert "Deep reverse will reverse deeply a nested list" (equal? (reverse E) F))
	(assert "Reverses all the elements in the list" (equal? (reverse G) H))

)