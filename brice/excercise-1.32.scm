#lang racket

(display "\nEXCERCISE 1.32\n")

(define (inc n) (+ 1 n))

(define (term n)
	(cond ((odd? n) (/ (+ n 1) (+ n 2)))
		  ((even? n) (/ (+ n 2) (+ n 1)))))



(define (accumulate combiner null-term term a next b)
	(define (iter a result)
		(if (> a b)
			result
			(iter (next a) (combiner (term a) result))))
	(iter a null-term))

(define (product term a next b) 
	(accumulate * 1 term a next b))

(define (accumulate-recur combiner null-term term a next b)
	(if (> a b) null-term
		(combiner 
			(term a) 
			(accumulate-recur combiner null-term term (next a) next b))))

(define (product-recur term a next b)
	(accumulate-recur * 1 term a next b))
	

(define (show t) (display (format "~a\n" t)))

(define (pi-iter n) (* 4.0 (product term 1 inc n)))
(define (pi-recur n) (* 4.0 (product-recur term 1 inc n)))

(show (pi-recur 1000))
(show (pi-iter 1000))
