;; not part of the package, just convenience to start the server
(format t "Welcome to max website dot website server have a good stay~%")
(ql:quickload :max-website)
(max-website:start-website "/Users/max/Repos/website/")
