#lang racket
(require "../utils.scm")


; Exercise 1.36:
;
; Modify fixed-point so that it prints the sequence of 
; approximations it generates, using the newline and 
; display primitives shown in Exercise 1.22. Then find a 
; solution to xˣ = 1000 by finding a fixed point of 
;
; x  → log(1000)/ log(x)
;
; (Use Scheme’s primitive log procedure, which computes 
; natural logarithms.) Compare the number of steps this 
; takes with and without average damping. 
;
; (Note that you cannot start fixed-point with a guess 
; of 1, as this would cause division by log(1) = 0.)

(define tolerance 0.00001)

(define tick 0)

(define (fixed-point f first-guess)



	(define (close-enough? v1 v2) 
		(< (abs (- v1 v2)) tolerance))

	(define (try guess)
		(display (format "~a\n" guess))
		(set! tick (inc tick))
		(let ((next (f guess)))
			(if (close-enough? guess next)
				next
          		(try next))))

  (try first-guess))

;
; xˣ = 1000
; 
; ⟹ log(xˣ) = log(1000)
; ⟹ x∙log(x) = log(1000)
; ⟹ x = log(1000)/log(x)

; Without average dampening
(fixed-point (lambda (x) (/ (log 1000) (log x))) 10)
(display (format "Ticked ~a times without average dampening\n" tick))
(set! tick 0)
; 33 iterations

; With average dampening 
(fixed-point (lambda (x) (average x (/ (log 1000) (log x)))) 10)
(display (format "Ticked ~a times with average dampening\n" tick))
(set! tick 0)
; 10 iterations



