#lang racket

; Section 2.5.3: Example: Symbolic Algebra

(require "common.rkt")

;   Exercise 2.87
;   =============
;   
;   Install =zero? for polynomials in the generic arithmetic package.  This
;   will allow adjoin-term to work for polynomials with coefficients that
;   are themselves polynomials.
;   
;   ------------------------------------------------------------------------
;   [Exercise 2.87]: http://sicp-book.com/book-Z-H-18.html#%_thm_2.87
;   2.5.3 Example: Symbolic Algebra - p209
;   ------------------------------------------------------------------------

(-start- "2.87")



(--end-- "2.87")

;   ========================================================================
;   
;   Exercise 2.88
;   =============
;   
;   Extend the polynomial system to include subtraction of polynomials.
;   (Hint: You may find it helpful to define a generic negation operation.)
;   
;   ------------------------------------------------------------------------
;   [Exercise 2.88]: http://sicp-book.com/book-Z-H-18.html#%_thm_2.88
;   2.5.3 Example: Symbolic Algebra - p209
;   ------------------------------------------------------------------------

(-start- "2.88")



(--end-- "2.88")

;   ========================================================================
;   
;   Exercise 2.89
;   =============
;   
;   Define procedures that implement the term-list representation described
;   above as appropriate for dense polynomials.
;   
;   ------------------------------------------------------------------------
;   [Exercise 2.89]: http://sicp-book.com/book-Z-H-18.html#%_thm_2.89
;   2.5.3 Example: Symbolic Algebra - p209
;   ------------------------------------------------------------------------

(-start- "2.89")



(--end-- "2.89")

;   ========================================================================
;   
;   Exercise 2.90
;   =============
;   
;   Suppose we want to have a polynomial system that is efficient for both
;   sparse and dense polynomials.  One way to do this is to allow both kinds
;   of term-list representations in our system.  The situation is analogous
;   to the complex-number example of section [2.4], where we allowed both
;   rectangular and polar representations. To do this we must distinguish
;   different types of term lists and make the operations on term lists
;   generic.  Redesign the polynomial system to implement this
;   generalization.  This is a major effort, not a local change.
;   
;   ------------------------------------------------------------------------
;   [Exercise 2.90]: http://sicp-book.com/book-Z-H-18.html#%_thm_2.90
;   [Section 2.4]:   http://sicp-book.com/book-Z-H-17.html#%_sec_2.4
;   2.5.3 Example: Symbolic Algebra - p209
;   ------------------------------------------------------------------------

(-start- "2.90")



(--end-- "2.90")

;   ========================================================================
;   
;   Exercise 2.91
;   =============
;   
;   A univariate polynomial can be divided by another one to produce a
;   polynomial quotient and a polynomial remainder.  For example,
;   
;   x⁵ - 1
;   ────── = x³ + x, remainder x - 1
;   x² - 1
;   
;   Division can be performed via long division. That is, divide the
;   highest-order term of the dividend by the highest-order term of the
;   divisor.  The result is the first term of the quotient.  Next, multiply
;   the result by the divisor, subtract that from the dividend, and produce
;   the rest of the answer by recursively dividing the difference by the
;   divisor.  Stop when the order of the divisor exceeds the order of the
;   dividend and declare the dividend to be the remainder.  Also, if the
;   dividend ever becomes zero, return zero as both quotient and remainder.
;   
;   We can design a div-poly procedure on the model of add-poly and
;   mul-poly. The procedure checks to see if the two polys have the same
;   variable.  If so, div-poly strips off the variable and passes the
;   problem to div-terms, which performs the division operation on term
;   lists. Div-poly finally reattaches the variable to the result supplied
;   by div-terms.  It is convenient to design div-terms to compute both the
;   quotient and the remainder of a division.  Div-terms can take two term
;   lists as arguments and return a list of the quotient term list and the
;   remainder term list.
;   
;   Complete the following definition of div-terms by filling in the missing
;   expressions.  Use this to implement div-poly, which takes two polys as
;   arguments and returns a list of the quotient and remainder polys.
;   
;   (define (div-terms L1 L2)
;     (if (empty-termlist? L1)
;         (list (the-empty-termlist) (the-empty-termlist))
;         (let ((t1 (first-term L1))
;               (t2 (first-term L2)))
;           (if (> (order t2) (order t1))
;               (list (the-empty-termlist) L1)
;               (let ((new-c (div (coeff t1) (coeff t2)))
;                     (new-o (- (order t1) (order t2))))
;                 (let ((rest-of-result
;                        <compute rest of result recursively>
;                        ))
;                   <form complete result>
;                   ))))))
;   
;   ------------------------------------------------------------------------
;   [Exercise 2.91]: http://sicp-book.com/book-Z-H-18.html#%_thm_2.91
;   2.5.3 Example: Symbolic Algebra - p210
;   ------------------------------------------------------------------------

(-start- "2.91")



(--end-- "2.91")

;   ========================================================================
;   
;   Exercise 2.92
;   =============
;   
;   By imposing an ordering on variables, extend the polynomial package so
;   that addition and multiplication of polynomials works for polynomials in
;   different variables.  (This is not easy!)
;   
;   ------------------------------------------------------------------------
;   [Exercise 2.92]: http://sicp-book.com/book-Z-H-18.html#%_thm_2.92
;   2.5.3 Example: Symbolic Algebra - p211
;   ------------------------------------------------------------------------

(-start- "2.92")



(--end-- "2.92")

;   ========================================================================
;   
;   Exercise 2.93
;   =============
;   
;   Modify the rational-arithmetic package to use generic operations, but
;   change make-rat so that it does not attempt to reduce fractions to
;   lowest terms.  Test your system by calling make-rational on two
;   polynomials to produce a rational function
;   
;   (define p1 (make-polynomial 'x '((2 1)(0 1))))
;   (define p2 (make-polynomial 'x '((3 1)(0 1))))
;   (define rf (make-rational p2 p1))
;   
;   Now add rf to itself, using add. You will observe that this addition
;   procedure does not reduce fractions to lowest terms.
;   
;   ------------------------------------------------------------------------
;   [Exercise 2.93]: http://sicp-book.com/book-Z-H-18.html#%_thm_2.93
;   2.5.3 Example: Symbolic Algebra - p212
;   ------------------------------------------------------------------------

(-start- "2.93")



(--end-- "2.93")

;   ========================================================================
;   
;   Exercise 2.94
;   =============
;   
;   Using div-terms, implement the procedure remainder-terms and use this to
;   define gcd-terms as above.  Now write a procedure gcd-poly that computes
;   the polynomial GCD of two polys. (The procedure should signal an error
;   if the two polys are not in the same variable.) Install in the system a
;   generic operation greatest-common-divisor that reduces to gcd-poly for
;   polynomials and to ordinary gcd for ordinary numbers.  As a test, try
;   
;   (define p1 (make-polynomial 'x '((4 1) (3 -1) (2 -2) (1 2))))
;   (define p2 (make-polynomial 'x '((3 1) (1 -1))))
;   (greatest-common-divisor p1 p2)
;   
;   and check your result by hand.
;   
;   ------------------------------------------------------------------------
;   [Exercise 2.94]: http://sicp-book.com/book-Z-H-18.html#%_thm_2.94
;   2.5.3 Example: Symbolic Algebra - p213
;   ------------------------------------------------------------------------

(-start- "2.94")



(--end-- "2.94")

;   ========================================================================
;   
;   Exercise 2.95
;   =============
;   
;   Define P₁, P₂, and P₃ to be the polynomials
;   
;   P₁ : x² - 2x + 1
;   
;   P₂ : 11x² + 7
;   
;   P₃ : 13x + 5
;   
;   Now define Q₁ to be the product of P₁ and P₂ and Q₂ to be the product of
;   P₁ and P₃, and use greatest-common-divisor (exercise [2.94]) to compute
;   the GCD of Q₁ and Q₂. Note that the answer is not the same as P₁. This
;   example introduces noninteger operations into the computation, causing
;   difficulties with the GCD algorithm.⁽⁶¹⁾ To understand what is
;   happening, try tracing gcd-terms while computing the GCD or try
;   performing the division by hand.
;   
;   ------------------------------------------------------------------------
;   [Exercise 2.95]: http://sicp-book.com/book-Z-H-18.html#%_thm_2.95
;   [Exercise 2.94]: http://sicp-book.com/book-Z-H-18.html#%_thm_2.94
;   [Footnote 61]:   http://sicp-book.com/book-Z-H-18.html#footnote_Temp_317
;   2.5.3 Example: Symbolic Algebra - p213
;   ------------------------------------------------------------------------

(-start- "2.95")



(--end-- "2.95")

;   ========================================================================
;   
;   Exercise 2.96
;   =============
;   
;   a.  Implement the procedure pseudoremainder-terms, which is just like
;   remainder-terms except that it multiplies the dividend by the
;   integerizing factor described above before calling div-terms. Modify
;   gcd-terms to use pseudoremainder-terms, and verify that
;   greatest-common-divisor now produces an answer with integer coefficients
;   on the example in exercise [2.95].
;   
;   b.  The GCD now has integer coefficients, but they are larger than those
;   of P₁.  Modify gcd-terms so that it removes common factors from the
;   coefficients of the answer by dividing all the coefficients by their
;   (integer) greatest common divisor.
;   
;   Thus, here is how to reduce a rational function to lowest terms:
;   
;   * Compute the GCD of the numerator and denominator, using the version of
;   gcd-terms from exercise [2.96].
;   
;   * When you obtain the GCD, multiply both numerator and denominator by
;   the same integerizing factor before dividing through by the GCD, so that
;   division by the GCD will not introduce any noninteger coefficients.  As
;   the factor you can use the leading coefficient of the GCD raised to the
;   power 1 + O₁ - O₂, where O₂ is the order of the GCD and O₁ is the
;   maximum of the orders of the numerator and denominator.  This will
;   ensure that dividing the numerator and denominator by the GCD will not
;   introduce any fractions.
;   
;   * The result of this operation will be a numerator and denominator with
;   integer coefficients.  The coefficients will normally be very large
;   because of all of the integerizing factors, so the last step is to
;   remove the redundant factors by computing the (integer) greatest common
;   divisor of all the coefficients of the numerator and the denominator and
;   dividing through by this factor.
;   
;   ------------------------------------------------------------------------
;   [Exercise 2.96]: http://sicp-book.com/book-Z-H-18.html#%_thm_2.96
;   [Exercise 2.95]: http://sicp-book.com/book-Z-H-18.html#%_thm_2.95
;   2.5.3 Example: Symbolic Algebra - p214
;   ------------------------------------------------------------------------

(-start- "2.96")



(--end-- "2.96")

;   ========================================================================
;   
;   Exercise 2.97
;   =============
;   
;   a. Implement this algorithm as a procedure reduce-terms that takes two
;   term lists n and d as arguments and returns a list nn, dd, which are n
;   and d reduced to lowest terms via the algorithm given above. Also write
;   a procedure reduce-poly, analogous to add-poly, that checks to see if
;   the two polys have the same variable.  If so, reduce-poly strips off the
;   variable and passes the problem to reduce-terms, then reattaches the
;   variable to the two term lists supplied by reduce-terms.
;   
;   b. Define a procedure analogous to reduce-terms that does what the
;   original make-rat did for integers:
;   
;   (define (reduce-integers n d)
;     (let ((g (gcd n d)))
;       (list (/ n g) (/ d g))))
;   
;   and define reduce as a generic operation that calls apply-generic to
;   dispatch to either reduce-poly (for polynomial arguments) or
;   reduce-integers (for scheme-number arguments). You can now easily make
;   the rational-arithmetic package reduce fractions to lowest terms by
;   having make-rat call reduce before combining the given numerator and
;   denominator to form a rational number. The system now handles rational
;   expressions in either integers or polynomials. To test your program, try
;   the example at the beginning of this extended exercise:
;   
;   (define p1 (make-polynomial 'x '((1 1)(0 1))))
;   (define p2 (make-polynomial 'x '((3 1)(0 -1))))
;   (define p3 (make-polynomial 'x '((1 1))))
;   (define p4 (make-polynomial 'x '((2 1)(0 -1))))
;   
;   (define rf1 (make-rational p1 p2))
;   (define rf2 (make-rational p3 p4))
;   
;   (add rf1 rf2)
;   
;   See if you get the correct answer, correctly reduced to lowest terms.
;   
;   The GCD computation is at the heart of any system that does operations
;   on rational functions.  The algorithm used above, although
;   mathematically straightforward, is extremely slow.  The slowness is due
;   partly to the large number of division operations and partly to the
;   enormous size of the intermediate coefficients generated by the
;   pseudodivisions.  One of the active areas in the development of
;   algebraic-manipulation systems is the design of better algorithms for
;   computing polynomial GCDs.⁽⁶²⁾
;   
;   ------------------------------------------------------------------------
;   [Exercise 2.97]: http://sicp-book.com/book-Z-H-18.html#%_thm_2.97
;   [Footnote 62]:   http://sicp-book.com/book-Z-H-18.html#footnote_Temp_320
;   2.5.3 Example: Symbolic Algebra - p215
;   ------------------------------------------------------------------------

(-start- "2.97")



(--end-- "2.97")

