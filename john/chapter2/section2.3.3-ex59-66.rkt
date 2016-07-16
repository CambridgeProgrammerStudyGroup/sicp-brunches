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

