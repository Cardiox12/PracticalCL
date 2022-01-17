; Hash Map

(defparameter *table* (make-hash-table))

(setf (gethash 'tony *table*) 22)
(setf (gethash 'mai-nhi *table*) 24)

(defun show-value (key hash-table)
  (multiple-value-bind (value present) (gethash key hash-table)
    (if present
        (format nil "Value ~a actually present." value)
        (format nil "Value ~a because key not found." value))))

