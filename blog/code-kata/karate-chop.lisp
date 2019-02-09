
(ql:quickload :prove)
(ql:quickload :iterate)
; http://codekata.com/kata/kata02-karate-chop/
(defpackage :karate-chop
  (:use :cl :iterate))
(in-package :karate-chop)
	    

(defun big-ol-array-maker (n)
  " makes unique, sorted (increasing) integer array of length n "
  (let ((k 0)
	(arr (make-array n :element-type 'integer)))
    (iter (for i from 0 below n)
	  (setf (aref arr i) k)
	  (incf k (1+ (random 5))))
    arr))

;; this on makes fixnums (al la cee-lang) instead of unbounded ints,
;; good enough for most purposes
(defun big-ol-array-maker-optimized (n)
  " makes unique, sorted (increasing) integer array of length n "
  (declare (optimize (speed 3) (space 3) (debug 0) (safety 0)))
  (let ((k 0)
	(arr (make-array n :element-type 'fixnum)))
    (iter (for i from 0 below n)
	  (setf (aref arr i) k)
	  (incf k (1+ (random 5))))
    arr))


(defun random-member (arr)
  (aref arr (random (length arr))))

(random-member (big-ol-array-maker 5))

(defun binary-search (el arr &optional (start 0) (end (length arr)))
  "recursive binary search on sorted (ascending) array for el"
  ;; off-by-one-notes:
  ;;   the end is never used as an index, but one below it should.
  ;;   the start index should be used as an index (last, if it is)
  (if (= start end)
      -1
      (let* ((middle (floor (+ start end) 2))
	     (middle-val (aref arr middle)))
      (cond
	((= el middle-val) ;;found it!
	 middle)
	((< el middle-val) ;; go to bottom half
	 (binary-search el arr start middle))
	((> el middle-val)
	 (binary-search el arr (1+ middle) end))))))

;;(print (big-ol-array-maker 20))
(defvar test-arr #(0 3 7 11 14 17 19 21 26 30 32 35 36 41 45 48 53 55 60 64))
(iter (for k in-vector test-arr)
      (prove:is (binary-search k test-arr) (position k test-arr)))

(prove:is (binary-search 1 #(0 2 3)) -1)
(prove:is (binary-search 1 #(0 2 3 4)) -1)
(prove:is (binary-search -1 #(0 2 3 4)) -1)
(prove:is (binary-search 9 #(0 2 3 4)) -1)

;; use this to break out of infinite loops
(defun binary-search (&rest args)
  (cons args nil))

;;(defun time-it (n)
;;  (let* ((arr (big-ol-array-maker n))
;;	 (el (random-member arr)))
;;    (time (binary-search el arr))))
;;
;;(time-it 1000000000)
;;(time-it 1000000)
;;(defun ignore-outut (&rest stuff)
;;  (declare (ignore stuff))
;;  nil)
;;(ignore-outut (time (big-ol-array-maker (expt 10 7))))
;;(ignore-outut (time (big-ol-array-maker-optimized (expt 10 7))))
;;(big-ol-array-maker-optimized 20)

