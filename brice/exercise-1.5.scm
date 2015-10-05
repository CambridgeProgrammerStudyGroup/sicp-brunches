; Exercise 1.5
(define (p) (p))

(define (test-1.5 x y)
  (if (= x 0)
      0
      y))

; (test 0 (p))

; Expected outcome is return 0 if language is normal order evalution, and to never return if 
; applicative order evaluation.

; NORMAL order case
;      .          
;     /|\
;    / | \
;   /  |  \ 
; test 0   .
;          |
;          p
;
;
;      .___      
;     /|\  \_    
;    / | \   \_  
;   /  |  \    \ 
; if   .   0   . 
;     /|\      | 
;    = 0 0     p  
;
;
;
;      .___      
;     /|\  \_    
;    / | \   \_  
;   /  |  \    \ 
; if   #T  0   . 
;              | 
;              p  
;
;
;     .
;     |
;     0
;
;
; APPLICATIVE order case
;
;   .__
;   |\ \ 
;   | \ \
;   |  \ \
; test  0 .
;         |
;         p
; 
; 
;   .__
;   |\ \ 
;   | \ \
;   |  \ \
; test  0 .
;         |
;         .
;         |
;         p
; 
;   .__
;   |\ \ 
;   | \ \
;   |  \ \
; test  0 .
;         |
;         .
;         |
;         .
;         |
;         p
; 
;  And so on...
;
; Racket scheme is applicative-order :)