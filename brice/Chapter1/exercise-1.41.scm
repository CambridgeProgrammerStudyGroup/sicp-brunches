#lang racket
(require "../utils.scm")
(require "../meta.scm")

; Exercise 1.41: 
;
; Define a procedure double that takes a procedure
; of one argument as argument and returns a 
; procedure that applies the original procedure twice. 
; For example, if inc is a procedure that adds 1 to its 
; argument, then (double inc) should be a procedure 
; that adds 2. What value is returned by
;
;      (((double (double double)) inc) 5)


(define (double g)
	(lambda (x) (g (g x))))

((double inc) 8) ;-> 10

(((double (double double)) inc) 5) ;-> Expecting 5+16=21

; That's because double applies its argument twice, so by doubling double, 
; the first application will apply g twice, while the second application will 
; apply g twice twice (4 times) for one application of double.
; Hence, applying double again will apply the g twice twice twice twice (16 times)

; Thus
(((double (double (double double))) inc) 0) ;-> 256



