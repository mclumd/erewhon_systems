(in-package "FRONT-END")

;;;THIS IS AN OLD OBSOLETE VERSION OF THE FILE. THE CURRENT VERSION USED BY THE
;;;SYSTEM IS IN THE PARENT DIR (I.E., THE FORMAT DIR). BY DOING SO. LOADING AND
;;;COMPILING ARE EASIER.


;;; Modifications to the prodigy files to use socket based watchdog.


;;;;;; HISTORY
;;;
;;; Comments by DER are David Rager's from U.Maryland (soon to be with BBN).
;;;
;;; Added connection icon. [30mar98 cox]
;;;


;;; Load Watchdog 

;;; Don't load the C file, since it's already loaded by UI.
(defpackage :sockfig)
(defvar sockfig::*load-sock-file-p* t) ;;runs without the UI
;(defvar sockfig::*load-sock-file-p* nil) ;;runs with the UI

;;; [cox 11apr98]
(defparameter *connect-file* 
  (concatenate 'string *format-directory* "watchdog/watchdog-xbiff")
  "When file exists, it signals that the front end has connected with ForMAT.")

;;; SET PATH
;;; *format-directory* defined in my-loader.lisp
(load (concatenate 'string *format-directory* "watchdog/watchdog.lisp"))
(use-package :watchdog)

;;; ============================================================
;;; From front-end.lisp
;;; ============================================================

;;; Default hostname for Prodigy (current machine)
;(defvar *default-prodigy-hostname* "yoyoma.prodigy.cs.cmu.edu")

;;; Default port number for Prodigy
;(defvar *default-prodigy-port* 3283)
(defvar *default-prodigy-port* 5003)


;;;
;;; Made run-prodigy an optional parameter of start-prodigy-front-end, so that
;;; user can disable the planning from scratch process during testing. With
;;; parameter *Use-Case-Replay* (file transformations.lisp) is true, Prodigy
;;; will plan in analogical mode, otherwise it will be generative mode. [cox
;;; 8mar98]
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
  ;; The following clause send "hi" to the UI so that the flush_socket tcl
  ;; procedure can remove all previous input that was generated (mainly & & &
  ;; continuation strings) during a ForMAT-Prodigy demo. That is, it searches
  ;; until it finds the terminating "hi" string. [27oct97 cox]
  (if called-from-ui
      (user::ping))
  )


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


;;; [cox 16apr98]
(defvar *xbiff-already-loaded* nil
  "Global flag so function initialize-prodigy knows not to exec another xbiff if one is already done.")


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
	       "ui/shell.lisp")))
    (if (not user::*alt-stream*)
	(user::init-shell user::*alt-stream* 'user::*alt-stream*))
;    (setq *basename* basename)
;    (setq *client-data-file* (format nil "~A.client" basename))
;    (setq *client-stop-file* (format nil "~A.client.STOP" basename))
    (setq *prodigy-output-count* 1)
    (setq *responses* nil)
    (setq *messages* nil)
    (setq *actions* nil)
    (setq *input-counter* 1)
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
	    "xbiff -file \"~s\" -update 5 -geometry 65x65 -xrm \"xbiff*fullPixmap\:~s\" -xrm \"xbiff*emptyPixmap\:~s\" & "
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
    (format t "Prodigy Front End initialized, waiting for connection from ForMAT...~%")
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
	       (format out "Prodigy front-end connects with ForMAT.~%")
	       )
	      (format t "...ForMAT client connected.~%")
	      (Setf stop t)
	      )
	;(format t "...ForMAT client FAILED to connect.~%"))
	(format t "."))
    (format t "*******************************************~%")
    ))


;;; 4 Dec 1997 DER - Added socket watchdog code.  Now format messages come 
;;; one at a time.
;;;
;;; Made run-prodigy an optional parameter passed from
;;; (start-prodigy-front-end) call, so that user can disable the planning from
;;; scratch process during testing. [cox 8mar98]
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
					  "xterm -geometry 48x10+100+100 -title \"PRODIGY Suggestions\" -n \"Suggestions\" -sb  -e /afs/cs/user/mcox/prodigy/format/Watch.dog/show-file2.sh ~S &" (title out)) user::*alt-stream*))
			   )
		   (setq output 
			 (concatenate 
			  'string output
			  (format nil ")~%"
				  )))
		   (watchdog::watchdog-send-message output :convert nil)
			   )))))
	   ))))




;;; ============================================================
;;; From ratio-rep.lisp
;;; ============================================================

;;; The form of the request is as follows:
;;; (:ON-REQUEST {:RATIO-REPORT | :FM-REPORT} ((:FM <FORCE-MODULE> <OPLAN>)+))
;;;
(defun request-reports (oplan fmid-mappings
			      &optional 
			      (which-report :ratio-rep))
  "Request a series of ratio reports from ForMAT."

  (format t 
	  "Writing output request for ~s, file # ~D~%" 
	  (case which-report
		 (:ratio-rep :RATIO-REPORT)
		 (:basic-fm-rep :FM-REPORT)
		 )
	  (1+ watchdog::*watchdog-sent-message-count*))

  (watchdog::watchdog-send-message 
   (format nil 
	   "(:ON-REQUEST ~S ~S)~%" 
	   ;; [cox 15apr98]
	   (case which-report
		 (:ratio-rep :RATIO-REPORT)
		 (:basic-fm-rep :FM-REPORT)
		 )
	   (assemble-args oplan fmid-mappings))
   :convert nil)
  )


(defun parse-ratio-string (input-string)
  ;; Structure the format by placing records in sublists
  (change-2-records
   ;; Remove the ratio report header titles 

   (read-from-string
    (let ((start 0))
      ;; Remove the ratio report header titles (5 lines)
      (dotimes (i 5)
	       (setq start (1+ (position #\Newline input-string :start start))))
      (concatenate 'string "("
		   ;; Change newlines and percent signs into spaces
		   (substitute #\Space #\% 
			       (substitute #\Space #\Newline 
					   (subseq input-string start)))
		   ")")
      ))))
