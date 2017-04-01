#lang racket

(require "common.rkt")

;   Exercise 3.30
;   =============
;   
;   Figure [3.27] shows a ripple-carry adder formed by stringing together n
;   full-adders.  This is the simplest form of parallel adder for adding two
;   n-bit binary numbers.  The inputs A₁, A₂, A₃, ..., A_(n) and B₁, B₂, B₃,
;   ..., B_(n) are the two binary numbers to be added (each A_(k) and B_(k)
;   is a 0 or a 1).  The circuit generates S₁, S₂, S₃, ..., S_(n), the n
;   bits of the sum, and C, the carry from the addition.  Write a procedure
;   ripple-carry-adder that generates this circuit.  The procedure should
;   take as arguments three lists of n wires each -- the A_(k), the B_(k),
;   and the S_(k) -- and also another wire C.  The major drawback of the
;   ripple-carry adder is the need to wait for the carry signals to
;   propagate.  What is the delay needed to obtain the complete output from
;   an n-bit ripple-carry adder, expressed in terms of the delays for
;   and-gates, or-gates, and inverters?
;   
;   Figure:
;   
;            A1 B1         A2 B2         A3 B3                  An Bn 
;       │    │  │   C1     │  │   C2     │  │   C3 │        │   │  │
;            │  │ ┌────┐   │  │ ┌────┐   │  │ ┌──────           │  │  Cn = 0
;       │    │  │ │    │   │  │ │    │   │  │ │    │        │   │  │ │ 
;           ┌┴──┴─┴┐   │  ┌┴──┴─┴┐   │  ┌┴──┴─┴┐               ┌┴──┴─┴┐
;       │   │      │   │  │      │   │  │      │   │        │  │      │
;           │  FA  │   │  │  FA  │   │  │  FA  │               │  FA  │
;       │   │      │   │  │      │   │  │      │   │        │  │      │
;           └─┬──┬─┘   │  └─┬──┬─┘   │  └─┬──┬─┘               └─┬──┬─┘
;       │     │  │     │    │  │     │    │  │     │        │    │  │
;   C ────────┘  │     └────┘  │     └────┘  │             ──────┘  │
;       │        │       C1    │       C2    │     │        │ Cn-1  Sn
;                S1            S2            S3                    
;   
;   Figure 3.27: A ripple-carry adder for n-bit numbers.
;   
;   ------------------------------------------------------------------------
;   [Exercise 3.30]: http://sicp-book.com/book-Z-H-22.html#%_thm_3.30
;   [Figure 3.27]:   http://sicp-book.com/book-Z-H-22.html#%_fig_3.27
;   3.3.4 A Simulator for Digital Circuits - p278
;   ------------------------------------------------------------------------

(-start- "3.30")



(--end-- "3.30")

