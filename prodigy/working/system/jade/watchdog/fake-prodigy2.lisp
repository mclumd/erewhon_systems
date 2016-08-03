(in-package "USER")

(format nil "Copyright the MITRE Corporation 1996.  All rights reserved.")

;;; ***************************** PURPOSE ****************************
;;; SMC 3/19/1996.  Simulation of a Prodigy process.
;;; DER 12/4/1997.  Updated to use socket based watchdog.

;;; ************************* MAIN FUNCTIONS *************************
;;; (start-fake-prodigy) - start
;;; (continue-fake-prodigy) - continue after a break
;;; (stop-fake-prodigy) - if exited abnormally

;;; ************************ PROGRAMMER NOTES ************************

;;; ************************ GLOBAL VARIABLES ************************

#|
This code depends on:

watchdog.lisp
sockets/c-interface.lisp
sockets/sock.o
sockets/socket-interface2.lisp
|#


;; SET correct path to
;; Load watchdog code
(load "/fs/parka/rager/tie-prodigy/watchdog/watchdog.lisp")
(use-package :watchdog)


;;; Default port number for Prodigy
(defvar *default-prodigy-port* 3283)


(defvar *prodigy-file-count* 1)
(defvar *input-counter* 1)
(defvar *prodigy-temp-filename* nil)
(defvar *client-data-file* nil)
(defvar *client-stop-file* nil)
(defvar *responses* nil)
(defvar *messages* nil)
(defvar *actions* nil)

(defvar *geographic-location* 'WORLD)


;;; ********************** FUNCTION DEFINITIONS **********************

(defvar *message-counter* 0)

(defclass message ()
  ((id :initform (incf *message-counter*) :initarg :id :accessor id)
   (title :initform "" :initarg :title :accessor title)
   (status :initform :active :initarg :status :accessor status)
   ))

(defclass prodigy-message (message)
  ()
  )

(defun find-message (id)
  (find id *messages* :test #'(lambda (id o) (eq (id o) id)))
  )

(defun find-message-by-text (text)
  (find text *messages* :test #'(lambda (str o) (string= (title o) str)))
  )

(defun make-message (&key id title (status :active))
  (let ((m (make-instance 'prodigy-message
			  :title (or title "")
			  :status status
			  :id (or id (incf *message-counter*)))))
    (push m *messages*)
    m
    ))
    
(defun coerce-to-message (text)
  (or (find-message-by-text text)
      (make-message :title text))
  )

(defun initialize-prodigy (&optional (port *default-prodigy-port*))
  (let (item)
    (setq *prodigy-output-count* 1)
    (setq *responses* nil)
    (setq *messages* nil)
    (setq *actions* nil)
    (setq *input-counter* 1)

    (watchdog:server-init port)
    
    (format t "*******************************************~%")
    (format t "Fake Prodigy initialized, waiting for connection from ForMAT...~%")
    (if (watchdog:server-connect)
	(format t "...ForMAT client connected.~%")
      (format t "...ForMAT client FAILED to connect.~%"))
    (format t "*******************************************~%")
    ))

(defun mark-tasks-completed (tasks)
  (dolist (message *messages*)
    (setf (status message) (if (member (id message) tasks) nil :active))
    ))

(defun format-action-taken? (action &optional (action-list *actions*))
  (find action action-list :test #'(lambda (x o) (eq x (second o))))
  )

(defun actions-after (action &optional (action-list *actions*))
  (cdr (member action action-list :test #'(lambda (x o) (eq x (second o)))))
  )

(defun get-prodigy-response (op arguments)
  (let (responses)
    (case op
      ;; SMC 3/21/1996.  Special case: enable/disable Prodigy tasks.
      (:completed-prodigy-tasks
       (mark-tasks-completed (car arguments))
       )
      (:set-task-status
       ;; SMC 6/26/1996.  Replaces :completed-prodigy-tasks
       (dolist (task (car arguments))
	 (dolist (message *messages*)
	   ;; SMC 6/26/1996.  It would be better to set the task
	   ;; status to exactly what the user has selected.  But to
	   ;; keep "backward compatibility" with older history files,
	   ;; the message is only marked :active if the user hasn't
	   ;; marked it at all.
	   (if (eq (id message) (car task))
	       (return (if (third task)
			   (setf (status message) nil)
			 (setf (status message) :active)))
	     )))
       )
      (:save-default-features
       (let ((features (car arguments)))
	 (dolist (f features)
	   (when (eq (car f) 'GEOGRAPHIC-LOCATION)
	     (setq *geographic-location* (cadr f))
	     (push (coerce-to-message
		    (format nil "Change POD, POD-CC, DEST, and DEST-CC to places in or near ~A"
			    *geographic-location*))
		   responses)
	     ))))
;;;       (:create-tpfdd
;;;        (format t "Create-tpfdd ~A" arguments)
;;;        (push (coerce-to-message
;;; 	      (format nil "Change POD, POD-CC, DEST, and DEST-CC to places in or near ~A in TPFDD ~A"
;;; 		      *geographic-location*
;;; 		      (car arguments)))
;;; 	     responses)
;;;        )
;;;
;;;       (:save-tpfdd
;;;        (push (coerce-to-message "Find some dog teams. Do the following:
;;;          Make a FM query for  FUNCTION = Supply-units
;;;          AND
;;;            Make TPFDD Query for	Desc = \"%DOG%\
;;;         Select General")
;;; 	     responses)
;;;        )
;;;       
      (:save-goals
       (push (coerce-to-message
	      "The goals of PLANC are most similar to this plan.")
	     responses)
       (push (coerce-to-message
	      "The following cases are also relevant: (PLANE).")
	     responses)
;;;        (when (format-action-taken? :create-tpfdd)
;;; 	 (push (coerce-to-message "Make Query for GOAL = SEND-SECURITY-POLICE")
;;; 	       responses)
;;; 	 )
;;;        
       )
      (:check-goal-consistency
       (push (coerce-to-message "Add or create a Force Module to address goal (:SECURE-TOWN-CENTER-HALL
                                              (AIRCRAFT-TYPE NONE)
                                              (FORCE NONE)
                                              (GEOGRAPHIC-LOCATION BOSNIA)
                                              (AC-QUANTITY NONE)
                                              (FORCE-QUANTITY NONE)).")
	     responses)
       (push (coerce-to-message "Remove BRIGADE Force Module from Plan.")
	     responses)
       (push (coerce-to-message
	      "Remove HAWK-BATTALION Force Module from Plan.")
	     responses)
       (push (coerce-to-message
	      "Change SECURITY-POLICE to MILITARY-POLICE.")
	     responses)
       (push (coerce-to-message "Change F-15 to A10A.") responses)
       )
      (:add-child  ;; Used to include :create-fm
       (let ((fmid (second (car arguments)))
	     )
	 (push (coerce-to-message (format nil "Change POD, POD-CC, DEST, and DEST-CC to places in or near ~A in FM ~A" *geographic-location* fmid))
	       responses)
	 ))
      (:copy-fm
       (let ((fmid-mapping (seventh arguments)))
	 (dolist (map fmid-mapping)
	   (push (coerce-to-message (format nil "Change POD, POD-CC, DEST, and DEST-CC to places in or near ~A in FM ~A" *geographic-location* (second map)))
		 responses)
	   )))
      (:add-parent
       (let ((fmid (second (cadr arguments))))
	 (push (coerce-to-message (format nil "Change POD, POD-CC, DEST, and DEST-CC to places in or near ~A in FM ~A" *geographic-location* fmid))
	       responses)
	 ))
      ((:add-fm-feature :change-feature-value)
	 ;; SMC 3/25/1996.  
	 (when (eq 'GEOGRAPHIC-LOCATION (caar arguments))
	   (if (eq op :add-fm-feature)
	       (setq *geographic-location* (cadar arguments))
	     (setq *geographic-location* (third arguments)))
	   (push (coerce-to-message (format nil "Change POD, POD-CC, DEST, and DEST-CC to places in or near ~A in FM ~A" *geographic-location* (second arguments)))
		 responses)
	 ))
      )
    ;; SMC 3/25/1996.  Only return messages that are active.
    (remove-if-not #'status responses)
    ))


(defun process-input ()
  (let ((message (watchdog:watchdog-read-message)))
    (when message
	  (print message)
	  (cond
	   ((equal message :STOP) ;; STOP message received
	    (watchdog:server-disconnect)
	    (watchdog:server-shutdown)
	    (format t "Fake Prodigy Done.~%")
	    (format t "Received STOP command from client.~%")
	    (format t "~%~%Type :exit to exit Lisp.~%~%")	 
	    :STOP)

	   ((and (consp message) (eq (first message) :reconnect)
		 (numberp (second message)))
	    (watchdog:watchdog-resend-messages (second message))
	    nil)
	    
	   (t
	    (let (response output)
	      (cond ((eq message :EOF)
		     (resume-prodigy-server))
		    ((eq message nil) 
		     nil)
		    (t
		     (format t "Read input message ~D~%" 
			     watchdog::*watchdog-received-message-count*)
		     (format t "Action found: ~S~%" message)
		     (setq response (get-prodigy-response 
				     (second message) (cddr message)))
		     (when response
			   (format t "sending output message ~D~%" 
				   (1+ watchdog::*watchdog-sent-message-count*))
			   (setq output (format nil "(:ON-ACTION ~S~%" message))
			   (dolist (out response)
				   (setq output 
					 (concatenate 
					  'string output
					  (format nil "(:MESSAGE ~D ~S)~%)~%"
						  (id out)(title out)))))
			   (watchdog:watchdog-send-message output :convert nil)
			   )))))
	   ))))


;;; Reset and wait for new connection
(defun resume-prodigy-server ()
  (format t "Lost connection with ForMAT client.~%")
  (format t "Please reconnect to Prodigy from ForMAT.~%")
  (format t "Waiting for connection from ForMAT...~%")
  (watchdog:server-resume)
  (format t "...ForMAT client connected.~%")
  (format t "Requesting messages since message ~D~%" 
	  watchdog::*watchdog-received-message-count*)
  )

(defun stop-fake-prodigy ()
  (watchdog:server-shutdown)
  )
  

(defun read-format-input ()
  (let ((counter 1)
	res)
    (loop
     (setq res (process-input))
     (if (eq res :STOP) (return))
     (incf counter)
     (if (= (mod counter 100) 0)
	 (format t "~D read cycles completed.~%" counter))
     (sleep 1)
     )))

(defun init-demo ()
  (setq *geographic-location* 'BOSNIA)
  )

(defun start-fake-prodigy (&optional port)
  (init-demo)
  (initialize-prodigy)
  (read-format-input)
  )


(defun continue-fake-prodigy ()
  (read-format-input)
  )

(defun lf ()
  (load
   "/NFS/ai/systems/cbr/format1.4.1/source/ties/prodigy/fake-prodigy.lisp")
  )

(format t "


****************************************************
To Start, enter the command (start-fake-prodigy)
To interrupt, type CTRL-C 
To continue after interrupting:
  - at the USER() prompt, enter the command :pop
  - enter the command (continue-fake-prodigy)
To quit:
  - if exited abnormally do (stop-fake-prodigy) to close server streams
  - at the USER() prompt, type :exit
****************************************************

")

