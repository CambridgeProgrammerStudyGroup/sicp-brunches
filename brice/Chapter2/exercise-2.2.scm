#lang racket
(require "../utils.scm")
(provide (all-defined-out))

; Exercise 2.2: 
;
; Consider the problem of representing line segments 
; in a plane. Each segment is represented as a pair 
; of points: a starting point and an ending point. 
; Define a constructor make-segment and selectors 
; start-segment and end-segment that define the 
; representation of segments in terms of points. 
;
; Furthermore, a point can be represented as a pair 
; of numbers: the x coordinate and the y coordinate. 
;
; Accordingly, specify a constructor make-point and 
; selectors x-point and y-point that define this 
; representation. 
;
; Finally, using your selectors and constructors, 
; define a procedure midpoint-segment that takes a 
; line segment as argument and returns its midpoint 
; (the point whose coordinates are the average of the 
; coordinates of the endpoints). To try your procedures, 
; you’ll need a way to print points:

(define (string-point p)
	(format "(~a,~a)" (x-point p) (y-point p)))

(define (print-point p) 
	(display (string-point p)) 
	(newline))

(define (make-point x y)
	(cons x y))

(define (x-point p)
	(car p))

(define (y-point p)
	(cdr p))

(assert "Points are represented as expected"
	(equal? "(0.3,9.0)" (string-point (make-point 0.3 9.0))))

(define (make-segment p1 p2)
	(cons p1 p2))

(define (start-segment s)
	(car s))

(define (end-segment s)
	(cdr s))

(define (midpoint-segment s)
	(midpoint (start-segment s) (end-segment s)))

(define (midpoint p1 p2)
	(make-point 
		(average (x-point p1) (x-point p2))
		(average (y-point p1) (y-point p2))))

(assert "Midpoint segment works as expected"
	(equal? 
		(make-point 5 5)
		(midpoint-segment 
			(make-segment 
				(make-point 0 0)
				(make-point 10 10)))))



