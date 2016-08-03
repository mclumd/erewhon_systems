(in-package :user)

(defvar *other-PROD-Stopped* nil "When t, only one of the two PRODIGYs are still running.")

(defvar *env-socket* nil "Communication between sharer and accepter now goes thru this.")
(defvar *passive-socket* nil "The actual socket for the application that calls wait-4-socket-connect.")

(defvar *sock-port* 5566 "Keep this different than the ones used by other Lab Programs.")


;;; 
;;; Needed so that when re-running a session, the defvars are reset.
;;; 
(defun init-vars ()
  (setf *other-PROD-Stopped* nil)
  )


(defun wait-4-socket-connect (&optional
			      (port
			       *sock-port*))
  (setf *env-socket*
    (socket:accept-connection 
     (setf
	 *passive-socket*
       (socket:make-socket 
	:connect :passive 
	:local-port port))))
  )

(defun connect-2-socket (&optional
			 (port
			  *sock-port*))
  (setf *env-socket* 
    (socket:make-socket :remote-host "cheops" 
		 :remote-port port))
  )


(defun close-socket (&optional
		     (socket
		      *env-socket*))
  (close socket)
  (if *passive-socket*
      (close *passive-socket*))
  )


(defun fake-P4P (&optional
		 (sequence 
		  *p4p-sequence*)
		 non-blocking)
  (if (not non-blocking)
      (format t "~%Fake P4P WAITING~%"))
  (do ((delta (first sequence) 
	      (first sequence)))
      ((or (null sequence)
;	   (and non-blocking
;		(not (listen *env-socket*)))
	   )
       nil)
    (do ()
	((or
	  non-blocking
	  (listen *env-socket*))))	;Wait until PRODIGY is ready.
;   (ready *ready4-file-name*)		;Wait until PRODIGY is ready.
;   (delete-file *ready4-file-name*)
    (pop sequence)			;cannot perform the pop in the var list
					;of the do funct because the last 
					;element of the list will not be used.
    (format *env-socket*
	    "~S~%"
	    delta)
    (force-output *env-socket*)
;    (create-data-file
;     (list delta)
;     *data2-file-name*)
;    (create-ready-file 
;     *ready3-file-name*)
    )
  )


(defun ready (&optional 
	       (socket *env-socket*))
  (do ()
      ((listen socket)
       t))
  )


;;; 
;;; Added optional non-blocking argument set to nil by default. When t, the
;;; system does not wait for input. If input does not exist, it
;;; returns. [28jul00 cox]
;;; 
(defun get-socket-msg (&optional 
			   (socket *env-socket*)
			   non-blocking
			   &aux
			   request)
  (if *other-PROD-Stopped*
      'DONE
    (when (if non-blocking
	      (listen socket)
	    (ready socket))
      (cond ((or (eq (setf request (read socket))
		     'run-request)
		 (eq request
		     'savep-request))
	     (let* ((obj-list (read socket))
		    (state-list (read socket))
		    (goal-list (read socket))
		    )
	       (values request obj-list state-list goal-list)
	       ))
	    (t				;Will handle case for p4p-agent
	     request)
	    )
      ))
  )


;;; The following 3 defuns need not be done in one-way communication. 
(defun perceive-from-env (&optional non-blocking)
  (format 
   t
   "~%Perceiving from environment~%")
  ;;Changed because get-file-message may now return nil. 
  ;;[28jul00 cox]
  (let ((msg (get-socket-msg
	      *env-socket*
	      non-blocking)))
    (if msg
	(push msg 
	      *senses*) ))
;  (delete-file *data2-file-name*)
;  (format 
;   t 
;   "~%Deletting READY1 file~%")
;  (delete-file *ready3-file-name*)
;  (format 
;   t 
;   "~%Deleting DATA file~%")
  (perceive t non-blocking)
  )


(defun perceive (&optional 
		 env-changed-p 
		 non-blocking)
  "Get input from *senses* rather than user."
  (cond ((listen *env-socket*)
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
	    (format t "~%delta list: ~S~%" delta-list)
	    (when (not (or 
			(null delta-list) ;Added [cox 1aug00]
			(eq delta-list t) ;Added [cox 9jun00]
			(eq delta-list 'DONE) ;Added [cox 16aug00]
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
	      #|
	      (when 
		  (and (boundp '*muliple-PRODIGYs-on*)
		       *muliple-PRODIGYs-on*)
		(create-data-file 
		 nil
		 *data2-file-name*)
		(create-ready-file 
		 *ready4-file-name*)
		 )
		 |#
	      (format
	       t 
	       "~%INPUT is t~%"))
	    (if (eq delta-list 'DONE)
		(setf *other-PROD-Stopped*
		  t)))
	  )
	 (*sensing*
	  (setf *sensor-count* (1- *sensor-count*))))
  )

