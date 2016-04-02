#lang racket
(require "../utils.scm")
(require "../meta.scm")


; https://docs.racket-lang.org/pict/index.html
; https://docs.racket-lang.org/teachpack/2htdpimage.html
; http://www.billthelizard.com/2011/08/sicp-244-245-picture-language.html
; http://planet.racket-lang.org/package-source/soegaard/sicp.plt/2/1/planet-docs/sicp-manual/index.html#(def._((planet._sicp..ss._(soegaard._sicp..plt._2._1))._make-frame))
; https://mitpress.mit.edu/sicp/psets/ps4hnd/readme.html
; https://docs.racket-lang.org/draw/overview.html
; https://docs.racket-lang.org/teachpack/2htdpimage.html#%28def._%28%28lib._2htdp%2Fimage..rkt%29._save-image%29%29
; https://docs.racket-lang.org/draw/bitmap_.html
; 

; (require (planet "sicp.ss" ("soegaard" "sicp.plt" 2 1)))
; (require 2htdp/image)
(require racket/draw)
(require math/matrix)
(require math/array)

(title "Exercise 2.44")

(define target (make-bitmap 300 300)) ; A 30x30 bitmap

(define dc (new bitmap-dc% [bitmap target]))

(define (make-matrix-stack) `())

; (define (push-matrix drawing-c transform-c m)
; 	(set! transform-c (cons m transform-c))
; 	(send dc transform (affine-matrix-to-vec m)))

; (define (pop-matrix drawing-c transform-c)
; 	(send dc transform (matrix-inverse (car transform-c)))
; 	(set! transform-c (cdr transform-c)))

(define-syntax push-matrix
	(syntax-rules ()
		[(push-matrix drawing-c transform-c m) 
			(begin 
				(set! transform-c (cons m transform-c))
				(send dc transform (affine-matrix-to-vec m)))]))

(define-syntax pop-matrix
	(syntax-rules ()
		[(pop-matrix drawing-c transform-c) 
			(begin 
				(send dc transform (affine-matrix-to-vec (matrix-inverse (car transform-c))))
			 	(set! transform-c (cdr transform-c)))]))

(define test-matrix (matrix [[1 3 0] 
							 [1 1 0] 
							 [0 0 1]]))

(define (affine-matrix-to-vec m)
	(vector 
		(array-ref m #(0 0)); xx: a scale from the logical x to the device x
		(array-ref m #(1 0)); xy: a scale from the logical x added to the device y
		(array-ref m #(0 1)); yx: a scale from the logical y added to the device x
		(array-ref m #(1 1)); yy: a scale from the logical y to the device y
		(array-ref m #(0 2)); x0: an additional amount added to the device x
		(array-ref m #(1 2)); y0: an additional amount added to the device y
	))

(define stack (make-matrix-stack))

(send dc draw-rectangle
      0 10   ; Top-left at (0, 10), 10 pixels down from top-left
      30 10) ; 30 pixels wide and 10 pixels high

(push-matrix dc stack test-matrix)

(send dc draw-rectangle
      0 10   ; Top-left at (0, 10), 10 pixels down from top-left
      30 10) ; 30 pixels wide and 10 pixels high


(pop-matrix dc stack)

(send dc draw-rectangle
      0 20   ; Top-left at (0, 10), 10 pixels down from top-left
      30 10) ; 30 pixels wide and 10 pixels high




; (define blue-brush (new brush% [color "blue"]))
; ; (send blue-brush set-stipple (read-bitmap "water.png"))
; (send dc set-brush blue-brush)
; (send dc draw-ellipse 25 25 100 100)

(send target save-file "foo.png" 'png)


; (define (right-split painter n)
;   (if (= n 0)
;       painter
;       (let ((smaller (right-split painter (- n 1))))
;         (beside painter (below smaller smaller)))))



; (define (corner-split painter n)
;   (if (= n 0)
;       painter
;       (let ((up (up-split painter (- n 1)))
;             (right (right-split painter (- n 1))))
;         (let ((top-left (beside up up))
;               (bottom-right (below right right))
;               (corner (corner-split painter (- n 1))))
;           (beside (below painter top-left)
;                   (below bottom-right corner))))))

; (define (square-limit painter n)
;   (let ((quarter (corner-split painter n)))
;     (let ((half (beside (flip-horiz quarter) quarter)))
;       (below (flip-vert half) half))))

; ; Exercise 2.44.  Define the procedure up-split used by corner-split. 
; ; It is similar to right-split, except that it switches the roles of 
; ; below and beside.

; (define (up-split painter n)
; 	(if (= n 0)
;       painter
;       (let ((smaller (up-split painter (- n 1))))
;         (below painter (beside smaller smaller)))))
