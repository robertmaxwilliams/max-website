
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
    (format t "Funnames ~a~%" fun-names)
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



;; TODO my alists are not dotted, is that bad style?
(defun vis-nodes (nodes)
  " returns quoted parenscript for nodes var for vis.js graph"
  `(array ,@(loop for node in nodes
	       collect `(create id ',node label ,(write-to-string node)))))

(defun vis-edges (edges)
  " returns quoted parenscript for edges var for vis.js graph"
  `(array ,@(loop for from-to in edges
		 collect `(create from ',(car from-to) to ',(cadr from-to) arrows 'to))))

(defun vis-js-graph (nodes-edges)
  " returns javasctipt string for visjs code to draw nodes and edges"
  (ps* `(defvar *nodes* (new ((@ vis -data-set)
			  ,(vis-nodes (car nodes-edges)))))
	 `(defvar *edges* (new ((@ vis -data-set)
			  ,(vis-edges (cadr nodes-edges)))))
	 `(defvar *container* ((@ document get-element-by-id) 'mynetwork))
	 `(defvar *data* (create :nodes *nodes* :edges *edges*))
	 `(defvar *options* (create))
	 `(defvar *network* (new ((@ vis *network) *container* *data* *options*)))))

;; TODO this is repeated code from the server-side code, how
;; to define exactly once? Not too sure.

(defun vis-js-inverse-collatz ()
  (ps (defun integerp (x)
	(chain -number (is-integer x)))
      (defvar *blue-node-color*
	(create :background "#D2E5FF" :border "#2B7CE9"))
      (defvar *red-node-color*
	(create :background "#FFD2D2" :border "#E92A2A"
		:highlight (create :background "#FFD2D2" :border "#E92A2A")))
      (defvar *leaves* '(4)) ;; nodes that have been added but not used
      (defun rand ()
	(* 10 (chain -math (random))))
      (defun push (obj arr)
	(chain arr (push obj)))
      (defun zerop (x)
	(= x 0))
      (defun inverse-collatz (n)
	(let ((second-val (/ (- n 1) 3)))
	  (if (and (integerp second-val) (not (zerop second-val)))
	      (array (* n 2) second-val)
	      (array (* n 2)))))
      (defun add-node (n x y)
	(let* ((offset-x (rand))
	       (offset-y (- 100 offset-x))
	       (new-node (create :id n :label (-string n)
				 :x (+ offset-x x) :y (+ offset-y y)
				 :scaling (create :max 100 :min 90 :label t)
				 :shape 'circle
				 :color (if (oddp n)
					    *red-node-color*
					    *blue-node-color*))))
	  (ignore-errors (chain *nodes* (add new-node)))))
      (defun add-edge (from to)
	(chain *edges* (add (create :from from :to to :arrows 'to :length 20))))
      (defun member (x arr)
	(chain arr (includes x)))
      (defun remove-duplicates (arr)
	;;Array.from(new Set([1,2,2,2]))
	(chain -array (from (new (-set arr)))))
      (defun without-element (arr el)
	(chain arr (filter (lambda (x) (!= el x)))))
      (defun add-inverses-to-graph (n)
	(if (not n) (return))
	;;TODO(if (member n  (return))
	(setf *LEAVES* (without-element *leaves* n))
	(let* ((parent-node (aref (@ *network* physics body nodes) n))
	       (x (@ parent-node x))
	       (y (@ parent-node y)))
	  (if (chain *nodes* (get n))
	      (loop for new-node in (inverse-collatz n)
		 do (chain console (log new-node))
		 do (chain *leaves* (push new-node))
		 ;; only add edge if add node returns non-null
		 do (if (add-node new-node x y) (add-edge new-node n))
		 do (chain console (log *leaves*))))))
      (defun explode-leaves ()
	(loop for n in *leaves*
	     do (add-inverses-to-graph n)))))
