#lang racket
(require "utils.scm")

(provide average-damp)
(provide fixed-point)
(provide deriv)
(provide newtons-method)
(provide fixed-point-of-transform)
(provide compose+)
(provide repeated)


(define dx 0.00001)

(define (average-damp f)
	(lambda (x) (average x (f x))))

(define (fixed-point f first-guess)

	(define (close-enough? v1 v2) 
		(< (abs (- v1 v2)) 0.0001))

	(define (try guess)
		(let ((next (f guess)))
			(if (close-enough? guess next)
				next
          		(try next))))

  (try first-guess))

(define (deriv g)
	(lambda (x) (/ (- (g (+ x dx)) (g x)) dx)))

(define (newton-transform g)
	(lambda (x) (- x (/ (g x) ((deriv g) x)))))

(define (newtons-method g guess) (fixed-point (newton-transform g) guess))

(define (fixed-point-of-transform g transform guess) (fixed-point (transform g) guess))

(define (compose+ . fns)
	(cond 
		((empty? (rest fns)) (first fns))
		(else 
			(lambda (x)
				((first fns) 
					((apply compose+ (rest fns)) x))))))

(define (repeated fn n)
	(if (< n 1)
		(lambda (x) x)
		(lambda (x) 
			((apply compose+ (repeat fn n)) x))))

