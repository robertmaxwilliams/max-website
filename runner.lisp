(format t "222 Welcome to max website dot website server have a good stay~%")

;; for interactive use, bc. I'm usually in the code dir when I launch slime
;;(setf *default-pathname-defaults* (truename "/Users/max/Repos/website/"))

(if (probe-file "TESTING")
  (progn 
    (print "Testing mode")
    (defparameter *max-website-dir* "/home/max/Repos/max-website/")
    (defparameter *testing* t))
  (progn
    (print "Deployment mode")
    (defparameter *max-website-dir* "/root/max-website/")
    (defparameter *testing* nil)))

(pushnew (truename *max-website-dir*) ql:*local-project-directories*)
(ql:register-local-projects)
(format t "ql local project dirs: ~a~%" ql:*local-project-directories*)

(ql:quickload :max-website)
(ql:quickload :banana-grams)

(max-website:start-website *max-website-dir* *testing*)
