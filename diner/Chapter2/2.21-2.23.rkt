#lang racket

(require "../utils.rkt")

; Map

(define (scale-list items factor)
  (if (null? items)
      null
      (cons (* (car items) factor)
            (scale-list (cdr items) factor))))

;(scale-list (list 1 2 3 4 5) 10)

; This general idea can be abstracted and captured as a common pattern expressed as a higher-order procedure -> map

;(define (map proc items)
;  (if (null? items)
;      null
;      (cons (proc (car items))
;            (map proc (cdr items)))))

; e.g.
;(map abs (list -10 2.5 -11.6 17))
;(map (lambda (x) (* x x)) (list 1 2 3 4))

; Defining scale-list in terms of map

(define (scale-list-map items factor)
  (map (lambda (x) (* x factor))
       items))

;(scale-list-map (list 1 2 3) 4)

"Exercise 2.21"

(define (square-list items)
  (if (null? items)
      null
      (cons (* (car items) (car items))
               (square-list (cdr items)))))

(square-list (list 2 3 5))

(define (square-list2 items)
  (map (lambda (x) (* x x))
       items))

(square-list2 (list 2 3 5))

"Exercise 2.22"

(define (square-list-iter items)
  (define (iter things answer)
    (if (null? things)
        answer
        (iter (cdr things)
              (append answer
                    (list (square (car things)))))))
  (iter items null))

; The problem with the first implementation was adding elements to the front of the answer list, so the list was reversed
; The problem with the second one was that cons everytime was putting together a list from the previous step with an integer, so it was forming new lists everytime
; A correct solution can be made by just using 'append' instead of 'cons'

(square-list-iter (list 2 3 4))

"Exercise 2.23"

(define (for-each proc items)
  (cond ((null? items) null)
      (else (proc (car items))
            (for-each proc (cdr items)))))

(for-each (lambda (x) (newline) (display x))
          (list 57 321 88))
