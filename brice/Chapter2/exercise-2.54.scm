#lang racket
(require "../utils.scm")
(require "../meta.scm")

(title "Exercise 2.54")

;   Exercise 2.54
;   =============
;
;   Two lists are said to be equal? if they contain equal elements arranged
;   in the same order.  For example,
;
;   (equal? '(this is a list) '(this is a list))
;
;   is true, but
;
;   (equal? '(this is a list) '(this (is a) list))
;
;   is false.  To be more precise, we can define equal? recursively in terms
;   of the basic eq? equality of symbols by saying that a and b are equal?
;   if they are both symbols and the symbols are eq?, or if they are both
;   lists such that (car a) is equal? to (car b) and (cdr a) is equal? to
;   (cdr b).  Using this idea, implement equal? as a procedure.⁽³⁶⁾
;
;   ------------------------------------------------------------------------
;   [Exercise 2.54]: http://sicp-book.com/book-Z-H-16.html#%_thm_2.54
;   [Footnote 36]:   http://sicp-book.com/book-Z-H-16.html#footnote_Temp_233
;   2.3.1 Quotation - p145
;   ------------------------------------------------------------------------

(define (bequal? a b)
  (cond
    ((and (symbol? a) (symbol? b) (eq? a b)) #t)
    ((or (symbol? a) (symbol? b)) #f)
    ((and (empty? a) (empty? b)) #t)
    ((or (empty? a) (empty? b)) #f)
    ((and (list? (first a)) (list? (first b)))
      (if (bequal? (first a) (first b))
        (bequal? (rest a) (rest b))
        #f))
    ((eq? (first a) (first b)) (bequal? (rest a) (rest b)))
    (else #f)
  ))

(let*
  (
    (A '(a b c))
    (B '(a c b))
    (C '(a (b c) d))
    (D '())
    (E '((a b) (c d)))
  )
  (assert "Empty list equals itself" (bequal? '() '()))
  (assert "Simple lists equal themselves" (bequal? A '(a b c)))
  (assert "Different simple lists differ" (not (bequal? A B)))
  (assert "Lists of different length cannot equal each other" (not (bequal? A D)))
  (assert "Nested lists equal themselves" (bequal? C '(a (b c) d)))
  (assert "Different nested lists differ" (not (bequal? C E)))
  (assert "Symbols equal themselves" (bequal? 'a 'a))
  (assert "Symbols do not equal lists" (not (bequal? 'a '(a))))
  (assert "Nested lists equal themselves mkII" (bequal? E '((a b) (c d))))
)
