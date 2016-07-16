#lang racket
(require "../utils.scm")
(require "../image.scm")
(require "./exercise-2.46.scm")
(require "./exercise-2.47.scm")
(require "./exercise-2.48.scm")
(require "./exercise-2.49.scm")

(provide (all-defined-out))

; Exercise 2.50: Define the transformation flip-horiz, which flips painters horizontally,
; and transformations that rotate painters counterclockwise by 180 degrees and 270 degrees.

; ================ From Book ================
(define (transform-painter painter origin corner1 corner2)
  (lambda (tframe)
    (let ((m (frame-coord-map tframe)))
      (let ((new-origin (m origin)))
        (painter
         (frame new-origin
                     (sub-vect (m corner1) new-origin)
                     (sub-vect (m corner2) new-origin)))))))
; ===========================================

(define (flip-horiz-f painter)
  (transform-painter painter (make-vect 1 0) (make-vect 0 0) (make-vect 1 1)))

(define (rotate-counterclockwise painter)
  (transform-painter painter (make-vect 0 1) (make-vect 0 0) (make-vect 1 1)))

(define (rotate-clockwise painter)
  (transform-painter painter (make-vect 1 0) (make-vect 1 1) (make-vect 0 0)))

(define (paint-arrows frame)
  ((segments->painter
    (list
      (make-segment (make-vect 0.0 0.0) (make-vect 1.0 0.0))
      (make-segment (make-vect 0.0 0.0) (make-vect 0.0 1.0))
      (make-segment (make-vect 1.0 0.0) (make-vect 0.9 0.05))
      (make-segment (make-vect 0.9 0.05) (make-vect 0.9 0.0))
      (make-segment (make-vect 0.0 1.0) (make-vect 0.05 0.9))
      (make-segment (make-vect 0.05 0.9) (make-vect 0.0 0.9)))) frame))

(module+ main
  (let*
		(
			(image (mkimage 600 600))
			(canvas (get-canvas image))
			(baseFrame (frame (make-vect 0 0) (make-vect 600  0) (make-vect 0 600)))
      (innerFrame (frame (make-vect 50 50) (make-vect 500 0) (make-vect 0 500)))
		)
    (send canvas set-pen "black" 3 'solid)
		((paint-arrows innerFrame) canvas)
    (send canvas set-pen "green" 3 'solid)
    (((flip-horiz-f paint-arrows) innerFrame) canvas)
    (send canvas set-pen "red" 1 'solid)
    (((rotate-clockwise paint-arrows) innerFrame) canvas)
    (send canvas set-pen "blue" 1 'solid)
    (((rotate-counterclockwise paint-arrows) innerFrame) canvas)
		(save-image image "exercise-2.50.png")
		(prn "")
	))
