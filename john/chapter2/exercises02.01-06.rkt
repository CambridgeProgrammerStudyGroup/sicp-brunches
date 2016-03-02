#lang racket

; Flotsam and Jetsam from working through Chapter 2.
(require "exercises02.util.rkt")

;#########################################################################
;#########################################################################

(ti "Exercise 2.1")

; https://mitpress.mit.edu/sicp/full-text/book/book-Z-H-14.html#%_sec_2.1

; Define a better version of make-rat that handles both positive and
; negative arguments. Make-rat should normalize the sign so that if the
; rational number is positive, both the numerator and denominator are
; positive, and if the rational number is negative, only the numerator is
; negative.

(define (gcd a b)
  (if (= b 0) a (gcd b (remainder a b))))

(define (make-rat-orig n d)
  (let ((g (gcd n d)))
    (cons (/ n g) (/ d g))))

(define (numer x) (car x))
(define (denom x) (cdr x))

(define samples (list
  (cons 2 4)
  (cons 3 -9)
  (cons -5 20)
  (cons -7 -35)
  (cons 4 2)
  (cons 9 -3)
  (cons -20 5)
  (cons -35 -7)
  ))

(define (display-samples make-rat samples)
  (if (empty? samples) (prn)
      (let* ((sample (car samples))
            (rat (make-rat (car sample) (cdr sample))))
        (prn (str "Given " sample " got rational " (numer rat)
                  " / " (denom rat)))
        (display-samples make-rat (cdr samples)))))

(define (make-rat n d)
  (let* ((g (gcd n d))
         (n (/ n g))
         (d (/ d g)))
    (if (> 0 d)
        (cons (- n)  (- d))
        (cons n d))))
            

(prn "Orignal make-rat")
(prn (str))
(display-samples make-rat-orig samples)
(prn (str))
(prn "Modified make-rat")
(display-samples make-rat samples)

;#########################################################################
;#########################################################################

(ti "Exercise 2.2")

; https://mitpress.mit.edu/sicp/full-text/book/book-Z-H-14.html#%_sec_2.1

;Consider the problem of representing line segments in a plane. Each
;segment is represented as a pair of points: a starting point and an ending
;point. Define a constructor make-segment and selectors start-segment and
;end-segment that define the representation of segments in terms of points.
;Furthermore, a point can be represented as a pair of numbers: the x
;coordinate and the y coordinate. Accordingly, specify a constructor
;make-point and selectors x-point and y-point that define this
;representation. Finally, using your selectors and constructors, define a
;procedure midpoint-segment that takes a line segment as argument and
;returns its midpoint (the point whose coordinates are the average of the
;coordinates of the endpoints). To try your procedures, you'll need a way
;to print points:
;
;(define (print-point p)
;  (newline)
;  (display "(")
;  (display (x-point p))
;  (display ",")
;  (display (y-point p))
;  (display ")"))

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
   
;#########################################################################
;#########################################################################

(ti "Exercise 2.3")

; https://mitpress.mit.edu/sicp/full-text/book/book-Z-H-14.html#%_sec_2.1

; Implement a representation for rectangles in a plane. (Hint: You may want
; to make use of exercise 2.2.) In terms of your constructors and          
; selectors, create procedures that compute the perimeter and the area of a
; given rectangle. Now implement a different representation for rectangles.
; Can you design your system with suitable abstraction barriers, so that   
; the same perimeter and area procedures will work using either            
; representation?                                                          

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
;#########################################################################
;#########################################################################

(ti "Exercise 2.4")

; https://mitpress.mit.edu/sicp/full-text/book/book-Z-H-14.html#%_sec_2.1

; Here is an alternative procedural representation of pairs. For this representation,
; verify that (car (cons x y)) yields x for any objects x and y.
;                                                                                                                                                   
; (define (cons x y)                                                                                                                                
;   (lambda (m) (m x y)))                                                                                                                           
;                                                                                                                                                   
; (define (car z)                                                                                                                                   
;   (z (lambda (p q) p)))                                                                                                                           
;                                                                                                                                                   
; What is the corresponding definition of cdr? (Hint: To verify that this works, make use
; of the substitution model of section 1.1.5.)              

(prn
 (str "require (car (con x y)) equel x.")
 (str)
 (str "substituting (z (lambda (p q) p)) for (car z)")
 (str "(con (lambda (p q) p))")
 (str)
 (str "substituting (lambda (m) (m x y)) for (cons x y)")
 (str "((lambda (m) (m x y) (lambda (p q) p))")
 (str "((lambda (p q) p) x y)")
 (str "x")
 (str))

(define (Cons x y)
  (lambda (m) (m x y)))

(define (Car z)
  (z (lambda (p q) p)))

(define (Cdr z)
  (z (lambda (p q) q)))

(let* ((x "I am X")
      (y "I am Y")
      (z (Cons x y)))
  (prn
   (str "Check it works with an example:")
   (str "(Car z): " (Car z))
   (str "(Cdr z): " (Cdr z))))

;#########################################################################
;#########################################################################

(ti "Exercise 2.5")
; https://mitpress.mit.edu/sicp/full-text/book/book-Z-H-14.html#%_sec_2.1

; Show that we can represent pairs of nonnegative integers using only numbers and
; arithmetic operations if we represent the pair a and b as the integer that is the product
; 2a 3b. Give the corresponding definitions of the procedures cons, car, and cdr.

(define (exp-in f n)
  (if (= 0 (remainder n f))
      (+ 1 (exp-in f (/ n f)))
      0))

(define (eCons a b)
  (* (expt 2 a) (expt 3 b)))

(define (eCar z)
  (exp-in 2 z))

(define (eCdr z)
  (exp-in 3 z))

(let* ((x 13)
       (y 17)
       (z (eCons x y)))
  (prn
   (str "x: " x)
   (str "y: " y)
   (str "'value' of (eCons x y): " z)
   (str "car: " (eCar z))
   (str "cdr: " (eCdr z))))


;#########################################################################
;#########################################################################

(ti "Exercise 2.6")

; https://mitpress.mit.edu/sicp/full-text/book/book-Z-H-14.html#%_sec_2.1

; In case representing pairs as procedures wasn't mind-boggling enough, consider that, in a
; language that can manipulate procedures, we can get by without numbers (at least insofar
; as nonnegative integers are concerned) by implementing 0 and the operation of adding 1 as
; 
; (define zero (lambda (f) (lambda (x) x)))
; 
; (define (add-1 n)
;   (lambda (f) (lambda (x) (f ((n f) x)))))
; 
; This representation is known as Church numerals, after its inventor, Alonzo Church, the
; logician who invented the  calculus.
; 
; Define one and two directly (not in terms of zero and add-1). (Hint: Use substitution to
; evaluate (add-1 zero)). Give a direct definition of the addition procedure + (not in
; terms of repeated application of add-1).

(define zero (lambda (f) (lambda (x) x)))

(define (add-1 n)
  (lambda (f) (lambda (x) (f ((n f) x)))))

(define one (lambda (f) (lambda (x) (f x))))

(define two (lambda (f) (lambda (x) (f (f x)))))

(define three (add-1 two))

(define x "")
(define (f x) (string-append x "I"))

(prn
 (str "zero:      '" ((zero f) x) "'") 
 (str "one:       '" ((one f) x) "'")
 (str "two:       '" ((two f) x) "'")
 (str "one add-1: '" (((add-1 one) f) x) "'")
 (str "two add-1: '" (((add-1 two) f) x) "'")
 (str "three:     '" ((three f) x)"'"))

(define (add n m)
  (lambda (f) (lambda (x) ((m f)((n f) x)))))

(define (mult n m)
  (lambda (f) (n (m f))))

(define (Expt n m)
  (lambda (f) ((m n) f)))

(prn
 (str)
 (str "one + two:   '" (((add one two) f) x) "'")
 (str "two + three: '" (((add two three) f) x) "'")
 (str)
 (str "two * two:     '" (((mult two two) f) x) "'")
 (str "two * three:   '" (((mult two three) f) x) "'")
 (str "three * three: '" (((mult three three) f) x) "'")
 (str)
 (str "two ^ zero:    '" (((Expt two zero) f) x) "'")
 (str "two ^ one:     '" (((Expt two one) f) x) "'")
 (str "two ^ two:     '" (((Expt two two) f) x) "'")
 (str "two ^ three:   '" (((Expt two three) f) x) "'")
 (str "three ^ three: '" (((Expt three three) f) x) "'"))
