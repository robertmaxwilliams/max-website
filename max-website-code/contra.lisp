
;; second try at mathy contra simulator

;;lingo:
;; sets: arrays with all the dancers
;; set: a hands 4
;; line: half the array
(ql:quickload :iterate)
(ql:quickload :alexandria)
(defpackage mathy-contra
  (:use :cl :iterate :alexandria))
(in-package :mathy-contra)

(defun make-sets (n-dancers)
  (coerce (iter (for i from 0 below n-dancers) (collect i)) 'vector))

(defun print-sets (sets)
  (format t "~%")
  (iter (for row from 0 below (/ (length sets) 2))
	(format t " ~2a ~2a~%"
		(aref sets (1- (- (length sets) row)))
		(aref sets row)))
  (format t "~%"))


(defmacro let*-alist (pairs)
  " just like let* but returns (var-name value) pairs in alist"
  `(let* ,pairs
    ,(cons `list 
	   (iter (for pair in pairs)
		 (collect `(list (quote ,(car pair)) ,(car pair)))))))

(defun m+ (n base)
  (mod (1+ n) base))
(defun m- (n base)
  (mod (1- n) base))

(defun dancer-vars-alist (sets pos time)
  (let*-alist
   ((n (length sets))
    (identity pos);;???
    (pivot (/ n 2))
    (id (aref sets pos))
    (is-raven (evenp id))
    (is-lark (not is-raven))
    (left-side (>= pos pivot))
    (right-side (not left-side))
    (row (if right-side pos (- n pos 1)))
    (cw-pos (mod (1+ pos) n))
    (ccw-pos (mod (1- pos) n))
    (across-pos (mod (if right-side (- n pos 1) (- 0 pos n 1)) n))
    (circle-right-pos
     (if (= (mod pos 2) (mod time 2))
	 across-pos ccw-pos))
    (circle-left-pos
     (if (= (mod pos 2) (mod time 2))
	 cw-pos across-pos))
    (beside-up-and-down-pos
     (if (evenp (+ pos time))
	 cw-pos ccw-pos))
    (partner-id (mod (if is-raven (1+ id) (1- id)) n))
    (partner-pos (position partner-id sets))
    (other-neighbor-id ;; person across when you started, + time
     (mod (- (if right-side (- n id 1) (- 0 id n 1)) (* 2 time)) n))
    (same-neighbor-id
     (mod (if is-raven (1- other-neighbor-id) (1+ other-neighbor-id)) n))
    (same-neighbor-pos (position same-neighbor-id sets))
    (other-neighbor-pos (position other-neighbor-id sets))
    (neighbor-raven-pos (if is-raven same-neighbor-pos other-neighbor-pos))
    (neighbor-lark-pos (if is-lark same-neighbor-pos other-neighbor-pos))
    (larks-swap (if is-lark same-neighbor-pos pos))
    (ravens-swap (if is-raven same-neighbor-pos pos))

    (trail-buddy-id (mod (if is-raven (1- id) (1+ id)) n))
    (trail-buddy-pos (position trail-buddy-id sets))

    (raven-on-the-right ;; puts the raven on the right, circle-wise
     (role-based-swap-in-circle is-raven partner-pos))
    (neighbor-raven-on-the-right ;; puts the partner raven on the right, circle-wise
     (role-based-swap-in-circle is-raven other-neighbor-pos))
    (raven-on-the-left ;; puts the raven on the left, circle-wise
     (role-based-swap-in-circle is-lark partner-pos))
    (neighbor-raven-on-the-left ;; puts the raven on the right, circle-wise
     (role-based-swap-in-circle is-lark other-neighbor-pos))
    )))

(defmacro role-based-swap-in-circle (role-p other-pos)
  " used to swap with partner/neighbor based on role, like after a swing"
  `(if ,role-p
      (cond ((eql ,other-pos circle-left-pos) pos)
	    ((eql ,other-pos circle-right-pos) circle-right-pos)
	    (t nil))
      (cond ((eql ,other-pos circle-right-pos) pos)
	    ((eql ,other-pos circle-left-pos) circle-left-pos)
	    (t nil))))

(setf foo (make-sets 10))
(print-sets foo)
(print-sets (setf foo (make-move foo 'cw-pos 0)))

(print-sets (setf foo (make-move foo 'circle-right-pos 1)))
(print-sets (setf foo (make-move foo 'circle-left-pos 1)))
(print-sets (setf foo (make-move foo 'raven-on-the-right 1)))
(print-sets (setf foo (make-move foo 'raven-on-the-left 1)))

(print-sets (permutation-set foo 'other-neighbor-id 1))
(print-sets (permutation-set foo 'same-neighbor-id 1))

(print-sets (make-sets 10))

;; associate a move name with a sequence of positions from dancer-vars-alist
(defun moves-association (move)
  (cdr
   (assoc
    move
    '((circle-left    circle-left-pos)
      (circle-left-two-places   circle-left-pos circle-left-pos)
      (circle-left-three-places circle-left-pos circle-left-pos circle-left-pos)
      (circle-left-four-places)
      (circle-left-five-places  circle-left-pos)
      (circle-right   circle-right-pos)
      (star-right     circle-left-pos)
      (star-right-five-places   circle-left-pos)
      (star-left      circle-right-pos)

      (partner-swing  raven-on-the-right)
      (partner-gypsy  raven-on-the-right)
      (partner-gypsy-and-swing raven-on-the-right)
      (neighbor-swing neighbor-raven-on-the-right)
      (neighbor-gypsy neighbor-raven-on-the-right)
      (neighbor-gypsy-and-swing neighbor-raven-on-the-right)
      (partner-swap   partner-pos)
      (neighbor-swap  other-neighbor-pos)
      (same-neighbor-swap same-neighbor-pos)

      (gypsy-trail-buddy trail-buddy-pos)

      (ladies-chain   ravens-swap)
      (courtesy-turn  beside-up-and-down-pos)
      (slide-right    ccw-pos)
      (slide-left     cw-pos)

      (chainsaw-circle-left    cw-pos)
      (chainsaw-circle-right   ccw-pos)
      (right-hands-across      across-pos)
      (right-and-left-through
       across-pos beside-up-and-down-pos)
      (long-lines-forward-and-back identity) ;; not sure?
      (gents-alaman-all-the-way)
      (ladies-alaman-all-the-way)
      (gents-alaman-half-way         larks-swap)
      (gents-alaman-once-and-a-half  larks-swap)
      (ladies-alaman-half-way        ravens-swap)
      (ladies-alaman-once-and-a-half ravens-swap)
      ))))

(defvar foo (make-sets 10))
(print-sets foo)

(print-sets (setf foo (make-move foo 'circle-left-pos 0)))
(print-sets (setf foo (make-move foo 'neighbor-swing 0)))

(format t "~%~%~%")

(defun dance-n-times-k-dancers (n-times k-dancers formation moves)
  (let ((sets (make-sets k-dancers)))
    (cond ((eql formation 'becket) nil)
	  ((eql formation 'improper) (setf sets (make-move sets 'circle-right-pos 0)))
	  (t nil))
    (iter (for time from 0 below n-times)
	  (format t ">> TIME: ~a  ===============~%~%" time)
	  (setf sets (run-dance sets moves time)))))

(format t "~%~%~%")
(dance-n-times-k-dancers
 3 6 'becket
 '(circle-left
   partner-swap
   partner-swing
   neighbor-swing
   circle-left
   partner-swing
   slide-left
   ))


;; Pearl Anniversary Whirl
;; https://www.cambridgefolk.org.uk/contra/dances/mike_richardson/pearl_anniversary_whirl.html

;; 
;; Pearl Anniversary Whirl
;; By Mike Richardson
;; Improper Contra
;; 
;; A1
;; Star right once and a quarter, gypsy left neighbour
;; will be the same one every time
;; A2
;; gypsy right partner, swing partner
;; B1
;; long lines forward and back
;; circle left three quarters
;; B2
;; swing neighbour
;; star left once
(format t "~%~%~%")

(dance-n-times-k-dancers
 3 8 'improper
 '(star-right-five-places
   ;;neighbor-gypsy
   ;;gypsy-trail-buddy
   partner-gypsy-and-swing
   long-lines-forward-and-back
   circle-left-three-places
   neighbor-swing
   star-left
   ))


(defun @ (key alist)
  (cadr (assoc key alist)))

(defun make-move (sets place-name time)
  (let ((new-sets (make-array (length sets))))
    (iter (for pos from 0 below (length sets))
	  (let ((new-pos (@ place-name (dancer-vars-alist sets pos time))))
	    (if new-pos
		(setf (aref new-sets new-pos) (aref sets pos))
		(error "new pos is null, bad move"))))
    new-sets))


(defun permutation-set (sets place-name time)
  (let ((new-sets (make-array (length sets))))
    (iter (for pos from 0 below (length sets))
	  (let ((new-pos (@ place-name (dancer-vars-alist sets pos time))))
	    (setf (aref new-sets pos) new-pos)))
    new-sets))

(defun run-dance (sets moves time &optional (pre-print t))
  (if pre-print
      (progn
	(format t ">> starting order~%")
	(print-sets sets)))
  (cond ((null moves)
	 (progn
	   ;;(print-sets sets)
	   (format t "~%==========~%")
	   sets))
	((moves-association (car moves))
	 (progn
	   (format t ">> ~a~%" (car moves))
	   (iter (for move in (moves-association (car moves)))
		(setf sets (make-move sets move time)))
	   (print-sets sets)
	   (run-dance sets (cdr moves) time nil)))
	(t
	 (progn
	   (format t ">> using single move form ~a~%" (car moves))
	   (setf sets (make-move sets (car moves) time))
	   (print-sets sets)
	   (run-dance sets (cdr moves) time nil)))))


  
(if nil
    (let ((sets (make-sets 10))
	  (time 0))
      (format t "~a~%" (dancer-vars-alist sets 3 0))
      (format t "~a~%" (dancer-vars-alist sets 4 0))
      (format t "~a~%" (dancer-vars-alist sets 6 0))
      (print-sets sets)
      (print-sets (permutation-set sets 'across-pos time))
      (setf sets (make-move sets 'across-pos time))
      (setf sets (make-move sets 'circle-left-pos time))
      (setf sets (make-move sets 'circle-right-pos time))
      (setf sets (make-move sets 'across-pos time))
      (print-sets sets)))
