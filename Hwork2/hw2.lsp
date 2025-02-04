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

;3.20

;3.21

;3.25