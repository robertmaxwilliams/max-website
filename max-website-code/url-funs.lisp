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

(defun read-files (filenames)
  (loop for filename in filenames
       append (with-open-file (file-stream filename)
	 (loop until (not (listen file-stream))
	    collect (read file-stream nil '())))))

(define-url-fn (test-filereader)
    "just a test TODO remove"
  (format nil "<xmp>~s</xmp>" (read-files '("max-website-code/ex1.notlisp"
					    "max-website-code/ex2.notlisp"))))


(defun collect-defuns (filenames)
  " Returns list of pairs of (function-name (functions-it-calls1 ...))
Does not acknowledge lisp2, aka all symbols are fair game."
  (let* ((list-o-sexps (read-files filenames))
	 (flatfuns ;; lists of defuns by (name all other symbols flattened)
	  (remove nil (maplb (if (eql (car it) 'defun) (alexandria:flatten (cdr it)))
			     list-o-sexps)))
	 (fun-names ;; list of just the names
	  (maplb (car it) flatfuns)))
    ;; for each flatfun, produce a list containing its cdr with only fun-names members in it
    (mapfor (flatfun in flatfuns)
	    (list
	     (car flatfun)
	     (remove-if-not #'(lambda (sym) (member sym fun-names))
			    (remove-duplicates (cdr flatfun)))))))

(define-url-fn (test-collect-defuns)
    (format nil "<xmp>~s</xmp>"
	    (collect-defuns '("max-website-code/ex1.notlisp"
			      "max-website-code/ex2.notlisp") )))

(define-url-fn (dependency-graph)
    (format nil "~a" (collect-defuns '("max-website-code/max-website.lisp"))))

(defun alist-to-edges (list-alist)
  " Takes in list of (thing (other things)) to (thing other) (thing things) "
  (if list-alist (append (mapfor (to-item in (cadar list-alist)) (list (caar list-alist) to-item))
			 (alist-to-edges (cdr list-alist)))))


(defun function-graph-nodes-edges (filenames)
  (let ((graphguy (collect-defuns filenames)))
    (list
     (mapcar #'car graphguy)
     (alist-to-edges graphguy))))

(define-url-fn (test-function-graph-nodes-edges)
    (format nil "<xmp>~s</xmp>"
	    (function-graph-nodes-edges '("max-website-code/ex1.notlisp"
					  "max-website-code/ex2.notlisp"))))
  

(defun basic-vis-js ()
  (ps (var nodes (new ((@ vis *data-set)
		       (array
			(create id 1 label "Node 1")
			(create id 2 label "Node 2")
			(create id 3 label "Node 3")))))
      (var edges (new ((@ vis *data-set)
		       (array
			(create from 1 to 2)
			(create from 2 to 3)))))
      (var container ((@ document get-element-by-id) 'mynetwork))
      (var data (create nodes nodes edges edges))
      (var options (create))
      (var network (new ((@ vis *network) container data options)))))

(defun vis-nodes (nodes)
  `(array ,@(loop for node in nodes
	       collect `(create id ',node label ',node))))
(defun vis-edges (edges)
  `(array ,@(loop for from-to in edges
		 collect `(create from ',(car from-to) to ',(cadr from-to)))))

(defun vis-js-graph (nodes-edges)
  (ps* `(defvar nodes (new ((@ vis *data-set)
			  ,(vis-nodes (car nodes-edges)))))
	 `(defvar edges (new ((@ vis *data-set)
			  ,(vis-edges (cadr nodes-edges)))))
	 `(defvar container ((@ document get-element-by-id) 'mynetwork))
	 `(defvar data (create nodes nodes edges edges))
	 `(defvar options (create))
	 `(defvar network (new ((@ vis *network) container data options)))))

(define-url-fn (dependency-graph)
    "dependency graph of the main file of this website"
    (standard-page (:title "Vis Dot Jay Ess" :include-vis t)
	(:style :type "text/css"
			   "#mynetwork { width: 600px; height: 400px; border: 1px solid lightgray; }")
	(:h1 "I love these complex graphs!")
	(:div :id "mynetwork")
	(:script :type "text/javascript"
		 (str (vis-js-graph (function-graph-nodes-edges '("max-website-code/max-website.lisp")))))))


(define-url-fn (bigger-dependency-graph)
    "dependency graph of all lisp files of this website"
  (standard-page (:title "Vis Dot Jay Ess" :include-vis t)
		 (:style :type "text/css"
			 "#mynetwork { width: 600px; height: 400px; border: 1px solid lightgray; }")
		 (:h1 "I love these complex graphs!")
		 (:div :id "mynetwork")
		 (:script :type "text/javascript"
			  (str (vis-js-graph (function-graph-nodes-edges
					      '("max-website-code/max-website.lisp"
						"max-website-code/blog.lisp"
						"max-website-code/page-templates.lisp"
						"max-website-code/utilities.lisp"
						"max-website-code/pascals-triangle.lisp"
						"max-website-code/url-funs.lisp")))))))

(define-url-fn (vis-js-example)
    (standard-page (:title "Vis Dot Jay Ess" :include-vis t)
	(:style :type "text/css"
			   "#mynetwork { width: 600px; height: 400px; border: 1px solid lightgray; }")
	(:h1 "I love these squishy graphs!")
	(:div :id "mynetwork")
	(:script :type "text/javascript"
		 (str (basic-vis-js)))))
		 




