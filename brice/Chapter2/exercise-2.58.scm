#lang racket
(require "../utils.scm")
(require "../meta.scm")

(require "./exercise-2.56.scm")

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

(module* infix-simple #f
  (title "Exercise 2.58a")

  (define (sum? exp) (equal? (second exp) '+))
  (define (addend sum) (first sum))
  (define (augend sum) (third sum))
  (define (make-sum x y)
    (if (and (number? x) (number? y))
      (+ x y)
      (list x '+ y)))

  (define (product? exp) (equal? (second exp) '*))
  (define (multiplier product) (first product))
  (define (multiplicand product) (third product))
  (define (make-product x y)
    (if (and (number? x) (number? y))
      (* x y)
      (list x '* y)))

  (let*
    (
      (TESTSUM (make-sum 'a 'b))
      (TESTPRODUCT (make-product 'a 'b))
    )

    (assert "We can detect a sum" (sum? TESTSUM))
    (assertequal? "We can get the augend of a sum" 'b (augend TESTSUM))
    (assertequal? "We can get the addend of a sum" 'a (addend TESTSUM))
    (assertequal? "We can make sums of two values" '(a + b) TESTSUM)
    (assertequal? "We can get the addend of a simple sum" 'a (addend TESTSUM))
    (assertequal? "We can get the augend of a simple sum" 'b (augend TESTSUM))
    (assertequal? "Sum will collapse numbers together" 5 (make-sum 2 3))

    (assert "We can detect a product" (product? TESTPRODUCT))
    (assertequal? "We can get the multiplicand of a product" 'b (multiplicand TESTPRODUCT))
    (assertequal? "We can get the multiplier of a product" 'a (multiplier TESTPRODUCT))
    (assertequal? "We can make product of two values" '(a * b) TESTPRODUCT)
    (assertequal? "We can get the multiplier of a simple product" 'a (multiplier TESTPRODUCT))
    (assertequal? "We can get the multiplicand of a simple product" 'b (multiplicand TESTPRODUCT))
    (assertequal? "Product will collapse numbers together" 6 (make-product 2 3))

  )
)

(module* infix #f
  (title "Exercise 2.58b"))



(module* main #f
  (require (submod ".." infix-simple))
  (require (submod ".." infix))


)
