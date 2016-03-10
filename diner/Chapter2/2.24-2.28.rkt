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

"Exercise 2.27"

(define the-list (list (list 1 2) (list 3 4) (list 5 6)))

; The Reverse function from 2.18 (for reference)
(define (reverse lst)
  (if (null? lst)
      lst
      (append (reverse (cdr lst)) (list (car lst)))))

(define (deep-reverse lst)
  (cond ((null? lst) lst)
        ((list? (car lst)) (append (deep-reverse (cdr lst)) (list (deep-reverse (car lst)))))
        (else
         (append (deep-reverse (cdr lst))
                 (list (car lst))))))

(deep-reverse the-list)

"Exercise 2.28"

(define (fringe items)
  (cond ((null? items) null)
        ((not (pair? items)) (list items))
        (else (append (fringe (car items))
                      (fringe (cdr items))))))

(define some-tree (list (list 1 2) (list 3 4)))

(fringe some-tree)
(fringe (list some-tree some-tree))

"Exercise 2.29"

(define (make-mobile left right)
  (list left right))

(define (make-branch length structure)
  (list length structure))

;a

(define (left-branch mobile)
  (car mobile))

(define (right-branch mobile)
  (car (cdr mobile)))

(define (branch-length branch)
  (car branch))

(define (branch-structure branch)
  (car (cdr branch)))

;b

(define branch1 (make-branch 4 4))
(define branch2 (make-branch 7 8))
(define testmobile (make-mobile branch1 branch2))

(define (branch-weight branch)
  (cond ((pair? (branch-structure branch)) (total-weight (branch-structure branch)))
        (else (branch-structure branch))))

(define (total-weight mobile)
  (+ (branch-weight (left-branch mobile))
     (branch-weight (right-branch mobile))))

(total-weight testmobile)

;c

(define (torque branch)
  (* (branch-length branch) (branch-weight branch)))

(define (branch-balanced? branch)
  (or (pair? (branch-structure branch))
      (balanced? (branch-structure branch))))

(define (balanced? mobile)
  (and (= (torque (left-branch mobile))
          (torque (right-branch mobile)))
       (branch-balanced? (left-branch mobile))
       (branch-balanced? (right-branch mobile))))

;(balanced? testmobile)

;d


