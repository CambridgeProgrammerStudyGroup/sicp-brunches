#lang sicp

(#%require "common.scm")

;   Exercise 3.76
;   =============
;   
;   Eva Lu Ator has a criticism of Louis's approach in exercise [3.75].  The
;   program he wrote is not modular, because it intermixes the operation of
;   smoothing with the zero-crossing extraction.  For example, the extractor
;   should not have to be changed if Alyssa finds a better way to condition
;   her input signal.  Help Louis by writing a procedure smooth that takes a
;   stream as input and produces a stream in which each element is the
;   average of two successive input stream elements.  Then use smooth as a
;   component to implement the zero-crossing detector in a more modular
;   style.
;   
;   ------------------------------------------------------------------------
;   [Exercise 3.76]: http://sicp-book.com/book-Z-H-24.html#%_thm_3.76
;   [Exercise 3.75]: http://sicp-book.com/book-Z-H-24.html#%_thm_3.75
;   3.5.3 Exploiting the Stream Paradigm - p346
;   ------------------------------------------------------------------------

(-start- "3.76")



(--end-- "3.76")

