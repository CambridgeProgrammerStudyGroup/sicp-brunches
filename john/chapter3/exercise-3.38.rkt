#lang racket

(require "common.rkt")

;   Exercise 3.38
;   =============
;   
;   Suppose that Peter, Paul, and Mary share a joint bank account that
;   initially contains $100.  Concurrently, Peter deposits $10, Paul
;   withdraws $20, and Mary withdraws half the money in the account, by
;   executing the following commands:
;   
;   Peter: (set! balance (+ balance 10))           
;   Paul:  (set! balance (- balance 20))           
;   Mary:  (set! balance (- balance (/ balance 2)))
;   
;   a. List all the different possible values for balance after these three
;   transactions have been completed, assuming that the banking system
;   forces the three processes to run sequentially in some order.
;   
;   b. What are some other values that could be produced if the system
;   allows the processes to be interleaved? Draw timing diagrams like the
;   one in figure [3.29] to explain how these values can occur.
;   
;   ------------------------------------------------------------------------
;   [Exercise 3.38]: http://sicp-book.com/book-Z-H-23.html#%_thm_3.38
;   [Figure 3.29]:   http://sicp-book.com/book-Z-H-23.html#%_fig_3.29
;   3.4.1 The Nature of Time in Concurrent Systems - p303
;   ------------------------------------------------------------------------

(-start- "3.38")



(--end-- "3.38")

