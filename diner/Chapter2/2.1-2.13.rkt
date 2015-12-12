#lang racket

(define ^ 
  (lambda (x y) 
    (if (= y 0)
      1 
      (* x (^ x (- y 1))))))

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

(newline)
"Exercise 2.2"

(define (make-point x y) (cons x y))
(define (x-point p) (car p))
(define (y-point p) (cdr p))

(define (make-segment p1 p2)
  (cons p1 p2))
(define (start-segment s) (car s))
(define (end-segment s) (cdr s))

(define (midpoint-segment segment)
  (make-point (/ (+ (x-point (start-segment segment)) (x-point (end-segment segment))) 2)
              (/ (+ (y-point (start-segment segment)) (y-point (end-segment segment))) 2)))

(define (print-point p)
  (newline)
  (display "(")
  (display (x-point p))
  (display ",")
  (display (y-point p))
  (display ")"))


(define segment1 (make-segment (make-point 9 9) (make-point 3 3)))
(print-point (midpoint-segment segment1))

(newline)
"Exercise 2.3"

; Rectangle constructor that uses 2 opposite points. Other representations would take in inessential information
(define (make-rectangle p1 p2) (cons p1 p2))
(define (rect-width rect)
  (abs (- (x-point (car rect)) (x-point (cdr rect)))))
(define (rect-height rect)
  (abs (- (y-point (car rect)) (y-point (cdr rect)))))

(define (rect-perimeter rect)
  (* 2 (+ (rect-width rect) (rect-height rect))))
(define (rect-area rect)
  (* (rect-width rect) (rect-height rect)))

(define a (make-point 0 0))
(define b (make-point 2 10))
(define rect (make-rectangle a b))
(newline)
(display (rect-perimeter rect))
(newline)
(display (rect-area rect))

(newline)
"Exercise 2.4"

(define (cons2 x y)
  (lambda (m) (m x y)))

(define (car2 z)
  (z (lambda (p q) p)))
(define (cdr2 z)
  (z (lambda (p q) q)))



(define (make-point2 x y) (cons2 x y))

(define d (make-point2 2 10))
(car2 d)
(cdr2 d)

"Exercise 2.5"
(define (factor-count factor n)
  (if (= (remainder n factor) 0)
      (+ 1 (factor-count factor (/ n factor)))
      0))


(define (cons3 x y)
  (* (^ 2 x) (^ 3 y)))

(define (car3 z)
  (factor-count 2 z))
(define (cdr3 z)
  (factor-count 3 z))

(car3 (cons3 27 55))
(cdr3 (cons3 27 55))

"Exercise 2.6"
(define zero (lambda (f) (lambda (x) x)))

(define (add-1 n)
  (lambda (f) (lambda (x) (f ((n f) x)))))

(define one
  (lambda (f) (lambda (x) (f x))))

(define two
  (lambda (f) (lambda (x) (f (f x)))))

(define (f str) (string-append str "="))

(f "")
((two f) "")

(define (mult m n)
  (lambda (f) (m (n f))))
(define (exp m n)
  (lambda (f) ((m n) f)))
(define (add m n)
  (lambda (f) (lambda (x) ((m f) ((n f) x)))))

(((mult zero one) f) "")
(((mult one one) f) "")
(((mult two one) f) "")
(((mult one two) f) "")
(((mult (mult two two) (mult two two)) f) "")

(((add zero one) f) "")
(((add one one) f) "")
(((add two one) f) "")
(((add one two) f) "")
(((add (add two two) (add two two)) f) "")

;-------------------------------------------------

(define (add-interval x y)
  (make-interval (+ (lower-bound x) (lower-bound y))
                 (+ (upper-bound x) (upper-bound y))))

(define (mul-interval x y)
  (let ((p1 (* (lower-bound x) (lower-bound y)))
        (p2 (* (lower-bound x) (upper-bound y)))
        (p3 (* (upper-bound x) (lower-bound y)))
        (p4 (* (upper-bound x) (upper-bound y))))
    (make-interval (min p1 p2 p3 p4)
                   (max p1 p2 p3 p4))))

(define (div-interval x y)
  (cond ((= (- (upper-bound x) (lower-bound x)) 0) (display "Invalid input"))
        ((= (- (upper-bound y) (lower-bound y)) 0) (display "Invalid input"))
        (else (mul-interval x
                (make-interval (/ 1.0 (upper-bound y))
                               (/ 1.0 (lower-bound y)))))))


"Exercise 2.7"

(define (make-interval a b) (cons a b))
(define (upper-bound x) (cdr x))
(define (lower-bound x) (car x))

"Exercise 2.8"

(define (sub-interval x y)
  (make-interval (+ (lower-bound x) (- (lower-bound y)))
                 (+ (upper-bound x) (- (upper-bound y)))))

(define interval1 (make-interval 5 11))
(define interval2 (make-interval 7 11))
(add-interval interval1 interval2)
(sub-interval interval1 interval2)

"Exercise 2.9"

(define (width-of-interval x)
  (/ (- (upper-bound x) (lower-bound x)) 2))

(define width1 (width-of-interval interval1))
(define width2 (width-of-interval interval2))
; The following two are equal, therefore proving that the width of the sum of two intervals is a function only of the widths of the intervals being added
(+ width1 width2)
(/ (- (+ (upper-bound interval1) (upper-bound interval2))
      (+ (lower-bound interval1) (lower-bound interval2))) 2)

; And the following two are NOT equal, therefore proving that the above isn't true for multiplication
(* width1 width2)
(/ (- (* (upper-bound interval1) (upper-bound interval2))
      (* (lower-bound interval1) (lower-bound interval2))) 2)

"Exercise 2.10"

(define interval-zero (make-interval 0 0))
;(div-interval interval1 interval-zero)

(newline)
"Exercise 2.11"

(define (mul-interval2 x y)
  (let ((xlo (lower-bound x))
        (xhi (upper-bound x))
        (ylo (lower-bound y))
        (yhi (upper-bound y)))
  (cond ((and (>= xlo 0)
              (>= xhi 0)
              (>= ylo 0)
              (>= yhi 0))
        (make-interval (* xlo ylo) (* xhi yhi)))
        ((and (>= xlo 0)
              (>= xhi 0)
              (<= ylo 0)
              (>= yhi 0))
        (make-interval (* xhi ylo) (* xhi yhi)))
        ((and (>= xlo 0)
              (>= xhi 0)
              (<= ylo 0)
              (<= yhi 0))
        (make-interval (* xhi ylo) (* xlo yhi)))
        ((and (<= xlo 0)
              (>= xhi 0)
              (>= ylo 0)
              (>= yhi 0))
        (make-interval (* xlo yhi) (* xhi yhi)))
        ((and (<= xlo 0)
              (>= xhi 0)
              (<= ylo 0)
              (>= yhi 0))
        (make-interval (min (* xhi ylo) (* xlo yhi))
                       (max (* xlo ylo) (* xhi yhi))))
        ((and (<= xlo 0)
              (>= xhi 0)
              (<= ylo 0)
              (<= yhi 0))
        (make-interval (* xhi ylo) (* xlo ylo)))
        ((and (<= xlo 0)
              (<= xhi 0)
              (>= ylo 0)
              (>= yhi 0))
        (make-interval (* xlo yhi) (* xhi ylo)))
        ((and (<= xlo 0)
              (<= xhi 0)
              (<= ylo 0)
              (>= yhi 0))
        (make-interval (* xlo yhi) (* xlo ylo)))
        ((and (<= xlo 0)
              (<= xhi 0)
              (<= ylo 0)
              (<= yhi 0))
        (make-interval (* xhi yhi) (* xlo ylo))))))

  
(define interval-to-mul-1 (make-interval 2 3))
(define interval-to-mul-2 (make-interval 3 4))
(mul-interval2 interval-to-mul-1 interval-to-mul-2)



(define (make-center-width c w)
  (make-interval (- c w) (+ c w)))

(define (center i)
  (/ (+ (lower-bound i) (upper-bound i)) 2))

(define (width i)
  (/ (- (upper-bound i) (lower-bound i)) 2))

(newline)
"Exercise 2.12"

(define (make-center-percent c wp)
  (make-interval (- c (* (/ wp 100) c)) (+ c (* (/ wp 100) c))))

(define interval-with-percentage (make-center-percent 5.0 10.0))
(lower-bound interval-with-percentage)
(upper-bound interval-with-percentage)

(define (percent i)
  (/ (- (center i) (lower-bound i)) (center i)))

(percent interval-with-percentage)

(newline)
"Exercise 2.13"

(define (par1 r1 r2)
  (div-interval (mul-interval r1 r2)
                (add-interval r1 r2)))

(define (par2 r1 r2)
  (let ((one (make-interval 1 1)))
    (div-interval one
                  (add-interval (div-interval (div-interval one r1)
                                              (div-interval one r2))))))

(define par-res1 (par1 interval1 interval2))
(lower-bound par-res1)
(upper-bound par-res1)

(define par-res2 (par2 interval1 interval2))
(lower-bound par-res2)
(upper-bound par-res2)

