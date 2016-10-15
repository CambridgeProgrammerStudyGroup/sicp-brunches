#lang racket
(require "utils.scm")
(provide (all-defined-out))



;;;-----------
;;;from section 3.3.3 for section 2.4.3
;;; to support operation/type table for data-directed dispatch

(define (assoc key records)
  (cond ((null? records) false)
        ((equal? key (caar records)) (car records))
        (else (assoc key (cdr records)))))

(define (make-table)
  (let [[local-table (list '(*table*))]]
    (define (lookup key-1 key-2)
      (define (inner in-table)
        (cond
          [(empty? in-table) #f]
          [(equal? (first (first in-table)) (list key-1 key-2))
            (second (first in-table))]
          [else (inner (rest in-table))]
          ))
      (inner local-table))
    (define (insert! key-1 key-2 value)
      (if (lookup key-1 key-2) (error "Cannot overwrite existing key")
          (set! local-table (cons (list (list key-1 key-2) value) local-table))))
    (define (show)
      (prn local-table))
    (define (dispatch m)
      (cond ((eq? m 'lookup-proc) lookup)
            ((eq? m 'insert-proc!) insert!)
            ((eq? m 'show) show)
            (else (error "Unknown operation -- TABLE" m))))
    dispatch))

(define operation-table (make-table))
(define get (operation-table 'lookup-proc))
(define put (operation-table 'insert-proc!))

(module* main #f
  (assert "Nothing in an empty table" (not (get 'a 'b)))
  (void (put 'a 'b 123))
  (assertequal? "We can lookup what we inserted" 123 (get 'a 'b))
)
