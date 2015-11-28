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