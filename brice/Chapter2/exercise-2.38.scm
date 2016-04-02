#lang racket
(require "../utils.scm")
(require "../meta.scm")

(title "Exercise 2.38")

(provide fold-left)

; Exercise 2.38.  The accumulate procedure is also known as fold-right, 
; because it combines the first element of the sequence with the result 
; of combining all the elements to the right. There is also a fold-left, 
; which is similar to fold-right, except that it combines elements 
; working in the opposite direction:

(define (fold-left op initial sequence)
  (define (iter result rest)
    (if (null? rest)
        result
        (iter (op result (car rest))
              (cdr rest))))
  (iter initial sequence))

; What are the values of

(assertequal? "We understand foldr with numbers"
	(foldr / 1 (list 1 2 3)) (/ 1 (/ 2 (/ 3 1))))

(assertequal? "We understand fold-left with numbers" 
	(fold-left / 1 (list 1 2 3))  (/ 1 1 2 3))


(assertequal? "We understand foldr with lists"
	(foldr list nil (list 1 2 3)) (list 1 (list 2 (list 3 nil))))

(assertequal? "We understand fold-left with lists" 
	(fold-left list nil (list 1 2 3)) (list (list (list nil 1) 2) 3))

; Give a property that op should satisfy to guarantee that fold-right and 
; fold-left will produce the same values for any sequence.

(prn "
For fold-left and fold-right to produce the same value 
`a op b` and `b op a` should also produce the same values
ie, the operator should be commutative.")

(prn "
Note: the book's `fold-left` is *not* analogous to scheme's `foldl`!")