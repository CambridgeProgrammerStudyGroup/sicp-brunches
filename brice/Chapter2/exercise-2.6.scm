#lang racket
(require "../utils.scm")
(require "../meta.scm")

; Exercise 2.6: 
;
; In case representing pairs as procedures wasn’t
; mind-boggling enough, consider that, in a language 
; that can manipulate procedures, we can get by 
; without numbers (at least insofar as nonnegative 
; integers are concerned) by implementing 0 and the 
; operation of adding 1 as:

(define zero 
	(lambda (f) 
		(lambda (x) x))) 

(define (add-1 n)
	(lambda (f) 
		(lambda (x) 
			(f ((n f) x)))))

; This representation is known as Church numerals, 
; after its inventor, Alonzo Church, the logician who 
; invented the λ-calculus.
;
; Define one and two directly (not in terms of zero 
; and add-1). 
;
; Hint: Use substitution to evaluate (add-1 zero). 
;
; Give a direct definition of the addition procedure + 
; (not in terms of repeated application of add-1).


(define one
	(lambda (f) 
		(lambda (x) 
			(f x))))

(define two
	(lambda (f) 
		(lambda (x) 
			(f (f x)))))

(define three
	(lambda (f) 
		(lambda (x) 
			(f (f (f x))))))

; turning church numerals into integers for testing
(define (cn-to-int cn)
	((cn inc) 0))

(asserteq "Expect λf.λx.x to be 0" 0 (cn-to-int zero))
(asserteq "Expect λf.λx.fx to be 1" 1 (cn-to-int one))
(asserteq "Expect λf.λx.f(fx) to be 2" 2 (cn-to-int two))
(asserteq "Expect λf.λx.f(f(fx)) to be 3" 3 (cn-to-int three))

(define (int-to-cn i)
	(lambda (f)
		(lambda (x)
			((repeated f i) x))))

(asserteq "We can convert ints to church numerals" 
	5 (cn-to-int (int-to-cn 5)))

(define (add-cn a b)
	"λa.λb.λf.λx.(a f) ((b f) x)"
	(lambda (f)
		(lambda (x) 
			((a f) ((b f) x)))))

(asserteq "Adding 1 to 1 in church numeral yields 2"
	2
	(cn-to-int (add-cn one one)))

(asserteq "Adding 2 to 1 in church numeral yields 3"
	3
	(cn-to-int (add-cn two one)))

(asserteq "Adding 1 to 2 in church numeral yields 3"
	3
	(cn-to-int (add-cn one two)))

(asserteq "Adding 2 to 2 in church numeral yields 4"
	4
	(cn-to-int (add-cn two two)))


(define (expt-cn a b)
	"λa.λb.b a"
	(b a))

(asserteq "Exponentiation works for even exponents" 
	(expt 2 8) 
	(cn-to-int (expt-cn two (int-to-cn 8))))

(asserteq "Exponentiation works for odd exponents" 
	(expt 4 5) 
	(cn-to-int (expt-cn (int-to-cn 4) (int-to-cn 5))))


(define (mul-cn a b)
	"λa.λb.λf.a (b f)"
	(lambda (f)
			(a (b f))))

(asserteq "Multiplication works for 2 x 2"
	4
	(cn-to-int (mul-cn two two)))

(asserteq "Multiplication works for 2 x 3"
	6
	(cn-to-int (mul-cn two three)))

(asserteq "Multiplication works for 123 x 87"
	(* 123 87)
	(cn-to-int (mul-cn (int-to-cn 123) (int-to-cn 87))))


; What about divide? Substract? Boolean logic?



