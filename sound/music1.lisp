
(ql:quickload :cl-portaudio)

(defpackage :audio-fun
  (:use :cl :portaudio))

(in-package :audio-fun)

;; set to true to kill music globaly
(defparameter *kill* nil)

(defmacro trivial-with-audio ((&key (duration 3)) &body body)
  " reduce boiler plate. I hate boiling plates! Supplies *i, half-earmuffed scoped var for time."
  `(let ((frames-per-buffer 1024)
	 (sample-rate 44100d0)
	 (seconds ,duration)
	 (sample-format :float)
	 (num-channels 2))
     (with-audio
       (format t "~%=== Wire on. Will run ~D seconds . ===~%" seconds) 
       (with-default-audio-stream
	   (astream num-channels num-channels
		    :sample-format sample-format
		    :sample-rate sample-rate
		    :frames-per-buffer frames-per-buffer)
	 (dotimes (frame-count (round (/ (* seconds sample-rate) frames-per-buffer)))
	   (if *kill* (error 'error))
	   (write-stream astream
			 (let ((arr (make-array '(2048) :element-type '(single-float) :initial-element 0.0)))
			   (loop for i from 0 below 2048
			      do (multiple-value-bind (*time *channel) (floor (+ i (* frame-count 2048)) 2)
				   (declare (ignorable *time))
				   (declare (ignorable *channel))
				   (setf (aref arr i)
					 (float ,@body))))
			   arr)))))))

(defmacro @ (plist property &body args)
    " just like accessing a member function or watever "
  `(funcall (getf ,plist ,property) ,@args))

;; basic wave classes
;; use plist closures for standard
;; should always have a step function
;; oh gee I really am becoming an OO programmer
;; should go from -1 to 1

;; samples per second
(defparameter *sps* 44100)

(defun triange-wave-maker (starting-freq)
  (let ((x 0.0)
	(freq starting-freq)
	(direction 1)) ;; -1 for down
    (list
     :step (lambda (&optional (dt 1))
	     (progn
	       (incf x (/ (* 2 dt freq) (* 1 *sps*)))
	       (if (> x 1) (progn
			     (incf x -2)
			     (setf direction (* -1 direction))))
	       (* direction x)))
     :get-x (lambda () (* direction x))
     :set-freq (lambda (new-freq) (setf freq new-freq)))))


(defun spring-mass-maker ()
  (let ((x 1.0)
	(v 0.0)
	(k -0.1) ;; spring constant
	(b 0.99)) ;; damping
    (list
     :step (lambda ()
	     (progn
	       (incf v (* x k))
	       (setf v (* v b))
	       (incf x v)))
     :reset (lambda () (setf x 1.0)))))

;;(defvar foo (spring-mass-maker))
;;(@ foo :step)



(defun slider-maker (starting-val slowness)
  (let ((x (float starting-val))
	(target (float starting-val))
	(ratio (expt 10 (- slowness))))
    (list
     :step (lambda () (setf x (+ x (* ratio (- target x)))))
     :get-x (lambda () x)
     :set-target (lambda (new-target) (setf target new-target)))))

(defun kyu-maker (ls)
  " very neat! And I came up with it myself!"
  ;; sorry I got really sick of spelling queueueuueueue
  (let* ((kyu ls)
	(tail (last kyu)))
    (list
     :push (lambda (x)
	     (nconc tail (list x))
	     (setf tail (cdr tail))
	     kyu)
     :pop (lambda () (pop kyu)))))


(defun delay-kyu-maker (steps initial-element)
  " call at each time step, and get out a value from
    so many steps back!"
  (let ((kyu
	 (kyu-maker
	  (loop for i from 0 below steps
	     collect initial-element))))
    (lambda (new-entry)
      (@ kyu :push new-entry)
      (@ kyu :pop))))

(defun trash (arg)
  (declare (ignore arg)))

;; short alias for funcall
(defmacro f (fun &rest args)
  `(funcall ,fun ,@args))

(defmacro return-after (value &body body)
  " saves a value to a gensym, progn's body, then returns saved value"
  (let ((temp1 (gensym)))
    `(let ((,temp1 ,value))
       (progn ,@body)
       ,temp1)))

;;(let ((x 5))
;;  (return-after x (incf x)))


(defun cycle-trigger-maker (freq &key (first-time nil))
  " gives a single t in a sea of nil at freq hz
    set first-time to start on a t"
  (let ((time (if first-time 0 1)) ;; flag is true after event is triggered
	(period (floor *sps* freq)))
  (lambda () (return-after
		 (if (zerop (mod time period)) t nil)
	       (incf time)))))

(defun play-list (ls &optional (speed 4))
  (let ((in1 (triange-wave-maker (car ls)))
	(in1f (slider-maker (car ls) 3))
	(ct (cycle-trigger-maker speed)))
    (trivial-with-audio (:duration (/ (+ 3 (length ls)) speed))
      (progn
	(if (= *channel 0)
	    (progn 
	      (if (and (f ct)
		       (not (null ls)))
		  (@ in1f :set-target (pop ls)))
	      (@ in1 :set-freq (@ in1f :step))
	      (@ in1 :step))
	    (@ in1 :get-x))))))

(defun tone-cycle-instrument-maker (freq-list oscillator freq-slider cycle-trigger)
  (lambda () (if (and (f cycle-trigger)
		      (not (null freq-list)))
		 (@ freq-slider :set-target (pop freq-list)))
	  (@ oscillator :set-freq (@ freq-slider :step))
	  (@ oscillator :step)))

(defun list-player-maker (ls speed) 
  (tone-cycle-instrument-maker 
   ls
   (triange-wave-maker (car ls))
   (slider-maker (car ls) 3)
   (cycle-trigger-maker speed)))

(defun play-lists (ls1 ls2 &optional (speed 4))
  " plays one through each speaker "
 (flet ()
    (let ((instrument1 (list-player-maker ls1 speed))
	  (instrument2 (list-player-maker ls2 speed)))
      (trivial-with-audio (:duration (/
				      (+ 3 (max (length ls1) (length ls2)))
				      speed))
	(progn
	  (if (= *channel 0)
	    (funcall instrument1)
	    (funcall instrument2)))))))

(defun sound-noise-wave ()
  (trivial-with-audio ()
    (float (/ (random 100) 100))))




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



(defun pair->frac (pair)
  (/ (car pair) (cadr pair)))

(defun frac->pair (frac)
  (list (numerator frac) (denominator frac)))



(defun bass-constraint (pair)
  " if pair is greater than 4, double denominator and cannonize
    if pair is less than 1/4, double numerator and cannonize"
  (destructuring-bind
	(n d) pair
    (cond ((> n (* 4 d))
	   (cannonize (list n (* 2 d))))
	  ((> d (* 4 n))
	   (cannonize (list (* 2 n) d)))
	  (t pair))))

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
	   :get-bass (lambda () (* 440.0 (pair->frac bass)))
	   :get-tenor (lambda () (* 440.0 (pair->frac tenor)))
	   :get-alto (lambda () (* 440.0 (pair->frac alto)))
	   :get-saprano (lambda () (* 440.0 (pair->frac saprano)))
	   :get-pairs
	   (lambda ()
	     (list bass tenor alto saprano))
	   :step
	   (lambda ()
	     (if (mero time 9)
		   (setf bass (bass-constraint (move-pair bass))))

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
	     (print (@ self :get-pairs))
	     (@ self :get-pairs))))))


(defun closure-cycle-instrument-maker (freq-closure oscillator freq-slider cycle-trigger)
  (lambda () (if (and (f cycle-trigger)
		      (not (null (f freq-closure))))
		 (@ freq-slider :set-target (f freq-closure)))
	  (@ oscillator :set-freq (@ freq-slider :step))
	  (@ oscillator :step)))


(defun closure-player-maker (fun speed)
  " pass in a fun which is called every step for instrument freq"
  (closure-cycle-instrument-maker 
   fun
   (triange-wave-maker (f fun))
   (slider-maker (f fun) 3.5)
   (cycle-trigger-maker speed)))

(defun merge-sum (ls1 ls2)
  "dot produce then sum"
  (reduce #'+ (mapcar #'* ls1 ls2)))

(defun yes (duration)
  (let* ((temp1 '(0 0 0 0))
	 (speed 3)
	 (left-balance '(0.1 0.25 0.25 0.4))
	 (right-balance '(0.4 0.25 0.25 0.1))
	 (orchestra-cycle-trigger (cycle-trigger-maker 3))
	 (orchestra (orchestra-maker))
	 (bass (closure-player-maker (getf orchestra :get-bass) speed))
	 (tenor (closure-player-maker (getf orchestra :get-tenor) speed))
	 (alto (closure-player-maker (getf orchestra :get-alto) speed))
	 (saprano (closure-player-maker (getf orchestra :get-saprano) speed)))
    (trivial-with-audio (:duration duration)
      (if (= *channel 0)
	  (progn
	    (if (f orchestra-cycle-trigger)
		(@ orchestra :step))
	    (setf temp1 (list (f bass) (f tenor) (f alto) (f saprano)))
	    (merge-sum temp1 left-balance))
	  (merge-sum temp1 right-balance)))))
	  
(defun white-noise ()
  (- 0.5 (/ (random 100) 100)))

(defun nat (x)
  (if (<= x 0) 1 x))
(defun maybe-trim (x)
  (if (and (> x 7) (zerop (random (nat (- 15 x)))))
      (1- x)
      x))


(defun reduce-highs (pair)
  " if n or d is greater than 7, is might get decremented"
  (mapcar #'maybe-trim pair))





;;(yes 1000)
;;(defparameter *kill* nil)
;;(defparameter *kill* t)

;; version two
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
	   :get-bass (lambda () (* 440.0 (pair->frac bass)))
	   :get-tenor (lambda () (* 440.0 (pair->frac tenor)))
	   :get-alto (lambda () (* 440.0 (pair->frac alto)))
	   :get-saprano (lambda () (* 440.0 (pair->frac saprano)))
	   :get-pairs
	   (lambda ()
	     (list bass tenor alto saprano))
	   :step
	   (lambda ()
	     (if (mero time 9)
		   (setf bass (bass-constraint (move-pair bass))))

	     (if (mero time 3)
		 (progn
		   (setf tenor (reduce-highs (move-pair tenor)))
		   (setf alto (reduce-highs (move-pair alto)))
		   (if (< (pair->frac alto) (pair->frac tenor))
		       (setf alto (increase-pair alto)))
		   (setf saprano (move-pair (frac->pair (* 2 (pair->frac tenor)))))
		   (setf saprano-direction (one-or-minus-one))))

	     (setf saprano (move-pair saprano saprano-direction))
	     (incf time)
	     (print (@ self :get-pairs))
	     (@ self :get-pairs))))))



