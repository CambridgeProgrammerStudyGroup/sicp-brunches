#lang racket
(require "../utils.scm")

(require (only-in "./exercise-2.61.scm" [intersection-set intersection-list]))
(require (only-in "./exercise-2.62.scm" [union-set union-list]))
(require (only-in "./exercise-2.63.scm" [tree->list-2 tree->list]))
(require "./exercise-2.64.scm")


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

(define (union-set A B)
  (list->tree (union-list (tree->list A) (tree->list B))))

(define (intersection-set A B)
  (list->tree (intersection-list (tree->list A) (tree->list B))))

(module* main #f
  (title "Exercise 2.65")

  (define set-A (list->tree '(1 3 5 7 9)))
  (define set-B (list->tree '(2 4 6 8 10)))
  (define set-C (list->tree '(3 4 6 8 9)))
  (define set-D (list->tree '(2 3 6 7 9)))


  (assertequal? "We can find the union of two sets represented as trees"
    (list->tree '(1 2 3 4 5 6 7 8 9 10))
    (union-set set-A set-B))

  (assertequal? "We can find the intersection of two sets represented as trees"
    (list->tree '(3 6 9))
    (intersection-set set-D set-C))


)
