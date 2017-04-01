#lang racket

(require "common.rkt")

;   Exercise 3.13
;   =============
;   
;   Consider the following make-cycle procedure, which uses the last-pair
;   procedure defined in exercise [3.12]:
;   
;   (define (make-cycle x)
;     (set-cdr! (last-pair x) x)
;     x)
;   
;   Draw a box-and-pointer diagram that shows the structure z created by
;   
;   (define z (make-cycle (list 'a 'b 'c)))
;   
;   What happens if we try to compute (last-pair z)?
;   
;   ------------------------------------------------------------------------
;   [Exercise 3.13]: http://sicp-book.com/book-Z-H-22.html#%_thm_3.13
;   [Exercise 3.12]: http://sicp-book.com/book-Z-H-22.html#%_thm_3.12
;   3.3.1 Mutable List Structure - p256
;   ------------------------------------------------------------------------

(-start- "3.13")



(--end-- "3.13")

