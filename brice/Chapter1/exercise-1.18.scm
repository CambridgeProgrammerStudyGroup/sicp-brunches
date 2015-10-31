#lang racket
(display "\nEXCERCISE 1.18\n")


(define (half x) (/ x 2))
(define (double x) (+ x x))
(define (dec x) (- x 1))

(define (multiply-inner x y a)
	(cond 
		((= x 0) a)
		((odd? x)  (multiply-inner (dec x)    y            (+ a y)  ))	
		((even? x) (multiply-inner (half x)   (double y)   a        ))))

		

(multiply-inner 3 6 0) ;-> 18
(multiply-inner 3 3 0) ;-> 9
(multiply-inner 4 5 0) ;-> 20