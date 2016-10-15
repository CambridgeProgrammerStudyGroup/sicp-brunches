#lang racket
(require "../utils.scm")
(require "../meta.scm")


(provide (all-defined-out))

(title "Exercise 2.7")

(define (make-interval a b) (cons a b))
(define (lower-bound i) (car i))
(define (upper-bound i) (cdr i))

(define TEST-INTERVAL (make-interval 1 2))

(asserteq "We can get the upper bound" (upper-bound TEST-INTERVAL) 2)
(asserteq "We can get the lower bound" (lower-bound TEST-INTERVAL) 1)
