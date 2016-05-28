#lang racket
(require "./utils.scm")
(require racket/draw)
(require math/matrix)
(require math/array)

(provide (all-defined-out))


(define (mkimage x y)
	(let* (
		(target (make-bitmap x y))
		(dc (new bitmap-dc% [bitmap target])))
	(list target dc)))

(define (get-canvas im)
	(second im))

(define (save-image im name)
	(let*-values ([(dc-x dc-y) (send (second im) get-size)])
	(prn (str "Saving image (" dc-x "," dc-y ") to " name))
	(send (first im) save-file name 'png)))



(define (affine-matrix->vec m)
	(vector 
		(array-ref m #(0 0)); xx: a scale from the logical x to the device x
		(array-ref m #(1 0)); xy: a scale from the logical x added to the device y
		(array-ref m #(0 1)); yx: a scale from the logical y added to the device x
		(array-ref m #(1 1)); yy: a scale from the logical y to the device y
		(array-ref m #(0 2)); x0: an additional amount added to the device x
		(array-ref m #(1 2)); y0: an additional amount added to the device y
	))

(define (with-matrix m painter) ;-> painter
	(lambda	(dc) 
		(send dc transform (affine-matrix->vec m))
		(painter dc)
		(send dc transform (affine-matrix->vec (matrix-inverse m)))))


;========= Paiters ===========
;
; painters ar functions that 
;     - accept a drawing context 
;     - draw an image into it
;     - leave the drawing context with the transform in the same state they found it.


(define (beside l-painter r-painter)
	(lambda (dc)
		(let*-values (
				[(dc-x dc-y) (send dc get-size)]
				[(half-width) (/ dc-x 2)]
				[(l-matrix) (matrix [[0.5 0 0] [0 1 0] [0 0 1]])]
				[(r-matrix) (matrix [[0.5 0 half-width] [0 1 0] [0 0 1]])]
			)
			((with-matrix l-matrix l-painter) dc)
			((with-matrix r-matrix r-painter) dc))))

(define (below bot-painter top-painter)
	(lambda (dc)
		(let*-values (
				[(dc-x dc-y) (send dc get-size)]
				[(half-height) (/ dc-y 2)]
				[(top-matrix) (matrix [[1 0 0] [0 0.5 0] [0 0 1]])]
				[(bot-matrix) (matrix [[1 0 0] [0 0.5 half-height] [0 0 1]])]
			)
			((with-matrix top-matrix top-painter) dc)
			((with-matrix bot-matrix bot-painter) dc))))

(define (flip-vert painter)
	(lambda (dc)
		(let*-values (
				[(dc-x dc-y) (send dc get-size)]
				[(flip-m) (matrix [[1 0 0][0 -1 dc-y][0 0 1]])]
			)
			((with-matrix flip-m painter) dc))))

(define (flip-horiz painter)
	(lambda (dc)
		(let*-values (
				[(dc-x dc-y) (send dc get-size)]
				[(flip-m) (matrix [[-1 0 dc-x][0 1 0][0 0 1]])]
			)
			((with-matrix flip-m painter) dc))))

(define (scaled-picture-painter filename)
	(lambda (dc)
		(let*-values (
				[(bm) (read-bitmap filename)]
				[(dc-x dc-y) (send dc get-size)]
				[(bm-w bm-h) (values (send bm get-width) (send bm get-height))]
				[(draw-bm) (lambda (dc) (send dc draw-bitmap bm 0 0))]
				[(scale-x scale-y) (values (/ dc-x bm-w) (/ dc-y bm-h))]
				[(transform) (matrix [[scale-x 0 0][0 scale-y 0][0 0 1]])]
			)
			((with-matrix transform draw-bm) dc))))

(define water (scaled-picture-painter "resources/water.png"))
(define rogers (scaled-picture-painter "resources/WBRogers.jpg"))

; ============ usage example ============
;
; (define (square-painter dc)
; 	(let*-values (
; 			[(dc-x dc-y) (send dc get-size)]
; 			[(ox oy) (values 10 10)]
; 			[(w h) (values (- dc-x 20) (- dc-y 20))]
; 			[(orig-pen) (send dc get-pen)]
; 			[(orig-brush) (send dc get-brush)]
; 			[(new-pen) (make-pen #:color "Black")]
; 			[(new-brush) (make-brush #:color "RoyalBlue")]
; 		)
; 	(send dc set-pen new-pen)
; 	(send dc set-brush new-brush)
; 	(send dc draw-rectangle ox oy w h)
; 	(send dc set-pen orig-pen)
; 	(send dc set-brush orig-brush)))

; (let* (
; 	(image (mkimage 1200 1200))
; 	(canvas (get-canvas image)))
; 	(begin 
; 		((flip-horiz 
; 			(flip-vert 
; 				(below square-painter 
; 					(beside (flip-vert rogers) 
; 						(below square-painter water))))) canvas)
; 		(save-image image "test.png")
; 		(prn "")))

