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


; Excercise 1.9
(define (inc a)
  (+ a 1))

(define (dec a)
  (- a 1))
; Definition 1
; (define (+ a b)
;   (if (= a 0)
;       b
;       (inc (+ (dec a) b))))

(+ 4 5)
(inc (+ 3 5))
(inc (inc (+ 2 5)))
(inc (inc (inc (+ 1 5))))
(inc (inc (inc (inc (+ 0 5)))))
(inc (inc (inc (inc 5))))
(inc (inc (inc 6)))
(inc (inc 7))
(inc 8)
9

; Definition 2
;
; (define (+ a b)
;   (if (= a 0)
;       b
;       (+ (dec a) (inc b))))

(+ 4 5)
(+ 3 6)
(+ 2 7)
(+ 1 8)
(+ 0 9)
9

; The first process is recursive, whilst the second is iterative. Both functions are recursive.
; The reason for the difference is that the second process is tail-recursive: it recurses on itself
; at the final call in the hierarchy; the first process is not, it recurses on itself at the last-but
; -one call in the hierarchy.

; Are all tail-recursive functions iterative? 
; defining a tail-recursive version of the factorial function creates an iterative process.
; This is generally true, as tail-recursive calls can be optimised to jumps and compile to the 
; same machine code as while loops.

(define (fac a)
  (define (fac-iter a b)
    (if (= a 1)
        b
        (fac-iter (dec a) (* a b))
    ))
  (fac-iter a 1))

(= (fac 5) (* 5 4 3 2 1))

; let's try and implement the 'for' looping construct using tail recursion.

(define (for environment predicate step action)
  (if (predicate environment)
      (and
       (action environment)
       (for (step environment) predicate step action))
      environment))

(for 0 (lambda (a) (< a 10)) inc print)

;;EXERCISE 1.10
(define (A m n)
  (cond ((= n 0) 0)
        ((= m 0) (* 2 n))
        ((= n 1) 2)
        (else (A (- m 1)
                 (A m (- n 1))))))

;: (A 1 10) ;-> 1024

;: (A 2 4) ;-> 65536

;: (A 3 3) ;-> 65536

(define (f n) (A 0 n)) ;-> f(n) = 2n

(define (g n) (A 1 n)) ;-> g(n) = 2^n = 2↑n

(define (h n) (A 2 n)) ;-> h(n) = 2^(h(n - 1)) = 2↑↑n

(define (k n) (* 5 n n)) ;-> k(n) = 5n²

; we can see from the above and from exploring the definiton 
; that the general form of the ackerman function above then becomes

; A(m,n) = 2↑ᵐn

; EXCERCISE 1.11
;        | if n<3; n
; f(n) = | if n>=3; f(n-1)+2f(n-2)+3f(n-3)

(define (f1.11r n)
  (cond ((< n 3) n)
        (else (+ (f1.11r (dec n)) (* 2 (f1.11r (- n 2))) (* 3 (f1.11r (- n 3)))))))

; a <- b 
; b <- c
; c <- c + 2b + 3a

(define (f-bare a b c)
  (+ a (* 2 b) (* 3 c)))


(define (f1.11i n)
  
  (define (f-iter a b c count)
    (if (= count 0)
        a
        (f-iter b c (f-bare c b a) (dec count))))
  
  (f-iter 0 1 2 n))

(define (test n) (print (list n (f1.11r n) (f1.11i n)) ))
(for 0 (lambda (x) (< x 10)) inc test)

; While this is the correct solution, it feels like it was arrived at by trial and error rather
; than deliberately...


; Excercise 1.12

; Pascal's pyramid:
; 1
; 1  1
; 1  2  1
; 1  3  3  1
; 1  4  6  4  1

(define (pascal l n)
  "l - 0-indexed layer
   n - 0-indexed position in layer."
  (cond ((> n l) (raise 'invalid-input))
        ((= l n 0) 1)
        ((= l 1) 1)
        ((= n 0) 1)
        ((= l n) 1)
        (else (+ (pascal (dec l) n) (pascal (dec l) (dec n))))
        ))


;----------------------------------------------
; Exercises 1.13 -> 1.21 To be completed later
;----------------------------------------------

;; Naivie primality testing
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

; Excercise 1.21
; Find smallest divisor of 199, 1999, 19999

(smallest-divisor 199) ;-> 199 (prime)
(smallest-divisor 1999) ;-> 1999 (prime)
(smallest-divisor 19999) ;-> 7 (not prime)

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



; Excercise 1.24

;(search-for-primes (timed-test (lambda (x) (fast-prime? x 10))) 1000 1000000 3)
; Average test time (fast-prime?): 0.0166015625 ms

;(search-for-primes (timed-test (lambda (x) (fast-prime? x 10))) 10000 1000000 3)
; Average test time (fast-prime?): 0.020345052083333332 ms

;(search-for-primes (timed-test (lambda (x) (fast-prime? x 10))) 100000 1000000 3)
; Average test time (fast-prime?): 0.023274739583333332 ms

;(search-for-primes (timed-test (lambda (x) (fast-prime? x 10))) 1000000 10000000 3)
; Average test time (fast-prime?): 0.025960286458333332 ms





