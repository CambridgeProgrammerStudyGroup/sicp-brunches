#lang racket

; Section 2.1.1: Example: Arithmetic Operations for Rational Numbers

(require "common.rkt")

;   Exercise 2.1
;   ============
;   
;   Define a better version of make-rat that handles both positive and
;   negative arguments.  Make-rat should normalize the sign so that if the
;   rational number is positive, both the numerator and denominator are
;   positive, and if the rational number is negative, only the numerator is
;   negative.
;   
;   ------------------------------------------------------------------------
;   [Exercise 2.1]:  http://sicp-book.com/book-Z-H-14.html#%_thm_2.1
;   2.1.1 Example: Arithmetic Operations for Rational Numbers - p87
;   ------------------------------------------------------------------------

(-start- "2.1")

(define (gcd a b)
  (if (= b 0) a (gcd b (remainder a b))))

(define (make-rat-orig n d)
  (let ((g (gcd n d)))
    (cons (/ n g) (/ d g))))

(define (numer x) (car x))
(define (denom x) (cdr x))

(define samples (list
  (cons 2 4)
  (cons 3 -9)
  (cons -5 20)
  (cons -7 -35)
  (cons 4 2)
  (cons 9 -3)
  (cons -20 5)
  (cons -35 -7)
  ))

(define (display-samples make-rat samples)
  (if (empty? samples) (prn)
      (let* ((sample (car samples))
            (rat (make-rat (car sample) (cdr sample))))
        (prn (str "Given " sample " got rational " (numer rat)
                  " / " (denom rat)))
        (display-samples make-rat (cdr samples)))))

(define (make-rat n d)
  (let* ((g (gcd n d))
         (n (/ n g))
         (d (/ d g)))
    (if (> 0 d)
        (cons (- n)  (- d))
        (cons n d))))
            

(prn "Orignal make-rat")
(prn (str))
(display-samples make-rat-orig samples)
(prn (str))
(prn "Modified make-rat")
(display-samples make-rat samples)

(--end-- "2.1")

