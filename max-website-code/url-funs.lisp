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


(define-url-fn (negative-pascal)
  "Pascal triangle, with the SECRET negative part"
  (let ((parameter-n (safety-cap 1000  5 (parse-integer (default-value "5" (parameter "n"))))))
    (standard-page (:title "||SECRET||")
      (:h1 "What math people don't want you to know")
      (loop for button-n in '(5 10 20 50 100)
	 do (htm (:a :class "button" :href (format nil "/fun/negative-pascal?n=~A" button-n)
		     (str (format nil "n=~a" button-n)))))
      (2d-table-from-array html-stream (array-pascal parameter-n)))))

(defmacro number-table-row (number-strings)
  "takes a list of strings and makes a <tr> for them"
  `(htm 
   (:tr
    :align "right"
    (loop for x in ,number-strings
	 do (htm (:td :class "blackborder" (:pre (str x))))))))


(defmacro base-table (ls)
  "html table of each element of the list"
  `(htm (:table
	 :class "numbertable"
	 :border 0 :cellpadding 0
	 (number-table-row '("base 10" "base 2" "base 3"))
	 (dolist (x ,ls)
	   (number-table-row (list (write-to-string x :base 10)
				   (write-to-string x :base  2)
				   (write-to-string x :base  3)))))))

(defun recur-until (fun cur-val end-val)
  " trivial consing recur on numeric function until reaches end val"
  (let ((next (funcall fun cur-val)))
    (if (= next end-val)
	(list cur-val next)
	(cons cur-val (recur-until fun next end-val)))))

;; example:
(recur-until #'1+ 1 4)

(defmacro simple-form (url variable-name default-value)
  "form that sends a single variable (input as a STRING) to a url by GET"
  `(htm (:form :action ,url
	  (:input :type "text" :name ,variable-name :value (str (format nil "~a" ,default-value)))
	  (:input :type "submit" :value "Go"))))

(define-url-fn (collatz-bases)
  "Find collatz sequence of a number"
  (let ((parameter-n (default-value 5
			 (parse-integer (default-value "" (parameter "n")) :junk-allowed t))))
    (standard-page (:title "Collatz")
      (:h2 "Take the collatz of any sequence")
      (simple-form *my-url "n" parameter-n)
      (:a :class "button" :href (format nil "~a?n=~a" *my-url (1+ (random 500))) "random")
      (:h1 (str (format nil "Collatz of ~a" parameter-n)))
      (base-table
       (recur-until #'next-collatz parameter-n 1)))))

(define-url-fn (shortcut-collatz-bases)
  "Find collatz sequence of a number using the powers of two shortcut"
  (let ((parameter-n (default-value 5
			 (parse-integer (default-value "" (parameter "n")) :junk-allowed t))))
    (standard-page (:title "Collatz")
      (:h2 "Take the shortcut collatz of any sequence")
      (:p "Shortcut collatz takes in an odd number and calculates " :code "(3n+1)/(2^x)"
	  " where 2^x is chosen to make the output odd.")
      (simple-form *my-url "n" parameter-n)
      (:h1 (str (format nil "Collatz of ~a" parameter-n)))
      (base-table
       (recur-until #'shortcut-collatz parameter-n 1)))))

(define-url-fn (update-server)
  "dies so the run script does a git pull and runs the server again"
  (cl-user::exit) ;; todo why do I have to use cl-user?
  "this should not be seen because the server was supposed to exit")

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


;;;; vis js is fun, too!
;;(define-url-fn (dependency-graph)
;;    "dependency graph of the main file of this website"
;;    (standard-page (:title "Vis Dot Jay Ess" :include-vis t)
;;	(:style :type "text/css"
;;			   "#mynetwork { width: 600px; height: 400px; border: 1px solid lightgray; }")
;;	(:h1 "vis.js is fun ;)")
;;	(:div :id "mynetwork")
;;	(:script :type "text/javascript"
;;		 (str (vis-js-graph (function-graph-nodes-edges '("max-website-code/max-website.lisp")))))))

(define-url-fn (website-dependency-graph)
    "dependency graph of all lisp files of this website"
  (standard-page (:title "Vis Dot Jay Ess" :include-vis t)
		 (:style :type "text/css"
			 "#mynetwork { width: auto; height: 400px; border: 1px solid lightgray; }")
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




(define-url-fn (collatz-graph)
  "graph of how all numbers lead back to unity"
  (standard-page (:title "Collatz Graph" :include-vis t)
		 (:style :type "text/css"
			 "#mynetwork { width: auto; height: 400px; border: 1px solid lightgray; }")
		 (:h1 "Collatz Graph")
		 (:p "Explanation goes here")
		 (:button :onclick "explodeLeaves()" "Explode Leaves")
		 (:div :id "mynetwork")
		 (:script :type "text/javascript"
			  (str (vis-js-graph '((1 2 4) ((2 1) (4 2) (1 4)))))
			  (str (vis-js-inverse-collatz))
			  
			  (str
			   (ps
			     ((@ *network* on)
			      "click"
			      (lambda (params) (add-inverses-to-graph
						(aref (@ params 'nodes) 0)))))))))


(define-url-fn (minsky-register-machine-sim)
    "probably a vunerability"
    (let* ((codestring (str:trim (default-value "inc 0" (parameter "code"))))
           (datastring (str:trim (default-value "0 0 0 0" (parameter "data"))))
	   (foo (format t "~%~%CODE FROM USER WATCH OUT ~%~a ~%~%" codestring)) ;;debug print
	   (output-array (read-eval-mrm datastring codestring))
	   (oa-as-string (format nil "~a" output-array)))
      (standard-page (:title "Minsky Machine")
	(:h1 "Minsky Register Machine Simulator")
	(htm (markdown "
## How To Use This Machine

This machine has two parts: an array of integers (the memory) 
and a list of instructions (the code)

This machine only has two instructions: `inc` and `branch`. They take the following arguments:

`inc <memory index>` will increment the integer at that memory cell

`branch <memory index> <codepoint a> <codepoint b>` will first check if the integer at `<memory index>`
is greater than zero. If it is, it decrements that integer and jumps to `<codepoint a>`. Otherwise, it
jumps to `<codepoint b>` without decrementing the memory cell's value.

Examples (the first line goes in the data input box, the rest goes in the line numbered code box:
TODO handle nils correctly

    0 0 1 0

    inc 0

result: `#(1 0 1 0)`

    0 0 0 1 0

    inc 0
    inc 1
    branch 0 4 5
    inc 0
    inc 0
    inc 0

result: `#(2 1 0 1 0)`



" :stream html-stream))
	(:br) (:br)
	(:p :id "output" "Output: " (:br) (str oa-as-string))
	(:form :action (str (format nil "~a#~a" *my-url "output")) :method "post" :id "codeform"
	       (:input :type "submit" :value "Go")
	       (:br)
	       (:input :type "text" :name "data" :value (str datastring))
	       (:br)
	       (:textarea :cols 50 :rows 100 :name "code" (str codestring))))))
