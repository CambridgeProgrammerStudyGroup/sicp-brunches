#lang racket

; Section 2.1.4: Extended Exercise: Interval Arithmetic

(require "common.rkt")

;   Exercise 2.7
;   ============
;   
;   Alyssa's program is incomplete because she has not specified the
;   implementation of the interval abstraction.  Here is a definition of the
;   interval constructor:
;   
;   (define (make-interval a b) (cons a b))
;   
;   Define selectors upper-bound and lower-bound to complete the
;   implementation.
;   
;   ------------------------------------------------------------------------
;   [Exercise 2.7]:  http://sicp-book.com/book-Z-H-14.html#%_thm_2.7
;   2.1.4 Extended Exercise: Interval Arithmetic - p94
;   ------------------------------------------------------------------------

(-start- "2.7")

(define (make-interval a b) (cons a b))

(define (upper-bound a)
  (let ((x (car a))
        (y (cdr a)))
    (if (> x y) x y)))

(define (lower-bound a)
  (let ((x (car a))
        (y (cdr a)))
    (if (< x y) x y)))

(let((bound-test1 (make-interval 4 6))
     (bound-test2 (make-interval 4 -6))
     (bound-test3 (make-interval -14 -6))
     (test-bounds (lambda (interval)
      (prn
       (str "interval: " interval)
       (str "    Upper bound: " (upper-bound interval))
       (str "    Lower bound: " (lower-bound interval))
       (str)))))
  (test-bounds bound-test1)
  (test-bounds bound-test2)
  (test-bounds bound-test3))
  

(--end-- "2.7")

;   ========================================================================
;   
;   Exercise 2.8
;   ============
;   
;   Using reasoning analogous to Alyssa's, describe how the difference of
;   two intervals may be computed.  Define a corresponding subtraction
;   procedure, called sub-interval.
;   
;   ------------------------------------------------------------------------
;   [Exercise 2.8]:  http://sicp-book.com/book-Z-H-14.html#%_thm_2.8
;   2.1.4 Extended Exercise: Interval Arithmetic - p95
;   ------------------------------------------------------------------------

(-start- "2.8")


(prn
 "We can include Alyssa's approach in subtraction by useig the"
 "substitution a - b  -> a + (- b)"
 "so define a negate function and use in Alyssa addition")

(define (add-interval x y)
  (make-interval (+ (lower-bound x) (lower-bound y))
                 (+ (upper-bound x) (upper-bound y))))

(define (negate-interval x)
  (make-interval (- (lower-bound x))
                 (- (upper-bound x))))

(define (sub-interval x y)
  (add-interval x (negate-interval y)))


(let ((fortyish (make-interval 39 41))
      (tenish (make-interval 9 11)))
  (prn
   (str)
   (str "  fourty-ish: " fortyish)
   (str "  Tenish: " tenish)
   (str "  fourtyish - tenish: " 
        (sub-interval fortyish tenish))))

(--end-- "2.8")

;   ========================================================================
;   
;   Exercise 2.9
;   ============
;   
;   The width of an interval is half of the difference between its upper and
;   lower bounds.  The width is a measure of the uncertainty of the number
;   specified by the interval.  For some arithmetic operations the width of
;   the result of combining two intervals is a function only of the widths
;   of the argument intervals, whereas for others the width of the
;   combination is not a function of the widths of the argument intervals. 
;   Show that the width of the sum (or difference) of two intervals is a
;   function only of the widths of the intervals being added (or
;   subtracted).  Give examples to show that this is not true for
;   multiplication or division.
;   
;   ------------------------------------------------------------------------
;   [Exercise 2.9]:  http://sicp-book.com/book-Z-H-14.html#%_thm_2.9
;   2.1.4 Extended Exercise: Interval Arithmetic - p95
;   ------------------------------------------------------------------------

(-start- "2.9")

(prn 
 "Why we can combine widths in addition (& therefore subraction):"
 
 "Given x with a lower bound of lx and upper bound of ux"
 "  and y with a lower bound of ly and upper bound of uy"
 "  under addtion the new width will be: "
 "    ((ux + uy) - (lx + ly)) / 2"
 "    = ((ux - lx) + (uy - ly)) / 2"
 "    = (2wx + 2wy) / 2"
 "    = wx + wy"
 "and that's good enough for me.")

(define (mul-interval x y)
  (let ((p1 (* (lower-bound x) (lower-bound y)))
        (p2 (* (lower-bound x) (upper-bound y)))
        (p3 (* (upper-bound x) (lower-bound y)))
        (p4 (* (upper-bound x) (upper-bound y))))
    (make-interval (min p1 p2 p3 p4)
                   (max p1 p2 p3 p4))))

(define (interval-width x)
   (/ (- (upper-bound x) (lower-bound x))
      2))


(let ((x (make-interval 9 11))
      (y (make-interval 999999 1000001)))  
  (prn
   "" "Lets try 'wx * wy' as a guess for the width after multiplication:"
   (str "x: " (lower-bound x) "-" (upper-bound x))
   (str "y: " (lower-bound y) "-" (upper-bound y))
   (str "Estimate: " (* (interval-width x) (interval-width y)))
   (str "Actual: " (interval-width  (mul-interval x y)))))


(prn
 "" "why?"
 "Assuming everything is positive..."
 "  width / 2"
 "    = (ux * uy) - (lx * ly)"
 "    = (lx + wx)*(ly + wy) - (lx * ly)"
 " which cannot be reduced to a form that has just wx and wy,"
 " so final width is dependant on both origanl 'values'")

(--end-- "2.9")

;   ========================================================================
;   
;   Exercise 2.10
;   =============
;   
;   Ben Bitdiddle, an expert systems programmer, looks over Alyssa's
;   shoulder and comments that it is not clear what it means to divide by an
;   interval that spans zero.  Modify Alyssa's code to check for this
;   condition and to signal an error if it occurs.
;   
;   ------------------------------------------------------------------------
;   [Exercise 2.10]: http://sicp-book.com/book-Z-H-14.html#%_thm_2.10
;   2.1.4 Extended Exercise: Interval Arithmetic - p95
;   ------------------------------------------------------------------------

(-start- "2.10")

(define (div-interval-unsafe x y)
  (mul-interval x
                (make-interval (/ 1.0 (upper-bound y))
                               (/ 1.0 (lower-bound y)))))

(define (div-interval x y)
  (if (>= 0 (* (lower-bound y) (upper-bound y)))
          (raise "Cannot do interval division when divisor includes zero")
          (div-interval-unsafe x y)))

    
(let ((tenish (make-interval 9 11))
      (hundredish (make-interval 99 101))
      (zeroish (make-interval -1 1)))
  (prn
   (str "Orignal 100ish / 10ish: " (div-interval-unsafe hundredish tenish))
   (str "New 100ish / 10ish: " (div-interval hundredish tenish))
   (str "Original 100ish / 0ish: " (div-interval-unsafe hundredish zeroish))
   (str "New 100ish / 0ish: "
        (with-handlers ([(lambda (exn) true) (lambda (exn) (str exn))])
          (div-interval hundredish zeroish)))))

(--end-- "2.10")

;   ========================================================================
;   
;   Exercise 2.11
;   =============
;   
;   In passing, Ben also cryptically comments: "By testing the signs of the
;   endpoints of the intervals, it is possible to break mul-interval into
;   nine cases, only one of which requires more than two multiplications."
;   Rewrite this procedure using Ben's suggestion.
;   
;   ------------------------------------------------------------------------
;   [Exercise 2.11]: http://sicp-book.com/book-Z-H-14.html#%_thm_2.11
;   2.1.4 Extended Exercise: Interval Arithmetic - p95
;   ------------------------------------------------------------------------

(-start- "2.11")

(define (mul-interval-ihateben x y)
  ; use LET* form that allows use of previous pairs
  ; change mi to (mi l1 l2 u1 u2) -> make-int l1.l2 u1.u2
  (let* (
         (neg "neg")
         (span "span")
         (pos "pos")
         (type (lambda (int)
              (cond
                ((> 0 (upper-bound int)) neg)
                ((> 0 (lower-bound int)) span)
                (else pos))
              ))
         (x-type (type x))
         (y-type (type y))
         (xy-have-type (lambda (type1 type2) (and (equal? x-type type1) (equal? y-type type2))))
         (lx (lower-bound x))
         (ux (upper-bound x))
         (ly (lower-bound y))
         (uy (upper-bound y))
         (make (lambda (l1 l2 u1 u2) (make-interval (* l1 l2) (* u1 u2))))
        )
    (cond
      ((xy-have-type pos pos) (make lx ly ux uy))
      ((xy-have-type pos span) (make ux ly ux uy))
      ((xy-have-type pos neg) (make ux ly lx uy))
      ((xy-have-type neg pos) (make lx uy ux ly))
      ((xy-have-type neg neg) (make ux uy lx ly))
      ((xy-have-type neg span) (make lx uy lx ly))
      ((xy-have-type span pos) (make lx uy ux uy))
      ((xy-have-type span neg) (make ux ly lx ly))
      ((xy-have-type span span)
       (make-interval (min (* lx uy) (* ux ly)) (max (* lx ly) (* ux uy))))
      (else raise "didn't expect to be here")
    )))
   
   (let ((pos (make-interval 9 11))
         (neg (make-interval -21 -19))
         (span (make-interval -0.5 1.5)))
     (prn
      (str "pos = " pos)
      (str "span = " span)
      (str "neg = " neg)
      (str)
      (str "pos x pos:  " (mul-interval-ihateben pos pos))
      (str "pos x neg:  " (mul-interval-ihateben pos neg))
      (str "pos x span:  " (mul-interval-ihateben pos span))
      (str "neg x pos:  " (mul-interval-ihateben neg pos))
      (str "neg x neg:  " (mul-interval-ihateben neg neg))
      (str "neg x span:  " (mul-interval-ihateben neg span))
      (str "span x pos:  " (mul-interval-ihateben span pos))
      (str "span x neg:  " (mul-interval-ihateben span neg))
      (str "span x span:  " (mul-interval-ihateben span span))))

(--end-- "2.11")

;   ========================================================================
;   
;   Exercise 2.12
;   =============
;   
;   Define a constructor make-center-percent that takes a center and a
;   percentage tolerance and produces the desired interval.  You must also
;   define a selector percent that produces the percentage tolerance for a
;   given interval.  The center selector is the same as the one shown above.
;   
;   ------------------------------------------------------------------------
;   [Exercise 2.12]: http://sicp-book.com/book-Z-H-14.html#%_thm_2.12
;   2.1.4 Extended Exercise: Interval Arithmetic - p96
;   ------------------------------------------------------------------------

(-start- "2.12")

(define (make-center-percent c %)
  (let ((tol (/ (* % c) 100)))
    (make-interval (- c tol) (+ c tol))))

(define (center interval)
  (/ (+ (lower-bound interval)
        (upper-bound interval))
     2))
        
(define (percentage interval)
  (/ (* 50 ; 100% / 2 because tolerance is half of interval)
        (- (upper-bound interval) (lower-bound interval)))
     (center interval))) 
        
(let ((interval (make-center-percent 100 3)))
  (prn
   "Creating interval with centre 100 and percentage 3"
   (str "Got: " interval)
  (str "Center: " (center interval))
  (str "Percentage: " (percentage interval))))

(--end-- "2.12")

;   ========================================================================
;   
;   Exercise 2.13
;   =============
;   
;   Show that under the assumption of small percentage tolerances there is a
;   simple formula for the approximate percentage tolerance of the product
;   of two intervals in terms of the tolerances of the factors. You may
;   simplify the problem by assuming that all numbers are positive.
;   
;   ------------------------------------------------------------------------
;   [Exercise 2.13]: http://sicp-book.com/book-Z-H-14.html#%_thm_2.13
;   2.1.4 Extended Exercise: Interval Arithmetic - p96
;   ------------------------------------------------------------------------

(-start- "2.13")

(prn "Note: For convenience using numbers as percentage e.g. using 0.12 for
12%"
     ""
 "so P percent of N is P x N instead of (P x N)/100"
 ""
 "Given intervals center, percent intervals: c1, p1  and c2, p2:"
 ""
 "Tolerence ti = ci * pi"
 ""
 "Expressing as min -> max intervals we have:"
 "(c1 - t1) -> (c1 + t1)"
 "(c2 - t2) -> (c2 + t2)"
 ""
 "Product of these intervals:"
 "(c1 - t1)(c2 - t2) -> (c1 + t1)(c2 + t2)"
 ""
 "Precentage (tolerence) of Product:"
 ""
 "1/2 *    (max - min)"
 "	  -----------------"
 "	  1/2 * (max + min)"
 ""
 "=>"
 ""
 "(c1 + t1)(c2 + t2) - (c1 - t1)(c2 - t2)"
 "---------------------------------------"
 "(c1 + t1)(c2 + t2) + (c1 - t1)(c2 - t2)"
 ""
 "=>"
 ""
 "2(c1.t2 + c2.t1)"
 "----------------"
 "2(c1.c2 + t1.t2)"
 ""
 "If p1 and p2 are small then t1.t2 is small so can approximate as:"
 ""
 "(c1.t2 + c2.t1)"
 "---------------"
 "     c1.c2"
 ""
 "=>"
 ""
 "t2   t1"
 "-- + --"
 "c2   c2"
 ""
 "=>"
 ""
 "p1 + p2")

(--end-- "2.13")

;   ========================================================================
;   
;   Exercise 2.14
;   =============
;   
;   Demonstrate that Lem is right. Investigate the behavior of the system on
;   a variety of arithmetic expressions. Make some intervals A and B, and
;   use them in computing the expressions A/A and A/B.  You will get the
;   most insight by using intervals whose width is a small percentage of the
;   center value. Examine the results of the computation in center-percent
;   form (see exercise [2.12]).
;   
;   ------------------------------------------------------------------------
;   [Exercise 2.14]: http://sicp-book.com/book-Z-H-14.html#%_thm_2.14
;   [Exercise 2.12]: http://sicp-book.com/book-Z-H-14.html#%_thm_2.12
;   2.1.4 Extended Exercise: Interval Arithmetic - p97
;   ------------------------------------------------------------------------

(-start- "2.14")

(define (par1 r1 r2)
  (div-interval (mul-interval r1 r2)
               (add-interval r1 r2)))

(define (par2 r1 r2)
  (let ((one (make-interval 1 1)))
    (div-interval one
                  (add-interval (div-interval one r1)
                                (div-interval one r2)))))

(let* ((make make-interval)
       (r1 (make 99 101))
       (r2 (make 199 201)))
  (prn
   (str "par1: " (par1 r1 r2))
   (str "par2: " (par2 r1 r2))))

(--end-- "2.14")

;   ========================================================================
;   
;   Exercise 2.15
;   =============
;   
;   Eva Lu Ator, another user, has also noticed the different intervals
;   computed by different but algebraically equivalent expressions. She says
;   that a formula to compute with intervals using Alyssa's system will
;   produce tighter error bounds if it can be written in such a form that no
;   variable that represents an uncertain number is repeated. Thus, she
;   says, par2 is a "better" program for parallel resistances than par1.  Is
;   she right?  Why?
;   
;   ------------------------------------------------------------------------
;   [Exercise 2.15]: http://sicp-book.com/book-Z-H-14.html#%_thm_2.15
;   2.1.4 Extended Exercise: Interval Arithmetic - p97
;   ------------------------------------------------------------------------

(-start- "2.15")

(prn
 "Eva Lu Ator is right."
 ""
 "There are certainly cases where including the same uncertain number"
 "twice does result in a wider than necessary answer."
 ""
 "I don't *think* it's a problem with addition and multiplication"
 "if x in the range l to u then x + x and x.x are in range 2l to 2u "
 "and l.l to u.u respectively."
 ""
 "but in the case of x - x the 'correct' width is always zero whereas the"
 "general substitution gives us a range of -2w to 2w (where w is width)."
 "Similarly with division the x / x is always 1 but general substitution"
 "will give a range (x-w)/(x+w) to (x+w)/(x-w)")

(--end-- "2.15")

;   ========================================================================
;   
;   Exercise 2.16
;   =============
;   
;   Explain, in general, why equivalent algebraic expressions may lead to
;   different answers.  Can you devise an interval-arithmetic package that
;   does not have this shortcoming, or is this task impossible?  (Warning:
;   This problem is very difficult.)
;   
;   ------------------------------------------------------------------------
;   [Exercise 2.16]: http://sicp-book.com/book-Z-H-14.html#%_thm_2.16
;   2.1.4 Extended Exercise: Interval Arithmetic - p97
;   ------------------------------------------------------------------------

(-start- "2.16")

(prn
 "This can be done given:"
 "  S: s-expression -> symbolic-reprsentation"
 "  N: symbolic-representation -> normalized symbolic-representation"
 "  L: symbolic-representation -> s-expression"
 ""
 "Given these and two algebraicly equivelant expressaion e1 and e2"
 "L.N.S(e1) = e3 (say) = L.N.S(e2)"
 ""
 "Of course N is impossible")

(--end-- "2.16")

