(defun read-file (filename)
  (with-open-file (stream filename)
    (do ((line (read-line stream nil) (read-line stream nil)))
        ((null line) t)
      (format t "~a~%" line))))


;(defun read-file (filename)
  ;(let ((in (open filename)))
    ;(do ((line (read-line in nil) (read-line in nil)))
        ;((null line) t)
      ;(format t "~a~%" line))
    ;(close in)))

#|(let ((in (open "test.txt")))|#
  #|(format t "~a~%" (read-line in))|#
  #|(format t "~a~%" (read-line in))|#
  #|(format t "~a~%" (read-line in))|#
  #|(format t "~a~%" (read-line in nil))|#
  #|(close in))|#
