
(ql:quickload :cl-portaudio)

(defpackage :audio-fun
  (:use :cl :portaudio))

(in-package :audio-fun)


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
	   (write-stream astream
			 (let ((arr (make-array '(2048) :element-type '(single-float) :initial-element 0.0)))
			   (loop for i from 0 below 2048
			      do (multiple-value-bind (*time *channel) (floor (+ i (* frame-count 2048)) 2)
				   (declare (ignorable *time))
				   (declare (ignorable *channel))
				   (setf (aref arr i)
					 (float ,@body))))
			   arr)))))))

;; redoing many of the wave functions to be stateful instruments, makes it easier to
;; slide frequency without creating artifacts
;; I think I'll make them all closures just for consistency, and
;; end their names with "-maker"
(defun let-over-lambdas () 
  " returns a property list with umm some lambdas and such. Use this pattern like class."
  (let ((x 0)) ;; x is the value we return every call
    (list
     :increment (lambda () (incf x))
     :decrement (lambda () (incf x -1)))))
;;(defvar quuzer (let-over-lambdas))
;;(print quuzer)
;;(getf quuzer :increment)

(defmacro @ (plist property &body args)
    " just like accessing a member function or watever "
  `(funcall (getf ,plist ,property) ,@args))

;;(@ quuzer :increment)
;;(@ quuzer :decrement)

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

  
(let ((in1 (triange-wave-maker 440))
      (in2 (triange-wave-maker 100))
      (delay (delay-kyu-maker (* *sps* 2) 0.0)))
  (trivial-with-audio (:duration 5)
    (if (= *channel 0)
	(@ in1 :step)
	(* 3 (funcall delay (@ in2 :step))))))

(let ((in1 (triange-wave-maker 440))
      (in1f (slider-maker 440 4)))
  (trivial-with-audio (:duration 3)
    (progn
      (if (= *channel 0)
	  (progn 
	    (if (> *time *sps*) (@ in1f :set-target 220))
	    (@ in1 :set-freq (@ in1f :step))
	    (@ in1 :step))
	  (@ in1 :get-x)))))

;; short alias
(defmacro f (fun &rest args)
  `(funcall ,fun ,@args))

(defmacro return-after (value &body body)
  " saves a value to a gensym, progn's body, then returns saved value"
  (let ((temp1 (gensym)))
    `(let ((,temp1 ,value))
       (progn ,@body)
       ,temp1)))

(let ((x 5))
  (return-after x (incf x)))


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
	(ct (cycle-trigger speed)))
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
      (trivial-with-audio (:duration (/ (+ 3 (length ls)) speed))
	(progn
	  (if (= *channel 0)
	    (funcall instrument1)
	    (funcall instrument2)))))))
 
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
      (incf-bounce (cdr ls) x))))

(defun rand-frac-list ()
  " starts at 3/3, each step num or den can increase or decrease "
  (let ((frac (cons 3 3)))
    (loop for i from 1 to 10
       do (rand-inc frac)
       collect (/ (car frac) (cdr frac)))))
;;(randfraclist)

(defun sound-noise-wave ()
  (trivial-with-audio ()
    (float (/ (random 100) 100))))
;;(sound-noise-wave)



;; some math scratch
;; freq = 1/secs
;; sps = samples/sec
;; (mod s x) -> repeates every x samples
;; freq = sps/x
;; x = sps/freq

(defun white-noise ()
  (- 0.5 (/ (random 100) 100)))
