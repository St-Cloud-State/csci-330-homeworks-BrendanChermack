(defun partition (oList list1 list2); partitioning of the half way point
  (cond
    ((null oList) (values list1 list2))
    ((null (cdr oList)) (values (cons (car oList) list1) list2))
    (t (partition (cddr oList) (cons (car oList) list1) (cons (cadr oList) list2)))))


(defun merge-sorted-lists (list1 list2)
  (cond
    ((null list1) list2)  ; If list1 is empty, return list2
    ((null list2) list1)  ; If list2 is empty, return list1
    ((<= (car list1) (car list2))  ; If first element of list1 is smaller
     (cons (car list1) (merge-sorted-lists (cdr list1) list2)))
    (t (cons (car list2) (merge-sorted-lists list1 (cdr list2))))))  ; Else take from list2


(defun mergesort (oList)
  (cond
    ((null oList) nil)  ; Base case: Empty list
    ((null (cdr oList)) oList)  ; Base case: Single element is already sorted
    (t (multiple-value-bind (left right) (partition oList '() '())  ; Partition into two halves
         (merge-sorted-lists (mergesort left) (mergesort right))))))  ; Recursively sort and merge


(print (mergesort '(4 3 7 8 1 5 2 6)))  
(print (mergesort '(10 9 8 7 6 5 4 3 2 1 3 5 1 2 11)))  
(print (mergesort '(1)))
(print (mergesort '()))

 