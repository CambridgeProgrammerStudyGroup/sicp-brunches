#lang racket

(display "\nEXCERCISE 1.33\n")

(define (inc n) (+ 1 n))
(define (show t) (display (format "~a\n" t)))

(define (filtered-accumulate keep? combiner null-term term a next b)
	(define (iter a result)
		(if (> a b)
			result
			(iter (next a) 
				(if (keep? a) 
					(combiner (term a) result) 
					result))))
	(iter a null-term))

(filtered-accumulate even? + 0 identity 1 inc 10)

;; a) sum of the square of primes from a to b
(filtered-accumulate prime? + 0 square a inc b)

;; b) product all positive integers less than n relatively prime to n
;; (ie: i < n so that GCD(i,n)==1 )

