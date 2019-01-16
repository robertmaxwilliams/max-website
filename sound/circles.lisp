
(ql:quickload :vecto)
(ql:quickload :cl-svg)


(defpackage :drawing-fun
  (:use :cl :vecto :cl-svg))
(in-package :drawing-fun)


(let* ((scene (make-svg-toplevel 'svg-1.1-toplevel :height 40 :width 250)))
  (draw scene (:rect :x 0 :y 0 :height 40 :width 250) :fill "#CCCCCC")
  (text scene (:x 25 :y 25)
    "Mouse over a "
    (tspan (:fill "orange" :font-weight "bold") "circle"))
  (draw scene (:circle :cx 200 :cy 20 :r 10) :fill "blue")
  (with-open-file (s #p"test.svg" :direction :output :if-exists :supersede)
    (stream-out s scene)))


(defun adj-pairs (ls)
  (loop for rest on ls
     until (null (cdr rest))
     collect (list (car rest) (cadr rest))))

(defun rekmon (upper-limit &optional (n 0) (i 1) (visited (make-hash-table)))
  (if (> n upper-limit)
  ;;(if (every #'identity (loop for ii from 0 to upper-limit
	;;		   collect (gethash ii visited)))
			     
      nil
      (let ((new-n
	     (if (and (<= 0 (- n i)) ;; if n-i is positive and n not in visited
		      (null (gethash (- n i) visited)))
		 (- n i)
		 (+ n i))))
	(setf (gethash n visited) t)
	(if (gethash
	(setf (gethash new-n visited) t)
	(cons n (rekmon upper-limit new-n (1+ i) visited)))))

(rekmon 4)
(defun max-list (list)
  (apply #'max list))
(defun max-diff (list)
  (max-list (mapcar
	     (lambda (a b) (abs (- a b)))
	     list (cons (car list) list))))

(defparameter +s+ 10)
(progn 
  (defun plot-circle-path (path &optional max-x)
    (if (null max-x) (setf max-x (max-list path)))
    (let* (;;(max-x (max-list path))
	   (max-y (max-diff path))
	   (width (* +s+ (+ max-x 10)))
	   (height (* +s+ (+ 10 max-y))))
      (with-canvas (:width width :height height)
	(set-rgb-fill 1 1 1)
	(set-rgba-stroke 1 1 1 1)
	(rectangle 0 0 width height)
	(fill-and-stroke)
	(translate 5 (/ height 2))
	(set-rgba-stroke 0 0 0 0.9)
	(set-line-width 3)
	(labels ((half-circle (x y radius)
		   ;;(move-to (* +s+ (+ x radius)) (* +s+ y))
		   (arc (* +s+ x) (* +s+ y) (* +s+ radius) 0 (/ pi 1)))
		 (half-circle-span (y x1 x2)
		   (set-rgba-fill 0 0 0 0.01)
		   (if (< 0 (- x1 x2))
		       (set-rgba-stroke 0.3 0.3 0.3 0.9)
		       (set-rgba-stroke 0.1 0.1 0.1 0.9))
		   (let ((middle (/ (+ x1 x2) 2))
			 (radius (/ (- x2 x1) 2)))
		     (half-circle middle y radius)
		     (fill-and-stroke))))
	  (loop for a-b in (adj-pairs path)
	     do (half-circle-span 0 (car a-b) (cadr a-b))))
	(save-png "oops.png"))))
  (plot-circle-path (rekmon 500))
  (print "done!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"))

  
