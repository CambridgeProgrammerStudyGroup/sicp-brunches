#lang racket
(require "../utils.scm")
(require "./exercise-2.61.scm")

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

(module* main #f
  (title "Exercise 2.62 - Sets as ordered lists")

  (define (union-set A B)
    (cond
      [(empty? A) B]
      [(empty? B) A]
      [else
        (let* [
          (a (first A))
          (b (first B))
          (rA (rest A))
          (rB (rest B))]
          (cond
            [(= a b) (cons a (union-set rA rB))]
            [(< a b) (cons a (union-set rA B))]
            [else (cons b (union-set A rB))]))]))

    (assertequal? "Values will be ordered when sets are joined"
      '(1 2 3 4 5 6) (union-set '(1 3 5) '(2 4 6)))

)
