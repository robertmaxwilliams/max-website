;; including file names her


;; note that max-website.asd stores dependencies and ql:quickload :max-website
;;  loads them for us
;; load boatloadds of dependencies
;;(ql:quickload '(:hunchentoot :cl-who :cl-markdown :asdf :parenscript))
;;(ql:quickload :cl-who)
;;(ql:quickload :iterate)
;;(ql:quickload :str)
;;(ql:quickload :uiop)

;; define the package
(defpackage :max-website
  (:use :cl :cl-who :cl-markdown :hunchentoot :parenscript)
  (:export :start-website))

;;(in-package :max-website)

