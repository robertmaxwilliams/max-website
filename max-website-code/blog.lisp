(in-package :max-website)

;; returns list of (pathname title)

(defun find-html-or-md (blog-name)
  (flet ((uri->path (ending) (merge-pathnames *blog-dir* (pathname (str:concat blog-name ending)))))
    (let ((md-file (uri->path ".md"))
          (html-file (uri->path ".html")))
      (cond
        ((probe-file md-file) md-file)
        ((probe-file html-file) html-file)
        (t (error "file not found for this url"))))))

(defun blog-pathname-title (uri)
  (let* ((blog-name (car (last (str:split "/" uri))))
         (file-pathname (find-html-or-md blog-name)))
    (list file-pathname 
	  (car (blog-title-and-preview file-pathname)))))

(defun blog-page (pathname)
  (with-open-file (stream pathname)
    (progn
      (unused (take-n-lines stream 4))
      (cond 
        ((str:ends-with-p ".md" (namestring pathname))
         ;;(second-value (markdown (stream-get-contents stream) :stream nil)))
         ;; What I need is stream | pandoc -f markdown -t html | string
         (let ((foo
                (uiop:run-program (list "pandoc" "-f" "markdown" "-t" "html")
                 :input stream
                 :output :string)))
                (format t "HTML:~%~a~%~%" foo)
                foo))


        ((str:ends-with-p ".html" (namestring pathname))
         (stream-get-contents stream))))))

(print "ooooooooooooooOOOOOoooooooooooooooooooooooOOO")
; takes in filepath, returns (title preview)
(defun blog-title-and-preview (file-pathname) ;; 
  (with-open-file (stream file-pathname) 
    (db (dashes1 layout-line title-line dashes2) (take-n-lines stream 4)
      (if (and (string-equal dashes1 "---")
	       (string-equal layout-line "layout: post")
	       (string-equal dashes2 "---"))
	  (list (str:trim (cadr (str:split ":" title-line))) (generate-preview stream))
	  '("badbadbad")))))

; returns lists of (pathname name title preview)
(defun blog-files ()
  (sort (remove-if #'null (mapcar #'(lambda (pathname)
				(let ((namestring (file-namestring pathname)))
				  (cond 
                    ((str:ends-with-p ".md" namestring)
                     (append (list namestring (str:substring 0 -3 namestring))
                             (blog-title-and-preview pathname)))
                    ((str:ends-with-p ".html" namestring)
                     (append (list namestring (str:substring 0 -5 namestring))
                             (blog-title-and-preview pathname))))))
				  (uiop:directory-files *blog-dir*)))
	#'(lambda (a b) (blog-name-sort-by-date (cadr a) (cadr b)))))

;;(start-website "/Users/max/Repos/website/")
;;(mapcar #'cadr (blog-files))
;;(mapcar #'blog-name-date-extractor (mapcar #'cadr (blog-files)))

(defun remove-tags (s)
  (mapcar #'(lambda (s) (car (str:split "<" s))) (str:split ">" s)))

(defun blog-name-date-extractor (namestring)
  (mapcar #'parse-integer (subseq (str:split "-" namestring) 0 3)))

(defun remove-tags (str)
  (ppcre:regex-replace-all "\<[^>]*\>" str ""))

  

(defun generate-preview (stream)
  "takes in markdown string and converts to html preview"
  (remove-tags 
    (str:concat 
      (str:trim 
        (str:substring 0 200 (second-value (markdown (str:join " " (take-n-lines stream 5)) :stream nil)))) "...")))

(defun less-than-int-list (a b)
  (cond ((null a) nil) ;; for when different length
	((null b) t)   ;; not sure which way to put these
	((< (car a) (car b)) t)
	((> (car a) (car b)) nil)
	(t (less-than-int-list (cdr a) (cdr b)))))

(defun blog-name-sort-by-date (a b)
  (not (less-than-int-list (blog-name-date-extractor a) (blog-name-date-extractor b))))
