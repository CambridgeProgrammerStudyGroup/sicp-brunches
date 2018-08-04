#lang racket

; Exercise 1.1

(define a 3)
(define b (+ a 1))

(cond ((= a 3) 6)
      ((= b 4) (+ 6 7 a))
      (else 25))

(if (and (> b a) (< b (* a b)))
    b
    a)