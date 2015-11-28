#lang racket
(require "../utils.scm")
(require "../meta.scm")


; Exercise 1.42: 
; Let f and g be two one-argument functions. 
; The composition f after g is defined to be the function 
;
;     x  → f (g(x)) 
;
; Define a procedure compose that implements composition. 
; For example, if inc is a procedure that adds 1 to its argument
; 
;     ((compose square inc) 6) ;-> 49

(define (compose f g)
	(lambda (x) (f (g x))))

((compose square inc) 6)

(define (compose+ . fns)
	(cond 
		((empty? (rest fns)) (first fns))
		(else 
			(lambda (x)
				((first fns) 
					((apply compose+ (rest fns)) x))))))

((compose+ inc inc dec (lambda (x) (* x x))) 4) ; -> 17 = (inc (inc (dec (sq 4))))