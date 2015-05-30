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

; sqrt-iter-alt will never return.
; 
; Because even when the predicate is true, the 
; else-clause will be evaluated unnecessarily 
  
