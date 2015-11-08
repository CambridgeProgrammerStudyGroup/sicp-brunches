#lang racket
(require "../utils.scm")
(require "../meta.scm")



; Exercise 1.43: 
;
; If f is a numerical function and n is a positive integer, 
; then we can form the nth repeated application of f , which 
; is defined to be the function whose value at x is f(f(...(f(x))...)). 
; For example, if f is the function 
; 
;     x  → x + 1
;
; then the nth repeated application of f is the function 
;
;     x  → x + n 
;
; If f is the operation of squaring a number, then the nth 
; repeated application of f is the function that raises its 
; argument to the 2ⁿ-th power. Write a procedure that takes 
; as inputs a procedure that computes f and a positive integer 
; n and returns the procedure that computes the nth repeated 
; application of f . Your procedure should be able to be used 
; as follows:
; 
;     ((repeated square 2) 5) 625
;
; Hint: You may find it convenient to use compose from Exercise 1.42.

(define (repeated fn n)
	(lambda (x) 
		((apply compose+ (repeat fn n)) x)))

((repeated square 2) 5) ;-> 625


; now, this is using list manipulations, so let's write it in 
; the way they wanted it...

(define (repeated2 fn n)
	
	(define (intern ifn k)
		(if (> k 1)
			(intern (compose fn ifn) (dec k))
			ifn))

	(intern fn n))

((repeated2 square 2) 5) ;-> 625







