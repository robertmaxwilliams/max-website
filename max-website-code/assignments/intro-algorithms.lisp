
;; CECS 419
;; This class doesn't have a lot of programming
;; but I will probably put code in here anyway
(ql:quickload :iterate)
(ql:quickload :alexandria)
(ql:quickload :prove)
(defpackage cecs-419
  (:use :cl :iterate :prove :alexandria))

(in-package cecs-419)

(let ((foo (list 1 2 3)))
  (setf (cdr foo) (cons 9 (cdr foo)))
  foo)

(defun insertion-sort (seq &optional out)
  (if (null seq)
      out
      (progn 
	(loop for rest on out
	   when (> (car rest) (car seq))
	   return (setf rest (cons (car seq) rest))
	     finally (setf rest (cons (car seq) nil)))
	(insertion-sort (cdr seq) out))))

(ok (insertion-sort '(1 5 2 6 2)))


(iter
  (with x = 0)
  (if (= 0 (random 8)) (leave x))
  (incf x))

(iter (for x in-vector #(9 8 6 5))
	 (collect x))
(iter (for i below 6 by 2)
      (collect i))


(defmacro swap (place-a place-b)
  (let ((temp (gensym)))
    `(let ((,temp ,place-a))
       (setf ,place-a ,place-b)
       (setf ,place-b ,temp))))
  
;;(defun array-insertion-sort (seq &optional (comparison #'>))
;;  " insertion sort for arrays, n^2 time "
;;  (let ((out-array (make-array (list (length seq)))))
;;    (iter (for ii from 0 below (length seq)) ;; iter over origin list
;;	  (let ((x (aref seq ii)))
;;	    (iter (for jj from 0 below (length seq))
;;		  (if (or (null (aref out-array jj))
;;			  (funcall comparison
;;				   (aref out-array jj)
;;				   (aref seq ii)
;;				   

(defun array-insertion-sort (seq &optional (comparison #'>))
  " insertion sort for arrays, n^2 time "
  ;; why is this so complicated? Am I bad at this?
  (let ((out-array (make-array (list (length seq)))))
    (iter (for x in-vector seq)
	  (let ((place (iter (for y in-vector out-array)
			  (for i upfrom 0)
			  (if (or (null y) (funcall comparison x y))
			      (leave i)))))
	    (iter (for i from (1- (length seq)) downto (1+ place))
		  (for y = (aref out-array i))
		  (setf (aref out-array i) (aref out-array (1- i))))
	    (setf (aref out-array place) x)))
    out-array))


(is (array-insertion-sort #(5 2 7 2 39 21 4 3) #'>)
    (sort #(5 2 7 2 39 21 4 3) #'>)
    :test #'equalp)

(cddr '(2 3))

(defun list-swappy-sort (seq &optional (comparison #'>))
  (iter (for i from 1 to 6)
    (until
     (iter (for rest on seq)
	   (with did-nothing = t)
	   (until (null (cdr rest)))
	   (if (funcall comparison (cadr rest) (car rest))
	       (progn (setf did-nothing nil)
		      ;;(format t "~a ~a ~%" (car seq) (cadr seq))
		      (swap (car rest) (cadr rest))))
	   (finally (return did-nothing)))))
  seq)

(is (list-swappy-sort (list 5 2 7 2 39 21 4 3) #'>)
    (sort (list 5 2 7 2 39 21 4 3) #'>)
    :test #'equalp)

(is (list-swappy-sort (list 5 2 7 2 39 21 4 3) #'<)
    (sort (list 5 2 7 2 39 21 4 3) #'<)
    :test #'equalp)

(print (macroexpand
 '(iter (for rest on bar)
	 (setf rest (cons 9 rest)))))

(let ((bar '(1 2 3))
      (buk '(nil)))
   (iter (for rest on (copy-sequence 'list bar))
	 (print rest)
	 (setf (cdr buk) (cons 9 rest)))
   (list bar buk))

(macroexpand
 '(let ((bar '(1 2 3)))
   (iter (for rest on (copy-sequence bar))
	 (setf rest (cons 9 rest)))
   bar))

(defun list-insertion-sort (seq &optional (comparison #'>) (out-seq nil))
  (iter (for el in seq)
	(if (null out-seq)
	    (setf out-seq (cons el out-seq))
	    (iter (for rest on out-seq)
		  (for p-rest previous rest initially out-seq)
		  (print rest)
		  (if (funcall comparison el (car rest))
		      (progn
			(format t "Inserting ~a onto ~a" el p-rest)
			(setf p-rest (cons el p-rest))
			(finish)))
		  (if (null (cdr rest))
		      (progn
			(print "noppe")
			(setf out-seq (cons el out-seq)))))))
  out-seq)

(list-insertion-sort (list 5 2 7 2 39 21 4 3) #'<)
(print "")

(defun same-truthy (a b)
  (or (and a b) (and (not a) (not b))))
(defun same-truthy (a b)
  (or (and a b) (and (null a) (null b))))
(same-truthy t t)
(same-truthy t 'foo)
(same-truthy nil 'foo)
(same-truthy nil nil)


(defun singleton-p (ls)
  (and (not (null ls))
       (null (cdr ls))))

(is (singleton-p '(2)) t :test #'same-truthy)
(is (singleton-p '(4 2)) nil :test #'same-truthy)
(is (singleton-p '()) nil :test #'same-truthy)

(defun sort-merge (a b &optional (comparison #'>))
  "merges two sorted lists"
  (cond ((null a) b)
	((null b) a)
	((funcall comparison (car a) (car b))
	 (cons (car a) (sort-merge (cdr a) b)))
	((funcall comparison (car b) (car a))
	 (cons (car b) (sort-merge (cdr b) a)))
	(t ;; if both eqp's are false, arbitrarily choose one
	 (cons (car b) (sort-merge (cdr b) a)))))

(let ((a '(6 4 2)) (b '(9 3 1)))
  (is (sort-merge a b #'>) (sort (copy-sequence 'list (append a b)) #'>)))
(let ((a '(6 4 2 1 -2 -10)) (b '(9 3 1)))
  (is (sort-merge a b #'>) (sort (copy-sequence 'list (append a b)) #'>)))
(let ((a '(6)) (b '(9 3 1)))
  (is (sort-merge a b #'>) (sort (copy-sequence 'list (append a b)) #'>)))

;;(untrace sort-merge)
(sort-merge '(6 4 2 1) '(9 3 1) #'>)
(is (sort-merge '(6 4 2) '(9 3 1)) '(9 6 4 3 2 1))

(defun split-list (ls)
  " First half is one longer than rest for odd length lists"
  (let ((half-len (floor (length ls) 2)))
    (iter (for rest on ls)
	  (for i upfrom 0)
	  (if (>= i half-len) (return (list first-half rest)))
	  (collect (car rest) into first-half))))

(split-list '(1 2 3 4 5 6))
(split-list '(1 2 3 4 5))
(split-list '(1 2))
(split-list '(1))
(split-list '())
    

(defun list-merge-sort (seq)
  ;; wastes lots of time checking length, could pass length in as optional
  ;; parameter at cost of elegence
  (cond ((null seq)
	 nil)
	(t (merge (
