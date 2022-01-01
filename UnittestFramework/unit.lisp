; Original test-+
;
; (defun test-+ ()
;   (and
; 	(= (+ 1 2) 3)
; 	(= (+ 1 2 3) 6)
; 	(= (+ -1 -3) -4)))

; Example call for combine-results
;
; (combine-results
;   (foo)
;   (bar))

; (let ((result t))
;   (unless (foo) (setf result nil))
;   (unless (bar) (setf result nil))
;   result)

(defvar *test-name* nil)

(defun report-result (res form)
  (format t "[~:[FAIL~;OK~]] ~a: ~a~%" res *test-name* form)
  res)

(defmacro with-gensyms ((&rest names) &body body)
  `(let ,(loop for n in names collect `(,n (gensym)))
	 ,@body))

(defmacro combine-results (&body forms)
  (with-gensyms (result)
	`(let ((,result t))
	   ,@(loop for f in forms collect `(unless ,f (setf ,result nil)))
	   ,result)))

(defmacro check (&body forms)
  `(combine-results
	 ,@(loop for f in forms collect `(report-result ,f ',f))))

(defmacro deftest (name parameters &body body)
  `(defun ,name ,parameters
	 (let ((*test-name* ',name))
	   ,@body)))

(deftest test-+ ()
  (check
	(= (+ 1 2) 3)
	(= (+ 1 2 3) 6)
	(= (+ -1 -3) -4)))

(deftest test-* ()
  (check
	(= (* 1 2) 2)
	(= (* 1 -2) -2)))

; (defmacro test (&rest exprs)
;   (loop for expr in exprs collect 
; 		 `(format t "~:[FAIL~;pass~] ... ~a~%" ,expr ,expr)))

; (test
;   (actual expect))

;(test
;  ((+ 1 2) 3)
;  ((+ 1 2 3) 6)
;  ((+ -1 -3) -4))

(test-+)
(test-*)
