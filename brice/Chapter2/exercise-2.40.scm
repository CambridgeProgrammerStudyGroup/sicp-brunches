#lang racket
(require "../utils.scm")
(require "../meta.scm")

(title "Exercise 2.40")

; Exercise 2.40.  Define a procedure unique-pairs that, 
; given an integer n, generates the sequence of pairs 
; (i,j) with 1< j< i< n. Use unique-pairs to simplify 
; the definition of prime-sum-pairs given above.

(define (enumerate-interval low high)
  (if (> low high)
      nil
      (cons low (enumerate-interval (+ low 1) high))))

(define (unique-pairs n)
	(define (inner acc xs)
		(if (empty? xs)
			acc
			(inner 
				(append acc (zip (rest xs) (repeat (first xs) (dec (length xs))))) 
                (rest xs))))
	
	(let* ((nums (enumerate-interval 1 n)))
		(inner '() nums)))

(define (prime-sum-pair? pair)
	(prime? (+ (first pair) (second pair))))

(define (prime-sum-pairs n)
	(let* ((xs (unique-pairs n)))
		(filter prime-sum-pair? xs)))

(let* 
	(
		(A '((2 1) (3 1) (4 1) (5 1) (3 2) (4 2) (5 2) (4 3) (5 3) (5 4)))
		(B '((2 1) (4 1) (6 1) (3 2) (5 2) (4 3) (6 5)))
	)

	(assertequal? "We can find the unique pairs of numbers less than n"
		A (unique-pairs 5))

	(assertequal? "We can use unique pairs to work out prime-sum-pairs"
		B (prime-sum-pairs 6))
	)





