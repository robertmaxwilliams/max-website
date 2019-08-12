(ql:quickload :opticl)
(ql:quickload :iterate)

(defpackage max-website
  (:use :cl :iter :opticl))

(in-package max-website)


(let ((img (make-8-bit-rgb-image 32 32)))
   (locally (declare (type 8-bit-rgb-image img))
     (with-image-bounds (height width)
	 img
       (time
	(iter (for i from 0 below height)
	   (iter (for j from 0 below width)
		 (multiple-value-bind (r g b)
		     (pixel img i j)
		   (declare (type (unsigned-byte 8) r g b))
		   (setf (pixel img i j)
			 (values (random 255) (random 255) (random 255)))))))))
  (write-jpeg-file "foo.jpeg" img))
