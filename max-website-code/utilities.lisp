(in-package :max-website)

;; some utilties. Most everyone depends on this file,
;; and it depends on nothing local
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

(defun zero-if-nil (x)
  (if x x 0))

(defun default-value (default x)
  (if x x default))


(defun list-to-2d-array (lsls)
  "Takes in a jagged 2d list and converts to array left justified, 
padded with zeros"
  (let ((empty-array
	 (make-array (list (length lsls)
			   (loop for ls in lsls maximize (length ls)))
		     :initial-element 0)))
    (loop for ls in lsls
       for i from 0
	 do (loop for x in ls
	       for j from 0
	       do (setf (aref empty-array i j) x)))
    empty-array))
;; (list-to-2d-array '((0 1) (2 3 4 5)))
;; (with-output-to-string (s) (2d-table-from-list s '((1 2) (3 4 6))))

;; TODO make tests? Nah.

(defun bare-url-p (url) ;; check if the request uri is just /blog
  (< (length (str:split "/" url)) 3))



(defmacro maplb (function list)
  "lapmambda like this: (maplb (+ 1 it) '(1 2 3 4))"
  `(mapcar #'(lambda (it) ,function) ,list))

(defmacro mapfor (var-in-list function)
  "ex: (mapfor (x in '(1 2 3)) (1+ x))"
  (destructuring-bind (var the-word-in list) var-in-list
    (assert (eql 'in the-word-in))
    `(mapcar #'(lambda (,var) ,function) ,list)))


(defun safety-cap (max-abs-value default-value x)
  " If (abs x) is above max, return 0 "
  (if (> (abs x) max-abs-value) default-value x))
      

