

(defsystem max-website
  :name "maxs-website"
  :version "0.0.0"
  :maintainer "Max"
  :author "Max"
  :licence "The Bible"
  :description "a website. I made an asdf system so I could link to files"
  :depends-on ("hunchentoot" "cl-who" "cl-markdown" "asdf" "parenscript" "iterate"
                  "str" "uiop")
  :components ((:file "package")
               (:file "config")
               (:file "utilities")
               (:file "blog")
               (:file "max-website"))
  )

