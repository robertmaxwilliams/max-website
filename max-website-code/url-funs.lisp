(in-package :max-website)

(define-url-fn (hello)
  "This is the docstring"
  "hello world")

(define-url-fn (goodbye)
  "this kills the server!"
  "goodbye moon")

(define-url-fn (pascal)
  "Pascal triangle, big-big"
  (standard-page (:title "Fun!")
    (:h1 "Pascal's triangle, left-justified, with odds colored pink")
    (loop for n in '(5 10 20 50 100)
       do (htm (:a :class "button" :href (format nil "/fun/pascal?n=~A" n) (str (format nil "n=~a" n)))))

    (2d-table-from-list html-stream (n-iterations-pascal-triangle (parse-integer (default-value "5" (parameter "n")))))))

(define-url-fn (update-server)
  "dies so the run script does a git pull and runs the server again"
  (cl-user::exit) ;; todo why do I have to use cl-user?
  "this should not be seen because the server was supposed to exit")

(define-url-fn (dont-run-this)
  "just kidding please run it"
  "hi 234923809")

;; some parenscript fun
(define-url-fn (parenscript-hello)
    "from the parenscript tutorial"
    (with-html-output-to-string (s)
      (:html
       (:head
	(:title "Parenscript tutorial: 2nd example")
	(:script :type "text/javascript"
		 (str (ps
			(defun greeting-callback ()
			  (alert "Hello World"))))))
       (:body
	(:h2 "Parenscript tutorial: 2nd example")
	(:a :href "" :onclick (ps (greeting-callback))
	    "Hello World")))))


;; vis js is fun, too!
(define-url-fn (dependency-graph)
    "dependency graph of the main file of this website"
    (standard-page (:title "Vis Dot Jay Ess" :include-vis t)
	(:style :type "text/css"
			   "#mynetwork { width: 600px; height: 400px; border: 1px solid lightgray; }")
	(:h1 "vis.js is fun ;)")
	(:div :id "mynetwork")
	(:script :type "text/javascript"
		 (str (vis-js-graph (function-graph-nodes-edges '("max-website-code/max-website.lisp")))))))

(define-url-fn (website-dependency-graph)
    "dependency graph of all lisp files of this website"
  (standard-page (:title "Vis Dot Jay Ess" :include-vis t)
		 (:style :type "text/css"
			 "#mynetwork { width: 600px; height: 400px; border: 1px solid lightgray; }")
		 (:h1 "This website's dependency graph")
		 (:p "All defun and defmacros are nodes, arrows indicate dependency.")
		 (:div :id "mynetwork")
		 (:script :type "text/javascript"
			  (str (vis-js-graph (function-graph-nodes-edges
					      '("max-website-code/max-website.lisp"
						"max-website-code/blog.lisp"
						"max-website-code/page-templates.lisp"
						"max-website-code/utilities.lisp"
						"max-website-code/pascals-triangle.lisp"
						"max-website-code/url-funs.lisp")))))))




