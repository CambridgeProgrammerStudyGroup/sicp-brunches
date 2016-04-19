#lang racket

; Section 1.2.5: Greatest Common Divisors

(require "common.rkt")

;   Exercise 1.20
;   =============
;   
;   The process that a procedure generates is of course dependent on the
;   rules used by the interpreter.  As an example, consider the iterative
;   gcd procedure given above. Suppose we were to interpret this procedure
;   using normal-order evaluation, as discussed in section [1.1.5]. (The
;   normal-order-evaluation rule for if is described in exercise [1.5].)
;   Using the substitution method (for normal order), illustrate the process
;   generated in evaluating (gcd 206 40) and indicate the remainder
;   operations that are actually performed. How many remainder operations
;   are actually performed in the normal-order evaluation of (gcd 206 40)?
;   In the applicative-order evaluation?
;   
;   ------------------------------------------------------------------------
;   [Exercise 1.20]: http://sicp-book.com/book-Z-H-11.html#%_thm_1.20
;   [Section 1.1.5]: http://sicp-book.com/book-Z-H-10.html#%_sec_1.1.5
;   [Exercise 1.5]:  http://sicp-book.com/book-Z-H-11.html#%_thm_1.5
;   1.2.5 Greatest Common Divisors - p49
;   ------------------------------------------------------------------------

(-start- "1.20")

(prn "(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))

I originally thought in normal-order the argument was only evaluated
once, but it looks like I was wrong and it's evaluate each time it's
referenced. So...

To keep things readable the substitution doesn't take place till the
last step, in the meantime arguments that are to be evaulated are
indicated by the value we know they will hold and a tick.  E.g. if the
argument is (+ 2 2) it is as shown as 4'.

(Using 'R' instead of 'remainder' to save space)

(gcd 206 40)

     |
     V

(if (= 40 0)
 (gcd 40 (R 206 40)) )

     |
     V

(if (= 40 0)
 (if (= 6' 0))
  (gcd (R 40 6')) ))

     |
     V

(if (= 40 0)
 (if (= 6' 0)
  (if (= 4' 0)
   (gcd 4' (R 6' 4')) )))

     |
     V

(if (= 40' 0)
 (if (= 6' 0)
  (if (= 4' 0)
   (if (= 2' 0)
    (gcd 2' (R 4' 2')) ))))

     |
     V

(if (= 40 0)
 (if (= 6' 0)
  (if (= 4' 0)
   (if (= 2' 0)
    (if (= 0' 0)
      2' )))))

Substituting arguments for their place holders, specifically:
6' = (R 206 40)
4' = (R 40 (R 206 40))
2' = (R (R 206 40) (R 40 (R 206 40)))
0' = (R (R 40 (R 206 40)) (R (R 206 40) (R 40 (R 206 40))))

     |
     V

(if (= 40 0)
 (if (= (R 206 40) 0)
  (if (= (R 40 (R 206 40)) 0)
   (if (= (R (R 206 40) (R 40 (R 206 40))) 0)
    (if (= (R (R 40 (R 206 40)) (R (R 206 40) (R 40 (R 206 40)))) 0)
      (R (R 206 40) (R 40 (R 206 40))) )))))

Thats a predicted total of 18 calls to R/remainder with normal-order evaluation.

For applicative-order evaluation let's look at the simplified
substitution again:

(if (= 40 0)
 (if (= 6' 0)
  (if (= 4' 0)
   (if (= 2' 0)
    (if (= 0' 0)
      2' )))))

Each 'if', apart form the last one, resulted in a call to 'remainder'.
Thats 5 - 1 = 4.  As our interpreter is applicative we can check:
")

(define (R n m)
  (display "Hey it's R here!\n")
  (remainder n m))

(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (R a b))))

(ignore
 (gcd 206 40))

(--end-- "1.20")

