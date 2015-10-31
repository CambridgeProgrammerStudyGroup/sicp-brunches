; Excercise 1.23
(display "\nEXCERCISE 1.23\n")
 
(define (next n)
  (if (= 2 n) 
      3
      (+ n 2)))

(define (smallest-divisor2 n)
  (find-divisor n 2))

(define (find-divisor2 n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (next test-divisor)))))

(define (divides2? a b)
  (= (remainder b a) 0))

(define (prime2? n)
  (= n (smallest-divisor n)))

(search-for-primes (timed-test prime2?) 1000 10000000 3) ;-> '(1019 1013 1009)
(search-for-primes (timed-test prime2?) 10000 10000000 3) ;-> '(10037 10009 10007)
(search-for-primes (timed-test prime2?) 100000 10000000 3) ;-> '(100043 100019 100003)
(search-for-primes (timed-test prime2?) 1000000 10000000 3) ;-> '(1000037 1000033 1000003)


; for 'prime?'
; testing @ 1000:    0.00277 ms
; testing @ 10000:   0.00903 ms
; testing @ 100000:  0.02808 ms
; testing @ 1000000: 0.08960 ms

; for 'prime2?'
; testing @ 1000:    0.00260 ms
; testing @ 10000:   0.00863 ms
; testing @ 100000:  0.02637 ms
; testing @ 1000000: 0.08268 ms

; As can be seen by comparison to 'prime?' above, there is a slight systematic difference
; with between the 'prime?' and 'prime2?' functions. However, the ratio is not 2 as expected, 
; but closer to (/ (+ 1.065 1.046 1.065 1.84) 4) -> 1.3

; XXXX -> Why is this?