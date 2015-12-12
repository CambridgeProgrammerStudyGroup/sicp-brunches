; Implement 'accumulate' with the following signature:
;
; (accumulate combiner null-val term a next b)
;
; where 'term' 		-: (term n)-> value for index n
; where 'next' 		-: (next n)-> next index
; where 'a' 		-: the lowermost index
; where 'b' 		-: the uppermost index
; where 'combiner' 	-: (combiner x y) -> term to accumulate
; where 'null-val' 	-: initial term

; We have divided opinions on the explicit and implicit request 
; of excercise 1.32. 
;
; A reading of the excercise would imply that the expected solution 
; for 1.32.a is recursive, because of its wording regarding the use of 
; the null-value at the end, despite the explicit mention of two 
; different solutions in 1.32.b (ie: The authors had the recursive 
; solution in mind while writing the excercise)
;
; However, another reading does not read any implementation expectations
; in the excercise, in particular because of its explicit request in 
; 1.32.b for the alternative solution (recursive/iterative).


; According to the second reading, the exercise is requesting the 
; following process:
(define (accumulate-1 combiner null-val term a next b)

  (define (acc-iter acc n)
    (if (> n b)
      (combiner acc null-val)
      (acc-iter 
        (combiner acc (term n))
        (next n))))

  (acc-iter (term a) (next a)))

; We all agree that this seems counter-intuitive and does not reflect 
; common semantics for widely used and understood functions such as
; fold, reduce, collect, etc...


; While the following process does not sem to reflect the requirements
; of excercise 1.32.a, we believe this to be much closer to accepted 
; semantics and use of reduce, collect, fold, and it is the function 
; we would prefer to write. 
;
; The contentious wording in the excercise is 
;
; > ... `null-value` that specifies what base value to use
; > when the terms run out.
; 
; Which implies that the null values is to be used at the end of the 
; generate sequence defined by term a next b
;
(define (accumulate-2 combiner null-val term a next b)

  (define (acc-iter acc n)
    (if (> n b)
      acc
      (acc-iter 
        (combiner acc (term n))
        (next n))))

  (acc-iter null-val a))

; In order to make the algorithms more excplicit, we can use 'term',
; 'a', 'next', and 'b' to generate a sequence and deal with the sequence
; explicitly.

(define (mksequence term a next b)
  (define (mkseq seq n)
    (if (> n b)
      seq
      (mkseq (append seq (list n)) (next n))))

  (map term (mkseq `() a)))

(mksequence identity 0 inc 5);-> `(0 1 2 3 4 5)

; Left to right and right to left accumulating processes seem to have 
; different natural implementations.
;
; A left to right accumulation seems to most naturally be impemented 
; with an iterative process, while a right to left accumulation seems 
; to be most naturally implemented using a recusive process.

; Implementation note: Combiner expected signature:
;
; (combiner element accumulated-value)
; 
; The order matters when (combiner a b) =/= (combiner b a)
; this is only relevant when 
; 
;      (combiner <T> <T>) -> <T>
; 
; As 
;
;      (combiner <A> <B>) -> <A>
;
; would lead to a type error if used incorrectly...

(define (fold-left combiner acc seq)
  (if (empty? seq)
    acc
    (fold-left 
      combiner
      (combiner (first seq) acc)
      (rest seq))))

(fold-left + 0 `(1 2 3 4 5)) ;-> 15 

; This is an iterative left-to-right fold. Using the null-value
; as the initial value of the accumulated term. (ie: 'acc')

(define (fold-right combiner null-value seq)
  (if (empty? seq)
    null-value
    (combiner 
      (first seq)
      (fold-right combiner null-value (rest seq)))))

(fold-right + 0 `(1 2 3 4 5)) ;-> 15

; These implementations agree with Scheme's foldr and foldl
; Outstanding are iterative implementation of foldr and recursive
; implementation of foldl.

; TODO:
; Should foldr and foldl have the same answer for (fold / 1 `(...))?
; We should try with string building to prove differences.


(define (inc n) (+ 1 n))

(define (term n)
	(cond ((odd? n) (/ (+ n 1) (+ n 2)))
		  ((even? n) (/ (+ n 2) (+ n 1)))))

(define (accumulate combiner null-term term a next b)
	(define (iter a result)
		(if (> a b)
			result
			(iter (next a) (combiner (term a) result))))
	(iter a null-term))

(define (product term a next b) 
	(accumulate * 1 term a next b))

(define (accumulate-recur combiner null-term term a next b)
	(if (> a b) null-term
		(combiner 
			(term a) 
			(accumulate-recur combiner null-term term (next a) next b))))

(define (product-recur term a next b)
	(accumulate-recur * 1 term a next b))
	

(define (show t) (display (format "~a\n" t)))

(define (pi-iter n) (* 4.0 (product term 1 inc n)))
(define (pi-recur n) (* 4.0 (product-recur term 1 inc n)))

(show (pi-recur 1000))
(show (pi-iter 1000))
