(in-package :max-website)

;; returns list of (pathname title)
(defun blog-pathname-title (uri)
  (let* ((blog-name (car (last (str:split "/" uri))))
	(file-pathname (merge-pathnames *blog-dir* (pathname (str:concat blog-name ".md")))))
    (list file-pathname 
	  (car (blog-title-and-preview file-pathname)))))

(defun blog-page (pathname)
  (with-open-file (stream pathname)
    (progn
      (unused (take-n-lines stream 4))
      (second-value (markdown (stream-get-contents stream) :stream nil)))))

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
				  (if (str:ends-with-p ".md" namestring)
				      (append (list namestring (str:substring 0 -3 namestring))
					    (blog-title-and-preview pathname)))))
				  (uiop:directory-files *blog-dir*)))
	#'(lambda (a b) (blog-name-sort-by-date (cadr a) (cadr b)))))

;;(start-website "/Users/max/Repos/website/")
;;(mapcar #'cadr (blog-files))
;;(mapcar #'blog-name-date-extractor (mapcar #'cadr (blog-files)))

(defun remove-tags (s)
  (mapcar #'(lambda (s) (car (str:split "<" s))) (str:split ">" s)))

;; takes in markdown string and converts to html preview
(defun generate-preview (stream)
  (str:concat 
    (str:substring 
      0 200 
      (str:join 
        "" 
        (remove-tags
          (str:trim 
            (str:substring 0 500 (second-value (markdown (str:join " " (take-n-lines stream 5)) :stream nil)))) 
          ))) 
    "..."))

(defun blog-links-page ()
  (standard-page (:title "Blog index")
    (:h3 "Blog posts:")
    (loop for pathname-name-title-preview in (blog-files)
       do (db (pathname name title preview) pathname-name-title-preview
	    (unused pathname)
	    
	    (htm (:h3 :class "nobottommargins" (:a :href (str:join "" (list "/blog/" name))
			  (str title)))
		 (str (str:join "-" (blog-name-date-extractor name)))
		 (:p (str preview)))))))


;;(ql:quickload :max-website)
;;(in-package :max-website)

(defun blog-name-date-extractor (namestring)
  (mapcar #'parse-integer (subseq (str:split "-" namestring) 0 3)))

(defun less-than-int-list (a b)
  (cond ((null a) nil) ;; for when different length
	((null b) t)   ;; not sure which way to put these
	((< (car a) (car b)) t)
	((> (car a) (car b)) nil)
	(t (less-than-int-list (cdr a) (cdr b)))))

(defun blog-name-sort-by-date (a b)
  (not (less-than-int-list (blog-name-date-extractor a) (blog-name-date-extractor b))))

;;(blog-name-date-extractor "2018-1-9-Adversarial-Examples")
  

;;what is this doing here;; eg 2018-1-9-Adversarial-Examples
