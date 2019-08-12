
(ql:quickload :cl-portaudio)
(ql:quickload :vecto)

(defpackage :audio-fun
  (:use :cl :portaudio :vecto))

(in-package :audio-fun)

;; set to true to kill music globaly
(defparameter *kill* t)
(defparameter *kill* nil)

;; short alias for funcall
(defmacro f (fun &rest args)
  `(funcall ,fun ,@args))

(get-default-input-device)
(get-host-api-count)
(get-default-host-api)
(print-devices)
(host-api-device-index-to-device-index 1 -1)
(get-device-info -1)
(describe #'host-api-device-index-to-device-index)

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

(defparameter *sps* 44100)

;; ==============
;; INSTRUMENTS
;; ==============

(defun saw (freq &optional (duration 1) (amp 1))
  (let* ((width 1.0)
	 (v (* 0.5 width (/ (* 440.0 freq) *sps*)))
	 (x 0.0)
	 (time 0))
    (lambda ()
      (incf time)
      (incf x v)
      (if (> x width)
	  (setf x (- width)))
      (if (< time (* duration *sps*))
	  (* 0.2 x amp)
	  :done))))

(defun wobble-saw (freq1 freq2))

(defun f-upramp (x)
    (1- (* (/ (+ 1 (exp (- (/ x 100))))) 2)))

(defun fade-in-fade-out (duration)
  (lambda (time)
    (if (>= time duration)
	0
	(* (f-upramp time) (f-upramp (- duration time))))))

(defun triangle (freq &optional (duration 1) (amp 1))
  (let* ((width 1.0)
	 (v (* width (/ (* 440.0 freq) *sps*)))
	 (x 0.0)
	 (fade (fade-in-fade-out (* *sps* duration)))
	 (time 0))
    (lambda ()
      (incf time)
      (incf x v)
      (if (or (<= x (- width)) (>= x width))
	  (setf v (- v)))
      (if (< time (* duration *sps*))
	  (* (f fade time) amp x)
	  :done))))

(defun random-logit ()
  (- (/ (random 256) 128.0) 1))
(random-logit)

(defun crash (slowness &optional (duration 1) (intensity 1))
  (let ((damping (- 1.0 (/ (expt 2 (+ 10 slowness)))))
	(time 0))
    (lambda ()
      (incf time)
      (setq intensity (* intensity damping))
      (if (< time (* duration *sps*))
	  (* (random-logit) intensity)
	  :done))))


(defun ramp-down (speed)
  (let ((decayer 1.0)
	(decay-rate (- 1 (/ (expt 2 speed))))
	(temp nil))
    (lambda ()
      (setq temp decayer)
      (setq decayer (* decayer decay-rate))
      temp)))
(defun ramp-up (speed)
  (let ((ramp-downer (ramp-down speed)))
    (lambda ()
      (- 1 (f ramp-downer)))))

(defvar foo (ramp-up 4))
(f foo)
(defun tink (freq &optional (duration 1))
  (let ((x 0.0)
	(v 4.0)
	(time 0)
	(ease-in (ramp-up 6))
	(damping 0.999)
	(k-decay 0.99999)
	(k (* freq 0.06)))
    (lambda ()
      (incf time)
      (incf x (* v 0.01))
      (setq x (* x damping))
      (setq k (* k k-decay))
      (if (minusp k)
	  (setq k 0.0001))
      (decf v (* x k))
      (if (< time (* duration *sps*))
	  (* 2.2 x (f ease-in))
	  :done))))

(defun doink (freq &optional (duration 1))
  (let ((x 0.0)
	(v 1.0)
	(time 0)
	(damping 0.999)
	;;(k-decay 1.0001)
	(k (* freq 0.01)))
    (lambda ()
      (incf time)
      (incf x (* v 0.01))
      (setq x (* x damping))
      (decf k 0.00001)
      (if (minusp k)
	  (setq k 0.0001))
      (decf v (* x k))
      (if (< time (* duration *sps*))
	  x
	  :done))))

(defun silence (duration)
  (let ((time 0))
    (lambda ()
      (incf time)
      (if (< time (* duration *sps*))
	  0.0
	  :done))))

(let ((foo (tink 9 5)))
  (trivial-with-audio (:duration 4)
    (if (zerop *channel) (f foo) 0)))


;; ==============
;; LAMBDATION
;; ==============


(defun arg-preprocess (ls)
  (cond
    ((null ls) nil)
    ((atom (car ls)) (cons (car ls) (arg-preprocess (cdr ls))))
    (t (case (car (car ls))
	 (:repeat (destructuring-bind (re times form) (car ls)
		    (pass-1 re)
		    (append (loop repeat times collect form) (arg-preprocess (cdr ls)))))
	 (otherwise (cons (car ls) (arg-preprocess (cdr ls))))))))

(defun single-list-unpacking-mapcar (fun ls)
  (cond
    ((null ls) nil)
    ((atom (car ls))
     (cons (funcall fun (car ls))
	   (single-list-unpacking-mapcar fun (cdr ls))))
    (t (cons (apply fun (car ls)) (single-list-unpacking-mapcar fun (cdr ls))))))

(member 3 '(1 2 3))
(defun special-lambdize-for-keywords (fun)
  (lambda (&rest args)
    (case (car args)
      ('rest (apply #'silence (cdr args)))
      (otherwise (apply fun args)))))

(defun lambdize-track (track)
  (single-list-unpacking-mapcar
   (special-lambdize-for-keywords (symbol-function (car track)))
   (arg-preprocess (cdr track))))

;; ==============
;; CHONKATION
;; ==============

(defun roll-chonk (chonk)
  "chonk is a lambdized track. Roll means cdr if :done"
  (if (null chonk)
      (list 0 nil)
      (let ((sample (f (car chonk))))
	(if (equal sample :done)
	    (roll-chonk (cdr chonk))
	    (list sample chonk)))))

(defun extract-step (chonks)
  " extracts next sample and rolled chonks"
  (let ((sample-chonk-pairs
	 (loop for chonk in chonks
	    collect (roll-chonk chonk))))
    (list (reduce #'+ (mapcar #'car sample-chonk-pairs))
	  (mapcar #'cadr sample-chonk-pairs))))

(defvar foo (lambdize-track '(triangle 1 2 1 3/2)))

(defun play-tracks (duration tracks)
  (let ((chonks (mapcar #'lambdize-track tracks))
	(sample 0))
    (trivial-with-audio (:duration duration)
      (if (= 0 *channel)
	  (let ((sample-chonks (extract-step chonks)))
	    (setq chonks (cadr sample-chonks))
	    (setq sample (car sample-chonks))
	    sample)
	  sample))))
 

 ;; ==============
 ;; PLAY SONG
 ;; ==============

 (play-tracks 
  ;;  |   |   |   |   |   |   |   |   |   |   |   |   |
  '((triangle 1   3/2 5/2 3/2 1   2/3 (1 3))
    (triangle 1   2   1   2/3 6/5 1   (1 3))
    (crash    (:repeat 4 (4 2)))
    (tink     (2 0.5)      (:repeat 4 (9 2)) (:repeat 4 (9 1)))
    (tink     (2 0.51)      (:repeat 4 (9 2)))
    (tink     (2 0.52)      (:repeat 4 (9 2)))
    (saw      1   2.1 1   6/7 6/7 1   (1 3) (9/8 0.5) (8/9 0.5)
     (10/7 0.25) (12/7 0.25) (7/9 0.5) (9/8 0.2) (8/9 0.8) 1 (2 0.125) (4 0.125) 1)
    ))
 (defun repeat (times x)
   (loop repeat times collect x))

(play-tracks
 15
 `(
   (tink  ,@(repeat 4 '(13 1)))
   (tink (rest 0.05) ,@(repeat 4 '(8 1)))
   (tink (rest 0.10) ,@(repeat 4 '(7.2 1)))
   (crash (rest 4) ,@(repeat 4 `(3 2)))
   (saw      (rest 4) (9/8 0.5) (8/9 0.5)
	     (10/7 0.25) (12/7 0.25) (7/9 0.5) (9/8 0.2) (8/9 0.8) 1 (2 0.125) (3 0.125) (2 0.5) 1
	     (10/7 0.25) (12/7 0.25) (7/12 0.5) (9/8 0.2) (8/9 0.8) 1 (2 0.125) (3 0.125) (2 0.5) 1)
   (triangle (rest 4) (8/9 0.5) (16/81 0.5)
	     (10/7 0.25) (12/7 0.25) (7/9 0.5) (9/8 0.2) (8/9 0.8) 1 (2 0.125) (3 0.125) (2 0.3) 1
	     (10/7 0.25) (12/7 0.25) (7/9 0.5 3) (1 0.2 4) (8/9 0.8 3) 1 (4 0.125) (-2 0.125) (2 0.5) 1)
   ))

(define-symbol-macro r '(rest 1))
(list +r)
(print '(1 2 +r))
(play-tracks
 19
 `(
   (saw (rest 4)              (6 3 0.1)                         (3/2 2 0.2) (5/2 1 0.2) (5/3 1 0.2))
   (triangle 1   2   1   2    (6 1 0.2) (3 1 0.1) (13/9 1 0.2)  ,r  (1 3)                             )
   (triangle ,r  3/2 5/3 (3/2 2)        (4/5 2)                 ,r  ,r          3/2         3/2)
   (triangle ,r ,r   3   1    (5/2 2)             5/3           (rest 4)                          )
   ))

(play-tracks
 10
 `(
   (tink ,@(repeat 4 '(9 0.2)))
   (triangle  5/3)
   (triangle  1)
   (triangle  3/2)
   ))

(play-tracks
 2
 `(
   (tink ,@(repeat 4 '(9 1)))
   (tink (rest 0.05) ,@(repeat 4 '(8 1)))
   (tink (rest 0.10) ,@(repeat 4 '(7.2 1)))
   ))

(defparameter *kill* t)
(defparameter *kill* nil)
