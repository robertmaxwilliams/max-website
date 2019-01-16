
(ql:quickload :vecto)

(defpackage #:vecto-examples
  (:use #:cl #:vecto))

(in-package #:vecto-examples)


(defparameter sc 10)
(defun radiant-lambda (file)
  (with-canvas (:width (* sc 90) :height (* sc 90))
    (let ((font (get-font "times.ttf"))
          (step (/ pi 7)))
      (set-font font (* sc 40))
      (translate 45 45)
      (draw-centered-string 0 (* sc -10) #(#x3BB))
      (set-rgb-stroke 1 0 0)
      (centered-circle-path 0 0 (* sc 35))
      (stroke)
      (set-rgba-stroke 0 0 1.0 0.5)
      (set-line-width (* sc 4))
      (dotimes (i 14)
        (with-graphics-state
          (rotate (* i step))
          (move-to (* sc 30) 0)
          (line-to (* sc 40) 0)
          (stroke)))
      (save-png file))))

(radiant-lambda "foo.png")
