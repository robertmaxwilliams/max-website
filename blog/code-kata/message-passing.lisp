
;; implement erlang style message objects
;; without CLOS
;; Next challenge will be to possibly use CLOS
;; also use make it use mutiple (but not one per object)
;; OS threads and add networking capabilities so objects can be on
;; multiple different computers

;; So how does an erlang thing work? It has a message queue,
;; and stored functions that are called, and local only memory.
(ql:quickload :iterate)
(ql:quickload :str)
(use-package :iterate)

;; standard newline constant
(defvar *n* (format nil "~%"))

;; (name . lambda) alist call, like `.`
(defun @ (object method &rest args)
    " user facing multilambda call, with &rest style args"
    (apply (cdr (assoc method object)) args))

;; alist call but args is a list instead of rest
(defun @@ (object method args)
    " same as @ but args is a list and required"
    (apply (cdr (assoc method object)) args))

(defun p (&rest args)
  " python style printing"
  (if args
      (progn
	(format t "~a " (if (stringp (car args))
				     (str:replace-all "\n" *n* (car args))
				     (car args)))
	(apply #'p (cdr args)))
      (format t "~%")))


;; forgot how to spell queueue
(defun kyu-maker ()
  (let* ((kyu nil)
	(tail (last kyu)))
    (list
     (cons 'push
	   (lambda (x)
	     (if (null kyu)
		 (p (setq tail (push x kyu)))
		 (progn
		   (nconc tail (list x))
		   (setf tail (cdr tail))))
	     kyu))
     (cons 'pop
	   (lambda () (pop kyu))))))

;; show off how kyu
(defvar foo (kyu-maker))
(@ foo 'push 4)
(@ foo 'pop)

;; alist: name, closure
;; this holds closures that return processes
(defparameter messengers* nil)
;; alist: pid, process
;; active processes, 
(defparameter processes* nil)

;; (p (macroexpand-1
;;  '(defmessenger-helper 
;;    ((x 1)
;;     (y 2))
;;    ((foo (lambda (a) (incf x a)))
;;     (bar (lambda (a b) (incf x a) (decf y b)))))))

;; use defmessenger to define a messenger closure into messengers*
(defmacro defmessenger-helper (let-forms functions)
  "functions is a list of (name (lambda ...)) forms"
  `(lambda ()
     (let* ,let-forms
       (let ((funs* nil)
	     (kyu* (kyu-maker)))
	 (setq funs*
	       (list ,@(iter (for (name lam) in functions)
			     (collect `(cons (quote ,name) ,lam)))))
	 (list
	  (cons 'send (lambda (fun &rest args)
			(@ kyu* 'push (list fun args))))
	  (cons 'step (lambda ()
			(let ((top (@ kyu* 'pop)))
			  (if top
			      (destructuring-bind (fun args) top
				(@@ funs* fun args))
			      :empty-kyu)))))))))


(defmacro defmessenger (name let-forms functions)
  `(push
    (cons (quote ,name) (defmessenger-helper ,let-forms ,functions))
    messengers*))
       

;; use spawn to spawn an instance of a messenger
(defun spawn (messenger-name)
  (let ((pid (gensym)))
    (push 
     (cons
      pid
      (@ messengers* messenger-name))
     processes*)
    pid))

(defmessenger bar
    ((x 1)
     (y 2))
  ((foo (lambda (a) (incf x a)))
   (bar (lambda (a b) (incf x a) (decf y b)))))


(defun get-process (pid)
  (cdr (assoc pid processes*)))

(defvar some-pid (spawn 'bar))
(@ (get-process some-pid) 'send 'foo 1)
(@ (get-process some-pid) 'step)

;; it works!
;; now to build ping pong example from erlang docs in this new paradignm


