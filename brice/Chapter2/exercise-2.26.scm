#lang racket
(require "../utils.scm")
(require "../meta.scm")

(title "Exercise 2.26")

(define x (list 1 2 3))
(define y (list 4 5 6))

(prn"Given 
	x := '(1 2 3)
	y := '(4 5 6)
")


(assert "(append x y) -> (1 2 3 4 5 6)" (equal? (append x y) '(1 2 3 4 5 6)))
(assert "(cons x y) -> ( (1 2 3) 4 5 6)" (equal? (cons x y) '( (1 2 3) 4 5 6)))
(assert "(list x y) -> ( (1 2 3) (4 5 6) )" (equal? (list x y) '( (1 2 3) (4 5 6))))