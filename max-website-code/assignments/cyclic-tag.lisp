
;; exploring with cyclic tag system as a computational substrate,
;; and find artificial life that lives within them

(mapcar #'ql:quickload '(:iterate :str :alexandria))
(defpackage tags
  (:use :cl :iter :alexandria))
(in-package :tags)

(defun p (&rest stuff)
  (cond
    ((null stuff)
     (format t "~%"))
    (t (progn
	 (format t "~a" (car stuff))
	 (format t " ")
	 (apply #'p (cdr stuff))))))))


(tag-system
 '((a b c)
   (b b)
   (c 'halt))
 '(a a a))
  
(defun g (n)
  (declare (fixnum n))
  (let ((s 0))
    (declare (fixnum s))
    (iter (for i from 1 to n)
	  (incf s i))
    (the fixnum s)))

(time (g (expt 10 6)))
;;Evaluation took:
;;  0.011 seconds of real time
;;  0.010883 seconds of total run time (0.010799 user, 0.000084 system)
;;  100.00% CPU
;;  21,537,601 processor cycles
;;  0 bytes consed
    
(time (g (expt 10 9)))
;; Evaluation took:
;;   6.628 seconds of real time
;;   6.628226 seconds of total run time (6.618736 user, 0.009490 system)
;;   100.00% CPU
;;   13,253,792,833 processor cycles
;;   0 bytes consed
  

(defun tag-system (inference-rules starting-list)
  (printl 
  (let* ((result (cdr (assoc (car starting-list) inference-rules))))
