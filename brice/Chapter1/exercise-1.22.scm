;; Naive primality testing
(define (smallest-divisor n)
  (find-divisor n 2))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (inc test-divisor)))))

(define (divides? a b)
  (= (remainder b a) 0))

(define (prime? n)
  (= n (smallest-divisor n)))

; Fermat's little theorem

; take integer a < n 
; The following holds if n is prime:
;     (a^n) % n = (a) % n

; We can use Fermat's little theorem to create a probabilistic algorithm 
; that tests for primality. While it does not guarantee primality, it has
; very good likelyhood of being correct. Numbers 'n' that fool this primality 
; test by meeting the criteria for Fermat's little theorem for all integers 
; less than 'n' are called Carmichael numbers and are very rare in practice.
; (in practice rarer than the likelyhood of radiation causing a miscomputation
; when dealing with very large numbers.)

;; We'll define the 'fast-prime?' probabilistic method as follow:

(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder (square (expmod base (/ exp 2) m)) ; a^n = a x a ^(n-1)
                    m))
        (else
         (remainder (* base (expmod base (- exp 1) m)) ; a^n = (a^(n/2))^2
                    m))))        

(define (fermat-test n)
  (define (try-it a)
    (= (expmod a n n) a))
  (try-it (+ 1 (random (- n 1)))))

(define (fast-prime? n times)
  (cond ((= times 0) true)
        ((fermat-test n) (fast-prime? n (- times 1)))
        (else false)))



; Excercise 1.22

; Timing code.
(define runtime current-inexact-milliseconds)

(define (timed-prime-test n)
  (newline)
  (display n)
  (start-prime-test n (runtime)))

(define (start-prime-test n start-time)
  (cond ((prime? n) (report-prime (- (runtime) start-time)))))

(define (report-prime elapsed-time)
  (display " *** ")
  (display elapsed-time))


; Using the old 'prime?' method
(define (search-for-primes primality-test start end nprimes)
  (define (internal-search start end primes)
    (cond ((>= start end)               primes)
          ((>= (length primes) nprimes) primes)
          ((even? start)                (internal-search (+ 1 start) end primes))
          ((primality-test start)       (internal-search (+ 2 start) end (cons start primes)))
          (else                         (internal-search (+ 2 start) end primes))))
  (internal-search start end '())) 

; Excercise 1.22 

(define (timed-test prime-test)
  (define (fn . args)
    (let* ((start-time (runtime))
           (is-prime? (apply prime-test args))
           (end-time (runtime)))
      (cond (is-prime? (display (format "~a ~a took ~a milliseconds to test\n" (if is-prime? "Prime" "Number") (first args) (- end-time start-time)))))
      is-prime?))
  fn)

; Three smalles primes > 1000
(search-for-primes (timed-test prime?) 1000 10000000 3) ;-> '(1019 1013 1009)
; Average test time (prime?): 0.0027669270833333335 ms
      
; Three smallest primes > 10000 
(search-for-primes (timed-test prime?) 10000 10000000 3) ;-> '(10037 10009 10007)
; Average test time (prime?): 0.009033203125 ms

; Three smalles primes > 100000
(search-for-primes (timed-test prime?) 100000 10000000 3) ;-> '(100043 100019 100003)
; Average test time (prime?): 0.028076171875 ms

; Three smalles primes > 1000000
(search-for-primes (timed-test prime?) 1000000 10000000 3) ;-> '(1000037 1000033 1000003)
; Average test time (prime?): 0.089599609375 ms


; We expect that primality testing with 'prime?' should be of order O(sqrt(n))
; this means that we expect that testing for primes around 10000 should take 
; sqrt(10) times the resources of testing around 1000, and that testing around 100000
; will take sqrt(10) times the resources of testing around 10000.
; in practice:

; testing @ 1000:    0.00277 ms
; testing @ 10000:   0.00903 ms (3.26 x @ 1000)
; testing @ 100000:  0.02808 ms (3.11 x @ 10000)
; testing @ 1000000: 0.08960 ms (3.19 x @ 100000)

; This bears well with the complexity estimates we made of O(sqrt(n)) which indicate 
; a growth of complexity of 3.16 x for every order of magnitude of n.

; This is very compatible with the idea that programs on this machine (x86 64bit quad core) 
; run in a time proportional to the number of stepd required for the computation.
