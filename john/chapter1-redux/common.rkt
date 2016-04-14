#lang racket

(define line-length 72)

(define nl "\n")

(define (str . parts)
  (apply string-append  (map ~a parts)))


(define (display-line line)
  (display (str "" line nl)))

(define (display-lines lines)
  (for-each display-line lines))

(define (prnl lines)
  (for-each display-line lines))

(define (prn . lines)
  (prnl lines))

;(define (dbl-un text)
;  (list text (make-string (string-length text) #\=)))

(define dsh-line (make-string line-length #\-))

(define (dsh-un text)
  (list text (make-string (string-length text) #\-) ""))

(define (out title)
   (list
    dsh-line
    (str "Output: Exercise " title)
    dsh-line
    ""))
    

(define (-start- ex-number)
  (display-lines (out ex-number)))

(define (--end-- _)
  (display "\n\n"))


(define (present-one function inputs expected)
  (list
   (str)
   (str "    With: " inputs)
   (str "    Expected: " expected)
   (str "    Actual:   " (apply function inputs))))

(define (present function . input-expected-pairs)
  (define (present-pair pair)
    (apply present-one (cons function pair)))
  (prn
   (str "Calling: " (object-name function)))
  (for-each prnl
            (map present-pair input-expected-pairs)))

(provide (all-defined-out))


;#########################################################################
;#########################################################################
