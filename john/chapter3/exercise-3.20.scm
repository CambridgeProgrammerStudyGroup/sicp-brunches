#lang sicp

(#%require "common.scm")

;   Exercise 3.20
;   =============
;   
;   Draw environment diagrams to illustrate the evaluation of the sequence
;   of expressions
;   
;   (define x (cons 1 2))
;   (define z (cons x x))
;   (set-car! (cdr z) 17)
;   (car x)
;   17
;   
;   using the procedural implementation of pairs given above.  (Compare
;   exercise [3.11].)
;   
;   ------------------------------------------------------------------------
;   [Exercise 3.20]: http://sicp-book.com/book-Z-H-22.html#%_thm_3.20
;   [Exercise 3.11]: http://sicp-book.com/book-Z-H-22.html#%_thm_3.11
;   3.3.1 Mutable List Structure - p261
;   ------------------------------------------------------------------------

(-start- "3.20")

(prn"

It's tempting to use different symbols in question's code so that
    (define x (cons 1 2))
becomes:
    (define a (cons 1 2))
to avoid potential (human) ambiguity between the x, y and z used in the
question and the x, y and z used in the definition of cons.  But I suspect
the re-use of symbols is intentional to emphasise they are different
identifiers because they exist in different contexts/environments.


                                                          
            para: x                                        para: z          
            para: y              para: z      para: z      para: new-value  
          (define (set-x!...    (z 'car)     (z 'cdr)     ((z 'set-car!) ...
                @ @ ─┐             @ @ ─┐       @ @ ─┐          @ @ ─┐
                 ^   │              ^   │        ^   │           ^   │
Global Env ──┐   │   │              │   │        │   │           │   │
             v   │   v              │   v        │   v           │   v
┌──────────────────────────────────────────────────────────────────────────┐
│cons: ──────────┘                  │            │               │         │
│car: ──────────────────────────────┘            │               │         │
│cdr: ───────────────────────────────────────────┘               │         │
│set-car!: ──────────────────────────────────────────────────────┘         │
│                                                                          │
│(after calls to cons)                                                     │
│x:┐                                   z:┐                                 │
└──────────────────────────────────────────────────────────────────────────┘
   │                              ^      │                              ^
   │                              │      │                              │
   │                              │      │                              │
   │ ,────────────────────────────│──────│─────────┐                    │
   │/                             │      │         │                    │
   │                call to cons  │      │         │      call to cons  │
   │     ┌───────────────────────────┐   │     ┌───────────────────────────┐
   │E1 ->│x: 1                       │   │E2 ->│x:─┘                       │
   │     │y: 2                       │   │     │y:─┘                       │
   │     │set-x!;────────────────┐   │   │     │set-x!;────────────────┐   │
   │     │set-y!:─────────┐      │   │   │     │set-y!:─────────┐      │   │
   │     │dispatch:┐      │      │   │   │     │dispatch:┐      │      │   │
   │     └───────────────────────────┘   │     └───────────────────────────┘
   │               │  ^   │  ^   │  ^    │               │  ^   │  ^   │  ^
   └───────────────│  │   │  │   │  │    └───────────────│  │   │  │   │  │
                   v  │   v  │   v  │                    v  │   v  │   v  │
                  @ @ │  @ @ │  @ @ │                   @ @ │  @ @ │  @ @ │
                  │ └─┘  │ └─┘  │ └─┘                   │ └─┘  │ └─┘  │ └─┘
                  │      │      │                       │      │      │
                  │─────────────────────────────────────┘      │      │
                  │      │      │                              │      │
                  │      └────────────────────────┐────────────┘      │
                  │             │                 │                   │
                  │             └──────────────────────────────────┐──┘ 
                  │                               │                │
                  │                               │                │
                  │                               │                │
                  v                               v                v
         parameter: m                        parameter: v     parameter: v
      (define (dispatch m)                    (set! x v)       (set! y v) 
     	    (cond ((eq? m 'car) x)                                
                ((eq? m 'cdr) y)                                
                ((eq? m 'set-car!) set-x!)                         
                ((eq? m 'set-cdr!) set-y!)                         
                (else ... )))

 
                call to cdr
         ┌───────────────────────────┐
    E3 ->│z: z                       │ -> Global Env
         │                           │
         └───────────────────────────┘
         
         
                        call to z (dispatch)
                   ┌───────────────────────────┐
              E4 ->│m: 'cdr                    │ -> E2
                   │                           │
                   └───────────────────────────┘
                        (returns x)  
                        
                   
         
                call set-car!
         ┌───────────────────────────┐
    E5 ->│z: x                       │ -> Global Env
         │new-value: 17              │
         │                           │
         └───────────────────────────┘  
         
         
                       call to x (dispatch)
                   ┌───────────────────────────┐
              E6 ->│m: 'set-car                │ -> E1
                   │                           │
                   └───────────────────────────┘  
         
         
                                 call to set-x!
                             ┌───────────────────────────┐
                        E7 ->│v: 17                      │ -> E1
                             │                           │
                             └───────────────────────────┘  
                             
         

                call to car
         ┌───────────────────────────┐
    E8 ->│z: x                       │ -> Global Env
         │new-value: 17              │
         │                           │
         └───────────────────────────┘  


                       call to x (dispatch)
                   ┌───────────────────────────┐
              E9 ->│m: 'car                    │ -> E1
                   │                           │
                   └───────────────────────────┘  
                        (returns 17)
")
(--end-- "3.20")

