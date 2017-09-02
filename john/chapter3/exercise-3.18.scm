#lang sicp

(#%require "common.scm")

;   Exercise 3.18
;   =============
;   
;   Write a procedure that examines a list and determines whether it
;   contains a cycle, that is, whether a program that tried to find the end
;   of the list by taking successive cdrs would go into an infinite loop. 
;   Exercise [3.13] constructed such lists.
;   
;   ------------------------------------------------------------------------
;   [Exercise 3.18]: http://sicp-book.com/book-Z-H-22.html#%_thm_3.18
;   [Exercise 3.13]: http://sicp-book.com/book-Z-H-22.html#%_thm_3.13
;   3.3.1 Mutable List Structure - p260
;   ------------------------------------------------------------------------

(-start- "3.18")


; helpers for constructing the subject list
(define (last-pair x)
  (if (null? (cdr x))
      x
      (last-pair (cdr x))))

(define (make-list list length)
  (if (= 0 length)
      list
      (make-list (cons 'content list) (- length 1))))

(define (make-cycle x)
  (set-cdr! (last-pair x) x)
  x)


; Construct subjects:
(define straight (make-list '() 1000))

(define looped (make-cycle (make-list '() 1000)))

(define straight->looped (make-list '() 1000))
(set-cdr! (last-pair straight->looped) looped)


; helpers for checking if we've seen a pair before
(define (contains? list item)
  (if (null? list)
      #f
      (if (eq? item (car list))
          #t
          (contains? (cdr list) item))))

(define (get-have-seen)
  (define seen-items '())
  (lambda (item)
    (if (contains? seen-items item)
        (begin
          (prn (str "length of tracked items: " (length seen-items)))
          #t)
        (begin
          (set! seen-items (cons item seen-items))
          #f))))


; Cycle check:
(define (contains-cycle list)
  (define have-seen? (get-have-seen))
  (define (iter item)
    (if (not (pair? item))
        #f
        (or
         (have-seen? item)
         (iter (cdr item)))))
  (iter list))


; Test against subjects:

(prn (str "Straight: " (contains-cycle straight))
     ""
     (str "Looped: " (contains-cycle looped))
     ""
     (str "Straight then Looped:  " (contains-cycle straight->looped))
     "
Cycles are correctly detected but space required is equal to the size of the
subject.")


(--end-- "3.18")

