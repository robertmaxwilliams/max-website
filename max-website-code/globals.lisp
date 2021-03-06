(in-package :max-website)

;; no idea where to put this but I wanted it on
(setf *show-lisp-errors-p* t)



;; set only at compile time, eval these forms to reset them
(defparameter *fun-dispatch-table* nil) ;; ex:  (create-prefix-dispatcher "/fun/hello" 'controller-hello)
(defparameter *fun-index* nil) ;; ex: ("hello" "this is a docstring")

;;also needs to be defined, default to t which means ssl dir not served
(defparameter *testing* t)


;; call when *document-root* changes
(defun set-global-config ()
  (defparameter *blog-dir* 
    (merge-pathnames #p"blog/" *document-root*))
  (defparameter *images-dir* 
    (merge-pathnames #p"images/" *document-root*))
  (defparameter *files-dir* 
    (merge-pathnames #p"files/" *document-root*))
  (defparameter *css-dir* 
    (merge-pathnames #p"css/" *document-root*))
  (defparameter *favicon-file*
    (merge-pathnames #p"favicon.ico" *document-root*))
  (defparameter *principia-dir* 
    (merge-pathnames #p"principia-discordia/book/" *document-root*))
  (format t "Dirs: ~A~% ~A~% ~A~% ~A~% ~A~%" *blog-dir* *images-dir* *css-dir* *favicon-file* *files-dir*))


;; default value, set to reduce number of warnings.
;; should be set on call to start-website
;; followed by a call to set dispatch table
(defparameter *document-root* #p"/maybe/i/should/have/been/a/baker/")
(set-global-config)

