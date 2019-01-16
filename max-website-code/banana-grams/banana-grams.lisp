(ql:quickload :str) ;; str is never :use'd in a pacakge, access by prefix
(ql:quickload :alexandria)
(ql:quickload :iterate)

;;(delete-package :banana-grams)
(defpackage :banana-grams
  (:use :cl :alexandria :iterate))
(in-package :banana-grams)

;; Step 1 is to build a frequency ordered dictionary (not in the python sense!)
;; of all scrabble words. First, the collins words list is itereated through,
;; keeping any words that match the scrabble list. Then, remaining scrabble
;; words are appended to the end. Excess scrabble words can be left off for
;; less memory consumption

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
(defvar ofoo (file-lines-to-hash  "collins-scrabble-words-2015.txt"))
(gethash "BUTTS" ofoo)

(file-lines-to-list "google-10000-english-usa.txt")
(file-lines-to-list "collins-scrabble-words-2015.txt")

  
(defun build-dict ()
  (let ((common-words
	 (file-lines-to-list "google-10000-english-usa.txt"))
	(scrabble-words
	 (file-lines-to-hash  "collins-scrabble-words-2015.txt")))
    (loop for word in common-words
       when (gethash word scrabble-words)
	 collect word)))

(defparameter *dict* (build-dict))
(defparameter *all-scrabble*
  (file-lines-to-list "collins-scrabble-words-2015.txt"))

(nth 6888 *dict*)

(defun sorted-string (string)
  (let ((temp-string (copy-seq string)))
    (sort temp-string #'char-lessp)))

(defun spells-p (a b)
  "takes two strings and checks if one can be arranged into the other"
  (and
   (= (length a) (length b)) ;; short circuit for performance
   (string= (sorted-string a) (sorted-string b))))

(defun spells-p (letters word)
  (setf letters (coerce letters 'list))
  (loop for x in (coerce word 'list)
     if (member x letters)
     do (setf letters (remove x letters))
     else
     return nil
       finally (return t)))

(spells-p "pasdfat" "fart")
(spells-p "pasdfrat" "fart")
	   

(defun possible-words (letters)
  (setf letters (normalize-string letters))
  ;;(loop for word in *all-scrabble*;;*dict*
  (loop for word in *dict*
     when (spells-p letters word)
       collect word))

(defun str->ls (string)
  " because im' tired of typing coerce"
  (coerce (normalize-string string) 'list))

(defun str->ls-spaces (string)
  " because im' tired of typing coerce"
  (coerce (string-upcase string) 'list))

(defun ls->str (ls)
  " because im' tired of typing coerce"
  ;; (normalize-string (coerce ls 'string))) actually, don't want to trim
  (string-upcase (coerce ls 'string)))



(concatenate 'string "foo" (list #\o))
(str:concat "foo" (list #\o))
(ls->str '(#\F #\o #\o))


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

(defun n-repeates->score (n)
  " Calculates score multiplier for n repeates of 
a letter that you have to get rid of"
  (expt 1.5 n))
;;(mapcar #'n-repeates->score '(0 1 2 3 4))

(defun n-occurences (item ls)
  (count-if (lambda (x) (equal x item)) ls))

;; internally uses all capitol chars
(n-occurences #\O (str->ls "foooo"))

(defun word-score (word letters)
  " scores a word based on length and usage of rare letters
or letters that you have a lot of"
  (setf letters (str->ls letters))
  (loop for x in (str->ls word)
     sum (*
	  (cdr (assoc x letter-to-score))
	  (n-repeates->score (n-occurences x letters)))))

(word-score "qfoo" "ffrtw")

  
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

(find #\f "oo")
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
(print (sort (build-on-word "signature" "dtnsrrrnotoq") #'caadr-length>))

(print (sort (possible-words "datusesnrntnogtrqiror") (score-compare-maker "")))
;; picked equations
(print (sort (build-on-word "equations" "sdntrrgntror")
	     (score-caadr-compare-maker "sdntrrgntror")))
;; picked grounds on u
(print (sort (build-on-word "equations" "trntrr")
	     (score-caadr-compare-maker "trntrr")))
;; picked rent on e
(print (sort (build-on-word "equations" "trr")
	     (score-caadr-compare-maker "trr")))
;; dead end?

" I think I have an idea of how this could work now. Start with a blank grid 
of chars, and choose a first word. Then, choose a word to go on it. Choose a 
place within the placed chars and try to build on it. Check if everything placed
is still a valid word. If that succeeds, repeat until either out of letters (and return success) or letters can't be used up (failure). On failure, step back up and try oother options. Alternatively, try random choices all the way down, as in monte carlo tree search. This might be a much simpler algorithm and won't have to worry about depth/breadth"


(defun print-board (board)
  (format t "~%<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<~%")
  (loop for i from 0 below (array-dimension board 0)
     do (format t "|")
       do (loop for j from 0 below (array-dimension board 1)
	     do (format t "~a" (aref board i j)))
     do (format t "|~%"))
  (format t ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>~%"))

(print-board (make-array '(2 5) :initial-contents '((1 2 3 4 5)
						    (1 2 3 6 4))))


(defun place-word (word coords board is-vertical)
  (destructuring-bind (ii jj) coords
    (loop for char in (str->ls-spaces word)
       for dd from 0
       do (if is-vertical
	      (setf (aref board (+ dd ii) jj) char)
	      (setf (aref board ii (+ dd jj)) char)))))

(defun nonempty-coords (board)
  (loop for i from 0 below (array-dimension board 0)
       append (loop for j from 0 below (array-dimension board 1)
		 when (not (equal #\Space (aref board i j)))
		   collect (list i j))))
  
(print "asda")

(iter (for i from 0 below 5)
      (collect i))

(defun rows (board)
  (destructuring-bind (di dj) (array-dimensions board)
    (iter (for i from 0 below di)
	  (collect (iter (for j from 0 below dj)
			 (collect (aref board i j)))))))


;; introducing the lingo "line" to mean
;; a string representing a row or column in a banan board

(defun word-to-regex (word)
  (str:concat ".*" (str:replace-all " " "." (str:trim word)) ".*"))

(word-to-regex "   FN D      ")

(ql:quickload "cl-ppcre")
(cl-ppcre:parse-string "a[a-z]")
(cl-ppcre:scan "WA..LE" "WAFFLE")
(cl-ppcre:regex-replace-all "(?i)fo+" "foo Fooo FOOOO bar" "frob" :preserve-case t)
(cl-ppcre:regex-replace-all "o" "foo Fooo FOOOO bar" "p")
(cl-ppcre:regex-replace-all "^ " "   WA  LE" ".")
(cl-ppcre:regex-replace-all " " "   WA  LE" ".")

(format t "~r" (/ 100000000 (expt 10 16) ))


(let ((ptrn (ppcre:create-scanner "BAN")))
  (ppcre:scan ptrn "xaaabd"))

    
;; the naive way to do this is to try all scramblings of extra-chars and
;; slide across the line... but way too expensive. Instead, search through
;; word dictionary with line like a regex... maybe using regex will improve
;; performance.  

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
  score ;; returned by fill-line
  )

(print (make-banana-line :row-or-col 'row :seq "FOO  BAR" :index 7))
	    
(defstruct move
  (line-played nil :type banana-line)
  (letters-consumed nil :type string))



;; depreciated
(defun fill-line (word letters)
  (iter (for real-word in (matching-words word))
	(if (spells-p (str:concat (remove-spaces word) letters) real-word)
	    (collect real-word))))

;; version that takes in a line struct
;; and returns a list of pairs of '(line letters-leftover)
(ql:quickload :prove)


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
(delete #\E (list #\F #\E #\O #\E) :count 1)
(delete #\R (list #\F #\E #\O #\E) :count 1)

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

(paste-string "lunch with friends" "wins" 6)

(fill-letters " RA GE" "ORANGE" "OLNL")
(fill-letters " RA GE" "ORANGE" "LNL")

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

(fill-line (make-banana-line
	    :row-or-col 'row
	    :seq "   WO  N  " 
	    :index 7)
	   "MFAOFLE")

(+ (* 4/24 5/25) (* 5/24 20/25))

(ql:quickload :cl-slice)

(defstruct board-letters
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
  (print line-and-letters)
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

;;(defparameter ford (make-array '(30 80) :initial-element #\Space))
(peel "datusesnrntnogtrqiror")

(defun peel (letters)
  ;; create 2d grid
  (let ((bl (make-board-letters
	     :board (make-array '(30 80) :initial-element #\Space)
	     :letters letters)))
    ;; plays the starting word
    (place-word
     (car (sort (possible-words letters) (score-compare-maker "")))
     '(15 10) (board-letters-board bl) nil)
    (print "Rows and cols: ")
    ;;
    (print (cadr (possible-plays (board-letters-board bl) (board-letters-letters bl))))
    (print-board (board-letters-board bl))
    (setf bl (play-line
	      bl
	      (car (possible-plays (board-letters-board bl) (board-letters-letters bl)))))
    (print-board (board-letters-board bl))
    (setf bl (play-line
	      bl
	      (car (possible-plays (board-letters-board bl) (board-letters-letters bl)))))
    (print-board (board-letters-board bl))))

(peel "datusesnrntnogtrqiror")
  ;; place first word randomly, bias toward better words

  ;; scan over all placed chars, seeing the best word to build on each one
  ;; try each of these, see if any overlap to create non-words

  ;; if placement was successful, repeat until out of letters or stuck

  ;; if stuck, return 'failed

(peel "datusesnrntnogtrqiror")
