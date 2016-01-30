#lang racket

(require "../utils.rkt")

(define (count-leaves x)
  (cond ((null? x) 0)
        ((not (pair? x)) 1)
        (else (+ (count-leaves (car x))
                 (count-leaves (cdr x))))))

"Exercise 2.24"

(list 1 (list 2 (list 3 4)))

; The box-and-pointer structure and the interpretation as a tree are pretty straightforward but difficult to draw here, so I'm skipping those

"Exercise 2.25"

;(1 3 (5 7) 9)
(car (cdr (car (cdr (cdr (list 1 3  (list 5 7) 9))))))

;((7))
(car (car (list (list 7))))

;(1 (2 (3 (4 (5 (6 7))))))
(car (cdr (car (cdr (car (cdr (car (cdr (car (cdr (car (cdr (list 1 (list 2 (list 3 (list 4 (list 5 (list 6 7))))))))))))))))))

"Exercise 2.26"

(define x (list 1 2 3))
(define y (list 4 5 6))

(append x y) ; --> '(1 2 3 4 5 6)
(cons x y)   ; --> '((1 2 3) 4 5 6)
(list x y)   ; --> '((1 2 3) (4 5 6))