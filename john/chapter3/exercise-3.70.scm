#lang sicp

(#%require "common.scm")

;   Exercise 3.70
;   =============
;   
;   It would be nice to be able to generate streams in which the pairs
;   appear in some useful order, rather than in the order that results from
;   an ad hoc interleaving process.  We can use a technique similar to the
;   merge procedure of exercise [3.56], if we define a way to say that one
;   pair of integers is "less than" another.  One way to do this is to
;   define a "weighting function" W(i,j) and stipulate that (i₁,j₁) is less
;   than (i₂,j₂) if W(i₁,j₁) < W(i₂,j₂).  Write a procedure merge-weighted
;   that is like merge, except that merge-weighted takes an additional
;   argument weight, which is a procedure that computes the weight of a
;   pair, and is used to determine the order in which elements should appear
;   in the resulting merged stream.⁽⁶⁹⁾ Using this, generalize pairs to a
;   procedure weighted-pairs that takes two streams, together with a
;   procedure that computes a weighting function, and generates the stream
;   of pairs, ordered according to weight.  Use your procedure to generate
;   
;   a. the stream of all pairs of positive integers (i,j) with i ≤ j ordered
;   according to the sum i + j
;   
;   b.  the stream of all pairs of positive integers (i,j) with i ≤ j, where
;   neither i nor j is divisible by 2, 3, or 5, and the pairs are ordered
;   according to the sum 2 i + 3 j + 5 i j.
;   
;   ------------------------------------------------------------------------
;   [Exercise 3.70]: http://sicp-book.com/book-Z-H-24.html#%_thm_3.70
;   [Exercise 3.56]: http://sicp-book.com/book-Z-H-24.html#%_thm_3.56
;   [Footnote 69]:   http://sicp-book.com/book-Z-H-24.html#footnote_Temp_485
;   3.5.3 Exploiting the Stream Paradigm - p342
;   ------------------------------------------------------------------------

(-start- "3.70")



(--end-- "3.70")

