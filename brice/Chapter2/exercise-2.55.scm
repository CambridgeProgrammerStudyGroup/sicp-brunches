#lang racket
(require "../utils.scm")
(require "../meta.scm")

(title "Exercise 2.55")

;   Exercise 2.55
;   =============
;
;   Eva Lu Ator types to the interpreter the expression
;
;   (car ''abracadabra)
;
;   To her surprise, the interpreter prints back quote.  Explain.
;
;   ------------------------------------------------------------------------
;   [Exercise 2.55]: http://sicp-book.com/book-Z-H-16.html#%_thm_2.55
;   2.3.1 Quotation - p145
;   ------------------------------------------------------------------------

(prn
"The expression

    ''abracadabra

actually evaluates to the complete expression

    (quote (quote abracadabra))

The first `quote` wraps a list with two symbols,
the first of which happens to also be `quote`.
Hence, the expression is identical to

    '(quote abracadabra)

Unsurprisingly, the car of such a list is the
symbol `quote`.

    > (car ''abracadabra)
    'quote
")
