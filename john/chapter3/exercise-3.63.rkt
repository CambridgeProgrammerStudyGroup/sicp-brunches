#lang racket

(require "common.rkt")

;   Exercise 3.63
;   =============
;   
;   Louis Reasoner asks why the sqrt-stream procedure was not written in the
;   following more straightforward way, without the local variable guesses:
;   
;   (define (sqrt-stream x)
;     (cons-stream 1.0
;                  (stream-map (lambda (guess)
;                                (sqrt-improve guess x))
;                              (sqrt-stream x))))
;   
;   Alyssa P. Hacker replies that this version of the procedure is
;   considerably less efficient because it performs redundant computation.
;   Explain Alyssa's answer.  Would the two versions still differ in
;   efficiency if our implementation of delay used only (lambda () <exp>)
;   without using the optimization provided by memo-proc (section [3.5.1])?
;   
;   ------------------------------------------------------------------------
;   [Exercise 3.63]: http://sicp-book.com/book-Z-H-24.html#%_thm_3.63
;   [Section 3.5.1]: http://sicp-book.com/book-Z-H-24.html#%_sec_3.5.1
;   3.5.3 Exploiting the Stream Paradigm - p338
;   ------------------------------------------------------------------------

(-start- "3.63")



(--end-- "3.63")

