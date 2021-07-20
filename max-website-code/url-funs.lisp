(in-package :max-website)


(define-url-fn (pascal :title "Pascal's Triangle")
  "Standard Pascal Triangle, very large sizes available."
  (standard-page (:title "Fun!")
    (:h1 "Pascals Triangle")
    (:p "This is Pascal's Triangle, left justified in order to fit nicely into a table. Odd numbers are colored pink to show the pattern they form.")
    (loop for n in '(5 10 20 50 100)
          do (link-button html-stream
                          (format nil "/fun/pascal?n=~A" n)
                          (format nil "n=~a" n)))
    (2d-table-from-list html-stream (n-iterations-pascal-triangle (parse-integer (default-value "5" (parameter "n")))))))

(defun link-button (stream link text)
    (with-html-output (stream)
      (:form :style "display: inline-block;" :method "POST" :action link (:button :type "submit" (str text)))))


;; <form>
;;   <button type="submit" formaction="https://www.freecodecamp.org/">freeCodeCamp</button>
;; </form>

(define-url-fn (negative-pascal :title "Negative Pascal's Triangle")
  "Pascal triangle, with the SECRET negative part."
  (let ((parameter-n (safety-cap 1000  5 (parse-integer (default-value "5" (parameter "n"))))))
    (standard-page (:title "||SECRET||")
     (:h1 "Negative Pascals Triangle")
     (:p "By making a few assumptions, we can work Pascal's triangle backwards and get some mathy-nonsense (or perhaps it does make sense?)")
     (:p "\"What math people don't want you to know\"")
     (loop for button-n in '(5 10 20 50 100)
	 do (link-button html-stream
                     (format nil "/fun/negative-pascal?n=~A" button-n)
                     (format nil "n=~a" button-n)))
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

(defmacro simple-form (url variable-name default-value)
  "form that sends a single variable (input as a STRING) to a url by GET"
  `(htm (:form :action ,url
	  (:input :type "text" :name ,variable-name :value (str (format nil "~a" ,default-value)))
	  (:input :type "submit" :value "Go"))))

(defun next-collatz (n)
  (if (evenp n)
      (/ n 2)
      (+ 1 (* 3 n))))

(defun recur-until (fun cur-val end-val)
  " trivial consing recur on numeric function until reaches end val"
  (let ((next (funcall fun cur-val)))
    (if (= next end-val)
	(list cur-val next)
	(cons cur-val (recur-until fun next end-val)))))

(define-url-fn (collatz-bases :title "Collatz")
  "Find collatz sequence of a number."
  (let ((parameter-n (default-value 5
			 (parse-integer (default-value "" (parameter "n")) :junk-allowed t))))
    (standard-page (:title "Collatz")
      (:h2 "Collatz")
      (:p "Show the Collatz sequence from any number back down to 1.")
      (simple-form *my-url "n" parameter-n)
      (link-button html-stream (format nil "~a?n=~a" *my-url (1+ (random 500))) "random")
      (:h1 (str (format nil "Collatz of ~a" parameter-n)))
      (base-table
       (recur-until #'next-collatz parameter-n 1)))))

(defun oddiate (n)
  "divide n by two until odd"
  (if (oddp n)
      n
      (oddiate (/ n 2))))

(defun shortcut-collatz (n)
  "divides by 2 until odd, then return 3n+1"
  (oddiate (+ 1 (* 3 (oddiate n)))))

(define-url-fn (shortcut-collatz-bases :is-unlisted t)
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


(define-url-fn (collatz-graph :title "The Collatz Web")
  "Graph of reverse Collatz, showing some of its structure."
  (standard-page (:title "Collatz Graph" :include-vis t)
		 (:style :type "text/css"
			 "#mynetwork { width: auto; height: 400px; border: 1px solid lightgray; }")
		 (:h1 "The Collatz Web")
		 (:p "Hit \"Explode Leaves\" to see the structure of the Collatz Web.")
         (:p "If the Collatz Conjecture is correct, all natural numbers will appear eventually in the graph.")
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


(define-url-fn (update-server :is-unlisted t)
  "dies so the run script does a git pull and runs the server again"
  (cl-user::exit) ;; todo why do I have to use cl-user?
  "This should not be seen because the server was supposed to exit. Good job if you're reading this.")

(define-url-fn (website-dependency-graph :title "Website Dependency Graph")
    "Function dependency graph of all lisp files of this website."
  (standard-page (:title "Dependency Graph" :include-vis t)
		 (:style :type "text/css"
			 "#mynetwork { border: 1px solid lightgray; }")
         (:h1 "Dependency Graph")
		 (:p "This website's dependency graph, rendered using vis.js")
		 (:p "All defun and defmacros (function and macro definitions) are nodes, arrows indicate dependency.")
		 (:p "Loading may take a few seconds.")
         (:button :id "closefullscreen" :class "float-top-left" :style "display: none;" :onclick
                  "mynetwork.className = \"not-full-size\";
          closefullscreen.style.display = \"none\";"
                  (str "Click To Exit Fullscreen"))
         (:button :onclick "mynetwork.className = \"full-size\";
          closefullscreen.style.display = \"block\";"
                  (str "Click For Full Screen"))
		 (:div :class "not-full-size" :id "mynetwork")
		 (:script :type "text/javascript"
			  (str (vis-js-graph (function-graph-nodes-edges
					      '("max-website-code/blog.lisp"
                            "max-website-code/color-test.lisp"
                            "max-website-code/globals.lisp"
                            "max-website-code/max-website.lisp"
                            "max-website-code/page-templates.lisp"
                            "max-website-code/pascals-triangle.lisp"
                            "max-website-code/tubes-game.lisp"
                            "max-website-code/undecide.lisp"
                            "max-website-code/url-funs.lisp"
                            "max-website-code/utilities.lisp"
                            "max-website-code/visjs-helpers.lisp"
						)))))))

(define-url-fn (minsky-register-machine-sim :title "Minsky Register Machine Simulator")
    "Run code on the simplest virtual machine ever made."
    (let* ((codestring (str:trim (default-value "inc 0" (parameter "code"))))
           (datastring (str:trim (default-value "0 0 0 0" (parameter "data"))))
	   (foo (format t "~%~%CODE FROM USER WATCH OUT ~%~a ~%~%" codestring)) ;;debug print
	   (output-array (read-eval-mrm datastring codestring))
	   (oa-as-string (format nil "~a" output-array)))
      (standard-page (:title "Minsky Machine")
	(:h1 "Minsky Register Machine Simulator")
    ;; TODO move this markdown to an external file
	(htm (markdown "
## How To Use This Machine

This machine has two parts: an array of integers (the memory)
and a list of instructions (the code)

This machine only has two instructions: `inc` and `branch`. They take the following arguments:

`inc <memory index>` will increment the integer at that memory cell

`branch <memory index> <codepoint a> <codepoint b>` will first check if the integer at `<memory index>`
is greater than zero. If it is, it decrements that integer and jumps to `<codepoint a>`. Otherwise, it
jumps to `<codepoint b>` without decrementing the memory cell's value.

Examples (the first line goes in the data input box, the rest goes in the line numbered code box):
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

(define-url-fn (banana-gram-solver :title "Banagram Solver")
  "Shows you how to arrange letters to win scrabble-style game, \"Bananagrams\"."
  (let ((parameter-letters (default-value nil (parameter "letters"))))
    (standard-page (:title "Banana Gram Solver")
      (:h1 "Enter all the letters you have, not spaces, case doesn't matter.")
      (str "scroll down if you don't see anything")
      (simple-form *my-url "letters" (default-value "dogf" parameter-letters))
      (htm
       (if parameter-letters
	   (if (find-package :banana-grams)
	       (let ((output-list (banana-grams:peel parameter-letters 1 10000)))
		 (if output-list
		     (2d-table-from-array html-stream (car output-list) nil)
		     (htm (:h1 "no solution found"))))
	       (htm (:h1 "banana grams no loaded. Contact dev.")))
	   (htm (:h1 "no letters supplied")))))))

(define-url-fn (tubes-game :title "Tubes Game")
  "Drag-and-drop alchemy game with developer art."
  (standard-page (:title "Tubes Game"
                         :extra-style-sheets (list "/css/tubes.css")
                         :draggable-viewport nil)
    (:h1 "Drag things into tube to get more things. Win by getting all 19 objects.")
    (:script :type "text/javascript" (str (tubes-js)))))

(define-url-fn (color-test :is-unlisted t)
  "Test your color perception!"
  (standard-page (:title "Color Test"
                         :draggable-viewport nil)
    (:h1 "(Under development) Test how well you can see color using uniformly spaced hues.")
    (:p "THIS IS UNDER DEVELOPMENT NOT READY YET")))

;;(tubes-game)
;;(in-package :max-website)
