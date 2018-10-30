(in-package :max-website)

(defun next-pascal (ls)
  (loop for a in (reverse (cons 0 ls))
     for b in (cons 0 ls)
       collect (+ a b)))

(defun repeat (f args n)
  (if (= 1 n)
      (funcall f args)
      (funcall f (repeat f args (- n 1)))))

(repeat #'next-pascal '(1) 3)

(defun n-iterations-pascal-triangle (n)
  (reverse
   (do ((i 0 (1+ i))
	(ls '(1) (next-pascal ls))
	(accumulate nil (cons ls accumulate)))
       ((> i n) accumulate))))

(defun 2d-table-from-list (html-stream lsls)
  (let ((array (list-to-2d-array lsls)))
    (print (array-dimension array 1))
    (with-html-output (html-stream)
      (:table :border 0 :cellpadding 4
	      (loop for i from 0 below (array-dimension array 0)
		 do (htm
		     (:tr :align "right"
			  (loop for j from 0 below (array-dimension array 1)
			     do (htm
				 (:td :bgcolor (cond ((zerop (aref array i j)) "lightblue")
						      ((oddp (aref array i j)) "pink")
						      (t "green"))
				      (str (aref array i j))))))))))))




