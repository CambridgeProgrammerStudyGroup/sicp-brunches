#lang racket
(require "../utils.scm")
(require "../meta.scm")

(title "Exercise 2.21")

(define (square-list-1 items)
  (if (null? items)
      '()
      (cons (* (first items) (first items)) (square-list-1 (rest items)))))

(define (square-list-2 items)
  (map (lambda (x) (* x x)) items))

(let* (
	(A '(1 2 3 4))
	(B '(1 4 9 16)))
	(assert "Naive squaring works" (equal? (square-list-1 A) B))
	(assert "Map squaring works" (equal? (square-list-2 A) B)))