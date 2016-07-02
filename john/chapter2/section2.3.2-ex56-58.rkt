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

; Code from the text:

(define (deriv-takes-makes exp var make-sum make-product)
  (cond ((number? exp) 0)
        ((variable? exp)
         (if (same-variable? exp var) 1 0))
        ((sum? exp)
         (make-sum (deriv-takes-makes (addend exp) var make-sum make-product)
                   (deriv-takes-makes (augend exp) var make-sum make-product)))
        ((product? exp)
         (make-sum
          (make-product (multiplier exp)
                        (deriv-takes-makes (multiplicand exp) var make-sum make-product))
          (make-product (deriv-takes-makes (multiplier exp) var make-sum make-product)
                        (multiplicand exp))))
        (else
         (error "unknown expression type -- DERIV" exp))))

  
(define (variable? exp) (symbol? exp))

(define (same-variable? v1 v2)
  (and (variable? v1) (variable? v2) (eq? v1 v2)))

(define (sum? x)
  (and (pair? x) (eq? (car x) '+)))
(define (make-sum-simple a1 a2) (list '+ a1 a2))
(define (addend s) (cadr s))
(define (augend s) (caddr s))

(define (product? x)
  (and (pair? x) (eq? (car x) '*)))
(define (make-product-simple m1 m2) (list '* m1 m2))
(define (multiplier p) (cadr p))
(define (multiplicand p) (caddr p))

(prn "Examples from text - simple makes...")
(define (deriv-simple exp var) (deriv-takes-makes exp var make-sum-simple make-product-simple))
(present-compare deriv-simple
                 (list (list '(+ x 3) 'x) '(+ 1 0))
                 (list (list '(* x y) 'x) '(+ (* x 0) (* 1 y)))
                 (list (list '(* (* x y) (+ x 3)) 'x)
                       '(+ (* (* x y) (+ 1 0)) (* (+ (* x 0) (* 1 y)) (+  x 3)))))


(define (make-sum a1 a2)
  (cond ((=number? a1 0) a2)
        ((=number? a2 0) a1)
        ((and (number? a1) (number? a2)) (+ a1 a2))
        (else (make-sum-simple a1 a2))))

(define (=number? exp num)
  (and (number? exp) (= exp num)))

(define (make-product m1 m2)
  (cond ((or (=number? m1 0) (=number? m2 0)) 0)
        ((=number? m1 1) m2)
        ((=number? m2 1) m1)
        ((and (number? m1) (number? m2)) (* m1 m2))
        (else (make-product-simple m1 m2))))

(define (deriv exp var) (deriv-takes-makes exp var make-sum make-product))

(prn "Examples from text - simplifying makes...")
(present-compare deriv
                 (list (list '(+ x 3) 'x) 1)
                 (list (list '(* x y) 'x) 'y)
                 (list (list '(* (* x y) (+ x 3)) 'x)
                       '(+ (* x y) (* y (+ x 3)))))

;; And the actual question...
(define (exponent? x)
  (and (pair? x) (eq? (car x) '**)))

(define (base exp)
  (cadr exp))

(define (exponent exp)
  (caddr exp))

(define (make-exponent base exponent)
  (cond ((=number? exponent 0) 1)
        ((=number? exponent 1) base)
        (else (list '** base exponent))))



(define (deriv-with-exp exp var) 
  (cond ((number? exp) 0)
        ((variable? exp)
         (if (same-variable? exp var) 1 0))
        ((sum? exp)
         (make-sum (deriv-with-exp (addend exp) var)
                   (deriv-with-exp (augend exp) var)))
        ((product? exp)
         (make-sum
          (make-product (multiplier exp)
                        (deriv-with-exp (multiplicand exp) var))
          (make-product (deriv-with-exp (multiplier exp) var)
                        (multiplicand exp))))
        ((exponent? exp)
         (make-product (exponent exp) (make-exponent (base exp) (make-sum (exponent exp) '-1))))
        (else
         (error "unknown expression type -- DERIV" exp))))


(present-compare deriv-with-exp
                 (list (list '(** x 3) 'x)
                       '(* 3 (** x 2)))
                 (list (list '(** x 2) 'x)
                       '(* 2 x))
                 (list (list '(** x 1) 'x)
                       '1)
                 (list (list '(+ (* 7 (** x 4)) (* 5 (** x 2))) 'x)
                       '(+ (* 7 (* 4 (** x 3))) (* 5 (* 2 x))) ))

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

(define (multi-product? exp)
  (pair? (cdddr exp)))

(define (nest-products exp)
  ; (* a b c) -> (* a (* b c))
  (make-product
   (multiplier exp)
    (make-product
    (car (cddr exp))
    (cadr (cddr exp)))))
   

(define (deriv-57 exp var) 
  (cond ((number? exp) 0)
        ((variable? exp)
         (if (same-variable? exp var) 1 0))
        ((sum? exp)
         (make-sum (deriv-57 (addend exp) var)
                   (deriv-57 (augend exp) var)))
        ((multi-product? exp)
         (deriv-57 (nest-products exp) var))
        ((product? exp)
         (make-sum
          (make-product (multiplier exp)
                        (deriv-57 (multiplicand exp) var))
          (make-product (deriv-57 (multiplier exp) var)
                        (multiplicand exp))))
        ((exponent? exp)         
         (make-product (exponent exp) (make-exponent (base exp) (make-sum (exponent exp) '-1))))
        (else
         (error "unknown expression type -- DERIV" exp))))

(present-compare deriv-57
                 (list (list '(* x y (+ x 3)) 'x)
                       '(+ (* x y) (* y (+ x 3))))
                 (list (list '(* x x x) 'x)
                       '(+ (* x (+ x x)) (* x x))))

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

