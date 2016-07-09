#lang racket
(require "../utils.scm")
(require "../meta.scm")

(title "Exercise 2.53")

;   Exercise 2.53
;   =============
;
;   What would the interpreter print in response to evaluating each of the
;   following expressions?
;
;   (list 'a 'b 'c')
(assertequal? "(list 'a 'b 'c)"
  (list 'a 'b 'c)
  '(a b c))
;
;   (list (list 'george))
(assertequal? "(list (list 'george))"
  (list (list 'george))
  '((george)))

;   (cdr '((x1 x2) (y1 y2)))
(assertequal? "(cdr '((x1 x2) (y1 y2)))"
  (cdr '((x1 x2) (y1 y2)))
  '((y1 y2)) )

;
;   (cadr '((x1 x2) (y1 y2)))
(assertequal? "(cadr '((x1 x2) (y1 y2)))"
  (cadr '((x1 x2) (y1 y2)))
  '(y1 y2))

;   (pair? (car '(a short list)))
(assertequal? "(pair? (car '(a short list)))"
  (pair? (car '(a short list)))
  #f)

;   (memq 'red '((red shoes) (blue socks)))
(assertequal? "(memq 'red '((red shoes) (blue socks)))"
  (memq 'red '((red shoes) (blue socks)))
  #f)
;
;   (memq 'red '(red shoes blue socks))
(assertequal? "(memq 'red '(red shoes blue socks))"
  (memq 'red '(red shoes blue socks))
  '(red shoes blue socks))
;
;   ------------------------------------------------------------------------
;   [Exercise 2.53]: http://sicp-book.com/book-Z-H-16.html#%_thm_2.53
;   2.3.1 Quotation - p144
;   ------------------------------------------------------------------------
