#lang racket
(require "../utils.scm")

(display "EXCERCISE 1.20\n")

(define (gcd a b)
	(if (= b 0)
		a
		(gcd b (remainder a b))))

; Illustrate the process needed for normal order evaluation and applicative order evaluation.
; For (gcd 206 40), how many `remainder` calls are needed for applicative order? For normal order?

; applicative order
(gcd 206 40)
(if #f 206 (gcd 40 (remainder 206 40)))
(if #f 206 (gcd 40 6))
(if #f 206 (if (= 6 0) 40 (gcd 6 (remainder 40 6))))
(if #f 206 (if (= 6 0) 40 (gcd 6 4)))
(if #f 206 (if (= 6 0) 40 (if (= 4 0) 6 (gcd 4 (remainder 6 4)))))
(if #f 206 (if (= 6 0) 40 (if (= 4 0) 6 (gcd 4 2))))
(if #f 206 (if (= 6 0) 40 (if (= 4 0) 6 (if (= 2 0) 4 (gcd 2 (remainder 4 2))))))
(if #f 206 (if (= 6 0) 40 (if (= 4 0) 6 (if (= 2 0) 4 (gcd 2 0)))))
(if #f 206 (if (= 6 0) 40 (if (= 4 0) 6 (if (= 2 0) 4 (if (= 0 0) 2 (...))))))
2
; therefore, for applicative order, `remainder` is called 4 times.

; Normal order (arguments evaluated when needed)
(gcd 206 40)

(if (= 40 0)
		206
		(gcd 40 (remainder 206 40)))

(if (= 40 0)
		206
		;(gcd 40 (remainder 206 40))
		(if (= (remainder 206 40) 0) ; #f
			40
			(gcd (remainder 206 40) (remainder 40 (remainder 206 40)))))

(if (= 40 0)
		206
		;(gcd 40 (remainder 206 40))
		(if (= (remainder 206 40) 0) ; #f
			40
			;(gcd (remainder 206 40) (remainder 40 (remainder 206 40)))))
			(if (= (remainder 40 (remainder 206 40)) 0) ; #f
				(remainder 206 40)
				(gcd (remainder 40 (remainder 206 40)) (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))))))

(if (= 40 0)
		206
		;(gcd 40 (remainder 206 40))
		(if (= (remainder 206 40) 0) ; #f
			40
			;(gcd (remainder 206 40) (remainder 40 (remainder 206 40)))))
			(if (= (remainder 40 (remainder 206 40)) 0) ; #f
				(remainder 206 40)
				;(gcd (remainder 40 (remainder 206 40)) (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))))))
				(if (= (remainder (remainder 206 40) (remainder 40 (remainder 206 40))) 0) ; #f
					(remainder 40 (remainder 206 40))
					(gcd (remainder (remainder 206 40) (remainder 40 (remainder 206 40))) (remainder (remainder 40 (remainder 206 40)) (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))))))))

(if (= 40 0)
		206
		;(gcd 40 (remainder 206 40))
		(if (= (remainder 206 40) 0) ; #f
			40
			;(gcd (remainder 206 40) (remainder 40 (remainder 206 40)))))
			(if (= (remainder 40 (remainder 206 40)) 0) ; #f
				(remainder 206 40)
				;(gcd (remainder 40 (remainder 206 40)) (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))))))
				(if (= (remainder (remainder 206 40) (remainder 40 (remainder 206 40))) 0) ; #f
					(remainder 40 (remainder 206 40))
					;(gcd (remainder (remainder 206 40) (remainder 40 (remainder 206 40))) (remainder (remainder 40 (remainder 206 40)) (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))))))))
					(if (= (remainder (remainder 40 (remainder 206 40)) (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))) 0) ; #t
						(remainder (remainder 206 40) (remainder 40 (remainder 206 40)))
						(gcd (remainder (remainder 40 (remainder 206 40)) (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))) (remainder (remainder (remainder 206 40) (remainder 40 (remainder 206 40))) (remainder (remainder 40 (remainder 206 40)) (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))))))))))


; for normal order, remainder is evaluated 18 times!

