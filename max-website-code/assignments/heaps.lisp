
(ql:quickload :iterate)
(use-package :iterate)

(defun heap-left (i)
  (+ 1 (* 2 i)))
(defun heap-right (i)
  (+ 2 (* 2 i)))
(defun heap-parent (i)
  (if (zerop i)
      0
      (1- (ceiling i 2))))

(heap-parent 5)

(tree-print-heap #(0 1 2 3 4 5 6 7 8 9))

(defun next-higher-pow-2 (x)
  (expt 2 (ceiling (log x 2))))

(defun tree-print-heap (arr &optional (head 0) (place 'top) (pipe-stack nil))
  (flet ((print-pipes () 
	   (iter (for pipe-or-space in (reverse (cdr pipe-stack)))
		 (format t "~a " pipe-or-space))))
    (cond
      ((< head (length arr))
       (let ((corner-pipe (case place (top "") (left "├─") (right "└─"))))
	 (print-pipes)
	 (format t "~a~a~%" corner-pipe (aref arr head))
	 (tree-print-heap arr (heap-left head) 'left (cons "|" pipe-stack))
	 (tree-print-heap arr (heap-right head)'right (cons " " pipe-stack))))
      ((and (evenp head) (< (1- head) (length arr)))
       (progn
	 (print-pipes)
	 (format t ".~%")))
      (t nil))))


(defun in-heap-p (heap i)
  (< i (length heap)))

(defmacro swap (place-a place-b)
  (let ((temp (gensym)))
    `(let ((,temp ,place-a))
       (setf ,place-a ,place-b)
       (setf ,place-b ,temp))))
  
(defun max-heapify (heap i)
  " ineligant because it's a direct translation from textbook's psuedocode "
  (let* ((left (heap-left i))
	 (right (heap-right i))
	 (largest nil))
    (if (and (in-heap-p heap left) (> (aref heap left) (aref heap i)))
	(setf largest left)
	(setf largest i))
    (if (and (in-heap-p heap right) (> (aref heap right) (aref heap largest)))
	(setf largest right))
    (if (not (= largest i))
	(progn
	  (swap (aref heap i) (aref heap largest))
	  (setf heap (max-heapify heap largest))))
    heap))

(defun build-max-heap (heap)
  (iter (for i from (1- (/ (next-higher-pow-2 (length heap)) 2)) downto 0)
	(setf heap (max-heapify heap i)))
  heap)

(defun build-max-heap-2 (arr)
  "uses insert"
  (let ((heap (vector)))
    (iter (for x in-vector arr)
	  (setf heap (max-heap-insert heap x)))
    heap))
  
	

(defun array-append-to-end (arr el)
  (let ((new-arr ;; might re-use old arr memory location
	 (adjust-array arr (1+ (length arr)))))
    (setf (aref new-arr (length arr)) el)
    new-arr))

(defun max-heap-insert (heap el &optional (l (length heap)))
  (setf heap (array-append-to-end heap el))
  (iter (initially (setq i l))
	(for i next (if (= i 0) (terminate) (heap-parent i)))
	(max-heapify heap i))
  heap)

(defun heap-pop-top (heap)

(max-heapify #(0 1 2 3 4 5 6 7 8) 0)

(defvar foo #(0 1 2 5 4 2 5 3))
;;(tree-print-heap foo)
;;(tree-print-heap (build-max-heap foo))
;;(tree-print-heap (build-max-heap-2 foo))
;;(tree-print-heap (setf foo (max-heap-insert foo (random 10))))

(length foo)
;;(print foo)
(heap-parent 8)
(aref foo 8)
;;(tree-print-heap (setf foo (max-heapify foo 4)))
;;(tree-print-heap foo)

	
