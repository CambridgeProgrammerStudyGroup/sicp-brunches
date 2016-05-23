#lang racket

; Section 2.3.1: Quotation

(require "common.rkt")

;   Exercise 2.53
;   =============
;   
;   What would the interpreter print in response to evaluating each of the
;   following expressions?
;   
;   (list 'a 'b 'c)
;   
;   (list (list 'george))
;   (cdr '((x1 x2) (y1 y2)))
;   
;   (cadr '((x1 x2) (y1 y2)))
;   (pair? (car '(a short list)))
;   (memq 'red '((red shoes) (blue socks)))
;   
;   (memq 'red '(red shoes blue socks))
;   
;   ------------------------------------------------------------------------
;   [Exercise 2.53]: http://sicp-book.com/book-Z-H-16.html#%_thm_2.53
;   2.3.1 Quotation - p144
;   ------------------------------------------------------------------------

(-start- "2.53")

(present-compare identity
                 (list (list (list 'a 'b 'c))  "(a b c)")
                 (list (list (list (list 'george)))  "((george))")
                 (list (list (cdr '((x1 x2) (y1 y2))))  "((y1 y2})")
                 (list (list (cadr '((x1 x2) (y1 y2))))  "contract violation")
                 (list (list (pair? (car '(a short list))))  "((#f))")
                 (list (list (memq 'red '((red shoes) (blue socks))))  "#f")
                 (list (list (memq 'red '(red shoes blue socks)))  "(red shoes blue socks)"))

(--end-- "2.53")

;   ========================================================================
;   
;   Exercise 2.54
;   =============
;   
;   Two lists are said to be equal? if they contain equal elements arranged
;   in the same order.  For example,
;   
;   (equal? '(this is a list) '(this is a list))
;   
;   is true, but
;   
;   (equal? '(this is a list) '(this (is a) list))
;   
;   is false.  To be more precise, we can define equal? recursively in terms
;   of the basic eq? equality of symbols by saying that a and b are equal?
;   if they are both symbols and the symbols are eq?, or if they are both
;   lists such that (car a) is equal? to (car b) and (cdr a) is equal? to
;   (cdr b).  Using this idea, implement equal? as a procedure.⁽³⁶⁾
;   
;   ------------------------------------------------------------------------
;   [Exercise 2.54]: http://sicp-book.com/book-Z-H-16.html#%_thm_2.54
;   [Footnote 36]:   http://sicp-book.com/book-Z-H-16.html#footnote_Temp_233
;   2.3.1 Quotation - p145
;   ------------------------------------------------------------------------

(-start- "2.54")



(--end-- "2.54")

;   ========================================================================
;   
;   Exercise 2.55
;   =============
;   
;   Eva Lu Ator types to the interpreter the expression
;   
;   (car ''abracadabra)
;   
;   To her surprise, the interpreter prints back quote.  Explain.
;   
;   ------------------------------------------------------------------------
;   [Exercise 2.55]: http://sicp-book.com/book-Z-H-16.html#%_thm_2.55
;   2.3.1 Quotation - p145
;   ------------------------------------------------------------------------

(-start- "2.55")



(--end-- "2.55")

