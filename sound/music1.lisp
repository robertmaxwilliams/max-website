
;;(ql:quickload :cl-mixed)

;; (cl-mixed:make-unpacker c-buffer bytes sample-encoding channel-count channel-layout samplerate)

;;(cl-mixed:make-unpacker NIL 4096 :int16 2 :alternating 44100)

(defvar *sr* 44100)

;;(cl-mixed:make-space-mixer)

;;(cl-mixed:make-fader :duration 5.0)

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

(defun sound-noise-wave ()
  (trivial-with-audio ()
    (float (/ (random 100) 100))))
(sound-noise-wave)


;; samples per second
(defparameter *sps* 44100)

;; some math scratch
;; freq = 1/secs
;; sps = samples/sec
;; (mod s x) -> repeates every x samples
;; freq = sps/x
;; x = sps/freq

(defun triangle-wave (time frequency)
  " frequency in hz, time in samples (1/44100 secs) "
  (let ((divisor (/ *sps* frequency)))
    (- 0.5 (/ (mod time divisor) divisor))))

(defun square-wave (time frequency)
  (let ((divisor (/ *sps* frequency)))
    (if (< (mod time divisor) (floor divisor 2))
	-0.5 0.5)))

(defun v-wave (time frequency)
  (let ((divisor (/ *sps* frequency)))
    (- 0.5 (abs (- (/ (mod time divisor) divisor) 0.5)))))

(defun sound-triangle-wave (root wobble duration)
  (let ((f2 (* (/ 3 2) root)))
    (trivial-with-audio (:duration duration)
      (- 0.5
	 (*
	  (v-wave *time wobble)
	  (+ 
	   (triangle-wave *time root)
	   (* 0.5 (triangle-wave *time f2))))))))

(defun white-noise ()
  (- 0.5 (/ (random 100) 100)))

(trivial-with-audio (:duration 1) (* (v-wave *time 440) (square-wave *time 4)))
(trivial-with-audio (:duration 1) (square-wave *time 440))
(trivial-with-audio (:duration 1) (white-noise))
(sound-triangle-wave 440 30 3)
(sound-triangle-wave 220 60 3)



(defun fraction-explorer (time)
  " takes in samples of time, and returns a changing sequence of fractions"
  (let ((step (floor time (floor *sps* 2)))
	(ls (list 1 (/ 3 2) 1 (/ 2 3) 1 (/ 5 3) 1 (/ 3 5))))
    (nth (mod step (length ls)) ls)))


(trivial-with-audio (:duration 8) (v-wave *time (* 440 (fraction-explorer *time))))

(defun descender (decay-ratio)
  (let ((x 1.0))
    #'(lambda (&optional force)
	(if force (setf x force))
	(setf x (* x decay-ratio))
	x)))

(let ((foo (descender 0.9999)))
  (trivial-with-audio (:duration 1) (* (/ (random 100) 100) (funcall foo))))


(defun beat (freq)
  (let ((i 0)
	(t-reset (floor *sps* freq))
	(desc (descender 0.9999)))
    #'(lambda () 
	(incf i)
	(if (>= i t-reset)
	    (progn
	      (funcall desc 1.0)
	      (setf i 0)))
	(funcall desc))))



  
(let ((foo (beat 1)))
  (trivial-with-audio (:duration 10) (* (/ (random 100) 100) (funcall foo))))


(defparameter *p1* 440)

(defun global-slider-spaceship (ratio)
  (let ((pitch-tracker *p1*))
    #'(lambda ()
	(setf pitch-tracker (+ pitch-tracker (* ratio (- *p1* pitch-tracker)))))))

(defun global-slider (ratio)
  (let ((pitch-tracker *p1*))
    #'(lambda ()
	(setf pitch-tracker (+ pitch-tracker (* ratio (- *p1* pitch-tracker)))))))

(let ((foo (global-slider 0.0001)))
  (trivial-with-audio (:duration 10) (v-wave *time (funcall foo))))


(let* ((freq1 440)
      (freq2 500)
      (freq freq1))
  (trivial-with-audio (:duration 3) (v-wave (*time
					    (progn (setf freq (+ freq (* 0.0001 (- freq2 freq)))))))))
  

(setf *p1* (* *p1* (/ 11 12)))
(setf *p1* (* *p1* (/ 4 12)))
(setf *p1* (* *p1* (/ 3 12)))
(setf *p1* 440)
(setf *p1* (* *p1* (/ 12 3)))
(setf *p1* (* *p1* (/ 12 4)))
(setf *p1* (* *p1* (/ 12 11)))
