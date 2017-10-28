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
  ┌┘                              │      │                              │
  │                               │      │                              │
  │ ,─────────────────────────────────────────────────┐                 │
  │/                              │      │            │                 │
  │                               │      │            │                 │
  │ ,──────────────────────────────────────────────┐  │                 │
  │/                              │      │         │  │                 │
  │              call to cons     │      │         │  │   call to cons  │
  v      ┌────────────────────────┴──┐   │     ┌────────────────────────┴──┐
  │      │x: 1                       │   │     │x:─┘  │                    │
  │ E1 ->│ (x: 17 after set-x!)      │   │ E2->│      │                    │
  │      │y: 2                       │   │     │y:────┘                    │
  │      │set-x!;────────────────┐   │   │     │set-x!;────────────────┐   │
  │      │set-y!:─────────┐      │   │   │     │set-y!:─────────┐      │   │
  │      │dispatch:┐      │      │   │   │     │dispatch:┐      │      │   │
  │      └───────────────────────────┘   │     └───────────────────────────┘
  │                │  ^   │  ^   │  ^    │               │  ^   │  ^   │  ^
  ├──>─────────────│  │   │  │   │  │    └──┬──>─────────┤  │   │  │   │  │
  │                v  │   v  │   v  │       │            v  │   v  │   v  │
  │               @ @ │  @ @ │  @ @ │       │           @ @ │  @ @ │  @ @ │
  │               │ └─┘  │ └─┘  │ └─┘       │           │ └─┘  │ └─┘  │ └─┘
  │               │      │      │           │           │      │      │
  │               ├─────────────────────────────────────┘      │      │
  │               │      │      │           │                  │      │
  │               │      └──────────────────────────┬──────────┘      │
  │               │             │           │       │                 │
  │               │             └───────────────────────────────────┬─┘ 
  │               │                         │       |               │
  │               │                         │       │               │
  │               │                         │       │               │
  │               v                         │       v               v
  │      parameter: m                       │  parameter: v    parameter: v
  │   (define (dispatch m)                  │   (set! x v)      (set! y v) 
  │        (cond ((eq? m 'car) x)           │                     
  │             ((eq? m 'cdr) y)            │   
  │             ((eq? m 'set-car!) set-x!)  │        
  │             ((eq? m 'set-cdr!) set-y!)  │        
  │             (else ... )))               │
  │                                         │
  │                                         │
  │                                         │
  │         ┌───────────────────────────────┘
  │         │              
  │         │     call to cdr               
  │      ┌───────────────────────────┐                   
  │      │z:┘                        │ 
  │ E3 ─>│                           ├─> Global Env                      
  │      │                           │
  │      └───────────────────────────┘                   
  │                                                      
  │                                                      
  │                     call to z (dispatch)             
  │                ┌───────────────────────────┐         
  │                │m: 'cdr                    │
  │           E4 ─>│                           ├─> E2         
  │                │                           │
  │                └───────────────────────────┘         
  │                     (returns 'x')                    
  │                                                      
  ^                                                      
  │         
  ├─────────┐         
  │         │   call set-car!   
  │      ┌───────────────────────────┐
  │      │z:┘                        │ 
  │ E5 ─>│new-value: 17              ├─> Global Env
  │      │                           │
  │      └───────────────────────────┘  
  │      
  │      
  │                    call to x (dispatch)
  │                ┌───────────────────────────┐
  │                │m: 'set-car                │ 
  │           E6 ─>│                           ├─> E1
  │                │                           │
  │                └───────────────────────────┘  
  │      
  │      
  │                              call to set-x!
  │                          ┌───────────────────────────┐
  │                          │v: 17                      │ 
  │                     E7 ─>│                           ├─> E1
  │                          │                           │
  │                          └───────────────────────────┘  
  │                                 (E1 modified)
  │      
  ^      
  │      
  └─────────┐
            │     call to car
         ┌───────────────────────────┐
         │z:┘                        │ 
    E8 ─>│new-value: 17              ├─> Global Env
         │                           │
         └───────────────────────────┘  


                       call to x (dispatch)
                   ┌───────────────────────────┐
                   │m: 'car                    │ 
              E9 ─>│                           ├─> E1
                   │                           │
                   └───────────────────────────┘  
                        (returns 17)

")

(--end-- "3.20")

