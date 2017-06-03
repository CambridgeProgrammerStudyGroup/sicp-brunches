#lang racket
(require "../utils.scm")

;   Exercise 2.76
;   =============
;
;   As a large system with generic operations evolves, new types of data
;   objects or new operations may be needed.  For each of the three
;   strategies -- generic operations with explicit dispatch, data-directed
;   style, and message-passing-style -- describe the changes that must be
;   made to a system in order to add new types or new operations.  Which
;   organization would be most appropriate for a system in which new types
;   must often be added?  Which would be most appropriate for a system in
;   which new operations must often be added?
;
;   ------------------------------------------------------------------------
;   [Exercise 2.76]: http://sicp-book.com/book-Z-H-17.html#%_thm_2.76
;   2.4.3 Data-Directed Programming and Additivity - p187
;   ------------------------------------------------------------------------

(module* main #f
  (title "Exercise 2.76")

  (Q: "As a large system with generic operations evolves, new types of data
objects or new operations may be needed.  For each of the three
strategies -- generic operations with explicit dispatch, data-directed
style, and message-passing-style -- describe the changes that must be
made to a system in order to add new types or new operations.")

(A:"
== generic operations with explicit dispatch ==
To add a new type:
  1) Write the new constructor
  2) Write a new selector
  3) Modify the existing explicitly dispatched function to handle
     the new type

To add a new operation:
  1) Add a new operation in the main dispatcher and implement
     it for all types using explicit selection

== data-directed style ==
To add a new type:
  1) Write the type creator which adds a unique type tag to all datum created
  2) Write the type-appropriate functions for existing operations
  3) Register the new operations with the dispatch table

To add a new operation:
  1) Write the appropriate functions for each type
  2) Register the functions with the dispatch table

== message-passing-style ==
(This refers to the message passing style shown in this chapter
rather than the possible improved message passing style)

To add a new type:
  1) Create the type constructor, which includes the individual operations

To add a new operation:
  2) Modify each type constructor with the new function to perform
     the operation.
")

(Q: "Which organization would be most appropriate for a system in which new
types must often be added?")

(A: "The message passing style would be very appropriate for this use case.
This is because adding a new type using this style requires a self-contained
change to a single file, and no external registration. The functions responsible
for carrying out the operations have access to the internal state without
exposing it to the rest of the code.
")

(Q:"Which would be most appropriate for a system in which new operations
must often be added?")

(A: "I would prefer to use the data-directed style for this use case. Adding
a new operation requires additional registration, but this can be significantly
improved using either type loader functions (which also remove the need to
pollute another namespace). The reason this type is optimal for this use case
because it requires no change to existing code, as it is open for addition.
This reduces the risk of adding new operations on existing types.")

)
