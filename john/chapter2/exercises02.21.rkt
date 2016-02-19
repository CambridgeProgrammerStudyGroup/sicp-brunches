#lang racket

; Flotsam and Jetsam from working through Chapter 2.

; 2.2.1  Representing Sequences
; https://mitpress.mit.edu/sicp/full-text/book/book-Z-H-15.html#%_sec_2.2.1

(require "exercises02.util.rkt")

;#########################################################################
;#########################################################################
(ti "Exercise 2.21")

; Exercise 2.21.  The procedure square-list takes a list of numbers as
; argument and returns a list of the squares of those numbers.
; 
; (square-list (list 1 2 3 4))
; (1 4 9 16)
; 
; Here are two different definitions of square-list. Complete both of them
; by filling in the missing expressions:
; 
; (define (square-list items)
;   (if (null? items)
;       nil
;       (cons <??> <??>)))
; (define (square-list items)
;   (map <??> <??>))

(define (square-list-rec items)
  (if (null? items)
      null
      (cons (* (car items) (car items)) (square-list-rec (cdr items)))))

(define (square-list-map items)
  (map (lambda (x) (* x x)) items))

(let ((items (list 0 1 2 3 4 5 6 7 8)))
  (prn
   (str "Items: " items)
   (str "square recurive: " (square-list-rec items))
   (str "square with map: " (square-list-map items))))

;Output:
;  Items: (0 1 2 3 4 5 6 7 8)
;  square recurive: (0 1 4 9 16 25 36 49 64)
;  square with map: (0 1 4 9 16 25 36 49 64)

;#########################################################################
;#########################################################################

(ti "Exercise 2.22")
; Exercise 2.22.  Louis Reasoner tries to rewrite the first square-list
; procedure of exercise 2.21 so that it evolves an iterative process:
; 
; (define (square-list items)
;   (define (iter things answer)
;     (if (null? things)
;         answer
;         (iter (cdr things) 
;               (cons (square (car things))
;                     answer))))
;   (iter items nil))
; 
; Unfortunately, defining squaqre-list this way produces the answer list
; in the reverse order of the one desired. Why?
;

(prn
 "In the first attempt 'answer' is more precisely 'answer-for-preceding-items'"
 "so the cons is putting the current answer ahead of the previous answers")

; Louis then tries to fix his bug by interchanging the arguments to cons:
; 
; (define (square-list items)
;   (define (iter things answer)
;     (if (null? things)
;         answer
;         (iter (cdr things)
;               (cons answer
;                     (square (car things))))))
;   (iter items nil))
; 
; This doesn't work either. Explain.

(prn
 ""
 "In the second attempt he is not adhereing to the list 'convention' which"
 "is that the first element in a cons pair is an item and the second is the"
 "rest of the list. Louis has reversed this convention. When his construct"
 "is interpreted as a regular list it has an item as the second element and "
 "a inner list as the first item in the outer list.")

;#########################################################################
;#########################################################################
(ti "Exercise 2.23")

; Exercise 2.23.  The procedure for-each is similar to map. It takes as
; arguments a procedure and a list of elements. However, rather than
; forming a list of the results, for-each just applies the procedure to
; each of the elements in turn, from left to right. The values returned
; by applying the procedure to the elements are not used at all -- for-
; each is used with procedures that perform an action, such as printing.
; For example,
; 
; (for-each (lambda (x) (newline) (display x))
;           (list 57 321 88))
; 57
; 321
; 88
; 
; The value returned by the call to for-each (not illustrated above) can
; be something arbitrary, such as true. Give an implementation of for-
; each.
