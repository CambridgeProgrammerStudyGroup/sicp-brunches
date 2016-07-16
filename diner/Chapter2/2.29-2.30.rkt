#lang racket

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

(define (get-length branch)
  (car branch))
(define (get-structure branch)
  (car (cdr branch)))

;b

(define amobile (make-mobile (make-branch 2 5) (make-branch 3 8)))

(define (get-branch-weight branch)
  (if (pair? (get-structure branch))
      (total-weight branch)
      (get-structure branch)))

(define (total-weight mobile)
  (+ (get-branch-weight (left-branch mobile))
     (get-branch-weight (right-branch mobile))))

(total-weight amobile)

;c

(define (get-torque branch)
  (* (get-length branch)
     (get-branch-weight branch)))

(define (branch-balanced? branch)
  (if (list? (get-structure branch))
      (balanced? (get-structure branch))
      true))

(define (balanced? mobile)
  (and (= (get-torque (left-branch mobile))
          (get-torque (right-branch mobile)))
       (branch-balanced? (left-branch mobile))
       (branch-balanced? (right-branch mobile))))

(define bmobile (make-mobile (make-branch 6 7) (make-branch 7 6)))

(balanced? amobile)
(balanced? bmobile)

;d

; If the representation of mobiles would change to the following:
;(define (make-mobile left right) (cons left right))
;(define (make-branch length structure)
;  (cons length structure))

; The only functions that will change are these:
;(define (right-branch mobile)
;  (cdr mobile))
;(define (get-structure branch)
;  (cdr branch))

"Exercise 2.30"

(define (square-tree-long tree)
  (cond ((null? tree) null)
        ((not (pair? tree)) (* tree 2))
        (else (cons (square-tree-long (car tree))
                    (square-tree-long (cdr tree))))))

(square-tree-long (list 1 (list 2 (list 3 4) 5) (list 6 7)))

(define (square-tree tree)
  (map (lambda (sub-tree)
         (if (pair? sub-tree)
             (square-tree sub-tree)
             (* sub-tree 2)))
       tree))

(square-tree (list 1 (list 2 (list 3 4) 5) (list 6 7)))
  
