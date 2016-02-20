#lang racket

;Lists

(define one-through-four (list 1 2 3 4))
;(car one-through-four)
;(cdr one-through-four)

(define (list-ref items n)
  (if (= n 0)
      (car items)
      (list-ref (cdr items) (- n 1))))

(define squares (list 1 4 9 16 25))
;(list-ref squares 3)

(define (append list1 list2)
  (if (null? list1)
      list2
      (cons (car list1) (append (cdr list1) list2))))

;(append squares squares)

"Exercise 2.17"

(define (last-element lst)
  (if (= (length lst) 1)
      (make-list 1 (car lst))
      (last-pair (cdr lst))))

(last-element squares)

"Exercise 2.18"

(define (reverse2 lst acc)
  (if (null? lst)
      acc
      (reverse2 (remove-last lst) (append acc (last-element lst)))))

(define (reverse lst)
  (if (null? lst)
      lst
      (append (reverse (cdr lst)) (list (car lst)))))
      
(define (remove-last lst)
  (if (null? (cdr lst))
      '()
      (cons (car lst) (remove-last (cdr lst)))))

(reverse squares)

"Exercise 2.19"

(define us-coins (list 50 25 10 5 1))
(define uk-coins (list 100 50 20 10 5 2 1 0.5))

(define (no-more? coin-values)
  (if (null? coin-values) true false))

(define (first-denomination coin-values)
  (car coin-values))

(define (except-first-denomination coin-values)
  (cdr coin-values))
  

(define (cc amount coin-values)
  (cond ((= amount 0) 1)
        ((or (< amount 0) (no-more? coin-values)) 0)
        (else
         (+ (cc amount
                (except-first-denomination coin-values))
            (cc (- amount
                   (first-denomination coin-values))
                coin-values)))))

(cc 100 us-coins)
; The order of the list coin-values doesn't affect the output of cc, because the procedure just recursively goes through each value of coin-values

"Exercise 2.20"

(define (same-parity a . lst)
  (define (iter items answer)
    (if (null? items)
        answer
        (iter (cdr items)
              (if (= (remainder (car items) 2)
                     (remainder a 2))
                  (append answer (list (car items)))
                  answer))))
  (iter lst (list a)))

(same-parity 1 2 3 4 5)
(same-parity 2 3 4 5 6)
      

                 