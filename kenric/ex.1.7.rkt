#lang racket

(define (square x)
  (* x x))

(define (improve guess x)
  (average guess (/ x guess)))

(define (average x y)
  (/ (+ x y) 2))

(define (good-enough? guess x)
  (< (abs (- (square guess) x)) (* x 0.001)))

(define (sqrt-iter guess x)
  (if (good-enough? guess x)
      guess
      (sqrt-iter (improve guess x) x)))

; For very small numbers, the difference between the square of the guess compared
; to the radicand would easily be under the threshold of 0.001.  This is because
; square of numbers less than one would yield a smaller output compared to input

; For very large numbers, a large number of iterations needed to get below the hard coded
; threshold, and machine doesn't have enough precision to work out small differences
; between large numbers