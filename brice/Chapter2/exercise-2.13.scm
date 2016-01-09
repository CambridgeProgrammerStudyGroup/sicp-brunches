#lang racket
(require "../utils.scm")
(require "../meta.scm")

; Let's find the approximate tolerance of a product of two intervals given the assumptions that the 
; intervals are small.


(require "exercise-2.7.scm")
(require "exercise-2.8.scm")
(require "exercise-2.9.scm")
(require "exercise-2.11.scm")
(require "exercise-2.12.scm")
(title "Exercise 2.13")

; make-interval 
; lower-bound
; upper-bound
; sub-interval
; add-interval
; mul-interval
; div-interval
; smart-mul-interval
; make-center-percent
; percent
; center
; width


(let* (
	(A (make-center-percent 1000 0.1))
	(B (smart-mul-interval A A))
	(C (make-interval (* 999.0 999.0) (* 1001.0 1001.0))))

	(show (percent A))
	(show (percent B))
	
	(assert "Making a center interval works as expected" (equal? (make-interval 999.0 1001.0) A))
	(assert "Squaring a center interval works as expected" (equal? C B))


	(prn "
	Take interval A between A1 and A2, where tolerance of A Ta = 0.5 * (A2 - A1) and center of A is A0
	Take interval B between B1 and B2, where tolerance of B Tb = 0.5 * (B2 - B1) and center of B is B0

	So A*B will be 

	AB = (B0-Tb)*(A0-Ta) -> (B0+Tb)*(A0+Ta)

	So that center of AB Cab is:

	Cab = 0.5 * [ (B0+Tb)*(A0+Ta) - (B0-Tb)*(A0-Ta) ]

	So that Tab is:

	Tab = 0.5 * [ (B0+Tb)(A0+Ta) - (B0-Tb)(A0-Ta) ]


	And the fractional tolerance of AB T% is

	T% = Tab / Cab

	T% = 
		 0.5 * [ (B0+Tb)(A0+Ta) - (B0-Tb)(A0-Ta) ]
		 -----------------------------------------
		 0.5 * [ (B0+Tb)(A0+Ta) - (B0-Tb)(A0-Ta) ]

	Which reduces to:

	T% = 
		 TbA0 + TaB0
		 -----------
		 B0A0 + TaTb

	But TaTb << B0A0 

	Therefore B0A0 + TaTb ≈ B0A0

	So:

	T% = 
		 Tb + Ta
		 --   --
		 B0   A0

	Ie: The fractional tolerance of the product is the sum of the fractional tolerance of the operands

    ")
)


