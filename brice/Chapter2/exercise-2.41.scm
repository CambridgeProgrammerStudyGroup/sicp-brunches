#lang racket
(require "../utils.scm")
(require "../meta.scm")

(title "Exercise 2.41")

; Exercise 2.41.  Write a procedure to find all ordered triples 
; of distinct positive integers i, j, and k less than or equal 
; to a given integer n that sum to a given integer s.

(define (flatmap proc seq)
  (accumulate append nil (map proc seq)))

(define (enumerate-interval low high)
  (if (> low high)
      nil
      (cons low (enumerate-interval (+ low 1) high))))

(define (sum-to-n n)
	(lambda (xs) (= n (reduce + xs))))

(define (triple-check n s)
	(let* (
		(xs (enumerate-interval 1 n))
		(sumcorrect? (sum-to-n s))
		(pred (lambda (ts) (and (apply < ts) (sumcorrect? ts)))))

		(filter pred
			(flatmap (lambda (i)
				(flatmap (lambda (j) 
					(map (lambda (k) (list i j k))
						xs
					)) xs) 
			) xs))))


(let* 
	(
		(A '((1 2 5) (1 3 4)))
	)

	(assert "We can check if three numbers sum to n" 
		((sum-to-n 5) '(1 3 2 -1)))
	(assertequal? "We can use triple-check to find triples of numbers below a threshold that add to a certain sum."
		A (triple-check 6 8))

	)