#lang racket

(define (make-rat n d)
  (let ((g (gcd n d)))
    (if (or (and (< n 0) (> d 0)) (and (> n 0) (< d 0)))
          (cons (/ (- n) g) (/ (abs d) (abs g)))
          (cons (/ n g) (/ d g)))))

(define (numer x) (car x))
(define (denom x) (cdr x))

; Greatest Common Divisor
(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))

(define (print-rat x)
  (newline)
  (display (numer x))
  (display "/")
  (display (denom x)))

(define (add-rat x y)
  (make-rat (+ (* (numer x) (denom y))
               (* (numer y) (denom x)))
            (* (denom x) (denom y))))

(define (sub-rat x y)
  (make-rat (- (* (numer x) (denom y))
               (* (numer y) (denom x)))
            (* (denom x) (denom y))))

(define (mul-rat x y)
  (make-rat (* (numer x) (numer y))
            (* (denom x) (denom y))))

(define (div-rat x y)
  (make-rat (* (numer x) (denom y))
            (* (denom x) (numer y))))

(define (equal-rat? x y)
  (= (* (numer x) (denom y))
     (* (numer y) (denom x))))


(define one-half (make-rat 1 2))
(define one-third (make-rat 1 3))

;(print-rat one-half)
;(print-rat one-third)
;(print-rat (add-rat one-third one-third))

"Exercise 2.1"

(define minus-one-half (make-rat -1 2))
(print-rat minus-one-half)