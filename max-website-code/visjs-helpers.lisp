
;; Functions used in the vis js stuff, such as manipulating graph like data
;; or reading defuns from files

(in-package :max-website)

(defun read-files (filenames)
  (loop for filename in filenames
       append (with-open-file (file-stream filename)
	 (loop until (not (listen file-stream))
	    collect (read file-stream nil '())))))


(defun collect-defuns (filenames)
  " Returns list of pairs of (function-name (functions-it-calls1 ...))
Does not acknowledge lisp2, aka all symbols are fair game."
  (let* ((list-o-sexps (read-files filenames))
	 (flatfuns ;; lists of defuns by (name all other symbols flattened)
	  (remove nil (maplb (if (member (car it) '(defun defmacro define-url-fn))
				 (alexandria:flatten (cdr it)))
			     list-o-sexps)))
	 (fun-names ;; list of just the names
	  (maplb (car it) flatfuns)))
    ;; for each flatfun, produce a list containing its cdr with only fun-names members in it
    (mapfor (flatfun in flatfuns)
	    (list
	     (car flatfun)
	     (remove-if-not #'(lambda (sym) (member sym fun-names))
			    (remove-duplicates (cdr flatfun)))))))

(defun alist-to-edges (list-alist)
  " Takes in list of (thing (other things)) to (thing other) (thing things) "
  (if list-alist (append (mapfor (to-item in (cadar list-alist)) (list (caar list-alist) to-item))
			 (alist-to-edges (cdr list-alist)))))

(defun function-graph-nodes-edges (filenames)
  (let ((graphguy (collect-defuns filenames)))
    (list
     (mapcar #'car graphguy)
     (alist-to-edges graphguy))))



(defun vis-nodes (nodes)
  " returns quoted parenscript for nodes var for vis.js graph"
  `(array ,@(loop for node in nodes
	       collect `(create id ',node label ',node))))
(defun vis-edges (edges)
  " returns quoted parenscript for edges var for vis.js graph"
  `(array ,@(loop for from-to in edges
		 collect `(create from ',(car from-to) to ',(cadr from-to) arrows 'to))))

(defun vis-js-graph (nodes-edges)
  " returns javasctipt string for visjs code to draw nodes and edges"
  (ps* `(defvar nodes (new ((@ vis *data-set)
			  ,(vis-nodes (car nodes-edges)))))
	 `(defvar edges (new ((@ vis *data-set)
			  ,(vis-edges (cadr nodes-edges)))))
	 `(defvar container ((@ document get-element-by-id) 'mynetwork))
	 `(defvar data (create nodes nodes edges edges))
	 `(defvar options (create))
	 `(defvar network (new ((@ vis *network) container data options)))))
