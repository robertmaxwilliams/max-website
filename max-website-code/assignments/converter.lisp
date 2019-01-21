
(defun usd-to-something (currency amount)
  (case currency
    (usd (* 1 amount)) ;; values from first row
    (gbp (* 1.8264 amount))
    (cad (* 0.949938 amount))
    (eur (* 1.46849 amount))
    (aud (* 0.861801 amount))
    (otherwise (error 'bad-input))))

(defun something-to-usd (currency amount)
  (case currency
    (usd (* 1 amount)) ;; values from column
    (gbp (* 0.54752 amount))
    (cad (* 1.0527 amount))
    (eur (* 0.680967 amount))
    (aud (* 1.16036 amount))
    (otherwise (error 'bad-input))))

(defun something-to-something (input-currency output-currency amount)
  (usd-to-something
   input-currency
   (something-to-usd output-currency amount)))

;;(something-to-something 'usd 'gbp 1)
;;(something-to-something 'gbp 'aud 1)

(defun money-to-english (n)
  (format nil "~r dollars and ~r cents."
	  (floor n)
	  (round (* 100 (rem n 1)))))

(ql:quickload :parse-float)
(ql:quickload :str)

;; basically what this program does
;;(parse-float:parse-float "1.5777usd" :junk-allowed t)
;;(subseq "1.5777udd" 6)

(define-condition user-quits (error) ())

(defun convert-from-user (&optional (english-mode nil))
  (let ((user-input (read-line)))
    (if (string-equal user-input "q")
	(error 'user-quits))
    (multiple-value-bind (amount end-index) 
	(parse-float:parse-float user-input :junk-allowed t)
      (if (not amount) (error "please enter a number followed by currency"))
      (let ((input-currency
	     (read-from-string (subseq user-input end-index))))
	(if (not (member input-currency '(usd gbp cad eur aud)))
	    (error "bad input currency, try usd gbp cad eur or aud"))
	(loop for out-currency in '(usd gbp cad eur aud)
	   do (format t "~,2f ~a in ~a is ~a~%"
		      amount
		      input-currency
		      out-currency
		      (funcall
		       (if english-mode
			   #'money-to-english
			   (lambda (x) (format nil "~,2f" x)))
		       (something-to-something
			input-currency out-currency amount))))))))


(defun money-repl (&optional (english-mode nil))
  (format t "~%Enter money: ")
  (handler-case
      (convert-from-user english-mode)
    (user-quits (c)
      (format t "quitting because ~a" c)) ;;quit
    (t (c)
      (format t "Got an exception: ~a~%" c)
      ;;(values 0 c)
      (money-repl english-mode)) ;; recur
    (:no-error (x)
      (declare (ignore x))
      (money-repl english-mode)))) ;;recur

(money-repl t)
