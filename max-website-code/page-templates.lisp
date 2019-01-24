(in-package :max-website)

(defmacro standard-page ((&key title include-vis extra-style-sheets) &body body)
  ;; html-stream is available inside scope, use it (with-html-output (html-stream) (:p ...))
  ;; set include-vis to true to get vis.js from CDN
  `(with-html-output-to-string (html-stream nil :prologue t :indent t)
     (:html :xmlns "http://www.w3.org/1999/xhtml"
	    :xml\:lang "en"
	    :lang "en"
	    (:head
	     (:meta :http-equiv "Content-Type" 
		    :content    "text/html;charset=utf-8")
	     ,(if include-vis
		  `(:htm (:script
			  :type "text/javascript"
			  :src "https://cdnjs.cloudflare.com/ajax/libs/vis/4.21.0/vis.js")
			 (:link
			  :href "https://cdnjs.cloudflare.com/ajax/libs/vis/4.21.0/vis.css"
			  :rel "sylesheet"
			  :type "text/css")))
	     (:title ,title)
	     (:link :type "text/css"
		    :rel "stylesheet"
		    :href "/css/index.css")
	     ,(loop for filename in extra-style-sheets
		 collect `(:htm (:link
				 :type "text/css"
				 :rel "stylesheet"
				 :href ,filename)))
	     (:link :rel "shortcut icon"
		    :href "/favicon.ico?")
	    ;; org properties so messaging/social app previews are better
	     (:meta :name "description" :content "a website the takes the fun out of living...")
	     (:meta :property "og:site_name" :content "Max Williams website dot website")
	     (:meta :property "og:title" :content "Max Williams")
	     (:meta :property "og:description" :content "A website the takes the fun out of living...")
	     (:meta :property "og:image" :content "/images/site-home.png")
	     (:meta :property "og:url" :content "http://maxwilliams.us/")
	     (:meta :property "og:type" :content "blog"))

	    (:body
	     (:div :id "header"
		   (:a :class "headlink" :href "/" "HOME")
		   (:a "&middot;")
		   (:a :class "headlink" :href "/blog" "BLOG")
		   (:a "&middot;")
		   (:a :class "headlink" :href "/fun" "FUN")
		   (:a "&middot;")
		   (:a :class "headlink" :href "/about" "ABOUT")
		   (:br)
		   (:span :class "strapline"
			  "Max website dot website"))
	     ,@body))))

