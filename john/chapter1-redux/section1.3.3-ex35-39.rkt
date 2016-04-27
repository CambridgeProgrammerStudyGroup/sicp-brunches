#lang racket

; Section 1.3.3: Procedures as General Methods

(require "common.rkt")

;   Exercise 1.35
;   =============
;   
;   Show that the golden ratio ɸ (section [1.2.2]) is a fixed point of the
;   transformation x → 1 + 1/x, and use this fact to compute ɸ by means of
;   the fixed-point procedure.
;   
;   ------------------------------------------------------------------------
;   [Exercise 1.35]: http://sicp-book.com/book-Z-H-12.html#%_thm_1.35
;   [Section 1.2.2]: http://sicp-book.com/book-Z-H-11.html#%_sec_1.2.2
;   1.3.3 Procedures as General Methods - p70
;   ------------------------------------------------------------------------

(-start- "1.35")

(prn "By definition the golden ratio is the ratio of a to b when:

    a + b   a
    ————— = —
      a     b

Lets fix b = 1 then:

    a + 1   a
    ————— = —
      a     1

Now a/1 is the golden ratio so 'a' represents its numeric value. We can
rewrite as:

    ψ + 1   ψ
    ————— = —
      ψ     1

    ψ   1   ψ
    — + — = —
    ψ   ψ   1

        1
    1 + — = ψ
        ψ


I.e. the golden ratio is a fixed point of x -> 1 + 1/x
")

(define tolerance 0.00001)
(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) tolerance))
  (define (try guess)
    (let ((next (f guess)))
      (if (close-enough? guess next)
          next
          (try next))))
  (try first-guess))

(define (golden-f x) (+ 1 (/ 1 x)))

(present-compare fixed-point
                 (list (list golden-f 1.0) "1.6180"))

(--end-- "1.35")

;   ========================================================================
;   
;   Exercise 1.36
;   =============
;   
;   Modify fixed-point so that it prints the sequence of approximations it
;   generates, using the newline and display primitives shown in exercise
;   [1.22].  Then find a solution to x^x = 1000 by finding a fixed point of
;   x → log(1000)/log(x).  (Use Scheme's primitive log procedure, which
;   computes natural logarithms.) Compare the number of steps this takes
;   with and without average damping.  (Note that you cannot start
;   fixed-point with a guess of 1, as this would cause division by log(1) =
;   0.)
;   
;   ------------------------------------------------------------------------
;   [Exercise 1.36]: http://sicp-book.com/book-Z-H-12.html#%_thm_1.36
;   [Exercise 1.22]: http://sicp-book.com/book-Z-H-12.html#%_thm_1.22
;   1.3.3 Procedures as General Methods - p70
;   ------------------------------------------------------------------------

(-start- "1.36")

(define (fp-display f average first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) tolerance))
  (define (try guess)
    (let ((next (average guess (f guess))))
      (display "        ")(display guess)(newline)
      (if (close-enough? guess next)
          next
          (try next))))
  (try first-guess))

(define (x^x=1000-f x)
  (/ (log 1000) (log x)))

(define (damp-none guess f-of-guess)
  f-of-guess)

(define (damp-mean guess f-of-guess)
  (/ (+ guess f-of-guess) 2))

(present-compare fp-display
                 (list (list x^x=1000-f damp-none 2.0) "4.5555"))

(present-compare fp-display
                 (list (list x^x=1000-f damp-mean 2.0) "4.5555"))

(prn "Dampening with the mean-average reduces the number of iterations from
34 to 9.")

(--end-- "1.36")

;   ========================================================================
;   
;   Exercise 1.37
;   =============
;   
;   a. An infinite continued fraction is an expression of the form
;   
;               N₁
;   f = ──────────────────
;                 N₂
;       D₁ + ─────────────
;                    N₃
;            D₂ + ──────── 
;                      ·                  
;                 D₃ +  ·
;                        ·
;   
;   As an example, one can show that the infinite continued fraction
;   expansion with the Nᵢ and the Dᵢ all equal to 1 produces 1/ɸ, where ɸ is
;   the golden ratio (described in section [1.2.2]). One way to approximate
;   an infinite continued fraction is to truncate the expansion after a
;   given number of terms.  Such a truncation -- a so-called k-term finite
;   continued fraction -- has the form
;   
;        N₁
;   ────────────
;           N₂
;   D₁ + ───────
;       ·
;        ·    N
;         ·    ᵏ
;           + ──                   
;             D
;              ᵏ
;   
;   Suppose that n and d are procedures of one argument (the term index i)
;   that return the Nᵢ and Dᵢ of the terms of the continued fraction. 
;   Define a procedure cont-frac such that evaluating (cont-frac n d k)
;   computes the value of the k-term finite continued fraction.  Check your
;   procedure by approximating 1/ɸ using
;   
;   (cont-frac (lambda (i) 1.0)
;              (lambda (i) 1.0)
;              k)
;   
;   for successive values of k.  How large must you make k in order to get
;   an approximation that is accurate to 4 decimal places?
;   
;   b. If your cont-frac procedure generates a recursive process, write one
;   that generates an iterative process. If it generates an iterative
;   process, write one that generates a recursive process.
;   
;   ------------------------------------------------------------------------
;   [Exercise 1.37]: http://sicp-book.com/book-Z-H-12.html#%_thm_1.37
;   [Section 1.2.2]: http://sicp-book.com/book-Z-H-11.html#%_sec_1.2.2
;   1.3.3 Procedures as General Methods - p71
;   ------------------------------------------------------------------------

(-start- "1.37")

(define (cont-frac-rec n d k)
  (define (recur i)
    (if (= i k)
        (/ (n i) (d i))
        (/ (n i) (+ (d i) (recur (+ i 1))))))
  (recur 1))

(define (cont-frac-itr n d k)
  (define (iter i nextTerm)
    (let ((currentTerm (/ (n i) (+ (d i) nextTerm))))
      (if (= i 1)
          currentTerm
          (iter (- i 1) currentTerm))))
  (iter k 0))

(define (golden-cf-rec k)
  (cont-frac-rec
        (lambda (i) 1.0)
        (lambda (i) 1.0)
        k))

(define (golden-cf-itr k)
  (cont-frac-itr
        (lambda (i) 1.0)
        (lambda (i) 1.0)
        k))

(present-compare golden-cf-rec
                 '((09) 0.618033)
                 '((10) 0.618033)
                 '((11) 0.618033)
                 '((12) 0.618033)
                 '((13) 0.618033)
                 '((14) 0.618033))

(present-compare golden-cf-itr
                 '((09) 0.618033)
                 '((10) 0.618033)
                 '((11) 0.618033)
                 '((12) 0.618033)
                 '((13) 0.618033)
                 '((14) 0.618033))

(prn "k must be 12 before our estimate of 1/ψ is accurate to 4 decimal
places.  After 11 steps we have 0.6180555555555556 which is 0.6181 to 4
decimal places.  After 12 steps we have 0.6180257510729613 which is
0.6180 to 4 decimal places.")

(--end-- "1.37")

;   ========================================================================
;   
;   Exercise 1.38
;   =============
;   
;   In 1737, the Swiss mathematician Leonhard Euler published a memoir De
;   Fractionibus Continuis, which included a continued fraction expansion
;   for e - 2, where e is the base of the natural logarithms. In this
;   fraction, the Nᵢ are all 1, and the Dᵢ are successively 1, 2, 1, 1, 4,
;   1, 1, 6, 1, 1, 8, ....  Write a program that uses your cont-frac
;   procedure from exercise [1.37] to approximate e, based on Euler's
;   expansion.
;   
;   ------------------------------------------------------------------------
;   [Exercise 1.38]: http://sicp-book.com/book-Z-H-12.html#%_thm_1.38
;   [Exercise 1.37]: http://sicp-book.com/book-Z-H-12.html#%_thm_1.37
;   1.3.3 Procedures as General Methods - p71
;   ------------------------------------------------------------------------

(-start- "1.38")

(define (e-2 k)
  (define (n i) 1.0)
  (define (d i)
    (if (= (remainder i 3) 2)
        (* (+ (quotient i 3) 1) 2)
        1))
  (cont-frac-itr n d k))

(present-compare e-2
                 '((1) 0.71828182845904523)
                 '((2) 0.71828182845904523)
                 '((4) 0.71828182845904523)
                 '((8) 0.71828182845904523)
                 '((16) 0.71828182845904523)
                 '((32) 0.71828182845904523))

(--end-- "1.38")

;   ========================================================================
;   
;   Exercise 1.39
;   =============
;   
;   A continued fraction representation of the tangent function was
;   published in 1770 by the German mathematician J.H. Lambert:
;   
;   tan x =        x
;           ────────────────
;                    x²
;           1 ─ ────────────
;                      x²
;               3 ─ ────────
;                       ·
;                   5 ─  ·
;                         ·
;   
;   where x is in radians. Define a procedure (tan-cf x k) that computes an
;   approximation to the tangent function based on Lambert's formula.  K
;   specifies the number of terms to compute, as in exercise [1.37].
;   
;   ------------------------------------------------------------------------
;   [Exercise 1.39]: http://sicp-book.com/book-Z-H-12.html#%_thm_1.39
;   [Exercise 1.37]: http://sicp-book.com/book-Z-H-12.html#%_thm_1.37
;   1.3.3 Procedures as General Methods - p72
;   ------------------------------------------------------------------------

(-start- "1.39")

(define (tan-cf x k)  
  (define (n i)
    (if (= i 1) x (- (* x x))))
  (define (d i)
    (- (* i 2) 1))
  (cont-frac-itr n d k))
    
(present-compare tan-cf
                 '((0.5 1) 0.54630248984)
                 '((0.5 2) 0.54630248984)
                 '((0.5 4) 0.54630248984)
                 '((0.5 8) 0.54630248984))

(--end-- "1.39")

