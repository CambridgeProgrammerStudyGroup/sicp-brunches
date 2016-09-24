#lang racket
(require "../utils.scm")
(require "../dispatch-table.scm")
(require (only-in "./exercise-2.56.scm" exponentiation? make-exponentiation base exponent))
(require "./exercise-2.57.scm")


;   Exercise 2.73
;   =============
;
;   Section [2.3.2] described a program that performs symbolic
;   differentiation:
;
;   (define (deriv exp var)
;     (cond ((number? exp) 0)
;           ((variable? exp) (if (same-variable? exp var) 1 0))
;           ((sum? exp)
;            (make-sum (deriv (addend exp) var)
;                      (deriv (augend exp) var)))
;           ((product? exp)
;            (make-sum
;              (make-product (multiplier exp)
;                            (deriv (multiplicand exp) var))
;              (make-product (deriv (multiplier exp) var)
;                            (multiplicand exp))))
;           <more rules can be added here>
;           (else (error "unknown expression type -- DERIV" exp))))
;
;   We can regard this program as performing a dispatch on the type of the
;   expression to be differentiated.  In this situation the "type tag" of
;   the datum is the algebraic operator symbol (such as +) and the operation
;   being performed is deriv.  We can transform this program into
;   data-directed style by rewriting the basic derivative procedure as
;
   (define (deriv expr var)
      (cond ((number? expr) 0)
            ((variable? expr) (if (same-variable? expr var) 1 0))
            (else ((get 'deriv (operator expr)) expr ; NOTE: Original code here has (operands exp) instead
                                               var))))
   (define (operator expr) (car expr))
   (define (operands expr) (cdr expr))
;
;   a.  Explain what was done above. Why can't we assimilate the predicates
;   number? and same-variable? into the data-directed dispatch?
;
;   b.  Write the procedures for derivatives of sums and products, and the
;   auxiliary code required to install them in the table used by the program
;   above.
;
;   c.  Choose any additional differentiation rule that you like, such as
;   the one for exponents (exercise [2.56]), and install it in this
;   data-directed system.
;
;   d.  In this simple algebraic manipulator the type of an expression is
;   the algebraic operator that binds it together.  Suppose, however, we
;   indexed the procedures in the opposite way, so that the dispatch line in
;   deriv looked like
;
;   ((get (operator exp) 'deriv) (operands exp) var)
;
;   What corresponding changes to the derivative system are required?
;
;   ------------------------------------------------------------------------
;   [Exercise 2.73]: http://sicp-book.com/book-Z-H-17.html#%_thm_2.73
;   [Section 2.3.2]: http://sicp-book.com/book-Z-H-16.html#%_sec_2.3.2
;   [Exercise 2.56]: http://sicp-book.com/book-Z-H-17.html#%_thm_2.56
;   2.4.3 Data-Directed Programming and Additivity - p184
;   ------------------------------------------------------------------------

; support
(define (variable? x) (symbol? x))

(define (same-variable? v1 v2)
  (and (variable? v1) (variable? v2) (eq? v1 v2)))


(module* main #f
  (title "Exercise 2.73")

  (Q:"2.73a) Explain what was done above. Why can't we assimilate the predicates
number? and same-variable? into the data-directed dispatch?")

  (A:"By using a dispatch table, we generalised the deriv procedure to handle all
possible expressions, and allowed us to add new expression types in the
future without requiring a change to the deriv procedure.

That said, we cannot integrate `number?` into our dispatch system as
bare numbers do not have a type tag. It would be possible to create a
tagged number type to avoid this problem, but this would mean wrapping
all bare numbers into this type. Likewise, `same-variable?` suffers
from the same restrictions and must therefore also be integrated into
our deriv function.")

;   b.  Write the procedures for derivatives of sums and products, and the
;   auxiliary code required to install them in the table used by the program
;   above.

  (define (deriv-sum exp var)
      (make-sum (deriv (addend exp) var)
                (deriv (augend exp) var)))

  (define (deriv-prod exp var)
      (make-sum
        (make-product (multiplier exp)
                      (deriv (multiplicand exp) var))
        (make-product (deriv (multiplier exp) var)
                      (multiplicand exp))))

  (void
    (put 'deriv '+ deriv-sum)
    (put 'deriv '* deriv-prod)
  )

  (assertequal? "We can use our dispatch system to find the derivative of a number"
    0 (deriv 123 'x))

  (assertequal? "We can use our dispatch system to find the derivative of a sum"
    1 (deriv '(+ 3 x) 'x))

  (assertequal? "We can use our dispatch system to find the derivative of a product"
    3 (deriv '(* 3 x) 'x))

;   c.  Choose any additional differentiation rule that you like, such as
;   the one for exponents (exercise [2.56]), and install it in this
;   data-directed system.


  (define (deriv-exp expr var)
    (let* ((u (base expr)) (n (exponent expr)))
      (make-product
        (make-product n (make-exponentiation u (make-sum n -1)))
        (deriv u var))))

  (void
    (put 'deriv '** deriv-exp))

  (assertequal? "We can use our dispatch system to find the derivative of an exponent"
    '(* 2 x) (deriv '(** x 2) 'x))

  (prn "")

  (Q: "2.73d)  In this simple algebraic manipulator the type of an expression is
the algebraic operator that binds it together.  Suppose, however, we
indexed the procedures in the opposite way, so that the dispatch line in
deriv looked like

    ((get (operator exp) 'deriv) (operands exp) var)

What corresponding changes to the derivative system are required?")

  (A: "Very few changes are required to the derivative system besides swapping the
arguments around to the put function also. This assumes that the dispatch
table has been implemented in a sensible way.")



)
