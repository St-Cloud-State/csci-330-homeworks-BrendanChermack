;From Lisp text: Questions 3.1, 3.2, 3.3 (page 81), 3.7 (pg 83) 3.10 (pg 90)
;3.20, 3.21 (pg96), and 3.25 (pg 111)
;3.1
(print (not (equal 3 (abs -3))))
;3.2
(print (/ (+ 8 12) 2))
;3.3
(print (+ (expt 3 2) (expt 4 2)))
;3.7
(defun MILES-PER-GALLON(INITIAL-ODOMETER-READING FINAL-ODOMETER-READING GALLONS-CONSUME)
  (/ (- FINAL-ODOMETER-READING INITIAL-ODOMETER-READING) GALLONS-CONSUME)
)
(print (miles-per-gallon 1000 1200 10))
;3.10
;(third (the quick brown fox)) third is not a keyword in lisp so they are being treated as variables. To make this work add a ' in front of (third and (the
(print '(third '(the quick brown fox))) 
;(list 2 and 2 is 4) Items and and is need a ' in front of them to not get evaled.
(print (list 2 'and 2 'is 4))
;(+ 1 '(length (list t t t t))) missing ' in front of the t's and the ' in front of the list needs to be removed to be evaled if that is the desire.
(print (+ 1 (length (list 't 't 't 't))))
;(cons 'patrick (seymour marvin)) seymour marvin is not a list. adding a ' in front makes it a list.
(print (cons 'patrick '(seymour marvin))) 
;(cons 'patrick (list seymour marvin)) The variable SEYMOUR is unbound. adding a ' in front of SEYMOUR and marvin will fix it.
(print (cons 'patrick (list 'seymour 'marvin)))
;3.20
(defun mystery (x)
  (list (second x) (first x)))

(print (mystery '(dancing bear))); result (BEAR DANCING)
;(print (mystery 'dancing 'bear)); error invalid number of arguments: 2
(print (mystery '(zowie))) ; result (NIL ZOWIE)
(print (mystery (list 'first 'second))) ; the list is reversed to second first
;3.21
;; (print (defun speak (x y) 
;;   (list 'all 'x 'is 'y))) ; X and Y are not used since they have a ' in front of them preventing them from being evaled.
;; (print (defun speak (x) (y) 
;;   (list 'all x 'is y))) ; (x) and (y) is incorrect it should be (x y)
;; (print (defun speak ((x) (y)) 
;;   (list all 'x is 'y))); ((x) (y)) should not be nested; (x y). all needs to also have ' in front
;3.25
(print (list 'cons t nil))
(print (eval (list 'cons t nil)))
;(print (eval (eval (list 'cons t nil)))); T is not a function
(print (apply #'cons '(t nil)))
(print (eval nil)) 
(print (list 'eval nil))
(print (eval (list 'eval nil)))