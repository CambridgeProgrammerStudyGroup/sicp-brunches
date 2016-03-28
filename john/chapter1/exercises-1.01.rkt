#lang racket

; Chapter 1 Redux

(require "util.rkt")

;   ========================================================================
;   
;   Exercise 1.1
;   ============
;   
;   Below is a sequence of expressions. What is the result printed by the
;   interpreter in response to each expression?  Assume that the sequence is
;   to be evaluated in the order in which it is presented.
;   
;   10
;   (+ 5 3 4)
;   (- 9 1)
;   (/ 6 2)
;   (+ (* 2 4) (- 4 6))
;   (define a 3)
;   (define b (+ a 1))
;   (+ a b (* a b))
;   (= a b)
;   (if (and (< b a) (< b (* a b)))
;       b
;       a)
;   (cond ((= a 4) 6)
;         ((= b 4) (+ 6 7 a))
;         (else 25))
;   (+ 2 (if (< b a) b a))
;   (* (cond ((< a b) a)
;            ((< a b) b)
;            (else -1))
;      (+ a 1))
;   
;   
;   ------------------------------------------------------------------------
;   [Exercise 1.1]: http://sicp-book.com/book-Z-H-10.html#%_thm_1.1
;   ------------------------------------------------------------------------

(output "Exercise 1.1")

(prn
 ""
 "Predicted:"
 "10"
 "8"
 "12"
 "3"
 "6"
 "-"
 "-"
 "19"
 "#false"
 "4"
 "16"
 "6"
 "16"
 "")

(prn
 "Actual:"
 10
 (+ 5 3 4)
 (- 9 1)
 (/ 6 2)
 (+ (* 2 4) (- 4 6)))
(define a 3)
(define b (+ a 1))
(prn
 (+ a b (* a b))
 (= a b)
 (if (and (> b a) (< b (* a b)))
     b
     a)
 
 (cond ((= a 4) 6)
       ((= b 4) (+ 6 7 a))
       (else 25))
 
 (+ 2 (if (> b a) b a))
 
 (* (cond ((> a b) a)
          ((< a b) b)
          (else -1))
    (+ a 1)))

;>  ----------------------------------------------------------------------------
;>  Exercise 1.1 (output)
;>  ----------------------------------------------------------------------------
;>  
;>  Predicted:
;>  10
;>  8
;>  12
;>  3
;>  6
;>  -
;>  -
;>  19
;>  #false
;>  4
;>  16
;>  6
;>  16
;>  
;>  Actual:
;>  10
;>  12
;>  8
;>  3
;>  6
;>  19
;>  #f
;>  4
;>  16
;>  6
;>  16

