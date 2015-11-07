#lang racket
(require "../utils.scm")

; Exercise 1.34: Suppose we define the procedure 
;
;     (define (f g) (g 2))
;
; Then we have
;
;     (f square) ;-> 4
;
; and also
;
;     (f (lambda (z) (* z (+ z 1)))) ;-> 6
;
; What happens if we (perversely) ask the interpreter to evaluate the combination (f f)? Explain.
;
; (f f) -> (f 2) -> (2 2) -> syntax error, 2 is not callable