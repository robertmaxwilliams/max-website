(in-package :max-website)

(defmacro standard-page ((&key title) &body body)
  ;; html-stream is available inside scope, use it (with-html-output (html-stream) (:p ...))
  `(with-html-output-to-string (html-stream nil :prologue t :indent t)
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
		   (:br)
		   (:span :class "strapline"
			  "Max website dot website"))
	     ,@body))))

