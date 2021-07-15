(in-package :max-website)

;; no idea where to put this but I wanted it on
(setf *show-lisp-errors-p* t)

;; set only at compile time, eval these forms to reset them
(defparameter *fun-dispatch-table* nil) ;; ex:  (create-prefix-dispatcher "/fun/hello" 'controller-hello)
(defparameter *fun-index* nil) ;; ex: ("hello" "this is a docstring")

;; also needs to be defined, default to t which means:
;; - port setting constrolled by this
;; - not sure what else, anything? I don't think so.
(defparameter *testing* t)

(defun set-path-globals-from-root (path)
  "set document root and all of the dir and file globals"
  (defparameter *document-root* path)
  (defparameter *blog-dir*
    (merge-pathnames #p"blog/" path))
  (defparameter *images-dir*
    (merge-pathnames #p"images/" path))
  (defparameter *files-dir*
    (merge-pathnames #p"files/" path))
  (defparameter *css-dir*
    (merge-pathnames #p"css/" path))
  (defparameter *favicon-file*
    (merge-pathnames #p"favicon.ico" path))
  (defparameter *principia-dir*
    (merge-pathnames #p"principia-discordia/book/" path)))

;; default value, set to reduce number of warnings.
;; should be set on call to start-website
;; followed by a call to set dispatch table
(defparameter *document-root* nil)
(defparameter *blog-dir* nil)
(defparameter *images-dir* nil)
(defparameter *files-dir* nil)
(defparameter *css-dir* nil)
(defparameter *favicon-file* nil)
(defparameter *principia-dir* nil)

