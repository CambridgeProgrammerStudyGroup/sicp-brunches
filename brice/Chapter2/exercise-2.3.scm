#lang racket
(require "../utils.scm")
(require "exercise-2.2.scm")

(title "Exercise 2.3")

; Exercise 2.3:
;
; Implement a representation for rectangles in a plane.
; (Hint: You may want to make use of Exercise 2.2.) In
; terms of your constructors and selectors, create
; procedures that compute the perimeter and the area of
; a given rectangle.
;
; Now implement a different representation for rectangles.
;
; Can you design your system with suitable abstraction
; barriers, so that the same perimeter and area procedures
; will work using either representation?

;rectangle formed of origin thn width and height
(define (mkrectangle origin width height)
	(cons
		origin
		(cons width height)))

(define (width rect)
	(car (cdr rect)))

(define (height rect)
	(cdr (cdr rect)))

(define (perimeter rect)
	(* 2 (+ (width rect) (height rect))))

(define (area rect)
	(* (width rect) (height rect)))


(define testrect (mkrectangle (make-point 10 10) 5 2))

(asserteq "Can recover width for rectangle 1"
	(width testrect) 5)

(asserteq "Can recover height for rectangle 1"
	(height testrect) 2)

(asserteq "Can calculate perimeter for rectangle 1"
	(perimeter testrect) 14)

(asserteq "Can calculate area for rectangle 1"
	(area testrect) 10)


; redefining an alternative representation...

; rectangle formed of two arbitrary points
(set! mkrectangle
	(lambda (p1 p2)
		(cons p1 p2)))

(set! width
	(lambda (rect)
		(let (
				(p1 (car rect))
				(p2 (cdr rect)))
		(abs (- (x-point p2) (x-point p1))))))

(set! height
	(lambda (rect)
		(let (
				(p1 (car rect))
				(p2 (cdr rect)))
		(abs (- (y-point p2) (y-point p1))))))

(set! testrect
	(mkrectangle
		(make-point 1 1)
		(make-point 7 5)
	))

(asserteq "Can recover width for rectangle 2"
	(width testrect) 6)

(asserteq "Can recover height for rectangle 2"
	(height testrect) 4)

(asserteq "Can calculate perimeter for rectangle 2"
	(perimeter testrect) 20)

(asserteq "Can calculate area for rectangle 2"
	(area testrect) 24)
