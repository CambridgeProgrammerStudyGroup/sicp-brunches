#lang sicp

(#%require "common.scm")

;   Exercise 3.64
;   =============
;   
;   Write a procedure stream-limit that takes as arguments a stream and a
;   number (the tolerance).  It should examine the stream until it finds two
;   successive elements that differ in absolute value by less than the
;   tolerance, and return the second of the two elements.  Using this, we
;   could compute square roots up to a given tolerance by
;   
;   (define (sqrt x tolerance)
;     (stream-limit (sqrt-stream x) tolerance))
;   
;   ------------------------------------------------------------------------
;   [Exercise 3.64]: http://sicp-book.com/book-Z-H-24.html#%_thm_3.64
;   3.5.3 Exploiting the Stream Paradigm - p338
;   ------------------------------------------------------------------------

(-start- "3.64")



(--end-- "3.64")

