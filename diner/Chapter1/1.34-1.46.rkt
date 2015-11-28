#lang racket

(define (square x) (* x x))
(define (average x y) (/ (+ x y) 2))
(define (inc x) (+ x 1))

"Exercise 1.34"

(define (f g)
  (g 2))

;(f square)
;(f (lambda (z) (* z (+ z 1))))
;(f f)

; Section 1.3.3

(define (close-enough? x y)
  (< (abs (- x y)) 0.001))

(define (search f neg-point pos-point)
  (let ((midpoint (average neg-point pos-point)))
    (if (close-enough? neg-point pos-point)
      midpoint
      (let ((test-value (f midpoint)))
        (cond ((positive? test-value)
                (search f neg-point midpoint))
              ((negative? test-value)
                (search f midpoint pos-point))
              (else midpoint))))))

(define (half-interval-method f a b)
  (let ((a-value (f a))
        (b-value (f b)))
    (cond ((and (negative? a-value) (positive? b-value))
           (search f a b))
          ((and (negative? b-value) (positive? a-value))
           (search f b a))
          (else
           (error "Values are not of opposite sign" a b)))))

;(half-interval-method sin 2.0 4.0)

;(half-interval-method (lambda (x) (- (* x x x) (* 2 x) 3))
                      ;1.0
                      ;2.0)

; Finding fixed points of functions

(define tolerance 0.00001)

(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) tolerance))
  (define (try guess)
    ;(newline)
    ;(display guess)
    (let ((next (f guess)))
      (if (close-enough? guess next)
          next
          (try next))))
  (try first-guess))

;(fixed-point cos 1.0)

(define (sqrt x)
  (fixed-point (lambda (y) (average y (/ x y)))
               1.0))

;(sqrt 4)

"Exercise 1.35"

(define (golden-ratio)
  (fixed-point (lambda (x) (+ 1 (/ 1 x))) 1.0))
;(golden-ratio)

"Exercise 1.36"

;(fixed-point (lambda (x) (/ (log 1000) (log x))) 2)

"Exercise 1.37"
; a
(define (cont-frac-recur n d k)
  (define (recur i)
    (if (= i k)
        (/ (n i) (d i))
        (/ (n i) (+ (d i) (recur (+ i 1))))))
  (recur 1))

;(cont-frac-recur (lambda (i) 1.0)
;                 (lambda (i) 1.0)
;                 100)

; b
(define (cont-frac-iter n d k)
  (define (iter i nextInSeq)
    (if (= i 1)
        (/ (n i) (+ (d i) nextInSeq))
        (iter (- i 1) (/ (n i) (+ (d i) nextInSeq)))))
  (iter k 0))

;(cont-frac-iter (lambda (i) 1.0)
;                (lambda (i) 1.0)
;                100)

"Exercise 1.38"

(cont-frac-iter (lambda (i) 1.0)
                (lambda (i)
                  (let ((numToTest (+ i 1)))
                    (if (= 0 (remainder numToTest 3))
                        (* (/ numToTest 3) 2)
                        1.0
                        )))
                1000)



"Exercise 1.39"

(define (tan-cf x k)
  (cont-frac-iter (lambda (i)
                    (if (= i 1)
                      x
                      (- (square x))))
                  (lambda (i) (- (* i 2) 1))
                  k))

(tan-cf 0.5 1000)
                    

"Exercise 1.40"

(define dx 0.00001)

(define (deriv g)
  (lambda (x)
    (/ (- (g (+ x dx)) (g x))
       dx)))

(define (newton-transform g)
  (lambda (x)
    (- x (/ (g x) ((deriv g) x)))))

(define (newtons-method g guess)
  (fixed-point (newton-transform g) guess))

(define (cube x) (* x x x))

((deriv cube) 5)

(define (cubic a b c)
  (lambda (x)
    (+ (cube x) (* a (square x)) (* b x) c)))

(newtons-method (cubic 1 1 1) 1)


"Exercise 1.41"

(define (double f)
  (lambda (x)
    (f (f x))))

; Here, (double double) makes a function run 4 times. So calling it again with double makes the function that runs 4 times run 4 times, so 16 times. It's increasing exponentially.
(((double (double double)) inc) 5)

"Exercise 1.42"

(define (compose f1 f2)
  (lambda (x)
    (f1 (f2 x))))

((compose square inc) 6)

"Exercise 1.43"

(define (repeated f count)
  (if (= count 1)
      (lambda (x)
        (f x))
      (compose f (repeated f (- count 1)))))

((repeated square 2) 5)

"Exercise 1.44"

(define (smooth f)
  (lambda (x)
    (/ (+ (f (- x dx)) (f x) (f (+ x dx))) 3)))

((smooth square) 4)
(((repeated smooth 10) square) 5)

"Exercise 1.45"

(define (average-damp f)
  (lambda (x) (average x (f x))))

(define (root x smooth-count)
  (fixed-point
   ((repeated average-damp smooth-count) (lambda (y) (/ x y)))
   5.0))

(define (cube-root x smooth-count)
  (fixed-point
   ((repeated average-damp smooth-count) (lambda (y) (/ x (square y))))
   3.0))

(define (fourth-root x smooth-count)
  (fixed-point
   ((repeated average-damp smooth-count) (lambda (y) (/ x (expt y 3))))
   3.0))

(define (nth-root x n)
  (fixed-point
   ((repeated average-damp (ceiling (expt n 0.5))) (lambda (y) (/ x (expt y (- n 1)))))
   3.0))

(root 9 1)
(cube-root 81 1)
(fourth-root 6561 2)
(nth-root 6561 2)
(nth-root 81 2)

"Exercise 1.46"

(define (iterative-improve good-enough? improve)
  (define (iter-imp guess)
    (if (good-enough? guess)
        guess
        (iter-imp (improve guess))))
  iter-imp)

(define (sqrt2 x)
  ((iterative-improve (lambda (guess)
                        (< (abs (- (square guess) x))
                           0.001))
                      (lambda (guess)
                        (average guess (/ x guess))))
   1.0))

(sqrt2 16)

(define (fixed-point2 f first-guess)
   ((iterative-improve (lambda (guess)
                         (< (abs (- (f guess) guess))
                            0.00001))
                       (lambda (guess)
                         (f guess)))
    first-guess))

(fixed-point2 (lambda (x) (+ 1 (/ 1 x))) 2.0)