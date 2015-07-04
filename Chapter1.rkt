#lang racket

; Exercise 1.1

10
; 10

(+ 5 3 4)
; 12

(- 9 1)
; 8

(/ 6 2)
; 3

(+ (* 2 4) (- 4 6))
; 6

(define a 3)

a
; 3

(define  b (+ a 1))

b
; 4

(+ a b (* a b))
; 19

(= a b)
; #f

(if (and (> b a) (< b (* a b))) b a)
; 4

(cond ((= a 4) 6)
        ((= b 4) (+ 6 7 a))
        (else 25))
16

(+ 2 (if (> b a) b a))
; 6

(* (cond ((> a b) a)
           ((< b a) b)
           (else -1)) (+ a 1))
; -4

(* (cond ((> a b) a)
           ((< a b) b)
           (else -1)) (+ a 1))
; 16


; Exercise 1.2
(/ (+ 5 4 (- 2 (- 3 (+ 6 (/ 4 5))))) 
   (* 3 (- 6 2) (- 2 7)))

; Exercise 1.3
(define (square x)
  (* x x))

(define (sum-square x y)
  (+ (square x) (square y)))

(define (sum-square-max x y z) 
  (cond ((> x y z) (sum-square x y))
        ((< x y z) (sum-square y z))
        (else (sum-square x z))))

(define (assert-eq expected actual)
  (cond ((= expected actual) (display "."))
        (else (display "F"))))

(assert-eq 13 (sum-square-max 1 2 3))
(assert-eq 18 (sum-square-max 3 2 3))
(assert-eq 13 (sum-square-max 3 2 1))
(assert-eq 18 (sum-square-max 3 3 3))
(display "\n")

; Exercise 1.4
(define (a-plus-abs-b a b)
  ((if (> b 0) + -) a b))

; eg a = 3 b = 4, then function returns 7 (a + b)
; eg a = 3 b = -4, then function returns 7 also (a - (-b)).

; Exercise 1.5
(define (p) (p))

(define (test-1.5 x y)
  (if (= x 0)
      0
      y))

; (test 0 (p))

; Expected outcome is return 0 if language is normal order evalution, and to never return if 
; applicative order evaluation.

; NORMAL order case
;      .          
;     /|\
;    / | \
;   /  |  \ 
; test 0   .
;          |
;          p
;
;
;      .___      
;     /|\  \_    
;    / | \   \_  
;   /  |  \    \ 
; if   .   0   . 
;     /|\      | 
;    = 0 0     p  
;
;
;
;      .___      
;     /|\  \_    
;    / | \   \_  
;   /  |  \    \ 
; if   #T  0   . 
;              | 
;              p  
;
;
;     .
;     |
;     0
;
;
; APPLICATIVE order case
;
;   .__
;   |\ \ 
;   | \ \
;   |  \ \
; test  0 .
;         |
;         p
; 
; 
;   .__
;   |\ \ 
;   | \ \
;   |  \ \
; test  0 .
;         |
;         .
;         |
;         p
; 
;   .__
;   |\ \ 
;   | \ \
;   |  \ \
; test  0 .
;         |
;         .
;         |
;         .
;         |
;         p
; 
;  And so on...
;
; Racket scheme is applicative-order :)


; Exercise 1.6
(define (average x y)
  (/ (+ x y) 2))

(define (good-enough? guess x)
  (< (abs (- (square guess) x)) 0.001))

(define (improve guess x)
  (average guess (/ x guess)))


(define (new-if predicate then-clause else-clause)
  (cond (predicate then-clause)
        (else else-clause)))

(assert-eq 5 (new-if (= 2 3) 0 5)) ;-> 5
(assert-eq 0 (new-if (= 1 1) 0 5)) ;-> 0


(define (sqrt-iter-alt guess x)
  (new-if (good-enough? guess x) guess
          (sqrt-iter-alt (improve guess x) x)))

; sqrt-iter-alt will never return: even when the
; predicate is true, the else-clause will be evaluated
; unnecessarily.

; Exercise 1.7
(define (sqrt-iter guess x)
  (if (good-enough? guess x) guess
          (sqrt-iter (improve guess x) x)))

; Statement: `good-enough?` will not be very effective 
;            for the root of small numbers
;
; Reasoning: Root will be smaller or close to the order of 
;            the threshold in the test, which means that the 
;            `good-enough?` function will return true prematurely.
;            For example:

(sqrt-iter 0.0001 0.0004) ;-> 0.0001

;
; Statement: Real calculations are almost always performed with 
;            limited precision
;
; Reasoning: We are usually limited by the register size of the 
;            floating point unit in the processor. Performing 
;            arbitrary precision calculation is expensive.
; 
; Statement: The `good-enough?` test is inadequate for large numbers.
; 
; Reasoning: The `improve` function will improve the guess to a limited 
;            precision inherent to the divide operation (depending on 
;            platform, etc...).
;            If the precision of the improvement is below the threshold 
;            of the `good-enough?` test, then a new improvement will be 
;            attempted. The precision of this will also be below the
;            threshold of the `good-enough?` test, causing infinite 
;            recursion. 
(define THRESHOLD 0.001)

; Old test relies on the answer being within THRESHOLD of the solution
(define (original-good-enough? previous-guess guess x)
  (< (abs (- (square guess) x)) THRESHOLD))

; New test relies on the difference between the previous and current  
; guess being a very small fraction of the current guess (less than THRESHOLD)
(define (new-good-enough? previous-guess guess x)
  (< (/ (abs (- previous-guess guess)) guess) THRESHOLD))

; For some reason, this alternative version of `good-enough?` seems to 
; give better results for small roots.
; For example, 
;
;     (new-sqrt-iter new-good-enough? 0 1 9e-4)         ;-> 0.030000012746348552
;     (new-sqrt-iter alternative-good-enough? 0 1 9e-4) ;-> 0.030000000000002705
; 
; This is due to the fact that the alternative function iterates one more
; than the new function. This can be seen by instrumenting the `new-sqrt-iter` 
; function with the following code: 
;
;     (printf "[~a] old: ~a new: ~a\n" x old-guess guess)
;
; and looking at the iteration sequence for both test functions
(define (alternative-good-enough? previous-guess guess x)
  (< (/ (abs (- previous-guess guess)) x) THRESHOLD))

(define (new-sqrt-iter end-predicate old-guess guess x)
  ;(printf "[~a] old: ~a new: ~a\n" x old-guess guess)
  (if (end-predicate old-guess guess x) guess
          (new-sqrt-iter end-predicate guess (improve guess x) x)))

; However, the `alternative-good-enough?` function fails for 
; large numbers as the fractional guess difference becomes small 
; relative to the x value and the function returns true too early.


; With the original `good-enough?` function, we get incorrect results
; for small numbers, however the `new-good-enough?` function returns the 
; correct values.
;
;     (new-sqrt-iter original-good-enough? 0 1 4e-4) ;-> 0.0354008825558513
;     (new-sqrt-iter new-good-enough? 0 1 4e-4)      ;-> 0.02
;
; For large numbers the new predicate will give worse results, as the 
; relative difference of the guesses is used to stop the iteration, and this 
; will lead to reduced absolute accuracy compared to using a fixed test to 
; stop the iteration.

; Exercise 1.8: 

(define (cube-root-improve y x)
  (/ (+ (/ x (* y y)) (* 2 y)) 3.0))

; define generic function which takes an improver function 'improve'
; and a test function 'test?' whcih checks if the iteration is sufficiently good.
; the 'test?' function must be of the form:
; 
;     (test? <previous-guess> <current-guess> original value)
; 
; and return a boolean value.
(define (iterator improve test? prev-guess curr-guess x)
  (if (test? prev-guess curr-guess x) curr-guess
          (iterator improve test? curr-guess (improve curr-guess x) x)))
