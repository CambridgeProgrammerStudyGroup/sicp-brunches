#lang racket
(require "../utils.scm")
(require "../huffman.scm")
(require "./exercise-2.68.scm")

;   Exercise 2.69
;   =============
;
;   The following procedure takes as its argument a list of symbol-frequency
;   pairs (where no symbol appears in more than one pair) and generates a
;   Huffman encoding tree according to the Huffman algorithm.
;
   (define (generate-huffman-tree pairs)
     (successive-merge (make-leaf-set pairs)))
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

(define (successive-merge leafs)
  (cond
    [(eq? (length leafs) 1) (first leafs)]
    [(eq? (length leafs) 2) (make-code-tree (second leafs) (first leafs))]
    [else (successive-merge (adjoin-set (make-code-tree (second leafs) (first leafs)) (rest (rest leafs))))]
    ))

(module* main #f
  (title "Exercise 2.69")

  (define pairs '((A 7) (B 4) (C 1) (D 1)))
  (define tree (generate-huffman-tree pairs))

  (prn "Given the pairs:" pairs "")
  (prn "We make the huffman tree:" tree "")

  (assertequal? "We can encode a simple symbol with our generated tree"
    '(0)
    (encode '(A) tree))

  (assertequal? "We can encode a non-root symbol with our generated tree"
    '(1 0)
    (encode '(B) tree))

  (assertequal? "We can encode multiple symbols with our generated tree"
    '(1 0 0)
    (encode '(B A) tree))

  (assertequal? "We can encode a string of symbols with our generated tree"
    '(1 0 0 1 0 1 1 0 1 1 1 0)
    (encode '(B A B C D A) tree))


)
