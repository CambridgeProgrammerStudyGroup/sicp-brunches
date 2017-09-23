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

            para: x
            para: y              para: z      para: z
          (define (set-x!...    (z 'car)     (z 'cdr)
                @ @ ─┐             @ @ ─┐       @ @ ─┐
                 ^   │              ^   │        ^   │
Global Env ──┐   │   │              │   │        │   │
             v   │   v              │   v        │   v
 ┌────────────────────────────────────────────────────────────────────────┐
 │cons: ─────────┘                   │           │                        │
 │car: ──────────────────────────────┘           │                        │
 │cdr: ──────────────────────────────────────────┘                        │
 │x: ───────┐                                                             │
 │y: ─┐     │                                                             │
 │    │     │                                                             │
 └────────────────────────────────────────────────────────────────────────┘
      │     │
      │     │      ┌────────────┐            ┌────────────┐
      │     │ E1 ->│ x: 1       │        E2->│ x: 1       │
      │     │      │ y: 2       │            │ x: 1       │
      │     │      │ set-x!: ───│────────┐   │ x: 1       │
      │     │      │ set-y!: ┐  │        │   │ x: 1       │
      │     │      └────────────┘        │   └────────────┘
      │     v          ^     │ ^^        │
      │    @ @ ────────┘     │ │└────────│───┐
      │ cond ((eq?...        │ └─┐       │   │
                             v   │       v   │
                            @ @ ─┘      @ @ ─┘
                        (set! y v)  (set! x v)

      │
     @ @ ────────────────────────────
  cond ((eq?...
   
########################################
########################################


It's tempting to use different symbols in question's code so that
    (define x (cons 1 2))
becomes:
    (define a (cons 1 2))
to avoid potential (human) ambiguity between the x, y and z used in the
question and the x, y and z used in the definition of cons.  But I suspect
the re-use of symbols is intentional to emphasise they are different
identifiers because they exist in different contexts/environments.


Global:
    cons:
    car:
    cdr
    set-car:

    x:
    w:


call cdr:  --> global
    z: w   
    (z 'cdr)

call z: (arg-a) --> w's
    m: 'cdr  
   (cond ...

call set-car!:  --> global
    z: arg-a
    new-value: 17
    ((z 'set-car!) new-value)

    call z:  -->  w's
        z: arg-a (= y)
        m: 'set-car
        (y 'set-car)

call set-x! --> x's --> new x
    v: new-value
    set! x new-value

=========

call car  --> global
    z: x
    (z 'car)

call z  --> x's
   m:


call y:



")
(--end-- "3.20")

