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


(let ((foo #(1 2 3 4)))
  (safe-dec foo 0)
  foo)
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

(defun ignore-var (x)
  (declare (ignorable x)))

(defun minsky-register-machine (instructions &optional initial-memory)
  " creates compilable code for given mrm "
  `(let ((memory
	  (make-array (length ,initial-memory)
		      :element-type 'integer
		      :initial-contents ,initial-memory
		      :adjustable t))
	 (jump-count 0)) ;; project against infinite loops and long programs that don't halt
     (ignore-var jump-count)
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
			       (if (< 0 (safe-aref memory ,(cadr instr)))
				   (progn
				     (safe-dec memory ,(cadr instr))
				     (go ,(caddr instr)))
				   (go ,(cadddr instr)))))
			   (t (error (format nil "instruction not known: ~a" (car instr)))))))
     memory))

(defvar adder-program
  '((branch 0 1 3)
    (inc 2)
    (branch 0 1 3)
    (branch 1 4 6)
    (inc 2)
    (branch 1 4 6)
    (inc 5)))

(eval (minsky-register-machine adder-program #(2 3 0 0 0 0)))

(defun adder-program-writer (a b result ln)
  " ln mean linenum "
  `((branch ,a ,(+ 1 ln) ,(+ 3 ln))
    (inc ,result)
    (branch ,a ,(+ 1 ln) ,(+ 3 ln))
    (branch ,b ,(+ 4 ln) ,(+ 6 ln))
    (inc ,result)
    (branch ,b ,(+ 4 ln) ,(+ 6 ln))))

(defun copy-program-writer (a x y ln)
  " copies value at a to x and y "
  `((assign ,ln current-line-number)
    (branch ,a (+ 1 ,ln) (+ 3 ,ln))
    (inc ,x)
    (inc ,y)
    (branch ,a (+ 1 ,ln) (+ 4 ,ln))))

;; TODO implement parser for linenum assign

;;(defvar program-2
;;  `((inc 0) ;; 0 
;;    (inc 0) ;; 1
;;    (inc 0) ;; 2
;;    (inc 1) ;; 3
;;    (inc 1) ;; 4
;;    ,@(copy-program-writer 1 2 3 'mylinenum) 
;;    (inc 5)))
;;(print program-2)

;; TODO finish
;;(defun program-parser (code &default (current-line-number 0) variables)
;;  (cond ((null (code)
;;	       nil))
;;	((or (eql (caar code) 'branch)
;;	     (eql (caar code) 'inc))
;;	 (cons (car code) (program-parse (cdr code)) (1+ current-line-number) variables))
;;	((eql (caar code) 'assign)
;;	 (program-parser (cdr codr) current-line-number (cons (cons (cadar code) current-line-number))))))


;;(eval (minsky-register-machine program-2 #(0 0 0 0 0 0)))
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

;;(recursive-all #'integerp '(1 2 (1 2 3) (a) 3))

(defun accumulate-stream (stream end-fun)
  " lists chars from stream until end-fun returns false on one,
    then put that char back and return "
  (let ((pchar (read-char stream nil 'end-of-stream)))
    (cond
      ((eql pchar 'end-of-stream) nil)
      ((funcall end-fun pchar)
       (progn
	 (unread-char pchar stream)
	 nil))
      (t (cons pchar (accumulate-stream stream end-fun))))))

  
;;(with-input-from-string (s "foo bar")
;;  (coerce (accumulate-stream s (lambda (x) (char= x #\Space)))
;;	  'string))

(defun any (ls)
  (some #'identity ls))
(defun all (ls)
  (every #'identity ls))
(defmacro maplambda (lambda-list lambda-form &rest list-args)
  `(mapcar (lambda ,lambda-list ,lambda-form) ,@list-args))

;;(all '(t t t))
;;(maplambda (x) (+ x 1) '(2 3 4))

(defparameter +whitespace+ (list #\Space #\Newline #\Tab #\Return #\Linefeed))

(defun read-symbol (stream)
  "reads chars from stream to form string or int and returns it"
  (let ((char-list 
	 (accumulate-stream
	  stream
	  (lambda (c) ;; like python (c in ['\n', ' '])
	    (any (maplambda (x) (char= x c) (append (list #\( #\) ) +whitespace+)))))))
    (if (all (mapcar #'digit-char-p char-list))
	(parse-integer (coerce char-list 'string))
	(coerce char-list 'string))))

(with-input-from-string (s "31d")
  (read-symbol s))

(defun trivial-read (stream)
  " reads string for sexp into list of strings "
  (if (stringp stream) ;; convenience for strings
      (with-input-from-string (s stream) (trivial-read s))
      (let ((char (read-char stream nil 'end-of-stream)))
	(cond ((eql char 'end-of-stream)
	       nil)
	      ((char= char #\( )
	       (cons (trivial-read stream) (trivial-read stream)))
	      ((char= char #\) )
	       nil)
	      ((any (maplambda (x) (char= x char) +whitespace+))
	       (trivial-read stream))
	      (t ;; read until space or ) is found, and intern as symbol
	       (progn
		 (unread-char char stream)
		 (cons (read-symbol stream) (trivial-read stream))))))))

(trivial-read "     fooo 0 1 2")


(mapcar #'trivial-read (str:lines " branch 0 1 3
inc 1
branch 4 0 0
inc 4 "))
;;(with-input-from-string (s "(foo
;;
;;   bar (bar 32 foo) bar)")
;;  (trivial-read s))

;;(trivial-read "foo bar rsoco")

;;(string= 'bar (make-symbol "bar"))

;;(make-symbol "bar")
;;(intern "bar")

;;(loop for sym in '(foo bar rosco)
;;   collect (cons (symbol-name sym) sym))
;;(let* ((symbols '(foo bar rocat))
;;       (fob (pairlis (mapcar #'symbol-name symbols) symbols)))
;;  (string-lookup fob "truck"))


(defun string-lookup (key alist)
    (cdr (assoc key alist :test #'string-equal)))
(string-lookup "foo" '(("bar" . bar) ("foo" . foo)))

(defun error-if-null (x &optional (message "That was supposed to be non-null"))
  (if x
      x
      (error message)))

(defun recursive-symbol-swap (ls symbols)
  " recurs through ls. integers pass through, strings try to convert to symbols
    raises error if string not in symbols"
  (let ((name-to-sym (pairlis (mapcar #'symbol-name symbols) symbols)))
    (recursive-symbol-swap-helper ls name-to-sym)))

(safe-aref #(0 2 3) 0)


(defun recursive-symbol-swap-helper (ls str->sym)
  " does the recursion because im a bad programmer "
  (cond
    ((null ls) 
      nil)
    ((stringp ls) (error-if-null (string-lookup ls str->sym)
				 (format nil "~s not in ~a" ls str->sym)))
    ((integerp ls) ls)
    ((not (atom ls)) (cons (recursive-symbol-swap-helper (car ls) str->sym)
			   (recursive-symbol-swap-helper (cdr ls) str->sym)))
    (t (error "yuh mesd up"))))

;;(recursive-symbol-swap '("foo" ("foo" 4 "truck" "bar" 5) "bar") '(foo bar))
;;(ql:quickload :str)
;;(use-package :str)

(defun read-eval-mrm (data-string code-string)
  (let* ((data (trivial-read data-string))
	 (code (mapcar #'trivial-read (str:lines code-string)))
	 (butts (format t "~%[DEBUG] ~%DATA: ~a~%CODE: ~%~a~%" data code))
	 (code-symbols (recursive-symbol-swap code '(inc branch))))
    (assert (every #'integerp data))
    (setf data (cons 'list data))
    (format t "[COMPOLED]~%~a~%~%" (minsky-register-machine code-symbols data))
    (eval (minsky-register-machine code-symbols data))))

(read-eval-mrm "4 0 0 0 0"
	       " branch 0 1 3
		inc 1
		branch 4 0 0
		inc 4 ")

(coerce (caadr (mapcar #'trivial-read
	(str:lines "    branch 0 1 3
		inc 1
		branch 4 0 0
		inc 4 "))) 'list)
(trivial-read (car (str:lines "   basr 4
     unbu 1 2")))
(trivial-read "      fobor")
;;(defun read-eval-mrm (data-string code-string)
;;  (let ((codestring
;;	 (with-output-to-string (codestream)
;;	   (with-input-from-string (s description-string)
;;	     (format codestream "((~a)~%" (read-line s nil))
;;	     (do ((line (read-line s nil) ;; var init-form
;;			(read-line s nil))) ;; step=form
;;		 ((null line) (format codestream ")"))
;;	       (format codestream "(~a)~%" line))))))
;;    (with-input-from-string (s codestring)
;;      (let ((forms (read s)))
;;	(pprint forms)
;;	;; assert for safety before eval. Still has read vunerabilities but wattaya gonna do about it
;;	(assert (recursive-all (lambda (x) (or (integerp x)
;;					       (string= x 'list)
;;					       (string= x 'inc)
;;					       (string= x 'branch)))
;;			       forms))
;;	(setf forms (remove nil forms)) ;; remove bottom level nils
;;	(if (not (string= "list" (caar forms))) ;; if starts on a code line
;;	    (setf forms (cons nil forms))) ;; prepend an empty list
;;	(eval (minsky-register-machine (cdr forms) (car forms)))))))
;;


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
