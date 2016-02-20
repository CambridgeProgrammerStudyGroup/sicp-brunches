#lang racket

; Flotsam and Jetsam from working through Chapter 2.
(require "exercises02.util.rkt")

(ti "Exercise 2.1")

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
         (dd (/ n g))
         (nn (/ d g)))
    (if (> 0 dd)
        (cons (- nn)  (- dd))
        (cons nn dd))))
            

(prn "Orignal make-rat")
(prn (str))
(display-samples make-rat-orig samples)
(prn (str))
(prn "Modified make-rat")
(display-samples make-rat samples)
