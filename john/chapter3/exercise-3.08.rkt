#lang racket

(require "common.rkt")

;   Exercise 3.8
;   ============
;   
;   When we defined the evaluation model in section [1.1.3], we said that
;   the first step in evaluating an expression is to evaluate its
;   subexpressions.  But we never specified the order in which the
;   subexpressions should be evaluated (e.g., left to right or right to
;   left).  When we introduce assignment, the order in which the arguments
;   to a procedure are evaluated can make a difference to the result. 
;   Define a simple procedure f such that evaluating (+ (f 0) (f 1)) will
;   return 0 if the arguments to + are evaluated from left to right but will
;   return 1 if the arguments are evaluated from right to left.
;   
;   ------------------------------------------------------------------------
;   [Exercise 3.8]:  http://sicp-book.com/book-Z-H-20.html#%_thm_3.8
;   [Section 1.1.3]: http://sicp-book.com/book-Z-H-10.html#%_sec_1.1.3
;   3.1.3 The Costs of Introducing Assignment - p236
;   ------------------------------------------------------------------------

(-start- "3.8")



(--end-- "3.8")

