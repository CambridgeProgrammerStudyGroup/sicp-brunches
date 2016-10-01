#lang racket
(require "../utils.scm")

;   Exercise 2.66
;   =============
;
;   Implement the lookup procedure for the case where the set of records is
;   structured as a binary tree, ordered by the numerical values of the
;   keys.
;
;   ------------------------------------------------------------------------
;   [Exercise 2.66]: http://sicp-book.com/book-Z-H-16.html#%_thm_2.66
;   2.3.3 Example: Representing Sets - p161
;   ------------------------------------------------------------------------

(define (make-db) '())
(define (make-record key value) (list key value))
(define (get-key record) (first record))
(define (get-value record) (second record))

(define (lower-keys tree) (second tree))
(define (higher-keys tree) (third tree))
(define (get-entry tree) (first tree))

(define (update-record db record)
  (let [[key (get-key record)]]
  (cond
    [(empty? db) (list record '() '())]
    [(eq? (get-key (get-entry db)) key) (list record (lower-keys db) (higher-keys db))]
    [(> key (get-key (get-entry db))) (list (get-entry db) (lower-keys db) (update-record (higher-keys db) record))]
    [(< key (get-key (get-entry db))) (list (get-entry db) (update-record (lower-keys db) record) (higher-keys db))]
    )))

(define (update-records db . records)
  (foldl
    (λ (record db)
      (update-record db record))
    db records))

(define (lookup db key)
  (if (empty? db) '()
    (let* [
        [entry (get-entry db)]
        [current-key (get-key entry)]
        [current-value (get-value entry)]]
      (cond
        [(eq? key current-key) current-value]
        [(> key current-key) (lookup (higher-keys db) key)]
        [(< key current-key) (lookup (lower-keys db) key)])
      )))

(module* main #f
  (title "Exercise 2.66")

  (define db
    (update-records (make-db)
      (make-record 2 "hello")
      (make-record 3 "bye")
      (make-record 1 "foo")))

  (assertequal? "We can create an empty database"
    '()
    (make-db))

  (assertequal? "We can add one item to a database"
    '((1 a) () ())
    (update-record (make-db) (make-record 1 'a)))

  (assertequal? "We can add multiple items to a database"
    '((1 a) () ((2 b) () ()))
    (update-records (make-db)
      (make-record 1 'a)
      (make-record 2 'b)))

  (assertequal? "We can lookup an item in an empty database"
    '()
    (lookup (make-db) 1))

  (assertequal? "We can lookup a missing item in a database"
    '()
    (lookup (update-record (make-db) (make-record 2 'b)) 1))

  (assertequal? "We can lookup an item from a simple database by its key"
    "hello"
    (lookup (update-record (make-db) (make-record 1 "hello")) 1))

  (assertequal? "We can lookup an item from a database by its key"
    "hello"
    (lookup
      (update-records (make-db)
        (make-record 5 "dog")
        (make-record 8 "romeo")
        (make-record 7 "cat")
        (make-record 3 "bye")
        (make-record 1 "hello"))
      1))
)
