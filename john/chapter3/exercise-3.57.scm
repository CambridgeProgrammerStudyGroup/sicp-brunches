#lang sicp

(#%require "common.scm")

;   Exercise 3.57
;   =============
;   
;   How many additions are performed when we compute the nth Fibonacci
;   number using the definition of fibs based on the add-streams procedure? 
;   Show that the number of additions would be exponentially greater if we
;   had implemented (delay <exp>) simply as (lambda () <exp>), without using
;   the optimization provided by the memo-proc procedure described in
;   section [3.5.1].⁽⁶⁴⁾
;   
;   ------------------------------------------------------------------------
;   [Exercise 3.57]: http://sicp-book.com/book-Z-H-24.html#%_thm_3.57
;   [Section 3.5.1]: http://sicp-book.com/book-Z-H-24.html#%_sec_3.5.1
;   [Footnote 64]:   http://sicp-book.com/book-Z-H-24.html#footnote_Temp_465
;   3.5.2 Infinite Streams - p332
;   ------------------------------------------------------------------------

(-start- "3.57")



(--end-- "3.57")

