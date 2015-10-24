#lang racket
(display "\nEXCERCISE 1.19\n")


; Let T be
;
;     a <- a + b
;     b <- a
;
; This will provide us with the fibonnaci sequence if applied repeatedly
;
; Now consider Tpq so that
;
;     a <- bq + aq + ap
;     b <- bp + aq
;
; Applying Tpq twice:
;
;     a1 <- bq + aq + ap
;     b1 <- bp + aq
;
;     a2 <- (bp + aq)q + (bq + aq + ap)q +(bq + aq + ap)p
;     b2 <- (bp + aq)p + (bq + aq + ap)q
;
;     a2 <- b(2qp + qq) + a(2qp + qq) + a(qq + pp)
;     b2 <- b(qq + pp) + a(2qp + qq)
;
; therefore, 
;
;     p' = qq + pp
;     q' = 2qp + qq
;
; Why do we care? 
;
; Because being able to square the fibonnaci transformation allows us to use 
; successive squaring to generate an iterative procedure for fibonnaci numbers 
; with logarithmic time complexity:


(define (half x) (/ x 2))

(define (fib n)
	(fibiter 1 0 0 1 n))

(define (p-prime q p)
	(+ (* q q) (* p p)))

(define (q-prime q p)
	(+ (* 2 q p) (* q q)))

(define (fibiter a b p q count)
	(display (format "~a ~a ~a ~a ~a\n" a b q p count))
	(cond 
		((= count 0)     b)
		((even? count)   (fibiter a b (p-prime q p) (q-prime q p)  (half count)))
		(else 			 (fibiter 
							(+ (* b q) (* a q) (* a p))
							(+ (* b p) (* a q))
							q
							p
							(- count 1)))))

(fib 3)
(fib 10)



