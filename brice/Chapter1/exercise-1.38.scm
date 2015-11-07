#lang racket
(require "../utils.scm")

; Exercise 1.38: 
;
; In 1737, the Swiss mathematician Leonhard Euler published 
; a memoir De Fractionibus Continuis, which included a 
; continued fraction expansion for e − 2, where e is the 
; base of the natural logarithms. In this fraction, the Ni are all 1, 
; and the Di are successively 
;
;               1, 2, 1, 1, 4, 1, 1, 6, 1, 1, 8, ...
;
;       index:  0  1  2  3  4  5  6  7  8  9 10
;   index % 3:  0  1  2  0  1  2  0  1  2  0  1
;     index+2:  2  3  4  5  6  7  8  9 10 11 12
; index+2 % 3:  2  0  1  2  0  1  2  0  1  2  0  1
;   
;
; Write a program that uses your cont-frac procedure from 
; Exercise 1.37 to approximate e, based on Euler’s expansion


; from exercise 1.37
(define (cont-frac n d k)

	(define (intern i)
		(if (> k i) 
			(/ (n i) (+ (d i) (intern (inc i))))
			(/ (n i) (d i))))

	(intern 0))

(define (n i) 1.0)
(define (d i) 
	(cond 
		((= (remainder (dec i) 3) 0) (* 2 (/ (+ i 2 ) 3))) ; 2*((i+2)/3)
		(else 1)))

(define (e)
	(+ 2 (cont-frac n d 10)))

(display "reference e = 2.71828 (wikipedia)\n")
(display (format "approximetely, e = ~a\n" (e)))
