; Exercise 1.3
(define (square x)
  (* x x))

(define (sum-square x y)
  (+ (square x) (square y)))

(define (sum-square-max x y z) 
  (cond ((> x y z) (sum-square x y))
        ((< x y z) (sum-square y z))
        (else (sum-square x z))))

(define (assert-eq expected actual)
  (cond ((= expected actual) (display "."))
        (else (display "F"))))

(assert-eq 13 (sum-square-max 1 2 3))
(assert-eq 18 (sum-square-max 3 2 3))
(assert-eq 13 (sum-square-max 3 2 1))
(assert-eq 18 (sum-square-max 3 3 3))
(display "\n")
