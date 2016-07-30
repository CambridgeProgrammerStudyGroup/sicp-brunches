#lang racket
(require "../utils.scm")
(provide (all-defined-out))
;   Exercise 2.61
;   =============
;
;   Give an implementation of adjoin-set using the ordered representation.
;   By analogy with element-of-set? show how to take advantage of the
;   ordering to produce a procedure that requires on the average about half
;   as many steps as with the unordered representation.
;
;   ------------------------------------------------------------------------
;   [Exercise 2.61]: http://sicp-book.com/book-Z-H-16.html#%_thm_2.61
;   2.3.3 Example: Representing Sets - p155
;   ------------------------------------------------------------------------

(define (make-set) '())

(define (element-of-set? x set)
  (cond ((null? set) false)
        ((= x (car set)) true)
        ((< x (car set)) false)
        (else (element-of-set? x (cdr set)))))

(define (adjoin-set x set)
  (cond
    ((null? set) (list x))
    ((= x (car set)) set)
    ((< x (car set)) (cons x set))
    (else (cons (first set) (adjoin-set x (rest set))))))

(define (intersection-set set1 set2)
  (if (or (null? set1) (null? set2))
      '()
      (let ((x1 (car set1)) (x2 (car set2)))
        (cond ((= x1 x2)
               (cons x1
                     (intersection-set (cdr set1)
                                       (cdr set2))))
              ((< x1 x2)
               (intersection-set (cdr set1) set2))
              ((< x2 x1)
               (intersection-set set1 (cdr set2)))))))

(module* main #f
  (title "Exercise 2.61 - Sets as ordered lists")

  (let* (
      (A '(1 2 3))
      (B '(3 4 5))
      (I (intersection-set A B)))

      (assert "Adding an element to a set will mean it is then present in the set"
        (element-of-set? 1 (adjoin-set 1 (make-set))))

      (assertequal? "Adding an element will place it in the right place in the ordered set"
        '(1 2 3) (adjoin-set 2 '(1 3)))

      (assert "The intersection will include common elements"
        (element-of-set? 3 I))

      (assert "The intersection will not include elements not in common"
        (and (not (element-of-set? 1 I)) (not (element-of-set? 5 I))))
  )
)
