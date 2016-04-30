#lang racket

; Section 2.1.2: Abstraction Barriers

(require "common.rkt")

;   Exercise 2.2
;   ============
;   
;   Consider the problem of representing line segments in a plane.  Each
;   segment is represented as a pair of points: a starting point and an
;   ending point. Define a constructor make-segment and selectors
;   start-segment and end-segment that define the representation of segments
;   in terms of points.  Furthermore, a point can be represented as a pair
;   of numbers: the x coordinate and the y coordinate.  Accordingly, specify
;   a constructor make-point and selectors x-point and y-point that define
;   this representation.  Finally, using your selectors and constructors,
;   define a procedure midpoint-segment that takes a line segment as
;   argument and returns its midpoint (the point whose coordinates are the
;   average of the coordinates of the endpoints). To try your procedures,
;   you'll need a way to print points:
;   
;   (define (print-point p)
;     (newline)
;     (display "(")
;     (display (x-point p))
;     (display ",")
;     (display (y-point p))
;     (display ")"))
;   
;   ------------------------------------------------------------------------
;   [Exercise 2.2]:  http://sicp-book.com/book-Z-H-14.html#%_thm_2.2
;   2.1.2 Abstraction Barriers - p89
;   ------------------------------------------------------------------------

(-start- "2.2")

(define (make-point x y)
  (cons x y))

(define (x-point p)
  (car p))

(define (y-point p)
  (cdr p))

(define (make-segment start end)
  (cons start end))

(define (start-segment seg)
  (car seg))

(define (end-segment seg)
  (cdr seg))

(define (midpoint-segment seg)
  (make-point
   (* 1/2 (+ (x-point (start-segment seg)) (x-point (end-segment seg))))
   (* 1/2 (+ (y-point (start-segment seg)) (y-point (end-segment seg))))))

(define (print-point p)
  (newline)
  (display "(")
  (display (x-point p))
  (display ",")
  (display (y-point p))
  (display ")"))

(let* ((start (make-point -2 4))
      (end (make-point 3 -5))
      (seg (make-segment start end)))
  (prn
   (str "Start: " start " End: " end)
   (str "Midpoint: " (midpoint-segment seg))))


(--end-- "2.2")

;   ========================================================================
;   
;   Exercise 2.3
;   ============
;   
;   Implement a representation for rectangles in a plane. (Hint: You may
;   want to make use of exercise [2.2].) In terms of your constructors and
;   selectors, create procedures that compute the perimeter and the area of
;   a given rectangle.  Now implement a different representation for
;   rectangles.  Can you design your system with suitable abstraction
;   barriers, so that the same perimeter and area procedures will work using
;   either representation?
;   
;   ------------------------------------------------------------------------
;   [Exercise 2.3]:  http://sicp-book.com/book-Z-H-14.html#%_thm_2.3
;   [Exercise 2.2]:  http://sicp-book.com/book-Z-H-14.html#%_thm_2.2
;   2.1.2 Abstraction Barriers - p90
;   ------------------------------------------------------------------------

(-start- "2.3")

(prn
 (str "Two rectangle representations:")
 (str "  ALIGNED takes two points for any two opposite veticies of the")
 (str "    rectangle. It assumes the rectangle is aligned with the x & y axis")
 (str "  VECTOR takes a vertex and two relative 'vectors' that describe the two")
 (str "     adjacent verticies.  This does not require the rectangle to be")
 (str "     aligned with axis, but does not check that the two vectors are")
 (str "     orthogonal.")
 (str)
 (str "As an abstraction each has a 'get segments' function that returns segments")
 (str "for two adjacent sides of the rectangle. Effectively a third")
 (str "representation that can be used by area and perimeter functions.")
 (str))
     
; Aligned rectangles:

(define (make-aligned-rect point opposite-point)
  (cons point opposite-point))

(define (get-segs-aligned aligned-rect)
  (let ((point (car aligned-rect))
        (op-pt (cdr aligned-rect)))         
    (cons
     (make-segment point (make-point (x-point point) (y-point op-pt)))
     (make-segment point (make-point (x-point op-pt) (y-point point))))))

(define aligned-rects
  (list
   (make-aligned-rect (make-point 2 4) (make-point 8 16))
   (make-aligned-rect (make-point 8 16) (make-point 2 4))
   (make-aligned-rect (make-point -2 -2) (make-point 3 8))))

; Vector rectanges: 
(define (make-rect vertex vect1 vect2)
  (cons vertex (cons vect1 vect2)))

(define (get-segs-rect rect)
  (let ((vertex (car rect))
        (vect1 (car (cdr rect)))
        (vect2 (cdr (cdr rect)))
        (apply-vect (lambda (point vect)
                      (make-point
                       (+ (x-point point) (car vect))
                       (+ (y-point point) (cdr vect))))))        
    (cons
     (make-segment vertex (apply-vect vertex vect1))
     (make-segment vertex (apply-vect vertex vect2)))))

(define rects
  (list
   (make-rect (make-point 2 4) (cons 6 0) (cons 0 12))
   (make-rect (make-point 8 16) (cons -6 0) (cons 0 -12))
   (make-rect (make-point -2 -2) (cons 5 0) (cons 0 10))
   (make-rect (make-point -2 -2) (cons 3 4) (cons 8 -6))))

; Abstractions:

(define (length-segment seg)
  (sqrt (+ (expt (- (x-point (end-segment seg))
                    (x-point (start-segment seg)))
                 2)
           (expt (- (y-point (end-segment seg))
                    (y-point (start-segment seg)))
                 2))))
            

(define (perimeter get-segs rect)
  (let ((seg1 (car (get-segs rect)))
        (seg2 (cdr (get-segs rect))))
    (+ (* 2 (length-segment seg1))
       (* 2 (length-segment seg2)))))

(define(area get-segs rect)
   (let ((seg1 (car (get-segs rect)))
        (seg2 (cdr (get-segs rect))))
     (* (length-segment seg1) (length-segment seg2))))


(define (describe-rect get-segs rect)
  (let ((seg1 (car (get-segs rect)))
        (seg2 (cdr (get-segs rect))))
  (prn
   (str "got rect: " rect)
   (str "seg1: " seg1)
   (str "seg2: " seg2)
   (str "perimeter: " (perimeter get-segs rect))
   (str "area: " (area get-segs rect))
   (str))))

(double-underline "Describing 'Aligned' rectangles:")
(for-each (lambda (rect) (describe-rect get-segs-aligned rect))
     aligned-rects)
       
(double-underline "Describing 'Vector' rectangles:")
(for-each (lambda (rect) (describe-rect get-segs-rect rect))
     rects)

(prn "The fourth rectangle is the third rectangle rotated by 53 degrees.")

(--end-- "2.3")

