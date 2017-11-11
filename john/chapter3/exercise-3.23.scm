#lang sicp

(#%require "common.scm")

;   Exercise 3.23
;   =============
;   
;   A deque ("double-ended queue") is a sequence in which items can be
;   inserted and deleted at either the front or the rear. Operations on
;   deques are the constructor make-deque, the predicate empty-deque?,
;   selectors front-deque and rear-deque, and mutators front-insert-deque!,
;   rear-insert-deque!, front-delete-deque!, and rear-delete-deque!.  Show
;   how to represent deques using pairs, and give implementations of the
;   operations.⁽²³⁾ All operations should be accomplished in θ(1) steps.
;   
;   ------------------------------------------------------------------------
;   [Exercise 3.23]: http://sicp-book.com/book-Z-H-22.html#%_thm_3.23
;   [Footnote 23]:   http://sicp-book.com/book-Z-H-22.html#footnote_Temp_370
;   3.3.2 Representing Queues - p266
;   ------------------------------------------------------------------------

(-start- "3.23")

; rear-delete-queue

(define (set-cdar! pair value)
  (set-cdr! (car pair) value))

(define (front-ptr queue) (car queue))
(define (rear-ptr queue) (cdr queue))
(define (set-front-ptr! queue item) (set-car! queue item))
(define (set-rear-ptr! queue item) (set-cdr! queue item))

(define (empty-dequeue? queue) (null? (front-ptr queue)))

(define (make-dequeue) (cons '() '())) 

(define (front-dequeue queue)
  (if (empty-dequeue? queue)
      (error "FRONT called with an empty queue" queue)
      (caar (front-ptr queue))))

(define (rear-dequeue queue)
  (if (empty-dequeue? queue)
      (error "REAR called with an empty queue" queue)
      (caar (rear-ptr queue))))

(define (rear-insert-dequeue! queue item)
  (let ((new-pair (cons (cons item '()) '())))
    (cond ((empty-dequeue? queue)
           (set-front-ptr! queue new-pair)
           (set-rear-ptr! queue new-pair)
           queue)
          (else
           (set-cdr! (rear-ptr queue) new-pair)
           (set-cdar! new-pair (rear-ptr queue))
           (set-rear-ptr! queue new-pair)
           queue))))

(define (front-insert-dequeue! queue item)
  (let ((new-pair (cons (cons item '()) '())))
    (cond ((empty-dequeue? queue)
           (set-front-ptr! queue new-pair)
           (set-rear-ptr! queue new-pair)
           queue)
          (else           
           (set-cdr! new-pair (front-ptr queue))
           (set-cdar! (front-ptr queue) new-pair)
           (set-front-ptr! queue new-pair)
           queue))))
  

(define (front-delete-dequeue! queue)
  (cond ((empty-dequeue? queue)
         (error "FRONT DELETE! called with an empty queue" queue))
        (else
         (set-front-ptr! queue (cdr (front-ptr queue)))
         (if (not (empty-dequeue? queue))
             (set-cdar! (front-ptr queue) '()))
         queue)))

(define (rear-delete-dequeue! queue)
  (cond ((empty-dequeue? queue)
         (error "REAR DELETE! called with an empty queue" queue))
        (else
         (cond
           ((pair? (cdar (rear-ptr queue))) 
                (set-rear-ptr! queue (cdar (rear-ptr queue)))
                (set-cdr! (rear-ptr queue) '()))
           (else (front-delete-dequeue! queue)))              
         queue)))

(define (print-queue queue)
  (define (iter list text)
    (if (null? list) (prn (str "Queue: " text))
        (begin
          (if (eq? text "")
              (iter (cdr list) (str text (caar list)))
              (iter (cdr list) (str text ", " (caar list)))))))
  (str (iter (car queue) ""))) 

(define (desc q)
  (print-queue q)
  (if (empty-dequeue? q)      
      (prn "->|<-" "")
      (prn (str (front-dequeue q) " <- front | rear -> " (rear-dequeue q)) "")
      ))
  

(prn "Ben's experience from Ex 3.21:")
(define q2 (make-dequeue))
(desc (rear-insert-dequeue! q2 'a))
(desc (front-insert-dequeue! q2 '1))
(desc (rear-insert-dequeue! q2 'b))
(desc (front-insert-dequeue! q2 '2))
(desc (rear-insert-dequeue! q2 'c))
(desc (front-insert-dequeue! q2 '3))
(desc (front-delete-dequeue! q2))
(desc (rear-delete-dequeue! q2))
(desc (front-delete-dequeue! q2))
(desc (rear-delete-dequeue! q2))
(desc (front-delete-dequeue! q2))
(desc (rear-delete-dequeue! q2))

(--end-- "3.23")

