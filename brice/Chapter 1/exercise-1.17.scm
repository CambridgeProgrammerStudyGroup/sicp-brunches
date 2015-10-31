#lang racket
(display "\nEXCERCISE 1.17\n")

(define (half x) (/ x 2))
(define (double x) (+ x x))


(define (times a b)
  (if (= b 0)
      0
      (+ a (times a (- b 1)))))

(define (times-iter a b)
	(define (internal a acc)
		(cond ((= a 1) acc)
		  	  (else (internal (- a 1) (+ acc b)))))
	(internal a b))

(define (test a b)
	(display (format "~a*~a=~a\n" a b (times-iter a b))))

(test 3 4)
(test 5 6)
(test 4 5)