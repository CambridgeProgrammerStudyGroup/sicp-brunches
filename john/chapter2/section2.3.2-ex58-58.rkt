#lang racket

; Section 2.3.2: Example: Symbolic Differentiation

(require "common.rkt")

; The 'wrap' function below can create redundent parenthesis, so need to
; remove edundent parentheses because some of the checks assume list
; lengtH is greater than 1. (Removing is probably a more general solution
; then making sure I'm not adding them.)

(define (redundent-parens? exp)
  (if (and (pair? exp) (= 1 (length exp)))
      #true
      #false))
(define (redundent-parens-contents exp)
  (car exp))



(define (deriv-takes-makes exp var
                           sum? addend augend make-sum
                           product? multiplicand multiplier make-product)

  ; Convenience function for recursing back into this function.
  (define (recur exp)
    (deriv-takes-makes exp var
                       sum? addend augend make-sum
                       product? multiplicand multiplier make-product))
  
  (cond ((redundent-parens? exp)
         (recur (redundent-parens-contents exp)))
        ((number? exp) 0)
        ((variable? exp)
         (if (same-variable? exp var) 1 0))
        ((sum? exp)
         (make-sum (recur (addend exp))
                   (recur (augend exp))))
        ((product? exp)
         (make-sum
          (make-product (multiplier exp)
                        (recur (multiplicand exp)))
          (make-product (recur (multiplier exp))
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

(prn "'Simplifying' example from text using prefix notation ...")
(present-compare deriv-prefix
                 (list (list '(+ x 3) 'x) 1)
                 (list (list '(* x y) 'x) 'y)
                 (list (list '(* (* x y) (+ x 3)) 'x)
                       '(+ (* x y) (* y (+ x 3))))
                 (list (list '(+ x (* 3 (+ x (+ y 2)))) 'x) 4)
                 )


; define deriv using infix operators:
(define (deriv-infix exp var)
  (define (sum? x)
    (and (pair? x) (eq? (cadr x) '+)))
  (define (make-sum-simple a1 a2) (list a1 '+ a2))
  (define (addend s) (car s))
  (define (augend s) (caddr s))
  (define (make-sum a1 a2)
    (cond ((=number? a1 0) a2)
          ((=number? a2 0) a1)
          ((and (number? a1) (number? a2)) (+ a1 a2))
          (else (make-sum-simple a1 a2)))) 
  
  
  (define (product? x)
    (and (pair? x) (eq? (cadr x) '*)))
  (define (make-product-simple m1 m2) (list m1 '* m2))
  (define (multiplier p) (car p))
  (define (multiplicand p) (caddr p))
  (define (make-product m1 m2)
    (cond ((or (=number? m1 0) (=number? m2 0)) 0)
          ((=number? m1 1) m2)
          ((=number? m2 1) m1)
          ((and (number? m1) (number? m2)) (* m1 m2))
          (else (make-product-simple m1 m2))))

;  ; check for redundant parens
;  (if (and (pair? exp) (= (length exp) 1))
;      (deriv-infix (car exp))
;  
      (deriv-takes-makes exp var
                         sum? addend augend make-sum
                         product? multiplicand multiplier make-product))

(prn "... and using infix notation ...")
(present-compare deriv-infix
                 (list (list '(x + 3) 'x) 1)
                 (list (list '(x * y) 'x) 'y)
                 (list (list '((x * y) * (x + 3)) 'x)
                       '((x * y) + (y * (x + 3))))
                 (list (list '(x + (3 * (x + (y + 2)))) 'x) 4))



(define (add-parens exp)
  (define (wrap op exp)
    (define (wrap-all exp)
      (if (or (not (pair? exp)) (< (length exp) 3))
          exp
          (cond ((not (eq? (cadr exp) op))
                 ; this can create 'redundent' paranthesis/lists
                 (cons (car exp) (cons (cadr exp) (wrap-all (cddr exp)))))
                (else
                 (wrap-all (wrap op (cons
                                     (list (car exp) op (caddr exp))
                                     (cdddr exp))))))))                         
    (if (< (length exp) 5)
        exp
        (wrap-all exp)))

  (define (wrap-mult exp)
    (wrap '* exp))
  (define (wrap-add exp)
    (wrap '+ exp))
  
  (cond ((pair? exp)
         (map add-parens (wrap-add (wrap-mult exp))))
        (else exp))) 

(present-compare add-parens
                 (list (list '(x + 3 * (x + y + 2)))
                       '(x + (3 * (((x + y) + 2))))))

(define (deriv-infix-without-parans exp var)
    (deriv-infix (add-parens exp) var))


(present-compare deriv-infix-without-parans
                 (list (list '(x + 3) 'x) 1)
                 (list (list '(x * y) 'x) 'y)
                 (list (list '((x * y) * (x + 3)) 'x)
                       '((x * y) + (y * (x + 3))))
                 (list (list '(x + (3 * (x + (y + 2)))) 'x) 4)
                 (list (list '(x + (3 * (((x + y) + 2)))) 'x) "who cares?")
                 (list (list '(x + 3 * (x + y + 2)) 'x) 4)
                 )

(--end-- "2.58")

