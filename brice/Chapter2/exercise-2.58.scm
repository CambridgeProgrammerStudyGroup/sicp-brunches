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
  (title "Exercise 2.58b")

  (define operators '(+ * **)) ; in order of precedence

  (define (operator? x)
    (if (member x operators) #t #f))

  (define (make-op-pred op)
    (lambda (exp)
      (empty?
        (remove*
          (member op operators)
          (filter operator? exp)))))

  (define sum? (make-op-pred '+))
  (define product? (make-op-pred '*))
  (define exponentiation? (make-op-pred '**))

  (define (get-left op exp)
    (let ((left (takef exp (lambda (x) (not (equal? x op))))))
      (if (> (length left) 1)
        left
        (first left))))

  (define (get-right op exp)
    (let ((right (rest (member op exp))))
      (if (> (length right) 1)
        right
        (first right))))

  (define (addend sum) (get-left '+ sum))
  (define (augend sum) (get-right '+ sum))

  (define (multiplier product) (get-left '* product))
  (define (multiplicand product) (get-right '* product))

  (define (intersperse x ys)
    (cond
      [(empty? ys) '()]
      [(empty? (rest ys)) ys]
      [else (cons (first ys)
              (cons x
                (intersperse x (rest ys))))]))

  (define (complement pred)
    (lambda args
      (not (apply pred args))))

  (define-syntax make-maker
  	(syntax-rules ()
  		[(_ operator)
        (lambda args
          (cond
            ((< (length args) 2)
              (error "Can't operate on one value"))
            ((findf number? args)
                (intersperse (quote operator)
                  (cons
                    (apply operator (filter number? args))
                    (filter (complement number?) args))))
            (else
              (intersperse (quote operator) args)))) ]))

  (define make-sum (make-maker +))
  (define make-product (make-maker *))

  (assertequal? "We can create a simple sum" '(a + b)  (make-sum 'a 'b ))
  (assertequal? "We can create a multiple value sum" '(a + b + c) (make-sum 'a 'b 'c))
  (assertequal? "We will collect all values that can be collected in a sum" '(5 + a + b) (make-sum 1 'a 2 'b 2 ))

  (assert "We can detect a simple sum" (sum? '(1 + 2)))
  (assert "We can detect a sum within a compound expression" (sum? '(1 + 3 * 4)))
  (assert "We can detect a sum within a compound expression (2)" (sum? '(1 * 3 + 4)))

  (assert "We do not detect a product in an expression with a sum" (not (product? '(1 + 3 * 4 + 4 ** 8))))
  (assert "We do not detect a product in an expression with a sum (2)" (not (product? '(1 * 3 * 4 + 4 ** 8))))
  (assert "We detect a product in a expression with an exponentiation" (product? '(1 * 4 ** 8)))
  (assert "We detect a simple product" (product? '(1 * 2)))

  (assert "We do not detect an exponentiation in an expression with another operator" (not (exponentiation? '(1 + 4 ** 8))))
  (assert "We detect a simple exponentiation" (exponentiation? '(1 ** 2)))

  (assertequal? "We can get the addend of a simple sum" 1 (addend '(1 + 2)))
  (assertequal? "We can get the addend of a simple compound sum" 1 (addend '(1 + 2 * 6)))
  (assertequal? "We can get the addend of a compound sum" '(1 * 2) (addend '(1 * 2 + 6)))
  (assertequal? "We can get the augend of a simple sum" 2 (augend '(1 + 2)))
  (assertequal? "We can get the augend of a simple compound sum" 2 (augend '(1 * 7 + 2)))
  (assertequal? "We can get the augend of a compound sum" '(2 ** 4) (augend '(1 * 7 + 2 ** 4)))
  (assertequal? "We can get the augend of a sum of multiple values" '(2 + 3) (augend '(1 + 2 + 3)))

  (assertequal? "We can get the multiplier of a simple product" 1 (multiplier '(1 * 2)))
  (assertequal? "We can get the multiplier of a simple compound product" 1 (multiplier '(1 * 2 ** 6)))
  (assertequal? "We can get the multiplier of a compound product" '(1 ** 2) (multiplier '(1 ** 2 * 6)))
  (assertequal? "We can get the multiplicand of a simple product" 2 (multiplicand '(1 * 2)))
  (assertequal? "We can get the multiplicand of a simple compound product" 2 (multiplicand '(1 ** 7 * 2)))
  (assertequal? "We can get the multiplicand of a compound product" '(2 ** 4) (multiplicand '(1 ** 7 * 2 ** 4)))
  (assertequal? "We can get the multiplicand of a product of multiple values" '(2 * 3) (multiplicand '(1 * 2 * 3)))
)



(module* main #f
  (require (submod ".." infix-simple))
  (require (submod ".." infix))
)
