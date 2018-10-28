(ql:quickload '(:hunchentoot :cl-who :cl-markdown :asdf :parenscript))
(ql:quickload :iterate)
(ql:quickload "str")
(ql:quickload "uiop")


(defpackage :website
  (:use :cl :cl-who :cl-markdown :hunchentoot :parenscript))
      
(in-package :website)

(defun start-server ()
  (make-instance 'hunchentoot:easy-acceptor :port 8080
		  :document-root #p"/Users/max/Repos/website/")
  (hunchentoot:start))
(setq *dispatch-table*
      (list
       ;;(create-regex-dispatcher "^/index" 'controller-index)
       (create-prefix-dispatcher "/blog" 'controller-blog)
       (create-prefix-dispatcher "/fun" 'controller-fun)
       (create-folder-dispatcher-and-handler "/images/" #p"/Users/max/Repos/website/images/")
       (create-folder-dispatcher-and-handler "/css/" #p"/Users/max/Repos/website/css/")
       (create-static-file-dispatcher-and-handler "/favicon.ico" "/Users/max/Repos/website/favicon.ico")
       (create-regex-dispatcher "^/$" 'controller-index) ;; order matters?? TF I don't udnerstand thita
       (create-regex-dispatcher "^/*" 'controller-404)
       (create-regex-dispatcher "^/hello" 'controller-hello)))

(defmacro standard-page ((&key title) &body body)
  `(with-html-output-to-string (*standard-output* nil :prologue t :indent t)
     (:html :xmlns "http://www.w3.org/1999/xhtml"
	    :xml\:lang "en"
	    :lang "en"
	    (:head
	     (:meta :http-equiv "Content-Type" 
		    :content    "text/html;charset=utf-8")
	     (:title ,title)
	     (:link :type "text/css"
		    :rel "stylesheet"
		    :href "/css/index.css"))

	    (:body
	     (:div :id "header"
		   (:a :class "headlink" :href "/" "HOME")
		   (:a "&middot;")
		   (:a :class "headlink" :href "/blog" "BLLLOOOOOGGGGG")
		   (:br)
		   (:span :class "strapline"
			  "Max website dot website"))
	     ,@body))))

(defun controller-index ()
 (standard-page (:title "Max Williams")
   (:h1 "Robert Max Williams")
   (:img :src "/images/face.jpg"
	 :alt "Max Williams"
	 :class "logo"
	 :style "center;")
   (:h1 "Current Stuff")
   (:p "Mostly wasting time and procrastintaing")
   (:h1 "Previous stuff")
   (:h2 "Optical Illusions Dataset")
   (:p "So I like collected data stuff")
   (:h2 "MAST-ML")
   (:p "Some sort of stuff with UWc")))
		;;;;(cl-who:str "<h1> AH
(create-regex-dispatcher "^/hello" 'controller-hello)))

(defun controller-hello ()
  "Hello there")

(defun controller-404 ()
  "FOUR TO THE OH TO THE FOUR ASSHOLE")

(defun controller-fun ()
  "fun stuff")

(defparameter *blog-dir* "/Users/max/Repos/website/blog/")
(defun bare-url-p (url) ;; check if the request uri is just /blog
  (< (length (str:split "/" url)) 3))

;; see blog.lsp for associated code
(defun controller-blog ()
  (if (bare-url-p (request-uri*))
      (blog-links-page)
      (db (pathname title) (blog-pathname-title (request-uri*))
	(standard-page (:title (str title))
	  (:h1 (str title))
	  (str (blog-page pathname))))))

;; This pipe dream made real, with macros! Now that's neat.
;; Pipe dream code is also called "wish code"
;; This macro is similar to define-easy-handler but auto-names the URL
(defmacro define-url-fn ((name) &body body)
  `(progn
     (defun ,name ()
       ,@body)
     (push (create-prefix-dispatcher ,(format nil "/~(~a~).htm" name) ',name)
	   *dispatch-table*)))
