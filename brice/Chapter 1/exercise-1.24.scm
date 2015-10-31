;; Excercise 1.24


;(search-for-primes (timed-test (lambda (x) (fast-prime? x 10))) 1000 1000000 3)
; Average test time (fast-prime?): 0.0166015625 ms

;(search-for-primes (timed-test (lambda (x) (fast-prime? x 10))) 10000 1000000 3)
; Average test time (fast-prime?): 0.020345052083333332 ms

;(search-for-primes (timed-test (lambda (x) (fast-prime? x 10))) 100000 1000000 3)
; Average test time (fast-prime?): 0.023274739583333332 ms

;(search-for-primes (timed-test (lambda (x) (fast-prime? x 10))) 1000000 10000000 3)
; Average test time (fast-prime?): 0.025960286458333332 ms

