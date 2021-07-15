(in-package :max-website)

(flet ((next-pascal (ls)
                    (loop for a in (reverse (cons 0 ls))
                          for b in (cons 0 ls)
                          collect (+ a b))))
  (defun n-iterations-pascal-triangle (n)
    (reverse
      (do ((i 0 (1+ i))
           (ls '(1) (next-pascal ls))
           (accumulate nil (cons ls accumulate)))
        ((> i n) accumulate)))))

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
