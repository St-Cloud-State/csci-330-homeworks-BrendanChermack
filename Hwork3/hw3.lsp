(defun partition (oList list1 list2)
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


(print (mergesort '(4 3 7 8 1 5 2 6)))  ; Expected: (1 2 3 4 5 6 7 8)
(print (mergesort '(10 9 8 7 6 5 4 3 2 1)))  ; Expected: (1 2 3 4 5 6 7 8 9 10)
(print (mergesort '(1)))  ; Expected: (1)
(print (mergesort '()))  ; Expected: ()
(defun merge-two-elements (a b)
  (cond
    ((null a) b)
    ((null b) a)
    ((<= (car a) (car b)) (list (car a) (car b)))
    (t (list (car b) (car a)))))
(defun make-sorted-pairs (lst)
  (cond
    ((null lst) nil)
    ((null (cdr lst)) (list (list (car lst))))
    (t (cons (merge-two-elements (list (car lst))
                                 (list (cadr lst)))
             (make-sorted-pairs (cddr lst))))))
(defvar pairsNums (make-sorted-pairs '(1 7 2 1 8 6 5 3 7 9 4)))
(print pairsNums)

(defun merge-sorted-sublists (list1 list2)
  "Merge two sorted lists into one sorted list."
  (cond
    ;; If the first list is empty, return the second
    ((null list1) list2)
    ;; If the second list is empty, return the first
    ((null list2) list1)
    ;; Otherwise, compare heads and pick the smaller
    ((<= (car list1) (car list2))
     (cons (car list1) (merge-sorted-sublists (cdr list1) list2)))
    (t (cons (car list2) (merge-sorted-sublists list1 (cdr list2))))))

(defun merge-pass (list-of-sublists)
  (cond
    ;; If there's nothing left to merge, return nil
    ((null list-of-sublists) nil)
    ;; If there's only one sublist left, it remains unmerged
    ((null (cdr list-of-sublists)) 
     (list (car list-of-sublists)))
    ;; Otherwise, merge the first two sublists and recurse on the rest
    (t (cons (merge-sorted-sublists (car list-of-sublists)
                                 (cadr list-of-sublists))
             (merge-pass (cddr list-of-sublists))))))
(defvar merged (merge-pass pairsNums))

(defun final-merge (list-of-sublists)
  (cond
    ;; No sublists at all ⇒ return nil
    ((null list-of-sublists) nil)
    ;; Exactly one sublist ⇒ fully merged
    ((null (cdr list-of-sublists)) (car list-of-sublists))
    ;; Otherwise, perform one pass, then recurse
    (t (final-merge (merge-pass list-of-sublists)))))
 (print (final-merge merged))


 