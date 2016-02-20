#lang racket
(require "../utils.scm")
(require "../meta.scm")

(title "Exercise 2.24")

(prn "Given 

    (list 1 (list 2 (list 3 4)))

The resulting value will look like the following:

	 .
	 |\\
	 | \\
	 1  .
	    |\\
	    | \\
	    2  .
	       |\\
	       | \\
	       3  4

Will interpret to:

    '(1 (2 (3 4)))

and will be a datastructure of the form:

	[.|-]->[.|/]
	 |      |
	 1     [.|-]->[.|/]
	        |      |
	        2     [.|-]->[.|/]
	               |      |
	               3      4

 ")