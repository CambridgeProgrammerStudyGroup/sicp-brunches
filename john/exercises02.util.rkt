#lang racket



; A helper function for priting out the exercise title
; and some other bits for displaying comments.
;(define nl "\n")
;(define (get-string item)
;  (cond ((string? item) item)
;        ((number? item) (number->string item))
;        (else item)))
(define get-string ~a)
(define (str . parts)
  (define strParts (map get-string parts))
  (apply string-append  strParts ))
(define (prn . lines)
  (for-each
   (lambda (line) (display (str line "\n")))
   lines))

(define (ti title)
  (define long (make-string 60 #\_))
  (prn "" "" long    title    long ""))

(define (ex number) (ti (str "Exercise " number)))

;#########################################################################
;#########################################################################

(provide (all-defined-out))