#lang racket
(require "../utils.scm")

(provide (all-defined-out))

; Exercise 2.46: 
; A two-dimensional vector v running from 
; the origin to a point can be represented 
; as a pair consisting of an x-coordinate 
; and a y-coordinate. 
; 
; Implement a data abstraction for vectors 
; by giving a constructor make-vect and 
; corresponding selectors xcor-vect and 
; ycor-vect. In terms of your selectors 
; and constructor, implement procedures 
; add-vect, sub-vect, and scale-vect that 
; perform the operations vector addition, 
; vector subtraction, and multiplying 
; a vector by a scalar:
; 
; (x1,y1)+(x2,y2)=(x1 +x2,y1 +y2), 
; (x1,y1)−(x2,y2)=(x1 −x2,y1 −y2),
; s · (x , y) = (sx , sy).

(define (make-vect . cs)
	cs)

(define (xcor-vect v)
	(first v))

(define (ycor-vect v)
	(second v))

(define (add-vect v1 v2)
	(map + v1 v2))

(define (sub-vect v1 v2)
	(map - v1 v2))

(define (scale-vect s v)
	(map (lambda (vi) (* s vi)) v))

(let* 
	(
		(A (make-vect 3 5))
		(B (make-vect 7 9))
		(s 3)
		(sA (make-vect 9 15))
		(A-B (make-vect -4 -4))
		(A+B (make-vect 10 14))
	)
	(assert "We can get the x-coordinate of a vector" (= (xcor-vect A) 3))
	(assert "We can get the y-coordinate of a vector" (= (ycor-vect A) 5))
	(assert "We can add two vectors together" (equal? (add-vect A B) A+B))
	(assert "We can subtract two vectors" (equal? (sub-vect A B) A-B))
	(assert "We can scale a vector" (equal? (scale-vect s A) sA))
)
