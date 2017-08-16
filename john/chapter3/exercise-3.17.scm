#lang sicp

(#%require "common.scm")

;   Exercise 3.17
;   =============
;   
;   Devise a correct version of the count-pairs procedure of exercise [3.16]
;   that returns the number of distinct pairs in any structure.  (Hint:
;   Traverse the structure, maintaining an auxiliary data structure that is
;   used to keep track of which pairs have already been counted.)
;   
;   ------------------------------------------------------------------------
;   [Exercise 3.17]: http://sicp-book.com/book-Z-H-22.html#%_thm_3.17
;   [Exercise 3.16]: http://sicp-book.com/book-Z-H-22.html#%_thm_3.16
;   3.3.1 Mutable List Structure - p259
;   ------------------------------------------------------------------------

(-start- "3.17")

;; count-pairs from previous question
(define (original-count-pairs x)
  (if (not (pair? x))
      0
      (+ (original-count-pairs (car x))
         (original-count-pairs (cdr x))
         1)))

;helper
(define (contains? list item)
  (if (null? list)
      #f
      (if (eq? item (car list))
          #t
          (contains? (cdr list) item))))

;helper
(define (get-have-seen)
  (define seen-items '())
  (lambda (item)
    (if (contains? seen-items item)
        #t
        (begin
          (set! seen-items (cons item seen-items))
          #f))))
                       
; our new count-pairs
(define (count-pairs item)
  (define have-seen? (get-have-seen))
  (define (iter item)
    (if (or (not (pair? item))
            (have-seen? item))
        0
        (+ 1 (iter (car item)) (iter (cdr item)))))
  (iter item))
        
; test data
(define simple
  (cons 'a
        (cons 'a
              (cons 'a '()))))

;test data
(define four
  (let ((last (cons 'a '())))
    (cons 'a
          (cons last
                last))))
;test data
(define seven
  (let ((last (cons 'a '())))
    (let ((middle (cons last last)))
      (cons middle middle))))

;test data
(define infinite
  (let ((last (cons 'a '())))
    (let ((first (cons 'a
                       (cons 'a
                             last))))
      (set-cdr! last first)
      first)))
      
(prn "Using 'original' count-pairs from previous question:"
 (str "simple list:  " (original-count-pairs simple))
 (str "'four' list:  " (original-count-pairs four))
 (str "'seven' list: " (original-count-pairs seven))
 (str "looped list:  " "<does not finish>"))

(prn ""
 "Using new count-pairs:"
 (str "simple list:  " (count-pairs simple))
 (str "'four' list:  " (count-pairs four))
 (str "'seven' list: " (count-pairs seven))
 (str "looped list:  " (count-pairs infinite)))

(--end-- "3.17")

