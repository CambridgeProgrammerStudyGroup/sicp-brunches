; Exercise 1.8: 

(define (cube-root-improve y x)
  (/ (+ (/ x (* y y)) (* 2 y)) 3.0))

; define generic function which takes an improver function 'improve'
; and a test function 'test?' whcih checks if the iteration is sufficiently good.
; the 'test?' function must be of the form:
; 
;     (test? <previous-guess> <current-guess> original value)
; 
; and return a boolean value.
(define (iterator improve test? prev-guess curr-guess x)
  (if (test? prev-guess curr-guess x) curr-guess
          (iterator improve test? curr-guess (improve curr-guess x) x)))

