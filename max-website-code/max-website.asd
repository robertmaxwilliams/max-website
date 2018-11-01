

(defsystem max-website
  :name "maxs-website"
  :serial nil
  :version "0.0.1"
  :maintainer "Max"
  :author "Max"
  :licence "The Bible"
  :description "a website. I made an asdf system so I could link to files"
  :depends-on ("hunchentoot" "cl-who" "cl-markdown" "asdf" "parenscript" "iterate"
                  "str" "uiop")
  :components ((:file "package")
               (:file "globals")
               (:file "utilities")
               (:file "page-templates")
               (:file "blog")
               (:file "max-website")
               (:file "pascals-triangle")
               (:file "url-funs")))


