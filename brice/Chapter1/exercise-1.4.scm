
; Exercise 1.4
(define (a-plus-abs-b a b)
  ((if (> b 0) + -) a b))

; eg a = 3 b = 4, then function returns 7 (a + b)
; eg a = 3 b = -4, then function returns 7 also (a - (-b)).
