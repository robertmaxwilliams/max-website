;; not part of the package, just convenience to start the server
(format t "222 Welcome to max website dot website server have a good stay~%")


;; caching problems, code changes don't get noticed
;;(asdf:clear-configuration)
;;(asdf:clear-system :max-website)

;; if the TESTING magic file is in pwd, then set to my laptop's dir. Otherwise set to 
;; server's dir. Not the best way but it works.
  
;; for interactive use, bc. I'm usually in the code dir when I launch slime
;;(setf *default-pathname-defaults* (truename "/Users/max/Repos/website/"))


;; ASDF should make this unneeded
(if (probe-file "TESTING")
  (progn 
    (print "Testing mode")
    (defparameter *max-website-dir* "/Users/max/Repos/website/")
    (defparameter *testing* t))
  (progn
    (print "Deployment mode")
    (defparameter *max-website-dir* "/home/public/max-website/")
    (defparameter *testing* nil)))

;;(ql:register-local-projects)
(pushnew (truename *max-website-dir*) ql:*local-project-directories*)
;;(pushnew (truename "/Users/max/Repos/website/max-website-code") ql:*local-project-directories*)
(ql:register-local-projects)
(print ql:*local-project-directories*)

;;(ql:quickload :max-website)
;;(ql:uninstall :max-website)
(ql:quickload :max-website)
;;(ql:quickload :banana-grams)
;;(ql:uninstall :banana-grams)


(asdf:component-pathname (asdf:find-component :foo '("bar" "baz")))
(asdf:component-pathname (asdf:find-component :max-website "package"))


;;(in-package :cl-user)
(banana-grams:peel "dogromasqu" 1)
(max-website::2d-table-from-

(setf banana-grams::*allow-run* t)

(max-website:start-website *max-website-dir* *testing*)
