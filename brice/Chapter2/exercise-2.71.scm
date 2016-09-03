#lang racket
(require "../utils.scm")
(require "../huffman.scm")
(require "./exercise-2.68.scm")
(require "./exercise-2.69.scm")

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

(module* main #f
  (title "Exercise 2.71")

  ; (display (generate-huffman-tree '((E 1) (D 2) (C 4) (B 8) (A 16))))
  (Q: "Suppose we have a Huffman tree for an alphabet of n symbols, and that
the relative frequencies of the symbols are 1, 2, 4, ..., 2ⁿ⁻¹.  Sketch
the tree for n=5")

  (A: "
    /\\
  16 /\\
    8 /\\
     4 /\\
      2  1")

  (Q: "for n=10")
  ; 1 2 4 8 16 32 64 128 256 512
  (A: "
      /\\
   512 /\\
    256 /\\
     128 /\\
       64 /\\
        32 /\\
         16 /\\
           8 /\\
            4 /\\
             2  1")

  (Q: "In such a tree (for general n) how many bits are required to encode the most frequent symbol?")
  (A: "One bit")

  (Q: "The least frequent symbol?")
  (A: "n-1 bits.")


)
