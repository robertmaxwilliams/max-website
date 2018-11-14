
;; some basic experiments in unstructured looping usuing goto



(defun sum (n)
  (declare (optimize (speed 3)
		     (safety 0)
		     (space 3)
		     (compilation-speed 0)))
  (declare (integer n))
  (loop for i from 1 to n sum i))

(sum 5)
(disassemble #'sum)


(defun foo (n)
  (declare (optimize (speed 3)
		     (safety 0)
		     (space 3)
		     (compilation-speed 0)))
  (declare (integer n))
  (* 2 n))

(foo 1)


(defun foo (n)
  (declare (optimize (speed 3)
		     (safety 0)
		     (space 3)
		     (compilation-speed 0)))
  (declare (integer n))
  (* 2 n))

(disassemble #'foo)
"
; disassembly for FOO
; Size: 23 bytes. Origin: #x10019898F9
; 8F9:       488BD0           MOV RDX, RAX                    ; no-arg-parsing entry point
; 8FC:       BF02000000       MOV EDI, 2
; 901:       B904000000       MOV ECX, 4
; 906:       FF7508           PUSH QWORD PTR [RBP+8]
; 909:       B8F8963120       MOV EAX, #x203196F8             ; #<FDEFN ASH>
; 90E:       FFE0             JMP RAX
"

(defun bar (val)
  (declare (optimize (speed 3)
		     (safety 0)
		     (space 3)
		     (compilation-speed 0)))
  (declare (integer val))
  (tagbody
     (setq val 1)
     (go point-a)
     (incf val 16)
   point-c
     (incf val 04)
     (go point-b)
     (incf val 32)
   point-a
     (incf val 02)
     (go point-c)
     (incf val 64)
   point-b
     (incf val 08))
  val)

(bar 3)

(disassemble #'bar)

"
; disassembly for BAR
; Size: 29 bytes. Origin: #x1001989969
; 69:       B802000000       MOV EAX, 2                       ; no-arg-parsing entry point
; 6E:       B806000000       MOV EAX, 6
; 73:       B80E000000       MOV EAX, 14
; 78:       B81E000000       MOV EAX, 30
; 7D:       488BD0           MOV RDX, RAX
; 80:       488BE5           MOV RSP, RBP
; 83:       F8               CLC  ; clear carry flag
; 84:       5D               POP RBP
; 85:       C3               RET
"






(defun bar (val)
  (declare (optimize (speed 3)
		     (safety 0)
		     (space 3)
		     (compilation-speed 0)))
  (declare (integer val))
  (tagbody
     (setq val 1)
     (go point-a)
     (incf val 16)
   point-c
     (incf val 04)
     (go point-b)
     (incf val 32)
   point-a
     (incf val 02)
     (go point-c)
     (incf val 64)
   point-b
     (incf val 08))
  val)

(bar 3)

(disassemble #'bar)

(defun str-insert (c i str)
  (concatenate 'string (subseq str 0 i) (string c) (subseq str (1+ i))))
(str-insert #\. 1 "asdf")


(defun dotty-printy (pos val)
  (format t
	  (str-insert #\x (* 2 pos) " [ ( ] ) a = ~a~%")
	  val))


(dotty-printy 0 3)
(dotty-printy 1 4)


;; creating the famous [(])
(defun rosco (val)
  (tagbody
     (dotty-printy 0 val)
   point-a               ;; [

     (dotty-printy 1 val)
     (incf val)
     (dotty-printy 1 val)

  point-b                ;; (

     (dotty-printy 2 val)
     (incf val)
     (dotty-printy 2 val)

     (if (> 5 val)
	 (progn
	   (format t "Jump to [~%")
	   (go point-a))) ;; ]

     (dotty-printy 3 val)

     (if (> 10 val)
	 (progn
	   (format t "Jump to (~%")
	   (go point-b))) ;; )

     (dotty-printy 4 val)
     (format t "end~%~%")
     )
     val)

(rosco -20)

(defun recursive-ackermann (m n)
  (cond ((zerop m) (1+ n))
	((zerop n) (recursive-ackermann (1- m) 1))
	(t (recursive-ackermann (1- m) (recursive-ackermann m (1- n))))))
(recursive-ackermann 2 2)

(defun recursive-factorial (n)
  (cond ((= 1 n) 1)
	(t (* n (recursive-factorial (1- n))))))

(defun tail-recursive-factorial (n &optional (p 1))
  (cond ((= 1 n) p)
	(t (tail-recursive-factorial (1- n) (* p n)))))


(defun goto-factorial (n)
  (let (result)
    (tagbody
       (setf result 1)
     start
       (setf result (* result n))
       (setf n (1- n))
       (if (> n 1)
	   (go start)))
    result))

(defun trash (arg)
  (declare (ignore arg)))

(get-internal-run-time)
(time (trash (tail-recursive-factorial (expt 3 11))))
(time (trash (recursive-factorial (expt 3 11))))
(time (trash (goto-factorial (expt 3 11))))

(defun addup2 (n) 
  (labels ((f (acc k)
              (if (= k 0)
                   acc 
                   (f (+ acc k) (- k 1)))))
  (f 0 n)))

       

(disassemble #'rosco)

(defparameter *my-string* (string "Groucho Marx"))
 (char *my-string* 11)
(setf (char *my-string* 6) #\y)
(print *my-string*)

  
(macroexpand-1 '(goif 8 n))



(defun quux (n)
  (prog ((index n) (acc 0))
   start
   0
   (incf acc 0)
   1
   (incf acc 1)
   2
   (incf acc 2)
   3
   (incf acc 3)
   4
   (incf acc 4)
   5
   (incf acc 5)
   6
   (incf acc 6)
   7
   (incf acc 7)
   (incf index)
   (goif 8 index)
   8
   (return acc)))

(quux 3)
   


(defmacro goif (limit var)
  "ponounced with the vowel of 'oil'. "
  `(cond ,@(loop for i from 0 below limit
	      collect `((= ,var ,i) (go ,i)))
	 (t (go ,limit))))

(defmacro tag-ladder (limit var)
  "god will not forgive us but we have HIS name"
  `(prog ((index ,var) (acc 0))
      ,@(loop for i from 0 below limit
	   collect i
	     collect `(incf acc ,i))
      (incf index)
      (goif ,limit index)
      ,limit
      (return acc)))


(tag-ladder 4 3)
