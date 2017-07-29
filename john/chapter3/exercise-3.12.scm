#lang sicp

(#%require "common.scm")

;   Exercise 3.12
;   =============
;   
;   The following procedure for appending lists was introduced in section
;   [2.2.1]:
;   
;   (define (append x y)
;     (if (null? x)
;         y
;         (cons (car x) (append (cdr x) y))))
;   
;   Append forms a new list by successively consing the elements of x onto
;   y.  The procedure append! is similar to append, but it is a mutator
;   rather than a constructor. It appends the lists by splicing them
;   together, modifying the final pair of x so that its cdr is now y. (It is
;   an error to call append! with an empty x.)
;   
;   (define (append! x y)
;     (set-cdr! (last-pair x) y)
;     x)
;   
;   Here last-pair is a procedure that returns the last pair in its
;   argument:
;   
;   (define (last-pair x)
;     (if (null? (cdr x))
;         x
;         (last-pair (cdr x))))
;   
;   Consider the interaction
;   
;   (define x (list 'a 'b))
;   (define y (list 'c 'd))
;   (define z (append x y))
;   z
;   (a b c d)
;   (cdr x)
;   <response>
;   (define w (append! x y))
;   w
;   (a b c d)
;   (cdr x)
;   <response>
;   
;   What are the missing <response>s? Draw box-and-pointer diagrams to
;   explain your answer.
;   
;   ------------------------------------------------------------------------
;   [Exercise 3.12]: http://sicp-book.com/book-Z-H-22.html#%_thm_3.12
;   [Section 2.2.1]: http://sicp-book.com/book-Z-H-15.html#%_sec_2.2.1
;   3.3.1 Mutable List Structure - p255
;   ------------------------------------------------------------------------

(-start- "3.12")

(prn
 "At first I thought  both would be ('b 'c 'd) but of course, but of course
it is not that simple.  (However, (cdr w) and (cdr z) are both ('b 'c 'd).)

With append:  (cdr x) -> ('b)
With append!: (cdr x) -> ('b 'c 'd)


Using 'append':
===============

Before:

x-> [.|.] - [.|/]
     |       |
    'a      'b

y-> [.|.] - [.|/]
     |       |
    'c      'd

After:

x-> [.|.] - [.|/]
     |       |
    'a      'b

                      y
                      |  
                      v
z-> [.|.] - [.|.] - [.|.] - [.|/]
     |       |       |       |
    'a      'b      'c      'd

x and y are unchanged by the operations. The result 


Using 'append!':
================

Initially x and y are as above. After append!:

      x               y
      |               |  
      v               v

z-> [.|.] - [.|.] - [.|.] - [.|/]
     |       |       |       |
    'a      'b      'c      'd
")

(--end-- "3.12")

