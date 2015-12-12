#lang racket
(display "\nEXCERCISE 1.16\n")

(define (square x) (* x x))

;; Logarithmic growth recursion
(define (fast-expt b n)
  (cond ((= n 0) 1)
        ((even? n) (square (fast-expt b (/ n 2))))
        (else (* b (fast-expt b (- n 1))))))

(define (even? n)
  (= (remainder n 2) 0))

;; our task is to create a logarithmic growth iterative function

(define (fast-expt-iter b n)
	(define (internal a n)
		(cond ((= n 1) a)
			  ((even? n) (internal (* a (square b)) (/ n 2)))
			  (else (internal b (- n 1)))))
	(internal 1 n))
	
(let ( (x 2) (n 3))
	(equal? (fast-expt x n) (fast-expt-iter x n)))


