#lang racket

(require "common.rkt")

;   Exercise 3.48
;   =============
;   
;   Explain in detail why the deadlock-avoidance method described above,
;   (i.e., the accounts are numbered, and each process attempts to acquire
;   the smaller-numbered account first) avoids deadlock in the exchange
;   problem.  Rewrite serialized-exchange to incorporate this idea. (You
;   will also need to modify make-account so that each account is created
;   with a number, which can be accessed by sending an appropriate message.)
;   
;   ------------------------------------------------------------------------
;   [Exercise 3.48]: http://sicp-book.com/book-Z-H-23.html#%_thm_3.48
;   3.4.2 Mechanisms for Controlling Concurrency - p314
;   ------------------------------------------------------------------------

(-start- "3.48")



(--end-- "3.48")

