#lang racket
(require "../utils.scm")
(require "../meta.scm")

(title "Exercise 2.22")

(define nil '())

; Louis Reasoner tries to rewrite the first square-list 
; procedure of exercise 2.21 so that it evolves an iterative process:

(define (square-list-1 items)
  (define (iter things answer)
    (if (null? things)
        answer
        (iter (cdr things) 
              (cons (square (car things))
                    answer))))
  (iter items nil))

; Unfortunately, defining square-list this way produces the answer 
; list in the reverse order of the one desired. Why?

(prn"
The list is returned in reverse order because the square value of
each element of the items is added at the front of the accumulator.

Given Louis Reasoner's code, this could be fixed by either reversing
the list, or by using a recursive process instead.")

; Louis then tries to fix his bug by interchanging the arguments to cons:

(define (square-list-2 items)
  (define (iter things answer)
    (if (null? things)
        answer
        (iter (cdr things)
              (cons answer
                    (square (car things))))))
  (iter items nil))

;This doesn't work either. Explain.

(prn "
Louis Reasoner's second function also fails to work because he's passing
the incorrect argument to cons. He attaches the answer to the new value
and the resulting outcome is:

(cons (cons (cons (cons 1 '()) 4) 9) 16)

instead of

(cons 1 (cons 4 (cons 9 (cons 16 '()))))")

