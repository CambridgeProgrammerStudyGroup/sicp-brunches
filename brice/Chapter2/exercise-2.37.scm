#lang racket
(require "../utils.scm")
(require "../meta.scm")

(title "Exercise 2.37")


; Exercise 2.37: Suppose we represent vectors v = (vi ) as
; sequences of numbers, and matrices m = (mij ) as sequences
; of vectors (the rows of the matrix). For example, the matrix
; 
;     1 2 3 4
;     6 7 8 9 
;     4 5 6 6
; 
; is represented as the sequence 
; 
;     ((1 2 3 4) (4 5 6 6) (6 7 8 9))
;
; With this representation, we can use sequence operations to 
; concisely express the basic matrix and vector operations. 
; These operations (which are described in any book on matrix 
; algebra) are the following:
;
;     (dot-product v w) 	-> returns the sum Σiviwi
;     (matrix-*-vector m v)	-> returns the vector t, where ti = Σjmijvj
;     (matrix-*-matrix m n) -> returns the matrix p, where pij = Σkmiknkj
;     (transpose m)			-> returns the matrix n, where nij = mji.
;
; We can define the dot product as 
;
    (define (dot-product v w)
          (accumulate + 0 (map * v w)))
;
; Fill in the missing expressions in the following procedures for 
; computing the other matrix operations. (The procedure accumulate-n 
; is defined in Exercise 2.36.)

(define (matrix-*-vector m v)
  (map 
  	(lambda (row) (accumulate + 0 (map * row (flatten v))))
  	m))

(define (transpose mat)
  	(apply zip mat))

(define (matrix-*-matrix m n)
  (let ((cols (transpose n)))
    (map 
    	(lambda (row)
    		(map 
    			(lambda (col)
    				(apply + (map (lambda (x) (apply * x)) (zip row col))))
    			cols))
    	m)))


(let* (
	(A '((1 2 3) 
		 (4 5 6) 
		 (6 7 8)))
	(B '((1 2)
		 (3 4)
		 (5 6)))
	(BT '((1 3 5)
		  (2 4 6)))
	(Vr '((1 2 3)))
	(Vc '((1)
		  (2)
		  (3)))
	(AVc (list (+ 1 4 9) (+ 4 10 18) (+ 6 14 24)))
	(VrVc '(14))
	(VcVr '((1 2 3)
		    (2 4 6)
		    (3 6 9)))
	(BBT '(( 5 11 17)
		   (11 25 39)
		   (17 39 61)))
	(BTB '((35 44)
		   (44 56)))
	)

	; Note well, here I choose to  distinguish between column and row vectors
	; The book does not make this distinction, and assumes that row vectors
	; are represented in terms of a simple list.
	(assert "We can flatten a one-deep list"
		(equal? (flatten '((1)(2)(3))) '(1 2 3)))	
	(assert "We can zip two lists together"
		(equal? (zip '(1 2 3) '(1 2 3)) '((1 1) (2 2) (3 3))))
	(assert "We can multiply a matrix by a column vector" 
		(equal? (matrix-*-vector A Vc) AVc))
	(assertequal? "We can multiply a row vector by a column vector"
		VrVc (matrix-*-vector Vr Vc))
	(assertequal? "We can transpose a matrix" 
		BT (transpose B))
	(assert "We can multiply two matrices together (a)"
		(equal? (matrix-*-matrix B BT) BBT))
	(assertequal? "We can multiply a column vector by a row vector"
		 VcVr (matrix-*-matrix Vc Vr))
	(assertequal? "We can multiply two matrices together (b)"
		BTB (matrix-*-matrix BT B))

)







