
;; Download this text file, then write a program to output the day number (column one) with the
;; smallest temperature spread (the maximum temperature is the second column, the minimum the third
;; column).

;; I looked at the head of the file, and the first line is column
;; names, second is blank, and third starts all the data

;; I think I'll make it into a 2d array, with an alist from column name to second index.

(ql:quickload :parse-float)
(ql:quickload :str)
(ql:quickload :iterate)
(ql:quickload :prove)
(ql:quickload :uiop)
(use-package :iterate)

(defun get-start-indexes (string)
  " one less than the start of every word. Should probably start with a space!"
  (append
   (iter (for c in-vector string)
	 (for i from 0)
	 (for p previous c)
	 (if (and
	      (ignore-errors (not (alphanumericp p)))
	      (alphanumericp c))
	     (collect (1- i))))
   (list (1- (length string)))))

(prove:is (get-start-indexes "  foo bar  rosco ") '(1 5 10 16))

(iter (for a-b on '(a b c d e))
      (collect (list (car a-b) (cadr a-b))))

(defun parse-float-or-string (s)
  (setf s (remove #\* s))
  (let ((float-or-nil (parse-float:parse-float s :junk-allowed t)))
    (cond
      ((str:blankp s) nil)
      ((null float-or-nil) (str:trim s))
      (t float-or-nil))))

(defun extract-data (data-str indexes)
  (mapcar
   #'parse-float-or-string
   (iter (for a-b on indexes)
	 (if (cadr a-b)
	     (collect (if (< (cadr a-b) (length data-str))
			  (subseq data-str (car a-b) (cadr a-b))
			  ""))))))

(prove:is (extract-data  "  foo bar  rosco " (get-start-indexes "  foo bar  rosco "))
	  '("foo" "bar" "rosco"))
  
(defun first-line-to-parser (s)
  " produces a function that takes in a data line and requested keys and produces a list"
  (let ((start-end-indexes (get-start-indexes s))
	(col-names (str:words s)))
    ;;(print start-end-indexes)
    (lambda (data-str keys)
      (let* ((data (extract-data data-str start-end-indexes))
	     (col->data (mapcar #'list col-names data)))
	;;(print col->data)
	col->data))))
	;;;(mapcar (lambda (key) (assoc key col->data :test #'string=)) keys)))))



;; ==========================
;; WEATHER.DAT SECTION
;; ==========================

(defun spread (day-max-min)
  (- (cadr (assoc "MxT" day-max-min :test #'string=)) (cadr (assoc "MnT" day-max-min :test #'string=))))
(defun day-number (day-max-min)
  (cadr (assoc "Dy" day-max-min :test #'string=)))

(defun keep-maximum-spread (day-max-min-1 day-max-min-2)
  " used to `reduce` a list to the item with largest spread"
  (if (> (spread day-max-min-1) (spread day-max-min-2))
      day-max-min-1 day-max-min-2))

;;(defun table-p (table)
;;  (flet ((extract-keys (alist)
;;	   (mapcar #'car (alist))))
;;    (let ((cannon-keys (extract-keys (car table))))
;;      (iter (for row in table)
;;	    (iter (

(defun file-to-table (filename)
  " turns a tabular text file to list of alist (aka table)"
  (let* ((lines (uiop:read-file-lines filename))
	 (header (car lines))
	 (data-lines (cddr lines))
	 (parser (first-line-to-parser header)))))

(defun data-munge (filename)
  " get day with highest temp spread"
  (let* ((lines (uiop:read-file-lines filename))
	 (header (car lines))
	 (data-lines (cddr lines))
	 (parser (first-line-to-parser header))
	 (day-max-mins
	  (iter (for data-str in data-lines)
		(collect (funcall parser data-str '("Dy" "MxT" "MnT" "AvT"))))))
    (reduce #'keep-maximum-spread day-max-mins)))

(data-munge "weather.dat")
(print "")

(defun data-munge-dumb ()
  (let* ((lines (uiop:read-file-lines "weather.dat"))
	 (data-lines (mapcar
		      (lambda (str) (substitute #\space #\* str))
		      (cddr lines))))
    (labels ((day-str (data) (str:trim (subseq data 0 4)))
	     (spread (data) (- (parse-float:parse-float (subseq data 6 10))
			       (parse-float:parse-float (subseq data 10 16))))
	     (spread-day (data) (list (spread data) (day-str data)))
	     (max-car (a b) (if (> (car a) (car b)) a b)))
      (reduce #'max-car (mapcar #'spread-day data-lines)))))
(data-munge-dumb)
    
	 
;; ==========================
;; FOOTBALL.DAT SECTION
;; ==========================
	 

(defun football-keep-maximum-spread (day-max-min-1 day-max-min-2)
  " used to `reduce` a list to the item with largest spread"
  (flet ((football-spread (day-max-min)
	   (- (cadr (assoc "F" day-max-min :test #'string=))
	      (cadr (assoc "A" day-max-min :test #'string=))))
	 (team-name (day-max-min)
	   (cadr (assoc "Team" day-max-min :test #'string=))))
    (if (> (football-spread day-max-min-1) (football-spread day-max-min-2))
	day-max-min-1 day-max-min-2)))

(defun remove-lines-with-only (lines str)
  " lines is list of strings, if a line contains only characters in str it is discarded"
  (iter (for line in lines)
	(iter (for c in-string str)
	      (setf line (remove c line)))
	(if (not (str:emptyp line))
	    (collect line))))

(prove:is
 (remove-lines-with-only '("aaa" " bbb - " " --- ") "- ")
 '("aaa" "bbb"))

(defun football-munge ()
  " get day with highest temp spread"
  (let* ((filename "football.dat")
	 (lines (uiop:read-file-lines filename))
	 (header (car lines)))
    (setf (aref header 3) #\N) ;; the columns need names to they don't get 
    (setf (aref header 47) #\x);;  mixed in with the data
    (let* ((data-lines (remove-lines-with-only (cddr lines) "- "))
	   (parser (first-line-to-parser header))
	   (day-max-mins
	    (iter (for data-str in data-lines)
		  (collect (funcall parser data-str '("Team" "F" "A"))))))
      (reduce #'football-keep-maximum-spread day-max-mins)
      (day-max-mins))))

(football-munge)
(print "")

(defun data-munge-dumb ()
  (let* ((lines (uiop:read-file-lines "weather.dat"))
	 (data-lines (mapcar
		      (lambda (str) (substitute #\space #\* str))
		      (cddr lines))))
    (labels ((day-str (data) (str:trim (subseq data 0 4)))
	     (spread (data) (- (parse-float:parse-float (subseq data 6 10))
			       (parse-float:parse-float (subseq data 10 16))))
	     (spread-day (data) (list (spread data) (day-str data)))
	     (max-car (a b) (if (> (car a) (car b)) a b)))
      (reduce #'max-car (mapcar #'spread-day data-lines)))))
(data-munge-dumb)
    
    

(str:words     "Dy MxT   MnT   AvT   HDDay  AvDP 1HrP TPcpn WxType PDir AvSp Dir MxS SkyC MxR MnR AvSLP")
(str:words  "   1  88    59    74          53.8       0.00 F       280  9.6 270  17  1.6  93 23 1004.5")
    
(parse-float:parse-float "*    43" :junk-allowed t)
(remove #\* "asfw* sfs**sd ")

(parse-float-or-string " a  ")

