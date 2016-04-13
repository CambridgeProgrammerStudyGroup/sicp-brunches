#lang racket
; Flotsam and Jetsam from working through Chapter 1.
;
; Not complete becauese was working on other folks' machines
; when pairing - honest.
;
;
; A helper function for making the output slightly more
; readable...
; 
; for priting out the exercise title...
(define (ti title)
  (define nl "\n")
  (define long (make-string 60 #\_))
  (display (string-append
   nl
   nl
   long nl
   title nl
   ;(make-string (string-length title) #\=)
   long nl
   nl )))

; and we're offf...

(ti "Exercise 1.3")

(define (squareOfTwoLargest a b c)
  (define (square x) (* x x))
  (define (order x y)
    (cond ((> x y) (cons y x))
          (else (cons x y))))
  (define abOrdered (order a b))
  (+ (square (cdr abOrdered))
     (square (cdr (order (car abOrdered) c)))))


(squareOfTwoLargest 5 3 4)


(ti "Exercise 1.4")
"a + b if b > 0 else a - b"

""
(ti "Exercise 1.5")
"Guess: Normal order returns (p)
Applicative order gets into infinite recursion evaluating (p)"
;(define (p) (p))
;(define (test x y)
;  (if (= 0 x)
;      0
;      y))
;(test 0 (p))

(ti "Exercise 1.6")
"ditto \"If\" will recurse infinitely trying to eval sqrr-iter"

(ti "Exercise 1.7")
(define (sqrt-iter guess x)
  (if (good-enough? guess x)
      guess
      (sqrt-iter (improve guess x)
                 x)))

(define (improve guess x)
  (average guess (/ x guess)))

(define (average x y)
  (/ (+ x y) 2))

(define (square x) (* x x ))

(define (dist a b) (abs (- a b)))

(define (good-enough? guess x)
  (< (dist (square guess) x) 0.001))

(define (good-enough-new? guess x)
  (< (dist 1 (/ (square guess) x)) 0.001))

(sqrt-iter 1. 10)
(sqrt-iter 1. 10000000000)
(sqrt-iter 1. 0.0000000001)

(ti "Excercise 1.8")

(define (good-enough-new2? fun guess x)
  (< (dist 1 (/ (fun guess) x)) 0.001))

(define (cube n) (* n n n))

(define (improveCube guess x)
  (/
   (+
    (/ x (square guess))
    (* 2 guess))
   3))


(define (cubeRoot-iter guess x)
  (if (good-enough-new2? cube guess x)
      guess
      (cubeRoot-iter (improveCube guess x)
                 x)))

(cubeRoot-iter 1. 27)


(ti "Exercise 1.9")
"First..."
"(+ 4 5)"
"(inc (+ (dec 4) 5))"
"(inc (inc (+ (dec 3) 5)))"
"(inc (inc (inc (+ (dec 2) 5))))"
"(inc (inc (inc (inc (+ (dec 1) 5)))))"
"(inc (inc (inc (inc 5))))"
"(inc (inc (inc 6)))"
"(inc (inc 7))"
"(inc 8)"
"9"
"recursive"
""

"Second..."
"(+ (dec 4) (inc 5))"
"(+ (dec 3) (inc 6))"
"(+ (dec 2) (inc 7))"
"(+ (dec 1) (inc 8))"
"9"
"iterative"

""
(ti "Exercise 1.10")

(define (A x y)
  (cond ((= y 0) 0)
        ((= x 0) (* 2 y))
        ((= y 1) 2)
        (else (A (- x 1)
                 (A x (- y 1))))))

(define (myA a b) (A a b))

(myA 0 0)
(myA 0 1)
(myA 0 2)
(myA 0 3)
(myA 0 4)
(display "\n========== \n")
(myA 1 0)
(myA 1 1)
(myA 1 2)
(myA 1 3)
(myA 1 4)
(display "\n========== \n")
(myA 2 0)
(myA 2 1)
(myA 2 2)
(myA 2 3)
(myA 2 4)
(display "\n========== \n")
(myA 3 0)
(myA 3 1)
(myA 3 2)
(myA 3 3)
;(myA 3 4)
(display "\n========== \n")
(myA 4 0)
(myA 4 1)
(myA 4 2)
;(myA 4 3)
;(myA 4 4)




(ti "Section 1.2.2")

(define (count-change amount) (cc amount 8))
(define (cc amount kinds-of-coins)
  (cond ((= amount 0) 1)
        ((or (< amount 0) (= kinds-of-coins 0)) 0)
        (else (+ (cc amount
                     (- kinds-of-coins 1))
                 (cc (- amount
                        (first-denomination
                         kinds-of-coins))
                     kinds-of-coins)))))
(define (first-denomination kinds-of-coins)
  (cond ((= kinds-of-coins 1) 1)
        ((= kinds-of-coins 2) 2)
        ((= kinds-of-coins 3) 5)
        ((= kinds-of-coins 4) 10)
        ((= kinds-of-coins 5) 20)
        ((= kinds-of-coins 6) 50)
        ((= kinds-of-coins 7) 100)
        ((= kinds-of-coins 8) 200)))

"Number of permutations of £2.10 change using coins."
(count-change 210)

(ti "Exercise 1.11")

(define (f n)
  (if (< n 3) n
      (f-iter n 0 1 2)))
(define (f-iter n ppp pp p)
  (if (< n 3) p
      (f-iter (- n 1) pp p (+ p (* pp 2) (* ppp 3)))))

"f of 4"
(f 4)


(ti "Exercise 1.12")
"  col 0  1  2  3  4  5"
"row "
"0     1"
"1     1  1"
"2     1  2  1"
"3     1  3  3  1"
"4     1  4  6  4  1"
"5     1  5  10 10 5  1"

(define (pascal row col)
  (cond
    ((> col row) -1)
    ((= col 0) 1)
    ((= col row) 1)
        (else
         (+
          (pascal (- row 1) (- col 1))
          (pascal (- row 1) col)))))

"Pascal row 5 col 3:"
(pascal 5 3)


(ti "Exercise 1.13")
"Quite remarkable proof but I don't have room in this text file"

;================================================
;  Mind the GAP
;================================================

""
"Excercise 1.15"
"ln(12.5 / 0.1) / ln(3)"
(ceiling (/ (log (/ 12.15 0.1)) (log 3)))
"Grows in time and space in proportion to log of a"


(ti "Excersice 1.16")

(define (exp1.16 b n) (exp-iter b n 1))

(define (even n) (= 0 (remainder n 2)))

(define (exp-iter b n a)
  (cond ((= n 0) a)
        ((even n)  (exp-iter (square b) (/ n 2)  a))
        (else (exp-iter b (- n 1) (* a b)))))


(exp1.16 2 16)
(exp1.16 2 32)
(exp1.16 0.707 2)

(ti "Exercise 1.17 & 1.18")
(define (double n) (* 2 n))
(define (halve n) (/ n 2))
(define (mult a b)
  (if (< a b) (mult-iter a b 0)
      (mult-iter b a 0)))
(define (mult-iter a b s)
  (cond ((= a 0) s)
        ((even a) (mult-iter (halve a) (double b) s))
        (else (mult-iter (- a 1) b (+ s b)))))
(mult 12 12)
(mult 7 8)



(ti "Exercise 1.19")


(define (fib n)
  (fib-iter 1 0 0 1 n))

(define (fib-iter a b p q count)
  (cond ((= count 0) b)
        ((even? count)
         (fib-iter a
                   b
                   (+ (square p) (square q))
                   (+ (square q) (* 2 p q))
                   (/ count 2)))
        (else (fib-iter (+ (* b q) (* a q) (* a p))
                        (+ (* b p) (* a q))
                        p
                        q
                        (- count 1)))))

"fib 6"
(fib 6)
"fib 8"
(fib 8)
"fib 23"
(fib 23)

(ti "Excercise 1.20")

"206 40"
"40 6 *"
"6 4 *"
"4 2 *"
"2 0 *"
"4 calls to Remainder"
"One extra with applicative"

(define (remainderStar a b)
  (print " * ")
  (remainder a b))

(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainderStar a b))))

(gcd 206 40)


(ti "Exercise 1.21")


(define (smallest-divisor n)
  (find-divisor n 2))


(define (find-divisor n next-divisor)
  (define (next n)
    (if (= n 2)
        3
        (+ n 2)))
  (cond
    ((> (square next-divisor) n) n)
    ((divides? next-divisor n) next-divisor)
    (else (find-divisor n (next next-divisor)))))

(define (divides? a b)
  (= 0 (remainder b a)))

"Smallest divisors of 199, 1999 and 19999"
(smallest-divisor 199)
(smallest-divisor 1999)
(smallest-divisor 19999)

(ti "Exercise 1.22")

(define (prog a b)
  a
  b)

(define (naive-prime? n) (= n (smallest-divisor n)))

(define (runtime)  (current-inexact-milliseconds))

(define (timed-prime-test n prime?)
  (start-prime-test n (runtime) prime?))

(define (start-prime-test n start-time prime?)
  (if (prime? n)
      (report-prime n (- (runtime) start-time))
      false))

(define (report-prime n elapsed-time)
  (display n)
  (display " *** ")
  (display elapsed-time)
  (newline))

"Is 1999 Prime?"
(timed-prime-test 1999 naive-prime?)



(define (search-for-primes lower upper prime?)
  (if (even? lower)
      (search-for-primes (+ lower 1) upper prime?)
      (if (> lower upper)
          false
          (prog (timed-prime-test lower prime?) (search-for-primes (+ lower 2) upper prime?) )  )))

"100,000,000"
(search-for-primes 100000000 100000040 naive-prime?)
"1,000,000,000"
(search-for-primes 1000000000 1000000022 naive-prime?)
"10,000,000,000"
(search-for-primes 10000000000 10000000062 naive-prime?)

(ti "Exercise 1.24")

(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder (square (expmod base (/ exp 2) m)) m))
        (else
         (remainder (* base (expmod base (- exp 1) m)) m))))

(define (fermat-test n )
  (define (try-it a)
    (= (expmod a n n) a))
  (try-it (+ 1 (random (- n 1)))))

(define (fast-prime? n times)
  (cond ((= times 0) true)
        ((fermat-test n) (fast-prime? n (- times 1)))
        (else false)))

"fast prime 123"
(fast-prime? 123 4)

(define (f-prime? n)
  (fast-prime? n 8))

"100,000,000"
(search-for-primes 100000000 100000040 f-prime?)
"1,000,000,000"
(search-for-primes 1000000000 1000000022 f-prime?)

(ti "Exercise 1.27")

(define (carmichael? n a)
  (cond
    ((>= a n) true)
    ((not (= (expmod a n n) a)) false)
    (else (carmichael? n (+ a 1)))))

"Carmichael 560?"
(carmichael? 560 2)

"Carmichael 561?"
(carmichael? 561 2)


(ti "Exercise 1.29")

(define (sum term a next b)
  (if (> a b)
      0
      (+ (term a) (sum term (next a) next b))))

(define (inc n)
  (+ n 1))

(define (pl t)
  (display t)
  (display "\n"))

(define (simpson f a b n)
  (define h (/ (- b a) n))
  (define (y k) (f (+ a (* k h))))
  (define (term kay)
    (cond
      ((= kay 0) (y 0))
      ((= kay n) (y n))
      ((even? kay) (* 2 (y kay)))
      (else (* 4 (y kay)))))
  (* (/ h  3)
     (sum term 0 inc n)))

(define (id x) x)

(simpson cube 0 1. 100)
(simpson cube 0 1. 1000)
"I don't understand how an aproximation comes up with the exact answer..."
(simpson cube 0 1 1001)

(ti "Exercise 1.30")


(define (sum-iter term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (+ result (term a)))))
  (iter a 0))

(define (product term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (* result (term a)))))
  (iter a 1))

(product id 1 inc 6)

(define (pi n)
  (define (term i)
    (/
     (* 2 (quotient (+ i 3) 2))
     (+ 1 (* 2 (quotient (+ i 2) 2)))))
  (* 4.0 (product term 0 inc n)))

"Estimate of pi"
(pi 100)

(ti "Section 1.3.3")

(define(close-enough? x y)
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


(ti "Exercise 1.34")


(define (callWith2 g) (g 2))

(callWith2 square)

(callWith2 (lambda (z) (* z (+ z 1))))

;(callWith2 callWith2)

"(callWith2 callWith2): ERROR because... after calling itself twice callWith2 tries to call '2'"

(ti "Exercise 1.35")

(define tolerence 0.0001)

(define (dampen1 guess next) next)
(define (dampen2 guess next) (/ (+ guess next) 2))

(define (fixed-point-my-damp f first-guess dampen)
  (define (close-enough v1 v2)
    (> tolerence (abs (- v1 v2))))
  (define (try guess count)
    (let ((next (f guess)))
      (if (close-enough guess next)
          (cons count next)
          (try (dampen guess next) (+ count 1)))))
  (try first-guess 0))

;Golden Ratio
(fixed-point-my-damp (lambda (x)  (+ 1 (/ 1 x))) 1.0 dampen1)

(ti "Exercise 1.36")

(fixed-point-my-damp (lambda (x) (/ (log 1000) (log x))) 2 dampen1)
(fixed-point-my-damp (lambda (x) (/ (log 1000) (log x))) 2 dampen2)

(ti "Exercise 1.37")

(define (cont-frac-recur n d k)
  (define (recur i)
    (if (= i k)
        (/ (n i) (d i))
        (/ (n i) (+ (d i) (recur (+ i 1))))))
  (recur 1))

(define (cont-frac n d k)
  (define (iter i nextTerm)
    (let ((currentTerm (/ (n i) (+ (d i) nextTerm))))
      (if (= i 1)
          currentTerm
          (iter (- i 1) currentTerm))))
  (iter k 0))


(cont-frac-recur (lambda (i) 1.0)
           (lambda (i) 1.0)
           100)

(cont-frac (lambda (i) 1.0)
           (lambda (i) 1.0)
           100)

(ti "Exercise 1.38")

(cont-frac (lambda (i) 1.0)
           (lambda (i)
             (let ((iPlusOne (+ i 1)))
               (if (= 0 (remainder iPlusOne 3))
                   (* (/ iPlusOne 3) 2)
                   1.0)))
           16)

(ti "Exercise 1.39")


(define (tan-cf x k)
  (cont-frac (lambda (i)
               (if (= 1 i)
                   x
                   (- (square x))))
             (lambda (i)
               (- (* i 2) 1))
             k))

(tan-cf 0.5 100)

(ti "Exercise 1.40")

(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (> tolerence (abs (- v1 v2))))
  (define (try guess)
    (let ((next (f guess)))
      (if (close-enough? guess next)
          next
          (try next))))
  (try first-guess))

(define dx 0.00001)

(define (deriv g)
  (lambda (x)
    (/ (- (g (+ x dx)) (g x))
       dx)))

(define (newtons-transform g)
  (lambda (x)
    (- x (/ (g x) ((deriv g) x)))))

(define (newtons-method g guess)
  (fixed-point (newtons-transform g) guess))

(define (cubic a b c)
  (lambda (x)
    (+ (cube x)
       (* a (square x))
       (* b x)
       c)))

(newtons-method (cubic 1 1 1) 1)
(newtons-method (cubic 1 2 3) 1)

(ti "Exercise 1.41")

(define (doubleFunc f)
  (lambda (x) (f (f x))))

(((doubleFunc (doubleFunc doubleFunc)) inc) 5)
;"(double double) runs f 4 times.
;"  (double  (d d)) runs 'run 4 times' 4 times"

(ti "Exercise 1.42")


(define (compose f g)
  (lambda (x) (f (g x))))

((compose square inc) 6)

(define (repeated f n)
  (if (= n 1)
      (lambda (x) (f x))
      (compose f (repeated f (- n 1)))))

((repeated square 2) 5)

(ti "Exercise 1.43")

;(define dx 0.00001)

(define (smooth f)
  (lambda (x)
    (/ (+ (f (- x dx)) (f x) (f (+ x dx))) 3)))

((smooth square) 4)

(define (smoothN n)
  (repeated smooth n))

(((smoothN 1) square) 4)
(((smoothN 2) square) 4)

(ti "Exercise 1.45")


(define (average-damp f)
  (lambda (x) (average x (f x))))

(define (dampN n)
  (repeated average-damp n))

(define (root x rootCount dampCount)
  (fixed-point
    ((dampN dampCount) (lambda (y) (/ x  (exp1.16 y (- rootCount 1))  )))
   5.0))

(root 9 2 1)
(root 81 4 2)
(root 2187 8 3)
(root 1000 16 4)

(define (root2 x rootCount)
  (fixed-point
    ((dampN (ceiling (expt rootCount 0.5))) (lambda (y) (/ x  (exp1.16 y (- rootCount 1))  )))
   5.0))

"=========="
(root2 9 2 )
(root2 81 4 )
(root2 2187 8 )
(root2 1000 16 )
(root2 1000 50 )

(ti "Exercise 1.46")


(define (iterative-improve good-enough? improve)
  (define (improve-until-good-enough guess)
    (if (good-enough? guess)
        guess
        (improve-until-good-enough (improve guess))))
  improve-until-good-enough)

((iterative-improve
    (lambda (x) (> x 10))
    (lambda (x) (+ x 1)))
 0.5)
    
(define (sqrtII guess x)
  ((iterative-improve
    (lambda (y) (< (abs (- (* y y) x)) 0.00001))
    (lambda (g) (average g (/ x g))))
   x))

(sqrtII 1 64.0)

(define (fixed-point-ii f first-guess)
  ((iterative-improve
    (lambda (g) (< (abs (- g (f g))) tolerence)) 
    f)
   first-guess))

(fixed-point-ii (lambda (y) (+ (sin y) (cos y))) 1.0)