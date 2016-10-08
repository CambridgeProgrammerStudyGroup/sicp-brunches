#lang racket

(provide (all-defined-out))

(define (get-record name records)
  (if (empty? records) #f
  (let* [
    [record (first records)]
    [record-name (first record)]
    [record-body (second record)]
    ]
    (if (equal? name record-name)
      record-body
      (get-record name (rest records))))))

(define (get-salary record)
  (if (empty? record) #f
    (let* [
      [row (first record)]
      [type (first row)]
      [data (second row)]]
      (if (equal? type 'salary)
        data
        (get-salary (rest record))))))
