;; not part of the package, just convenience to start the server
(format t "Welcome to max website dot website server have a good stay~%")
;;(asdf:clear-configuration)
;;(asdf:clear-system :max-website)
;;(ql:uninstall :max-website)
(ql:register-local-projects)
(ql:quickload :max-website)
(max-website:start-website "/Users/max/Repos/website/")
