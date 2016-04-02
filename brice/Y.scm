#lang racket

(provide (all-defined-out))


(define Y-lazy
	(lambda (f)
		((lambda (x) (f (x x)))
		(lambda (x) (f (x x))))))

(define Y-strict
	(lambda (f)
		((lambda (x) (f (lambda (y) ((x x) y))))
		 (lambda (x) (f (lambda (y) ((x x) y)))))))
