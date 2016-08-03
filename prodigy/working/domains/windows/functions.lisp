;;;; 
;;;; This file contains some of the function specific to Kerkez, Srinivas, & Cox (in press)
;;;; 


(defvar *p4p-threshhold* 3
  "The number of windows at which the screen is considered cluttered.")


(defun diff (x y)
  (not (eq x y)))

;;; 
;;; Predicate above-thresh-p returns t if the number of windows "on" the screen
;;; SCR is above *p4p-threshhold*
;;; 
(defun above-thresh-p ()
  (let ((counter 0))
    (dolist (each-window
		(all-the-instances 'WINDOW))
      (if (true-in-state
	   `(on ,each-window 
		,(p4::object-name-to-object 
		  'SCR
		  *current-problem-space*)))
	  (setf counter (+ 1 counter))))
    (>= counter
	*p4p-threshhold*))
  )

;;; 
;;; Function test-candidate-window returns t if the argument wind (a prodigy
;;; window object) is either an empty window whose function is input2user
;;; (i.e., the View_Window) or a window whose function is input2PRODIGY (i.e.,
;;; the Load_Window).
;;; 
;;; The function is called to establish the window binding <w> in inference
;;; rule infer-no-clutter.
;;; 
(defun test-candidate-window (wind)
  (if (above-thresh-p)
      (cond ((and 
	      (true-in-state
	       `(has-function 
		 ,wind
		 ,(p4::object-name-to-object 
		   'input2user
		   *current-problem-space*))
	       )
	      (true-in-state
	       `(is-empty 
		 ,wind))
	      )
	     t)
	    ((true-in-state
	      `(has-function 
		,wind
		,(p4::object-name-to-object 
		  'input2PRODIGY
		  *current-problem-space*))
	      )
	     t)
	    )
    )
  )




;;; OBSOLETE and NOT USED
#+obsolete
(defun gen-candidate-windows (wind)
  (let ((winds (all-the-instances 'WINDOW))
	(b-list nil)
	)
    (when (>= (length winds) threshhold)
      (dolist (each-window
		  winds)
	(if (true-in-state
	     `(has-function ,each-window 
			    ,(p4::object-name-to-object 
			      'input2user
			      *current-problem-space*))
	     )
	    (push
	     (cons wind
		   each-window)
	     b-list))
	)
      b-list)
    )
  )


