#lang racket

;; recursive
(define (f n)
  (if (< n 3)
      n
      (+ (f (- n 1))
         (* 2 (f (- n 2)))
         (* 3 (f (- n 3))))))

;; iterative
(define (fn n)
  (if (< n 3)
      n
      (helper 2 1 0 n)))

(define (helper a b c n)
  (if (< n 3)
      a
      (helper (+ a (* 2 b) (* 3 c)) a b (- n 1))))