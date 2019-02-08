
;; inefficient but numerically safe
(defun fact (n)
  (if (<= n 1)
      1
      (* n (fact (1- n)))))

;; inefficient but numerically safe
(defun choose (n k)
  (assert (>= n k))
  (assert (>= n 0))
  (assert (>= k 0))
  (cond ((= k 0) 1)
	((= n k) 1)
	(t (+ (choose (1- n) (1- k))
	      (choose (1- n) k)))))

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
