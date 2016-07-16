#lang racket

; Section 2.5.1: Generic Arithmetic Operations

(require "common.rkt")

;   Exercise 2.77
;   =============
;   
;   Louis Reasoner tries to evaluate the expression (magnitude z) where z is
;   the object shown in figure [2.24].  To his surprise, instead of the
;   answer 5 he gets an error message from apply-generic, saying there is no
;   method for the operation magnitude on the types (complex). He shows this
;   interaction to Alyssa P. Hacker, who says "The problem is that the
;   complex-number selectors were never defined for complex numbers, just
;   for polar and rectangular numbers.  All you have to do to make this work
;   is add the following to the complex package:"
;   
;   (put 'real-part '(complex) real-part)
;   (put 'imag-part '(complex) imag-part)
;   (put 'magnitude '(complex) magnitude)
;   (put 'angle '(complex) angle)
;   
;   Describe in detail why this works.  As an example, trace through all the
;   procedures called in evaluating the expression (magnitude z) where z is
;   the object shown in figure [2.24].  In particular, how many times is
;   apply-generic invoked?  What procedure is dispatched to in each case?
;   
;   ------------------------------------------------------------------------
;   [Exercise 2.77]: http://sicp-book.com/book-Z-H-18.html#%_thm_2.77
;   [Figure 2.24]:   http://sicp-book.com/book-Z-H-18.html#%_fig_2.24
;   2.5.1 Generic Arithmetic Operations - p192
;   ------------------------------------------------------------------------

(-start- "2.77")



(--end-- "2.77")

;   ========================================================================
;   
;   Exercise 2.78
;   =============
;   
;   The internal procedures in the scheme-number package are essentially
;   nothing more than calls to the primitive procedures +, -, etc.  It was
;   not possible to use the primitives of the language directly because our
;   type-tag system requires that each data object have a type attached to
;   it.  In fact, however, all Lisp implementations do have a type system,
;   which they use internally. Primitive predicates such as symbol? and
;   number? determine whether data objects have particular types.  Modify
;   the definitions of type-tag, contents, and attach-tag from section
;   [2.4.2] so that our generic system takes advantage of Scheme's internal
;   type system.  That is to say, the system should work as before except
;   that ordinary numbers should be represented simply as Scheme numbers
;   rather than as pairs whose car is the symbol scheme-number.
;   
;   ------------------------------------------------------------------------
;   [Exercise 2.78]: http://sicp-book.com/book-Z-H-18.html#%_thm_2.78
;   [Section 2.4.2]: http://sicp-book.com/book-Z-H-17.html#%_sec_2.4.2
;   2.5.1 Generic Arithmetic Operations - p193
;   ------------------------------------------------------------------------

(-start- "2.78")



(--end-- "2.78")

;   ========================================================================
;   
;   Exercise 2.79
;   =============
;   
;   Define a generic equality predicate equ? that tests the equality of two
;   numbers, and install it in the generic arithmetic package.  This
;   operation should work for ordinary numbers, rational numbers, and
;   complex numbers.
;   
;   ------------------------------------------------------------------------
;   [Exercise 2.79]: http://sicp-book.com/book-Z-H-18.html#%_thm_2.79
;   2.5.1 Generic Arithmetic Operations - p193
;   ------------------------------------------------------------------------

(-start- "2.79")



(--end-- "2.79")

;   ========================================================================
;   
;   Exercise 2.80
;   =============
;   
;   Define a generic predicate =zero? that tests if its argument is zero,
;   and install it in the generic arithmetic package.  This operation should
;   work for ordinary numbers, rational numbers, and complex numbers.
;   
;   ------------------------------------------------------------------------
;   [Exercise 2.80]: http://sicp-book.com/book-Z-H-18.html#%_thm_2.80
;   2.5.1 Generic Arithmetic Operations - p193
;   ------------------------------------------------------------------------

(-start- "2.80")



(--end-- "2.80")

