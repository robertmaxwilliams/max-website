
(ql:quickload :str)
(ql:quickload :iterate)
(use-package :iterate)

(setq *print-circle* t)

(defstruct (rb-tree (:conc-name rb-))
  (parent nil :type (or rb-tree null))
  value
  (color nil :type (member red black))
  (left nil :type (or rb-tree null))
  (right nil :type (or rb-tree null)))

(defun rb-side (tree side)
  " useful for dynamically selecting a side, otherside difficult"
  (ecase side
    (left (rb-left tree))
    (right (rb-right tree))))

(defun (setf rb-side) (new-value tree side)
  " woah dfsetf is awesome! Damn that's neat!"
  (ecase side
    (left (setf (rb-left tree) new-value))
    (right (setf (rb-right tree) new-value))))


(defvar *n* (format nil "~%")) ;; standard newline

(defun p (&rest args)
  (if args
      (progn
	(format t "~a " (if (stringp (car args))
				     (str:replace-all "\n" *n* (car args))
				     (car args)))
	(apply #'p (cdr args)))
      (format t "~%")))

(defun pp (printables &key (stream t) (sep " ") (end "~%"))
  (format stream (str:concat "~{~a~^" sep "~}" end) printables))

(format t "|||- 4")
(pp (list (str:join "" '("|" "|" "|")) "-" 3 'black) :stream t)


(defun print-rb-tree (root &optional (stream t) (barstack nil))
  (if (null root)
      nil
      (progn
	(pp (list (str:join "" barstack) "-" (rb-value root) (rb-color root)) :stream stream)
	(print-rb-tree (rb-left root) stream (cons "|" barstack))
	(print-rb-tree (rb-right root) stream (cons "|" barstack)))))

(defmethod print-object ((root rb-tree) stream)
  (print-rb-tree root stream))
  


(defun rb-insert (root value)
  (let ((side (if (< (rb-value root) value)
		  'right 'left)))
    (if (null (rb-side root side))
	(setf (rb-side root side)
	      (make-rb-tree :parent root  :value value :color 'red))
	(rb-insert (rb-side root side) value))))

(defun rb-right-rotate (root)
  "https://en.wikipedia.org/wiki/Tree_rotation"
  (let ((q root)
	(p (rb-left root))
	(a (rb-right root))
	(b (rb-right (rb-left root)))
	(c (rb-right root)))
    (setf (rb-left p) a)
    (setf (rb-right p) q)
    (setf (rb-left q) b)
    (setf (rb-right q) c)))

(defun rb-left-rotate (root)
  "https://en.wikipedia.org/wiki/Tree_rotation"
  (let ((p root)
	(q (rb-right root))
	(a (rb-left root))
	(b (rb-left (rb-right root)))
	(c (rb-right (rb-right root))))
    (setf (rb-left q) p)
    (setf (rb-right q) c)
    (setf (rb-left p) a)
    (setf (rb-right p) b)))

(defun rb-find (root value))

(defvar foo (make-rb-tree :value 4 :color 'black))
(print-rb-tree foo)
(rb-insert foo (random 10))
(p)

(print-rb-tree foo)
(rb-left-rotate foo)
(rb-right-rotate foo)

(print-rb-tree foo)
(print foo)

(print-rb-tree (rb-side foo 'right))

(setf (rb-left foo) (make-rb-tree :value 2 :color 'black))
(setf (rb-right foo) (make-rb-tree :value 1 :color 'black))
(print foo)
