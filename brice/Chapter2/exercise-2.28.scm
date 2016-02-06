#lang racket
(require "../utils.scm")
(require "../meta.scm")

(title "Exercise 2.28")


(define (fringe tree)
	(define (inner leafs tree)
		(if (empty? tree)
			leafs
			(let* ( 
				(elem (car tree))
				(newleafs (if (pair? elem) (fringe elem) (list elem)))
				)
				(inner (append leafs newleafs) (cdr tree)))))
	(inner '() tree))

(let* (
	(A '(1 2 3 4))
	(B '((1 2) (3 4)))
	(fB '(1 2 3 4))
	(C (list A A))
	(fC '(1 2 3 4 1 2 3 4))
	)
	(assert "Fringes of a flat list are the elements" (equal? (fringe A) A))
	(assert "Fringes of a singly nested list are extracted" (equal? (fringe B) fB))	
	(assert "Fringes of a deeply nested list are extracted" (equal? (fringe C) fC))	
)
