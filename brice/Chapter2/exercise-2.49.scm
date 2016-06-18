#lang racket
(require "../utils.scm")
(require "../image.scm")
(require "./exercise-2.46.scm")
(require "./exercise-2.47.scm")
(require "./exercise-2.48.scm")


; Exercise 2.49:
; Use segments->painter to define the following
; primitive painters:
;
;  a. The painter that draws the outline of the designated frame.
;  b. The painter that draws an “X” by connecting opposite
;     corners of the frame.
;  c. The painter that draws a diamond shape by connecting the
;     midpoints of the sides of the frame.
;  d. The wave painter.


; ============= From book =============
(define (frame-coord-map frame)
	(lambda (v)
    	(add-vect
     		(origin-frame frame)
     		(add-vect
     			(scale-vect (xcor-vect v) (edge1-frame frame))
               	(scale-vect (ycor-vect v) (edge2-frame frame))))))

(define (segments->painter segment-list)
	(lambda (frame)
		(lambda (dc)
			(for-each
				(lambda (segment)
			        ((draw-line
			        	((frame-coord-map frame) (start-segment segment))
			        	((frame-coord-map frame) (end-segment segment))) dc))
		     segment-list))))
; =====================================

(define (draw-line start end)
	(lambda (dc)
		(send dc draw-line
			(xcor-vect start) (ycor-vect start)
			(xcor-vect end) (ycor-vect end))
			dc))

(define (paint-outline frame)
		((segments->painter
			(list
				(make-segment (make-vect 0 0) (make-vect 0 1))
				(make-segment (make-vect 0 1) (make-vect 1 1))
				(make-segment (make-vect 1 1) (make-vect 1 0))
				(make-segment (make-vect 1 0) (make-vect 0 0)))) frame))

(define (paint-X frame)
	((segments->painter
		(list
			(make-segment (make-vect 0 0) (make-vect 1 1))
			(make-segment (make-vect 1 0) (make-vect 0 1)))) frame))
(define (paint-diamond frame)
		((segments->painter
			(list
				(make-segment (make-vect 0.5 0.0) (make-vect 0.0 0.5))
				(make-segment (make-vect 0.0 0.5) (make-vect 0.5 1.0))
				(make-segment (make-vect 0.5 1.0) (make-vect 1.0 0.5))
				(make-segment (make-vect 1.0 0.5) (make-vect 0.5 0.0))
				)) frame))

(let*
	(
		(image (mkimage 600 600))
		(canvas (get-canvas image))
		(myFrame (frame (make-vect 0 0) (make-vect 100  200) (make-vect 200 100)))
	)
	((paint-outline myFrame) canvas)
	((paint-X myFrame) canvas)
	((paint-diamond myFrame) canvas)
	;(send canvas draw-line 0 0 1 1)
	(save-image image "exercise-2.49.png")
	(prn "")
)







;
