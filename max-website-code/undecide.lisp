(in-package :max-website)

;; implementing some of the languages described in
;; http://www.ams.org/notices/201003/rtx100300343p.pdf



(defun fractran-helper (fraction-seq n)
  " does the tail recursion for fractran"
  (cond ((null fraction-seq) nil)
	((integerp (* n (car fraction-seq)))
	 (* n (car fraction-seq)))
	(t (fractran-helper (cdr fraction-seq) n))))

(defun fractran (fraction-seq n &key (limit 1000))
  " multiplies n by the first fraction that yields an int, or halts"
  (loop while (and (not (null n)) (< i limit))
     for i from 0
     collect n
     do (setf n (fractran-helper fraction-seq n))))

(defun power-of-ten? (n)
  (cond ((= n 10) t)
	((integerp (/ n 10)) (power-of-ten? (/ n 10)))
	(t nil)))

;;(mapcar (lambda (n) (floor (log n 10)))
;;	(remove-if-not
;;	 #'power-of-ten?
;;	 (fractran
;;	  '(3/11 847/45 143/6 7/3 10/91 3/7 36/325 1/2 36/5)
;;	  10 :limit 1000000)))
;;
;;(let ((array (make-array 4 :adjustable t :element-type 'integer)))
;;  (setf (aref array 0) 2)
;;  (print (safe-aref array 10))
;;  (setf array (safe-inc array 10))
;;  (print (safe-aref array 10))
;;  (print (length array))
;;  (print array))

(defun safe-aref (array index)
  " safe access - returns zero if out of range "
  (if (>= index (length array))
      0
      (aref array index)))

(defun safe-inc (array index)
  " safe incf - grows array if index is out of range"
  (if (>= index (length array))
      (adjust-array array (list (+ index 5)) :initial-element 0))
  (incf (aref array index))
  array)

(defun safe-dec (array index)
  " safe decf - grows array if index is out of range"
  (if (>= index (length array))
      (adjust-array array (list (+ index 5)) :initial-element 0))
  (decf (aref array index))
  array)
"
Instruction I_n: Increment a_n
and go on to instruction I_n1
or
Instruction I_n: If register
an > 0, decrement an and
go to instruction I_n1 ; otherwise
go to instruction I_n2 .
"

;;;; long form: (not implemented)
;;'(
;;  0 (increment :register 0)
;;  1 (conditional :register 0 :jump 0 :orjump 1))
;;
;;;; condenced to:
;;'(inc 0)       ;;0
;;(branch 0 0 1) ;;1
;;)
;;


(defun minsky-register-machine (instructions &optional initial-memory)
  " creates compilable code for given mrm "
  `(let ((memory
	  (make-array (length ,initial-memory)
		      :element-type 'integer
		      :initial-contents ,initial-memory
		      :adjustable t))
	 (jump-count 0)) ;; project against infinite loops and long programs that don't halt
     (tagbody
	,@(loop for instr in instructions
	     for i from 0
	     collect i
	     collect (cond ((string= (car instr) 'inc)
			    `(safe-inc memory ,(cadr instr)))
			   ((string= (car instr) 'branch)
			    `(progn
			       (incf jump-count)
			       (if (> jump-count 100000) (error "jump count exceeded"))
			       (if (> 0 (safe-aref memory ,(cadr instr)))
				   (progn
				     (safe-dec memory ,(cadr instr))
				     (go ,(caddr instr)))
				   (go ,(cadddr instr)))))
			   (t (error (format nil "instruction not known: ~a" (car instr)))))))
     memory))


;;(minsky-register-machine
;; ((inc 0)
;;  (inc 1)
;;  (branch 0 4 3)
;;  (inc 0)
;;  (inc 10)
;;  (inc 0))
;; '(0 0 0 0 0 0 0 1))
;;



(defun recursive-all (checkfun ls)
  (cond ((null ls)
	 t)
	((atom ls)
	 (funcall checkfun ls))
	(t
	 (and (recursive-all checkfun (car ls)) (recursive-all checkfun (cdr ls))))))
(recursive-all #'integerp '(1 2 (1 2 3) (a) 3))

(defun read-eval-mrm (description-string)
  (let ((codestring
	 (with-output-to-string (codestream)
	   (with-input-from-string (s description-string)
	     (format codestream "((~a)~%" (read-line s nil))
	     (do ((line (read-line s nil) ;; var init-form
			(read-line s nil))) ;; step=form
		 ((null line) (format codestream ")"))
	       (format codestream "(~a)~%" line))))))
    (with-input-from-string (s codestring)
      (let ((forms (read s)))
	(pprint forms)
	;; assert for safety before eval. Still has read vunerabilities but wattaya gonna do about it
	(assert (recursive-all (lambda (x) (or (integerp x)
					       (string= x 'list)
					       (string= x 'inc)
					       (string= x 'branch)))
			       forms))
	(setf forms (remove nil forms)) ;; remove bottom level nils
	(if (not (string= 'list (caar forms))) ;; if starts on a code line
	    (setf forms (cons nil forms))) ;; prepend an empty list
	(eval (minsky-register-machine (cdr forms) (car forms)))))))



;;(defpackage :foobar
  ;;(:use :cl))
;;(in-package :foobar)
;;(string= 'cl-user::foo 'foo)

;;(read-eval-mrm " list 0 0 0 1 0
;;inc 0
;;inc 1
;;branch 0 4 5
;;inc 0
;;inc 0
;;inc 0")
