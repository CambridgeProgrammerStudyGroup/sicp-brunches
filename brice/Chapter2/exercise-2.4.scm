#lang racket
(require "../utils.scm")

(title "Exercise 2.4")
; Exercise 2.4:
;
; Here is an alternative procedural representation
; of pairs. For this representation, verify that
;
;     (car (cons x y))
;
; yields x for any objects x and y.

(define (cons x y)
	(lambda (m) (m x y)))

(define (car z)
	(z (lambda (p q) p)))

; What is the corresponding definition of cdr?
; (Hint: To verify that this works, make use of the
; substitution model of Section 1.1.5.)

; Testing that car and cons work as expected

(assert "Recovering strings with car works"
	(equal? "hello" (car (cons "hello" "bye"))))

(assert "Recovering functions with car works"
	(equal? cons (car (cons cons car))))

(assert "Recovering numbers with car works"
	(equal? 42 (car (cons 42 11))))

; implementing cdr

(define (cdr z)
	(z (lambda (p q) q)))

(assert "Recovering strings with cdr works"
	(equal? "bye" (cdr (cons "hello" "bye"))))

(assert "Recovering functions with cdr works"
	(equal? cdr (cdr (cons cons cdr))))

(assert "Recovering numbers with cdr works"
	(equal? 11 (cdr (cons 42 11))))
