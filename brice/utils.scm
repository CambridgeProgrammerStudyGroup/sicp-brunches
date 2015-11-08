#lang racket

(provide inc)
(provide dec)
(provide assert)
(provide asserteq)
(provide square)
(provide average)
(provide repeat)

(define (inc x) (+ x 1))
(define (dec x) (- x 1))
(define (square x) (* x x))


(define (reporterr msg)
	(display "ERROR: ")
	(display msg)
	(newline))

(define (reportok msg)
	(display "OK: ")
	(display msg)
	(newline))

(define (assert msg b)
  (if b (reportok msg) (reporterr msg)))

(define (asserteq msg a b)
  (assert msg (> 0.0001 (abs ( - a b)))))

(define (average a b)
	(/ (+ a b) 2))

(define (repeat x n)
	
	(define (intern i seq)
		(if (> i 0)
			(intern (dec i) (cons x seq))
			seq))
	
	(intern n '()))

