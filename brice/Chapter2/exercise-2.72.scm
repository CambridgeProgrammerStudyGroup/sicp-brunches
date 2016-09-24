#lang racket
(require "../utils.scm")

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
#|
  (define (encode-symbol symbol tree)
    (let [[left (left-branch tree)] [right (right-branch tree)]]
    (cond
      [(leaf? tree)
        '()]
      [(member symbol (symbols left))
        (cons 0 (encode-symbol symbol left)) ]
      [(member symbol (symbols right))
        (cons 1 (encode-symbol symbol right))]
      [else
        (error (str "ERROR: Symbol" symbol "not found in encoding"))])))
|#


#|
    /\
  16 /\
    8 /\
     4 /\
      2  1
|#

(module* main #f
  (title "Exercise 2.72")

  (Q:"Consider the encoding procedure that you designed in exercise [2.68].
What is the order of growth in the number of steps needed to encode a
symbol?  Be sure to include the number of steps needed to search the
symbol list at each node encountered.  To answer this question in
general is difficult. Consider the special case where the relative
frequencies of the n symbols are as described in exercise [2.71], and
give the order of growth (as a function of n) of the number of steps
needed to encode the most frequent and least frequent symbols in the
alphabet.")

  (A:"Firstly, we should note that the complexity of member search is O(n).

This means that for every call of `encode-symbol`, a full symbol search
will perform at least one operation for every symbol in the subtree we
are studying.

In the case where the relative frequencies of the symbols are powers
of two, we call `encode-symbol` - in the worst case - n times.

This leads to a total worst case complexity of O(n²), which occurs
with the least frequent symbol.

It is worth noting here, that because we check the left side first,
and because we encode most freqent symbols on the left side of our
tree, when we arrive at a node where the left side is the symbol we
are trying to encode, the lookup will actually be O(1), due to the
fact that we'll be looking at a list of one element. 

The best case is thus O(1) for the most common symbol.
")

)
