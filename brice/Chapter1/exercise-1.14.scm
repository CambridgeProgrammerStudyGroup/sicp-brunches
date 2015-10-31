; Exercise 1.14 

; The counting change function as per sectio 1.2.2
(define (count-change amount)
  (cc amount 5))

(define (cc amount kinds-of-coins)
  (cond ((= amount 0) 1)
        ((or (< amount 0) (= kinds-of-coins 0)) 0)
        (else (+ (cc amount
                     (- kinds-of-coins 1))
                 (cc (- amount
                        (first-denomination kinds-of-coins))
                     kinds-of-coins)))))

(define (first-denomination kinds-of-coins)
  (cond ((= kinds-of-coins 1) 1)
        ((= kinds-of-coins 2) 5)
        ((= kinds-of-coins 3) 10)
        ((= kinds-of-coins 4) 25)
        ((= kinds-of-coins 5) 50)))

; breakdown for 11c
(count-change 11)
(cc 11 5)
(+ (cc 11 4) (cc (- 11 50) 5))
(+ (cc 11 4) 0)
(+ (+ (cc 11 3)    (cc (- 11 25) 4)) 0)
(+ (+ (cc 11 3) 0) 0)
(+ (+ (+ (cc 11 2)                                               (cc (- 11 10) 3)) 0) 0)
(+ (+ (+ (+ (cc 11 1)               (cc (- 11 5) 2))             (+ (cc 1 2)                       (cc (- 1 5) 3))) 0) 0)
(+ (+ (+ (+ (+ (cc 11 0) (cc 10 1)) (+ (cc 6 1) (cc (- 6 5) 2))) (+ (+ (cc 1 1) (cc (- 1 5) 2))    0)) 0) 0)


; Special case: All coins larger thabn Let us imagine a list of coins with all denominations larger than the change we wish to give.
; in this special case, we will attempt to change for every denomination and fail,
; and this will lead to a complexity of O(n), where n is the number of the coins.

; Can also be said: imagine k is the amount we are trying to change and N is a set of denominations. 
; if k < min(N) then complexity is O(N)
; This is also the case if we have only one kind of coins and len(N) = 1

