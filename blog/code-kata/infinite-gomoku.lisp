
;; So the board being infinite is a bit tricky.
;; I should encapsulate the board, so I can change how it works later on
;; without rewriting everything that accesses it.

;; Also, I'll have to do graphics. I can either do html/javascript, or
;; html/POST/serverside computation or do it locally in SDL. I think
;; I'll make it server based, maybe even no-JS if I'm feeling... ethical.

;; Should I use CLOS or functions/structs? I'll do it functional for now...

;; this function is called the same way no matter what data structure
;; board is. If I need to change how board is accessed, I just have to change these
;; functions, not the ones that call it.
(ql:quickload :alexandria) ;; good toolbox, hash table utils
(ql:quickload :iterate) ;; better than `loop`
(ql:quickload :safe-read)
(defpackage infinite-gomoku
  (:use :cl :alexandria :iterate))
(in-package :infinite-gomoku)

(defun make-move (board x y piece)
  ;; returns nil if unsuccessful
  (macrolet ((location () `(gethash (cons x y) board)))
    (let ((cur-piece (location)))
      (if (null cur-piece)
	  (setf (location) piece)
	  nil))))

(defun get-piece (board x y)
  (gethash (cons x y) board))

(defun create-board ()
  (make-hash-table :test #'equal))

(defun run-length (board x y piece increment-x increment-y)
  ;; direction fun should take in x and y and return the next
  ;; x and y in a row/col/diagonal (as a list)
  (if (eql piece (get-piece board x y))
      (1+ (run-length
	   board
	   (funcall increment-x x)
	   (funcall increment-y y)
	   piece increment-x  increment-y))
      0))


(defun check-five-in-a-row (board x y piece)
  ;; should probably be called immidietly after make-move
  ;; consists of horizontal, vertical, and two diagonal scanners
  (macrolet
      ;; simple macro to save on typing all 8 of the directions we're going to check
      ((run-len (inc-x inc-y) `(run-length board x y piece ,inc-x ,inc-y)))
    ;; When talking about top/bottom/left/right etc I'm thinking about
    ;; x and y in cartesian, it doesn't matter bc they're in a hash table.
    (let ((horiontal (+ -1 (run-len #'1+ #'identity) (run-len #'1- #'identity)))
	  (vertical  (+ -1 (run-len #'identity #'1+) (run-len #'identity #'1-)))
	  (pos-diagonal (+ -1 (run-len #'1+ #'1+) (run-len #'1- #'1-))) ;;top right, bottom left
	  (neg-diagonal (+ -1 (run-len #'1- #'1+) (run-len #'1+ #'1-)))) ;; top left, bottom right
      (format t "h: ~a, v: ~a, pos: ~a, neg: ~a~%" horiontal vertical pos-diagonal neg-diagonal)
      (>= (max horiontal vertical pos-diagonal neg-diagonal) 5))))

(defun print-board (board &optional (center-x 0) (center-y 0) (radius 10))
  (iter (for y from (+ center-y radius) downto (- center-y radius))
	(iter (for x from (- center-x radius) to (+ center-x radius))
	      (format t " ~a" (if-let (piece (get-piece board x y))
				piece ".")))
	(format t "~%")))

(defun read-integer-list (string &optional (start 0))
  (multiple-value-bind (n new-start) (parse-integer string :start start :junk-allowed t)
    (if n
	(cons n (read-integer-list string new-start))
	nil)))

(read-integer-list "4 3")

(defun gomoku-repl ()
  (let ((b (create-board))
	(turn 'b))
    (print-board b)
    (iter
      ;;(repeat 5)
      (format t "~a >> " turn)
      (finish-output)
      (if
       ;; this block returns nil if unsucessful
       (let* ((input ;;(ignore-errors
	       (read-integer-list (read-line))))
	 (if (not (and (= (length input) 2)
		       (numberp (car input))
		       (numberp (cadr input))))
	     (progn
	       (format t "must be two integers seperated by space~%")
	       nil)
	     (let ((success (make-move b (car input) (cadr input) turn)))
	       (if (check-five-in-a-row b (car input) (cadr input) turn)
		   (format t "WINNNNNNERRRRRR!!!!!~%~%"))
	       success)))

       (progn
	 (format t "made move~%")
	 (print-board b)
	 (setf turn (if (eql turn 'b) 'w 'b)))
       (format t "try again~%")))))

(gomoku-repl)
	

(defvar foo (create-board))
(print-board foo)
(check-five-in-a-row foo 3 0 'w)

(mapcar (lambda (x-y) (make-move foo (car x-y) (cadr x-y) 'w))
	'((0 -2)
	  (0 -1)
	  (0 0)
	  (3 0)
	  (0 1)
	  (0 2)
	  (0 3)))
(progn
  (make-move foo 0 0 'b)
  (make-move foo 1 0 'b)
  (make-move foo 2 0 'b)
  (make-move foo 3 0 'b)
  (make-move foo 4 0 'b)
  (make-move foo 5 0 'b)
  (make-move foo 6 0 'b))
