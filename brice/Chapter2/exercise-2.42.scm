#lang racket
(require "../utils.scm")
(require "../meta.scm")
(require (only-in srfi/1 iota))

(title "Exercise 2.42")


; Exercise 2.42: The “eight-queens puzzle” asks how to place eight queens 
; on a chessboard so that no queen is in check from any other (i.e., no 
; two queens are in the same row, column, or diagonal). One possible solution 
; is shown in Figure 2.8. One way to solve the puzzle is to work across the 
; board, placing a queen in each column. Once we have placed k − 1 queens, 
; we must place the kth queen in a position where it does not check any of 
; the queens already on the board. We can formulate this approach recursively: 
; Assume that we have already generated the sequence of all possible ways to 
; place k − 1 queens in the first k − 1 columns of the board. For each of 
; these ways, generate an extended set of positions by placing a queen in 
; each row of the kth column. Now filter these, keeping only the positions 
; for which the queen in the kth column is safe with respect to the other 
; queens. This produces the sequence of all ways to place k queens in the 
; first k columns. By continuing this process, we will produce not only one 
; solution, but all solutions to the puzzle.
; 
; We implement this solution as a procedure queens, which returns a sequence 
; of all solutions to the problem of placing n queens on an n × n chessboard. 
; queens has an internal procedure queen-cols that returns the sequence of all 
; ways to place queens in the first k columns of the board.

	; (define (queens board-size) 
	; 	(define (queen-cols k)
	; 		(if (= k 0)
	; 			(list empty-board) 
	; 			(filter
	; 				(lambda (positions) (safe? k positions)) 
	; 				(flatmap
	; 					(lambda (rest-of-queens) 
	; 						(map (lambda (new-row)
	; 				                 (adjoin-position new-row k rest-of-queens))
	; 				                 (enumerate-interval 1 board-size)))
	; 				          (queen-cols (- k 1))))))
	; 	  (queen-cols board-size))

; In this procedure rest-of-queens is a way to place k − 1 queens in the 
; first k − 1 columns, and new-row is a proposed row in which to place the 
; queen for the kth column. Complete the program by implementing the 
; representation for sets of board positions, including the procedure 
; adjoin-position, which adjoins a new row-column position to a set of 
; positions, and empty-board, which represents an empty set of positions. 
;
; You must also write the procedure safe?, which determines for a set of 
; positions, whether the queen in the kth column is safe with respect to 
; the others. 
;
; (Note that we need only check whether the new queen is safe. The other 
; queens are already guaranteed safe with respect to each other.)

(define empty-board '())

(define (row pos) (car pos))
(define (col pos) (cdr pos))
(define (mkpos r c) (cons r c))

(define (adjoin-position row column positions)
	(cons (mkpos row column) positions))

(define (threatened? A B)
	(cond 
		((equal? A B) #f) ; they're the same piece!
		((or (= (row A) (row B)) (= (col A) (col B))) #t)
		((= (abs (- (row A) (row B))) (abs (- (col A) (col B)))) #t)
		(else #f)))

(define logging-threatened? (inspect threatened?))

(define (threatened-by-any? pos positions)
	(any? identity 
		(map 
			(lambda (x) (threatened? pos x))
			positions)))

(define (correct-solution? positions)
		(not (any? identity
			(map 
				(lambda (p) (threatened-by-any? p positions))
				positions)))
		)

(define (safe? k positions)
	(correct-solution? positions))


(define (queens board-size) 
	(define (queen-cols k)
		(if (= k 0)
			(list empty-board) 
			(filter
				(lambda (positions) (safe? k positions)) 
				(flatmap
					(lambda (rest-of-queens) 
						(map (lambda (new-row)
				                 (adjoin-position new-row k rest-of-queens))
				                 (enumerate-interval 1 board-size)))
				          (queen-cols (- k 1))))))
	  (queen-cols board-size))

(define (contains? l i)
  (if (empty? l) #f
      (or (equal? (first l) i) (contains? (rest l) i))))

(define (showboard board k)
	(let* (
		(xs (iota k 0))
		(ys (iota k 0)))
		(for-each (lambda (y)
			(begin 
				(for-each (lambda (x) 
					(if (contains? board (mkpos x y))
							(display "Q")
							(display "."))) xs)
				(display "\n"))) ys)))			

(let* 
	(
		(A (mkpos 3 5))
		(B (mkpos 3 7))
		(C (mkpos 4 7))
		(D (mkpos 1 1))
		(E (mkpos 4 4))
		(board-hostile (list A B C D E))
		(board-imcomplete (list A C))
		(board-correct (list 
			(mkpos 2 0)
			(mkpos 6 1)
			(mkpos 1 2)
			(mkpos 7 3)
			(mkpos 4 4)
			(mkpos 0 5)
			(mkpos 3 6)
			(mkpos 5 7)
		))
	)
	(assert "Two queens on the same row threaten each other"
		(and (threatened? A B) (threatened? B A)))
	(assert "Two queens in the same column threaten each other"
		(and (threatened? B C) (threatened? C B)))
	(assert "A queen cannot threaten itself"
		(not (threatened? A A)))
	(assert "Two queens diagonal to each other are threatened"
		(and (threatened? D E) (threatened? E D)))
	(assert "We can detect an inccorect solution"
		(not (correct-solution? board-hostile)))
	(assert "We can detect a correct solution"
		(correct-solution? board-correct))
	(assert "We can correctly find all 92 solutions to the 8 queens puzzle."
		(= 92 (length (queens 8))))
)
