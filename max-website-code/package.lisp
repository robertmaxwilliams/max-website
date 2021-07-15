;; define the package
(defpackage :max-website
  (:use :cl :cl-who :cl-markdown :hunchentoot :parenscript)
  (:export :start-website))

;; Note that max-website.asd stores dependencies and ql:quickload :max-website loads them for us,
;; so only for rare cases should you be messing around in this file.

;; Interactive only: uncomment and run to get dependencies.
;;(ql:quickload '(:hunchentoot :cl-who :cl-markdown :asdf :parenscript))
;;(ql:quickload :cl-who)
;;(ql:quickload :iterate)
;;(ql:quickload :str)
;;(ql:quickload :uiop)

;; Interactive only: now you can use the package!
;;(in-package :max-website)
