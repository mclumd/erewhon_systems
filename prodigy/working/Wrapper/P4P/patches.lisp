(in-package :user)

;;;;
;;;; This file is a patch file that modifies the perceive function of the
;;;; monitor module of PRODIGY. The changes allow PRODIGY to "pewrceive" the
;;;; environment in two different ways. It can use the old manual method
;;;; whereby the user sets the *sequence* list to a predetermined series of
;;;; adds deletes and no-changes. It can now react to arbitrary environmental
;;;; inputs from other programs that create a data file and a
;;;; ready-file. Explain....
;;;;
;;;; NOTE that eventually we want to change this to sockets.
;;;;


;;; NOTE that this should change *sequence* only if some flag is set. That will
;;; allow PRODIGY to be backward compatible.
;;;
;;; If something goes wrong, at least the system should see the q (quit).
;;;
(setf *sequence* '(t q)) 





;;;
;;; The global var *data-file-name* is from file-fns.lisp (wrapper code). The
;;; function get-file-message is too. The function reads a Lisp object from
;;; *data-file-name*. No longer requiring the file, perceive-from-env deletes
;;; it. This function then returns control to the perceive function (passing t
;;; for the optional argument env-changed-p).
;;; 
;;; Added optional non-blocking argument set to nil by default. When t, the
;;; system does not wait for input. If input does not exist, it
;;; returns. [28jul00 cox]
;;; 
(defun perceive-from-env (&optional non-blocking)
  (format 
   t
   "~%Perceiving from environment~%")
  ;;Changed because get-file-message may now return nil. 
  ;;[28jul00 cox]
  (let ((msg (get-file-message 
	      *ready1-file-name*
	      *data-file-name*
	      non-blocking)))
    (if msg
	(push msg 
	      *senses*) ))
  (delete-file *data-file-name*)
  (format 
   t 
   "~%Deletting READY1 file~%")
  (delete-file *ready1-file-name*)
  (format 
   t 
   "~%Deleting DATA file~%")
  (perceive t non-blocking)
  )



;;; 
;;; Overrides perceive from sensing.lisp in monitors dir.
;;; 
;;; If P4P has created a ready file (signaling that the data file exists), call
;;; perceive-from-env. Perceive-from-env pushes the list of state changes from
;;; the data file onto *senses*, deletes the data and ready files, and calls
;;; perceive with env-changed-p set to t. Control passes back to perceive. This
;;; second time that perceive is called, the probe-file call returns nil. Thus
;;; control passes to the second cond clause. Now the predicate argument is t,
;;; and thus, the *senses* variable is poped. As a result, the env changes are
;;; removed and returned by perceive.
;;; 
;;; Alternatively, if no changes exists when perceive is first called, then no
;;; data file will exist (probe-file returns nil) and env-changed-p is nil. Thus the
;;; third cond clause is executed, returning the first item from *senses*
;;; (i.e., t).
;;;
(defun perceive (&optional 
		 env-changed-p 
		 non-blocking)
  "Get input from *senses* rather than user."
  (cond ((probe-file *ready1-file-name*)
	 (perceive-from-env non-blocking))
	(env-changed-p
	 (pop *senses*))
	(t
	 (first *senses*)))
  )



;;;
;;; Changed to include p4p-p parameter.
;;;
(defun reset (&optional 
	      (do-pause *pause*)
	      (interactive-pause 
	       *interactive-pause*)
	      (p4p-p (and (boundp 
			   '*active-p4p*)
			  *active-p4p*)))
  "Simple function for restarting a new demo."
  (declare (special *pause*)
	   (special *interactive-pause*))
  (setf *done-already* nil)		; Added [5dec97 cox]. Remove later.
  (clear-prod-handlers)
  (add-handler 
   'sense-world				; Made args explicit [1may00 cox]
   :always)				; Ditto.
  ;;Added 19apr00 [cox]
  (if p4p-p
      (add-handler 
       'interpret-new-state 
       :state-change))
  (setf *sensor-count* *sensing-cycle-length*)
  (set-pause do-pause interactive-pause)
  (load-senses)
  )


;;; Taken from monitors/source/sensing.lisp
(defun sense-world (signal)
  "The Prodigy interrupt handler that provides an interface to the environment."
  (cond  ((and *sensing*
	       (= *sensor-count* 0))
	  (setf *sensor-count* *sensing-cycle-length*)
	  (when 
	   *interactive*
	   (format t "~%~%This is the current state ~S" (show-state))
	   (format 
	    t 
	    "~%Enter add (a), del (d), quit-sensing (q), otherwise terminate: "))
	  (let ((delta-list
		 (if *interactive*
		     (read)
		   (perceive 
		    nil
		    (and (boundp '*muliple-PRODIGYs-on*)
			 *muliple-PRODIGYs-on*))))
		(ans nil)
		(action nil))
	    (when (not (or 
			(null delta-list) ;Added [cox 1aug00]
			(eq delta-list t) ;Added [cox 9jun00]
			))
	      (dolist (each-change delta-list)
		(format t "~%each-change: ~S~%" each-change) ;Added [cox 9may00]
		(setf ans (first each-change))
		(case ans
		  ((a) (setf action t))
		  ((d) (setf action nil))
		  ;;If user responds with quit or *senses* empty.
		  ((q nil) (setf *sensing* nil ans nil))
		  (t (setf ans nil)))
		(when ans
		  (if *interactive*
		      (format t "Enter sensed state literal: "))
		  (let ((new-visible 
			 (second each-change)
					;		       (if *interactive* (read)
					;			 (perceive))
			 ))
		    (when new-visible
		      (unless (and (boundp '*muliple-PRODIGYs-on*)
				   *muliple-PRODIGYs-on* ;Added [28jul00 cox]
				   (boundp '*change-state-on*)
				   (not *change-state-on*) ;Added [28jul00 cox]
				   )
			(setf (p4::literal-state-p
			       (p4::instantiate-consed-literal 
				new-visible))
			  action))
		      (if (not *interactive*)
			  (if *monitor-trace*
			      (format t 
				      "~%~a new literal ~S~%" 
				      (if (eq ans 'a) "Adding" "Deleting") 
				      new-visible))
			(format t "This is the new state ~S" (show-state)))
		      ;; Added interrupt signal for new input so that
		      ;; monitors can see the change [12oct97 cox]
		      (prod-signal :state-change 
				   (cons ans (list new-visible)))
		      ))
					;		(sense-world signal)
		  )
		)
	      ;;Added the following [1aug00]
	      (when 
		  (and (boundp '*muliple-PRODIGYs-on*)
		       *muliple-PRODIGYs-on*)
		(create-data-file 
		 nil)
		(create-ready-file 
		 *ready2-file-name*)
		)
	      (format
	       t 
	       "~%INPUT is t~%")))
	  )
	 (*sensing*
	  (setf *sensor-count* (1- *sensor-count*))))
  )



