(in-package "USER")

;;; History 
;;;
;;;
;;; Changes from Sean's version:
;;;
;;; 1. references to theo removed
;;; 2. *tcl-messages* global list of strings replaces a theo location
;;; 3. Made query-server add a newline to each string, so I can use
;;; gets
;;; 4. Made error handling in evaluated code more sophisticated: The
;;; communication link doesn't break but the error is printed to the
;;; screen. 
;;;
;;; 15jun98 Moved ping function here from ui.lisp in a major overhaul of the
;;; file and the way the UI is bootstrapped. [cox]
;;;
;;; 26jun99 Created program variable to hold default port so that multiple
;;; users can run PRODIGY UI on same machine. *default-port*. [cox]
;;;
;;; Commented out line in start-tcl-server that called
;;; mp::process-interruptable-p since no such function exists in the mp
;;; package. When calling this fn the server would still work, but any code
;;; past that would not be executed. This is the reason that under Solaris we
;;; had to have the manual switch in prod-ui and were forced to call wish
;;; external to PRODIGY. [12dec99 cox]
;;; 
;;; Commented out original tcl-server definition. Now if the user has Allegro
;;; version 5.0.1, the tcl-server will be redefined for LISP-specific sockets
;;; (avail on version 5.0.1). Otherwise the old BBN C-specific socket version
;;; of tcl-server will be used [2aug00 cox]


#+(version>= 4 0)
(defpackage :ipc (:use :lisp :excl :ff :mp)
            (:export #:create-server-socket
                     #:accept-connection
                     #:close-socket
                     ))
;;;
;;; If you change this, also change port global variable in the tcl code of 
;;; the file ui-start.tcl. Because it is a variable, you can make your change
;;; before loading prodigy. E.g., place (setf  *default-port* 5680) in your 
;;; .clinit.cl. This is useful when multiple user need to run the ui on the
;;; same machine. Each uses a different port.
;;; 
(defvar *default-port* 5679 
  "Changes socket between lisp and Tcl. USeful when multiple user")

(defvar *sean-trace* nil)
(defvar *jim-trace* nil
  "You see the messages for lisp from tcl if this is not nil")
(defvar *last-line-from-tcl* nil
  "If *jim-trace* is t, this will be set to the last line sent")

;;; You send messages to tcl by sticking them on this list
(defvar *tcl-messages* nil)

;;; This is for when things don't work out
(defvar *tcl-send*)
(defvar *tcl-query*)

(defvar *tcl-lisp-command-server* nil)
(defvar *tcl-event-notifyer* nil)

(defvar *send-socket* nil)
(defvar *use-old-socket* t)

(defun start-tcl-server (&optional (inet nil) (port *default-port*))
  (setq *tcl-lisp-command-server* 
	(mp::process-run-function "Tcl lisp command server"
				  'tcl-server inet port))
;;; Commented out line below since no such function exists 
;;; in the mp package. [12dec99 cox]
;  (setf (mp::process-interruptable-p *tcl-lisp-command-server*) nil)
  (setf (getf (mp::process-property-list *tcl-lisp-command-server*) 
	      ':survive-dumplisp)
	'mp:process-kill)
  ;; Start the Query server
  ;;(setq *tcl-event-notifyer* 
  ;;(mp::process-run-function "Tcl event notifyer" 'query-server inet))
  ;;(setf (mp::process-interruptable-p *tcl-event-notifyer*) nil)
  ;;(setf (getf (mp::process-property-list *tcl-event-notifyer*) 
  ;;':survive-dumplisp)
  ;;'mp:process-kill)
  )

(defun kill-tcl-server(&key silent)
  (unless silent (format t "Shutting down tcl interface..~%"))
  (if *tcl-lisp-command-server*
      (mp:process-kill *tcl-lisp-command-server*))
  (if *tcl-event-notifyer*
      (mp:process-kill *tcl-event-notifyer*))
  (mp:process-allow-schedule)
  t)

;;; ****************************************************************
;;; ****************************************************************
;;; ****************************************************************

#|
(defun tcl-server (&optional (inet nil) (port *default-port*))
  (let* ((me (read-line (excl:run-shell-command
			 "whoami" :output :stream :wait nil)))
	 (send-socket (if (and *use-old-socket* *send-socket*)
			  *send-socket*
			(ipc::create-server-socket
			 :inet-domain inet :port port
			 :pathname (format nil "/tmp/sock3_~A" me))))
	 (socket      (car send-socket))
	 (sockaddr    (cadr send-socket)))
    (setf *send-socket* send-socket)
    (loop
     (let* ((tcl-send (ipc::accept-connection (car send-socket) (cadr send-socket)))
	    (send-str (make-instance 'excl::bidirectional-terminal-stream
				     :fn-in tcl-send
				     :fn-out tcl-send)))
       (setf *tcl-send* send-str)
       (when *sean-trace*
	 (format t "~&Got a stream!!!!"))
       (do ((input_line (read-line send-str nil "(quit)") 
                        (read-line send-str nil "(quit)")))
	   ((string= input_line "(quit)")
	    (format t "Tcl server quits~%"))
	 (when *jim-trace*
	   (format t "Tcl server gets: ~A~%" input_line)
	   (setf *last-line-from-tcl* input_line))
	 (eval-for-tcl input_line send-str))
       (ipc::close-socket tcl-send)))))

|#


;;; ****************************************************************

;;;new, at bbn. uses portable socket code. CRH, 10-2-97.
(defun tcl-server (&optional (inet nil) (port *default-port*))
  (let (got-server
	send-str)
    (unwind-protect 
	(progn (setf *send-socket* (ipc-server-init port))
	       (if *send-socket*
		   (loop
		     (unwind-protect 
			 (progn (setq got-server (ipc-server-connect))
				(cond (got-server
				       (setq send-str (sockfig-stream *send-socket*)
					     *tcl-send* send-str)
				       (if send-str
					   (do ((input_line (read-line send-str nil "(quit)") 
							    (read-line send-str nil "(quit)")))
					       ((string= input_line "(quit)")
						(format t "Tcl server quits~%")
						(return-from tcl-server))
					     (when *jim-trace*
					       (format t "Tcl server gets: ~A~%" input_line)
					       (setq *last-line-from-tcl* input_line))
					     (eval-for-tcl input_line send-str)
					     )
					 )
				       (if send-str (ipc-close-stream))
				       ))
				(sleep 5)
				)
		       ;;protected
		       (if send-str (ipc-close-stream))
		       )
		     )
		 )
	       )
      ;;protected
      (ipc-server-shutdown))
    )
  )

#+(and ALLEGRO-V6.0) 
;;; 
;;; Substituted Allegro 5.0.1 socket calls to replace the old bbn
;;; calls. This had to be done to run on Windows98. [25jun00 2aug00 cox]
;;; 
;;; The following evaluate the Allegro socket version of tcl-server if version
;;; 5.0.1 is used. Otherwise the older version using C implemented sockets is
;;; not overwritten. When version 6 and higher is released, add the appropriate
;;; identifier to the "and" clause.
;;; 
(defun tcl-server (&optional (inet nil) (port *default-port*))
  (let (got-server
	send-str)
    (unwind-protect 
	(progn (setf *send-socket* 
;;;		 (ipc-server-init port)
		 (socket:make-socket 
		  :connect :passive
		  :local-port port)
		 )
	       (format t "~%Create socket ~S on port~s~%" 
		       *send-socket*
		       port)
	       (if *send-socket*
		   (loop
		     (unwind-protect 
			 (progn (setq got-server 
;;;				  (ipc-server-connect)
				  (socket:accept-connection
				   *send-socket*
				   :wait nil)
				  )
				(cond (got-server
				       (format t "~%Got connected. Stream is ~S~%" got-server)
				       (setq send-str 
;;;					 (sockfig-stream *send-socket*)
					 got-server
					     *tcl-send* send-str)
				       (if send-str
					   (do ((input_line (read-line send-str nil "(quit)") 
							    (read-line send-str nil "(quit)")))
					       ((string= input_line "(quit)")
						(format t "Tcl server quits~%")
						(return-from tcl-server))
					     (when *jim-trace*
					       (format t "Tcl server gets: ~A~%" input_line)
					       (setq *last-line-from-tcl* input_line))
					     (eval-for-tcl input_line send-str)
					     )
					 )
				       (if send-str 
;;;					   (ipc-close-stream)
					   (close *tcl-send*)
					 )
				       )
				      (t
				       (format t "~%Failed to Connect so far.~%")))
				(sleep 5)
				)
		       ;;protected
		       (if send-str 
;;;			   (ipc-close-stream)
			   (close *tcl-send*))
		       )
		     )
		 )
	       )
      ;;protected
;;;      (ipc-server-shutdown)
					;      (close *tcl-send*)
      (close *tcl-send*)
      ;(socket:shutdown *tcl-send* :direction :output)
;      (socket:shutdown *tcl-send* :direction :input)
      (close *send-socket*)
      )
    )
  )


;;; ****************************************************************
;;; ****************************************************************
;;; ****************************************************************

;;; For an inet connection, need to create the server and then wait a
;;; bit for a connection. Run like this:
;;; (setf socket (ipc::create-server-socket :inet-domain t :port *default-port*))
;;; [make sure a connection is waiting..]
;;; (tcl-inet-server socket)
;;;

(defun tcl-inet-server (send-socket)
  (let* ((socket      (car send-socket))
	 (sockaddr    (cadr send-socket)))
    (loop
     (let* ((tcl-send (ipc::accept-connection socket sockaddr))
	    (send-str (make-instance 'excl::bidirectional-terminal-stream
				     :fn-in tcl-send
				     :fn-out tcl-send)))
       (setf *tcl-send* send-str)
       (when *sean-trace*
	 (format t "~&Got a stream: ~S~%" tcl-send))
       (do ((input_line (read-line send-str nil "(quit)") 
                        (read-line send-str nil "(quit)")))
	   ((string= input_line "(quit)")
	    (format t "Tcl server quits~%"))
	 (when *jim-trace*
	   (format t "Tcl server gets: ~A~%" input_line)
	   (setf *last-line-from-tcl* input_line))
	 (eval-for-tcl input_line send-str))
       (ipc::close-socket tcl-send)))))

;;; This piece of code evaluates a string, trapping and noting
;;; errors. Since there are a few places where the prod-ui evaluates
;;; stuff from tcl, it's useful to have this separate function.
(defun eval-for-tcl (string &optional (stream *tcl-send*))
  (if (not (string= string ""))
      (multiple-value-bind (result error)
	  (ignore-errors (eval (read-from-string string)))
	(when (and error (typep error 'error))
	  (format t "Form being evaluated for tcl had an error:~%")
	  ;; there's a nicer way but..
	  (apply #'format 
		 (append (list t (slot-value error 'excl::format-control))
			 (slot-value error 'excl::format-arguments)))
	  (setf result :error))
	(send-to-tcl (lisp-tcl result) stream))))
  
;;; This function notifies TCL when something happens - eg. mail
;;; arrives. (I don't use this in the prodigy interface)
(defun query-server(&optional inet)
  (let* ((me (read-line (excl:run-shell-command
			 "whoami" :output :stream :wait nil)))
	 (message-socket (ipc::create-server-socket
			  :inet-domain inet :port *default-port*
			  :pathname (format nil "/tmp/sock4_~A" me)))
	 (socket (car message-socket))
	 (sockaddr (cadr message-socket)))
    (loop
     (let* ((tcl-message (ipc::accept-connection socket sockaddr))
	    (message-stream (make-instance 'excl::bidirectional-terminal-stream
					   :fn-in tcl-message
					   :fn-out tcl-message)))
       (setf *tcl-query* message-stream)
       ;;(let ((*print-pretty* nil))
	;; (dolist (message (get.value? 'tcl-notified 'mail-apprentice))
	;;   (format message-stream "~A~&" (lisp-tcl message))
	;;   (force-output message-stream)))
       ;;(dolist (message (get.value? 'tcl-notified 'mail-apprentice))
       ;;        (send-to-tcl message-stream (lisp-tcl message)))
       (do ((x (mp:process-sleep 5) (mp:process-sleep 5))
	    (input_line (if (listen message-stream) 
			    (read-line message-stream nil "(quit)") "")
			(if (listen message-stream) 
			    (read-line message-stream nil "(quit)") ""))
	    (new-messages *tcl-messages* *tcl-messages*
	     ;;(get.value? 'tcl-notify 'mail-apprentice)
	     ;;(get.value? 'tcl-notify 'mail-apprentice)
	     ))
	   ((string= input_line "(quit)"))
	 (if (not (string= input_line ""))
	     (eval (read-from-string input_line)))
	 ;; Send out anything new that has happened.
	 ;;(let ((*print-pretty* nil))
	 ;;  (dolist (new-message new-messages)
	 ;;    (remove.value 'tcl-notify 'mail-apprentice new-message)
	 ;;    (format message-stream "~A~&" (lisp-tcl new-message))
	 ;;    (force-output message-stream)))
	 (dolist (new-message new-messages)
	   (pop *tcl-messages*)
	   ;;(remove.value 'tcl-notify 'mail-apprentice new-message)
	   (send-to-tcl (lisp-tcl new-message) message-stream)))
	 
       (ipc::close-socket tcl-message)))))

(defun send-to-tcl (string &optional (socket *tcl-send*))
  (declare (special *print-pretty* *print-case*))
  (let ((*print-pretty* nil)
	(*print-case* :upcase))
    (format socket "~A~%" string)
    ;; Added [cox 9jun98]
    (if *jim-trace*
	(format t 
		"~%send to tcl ~s~%"
		string))
    (force-output socket)))

;;; Useful for quick sanity checks
(defun ping () (send-to-tcl "hi"))

(defun reload-tcl()
  (load (concatenate 'string *prod-ui-home* "/tcl"))
  )

;;; Function to convert a lisp-list to a tcl-list ready to send down
;;; the socket. (Not used in the prodigy interface)
(defun lisp-tcl (lisp-list)
  (let ((*print-case* :upcase))
    (cond ((atom lisp-list)
	   ;; Here we have just a plain old symbol.
	   (code-item lisp-list))
	  (T
	   ;; Here we have the erstwhile list
	   (let ((text ""))
	     (do* ((lisp-list lisp-list (rest lisp-list)))
		  ((or (null lisp-list) (symbolp lisp-list))
		   (if (null lisp-list)
		       text
		     (format nil "~A .~A" text (code-item lisp-list))))
		  (setq text (format nil "~A~A" 
				     text (code-item (car lisp-list))))))))))

(defun code-item (item)
  (let ((*print-case* :upcase))
    (cond ((stringp item)
	   (format nil " {~S}" item))
	  ((atom item)
	   (format nil " ~S" item))
	  ;; Use this if you ever want the output to be ' instead of { quote <> }
	  ;;((eq (first item) 'quote)
	  ;; (format nil " '~A"
	  ;;	 (string-left-trim '(#\Space) (code-item (second item)))))
	  ((listp item)
	   (let ((text " {"))
	     (do* ((item item (rest item)))
		  ((or (null item) (atom item))
		   (if (null item)
		       (format nil "~A }" text)
		     (format nil "~A .~A }" text (code-item item))))
		  (setq text (format nil "~A~A" text (code-item (car item))))))))))
  
;; Not this could be a proper list or just a dotted pair thingy
(defun lisp-list-tcl (lisp-list)
  (cond ((null lisp-list)
	 " }")
	((symbolp lisp-list)
	 (format nil " . ~S }" lisp-list))
	((listp lisp-list)
	 (if (listp (first lisp-list))
	     (format nil " { ~A ~A" (lisp-list-tcl (first lisp-list))
		     (lisp-list-tcl (rest lisp-list)))
	   (format nil " ~S ~A" (first lisp-list)
		   (lisp-list-tcl (rest lisp-list)))))))

