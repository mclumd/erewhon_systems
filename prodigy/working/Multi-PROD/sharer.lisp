(in-package :user)

(load "/usr/local/mcox/Research/PRODIGY/Wrapper/P4P/fake-P4P.lisp")
(load "/usr/local/mcox/Research/PRODIGY/Multi-PROD/multiple.lisp")
(load "/usr/local/mcox/Research/PRODIGY/Multi-PROD/patches.lisp")
(load "/usr/local/mcox/Research/PRODIGY/Multi-PROD/socket-specific.lisp")


;;; The following value should be nil for one-way communication, t otherwise.
(setf *use-monitors-p* t)

(setf *active-p4p* nil)
(setf *muliple-PRODIGYs-on* t)

;;; The following 2 need not be done in one-way communication. 
(setf *interactive-pause* nil)
(setf *pause* nil)

(defvar *change-state-on* t)

#|

(defvar *data2-file-name*
  "/tmp/data2.txt")

(defvar *ready3-file-name*
  "/tmp/ready3.txt")


(defvar *ready4-file-name*
  "/tmp/ready4.txt")


(defun fake-P4P (&optional
		 (sequence 
		  *p4p-sequence*)
		 non-blocking)
  (format t "~%Fake P4P WAITING~%")
  (do ((delta (first sequence) 
	      (first sequence)))
      ((or (null sequence)
	   (and non-blocking
		(not (probe-file
		      *ready2-file-name*))))
       nil)
    (ready *ready2-file-name*)		;Wait until PRODIGY is ready.
    (delete-file *ready2-file-name*)
    (pop sequence)			;cannot perform the pop in the var list
					;of the do funct because the last 
					;element of the list will not be used.
    (create-data-file
     (list delta)
     *data-file-name*)
    (create-ready-file 
     *ready1-file-name*)
    )
  )




;;; The following 3 defuns need not be done in one-way communication. 
(defun perceive-from-env (&optional non-blocking)
  (format 
   t
   "~%Perceiving from environment~%")
  ;;Changed because get-file-message may now return nil. 
  ;;[28jul00 cox]
  (let ((msg (get-file-message 
	      *ready3-file-name*
	      *data2-file-name*
	      non-blocking)))
    (if msg
	(push msg 
	      *senses*) ))
  (delete-file *data2-file-name*)
  (format 
   t 
   "~%Deletting READY1 file~%")
  (delete-file *ready3-file-name*)
  (format 
   t 
   "~%Deleting DATA file~%")
  (perceive t non-blocking)
  )



(defun perceive (&optional 
		 env-changed-p 
		 non-blocking)
  "Get input from *senses* rather than user."
  (cond ((probe-file *ready3-file-name*)
	 (perceive-from-env non-blocking))
	(env-changed-p
	 (pop *senses*))
	(t
	 (first *senses*)))
  )


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
		 nil
		 *data2-file-name*)
		(create-ready-file 
		 *ready4-file-name*)
		)
	      (format
	       t 
	       "~%INPUT is t~%")))
	  )
	 (*sensing*
	  (setf *sensor-count* (1- *sensor-count*))))
  )

|#



(setf *world-path* "/usr/local/users/mcox/Research/PRODIGY/Wrapper/P4P/domains/")
(domain 'sharer)
(problem 'sharer)
(output-level 3)


;;; The following need not be done in one-way communication. 
;;; 
;;; Now within do-session
;(reset)




(if (y-or-n-p "Run Session Now? ")
    (do-session)
  )
