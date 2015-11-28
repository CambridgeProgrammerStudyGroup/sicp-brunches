#lang racket

(define (p) (p))
(define (test x y)
  (if (= x 0) 0 y))

(test 0 (p))

; applicative order
; will be infinite loop, because p will be evaluated first

; normal order
; will evaluate to 0, because p will be passed in without evaluation, using the substitution model