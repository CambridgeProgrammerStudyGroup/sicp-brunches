#lang racket

; Newton square root

(define (sqrt-iter guess x)
    (if (good-enough? guess x)
        guess
        (sqrt-iter (improve guess x)
        x)))

(define (good-enough? guess x)
    (< (abs (- (square guess) x)) 0.001))

(define (abs x)
    (cond ((> x 0) x)
          ((< x 0) (- x))
          ((= x 0) 0))
)

(define (improve guess x)
    (average guess (/ x guess)))

(define (average x y)
    (/ (+ x y) 2))

(define (square x)
    (* x x)
)

(sqrt-iter 1 2)