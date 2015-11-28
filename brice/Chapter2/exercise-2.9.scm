#lang racket
(require "../utils.scm")
(require "../meta.scm")
(require "exercise-2.7.scm")
(require "exercise-2.8.scm")


(define (add-interval x y)
	(make-interval 
		(+ (lower-bound x) (lower-bound y))
		(+ (upper-bound x) (upper-bound y))))

(define (mul-interval x y)
	(let (
		(p1 (* (lower-bound x) (lower-bound y)))
		(p2 (* (upper-bound x) (lower-bound y)))
		(p3 (* (lower-bound x) (upper-bound y)))
		(p4 (* (upper-bound x) (upper-bound y))))
		(make-interval (min p1 p2 p3 p4) (max p1 p2 p3 p4))))




(define (width a) (/ (- (upper-bound a) (lower-bound a)) 2))


(define A (make-interval 3 5))
(define B (make-interval 5 15))

(asserteq "Width of result of addition is a function of the width of the two numbers"
	(width (add-interval A B))
	(+ (width A) (width B)))

(display (format "We expect that the width of the product of intervals to NOT be a \ndirect function of the width of the intervals\n\t(width A*B)=~a\n\t(width A)=~a\n\t(width B)=~a\n" (width (mul-interval A B)) (width A) (width B)))