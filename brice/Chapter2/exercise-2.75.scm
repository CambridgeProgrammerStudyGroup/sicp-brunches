#lang racket
(require "../utils.scm")
(require "../meta.scm")

(title "Exercise 2.75")

;   Exercise 2.75
;   =============

(define (make-from-real-imag x y)
  (define (dispatch op)
    (cond
      [(eq? op 'real-part) x]
      [(eq? op 'imag-part) y]
      [(eq? op 'magnitude)
        (sqrt (+ (square x) (square y)))]
      [(eq? op 'angle) (atan y x)]
      [else (error "Unknown op: MAKE-FROM-REAL-IMAG" op)]))
  dispatch)
;
;   Implement the constructor make-from-mag-ang in message-passing style.
;   This procedure should be analogous to the make-from-real-imag procedure
;   given above.
;
;   ------------------------------------------------------------------------
;   [Exercise 2.75]: http://sicp-book.com/book-Z-H-17.html#%_thm_2.75
;   2.4.3 Data-Directed Programming and Additivity - p187
;   ------------------------------------------------------------------------

(define (make-from-mag-ang mag ang)
  (define (dispatch op)
    (cond
      [(eq? op 'real-part) (* mag (cos ang))]
      [(eq? op 'imag-part) (* mag (sin ang))]
      [(eq? op 'magnitude) mag]
      [(eq? op 'angle) ang]
      [else (error "Unknown op: MAKE-FROM-REAL-IMAG" op)]))
  dispatch)

(module* main #f
  (let* [
    [ang-1 (make-from-real-imag 1 1)]
    [ang-2 (make-from-mag-ang (sqrt 2) (* 0.25 π))]]

  (asserteq "Numbers (mag & angle) and (real & imag) have same magnitude"
    (ang-1 'magnitude)
    (ang-2 'magnitude))

  (asserteq "Numbers (mag & angle) and (real & imag) have same angle"
    (ang-1 'angle)
    (ang-2 'angle))

  (asserteq "Numbers (mag & angle) and (real & imag) have same real part"
    (ang-1 'real-part)
    (ang-2 'real-part))

  (asserteq "Numbers (mag & angle) and (real & imag) have same imaginary part"
    (ang-1 'imag-part)
    (ang-2 'imag-part))

  )
)
