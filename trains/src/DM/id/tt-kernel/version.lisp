;; Time-stamp: <Mon Jan 20 17:22:47 EST 1997 ferguson>

(when (not (find-package :hack))
  (load "hack-def"))
(in-package hack)

(defparameter *system-name* "Trains 96")
(defparameter *version-number* "2.2")
(defparameter *version-number-string* "two point \\!*H*2 two")
(defparameter *version-subnumber* 0)
(defparameter *demo-version* 0)
;;(defparameter *full-system-name* (format nil "~A ~A ~D" *system-name* *version-number* *version-subnumber*))
(defparameter *full-system-name* (format nil "~A ~A" *system-name* *version-number*))
(defparameter *version-string* (format nil "~A Time-stamp: <96/10/31 17:16:13 ferguson>" *full-system-name*))

;; alpha beta gamma delta epsilon zeta eta theta iota kappa lambda mu nu xi 
;; omicron pi rho sigma tau upsilon phi chi psi omega

;; arathorn boromir celeborn durin elrond frodo gandalf h i j k legolas mordor n oliphant peregrin q 
;; radagast sauron tinuviel umbar v w x y z

;; some strings that depend on version

;; Not used, after all that trouble to get Phenelope right...
;;(defparameter *initial-welcome-message*
;;  (format nil "Welcome to ~A version ~A. I'm \\(f^-\"nel-a-pE\\) Dujour, but \\!*H*1.2 you can call me Phenny \\!si30 \\!sf17 ."
;;	  *system-name* *version-number-string*))
(defparameter *initial-welcome-message*
  (format nil "Welcome to ~A version ~A."
	  *system-name* *version-number-string*))
(defparameter *initial-welcome-message-debug*
  (format nil "Welcome to ~A version ~A, debug mode."
	  *system-name* *version-number-string*))

(defparameter *real-welcome-message*
  "Hi, I'm \\!*H*2 Brad. I'm ready to start.")
(defparameter *real-welcome-message-debug*
  "Hi, I'm \\!*H*2 Brad. I'm ready for testing.")

