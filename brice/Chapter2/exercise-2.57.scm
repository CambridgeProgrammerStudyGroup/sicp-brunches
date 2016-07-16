#lang racket
(require "../utils.scm")
(require "../meta.scm")

(require "./exercise-2.56.scm")

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

(module* main #f
  (title "Exercise 2.57")

  (let*
    (
      (sum? (lambda (x) (and (list? x) (eq? (car x) '+))))
      (make-sum (lambda args (cons '+ args)))
      (addend (lambda (xs) (second xs)))
      (augend (lambda (xs)
        (if (> (length xs) 3)
          (cons '+ (rest (rest xs)))
          (third xs))))

      (product? (lambda (x) (and (list? x) (eq? (car x) '*))))
      (make-product (lambda args (cons '* args)))
      (multiplier (lambda (xs) (second xs)))
      (multiplicand (lambda (xs)
        (if (> (length xs) 3)
          (cons '* (rest (rest xs)))
          (third xs))))


      (TESTSUM (make-sum 1 2 3 4))
      (TESTPRODUCT (make-product 1 2 3 4))
    )


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




    (assertequal? "We can make sums of multiple values" '(+ 1 2 3 4) TESTSUM)
    (assertequal? "We can get the augend of a long sum" '(+ 2 3 4) (augend TESTSUM))
    (assertequal? "We can get the addend of a long sum" 1 (addend TESTSUM))
    (assertequal? "We can make sums of two values" '(+ 1 2) (make-sum 1 2))
    (assertequal? "We can get the addend of a simple sum" 1 (addend (make-sum 1 2)))
    (assertequal? "We can get the augend of a simple sum" 2 (augend (make-sum 1 2)))

    (assertequal? "We can make products of multiple values" '(* 1 2 3 4) (make-product 1 2 3 4))
    (assertequal? "We can get the multiplicand of a long product" '(* 2 3 4) (multiplicand (make-product 1 2 3 4)))
    (assertequal? "We can get the multiplier of a long product" 1 (multiplier (make-product 1 2 3 4)))
    (assertequal? "we can make products out of two numbers " '(* 1 2) (make-product 1 2))
    (assertequal? "we can get the multiplier out of a simple product " 1 (multiplier (make-product 1 2)))
    (assertequal? "we can get the multiplicand out of a simple product " 2 (multiplicand (make-product 1 2)))
  )
)
