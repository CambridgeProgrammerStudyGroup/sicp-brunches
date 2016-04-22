#lang racket

; Section 1.2.2: Tree Recursion

(require "common.rkt")

;   Exercise 1.11
;   =============
;   
;   A function f is defined by the rule that f(n) = n if n<3 and f(n) = f(n
;   - 1) + 2f(n - 2) + 3f(n - 3) if n≥ 3.  Write a procedure that computes f
;   by means of a recursive process.  Write a procedure that computes f by
;   means of an iterative process.
;   
;   ------------------------------------------------------------------------
;   [Exercise 1.11]: http://sicp-book.com/book-Z-H-11.html#%_thm_1.11
;   1.2.2 Tree Recursion - p42
;   ------------------------------------------------------------------------

(-start- "1.11")

(define (f-rec n)
  (if (< n 3) n
      (+ (f-rec (- n 1))
         (* 2 (f-rec (- n 2)))
         (* 3 (f-rec (- n 3))))))

(define (f-itr n)
  (define (iter m f-prev f-pre-prev f-pre-pre-prev)
    (define f-this (+ f-prev (* 2 f-pre-prev) (* 3 f-pre-pre-prev)))
    (if (= n m)
        f-this
        (iter (+ m 1) f-this f-prev f-pre-prev)))
  (if (< n 3) n (iter 3 2 1 0)))
  
    
(present-compare f-rec
                 '((0) 0)
                 '((3) 4)
                 '((4) 11)
                 '((6) 59)
                 '((12) 10661))

(present-compare f-itr
                 '((0) 0)
                 '((3) 4)
                 '((4) 11)
                 '((6) 59)
                 '((12) 10661))

(--end-- "1.11")

;   ========================================================================
;   
;   Exercise 1.12
;   =============
;   
;   The following pattern of numbers is called Pascal's triangle.
;   
;       1
;      1 1
;     1 2 1 
;    1 3 3 1
;   1 4 6 4 1
;   
;   The numbers at the edge of the triangle are all 1, and each number
;   inside the triangle is the sum of the two numbers above it.⁽³⁵⁾ Write a
;   procedure that computes elements of Pascal's triangle by means of a
;   recursive process.
;   
;   ------------------------------------------------------------------------
;   [Exercise 1.12]: http://sicp-book.com/book-Z-H-11.html#%_thm_1.12
;   [Footnote 35]:   http://sicp-book.com/book-Z-H-11.html#footnote_Temp_57
;   1.2.2 Tree Recursion - p42
;   ------------------------------------------------------------------------

(-start- "1.12")

(prn
"Will use 'row' and 'col' identify an element in the triangle:

row   col 0  1  2  3  4  5
0         1
1         1  1
2         1  2  1
3         1  3  3  1
4         1  4  6  4  1
5         1  5  10 10 5  1

e.g. row 5, col 3 is 10")

(define (pascal row col)
  (cond
    ((> col row) -1)
    ((= col 0) 1)
    ((= col row) 1)
    (else
     (+
      (pascal (- row 1) (- col 1))
      (pascal (- row 1) col)))))

(present-compare pascal
                 '((0 0) 1)
                 '((5 5) 1)
                 '((5 3) 10)
                 '((6 4) 15))

(--end-- "1.12")

;   ========================================================================
;   
;   Exercise 1.13
;   =============
;   
;   Prove that Fib(n) is the closest integer to ɸⁿ/√5, where ɸ = (1 + √5)/2.
;   Hint: Let ψ = (1 - √5)/2.  Use induction and the definition of the
;   Fibonacci numbers (see section [1.2.2]) to prove that Fib(n) = (ɸⁿ -
;   ψⁿ)/√5.
;   
;   ------------------------------------------------------------------------
;   [Exercise 1.13]: http://sicp-book.com/book-Z-H-11.html#%_thm_1.13
;   [Section 1.2.2]: http://sicp-book.com/book-Z-H-11.html#%_sec_1.2.2
;   1.2.2 Tree Recursion - p42
;   ------------------------------------------------------------------------

(-start- "1.13")

(prn
"PART 1
======
Proof that Fib ≡ I

                 ɸⁿ - ψⁿ
    where I(n) = ———————
                   √5

        1 + √5         1 - √5
    ɸ = —————— and ψ = ——————
          2              2

I(0) = Fib(0)
-------------
	I(0) = (ɸ⁰ - ψ⁰) / √5
		 = (1 - 1) / √5
		 = 0
		 = Fib(0)

--QED--


I(1) = Fib(1)
-------------
	I(1) = ((ɸ¹ - ψ¹) / √5)
		 = ((1 + √5)/2  - (1 - √5)/2) / √5
		 = (1 + √5 - 1 + √5) / 2√5
		 = 2√5 / 2√5
		 = 1
		 = Fib(1)

--QED--


If I(n-1) = Fib(n-1) and I(n-2) = Fib(n-2) then I(n) = Fib(n)
-------------------------------------------------------------
    Lemma1: ɸψ = -1
    ---------------
	    ɸψ = ((1 + √5)/2)((1 - √5)/2)
	       = (1 + √5)(1 - √5)/4
	       = (1 - √5 + √5 -5)/4
	       = -4/4
	       = -1

    --QED--

    using defintion of Fib:
	 Fib(n) = Fib(n-1) + Fib(n-2)
    
           using we our assumption:
           = I(n-1) + I(n-2) =

           substituting the definition of I:
             ɸⁿ⁻¹ - ψⁿ⁻¹ + ɸⁿ⁻² - ψⁿ⁻²
           = ——————————   ——————————
                 √5            √5
    
    multiplying both sides by √5:
    => Fib(n)·√5 = (ɸⁿ⁻¹ - ψⁿ⁻¹) + (ɸⁿ⁻² - ψⁿ⁻²)
                 = (ɸⁿ⁻¹ + ɸⁿ⁻²) - (ψⁿ⁻¹ + ψⁿ⁻²)
                 =  ɸⁿ⁻²(ɸ + 1)  -  ψⁿ⁻²(ψ + 1)

    multiplying both sides by ɸ²ψ²:
    => Fib(n)·√5·ɸ²ψ²  = ɸⁿψ²(ɸ + 1) - ψⁿɸ²(ψ + 1)

    using lemma1: ɸψ = -1
    => Fib(n)·√5·(-1)² = ɸⁿψ(-1 + ψ) - ψⁿɸ(-1 + ɸ)

    => Fib(n)·√5       = ɸⁿψ(ψ - 1) - ψⁿɸ(ɸ - 1)

    selectively substituting the definitions of ɸ and ψ:
    => Fib(n)·√5 = ɸⁿ((1 - √5)/2)((1 - √5)/2 - 1) -
                   ψⁿ((1 + √5)/2)((1 + √5)/2 - 1)

                 = ɸⁿ((1 - √5)/2)((-1 - √5)/2) -
                   ψⁿ((1 + √5)/2)((-1 + √5)/2)

                 = ɸⁿ(1 - √5)(-1 - √5)/4 -
                   ψⁿ(1 + √5)(-1 + √5)/4

                 = ɸⁿ(-1 - √5 + √5 + 5)/4 -
                   ψⁿ(-1 + √5 - √5 + 5)/4

                 = ɸⁿ(4)/4 - ψⁿ(4)/4

                 = ɸⁿ - ψⁿ

                   ɸⁿ - ψⁿ
    => Fib(n)    = ———————
                     √5

    Substituting the defintion of I:
    Fib(n) = I(n)

--QED--


We have:
   I(0) = Fib(0)
   I(1) = Fib(1)
   I(n) = Fib(n) if I(n-1) = Fib(n-1) and I(n-2) = Fib(n-2)

So using induction we can conclude:

Fib ≡ I 


PART 2
======

Let E(n), estimate = ɸⁿ/√5
Let D(n), delta    = ψⁿ/√5

Lemma2: |ψ| < 1
---------------
4 < 5 < 9 => √4 < √5 < √9
          =>  2 < √5 < 3
          =>  1 - 2 > 1 - √5 > 1 - 3
          =>  -1 > 1 - √5 > -2
          => -1/2 > (1 - √5)/2 > - 1
          => |(1 - √5)/2| < 1
          => |ψ| < 1


Lemma3: |D(n)| < 1/2 for all n >= 0
-----------------------------------
proof by induction:
	D(0)     = 1/√5 < 1/√4 = 1/2

   if D(n) < 1/2 then D(n+1) < 1/2
	|D(n+1)| = |ψ|.|D(n)|
            using lemma2 above
            < |D(n)| 
            < 1/2

--QED--


Fib(n) is the closest integer to ɸⁿ/√5
--------------------------------------
using Part1:
	Fib(n) = I(n)
          using definition of I:
          = (ɸⁿ - ψⁿ)/√5
          = ɸⁿ/√5 - ψⁿ/√5
          using above defintion of E & D:
	       = E(n) - D(n)

	=> Fib(n) - E(n) = -D(n)

	=> |Fib(n) - E(n)| = |D(n)| 
                      using Lemma3 above:
                      < 1/2

	substituting definition of E:
	=> |Fib(n) - ɸⁿ/√5| < 1/2 

	or in other words... 

	Fib(n) is the closest integer to ɸⁿ/√5

--QED--")

(--end-- "1.13")
