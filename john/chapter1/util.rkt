#lang racket

(define line-length 76)

(define (str . parts)
  (apply string-append  (map ~a parts)))

(define (display-line line)
  (display (str ";>  " line "\n")))

(define (display-lines lines)
  (for-each display-line lines))

(define (prn . lines)
  (for-each display-line lines))

;(define (dbl-un text)
;  (list text (make-string (string-length text) #\=)))

(define dsh-line (make-string line-length #\-))

(define (out title)
  (list
   dsh-line
   (str title " (output)")
   dsh-line))

(define (output title)
  (display-lines (out title)))

(provide (all-defined-out))


;#########################################################################
;#########################################################################
