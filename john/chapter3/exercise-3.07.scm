#lang sicp

(#%require "common.scm")

;   Exercise 3.7
;   ============
;   
;   Consider the bank account objects created by make-account, with the
;   password modification described in exercise [3.3].  Suppose that our
;   banking system requires the ability to make joint accounts.  Define a
;   procedure make-joint that accomplishes this.  Make-joint should take
;   three arguments.  The first is a password-protected account.  The second
;   argument must match the password with which the account was defined in
;   order for the make-joint operation to proceed.  The third argument is a
;   new password.  Make-joint is to create an additional access to the
;   original account using the new password.  For example, if peter-acc is a
;   bank account with password open-sesame, then
;   
;   (define paul-acc
;     (make-joint peter-acc 'open-sesame 'rosebud))
;   
;   will allow one to make transactions on peter-acc using the name paul-acc
;   and the password rosebud.  You may wish to modify your solution to
;   exercise [3.3] to accommodate this new feature.
;   
;   ------------------------------------------------------------------------
;   [Exercise 3.7]:  http://sicp-book.com/book-Z-H-20.html#%_thm_3.7
;   [Exercise 3.3]:  http://sicp-book.com/book-Z-H-20.html#%_thm_3.3
;   3.1.3 The Costs of Introducing Assignment - p236
;   ------------------------------------------------------------------------

(-start- "3.7")

(define (make-account initial-password balance)
  (define (withdraw amount)
    (if (>= balance amount)
        (begin (set! balance (- balance amount))
               balance)
        "Insufficient funds"))
  (define (deposit amount)
    (set! balance (+ balance amount))
    balance)
  (define (dispatch given-password m)
    (if (eq? initial-password given-password)
        (cond ((eq? m 'withdraw) withdraw)
              ((eq? m 'deposit) deposit)
              (else (error "Unknown request -- MAKE-ACCOUNT"
                           m)))
        (lambda (_) "Incorrect Password")))
  dispatch)

(define (make-joint base-account base-password initial-password)
  (define (dispatch given-password m)
    (if (eq? initial-password given-password)
        (base-account base-password m)
        (lambda (_) "Incorrect Password")))
  dispatch)

(prn "Create Peter's account with 200")
(define peter-acc (make-account 'open-seseme 200))
(prn "
And withdraw 10")
((peter-acc 'open-seseme 'withdraw) 10)

(prn "
Create Paul's account as joint account")
(define paul-acc (make-joint peter-acc 'open-seseme 'rosebud))
(prn "
And withdraw 3")
((paul-acc 'rosebud 'withdraw) 3)

(prn "
Use wrong password on Paul's account")
((paul-acc 'open-seseme 'withdraw) 3)


(prn "
Use wrong password on Peter's account")
((peter-acc 'rosebud 'withdraw) 3)

(prn "
And withdraw 10 from Peter (and demonstrate shared state).")
((peter-acc 'open-seseme 'withdraw) 10)

(prn "
Seems to work.  A weakness of this is that Paul's acount depends on
Peter's.  I.e. Paul can close his account without affecting Peter but
Peter cannot close his without affecting Paul.  A neater solution would
allow the account functions to exist independenlty of the identity
functions.  E.g. symmetric Peter & Paul wrapper could point to the same
shared (but anonymous) account instance.")
(--end-- "3.7")

