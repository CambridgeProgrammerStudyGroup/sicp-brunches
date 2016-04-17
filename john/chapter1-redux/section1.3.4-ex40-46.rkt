#lang racket

; Section 1.3.4: Procedures as Returned Values

(require "common.rkt")

;   Exercise 1.40
;   =============
;   
;   Define a procedure cubic that can be used together with the
;   newtons-method procedure in expressions of the form
;   
;   (newtons-method (cubic a b c) 1)
;   
;   to approximate zeros of the cubic x³ + ax² + bx + c.
;   
;   ------------------------------------------------------------------------
;   [Exercise 1.40]: http://sicp-book.com/book-Z-H-12.html#%_thm_1.40
;   1.3.4 Procedures as Returned Values - p77
;   ------------------------------------------------------------------------

(-start- "1.40")



(--end-- "1.40")

;   ========================================================================
;   
;   Exercise 1.41
;   =============
;   
;   Define a procedure double that takes a procedure of one argument as
;   argument and returns a procedure that applies the original procedure
;   twice.  For example, if inc is a procedure that adds 1 to its argument,
;   then (double inc) should be a procedure that adds 2.  What value is
;   returned by
;   
;   (((double (double double)) inc) 5)
;   
;   ------------------------------------------------------------------------
;   [Exercise 1.41]: http://sicp-book.com/book-Z-H-12.html#%_thm_1.41
;   1.3.4 Procedures as Returned Values - p77
;   ------------------------------------------------------------------------

(-start- "1.41")



(--end-- "1.41")

;   ========================================================================
;   
;   Exercise 1.42
;   =============
;   
;   Let f and g be two one-argument functions.  The composition f after g is
;   defined to be the function x → f(g(x)). Define a procedure compose that
;   implements composition.  For example, if inc is a procedure that adds 1
;   to its argument,
;   
;   ((compose square inc) 6)
;   49
;   
;   ------------------------------------------------------------------------
;   [Exercise 1.42]: http://sicp-book.com/book-Z-H-12.html#%_thm_1.42
;   1.3.4 Procedures as Returned Values - p77
;   ------------------------------------------------------------------------

(-start- "1.42")



(--end-- "1.42")

;   ========================================================================
;   
;   Exercise 1.43
;   =============
;   
;   If f is a numerical function and n is a positive integer, then we can
;   form the nth repeated application of f, which is defined to be the
;   function whose value at x is f(f(...(f(x))...)).  For example, if f is
;   the function x → x + 1, then the nth repeated application of f is the
;   function x → x + n.  If f is the operation of squaring a number, then
;   the nth repeated application of f is the function that raises its
;   argument to the 2ⁿth power.  Write a procedure that takes as inputs a
;   procedure that computes f and a positive integer n and returns the
;   procedure that computes the nth repeated application of f.  Your
;   procedure should be able to be used as follows:
;   
;   ((repeated square 2) 5)
;   625
;   
;   Hint: You may find it convenient to use compose from exercise [1.42].
;   
;   ------------------------------------------------------------------------
;   [Exercise 1.43]: http://sicp-book.com/book-Z-H-12.html#%_thm_1.43
;   [Exercise 1.42]: http://sicp-book.com/book-Z-H-12.html#%_thm_1.42
;   1.3.4 Procedures as Returned Values - p77
;   ------------------------------------------------------------------------

(-start- "1.43")



(--end-- "1.43")

;   ========================================================================
;   
;   Exercise 1.44
;   =============
;   
;   The idea of smoothing a function is an important concept in signal
;   processing.  If f is a function and dx is some small number, then the
;   smoothed version of f is the function whose value at a point x is the
;   average of f(x - dx), f(x), and f(x + dx).  Write a procedure smooth
;   that takes as input a procedure that computes f and returns a procedure
;   that computes the smoothed f.  It is sometimes valuable to repeatedly
;   smooth a function (that is, smooth the smoothed function, and so on) to
;   obtained the n-fold smoothed function.  Show how to generate the n-fold
;   smoothed function of any given function using smooth and repeated from
;   exercise [1.43].
;   
;   ------------------------------------------------------------------------
;   [Exercise 1.44]: http://sicp-book.com/book-Z-H-12.html#%_thm_1.44
;   [Exercise 1.43]: http://sicp-book.com/book-Z-H-12.html#%_thm_1.43
;   1.3.4 Procedures as Returned Values - p78
;   ------------------------------------------------------------------------

(-start- "1.44")



(--end-- "1.44")

;   ========================================================================
;   
;   Exercise 1.45
;   =============
;   
;   We saw in section [1.3.3] that attempting to compute square roots by
;   naively finding a fixed point of y → x/y does not converge, and that
;   this can be fixed by average damping.  The same method works for finding
;   cube roots as fixed points of the average-damped y → x/y².
;   Unfortunately, the process does not work for fourth roots -- a single
;   average damp is not enough to make a fixed-point search for y → x/y³
;   converge.  On the other hand, if we average damp twice (i.e., use the
;   average damp of the average damp of y → x/y³) the fixed-point search
;   does converge.  Do some experiments to determine how many average damps
;   are required to compute nth roots as a fixed-point search based upon
;   repeated average damping of y → x/yⁿ⁻¹.  Use this to implement a simple
;   procedure for computing nth roots using fixed-point, average-damp, and
;   the repeated procedure of exercise [1.43]. Assume that any arithmetic
;   operations you need are available as primitives.
;   
;   ------------------------------------------------------------------------
;   [Exercise 1.45]: http://sicp-book.com/book-Z-H-12.html#%_thm_1.45
;   [Section 1.3.3]: http://sicp-book.com/book-Z-H-12.html#%_sec_1.3.3
;   [Exercise 1.43]: http://sicp-book.com/book-Z-H-12.html#%_thm_1.43
;   1.3.4 Procedures as Returned Values - p78
;   ------------------------------------------------------------------------

(-start- "1.45")



(--end-- "1.45")

;   ========================================================================
;   
;   Exercise 1.46
;   =============
;   
;   Several of the numerical methods described in this chapter are instances
;   of an extremely general computational strategy known as iterative
;   improvement.  Iterative improvement says that, to compute something, we
;   start with an initial guess for the answer, test if the guess is good
;   enough, and otherwise improve the guess and continue the process using
;   the improved guess as the new guess.  Write a procedure
;   iterative-improve that takes two procedures as arguments: a method for
;   telling whether a guess is good enough and a method for improving a
;   guess.  Iterative-improve should return as its value a procedure that
;   takes a guess as argument and keeps improving the guess until it is good
;   enough.  Rewrite the sqrt procedure of section [1.1.7] and the
;   fixed-point procedure of section [1.3.3] in terms of iterative-improve.
;   
;   ------------------------------------------------------------------------
;   [Exercise 1.46]: http://sicp-book.com/book-Z-H-12.html#%_thm_1.46
;   [Section 1.1.7]: http://sicp-book.com/book-Z-H-10.html#%_sec_1.1.7
;   [Section 1.3.3]: http://sicp-book.com/book-Z-H-12.html#%_sec_1.3.3
;   1.3.4 Procedures as Returned Values - p78
;   ------------------------------------------------------------------------

(-start- "1.46")



(--end-- "1.46")

