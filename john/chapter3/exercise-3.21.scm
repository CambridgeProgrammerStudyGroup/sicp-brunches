#lang sicp

(#%require "common.scm")

;   Exercise 3.21
;   =============
;   
;   Ben Bitdiddle decides to test the queue implementation described above. 
;   He types in the procedures to the Lisp interpreter and proceeds to try
;   them out:
;   
;   (define q1 (make-queue))
;   (insert-queue! q1 'a)
;   ((a) a)
;   (insert-queue! q1 'b)
;   ((a b) b)
;   (delete-queue! q1)
;   ((b) b)
;   (delete-queue! q1)
;   (() b)
;   
;   "It's all wrong!" he complains.  "The interpreter's response shows that
;   the last item is inserted into the queue twice.  And when I delete both
;   items, the second b is still there, so the queue isn't empty, even
;   though it's supposed to be." Eva Lu Ator suggests that Ben has
;   misunderstood what is happening.  "It's not that the items are going
;   into the queue twice," she explains.  "It's just that the standard Lisp
;   printer doesn't know how to make sense of the queue representation.  If
;   you want to see the queue printed correctly, you'll have to define your
;   own print procedure for queues." Explain what Eva Lu is talking about. 
;   In particular, show why Ben's examples produce the printed results that
;   they do.  Define a procedure print-queue that takes a queue as input and
;   prints the sequence of items in the queue.
;   
;   ------------------------------------------------------------------------
;   [Exercise 3.21]: http://sicp-book.com/book-Z-H-22.html#%_thm_3.21
;   3.3.2 Representing Queues - p265
;   ------------------------------------------------------------------------

(-start- "3.21")

(define (front-ptr queue) (car queue))
(define (rear-ptr queue) (cdr queue))
(define (set-front-ptr! queue item) (set-car! queue item))
(define (set-rear-ptr! queue item) (set-cdr! queue item))

(define (empty-queue? queue) (null? (front-ptr queue)))

(define (make-queue) (cons '() '()))

(define (front-queue queue)
  (if (empty-queue? queue)
      (error "FRONT called with an empty queue" queue)
      (car (front-ptr queue))))

(define (insert-queue! queue item)
  (let ((new-pair (cons item '())))
    (cond ((empty-queue? queue)
           (set-front-ptr! queue new-pair)
           (set-rear-ptr! queue new-pair)
           queue)
          (else
           (set-cdr! (rear-ptr queue) new-pair)
           (set-rear-ptr! queue new-pair)
           queue))))

(define (delete-queue! queue)
  (cond ((empty-queue? queue)
         (error "DELETE! called with an empty queue" queue))
        (else
         (set-front-ptr! queue (cdr (front-ptr queue)))
         queue)))


(prn "Recreating Ben's experience:")
(define q1 (make-queue))
(insert-queue! q1 'a)
(insert-queue! q1 'b)
(delete-queue! q1)
(delete-queue! q1)

(prn "

Our queue is a pair.  The car points to a list that can be thought of as the
contents of the queue.  The cdr can be thought of as a convenience or
optimisation to quickly get to the end of the list for adding new items.

If Ben were to simply look at the car and ignore the cdr then he would see
what he expects to see - the contents of the queue.

")


(define (simple-print-queue queue) (car queue))

(prn "Ben's experience with a simple print:")
(define q2 (make-queue))
(simple-print-queue (insert-queue! q2 'a))
(simple-print-queue (insert-queue! q2 'b))
(simple-print-queue (delete-queue! q2))
(simple-print-queue (delete-queue! q2))


(define (pretty-print-queue queue)
  (define (iter list text)
    (if (null? list) text
        (begin
          (if (eq? text "")
              (iter (cdr list) (str text (car list)))
              (iter (cdr list) (str text ", " (car list)))))))
  (iter (car queue) ""))
        
(prn "

Ben's experience with a pretty print (with an extra item):")
(define q3 (make-queue))
(pretty-print-queue (insert-queue! q3 'a))
(pretty-print-queue (insert-queue! q3 'b))
(pretty-print-queue (insert-queue! q3 'c))
(pretty-print-queue (delete-queue! q3))
(pretty-print-queue (delete-queue! q3))
(pretty-print-queue (delete-queue! q3))

(--end-- "3.21")

