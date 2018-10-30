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
