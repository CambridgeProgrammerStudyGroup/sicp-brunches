#lang racket

;#########################################################################
;#########################################################################

; Succently named string/dislpay helpers:

; preferred line max line length
(define ruler 74)

; concat objects
(define (str . parts)
  (apply string-append (map ~a parts)))

; join strings
(define (jn sep . parts)
  (if (empty? parts) ""
      (string-append
       (string-append (car parts) sep)
       (apply jn sep (cdr parts)))))

; newline string
(define nl "\n")

; join lines
(define (jnl . lines)
  (apply jn (cons nl lines)))

; horizontal rule
(define hr (make-string ruler #\_))

; decorate a line
(define (dec line)
  (jnl "" hr line hr ""))

; display an exercise title
(define (Exercise title)
  (display (dec (str "Exercise " title))))

; display a series of lines
(define (prn . lines)
  (display (apply jnl lines)))

(define (exercise url text) )

;#########################################################################
;#########################################################################

(provide (all-defined-out))

