(defsystem banana-grams
  :name "banana-grams"
  :serial t ;; makes sure each file depends on the other in series
  ;; and force recompile of everything if, for instance, a page template macro changes.
  :version "0.0.1"
  :maintainer "Max"
  :author "Max"
  :licence "The Bible"
  :description "A bananagrams AI that can peel in ~3 seconds for easy boards"
  :depends-on ("asdf" "str" "alexandria" "iterate" "cl-ppcre" "prove" "cl-slice")
  :components ((:file "package")
	       (:static-file "1-1000.txt")
               (:file "banana-grams")))
