#lang racket
(require "../utils.scm")
(require "../meta.scm")

(title "Exercise 2.56")

;   Exercise 2.56
;   =============
;
;   Show how to extend the basic differentiator to handle more kinds of
;   expressions.  For instance, implement the differentiation rule
;
;   d(uⁿ)          du
;   ─── = nuⁿ⁻¹  ──
;    dx            dx
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



(define (derivate exp var)
  (cond ((number? exp) 0)
        ((variable? exp)
         (if (same-variable? exp var) 1 0))
        ((sum? exp)
         (make-sum (deriv (addend exp) var)
                   (deriv (augend exp) var)))
        ((product? exp)
         (make-sum
           (make-product (multiplier exp)
                         (deriv (multiplicand exp) var))
           (make-product (deriv (multiplier exp) var)
                         (multiplicand exp))))
        (else
         (error "unknown expression type -- DERIV" exp))))

;; representing algebraic expressions

(define (variable? x) (symbol? x))

(define (same-variable? v1 v2)
  (and (variable? v1) (variable? v2) (eq? v1 v2)))

;(define (make-sum a1 a2) (list '+ a1 a2))
;
;(define (make-product m1 m2) (list '* m1 m2))

(define (sum? x)
  (and (pair? x) (eq? (car x) '+)))

(define (addend s) (cadr s))

(define (augend s) (caddr s))

(define (product? x)
  (and (pair? x) (eq? (car x) '*)))

(define (multiplier p) (cadr p))

(define (multiplicand p) (caddr p))

(define (make-sum a1 a2)
  (cond ((=number? a1 0) a2)
        ((=number? a2 0) a1)
        ((and (number? a1) (number? a2)) (+ a1 a2))
        (else (list '+ a1 a2))))

(define (=number? exp num)
  (and (number? exp) (= exp num)))

(define (make-product m1 m2)
  (cond ((or (=number? m1 0) (=number? m2 0)) 0)
        ((=number? m1 1) m2)
        ((=number? m2 1) m1)
        ((and (number? m1) (number? m2)) (* m1 m2))
        (else (list '* m1 m2))))

; =============================

(define (make-exponentiation a b)
  (cond
    ((=number? a 0) 0)
    ((=number? b 1) a)
    ((=number? b 0) 1)
    (else (list '** a b))))

(define (exponentiation? e)
  (and (list? e)
    (and (eq? '** (first e)) (number? (third e)))))

(define (base e)
  (second e))

(define (exponent e)
  (third e))

(define (derive exp var)
  (cond ((number? exp) 0)
        ((variable? exp)
         (if (same-variable? exp var) 1 0))
        ((sum? exp)
         (make-sum (derive (addend exp) var)
                   (derive (augend exp) var)))
        ((product? exp)
         (make-sum
           (make-product (multiplier exp)
                         (derive (multiplicand exp) var))
           (make-product (derive (multiplier exp) var)
                         (multiplicand exp))))
         ;   d(uⁿ)          du
         ;   ─── = nuⁿ⁻¹  ──
         ;    dx            dx
        ((exponentiation? exp)
          (let* ((u (base exp)) (n (exponent exp)))
            (make-product
              (make-product n (make-exponentiation u (make-sum n -1)))
              (derive u var))))
        (else
         (error "unknown expression type -- DERIV" exp))))

(assertequal? "Derive 1 wrt x"
  0
  (derive 1 'x))

(assertequal? "Derive 0 wrt x"
  0
  (derive 0 'x))

(assertequal? "Derive x wrt x"
  1
  (derive 'x 'x))

(assertequal? "Derive 2x wrt x"
  2
  (derive '(* 2 x) 'x))

(assertequal? "Derive x**2 wrt x"
  '(* 2 x)
  (derive '(** x 2) 'x))

(assert-raises-error "Derive x**x wrt x will raise an error"
  ;'(* (+ (ln x) 1) (** x x))
  (derive '(** x x) 'x))

(assertequal? "Derive 4x**3 wrt x"
  '(* 4 (* 3 (** x 2)))
  (derive '(* 4 (** x 3)) 'x))
