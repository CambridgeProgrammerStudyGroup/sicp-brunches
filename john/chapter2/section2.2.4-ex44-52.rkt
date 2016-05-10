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
(define picture einstein)

(define (up-split1 painter n)
  (if (= n 0)
      painter
      (let ((smaller (up-split1 painter (- n 1))))
        (below painter (beside smaller smaller)))))

(paint-hi-res (up-split1 picture 3))

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

(paint-hi-res (up-split picture 3))

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

