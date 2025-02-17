(defun insert-ascending (x sorted) ;inserts the value in the right spot in the sorted list
  (cond
    ;if empty place x in the sorted list
    ((null sorted)
     (list x))
    ;if x is less or equal to the first element insert at the front
    ((<= x (car sorted))
     (cons x sorted))
    ;if not continue down the list
    (t
     (cons (car sorted)
           (insert-ascending x (cdr sorted))))))

(defun insertion-sort-helper (sorted unsorted); uses the insertion ascending function for placement and takes the 2 lists for sorting
  (if (null unsorted)
      ;base case: no more elements to insert
      sorted
    ;insert the first unsorted element into the sorted list and continue on the rest
    (insertion-sort-helper
      (insert-ascending (car unsorted) sorted)
      (cdr unsorted))))

(defun insertion-sort (lst) ; wrapper function for neat calling
  (insertion-sort-helper nil lst))

(print (insertion-sort '(7 3 5 2 9 1 8))) 
(print (insertion-sort '(10 9 8 7 6 5 4 3 2 1))) 