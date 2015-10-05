; Excercise 1.12

; Pascal's pyramid:
; 1
; 1  1
; 1  2  1
; 1  3  3  1
; 1  4  6  4  1

(define (pascal l n)
  "l - 0-indexed layer
   n - 0-indexed position in layer."
  (cond ((> n l) (raise 'invalid-input))
        ((= l n 0) 1)
        ((= l 1) 1)
        ((= n 0) 1)
        ((= l n) 1)
        (else (+ (pascal (dec l) n) (pascal (dec l) (dec n))))
        ))

; Alternative solution uses recursion by row to get the nth row


(define (new-from-previous previous)
  (cond ((equal? previous '()) '(1))
        (else (map (lambda (pair) (apply + pair))  
             (map list 
                  (reverse (cons 0 (reverse previous)))
                  (cons 0 previous))))))

(define (pascal-new row)
  (define (pascal-rec row previous-row)
    (cond ((= row 0) previous-row)
          (else      (pascal-rec (- row 1) (new-from-previous previous-row)))))
 (pascal-rec row '()))