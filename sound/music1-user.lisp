
(load "music1.lisp")
(in-package :audio-fun)

(play-lists
  (mapcar (lambda (x) (* x 440)) (rand-frac-list))
  (mapcar (lambda (x) (* x 220)) (rand-frac-list)))


(numerator 4/2)

;; Now that I've done THAT it's time to come up with nice molodies for our music machine
;; There are a few concepts that create nice music:
;; small integer ratios between frequencies

;; Here's one idea: several instruments, each moving one step slower than the last, each a small integer fraction of
;; the one before it
;; Lets make a symphony of 4 instruments, and call them bass, tenor, alto and saprano for old times sakes.
;; Bass is the driver and moves once per second
;; Tenor's freq is n*bass-f where n is less than one and a SIF
;; and it moves three times per second
;; Alto is the same as tenor but must be a higher freq than tenor
;; Saprano is a SIF of tenor or alto (changing this every 2 seconds) and changes freq nine times a second
;; maybe I'll keep them in a list, going '(bass tenor alto saprano)
;;                                         car  cadr caddr cadddr


;; test 3 will be over 7 8 9 10 but no 10.5
 
(defun one-or-minus-one ()
  (if (zerop (random 2)) 1 -1))

(defmacro incf-bounce (place x)
  " like incf but if it would go to zero, bounce to 1"
  `(progn (incf ,place ,x)
	  (if (<= ,place 0)
	      (setf ,place 1))
	  ,place))

(defun rand-inc (ls)
  (let ((x (one-or-minus-one)))
    (if (zerop (random 2))
      (incf-bounce (car ls) x)
      (incf-bounce (cdr ls) x))
    ls))

(defun rand-inc-above-n (ls1 ls2 &optional (tries-left 10))
  " rand-inc's ls1 until it's greater than ls2 
    if it doesn't get it in 10 tries, give up"
  (cond ((zerop tries-left) (rand-inc ls2))
	((>= (fra ls1) (fra ls2)) ls1)
	(t (rand-inc-above-n
	    (rand-inc ls1)
	    ls2
	    (1- tries-left)))))

(rand-inc '(3 . 2))
(rand-inc-above-n '(3 . 2) '(9 . 5))

(defun rand-frac-list ()
  " starts at 3/3, each step num or den can increase or decrease "
  (let ((frac (cons 3 3)))
    (loop for i from 1 to 10
       do (rand-inc frac)
       collect (/ (car frac) (cdr frac)))))
;;(randfraclist)



(defun fra (ls)
  " turns '(3 . 2) into 3/2"
  (/ (car ls) (cdr ls)))

(defun properties (plist)
  (loop for foo on plist by #'cddr
       collect (car foo)))
(properties '(a b c d))

(defun symphony1-maker ()
  (let ((band (list :bass '(1 . 1) ;;root
		    :tenor '(3 . 2) ;;relative to bass
		    :alto '(5 . 3) ;;realtive to root, must be higher than tenor
		    :saprano '(2 . 1)))) ;;relative to alto
    (list
     :calculate-freqs
     (lambda ()
       (let* ((bass-f (fra (getf band :bass)))
	      (tenor-f (* (fra (getf band :tenor)) bass-f))
	      (alto-f (* (fra (getf band :alto)) bass-f))
	      (saprano-f (* (fra (getf band :saprano)) alto-f)))
	 (list bass-f tenor-f alto-f saprano-f)))
     :move
     (lambda ()
       (loop for p in (properties band)
	  do (rand-inc (getf band p))))
     :move2
     (lambda (time)
       (progn
	 (if (mero time 9)
	     (rand-inc (getf band :bass)))
	 (if (mero time 3)
	     (rand-inc


(defvar foo (symphony1-maker))

(@ foo :calculate-freqs)
(@ foo :move)


(defun pair->frac (pair)
  (/ (car pair) (cadr pair)))

(defun frac->pair (frac)
  (list (numerator frac) (denominator frac)))


;; starting over
;; not using dotted lists because I hate typing and looking at them
;; and are all relative to bass



(defun mero (x y)
  "means mod-equals-zero"
  (zerop (mod x y)))

(defun cannonize (pair)
  (let ((frac (/ (car pair) (cadr pair))))
    (list (numerator frac) (denominator frac))))
 
(defun one-or-minus-one ()
  (if (zerop (random 2)) 1 -1))

(defun nat-add (a b)
  "add but if 0 or less, return 1"
  (let ((result (+ a b)))
    (if (<= result 0)
	1
	result)))


(defun move-pair (pair &optional (direction (one-or-minus-one)))
  (let* (;;(direction (one-or-minus-one))
	 (x1 (random 2)) ;; x1=1;x2=0 or x1=0;x2=1
	 (x2 (- 1 x1))) 
    (list
     (nat-add (car pair) (* x1 direction))
     (nat-add (cadr pair) (* x2 direction)))))

(defun increase-pair (pair)
    "either move numerator up or denominator down"
    (destructuring-bind
     (n d) pair
     (if (= 1 d)
	 (list (1+ n) d)
	 (if (zerop (random 2))
	     (list (1+ n) d)
	     (list n (1- d))))))



(defun decrease-pair (pair)
  "either move car down or caddr up"
  ;; hahahahahhahaha
  (reverse (increase-pair (reverse pair))))

(move-pair '(3 4) -1)
(decrease-pair '(1 1))


(defun orchestra-maker ()
  (let ((bass '(1 1))
	(tenor '(2 1))
	(alto '(3 2))
	(saprano '(4 1))
	(saprano-direction 1)
	(time 0)
	(self nil))
    (setf self
	  (list
	   :get-freqs
	   (lambda ()
	     (let ((freqs (mapcar #'pair->frac (list bass tenor alto saprano))))
	       (cons (car freqs) (mapcar (lambda (x) (* x (car freqs))) (cdr freqs)))))
	   :get-pairs
	   (lambda ()
	     (list bass tenor alto saprano))
	   :move
	   (lambda ()
	     (if (mero time 9)
		 (setf bass (move-pair bass)))

	     (if (mero time 3)
		 (progn
		   (setf tenor (cannonize (move-pair tenor)))
		   (setf alto (move-pair alto))
		   (if (< (pair->frac alto) (pair->frac tenor))
		       (setf alto (increase-pair alto)))
		   (setf saprano (move-pair (frac->pair (* 2 (pair->frac tenor)))))
		   (setf saprano-direction (one-or-minus-one))))

	     (setf saprano (move-pair saprano saprano-direction))
	     (incf time)
	     (@ self :get-pairs))))))


(defvar foo (orchestra-maker))

(@ foo :get-freqs)
(@ foo :get-pairs)
(@ foo :move)

(let ((orchestra (orchestra-maker)))
