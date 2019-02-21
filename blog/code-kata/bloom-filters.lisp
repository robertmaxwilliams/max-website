(ql:quickload :str)
(ql:quickload :iterate)
(ql:quickload :uiop)
(use-package :iterate)

(defun word-list ()
  (list "foo" "bar" "rosco"))

(defun normalize-string (str)
  (str:trim (string-downcase str)))

(defparameter *word-list-pathname*
  "/Users/max/Repos/website/banana-grams/collins-scrabble-words-2015.txt")

(defun word-list ()
  (mapcar #'normalize-string
	  (uiop:read-file-lines *word-list-pathname*)))

;;(print (length (word-list)))
;; => 276643

(defun my-hash (bloom str)
  (mod (sxhash (normalize-string str)) (length bloom)))

(defun add-item (bloom str)
  (setf (sbit bloom (my-hash bloom str)) 1))

(defun check-item (bloom str)
  (= 1 (sbit bloom (my-hash bloom str))))

(my-hash foo "foo")

(defun make-bloom (size)
  (make-array size :initial-element 0 :element-type 'bit))
(describe foo)


(defun build-bloom-dict ()
  (let* ((words (word-list))
	 (bloom (make-bloom (* (length words) 4))))
    (iter (for word in words)
	  (add-item bloom word))
    bloom))


(defvar foo (build-bloom-dict))
(check-item foo "asdasdalkjlksafabbanana")
(add-item foo "foo")
(check-item foo "bar")
(format t "~a" foo)
(type-of foo)
