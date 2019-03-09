
;; inefficient but numerically safe
(defun fact (n)
  (if (<= n 1)
      1
      (* n (fact (1- n)))))


(* 8 (exp -0.02))
;; inefficient but numerically safe
(defun choose (n k)
  (assert (>= n k))
  (assert (>= n 0))
  (assert (>= k 0))
  (cond ((= k 0) 1)
	((= n k) 1)
	(t (+ (choose (1- n) (1- k))
	      (choose (1- n) k)))))

(let* ((n-containers 500)
       (n-defective 5)

(defun pascal-row (x)
  (mapcar (lambda (n) (choose x n)) (loop for x from 0 to x collect x)))
	

(defun poisson (x lam tt)
  (/ (* (exp (- (* lam tt)))
	(expt (* lam tt) x))
     (fact x)))
(+
 (poisson 2 0.25 5)
 (poisson 1 0.25 5)
 (poisson 0 0.25 5))

(ql:quickload :iterate)
(use-package :iterate)

(defun square (x)
  (* x x))
(defun s-2 (samples)
  (let* ((sum-squares
	  (iter (for x in samples)
		(sum (square x))))
	 (square-sum
	  (square 
	  (iter (for x in samples)
		(sum x))))
	 (n (length samples)))
    (format t "~a~%" sum-squares)
    (format t "~a~%" (/ square-sum n))
    (/ (- sum-squares (/
		       square-sum
		       (length samples)))
       (1- n))))

(defun mean (samples)
  (/ (reduce #'+ samples)
     (length samples)))

(print (sqrt (s-2 '(5.0 4.5 6.0 7.0 5.8 3.7 6.5 7.8))))
(print (s-2 '(5.0 4.5 6.0 7.0 5.8 3.7 6.5 7.8)))

(print (mean '(5.0 4.5 6.0 7.0 5.8 3.7 6.5 7.8)))
(print (length '(5.0 4.5 6.0 7.0 5.8 3.7 6.5 7.8)))

76.52

(print (/ (* 1.895 1.3474193) (sqrt 8)))
(print (+ 5.7875 0.90274894))
(print (- 5.7875 0.90274894))








(defun rand-p ()
  (zerop (random 2)))

;; random walk
(defun random-walk ()
  (let ((x 1))
    (iter (for i from 0)
	  (if (zerop x)
	      (return i))
	  (setf x (if (rand-p) (1+ x) (1- x))))))

(iter (repeat 100)
      (maximizing (random-walk)))

(defun damnit (x)
  (1- (* -2 (log (- 1 (* 3/2 x)) 4))))

(damnit (random 1.0))

(damnit (random 1.0))

(iter (repeat 10000)
      (maximizing (- (log (random 1.0) 2))))

(logarithm 

(defun rand-p ()
  (zerop (random 2)))

;; random walk
(defun random-walk ()
  (let ((x 1))
    (iter (for i from 0)
	  (if (zerop x)
	      (return i))
	  (setf x (if (rand-p) (1+ x) (1- x))))))

(iter (repeat 100)
      (maximizing (random-walk)))

(defun damnit (x)
  (1- (* -2 (log (- 1 (* 3/2 x)) 4))))

(damnit (random 1.0))

(damnit (random 1.0))

(iter (repeat 10000)
      (maximizing (- (log (random 1.0) 2))))

(logarithm 
(defun rand-p ()
  (zerop (random 2)))

;; random walk
(defun random-walk ()
  (let ((x 1))
    (iter (for i from 0)
	  (if (zerop x)
	      (return i))
	  (setf x (if (rand-p) (1+ x) (1- x))))))

(iter (repeat 100)
      (maximizing (random-walk)))

(defun damnit (x)
  (1- (* -2 (log (- 1 (* 3/2 x)) 4))))

(damnit (random 1.0))

(damnit (random 1.0))

(iter (repeat 10000)
      (maximizing (- (log (random 1.0) 2))))

(logarithm 

(defun rand-p ()
  (zerop (random 2)))

;; random walk
(defun random-walk ()
  (let ((x 1))
    (iter (for i from 0)
	  (if (zerop x)
	      (return i))
	  (setf x (if (rand-p) (1+ x) (1- x))))))

(iter (repeat 100)
      (maximizing (random-walk)))

(defun damnit (x)
  (1- (* -2 (log (- 1 (* 3/2 x)) 4))))

(damnit (random 1.0))

(damnit (random 1.0))

(iter (repeat 10000)
      (maximizing (- (log (random 1.0) 2))))

(logarithm 

(defun rand-p ()
  (zerop (random 2)))

;; random walk
(defun random-walk ()
  (let ((x 1))
    (iter (for i from 0)
	  (if (zerop x)
	      (return i))
	  (setf x (if (rand-p) (1+ x) (1- x))))))

(iter (repeat 100)
      (maximizing (random-walk)))

(defun damnit (x)
  (1- (* -2 (log (- 1 (* 3/2 x)) 4))))

(damnit (random 1.0))

(damnit (random 1.0))

(iter (repeat 10000)
      (maximizing (- (log (random 1.0) 2))))




(defun rando (x)
  (if (zerop (random (+ 2 x)))
      x
      (rando (1+ x))))
(rando 1)

(iter (for i from 1 to 1000)
	   (sum (rando 0)))



