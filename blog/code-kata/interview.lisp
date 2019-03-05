
;; Programming section of USC (University of south California)
;; ISI (information science institute)
;; interview with Ryan

(ql:quickload :iterate)
(use-package :iterate)
(ql:quickload :str)
(use-package :str)


;; the example production rules
;; first of a rule is the key, the rest is the value
;; strings are terminal elements, symbols are non-terminal
(defvar foo
  '((s np v p)
    (s s "but" s)
    (np dt n)
    (dt "the")
    (dt "a")
    (n "dog")
    (n "cat")
    (vp v np)
    (v "ate")
    (v "chased")))

(defvar english-2
  '((sentence noun-phrase verb noun-phrase)
    (sentence sentence "but" sentence)
    (noun-phrase article noun)
    (noun-phrase article noun)
    (noun-phrase article adjective noun)
    (verb-phrase verb noun-phrase)
    (verb-phrase verb noun-phrase)
    (verb-phrase verb adverb noun-phrase)
    (article "the")
    (article "a")
    (adjective "exquisite")
    (adjective "fat")
    (adjective "hungry")
    (adjective "small")
    (adverb "quickly")
    (adverb "angrily")
    (adverb "slowly")
    (adverb "slowly")
    (noun "dog")
    (noun "cat")
    (noun "corpse")
    (verb "ate")
    (verb "chased")))

(defvar bar
  '((start "done")
    (start start start)))

(iter (repeat 500)
      (maximizing (length (expand '(start) bar))))
(length (expand '(start) bar))

(str:unwords (expand '(sentence) english-2))
(length (expand '(sentence) english-2))

;; pick random element from list
;; (random-choice nil) is nil, for simplicity
(defun random-choice (ls)
  (if (null ls)
      nil
      (nth (random (length ls)) ls)))

;; the heart of the expand function:
;; iterate through the production rules, keep the value
;; (the cdr of the rule) if the key (the car of the rule)
;; matches "top", which is the first element of the input
;; list, which is getting expanded
(random-choice
 (let ((top 's))
  (iter (for (key . value) in foo)
	(if (eql key top)
	    (collect value)))))

(defun assoc-all (item alist)
  (iter (for (key . value) in alist)
	(if (eql key item)
	    (collect value))))

(defun expand (ls grammar)
  (let ((top (car ls)))
    (cond
      ;; if out of symbols, terminate
      ((null ls) nil)
      ;; if it's a terminal symbol, recur down
      ((stringp top) (cons top (expand (cdr ls) grammar)))
      ;; otherwise, expand top and recur on produced list
      (t (expand (append (random-choice (assoc-all top grammar)) (cdr ls))
		 grammar)))))

;; call expand with start token and the example production rules
(expand '(s) foo)

;; post-interview: here's some samples. Almost passes Turing test?
(str:unwords (expand '(s) foo))
"a dog chased" 
"a cat chased" 
"a dog chased but the dog chased but a dog ate but a dog chased" 
"a dog chased" 
"the dog chased" 
"the dog ate but the dog ate but the cat chased" 
"the cat chased" 
"a dog chased but a cat ate but a cat ate" 
"the dog ate" 
"a dog ate but a cat ate but a cat ate but a dog chased but the dog chased but the cat ate" 
"a dog ate" 
"the cat chased but a dog ate" 
"a cat chased but a dog chased but a dog ate" 
"the dog ate but the cat ate" 
"the cat chased but the cat ate but a dog chased but the dog chased but the dog ate but the dog ate" 
"a cat ate" 
"a dog ate" 
"the dog ate but the cat chased but a cat ate but the cat ate but the cat ate but the cat chased but a cat ate but a cat ate but a cat chased but a cat ate but a cat chased but the cat chased but the cat chased but the cat chased but a cat chased but a dog chased but a cat chased but a dog chased but the cat ate but a cat chased but the dog ate but the dog ate but a dog ate but a dog ate but the cat chased but a dog chased but a cat chased but a dog ate but the dog chased but a cat chased but a cat ate but a dog ate but a dog ate but the dog ate but the cat ate but a dog chased but the dog ate but the cat chased but a dog chased but a dog chased but the cat chased but the cat chased but a cat chased but the cat chased but a cat ate but a dog chased but the cat chased but the dog chased but a dog chased but the dog chased but a dog chased but a dog chased but a dog ate but a cat chased" 
