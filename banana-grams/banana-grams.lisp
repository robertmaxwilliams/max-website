(in-package :banana-grams)

;; Step 1 is to build a frequency ordered dictionary (not in the python sense!)
;; of all scrabble words. First, the collins words list is itereated through,
;; keeping any words that match the scrabble list. Then, remaining scrabble
;; words are appended to the end. Excess scrabble words can be left off for
;; less memory consumption


;; word list credit:
;; https://gist.github.com/deekayen/4148741#file-1-1000-txt

(defun normalize-string (string)
  " strips whitespace and uppercase a string "
  (str:trim (string-upcase string)))

(defun file-lines-to-list (filename)
  (with-open-file (s (pathname filename))
    (loop for line = (read-line s nil)
	 until (null line)
	 collect (normalize-string line))))

(defun file-lines-to-hash (filename)
  (let ((lines (make-hash-table :test 'equal)))
    (with-open-file (s (pathname filename))
      (loop for line = (read-line s nil)
	 until (null line)
	 do (setf
	     (gethash (normalize-string line) lines)
	     t)))
    lines))

;;(print
 ;;(subseq
  ;;(sort 
   ;;(file-lines-to-list "1-1000.txt")
   ;;(lambda (a b) (< (length a) (length b))))
  ;;0 5))
  
;; longer dict but more garbage words
;;(defun build-dict ()
;;  (let ((common-words
;;	 (file-lines-to-list "google-10000-english-usa.txt"))
;;	(scrabble-words
;;	 (file-lines-to-hash  "collins-scrabble-words-2015.txt"))
;;	(blacklist '("ET" "ST" "AVE")))
;;    (loop for word in common-words
;;       when (and
;;	     (gethash word scrabble-words)
;;	     (not (member word blacklist :test #'string=)))
;;	 collect word)))

;; depends on bananagrams.asd for get this file location
(defun build-dict ()
  (file-lines-to-list
   (asdf:component-pathname
    (asdf:find-component
     :banana-grams "1-1000.txt"))))

(defparameter *dict* (build-dict))

(defun sorted-string (string)
  (let ((temp-string (copy-seq string)))
    (sort temp-string #'char-lessp)))

;;(defun spells-p (a b)
;;  "takes two strings and checks if one can be arranged into the other"
;;  (and
;;   (= (length a) (length b)) ;; short circuit for performance
;;   (string= (sorted-string a) (sorted-string b))))

(defun spells-p (letters word)
  (setf letters (coerce letters 'list))
  (loop for x in (coerce word 'list)
     if (member x letters)
     do (setf letters (remove x letters))
     else
     return nil
       finally (return t)))

(prove:is (spells-p "pasdfat" "fart") nil)
(prove:is (spells-p "pasdfrat" "fart") t)

(defun possible-words (letters)
  (setf letters (normalize-string letters))
  (loop for word in *dict*
     when (spells-p letters word)
       collect word))

(defun str->ls (string)
  " because im' tired of typing coerce"
  (coerce (normalize-string string) 'list))

(defun str->ls-spaces (string)
  " same as str->ls but preserves surrounding whitespace"
  (coerce (string-upcase string) 'list))

(defun ls->str (ls)
  " because im' tired of typing coerce"
  ;; (normalize-string (coerce ls 'string))) actually, don't want to trim
  (string-upcase (coerce ls 'string)))



(prove:is (ls->str '(#\F #\o #\o)) "FOO" :test #'string=)


;;freqencies from:
;; http://pi.math.cornell.edu/~mec/2003-2004/cryptography/subs/frequencies.html
(defparameter letter-to-freq
  '((#\E . 12.02) 
    (#\T . 9.10) 
    (#\A . 8.12) 
    (#\O . 7.68) 
    (#\I . 7.31) 
    (#\N . 6.95) 
    (#\S . 6.28) 
    (#\R . 6.02) 
    (#\H . 5.92) 
    (#\D . 4.32) 
    (#\L . 3.98) 
    (#\U . 2.88) 
    (#\C . 2.71) 
    (#\M . 2.61) 
    (#\F . 2.30) 
    (#\Y . 2.11) 
    (#\W . 2.09) 
    (#\G . 2.03) 
    (#\P . 1.82) 
    (#\B . 1.49) 
    (#\V . 1.11) 
    (#\K . 0.69) 
    (#\X . 0.17) 
    (#\Q . 0.11) 
    (#\J . 0.10) 
    (#\Z . 0.07)))

(defparameter letter-to-score
  (loop for pair in letter-to-freq
       collect (cons (car pair) (/ (cdr pair)))))

(loop for pair in letter-to-freq
   collect (cons (car pair) (/ 24 (cdr pair))))

(defun n-repeates->score (n)
  " Calculates score multiplier for n repeates of 
a letter that you have to get rid of"
  (expt 1.5 n))

(defun n-occurences (item ls)
  (count-if (lambda (x) (equal x item)) ls))

	
(defun occurences-pairs (ls)
  (let ((graveyard nil))
    (iter (for x in ls)
	  (if (not (member x graveyard :test #'equal))
	      (collect (cons x (n-occurences x ls))))
	  (setf graveyard (cons x graveyard)))))


(occurences-pairs (str->ls "FOOBARROSCO"))

(defun rare-letter-penalty (letters)
  " gives penalty for holding onto rare letters. This doesn't seem to help much"
  (- (iter (for letter-freq in (occurences-pairs (str->ls letters)))
	   (summing (*
		     (/ 24 (cdr (assoc (car letter-freq) letter-to-freq)))
		     (expt 2 (cdr letter-freq)))))))

(rare-letter-penalty "A")
(rare-letter-penalty "AAA")
(rare-letter-penalty "EEE")
(rare-letter-penalty "QQQ")
(rare-letter-penalty "ZZZ")
(rare-letter-penalty "ZJQ")

(defun word-score (word letters)
  " scores a word based on length and usage of rare letters
or letters that you have a lot of. This is critical to the functioning of the AI"
  (+
   (* 0.1 (rare-letter-penalty letters))
   (let ((letters-list (str->ls letters)))
     (loop for x in (str->ls word)
	sum (*
	     (cdr (assoc x letter-to-score))
	     (n-repeates->score (n-occurences x letters-list)))))))
   
(prove:ok (word-score "qfoo" "qffrtw"))

  
;; most of this isn't needed but keeping around anyway
(defun score-compare-maker (letters)
  (lambda (a b)
    (> (word-score a letters) (word-score b letters))))
(defun score-caadr-compare-maker (letters)
  (lambda (a b)
    (> (word-score (caadr a) letters) (word-score (caadr b) letters))))
(defun length> (a b)
  (> (length a) (length b)))
(defun caadr-length> (a b)
  (> (length (caadr a)) (length (caadr b))))
(defun build-on-word (word letters)
  (loop for extra-char in (str->ls word)
     collect (list
	      extra-char 
	      (sort
	       (remove-if-not
		(lambda (string)
		  (find extra-char string))
		(possible-words (str:concat (normalize-string letters) (list extra-char))))
	       #'length>))))
(sort (possible-words "nncieuafte") #'length>)
(sort (build-on-word "acute" "finne") #'caadr-length>)
(build-on-word "cute" "nie")
(print (sort (possible-words "datusesnrntnogtrqiror") #'length>))

(defun print-board (board)
  (format t "~%<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<~%")
  (loop for i from 0 below (array-dimension board 0)
     do (let ((line
	       (coerce 
		(loop for j from 0 below (array-dimension board 1)
		   collect (aref board i j))
		'string)))
	  (if (str:blankp line)
	      nil
	      (format t "|~a|~%" line))))
  (format t ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>~%"))

(print-board (make-array '(3 5) :initial-contents '((#\B #\O #\C #\B #\B)
							      (#\  #\  #\  #\  #\ )
							      (#\B #\B #\B #\B #\B))))

(defun place-word (word coords board is-vertical)
  (destructuring-bind (ii jj) coords
    (loop for char in (str->ls-spaces word)
       for dd from 0
       do (if is-vertical
	      (setf (aref board (+ dd ii) jj) char)
	      (setf (aref board ii (+ dd jj)) char)))))

(defun word-to-regex (word)
  (str:concat ".*" (str:replace-all " " "." (str:trim word)) ".*"))

(prove:is (word-to-regex "   FN D      ") ".*FN.D.*" :test #'string=)

;; the naive way to do this is to try all scramblings of extra-chars and
;; slide across the line... but way too expensive. Instead, search through
;; word dictionary with line like a regex then checking from there

(defun matching-words (word)
  " scans over *dict* looking for words that word could match to"
  (let ((word-scanner (ppcre:create-scanner (word-to-regex word))))
    (iter (for real-word in *dict*)
	  (if (ppcre:scan word-scanner real-word)
	      (collect real-word)))))

(defun remove-spaces (word)
  " removes ALL spaces"
  (ppcre:regex-replace-all " " word ""))




(defstruct banana-line
  (row-or-col nil :type (member nil row col))
  (seq nil :type string)
  (index nil :type integer)
  score) ;; returned by fill-line

(print (make-banana-line :row-or-col 'row :seq "FOO  BAR" :index 7))
	    
(defstruct move
  (line-played nil :type banana-line)
  (letters-consumed nil :type string))

(defun match-strings-ignore-whitespace (holey-word full-word)
  "t if they match, nil if they don't"
  (assert (= (length holey-word) (length full-word)))
  (if (str:blankp holey-word)
      nil
      (iter (for i from 0 below (length holey-word))
	    (if (not (or (char= (aref holey-word i) #\Space)
			 (char= (aref full-word i) (aref holey-word i))))
		(leave nil))
	    (finally (return t)))))


(prove:is (match-strings-ignore-whitespace "FO B R" "FOOBAR") t)
(prove:is (match-strings-ignore-whitespace "FO BR " "FOOBAR") nil)
(prove:is (match-strings-ignore-whitespace "      " "FOOBAR") nil) ;; fix floating word bug
(prove:is-error (match-strings-ignore-whitespace "FOBR" "FOOBAR") 'simple-error)

(defun fill-letters (holey-word full-word letters)
  "returns what letters are left after using the ones 
   needed for filling in holey word.
   hword and fword should be aligned and of the same length"
  ;; note the use of destructive operations on "letters"
  (assert (= (length holey-word) (length full-word)))
  (setf letters (str->ls letters))
  (if (not (str:containsp " " holey-word))
      'failure ;; check if the holey word is already filled in. Can't do that!!
      (if (iter (for i from 0 below (length holey-word))
		(if (char= (aref holey-word i) #\Space)
		    (if (member (aref full-word i) letters)
			(setf letters (delete (aref full-word i) letters :count 1))
			(leave nil)))
		(finally (return t)))
	  (ls->str letters)
	  'failure)))

(defun paste-string (parent child index)
  "paste child over part of parent, like this:"
  ;;(paste-string "lunch with friends" "wins" 6) -> "lunch wins friends")
  (setf parent (copy-seq parent)) ;; avoid weird bugs from modifying original
  (assert (< (+ (length child) index) (length parent)))
  (iter (for i from 0 below (length parent))
	(if (and (>= i index) (< (- i index) (length child)))
	    (setf (aref parent i) (aref child (- i index)))))
  parent)

(prove:is (paste-string "lunch with friends" "wins" 6) "lunch wins friends" :test #'string=)

(prove:is (fill-letters " RA GE" "ORANGE" "OLNL") "LL")
(prove:is (fill-letters " RA GE" "ORANGE" "LNL") 'failure)

(defun slide-match (real-word word letters)
  " takes in a word from dict and a 'word' with holes in it to be filled in
    with letters to make it match the real-word. Returns nil if can't be done,
    else returns list of (completed-word new-letters)"
  ;; patch note: some stuff added to prevent "floating plays"
  ;; that I forgot to check for
  (cons letters nil)
  (iter (for i from 0 below (- (length word) (length real-word)))
	(let ((holey-substring (str:substring i (+ i (length real-word)) word)))
	  (if (match-strings-ignore-whitespace
	       holey-substring
	       real-word)
	      (let ((fill-letters-result ;; sometimes returns 'failure
		     ;; maybe using the conditioning system would be better...
		     (fill-letters holey-substring real-word letters)))
		(if (eql fill-letters-result 'failure)
		    (return nil)
		    (return (list
		       (paste-string word real-word i)
		       fill-letters-result))))))))

(prove:is
 (slide-match "JUNGLE" "    JU  LE    " "FUNGJE")
 '("    JUNGLE    " "FUJE") :test #'equal)
(prove:is (slide-match "JUNGLE" "    JU  LE    " "FE") nil)

(if-let ((x (nth (random 3) '(yes no))))
  x
  'not-sure)

(defun fill-line (line letters)
  " for each real-word, slide along word until all non-whitespaces match.
    if match is found, collect excess letters in real world, and check if 
    they exist in letters. If so, paste real-word onto word, subtract
    used letters, and return."
  (let ((line-word (banana-line-seq line)))
    (iter (for real-word in (matching-words line-word))
	  (if-let ((matching-word-letters
		    (slide-match real-word line-word letters)))
	    (collect
		(list
		 (let ((copied-line (copy-structure line)))
		  (setf (banana-line-seq copied-line) (car matching-word-letters))
		  (setf (banana-line-score copied-line)
			(word-score real-word letters))
		  copied-line)
		 (cadr matching-word-letters)))))))

;; keep around to compare performance in the future
;;(if (spells-p (str:concat (remove-spaces word) letters) real-word)

;; returns list of possible moves given a line and letters
(prove:ok (fill-line (make-banana-line
	    :row-or-col 'row
	    :seq "   WO  N  " 
	    :index 7)
	   "MFAOFLE"))


(defstruct board-letters ;; I really need to work on my struct skills
  board
  letters)

(defun rows-and-cols (board)
  (destructuring-bind (i-dim j-dim) (array-dimensions board)
      (append
       (iter (for j from 0 below j-dim)
	     (let ((maybe-col (ls->str (cl-slice:slice board t j))))
	       (if (not (str:blankp maybe-col))
		   (collect (make-banana-line
			     :row-or-col 'col
			     :seq maybe-col
			     :index j)))))
       (iter (for i from 0 below i-dim)
	     (let ((maybe-row (ls->str (cl-slice:slice board i t))))
	       (if (not (str:blankp maybe-row))
		   (collect (make-banana-line
			     :row-or-col 'row
			     :seq maybe-row
			     :index i))))))))
		 
	
(defun possible-plays (board letters)
  (setf letters (normalize-string letters))
  (sort
   (iter (for line in (rows-and-cols board))
	 (appending (fill-line line letters)))
   (lambda (a b) ;; these are lists of type '(banana-line letters)
     (> (banana-line-score (car a)) (banana-line-score (car b))))))

(defun play-line (bl line-and-letters)
  ;;(print "ummmm")
  ;;(print (board-letters-letters bl))
  ;;(print line-and-letters)
  ;;(print "====")
  (destructuring-bind (line letters) line-and-letters
    (place-word
     (banana-line-seq line) ;;word that gets placed (a whole line here)
     (if (eql (banana-line-row-or-col line) 'row) ;;placement coords
	 (list (banana-line-index line) 0)
	 (list 0 (banana-line-index line)))
     (board-letters-board bl) ;; the board
     (eql (banana-line-row-or-col line) 'col));;is-vertical is true if it is a column
    (setf (board-letters-letters bl) letters)
    bl))

(defun play-line-on-board (board line)
  "like play-line but doesn't care about letters"
  (place-word
   (banana-line-seq line) ;;word that gets placed (a whole line here)
   (if (eql (banana-line-row-or-col line) 'row) ;;placement coords
       (list (banana-line-index line) 0)
       (list 0 (banana-line-index line)))
   board ;; the board
   (eql (banana-line-row-or-col line) 'col));;is-vertical is true if it is a column
  board)


(defun tobool (x)
  " for predicates that return really big stuff sometimes"
  (if x t nil))

(defun validate-board (board)
  (tobool
   (iter (for line in (rows-and-cols board))
	 (always (iter (for word in (str:words (banana-line-seq line)))
		       (always (or
				(= 1 (length word))
				(member word *dict* :test #'string=))))))))


(let ((bl (make-board-letters
	   :board (make-array '(30 80) :initial-element #\Space)
	   :letters "foo")))
  ;; plays the starting word
  (place-word
   "BUTTS"
   '(15 10) (board-letters-board bl) nil)
  (place-word
   "BURN"
   '(15 10) (board-letters-board bl) t)
  (print-board (board-letters-board bl))
  (validate-board (board-letters-board bl)))

(defun copy-board-letters (bl)
  (make-board-letters
   :board (copy-array (board-letters-board bl))
   :letters (copy-seq (board-letters-letters bl))))

;; TODO better score huristics

(defparameter *allow-run* nil)
(defparameter *allow-run* t)

(defparameter *debug-print* t)
(defparameter *debug-print* nil)


(print "=================")

(defun limited-calls (&optional (max-calls 10))
  (let ((n 0))
    (lambda () (progn (incf n)
		      (if (>= n max-calls)
			  nil
			  n)))))

(defparameter foo (limited-calls 10))
(funcall foo)


;; this thing gives me a headache
(defun dfs (bl &optional
		 (solutions-to-find 1)
		 (termination-closure nil))
  " returns number of solutions to find and solutions list"
  ;;(print (board-letters-letters bl))
  
  (if (not *allow-run*) (error "terminating")) ;; love this
  (if *debug-print*
      (progn
	(print-board (board-letters-board bl))
	(print (board-letters-letters bl))
	(format t "Is board valid: ~a~%   --..--"
		(validate-board (board-letters-board bl)))))
  (if (zerop solutions-to-find)
      (list 0 nil)
      (let ((backup (copy-board-letters bl))
	    (found-solutions nil))
	(iter (for play in ;; play is actually a line-and-letters
		   (possible-plays
		    (board-letters-board bl)
		    (board-letters-letters bl)))
	      (if (and termination-closure ;; die if we've been running too long
		       (null (funcall termination-closure)))
		  (error "too many recursive calls to dfs"))
	      (while (> solutions-to-find 0))
	      (setf bl (play-line bl play))

	      (if (validate-board (board-letters-board bl)) ;; check if valid board
		  (if (str:emptyp (board-letters-letters bl)) ;; check if out of letters
		      (progn ;; if found a solution, print, dec and recur
			(format t "Found a solution, ~a left.~%" (1- solutions-to-find))
		        (if *debug-print* (print-board (board-letters-board bl)))
			(destructuring-bind (stf solution-list) ;; modify return values
			    (dfs bl (1- solutions-to-find) termination-closure)
			  (setf solutions-to-find stf)
			  (setf found-solutions
				(cons
				 ;; put the board in there
				 (copy-array (board-letters-board bl)) 
				 (append solution-list found-solutions)))))
		      (progn ;; is board is valid but not solution
			(destructuring-bind (stf solution-list) ;; modify return values
			    (dfs bl solutions-to-find termination-closure)
			  (setf solutions-to-find stf)
			  (setf found-solutions
				(append solution-list found-solutions))))))

	      ;; no matter what, reset and iterate
	      (setf bl
		    (copy-board-letters backup)))
	(list solutions-to-find found-solutions))));;return value

;;(in-package :banana-grams)
(defun peel (letters &optional (n-solutions 1) (max-depth 1000))
  ;; create 2d grid
  (let ((bl (make-board-letters
	     :board (make-array '(30 80) :initial-element #\Space)
	     :letters letters)))

    ;; play a single letter at random then call DFS
    (setf (aref (board-letters-board bl) 15 10) (aref (board-letters-letters bl) 0))
    (setf (board-letters-letters bl) (subseq (board-letters-letters bl) 1))
    (let ((solutions (cadr (dfs bl n-solutions (limited-calls max-depth)))))
      (mapcar #'print-board solutions)
      solutions)))

;;(tobool (member "ET" *dict* :test #'string=))
;;(peel "datusesnrntnogtrqiror")
;;
;;(peel "dogmor")
;;(peel "datusesnrntnogtrqirort" 3)
;;
;;(time (peel "datusesnrntnogtrqirorte"))
;;
;;(peel "qwertyuiopasdfghjklzxcvbnm")
;;(time (peel "qqwuuueeertyuiop"))
