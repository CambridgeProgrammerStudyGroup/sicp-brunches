#lang racket

; Section 1.3.2: Constructing Procedures Using <tt>Lambda</tt>

(require "common.rkt")

;   Exercise 1.34
;   =============
;   
;   Suppose we define the procedure
;   
;   (define (f g)
;     (g 2))
;   
;   Then we have
;   
;   (f square)
;   4
;   
;   (f (lambda (z) (* z (+ z 1))))
;   6
;   
;   What happens if we (perversely) ask the interpreter to evaluate the
;   combination (f f)?  Explain.
;   
;   ------------------------------------------------------------------------
;   [Exercise 1.34]: http://sicp-book.com/book-Z-H-12.html#%_thm_1.34
;   1.3.2 Constructing Procedures Using <tt>Lambda</tt> - p66
;   ------------------------------------------------------------------------

(-start- "1.34")



(--end-- "1.34")

