(defun merge-two-elements (a b) ; merges two elements for proper sorting
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

(defun merge-sorted-sublists (list1 list2)
(cond
    ;if the first list is empty return the second
    ((null list1) list2)
    ;if the second list is empty return the first
    ((null list2) list1)
    ;compare elements and pick the smaller
    ((<= (car list1) (car list2))
     (cons (car list1) (merge-sorted-sublists (cdr list1) list2)))
    (t (cons (car list2) (merge-sorted-sublists list1 (cdr list2))))))

(defun merge-all-passes (list-of-sublists)
  (cond
    ((null list-of-sublists) nil)
    ;done if only one remains
    ((null (cdr list-of-sublists)) (car list-of-sublists))
    (t
     ;do one pass of pairwise merges then recurse it
     (merge-all-passes
       (labels ((one-pass (subs acc)
                  (cond
                    ;no sublists leads to just returning reversed accumulator which reverses in place in memory without allocating new space
                    ((null subs) (nreverse acc))
                    ;leftovers: add it and finish
                    ((null (cdr subs))
                     (nreverse (cons (car subs) acc)))
                    (t
                     (one-pass (cddr subs)
                               (cons (merge-sorted-sublists (car subs)
                                                            (cadr subs))
                                     acc))))))
         (one-pass list-of-sublists nil))))))
;Printed results
 (let* ((pairs (make-sorted-pairs '(1 7 2 1 8 6 5 3 7 9 4 8 3 1 19)))
       (sorted (merge-all-passes pairs)))
(print pairs)
(print sorted))

