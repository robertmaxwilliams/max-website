
;; that last one got so confusing, I'm starting over. Data munge is
;; a pretty great programming task



(ql:quickload :parse-float)
(ql:quickload :str)
(ql:quickload :iterate)
(ql:quickload :prove)
(ql:quickload :uiop)
(use-package :iterate)

(defvar *n* (format nil "~%"))

(defun p (&rest args)
  " python style printing"
  (if args
      (progn
	(format t "~a " (if (stringp (car args))
				     (str:replace-all "\\n" *n* (car args))
				     (car args)))
	(apply #'p (cdr args)))
      (format t "~%")))

(defun parse-float-or-string (s)
  " convert a string to a float (if it's a float) otherwise return a string"
  (setf s (remove #\* s))
  (let ((float-or-nil (parse-float:parse-float s :junk-allowed t)))
    (cond
      ((str:blankp s) nil)
      ((null float-or-nil) (str:trim s))
      (t float-or-nil))))

(defun even-index-elements (ls)
  (iter (for x in ls)
	(for i from 0)
	(if (evenp i) (collect x))))
	    
  
(defun start-of-every-word (s)
  "returns start indices of each 'word' in a string"
  (let ((word-start (ppcre:create-scanner
		     '(:sequence :WORD-BOUNDARY))))
    (even-index-elements (even-index-elements (ppcre:all-matches word-start s)))))

(defun end-cons (ls x)
  (append ls (list x)))
(end-cons '(1 2 3) 4)

(defun word-boundary-indices (s)
  " returns list of pairs that slice words, with 1 leading space for each word"
  ;; BUG if no leading space (doesn't happen in dataset) will have index -1, BAD
  (let ((start-indices (mapcar #'1- (start-of-every-word s)))
	(end-index (1- (length s))))
    (mapcar #'list start-indices (end-cons (cdr start-indices) end-index))))

(defun word-boundary-slicer-maker (s)
  (let ((word-boundaries (word-boundary-indices s)))
    (lambda (data-string)
      (iter (for (start end) in word-boundaries)
	    (collect (subseq data-string start end))))))

;(defun word-boundary-slices (s)
;  (iter (for (start end) in (word-boundary-indices s))
;	(collect (subseq s start end))))

(let ((slicer (word-boundary-slicer-maker " foo bar  rosco ")))
  (funcall slicer                         " 1   2     3    "))

(subseq "foo" 1 2)

(defun football-prepro (lines)
  (iter (for line in lines)
	(for i from 0)
	(if (= i 0) (setf (aref line 3) #\n))
	(if (not (or (str:blankp line) (str:blankp (remove #\- line))))
	    (collect line))))

(defun pad-to-length (str len)
  "add whitespace string to make length"
  ;; str:repeat ignores negative! Nice.
  (str:concat str (str:repeat (- len (length str)) " ")))

(defun weather-prepro (lines)
  " remove blank lines and pad with spaces to same length as header"
  (let ((header-len (length (car lines))))
    (iter (for line in lines)
	  (for i from 0)
	  (if (not (str:blankp line))
	      (collect (pad-to-length line header-len))))))

(p (uiop:read-file-lines "football.dat"))
(p (football-prepro (uiop:read-file-lines "football.dat")))
		 
		 


(defun read-file-to-table (filename &optional (prepro #'identity))
  (let* ((lines (funcall prepro (uiop:read-file-lines filename)))
	 (slicer (word-boundary-slicer-maker (car lines))))
	 ;;(headers (mapcar #'str:trim (funcall slicer (car lines)))))
    (iter (for cells in (mapcar slicer lines))
	  (collect (mapcar #'parse-float-or-string cells)))))

(string-equal "foo" "Foo")
(defun table-lookup-column (col-name table)
  (let ((index (position col-name (car table) :test #'string-equal)))
    (iter (for row in (cdr table))
	  (collect (nth index row)))))

(defun table-lookup-row (col-name value table)
  (let ((index (position col-name (car table) :test #'string-equal)))
    (iter (for row in (cdr table))
	  (if (eql (nth index row) value)
	      (collect row)))))

(defvar foo (read-file-to-table "football.dat" #'football-prepro))
(p foo)
(p)
(car foo)
(table-lookup-column "n" foo)
(table-lookup-row "Team" "Derby" foo)
(p (cadr foo))

(defun maximize-cadr-caddr-difference (a b)
    (destructuring-bind (day-a max-a min-a day-b max-b min-b) (append a b)
      (declare (ignore day-a day-b))
      (if (> (abs (- max-a min-a)) (abs (- max-b min-b))) a b)))

(defun minimize-cadr-caddr-difference (a b)
    (destructuring-bind (day-a max-a min-a day-b max-b min-b) (append a b)
      (declare (ignore day-a day-b))
      (if (< (abs (- max-a min-a)) (abs (- max-b min-b))) a b)))

(p "Day with highest temp spread:")
(p
 (let* ((weather (read-file-to-table "weather.dat" #'weather-prepro)))
  (car
   (reduce 
    #'maximize-cadr-caddr-difference
    (mapcar #'list (table-lookup-column "Dy" weather)
	    (table-lookup-column "MxT" weather)
	    (table-lookup-column "MnT" weather))))))

(p "Team with smallest for/against spread:")
(p
 (let* ((football (read-file-to-table "football.dat" #'football-prepro)))
  (car
   (reduce 
    #'minimize-cadr-caddr-difference
    (mapcar #'list (table-lookup-column "Team" football)
	    (table-lookup-column "F" football)
	    (table-lookup-column "A" football))))))
		  
;;
;;	(reduce (list day max min) by (- max min))))
;;  (iter (for day in (table-lookup-column "Dy" weather))
;;        (for max in (table-lookup-column "MxT" weather))
;;	(for min in (table-lookup-column "MnT" weather))
;;	(reduce (list day max min) by (- max min))))
;;   
