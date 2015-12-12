#lang racket
(require "utils.scm")

(provide (all-defined-out))


(define (add-rat x y)
	(make-rat (+ (* (numer x) (denom y))
                 (* (numer y) (denom x)))
              (* (denom x) (denom y))))

(define (sub-rat x y)
	(make-rat (- (* (numer x) (denom y))
                 (* (numer y) (denom x)))
              (* (denom x) (denom y))))

(define (mul-rat x y)
	(make-rat (* (numer x) (numer y))
			  (* (denom x) (denom y)))) 

(define (div-rat x y)
  	(make-rat (* (numer x) (denom y))
              (* (denom x) (numer y))))

(define (equal-rat? x y)
	(= (* (numer x) (denom y))
       (* (numer y) (denom x))))

(define (make-rat n d)
	(let ((g (gcd n d)))
		(cons 
			(* (/ n g) (sign (* n d)))
			(abs (/ d g)))))

(define (numer x) (car x)) 

(define (denom x) (cdr x))

(define (string-rat x)
	(format "~a/~a" (numer x) (denom x)))