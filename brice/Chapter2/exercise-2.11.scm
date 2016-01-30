#lang racket
(require "../utils.scm")
(require "../meta.scm")
(require "exercise-2.7.scm")
(require "exercise-2.8.scm")
(require "exercise-2.9.scm")

(provide (all-defined-out))

(define (below-zero? A) (> 0 (upper-bound A) (lower-bound A)))
(define (spans-zero? A) (> (upper-bound A) 0 (lower-bound A)))
(define (above-zero? A) (> (upper-bound A) (lower-bound A) 0))

(define (smart-mul-interval A B)
	(cond
		((and (below-zero? A) (below-zero? B)) 
			(make-interval 
				(* (lower-bound A) (lower-bound B))
				(* (upper-bound A) (upper-bound B))))

		((and (below-zero? A) (spans-zero? B)) 
			(make-interval
				(* (lower-bound A) (upper-bound B))
				(* (lower-bound A) (lower-bound B))))

		((and (below-zero? A) (above-zero? B)) 
			(make-interval 
				(* (lower-bound A) (upper-bound B))
				(* (upper-bound A) (lower-bound B))))

		((and (spans-zero? A) (below-zero? B)) 
			(make-interval 
				(* (upper-bound A) (lower-bound B)) 
				(* (lower-bound A) (lower-bound B))))

		((and (spans-zero? A) (spans-zero? B)) 
			(make-interval
				(min
					(* (lower-bound A) (upper-bound B))
					(* (upper-bound A) (lower-bound B)))
				(max 
					(* (upper-bound A) (upper-bound B))
					(* (lower-bound A) (lower-bound B)))))

		((and (spans-zero? A) (above-zero? B)) 
			(make-interval 
				(* (lower-bound A) (upper-bound B))
				(* (upper-bound A) (upper-bound B))))

		((and (above-zero? A) (below-zero? B)) 
			(make-interval 
				(* (upper-bound A) (lower-bound B))
				(* (lower-bound A) (upper-bound B))))

		((and (above-zero? A) (spans-zero? B)) 
			(make-interval 
				(* (upper-bound A) (lower-bound B))
				(* (upper-bound A) (upper-bound B))))

		((and (above-zero? A) (above-zero? B)) 
			(make-interval 
				(* (lower-bound A) (lower-bound B)) 
				(* (upper-bound A) (upper-bound B))))
		))

(define L (make-interval 1 2))
(define M (make-interval -3 4))
(define N (make-interval -4 3))
(define K (make-interval -2 -1))

(assert "Multiply positive with positive" (equal? (smart-mul-interval L L) (make-interval 1 4)))
(assert "Multiply positive with negative" (equal? (smart-mul-interval L K) (make-interval -4 -1)))
(assert "Multiply negative with negative" (equal? (smart-mul-interval L K) (make-interval -4 -1)))







