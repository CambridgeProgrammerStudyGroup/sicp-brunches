#lang racket
(require "../utils.scm")
(require "../meta.scm")

(title "Exercise 2.30")

; Exercise 2.30: Define a procedure square-tree analogous
; to the square-list procedure of Exercise 2.21. That is, 
; square-tree should behave as follows:
;
;     (square-tree
;		(list 1 (list 2 (list 3 4) 5) (list 6 7)))
;     
;      => (1 (4 (9 16) 25) (36 49))
;
; Define square-tree both directly (i.e., without using any 
; higher-order procedures) and also by using map and recursion.

(define (square-tree-direct tree)
	(define (inner newtree tree)
		(if (empty? tree)
			newtree
			(let* (
				(elem (car tree))
				(selem (if (pair? elem) (square-tree-direct elem) (* elem elem)))
				)
				(cons selem (square-tree-direct (cdr tree))))))
	(inner '() tree))


(define (map-tree fn tree)
	(define (mapper elem)
		(if (pair? elem)
			(map-tree fn elem)
			(fn elem)))
	(map mapper tree))


(define (square-tree-map tree)
	(map-tree (lambda (x) (* x x)) tree))



(let* (
	(A '(1 (2 (3 4) 5) (6 7)))
	(B '(1 (4 (9 16) 25) (36 49)))
	)
	(assert "square-tree-direct works as expected" (equal? (square-tree-direct A) B))
	(assert "square-tree-map works as expected" (equal? (square-tree-map A) B))
)