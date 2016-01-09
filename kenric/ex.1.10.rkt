#lang racket

(define (A x y)
  (cond ((= y 0) 0)
        ((= x 0) (* 2 y))
        ((= y 1) 2)
        (else (A (- x 1) (A x (- y 1))))))

; (A 1 10) 1024
; (A 2 4) 65536
; (A 3 3) 65536

(A 2 n)
(A 1 (A 2 (- n 1)))
(A 1 (A 1 (A 2 (- (- n 1) 1))))
(A 0 (A 1 (A 2 (- n 2)) (A 1 (A 2 (- n 2)))))

#|
                         | 0  if n = 0
(define (f n) (A 0 n)) = | 2  if n = 1
                         | 2n if n > 1

                         | 0 if n = 0
(define (g n) (A 1 n)) = | 2^n if n > 0

                         | 0 if n = 0
(define (h n) (A 2 n)) = | 2 if n = 1
                         | Knuth's up arrow notation  if n > 1
|#