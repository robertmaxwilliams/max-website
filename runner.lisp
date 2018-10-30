;; not part of the package, just convenience to start the server
(format t "Welcome to max website dot website server have a good stay~%")

;; if the TESTING magic file is in pwd, then set to my laptop's dir. Otherwise set to 
;; server's dir. Not the best way but it works.
(if (probe-file "TESTING")
  (defparameter *max-website-dir* "/Users/max/Repos/website/")
  (defparameter *max-website-dir* "/home/public/max-website/"))

(pushnew (truename *max-website-dir*) ql:*local-project-directories*)
(ql:register-local-projects)
(ql:quickload :max-website)
(max-website:start-website *max-website-dir*)
