
;; Download this text file, then write a program to output the day number (column one) with the
;; smallest temperature spread (the maximum temperature is the second column, the minimum the third
;; column).

;; I looked at the head of the file, and the first line is column
;; names, second is blank, and third starts all the data

;; I think I'll make it into a 2d array, with an alist from column name to second index.

(ql:quickload :parse-float)
(ql:quickload :str)
(ql:quickload :iterate)
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

(get-start-indexes "  foo bar  rosco ")
(extract-data  "  foo bar  rosco " (get-start-indexes "  foo bar  rosco "))

(iter (for a-b on '(a b c d e))
      (collect (list (car a-b) (cadr a-b))))

(defun extract-data (data-str indexes)
  (mapcar
   #'parse-float-or-string
   (iter (for a-b on indexes)
	 (if (cadr a-b)
	     (collect (if (< (cadr a-b) (length data-str))
			  (subseq data-str (car a-b) (cadr a-b))
			  ""))))))

(extract-data " a b cc d e " '(0 2 4 6 9))
  
(defun first-line-to-parser (s)
  " produces a function that takes in a data line and requested keys and produces a list"
  (let ((start-end-indexes (get-start-indexes s))
	(col-names (str:words s)))
    (print start-end-indexes)
    (lambda (data-str keys)
      (let* ((data (extract-data data-str start-end-indexes))
	     (col->data (mapcar #'list col-names data)))
	(print col->data)
	(mapcar (lambda (key) (assoc key col->data :test #'string=)) keys)))))
(funcall
 (first-line-to-parser
  "  Dy MxT   MnT   AvT   HDDay  AvDP 1HrP TPcpn WxType PDir AvSp Dir MxS SkyC MxR MnR AvSLP")
 "   1  88    59    74          53.8       0.00 F       280  9.6 270  17  1.6  93 23 1004.5"
 '("Dy" "1HrP"))
		
(lookup 
 (index-line-maker "Dy MxT   MnT   AvT   HDDay  AvDP 1HrP TPcpn WxType PDir AvSp Dir MxS SkyC MxR MnR AvSLP")
 (mapcar #'parse-float-or-string (str:words "   1  88    59    74          53.8       0.00 F       280  9.6 270  17  1.6  93 23 1004.5"))
 "MxR")

(ql:quickload :uiop)

(defun spread (day-max-min)
  (- (cadr (assoc "MxT" day-max-min :test #'string=)) (cadr (assoc "MnT" day-max-min :test #'string=))))
(defun day-number (day-max-min)
  (cadr (assoc "Dy" day-max-min :test #'string=)))

(defun keep-maximum-spread (day-max-min-1 day-max-min-2)
  (if (> (spread day-max-min-1) (spread day-max-min-2))
      day-max-min-1 day-max-min-2))

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

(ql:quickload :parse-float)
(ql:quickload :str)
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
(defun parse-float-or-string (s)
  (setf s (remove #\* s))
  (let ((float-or-nil (parse-float:parse-float s :junk-allowed t)))
    (cond
      ((str:blankp s) nil)
      ((null float-or-nil) (str:trim s))
      (t float-or-nil))))

(parse-float-or-string " a  ")

parse-float 
