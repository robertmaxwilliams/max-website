(the (member foo br) 'foo)

(defstruct (rb-tree (:conc-name rb-))
  (parent nil :type (or rb-tree null))
  value
  (color nil :type (member red black))
  (left nil :type (or rb-tree null))
  (right nil :type (or rb-tree null)))

(defvar foo (make-rb-tree :value 4 :color 'red))
(setf (rb-left foo) (make-rb-tree :value 2 :color 'black))
(setf (rb-right foo) (make-rb-tree :value 1 :color 'black))
(print foo)

(ql:quickload :str)
(defvar *n* (format nil "~%")) ;; standard newline

(defun p (&rest args)
  (if args
      (progn
	(format t "~a " (if (stringp (car args))
				     (str:replace-all "\n" *n* (car args))
				     (car args)))
	(apply #'p (cdr args)))
      (format t "~%")))

(defun print-rb-tree (root &optional (barstack nil))
  (if (null root)
      nil
      (progn
	(p (str:join "" barstack) "-" (rb-value root) (rb-color root) )
	(print-rb-tree (rb-left root) (cons "|" barstack))
	(print-rb-tree (rb-right root) (cons "|" barstack)))))


(print-rb-tree foo)
