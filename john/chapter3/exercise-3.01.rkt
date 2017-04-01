#lang racket

(require "common.rkt")

;   Exercise 3.1
;   ============
;   
;   An accumulator is a procedure that is called repeatedly with a single
;   numeric argument and accumulates its arguments into a sum. Each time it
;   is called, it returns the currently accumulated sum. Write a procedure
;   make-accumulator that generates accumulators, each maintaining an
;   independent sum.  The input to make-accumulator should specify the
;   initial value of the sum; for example
;   
;   (define A (make-accumulator 5))
;   (A 10)
;   15
;   (A 10)
;   25
;   
;   ------------------------------------------------------------------------
;   [Exercise 3.1]:  http://sicp-book.com/book-Z-H-20.html#%_thm_3.1
;   3.1.1 Local State Variables - p224
;   ------------------------------------------------------------------------

(-start- "3.1")



(--end-- "3.1")

