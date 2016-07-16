#lang racket

; Section 2.2.3: Sequences as Conventional Interfaces

(require "common.rkt")

;   Exercise 2.33
;   =============
;   
;   Fill in the missing expressions to complete the following definitions of
;   some basic list-manipulation operations as accumulations:
;   
;   (define (map p sequence)
;     (accumulate (lambda (x y) <??>) nil sequence))
;   (define (append seq1 seq2)
;     (accumulate cons <??> <??>))
;   (define (length sequence)
;     (accumulate <??> 0 sequence))
;   
;   ------------------------------------------------------------------------
;   [Exercise 2.33]: http://sicp-book.com/book-Z-H-15.html#%_thm_2.33
;   2.2.3 Sequences as Conventional Interfaces - p119
;   ------------------------------------------------------------------------

(-start- "2.33")

(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

(define (map p sequence)
  (accumulate (lambda (x y) (cons (p x) y)) null sequence))

 (define (append seq1 seq2)
   (accumulate cons seq2 seq1))

 (define (length sequence)
   (accumulate (lambda (item length) (+ 1 length)) 0 sequence))

(let ((items (list 1 2 3 4))
      (items2 (list 5 6 7 8))
      (square (lambda (n) (* n n))))
  (prn
   (str "items:      " items)
   (str "map square: " (map square items))
   (str "append:     " (append items items2))
   (str "length:     " (length items))))

(--end-- "2.33")

;   ========================================================================
;   
;   Exercise 2.34
;   =============
;   
;   Evaluating a polynomial in x at a given value of x can be formulated as
;   an accumulation.  We evaluate the polynomial
;   
;   a xⁿ + a   xⁿ⁻¹ + ··· + a₁x + a₀
;    ⁿ      ⁿ⁻¹ 
;   
;   using a well-known algorithm called Horner's rule, which structures the
;   computation as
;   
;   (···(a x + a   )x + ··· + a₁)x + a₀
;         ⁿ     ⁿ⁻¹
;   
;   In other words, we start with a_(n), multiply by x, add a_(n-1),
;   multiply by x, and so on, until we reach a₀.⁽¹⁶⁾ Fill in the following
;   template to produce a procedure that evaluates a polynomial using
;   Horner's rule. Assume that the coefficients of the polynomial are
;   arranged in a sequence, from a₀ through a_(n).
;   
;   (define (horner-eval x coefficient-sequence)
;     (accumulate (lambda (this-coeff higher-terms) <??>)
;                 0
;                 coefficient-sequence))
;   
;   For example, to compute 1 + 3x + 5x³ + x⁵ at x = 2 you would evaluate
;   
;   (horner-eval 2 (list 1 3 0 5 0 1))
;   
;   ------------------------------------------------------------------------
;   [Exercise 2.34]: http://sicp-book.com/book-Z-H-15.html#%_thm_2.34
;   [Footnote 16]:   http://sicp-book.com/book-Z-H-15.html#footnote_Temp_186
;   2.2.3 Sequences as Conventional Interfaces - p119
;   ------------------------------------------------------------------------

(-start- "2.34")

(define (horner-eval x coefficient-sequence)
  (accumulate (lambda (this-coeff higher-terms)
                (+ this-coeff (* x higher-terms)))
              0
              coefficient-sequence))

(prn
 (str "1 + 3.2 + 5.2^3 + 2^5: "
      (horner-eval 2 (list 1 3 0 5 0 1))))

(--end-- "2.34")

;   ========================================================================
;   
;   Exercise 2.35
;   =============
;   
;   Redefine count-leaves from section [2.2.2] as an accumulation:
;   
;   (define (count-leaves t)
;     (accumulate <??> <??> (map <??> <??>)))
;   
;   ------------------------------------------------------------------------
;   [Exercise 2.35]: http://sicp-book.com/book-Z-H-15.html#%_thm_2.35
;   [Section 2.2.2]: http://sicp-book.com/book-Z-H-15.html#%_sec_2.2.2
;   2.2.3 Sequences as Conventional Interfaces - p120
;   ------------------------------------------------------------------------

(-start- "2.35")

(define (count-leaves t)
  (accumulate
   +
   0
   (map
    (lambda (item)
      (if (pair? item) (count-leaves item) 1))
    t)))

(let
    ((tree (list (list 1 2) (list 1 2 3) 1)))
  (prn
   (str "tree: " tree)
   (str "leaf count: " (count-leaves tree))))

(--end-- "2.35")

;   ========================================================================
;   
;   Exercise 2.36
;   =============
;   
;   The procedure accumulate-n is similar to accumulate except that it takes
;   as its third argument a sequence of sequences, which are all assumed to
;   have the same number of elements.  It applies the designated
;   accumulation procedure to combine all the first elements of the
;   sequences, all the second elements of the sequences, and so on, and
;   returns a sequence of the results.  For instance, if s is a sequence
;   containing four sequences, ((1 2 3) (4 5 6) (7 8 9) (10 11 12)), then
;   the value of (accumulate-n + 0 s) should be the sequence (22 26 30). 
;   Fill in the missing expressions in the following definition of
;   accumulate-n:
;   
;   (define (accumulate-n op init seqs)
;     (if (null? (car seqs))
;         nil
;         (cons (accumulate op init <??>)
;               (accumulate-n op init <??>))))
;   
;   ------------------------------------------------------------------------
;   [Exercise 2.36]: http://sicp-book.com/book-Z-H-15.html#%_thm_2.36
;   2.2.3 Sequences as Conventional Interfaces - p120
;   ------------------------------------------------------------------------

(-start- "2.36")

(define (accumulate-n op init seqs)
  (if (null? (car seqs))
      null
      (cons (accumulate op init (map car seqs))
            (accumulate-n op init (map cdr seqs)))))

(let ((v (list (list 1 2 3) (list 4 5 6) (list 7 8 9) (list 10 11 12))))
  (prn
   (str "v: " v)
   (str "accumulate-n v: " (accumulate-n + 0 v))))

(--end-- "2.36")

;   ========================================================================
;   
;   Exercise 2.37
;   =============
;   
;   Suppose we represent vectors v = (vᵢ) as sequences of numbers, and
;   matrices m = (m_(ij)) as sequences of vectors (the rows of the matrix).
;   For example, the matrix
;   
;   │1 2 3 4│
;   │4 5 6 6│
;   │6 7 8 9│
;   
;   is represented as the sequence ((1 2 3 4) (4 5 6 6) (6 7 8 9)). With
;   this representation, we can use sequence operations to concisely express
;   the basic matrix and vector operations.  These operations (which are
;   described in any book on matrix algebra) are the following:
;   
;   (dot-product v w)       returns the sum ∑ᵢ vᵢwᵢ
;   
;   (matrix-*-vector m v)   returns the vector t, where t  = ∑ m  v
;                                                        i    J ij j
;   
;   (matrix-*-matrix m n)   returns the matrix p, where p  = ∑ m  n
;                                                        ij   k ik kj
;   
;   (transpose m)           returns the matrix n, where n   = m
;                                                        ij    ji
;   
;   We can define the dot product as⁽¹⁷⁾
;   
;   (define (dot-product v w)
;     (accumulate + 0 (map * v w)))
;   
;   Fill in the missing expressions in the following procedures for
;   computing the other matrix operations.  (The procedure accumulate-n is
;   defined in exercise [2.36].)
;   
;   (define (matrix-*-vector m v)
;     (map <??> m))
;   (define (transpose mat)
;     (accumulate-n <??> <??> mat))
;   (define (matrix-*-matrix m n)
;     (let ((cols (transpose n)))
;       (map <??> m)))
;   
;   ------------------------------------------------------------------------
;   [Exercise 2.37]: http://sicp-book.com/book-Z-H-15.html#%_thm_2.37
;   [Exercise 2.36]: http://sicp-book.com/book-Z-H-15.html#%_thm_2.36
;   [Footnote 17]:   http://sicp-book.com/book-Z-H-15.html#footnote_Temp_190
;   2.2.3 Sequences as Conventional Interfaces - p120
;   ------------------------------------------------------------------------

(-start- "2.37")

(define (map-n proc . lists)
  (map (lambda (heads) (apply proc heads))
       (accumulate-n (lambda (heads acc)
                  (cons heads acc))
                null
                lists)))
; Dot Product
; ===========
(define (dot-product v w)
  (accumulate + 0 (map-n * v w)))

; Example: http://mathinsight.org/dot_product_examples

(let ((v '(1 2 3))
      (w '(4 -5 6)))
  (prn
   (str)
   (str "Dot Product:")
   (str "============")
   (str "v: " v)
   (str "w: " w)
   (str "dot-product v w:")
   (str "  expected: " 12)
   (str "  actual:   " (dot-product v w))))

; Matrix * Vector
; ===============
(define (matrix-*-vector m v)
  (map-n (lambda (col)
           (dot-product col v))
         m))

; Example: http://mathinsight.org/matrix_vector_multiplication_examples

(let (
      (x '(-2 1 0))
      (A (list
          '(1 2 3)
          '(4 5 6)
          '(7 8 9)
          '(10 11 12))))
  (prn
   (str)
   (str "Matrix * Vector:")
   (str "================")
   (str "A: " A)
   (str "x: " x)
   (str "matrix-*-vector A x")
   (str "  expected: (0 -3 -6 -9)")
   (str "  actual:   " (matrix-*-vector A x))))

; Transpose
; =========

(define (transpose mat)
  (accumulate-n cons '() mat))

; Example: http://mathinsight.org/matrix_transpose

(let (
      (A (list
          '(1 2 3)
          '(4 5 6))))
  (prn
   (str)
   (str "Transpose")
   (str "=========")
   (str "A: " A)
   (str "transpose A:")
   (str "  expected: " (list '(1 4) '(2 5) '(3 6)))
   (str "  actual:   " (transpose A))))

; Matrix * Matrix
; ===============

(define (matrix-*-matrix m n)
  (let ((cols (transpose n)))
    (map (lambda (col)
       (map (lambda (row)
          (dot-product row col))
        cols))
     m)))

; Example http://mathinsight.org/matrix_vector_multiplication_examples (Example 3)

(let (
      (B (list
          '(1 2 3)
          '(4 5 6)))
      (C (list
          '(1 2)
          '(3 4)
          '(5 6))))
  (prn
   (str)
   (str "Matrix * Matrix")
   (str "===============")
   (str "B: " B)
   (str "C: " C)
   (str "matrix-*-matrix B C:")
   (str "  expected: " (list '(22 28) '(49 64)))
   (str "  actual:   " (matrix-*-matrix B C))))

(--end-- "2.37")

;   ========================================================================
;   
;   Exercise 2.38
;   =============
;   
;   The accumulate procedure is also known as fold-right, because it
;   combines the first element of the sequence with the result of combining
;   all the elements to the right.  There is also a fold-left, which is
;   similar to fold-right, except that it combines elements working in the
;   opposite direction:
;   
;   (define (fold-left op initial sequence)
;     (define (iter result rest)
;       (if (null? rest)
;           result
;           (iter (op result (car rest))
;                 (cdr rest))))
;     (iter initial sequence))
;   
;   What are the values of
;   
;   (fold-right / 1 (list 1 2 3))
;   (fold-left / 1 (list 1 2 3))
;   (fold-right list nil (list 1 2 3))
;   (fold-left list nil (list 1 2 3))
;   
;   Give a property that op should satisfy to guarantee that fold-right and
;   fold-left will produce the same values for any sequence.
;   
;   ------------------------------------------------------------------------
;   [Exercise 2.38]: http://sicp-book.com/book-Z-H-15.html#%_thm_2.38
;   2.2.3 Sequences as Conventional Interfaces - p121
;   ------------------------------------------------------------------------

(-start- "2.38")

(prn
 (str "Guess:")
 (str "  (fold-right / 1 (list 1 2 3)):      1/6")
 (str "  (fold-left / 1 (list 1 2 3)):       1 1/2")
 (str "  (fold-right list nil (list 1 2 3)): (((1) 2) 3)")
 (str "  (fold-left list nil (list 1 2 3)) : (1 (2 (3)))"))

(define fold-right accumulate)

(define (fold-left op initial sequence)
  (define (iter result rest)
    (if (null? rest)
        result
        (iter (op result (car rest))
              (cdr rest))))
  (iter initial sequence))

(prn
 (str)
 (str "Actual")
 (str "  (fold-right / 1 (list 1 2 3)):      " (fold-right / 1 (list 1 2 3)))
 (str "  (fold-left / 1 (list 1 2 3)):       " (fold-left / 1 (list 1 2 3)))
 (str "  (fold-right list nil (list 1 2 3)): " (fold-right list '() (list 1 2 3)))
 (str "  (fold-left list nil (list 1 2 3)) : " (fold-left list '() (list 1 2 3))))

(prn
 (str)
 (str "Yea!  I got 4 out of 0 right!  Maybe I should think instaead of guessing.")
 (str "Or learn my left from right. (I can never rember if fold-left starts on")
 (str "the left and travels right or travels left having started on the right.)"))


(--end-- "2.38")

;   ========================================================================
;   
;   Exercise 2.39
;   =============
;   
;   Complete the following definitions of reverse (exercise [2.18]) in terms
;   of fold-right and fold-left from exercise [2.38]:
;   
;   (define (reverse sequence)
;     (fold-right (lambda (x y) <??>) nil sequence))
;   (define (reverse sequence)
;     (fold-left (lambda (x y) <??>) nil sequence))
;   
;   ------------------------------------------------------------------------
;   [Exercise 2.39]: http://sicp-book.com/book-Z-H-15.html#%_thm_2.39
;   [Exercise 2.18]: http://sicp-book.com/book-Z-H-15.html#%_thm_2.18
;   [Exercise 2.38]: http://sicp-book.com/book-Z-H-15.html#%_thm_2.38
;   2.2.3 Sequences as Conventional Interfaces - p122
;   ------------------------------------------------------------------------

(-start- "2.39")

(define (reverse-r sequence)
  (fold-right (lambda (x y)
                (append y (list x)))
              '() sequence))

(define (reverse-l sequence)
  (fold-left (lambda (x y)
               (cons y x))
             '() sequence))

(let ((items '(1 4 9 16 25)))
  (prn
   (str "items:              " items)
   (str "reverse left fold:  " (reverse-l items))
   (str "reverse right fold: " (reverse-r items))))

(--end-- "2.39")

;   ========================================================================
;   
;   Exercise 2.40
;   =============
;   
;   Define a procedure unique-pairs that, given an integer n, generates the
;   sequence of pairs (i,j) with 1≤ j< i≤ n.  Use unique-pairs to simplify
;   the definition of prime-sum-pairs given above.
;   
;   ------------------------------------------------------------------------
;   [Exercise 2.40]: http://sicp-book.com/book-Z-H-15.html#%_thm_2.40
;   2.2.3 Sequences as Conventional Interfaces - p124
;   ------------------------------------------------------------------------

(-start- "2.40")

(define (prime? n)
  (define (divides? a b)
    (= 0 (remainder b a)))
  (define (next d)
    (if (= d 2)
        3
        (+ d 2)))
  (define (find-factor f)
    (cond 
      ((> (* f f) n) n)
      ((divides? f n) f)
      (else (find-factor (next f)))))
  (= n (find-factor 2)))

(define (enumerate-range start end-ex)
  (if (< start end-ex)
      (cons start (enumerate-range (+ start 1) end-ex))
      '()))

(define (flatmap proc seq)
  (accumulate append '() (map proc seq)))

(define (unique-pairs start end)
  (flatmap
   (lambda (second)
     (map (lambda (first)
            (list first second))
          (enumerate-range start second)))
   (enumerate-range start (+ end 1))))

(define (prime-sum-pairs end)
  (filter
   (lambda (pair)
     (prime? (+ (car pair) (car (cdr pair)))))
   (unique-pairs 1 end)))
        

(let* ((start 1)
       (end 10)
       (pairs (unique-pairs start end))
       (prime-pairs (prime-sum-pairs end)))  
  (prn
   (str "Start: " start)
   (str "End:   " end)
   (str)
   (str "Unique Pairs:    ")
   (str pairs)
   (str)
   (str "Prime Sum Pairs: ")
   (str (apply str 
        (map (lambda (pair)
               (let ((first (car pair)) (second (car (cdr pair))))
                 (str first "+" second "=" (+ first second) ", ")))
             prime-pairs)))))

(--end-- "2.40")

;   ========================================================================
;   
;   Exercise 2.41
;   =============
;   
;   Write a procedure to find all ordered triples of distinct positive
;   integers i, j, and k less than or equal to a given integer n that sum to
;   a given integer s.
;   
;   ------------------------------------------------------------------------
;   [Exercise 2.41]: http://sicp-book.com/book-Z-H-15.html#%_thm_2.41
;   2.2.3 Sequences as Conventional Interfaces - p124
;   ------------------------------------------------------------------------

(-start- "2.41")

(define (unique-triples start end)
  (flatmap
   (lambda (right-pair)
     (map (lambda (first)
            (cons first right-pair))
          (enumerate-range start (car right-pair))))
   (unique-pairs start end)))

(let
    ((start 1)
     (end 5))
  (prn
   (str "start: " start)
   (str "end:   " end)
   (str "unique-triples: ")
   (str (unique-triples start end))))

(--end-- "2.41")

;   ========================================================================
;   
;   Exercise 2.42
;   =============
;   
;   Figure:
;   
;    _ _ _ _ _ _ _ _
;   |_|_|_|_|_|Q|_|_|
;   |_|_|Q|_|_|_|_|_|
;   |Q|_|_|_|_|_|_|_|
;   |_|_|_|_|_|_|Q|_|
;   |_|_|_|_|Q|_|_|_|
;   |_|_|_|_|_|_|_|Q|
;   |_|Q|_|_|_|_|_|_|
;   |_|_|_|Q|_|_|_|_|
;   
;   Figure 2.8: A solution to the eight-queens puzzle.
;   
;   The "eight-queens puzzle" asks how to place eight queens on a chessboard
;   so that no queen is in check from any other (i.e., no two queens are in
;   the same row, column, or diagonal).  One possible solution is shown in
;   figure [2.8].  One way to solve the puzzle is to work across the board,
;   placing a queen in each column. Once we have placed k - 1 queens, we
;   must place the kth queen in a position where it does not check any of
;   the queens already on the board.  We can formulate this approach
;   recursively: Assume that we have already generated the sequence of all
;   possible ways to place k - 1 queens in the first k - 1 columns of the
;   board.  For each of these ways, generate an extended set of positions by
;   placing a queen in each row of the kth column.  Now filter these,
;   keeping only the positions for which the queen in the kth column is safe
;   with respect to the other queens.  This produces the sequence of all
;   ways to place k queens in the first k columns.  By continuing this
;   process, we will produce not only one solution, but all solutions to the
;   puzzle.
;   
;   We implement this solution as a procedure queens, which returns a
;   sequence of all solutions to the problem of placing n queens on an
;   n&times; n chessboard.  Queens has an internal procedure queen-cols that
;   returns the sequence of all ways to place queens in the first k columns
;   of the board.
;   
;   (define (queens board-size)
;     (define (queen-cols k)  
;       (if (= k 0)
;           (list empty-board)
;           (filter
;            (lambda (positions) (safe? k positions))
;            (flatmap
;             (lambda (rest-of-queens)
;               (map (lambda (new-row)
;                      (adjoin-position new-row k rest-of-queens))
;                    (enumerate-interval 1 board-size)))
;             (queen-cols (- k 1))))))
;     (queen-cols board-size))
;   
;   In this procedure rest-of-queens is a way to place k - 1 queens in the
;   first k - 1 columns, and new-row is a proposed row in which to place the
;   queen for the kth column.  Complete the program by implementing the
;   representation for sets of board positions, including the procedure
;   adjoin-position, which adjoins a new row-column position to a set of
;   positions, and empty-board, which represents an empty set of positions. 
;   You must also write the procedure safe?, which determines for a set of
;   positions, whether the queen in the kth column is safe with respect to
;   the others.  (Note that we need only check whether the new queen is safe
;   -- the other queens are already guaranteed safe with respect to each
;   other.)
;   
;   ------------------------------------------------------------------------
;   [Exercise 2.42]: http://sicp-book.com/book-Z-H-15.html#%_thm_2.42
;   [Figure 2.8]:    http://sicp-book.com/book-Z-H-15.html#%_fig_2.8
;   2.2.3 Sequences as Conventional Interfaces - p124
;   ------------------------------------------------------------------------

(-start- "2.42")

(define empty-board '())

(define (adjoin-position new-row col rest-of-queens)
  (cons (list col new-row) rest-of-queens))

(define (enumerate-interval start end)
  (enumerate-range start (+ end 1)))

(define (safe? k positions)

  (define (col p) (car p))
  (define (row p) (car (cdr p)))
  
  (define (in-check? existing)
    (or
     (= (row new) (row existing))
     (= (row new) (+ (row existing) (- k (col existing))))
     (= (row new) (- (row existing) (- k (col existing))))))
     
  (define new (car positions))
  
  (accumulate
   (lambda (existing still-safe)
     (and
      still-safe
      (not (in-check? existing))))
   #true
   (cdr positions)))

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
  (map reverse-l (queen-cols board-size)))

(let* ((board-size 8)
      (expected-solution-count 92) ; https://en.wikipedia.org/wiki/Eight_queens_puzzle
      (book-example-solution
       (list `(1 6) `(2 2) `(3 7) `(4 1) `(5 4) `(6 8) `(7 5) `(8 3)))
      (solutions (queens board-size))
      (index-of (lambda (item list)
                  (define (iter item list index)
                    (if (equal? item (car list))
                        index
                        (iter item (cdr list) (+ index 1))))
                  (iter item list 0))))
  (prn
   (str "board size: " board-size)
   (str "expected solution count: " expected-solution-count)
   (str "actual solution count:   " (length solutions))
   (str "example solution: " book-example-solution)
   (str "index of example: " (index-of book-example-solution solutions))))

(--end-- "2.42")

;   ========================================================================
;   
;   Exercise 2.43
;   =============
;   
;   Louis Reasoner is having a terrible time doing exercise [2.42].  His
;   queens procedure seems to work, but it runs extremely slowly. (Louis
;   never does manage to wait long enough for it to solve even the 6&times;
;   6 case.) When Louis asks Eva Lu Ator for help, she points out that he
;   has interchanged the order of the nested mappings in the flatmap,
;   writing it as
;   
;   (flatmap
;    (lambda (new-row)
;      (map (lambda (rest-of-queens)
;             (adjoin-position new-row k rest-of-queens))
;           (queen-cols (- k 1))))
;    (enumerate-interval 1 board-size))
;   
;   Explain why this interchange makes the program run slowly.  Estimate how
;   long it will take Louis's program to solve the eight-queens puzzle,
;   assuming that the program in exercise [2.42] solves the puzzle in time
;   T.
;   
;   ------------------------------------------------------------------------
;   [Exercise 2.43]: http://sicp-book.com/book-Z-H-15.html#%_thm_2.43
;   [Exercise 2.42]: http://sicp-book.com/book-Z-H-15.html#%_thm_2.42
;   2.2.3 Sequences as Conventional Interfaces - p126
;   ------------------------------------------------------------------------

(-start- "2.43")

(prn
 (str "This time Brother Louis's problem is that 'enumerate-interval' is inside")
 (str "the filter expression. This means no filtering takes place until every ")
 (str "permutation good and bad has been enumerated.  I.e. 8^8 (" (expt 8 8) ")")
 (str "permutations.  Filtering is probably much less efficient too because it")
 (str "to check each queen against all the preceeding queens (not just the 'new'")
 (str "queen) and if it fails at the last check it has to start from scratch for")
 (str "the next permutation.")
 (str)
 (str "I can only guestimate that for 8x8 board the Louis's solution will take")
 (str "around 100,000 times longer. Our solution only has to check 92 full")
 (str "permutations vs 16M permutations.  We do have to check incomplete")
 (str "boards, but then Louis had a less efficient filter routine.")
 (str "")
 (str "(Looks like opions vary, a quick google sees guestimates of T^8 (!?),")
 (str " T.8^8 and T.8^7)")
 (str)
 (str "Perusing board sizes up to 13, I'd estimate the number of solutions")
 (str "increases by about 2.4 each time. This would suggest Louis is testing")
 (str "(n - 2.4) times more permutations then necessary. So perhaps n^(n - 2.4)")
 (str "is a rough general estimate, but this is (guess ^ lunch-time)."))

(--end-- "2.43")

