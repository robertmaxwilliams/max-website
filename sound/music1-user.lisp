
(load "music1.lisp")
(in-package :audio-fun)

(yes 10000)

(let ((tone (spring-mass-maker :k -0.00000041 :b 0.99999)))
  (trivial-with-audio ()
    (progn
      (@ tone :set-k (* 1.0001 (@ tone :get-k)))
      (float (* (@ tone :step) (/ (random 100) 100))))))

(defparameter *kill* nil)
(defparameter *kill* t)


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

