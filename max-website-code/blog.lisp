(in-package :max-website)

(labels ((remove-tags (str)
                    (ppcre:regex-replace-all "\<[^>]*\>" str ""))
       (generate-preview (stream)
                         "takes in markdown string and converts to html preview"
                         (remove-tags
                           (str:concat
                             (str:trim
                               (str:substring 0 200 (second-value (markdown (str:join " " (take-n-lines stream 5)) :stream nil)))) "..."))))

  (defun blog-title-and-preview (file-pathname)
    "(internal) takes in filepath, returns list of (title preview)"
    (with-open-file (stream file-pathname)
      (db (dashes1 layout-line title-line dashes2) (take-n-lines stream 4)
          (if (and (string-equal dashes1 "---")
                   (string-equal layout-line "layout: post")
                   (string-equal dashes2 "---"))
            (list (str:trim (cadr (str:split ":" title-line))) (generate-preview stream))
            (error "a blog page has an incorrect header format"))))))

(flet ((find-html-or-md (blog-name)
                        "check if html or md version of a file exists (from uri)"
                        (flet ((uri->path (ending) (merge-pathnames *blog-dir* (pathname (str:concat blog-name ending)))))
                          (let ((md-file (uri->path ".md"))
                                (html-file (uri->path ".html")))
                            (cond
                              ((probe-file md-file) md-file)
                              ((probe-file html-file) html-file)
                              (t (error "file not found for this url")))))))

  (defun blog-pathname-title (uri)
    "(exported) Fallback page title based on the uri of the blog page"
    (let* ((blog-name (car (last (str:split "/" uri))))
           (file-pathname (find-html-or-md blog-name)))
      (list file-pathname
            (car (blog-title-and-preview file-pathname))))))

(defun blog-page (pathname)
  "(exported) Returns html string of the entire page for the blog"
  (with-open-file (stream pathname)
    (cond
      ((str:ends-with-p ".md" (namestring pathname))
       (uiop:run-program (list "pandoc" "-f" "markdown" "-t" "html")
                         :input stream :output :string))
      ((str:ends-with-p ".html" (namestring pathname))
       (progn (take-n-lines stream 4)
              (stream-get-contents stream))))))

(defun blog-name-date-extractor (namestring)
  "(exported) extracts list of (year month day) from namestring of blog"
  (mapcar #'parse-integer (subseq (str:split "-" namestring) 0 3)))

(labels ((less-than-int-list (a b)
                             (cond ((null a) nil) ;; for when different length
                                   ((null b) t)   ;; not sure which way to put these
                                   ((< (car a) (car b)) t)
                                   ((> (car a) (car b)) nil)
                                   (t (less-than-int-list (cdr a) (cdr b)))))
         (blog-name-sort-by-date (a b)
                                 (not (less-than-int-list (blog-name-date-extractor a)
                                                          (blog-name-date-extractor b)))))

  (defun blog-files ()
    "(exported) returns lists of (pathname name title preview) sorted by date"
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
          #'(lambda (a b) (blog-name-sort-by-date (cadr a) (cadr b))))))
