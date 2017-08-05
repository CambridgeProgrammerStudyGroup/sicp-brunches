#lang sicp

(#%require "common.scm")

;   Exercise 3.15
;   =============
;   
;   Draw box-and-pointer diagrams to explain the effect of set-to-wow! on
;   the structures z1 and z2 above.
;   
;   ------------------------------------------------------------------------
;   [Exercise 3.15]: http://sicp-book.com/book-Z-H-22.html#%_thm_3.15
;   3.3.1 Mutable List Structure - p269
;   ------------------------------------------------------------------------

(-start- "3.15")

(prn "
Before:

z1 -> [.|.]
       | |  
        v   
 x -> [.|.] - [.|/]
       |       |      
      'a      'b   

and

       ┌─----[.|.] - [.|/]
       │      |       |      
z2 -> [.|.]  'a      'b   
         │    |       |      
         └─--[.|.] - [.|/]

After:

z1 -> [.|.]
       | |  
        v   
 x -> [.|.] - [.|/]
       |       |      
      Wow     'b   

and
            'Wow
              |
       ┌─----[.|.] - [.|/]
       │              |      
z2 -> [.|.]  'a      'b   
         │    |       |      
         └─--[.|.] - [.|/]

")
(--end-- "3.15")

