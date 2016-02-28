#lang racket
(require "../utils.scm")
(require "../meta.scm")

(title "Exercise 2.29")


; Exercise 2.29: A binary mobile consists of two branches, a left
; branch and a right branch. Each branch is a rod of a certain 
; length, from which hangs either a weight or another binary mobile. 
; We can represent a binary mobile using compound data by constructing 
; it from two branches (for example, using list):
;
(define (make-mobile left right) 
	(list left right))
; 
; A branch is constructed from a length (which must be a number) together 
; with a structure, which may be either a number (representing a simple
; weight) or another mobile:
;
; 
(define (make-branch length structure) 
	(list length structure))
;
; a. Write the corresponding selectors left-branch and right-branch, which 
; return the branches of a mobile, and branch-length and branch-structure, 
; which re turn the components of a branch.

(define (left-branch mobile)
	(car mobile))

(define (right-branch mobile)
	(car (cdr mobile)))

(define (branch-length branch)
	(car branch))

(define (branch-structure branch)
	(car (cdr branch)))


(let* (
	(A (make-mobile (make-branch 30 50) (make-branch 50 30)))
	(rA (make-branch 50 30))
	(lA (make-branch 30 50))
	)
	(assert "We can get the left branch of a mobile" (equal? (left-branch A) lA))
	(assert "We can get the right branch of a mobile" (equal? (right-branch A) rA))
	(assert "We can get the length of a branch" (equal? (branch-length rA) 50))
	(assert "We can get the structure of a branch" (equal? (branch-structure rA) 30))
)

; b. Using your selectors, define a procedure total-weight that returns 
; the total weight of a mobile.

(define (total-weight mobile)
	
	(define (weight-branch branch)
		(if (pair? (branch-structure branch))
			(total-weight (branch-structure branch))
			(branch-structure branch)))
	(if (pair? mobile)
		(+ 
			(weight-branch (right-branch mobile))
			(weight-branch (left-branch mobile)))
		mobile))

(let* (
	(A (make-mobile (make-branch 30 50) (make-branch 50 30)))
	(B (make-mobile 
			(make-branch 30 (make-mobile 
				(make-branch 30 50) 
				(make-branch 50 30))) 
			(make-branch 50 30)))
	)
	(asserteq "We can calculate the total weight of a simple mobile" 80 (total-weight A))
	(asserteq "We can calculate the total weight of a compound mobile" 110 (total-weight B)))

; c. A mobile is said to be balanced if the torque applied by its top-left
; branch is equal to that applied by its top-right branch (that is, if the 
; length of the left rod multiplied by the weight hanging from that rod is 
; equal to the corresponding product for the right side) and if each of 
; the submobiles hanging off its branches is balanced. Design a predicate 
; that tests whether a binary mobile is balanced.

(define (balanced? mobile)
	(define (torque branch)
		(* 
			(branch-length branch)
			(total-weight (branch-structure branch))))
	(= 
		(torque (left-branch mobile))
		(torque (right-branch mobile))))


(let* (
	(A (make-mobile (make-branch 30 50) (make-branch 50 30)))
	(B (make-mobile (make-branch 30 (make-mobile (make-branch 30 50) (make-branch 50 30))) (make-branch 50 30)))
	)
	(assert "We can distinguish a balanced mobile" (balanced? A))
	(assert "We can distinguish an unbalanced mobile" (not (balanced? B)))	
)

; d. Suppose we change the representation of mobiles so that the 
; constructors are

(define (make-mobile2 left right) 
	(cons left right)) 

(define (make-branch2 length structure)
	(cons length structure))

; How much do you need to change your programs to convert to the new 
; representation?

(prn "A: Very little. Only the selectors would need to be changed, 
and then only by removing the car function call.")