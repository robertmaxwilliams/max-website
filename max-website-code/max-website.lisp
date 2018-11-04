;; for intereactive session ONLY
;;(ql:quickload :max-website)
;;(in-package :max-website)
;;(start-website "/Users/max/Repos/website/")
;;
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
(defparameter *fun-dispatch-table* nil) ;; ex:  (create-prefix-dispatcher "/fun/hello" 'controller-hello)
(defparameter *fun-index* nil) ;; ex: ("hello" "this is a docstring")

(defun start-website (document-root)
  (defparameter *document-root* (pathname document-root))
  (set-global-config)
  (set-dispatch-table) ;; this cost me hours of frustation to realize
  (hunchentoot:start (make-instance 'hunchentoot:easy-acceptor :port 8080
                                    :document-root *document-root*)))

(defun set-dispatch-table ()
  "Sets hunchentoot's dispatch table. Notice prepending *fun-dispatch-table*, it is dynamically generated by
calls to define-url-fn"
  (setq *dispatch-table*
	(append
	 *fun-dispatch-table*
	 (list
	  ;;(create-regex-dispatcher "^/index" 'controller-index)
	  (create-regex-dispatcher "^/blog$" 'controller-blog)
	  (create-regex-dispatcher "^/blog/*" 'controller-blog-a-blog)
	  (create-prefix-dispatcher "/fun" 'controller-fun)
	  (create-regex-dispatcher "^/fun/*" 'controller-404)
	  (create-folder-dispatcher-and-handler "/images/" *images-dir*)
	  (create-folder-dispatcher-and-handler "/css/" *css-dir*)
	  (create-static-file-dispatcher-and-handler "/favicon.ico" *favicon-file*)
	  (create-regex-dispatcher "^/$" 'controller-index) ;; order matters?? TF I don't udnerstand thita
	  (create-regex-dispatcher "^/*" 'controller-404)
	  (create-regex-dispatcher "^/hello" 'controller-hello)))))


(defun remove-alist-duplicate-string-keys (alist)
  (delete-duplicates alist :test #'string-equal :key #'car :from-end t))

(defmacro define-url-fn ((name) &body body)
  "Call like this: (define-url-fn (foo) \"some docstring\" (string 'bar))
defines the function, pushes it into *fun-dispatch-table* and *fun-index* then
recompiles *dispatch-table*."
  `(progn
     (defun ,name ()
       ,@body)
     (push (create-prefix-dispatcher ,(format nil "/fun/~(~a~)" name) ',name)
	   *fun-dispatch-table*)
     (push (list (string-downcase (string ',name)) (documentation #',name t))
	   *fun-index*)
     (remove-alist-duplicate-string-keys *fun-index*)
     (set-dispatch-table)))


(defun controller-index ()
 (standard-page (:title "Max Williams")
   (:h1 "Robert Max Williams")
   (:img :src "/images/face.jpg"
	 :alt "Max Williams"
	 :class "logo"
	 :style "center;")
   (markdown #p"bio.md" :stream html-stream)))

(defun controller-hello ()
  "Hello there")

(defun controller-404 ()
  "<h1>FOUR TO THE OH TO THE FOUR</h1>")

;; s is the html stream
(defun describe-fun-index (s)
  (with-html-output (s nil :indent t)
    (loop for name-docstring in *fun-index*
       do (db (name docstring) name-docstring
	    (htm (:h3 :class "nobottommargins" (:a :href (format nil "/fun/~A" name) (str name))) (str docstring))))))
;;(with-html-output-to-string (s) (describe-fun-index s))
	       
(defun controller-fun ()
  (standard-page (:title "have fun!")
    (:h2 "Some fun examples of what is has to:")
    (describe-fun-index html-stream)))

;; here as example code
(defun checkbox (stream name checked &optional value)
    (with-html-output (stream)
      (:input :type "checkbox" :name name :checked checked :value value)))

(defun controller-blog ()
  (standard-page (:title "Blog index")
    (:h3 "Blog posts:")
    (loop for pathname-name-title-preview in (blog-files)
       do (db (pathname name title preview) pathname-name-title-preview
	    (unused pathname)
	    (htm (:h3 :class "nobottommargins" (:a :href (str:join "" (list "/blog/" name))
			  (str title)))
		 (str (str:join "-" (blog-name-date-extractor name)))
		 (:p (str preview)))))))

(defun controller-blog-a-blog ()
  (db (pathname title) (blog-pathname-title (request-uri*))
    (standard-page (:title (str title))
      (:h1 (str title))
      (str (blog-page pathname)))))
