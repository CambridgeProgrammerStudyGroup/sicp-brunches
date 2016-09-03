#lang racket
(require "../utils.scm")
(require "../huffman.scm")
(require "./exercise-2.68.scm")
(require "./exercise-2.69.scm")

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
;   Sha na na na na na na na na
;   Get a job
;   Sha na na na na na na na na
;   Wah yip yip yip yip yip yip yip yip yip
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

(module* main #f
  (title "Exercise 2.70")

  (define song '(
     Get a job
     Sha na na na na na na na na
     Get a job
     Sha na na na na na na na na
     Wah yip yip yip yip yip yip yip yip yip
     Sha boom
    ))

  (define tree (generate-huffman-tree '(
     (a 2) (na 16) (boom 1) (Sha 3)
     (Get 2) (yip 9) (job 2) (Wah 1))))

  (define encoded (encode song tree))

  (Q: "How many bits are required for the encoding?")
  (A: (str (length encoded) "bits are required to encode the song using huffman encoding"))

  (Q: "What is the smallest number of bits that would be needed to encode
this song if we used a fixed-length code for the eight-symbol alphabet?")

  (A: (str "There are 8 different symbols and" (length song) "symbols in the song.
Therefore, we would need log2(8)=" (log2 8) "bits per symbols for a total of" (* (length song) (log2 8)) "bits"))
)
