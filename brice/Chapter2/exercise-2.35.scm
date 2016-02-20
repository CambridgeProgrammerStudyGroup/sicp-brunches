#lang racket
(require "../utils.scm")
(require "../meta.scm")

(title "Exercise 2.35")

; Exercise 2.35.  Redefine count-leaves from section 2.2.2 as an accumulation:

(define (count-leaves tree)
  (foldr (lambda (x y) (inc y)) 0 
  	(map (lambda (elem)) tree)))