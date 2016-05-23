#lang racket

; Section 2.4.3: Data-Directed Programming and Additivity

(require "common.rkt")

;   Exercise 2.73
;   =============
;   
;   Section [2.3.2] described a program that performs symbolic
;   differentiation:
;   
;   (define (deriv exp var)
;     (cond ((number? exp) 0)
;           ((variable? exp) (if (same-variable? exp var) 1 0))
;           ((sum? exp)
;            (make-sum (deriv (addend exp) var)
;                      (deriv (augend exp) var)))
;           ((product? exp)
;            (make-sum
;              (make-product (multiplier exp)
;                            (deriv (multiplicand exp) var))
;              (make-product (deriv (multiplier exp) var)
;                            (multiplicand exp))))
;           <more rules can be added here>
;           (else (error "unknown expression type -- DERIV" exp))))
;   
;   We can regard this program as performing a dispatch on the type of the
;   expression to be differentiated.  In this situation the "type tag" of
;   the datum is the algebraic operator symbol (such as +) and the operation
;   being performed is deriv.  We can transform this program into
;   data-directed style by rewriting the basic derivative procedure as
;   
;   (define (deriv exp var)
;      (cond ((number? exp) 0)
;            ((variable? exp) (if (same-variable? exp var) 1 0))
;            (else ((get 'deriv (operator exp)) (operands exp)
;                                               var))))
;   (define (operator exp) (car exp))
;   (define (operands exp) (cdr exp))
;   
;   a.  Explain what was done above. Why can't we assimilate the predicates
;   number? and same-variable? into the data-directed dispatch?
;   
;   b.  Write the procedures for derivatives of sums and products, and the
;   auxiliary code required to install them in the table used by the program
;   above.
;   
;   c.  Choose any additional differentiation rule that you like, such as
;   the one for exponents (exercise [2.56]), and install it in this
;   data-directed system.
;   
;   d.  In this simple algebraic manipulator the type of an expression is
;   the algebraic operator that binds it together.  Suppose, however, we
;   indexed the procedures in the opposite way, so that the dispatch line in
;   deriv looked like
;   
;   ((get (operator exp) 'deriv) (operands exp) var)
;   
;   What corresponding changes to the derivative system are required?
;   
;   ------------------------------------------------------------------------
;   [Exercise 2.73]: http://sicp-book.com/book-Z-H-17.html#%_thm_2.73
;   [Section 2.3.2]: http://sicp-book.com/book-Z-H-16.html#%_sec_2.3.2
;   [Exercise 2.56]: http://sicp-book.com/book-Z-H-17.html#%_thm_2.56
;   2.4.3 Data-Directed Programming and Additivity - p184
;   ------------------------------------------------------------------------

(-start- "2.73")



(--end-- "2.73")

;   ========================================================================
;   
;   Exercise 2.74
;   =============
;   
;   Insatiable Enterprises, Inc., is a highly decentralized conglomerate
;   company consisting of a large number of independent divisions located
;   all over the world.  The company's computer facilities have just been
;   interconnected by means of a clever network-interfacing scheme that
;   makes the entire network appear to any user to be a single computer.
;   Insatiable's president, in her first attempt to exploit the ability of
;   the network to extract administrative information from division files,
;   is dismayed to discover that, although all the division files have been
;   implemented as data structures in Scheme, the particular data structure
;   used varies from division to division.  A meeting of division managers
;   is hastily called to search for a strategy to integrate the files that
;   will satisfy headquarters' needs while preserving the existing autonomy
;   of the divisions.
;   
;   Show how such a strategy can be implemented with data-directed
;   programming.  As an example, suppose that each division's personnel
;   records consist of a single file, which contains a set of records keyed
;   on employees' names.  The structure of the set varies from division to
;   division.  Furthermore, each employee's record is itself a set
;   (structured differently from division to division) that contains
;   information keyed under identifiers such as address and salary.  In
;   particular:
;   
;   a.  Implement for headquarters a get-record procedure that retrieves a
;   specified employee's record from a specified personnel file.  The
;   procedure should be applicable to any division's file. Explain how the
;   individual divisions' files should be structured.  In particular, what
;   type information must be supplied?
;   
;   b.  Implement for headquarters a get-salary procedure that returns the
;   salary information from a given employee's record from any division's
;   personnel file.  How should the record be structured in order to make
;   this operation work?
;   
;   c.  Implement for headquarters a find-employee-record procedure. This
;   should search all the divisions' files for the record of a given
;   employee and return the record.  Assume that this procedure takes as
;   arguments an employee's name and a list of all the divisions' files.
;   
;   d.  When Insatiable takes over a new company, what changes must be made
;   in order to incorporate the new personnel information into the central
;   system?
;   
;   ------------------------------------------------------------------------
;   [Exercise 2.74]: http://sicp-book.com/book-Z-H-17.html#%_thm_2.74
;   2.4.3 Data-Directed Programming and Additivity - p185
;   ------------------------------------------------------------------------

(-start- "2.74")



(--end-- "2.74")

;   ========================================================================
;   
;   Exercise 2.75
;   =============
;   
;   Implement the constructor make-from-mag-ang in message-passing style.
;   This procedure should be analogous to the make-from-real-imag procedure
;   given above.
;   
;   ------------------------------------------------------------------------
;   [Exercise 2.75]: http://sicp-book.com/book-Z-H-17.html#%_thm_2.75
;   2.4.3 Data-Directed Programming and Additivity - p187
;   ------------------------------------------------------------------------

(-start- "2.75")



(--end-- "2.75")

;   ========================================================================
;   
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

(-start- "2.76")



(--end-- "2.76")

