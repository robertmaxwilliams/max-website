---
layout: post
title: Emacs Defun Custom Syntax
---

In common lisp, it's fairly common to come up with your own variations on `defun`. For instance,
I might make the following macro, which prints out a function's name before calling `defun` as
usual:


    (defmacro defun5 (function-name &body rest)
      (format t "~%You defined ~a to be a fuction! Good job!~%" function-name)
      `(defun ,function-name ,@rest))

And now I can use it:

    (defun5 add-one (a)
            (1+ a))

    >> You defined FOO to be a fuction! Good job!

Which all good, except that emacs doesn't highlight defun5 as a keyword, and it doesn't highlight
add-one as a function name. This makes it hard to parse code that uses these custom `defun`-like
constructs. I looked in the syntax file for `lisp-mode` (`lisp-mode.el`) and found the following
code:

    (list nil
         (purecopy (concat "^\\s-*("
                   (eval-when-compile
                     (regexp-opt
                      '("defun" "defmacro"
                                    ;; Elisp.
                                    "defun*" "defsubst" "define-inline"
                    "define-advice" "defadvice" "define-skeleton"
                    "define-compilation-mode" "define-minor-mode"
                    "define-global-minor-mode"
                    "define-globalized-minor-mode"
                    "define-derived-mode" "define-generic-mode"
                    "ert-deftest"
                    "cl-defun" "cl-defsubst" "cl-defmacro"
                    "cl-define-compiler-macro" "cl-defgeneric"
                    "cl-defmethod"
                                    ;; CL.
                    "define-compiler-macro" "define-modify-macro"
                    "defsetf" "define-setf-expander"
                    "define-method-combination"
                                    ;; CLOS and EIEIO
                    "defgeneric" "defmethod")
                                  t))
                   "\\s-+\\(" lisp-mode-symbol-regexp "\\)"))
         2)

So it seems that somehow I need to add a form consisting of a regular expression matching my
function to the syntax highlighting. After hours of learning regular expressions and consulting the
good word of the emacs manual, I came up with this:

    (font-lock-add-keywords 'lisp-mode
                '(("^\\s-*(defun5\\s-+\\(\\(\\(?:\\sw\\|\\s_\\|\\\\.\\)+\\)\\)" 2 font-lock-function-name-face)
                  ("^\\s-*(\\(defun5\\)" 1 font-lock-keyword-face)))

Figuring out that this process is known by the strange name "font lock" took as long as anything
else. Then hardest part was noticing the `1` and `2` that could be used as the second argument. They seem
to take the nth return from the regular expression, so that it can match `defun5` to find the
function's name, then discard the part of the match that is `defun5`. Regular expressions are
confusing.  

Anyway I finally came up with this code to keep in my `init.el`:

    (defvar defun-variants '(defun5 defmulticlosure def-url-fun))
    (defvar defun-variants-str (mapcar #'symbol-name defun-variants))

    (font-lock-add-keywords 'lisp-mode
                (list (list
                       (concat "^\\s-*("
                           (regexp-opt defun-variants-str t)
                           "\\s-+\\(\\(\\(?:\\sw\\|\\s_\\|\\\\.\\)+\\)\\)")
                       2 'font-lock-function-name-face)
                      (list
                       (concat "^\\s-*(\\("
                           (regexp-opt defun-variants-str t)
                           "\\)")
                       1 'font-lock-keyword-face)))


So now I can add arbitrary defun-like function! Now the issue is that the don't indent like `defun`
does.

In the same `lisp-mode.el` I found the following about indentation, among many similar forms:

    (put 'progn 'lisp-indent-function 0)
    (put 'prog1 'lisp-indent-function 1)
    (put 'prog2 'lisp-indent-function 2)

So it seems that you use `put` and the `lisp-indent-function` to register a symbol as one that needs
special indentation. So let's add that behavior to `init.el` as well, using `'defun` as the
argument:


    (dolist (defun-variant defun-variants)
      (put defun-variant 'lisp-indent-function 'defun))


And it works! And it only took six hours! Isn't it wonderful being able to customize your text
editor? `:\`

I'm afraid I'm going to find out there was a command like "register-keyword" or something that was
here all along. Even so, all was not for naught because I learned something and forgot to eat
dinner and I have finals to study for oh no.


