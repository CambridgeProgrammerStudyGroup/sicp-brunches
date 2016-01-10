#lang racket

; Flotsam and Jetsam from working through Chapter 2.
(require "exercises02.util.rkt")

;#########################################################################
;#########################################################################
(ti "Exercise 2.17")

(define (last-pair lst)
  (let ((tail (cdr lst)))
    (if (null? tail)
        lst
        (last-pair tail))))

(define list-2.17 (list 23 72 149 34))

(prn
 (str "last-pair of " list-2.17 ": " (last-pair list-2.17)))

;#########################################################################
;#########################################################################
(ti "Exercise 2.18")

(define list-2.18 (list 1 4 9 16 25))

(define (reverse-rec lst)
  (if (null? lst) lst
      (append (reverse-rec (cdr lst)) (list (car lst)))))

(prn
 (str "reverse-rec of " list-2.18 ": " 
      (reverse-rec list-2.18)))

(define (reverse-itr lst)
  (define (iter lst reversed)
    (if (null? lst) reversed
        (iter (cdr lst) (cons (car lst) reversed))))
  (iter lst null))

(prn
 (str "reverse-itr of " list-2.18 ": " 
      (reverse-itr list-2.18)))



;#########################################################################
;#########################################################################
(ex "2.19")

; this is a trivial function, but since we
; are creating selector functions to abstract
; the data representation it seems only right
; to the same for creating the representation.
(define (make-denominations d-list) d-list)

(define uk-coins (make-denominations (list 200 100 50 20 10 5 2 1)))
(define us-coins (make-denominations (list 50 25 10 5 1)))

(define (first-denomination ds)
  (car ds))

(define (except-first-denomination ds)
  (cdr ds))

(define (no-more? ds)
  (null? ds))

(define (cc amount ds)
  (cond
    ((= amount 0) 1)
    ((or (< amount 0)(no-more? ds)) 0)
    (else
     (+ (cc (- amount (first-denomination ds)) ds)
        (cc amount (except-first-denomination ds))))))

(prn
 (str "UK coin count for £2.10: "
      (cc 210 uk-coins))
 (str "US coin count for $1.00: "
      (cc 100 us-coins))
 (str)
 (str "My guess... we get the same result.")
 (str "Because I don't think the algorithm makes any assumption")
 (str "about the size of the coins. Performance may be worse")
 (str "as 'backing-off' will require more steps, e.g., need to")
 (str "back-off by a penny 5 times before using 5p or nickle.")
 (str)
 (str "Let's see...")
 (str))

(define uk-coins-rev (reverse uk-coins))
(prn 
 (str "Reversed UK denominations: " uk-coins-rev)
 (str "UK coin count for £2.10 (rev):"
      (cc 210 uk-coins-rev)))

(prn (str) "Phew. (And appears noticably slower.)")

;#########################################################################
;#########################################################################

(ex "2.20")

(define list-2.20-1 (list 1 2 3 4 5 6 7))
(define list-2.20-2 (list 2 3 4 5 6 7))

(define (filter predicate list)
  (define (filter-itr list filtered)
    (if (null? list) filtered        
        (filter-itr (cdr list)
                    (if (predicate (car list))
                        (cons (car list) filtered)
                        filtered))))
  (reverse (filter-itr list null)))

            

(define (same-parity first . rest)
  (let ((first-mod (modulo first 2)))
    (cons first (filter
                 (lambda (r) (= first-mod (modulo r 2)))
                 rest))))

(same-parity 1 2 3 4 5 6 7)