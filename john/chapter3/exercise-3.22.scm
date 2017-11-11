#lang sicp

(#%require "common.scm")

;   Exercise 3.22
;   =============
;   
;   Instead of representing a queue as a pair of pointers, we can build a
;   queue as a procedure with local state.  The local state will consist of
;   pointers to the beginning and the end of an ordinary list.  Thus, the
;   make-queue procedure will have the form
;   
;   (define (make-queue)
;     (let ((front-ptr ...)
;           (rear-ptr ...))
;       <definitions of internal procedures>
;       (define (dispatch m) ...)
;       dispatch))
;   
;   Complete the definition of make-queue and provide implementations of the
;   queue operations using this representation.
;   
;   ------------------------------------------------------------------------
;   [Exercise 3.22]: http://sicp-book.com/book-Z-H-22.html#%_thm_3.22
;   3.3.2 Representing Queues - p266
;   ------------------------------------------------------------------------

(-start- "3.22")

(define (make-queue)
  (let ((front-ptr nil)
        (rear-ptr nil))
    (define (empty-queue?) (null? front-ptr))      
    (define (insert new-value)
      (cond
        ((empty-queue?)
         (set! front-ptr (list new-value))
         (set! rear-ptr front-ptr))
        (else
         (set-cdr! front-ptr (cons new-value '())))))          
    (define (front)
      (cond
        ((empty-queue?) error "FRONT called on an empty queue")
        (else (car front-ptr))))
    (define (delete)
      (cond
        ((empty-queue?)
         error "DELETE called on an empty queue")
        (else
         (set! front-ptr (cdr front-ptr)))))          
    (define (dispatch m)
      (cond
        ((eq? m 'insert) insert)
        ((eq? m 'front) front)
        ((eq? m 'delete) delete)
        ))

    dispatch))

(define (front-queue queue)
  ((queue 'front)))

(define (insert-queue! queue item)
  ((queue 'insert) item))

(define (delete-queue! queue)
  ((queue 'delete)))

;;;;;;;;;

(define queue (make-queue))
(front-queue queue) 
(delete-queue! queue) 
(insert-queue! queue "first")
(front-queue queue)
(insert-queue! queue "second")
(front-queue queue)
(delete-queue! queue)
(insert-queue! queue "third")
(front-queue queue)
(delete-queue! queue) 
(front-queue queue)
(delete-queue! queue) 
(front-queue queue)
(insert-queue! queue "fourth")
(front-queue queue)
(delete-queue! queue) 
(front-queue queue)

(--end-- "3.22")

