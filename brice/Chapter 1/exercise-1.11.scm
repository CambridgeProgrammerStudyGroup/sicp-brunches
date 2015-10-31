; EXCERCISE 1.11
;        | if n<3; n
; f(n) = | if n>=3; f(n-1) + 2f(n-2) + 3f(n-3)
; write an iterative and recursive process for this function.

; recursive process, recursive function
(define (f1.11r n)
  (cond ((< n 3) n)
        (else (+ (f1.11r (dec n)) (* 2 (f1.11r (- n 2))) (* 3 (f1.11r (- n 3)))))))

; a <- b 
; b <- c
; c <- c + 2b + 3a

(define (dec x) (- x 1))

; iterative process, recursive function
(define (f1.11i n)

  (define (f-bare a b c)
  	(+ a (* 2 b) (* 3 c)))

  (define (iter a b c count)
    (cond 
    	((= count 0) a)
        (else        (iter b c (f-bare c b a) (dec count)))))
  
  (iter 0 1 2 n))

; Util functions...
(define (test n) (print (list n (f1.11r n) (f1.11i n))))

(define (for environment predicate step action)
  (if (predicate environment)
      (and
       (action environment)
       (for (step environment) predicate step action))
      environment))

(for 0 (lambda (x) (< x 10)) inc test)

; 
; For f(n) we're going over the expanded terms of the computation right to left.
; We could re-write this process as the term substitution process below:
; 
; a <- b
; b <- c
; c <- c + 2b + 3a
; 
; which we carry out n times, the result being in 'a'

