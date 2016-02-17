#lang racket

; Flotsam and Jetsam from working through Chapter 2.
(require "exercises02.util.rkt")

(ti "Exercise 2.1")

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

(define zero (lambda (f) (lambda (x) x)))

(define (add-1 n)
  (lambda (f) (lambda (x) (f ((n f) x)))))

(define one (lambda (f) (lambda (x) (f x))))

(define two (lambda (f) (lambda (x) (f (f x)))))

(define three (add-1 two))

(define (f x) (string-append x "I"))

(prn
 (str "zero:      '" ((zero f) "") "'") 
 (str "one:       '" ((one f) "") "'")
 (str "two:       '" ((two f) "") "'")
 (str "one add-1: '" (((add-1 one) f) "") "'")
 (str "two add-1: '" (((add-1 two) f) "") "'")
 (str "three:     '" ((three f) "")"'"))

(define (add n m)
  (lambda (f) (lambda (x) ((m f)((n f) x)))))

(define (mult n m)
  (lambda (f) (n (m f))))

(define (Expt n m)
  (lambda (f) ((m n) f)))

(prn
 (str)
 (str "one + two:   '" (((add one two) f) "") "'")
 (str "two + three: '" (((add two three) f) "") "'")
 (str)
 (str "two * two:     '" (((mult two two) f) "") "'")
 (str "two * three:   '" (((mult two three) f) "") "'")
 (str "three * three: '" (((mult three three) f) "") "'")
 (str)
 (str "two ^ zero:    '" (((Expt two zero) f) "") "'")
 (str "two ^ one:     '" (((Expt two one) f) "") "'")
 (str "two ^ two:     '" (((Expt two two) f) "") "'")
 (str "two ^ three:   '" (((Expt two three) f) "") "'")
 (str "three ^ three: '" (((Expt three three) f) "") "'"))