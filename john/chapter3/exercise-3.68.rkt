#lang racket

(require "common.rkt")

;   Exercise 3.68
;   =============
;   
;   Louis Reasoner thinks that building a stream of pairs from three parts
;   is unnecessarily complicated.  Instead of separating the pair (S₀,T₀)
;   from the rest of the pairs in the first row, he proposes to work with
;   the whole first row, as follows:
;   
;   (define (pairs s t)
;     (interleave
;      (stream-map (lambda (x) (list (stream-car s) x))
;                  t)
;      (pairs (stream-cdr s) (stream-cdr t))))
;   
;   Does this work?  Consider what happens if we evaluate (pairs integers
;   integers) using Louis's definition of pairs.
;   
;   ------------------------------------------------------------------------
;   [Exercise 3.68]: http://sicp-book.com/book-Z-H-24.html#%_thm_3.68
;   3.5.3 Exploiting the Stream Paradigm - p341
;   ------------------------------------------------------------------------

(-start- "3.68")



(--end-- "3.68")

