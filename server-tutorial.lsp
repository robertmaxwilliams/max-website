(ql:quickload '(:hunchentoot :cl-who :asdf :parenscript))

(defpackage :retro-games
             (:use :cl :cl-who :hunchentoot :parenscript))
      
(in-package :retro-games)


(hunchentoot:start (make-instance 'hunchentoot:easy-acceptor :port 8080))

(hunchentoot:define-easy-handler (say-hello :uri "/hello") (name)
 (setf (hunchentoot:content-type*) "text/plain")
 (format nil "Hello, ~a! I am Mux ~%I build a website with Lisp!!!" name))

(defun clunk ()
  (with-html-output (*standard-output* nil :indent t)
    (:html
     (:head
      (:title "Test page"))
     (:body
      (:p "CL-WHO is really easy to use")))))


;; brief aside showing CLOS
;; where a "game" is a game being voted on in a web page online
(defclass game ()
  ((name  :initarg  :name)
   (votes :initform 0)))

;; now with accessors
(defclass game ()
  ((name  :reader   name 
	  :initarg  :name)
   (votes :accessor votes 
	  :initform 0)))

(defmethod vote-for (user-selected-game)
  (incf (votes user-selected-game)))

(defparameter game1 (make-instance 'game :name "Tetris"))

game1

(name game1)
(votes game1)
(incf (votes game1))
(votes game1)
(vote-for game1)

  
;; in memory storage. Maybe use database later
(defvar *games* '())

(defun game-from-name (name)
  (find name *games* :test #'string-equal 
	:key  #'name))

;; same thing but in boolean style
(defun game-stored? (game-name)
  (game-from-name game-name))

;; gets games, sorted by popularity
(defun games ()
  (sort (copy-list *games*) #'> :key #'votes))

(defun add-game (name)
  (unless (game-stored? name)
    (push (make-instance 'game :name name) *games*)))

(games)
(add-game "Tetris")
(add-game "Mario")
(game-from-name "Tetris")
(game-from-name "Metris")
(games)
(mapcar #'score (games))

(with-html-output (*standard-output* nil :indent t)
  (:html
   (:head
    (:title "Pest Tage"))
   (:body
    (:p "CL-WHO is for chumps with no moeny"))))

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
		    :href "/retro.css"))
	    (:body
	     (:div :id "header" ;; Retro game header?
		   (:img :src "/logo.jpg"
			 :alt "Comandor 54"
			 :class "logo")
		   (:span :class "strapline"
			  "Vot on ur fav Retro Game (tm)"))
	     ,@body))))
		   
(macroexpand-1 '(standard-page (:title "Retro Games")
		 (:h1 "Top Retro Games")
		 (:p "We'll write the code later...")))

;;; deprecated (start-server :port 8080)
(start (make-instance 'easy-acceptor :port 8081))




(define-easy-handler (say-hello :uri "/hello") (name)
 (setf (hunchentoot:content-type*) "text/plain")
 (format nil "Hello, ~a! I am Mux ~%I build a website with Lisp!!!" name))

(defun retro-games ()
  (standard-page (:title "Retro Games")
    (:h1 "Top retro game")
    (:p "Welss dsdio TODO")))

(push (create-prefix-dispatcher "/retro-games" 'retro-games) *dispatch-table*)


(define-easy-handler (retro-games2 :uri "/retro-games2") (name)
  (retro-games))

;; this is nice but could be better - what if we could do this?
(define-url-fn (retro-games)
    (standard-apge (:title "reree")
		   (:h1 "heheheh")
		   (:p "TODO write this")))
;; This pipe dream made real, with macros! Now that's neat.
;; Pipe dream code is also called "wish code"
;; This macro is similar to define-easy-handler but auto-names the URL
(defmacro define-url-fn ((name) &body body)
  `(progn
     (defun ,name ()
       ,@body)
     (push (create-prefix-dispatcher ,(format nil "/~(~a~).htm" name) ',name)
	   *dispatch-table*)))
			   
(macroexpand
 '(define-url-fn (retro-games)
   (standard-page (:title "reree")
    (:h1 "heheheh")
    (:p "TODO write this"))))


;; Okay time to make the real thing
(define-url-fn (retro-games)
  (standard-page (:title "Top Rtrro Gms")
    (:h1 "Bote  bon ur top fav retro game")
    (:p "Mussing a game? Add it for votes:" (:a :href "new-game.htm" "here"))
    (:h2 "Current: ")
    (:div :id "chart" ;; for CSS stying of links
	  (:ol
	   (dolist (game (games))
	     (htm
	      (:li
	       (:a :href (format nil "vote.htm?name=~a" (name game)) "vote!")
	       (fmt "~A with ~d votes" (name game) (votes game)))))))))


;; Get voted on game and increment its votes.
;; uses hunchentoot's parameter function to get url parameters
(define-url-fn (vote)
  (let ((game (game-from-name (parameter "name"))))
    (if game
	(vote-for game)
	"Game not recognized") ;; TODO have a failure page with back button
    (redirect "/retro-games.htm")))

(define-url-fn (new-game)
  (standard-page (:title "Adda new game")
    (:h1 "Add a new game to the chart")
    (:form :action "/game-added.htm" :method "post"
	   :onsubmit ;;parenscript time
	   (ps-inline
	    (when (= name.value "")
	      (alert "Please enter a name.")
	      (return false)))
	   (:p "What is the name of the game?" (:br)
	       (:input :type "text"
		       :name "name"
		       :class "txt"))
	   (:p (:input :type "submit"
		       :value "Add"
		       :class "btn")))))

(define-url-fn (game-added)
    (let ((name (parameter "name")))
      (unless (or (null name) (zerop (length name)))
	(add-game name))
      (redirect "/retro-games.htm")))
