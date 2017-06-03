#lang sicp

(#%require "common.scm")

;   Exercise 3.26
;   =============
;   
;   To search a table as implemented above, one needs to scan through the
;   list of records.  This is basically the unordered list representation of
;   section [2.3.3].  For large tables, it may be more efficient to
;   structure the table in a different manner.  Describe a table
;   implementation where the (key, value) records are organized using a
;   binary tree, assuming that keys can be ordered in some way (e.g.,
;   numerically or alphabetically).  (Compare exercise [2.66] of chapter 2.)
;   
;   ------------------------------------------------------------------------
;   [Exercise 3.26]: http://sicp-book.com/book-Z-H-22.html#%_thm_3.26
;   [Section 2.3.3]: http://sicp-book.com/book-Z-H-16.html#%_sec_2.3.3
;   [Exercise 2.66]: http://sicp-book.com/book-Z-H-22.html#%_thm_2.66
;   3.3.3 Representing Tables - p272
;   ------------------------------------------------------------------------

(-start- "3.26")



(--end-- "3.26")

