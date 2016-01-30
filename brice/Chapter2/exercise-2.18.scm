#lang racket
(require "../utils.scm")
(require "../meta.scm")

(title "Exercise 2.18")

(define (append list1 list2)
		(if (null? list1)
			list2
			(cons (car list1) (append (cdr list1) list2))))

(define (F A B) (if (null? B) A (F (cons (car B) A) (cdr B))))

(define (reverse xs)
	(define (inner ret xs)
		(if (null? xs)
			ret
			(inner 
				(cons (car xs) ret) 
				(cdr xs))))
	(inner '() xs))

(define (reverse-rec xs)
	(if (null? xs) 
		xs
		(append (reverse-rec (cdr xs)) (cons (car xs) '()))))

; However, note that this is is definitely *not* linear time – O(n^2). Can we find a recursive
; process that reverses a list in linear time?

; REVERSE := Y (λgal. NULL l a (g (PAIR (CAR l) a) (CDR l))) NIL
; Y := λg. (λx. g (x x)) (λx. g (x x)) 


(define (recursive-reverse-helper xs)
	(lambda (reverse-prev)
			(if (empty? xs)
				(reverse-prev)
				(
					(recursive-reverse-helper (cdr xs))
					(lambda ()
						(cons (car xs) (reverse-prev)))))))

(define (reverse-rec-lt xs)
	((recursive-reverse-helper xs) (lambda () '())))

(let* (
		(A (list 1 2 3 4 5))
		(B (list 5 4 3 2 1)))

	(assert "Reversing a list works." (equal? A (reverse B)))
	(assert "Recursive reverse empty list ok" (equal? '() (reverse-rec '())))
	(assert "Recursive reverse full list ok" (equal? A (reverse-rec B)))
	(assert "Linear time recursvive works with empty list" (equal? '() (reverse-rec-lt '())))
	(assert "Linear time recursvive works with full list" (equal? A (reverse-rec-lt B)))
)

