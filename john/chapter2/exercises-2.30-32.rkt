#lang racket

; Flotsam and Jetsam from working through Chapter 2.

; 2.2.2  Hierarchical Structures - Mapping over Trees
; ===================================================

; https://mitpress.mit.edu/sicp/full-text/book/book-Z-H-15.html#%_sec_2.2.1

(require "util-v1.rkt")

;#########################################################################
;#########################################################################
(ti "Exercise 2.30")

; Exercise 2.30.  Define a procedure square-tree analogous to the square-
; list procedure of exercise 2.21. That is, square-list should behave as
; follows:
; 
; (square-tree
;  (list 1
;        (list 2 (list 3 4) 5)
;        (list 6 7)))
; (1 (4 (9 16) 25) (36 49))
; 
; Define square-tree both directly (i.e., without using any higher-order
; procedures) and also by using map and recursion.

(define (square n) (* n n))

(define (square-tree tree)
  (cond ((null? tree) null)
        ((pair? tree)
         (cons (square-tree (car tree)) (square-tree (cdr tree))))
        (else (square tree))))

(let ((tree (list 1
                  (list 2 (list 3 4) 5)
                  (list 6 7))))
  (prn
   (str "square-tree:")
   (str "  Tree: " tree)
   (str "  Expected: (1 (4 (9 16) 25) (36 49))")
   (str "  Got:      " (square-tree tree))))

;#########################################################################
;#########################################################################

(ti "Exercise 2.31")

; Exercise 2.31.  Abstract your answer to exercise 2.30 to produce a
; procedure tree-map with the property that square-tree could be defined
; as
; 
; (define (square-tree tree) (tree-map square tree))

(define (tree-map func tree)
  (cond ((null? tree) null)
        ((pair? tree)
         (cons (tree-map func (car tree))
               (tree-map func (cdr tree))))
        (else (func tree))))

(let ((tree (list 1
                  (list 2 (list 3 4) 5)
                  (list 6 7))))
  (prn
   (str "tree-map:")
   (str "  Tree: " tree)
   (str "  Expected: (1 (4 (9 16) 25) (36 49))")
   (str "  Got:      " (tree-map square tree))))

;#########################################################################
;#########################################################################

(ti "Exercises 2.32")

; Exercise 2.32.  We can represent a set as a list of distinct elements,
; and we can represent the set of all subsets of the set as a list of
; lists. For example, if the set is (1 2 3), then the set of all subsets
; is (() (3) (2) (2 3) (1) (1 3) (1 2) (1 2 3)). Complete the following
; definition of a procedure that generates the set of subsets of a set and
; give a clear explanation of why it works:
; 
; (define (subsets s)
;   (if (null? s)
;       (list nil)
;       (let ((rest (subsets (cdr s))))
;         (append rest (map <??> rest)))))

(define (subsets s)
  (if (null? s)
      (list null)
      (let ((rest (subsets (cdr s))))
        (append rest (map
                      (lambda (r) (cons (car s) r))
                      rest)))))

(let ((s (list 1 2 3)))
  (prn
   (str "subsets:")
   (str " set: " s)
   (str " expected: (() (3) (2) (2 3) (1) (1 3) (1 2) (1 2 3))")
   (str " got:      " (subsets s))))

;#########################################################################
;#########################################################################


