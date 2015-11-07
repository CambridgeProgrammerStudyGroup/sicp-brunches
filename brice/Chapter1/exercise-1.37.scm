#lang racket
(require "../utils.scm")

; Exercise 1.37:

; a) An infinite continued fraction is an expression of the form
;
; f =           N1 
;     ----------------------
;     D1 + ⎧      N2       ⎫
;          |---------------|
;          ⎩D2 + ⎧   N3   ⎫⎭
;                |--------|
;                ⎩D3 + ...⎭
;
;
; As an example, one can show that the infinite continued fraction 
; expansion with the Ni and the Di all equal to 1 produces 1/φ, 
; where φ is the golden ratio (described in Section 1.2.2). 
; One way to approximate an infinite continued fraction is to 
; truncate the expansion afer a given number of terms. Such a 
; truncation (a so-called k-term finite continued fraction)
; has the form
;
; f =       N1 
;     ---------------
;     D1 + ⎧   ...  ⎫
;          |--------|
;          ⎩...+⎧Nk⎫⎭
;               |--|
;               ⎩Dk⎭
;
;
; Suppose that n and d are procedures of one argument
; (the term index i) that return the Ni and Di of the terms of 
; the continued fraction. Define a procedure cont-frac such 
; that evaluating (cont-frac n d k) computes the value of the 
; k -term finite continued fraction. Check your procedure by 
; approximating 1/φ using


#;(cont-frac 
	(lambda (i) 1.0)
	(lambda (i) 1.0)
	k)


; for successive values of k. How large must you make k in 
; order to get an approximation that is accurate to 4 decimal places?

(define (cont-frac n d k)

	(define (intern i)
		(if (> k i) 
			(/ (n i) (+ (d i) (intern (inc i))))
			(/ (n i) (d i))))

	(intern 0))

; let's work out how big k need to be...

(define (rphi k)
	(cont-frac (lambda (i) 1.0) (lambda (i) 1.0) k))

(display (format "1/φ: ~a\n" (rphi 10))) ;-> 0.6180555555555556


(define reference 0.61803398875) ; 1/φ = 0.61803398875 (google)
(define tolerance 0.0001)

(define (calc-k f)
	"Calculates the number of recursion needed to get 
	 within tolerance of reference for function f"
	
	(define (close-enough? v1 v2) 
		(< (abs (- v1 v2)) tolerance))

	(define (intern n)
		(if (close-enough? (f n) reference)
			n
			(intern (inc n))))

	(intern 1))

(calc-k rphi) ;-> 9

;-> k needed to get to 0.0001 of reference is 9 

; b) If your cont-frac procedure generates a recursive process, 
; write one that generates an iterative process. If it generates 
; an iterative process, write one that generates a recursive process.

(define (cont-frac-iter n d k)

	(define (intern i a)
		(if (> i 0) 
			(intern (dec i) (/ (n k) (+ (d k) a)))
			a))

	(intern (dec k) (/ (n k) (d k))))

(define (rphi-iter k)
	(cont-frac-iter (lambda (i) 1.0) (lambda (i) 1.0) k))

(calc-k rphi-iter) ;-> 10

