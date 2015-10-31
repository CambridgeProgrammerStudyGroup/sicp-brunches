#lang racket

(display "\nEXCERCISE 1.31\n")

(define (inc n) (+ 1 n))

(define (term n)
	(cond ((odd? n) (/ (+ n 1) (+ n 2)))
		  ((even? n) (/ (+ n 2) (+ n 1)))))

;; iterative process for product series function
(define (product term a next b)
	(define (iter a result)
		(if (> a b)
			result
			(iter (next a) (* (term a) result))))
	(iter a 1))

;; recursive process for product series function
(define (product-recur term a next b)
	(cond 
		((> a b) 1)
		(else (* (term a) (product-recur term (next a) next b)))))

(define (show t) (display (format "~a\n" t)))

(define (pi-iter n) (* 4.0 (product term 1 inc n)))
(define (pi-recur n) (* 4.0 (product-recur term 1 inc n)))

(show (pi-recur 1000))
(show (pi-iter 1000))
