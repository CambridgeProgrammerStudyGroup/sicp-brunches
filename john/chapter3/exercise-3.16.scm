#lang sicp

(#%require "common.scm")

;   Exercise 3.16
;   =============
;   
;   Ben Bitdiddle decides to write a procedure to count the number of pairs
;   in any list structure.  "It's easy," he reasons.  "The number of pairs
;   in any structure is the number in the car plus the number in the cdr
;   plus one more to count the current pair." So Ben writes the following
;   procedure:
;   
;   (define (count-pairs x)
;     (if (not (pair? x))
;         0
;         (+ (count-pairs (car x))
;            (count-pairs (cdr x))
;            1)))
;   
;   Show that this procedure is not correct.  In particular, draw
;   box-and-pointer diagrams representing list structures made up of exactly
;   three pairs for which Ben's procedure would return 3; return 4; return
;   7; never return at all.
;   
;   ------------------------------------------------------------------------
;   [Exercise 3.16]: http://sicp-book.com/book-Z-H-22.html#%_thm_3.16
;   3.3.1 Mutable List Structure - p259
;   ------------------------------------------------------------------------

(-start- "3.16")



(--end-- "3.16")

