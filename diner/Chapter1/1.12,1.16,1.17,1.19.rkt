#lang racket

(define (f n) (if (< n 3) n
                  (+ (f (- n 1)) (* 2 (f (- n 2))) (* 3 (f (- n 3))))))

(define (f-new n) (if (< n 3) n
                      (f-iter 0 1 2 (- n 2))))

(define (f-iter a b c count) (if (= count 0) c
                                 (f-iter b c (+ c (* 2 b) (* 3 a)) (- count 1))))

;(f-new 4)
;(f 4)

;(f-new 5)
;(f 5)

;(f-new 1000)
;(f 10)

"Exercise 1.12"

(define (pascal row col)
  (cond ((= col 0) 1)
        ((= row col) 1)
        (else (+ (pascal (- row 1) (- col 1)) (pascal (- row 1) col)))))

;(pascal 50 25)

"Exercise 1.16"

(define (fast-exp b n) (fast-exp-iter b n 1))

(define (fast-exp-iter b n a) (if (= n 0) a
                                  (fast-exp-iter (* b b)
                                                 (quotient n 2)
                                                 (*
                                                  (if (odd? n) b 1)
                                                  a))))

"Exercise 1.17"

(define (fast-multiplication b n) (fast-multiplication-iter b n 0))

(define (fast-multiplication-iter b n a) (if (= n 0) a
                                  (fast-multiplication-iter (+ b b)
                                                 (quotient n 2)
                                                 (+
                                                  (if (odd? n) b 0)
                                                  a))))

;(fast-multiplication 8 6)


(define (perform-operation operation neutral-element)
  (define (perform-operation-aux b n a)
    (if (= n 0) a
        (perform-operation-aux
         (operation b b)
         (quotient n 2)
         (operation a (if (odd? n) b neutral-element)))))
  
  (lambda (b n) (perform-operation-aux b n neutral-element)))

(define fast-exp2 (perform-operation * 1))
(define fast-mult2 (perform-operation + 0))


;(fast-mult2 2 4)

"Exercise 1.19"

(define (fib n)
  (fib-iter 1 0 0 1 n))

(define (fib-iter a b p q count)
  (cond ((= count 0) b)
        ((even? count)
         (fib-iter a
                   b
                   (+ (* q q) (* p p))
                   (+ (* q q) (* 2 p q))
                   (/ count 2)))
        (else (fib-iter (+ (* b q) (* a q) (* a p))
                        (+ (* b p) (* a q))
                        p
                        q
                        (- count 1)))))
