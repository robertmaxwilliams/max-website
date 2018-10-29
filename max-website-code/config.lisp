;; modify this file to change document root and such
(in-package :max-website)

(defparameter *document-root* #p"/Users/max/Repos/website/")

(defparameter *blog-dir* 
  (merge-pathnames #p"blog/" *document-root*))

(defparameter *images-dir* 
  (merge-pathnames #p"images/" *document-root*))

(defparameter *css-dir* 
  (merge-pathnames #p"css/" *document-root*))

(defparameter *favicon-file*
  (merge-pathnames #p"favicon.ico" *document-root*))
