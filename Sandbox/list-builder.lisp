; - Recursive non terminal

;(defun build-list (n)
;  (if (zerop n)
;    nil
;    (cons n (build-list (1- n)))))

; - Recursive terminal

;(defun build-list (n l)
;  (if (zerop n)
;    l
;    (build-list (1- n) (cons n l))))


; - Recursive terminal closure

(defun build-list (n)
  (labels ((build-list-recursive (_n _l)
             (if (zerop _n)
                 _l
                 (build-list-recursive (1- _n) (cons _n _l)))))
    (build-list-recursive n nil)))

