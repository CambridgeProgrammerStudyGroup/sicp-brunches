#lang racket

; Section 2.3.2: Example: Symbolic Differentiation

(require "common.rkt")

(define (deriv-takes-makes exp var
                           sum? addend augend make-sum
                           product? multiplicand multiplier make-product)
  (cond ((number? exp) 0)
        ((variable? exp)
         (if (same-variable? exp var) 1 0))
        ((sum? exp)
         (make-sum (deriv-takes-makes (addend exp) var
                                      sum? addend augend make-sum
                                      product? multiplicand multiplier make-product)
                   (deriv-takes-makes (augend exp) var
                                      sum? addend augend make-sum
                                      product? multiplicand multiplier make-product)))
        ((product? exp)
         (make-sum
          (make-product (multiplier exp)
                        (deriv-takes-makes (multiplicand exp) var
                                           sum? addend augend make-sum
                                           product? multiplicand multiplier make-product))
          (make-product (deriv-takes-makes (multiplier exp) var
                                           sum? addend augend make-sum
                                           product? multiplicand multiplier make-product)
                        (multiplicand exp))))
        (else
         (error "unknown expression type -- DERIV" exp))))

  
(define (variable? exp) (symbol? exp))

(define (same-variable? v1 v2)
  (and (variable? v1) (variable? v2) (eq? v1 v2)))

(define (=number? exp num)
  (and (number? exp) (= exp num)))

(define (deriv-prefix exp var)
  (define (sum? x)
    (and (pair? x) (eq? (car x) '+)))
  (define (make-sum-simple a1 a2) (list '+ a1 a2))
  (define (addend s) (cadr s))
  (define (augend s) (caddr s))
  (define (make-sum a1 a2)
    (cond ((=number? a1 0) a2)
          ((=number? a2 0) a1)
          ((and (number? a1) (number? a2)) (+ a1 a2))
          (else (make-sum-simple a1 a2))))
  
  
  (define (product? x)
    (and (pair? x) (eq? (car x) '*)))
  (define (make-product-simple m1 m2) (list '* m1 m2))
  (define (multiplier p) (cadr p))
  (define (multiplicand p) (caddr p))
  (define (make-product m1 m2)
    (cond ((or (=number? m1 0) (=number? m2 0)) 0)
          ((=number? m1 1) m2)
          ((=number? m2 1) m1)
          ((and (number? m1) (number? m2)) (* m1 m2))
          (else (make-product-simple m1 m2))))

  (deriv-takes-makes exp var
                     sum? addend augend make-sum
                     product? multiplicand multiplier make-product))

(prn "Examples from text - simplifying makes...")
(present-compare deriv-prefix
                 (list (list '(+ x 3) 'x) 1)
                 (list (list '(* x y) 'x) 'y)
                 (list (list '(* (* x y) (+ x 3)) 'x)
                       '(+ (* x y) (* y (+ x 3)))))



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

