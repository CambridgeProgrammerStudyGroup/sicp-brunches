#lang racket

(require "common.rkt")

;   Exercise 3.3
;   ============
;   
;   Modify the make-account procedure so that it creates password-protected
;   accounts.  That is, make-account should take a symbol as an additional
;   argument, as in
;   
;   (define acc (make-account 100 'secret-password))
;   
;   The resulting account object should process a request only if it is
;   accompanied by the password with which the account was created, and
;   should otherwise return a complaint:
;   
;   ((acc 'secret-password 'withdraw) 40)
;   60
;   
;   ((acc 'some-other-password 'deposit) 50)
;   
;   "Incorrect password"
;   
;   ------------------------------------------------------------------------
;   [Exercise 3.3]:  http://sicp-book.com/book-Z-H-20.html#%_thm_3.3
;   3.1.1 Local State Variables - p225
;   ------------------------------------------------------------------------

(-start- "3.3")



(--end-- "3.3")

