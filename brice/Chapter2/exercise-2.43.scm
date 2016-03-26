#lang racket
(require "../utils.scm")
(require "../meta.scm")

(title "Exercise 2.43")

; Exercise 2.43.  Louis Reasoner is having a terrible time doing 
; exercise 2.42. His queens procedure seems to work, but it runs 
; extremely slowly. (Louis never does manage to wait long enough 
; for it to solve even the 6× 6 case.) When Louis asks Eva Lu Ator 
; for help, she points out that he has interchanged the order of 
; the nested mappings in the flatmap, writing it as
;
;     (flatmap
;         (lambda (new-row)
;             (map (lambda (rest-of-queens)
;                   (adjoin-position new-row k rest-of-queens))
;                 (queen-cols (- k 1))))
;         (enumerate-interval 1 board-size))
; 
; Explain why this interchange makes the program run slowly. 
; Estimate how long it will take Louis's program to solve the 
; eight-queens puzzle, assuming that the program in exercise 
; 2.42 solves the puzzle in time T.

(prn "Q: Why do the changes make the procedure run more slowly?

Louis's solution calls the `queen-cols` procedure inside the inner map.
This means that instead of being called once per column, the procedure
will in fact be called once per position on the board. Since this 
procedure is recursive the entire solution is therefore tree-recursive. 
This greatly increases the number of function calls needed to complete 
the solutions list and therefore takes a lot more time.

Q: Given that the previous solution takes time T, how long will this one take?

If the linear-recursive solution takes time T, then the tree-recursive
solution will take time T^(board-size).")