#lang racket
(require "../utils.scm")


; Louis Reasoner writes the following:
(define (expmod base exp m)
	(cond 
		((= exp 0) 1)
		((even? exp) 
			(remainder 
				(* 
					(expmod base (/ exp 2))
					(expmod base (/ exp 2)))
				m))
		(else
			(remainder (* base (expmod base (- exp 1) m))))))

; this formulation, by not using `square` turns the O(log n) process into a O(n) process. Why?

; That's because the `(expmode base (/exp 2))` expression is evaluated twice. Since the expression is recursive, the does
; not just double the complexity class of the process, but actually changes its complexity class to 0(n). 