#| Exprimental features
(defun prompt-read-expect (prompt pred)
	(format *query-io* "~a: " prompt)
	(force-output *query-io*)
	(let ((response (read-line *query-io*)))
		(if (funcall pred response)
			response
			(prompt-read-expect prompt pred))))

(defun yes-or-no-p (c)
	(or 
		(string= c "y") 
		(string= c "n")))
 |#

; Create a global variable containg our database
(defvar *db* nil)

(defun make-cd (title artist rating ripped)
	(list 
		:title title
		:artist artist
		:rating rating
		:ripped ripped))

(defun add-record (cd) (push cd *db*))

(add-record (make-cd "Roses" "Kathy Mattea" 7 t))
(add-record (make-cd "Fly" "Dixie Chicks" 8 t))
(add-record (make-cd "Home" "Dixie Chicks" 9 t))
(add-record (make-cd "Oyasumi" "Lomepal" 10 t))

(defun dump-db ()
	(dolist (cd *db*) 
		(format t "~{~a:~10t'~a'~%~}~%" cd)))

(defun prompt-read (prompt)
	(format *query-io* "~a: " prompt)
	(force-output *query-io*)
	(read-line *query-io*))

(defun prompt-for-cd ()
	(make-cd
		(prompt-read "Title")
		(prompt-read "Artist")
		(or
			(parse-integer (prompt-read "Rating") :junk-allowed t)
			0)
		(y-or-n-p "Ripped")))


(defun repl-db ()
	(loop (add-record (prompt-for-cd))
		(if (not (y-or-n-p "Another:"))
			(return))))

(defun save-db (filename)
	(with-open-file (out filename
					:direction :output
					:if-exists :supersede)
		(with-standard-io-syntax
			(print *db* out))))

(defun load-db (filename)
	(with-open-file (in filename)
		(with-standard-io-syntax
			(setf *db* (read in)))))

; Accesses functions

(defun select-db (key val)
	(remove-if-not 
		#'(lambda (cd) (equal (getf cd key) val)) *db*))

(defun select-by-artist (name)
	(select-db :artist name))