(in-package :max-website)

;; returns list of (pathname title)
(defun blog-pathname-title (uri)
  (let* ((blog-name (car (last (str:split "/" uri))))
	(pathname (pathname (concatenate 'string *blog-dir* blog-name ".md"))))
    (list pathname 
	  (car (blog-title-and-preview pathname)))))

(defun blog-page (pathname)
  (with-open-file (stream pathname)
    (progn
      (unused (take-n-lines stream 4))
      (second-value (markdown (stream-get-contents stream) :stream nil)))))

; takes in filepath, returns (title preview)
(defun blog-title-and-preview (pathname) ;; 
  (with-open-file (stream pathname) 
    (db (dashes1 layout-line title-line dashes2) (take-n-lines stream 4)
      (if (and (string-equal dashes1 "---")
	       (string-equal layout-line "layout: post")
	       (string-equal dashes2 "---"))
	  (list (str:trim (cadr (str:split ":" title-line))) (generate-preview stream))
	  '("badbadbad")))))

; returns lists of (pathname name title preview)
(defun blog-files ()
  (remove-if #'null (mapcar #'(lambda (pathname)
				(let ((namestring (file-namestring pathname)))
				  (if (str:ends-with-p ".md" namestring)
				      (append (list namestring (str:substring 0 -3 namestring))
					    (blog-title-and-preview pathname)))))
			    (uiop:directory-files *blog-dir*))))

;; takes in markdown string and converts to html preview
(defun generate-preview (stream)
  (str:concat (str:trim (str:substring 0 200 (second-value (markdown (str:join " " (take-n-lines stream 5)) :stream nil)))) "..."))

(defun blog-links-page ()
  (standard-page (:title "Blog index")
    (:h3 "Blog posts:")
    (loop for pathname-name-title-preview in (blog-files)
       do (db (pathname name title preview) pathname-name-title-preview
	    (unused pathname)
	    (htm (:h3 (:p (:a :href (str (str:join "" (list "/blog/" name))) (str title))))
		 (:p (str preview)))))))



;;what is this doing here;; eg 2018-1-9-Adversarial-Examples
