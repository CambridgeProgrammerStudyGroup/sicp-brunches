#lang racket

; Flotsam and Jetsam from working through Chapter 2.

; 2.2.1  Representing Sequences
; https://mitpress.mit.edu/sicp/full-text/book/book-Z-H-15.html#%_sec_2.2.1

(require "util-v1.rkt")

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

(define (for-each proc items)
  (if (empty? items)
      #t
      (let ()
        (proc (car items))
        (for-each proc (cdr items)))))
                   
(for-each (lambda (x) (newline) (display x))
          (list 57 321 88))

;#########################################################################
;#########################################################################

(ti "Exercise 2.24")

; Exercise 2.24.  Suppose we evaluate the expression (list 1 (list 2 (list
; 3 4))). Give the result printed by the interpreter, the corresponding
; box-and-pointer structure, and the interpretation of this as a tree (as
; in figure 2.6).

(prn
 (str "[.|.] - [.|/]                 ")
 (str " |       |                    ")
 (str " 1      [.|.] - [.|/]         ")
 (str "         |       |            ")
 (str "         2      [.|.] - [.|/] ")
 (str "                 |       |    ")
 (str "                 3       4    "))

;#########################################################################
;#########################################################################

(ti "Exercise 2.25")

; Exercise 2.25.  Give combinations of cars and cdrs that will pick 7 from
; each of the following lists:
; 
; (1 3 (5 7) 9)
; 
; ((7))
; 
; (1 (2 (3 (4 (5 (6 7))))))

(let ((a (list 1 3 (list 5 7) 9))
      (b (list (list 7)))
      (c (list 1 (list 2 (list 3 (list 4 (list 5 (list 6 7))))))))
  (prn
   (str a ":")
   (str "    cdr->cdr->car->cdr->car: " (car (cdr (car (cdr (cdr a))))))
   (str b ":")
   (str "    car->car: " (car (car b)))
   (str c ":")
   (str "    cdr->car->cdr->car->cdr->car->cdr->car->cdr->car->cdr->car: "
        (car (cdr (car (cdr (car (cdr (car (cdr (car (cdr (car (cdr c)))))))))))))
   ))

;#########################################################################
;#########################################################################

(ti "Exercise 2.26")

; Exercise 2.26.  Suppose we define x and y to be two lists:
; 
; (define x (list 1 2 3))
; (define y (list 4 5 6))
; 
; What result is printed by the interpreter in response to evaluating each
; of the following expressions:
; 
; (append x y)
; 
; (cons x y)
; 
; (list x y)

(prn
 (str "Guess...")
 (str "  (append x y): (1 2 3 (4 5 6))")
 (str "  (cons x y):   ((1 2 3) (4 5 6))")
 (str "  (list x y):   ((1 2 3) (4 5 6))"))

(let ((x (list 1 2 3))
      (y (list 4 5 6)))    
  (prn
   (str)
   (str "Actual...")
   (str "  (append x y): " (append x y))
   (str "  (cons x y)  : " (cons x y))
   (str "  (list x y)  : " (list x y))
   (str)
   (str "Well that's embarrassing. One outa three IS bad.  I think I'll go")
   (str "get another coffee :(")))


;#########################################################################
;#########################################################################

(ti "Exercise 2.27")

; Exercise 2.27.  Modify your reverse procedure of exercise 2.18 to
; produce a deep-reverse procedure that takes a list as argument and
; returns as its value the list with its elements reversed and with all
; sublists deep-reversed as well. For example,
; 
; (define x (list (list 1 2) (list 3 4)))
; 
; x
; ((1 2) (3 4))
; 
; (reverse x)
; ((3 4) (1 2))
; 
; (deep-reverse x)
; ((4 3) (2 1))

(define (reverse lst)
  (define (iter lst reversed)
    (if (null? lst) reversed
        (iter (cdr lst) (cons (car lst) reversed))))
  (iter lst null))

(define (deep-reverse lst)
  (define (iter lst reversed)
    (if (null? lst) reversed
        (let* ((head (car lst))
               (rev-head (if (pair? head)
                             (iter head null)
                             head)))
          (iter (cdr lst) (cons rev-head reversed)))))
  (iter lst null))

(let ((x (list (list 1 2) (list 3 4))))
  (prn
   (str "x: " x)
   (str "reverse x: " (reverse x))
   (str "deep-reverse x: " (deep-reverse x))))
    

;#########################################################################
;#########################################################################

(ti "Exercise 2.28")

; Exercise 2.28.  Write a procedure fringe that takes as argument a tree
; (represented as a list) and returns a list whose elements are all the
; leaves of the tree arranged in left-to-right order. For example,
; 
; (define x (list (list 1 2) (list 3 4)))
; 
; (fringe x)
; (1 2 3 4)
; 
; (fringe (list x x))
; (1 2 3 4 1 2 3 4)

(define (fringe tree)
  (if (pair? tree)
      (append (fringe (car tree)) (fringe (cdr tree)))
      (if (null? tree)
           tree
           (list tree))))

(let ((x (list (list 1 2) (list 3 4)))) 
  (prn
   (str "x: " x)
   (str "fringe x: " (fringe x))
   (str "fringe list x x " (fringe (list x x)))))


;#########################################################################
;#########################################################################

(ti "Exercise 2.29")

; Exercise 2.29.  A binary mobile consists of two branches, a left branch
; and a right branch. Each branch is a rod of a certain length, from which
; hangs either a weight or another binary mobile. We can represent a
; binary mobile using compound data by constructing it from two branches
; (for example, using list):
; 
; (define (make-mobile left right)
;   (list left right))
; 
; A branch is constructed from a length (which must be a number) together
; with a structure, which may be either a number (representing a simple
; weight) or another mobile:
; 
; (define (make-branch length structure)
;   (list length structure))
; 
; a.  Write the corresponding selectors left-branch and right-branch,
; which return the branches of a mobile, and branch-length and branch-
; structure, which return the components of a branch.
; 
; b.  Using your selectors, define a procedure total-weight that returns
; the total weight of a mobile.
; 
; c.  A mobile is said to be balanced if the torque applied by its top-
; left branch is equal to that applied by its top-right branch (that is,
; if the length of the left rod multiplied by the weight hanging from that
; rod is equal to the corresponding product for the right side) and if
; each of the submobiles hanging off its branches is balanced. Design a
; predicate that tests whether a binary mobile is balanced.
; 
; d.  Suppose we change the representation of mobiles so that the
; constructors are
; 
; (define (make-mobile left right)
;   (cons left right))
; (define (make-branch length structure)
;   (cons length structure))
; 
; How much do you need to change your programs to convert to the new
; representation?

(define (make-mobile left right)
  (list left right))

(define (make-branch length structure)
  (list length structure))

(define one (make-mobile (make-branch 1 1) (make-branch 1 1)))
(define two (make-mobile (make-branch 1 2) (make-branch 2 1)))
(define three (make-mobile (make-branch 3 one) (make-branch 2 two)))
(define oops (make-mobile (make-branch 3 one)
                          (make-branch
                           2
                           (make-mobile (make-branch 2 2) (make-branch 2 1)))))

(prn
 "one:"
 "    |"
 "   -|- "
 "  1   1"
 ""
 "two:"
 "    |"
 "   -|--"
 "  2    1"
 ""
 "three:"
 "          |"
 "       ---|--"
 "   -|-        -|--"
 "  1   1      2    1"
 ""
 "oops:"
 "          |"
 "       ---|--"
 "   -|-        --|--"
 "  1   1      2     1"
 )

(define (left-branch mobile)
  (car mobile))

(define (right-branch mobile)
  (car (cdr mobile)))

(define (branch-length branch)
  (car branch))

(define (branch-structure branch)
  (car (cdr branch)))

;#########################################################################
; b.

(define (total-weight mobile)
  (let((ls (branch-structure (left-branch mobile)))
       (rs (branch-structure (right-branch mobile))))
    (+ (if (pair? ls) (total-weight ls) ls)
       (if (pair? rs) (total-weight rs) rs))))

(prn
 ""
 "weights:"
 (str "  one:   " (total-weight one))
 (str "  two:   " (total-weight two))
 (str "  three: " (total-weight three))
 (str "  oops:  " (total-weight oops)))

;#########################################################################
(sub "c.")

(define (branch-torque branch)
  (* (branch-length branch)
     (let ((structure (branch-structure branch)))
       (if (pair? structure)
           (total-weight structure)
           structure))))

(define (balanced? structure)
  (if (not (pair? structure))
      true
      (and (equal? (branch-torque (left-branch structure))
                  (branch-torque (right-branch structure)))
           (and (balanced? (branch-structure (left-branch structure)))
                (balanced? (branch-structure (right-branch structure)))))))

(prn
 (str "")
 (str "balanced?: ")
 (str "  one:   " (balanced? one))
 (str "  two:   " (balanced? two))
 (str "  three: " (balanced? three))
 (str "  oops:  " (balanced? oops)))
 
;#########################################################################
(sub "d.")

(prn
 (str "Guess:  We just need to change the get branch, length and strructure")
 (str "functions.  Although that does depend on the 'coincidence' that in")
 (str "both implementations we can use 'pair?' to distinguish between a weight")
 (str "and a structure."))

; Ok, a crude way to test it ...

(define (Make-Mobile left right)
  (cons left right))

(define (Make-Branch length structure)
  (cons length structure))

(define One (Make-Mobile (Make-Branch 1 1) (Make-Branch 1 1)))
(define Two (Make-Mobile (Make-Branch 1 2) (Make-Branch 2 1)))
(define Three (Make-Mobile (Make-Branch 3 One) (Make-Branch 2 Two)))
(define Oops (Make-Mobile (Make-Branch 3 One)
                          (Make-Branch
                           2
                           (Make-Mobile (Make-Branch 2 2) (Make-Branch 2 1)))))

(define (Left-Branch mobile)
  (car mobile))

(define (Right-Branch mobile)
  (cdr mobile))

(define (Branch-Length branch)
  (car branch))

(define (Branch-Structure branch)
  (cdr branch))

(define (Total-Weight mobile)
  (let((ls (Branch-Structure (Left-Branch mobile)))
       (rs (Branch-Structure (Right-Branch mobile))))
    (+ (if (pair? ls) (total-weight ls) ls)
       (if (pair? rs) (total-weight rs) rs))))

(define (Branch-Torque branch)
  (* (branch-length branch)
     (let ((structure (Branch-Structure branch)))
       (if (pair? structure)
           (Total-Weight structure)
           structure))))

(define (Balanced? structure)
  (if (not (pair? structure))
      true
      (and (equal? (Branch-Torque (Left-Branch structure))
                  (Branch-Torque (Right-Branch structure)))
           (and (Balanced? (Branch-Structure (Left-Branch structure)))
                (Balanced? (Branch-Structure (Right-Branch structure)))))))

(prn
 (str "")
 (str "Balanced?: ")
 (str "  One:   " (Balanced? One))
 (str "  Two:   " (Balanced? Two))
 (str "  Three: " (Balanced? Three))
 (str "  Oops:  " (Balanced? Oops)))

(prn
 (str)
 (str "Phew... Yep, just had to use cdr instead of car-cdr to get the")
 (str "second element of mobile / branch."))

; end-of-file