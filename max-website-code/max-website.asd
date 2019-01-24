

(defsystem max-website
  :name "maxs-website"
  :serial t ;; makes sure each file depends on the other in series
  ;; and force recompile of everything if, for instance, a page template macro changes.
  :version "0.0.1"
  :maintainer "Max"
  :author "Max"
  :licence "The Bible"
  :description "a website. I made an asdf system so I could link to files"
  :depends-on ("hunchentoot" "cl-who" "cl-markdown" "asdf" "parenscript" "iterate"
                  "str" "uiop" "banana-grams")
  :components ((:file "package")
               (:file "globals")
               (:file "utilities")
               (:file "page-templates")
               (:file "blog")
               (:file "max-website")
               (:file "pascals-triangle")
               (:file "undecide")
               (:file "visjs-helpers")
	       (:file "tubes-game")
               (:file "url-funs")))


