#lang racket

; Section 2.5.2: Combining Data of Different Types

(require "common.rkt")

;   Exercise 2.81
;   =============
;   
;   Louis Reasoner has noticed that apply-generic may try to coerce the
;   arguments to each other's type even if they already have the same type. 
;   Therefore, he reasons, we need to put procedures in the coercion table
;   to "coerce" arguments of each type to their own type.  For example, in
;   addition to the scheme-number->complex coercion shown above, he would
;   do:
;   
;   (define (scheme-number->scheme-number n) n)
;   (define (complex->complex z) z)
;   (put-coercion 'scheme-number 'scheme-number
;                 scheme-number->scheme-number)
;   (put-coercion 'complex 'complex complex->complex)
;   
;   a. With Louis's coercion procedures installed, what happens if
;   apply-generic is called with two arguments of type scheme-number or two
;   arguments of type complex for an operation that is not found in the
;   table for those types?  For example, assume that we've defined a generic
;   exponentiation operation:
;   
;   (define (exp x y) (apply-generic 'exp x y))
;   
;   and have put a procedure for exponentiation in the Scheme-number package
;   but not in any other package:
;   
;   ;; following added to Scheme-number package
;   (put 'exp '(scheme-number scheme-number)
;        (lambda (x y) (tag (expt x y)))) ; using primitive expt
;   
;   What happens if we call exp with two complex numbers as arguments?
;   
;   b. Is Louis correct that something had to be done about coercion with
;   arguments of the same type, or does apply-generic work correctly as is?
;   
;   c. Modify apply-generic so that it doesn't try coercion if the two
;   arguments have the same type.
;   
;   ------------------------------------------------------------------------
;   [Exercise 2.81]: http://sicp-book.com/book-Z-H-18.html#%_thm_2.81
;   2.5.2 Combining Data of Different Types - p200
;   ------------------------------------------------------------------------

(-start- "2.81")



(--end-- "2.81")

;   ========================================================================
;   
;   Exercise 2.82
;   =============
;   
;   Show how to generalize apply-generic to handle coercion in the general
;   case of multiple arguments.  One strategy is to attempt to coerce all
;   the arguments to the type of the first argument, then to the type of the
;   second argument, and so on.  Give an example of a situation where this
;   strategy (and likewise the two-argument version given above) is not
;   sufficiently general.  (Hint: Consider the case where there are some
;   suitable mixed-type operations present in the table that will not be
;   tried.)
;   
;   ------------------------------------------------------------------------
;   [Exercise 2.82]: http://sicp-book.com/book-Z-H-18.html#%_thm_2.82
;   2.5.2 Combining Data of Different Types - p201
;   ------------------------------------------------------------------------

(-start- "2.82")



(--end-- "2.82")

;   ========================================================================
;   
;   Exercise 2.83
;   =============
;   
;   Suppose you are designing a generic arithmetic system for dealing with
;   the tower of types shown in figure [2.25]: integer, rational, real,
;   complex.  For each type (except complex), design a procedure that raises
;   objects of that type one level in the tower.  Show how to install a
;   generic raise operation that will work for each type (except complex).
;   
;   ------------------------------------------------------------------------
;   [Exercise 2.83]: http://sicp-book.com/book-Z-H-18.html#%_thm_2.83
;   [Figure 2.25]:   http://sicp-book.com/book-Z-H-18.html#%_fig_2.25
;   2.5.2 Combining Data of Different Types - p201
;   ------------------------------------------------------------------------

(-start- "2.83")



(--end-- "2.83")

;   ========================================================================
;   
;   Exercise 2.84
;   =============
;   
;   Using the raise operation of exercise [2.83], modify the apply-generic
;   procedure so that it coerces its arguments to have the same type by the
;   method of successive raising, as discussed in this section.  You will
;   need to devise a way to test which of two types is higher in the tower. 
;   Do this in a manner that is "compatible" with the rest of the system and
;   will not lead to problems in adding new levels to the tower.
;   
;   ------------------------------------------------------------------------
;   [Exercise 2.84]: http://sicp-book.com/book-Z-H-18.html#%_thm_2.84
;   [Exercise 2.83]: http://sicp-book.com/book-Z-H-18.html#%_thm_2.83
;   2.5.2 Combining Data of Different Types - p201
;   ------------------------------------------------------------------------

(-start- "2.84")



(--end-- "2.84")

;   ========================================================================
;   
;   Exercise 2.85
;   =============
;   
;   This section mentioned a method for "simplifying" a data object by
;   lowering it in the tower of types as far as possible.  Design a
;   procedure drop that accomplishes this for the tower described in
;   exercise [2.83].  The key is to decide, in some general way, whether an
;   object can be lowered.  For example, the complex number 1.5 + 0i can be
;   lowered as far as real, the complex number 1 + 0i can be lowered as far
;   as integer, and the complex number 2 + 3i cannot be lowered at all. 
;   Here is a plan for determining whether an object can be lowered: Begin
;   by defining a generic operation project that "pushes" an object down in
;   the tower.  For example, projecting a complex number would involve
;   throwing away the imaginary part.  Then a number can be dropped if, when
;   we project it and raise the result back to the type we started with, we
;   end up with something equal to what we started with.  Show how to
;   implement this idea in detail, by writing a drop procedure that drops an
;   object as far as possible.  You will need to design the various
;   projection operations⁽⁵³⁾ and install project as a generic operation in
;   the system.  You will also need to make use of a generic equality
;   predicate, such as described in exercise [2.79].  Finally, use drop to
;   rewrite apply-generic from exercise [2.84] so that it "simplifies" its
;   answers.
;   
;   ------------------------------------------------------------------------
;   [Exercise 2.85]: http://sicp-book.com/book-Z-H-18.html#%_thm_2.85
;   [Exercise 2.83]: http://sicp-book.com/book-Z-H-18.html#%_thm_2.83
;   [Exercise 2.79]: http://sicp-book.com/book-Z-H-18.html#%_thm_2.79
;   [Exercise 2.84]: http://sicp-book.com/book-Z-H-18.html#%_thm_2.84
;   [Footnote 53]:   http://sicp-book.com/book-Z-H-18.html#footnote_Temp_295
;   2.5.2 Combining Data of Different Types - p201
;   ------------------------------------------------------------------------

(-start- "2.85")



(--end-- "2.85")

;   ========================================================================
;   
;   Exercise 2.86
;   =============
;   
;   Suppose we want to handle complex numbers whose real parts, imaginary
;   parts, magnitudes, and angles can be either ordinary numbers, rational
;   numbers, or other numbers we might wish to add to the system.  Describe
;   and implement the changes to the system needed to accommodate this.  You
;   will have to define operations such as sine and cosine that are generic
;   over ordinary numbers and rational numbers.
;   
;   ------------------------------------------------------------------------
;   [Exercise 2.86]: http://sicp-book.com/book-Z-H-18.html#%_thm_2.86
;   2.5.2 Combining Data of Different Types - p202
;   ------------------------------------------------------------------------

(-start- "2.86")



(--end-- "2.86")

