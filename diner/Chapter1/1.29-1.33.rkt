#lang racket

(define (square x) (* x x))
(define (cube x) (* x x x))
(define (inc x) (+ x 1))
(define (add2 x) (+ x 2))


(define (sum-integers a b)
  (if (> a b)
      0
      (+ (identity a) (sum-integers (+ a 1) b))))

;(sum-integers 1 6)

(define (sum-cubes a b)
  (if (> a b)
      0
      (+ (cube a) (sum-cubes (+ a 1) b))))

;(sum-cubes 1 3)

;Abstracting the function that is applied to each term as 'term'. Now, a procedure can be passed to this procedure that will work on each term
(define (sum-term term a b)
  (if (> a b)
      0
      (+ (term a) (sum-term term (+ a 1) b))))

;(sum-term identity 1 6)
;(sum-term cube 1 3)

;Now abstracting even more, by also being able to pass a procedure that calculates the next term. So it doesn't have to add one everytime
(define (sum term a next b)
  (if (> a b)
      0
      (+ (term a) (sum term (next a) next b))))

;(sum identity 1 inc 6)
;(sum cube 1 add2 10)


"Exercise 1.29"

(define (simpson function a b n)
  (define h (/ (- b a) n))
  (define (y k) (function (+ a (* k h))))
  (define (term k)
    (+
     (* 4 (y k))
     (* 2 (y (+ k 1)))))
  (* (/ h 3) (+ (y 0) (sum term 1 add2 (- n 2)) (y n))))

;(simpson cube 0.0 1.0 10000)

"Exercise 1.30"

(define (sum-iter term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (+ result (term a)))))
  (iter a 0))

;(sum-iter identity 1 inc 6)
;(sum-iter cube 1 inc 3)

"Exercise 1.31"
;a
(define (product term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (* result (term a)))))
  (iter a 1))

;(product identity 1 inc 4)

(define (factorial n)
  (product identity 1 inc n))

;(factorial 10)

(define (pi n)
  (define (term n)
     (cond ((odd? n) (/ (+ n 1) (+ n 2)))
           ((even? n) (/ (+ n 2)(+ n 1)))))
  (* (product term 1 inc n) 4.0))

;(pi 300)

;b
(define (product-recursive term a next b)
  (if (> a b)
      1
      (* (term a) (product-recursive term (next a) next b))))

(define (pi-recursive n)
  (define (term n)
     (cond ((odd? n) (/ (+ n 1) (+ n 2)))
           ((even? n) (/ (+ n 2)(+ n 1)))))
  (* (product-recursive term 1 inc n) 4.0))

;(pi-recursive 300)

"Exercise 1.32"
"a"
(define (accumulate combiner null-value term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (combiner result (term a)))))
  (iter a null-value))

(define (sum-general term a next b)
  (accumulate + 0 term a next b))

;(sum-general identity 1 inc 5)

(define (product-general term a next b)
  (accumulate * 1 term a next b))

;(product-general identity 1 inc 5)

"b"
(define (accumulate-recursive combiner null-value term a next b)
  (if (> a b)
      null-value
      (combiner (term a) (accumulate-recursive combiner null-value term (next a) next b))))

(define (sum-general-recur term a next b)
  (accumulate-recursive + 0 term a next b))

(sum-general-recur identity 0 inc 5)

"Exercise 1.33"
  
(define (filtered-accumulate filter? combiner null-value term a next b)
  (define (iter a result)
    (cond ((> a b) result)
          ((filter? a) (iter (next a) (combiner result (term a))))
          (else (iter (next a) result))))
  (iter a null-value))

"a"

;---------Prime stuff-------------------
(define (smallest-divisor n)
  (find-divisor n 2))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (next test-divisor)))))

(define (divides? a b)
  (= (remainder b a) 0))

(define (next n)
  (if (= n 2)
        3
        (+ n 2)))

(define (prime? n)
  (= n (smallest-divisor n)))
;---------End of Prime stuff------------------

(define (sum-of-squares-of-primes a b)
  (filtered-accumulate prime? + 0 square a inc b))

(sum-of-squares-of-primes 0 5)

"b"

(define (GCD a b)
  (if (= b 0)
      a
      (GCD b (remainder a b))))

(define (relative-prime? a b)
  (if (> (GCD a b) 1) #f
      #t))

(define (product-of-relative-prime-positive-integers-less-than-n n)
  (define (filter? i) (relative-prime? i n))
  (filtered-accumulate filter? * 1 identity 1 inc (- n 1)))

(product-of-relative-prime-positive-integers-less-than-n 12)
            