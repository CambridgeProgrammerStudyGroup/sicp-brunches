#lang racket
; Flotsam and Jetsam from working through Chapter 2.
  

; A helper function for priting out the exercise title
; and some other bits for displaying comments.
;(define nl "\n")
;(define (get-string item)
;  (cond ((string? item) item)
;        ((number? item) (number->string item))
;        (else item)))
(define get-string ~a)
(define (str . parts)
  (define strParts (map get-string parts))
  (apply string-append  strParts ))
(define (prn . lines)
  (for-each
   (lambda (line) (display (str line "\n")))
   lines))
(define (ti title)
  (define long (make-string 60 #\_))
  (prn "" "" long    title    long ""))


;#########################################################################
;#########################################################################
(ti "Exercise 2.7")

(define (make-interval a b) (cons a b))

(define (upper-bound a)
  (let ((x (car a))
        (y (cdr a)))
    (if (> x y) x y)))

(define (lower-bound a)
  (let ((x (car a))
        (y (cdr a)))
    (if (< x y) x y)))

(define bound-test (make-interval 3 2))
"I'd like a simbple string concating display function"
(lower-bound bound-test)
(upper-bound bound-test)


;#########################################################################
;#########################################################################
(ti "Exercise 2.8")

(define (add-interval x y)
  (make-interval (+ (lower-bound x) (lower-bound y))
                 (+ (upper-bound x) (upper-bound y))))

(define (negate-interval x)
  (make-interval (- (lower-bound x))
                 (- (upper-bound x))))

(define (sub-interval x y)
  (add-interval x (negate-interval y)))

(let ((fortyish (make-interval 39 41))
      (tenish (make-interval 9 11)))
  (sub-interval fortyish tenish))


;#########################################################################
;#########################################################################
(ti "Exercise 2.9")

(prn 
 "Why we can combine widths in addition (& therefore subraction):"
 
 "Given x with a lower bound of lx and upper bound of ux"
 "  and y with a lower bound of ly and upper bound of uy"
 "  under addtion the new width will be: "
 "    ((ux + uy) - (lx + ly)) / 2"
 "    = ((ux - lx) + (uy - ly)) / 2"
 "    = (2wx + 2wy) / 2"
 "    = wx + wy"
 "and that's good enough for me.")

(define (mul-interval x y)
  (let ((p1 (* (lower-bound x) (lower-bound y)))
        (p2 (* (lower-bound x) (upper-bound y)))
        (p3 (* (upper-bound x) (lower-bound y)))
        (p4 (* (upper-bound x) (upper-bound y))))
    (make-interval (min p1 p2 p3 p4)
                   (max p1 p2 p3 p4))))

(define (interval-width x)
   (/ (- (upper-bound x) (lower-bound x))
      2))


(let ((x (make-interval 9 11))
      (y (make-interval 999999 1000001)))  
  (prn
   "" "Lets try 'wx * wy' as a guess for the width after multiplication:"
   (str "x: " (lower-bound x) "-" (upper-bound x))
   (str "y: " (lower-bound y) "-" (upper-bound y))
   (str "Estimate: " (* (interval-width x) (interval-width y)))
   (str "Actual: " (interval-width  (mul-interval x y)))))


(prn
 "" "why?"
 "Assuming everything is positive..."
 "  width / 2"
 "    = (ux * uy) - (lx * ly)"
 "    = (lx + wx)*(ly + wy) - (lx * ly)"
 " which cannot be reduced to a form that has just wx and wy,"
 " so final width is dependant on both origanl 'values'")

;#########################################################################
;#########################################################################
(ti "Exercise 2.10")

(define (div-interval-unsafe x y)
  (mul-interval x
                (make-interval (/ 1.0 (upper-bound y))
                               (/ 1.0 (lower-bound y)))))

(define (div-interval x y)
  (if (>= 0 (* (lower-bound y) (upper-bound y)))
          (raise "Cannot do interval division when divisor includes zero")
          (div-interval-unsafe x y)))

    
(let ((tenish (make-interval 9 11))
      (hundredish (make-interval 99 101))
      (zeroish (make-interval -1 1)))
  (prn
   (str "Orignal 100ish / 10ish: " (div-interval-unsafe hundredish tenish))
   (str "New 100ish / 10ish: " (div-interval hundredish tenish))
   (str "Original 100ish / 0ish: " (div-interval-unsafe hundredish zeroish))
   (str "New 100ish / 0ish: "
        (with-handlers ([(lambda (exn) true) (lambda (exn) (str exn))])
          (div-interval hundredish zeroish)))))

;#########################################################################
;#########################################################################
(ti "Exercise 2.11")

(define (mul-interval-ihateben x y)
  ; use LET* form that allows use of previous pairs
  ; change mi to (mi l1 l2 u1 u2) -> make-int l1.l2 u1.u2
  (let* (
         (neg "neg")
         (span "span")
         (pos "pos")
         (type (lambda (int)
              (cond
                ((> 0 (upper-bound int)) neg)
                ((> 0 (lower-bound int)) span)
                (else pos))
              ))
         (x-type (type x))
         (y-type (type y))
         (xy-have-type (lambda (type1 type2) (and (equal? x-type type1) (equal? y-type type2))))
         (lx (lower-bound x))
         (ux (upper-bound x))
         (ly (lower-bound y))
         (uy (upper-bound y))
         (make (lambda (l1 l2 u1 u2) (make-interval (* l1 l2) (* u1 u2))))
        )
    (cond
      ((xy-have-type pos pos) (make lx ly ux uy))
      ((xy-have-type pos span) (make ux ly ux uy))
      ((xy-have-type pos neg) (make ux ly lx uy))
      ((xy-have-type neg pos) (make lx uy ux ly))
      ((xy-have-type neg neg) (make ux uy lx ly))
      ((xy-have-type neg span) (make lx uy lx ly))
      ((xy-have-type span pos) (make lx uy ux uy))
      ((xy-have-type span neg) (make ux ly lx ly))
      ((xy-have-type span span)
       (make-interval (min (* lx uy) (* ux ly)) (max (* lx ly) (* ux uy))))
      (else raise "didn't expect to be here")
    )))
   
   (let ((pos (make-interval 9 11))
         (neg (make-interval -21 -19))
         (span (make-interval -0.5 1.5)))
     (prn
      (str "pos = " pos)
      (str "span = " span)
      (str "neg = " neg)
      (str)
      (str "pos x pos:  " (mul-interval-ihateben pos pos))
      (str "pos x neg:  " (mul-interval-ihateben pos neg))
      (str "pos x span:  " (mul-interval-ihateben pos span))
      (str "neg x pos:  " (mul-interval-ihateben neg pos))
      (str "neg x neg:  " (mul-interval-ihateben neg neg))
      (str "neg x span:  " (mul-interval-ihateben neg span))
      (str "span x pos:  " (mul-interval-ihateben span pos))
      (str "span x neg:  " (mul-interval-ihateben span neg))
      (str "span x span:  " (mul-interval-ihateben span span))     
      ))

;#########################################################################
;#########################################################################

(ti "Excercise 2.12")

(define (get%of % n)
  (/ (* % n) 100))

(define (make-center-percent c %)
  (let ((tol (get%of % c)))
    (make-interval (- c tol) (+ c tol))))

(prn
 "Creating interval with centre 100 and percentage 3"
 (str "Got: " (make-center-percent 100 3)))
 


;#########################################################################
;#########################################################################

(ti "Exercise 2.13")

(prn

 "Note: For convenience using numbers as percentage e.g. using 0.12 for 12%"
 "so P percent of N is P x N instead of (P x N)/100"
 ""
 "Given intervals center, percent intervals: c1, p1  and c2, p2:"
 ""
 "Tolerence ti = ci * pi"
 ""
 "Expressing as min -> max intervals we have:"
 "(c1 - t1) -> (c1 + t1)"
 "(c2 - t2) -> (c2 + t2)"
 ""
 "Product of these intervals:"
 "(c1 - t1)(c2 - t2) -> (c1 + t1)(c2 + t2)"
 ""
 "Precentage (tolerence) of Product:"
 ""
 "1/2 *    (max - min)"
 "	  -----------------"
 "	  1/2 * (max + min)"
 ""
 "=>"
 ""
 "(c1 + t1)(c2 + t2) - (c1 - t1)(c2 - t2)"
 "---------------------------------------"
 "(c1 + t1)(c2 + t2) + (c1 - t1)(c2 - t2)"
 ""
 "=>"
 ""
 "2(c1.t2 + c2.t1)"
 "----------------"
 "2(c1.c2 + t1.t2)"
 ""
 "If p1 and p2 are small then t1.t2 is small so can approximate as:"
 ""
 "(c1.t2 + c2.t1)"
 "---------------"
 "     c1.c2"
 ""
 "=>"
 ""
 "t2   t1"
 "-- + --"
 "c2   c2"
 ""
 "=>"
 ""
 "p1 + p2")