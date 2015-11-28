#lang racket
(require "../utils.scm")
(require "../meta.scm")

; Exercise 1.45: 
;
; We saw in Section 1.3.3 that attempting to compute 
; square roots by naively finding a fixed point of 
;
;     y  → x/y 
; 
; does not converge, and that this can be fixed by 
; average damping. The same method works for finding 
; cube roots as fixed points of the average-damped 
;
;     y  → x/y². 
;
; Unfortunately, the process does not work for fourth 
; roots – a single average damp is not enough to make 
; a fixed-point search for 
;
;      y  → x/y³ 
;
; converge. On the other hand, if we average damp 
; twice (i.e., use the average damp of the average damp 
; of y  → x/y³) the fixed-point search does converge. 
;
; Do some experiments to determine how many average damps 
; are required to compute nth roots as a fixed point 
; search based upon repeated average damping of 
;
;     y  → x/y^(n−1)
; 
; Use this to implement a simple procedure for computing 
; nth roots using fixed-point, average-damp, and the 
; repeated procedure of Exercise 1.43. Assume that any 
; arithmetic operations you need are available as primitives.


(define (nth-root-fixer n x)
	(lambda (y) (/ x (expt y (dec n)))))

(define (compute-root root x damp-ntimes)
	(fixed-point
		((repeated average-damp damp-ntimes) (nth-root-fixer root x))
		1.0))

(define (test-root root x ndamp)
	(display 
		(format 
			"~a root of ~a requires ~a average-dampening and results in ~a\n" 
			root x ndamp (compute-root root x ndamp))))

(test-root 2 4.0 1)
(test-root 3 8.0 1)
(test-root 4 16.0 2)
(test-root 5 32.0 2)
(test-root 6 64.0 2)
(test-root 7 128.0 2)
(test-root 8 256.0 3)
(test-root 9 512.0 3)
(test-root 10 1024.0 3)
(test-root 11 2048.0 3)
(test-root 12 4096.0 3)
(test-root 13 8192.0 3)
(test-root 14 16384.0 3)
(test-root 15 32768.0 3)
(test-root 16 65536.0 4)

;    Maximum n: 3 7 15
; average damp: 1 2  3
;
; Therefore nmax = 2^(average_damp+1) -1
;
; We can test this at a boundary, for example, average damp 4 => maximum 2^5-1 => maximum 31

(test-root 31 2147483648 4) ;-> terminates
#;(test-root 32 4294967296 4) ;-> doesn't

; Therefore, 
;
; log₂(nmax) ~ avg_damp


(define (log2 x)
  (/ (log x) (log 2)))

(define (autodamp-root n x)
	(compute-root n x (log2 n)))

(autodamp-root 2 4.0)
(autodamp-root 3 8.0)
(autodamp-root 4 16.0)
(autodamp-root 5 32.0)
(autodamp-root 6 64.0)
(autodamp-root 7 128.0)
(autodamp-root 8 256.0)
(autodamp-root 9 512.0)
(autodamp-root 10 1024.0)
(autodamp-root 11 2048.0)
(autodamp-root 12 4096.0)
(autodamp-root 13 8192.0)
(autodamp-root 14 16384.0)
(autodamp-root 15 32768.0)
(autodamp-root 16 65536.0)

;(fixed-point (average-damp fn) guess)








