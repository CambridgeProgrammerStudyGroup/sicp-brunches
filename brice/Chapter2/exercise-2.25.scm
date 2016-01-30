#lang racket
(require "../utils.scm")
(require "../meta.scm")

(title "Exercise 2.25")

(let* (
	(A '(1 3 (5 7) 9))
	(B '((7)))
	(C '(1 (2 (3 (4 (5 (6 7))))))))

	(asserteq "Can recover 7 from list A" 7 
		(car (cdr (car (cdr (cdr A))))))
	(asserteq "Can recover 7 from list B" 7 
		(car (car B)))
	(asserteq "Can recover 7 from list C" 7
		(car (cdr (car (cdr (car (cdr (car (cdr (car (cdr (car (cdr C))))))))))))))