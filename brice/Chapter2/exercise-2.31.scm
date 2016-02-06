#lang racket
(require "../utils.scm")
(require "../meta.scm")

(title "Exercise 2.31")


(define (tree-map fn tree)
	(define (mapper elem)
		(if (pair? elem)
			(tree-map fn elem)
			(fn elem)))
	(map mapper tree))

(let* (
	(A '(1 (2 (3 4) 5) (6 7)))
	(B '(1 (4 (9 16) 25) (36 49)))
	)
	(assert "tree-map works as expected" (equal? (tree-map square A) B))
)