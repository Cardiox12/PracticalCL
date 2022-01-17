(defun parent-closedp (s)
  (= 0 (reduce #'(lambda (acc x)
              (cond
                ((char= x #\() (1+ acc))
                ((char= x #\)) (1- acc)))) s :initial-value 0)))
