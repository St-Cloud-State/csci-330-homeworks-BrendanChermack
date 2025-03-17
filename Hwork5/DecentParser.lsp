(defun parse-G (tokens)
  "G -> x | y | z | w"
  (if (member (car tokens) '(x y z w)) ;; Check if the first token in the list is one of x, y, z, w
      (cdr tokens)  ; consume one terminal from [x,y,z,w]
      (error "Expected x, y, z, or w in G")))

(defun parse-E-prime (tokens)
  "E' -> oG E' | epsilon"
  (if (equal (car tokens) 'o) ; If the next token is o consume it parse G, and recurse on E'
      (let ((remaining (parse-G (cdr tokens))))
        (parse-E-prime remaining)) 
      tokens)) ; epsilon condition (do nothing)

(defun parse-E (tokens)
  "E -> G E'"
  (let ((remaining (parse-G tokens))); First parse G then parse E' on the remaining tokens
    (parse-E-prime remaining)))

(defun parse-L-both (tokens) ;; Since LISP is a one pass lang, L and L' need to be combined into a single function
  (labels
      ((parse-l (tokens)
         ;; L -> s L'
         (if (equal (car tokens) 's)
             (parse-l-prime (cdr tokens))
             (error "Expected 's' in L")))

       (parse-l-prime (tokens)
         ;; L' -> L | epsilon
         (if (equal (car tokens) 's)
             (parse-l tokens) ; If another s parse-L again
             tokens)))        ; Otherwise epsilon cond
    (parse-l tokens)))  ; Start at L


(defun parse-S (tokens)
  "S -> s | dLb"
  (cond
    ((equal (car tokens) 's)
     ;; S -> s
     (cdr tokens)) ; just consume the s
    ((equal (car tokens) 'd)
     ;; S -> dLb
     (let ((remaining (parse-L-both (cdr tokens))))
       (if (and remaining (equal (car remaining) 'b))
           (cdr remaining)  ; consume b
           (error "Expected 'b' after L in S"))))
    (t (error "Unexpected token in S"))))

(defun parse-I-prime (tokens)
  "I' -> eS | epsilon"
  (if (equal (car tokens) 'e)
      (parse-S (cdr tokens))
      tokens)) ; ε branch

(defun parse-I (tokens)
  "I -> i E S I'"
  (if (equal (car tokens) 'i)
      (let* ((remaining1 (parse-E (cdr tokens)))
             (remaining2 (parse-S remaining1)))
        (parse-I-prime remaining2))
      (error "Expected 'i' at the start of I")))

(defun parse (string) ; encapsulating function to call on the strings
  (let ((remaining (parse-I string)))
    (if (null remaining)
        (format t "Parsing successful!~%")
        (format t "Parsing failed, extra tokens: ~a~%" remaining))))

;; Valid Test Cases
(format t "Running valid tests:~%")
(parse '(i x s e s))
(parse '(i x o y s))
(parse '(i x o y o w d s s b e s))
(parse '(i w o z o y s))
(parse '(i x o y o w s e s))
(parse '(i x d s b e s))
(parse '(i z s e s))

;;;Invalid Strings;;;
;; (parse '(x x x x x))) ; First token is not i
;; (parse '(i x y s e s)) ; ending condition is not s or d
;; (parse '(i x x x x x)) ; does not end with s or d
;; (parse '(i w e d s s s s)) ; S sees e: which is invalid for S -> s | d L b
;; (parse '(i d s b e s)) ; parsing of G fails
;; (parse '(i x o w o y o x)) ; Ends to quickly
;; (parse '(i x d b s)) ; expecting a leading s but has a b
