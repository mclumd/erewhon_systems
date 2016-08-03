(unless (find-package "FRONT-END")
  (make-package "FRONT-END" :nicknames '("FE") :use '("LISP" "P4")))

(in-package "FRONT-END")

;;; Moved from prodigy-patch.lisp [22jul98 cox]
(use-package :watchdog)

(export '(start-prodigy-front-end continue-prodigy-front-end))

(format nil "Copyright the MITRE Corporation 1996.  All rights reserved.")

;;; ****************************** FILE ******************************
;;;
;;;			      FRONT-END.LISP
;;;
;;;
;;; ***************************** HISTORY ****************************
;;;
;;; Comments by DER are David Rager's from U.Maryland (now with BBN).
;;; Comments by SMC are Steve Christey's from Mitre.
;;; Comments by COX are Michael Cox's from CMU.
;;;
;;; SMC 3/19/1996.  Simulation of a Prodigy process.
;;;
;;; COX 6/17/1998. Hardly can be considered a simulation of Prodigy. This code
;;; was part of the "fake-prodigy" code that Steve Coley of Mitre has
;;; originally created. I started with this and turned it into a front-end to
;;; the Prodigy system so that it could accept input from ForMAT and write to
;;; ForMAT suggestions for plan modification.
;;;
;;; COX Summer 1996 Left this file mostly intact with the following changes:
;;; 
;;; Commented out function start-fake-prodigy and replaced it with a more 
;;; suitably named function (i.e., start-prodigy-front-end). Ditto on
;;; continue-fake-prodigy --> continue-prodigy-front-end. I also changed the 
;;; message to the user that is printed at load-time appropriately (see format 
;;; statement at bottom of file).
;;;
;;; Commented out function get-prodigy-response and redefined it and its 
;;; calling convention in file prodigy-suggestions.lisp. Changed the call to it
;;; in the body of function process-input.
;;;
;;; Added call of reset-domain in the body of function initialize-prodigy.
;;;
;;; Changed the name of the file from fake-format.lisp to front-end.lisp. The 
;;; code does, after all, perform this function. That is, it loops looking for
;;; ForMAT output and inputs the information into Prodigy if found.
;;;
;;; 21oct97 Changed the code in function process-input to handle delayed
;;;         Prodigy responses due to waits on ratio reports. [cox]
;;;
;;; 8-27oct Modified start-prodigy-front-end.
;;;
;;; 30mar & 
;;; 11apr98 Added connection icon. [cox]
;;;
;;; 13apr98 Modified process-input to save format input to a history
;;;         file. [cox]
;;; 13apr &
;;; 16jun98 Included redefined functions. Search for #+original. Also modified
;;;         process-input in file prodigy-patch.lisp to write to a history file
;;;         so that ForMAT input can be saved to the file. The file is opened
;;;         by function read-format-input (found below) and is named by this
;;;         function's auxiliary variable format-history-filename.
;;;
;;; 17jun98 Removed the message specific code to a new file
;;;         (messages.lisp). [cox]
;;;
;;; 22jul98 Moved code from prodigy-patch.lisp that had been modified (by Rager
;;;         originally). Moved support code along with it. E.g., moved
;;;         start-prodigy-front-end function and the new variable
;;;         *default-prodigy-port*. [cox]
;;;



;;; ********************* GLOBAL VARIABLES AND PARAMETERS *********************

;;; Added [18jun98 cox]
(defparameter *history-directory*
  (concatenate
   'string
   *format-directory*
   "history/")
  "Directory where histories of input received 
   from ForMAT for each run are stored.")


;;; [cox 11apr98]
(defparameter *connect-file* 
  (concatenate 'string *format-directory* "watchdog/watchdog-xbiff")
  "When file exists, it signals that the front end has connected with ForMAT.")


;;; Default port number
;;;
(defvar *default-prodigy-port* 3283
  "The port through which ForMAT and Prodigy communicate.")


;;; [cox 16apr98]
(defvar *xbiff-already-loaded* nil
  "Global flag so function initialize-prodigy knows not 
   to exec another xbiff if one is already done.")



(defvar *prodigy-file-count* 1)
(defvar *input-counter* 1)
(defvar *prodigy-temp-filename* nil)
(defvar *client-data-file* nil)
(defvar *client-stop-file* nil)
(defvar *basename* nil)
(defvar *prodigy-output-count* 0	;Added [cox 17jun98]
  "0 is a value the counter shound 
   never have after it is initialized.") 
(defvar *responses* nil)
(defvar *actions* nil)

;;;
;;; The program no longer uses this variable. See *current-destination* in file
;;; prodigy-suggestions.lisp.
;;;
;(defvar *geographic-location* 'WORLD) 

;;; ********************** FUNCTION DEFINITIONS **********************

;;;
;;; Function init-front-end-globals initializes the PRODIGY/ForMAT
;;; interfaceglobal variables. 
;;; 
;;; This function used to be called init-front-end and was located in
;;; transformations.lisp. It included a call to set-problem which is now within
;;; the reset-domain function. [cox 17jun98]
;;; 
(defun init-front-end-globals ()
  ;;The following block of assignments used to be part of the
  ;;initialize-prodigy function.
  (setq *prodigy-output-count* 1)
  (setq *responses* nil)
  (setq *messages* nil)
  (setq *actions* nil)
  (setq *input-counter* 1)

  (setf *case-candidates* nil)		;Added [cox 17jun98]
  (setf *current-destination* *unknown-destination*)
  (setf *best-matches* nil)
  (setf *max-cover-set* nil)
  (setf *coverage-length-list* nil)
  (setf *dependency-list* nil)
  (setf *latest-ForMAT-goals* nil)
  (setf *extraneous-goals-list* nil)
  (setf *bad-FM-children* nil) ; Added [cox 9mar98]
  )
  



;;; NOTE that this function is redefined in watchdog/prodigy-patch.lisp
#+original
(defun initialize-prodigy (&optional (basename "/tmp/PRODIGY"))
  (let (item)
    (setq *basename* basename)
    (setq *client-data-file* (format nil "~A.client" basename))
    (setq *client-stop-file* (format nil "~A.client.STOP" basename))
    (setq *prodigy-output-count* 1)
    (setq *responses* nil)
    (setq *messages* nil)
    (setq *actions* nil)
    (setq *input-counter* 1)
    (init-front-end-globals)
    (reset-domain			;Added mcox 10/13jun96
     (if *JADE-demo-p*			;Added mcox 28apr98
	 'jade
       'tfs))
    (format t "*******************************************~%")
    (format t "Prodigy Front End initialized, looking for data in~%~A.~%"
	    basename)
    (format t "*******************************************~%")
    ))

(defun initialize-prodigy (&optional (port *default-prodigy-port*)
				     (domain-name 'user::tfs)
				     called-from-ui)
  (let (item)
    ;; The file could have been left on disk if the program previously
    ;; crashed. [16jun98 cox]
    (if (probe-file *connect-file*)
	(delete-file *connect-file*))
    (if (not (boundp 'user::*alt-stream*))
	(load (concatenate 
	       'string 
	       user::*system-directory*
	       "ui/lisp-source/shell.lisp")))
    (if (not user::*alt-stream*)
	(user::init-shell user::*alt-stream* 'user::*alt-stream*))
;    (setq *basename* basename)
;    (setq *client-data-file* (format nil "~A.client" basename))
;    (setq *client-stop-file* (format nil "~A.client.STOP" basename))
    (init-front-end-globals)
    (reset-domain domain-name)          ;Added [cox 10/13jun96]
    (init-current-pop)			;Added [cox 27apr98]
    (init-maps)				;Added [cox 20may98]
    (when *Use-Case-Replay*		;Added [cox 21may98]
	  (load-analogy-if-needed 	;[cox 6jun98]
	   called-from-ui)
	  (user::domain domain-name)
	  (user::set-problem nil)
	  (p4::load-problem (current-problem) nil))

    ;; DER 12 Dec 97 - Initialize the watchdog server 
    (when watchdog::*watchdog-running*
	  (watchdog::server-shutdown))

    (watchdog:server-init port)
    ;; [30mar98 cox]
    (if (or (not (boundp 'user::*alt-stream*))
	    (null user::*alt-stream*))
	(user::init-shell user::*alt-stream* 
			  'user::*alt-stream*))
    ;; [30mar98 16apr98 cox]
    (when (not *xbiff-already-loaded*)
	  (user::send-shell 
	   (format
	    nil
	    (concatenate
	     'string 
	     "xbiff "
	     "-file ~s "
	     "-update 5 "
	     "-geometry 65x65 "
	     "-xrm \"xbiff*iconName\:WatchDog\" "
	     "-xrm \"xbiff*fullPixmap\:~a\" "
	     "-xrm \"xbiff*emptyPixmap\:~a\" & ")
	    *connect-file*
	    (concatenate
	     'string 
	     *format-directory* 
	     "Watch.dog/format-tree.bm")
	    (concatenate
	     'string 
	     *format-directory* 
	     "Watch.dog/prodigy.bm")
	    )
	   user::*alt-stream*)
	  (setf *xbiff-already-loaded* t))
    (format t "*******************************************~%")
    (format t "Prodigy/CBMIP initialized, 
waiting for connection from ForMAT...~%")
    (do ((stop nil))
	(stop)
	(when (watchdog:server-connect)
	      ;; [30mar98 cox]
	      (with-open-file 
	       (out *connect-file*
		    :direction :output
;		    :if-exists :overwrite
;		    :if-does-not-exist :create
		    )
	       (format out "Prodigy/CBMIP connects with ForMAT.~%")
	       )
	      (format t "...ForMAT client connected.~%")
	      (Setf stop t)
	      )
	;(format t "...ForMAT client FAILED to connect.~%"))
	(format t "."))
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

;(defun get-prodigy-response (op arguments)
;  (let (item
;	action-items
;	match
;	responses)
;    (case op
;      ;; SMC 3/21/1996.  Special case: enable/disable Prodigy tasks.
;      (:completed-prodigy-tasks
;       (mark-tasks-completed (car arguments))
;       )
;      (:save-default-features
;       (let ((features (car arguments)))
;	 (dolist (f features)
;	   (when (eq (car f) 'GEOGRAPHIC-LOCATION)
;	     (setq *geographic-location* (cadr f))
;	     (push (coerce-to-message
;		    (format nil "Change POD, POD-CC, DEST, and DEST-CC to places in or near ~A"
;			    *geographic-location*))
;		   responses)
;	     ))))
;;;;       (:create-tpfdd
;;;;        (format t "Create-tpfdd ~A" arguments)
;;;;        (push (coerce-to-message
;;;; 	      (format nil "Change POD, POD-CC, DEST, and DEST-CC to places in or near ~A in TPFDD ~A"
;;;; 		      *geographic-location*
;;;; 		      (car arguments)))
;;;; 	     responses)
;;;;        )
;;;;
;      (:save-tpfdd
;       (push (coerce-to-message "Find some dog teams. Do the following:
;         Make a FM query for  FUNCTION = Supply-units
;         AND
;           Make TPFDD Query for	Desc = \"%DOG%\
;        Select General")
;	     responses)
;       )
;      (:save-goals
;       (push (coerce-to-message
;	      "The goals of PLANE are most similar to this plan.")
;	     responses)
;       (when (format-action-taken? :create-tpfdd)
;	 (push (coerce-to-message "Make Query for GOAL = SEND-SECURITY-POLICE")
;	       responses)
;	 ))
;      (:check-goal-consistency
;       (push (coerce-to-message "Remove Hawk Force Module from Plan")
;	     responses)
;       (push (coerce-to-message "Change F-16s to F-15s") responses)
;       )
;      (:add-child  ;; Used to include :create-fm
;       (let ((fmid (second (car arguments)))
;	     )
;	 (push (coerce-to-message (format nil "Change POD, POD-CC, DEST, and DEST-CC to places in or near ~A in FM ~A" *geographic-location* fmid))
;	       responses)
;	 ))
;      (:copy-fm
;       (let ((fmid-mapping (seventh arguments)))
;	 (dolist (map fmid-mapping)
;	   (push (coerce-to-message (format nil "Change POD, POD-CC, DEST, and DEST-CC to places in or near ~A in FM ~A" *geographic-location* (second map)))
;		 responses)
;	   )))
;      (:add-parent
;       (let ((fmid (second (cadr arguments))))
;	 (push (coerce-to-message (format nil "Change POD, POD-CC, DEST, and DEST-CC to places in or near ~A in FM ~A" *geographic-location* fmid))
;	       responses)
;	 ))
;      ((:add-fm-feature :change-feature-value)
;       ;; SMC 3/25/1996.  
;       (if (eq 'GEOGRAPHIC-LOCATION (caar arguments))
;	   (push (coerce-to-message (format nil "Change POD, POD-CC, DEST, and DEST-CC to places in or near ~A in FM ~A" *geographic-location* (second arguments)))
;		 responses)
;	 ))
;      )
;    ;; SMC 3/25/1996.  Only return messages that are active.
;    (remove-if-not #'status responses)
;    ))

;;; NOTE that this function is redefined in watchdog/prodigy-patch.lisp
#+original
(defun process-input (&optional called-from-ui)
  (cond
    ((probe-file *client-stop-file*)
     (with-open-file (out (format nil "~A.server.STOP" *basename*)
			  :direction :output)
       (format out "Prodigy front-end Done.~%")
       )
     (format t "Received STOP command from client.~%")
     :STOP)
    ((probe-file *client-data-file*)
     (let (item
	   current-actions
	   current-messages)
       (with-open-file (w *client-data-file*)
	 (loop
	  (setq item (read w nil nil))
	  (if (not item) (return))
	  (push item *actions*)
	  (push item current-actions)
	  ))
       (format t "Reading input file # ~D~%" *input-counter*)
       (incf *input-counter*)
       (setq current-actions (nreverse current-actions))
       (format t "Actions found: ~S~%" current-actions)
       (dolist (a current-actions)
	 (if (setq item (get-prodigy-response a called-from-ui
;					      (second a) (cddr a) ; These are now auxilliary vars.
					      ))
	     ;; Added the alternative action for the case when Prodigy is
	     ;; performing a delayed response to a :copy-fm command. See
	     ;; comments in file prodigy-suggestions.lisp around variable
	     ;; definition of *alt-available*. [21oct97 cox]
	     (cond (*alt-available*
		    (push (list *old-action* item) current-messages)
		    (setf *alt-available* nil)
		    (setf *old-action* nil))
		   (t
		    (push (list a item) current-messages))))
	 )
       (delete-file *client-data-file*)
       (when current-messages
         ;;Added "suggestion," [20oct97 cox]
	 (format t "Writing output suggestion, file # ~D~%" *prodigy-output-count*)
	 (setq *prodigy-temp-filename*
	       (format nil "~A.prodigy.temp.~A"
		       *basename*
		       *prodigy-output-count*))
	 (with-open-file (out *prodigy-temp-filename* :direction :output)
	   (dolist (c current-messages)
	     (format out "(:ON-ACTION ~S~%" (car c))
	     (dolist (x (cadr c))
	       (format out " (:MESSAGE ~D ~S)~%" (id x) (title x))
	       )
	     (format out ")~%")))
	 (rename-file *prodigy-temp-filename*
		      (format nil "~A.server.~A"
			      *basename*
			      *prodigy-output-count*))
	 (incf *prodigy-output-count*)
	 )
       ))))


;;;
;;; 4 Dec 1997 DER - Added socket watchdog code.  Now format messages come 
;;; one at a time.
;;;
;;; Made run-prodigy an optional parameter passed from
;;; (start-prodigy-front-end) call, so that user can disable the planning from
;;; scratch process during testing. This is useful if running under
;;; Solaris. [cox 8mar98]
;;;
(defun process-input (&optional 
		      called-from-ui 
		      (run-prodigy t) 
		      history
		      )
  (let ((message (watchdog::watchdog-read-message)));; read message
    (when message
	  (when sockfig::*trace-ipc* (print message))
	  (cond 
	   ((eq message :stop);; Stop message received
	    (watchdog:server-disconnect)
	    (watchdog:server-shutdown)
	    (format t "Received STOP command from client.~%")
	    ;; [cox 11apr98]
	    (if (probe-file *connect-file*)
		(delete-file *connect-file*))
	    :STOP)

	   ;; handle a reconnection request for past messages
	   ((and (consp message) (eq (first message) :reconnect)
		 (numberp (second message)))
	    (watchdog::watchdog-resend-messages (second message))
	    nil)

	   (t
	    (let (response output current-message)
	      (cond ((eq message :EOF)
		     (resume-prodigy-server))
		    ((eq message nil) 
		     nil)
		    (t
		     (format t "Read input message ~D~%" 
			     watchdog::*watchdog-received-message-count*)
		     (format t "Action found: ~S~%" message)
		     ;; Save to global history file. See front-end.lisp. [cox 13apr98]
		     (format history "~s~%" message)
		     (setq response (get-prodigy-response message 
							  called-from-ui
							  run-prodigy))

		     (when response
			   (cond (*alt-available*
				  (setq current-message (list *old-action* response))
				  (setf *alt-available* nil)
				  (setf *old-action* nil))
				 (t
				  (setq current-message (list message response))))
			   (format t "sending output suggestion, message set ~D~%" 
				   (1+ watchdog::*watchdog-sent-message-count*))	
		   (setq output (format nil "(:ON-ACTION ~S~%" (car current-message)))
		   (dolist (out (second current-message))
			   (setq output 
				 (concatenate 
				  'string output
				  (format nil "(:MESSAGE ~D ~S ~S)~%"
					  (id out)(title out)
					  ;; [cox 13apr98]
					  (args out)
					  )))
			   ;;[cox 12&17apr 16jun98]
			   (when (not (displayed-2-user out))
				 (setf (displayed-2-user out) t)
				 (format t 
					 "Prodigy Suggestion: ~S~%" 
					 (title out))
				 (user::send-shell
				  (format nil 
					  "xterm -geometry 48x10+100+100 -title \"PRODIGY Suggestions\" -n \"Suggestions\" -sb  -e ~Ajade/Watch.dog/show-file2.sh ~S &" 
					  user::*system-directory* (title out))
;				  (format nil
;					  "xterm -geometry 48x10+100+100 -title \"PRODIGY Suggestions\" -n \"Suggestions\" -sb  -e /afs/cs/user/mcox/prodigy/working/system/jade/Watch.dog/show-file2.sh ~S &" (title out))
				  user::*alt-stream*))
			   )
		   (setq output 
			 (concatenate 
			  'string output
			  (format nil ")~%"
				  )))
		   (watchdog::watchdog-send-message output :convert nil)
			   )))))
	   ))))



;;; New function to resume a broken connection - DER
(defun resume-prodigy-server ()
  (format t "Lost connection with ForMAT client.~%")
  (format t "Please reconnect to Prodigy from ForMAT.~%")
  (format t "Waiting for connection from ForMAT...~%")
  (watchdog:server-resume)
  (format t "...ForMAT client connected.~%")
  (format t "Requesting messages since message ~D~%" 
	  watchdog::*watchdog-received-message-count*)
  )


;;;
;;; Made run-prodigy an optional parameter of start-prodigy-front-end, so that
;;; user can disable the planning from scratch process during testing. 
;;; [cox 8mar98]
;;;
(defun read-format-input (&optional 
			  called-from-ui
			  (run-prodigy t)
			  &aux
			  (format-history-filename
			     (concatenate
			      'string
			      *history-directory*
			      "PRODIGY.history."
			      (format nil "~s" (get-universal-time))))
			  )
  (let ((counter 1)
	res)
    ;; [cox 13apr98]
    (with-open-file
     (history format-history-filename :direction :output)
    (loop
     (setq res (process-input called-from-ui run-prodigy 
			      ;; Added [cox 13apr98]
			      history
			      ))
     (when (eq res :STOP)
	   (return))
     (if called-from-ui
	 ;;Send signal to Tcl
;	 (user::send-to-tcl " & & & ")
	 (user::ping)
       )
     (incf counter)
     (if (= (mod counter 100) 0)
	 (format t "~D read cycles completed.~%" counter))
     (sleep 1)
     ))))

;(defun start-fake-prodigy (&optional (basename "/tmp/PRODIGY"))
;  (initialize-prodigy basename)
;  (read-format-input)
;  )

;;; Better name for the function start-fake-prodigy.
;;;
;;; NOTE that this function is redefined in watchdog/prodigy-patch.lisp
;;;
#+original
(defun start-prodigy-front-end (&optional
				called-from-ui
				(basename "/tmp/PRODIGY"))
  (initialize-prodigy basename)
  (setf *ratio-reports* nil) ;;Added 8oct97 [cox]
  (setf *current-oplan* nil) ;;Added 20oct97 [cox]
  (setf *old-args* nil)      ;;Added 20oct97 [cox]
  (setf *old-action* nil)    ;;Added 21oct97 [cox]
  (setf *alt-available* nil) ;;Added 21oct97 [cox]
  (read-format-input called-from-ui)
  ;; The following clause send "hi" to the UI so that the flush_socket tcl
  ;; procedure can remove all previous input that was generated (mainly & & &
  ;; continuation strings) during a ForMAT-Prodigy demo. That is, it searches
  ;; until it finds the terminating "hi" string. [27oct97 cox]
  (if called-from-ui
      (user::ping))
  )


;;;
;;; Made run-prodigy an optional parameter of start-prodigy-front-end, so that
;;; user can disable the planning from scratch process during testing. With
;;; parameter *Use-Case-Replay* (file transformations.lisp) is true, Prodigy
;;; will plan in analogical mode, otherwise it will be generative mode. [cox
;;; 8mar98]
;;;
;;; This version was in file prodigy-patch.lisp
;;;
(defun start-prodigy-front-end (&optional
				called-from-ui
				(run-prodigy t)
				(domain-name (if *JADE-demo-p*
						 'user::jade
					       'user::tfs))
				(port *default-prodigy-port*))
				
  (initialize-prodigy port domain-name called-from-ui)
  (setf *ratio-reports* nil) ;;Added 8oct97 [cox]
  (setf *current-oplan* nil) ;;Added 20oct97 [cox]
  (setf *old-args* nil)      ;;Added 20oct97 [cox]
  (setf *old-action* nil)    ;;Added 21oct97 [cox]
  (setf *alt-available* nil) ;;Added 21oct97 [cox]
  (read-format-input called-from-ui run-prodigy)
  ;; The following clause sends the string "hi" to the UI so that the
  ;; flush_socket tcl procedure can remove all previous input that was
  ;; generated (mainly & & & continuation strings) during a ForMAT-Prodigy
  ;; demo. That is, it searches until it finds the terminating "hi"
  ;; string. [27oct97 cox]
  (if called-from-ui
      (user::ping))
  )



;(defun continue-fake-prodigy ()
;  (read-format-input)
;  )

;;; Better name for this function too.
(defun continue-prodigy-front-end ()
  (read-format-input)
  )

(format t "


****************************************************
To Start, enter the command (start-prodigy-front-end)
To interrupt, type CTRL-C 
To continue after interrupting:
  - at the USER() prompt, enter the command :pop
  - enter the command (continue-prodigy-front-end)
To quit:
  - at the USER() prompt, type :exit
****************************************************

")
