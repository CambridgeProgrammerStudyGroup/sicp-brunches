#lang sicp

(#%require "common.scm")

;   Exercise 3.6
;   ============
;   
;   It is useful to be able to reset a random-number generator to produce a
;   sequence starting from a given value.  Design a new rand procedure that
;   is called with an argument that is either the symbol generate or the
;   symbol reset and behaves as follows: (rand 'generate) produces a new
;   random number; ((rand 'reset) <new-value>) resets the internal state
;   variable to the designated <new-value>.  Thus, by resetting the state,
;   one can generate repeatable sequences.  These are very handy to have
;   when testing and debugging programs that use random numbers.
;   
;   ------------------------------------------------------------------------
;   [Exercise 3.6]:  http://sicp-book.com/book-Z-H-20.html#%_thm_3.6
;   3.1.2 The Benefits of Introducing Assignment - p229
;   ------------------------------------------------------------------------

(-start- "3.6")

(define rand-size (expt 2 32))

(define rand-update
  (lambda (x)
    (let ((a 1664525)
          (b 1013904223)
          (m rand-size))
      (modulo
       (+ (* x a) b)
       m))))

(define (rand)
  (define x 0)
  (lambda (method)
    (cond
      ((eq? method 'generate)
       (set! x (rand-update x))
       x)
      ((eq? method 'reset)
       (lambda (seed) (set! x seed)))
      (else ((error "Unknown Method - " method))))))

(define r (rand))

(prn "Expect default output with default seed zero:
    (1013904223, 1196435762, 3519870697)")
(r 'generate)
(r 'generate)
(r 'generate)

(prn "
Expect new sequence with new seed 351181:
    (1447905992, 3081727879, 1526097722)")
((r 'reset) 351181)
(r 'generate)
(r 'generate)
(r 'generate)

(prn "
Expect sequence to continue with different values:
    (482168145, 2881693308, 2026459051)")
(r 'generate)
(r 'generate)
(r 'generate)

(prn "
Expect repeat of (second) sequence after resetting to 351181:
    (1447905992, 3081727879, 1526097722)")
((r 'reset) 351181)
(r 'generate)
(r 'generate)
(r 'generate)

(--end-- "3.6")