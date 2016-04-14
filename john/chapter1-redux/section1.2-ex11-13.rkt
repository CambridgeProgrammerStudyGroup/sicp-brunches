#lang racket

; Section 1.2.2: Tree Recursion

(require "common.rkt")

;   Exercise 1.11
;   =============
;   
;   A function f is defined by the rule that f(n) = n if n<3 and f(n) = f(n
;   - 1) + 2f(n - 2) + 3f(n - 3) if n≥ 3.  Write a procedure that computes f
;   by means of a recursive process.  Write a procedure that computes f by
;   means of an iterative process.
;   
;   ------------------------------------------------------------------------
;   [Exercise 1.11]: http://sicp-book.com/book-Z-H-11.html#%_thm_1.11
;   1.2.2 Tree Recursion - p42
;   ------------------------------------------------------------------------

(-start- "1.11")



(--end-- "1.11")

;   ========================================================================
;   
;   Exercise 1.12
;   =============
;   
;   The following pattern of numbers is called Pascal's triangle.
;   
;       1
;      1 1
;     1 2 1 
;    1 3 3 1
;   1 4 6 4 1
;   
;   The numbers at the edge of the triangle are all 1, and each number
;   inside the triangle is the sum of the two numbers above it.⁽³⁵⁾ Write a
;   procedure that computes elements of Pascal's triangle by means of a
;   recursive process.
;   
;   ------------------------------------------------------------------------
;   [Exercise 1.12]: http://sicp-book.com/book-Z-H-11.html#%_thm_1.12
;   [Footnote 35]:   http://sicp-book.com/book-Z-H-11.html#footnote_Temp_57
;   1.2.2 Tree Recursion - p42
;   ------------------------------------------------------------------------

(-start- "1.12")



(--end-- "1.12")

;   ========================================================================
;   
;   Exercise 1.13
;   =============
;   
;   Prove that Fib(n) is the closest integer to ɸⁿ/√5, where ɸ = (1 + √5)/2.
;   Hint: Let ψ = (1 - √5)/2.  Use induction and the definition of the
;   Fibonacci numbers (see section [1.2.2]) to prove that Fib(n) = (ɸⁿ -
;   ψⁿ)/√5.
;   
;   ------------------------------------------------------------------------
;   [Exercise 1.13]: http://sicp-book.com/book-Z-H-11.html#%_thm_1.13
;   [Section 1.2.2]: http://sicp-book.com/book-Z-H-11.html#%_sec_1.2.2
;   1.2.2 Tree Recursion - p42
;   ------------------------------------------------------------------------

(-start- "1.13")



(--end-- "1.13")

