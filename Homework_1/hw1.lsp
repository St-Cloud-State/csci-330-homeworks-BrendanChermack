(defvar list1)

(defvar list2)

(defvar list3)

(setq list1 '(a b x d))

(setq list2 '(a (b (x d))))

(setq list3 '((( a (b (x) d)))))

(print (caddr list1))

(print (car(cadadr list2)))

(print (caadr(cadaar list3)))