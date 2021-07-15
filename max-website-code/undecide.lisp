(in-package :max-website)

;; implementing some of the languages described in
;; http://www.ams.org/notices/201003/rtx100300343p.pdf

;; Actually, just minsky register machine for now.

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

;;(eval (minsky-register-machine adder-program #(2 3 0 0 0 0)))

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

(defun any (ls)
  (some #'identity ls))

(defun all (ls)
  (every #'identity ls))

(defmacro maplambda (lambda-list lambda-form &rest list-args)
  `(mapcar (lambda ,lambda-list ,lambda-form) ,@list-args))

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

(defun string-lookup (key alist)
    (cdr (assoc key alist :test #'string-equal)))

(defun error-if-null (x &optional (message "That was supposed to be non-null"))
  (if x
      x
      (error message)))

(defun recursive-symbol-swap (ls symbols)
  " recurs through ls. integers pass through, strings try to convert to symbols
    raises error if string not in symbols"
  (let ((name-to-sym (pairlis (mapcar #'symbol-name symbols) symbols)))
    (recursive-symbol-swap-helper ls name-to-sym)))

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

(defun read-eval-mrm (data-string code-string)
  (let* ((data (trivial-read data-string))
	 (code (mapcar #'trivial-read (str:lines code-string)))
	 (butts (format t "~%[DEBUG] ~%DATA: ~a~%CODE: ~%~a~%" data code))
	 (code-symbols (recursive-symbol-swap code '(inc branch))))
    (assert (every #'integerp data))
    (setf data (cons 'list data))
    ;;(format t "[COMPOLED]~%~a~%~%" (minsky-register-machine code-symbols data))
    (eval (minsky-register-machine code-symbols data))))
