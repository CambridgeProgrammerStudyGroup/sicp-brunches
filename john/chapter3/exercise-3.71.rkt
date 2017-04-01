#lang racket

(require "common.rkt")

;   Exercise 3.71
;   =============
;   
;   Numbers that can be expressed as the sum of two cubes in more than one
;   way are sometimes called Ramanujan numbers, in honor of the
;   mathematician Srinivasa Ramanujan.⁽⁷⁰⁾ Ordered streams of pairs provide
;   an elegant solution to the problem of computing these numbers.  To find
;   a number that can be written as the sum of two cubes in two different
;   ways, we need only generate the stream of pairs of integers (i,j)
;   weighted according to the sum i³ + j³ (see exercise [3.70]), then search
;   the stream for two consecutive pairs with the same weight.  Write a
;   procedure to generate the Ramanujan numbers.  The first such number is
;   1,729.  What are the next five?
;   
;   ------------------------------------------------------------------------
;   [Exercise 3.71]: http://sicp-book.com/book-Z-H-24.html#%_thm_3.71
;   [Exercise 3.70]: http://sicp-book.com/book-Z-H-24.html#%_thm_3.70
;   [Footnote 70]:   http://sicp-book.com/book-Z-H-24.html#footnote_Temp_487
;   3.5.3 Exploiting the Stream Paradigm - p342
;   ------------------------------------------------------------------------

(-start- "3.71")



(--end-- "3.71")

