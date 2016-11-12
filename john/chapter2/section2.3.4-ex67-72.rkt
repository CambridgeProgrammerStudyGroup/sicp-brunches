#lang racket

; Section 2.3.4: Example: Huffman Encoding Trees

(require "common.rkt")

;   Exercise 2.67
;   =============
;   
;   Define an encoding tree and a sample message:
;   
;   (define sample-tree
;     (make-code-tree (make-leaf 'A 4)
;                     (make-code-tree
;                      (make-leaf 'B 2)
;                      (make-code-tree (make-leaf 'D 1)
;                                      (make-leaf 'C 1)))))
;   
;   (define sample-message '(0 1 1 0 0 1 0 1 0 1 1 1 0))
;   
;   Use the decode procedure to decode the message, and give the result.
;   
;   ------------------------------------------------------------------------
;   [Exercise 2.67]: http://sicp-book.com/book-Z-H-16.html#%_thm_2.67
;   2.3.4 Example: Huffman Encoding Trees - p167
;   ------------------------------------------------------------------------

(-start- "2.67")

;; Code from book

(define (make-leaf symbol weight)
  (list 'leaf symbol weight))
(define (leaf? object)
  (eq? (car object) 'leaf))
(define (symbol-leaf x) (cadr x))
(define (weight-leaf x) (caddr x))

(define (make-code-tree left right)
  (list left
        right
        (append (symbols left) (symbols right))
        (+ (weight left) (weight right))))

(define (left-branch tree) (car tree))
(define (right-branch tree) (cadr tree))

(define (symbols tree)
  (if (leaf? tree)
      (list (symbol-leaf tree))
      (caddr tree)))

(define (weight tree)
  (if (leaf? tree)
      (weight-leaf tree)
      (cadddr tree)))

(define (adjoin-set x set)
  (cond ((null? set) (list x))
        ((< (weight x) (weight (car set))) (cons x set))
        (else (cons (car set)
                    (adjoin-set x (cdr set))))))

(define (make-leaf-set pairs)
  (if (null? pairs)
      '()
      (let ((pair (car pairs)))
        (adjoin-set (make-leaf (car pair)    ; symbol
                               (cadr pair))  ; frequency
                    (make-leaf-set (cdr pairs))))))

(define (decode bits tree)
  (define (decode-1 bits current-branch)
    (if (null? bits)
        '()
        (let ((next-branch
               (choose-branch (car bits) current-branch)))
          (if (leaf? next-branch)
              (cons (symbol-leaf next-branch)
                    (decode-1 (cdr bits) tree))
              (decode-1 (cdr bits) next-branch)))))
  (decode-1 bits tree))
(define (choose-branch bit branch)
  (cond ((= bit 0) (left-branch branch))
        ((= bit 1) (right-branch branch))
        (else (error "bad bit -- CHOOSE-BRANCH" bit))))


;; Create the tree

(define sample-tree
  (make-code-tree (make-leaf 'A 4)
                  (make-code-tree
                   (make-leaf 'B 2)
                   (make-code-tree (make-leaf 'D 1)
                                   (make-leaf 'C 1)))))

;; The message

(define sample-message '(0 1 1 0 0 1 0 1 0 1 1 1 0))

;; Decode the message

(prn "Decoding " sample-message "gives: " (decode sample-message sample-tree))

(--end-- "2.67")

;   ========================================================================
;   
;   Exercise 2.68
;   =============
;   
;   The encode procedure takes as arguments a message and a tree and
;   produces the list of bits that gives the encoded message.
;   
;   (define (encode message tree)
;     (if (null? message)
;         '()
;         (append (encode-symbol (car message) tree)
;                 (encode (cdr message) tree))))
;   
;   Encode-symbol is a procedure, which you must write, that returns the
;   list of bits that encodes a given symbol according to a given tree.  You
;   should design encode-symbol so that it signals an error if the symbol is
;   not in the tree at all.  Test your procedure by encoding the result you
;   obtained in exercise [2.67] with the sample tree and seeing whether it
;   is the same as the original sample message.
;   
;   ------------------------------------------------------------------------
;   [Exercise 2.68]: http://sicp-book.com/book-Z-H-16.html#%_thm_2.68
;   [Exercise 2.67]: http://sicp-book.com/book-Z-H-16.html#%_thm_2.67
;   2.3.4 Example: Huffman Encoding Trees - p167
;   ------------------------------------------------------------------------

(-start- "2.68")

;; Code from question
(define (encode message tree)
  (if (null? message)
      '()
      (append (encode-symbol (car message) tree)
              (encode (cdr message) tree))))

(define (contains tree symbol)
  (define (list-contains list)
    (cond ((empty? list) #false)
          ((equal? symbol (car list)) #true)
          (else list-contains (cdr list))))
  (if (leaf? tree)
      (equal? symbol (symbol-leaf tree))
      (list-contains (caddr tree))))

(define (encode-symbol symbol tree)
  (define (encode-symbol-1 tree bits)
    ;;(prn tree)
    (if (leaf? tree)        
        (reverse bits)
        (cond  ((contains (left-branch tree) symbol)
                (encode-symbol-1 (left-branch tree) (cons '0 bits)))
               ((contains (right-branch tree) symbol)
                (encode-symbol-1 (right-branch tree) (cons 1 bits)))
               (else (error "bad symbol -- ENCODE SYMBOL" symbol)))))
  (encode-symbol-1 tree '()))
;; Chapter 1 habits make me want to do a recursive version too!                

(present-compare encode
                 (list (list '(A D A B B C A) sample-tree) sample-message))

(--end-- "2.68")

;   ========================================================================
;   
;   Exercise 2.69
;   =============
;   
;   The following procedure takes as its argument a list of symbol-frequency
;   pairs (where no symbol appears in more than one pair) and generates a
;   Huffman encoding tree according to the Huffman algorithm.
;   
;   (define (generate-huffman-tree pairs)
;     (successive-merge (make-leaf-set pairs)))
;   
;   Make-leaf-set is the procedure given above that transforms the list of
;   pairs into an ordered set of leaves.  Successive-merge is the procedure
;   you must write, using make-code-tree to successively merge the
;   smallest-weight elements of the set until there is only one element
;   left, which is the desired Huffman tree.  (This procedure is slightly
;   tricky, but not really complicated.  If you find yourself designing a
;   complex procedure, then you are almost certainly doing something wrong. 
;   You can take significant advantage of the fact that we are using an
;   ordered set representation.)
;   
;   ------------------------------------------------------------------------
;   [Exercise 2.69]: http://sicp-book.com/book-Z-H-16.html#%_thm_2.69
;   2.3.4 Example: Huffman Encoding Trees - p168
;   ------------------------------------------------------------------------

(-start- "2.69")

(define (successive-merge node-set)
  (cond ((empty? node-set) '())
        ((= 1 (length node-set)) (car node-set))
        (else
         (let* ((fst (car node-set))
                (snd (cadr node-set))
                (new-tree (make-code-tree fst snd))) 
           (successive-merge (adjoin-set new-tree (cddr node-set)))))))

(define sample-pairs (list (list 'A 4) (list 'B 2) (list' C 1) (list 'D 1))) 

(define (generate-huffman-tree pairs)
  (successive-merge (make-leaf-set pairs)))

(define generated-tree (generate-huffman-tree sample-pairs))

(prn "Seeing if generated tree matches the sample tree.  (Although equivalent
trees need not be identical.")
(present-compare generate-huffman-tree
                 (list (list sample-pairs) sample-tree))


(--end-- "2.69")

;   ========================================================================
;   
;   Exercise 2.70
;   =============
;   
;   The following eight-symbol alphabet with associated relative frequencies
;   was designed to efficiently encode the lyrics of 1950s rock songs. 
;   (Note that the "symbols" of an "alphabet" need not be individual
;   letters.)
;   
;   A    2 NA  16
;   BOOM 1 SHA 3 
;   GET  2 YIP 9 
;   JOB  2 WAH 1 
;   
;   Use generate-huffman-tree (exercise [2.69]) to generate a corresponding
;   Huffman tree, and use encode (exercise [2.68]) to encode the following
;   message:
;   
;   Get a job
;   
;   Sha na na na na na na na na
;   
;   Get a job
;   
;   Sha na na na na na na na na
;   
;   Wah yip yip yip yip yip yip yip yip yip
;   
;   Sha boom
;   
;   How many bits are required for the encoding?  What is the smallest
;   number of bits that would be needed to encode this song if we used a
;   fixed-length code for the eight-symbol alphabet?
;   
;   ------------------------------------------------------------------------
;   [Exercise 2.70]: http://sicp-book.com/book-Z-H-16.html#%_thm_2.70
;   [Exercise 2.69]: http://sicp-book.com/book-Z-H-16.html#%_thm_2.69
;   [Exercise 2.68]: http://sicp-book.com/book-Z-H-16.html#%_thm_2.68
;   2.3.4 Example: Huffman Encoding Trees - p168
;   ------------------------------------------------------------------------

(-start- "2.70")



(--end-- "2.70")

;   ========================================================================
;   
;   Exercise 2.71
;   =============
;   
;   Suppose we have a Huffman tree for an alphabet of n symbols, and that
;   the relative frequencies of the symbols are 1, 2, 4, ..., 2ⁿ⁻¹.  Sketch
;   the tree for n=5; for n=10.  In such a tree (for general n) how many
;   bits are required to encode the most frequent symbol?  the least
;   frequent symbol?
;   
;   ------------------------------------------------------------------------
;   [Exercise 2.71]: http://sicp-book.com/book-Z-H-16.html#%_thm_2.71
;   2.3.4 Example: Huffman Encoding Trees - p168
;   ------------------------------------------------------------------------

(-start- "2.71")



(--end-- "2.71")

;   ========================================================================
;   
;   Exercise 2.72
;   =============
;   
;   Consider the encoding procedure that you designed in exercise [2.68]. 
;   What is the order of growth in the number of steps needed to encode a
;   symbol?  Be sure to include the number of steps needed to search the
;   symbol list at each node encountered.  To answer this question in
;   general is difficult. Consider the special case where the relative
;   frequencies of the n symbols are as described in exercise [2.71], and
;   give the order of growth (as a function of n) of the number of steps
;   needed to encode the most frequent and least frequent symbols in the
;   alphabet.
;   
;   ------------------------------------------------------------------------
;   [Exercise 2.72]: http://sicp-book.com/book-Z-H-16.html#%_thm_2.72
;   [Exercise 2.68]: http://sicp-book.com/book-Z-H-16.html#%_thm_2.68
;   [Exercise 2.71]: http://sicp-book.com/book-Z-H-16.html#%_thm_2.71
;   2.3.4 Example: Huffman Encoding Trees - p169
;   ------------------------------------------------------------------------

(-start- "2.72")



(--end-- "2.72")

