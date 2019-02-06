;; for intereactive session ONLY
;;(ql:quickload :max-website)
;;(in-package :max-website)
;;(start-website "/Users/max/Repos/website/")
;;
(in-package :max-website)

(defun start-website (document-root is-testing)
  (print *fun-index*)
  (defparameter *document-root* (pathname document-root))
  (defparameter *testing* is-testing)
  (set-global-config)
  (set-dispatch-table) ;; this cost me hours of frustation to realize
  (print *fun-index*)
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
	  (create-prefix-dispatcher "/about" 'controller-about)
	  (create-regex-dispatcher "^/fun/*" 'controller-404)
	  (create-folder-dispatcher-and-handler "/.well-known/acme-challenge/" 
                                            "/home/private/.dehydrated/") ;; for dehydrated client
	  (create-folder-dispatcher-and-handler "/images/" *images-dir*)
	  (create-folder-dispatcher-and-handler "/files/" *files-dir*)
	  (create-regex-dispatcher "^/principia-discordia/$" 'redirect-page-1)
	  (create-regex-dispatcher "^/principia-discordia$" 'redirect-page-1)
	  (create-folder-dispatcher-and-handler "/principia-discordia/" *principia-dir*)
	  (create-folder-dispatcher-and-handler "/css/" *css-dir*)
	  (create-static-file-dispatcher-and-handler "/favicon.ico" *favicon-file*)
	  (create-regex-dispatcher "^/$" 'controller-index) ;; order matters?? TF I don't udnerstand thita
	  (create-regex-dispatcher "^/*" 'controller-404)
	  (create-regex-dispatcher "^/hello" 'controller-hello))
	 (if (not *testing*) ;; optionally included Let's Encrypt challenge dir on real server
	   (create-folder-dispatcher-and-handler "/.well-known/" "/home/public/.well-known/")))))

(defun redirect-page-1 ()
  "rediercting to page 1"
  (standard-page (:title "The Principia According to Huneker")
    (:h1 "YOU HAVE BEEN CHEATED AND LIED TO")
    (:a :href "/principia-discordia/1.html" "TO THE BOOK")))

(defun remove-alist-duplicate-string-keys (alist)
  (delete-duplicates alist :test #'string-equal :key #'car :from-end t))

;; todo refaactor html-stream to use half-earmuff

(defmacro define-url-fn ((name) &body body)
  "Call like this: (define-url-fn (foo) \"some docstring\" (string 'bar))
defines the function, pushes it into *fun-dispatch-table* and *fun-index* then
recompiles *dispatch-table*."
  (let ((url (format nil "/fun/~(~a~)" name)))
    `(progn
       (let ((*my-url ,url)) ;; wrapping in let to make *my-url available
	 (declare (ignorable *my-url));;to get rid of warning when not used, which is usualy
	 (defun ,name ()
	   ,@body))
       (push (create-prefix-dispatcher ,url ',name)
	     *fun-dispatch-table*)
       (push (list (string-downcase (string ',name)) (documentation #',name t))
	     *fun-index*)
       (remove-alist-duplicate-string-keys *fun-index*)
       (set-dispatch-table))))

(defun controller-index ()
 (standard-page (:title "Max Williams")
   (:h1 "Robert Max Williams")
   (:img :src "/images/face.jpg"
	 :alt "Max Williams"
	 :class "logo"
	 :style "center;")
   (markdown (truename #p"bio.md") :stream html-stream)))

(defun controller-about ()
 (standard-page (:title "About")
   (:h1 "How did this website?")
   (:img :src "/images/lisplogo_fancy_trans_256.png"
	 :alt "Lisp Alien, credit to Conrad Barski"
	 :style "center; height: 150px")
   (markdown (truename #p"about.md") :stream html-stream)))


(defun controller-hello ()
  "Hello there")

(defun controller-404 ()
  "<h1>Error: Page not found (404) </h1>")

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
