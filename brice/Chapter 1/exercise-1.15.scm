#lang racket

;; Excercise 1.15

(display "\nEXCERCISE 1.15\n")

; We can approximate sin(x) = x for small x.
; sin(x)=3sin(x/3) - 4 sin^3(x/3)
(define (cube x) (* x x x))

(define counter 0)

(define (p x) (set! counter (+ 1 counter)) (- (* 3 x) (* 4 (cube x))))


(define (sine angle)
   (if (not (> (abs angle) 0.1))
       angle
       (p (sine (/ angle 3.0)))))

(sine 12.15) ;-> p will be called 5 times.

; This makes sense because 12.15*(1/3)^4 > 0.1, but 12.15*(1/3)^5 < 0.1

(set! counter 0)

; for the following, we expect p to be called 8 times.

; This is because 
; x*(1/3)^N > 0.1
;=> (1/3)^N > 0.1/x
;=> N log(1/3) > log(0.1/x)
;=> N > log(0.1/x) / log(1/3)
;=> Since steps are discrete, N = Ceil(log(0.1/x) / log(1/3))
; When x = 345.67, N = 8
(sine 345.67)  ;-> calls p 8 times as expected.
; Which implies that Sine is of order O(log(N))

; Because the function is not tail recursive, and is therefore a 
; recursive process, rather than an iterative one, the order of 
; growth for the space requirements of the sine function is also
; O(log(N)), as it will be identical to the order of growth for the
; number of steps.

(display (format "~a\n" counter)) 