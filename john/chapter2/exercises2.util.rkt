#lang racket



; A helper function for priting out the exercise title
; and some other bits for displaying comments.
(define nl "\n")
(define (get-string item)
  (cond ((string? item) item)
        ((number? item) (number->string item))
        (else item)))

(define (str . parts)
  (define strParts (map ~a parts))
  (apply string-append  strParts ))

(define (display-line line)
  (display (str line "\n")))

(define (prn . lines)
  (for-each display-line lines))

(define (double-underline line)
  (let ((len (string-length line)))
    (display-line line)
    (display-line (make-string len #\=))))

(define (decorate-line line length)  
  (define decor (make-string length #\_))
  (prn "" decor line decor ""))

(define (ti title) (decorate-line title 74))

(define (ex number) (ti (str "Exercise " number)))

(define (sub text) (decorate-line text 18))

;#########################################################################
;#########################################################################

(provide (all-defined-out))