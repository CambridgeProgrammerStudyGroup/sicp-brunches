#lang racket
(require "../utils.scm")
(require "../meta.scm")
(require "../image.scm")


; https://docs.racket-lang.org/pict/index.html
; https://docs.racket-lang.org/teachpack/2htdpimage.html
; http://www.billthelizard.com/2011/08/sicp-244-245-picture-language.html
; http://planet.racket-lang.org/package-source/soegaard/sicp.plt/2/1/planet-docs/sicp-manual/index.html#(def._((planet._sicp..ss._(soegaard._sicp..plt._2._1))._make-frame))
; https://mitpress.mit.edu/sicp/psets/ps4hnd/readme.html
; https://docs.racket-lang.org/draw/overview.html
; https://docs.racket-lang.org/teachpack/2htdpimage.html#%28def._%28%28lib._2htdp%2Fimage..rkt%29._save-image%29%29
; https://docs.racket-lang.org/draw/bitmap_.html

(title "Exercise 2.44")
(require racket/draw)

; ============ From the book ============
;
(define (flipped-pairs painter)
	(let ((painter2 (beside painter (flip-vert painter))))
		(below painter2 painter2)))
;
(define (right-split painter n)
  (if (= n 0)
      painter
      (let ((smaller (right-split painter (- n 1))))
        (beside painter (below smaller smaller)))))

(define (corner-split painter n) 
	(if (= n 0)
		painter
	(let* (
			(up (up-split painter (- n 1)))
			(right (right-split painter (- n 1)))
			(top-left (beside up up))
			(bottom-right (below right right)) 
			(corner (corner-split painter (- n 1)))
		)
		(beside (below painter top-left)
			(below bottom-right corner)))))
;
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
;
(define (square-limit painter n)
  (let ((quarter (corner-split painter n)))
    (let ((half (beside (flip-horiz quarter) quarter)))
      (below (flip-vert half) half))))
; 
; ========================================

; Exercise 2.44.  Define the procedure up-split used by corner-split. 
; It is similar to right-split, except that it switches the roles of 
; below and beside.

(define (up-split painter n)
	(if (= n 0)
      painter
      (let ((smaller (up-split painter (- n 1))))
        (below painter (beside smaller smaller)))))

(let* (
	(image (mkimage 600 600))
	(canvas (get-canvas image)))
	(begin 
		((right-split rogers 4) canvas)
		(save-image image "test.png")
		(prn "")))
