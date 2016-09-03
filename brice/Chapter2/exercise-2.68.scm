#lang racket
(require "../utils.scm")
(require "../huffman.scm")

;   Exercise 2.68
;   =============
;
;   The encode procedure takes as arguments a message and a tree and
;   produces the list of bits that gives the encoded message.
;
   (define (encode message tree)
     (if (null? message)
         '()
         (append (encode-symbol (car message) tree)
                 (encode (cdr message) tree))))
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

(module* main #f
  (title "Exercise 2.68")

  (define sample-tree
    (make-code-tree
      (make-leaf 'A 4)
      (make-code-tree
        (make-leaf 'B 2)
        (make-code-tree
          (make-leaf 'D 1)
          (make-leaf 'C 1)))))

  (define sample-message '(0 1 1 0 0 1 0 1 0 1 1 1 0))

  (assertequal? "Decode works as expected"
    sample-message
    (encode (decode sample-message sample-tree) sample-tree))

)
