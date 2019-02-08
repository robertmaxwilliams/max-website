
;; programming stuff for everything I know how to do in
;; my linear algebra class

(defun |#"-reader| (stream sub-char numarg)
  (declare (ignore sub-char numarg))
  (let (chars)
    (do ((prev (read-char stream) curr)
         (curr (read-char stream) (read-char stream)))
        ((and (char= prev #\") (char= curr #\#)))
      (push prev chars))
    (coerce (nreverse chars) 'string)))

(set-dispatch-macro-character
  #\# #\" #'|#"-reader|)

(print #"hi ther e"#)


;; reader macro to convert octave matri notation to
;; actual matrix
;; #[1 2 3; 4 5 6] -> #( #(1 2 3) #(4 5 6))

(defun |#[]-reader| (stream sub-char numarg)
  (declare ignore sub-char numarg)
  (let (chars)
