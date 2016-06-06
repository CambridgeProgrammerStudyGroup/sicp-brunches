#lang racket
(require "../utils.scm")
(require "../meta.scm")
(require "../image.scm")

; Exercise 2.45: 
; 
; right-split and up-split can be expressed as 
; instances of a general splitting operation. 
; Define a procedure split with the property 
; that evaluating
; 
;     (define right-split (split beside below)) 
; 
;     (define up-split (split below beside))
; 
; produces procedures right-split and up-split 
; with the same behaviors as the ones already defined.

; =============== From the book ===============
;
(define (right-split painter n)
  (if (= n 0)
      painter
      (let ((smaller (right-split painter (- n 1))))
        (beside painter (below smaller smaller)))))
;
; =============================================

; =============== Exercise 2.44 ===============
;
(define (up-split painter n)
	(if (= n 0)
      painter
      (let ((smaller (up-split painter (- n 1))))
        (below painter (beside smaller smaller)))))
;
; =============================================

(define (split proc1 proc2)
	(lambda (painter n)
		(if (= n 0)
	      painter
	      (let ((smaller ((split proc1 proc2) painter (- n 1))))
	        (proc1 painter (proc2 smaller smaller))))))

(let* (
	(image1 (mkimage 600 600))
	(canvas1 (get-canvas image1))
	(image2 (mkimage 600 600))
	(canvas2 (get-canvas image2))
	(image3 (mkimage 600 600))
	(canvas3 (get-canvas image3))
	(image4 (mkimage 600 600))
	(canvas4 (get-canvas image4)))
	(begin 
		((right-split rogers 4) canvas1)
		(save-image image1 "test1.png")

		(((split beside below) rogers 4) canvas2)
		(save-image image2 "test2.png")

		((up-split rogers 4) canvas3)
		(save-image image3 "test3.png")

		(((split below beside) rogers 4) canvas4)
		(save-image image4 "test4.png")
		(prn "")))


