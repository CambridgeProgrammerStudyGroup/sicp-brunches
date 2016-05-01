#lang racket

; Section 2.2.1: Representing Sequences

(require "common.rkt")

;   Exercise 2.17
;   =============
;   
;   Define a procedure last-pair that returns the list that contains only
;   the last element of a given (nonempty) list:
;   
;   (last-pair (list 23 72 149 34))
;   (34)
;   
;   ------------------------------------------------------------------------
;   [Exercise 2.17]: http://sicp-book.com/book-Z-H-15.html#%_thm_2.17
;   2.2.1 Representing Sequences - p103
;   ------------------------------------------------------------------------

(-start- "2.17")

(define (last-pair lst)
  (let ((tail (cdr lst)))
    (if (null? tail)
        lst
        (last-pair tail))))

(define list-2.17 (list 23 72 149 34))

(prn
 (str "last-pair of " list-2.17 ": " (last-pair list-2.17)))

(--end-- "2.17")

;   ========================================================================
;   
;   Exercise 2.18
;   =============
;   
;   Define a procedure reverse that takes a list as argument and returns a
;   list of the same elements in reverse order:
;   
;   (reverse (list 1 4 9 16 25))
;   (25 16 9 4 1)
;   
;   ------------------------------------------------------------------------
;   [Exercise 2.18]: http://sicp-book.com/book-Z-H-15.html#%_thm_2.18
;   2.2.1 Representing Sequences - p103
;   ------------------------------------------------------------------------

(-start- "2.18")

(define list-2.18 (list 1 4 9 16 25))

; using append is a bit of a cheat :(
; or at least might get a bit slow.
(define (reverse-rec-append lst)
  (if (null? lst) lst
      (append (reverse-rec-append (cdr lst)) (list (car lst)))))

(prn
 (str "reverse-rec-append of " list-2.18 ": " 
      (reverse-rec-append list-2.18)))

(define (reverse-itr lst)
  (define (iter lst reversed)
    (if (null? lst) reversed
        (iter (cdr lst) (cons (car lst) reversed))))
  (iter lst null))

(prn
 (str "reverse-itr of " list-2.18 ": " 
      (reverse-itr list-2.18)))


(prn
 (str)
 (str)
 (str "Now a recursive(?) function with linear perfomrance?")
 (str)
 (str "First a function which builds a function for")
 (str "each member of the list.  For each item we get")
 (str "a function which: ")
 (str "  - takes: a function that returns")
 (str "    the reverse of the preceding items")
 (str "  - returns: a list which is the reverse")
 (str "    of everything")
 (str "When called on a list, the above functions is for ")
 (str "the head of the list. As the head has no predecessors, ")
 (str "the function which returns its predecessors need only ")
 (str "return an empty list.")
 (str))

; function builder
(define (reverse-rec-fb list)
  (lambda (get-reverse-of-predecessors)
    (if (null? list)
        (get-reverse-of-predecessors)
        ((reverse-rec-fb (cdr list))
                  (lambda ()
                    (prn (str "About to call cons with: " (car list)))
                    (cons (car list) (get-reverse-of-predecessors)))))))

(define (reverse-rec list)
  ((reverse-rec-fb list) (lambda () '())))

(prn (str)
 (str "reverse-rec of " list-2.18 ": " 
      (reverse-rec list-2.18))

;Output:
;
; About to call cons with: 25
; About to call cons with: 16
; About to call cons with: 9
; About to call cons with: 4
; About to call cons with: 1
;
; reverse-rec of (1 4 9 16 25): (25 16 9 4 1)
 
 (str)
 (str "Despite the output, cons is first called with 1")
 (str "not with 25, because of applicative order, ")
 (str "(arguments are evaluated before the call to cons).")
 (str))

(--end-- "2.18")

;   ========================================================================
;   
;   Exercise 2.19
;   =============
;   
;   Consider the change-counting program of section [1.2.2].  It would be
;   nice to be able to easily change the currency used by the program, so
;   that we could compute the number of ways to change a British pound, for
;   example.  As the program is written, the knowledge of the currency is
;   distributed partly into the procedure first-denomination and partly into
;   the procedure count-change (which knows that there are five kinds of
;   U.S. coins).  It would be nicer to be able to supply a list of coins to
;   be used for making change.
;   
;   We want to rewrite the procedure cc so that its second argument is a
;   list of the values of the coins to use rather than an integer specifying
;   which coins to use.  We could then have lists that defined each kind of
;   currency:
;   
;   (define us-coins (list 50 25 10 5 1))
;   (define uk-coins (list 100 50 20 10 5 2 1 0.5))
;   
;   We could then call cc as follows:
;   
;   (cc 100 us-coins)
;   292
;   
;   To do this will require changing the program cc somewhat.  It will still
;   have the same form, but it will access its second argument differently,
;   as follows:
;   
;   (define (cc amount coin-values)
;     (cond ((= amount 0) 1)
;           ((or (< amount 0) (no-more? coin-values)) 0)
;           (else
;            (+ (cc amount
;                   (except-first-denomination coin-values))
;               (cc (- amount
;                      (first-denomination coin-values))
;                   coin-values)))))
;   
;   Define the procedures first-denomination, except-first-denomination, and
;   no-more? in terms of primitive operations on list structures.  Does the
;   order of the list coin-values affect the answer produced by cc?  Why or
;   why not?
;   
;   ------------------------------------------------------------------------
;   [Exercise 2.19]: http://sicp-book.com/book-Z-H-15.html#%_thm_2.19
;   [Section 1.2.2]: http://sicp-book.com/book-Z-H-11.html#%_sec_1.2.2
;   2.2.1 Representing Sequences - p103
;   ------------------------------------------------------------------------

(-start- "2.19")

; this is a trivial function, but since we
; are creating selector functions to abstract
; the data representation it seems only right
; to the same for creating the representation.
(define (make-denominations d-list) d-list)

(define uk-coins (make-denominations (list 200 100 50 20 10 5 2 1)))
(define us-coins (make-denominations (list 50 25 10 5 1)))

(define (first-denomination ds)
  (car ds))

(define (except-first-denomination ds)
  (cdr ds))

(define (no-more? ds)
  (null? ds))

(define (cc amount ds)
  (cond
    ((= amount 0) 1)
    ((or (< amount 0)(no-more? ds)) 0)
    (else
     (+ (cc (- amount (first-denomination ds)) ds)
        (cc amount (except-first-denomination ds))))))

(prn
 (str "UK coin count for £2.10: "
      (cc 210 uk-coins))
 (str "US coin count for $1.00: "
      (cc 100 us-coins))
 (str)
 (str "My guess... we get the same result.")
 (str "Because I don't think the algorithm makes any assumption")
 (str "about the size of the coins. Performance may be worse")
 (str "as 'backing-off' will require more steps, e.g., need to")
 (str "back-off by a penny 5 times before using 5p or nickle.")
 (str)
 (str "Let's see...")
 (str))

(define uk-coins-rev (reverse uk-coins))
(prn 
 (str "Reversed UK denominations: " uk-coins-rev)
 (str "UK coin count for £2.10 (rev):"
      (cc 210 uk-coins-rev)))

(prn (str) "Phew. (And appears noticably slower.)")

(--end-- "2.19")

;   ========================================================================
;   
;   Exercise 2.20
;   =============
;   
;   The procedures +, *, and list take arbitrary numbers of arguments. One
;   way to define such procedures is to use define with dotted-tail
;   notation.  In a procedure definition, a parameter list that has a dot
;   before the last parameter name indicates that, when the procedure is
;   called, the initial parameters (if any) will have as values the initial
;   arguments, as usual, but the final parameter's value will be a list of
;   any remaining arguments. For instance, given the definition
;   
;   (define (f x y . z) <body>)
;   
;   the procedure f can be called with two or more arguments. If we evaluate
;   
;   (f 1 2 3 4 5 6)
;   
;   then in the body of f, x will be 1, y will be 2, and z will be the list
;   (3 4 5 6). Given the definition
;   
;   (define (g . w) <body>)
;   
;   the procedure g can be called with zero or more arguments. If we
;   evaluate
;   
;   (g 1 2 3 4 5 6)
;   
;   then in the body of g, w will be the list (1 2 3 4 5 6).⁽¹¹⁾
;   
;   Use this notation to write a procedure same-parity that takes one or
;   more integers and returns a list of all the arguments that have the same
;   even-odd parity as the first argument.  For example,
;   
;   (same-parity 1 2 3 4 5 6 7)
;   (1 3 5 7)
;   
;   (same-parity 2 3 4 5 6 7)
;   (2 4 6)
;   
;   ------------------------------------------------------------------------
;   [Exercise 2.20]: http://sicp-book.com/book-Z-H-15.html#%_thm_2.20
;   [Footnote 11]:   http://sicp-book.com/book-Z-H-15.html#footnote_Temp_164
;   2.2.1 Representing Sequences - p104
;   ------------------------------------------------------------------------

(-start- "2.20")

(define list-2.20-1 (list 1 2 3 4 5 6 7))
(define list-2.20-2 (list 2 3 4 5 6 7))

(define (filter predicate list)
  (define (filter-itr list filtered)
    (if (null? list) filtered        
        (filter-itr (cdr list)
                    (if (predicate (car list))
                        (cons (car list) filtered)
                        filtered))))
  (reverse (filter-itr list null)))

            

(define (same-parity first . rest)
  (let ((first-mod (modulo first 2)))
    (cons first (filter
                 (lambda (r) (= first-mod (modulo r 2)))
                 rest))))
(prn 
 (str "same parity of 1, ..., 7: " (same-parity 1 2 3 4 5 6 7))
 (str "same parity of 2, ..., 7: " (same-parity 2 3 4 5 6 7)))

(--end-- "2.20")

;   ========================================================================
;   
;   Exercise 2.21
;   =============
;   
;   The procedure square-list takes a list of numbers as argument and
;   returns a list of the squares of those numbers.
;   
;   (square-list (list 1 2 3 4))
;   (1 4 9 16)
;   
;   Here are two different definitions of square-list.  Complete both of
;   them by filling in the missing expressions:
;   
;   (define (square-list items)
;     (if (null? items)
;         nil
;         (cons <??> <??>)))
;   (define (square-list items)
;     (map <??> <??>))
;   
;   ------------------------------------------------------------------------
;   [Exercise 2.21]: http://sicp-book.com/book-Z-H-15.html#%_thm_2.21
;   2.2.1 Representing Sequences - p106
;   ------------------------------------------------------------------------

(-start- "2.21")

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

(--end-- "2.21")

;   ========================================================================
;   
;   Exercise 2.22
;   =============
;   
;   Louis Reasoner tries to rewrite the first square-list procedure of
;   exercise [2.21] so that it evolves an iterative process:
;   
;   (define (square-list items)
;     (define (iter things answer)
;       (if (null? things)
;           answer
;           (iter (cdr things) 
;                 (cons (square (car things))
;                       answer))))
;     (iter items nil))
;   
;   Unfortunately, defining square-list this way produces the answer list in
;   the reverse order of the one desired.  Why?
;   
;   Louis then tries to fix his bug by interchanging the arguments to cons:
;   
;   (define (square-list items)
;     (define (iter things answer)
;       (if (null? things)
;           answer
;           (iter (cdr things)
;                 (cons answer
;                       (square (car things))))))
;     (iter items nil))
;   
;   This doesn't work either.  Explain.
;   
;   ------------------------------------------------------------------------
;   [Exercise 2.22]: http://sicp-book.com/book-Z-H-15.html#%_thm_2.22
;   [Exercise 2.21]: http://sicp-book.com/book-Z-H-15.html#%_thm_2.21
;   2.2.1 Representing Sequences - p106
;   ------------------------------------------------------------------------

(-start- "2.22")

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

(--end-- "2.22")

;   ========================================================================
;   
;   Exercise 2.23
;   =============
;   
;   The procedure for-each is similar to map.  It takes as arguments a
;   procedure and a list of elements.  However, rather than forming a list
;   of the results, for-each just applies the procedure to each of the
;   elements in turn, from left to right.  The values returned by applying
;   the procedure to the elements are not used at all -- for-each is used
;   with procedures that perform an action, such as printing.  For example,
;   
;   (for-each (lambda (x) (newline) (display x))
;             (list 57 321 88))
;   57
;   321
;   88
;   
;   The value returned by the call to for-each (not illustrated above) can
;   be something arbitrary, such as true.  Give an implementation of
;   for-each.
;   
;   ------------------------------------------------------------------------
;   [Exercise 2.23]: http://sicp-book.com/book-Z-H-15.html#%_thm_2.23
;   2.2.1 Representing Sequences - p107
;   ------------------------------------------------------------------------

(-start- "2.23")

(define (for-each proc items)
  (if (empty? items)
      #t
      (let ()
        (proc (car items))
        (for-each proc (cdr items)))))

(prn
 ""
 (for-each (lambda (x) (newline) (display x))
           (list 57 321 88)))

(--end-- "2.23")

