#lang racket
(require "../utils.scm")
(require "../dispatch-table.scm")

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
(module* main #f
  (title "Exercise 2.74")

  (define records-a (file->list "Chapter2/exercise-274/data-a.scm" read))
  (define records-b (file->list "Chapter2/exercise-274/data-b.scm" read))
  (define records-c (file->list "Chapter2/exercise-274/data-c.scm" read))

  (define all-divisions
    (list records-a records-b records-c))

  (Q: "2.74a) Implement for headquarters a get-record procedure that retrieves a
specified employee's record from a specified personnel file.  The
procedure should be applicable to any division's file. Explain how the
individual divisions' files should be structured.  In particular, what
type information must be supplied?")

  (A: "Each record must provide a type tag so that the right procedures can
be used to access the data. This is done by providing a type tag as
the first valid form of the record. For example

    type-xyz
    (1 2 3 4)

Would be a valid file with the type `'type-xyz` and value `'(1 2 3 4)`.
This requires absolutley minimal changes to division records, while
giving us sufficient information to carry out type dispatch. We can
also strip out the type tag and still use previous functions.
")

  (require (prefix-in divA: "exercise-274/division-a.scm"))

  (void
    (put 'get-record 'division-a divA:get-record)
    (put 'get-salary 'division-a divA:get-salary)
  )

  (define (typeof x) (first x))
  (define (value x) (second x))

  (define (get-record name records)
    (let* [[division (typeof records)]]
     (list division ((get 'get-record division) name(value records)))))

  (assertequal? "We can use get record to get division A records"
    '(division-a
      ( (address "321 Seal St, 62532, Sealand")
        (role "VP Carrot growing")
        (salary 54343.00)
        (age 12)))
      (get-record "Wendy Barnacles" records-a))

  (newline)

  (Q: "2.74b) Implement for headquarters a get-salary procedure that returns the
salary information from a given employee's record from any division's
personnel file.  How should the record be structured in order to make
this operation work?")

  (define (get-salary record)
    (let* [
      [division (typeof record)]]
      ((get 'get-salary division) (value record))))

  (assertequal?
    "We can get the salary of an employee from the record list"
    54343.00
    (get-salary (get-record "Wendy Barnacles" records-a)))

  (newline)

  (A: "We do not have to change the records at all for this operation to work,
if we can dispatch the calls to access the record attributes using the
division type, which we get from the division record at the top level.
We do however have to register the `get-salary` function with our
dispatch system.

If we wish for the procedure to work with any record, the record will
need its division as an initial value, so that we may dispatch accordingly.
We can create a function that will add a division tag to all personnel
records on access to circumvent the requirement. One way to do this is
to add the division information as part of our own `get-record`
procedure")

  (Q: "2.74c) Implement for headquarters a find-employee-record procedure. This
should search all the divisions' files for the record of a given
employee and return the record.  Assume that this procedure takes as
arguments an employee's name and a list of all the divisions' files.")

  (define (find-employee-record name)
    (define (inner divisions)
      (if (empty? divisions) #f
        (let* [
            [division-tag (first divisions)]
            [employee-record (get-record name division-tag)]]
          (if employee-record
            employee-record
            (inner (rest divisions))))))
    (inner all-divisions))

  (assertequal? "We can find an employee record across all divisions"
    '(division-a
      ( (address "321 Seal St, 62532, Sealand")
        (role "VP Carrot growing")
        (salary 54343.00)
        (age 12)))
      (find-employee-record "Wendy Barnacles"))

  (newline)

  (Q: "2.74d) When Insatiable takes over a new company, what changes must be made
in order to incorporate the new personnel information into the central
system?")

  (A: "When Insatiable takes over a new company, the only changes required
are:

- The addition of the divisions's records file to the `all-divisions` list
- Adding division-specific record accessor to the dispatch table with the
  division type tag
- Adding record accessor to the division ")

)
