#lang racket
(require "../utils.scm")

;   Exercise 2.59
;   =============
;
;   Implement the union-set operation for the unordered-list representation
;   of sets.
;
;   ------------------------------------------------------------------------
;   [Exercise 2.59]: http://sicp-book.com/book-Z-H-16.html#%_thm_2.59
;   2.3.3 Example: Representing Sets - p153
;   ------------------------------------------------------------------------
(define (make-set . args)
  (define (inner set vals)
    (if (empty? vals) set
      (inner (adjoin-set (car vals) set) (rest vals))))
  (if (empty? args) '() (inner '() args)))

(define (element-of-set? x set)
  (cond ((null? set) false)
        ((equal? x (car set)) true)
        (else (element-of-set? x (cdr set)))))

(define (adjoin-set x set)
  (if (element-of-set? x set)
      set
      (cons x set)))

(define (intersection-set set1 set2)
  (cond ((or (null? set1) (null? set2)) '())
        ((element-of-set? (car set1) set2)
         (cons (car set1)
               (intersection-set (cdr set1) set2)))
        (else (intersection-set (cdr set1) set2))))

(module* main #f
  (title "Exercise 2.59")

  (define (union-set set1 set2)
    (if (empty? set2)
      set1
      (union-set (adjoin-set (first set2) set1) (rest set2))))

  (assert "Adding an element to a set will mean it is then present in the set"
    (element-of-set? 'a (adjoin-set 'a (make-set))))

  (let* (
      (A (make-set 1 2 3))
      (B (make-set 4 5 6))
      (U (union-set A B)))
    (assert "The union of two sets will include elements from both"
      (and (element-of-set? 1 U) (element-of-set? 6 U))))
)
