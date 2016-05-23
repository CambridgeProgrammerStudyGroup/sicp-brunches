#lang racket

; Section 2.3.2: Example: Symbolic Differentiation

(require "common.rkt")

;   Exercise 2.56
;   =============
;   
;   Show how to extend the basic differentiator to handle more kinds of
;   expressions.  For instance, implement the differentiation rule
;   
;   d(uⁿ)          / du \
;   ───── = nuⁿ⁻¹ ( ──── )
;     dx           \ dx /
;   
;   by adding a new clause to the deriv program and defining appropriate
;   procedures exponentiation?, base, exponent, and make-exponentiation. 
;   (You may use the symbol ** to denote exponentiation.) Build in the rules
;   that anything raised to the power 0 is 1 and anything raised to the
;   power 1 is the thing itself.
;   
;   ------------------------------------------------------------------------
;   [Exercise 2.56]: http://sicp-book.com/book-Z-H-16.html#%_thm_2.56
;   2.3.2 Example: Symbolic Differentiation - p150
;   ------------------------------------------------------------------------

(-start- "2.56")



(--end-- "2.56")

;   ========================================================================
;   
;   Exercise 2.57
;   =============
;   
;   Extend the differentiation program to handle sums and products of
;   arbitrary numbers of (two or more) terms. Then the last example above
;   could be expressed as
;   
;   (deriv '(* x y (+ x 3)) 'x)
;   
;   Try to do this by changing only the representation for sums and
;   products, without changing the deriv procedure at all.  For example, the
;   addend of a sum would be the first term, and the augend would be the sum
;   of the rest of the terms.
;   
;   ------------------------------------------------------------------------
;   [Exercise 2.57]: http://sicp-book.com/book-Z-H-16.html#%_thm_2.57
;   2.3.2 Example: Symbolic Differentiation - p151
;   ------------------------------------------------------------------------

(-start- "2.57")



(--end-- "2.57")

;   ========================================================================
;   
;   Exercise 2.58
;   =============
;   
;   Suppose we want to modify the differentiation program so that it works
;   with ordinary mathematical notation, in which + and * are infix rather
;   than prefix operators.  Since the differentiation program is defined in
;   terms of abstract data, we can modify it to work with different
;   representations of expressions solely by changing the predicates,
;   selectors, and constructors that define the representation of the
;   algebraic expressions on which the differentiator is to operate.
;   
;   a. Show how to do this in order to differentiate algebraic expressions
;   presented in infix form, such as (x + (3 * (x + (y + 2)))). To simplify
;   the task, assume that + and * always take two arguments and that
;   expressions are fully parenthesized.
;   
;   b. The problem becomes substantially harder if we allow standard
;   algebraic notation, such as (x + 3 * (x + y + 2)), which drops
;   unnecessary parentheses and assumes that multiplication is done before
;   addition.  Can you design appropriate predicates, selectors, and
;   constructors for this notation such that our derivative program still
;   works?
;   
;   ------------------------------------------------------------------------
;   [Exercise 2.58]: http://sicp-book.com/book-Z-H-16.html#%_thm_2.58
;   2.3.2 Example: Symbolic Differentiation - p151
;   ------------------------------------------------------------------------

(-start- "2.58")



(--end-- "2.58")

