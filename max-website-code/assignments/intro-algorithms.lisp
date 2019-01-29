
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
	 (cons (car a) (sort-merge (cdr a) b comparison)))
	((funcall comparison (car b) (car a))
	 (cons (car b) (sort-merge (cdr b) a comparison)))
	(t ;; if both eqp's are false, arbitrarily choose one
	 (cons (car b) (sort-merge (cdr b) a comparison)))))

(let ((a '(6 4 2)) (b '(9 3 1)))
  (is (sort-merge a b #'>) (sort (copy-sequence 'list (append a b)) #'>)))
(let ((a '(6 4 2 1 -2 -10)) (b '(9 3 1)))
  (is (sort-merge a b #'>) (sort (copy-sequence 'list (append a b)) #'>)))
(let ((a '(6)) (b '(9 3 1)))
  (is (sort-merge a b #'>) (sort (copy-sequence 'list (append a b)) #'>)))

;;(untrace sort-merge)
(sort-merge '(6 4 2 1) '(9 3 1) #'<)
(is (sort-merge '(6 4 2) '(9 3 1)) '(9 6 4 3 2 1))
(is (sort-merge '(5) '(2 7) #'<) '(2 5 7))

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

;;notused(defstruct (vector-slice (:conc-name vs)) vector start end)
    
(defun list-merge-sort (seq &optional (comparison #'>))
  ;; wastes lots of time checking length, could pass length in as optional
  ;; parameter at cost of elegence
  (cond ((null seq)
	 nil)
	((singleton-p seq)
	 seq)
	(t (destructuring-bind (first-half second-half) (split-list seq)
	     (sort-merge (list-merge-sort first-half comparison)
			 (list-merge-sort second-half comparison)
			 comparison)))))

(is (list-merge-sort '(5 2 7 3 7 2) #'<) '(2 2 3 5 7 7))

(let ((foo (vector 1 2 3 4 5)))
  (setf (aref (subseq foo 2 4) 0) 9)
  (setf (aref foo 0) 9)
  foo)

(defun list-pivot (ls value comparison)
  "greater-than puts larger items in left-list"
  (iter (for item in ls)
	(if (funcall comparison item value)
	    (collect item into left-list at beginning)
	    (collect item into right-list at beginning))
	(finally (return (list left-list right-list)))))


(list-pivot '(1 0 0 6 3 6 3 9 9 9) 6 #'>=)
(list-pivot '(1 0 0 6 3 6 3 9 9 9) 6 #'>)
(list-pivot '(1 9) 5 #'>=)
(list-pivot '(9) 5 #'>=)
(list-pivot '(1) 5 #'>=)
(list-pivot '() 5 #'>=)

(list-pivot '(1 9) 1 #'>=)
(list-pivot '(9 1) 1 #'>=)
(list-pivot '(1 9) 9 #'>=)
(list-pivot '(9 1) 9 #'>=)

(defun car-or-cadr (ls)
  (if (= 0 (random 2))
      (car ls)
      (cadr ls)))

(defun sorted-p (ls comparison)
  " be sure to use >= <= if repeated elements!"
  (iter (for item in ls)
	(for prev previous item)
	(if-first-time
	 nil
	 (always (funcall comparison prev item)))))

(sorted-p '(1 2 3 4) #'>=)
(sorted-p '(1 2 3 4) #'<=)

(defun list-quick-sort (ls &optional (comparison #'>))
  (cond ((null ls)
	 nil)
	((sorted-p ls comparison) ls)
	((singleton-p ls) ls)
	(t (destructuring-bind (left-list right-list)
	       (list-pivot ls (car-or-cadr (identity ls)) comparison)
	     (append (list-quick-sort left-list comparison)
		     (list-quick-sort right-list comparison))))))

(last '(122 34 4))

(list-quick-sort '(2 1 2 6 3 7 3) #'>=)
(list-quick-sort (iter (repeat 90) (collect (random 100))) #'<=)
(iter (repeat 10) (collect (random 10)))

(list-pivot '(2 2 6 3 7 3) 3 #'>=)
(list-pivot '(6 7) 7 #'>=)

;;
;;int partition( void *a, int low, int high )
;;  {
;;  int left, right;
;;  void *pivot_item;
;;  pivot_item = a[low];
;;  pivot = left = low;
;;  right = high;
;;  while ( left < right ) {
;;    /* Move left while item < pivot */
;;    while( a[left] <= pivot_item ) left++;
;;    /* Move right while item > pivot */
;;    while( a[right] > pivot_item ) right--;
;;    if ( left < right ) SWAP(a,left,right);
;;    }
;;  /* right is final position for the pivot */
;;  a[low] = a[right];
;;  a[right] = pivot_item;
;;  return right;
;;  }
;;



(defmacro while-loop (condition &body body)
  (let ((start-tag (gensym))
	(end-tag (gensym)))
  `(tagbody
      (go ,end-tag)
      ,start-tag
      (progn ,@body) ;;progn for safety
      ,end-tag
      (if ,condition (go ,start-tag)))))

(print (macroexpand-1 '(while-loop (< x 5)
		 (print x)
		 (incf x))))

(let ((x 0))
  (while-loop (< x 5)
    (print x)
    (incf x)))

(defmacro swap (place-a place-b)
  (let ((temp (gensym)))
    `(let ((,temp ,place-a))
       (setf ,place-a ,place-b)
       (setf ,place-b ,temp))))

(defun array-pivot-tagbody (arr comparison &optional
					     (low 0)
					     (high (1- (length arr))))
  " low level pivot algorithm just for fun "
  ;;(if (null high) (setf high (length arr)))
  (declare (fixnum low high))
  (let ((left low)
	(pivot low)
	(right high)
	(pivot-item (aref arr low)))
    (declare (fixnum left pivot right))
    (tagbody
       (go outer-while-end)
     outer-while-start

       (go while1-end)
     while1-start
       (incf left)
     while1-end
       (if (funcall comparison (aref arr left) pivot-item)
	   (go while1-start))

       (go while2-end)
     while2-start
       (decf right)
     while2-end
       (if (funcall comparison pivot-item (aref arr right))
	   (go while2-start))

       (if (< left right) (swap (aref arr left) (aref arr right)))

     outer-while-end
       (if (> left right) (go outer-while-start)))
    
    (setf (aref arr low) (aref arr right))
    (setf (aref arr right) pivot-item)
    (list arr right)))

(array-pivot-tagbody (vector 4 1 6 4 7 3 2) #'>)
       
     
(defmacro progn-protect (&body stuff)
  (flet ((protected-form-p (form) (and (listp form) (eql (car form) :protected))))
    (let ((protected-clauses
	   (mapcar #'cadr (remove-if-not #'protected-form-p stuff)))
	  (normal-clauses
	   (remove-if #'protected-form-p stuff)))
      `(unwind-protect (progn ,@normal-clauses)
	 (progn ,@protected-clauses)))))

(flet ((protected-form-p (form) (and (listp form) (eql (car form) :protected))))
  (defmacro progn-protect (&body stuff)

(macroexpand-1 '(progn-protect
		 (:protected (print 5))
		 (+ 2 2)))
  

(defun bar ()
  (block a
    (foo (lambda () (return-from a)))))

(defun foo (fun)
  (progn-protect
    (print "foo-ing")
    (:protected (print "this gets run when foo leaves"))
    (print "more foo-ing")
    (funcall fun)
    (:protected (print "so does this!"))
    (print "this does not")))
		
    
(bar)
