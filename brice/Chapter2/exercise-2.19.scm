#lang racket
(require "../utils.scm")
(require "../meta.scm")

(title "Exercise 2.19")

(define (no-more? coins)
	(empty? coins))

(define (except-first-denomination coins)
	(cdr coins))

(define (first-denomination coins)
	(car coins))

(define (cc amount coin-values)
  (cond ((= amount 0) 1)
        ((or (< amount 0) (no-more? coin-values)) 0)
        (else
         (+ (cc amount
                (except-first-denomination coin-values))
            (cc (- amount
                   (first-denomination coin-values))
                coin-values)))))

(define us-coins (list 50 25 10 5 1))
(define uk-coins (list 100 50 20 10 5 2 1 0.5))


(asserteq "Only one way to return a cent" (cc 1 us-coins) 1)
(asserteq "Only one way to return 2 cents" (cc 2 us-coins) 1)
(asserteq "Two ways of retunrning 5 cents" (cc 5 us-coins) 2)
(asserteq "It gets more complicated for british currency" (cc 5 uk-coins) 13)
(asserteq "The order of the list doesn't matter" (cc 17 uk-coins) (cc 17 (reverse uk-coins)))

(prn "
No, The answers returned by cc will not change 
when the list is in a different order.

Since the procedure will recurse into each branch 
for each change amount, changing the order of the 
coins will change the shape of the call tree created,
but not fundamentally affect the answer. 

However, in a real scenario, the order of the coins could
affect the time it takes to return the first solution.")
