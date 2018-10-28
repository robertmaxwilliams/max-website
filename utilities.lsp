
;; some utilties. Most everyone depends on this file,
;; and it depends on NOTHING
(defmacro alias (to fn)
    `(setf (fdefinition ',to) #',fn))
(defmacro m-alias (to fn)
  `(setf (macro-function ',to) (macro-function ',fn)))
(defmacro second-value (body) ;; unhygenic, consider let over gensym
  `(multiple-value-bind (x y) ,body y))

(defun unused (&rest stuff)
  nil)
;; os independent line break or something, this is probably garbage
(defparameter nl (format nil "~%"))

;; credit to http://sodaware.sdf.org/notes/cl-read-file-into-string/
;; for this little tool
(defun file-get-lines (filename)
  (with-open-file (stream filename)
    (loop for line = (read-line stream nil)
          while line
          collect line)))

(defun join-lines (lines)
  (format nil "~{~A~^~%~}" lines))

(defun file-get-contents (filename)
    (join-lines (file-get-lines filename)))

(defun stream-get-lines (stream)
    (loop for line = (read-line stream nil)
          while line
          collect line))

(defun stream-get-contents (stream)
    (join-lines (stream-get-lines stream)))

;; takes a stream, returns first n lines consed. Does not check for eof.
(defun take-n-lines (stream n) 
  (cond ((zerop n) nil)
	(t (cons (read-line stream) (take-n-lines stream (1- n))))))

;; because I use it all the time
(m-alias db destructuring-bind)
