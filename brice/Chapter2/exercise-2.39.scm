#lang racket
(require "../utils.scm")
(require "../meta.scm")

(title "Exercise 2.39")

(require "./exercise-2.38.scm")

; Exercise 2.39.   Complete the following definitions of reverse 
; (exercise 2.18) in terms of fold-right and fold-left from 
; exercise 2.38:

(define (reverse1 sequence)
  (foldr (lambda (x y) (append y (list x)) ) nil sequence))

(assertequal? "We can reverse a list with foldr"
	'(4 3 2 1) (reverse1 '(1 2 3 4)))

(define (reverse2 sequence)
  (fold-left (lambda (x y) (cons y x)) nil sequence))

(assertequal? "We can reverse a list with fold-left"
	'(4 3 2 1) (reverse2 '(1 2 3 4)))


