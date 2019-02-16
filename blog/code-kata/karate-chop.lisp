
(ql:quickload :prove)
(ql:quickload :iterate)
(ql:quickload :alexandria)
; http://codekata.com/kata/kata02-karate-chop/
(defpackage :karate-chop
  (:use :cl :iterate :alexandria))
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



(defun binary-search-multiple (el arr)
  (labels ((collect-until-not-equal (el arr i fun)
	     (if (eql (ignore-errors (aref arr i)) el)
		 (cons i (collect-until-not-equal
			  el arr (funcall fun i) fun)))))
    (let ((i (binary-search el arr)))
      (if (= i -1)
	  -1
	  (append (reverse (cdr (collect-until-not-equal el arr i #'1-)))
		  (collect-until-not-equal el arr i #'1+))))))

(binary-search-multiple 3 (vector 1 2 3 3 3 4 5))



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

;; try two: make a totally different algorithm for binary search


 (setq a1 (make-array 5)) =>  #<ARRAY 5 simple 46115576>
 (setq a2 (make-array 4 :displaced-to a1
                        :displaced-index-offset 1))

(aref #(1 2 3) 5)

(defun add-if-positive (x n)
  "adds x to n if n is an int and >=0, otherwise just returns n"
  (if (and (numberp n) (>= n 0))
      (+ n x)
      n))

(defun binary-search-2 (el arr)
  "similar to before, but using displaced arrays"
  (let* ((len (length arr))
	 (middle (floor (length arr) 2))
	 (middle-el (ignore-errors (aref arr middle))))
    (cond
      ((= 0 (length arr)) ;; array is empty
       -1)
      ((= el middle-el) ;; found it!
       middle)
       ((< el middle-el) ;; if el > middle, we need to take bottom half
	(binary-search-2
	 el
	 (make-array
	  (floor len 2) ;; length of bottom half
	  :displaced-to arr
	  :displaced-index-offset 0)))
      ((> el middle-el) ;; if el > middle, we need to take top half
       ;; displace output index same as array, since it starts higher
       ;; up now. Also, have to check if negative
       (add-if-positive
	(1+ middle)
	(binary-search-2
	 el
	 (make-array
	  (floor (1- len) 2) ;; length of top
	  :displaced-to arr
	  :displaced-index-offset (1+ middle))))))))

(binary-search-2 1 #(1 2 3 4 5 6 7))

(defvar test-arr #(0 3 7 11 14 17 19 21 26 30 32 35 36 41 45 48 53 55 60 64))
(iter (for k in-vector test-arr)
      (prove:is (binary-search-2 k test-arr) (position k test-arr)))

(prove:is (binary-search-2 1 #(0 2 3)) -1)
(prove:is (binary-search-2 1 #(0 2 3 4)) -1)
(prove:is (binary-search-2 -1 #(0 2 3 4)) -1)
(prove:is (binary-search-2 9 #(0 2 3 4)) -1)


(defun barr (x)
  (block nil 
    (if (= x 2)
	(return 'two))
    (if (= x 3)
	(return 'three))
    (return 'none)
    'nile))

(barr 4)

;; using iter this time
;; and Cee style programming, with returns and such
;; I started off with several if's, in true algol tradition,
;; then wished I had if-else, then realized that cond is if-else
;; but better
(defun binary-search-3 (el arr)
  (block main
    (if (zerop (length arr))
	(return-from main -1))
    (let* ((start 0)
	   (len (length arr))
	   (end (1- len))
	   (middle (floor len 2))
	   (middle-el nil))
      (iter (repeat 100)
	    (setf middle (floor (+ start end) 2)) ;; forgot this for 10 minutes!
	    (setf middle-el (aref arr middle))
	    (cond ;; returning forms can be placed outside cond if desired
	      ((= el middle-el) (return-from main middle))
	      ((> el middle-el) ;; check top half
	       (setf start (1+ middle)))
	      ((< el middle-el) ;; check bottom hal
	       (setf end middle))
	      (t (print "that shouldnt happen")))
	    ;; special case for last element
	    (if (<= (- end start) 1) (return-from main
				       (cond ((= el (aref arr start))
					      start)
					     ((= el (aref arr end))
					      end)
					     (t -1))))
	    ;; terminating condition
	    (if (<= (- end start) 0) (return-from main -1))
	    (finally (return-from main 'bad))))))

(binary-search-3 7 #(1 2 3 4 5 6 7))

(defvar test-arr #(0 3 7 11 14 17 19 21 26 30 32 35 36 41 45 48 53 55 60 64))
(iter (for k in-vector test-arr)
      (prove:is (binary-search-3 k test-arr) (position k test-arr)))

(prove:is (binary-search-3 1 #(0 2 3)) -1)
(prove:is (binary-search-3 1 #(0 2 3 4)) -1)
(prove:is (binary-search-3 -1 #(0 2 3 4)) -1)
(prove:is (binary-search-3 9 #(0 2 3 4)) -1)


;;

(defun average (a b)
  (floor (+ a b) 2))


;; doing a strictly goto based program.
;; Additional restriction: branches of `if` function can ONLY BE GOTOs
(defun binary-search-4 (el arr)
  (let (start len end middle middle-el)
    (tagbody
       (setf start 0)
       (setf len (length arr))
       (setf end len)
     tag-start
       ;; no more remaining values, return -1
       (if (= 0 (- end start)) (go tag-failure))
       (setf middle (average start end))
       (setf middle-el (aref arr middle))
       (if (= middle-el el) (go tag-found-el))
       (if (< middle-el el) (go tag-bottom-half))
       (if (> middle-el el) (go tag-top-half))
     (error "trap reached")

     tag-found-el
       (go tag-end)
     tag-bottom-half
       (setf start (1+ middle))
       (go tag-start)
     tag-top-half
       (setf end middle)
       (go tag-start)
     tag-failure
       (setf middle -1)
       (go tag-end)
     tag-end)
    middle))



(binary-search-4 4 #(1 2 3 4 5 6 7))

(defvar test-arr #(0 3 7 11 14 17 19 21 26 30 32 35 36 41 45 48 53 55 60 64))
(iter (for k in-vector test-arr)
      (prove:is (binary-search-4 k test-arr) (position k test-arr)))

(prove:is (binary-search-4 1 #(0 2 3)) -1)
(prove:is (binary-search-4 1 #(0 2 3 4)) -1)
(prove:is (binary-search-4 -1 #(0 2 3 4)) -1)
(prove:is (binary-search-4 9 #(0 2 3 4)) -1)

