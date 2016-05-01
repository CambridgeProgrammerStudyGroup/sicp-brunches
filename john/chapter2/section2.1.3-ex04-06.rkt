#lang racket

; Section 2.1.3: What Is Meant by Data?

(require "common.rkt")

;   Exercise 2.4
;   ============
;   
;   Here is an alternative procedural representation of pairs.  For this
;   representation, verify that (car (cons x y)) yields x for any objects x
;   and y.
;   
;   (define (cons x y)
;     (lambda (m) (m x y)))
;   
;   (define (car z)
;     (z (lambda (p q) p)))
;   
;   What is the corresponding definition of cdr? (Hint: To verify that this
;   works, make use of the substitution model of section [1.1.5].)
;   
;   ------------------------------------------------------------------------
;   [Exercise 2.4]:  http://sicp-book.com/book-Z-H-14.html#%_thm_2.4
;   [Section 1.1.5]: http://sicp-book.com/book-Z-H-10.html#%_sec_1.1.5
;   2.1.3 What Is Meant by Data? - p92
;   ------------------------------------------------------------------------

(-start- "2.4")

(prn
 (str "require (car (con x y)) equel x.")
 (str)
 (str "substituting (z (lambda (p q) p)) for (car z)")
 (str "(con (lambda (p q) p))")
 (str)
 (str "substituting (lambda (m) (m x y)) for (cons x y)")
 (str "((lambda (m) (m x y) (lambda (p q) p))")
 (str "((lambda (p q) p) x y)")
 (str "x")
 (str))

(define (Cons x y)
  (lambda (m) (m x y)))

(define (Car z)
  (z (lambda (p q) p)))

(define (Cdr z)
  (z (lambda (p q) q)))

(let* ((x "I am X")
      (y "I am Y")
      (z (Cons x y)))
  (prn
   (str "Check it works with an example:")
   (str "(Car z): " (Car z))
   (str "(Cdr z): " (Cdr z))))

(--end-- "2.4")

;   ========================================================================
;   
;   Exercise 2.5
;   ============
;   
;   Show that we can represent pairs of nonnegative integers using only
;   numbers and arithmetic operations if we represent the pair a and b as
;   the integer that is the product 2^a 3^b.  Give the corresponding
;   definitions of the procedures cons, car, and cdr.
;   
;   ------------------------------------------------------------------------
;   [Exercise 2.5]:  http://sicp-book.com/book-Z-H-14.html#%_thm_2.5
;   2.1.3 What Is Meant by Data? - p92
;   ------------------------------------------------------------------------

(-start- "2.5")

(define (exp-in f n)
  (if (= 0 (remainder n f))
      (+ 1 (exp-in f (/ n f)))
      0))

(define (eCons a b)
  (* (expt 2 a) (expt 3 b)))

(define (eCar z)
  (exp-in 2 z))

(define (eCdr z)
  (exp-in 3 z))

(let* ((x 13)
       (y 17)
       (z (eCons x y)))
  (prn
   (str "x: " x)
   (str "y: " y)
   (str "'value' of (eCons x y): " z)
   (str "car: " (eCar z))
   (str "cdr: " (eCdr z))))


(--end-- "2.5")

;   ========================================================================
;   
;   Exercise 2.6
;   ============
;   
;   In case representing pairs as procedures wasn't mind-boggling enough,
;   consider that, in a language that can manipulate procedures, we can get
;   by without numbers (at least insofar as nonnegative integers are
;   concerned) by implementing 0 and the operation of adding 1 as
;   
;   (define zero (lambda (f) (lambda (x) x)))
;   
;   (define (add-1 n)
;     (lambda (f) (lambda (x) (f ((n f) x)))))
;   
;   This representation is known as Church numerals, after its inventor,
;   Alonzo Church, the logician who invented the λ calculus.
;   
;   Define one and two directly (not in terms of zero and add-1).  (Hint:
;   Use substitution to evaluate (add-1 zero)). Give a direct definition of
;   the addition procedure + (not in terms of repeated application of
;   add-1).
;   
;   ------------------------------------------------------------------------
;   [Exercise 2.6]:  http://sicp-book.com/book-Z-H-14.html#%_thm_2.6
;   2.1.3 What Is Meant by Data? - p93
;   ------------------------------------------------------------------------

(-start- "2.6")

(define zero (lambda (f) (lambda (x) x)))

(define (add-1 n)
  (lambda (f) (lambda (x) (f ((n f) x)))))

(define one (lambda (f) (lambda (x) (f x))))

(define two (lambda (f) (lambda (x) (f (f x)))))

(define three (add-1 two))

(define x "")
(define (f x) (string-append x "I"))

(prn
 (str "zero:      '" ((zero f) x) "'") 
 (str "one:       '" ((one f) x) "'")
 (str "two:       '" ((two f) x) "'")
 (str "one add-1: '" (((add-1 one) f) x) "'")
 (str "two add-1: '" (((add-1 two) f) x) "'")
 (str "three:     '" ((three f) x)"'"))

(define (add n m)
  (lambda (f) (lambda (x) ((m f)((n f) x)))))

(define (mult n m)
  (lambda (f) (n (m f))))

(define (Expt n m)
  (lambda (f) ((m n) f)))

(prn
 (str)
 (str "one + two:   '" (((add one two) f) x) "'")
 (str "two + three: '" (((add two three) f) x) "'")
 (str)
 (str "two * two:     '" (((mult two two) f) x) "'")
 (str "two * three:   '" (((mult two three) f) x) "'")
 (str "three * three: '" (((mult three three) f) x) "'")
 (str)
 (str "two ^ zero:    '" (((Expt two zero) f) x) "'")
 (str "two ^ one:     '" (((Expt two one) f) x) "'")
 (str "two ^ two:     '" (((Expt two two) f) x) "'")
 (str "two ^ three:   '" (((Expt two three) f) x) "'")
 (str "three ^ three: '" (((Expt three three) f) x) "'"))

(--end-- "2.6")

