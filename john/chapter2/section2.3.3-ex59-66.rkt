#lang racket

; Section 2.3.3: Example: Representing Sets

(require "common.rkt")

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

(-start- "2.59")

(define (element-of-set? x set)
  (if (empty? set)
      #false
      (if (equal? x (car set))
          #true
          (element-of-set? x (cdr set)))))

(define (union-set set1 set2)
  (if (empty? set2)
      set1
      (union-set
       (if (element-of-set? (car set2) set1)
           set1
           (cons (car set2) set1))
       (cdr set2))))

(present-compare union-set
                 (list (list '(1 2 3) '(4 5 6)) '(1 2 3 4 5 6))
                 (list (list '(1 2 3) '(1 2 3)) '(1 2 3))
                 (list (list '(1 2 3) '(2 3 4)) '(4 1 2 3)))

(--end-- "2.59")

;   ========================================================================
;   
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

(-start- "2.60")

; duplicate ignoring adjoin
(define (adjoin-set-dup x set2)
  (cons x set2))

; duplicate ignoring union
(define (union-set-dup set1 set2)
  (append set1 set2))

; regular intersection
(define (intersection-set set1 set2)
  (if (or (empty? set1) (empty? set2))
      '()
      (if (element-of-set? (car set2) set1)
          (cons (car set2) (intersection-set set1 (cdr set2)))
          (intersection-set set1 (cdr set2)))))
                
      
(present-compare intersection-set
                 (list (list '(1 1 2 2) '(2 2 3 3)) '(2 2)))

(present-compare adjoin-set-dup
                 (list (list 3 '(3)) '(3 3)))

(present-compare union-set-dup
                 (list (list '(1 2 3) '(4 5 6)) '(1 2 3 4 5 6 ))
                 (list (list '(1 2 3) '(1 2 3)) '(1 2 3 1 2 3))
                 (list (list '(1 2 3) '(2 3 4)) '(1 2 3 2 3 4)))

(prn
 "The adjoin and union functions are much faster ( O(1)? ) so this
implementation might be desireable if a process does a lot of unions.
Intersection will be slower, because the lists are longer, but that
might not be significant if intersections is rarely used or if duplicates
are rare,")

(--end-- "2.60")

;   ========================================================================
;   
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

(-start- "2.61")

(define (adjoin-set-ordered x set)
  (cond ((empty? set) (list x))
        ((< x (car set)) (cons x set))
        ((= x (car set)) set)
        (else (cons (car set) (adjoin-set-ordered x (cdr set))))))

(present-compare adjoin-set-ordered
                 (list (list 5 '()) '(5))
                 (list (list 5 '(6 7)) '(5 6 7))
                 (list (list 5 '(3 4)) '(3 4 5))
                 (list (list 5 '(4 6)) '(4 5 6))
                 (list (list 5 '(4 5 6)) '(4 5 6)))


(--end-- "2.61")

;   ========================================================================
;   
;   Exercise 2.62
;   =============
;   
;   Give a θ(n) implementation of union-set for sets represented as ordered
;   lists.
;   
;   ------------------------------------------------------------------------
;   [Exercise 2.62]: http://sicp-book.com/book-Z-H-16.html#%_thm_2.62
;   2.3.3 Example: Representing Sets - p155
;   ------------------------------------------------------------------------

(-start- "2.62")

(define (union-set-ordered set1 set2)
  (cond ((empty? set1) set2)
        ((empty? set2) set1)
        ((< (car set1) (car set2))
         (cons (car set1) (union-set-ordered (cdr set1) set2)))
        ((= (car set1) (car set2))
         (cons (car set1) (union-set-ordered (cdr set1) (cdr set2))))
        ((> (car set1) (car set2))
         (cons (car set2) (union-set-ordered set1 (cdr set2))))))

(present-compare union-set-ordered
                 (list (list '(1 2 3) '(4 5 6)) '(1 2 3 4 5 6 ))
                 (list (list '(1 2 3) '(1 2 3)) '(1 2 3))
                 (list (list '(1 2 3) '(2 3 4)) '(1 2 3 4)))
         
(--end-- "2.62")

;   ========================================================================
;   
;   Exercise 2.63
;   =============
;   
;   Each of the following two procedures converts a binary tree to a list.
;   
;   (define (tree->list-1 tree)
;     (if (null? tree)
;         '()
;         (append (tree->list-1 (left-branch tree))
;                 (cons (entry tree)
;                       (tree->list-1 (right-branch tree))))))
;   (define (tree->list-2 tree)
;     (define (copy-to-list tree result-list)
;       (if (null? tree)
;           result-list
;           (copy-to-list (left-branch tree)
;                         (cons (entry tree)
;                               (copy-to-list (right-branch tree)
;                                             result-list)))))
;     (copy-to-list tree '()))
;   
;   a. Do the two procedures produce the same result for every tree?  If
;   not, how do the results differ?  What lists do the two procedures
;   produce for the trees in figure [2.16]?
;   
;   b. Do the two procedures have the same order of growth in the number of
;   steps required to convert a balanced tree with n elements to a list? If
;   not, which one grows more slowly?
;   
;   ------------------------------------------------------------------------
;   [Exercise 2.63]: http://sicp-book.com/book-Z-H-16.html#%_thm_2.63
;   [Figure 2.16]:   http://sicp-book.com/book-Z-H-16.html#%_fig_2.16
;   2.3.3 Example: Representing Sets - p158
;   ------------------------------------------------------------------------

(-start- "2.63")

(prn "So, I've got a horrible feeling I'm missing something here, but here are my
pre-google guesses:

  a. Yes, I think they do produce the same result. (It can't be that easy
     can it?).  The  results would just be the order list, e.g.:
         1  3 5  7 9

  b. Yes and No.  Yes, I think the function takes the same number of steps
     in terms of the number of recursive calls as they get called once on
     each node.  However, the first one is much slower because the time
     taken by append increases in proportion to the lenght of the list and
     so the function will be O(n^2).
")

(--end-- "2.63")

;   ========================================================================
;   
;   Exercise 2.64
;   =============
;   
;   The following procedure list->tree converts an ordered list to a
;   balanced binary tree.  The helper procedure partial-tree takes as
;   arguments an integer n and list of at least n elements and constructs a
;   balanced tree containing the first n elements of the list.  The result
;   returned by partial-tree is a pair (formed with cons) whose car is the
;   constructed tree and whose cdr is the list of elements not included in
;   the tree.
;   
;   (define (list->tree elements)
;     (car (partial-tree elements (length elements))))
;   
;   (define (partial-tree elts n)
;     (if (= n 0)
;         (cons '() elts)
;         (let ((left-size (quotient (- n 1) 2)))
;           (let ((left-result (partial-tree elts left-size)))
;             (let ((left-tree (car left-result))
;                   (non-left-elts (cdr left-result))
;                   (right-size (- n (+ left-size 1))))
;               (let ((this-entry (car non-left-elts))
;                     (right-result (partial-tree (cdr non-left-elts)
;                                                 right-size)))
;                 (let ((right-tree (car right-result))
;                       (remaining-elts (cdr right-result)))
;                   (cons (make-tree this-entry left-tree right-tree)
;                         remaining-elts))))))))
;   
;   a. Write a short paragraph explaining as clearly as you can how
;   partial-tree works.  Draw the tree produced by list->tree for the list
;   (1 3 5 7 9 11).
;   
;   b. What is the order of growth in the number of steps required by
;   list->tree to convert a list of n elements?
;   
;   ------------------------------------------------------------------------
;   [Exercise 2.64]: http://sicp-book.com/book-Z-H-16.html#%_thm_2.64
;   2.3.3 Example: Representing Sets - p159
;   ------------------------------------------------------------------------

(-start- "2.64")

(prn "a.  It recursively constructs the left node at each point.  Having
    completed the left tree at any level it then consturcts the right tree
    using the same method and cons-es those trees with the central element
    to return tree.

b.  (My guess...) It's O(n), proportional to the number of elements. Because
    each element requires a node and only one node is created per call to
    the function
")

(--end-- "2.64")

;   ========================================================================
;   
;   Exercise 2.65
;   =============
;   
;   Use the results of exercises [2.63] and [2.64] to give θ(n)
;   implementations of union-set and intersection-set for sets implemented
;   as (balanced) binary trees.⁽⁴¹⁾
;   
;   ------------------------------------------------------------------------
;   [Exercise 2.65]: http://sicp-book.com/book-Z-H-16.html#%_thm_2.65
;   [Exercise 2.63]: http://sicp-book.com/book-Z-H-16.html#%_thm_2.63
;   [Exercise 2.64]: http://sicp-book.com/book-Z-H-16.html#%_thm_2.64
;   [Footnote 41]:   http://sicp-book.com/book-Z-H-16.html#footnote_Temp_254
;   2.3.3 Example: Representing Sets - p160
;   ------------------------------------------------------------------------

(-start- "2.65")

(define (entry tree) (car tree))
(define (left-branch tree) (cadr tree))
(define (right-branch tree) (caddr tree))
(define (make-tree entry left right)
  (list entry left right))

(define (tree->list tree)
  (define (copy-to-list tree result-list)
    (if (null? tree)
        result-list
        (copy-to-list (left-branch tree)
                      (cons (entry tree)
                            (copy-to-list (right-branch tree)
                                          result-list)))))
  (copy-to-list tree '()))

(define (list->tree elements)
  (car (partial-tree elements (length elements))))

(define (partial-tree elts n)
  (if (= n 0)
      (cons '() elts)
      (let ((left-size (quotient (- n 1) 2)))
        (let ((left-result (partial-tree elts left-size)))
          (let ((left-tree (car left-result))
                (non-left-elts (cdr left-result))
                (right-size (- n (+ left-size 1))))
            (let ((this-entry (car non-left-elts))
                  (right-result (partial-tree (cdr non-left-elts)
                                              right-size)))
              (let ((right-tree (car right-result))
                    (remaining-elts (cdr right-result)))
                (cons (make-tree this-entry left-tree right-tree)
                      remaining-elts))))))))

; Ok I spent a while trying to do something that directly manuplated the
; trees rather than converting to ordered lists.  But, I could only think
; of processes that ultimately required to access the elements in order.

(define (union-set-tree set1 set2)
  (list->tree (union-set-ordered
               (tree->list set1)
               (tree->list set2))))

(define (t list) (list->tree list))

(present-compare union-set-tree
                 (list (list (t '(1 2 3)) (t '(4 5 6))) (t '(1 2 3 4 5 6 )))
                 (list (list (t '(1 2 3)) (t '(1 2 3))) (t '(1 2 3)))
                 (list (list (t '(1 2 3)) (t '(2 3 4))) (t '(1 2 3 4))))

(define (intersection-set-tree set1 set2)
  (list->tree (intersection-set
               (tree->list set1)
               (tree->list set2))))

(present-compare intersection-set-tree
                 (list (list (t '(1 2 3)) (t '(4 5 6))) (t '()))
                 (list (list (t '(1 2 3)) (t '(1 2 3))) (t '(1 2 3)))
                 (list (list (t '(1 2 3)) (t '(2 3 4))) (t '(2 3))))

(--end-- "2.65")

;   ========================================================================
;   
;   Exercise 2.66
;   =============
;   
;   Implement the lookup procedure for the case where the set of records is
;   structured as a binary tree, ordered by the numerical values of the
;   keys.
;   
;   ------------------------------------------------------------------------
;   [Exercise 2.66]: http://sicp-book.com/book-Z-H-16.html#%_thm_2.66
;   2.3.3 Example: Representing Sets - p161
;   ------------------------------------------------------------------------

(-start- "2.66")



(--end-- "2.66")

