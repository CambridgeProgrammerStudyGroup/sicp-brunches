#lang racket
(require "../utils.scm")

;   Exercise 2.63
;   =============
;
;   Each of the following two procedures converts a binary tree to a list.
;
   (define (tree->list-1 tree)
     (if (null? tree)
         '()
         (append (tree->list-1 (left-branch tree))
                 (cons (entry tree)
                       (tree->list-1 (right-branch tree))))))

   (define (tree->list-2 tree)
     (define (copy-to-list tree result-list)
       (if (null? tree)
           result-list
           (copy-to-list (left-branch tree)
                         (cons (entry tree)
                               (copy-to-list (right-branch tree)
                                             result-list)))))
     (copy-to-list tree '()))
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

(define (entry tree) (car tree))
(define (left-branch tree) (cadr tree))
(define (right-branch tree) (caddr tree))

(define (make-tree entry left right)
  (list entry left right))

(define (element-of-set? x set)
  (cond ((null? set) false)
        ((= x (entry set)) true)
        ((< x (entry set))
         (element-of-set? x (left-branch set)))
        ((> x (entry set))
         (element-of-set? x (right-branch set)))))

(define (adjoin-set x set)
  (cond ((null? set) (make-tree x '() '()))
        ((= x (entry set)) set)
        ((< x (entry set))
         (make-tree (entry set)
                    (adjoin-set x (left-branch set))
                    (right-branch set)))
        ((> x (entry set))
         (make-tree (entry set)
                    (left-branch set)
                    (adjoin-set x (right-branch set))))))




(module* main #f
  (title "Exercise 2.63")

  (Q: "a. Do the two procedures produce the same result for every tree?  If
not, how do the results differ?  What lists do the two procedures
produce for the trees in figure [2.16]?")

  (A: "Yes. Both procedures will return the same values given the same tree.
Given the same sets, the procedures will return the same lists,
and this will be true no matter how the trees are balanced.")

  (define tree-1
    '(7
      (3
        (1 () ())
        (5 () ()))
      (9
        ()
        (11 () ()))))

  (define tree-2
    '(3
      (1 () ())
      (7
        (5 () ())
        (9
          ()
          (11 () ())))))

  (define tree-3
    '(5
      (3
        (1 () ())
        ())
      (9
        (7 () ())
        (11 () ()))))

  (define expected '(1 3 5 7 9 11))

  (assertequal? "Both procedures will return the same for tree-1"
    (tree->list-1 tree-1)
    (tree->list-2 tree-1))

  (assertequal? "Both procedures will return the same for tree-2"
    (tree->list-1 tree-2)
    (tree->list-2 tree-2))

  (assertequal? "Both procedures will return the same for tree-3"
    (tree->list-1 tree-3)
    (tree->list-2 tree-3))

  (for-each
    (λ (tree)
      (for-each (λ (fn)
        (assertequal? (str (object-name fn) " returns as expected for " tree)
          expected (fn tree)))
            (list tree->list-1 tree->list-2)))
    (list tree-1 tree-2 tree-3))

    (Q: "b. Do the two procedures have the same order of growth in the number of
steps required to convert a balanced tree with n elements to a list? If
not, which one grows more slowly?")

  (A: "`tree->list-2` will grow more slowly. It will visit each element in
the tree once (both functions do) but creates the resulting list using
`cons` which has O(1) complexity, whereas `tree->list-2` will use `append`
which has O(n) complexity. ")

)
