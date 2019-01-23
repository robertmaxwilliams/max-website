(in-package :max-website)

(defun next-pascal (ls)
  (loop for a in (reverse (cons 0 ls))
     for b in (cons 0 ls)
       collect (+ a b)))

(defun repeat (f args n)
  (if (= 1 n)
      (funcall f args)
      (funcall f (repeat f args (- n 1)))))

;;(repeat #'next-pascal '(1) 3)

(defun n-iterations-pascal-triangle (n)
  (reverse
   (do ((i 0 (1+ i))
	(ls '(1) (next-pascal ls))
	(accumulate nil (cons ls accumulate)))
       ((> i n) accumulate))))


(defun array-pascal (size)
  (let* ((n-rows (1- (* 2 size)))
	 (n-cols (+ 1 size))
	 (middle-row-i (1- size))
	 (output-array (make-array (list n-rows n-cols) :initial-element 0)))
    (setf (aref output-array middle-row-i 1) 1)
    (loop for i downfrom (1- middle-row-i) to 0
	   do (loop for j from 1 below n-cols
		 do (setf (aref output-array i j)
			  (-
			   (aref output-array (1+ i) j)
			   (aref output-array i (1- j))))))
    (loop for i from (1+ middle-row-i) below n-rows
	   do (loop for j from 1 below n-cols
		 do (setf (aref output-array i j)
			  (+
			   (aref output-array (1- i) j)
			   (aref output-array (1- i) (1- j))))))
    output-array))

;;(array-pascal 5)


;; TODO extended eucledian algorythm

;; putting this code here even though it belongs in its own file.
;; TODO refactor math stuff some how

(defun printb (n)
  "Print in binray"
   (format t "~B" n))

(defun bstring (n)
  "return as string in binray"
  (write-to-string n :base 2))
  
(defun next-collatz (n)
  (if (evenp n)
      (/ n 2)
      (+ 1 (* 3 n))))


(defun oddiate (n)
  "divide n by two until odd"
  (if (oddp n)
      n
      (oddiate (/ n 2))))

(defun shortcut-collatz (n)
  "divides by 2 until odd, then return 3n+1"
  (oddiate (+ 1 (* 3 (oddiate n)))))
(shortcut-collatz 64)


(defun inverse-collatz (n)
  "returns a list with one or two values that collatz to n"
  (cons (* 2 n)
	(let ((other-result (/ (- n 1) 3)))
	  (if (and (integerp other-result) (not (zerop other-result)))
	      (list other-result)
	      nil))))

(defparameter *foo* 0)
(defun foo-counter ()
  (setf *foo* (1+ *foo*))
  (if (zerop (mod *foo* 10000)) t))
(foo-counter)

(defun find-double (n)
  (let ((next-colls (inverse-collatz n)))
    (if (> (length next-colls) 1)
	(format t "FOUND IT!!!! ~a" next-colls)
	(progn
	  (if (foo-counter) (format t "Found only one, with ~a digits.~%" (log (car next-colls) 10)))
	  (find-double (car next-colls))))))
;;(find-double 42)
;;(inverse-collatz 42)
;;(next-collatz 0)
;;
;;(cadr '(4 (8 16)))
;;(cadr '(4 8))

(defun value-to-split (n)
  (cons n (inverse-collatz n)))
;;(value-to-split 16)
;;'(16 32 5)
(defun values-to-splits (ns)
  (loop for n in ns
     collect (value-to-split n)))
(values-to-splits '(32 5))

(defun grow-tree (tree)
  (cond ((null tree) nil)
	((atom (cadr tree))
	 (cons (car tree)
	       (values-to-splits (cdr tree))))
	(t (cons (car tree) (loop for rast in (cdr tree)
				 collect (grow-tree rast))))))

;;(grow-tree '(4 (8 16)))
;;(grow-tree (grow-tree '(4 (8 16))))
;;(grow-tree (grow-tree (grow-tree '(4 (8 16)))))
(defun n-times (fun n x)
  " calls fun n times on x"
  (if (zerop n)
      x
      (funcall fun (n-times fun (1- n) x))))
;;(n-times #'1+ 4 4)
;;(pprint (n-times #'grow-tree 8 '(4 8)))
;;(grow-tree '(4 (8 16)))
;;(cadr '(4 (8 16)))
      
;;(bstring 5)
;;(list 'foo (lambda (x) 5))

(defun inverse-collatz-grower-maker (starting-list)
  (list
   (cons 'get-starting-list
	 #'(lambda ()
	     starting-list))
   (cons 'set-starting-list
	 #'(lambda (new-val)
	     (setf starting-list new-val)))
   (cons 'expand-n
	 #'(lambda (n)
	     (if (member n starting-list)
		 (setf starting-list
		       (remove-duplicates (append (inverse-collatz n) starting-list))))))))


(defun dot (alist key &rest args)
  (apply (cdr (assoc key alist)) args))

;; minimal example of structure it works on
;;(dot (list (cons 'foo #'(lambda (x y) (+ x y)))) 'foo 4 2)
;; >> 6

;;(defvar foo1 (inverse-collatz-grower-maker '(1)))
;; >> foo1

;;(dot foo1 'get-starting-list)
;;;; >> (1)
;;(dot foo1 'set-starting-list '(1 2 3))
;;;; >> (1 2 3)
;;(dot foo1 'expand-n 1)
;;;; >> (0 1 2 3) ;; 0 should be redacted ;(
;;(dot foo1 'expand-n 2)
;;;; >> (4 0 1 2 3)
;;(dot foo1 'expand-n 3)
;;;; >> (6 4 0 1 2 3)
;;(dot foo1 'expand-n 4)
;;;; >> (8 6 4 0 1 2 3)



(defun inverse-grow-collatz (ls n)
  (if (member n ls)
      (remove-duplicates (append ls (inverse-collatz n)))
      ls))

;;(inverse-grow-collatz '(1) 1)

(defun grow-collatz-graph-edges (nodes-edges n)
  "adds links from inverses of n to n."
  (db (nodes edges) nodes-edges
    (if (member n nodes)
	(let* ((new-nodes
		(inverse-collatz n))
	       (new-edges
		(loop for new-node in new-nodes
		   collect (list new-node n))))
	  (print (append new-nodes nodes))
	  (list ;; this is the returned nodes-edges
	   (remove-duplicates
	    (append new-nodes nodes))
	   (remove-duplicates
	    (append new-edges edges)
	    :key #'car)))
	nodes-edges)))
  

;;(let ((nodes-edges '((1 2 4 8 16 5 32)
;;		     ((2 1) (1 4) (4 2) (8 4) (16 8) (5 16) (32 16)))))
;;  (grow-collatz-graph-edges nodes-edges 32))
