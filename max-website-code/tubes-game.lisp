
;; javascript for tubes game
(in-package :max-website)

(defun lowstring (x)
  (string-downcase (string x)))

(defparameter tube-transforms
   '((bird tiger bird)
     (tiger)
     (brick scissors)
     (scissors muscle)
     (muscle cake)
     (cake heart scissors)
     (heart wheel pig)
     (heart pig wheel)
     (wheel brick goldfish goldfish goldfish)
     (goldfish)
     (pig ghost leg leg)
     (leg bone)
     (ghost balloon tiny-ghost)
     (tiny-ghost)
     (balloon ant popped blue-bird)
     (ant tiny-ghost tiny-tube)
     (tiny-tube tiny-tube)
     (blue-bird heart bones bones bones)
     (popped)
     (bone)))

(defun tubize (item)
  (cdr (assoc item tube-transforms)))


(defun play-tubes (item inventory)
  (if (member item inventory :test #'string=)
      (append (tubize item) (remove item inventory :count 1))
      (progn
	(format t "you don't have ~a!~%" item)
	inventory)))

;;(play-tubes 'bird '(bird brick))

(defun tubes-repl ()
  (let ((inventory '(bird brick)))
    (loop
       (progn
	 (format t "TOOB:> ")
	 (finish-output)
	 (setf inventory (play-tubes (intern (string-upcase (read-line))) inventory))
	 (format t "Inventory: ~a~%" inventory)))))

(defun tube-transforms-js ()
  " convert from tube-transforms to js alist"
  `(create
    ,@(loop for entry in tube-transforms
	 append (list
		 (lowstring (car entry))
		 (cons
		  'list
		  (loop for newthing in (cdr entry)
		     collect (lowstring newthing)))))))
;;(ps* (tube-transforms-js))
;;(tube-transforms-js)



;;(with-html-output-to-string (s) (:h1 "hi"))


(defun tubes-js ()
  (ps*
   `(defun print (text)
      (chain console (log text)))
   `(defun string (x)
      (to-string x))
   `(defun random (upper)
      (chain -math (floor (* upper (chain -math (random))))))
   `(defvar item-divs (chain document (query-selector-all "#item")))
   `(defvar items (loop for div in item-divs
		     collect (make-item div)))
   `(defvar ai nil) ;;short for active item
   `(defvar container (chain document (query-selector "body")))
   `(defun make-item (div)
      (create active nil
	      div div
	      current (create x 0 y 0) ;; where it is drawn
	      initial (create x 0 y 0) ;; where it was clicked
	      offset (create x 0 y 0))) ;; where it landed after leave

   `(defun place-item (item-class initial-position)
      ;;(setf initial-position (pair-mult initial-position (make-pair 0.5 0.5))))
      (setf initial-position (pair-sub initial-position origin-offset))
      (print initial-position)
      (let ((div (chain document (create-element "div"))))
	(setf (@ div id) "item")
	(setf (@ div class-name) item-class)
	(let ((new-item (make-item div)))
	      
	  (setf items (chain items (concat new-item)))
	  (css-translate (+ (@ initial-position x))
			 (+ (@ initial-position y)) div)
	  (setf (@ new-item offset) (pair-copy initial-position)))
	(chain container (append-child div))))

   `(defvar tube-transforms ,(tube-transforms-js)) ;; alist of thing to tube out
   `(defun get-tube-place (widther)
      (let* ((tube-rect (chain tube (get-bounding-client-rect))))
	     (make-pair
	      (+ (* (@ tube-rect width) widther) (@ tube-rect left))
	      (avg (@ tube-rect top)  (@ tube-rect bottom)))))

   `(defun tube-spawn (in-item)
      (let* ((in-thing (@ in-item div class-name))
	     (spawn-location (pair-sub (get-tube-place 1)
				       (make-pair 0 50)))))
      (loop for thing in (getprop tube-transforms in-thing)
	 do (place-item
	     thing
	     (pair-add
	      (pair-sub (make-pair 50 50) ;; random -50 to 50
			(make-pair (random 100) (random 100)))
	      spawn-location))))

   `(defun remove-item (item)
      (chain container (remove-child (@ item div)))
      (chain items ;; remove item from items list
	     (splice
	      (chain items
		     (find-index (lambda (x) (eql x item))))
	      1)))

   `(place-item "tube" (make-pair 0 0))
   `(place-item "bird" (make-pair -200 -200))
   `(place-item "brick" (make-pair -300 -200))
   `(defvar tube (chain document (query-selector ".tube")))
   `(defvar origin-offset
      (let ((tube-rect (chain tube (get-bounding-client-rect))))
	(make-pair (@ tube-rect x) (@ tube-rect y))))

   `(progn
      ;; touch
      (chain container (add-event-listener "touchstart" drag-start false))
      (chain container (add-event-listener "touchend" drag-end false))
      (chain container (add-event-listener "touchmove" drag false))
      ;; mouse
      (chain container (add-event-listener "mousedown" drag-start false))
      (chain container (add-event-listener "mouseup" drag-end false))
      ;;(chain container (add-event-listener "mouseleave" drag-end false))
      (chain container (add-event-listener "mousemove" drag false)))
   `(defun subseq (arr start &optional end) ;; all args are optional in JS ;(
      (chain arr (slice start end)))
   `(defun touch-event-p (e)
      (= (subseq (@ e type) 0 5) "touch"))

   `(defun make-pair (x y)
      (create x x y y))
   `(defun pair-sub (pair1 pair2)
      (if pair2 ;; two-arg form
	  (create
	   x (- (@ pair1 x) (@ pair2 x))
	   y (- (@ pair1 y) (@ pair2 y)))
	  (create
	   x (- (@ pair1 x))
	   y (- (@ pair1 y)))))
   `(defun pair-copy (pair)
      (create
       x (@ pair x)
       y (@ pair y)))
   `(defun sqrt (x)
      (chain -math (sqrt x)))
   `(defun sqr (x) (* x x))
   `(defun pair-mult (a b)
      (make-pair
       (* (@ a x) (@ b x))
       (* (@ a y) (@ b y))))
   `(defun pair-add (a b)
      (make-pair
       (+ (@ a x) (@ b x))
       (+ (@ a y) (@ b y))))
   `(defun pair-dist (a b)
      (let ((diff (pair-sub a b)))
	(sqrt (+ (sqr (@ diff x)) (sqr (@ diff y))))))

   `(defun client-pos (e)
      (if (touch-event-p e)
	  (create
	   x (chain e touches 0 client-x)
	   y (chain e touches 0 client-y))
	  (create
	   x (@ e client-x)
	   y (@ e client-y))))
   
   `(defun drag-start (e)
      ;;(print "drag-start")
      ;;(print ai)
      (print (client-pos e))
      ;;(print ai)
      (loop for item in items ;; set active if event target
	 do (if (= (@ e target) (@ item div))
		(progn
		  (setf (@ item active) t)
		  (setf ai item))
		(progn
		  (setf (@ item active) nil))))
      (if ai
	  (setf (@ ai initial) (pair-sub (client-pos e) (@ ai offset)))))
   `(defun avg (a b) (/ (+ a b) 2))
   `(defun touching-tube-p (el)
      (if (eql (@ el class-name) "tube")
	  nil
	  (let* ((tube-place (get-tube-place 0.2))
		 (el-rect (chain el (get-bounding-client-rect)))
		 (el-place (make-pair 
			    (avg (@ el-rect left) (@ el-rect right))
			    (avg (@ el-rect top)  (@ el-rect bottom)))))
	    (> 50 (pair-dist tube-place el-place)))))

   `(defun drag (e)
      ;;(Print e)
      ;;(print (client-pos e 'x))
      ;;(print (client-pos e 'y))
      (if ai
	  (progn
	    (if (or
		 (= (% (@ e buttons) 2) 1) ;; if left button is held
		 (@ e button)) ;; or if um??
		(progn
		  ;;(print ai)
		  (chain e (prevent-default))
		  (setf (@ ai current) (pair-sub (client-pos e) (@ ai initial)))
		  (setf (@ ai offset) (pair-copy (@ ai current)))
		  (css-translate (@ ai current x) (@ ai current y) (@ ai div)))
		(drag-end e)) ;; if mouse let go of off-screen!
	    ;; check if touching tube
	    (if (touching-tube-p (@ ai div))
		(progn
		  (print "tube touch!")
		  (tube-spawn ai)
		  (remove-item ai))))))
   `(defun drag-end (e)
      ;;(print "drag end")
      ;;(print ai)
      ;;(print (client-pos e))
      (if ai
	  (progn
	    (setf (@ ai initial) (pair-copy (@ ai current)))
	    (setf (@ ai active) nil)
	    (setf ai nil))))
   `(defun css-translate (x-pos y-pos el)
      ;;(print x-pos) (print y-pos)
      ;;(setf x-pos (- x-pos 16))
      ;;(setf y-pos (- y-pos 203))
      (setf (chain el style transform) (+ "translate(" x-pos "px," y-pos "px)")))))
