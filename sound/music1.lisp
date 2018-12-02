
(ql:quickload :cl-portaudio)
(ql:quickload :vecto)

(defpackage :audio-fun
  (:use :cl :portaudio :vecto))

(in-package :audio-fun)

;; set to true to kill music globaly
(defparameter *kill* nil)

;; short alias for funcall
(defmacro f (fun &rest args)
  `(funcall ,fun ,@args))

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

;; this should be a functoin?
(defun defclosure->plist-lambda (name lambdalist &rest body)
  " converts (:foo (x) (+ x 1)) to (:foo (lambda (x) (+ x 1))) "
  `(,name (lambda ,lambdalist ,@body)))

(defmacro defmulticlosure (name lambdalist docstring letforms &body methods)
  (if (listp docstring) ;; optional docstring is missing, shift args by one
      (progn
	(setf methods (cons letforms methods))
	(setf letforms docstring) ;;oops!
	(setf docstring nil)))
  `(defun ,name ,lambdalist
     ,docstring
     (let* ,letforms
       (let (self)
	 (setf
	  self
	  ,(cons 'list
		 (loop for method in methods
		    append (list (car method)
				 (cons 'lambda (cdr method))))))
	 (if (getf self :init) (@ self :init))
	 self))))

;;(print "")
;;(print
;; (macroexpand-1
;;  '(defmulticlosure foo-maker (somearg)
;;    ((a 5)
;;     (b somearg))
;;    (:foo () a)
;;    (:bar (x) (incf a x))
;;    (:init () (incf b)))))

(defmulticlosure foo-maker (somearg)
    ((a 5)
     (b somearg))
    (:foo () a)
  (:get-b () b)
  (:bar (x) (incf a x))
  (:init () (incf b)))

;;(defvar foo (foo-maker 4))
;;(@ foo :get-b)


(defun random-walk-maker ()
  (let ((x 0.5))
    (lambda ()
      (incf x (/ (- (random 100) 50) 900))
      (if (> x 1)
	  (setf x 1.0))
      (if (< x 0)
	  (setf x 0.0))
      x)))

(defun walking-tone-maker (starting-freq)
  (setf starting-freq (coerce starting-freq 'float))
  (let* ((f starting-freq)
	 (tone (triange-wave-maker f)))
    (lambda ()
      (setf f (* f (1+ (/ (- (random 101) 50) 90000))))
      (if (< f (* 0.1 starting-freq))
	  (setf f (* 0.1 starting-freq)))
      (if (> f (* 10 starting-freq))
	  (setf f (* 10 starting-freq)))
      
      (@ tone :set-freq f)
      (@ tone :step))))

(defun rumble-sound ()
  (let ((foo1 (random-walk-maker))
	(foo2 (random-walk-maker))
	(temp 0))
    (trivial-with-audio (:duration 500)
      (if (= *channel 0)
	  (setf temp (* 0.4 (+ (f foo1) (f foo2))))
	  temp))))
 
;;(let ((foo (walking-tone-maker 220.0)))
;;  (trivial-with-audio (:duration 5)
;;    (f foo)))

;;(rumble-sound)

(defun rumble-sound-with-tone ()
  (let ((foo1 (random-walk-maker))
	(foo2 (random-walk-maker))
	(foo3 (random-walk-maker))
	(tone (walking-tone-maker 220.0))
	(temp 0))
    (trivial-with-audio (:duration 500)
      (if (= *channel 0)
	  (setf temp (+ (* 0.5 (* (f tone) (f foo3))) (* 0.4 (+ (f foo1) (f foo2)))))
	  temp))))

;;(rumble-sound-with-tone)

(defun spring-mass-maker (&key (k -0.01) (b 0.9999))
  (let* ((x 1.0)
	 (v 0.0)
	 (freq nil) ;; measured on init
	 ;;(k -0.01) ;; spring constant
	 ;;(b 0.9999);; damping
	 self) 
    (setf
     self
     (list
      :init ;; to reduce click without doing calculus
      (lambda () (let ((time-to-fall 0.0))
		   (loop while (> x 0)
		      do (@ self :step)
		      do (incf time-to-fall))
		   (setf freq (/ *sps* (* 2 time-to-fall)))))
      :step (lambda ()
	      (progn
		(incf v (* x k))
		(setf v (* v b))
		(incf x v)))
      :get-vars (lambda () (list x v k b freq))
      :set-k (lambda (new-k) (setf k new-k))
      :get-k (lambda () k)
      :get-x (lambda () x)
      :reset (lambda ()
	       (setf x 1.0)
	       (@ self :init))))
    (@ self :init)
    self))

(loop for ls on '(1 2 3)
   collect ls)

(defun add-to-car (x ls)
  (if (null ls)
      (cons x nil)
      (cons (+ x (car ls)) (cdr ls))))
;;(add-to-car 5 '(1 2 3))


(defun adj-pairs (ls)
  (loop for rest on ls
     until (null (cdr rest))
     collect (list (car rest) (cadr rest))))
(adj-pairs '(1 2 3 4 5))


(defun rand-1 ()
  (/ (random 100) 100))

(defun simple-plot (sequences file &key (width 500) (height 500) (x-width 2))
  (vecto:with-canvas (:width width :height height)
    (vecto:translate 45 45)
    (vecto:set-rgb-stroke 1 0 0)
    (vecto:set-rgba-stroke 0 0 1.0 0.5)
    (vecto:set-line-width 2)
    (loop for ls in sequences
       do (vecto:set-rgb-stroke (rand-1) (rand-1) (rand-1))
       do (loop for a-b in (adj-pairs ls)
	     for x from 0
	     do (progn
		  (vecto:move-to (* x-width x) (* 10 (car a-b)))
		  (vecto:line-to (* x-width (1+ x)) (* 10 (cadr a-b)))
		  (vecto:stroke))))
    (vecto:save-png file)))

(simple-plot '((1 2 3 4) (5 4 3 2 2)) "oops.png")

(defun get-dvs (xs k)
  " using posisions, gets change in velocities of all masses "
  (cond ((null (cdr xs)) ;; end when only one element bc we need 2
	 nil)
	(t (let* ((d (1+ (- (car xs) (cadr xs) ))) ;; displacement
		  (dv (* d k))) ;; delta v
	     (cons dv (add-to-car (- dv) (get-dvs (cdr xs) k)))))))

(defun update-wobble-stack (xs vs k)
  " returns vs and xs, incremented "
  (let* ((dvs (get-dvs xs k))
	 (new-vs (mapcar #'+ vs dvs))
	 (new-xs (mapcar #'+ xs vs)))
    (setf new-vs (mapcar (lambda (v) (- v 0.00001)) new-vs)) ;;gravity
    (if (< (car new-xs) 0)
	(setf (car new-vs) (- (car new-vs)))) ;; bounce
    (mapcar (lambda (v) (* 0.9 v)) vs) ;; damping (TODO better damping)
    (list new-xs new-vs)))

(defun draw-wobble-plot ()
  (simple-plot
   (let ((foo (wobble-stack-maker :k 0.1)))
     (apply #'mapcar #'list
	    (loop for i from 0 to 100
	       collect 
		 (progn
		   (@ foo :step)
		   (@ foo :get-xs)))))
   "oops.png"))

;;(draw-wobble-plot)

(defmulticlosure wobble-stack-maker (&key (k -0.01))
    " several weights, unit distance apart with stiff springs that default to
    unit distance. This whole thing falls, hits the groung (at zero) and bounced.
    output is displacement of lowest mass from it's partner (car and cadr of xs) "
    ((xs '(0.0 1.0 2.0 3.0 4.0)) ;; starting with 5 weights
     (vs '(0.0 0.0 0.0 0.0 0.0)))
  ;; raise all masses by one unit
  (:raise () (setf xs (mapcar #'1+ xs)))
  ;; pysics step
  (:step ()
	 (let ((new-xs-vs (update-wobble-stack xs vs k)))
	   (setf xs (car new-xs-vs))
	   (setf vs (cadr new-xs-vs)))
	 (car xs))
  (:get-xs () xs)
  (:get-vs () vs))

;;(defvar foo (wobble-stack-maker))
;;(progn
;;  (@ foo :step)
;;  (@ foo :get-xs))
;;
;;(defvar foo (spring-mass-maker :k -0.00011 :b 0.99995))
;;(@ foo :get-vars)
;;(@ foo :step)
;;(@ foo :get-vars)
;;
;;(@ foo :set-k (* 0.9999 (@ foo :get-k)))

(defun play-tone ()
  (let ((tone (spring-mass-maker :k -0.0041 :b 0.99999)))
    (print (@ tone :get-vars))
    (trivial-with-audio ()
      (if (= *channel 0)
	  (@ tone :step)
	  0))))

(defun play-another-tone ()
  (let ((tone (triange-wave-maker 565.0)))
    (trivial-with-audio ()
      (if (= *channel 0)
	  (@ tone :step)
	  0))))


(defun repeate-dingo-maker ()
  (let ((tone (spring-mass-maker :k -0.0011 :b 0.99995))
	(wobble (spring-mass-maker :k -0.000002 :b 1.0)))
    (lambda ()
      (progn
	(destructuring-bind (x v k b freq) (@ tone :get-vars)
	  (declare (ignore k b freq))
	  (if (and (> 0.1 x -0.1)
		   (< (abs v) 0.001))
	      (progn
		(@ tone :reset)
		(@ wobble :reset)
		(* (@ tone :get-x)
		   (@ wobble :get-x)))
	      (* (@ tone :step) ;;else
		 (@ wobble :step))))))))
		     

(defun play-ding-sound ()
  (let ((foo (repeate-dingo-maker)))
    (trivial-with-audio (:duration 10)
      (f foo))))


(defun play-wobble ()
  (let ((foo (spring-mass-maker :k -0.0011 :b 0.99995))
	(bar (spring-mass-maker :k -0.000002 :b 0.99999)))
    (trivial-with-audio ()
      (if (= *channel 0)
	  (* (@ foo :step)
	     (@ bar :step))
	  0))))

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




;; ======= branch - everything under this line is special purpose for this orchestra
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



