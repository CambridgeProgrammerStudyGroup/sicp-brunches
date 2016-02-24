#lang racket

; 2.2.3  Sequences as Conventional Interfaces
; ===========================================

; https://mitpress.mit.edu/sicp/full-text/book/book-Z-H-15.html#%_sec_2.2.3

(require "exercises2.util.rkt")

;#########################################################################
;#########################################################################
(ti "Exercise 2.33")

; Exercise 2.33.  Fill in the missing expressions to complete the
; following definitions of some basic list-manipulation operations as
; accumulations:
; 
; (define (map p sequence)
;   (accumulate (lambda (x y) <??>) nil sequence))
; (define (append seq1 seq2)
;   (accumulate cons <??> <??>))
; (define (length sequence)
;   (accumulate <??> 0 sequence))

(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

(define (map p sequence)
  (accumulate (lambda (x y) (cons (p x) y)) null sequence))

 (define (append seq1 seq2)
   (accumulate cons seq2 seq1))

 (define (length sequence)
   (accumulate (lambda (item length) (+ 1 length)) 0 sequence))

(let ((items (list 1 2 3 4))
      (items2 (list 5 6 7 8))
      (square (lambda (n) (* n n))))
  (prn
   (str "items:      " items)
   (str "map square: " (map square items))
   (str "append:     " (append items items2))
   (str "length:     " (length items))))
  
;#########################################################################
;#########################################################################

(ti "Exercise 2.34")

; Exercise 2.34.  Evaluating a polynomial in x at a given value of x can
; be formulated as an accumulation. We evaluate the polynomial
; 
; 
; using a well-known algorithm called Horner's rule, which structures the
; computation as
; 
; 
; In other words, we start with an, multiply by x, add an-1, multiply by
; x, and so on, until we reach a0.16 Fill in the following template to
; produce a procedure that evaluates a polynomial using Horner's rule.
; Assume that the coefficients of the polynomial are arranged in a
; sequence, from a0 through an.
; 
; (define (horner-eval x coefficient-sequence)
;   (accumulate (lambda (this-coeff higher-terms) <??>)
;               0
;               coefficient-sequence))
; 
; For example, to compute 1 + 3x + 5x3 + x5 at x = 2 you would evaluate
; 
; (horner-eval 2 (list 1 3 0 5 0 1)); 