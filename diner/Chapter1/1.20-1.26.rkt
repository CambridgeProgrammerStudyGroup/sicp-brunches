#lang racket

"Exercises 1.21 - 1.24"

(define (smallest-divisor n)
  (find-divisor n 2))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (next test-divisor)))))

(define (divides? a b)
  (= (remainder b a) 0))

(define (square n) (* n 2))

(define (next n)
  (if (= n 2)
        3
        (+ n 2)))

(define (prime? n)
  (= n (smallest-divisor n)))

;(smallest-divisor 199)
;(smallest-divisor 1999)
;(smallest-divisor 19999)

"Exercise 1.22"

;Expmod with O(log(n))
(define (expmod base exp m)
  (remainder (fast-exp base exp) m))

(define (fast-exp b n) (fast-exp-iter b n 1))

(define (fast-exp-iter b n a)
  (if (= n 0) a
                                  (fast-exp-iter (* b b)
                                                 (quotient n 2)
                                                 (*
                                                  (if (odd? n) b 1)
                                                  a))))

;Expmod with O(n)
(define (expmod2 base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder (* (expmod2 base (/ exp 2) m)
                       (expmod2 base (/ exp 2) m))
                    m))
        (else
         (remainder (* base (expmod2 base (- exp 1) m))
                    m))))

(define (fermat-test-single-number a n)
  (= (expmod2 a n n) a))

(define (fermat-test n)
  (define (try-it a)
    (= (expmod a n n) a))
  (try-it (+ 1 (random (- n 1)))))


(define (fast-prime? n times)
  (cond ((= times 0) true)
        ((fermat-test n) (fast-prime? n (- times 1)))
        (else false)))

"Exercise 1.27"

;Test for Carmichael numbers

(define (carmichael-test? n current)
  (cond
    ((>= current n) true)
    ((not (fermat-test-single-number current n)) false)
    (else (carmichael-test? n (+ 1 current)))))

;(fermat-test-single-number 4 12)
(fast-prime? 561 10)
(carmichael-test? 560 1)
(carmichael-test? 561 1)
(carmichael-test? 571 1)

(define (timed-prime-test n)
  (newline)
  (display n)
  (start-prime-test n (current-inexact-milliseconds)))

(define (start-prime-test n start-time)
  (cond ((fast-prime? n 20)
      (report-prime (- (current-inexact-milliseconds) start-time)))))

(define (report-prime elapsed-time)
  (display " *** ")
  (display elapsed-time))

;(timed-prime-test 9)

(define (search-for-primes start end)
  (if (even? start)
      (search-for-primes (+ start 1) end)
      (cond ((< start end) (timed-prime-test start)
                           (search-for-primes (+ start 2) end)))))

;(search-for-primes 10000 11000)

;(fast-prime? 561 100)
;(fast-prime? 1105 100)
;(fast-prime? 1729 100)
;(fast-prime? 2465 100)
;(fast-prime? 2821 100)
;(fast-prime? 6601 100)

;(prime? 561)
;(prime? 1105)
;(prime? 1729)
;(prime? 2465)
;(prime? 2821)
;(prime? 6601)