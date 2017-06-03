(define (square x) (* x x))
(define (sum-of-squares x y) (+ (square x) (square y)))
(define (max x y) (cond ((> x y) x) (else y)))
(define (two-largest-sum-of-squares x y z) (max (sum-of-squares x y) (max (sum-of-squares x z) (sum-of-squares y z))))

(two-largest-sum-of-squares 1 3 4)
