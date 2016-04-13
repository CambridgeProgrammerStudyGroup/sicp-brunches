#lang racket

; Section 1.2.5: Greatest Common Divisors

(require "common.rkt")

;   Exercise 1.20
;   =============
;   
;   The process that a procedure generates is of course dependent on the
;   rules used by the interpreter.  As an example, consider the iterative
;   gcd procedure given above. Suppose we were to interpret this procedure
;   using normal-order evaluation, as discussed in section [1.1.5]. (The
;   normal-order-evaluation rule for if is described in exercise [1.5].)
;   Using the substitution method (for normal order), illustrate the process
;   generated in evaluating (gcd 206 40) and indicate the remainder
;   operations that are actually performed. How many remainder operations
;   are actually performed in the normal-order evaluation of (gcd 206 40)?
;   In the applicative-order evaluation?
;   
;   ------------------------------------------------------------------------
;   [Exercise 1.20]: http://sicp-book.com/book-Z-H-11.html#%_thm_1.20
;   [Section 1.1.5]: http://sicp-book.com/book-Z-H-10.html#%_sec_1.1.5
;   [Exercise 1.5]:  http://sicp-book.com/book-Z-H-11.html#%_thm_1.5
;   1.2.5 Greatest Common Divisors - p49
;   ------------------------------------------------------------------------

(-start- "1.20")



(--end-- "1.20")

