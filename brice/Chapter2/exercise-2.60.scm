#lang racket
(require "../utils.scm")
(require "../meta.scm")

;   Exercise 2.60
;   =============
;
;   We specified that a set would be represented as a list with no
;   duplicates.  Now suppose we allow duplicates.  For instance, the set
;   {1,2,3} could be represented as the list (2 3 2 1 3 2 2).  Design
;   procedures element-of-set?, adjoin-set, union-set, and intersection-set
;   that operate on this representation.  How does the efficiency of each
;   compare with the corresponding procedure for the non-duplicate
;   representation?  Are there applications for which you would use this
;   representation in preference to the non-duplicate one?
;
;   ------------------------------------------------------------------------
;   [Exercise 2.60]: http://sicp-book.com/book-Z-H-16.html#%_thm_2.60
;   2.3.3 Example: Representing Sets - p153
;   ------------------------------------------------------------------------

(define (make-set . args)
  args)

(define (element-of-set? x set)
  (cond ((null? set) false)
        ((equal? x (car set)) true)
        (else (element-of-set? x (cdr set)))))

(define (adjoin-set x set)
  (cons x set))

(define (union-set set1 set2)
  (append set1 set2))

(define (intersection-set set1 set2)
  (cond ((or (null? set1) (null? set2)) '())
        ((element-of-set? (car set1) set2)
         (cons (car set1)
               (intersection-set (cdr set1) set2)))
        (else (intersection-set (cdr set1) set2))))


(module* main #f
  (title "Exercise 2.60 - Sets with Duplicates")

  (let* (
      (A '(1 2 3))
      (B '(3 4 5))
      (U (union-set A B))
      (I (intersection-set A B)))

      (assert "Adding an element to a set will mean it is then present in the set"
        (element-of-set? 'a (adjoin-set 'a (make-set))))

      (assert "The union of two sets will include elements from both"
        (and (element-of-set? 1 U) (element-of-set? 5 U)))

      (assert "The intersection will include common elements"
        (element-of-set? 3 I))

      (assert "The intersection will not include elements not in common"
        (and (not (element-of-set? 1 I)) (not (element-of-set? 5 I))))
  )

  (newline)

  (Q:
"How does the efficiency of each compare with the corresponding
procedure for the non-duplicate representation?")
  (A:
"For unique lists the cost of operations are as follows (worst-case)

       element-of-set?  - O(n)
       adjoin-set       - O(n)
       union-set        - O(n^2)
       intersection-set - O(n^2)

For the duplicate representation, the costs of operations are as follows:

       element-of-set?  - O(n)      Note: More expensive with duplicates
       adjoin-set       - O(1)
       union-set        - O(1)
       intersection-set - O(n^2)    Note: More expensive with duplicates")

  (Q:
"Are there applications for which you would use this representation
in preference to the non-duplicate one?")
  (A:
"Yes, operations that require fast additions would benefit from
this representation, especially on longer sets. Membership tests
are more expensive, and the additional cost will be proportional
to the frequency of duplication. Thus this representation is
particularly well suited to applications where there is low
duplication and only occasional membership tests. For example, a
set of randomly generated identifiers for manufactured goods,
where membership tests for batches (sets) only occurs when a
defect has been found.")

)
