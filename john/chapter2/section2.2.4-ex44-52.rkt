#lang racket
; Section 2.2.4: Example: A Picture Language

(require "common.rkt")

;   Exercise 2.44
;   =============
;   
;   Define the procedure up-split used by corner-split. It is similar to
;   right-split, except that it switches the roles of below and beside.
;   
;   ------------------------------------------------------------------------
;   [Exercise 2.44]: http://sicp-book.com/book-Z-H-15.html#%_thm_2.44
;   2.2.4 Example: A Picture Language - p132
;   ------------------------------------------------------------------------

(-start- "2.44")

; For image support we need the sicp-module from the sicp package:
;
; For DrRacket:
;
; 1.  Open the Package Manager:
;       in DrRacket choose the menu "File" then choose "Package Manager...".
;
; 2.  In the tab "Do What I Mean" find the text field and enter: "sicp"
;
; 3.  Finally click the "Install" button.
;
; https://docs.racket-lang.org/sicp-manual/index.html

(require sicp-pict)
(define pict-for-hi einstein)
(define pict-for-lo diagonal-shading)

(define (up-split1 painter n)
  (if (= n 0)
      painter
      (let ((smaller (up-split1 painter (- n 1))))
        (below painter (beside smaller smaller)))))

(paint-hi-res (up-split1 pict-for-hi 3))

(--end-- "2.44")

;   ========================================================================
;   
;   Exercise 2.45
;   =============
;   
;   Right-split and up-split can be expressed as instances of a general
;   splitting operation. Define a procedure split with the property that
;   evaluating
;   
;   (define right-split (split beside below))
;   (define up-split (split below beside))
;   
;   produces procedures right-split and up-split with the same behaviors as
;   the ones already defined.
;   
;   ------------------------------------------------------------------------
;   [Exercise 2.45]: http://sicp-book.com/book-Z-H-15.html#%_thm_2.45
;   2.2.4 Example: A Picture Language - p134
;   ------------------------------------------------------------------------

(-start- "2.45")

(define (split outer inner)
  (define (splitter painter n)
    (if (= n 0)
        painter
        (let ((smaller (splitter painter (- n 1))))
          (outer painter (inner smaller smaller)))))
  (lambda (painter n) (splitter painter n)))

(define right-split (split beside below))
(define up-split (split below beside))

(paint-hi-res (up-split pict-for-hi 3))
(paint (right-split pict-for-lo 3))

(--end-- "2.45")

;   ========================================================================
;   
;   Exercise 2.46
;   =============
;   
;   A two-dimensional vector v running from the origin to a point can be
;   represented as a pair consisting of an x-coordinate and a y-coordinate. 
;   Implement a data abstraction for vectors by giving a constructor
;   make-vect and corresponding selectors xcor-vect and ycor-vect.  In terms
;   of your selectors and constructor, implement procedures add-vect,
;   sub-vect, and scale-vect that perform the operations vector addition,
;   vector subtraction, and multiplying a vector by a scalar:
;   
;   (x₁, y₁) + (x₂, y₂) = (x₁ + x₂, y₁ + y₂)
;   (x₁, y₁) - (x₂, y₂) = (x₁ - x₂, y₁ - y₂)
;              s.(x, y) = (s.x, s.y)
;   
;   ------------------------------------------------------------------------
;   [Exercise 2.46]: http://sicp-book.com/book-Z-H-15.html#%_thm_2.46
;   2.2.4 Example: A Picture Language - p136
;   ------------------------------------------------------------------------

(-start- "2.46")

(define (make-vect xcor ycor)
  (cons xcor ycor))

(define (xcor-vect vect)
  (car vect))

(define (ycor-vect vect)
  (cdr vect))

(define (add-vect vect1 vect2)
  (cons
   (+ (xcor-vect vect1) (xcor-vect vect2))
   (+ (ycor-vect vect1) (ycor-vect vect2))))

(define (sub-vect vect1 vect2)
  (cons
   (- (xcor-vect vect1) (xcor-vect vect2))
   (- (ycor-vect vect1) (ycor-vect vect2))))

(define (scale-vect s vect)
  (cons
   (* s (xcor-vect vect))
   (* s (ycor-vect vect))))

(define vect1 (make-vect 10 3))
(define vect2 (make-vect 21 12))

(present-compare add-vect
                 (list (list vect1 vect2) (make-vect 31 15)))
 
(present-compare sub-vect
                 (list (list vect1 vect2) (make-vect -11 -9)))
 
(present-compare scale-vect
                 (list (list 3 vect1) (make-vect 30 9)))
 
(--end-- "2.46")

;   ========================================================================
;   
;   Exercise 2.47
;   =============
;   
;   Here are two possible constructors for frames:
;   
;   (define (make-frame origin edge1 edge2)
;     (list origin edge1 edge2))
;   
;   (define (make-frame origin edge1 edge2)
;     (cons origin (cons edge1 edge2)))
;   
;   For each constructor supply the appropriate selectors to produce an
;   implementation for frames.
;   
;   ------------------------------------------------------------------------
;   [Exercise 2.47]: http://sicp-book.com/book-Z-H-15.html#%_thm_2.47
;   2.2.4 Example: A Picture Language - p136
;   ------------------------------------------------------------------------

(-start- "2.47")

(prn
 (dbl-un "Using list:") "")

(define (make-frame-l origin edge1 edge2)
  (list origin edge1 edge2))

(define (origin-frame-l frame)
  (car frame))

(define (edge1-frame-l frame)
  (car (cdr frame)))

(define (edge2-frame-l frame)
  (car (cdr (cdr frame))))

(define frame-l
  (make-frame-l
   (make-vect -7 2)
   (make-vect 9 6)
   (make-vect -3 6)))

(present-compare origin-frame-l
                 (list (list frame-l) (cons -7 2)))

(present-compare edge1-frame-l
                 (list (list frame-l) (cons 9 6)))

(present-compare edge2-frame-l
                 (list (list frame-l) (cons -3 6)))


(prn "" (dbl-un "And using cons:") "")

(define (make-frame-c origin edge1 edge2)
  (cons origin (cons edge1 edge2)))

(define (origin-frame-c frame)
  (car frame))

(define (edge1-frame-c frame)
  (car (cdr frame)))

(define (edge2-frame-c frame)
  (cdr (cdr frame)))

(define frame-c
  (make-frame-c
   (make-vect -7 2)
   (make-vect 9 6)
   (make-vect -3 6)))

(present-compare origin-frame-c
                 (list (list frame-c) (cons -7 2)))

(present-compare edge1-frame-c
                 (list (list frame-c) (cons 9 6)))

(present-compare edge2-frame-c
                 (list (list frame-c) (cons -3 6)))
(prn
 "Only the imlementation of 'edge2-frame' needs to change depending on
whether the imlementation uses cons or list.")

(--end-- "2.47")

;   ========================================================================
;   
;   Exercise 2.48
;   =============
;   
;   A directed line segment in the plane can be represented as a pair of
;   vectors -- the vector running from the origin to the start-point of the
;   segment, and the vector running from the origin to the end-point of the
;   segment. Use your vector representation from exercise [2.46] to define a
;   representation for segments with a constructor make-segment and
;   selectors start-segment and end-segment.
;   
;   ------------------------------------------------------------------------
;   [Exercise 2.48]: http://sicp-book.com/book-Z-H-15.html#%_thm_2.48
;   [Exercise 2.46]: http://sicp-book.com/book-Z-H-15.html#%_thm_2.46
;   2.2.4 Example: A Picture Language - p137
;   ------------------------------------------------------------------------

(-start- "2.48")

(define (make-segment start end)
  (cons start end))

(define (start-segment segment)
  (car segment))

(define (end-segment segment)
  (cdr segment))

(define start (make-vect 0 1))
(define end (make-vect 1 0))

(define segment
  (make-segment start end))

(present-compare start-segment
                 (list (list segment) start))

(present-compare end-segment
                 (list (list segment) end))             


(--end-- "2.48")

;   ========================================================================
;   
;   Exercise 2.49
;   =============
;   
;   Use segments->painter to define the following primitive painters:
;   
;   a.  The painter that draws the outline of the designated frame.
;   
;   b.  The painter that draws an "X" by connecting opposite corners of the
;   frame.
;   
;   c.  The painter that draws a diamond shape by connecting the midpoints
;   of the sides of the frame.
;   
;   d.  The wave painter.
;   
;   ------------------------------------------------------------------------
;   [Exercise 2.49]: http://sicp-book.com/book-Z-H-15.html#%_thm_2.49
;   2.2.4 Example: A Picture Language - p137
;   ------------------------------------------------------------------------

(-start- "2.49")

;(define (outline frame)
;  (let ((left   (make-segment (make-vect 0 0) (make-vect 0 1)))
;        (top    (make-segment (make-vect 0 1) (make-vect .5 .5)))
;        (right  (make-segment (make-vect .5 .5) (make-vect 1 0)))
;        (bottom (make-segment (make-vect 1 0) (make-vect 0 0))))
;    (segments->painter
;     (list segment left top right bottom))))

(prn (dbl-un "a: Outline:"))

(define outline
  (let ((left   (make-segment (make-vect 0 0) (make-vect 0 1)))
        (top    (make-segment (make-vect 0 1) (make-vect 1.0 1.0)))
        (right  (make-segment (make-vect 1 1) (make-vect 1 0)))
        (bottom (make-segment (make-vect 1 0) (make-vect 0 0))))
    (segments->painter
     (list left top right bottom))))

(paint outline)
        
(prn "It seems that paint only supports values where 0 <= x < 1 unike in the
book where it supports 0 <= x <= 1.")

(prn "" (dbl-un "b: X"))

(define X
  (segments->painter
   (list (make-segment (make-vect 0 0) (make-vect 1 1))
         (make-segment (make-vect 0 1) (make-vect 1 0)))))
    
(paint X)

(prn "" (dbl-un "c: Diamond"))

(define diamond
  (segments->painter
   (list (make-segment (make-vect 0 0.5) (make-vect 0.5 1))
         (make-segment (make-vect 0.5 1) (make-vect 1 0.5))
         (make-segment (make-vect 1 0.5) (make-vect 0.5 0))
         (make-segment (make-vect 0.5 0) (make-vect 0 0.5)))))

(paint diamond)

(prn "" (dbl-un "d: (not) Wave"))

(define (ms x1 y1 x2 y2)
  (make-segment (make-vect x1 y1) (make-vect x2 y2)))

(define see
  (segments->painter
   (list (ms 0.1 0.5   0.2 0.7)
         (ms 0.2 0.7   0.8 0.7)
         (ms 0.8 0.7   0.9 0.6)
         (ms 0.9 0.6   0.9 0.4)
         (ms 0.9 0.4   0.8 0.3)
         (ms 0.8 0.3   0.2 0.3)
         (ms 0.2 0.3   0.1 0.5)

         (ms 0.9 0.60  1 0.60)
         (ms 0.9 0.58  1 0.58)
         (ms 0.9 0.54  1 0.56)
         (ms 0.9 0.52  1 0.54)

         (ms 0.15 0.6   0.11 0.6)
         (ms 0.11 0.6   0.115 0.65)
         (ms 0.115 0.65  0.165 0.65)

         (ms 0.13 0.5      0.225 0.675)
         (ms 0.225 0.675   0.775 0.675)
         (ms 0.775 0.675   0.863 0.592)
         (ms 0.863 0.592   0.863 0.418)
         (ms 0.863 0.418   0.775 0.325)
         (ms 0.775 0.325   0.225 0.325)
         (ms 0.225 0.325   0.13  0.5)
         
   )))

(paint-hi-res see)

(--end-- "2.49")

;   ========================================================================
;   
;   Exercise 2.50
;   =============
;   
;   Define the transformation flip-horiz, which flips painters horizontally,
;   and transformations that rotate painters counterclockwise by 180 degrees
;   and 270 degrees.
;   
;   ------------------------------------------------------------------------
;   [Exercise 2.50]: http://sicp-book.com/book-Z-H-15.html#%_thm_2.50
;   2.2.4 Example: A Picture Language - p140
;   ------------------------------------------------------------------------

(-start- "2.50")

(define flip-horiz
  (transform-painter
   (make-vect 1.0 0.0)
   (make-vect 0.0 0.0)
   (make-vect 1.0 1.0)))

(define rotate180
  (transform-painter
   (make-vect 1.0 1.0)
   (make-vect 0.0 1.0)
   (make-vect 1.0 0.0)))

(define rotate270
  (transform-painter
   (make-vect 0.0 1.0)
   (make-vect 0.0 0.0)
   (make-vect 1.0 1.0)))

; The signature of transform-painter appears to be differen (3 arguments) in
; the package compared to the book (4 aguments).

(prn "flip-horiz:")
(paint-hi-res (flip-horiz see))

(define pair (beside see (flip-horiz see)))

(prn "pair:")
(paint-hi-res pair)

(prn "rotate90 (built-in):")
(paint-hi-res (rotate90 pair))

(prn "rotate180:")
(paint-hi-res (rotate180 pair))

(prn "rotate270:")
(paint-hi-res (rotate270 pair))
     

(--end-- "2.50")

;   ========================================================================
;   
;   Exercise 2.51
;   =============
;   
;   Define the below operation for painters.  Below takes two painters as
;   arguments.  The resulting painter, given a frame, draws with the first
;   painter in the bottom of the frame and with the second painter in the
;   top.  Define below in two different ways -- first by writing a procedure
;   that is analogous to the beside procedure given above, and again in
;   terms of beside and suitable rotation operations (from exercise [2.50]).
;   
;   ------------------------------------------------------------------------
;   [Exercise 2.51]: http://sicp-book.com/book-Z-H-15.html#%_thm_2.51
;   [Exercise 2.50]: http://sicp-book.com/book-Z-H-15.html#%_thm_2.50
;   2.2.4 Example: A Picture Language - p140
;   ------------------------------------------------------------------------

(-start- "2.51")

(define (below-like-beside painter1 painter2)
  (let ((split-point (make-vect 0.0 0.5)))
    (let ((paint-bottom
           (transform-painter 
            (make-vect 0.0 0.0)
            (make-vect 1.0 0.0)
            split-point))
          (paint-top
           (transform-painter 
            split-point
            (make-vect 1.0 0.5)
            (make-vect 0.0 1.0))))
      (lambda (frame)
        ((paint-bottom painter1) frame)
        ((paint-top    painter2) frame)))))

(prn "below-like-beside")
(paint-hi-res (below-like-beside pair pict-for-hi))

(define (below-using-beside painter1 painter2)
  (rotate90
   (beside (rotate270 painter1) (rotate270 painter2))))

(prn "below-using-beside:")
(paint-hi-res (below-using-beside pair pict-for-hi))

(--end-- "2.51")

;   ========================================================================
;   
;   Exercise 2.52
;   =============
;   
;   Make changes to the square limit of wave shown in figure [2.9] by
;   working at each of the levels described above.  In particular:
;   
;   a.  Add some segments to the primitive wave painter of exercise [2.49]
;   (to add a smile, for example).
;   
;   b.  Change the pattern constructed by corner-split (for example, by
;   using only one copy of the up-split and right-split images instead of
;   two).
;   
;   c.  Modify the version of square-limit that uses square-of-four so as to
;   assemble the corners in a different pattern.  (For example, you might
;   make the big Mr. Rogers look outward from each corner of the square.)
;   
;   ------------------------------------------------------------------------
;   [Exercise 2.52]: http://sicp-book.com/book-Z-H-15.html#%_thm_2.52
;   [Exercise 2.49]: http://sicp-book.com/book-Z-H-15.html#%_thm_2.49
;   [Figure 2.9]:    http://sicp-book.com/book-Z-H-15.html#%_fig_2.9
;   2.2.4 Example: A Picture Language - p141
;   ------------------------------------------------------------------------

(-start- "2.52")



(--end-- "2.52")

