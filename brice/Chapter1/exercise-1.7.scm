; Exercise 1.7
(define (sqrt-iter guess x)
  (if (good-enough? guess x) guess
          (sqrt-iter (improve guess x) x)))

; Statement: `good-enough?` will not be very effective 
;            for the root of small numbers
;
; Reasoning: Root will be smaller or close to the order of 
;            the threshold in the test, which means that the 
;            `good-enough?` function will return true prematurely.
;            For example:

(sqrt-iter 0.0001 0.0004) ;-> 0.0001

;
; Statement: Real calculations are almost always performed with 
;            limited precision
;
; Reasoning: We are usually limited by the register size of the 
;            floating point unit in the processor. Performing 
;            arbitrary precision calculation is expensive.
; 
; Statement: The `good-enough?` test is inadequate for large numbers.
; 
; Reasoning: The `improve` function will improve the guess to a limited 
;            precision inherent to the divide operation (depending on 
;            platform, etc...).
;            If the precision of the improvement is below the threshold 
;            of the `good-enough?` test, then a new improvement will be 
;            attempted. The precision of this will also be below the
;            threshold of the `good-enough?` test, causing infinite 
;            recursion. 
(define THRESHOLD 0.001)

; Old test relies on the answer being within THRESHOLD of the solution
(define (original-good-enough? previous-guess guess x)
  (< (abs (- (square guess) x)) THRESHOLD))

; New test relies on the difference between the previous and current  
; guess being a very small fraction of the current guess (less than THRESHOLD)
(define (new-good-enough? previous-guess guess x)
  (< (/ (abs (- previous-guess guess)) guess) THRESHOLD))

; For some reason, this alternative version of `good-enough?` seems to 
; give better results for small roots.
; For example, 
;
;     (new-sqrt-iter new-good-enough? 0 1 9e-4)         ;-> 0.030000012746348552
;     (new-sqrt-iter alternative-good-enough? 0 1 9e-4) ;-> 0.030000000000002705
; 
; This is due to the fact that the alternative function iterates one more
; than the new function. This can be seen by instrumenting the `new-sqrt-iter` 
; function with the following code: 
;
;     (printf "[~a] old: ~a new: ~a\n" x old-guess guess)
;
; and looking at the iteration sequence for both test functions
(define (alternative-good-enough? previous-guess guess x)
  (< (/ (abs (- previous-guess guess)) x) THRESHOLD))

(define (new-sqrt-iter end-predicate old-guess guess x)
  ;(printf "[~a] old: ~a new: ~a\n" x old-guess guess)
  (if (end-predicate old-guess guess x) guess
          (new-sqrt-iter end-predicate guess (improve guess x) x)))

; However, the `alternative-good-enough?` function fails for 
; large numbers as the fractional guess difference becomes small 
; relative to the x value and the function returns true too early.


; With the original `good-enough?` function, we get incorrect results
; for small numbers, however the `new-good-enough?` function returns the 
; correct values.
;
;     (new-sqrt-iter original-good-enough? 0 1 4e-4) ;-> 0.0354008825558513
;     (new-sqrt-iter new-good-enough? 0 1 4e-4)      ;-> 0.02
;
; For large numbers the new predicate will give worse results, as the 
; relative difference of the guesses is used to stop the iteration, and this 
; will lead to reduced absolute accuracy compared to using a fixed test to 
; stop the iteration.
