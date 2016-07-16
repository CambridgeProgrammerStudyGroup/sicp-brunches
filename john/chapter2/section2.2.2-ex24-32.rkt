#lang racket

; Section 2.2.2: Hierarchical Structures

(require "common.rkt")

;   Exercise 2.24
;   =============
;   
;   Suppose we evaluate the expression (list 1 (list 2 (list 3 4))). Give
;   the result printed by the interpreter, the corresponding box-and-pointer
;   structure, and the interpretation of this as a tree (as in figure
;   [2.6]).
;   
;   ------------------------------------------------------------------------
;   [Exercise 2.24]: http://sicp-book.com/book-Z-H-15.html#%_thm_2.24
;   [Figure 2.6]:    http://sicp-book.com/book-Z-H-15.html#%_fig_2.6
;   2.2.2 Hierarchical Structures - p110
;   ------------------------------------------------------------------------

(-start- "2.24")

(prn
 (str "[.|.] - [.|/]                 ")
 (str " |       |                    ")
 (str " 1      [.|.] - [.|/]         ")
 (str "         |       |            ")
 (str "         2      [.|.] - [.|/] ")
 (str "                 |       |    ")
 (str "                 3       4    "))

(--end-- "2.24")

;   ========================================================================
;   
;   Exercise 2.25
;   =============
;   
;   Give combinations of cars and cdrs that will pick 7 from each of the
;   following lists:
;   
;   (1 3 (5 7) 9)
;   
;   ((7))
;   
;   (1 (2 (3 (4 (5 (6 7))))))
;   
;   ------------------------------------------------------------------------
;   [Exercise 2.25]: http://sicp-book.com/book-Z-H-15.html#%_thm_2.25
;   2.2.2 Hierarchical Structures - p110
;   ------------------------------------------------------------------------

(-start- "2.25")

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

(--end-- "2.25")

;   ========================================================================
;   
;   Exercise 2.26
;   =============
;   
;   Suppose we define x and y to be two lists:
;   
;   (define x (list 1 2 3))
;   (define y (list 4 5 6))
;   
;   What result is printed by the interpreter in response to evaluating each
;   of the following expressions:
;   
;   (append x y)
;   
;   (cons x y)
;   
;   (list x y)
;   
;   ------------------------------------------------------------------------
;   [Exercise 2.26]: http://sicp-book.com/book-Z-H-15.html#%_thm_2.26
;   2.2.2 Hierarchical Structures - p110
;   ------------------------------------------------------------------------

(-start- "2.26")

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

(--end-- "2.26")

;   ========================================================================
;   
;   Exercise 2.27
;   =============
;   
;   Modify your reverse procedure of exercise [2.18] to produce a
;   deep-reverse procedure that takes a list as argument and returns as its
;   value the list with its elements reversed and with all sublists
;   deep-reversed as well.  For example,
;   
;   (define x (list (list 1 2) (list 3 4)))
;   
;   x
;   ((1 2) (3 4))
;   
;   (reverse x)
;   ((3 4) (1 2))
;   
;   (deep-reverse x)
;   ((4 3) (2 1))
;   
;   ------------------------------------------------------------------------
;   [Exercise 2.27]: http://sicp-book.com/book-Z-H-15.html#%_thm_2.27
;   [Exercise 2.18]: http://sicp-book.com/book-Z-H-15.html#%_thm_2.18
;   2.2.2 Hierarchical Structures - p110
;   ------------------------------------------------------------------------

(-start- "2.27")

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

(--end-- "2.27")

;   ========================================================================
;   
;   Exercise 2.28
;   =============
;   
;   Write a procedure fringe that takes as argument a tree (represented as a
;   list) and returns a list whose elements are all the leaves of the tree
;   arranged in left-to-right order.  For example,
;   
;   (define x (list (list 1 2) (list 3 4)))
;   
;   (fringe x)
;   (1 2 3 4)
;   
;   (fringe (list x x))
;   (1 2 3 4 1 2 3 4)
;   
;   ------------------------------------------------------------------------
;   [Exercise 2.28]: http://sicp-book.com/book-Z-H-15.html#%_thm_2.28
;   2.2.2 Hierarchical Structures - p111
;   ------------------------------------------------------------------------

(-start- "2.28")

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

(--end-- "2.28")

;   ========================================================================
;   
;   Exercise 2.29
;   =============
;   
;   A binary mobile consists of two branches, a left branch and a right
;   branch.  Each branch is a rod of a certain length, from which hangs
;   either a weight or another binary mobile.  We can represent a binary
;   mobile using compound data by constructing it from two branches (for
;   example, using list):
;   
;   (define (make-mobile left right)
;     (list left right))
;   
;   A branch is constructed from a length (which must be a number) together
;   with a structure, which may be either a number (representing a simple
;   weight) or another mobile:
;   
;   (define (make-branch length structure)
;     (list length structure))
;   
;   a.  Write the corresponding selectors left-branch and right-branch,
;   which return the branches of a mobile, and branch-length and
;   branch-structure, which return the components of a branch.
;   
;   b.  Using your selectors, define a procedure total-weight that returns
;   the total weight of a mobile.
;   
;   c.  A mobile is said to be balanced if the torque applied by its
;   top-left branch is equal to that applied by its top-right branch (that
;   is, if the length of the left rod multiplied by the weight hanging from
;   that rod is equal to the corresponding product for the right side) and
;   if each of the submobiles hanging off its branches is balanced. Design a
;   predicate that tests whether a binary mobile is balanced.
;   
;   d.  Suppose we change the representation of mobiles so that the
;   constructors are
;   
;   (define (make-mobile left right)
;     (cons left right))
;   (define (make-branch length structure)
;     (cons length structure))
;   
;   How much do you need to change your programs to convert to the new
;   representation?
;   
;   ------------------------------------------------------------------------
;   [Exercise 2.29]: http://sicp-book.com/book-Z-H-15.html#%_thm_2.29
;   2.2.2 Hierarchical Structures - p111
;   ------------------------------------------------------------------------

(-start- "2.29")

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
(prn "" "")
(double-underline "Part c.")

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
(prn "" "")
(double-underline "Part d.")

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

(--end-- "2.29")

;   ========================================================================
;   
;   Exercise 2.30
;   =============
;   
;   Define a procedure square-tree analogous to the square-list procedure of
;   exercise [2.21].  That is, square-list should behave as follows:
;   
;   (square-tree
;    (list 1
;          (list 2 (list 3 4) 5)
;          (list 6 7)))
;   (1 (4 (9 16) 25) (36 49))
;   
;   Define square-tree both directly (i.e., without using any higher-order
;   procedures) and also by using map and recursion.
;   
;   ------------------------------------------------------------------------
;   [Exercise 2.30]: http://sicp-book.com/book-Z-H-15.html#%_thm_2.30
;   [Exercise 2.21]: http://sicp-book.com/book-Z-H-15.html#%_thm_2.21
;   2.2.2 Hierarchical Structures - p112
;   ------------------------------------------------------------------------

(-start- "2.30")

(define (square n) (* n n))

(define (square-tree tree)
  (cond ((null? tree) null)
        ((pair? tree)
         (cons (square-tree (car tree)) (square-tree (cdr tree))))
        (else (square tree))))

(let ((tree (list 1
                  (list 2 (list 3 4) 5)
                  (list 6 7))))
  (prn
   (str "square-tree:")
   (str "  Tree: " tree)
   (str "  Expected: (1 (4 (9 16) 25) (36 49))")
   (str "  Got:      " (square-tree tree))))

(--end-- "2.30")

;   ========================================================================
;   
;   Exercise 2.31
;   =============
;   
;   Abstract your answer to exercise [2.30] to produce a procedure tree-map
;   with the property that square-tree could be defined as
;   
;   (define (square-tree tree) (tree-map square tree))
;   
;   ------------------------------------------------------------------------
;   [Exercise 2.31]: http://sicp-book.com/book-Z-H-15.html#%_thm_2.31
;   [Exercise 2.30]: http://sicp-book.com/book-Z-H-15.html#%_thm_2.30
;   2.2.2 Hierarchical Structures - p113
;   ------------------------------------------------------------------------

(-start- "2.31")

(define (tree-map func tree)
  (cond ((null? tree) null)
        ((pair? tree)
         (cons (tree-map func (car tree))
               (tree-map func (cdr tree))))
        (else (func tree))))

(let ((tree (list 1
                  (list 2 (list 3 4) 5)
                  (list 6 7))))
  (prn
   (str "tree-map:")
   (str "  Tree: " tree)
   (str "  Expected: (1 (4 (9 16) 25) (36 49))")
   (str "  Got:      " (tree-map square tree))))

(--end-- "2.31")

;   ========================================================================
;   
;   Exercise 2.32
;   =============
;   
;   We can represent a set as a list of distinct elements, and we can
;   represent the set of all subsets of the set as a list of lists.  For
;   example, if the set is (1 2 3), then the set of all subsets is (() (3)
;   (2) (2 3) (1) (1 3) (1 2) (1 2 3)).  Complete the following definition
;   of a procedure that generates the set of subsets of a set and give a
;   clear explanation of why it works:
;   
;   (define (subsets s)
;     (if (null? s)
;         (list nil)
;         (let ((rest (subsets (cdr s))))
;           (append rest (map <??> rest)))))
;   
;   ------------------------------------------------------------------------
;   [Exercise 2.32]: http://sicp-book.com/book-Z-H-15.html#%_thm_2.32
;   2.2.2 Hierarchical Structures - p113
;   ------------------------------------------------------------------------

(-start- "2.32")

(define (subsets s)
  (if (null? s)
      (list null)
      (let ((rest (subsets (cdr s))))
        (append rest (map
                      (lambda (r) (cons (car s) r))
                      rest)))))

(let ((s (list 1 2 3)))
  (prn
   (str "subsets:")
   (str " set: " s)
   (str " expected: (() (3) (2) (2 3) (1) (1 3) (1 2) (1 2 3))")
   (str " got:      " (subsets s))))

(--end-- "2.32")

