
(defun square-bar-moment (width height)
  (/ (* width (expt height 3)) 12))
(defun hollow-square-tube-moment (width thickness)
  (let ((inner-width (- width (* 2 thickness))))
    (- (square-bar-moment width width)
       (square-bar-moment inner-width inner-width))))

(hollow-square-tube-moment 1 0.065)

(defun deflection (&key length area-moment force modulo-elasticity)
  (/ (* (expt length 3) force)
     (* 48 area-moment modulo-elasticity)))

(deflection
  :length 96 ;; 96 inches long
  :area-moment (* 3 (hollow-square-tube-moment 1 0.065)) ;; area moment of intertia
  :force 500 ;; lbs
  :modulo-elasticity 29700000) ;; modulo elasticity for stell (psi)
