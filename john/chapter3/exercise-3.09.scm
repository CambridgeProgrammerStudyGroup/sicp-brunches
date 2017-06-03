#lang sicp

(#%require "common.scm")

;   Exercise 3.9
;   ============
;   
;   In section [1.2.1] we used the substitution model to analyze two
;   procedures for computing factorials, a recursive version
;   
;   (define (factorial n)
;     (if (= n 1)
;         1
;         (* n (factorial (- n 1)))))
;   
;   and an iterative version
;   
;   (define (factorial n)
;     (fact-iter 1 1 n))
;   (define (fact-iter product counter max-count)
;     (if (> counter max-count)
;         product
;         (fact-iter (* counter product)
;                    (+ counter 1)
;                    max-count)))
;   
;   Show the environment structures created by evaluating (factorial 6)
;   using each version of the factorial procedure.⁽¹⁴⁾
;   
;   ------------------------------------------------------------------------
;   [Exercise 3.9]:  http://sicp-book.com/book-Z-H-21.html#%_thm_3.9
;   [Section 1.2.1]: http://sicp-book.com/book-Z-H-11.html#%_sec_1.2.1
;   [Footnote 14]:   http://sicp-book.com/book-Z-H-21.html#footnote_Temp_345
;   3.2.2 Applying Simple Procedures - p246
;   ------------------------------------------------------------------------

(-start- "3.9")



(--end-- "3.9")

