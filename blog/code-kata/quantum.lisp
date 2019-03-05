
  
;; a q-bit is a 2-vector with real numbers (later, imaginary)
;; such that q[0]^2 + q[1]^2 = 1
(ql:quickload :iterate)
(use-package :iterate)

(defun square-sum (vec)
  (iter (for x in-vector vec)
	(sum (expt x 2))))

(square-sum #(0.5 0.5 0.2))

(defun [] (array &rest things)
  (apply #'aref array things))

(defun multi (arr vec)
  (let ((n-rows (array-dimension arr 0))
	(n-cols (array-dimension arr 1)))
    (assert (= n-rows n-cols (length vec)))
    (iter (for i from 0 below n-rows)
	  (collect
	      (iter (for j from 0 below n-cols)
		    (sum (* ([] arr i j) ([] vec j))))))))

(defun print-2d (arr)
  (let ((n-rows (array-dimension arr 0))
	(n-cols (array-dimension arr 1)))
    (iter (for i from 0 below n-rows)
	  (iter (for j from 0 below n-cols)
		(format t "~a " ([] arr i j)))
	  (format t "~%"))))

(defun tensor-product-2 (a b)
  (iter (for x in-vector a)
	(appending
	 (iter (for y in-vector b)
	       (collect (* x y))))))

(defun ff (n)
  (cond
    ((= 0 n)
     #(1 0))
    ((= 1 n)
     #(0 1))))
(ff 1)
(tensor-product-2 (ff 0) (ff 0))
(tensor-product-2 (ff 0) (ff 1))
(tensor-product-2 (ff 1) (ff 0))
(tensor-product-2 (ff 1) (ff 1))

(describe #'array-dimensions)
		    
(make-array '(2 2) :initial-contents '((0 1) (1 0)))

(print-2d #2a((1 0) (0 1)))
(defvar identity-2 #2a((1 0) (0 1)))
(defvar always-zero #2a((1 1) (0 0)))
(defvar always-one #2a((0 0) (1 1)))
(defvar negate #2a((0 1) (1 0)))
(defvar cond-negate
  #2a((1 0 0 0)
      (0 1 0 0)
      (0 0 0 1)
      (0 0 1 0)))
(multi #2a((1 #(1 1))
