#lang sicp

(#%require "common.scm")

;   Exercise 3.20
;   =============
;   
;   Draw environment diagrams to illustrate the evaluation of the sequence
;   of expressions
;   
;   (define x (cons 1 2))
;   (define z (cons x x))
;   (set-car! (cdr z) 17)
;   (car x)
;   17
;   
;   using the procedural implementation of pairs given above.  (Compare
;   exercise [3.11].)
;   
;   ------------------------------------------------------------------------
;   [Exercise 3.20]: http://sicp-book.com/book-Z-H-22.html#%_thm_3.20
;   [Exercise 3.11]: http://sicp-book.com/book-Z-H-22.html#%_thm_3.11
;   3.3.1 Mutable List Structure - p261
;   ------------------------------------------------------------------------

(-start- "3.20")



(--end-- "3.20")

