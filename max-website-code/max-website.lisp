(in-package :max-website)


;; call when *document-root* changes
(defun set-global-config ()
  (defparameter *blog-dir* 
    (merge-pathnames #p"blog/" *document-root*))
  (defparameter *images-dir* 
    (merge-pathnames #p"images/" *document-root*))
  (defparameter *css-dir* 
    (merge-pathnames #p"css/" *document-root*))
  (defparameter *favicon-file*
    (merge-pathnames #p"favicon.ico" *document-root*))
  (format t "Dirs: ~A~% ~A~% ~A~% ~A~%" *blog-dir* *images-dir* *css-dir* *favicon-file*))


;; default value, set to reduce number of warnings.
;; should be set on call to start-website
;; followed by a call to set dispatch table
(defparameter *document-root* #p"/maybe/i/should/have/been/a/baker/")
(set-global-config)

(defun start-website (document-root)
  (defparameter *document-root* (pathname document-root))
  (set-global-config)
  (set-dispatch-table) ;; this cost me hours of frustation to realize
  (hunchentoot:start (make-instance 'hunchentoot:easy-acceptor :port 8080
                                    :document-root *document-root*)))

(defun set-dispatch-table ()
  (setq *dispatch-table*
	(list
	  ;;(create-regex-dispatcher "^/index" 'controller-index)
	  (create-prefix-dispatcher "/blog" 'controller-blog)
	  (create-prefix-dispatcher "/fun" 'controller-fun)
	  (create-folder-dispatcher-and-handler "/images/" *images-dir*)
	  (create-folder-dispatcher-and-handler "/css/" *css-dir*)
	  (create-static-file-dispatcher-and-handler "/favicon.ico" *favicon-file*)
	  (create-regex-dispatcher "^/$" 'controller-index) ;; order matters?? TF I don't udnerstand thita
	  (create-regex-dispatcher "^/*" 'controller-404)
	  (create-regex-dispatcher "^/hello" 'controller-hello))))

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
		    :href "/css/index.css")
	     (:link :rel "shortcut icon"
                :href "/favicon.ico?"))
	    ;; org properties so messaging/social app previews are better
	    (:meta :property "og:site_name" :content "Max Williams website dot website")
	    (:meta :property "og:title" :content "Max Williams")
	    (:meta :property "og:description" :content "A website the takes the fun out of living...")
	    (:meta :property "og:image" :content "/images/site-home.png")
	    (:meta :property "og:url" :content "http://maxwilliams.us/")
	    (:meta :property "og:type" :content "blog")

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

(defun controller-hello ()
  "Hello there")

(defun controller-404 ()
  "FOUR TO THE OH TO THE FOUR ASSHOLE")

(defun controller-fun ()
  "fun stuff")

(defun bare-url-p (url) ;; check if the request uri is just /blog
  (< (length (str:split "/" url)) 3))

(defun controller-blog ()
  (if (bare-url-p (request-uri*))
      (blog-links-page)
      (db (pathname title) (blog-pathname-title (request-uri*))
	(standard-page (:title (str title))
	  (:h1 (str title))
	  (str (blog-page pathname))))))

;;what is this doing here;; eg 2018-1-9-Adversarial-Examples

;; takes in markdown string and converts to html preview
(defun generate-preview (stream)
  (str:concat (str:trim (str:substring 0 200 (second-value (markdown (str:join " " (take-n-lines stream 5)) :stream nil)))) "..."))


;; This pipe dream made real, with macros! Now that's neat.
;; Pipe dream code is also called "wish code"
;; This macro is similar to define-easy-handler but auto-names the URL
;;(defmacro define-url-fn ((name) &body body)
;;  `(progn
;;     (defun ,name ()
;;       ,@body)
;;     (push (create-prefix-dispatcher ,(format nil "/~(~a~).htm" name) ',name)
;;	   *dispatch-table*)))
