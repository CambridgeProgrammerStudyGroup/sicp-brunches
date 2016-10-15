#lang racket
(require "../utils.scm")

(title "Exercise 2.5")
; Exercise 2.5:
;
; Show that we can represent pairs of nonnegative
; integers using only numbers and arithmetic
; operations if we represent the pair a and b as
; the integer that is the product (2^a)(3^b).
;
; Give the corresponding definitions of the
; procedures cons, car, and cdr.

(define (cons a b)
	(*
		(expt 2 a)
		(expt 3 b)))

(define (car n)
	(define (recur k c)
		(if (= 0 (remainder k 2))
			(recur (/ k 2) (inc c))
			c))
	(recur n 0))


(asserteq "CAR can extract even number"
	4 (car (cons 4 5)))

(asserteq "CAR can extract odd number"
	3 (car (cons 3 5)))

(define (cdr n)
	(define (recur k c)
		(if (= 0 (remainder k 3))
			(recur (/ k 3) (inc c))
			c))
	(recur n 0))

(asserteq "CDR can extract even number"
	8 (cdr (cons 3 8)))

(asserteq "CDR can extract odd number"
	5 (cdr (cons 3 5)))
