#lang racket
(require "../utils.scm")
(require "./exercise-2.46.scm")

(provide (all-defined-out))

; Exercise 2.48:
; A directed line segment in the plane can be
; represented as a pair of vectors—the vector
; running from the origin to the start-point
; of the segment, and the vector running from
; the origin to the end-point of the segment.
; Use your vector representation from
; Exercise 2.46 to de- fine a representation
; for segments with a constructor make-segment
; and selectors start-segment and end-segment.


(define (make-segment start end)
	(list start end))

(define (start-segment segment)
	(first segment))

(define (end-segment segment)
	(second segment))


(let*
	(
		(A (make-vect 1 1))
		(B (make-vect 5 5))
		(seg (make-segment A B))
	)
	(assertequal? "We can get the start point of a segment"
		(start-segment seg) A)
	(assertequal? "We can get the end point of a segment"
		(end-segment seg) B)
	(assertequal? "We can compare segments"
		seg (make-segment (make-vect 1 1) (make-vect 5 5)))
)
