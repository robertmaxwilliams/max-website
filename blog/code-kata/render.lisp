(ql:quickload :cl-gd)
(use-package :cl-gd)

(ql:quickload :iterate)
(use-package :iterate)


(with-image* (200 200) ; create 200x200 pixel image
  (let ((black (allocate-color 0 0 0))
	(white (allocate-color 255 255 255)))
    (with-default-color (white)
      (set-pixel 1 1))))
    


(ql:quickload :zpng)
(use-package :zpng)
(defun f (x)
  (funcall #'f x))

(defun draw-rgb (png)
      (loop for a from 38 to 255 by 31
	do (loop for b from 10 to 255 by 10
	     do (loop for g from 38 to 255 by 31
		  do (loop for r from 10 to 255 by 10
			do (write-pixel (list r g b a) (f png))))))
      (finish-png (f png)))

(defun draw-line (file)

(draw-rgb "foo.png")


(draw-rgb (make-png "foo.png"))

(defstruct (point (:conc-name p-)) x y)
(defvar foo (make-point))
(setf (p-x foo) 4)

(defmacro with-png ((file) &rest forms)
  `(let ((png (make-instance 'pixel-streamed-png
                             :color-type :truecolor-alpha
                             :width 200
                             :height 200)))
    (with-open-file (stream ,file
			    :direction :output
			    :if-exists :supersede
			    :if-does-not-exist :create
			    :element-type '(unsigned-byte 8))
      (start-png png stream)
      ,@forms
      (finish-png png))))

(+ 38.02 39.95)
(+ 61.98 60.05)
(/ (+ 38.02 61.98) 2)
(/ (+ 39.96 60.05) 2)

(defmacro with-image ((file as name) &rest forms)
  (declare (ignore as))
  `(let* ((png (make-instance 'png
			     :color-type :truecolor-alpha
			     :width 200
			     :height 200))
	 (,name (data-array png)))
    ,@forms
    (write-png png ,file)))
  
(defun rect (image x y w h)
  (iter (for xx from x to (+ x w))
	(iter (for yy from y to (+ y h))
	      (wp image x y 1 1 1))))
(defun wp (image x y r g b &optional (a 1))
  (iter (for thing in (list r g b a))
	(for i from 0)
	(setf (aref image y x i) (round (mod (* 255 thing) 255)))))

(with-image ("dot.png" as image)
  (setf (aref image 0 0 0) 255)
  (setf (aref image 0 0 3) 255))
  ;;(rect image 2 2 100 100)
  ;;(iter (for x from 0 to 10)
  ;;	(for y from 10 to 20)
  ;;	(wp image x y 0.5 0.5 0.5)))
  ;;(wp image 1 1 0.5 0.5 0.5))


		      (setf (aref image y x 1) iteration)
	    (defun draw-line (point-a point-b)
	      (iter (for x from (p-x point-1) to (p-x point-2))
		    (iter (for y from (p-y point-1) to (p-y point-2))
			  (write-pixel (list 
  
			    (

(with-png ("bar.png")
      (loop for a from 38 to 255 by 31
	do (loop for b from 10 to 255 by 10
	     do (loop for g from 38 to 255 by 31
		  do (loop for r from 10 to 255 by 10
			do (write-pixel (list r g b a) png))))))

;;; evil! Evil!
;;(ql:quickload :cepl)
;;(ql:quickload :cepl.sdl2)
;;(ql:quickload :quickproject)
;;(cepl:make-project "my-proj")
;;(ql:quickload "my-proj")
;;(in-package :my-proj)
;;(cepl:repl)
