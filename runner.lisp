;; not part of the package, just convenience to start the server
(format t "222 Welcome to max website dot website server have a good stay~%")


;; caching problems, code changes don't get noticed
;;(asdf:clear-configuration)
;;(asdf:clear-system :max-website)

;; if the TESTING magic file is in pwd, then set to my laptop's dir. Otherwise set to 
;; server's dir. Not the best way but it works.
  
(if (probe-file "TESTING")
  (progn 
    (defparameter *max-website-dir* "/Users/max/Repos/website/")
    (defparameter *testing* t))
  (progn
    (defparameter *max-website-dir* "/home/public/max-website/")
    (defparameter *testing* nil)))

;;(ql:register-local-projects)
(pushnew (truename *max-website-dir*) ql:*local-project-directories*)
(ql:register-local-projects)

;;(ql:quickload :max-website)
;;(ql:uninstall :max-website)
(ql:quickload :max-website)

(max-website:start-website *max-website-dir* *testing*)

