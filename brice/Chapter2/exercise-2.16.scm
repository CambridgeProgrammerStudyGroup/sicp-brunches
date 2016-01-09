#lang racket
(require "../utils.scm")

(title "Exercise 2.16")

; Exercise 2.16.  Explain, in general, why equivalent algebraic expressions 
; may lead to different answers. Can you devise an interval-arithmetic package 
; that does not have this shortcoming, or is this task impossible? 
; (Warning: This problem is very difficult.)

(prn
"
## Equivalent algebraic expressions can lead to different answers when using intervals. 

This is because expressions with the same term appearing multiple times will have a 
greater error value than neccessary. Conceptually, this is because the error of a given
quantity will be accounted for multiple times. If the expressions can be re-written so 
that the given term appears only once, then the resulting error will be smaller and a 
better reflection of the real error of the expression.

## Can an interval-arithmetic package be derived that does not have this shortcoming?

Creating an interval arithmetic package that does not suffer from this shortcoming would
require that expressions be re-written to their canonical form where each interval occurs
only once in the expression, or to define a canonical/normal form for an expression in 
which the intervals occur the minimum possible number of times.

This would be akin to asking the following question of an expression:

    Is this expression fully reduced to its canonical form?

Which can be interpreted as the search for a proof to the following statement:

    The expression is in its canonical/normal form.

Which is the Entscheidungsproblem (https://en.wikipedia.org/wiki/Entscheidungsproblem), 
as we're making a formal statement that we must prove true or false, and this was proved
undecidable by Alonzo Church and Alan Turing in 1936. 
(see https://en.wikipedia.org/wiki/Church%E2%80%93Turing_thesis)

It is therefore impossible to write an interval arithmetic package that is generally 
capable of resolving the dependency problem.

The best we can do is re-write the expression to its canonical form manually, or provide
a best effort reduction solution with a resource limited search for a more reduced form 
of the expression.
")
