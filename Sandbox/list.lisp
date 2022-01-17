; Custom primitives for list manipulation


; Access functions
(defun at-first (l)
  (car l))

(defun at-second (l)
  (car (cdr l)))

(defun at-third (l)
  (car (cdr (cdr l))))

(defun at-rest (l)
  (cdr l))

(defun at-length (l)
  (if (null l)
      0
      (1+ (at-length (at-rest l)))))

(defun at-substitute (x y seq)
  (if (null seq)
      nil
      (let ((curr (at-first seq)))
        (cons (if (eq y curr) x curr) 
              (at-substitute x y (at-rest seq))))))

(defun at-remove (x seq)
  (if (null seq)
      nil
      (let ((curr (at-first seq)))
        (if (eql curr x)
            (at-remove x (at-rest seq))
            (cons curr (at-remove x (at-rest seq)))))))

(defun at-count (x seq)
  (if (null seq)
      0
      (funcall 
        (if (eql x (at-first seq)) 
            '1+ 
            'identity)
        (at-count x (at-rest seq)))))

(defun at-count-if-not (f seq)
  (if (null seq)
      0
      (funcall
        (if (not (funcall f (at-first seq)))
            '1+
            'identity)
        (at-count-if-not f (at-rest seq)))))

(defun at-position (x seq)
  (if (null seq)
      nil
      (if (eql x (at-first seq))
          0
          (let ((res (at-position x (at-rest seq))))
            (if (null res) nil (1+ res))))))

(defun at-find (x seq)
  (if (null seq)
      nil
      (if (eql x (at-first seq))
          x
          (at-find x (at-rest seq)))))


; Modify functions

(defun at-map (f l)
  (if l
      (cons (funcall f (at-first l)) (at-map f (at-rest l)))
      nil))

(defun at-reduce (f l)
  (labels ((at-reduce-recursive (_l _acc)
             (if (null _l)
                 _acc
                 (at-reduce-recursive (at-rest _l) (funcall f _acc (at-first _l))))))
    (at-reduce-recursive (at-rest l) (at-first l))))

(defun at-filter (f l)
  (if (null l)
      nil
      (if (funcall f (at-first l))
          (cons (at-first l) (at-filter f (at-rest l)))
          (at-filter f (at-rest l)))))

; Semi-Optimized way, by using recycling (side effect)
;(defun at-filter (f l)
  ;(let ((filtered nil))
    ;(labels ((at-filter-recursive (_f _l)
               ;(if (null _l)
                   ;filtered
                   ;(let ((curr (at-first _l))
                         ;(if (funcall _f curr)
                             ;(cons curr (at-filter-recursive _f (at-rest _l)))
                             ;(at-filter-recursive _f (at-rest _l))))))))
      ;(at-filter-recursive f l))))

; Tree
; 
; Representation :
;   (data 
;      (fg nil nil) 
;      (fd nil nil))

; Tree access functions
(defun at-get-node-data (node)
  (at-first node))

(defun at-get-left-node (node)
  (at-second node))

(defun at-get-right-node (node)
  (at-third node))

; Tree predicate
(defun at-is-leaf? (node)
  (and 
    (null (at-get-left-node node)) 
    (null (at-get-right-node node))))

; Tree build functions

(defun at-make-leaf (data)
  (list data nil nil))

(defun at-make-tree (p fg fd)
  (list p fg fd))

;(defun at-build-tree (il)
;  )
