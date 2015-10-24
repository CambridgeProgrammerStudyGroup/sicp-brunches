#lang racket

(define (f n1 n2 n3)
  (cond [(and (< n1 n2) (< n1 n3))
         (+ (* n2 n2) (* n3 n3))]
        [(and (< n2 n1) (< n2 n3))
         (+ (* n1 n1) (* n3 n3))]
        [else (+ (* n1 n1) (* n2 n2))]))