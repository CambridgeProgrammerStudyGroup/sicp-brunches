#lang sicp

(#%require "common.scm")

;   Exercise 3.9
;   ============
;   
;   In section [1.2.1] we used the substitution model to analyze two
;   procedures for computing factorials, a recursive version
;   
;   (define (factorial n)
;     (if (= n 1)
;         1
;         (* n (factorial (- n 1)))))
;   
;   and an iterative version
;   
;   (define (factorial n)
;     (fact-iter 1 1 n))
;   (define (fact-iter product counter max-count)
;     (if (> counter max-count)
;         product
;         (fact-iter (* counter product)
;                    (+ counter 1)
;                    max-count)))
;   
;   Show the environment structures created by evaluating (factorial 6)
;   using each version of the factorial procedure.⁽¹⁴⁾
;   
;   ------------------------------------------------------------------------
;   [Exercise 3.9]:  http://sicp-book.com/book-Z-H-21.html#%_thm_3.9
;   [Section 1.2.1]: http://sicp-book.com/book-Z-H-11.html#%_sec_1.2.1
;   [Footnote 14]:   http://sicp-book.com/book-Z-H-21.html#footnote_Temp_345
;   3.2.2 Applying Simple Procedures - p246
;   ------------------------------------------------------------------------

(-start- "3.9")
(prn"

Factorial, Recursive
====================

  global env                                                               
  ----------                                                               
       │                                                                   
       v                                                                   
 ┌────────────────────────────────────────────────────────────────────────┐
 │ factorial:                                                             │
 │                                                                        │
 └────────────────────────────────────────────────────────────────────────┘
       ^                 
       │                
     ┌────┐ <────  ┌────┐ <──── ┌────┐ <──── ┌────┐          <──── ┌────┐
     │n:6 │        │n:5 │       │n:4 │       │n:3 │                │n:1 │
E1-> │    │   E2-> │    │  E3-> │    │  E4-> │    │    ...    E7-> │    │
     │    │        │    │       │    │       │    │                │    │
     └────┘        └────┘       └────┘       └────┘                └────┘
 '(if (=...'   '(if (=...'  '(if (=...'  '(if (=...'            '(if (=...'



Factorial, Iterative
====================

  global env                                                               
  ----------                                                               
       │                                                                   
       v                                                                   
 ┌────────────────────────────────────────────────────────────────────────┐
 │ factorial:                                                             │
 │            fact-iter:                                                  │
 └────────────────────────────────────────────────────────────────────────┘
       ^             ^            ^            ^                      ^    
       │             │            │            │                      │    
     ┌────┐        ┌────┐       ┌────┐       ┌────┐                ┌──────┐
     │n:6 │        │p:1 │       │p:1 │       │p:2 │                │p:720 │
E1-> │    │   E2-> │c:1 │  E3-> │c:2 │  E4-> │c:3 │    ...    E8-> │c:7   │
     │    │        │m:6 │       │m:6 │       │m:6 │                │m:6   │
     └────┘        └────┘       └────┘       └────┘                └──────┘
 '(fact-iter) '(if (>...'  '(if (>...'  '(if (>...'            '(if (>...'
    ...'


")

recursive?

(--end-- "3.9")

