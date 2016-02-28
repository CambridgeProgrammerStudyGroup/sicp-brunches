#lang racket
(require "../utils.scm")
(require "../meta.scm")

(title "Exercise 2.33")

; Exercise 2.33.  Fill in the missing expressions to 
; complete the following definitions of some basic 
; list-manipulation operations as accumulations:

; From page 116 definition for accumulate
(define (accumulate op init seq)
	(if (null? seq)
		init
		(op (car seq) (accumulate op init (cdr seq)))))


(define (b-map p sequence)
  (accumulate (lambda (x y) (cons (p x) y)) nil sequence))


(define (b-append seq1 seq2)
  (accumulate cons seq2 seq1))


(define (b-length sequence)
  (accumulate (lambda (x y) (inc y)) 0 sequence))



(let* (
	(A '(1 2 3 4 5)))
	(assert "Map defined in term of fold works" (equal? (b-map square A) (map square A)))
	(assert "Append defined in term of fold works" (equal? (b-append A A) (append A A)))
	(assert "length defined in term of fold works" (= (b-length A) (length A)))
)

