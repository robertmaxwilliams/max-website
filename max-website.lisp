(in-package :max-website)


(defun start-website ()
  (hunchentoot:start (make-instance 'hunchentoot:easy-acceptor :port 8080
                                    :document-root *document-root*)))


;;(db (a b) (3 2) (+ a b))

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

;; returns list of (pathname title)
(defun blog-pathname-title (uri)
  (let* ((blog-name (car (last (str:split "/" uri))))
	(file-pathname (merge-pathnames (pathname (str:concat blog-name ".md")) *blog-dir*)))
    (list file-pathname 
	  (car (blog-title-and-preview file-pathname)))))

(defun blog-page (pathname)
  (with-open-file (stream pathname)
    (progn
      (unused (take-n-lines stream 4))
      (second-value (markdown (stream-get-contents stream) :stream nil)))))

; takes in filepath, returns (title preview)
(defun blog-title-and-preview (pathname) ;; 
  (with-open-file (stream pathname) 
    (db (dashes1 layout-line title-line dashes2) (take-n-lines stream 4)
      (if (and (string-equal dashes1 "---")
	       (string-equal layout-line "layout: post")
	       (string-equal dashes2 "---"))
	  (list (str:trim (cadr (str:split ":" title-line))) (generate-preview stream))
	  '("badbadbad")))))

; returns lists of (pathname name title preview)
(defun blog-files ()
  (remove-if #'null (mapcar #'(lambda (pathname)
				(let ((namestring (file-namestring pathname)))
				  (if (str:ends-with-p ".md" namestring)
				      (append (list namestring (str:substring 0 -3 namestring))
					    (blog-title-and-preview pathname)))))
			    (uiop:directory-files *blog-dir*))))

;; takes in markdown string and converts to html preview
(defun generate-preview (stream)
  (str:concat (str:trim (str:substring 0 200 (second-value (markdown (str:join " " (take-n-lines stream 5)) :stream nil)))) "..."))

(defun blog-links-page ()
  (standard-page (:title "Blog index")
    (:h3 "Blog posts:")
    (loop for pathname-name-title-preview in (blog-files)
       do (db (garbage name title preview) pathname-name-title-preview
	    (unused garbage)
	    (htm (:h3 (:p (:a :href (str (str:join "" (list "/blog/" name))) (str title))))
		 (:p (str preview)))))))

;; This pipe dream made real, with macros! Now that's neat.
;; Pipe dream code is also called "wish code"
;; This macro is similar to define-easy-handler but auto-names the URL
;;(defmacro define-url-fn ((name) &body body)
;;  `(progn
;;     (defun ,name ()
;;       ,@body)
;;     (push (create-prefix-dispatcher ,(format nil "/~(~a~).htm" name) ',name)
;;	   *dispatch-table*)))
