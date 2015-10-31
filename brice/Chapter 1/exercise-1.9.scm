; Excercise 1.9:
(define (inc a)
  (+ a 1))

(define (dec a)
  (- a 1))

; Look at the differences between 
'( 
 
 (define (+ a b)
   (if (= a 0)
       b
       (inc (+ (dec a) b))))

; and 

 (define (+ a b)
   (if (= a 0)
       b
       (+ (dec a) (inc b))))

)

; Definition 1
; (define (+ a b)
;   (if (= a 0)
;       b
;       (inc (+ (dec a) b))))

(+ 4 5)
(inc (+ 3 5))
(inc (inc (+ 2 5)))
(inc (inc (inc (+ 1 5))))
(inc (inc (inc (inc (+ 0 5)))))
(inc (inc (inc (inc 5))))
(inc (inc (inc 6)))
(inc (inc 7))
(inc 8)
9

; Definition 2
;
; (define (+ a b)
;   (if (= a 0)
;       b
;       (+ (dec a) (inc b))))

(+ 4 5)
(+ 3 6)
(+ 2 7)
(+ 1 8)
(+ 0 9)
9


; The first process is recursive, whilst the second is iterative. Both functions are recursive.
; The reason for the difference is that the second process is tail-recursive: it recurses on itself
; at the final call in the hierarchy; the first process is not, it recurses on itself at the last-but
; -one call in the hierarchy.

; Are all tail-recursive functions iterative? 
; defining a tail-recursive version of the factorial function creates an iterative process.
; This is generally true, as tail-recursive calls can be optimised to jumps and compile to the 
; same machine code as while loops.

(define (fac a)
  (define (fac-iter a b)
    (if (= a 1)
        b
        (fac-iter (dec a) (* a b))
    ))
  (fac-iter a 1))

(= (fac 5) (* 5 4 3 2 1))

; let's try and implement the 'for' looping construct using tail recursion.

(define (for environment predicate step action)
  (if (predicate environment)
      (and
       (action environment)
       (for (step environment) predicate step action))
      environment))

(for 0 (lambda (a) (< a 10)) inc print)

; Excercise 1.9 (in the first edition):
; design an a procedure that evolves an iterative process for solving the change 
; counting problem. For simplicity you may wish to start by considering only two 
; or three kinds of coins