#lang racket

(provide (all-defined-out))

(define nil '())

(define (inc x) (+ x 1))
(define (dec x) (- x 1))
(define (square x) (* x x))

(define (str . parts)
  (define strParts (map ~a parts))
  (apply string-append  strParts ))

(define (prn . lines)
  (for-each
   (lambda (line) (display (str line "\n")))
   lines))

(define (title ti)
  (let ((long (make-string 60 #\-)))
  	(prn "" long ti long "")))

(define (show smth)
	(display (format "~a\n" smth)))

(define (reporterr msg)
	(display "ERROR: ")
	(display msg)
	(newline))

(define (reportok msg)
	(display "OK: ")
	(display msg)
	(newline))

(define (assert msg b)
  (if b (reportok msg) (reporterr msg)))

(define (asserteq msg a b)
	(let ((pass (> 0.0001 (abs ( - a b)))))
  		(assert msg pass)
  		(cond ((not pass)
  			(display (format "    Expected ~a got ~a\n" a b))))))

(define (assertequal? msg a b)
	(if (equal? a b)
		(reportok msg)
		(begin
			(reporterr msg)
			(display (format "    Expected: ~a\n" a))
			(display (format "    Got:      ~a\n" b)))))

(define-syntax assert-raises-error
	(syntax-rules ()
		[(assertraises msg body) 
			(with-handlers 
				([exn:fail? (lambda (ex) (reportok msg))]) 
				(begin body (reporterr msg)))]))


(define (average a b)
	(/ (+ a b) 2))

(define (repeat x n)
	
	(define (intern i seq)
		(if (> i 0)
			(intern (dec i) (cons x seq))
			seq))
	
	(intern n '()))

(define (gcd a b) 
	(if (= b 0)
		a
      	(gcd b (remainder a b))))

(define (sign n)
	(/ n (abs n)))

(define accumulate foldr)

(define (accumulate-n op init seqs)
  (if (null? (car seqs))
      nil
      (cons (foldr op init (map first seqs))
            (accumulate-n op init (map rest seqs)))))

(define (flatten xs)
	(foldr append (map first xs) '()))

(define (any? pred xs)
	(not (empty? (filter identity (map pred xs)))))

(define (zip . xs)
	(if (any? empty? xs)
		'()
		(cons 
			(map first xs)
			(apply zip (map rest xs)))))

;; Naive primality testing
(define (smallest-divisor n)
  (find-divisor n 2))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (inc test-divisor)))))

(define (divides? a b)
  (= (remainder b a) 0))

(define (prime? n)
  (= n (smallest-divisor n)))

(define (reduce func xs)
  (if (empty? (cdr xs))
      (car xs)
      (func (car xs) (reduce func (cdr xs)))))

