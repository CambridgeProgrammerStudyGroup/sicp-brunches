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

(-start- "3.19")


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

; Construct subject lists:
(define straight (make-list '() 1000))

(define looped (make-cycle (make-list '() 1000)))

(define straight->looped (make-list '() 1000))
(set-cdr! (last-pair straight->looped) looped)


; Cycle check:
(define step-count 0)

(define (contains-cycle list)
  (set! step-count 0)
  (define (iter item remembered-item count initial-count)
    (set! step-count (+ 1 step-count))
    (if (not (pair? item))
        #f
        (or
         (eq? remembered-item item)
         (if (= count 0)
             (iter (cdr item) item (* 2 initial-count) (* 2 initial-count))
             (iter (cdr item) remembered-item (- count 1) initial-count)))))
  (iter list '() 0 8))


; Test against subjects:

(prn
 (str "Check we get the right result for the empty list (as we're using the empty
list as the 'remembered item':
    Empty list: " (contains-cycle '()) "  (" step-count " steps)")
 ""
 (str "    Straight: " (contains-cycle straight) "  (" step-count " steps)")
 ""
 (str "    Looped: " (contains-cycle looped) "  (" step-count " steps)")
 ""
 (str "    Straight then Looped:  " (contains-cycle straight->looped) "  (" step-count " steps)")
 "
This uses constant space but will usually require more steps.  E.g. the
simple loop of 1,000 items took 2,015 steps to complete.
")

(--end-- "3.19")

