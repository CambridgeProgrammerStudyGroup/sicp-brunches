#lang sicp

(#%require "common.scm")

;   Exercise 3.19
;   =============
;   
;   Redo exercise [3.18] using an algorithm that takes only a constant
;   amount of space.  (This requires a very clever idea.)
;   
;   ------------------------------------------------------------------------
;   [Exercise 3.19]: http://sicp-book.com/book-Z-H-22.html#%_thm_3.19
;   [Exercise 3.18]: http://sicp-book.com/book-Z-H-22.html#%_thm_3.18
;   3.3.1 Mutable List Structure - p260
;   ------------------------------------------------------------------------

(-start- "3.19-extra")

; Just for fun seing if we can  find the first item in the loop (with
; constant memory).

; helpers for constructing the subject list
(define (last-pair x)
  (if (null? (cdr x))
      x
      (last-pair (cdr x))))

(define (make-list list length label)
  (if (= 0 length)
      list
      (make-list (cons (str label (- length 1)) list) (- length 1) label)))

(define (make-cycle x)
  (set-cdr! (last-pair x) x)
  x)

; Construct subject lists:

(define looped (make-cycle (make-list '() 1000 "looped-")))

(define straight->looped (make-list '() 1000 "straight-"))
(set-cdr! (last-pair straight->looped) looped)


; Cycle check:

(define (get-repeated-item list)
  (define (iter item remembered-item count initial-count)
    (if (not (pair? item))
        nil
        (if (eq? remembered-item item)
            item
            (if (= count 0)
                (iter (cdr item) item (* 2 initial-count) (* 2 initial-count))
                (iter (cdr item) remembered-item (- count 1) initial-count)))))           
  (iter list '() 0 8))

(define (get-loop-size item)
  (define (iter item2 size)
    (if (eq? item item2)
        size
        (iter (cdr item2) (+ size 1))))
  (iter (cdr item) 1))

; could use list-tail instead
(define (get-nth item n)
  (if (eq? n 0)
      item 
      (get-nth (cdr item) (- n 1))))

  
(define (first-repeated-given-size item size)
  (define (iter this that)
    (if (eq? this that)
        this
        (iter (cdr this) (cdr that))))
  (iter item (get-nth item size)))


(define (first-repeated list)
  (let ((size (get-loop-size (get-repeated-item list))))
    (first-repeated-given-size list size)))


; Test against subjects:

(prn
 (str
  "    Looped...              " 
  "  size:" (get-loop-size (get-repeated-item looped))
  "  first:" (car looped)
  "  first-repeated:" (car (first-repeated looped))
  )
 ""
 (str
  "    Straight-then-Looped..." 
  "  size:" (get-loop-size (get-repeated-item straight->looped))
  "  first:" (car straight->looped)
  "  first-repeated:" (car (first-repeated straight->looped))
  ))

(--end-- "3.19")

