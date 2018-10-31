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
  "hi")
