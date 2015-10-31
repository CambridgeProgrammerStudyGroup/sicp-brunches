;EXERCISE 1.10
(define (A m n)
  (cond ((= n 0) 0)
        ((= m 0) (* 2 n))
        ((= n 1) 2)
        (else (A (- m 1)
                 (A m (- n 1))))))

(A 1 10) ;-> 1024
(A 2 4) ;-> 65536
(A 3 3) ;-> 65536

(define (f n) (A 0 n)) ;-> f(n)=2n by substitution

(define (g n) (A 1 n)) ;-> g(n) = 2^n = 2↑n
; taking the definition for A:
;          | if y=0; 0
; A(x,y) = | if x=0; 2y
;          | if y=1; 2
;          | A(x-1, A(x,y-1)) otherwise.
;
; therefore, for positive numbers:
; A(1,n) = A(0, A(1, n-1))
;        = A(0, A(0, A(1, n-2))
;        = A(0, A(0, A(0, A(1, n-3))
;        = A(0, A(0, A(0, ... A(1, n-(n-1)))))
;        = 2 x 2 x 2 ... x 2
;        = 2^n
;               | if n>0; 2^n
; =>     g(n) = | if n=0; 0
;               | undefined? Positive countable infinity of (2^inf)


(define (h n) (A 2 n)) ;-> h(n) = 2^(h(n - 1)) = 2↑↑n
; expanding A(2,n):
;
; A(2,n) = A(1, A(2, n-1))
;        = A(1, A(1, A(2, n-2))
;        = A(1, A(1, A(1, A(2, n-3))
;        = 2 ^ 2 ^ 2 ... ^ A(2, n-(n-1))
;        = 2 ^ 2 ^ 2 ... ^ 2
;        = 2 ^^ n
; therefore 
;               | if n>0; 2^^n
; =>     h(n) = | if n=0; 0
;               | if n<0; positive countable infinity of 2^^inf
; 
; generally, A(x,y) = 2↑ˣy

(define (k n) (* 5 n n)) ;-> k(n) = 5n²

; we can see from the above and from exploring the definiton 
; that the general form of the ackerman function above then becomes
;
; A(m,n) = 2↑ᵐn
;