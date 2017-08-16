#lang sicp

(#%require "common.scm")

;   Exercise 3.10
;   =============
;   
;   In the make-withdraw procedure, the local variable balance is created as
;   a parameter of make-withdraw.  We could also create the local state
;   variable explicitly, using let, as follows:
;   
;   (define (make-withdraw initial-amount)
;     (let ((balance initial-amount))
;       (lambda (amount)
;         (if (>= balance amount)
;             (begin (set! balance (- balance amount))
;                    balance)
;             "Insufficient funds"))))
;   
;   Recall from section [1.3.2] that let is simply syntactic sugar for a
;   procedure call:
;   
;   (let ((<var> <exp>)) <body>)
;   
;   is interpreted as an alternate syntax for
;   
;   ((lambda (<var>) <body>) <exp>)
;   
;   Use the environment model to analyze this alternate version of
;   make-withdraw, drawing figures like the ones above to illustrate the
;   interactions
;   
;   (define W1 (make-withdraw 100))
;   
;   (W1 50)
;   
;   (define W2 (make-withdraw 100))
;   
;   Show that the two versions of make-withdraw create objects with the same
;   behavior.  How do the environment structures differ for the two
;   versions?
;   
;   ------------------------------------------------------------------------
;   [Exercise 3.10]: http://sicp-book.com/book-Z-H-21.html#%_thm_3.10
;   [Section 1.3.2]: http://sicp-book.com/book-Z-H-12.html#%_sec_1.3.2
;   3.2.3 Frames as the Repository of Local State - p248
;   ------------------------------------------------------------------------

(-start- "3.10")

(prn"
  global env                                                               
  ==========                                                               
       │                                                                   
       v                                                                   
 ┌────────────────────────────────────────────────────────────────────────┐
 │make-withdrawl:                                                         │
 │     │                                    W1:                           │
 └────────────────────────────────────────────────────────────────────────┘
       │ ^               ^                    │
       v │               │                    │
      @ @┘               │                    │ 
  para: intitial-amount  │                    │
  (let ...               │                    │
                         │                    │
                         │                    │
                   ┌───────────────────┐      │
               E'1 │initial-amount: 100│      │
                   └───────────────────┘      │
                         ^                    │
                         │                    │
                         │                    │
                   ┌───────────────────┐      │
               E'2 │balance: 100       │      │
                   └───────────────────┘      │
                         │       ^            v
                         │       └─────────────┐
                         │                   @ @
                         │               para: amount
                         │               (lambda (amount)...
                         │                    
                   ┌───────────────────┐      
               E'3 │amount: 50         │      
                   └───────────────────┘      
                   (if (>= balance...

The models are similar, E'3 and E'2 are similar to E2 and E1 in the prevous
model.  The major diference is that this model's E'1 with 'initial-amount'
did not exist in the previous model.  However intial-amount is not
referenced in any of the code used by W1 so if presence of the frame and
the value it contains does not affect the execution.  I.e. the
""(if (>= balance ..."" code is the same in both models and is running in an
environment that is essentially identical in both models.
")

(--end-- "3.10")

