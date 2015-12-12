#lang racket
(require "../utils.scm")


(define carmichael '(561 1105 1729 2465 2821 6601))

(define primes '(17 23 5 199))
(define notprimes '(40 25 9 206))


(define (congruent a n)
	(= 
		(remainder (expt a n) n) 
		(remainder a n)))


(define (pass-test? n)
	(define (pass? a)
		(cond 
			((= 0 a) #t)
			((congruent a n) (pass? (dec a)))
			(else #f)
		))
	(pass? n))

(map pass-test? primes) ;-> '(#t #t #t #t)
(map pass-test? carmichael) ;-> '(#t #t #t #t #t #t)
(map pass-test? notprimes) ;-> '(#f #f #f #f)