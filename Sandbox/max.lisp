;(defun max-recursive (iter max-value)
;  (if iter
;	  (let ((value (first iter)))
;		(max-recursive (rest iter) (if (>= value max-value) value max-value)))
;	  max-value))
;
;(defun get-max (iter)
;  (max-recursive iter (first iter)))
;
;
;(defun min-recursive (iter min-value)
;  (if iter
;	  (let ((value (first iter)))
;		(min-recursive (rest iter) (if (<= value min-value) value min-value)))
;	  min-value))
;
;(defun get-min (iter)
;  (min-recursive iter (first iter)))


(defun get-min (l)
  (labels ((get-min-recursive (l min-val)
			 (if l 
				 (let ((value (first l)))
				   (get-min-recursive (rest l) (if (<= value min-val) value min-val)))
				 min-val)))
	(get-min-recursive (rest l) (first l))))

(defun get-max (l)
  (labels ((get-max-recursive (l max-val)
			 (if l
				 (let ((value (first l)))
				   (get-max-recursive (rest l) (if (>= value max-val) value max-val)))
				 max-val)))
	(get-max-recursive (rest l) (first l))))

; (defun closure-print (it)
;   (if it
; 	  (let ((val (first it)))
; 		(progn
; 		  (print val)
; 		  (closure-print (rest it))))))

(defun my-print (iter)
  (labels ((closure-print (it)
			 (if it
				 (let ((val (first it)))
				   (progn
					 (print val)
					 (closure-print (rest it)))))))
	(closure-print iter)))

