#lang racket

(require "../utils.scm")

;; Naive primality testing
(define (smallest-divisor n)
  (find-divisor n 2))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (inc test-divisor)))))

(define (divides? a b)
  (= (remainder b a) 0))

(define (prime? n)
  (= n (smallest-divisor n)))

; Excercise 1.21
; Find smallest divisor of 199, 1999, 19999

(smallest-divisor 199) ;-> 199 (prime)
(smallest-divisor 1999) ;-> 1999 (prime)
(smallest-divisor 19999) ;-> 7 (not prime)
