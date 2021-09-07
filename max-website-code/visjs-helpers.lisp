;; Functions used in the vis js stuff, such as manipulating graph like data
;; or reading defuns from files

(in-package :max-website)

(defun read-files (filenames)
  (loop for filename in filenames
       append (with-open-file (file-stream filename)
	 (loop until (not (listen file-stream))
	    collect (read file-stream nil '())))))

(defun strip (thing)
  (if (listp thing)
    (car thing)
    thing))

;; TODO DO finish
(defun get-fun-names (tree)
  (append
    (cond
      ((atom tree) nil)
      ((and (listp tree) (listp (cdr tree)) 
            (symbolp (cadr tree)) (cadr tree) (not (eql (char (string (cadr tree)) 0) #\,))
            (member (car tree) (list 'defun 'defmacro 'define-url-fn)))
       (list (cons (strip (cadr tree)) (alexandria:flatten tree))))
      (t nil))
    (if (and tree (listp tree)) (get-fun-names (car tree)) nil)
    (if (and tree (listp tree)) (get-fun-names (cdr tree)) nil)))

(defun match-em-up (nameso)
  (let ((fun-names (mapcar #'car nameso)))
    (loop for (name . contents) in nameso
          collect (cons name
                        (loop for x in contents
                              when (and (not (equal x name)) (member x fun-names))
                              collect x)))))


;;(format t "List those fun namess:~%~%")
;;(let ((list-o-sexps (read-files '("max-website-code/visjs-helpers.lisp"))))
;;  (format t "Hm: ~a~%" (get-fun-names list-o-sexps))
;;  (format t "Yes: ~a~%" (mapcar #'remove-duplicates (match-em-up (get-fun-names list-o-sexps)))))
(defun remove-duplicate-keys (alist)
  (let ((new-keys (remove-duplicates (mapcar #'car alist))))
    (mapcar (lambda (key) (assoc key alist)) new-keys)))

(defun collect-defuns (filenames)
  (remove-duplicate-keys (mapcar #'remove-duplicates (match-em-up (get-fun-names (read-files filenames))))))

(defun alist-to-edges (list-alist)
  " Takes in list of (thing (other things)) to (thing other) (thing things) "
  (if list-alist (append (mapfor (to-item in (cdar list-alist)) (list (caar list-alist) to-item))
			 (alist-to-edges (cdr list-alist)))))

(defun function-graph-nodes-edges (filenames)
  (let ((graphguy (collect-defuns filenames)))
    (list
     (mapcar #'car graphguy)
     (alist-to-edges graphguy))))

;;(format t "yesss ~A~%" (function-graph-nodes-edges '("max-website-code/visjs-helpers.lisp")))

;; NOTE these alists are not dotted
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


(defun inverse-collatz (n)
  "returns a list with one or two values that collatz to n"
  (cons (* 2 n)
	(let ((other-result (/ (- n 1) 3)))
	  (if (and (integerp other-result) (not (zerop other-result)))
	      (list other-result)
	      nil))))

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
