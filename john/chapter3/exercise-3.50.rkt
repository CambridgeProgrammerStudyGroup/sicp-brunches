#lang racket

(require "common.rkt")

;   Exercise 3.50
;   =============
;   
;   Complete the following definition, which generalizes stream-map to allow
;   procedures that take multiple arguments, analogous to map in section
;   [2.2.3], footnote [12].
;   
;   (define (stream-map proc . argstreams)
;     (if (<??> (car argstreams))
;         the-empty-stream
;         (<??>
;          (apply proc (map <??> argstreams))
;          (apply stream-map
;                 (cons proc (map <??> argstreams))))))
;   
;   ------------------------------------------------------------------------
;   [Exercise 3.50]: http://sicp-book.com/book-Z-H-24.html#%_thm_3.50
;   [Section 2.2.3]: http://sicp-book.com/book-Z-H-15.html#%_sec_2.2.3
;   [Footnote 12]:   http://sicp-book.com/book-Z-H-24.html#footnote_Temp_166
;   3.5.1 Streams Are Delayed Lists - p350
;   ------------------------------------------------------------------------

(-start- "3.50")



(--end-- "3.50")

