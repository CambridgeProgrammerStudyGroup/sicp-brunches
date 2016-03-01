#lang racket

; 2.2.3  Sequences as Conventional Interfaces
; ===========================================

; https://mitpress.mit.edu/sicp/full-text/book/book-Z-H-15.html#%_sec_2.2.3

(require "exercises2.util.rkt")

;#########################################################################
;#########################################################################
(ti "Exercise 2.33")

; Exercise 2.33.  Fill in the missing expressions to complete the
; following definitions of some basic list-manipulation operations as
; accumulations:
; 
; (define (map p sequence)
;   (accumulate (lambda (x y) <??>) nil sequence))
; (define (append seq1 seq2)
;   (accumulate cons <??> <??>))
; (define (length sequence)
;   (accumulate <??> 0 sequence))

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
  
;#########################################################################
;#########################################################################

(ti "Exercise 2.34")

; Exercise 2.34.  Evaluating a polynomial in x at a given value of x can
; be formulated as an accumulation. We evaluate the polynomial
; 
; 
; using a well-known algorithm called Horner's rule, which structures the
; computation as
; 
; 
; In other words, we start with an, multiply by x, add an-1, multiply by
; x, and so on, until we reach a0.16 Fill in the following template to
; produce a procedure that evaluates a polynomial using Horner's rule.
; Assume that the coefficients of the polynomial are arranged in a
; sequence, from a0 through an.
; 
; (define (horner-eval x coefficient-sequence)
;   (accumulate (lambda (this-coeff higher-terms) <??>)
;               0
;               coefficient-sequence))
; 
; For example, to compute 1 + 3x + 5x3 + x5 at x = 2 you would evaluate
; 
; (horner-eval 2 (list 1 3 0 5 0 1))


(define (horner-eval x coefficient-sequence)
  (accumulate (lambda (this-coeff higher-terms)
                (+ this-coeff (* x higher-terms)))
              0
              coefficient-sequence))

(prn
 (str "1 + 3.2 + 5.2^3 + 2^5: "
      (horner-eval 2 (list 1 3 0 5 0 1))))

;#########################################################################
;#########################################################################

(ti "Excercise 2.35")

; Exercise 2.35.  Redefine count-leaves from section 2.2.2 as an
; accumulation:

; (define (count-leaves t)
;   (accumulate <??> <??> (map <??> <??>)))

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

;#########################################################################
;#########################################################################

(ti "Exercise 2.36")

; Exercise 2.36.  The procedure accumulate-n is similar to accumulate
; except that it takes as its third argument a sequence of sequences,
; which are all assumed to have the same number of elements. It applies
; the designated accumulation procedure to combine all the first elements
; of the sequences, all the second elements of the sequences, and so on,
; and returns a sequence of the results. For instance, if s is a sequence
; containing four sequences, ((1 2 3) (4 5 6) (7 8 9) (10 11 12)), then
; the value of (accumulate-n + 0 s) should be the sequence (22 26 30).
; Fill in the missing expressions in the following definition of
; accumulate-n:
;  
; (define (accumulate-n op init seqs)
;   (if (null? (car seqs))
;       nil
;       (cons (accumulate op init <??>)
;             (accumulate-n op init <??>))))

(define (accumulate-n op init seqs)
  (if (null? (car seqs))
      null
      (cons (accumulate op init (map car seqs))
            (accumulate-n op init (map cdr seqs)))))

(let ((v (list (list 1 2 3) (list 4 5 6) (list 7 8 9) (list 10 11 12))))
  (prn
   (str "v: " v)
   (str "accumulate-n v: " (accumulate-n + 0 v))))
    

;#########################################################################
;#########################################################################

(ti "Excercise 2.37")

; Exercise 2.37.  Suppose we represent vectors v = (vi) as sequences of
; numbers, and matrices m = (mij) as sequences of vectors (the rows of the
; matrix). For example, the matrix
; 
;   |1 2 3 4| 
;   |4 5 6 6| 
;   |6 7 8 9| 
;
; is represented as the sequence ((1 2 3 4) (4 5 6 6) (6 7 8 9)). With
; this representation, we can use sequence operations to concisely express
; the basic matrix and vector operations. These operations (which are
; described in any book on matrix algebra) are the following:
;
; (dot-product v w)       scalar of sum of products of numbers
; (matrix-*-vecotor m v)  vector of lenght k
; (matrix-*-matrix m v)   matrix of k, j
; (transpose m)           matrix of k, l
; 
; [where v has len l, and matrix is l x k];
;
; We can define the dot product as
; 
; (define (dot-product v w)
;   (accumulate + 0 (map * v w)))
; 
; Fill in the missing expressions in the following procedures for
; computing the other matrix operations. (The procedure accumulate-n is
; defined in exercise 2.36.)
; 
; (define (matrix-*-vector m v)
;   (map <??> m))
; (define (transpose mat)
;   (accumulate-n <??> <??> mat))
; (define (matrix-*-matrix m n)
;   (let ((cols (transpose n)))
;     (map <??> m)))
;;;;

; Hmmm the map we've defined so far only takes 2 args but in the
; question it's used with 3, like the built-in map, so creating
; a map-n that can take 3 or more args.

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

;#########################################################################
;#########################################################################

(ti "Exercise 2.38")

; Exercise 2.38.  The accumulate procedure is also known as fold-right,
; because it combines the first element of the sequence with the result of
; combining all the elements to the right. There is also a fold-left,
; which is similar to fold-right, except that it combines elements working
; in the opposite direction:
; 
; (define (fold-left op initial sequence)
;   (define (iter result rest)
;     (if (null? rest)
;         result
;         (iter (op result (car rest))
;               (cdr rest))))
;   (iter initial sequence))
; 
; What are the values of
; 
; (fold-right / 1 (list 1 2 3))
; (fold-left / 1 (list 1 2 3))
; (fold-right list nil (list 1 2 3))
; (fold-left list nil (list 1 2 3))
; 
; Give a property that op should satisfy to guarantee that fold-right and
; fold-left will produce the same values for any sequence.

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
 (str "Or learn my left from right."))

;#########################################################################
;#########################################################################

(ti "Exercise 2.39")

; Exercise 2.39.   Complete the following definitions of reverse (exercise
; 2.18) in terms of fold-right and fold-left from exercise 2.38:
; 
; (define (reverse sequence)
;   (fold-right (lambda (x y) <??>) nil sequence))
; (define (reverse sequence)
;   (fold-left (lambda (x y) <??>) nil sequence))

(define (reverse-l sequence)
  (fold-right (lambda (x y)
                (append y (list x)))
              '() sequence))

(define (reverse-r sequence)
  (fold-left (lambda (x y)
               (cons y x))
             '() sequence))

(let ((items '(1 4 9 16 25)))
  (prn
   (str "items:              " items)
   (str "reverse left fold:  " (reverse-l items))
   (str "reverse right fold: " (reverse-r items))))

;#########################################################################
;#########################################################################

(ti "Exercise 2.40")

; Exercise 2.40.  Define a procedure unique-pairs that, given an integer
; n, generates the sequence of pairs (i,j) with 1< j< i< n. Use unique-
; pairs to simplify the definition of prime-sum-pairs given above.


