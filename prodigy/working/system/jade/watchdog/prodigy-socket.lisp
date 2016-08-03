;;; prodigy-socket.lisp
;;; Socket communication code for ForMAT/Prodigy tie.
;;;
;;; 13 Nov 1997 - Created by David Rager
;;;  8 Dec 1997 - Separate the watchdog into a new package :watchdog


#| Notes

Only the basic communication function should need to be changed (those 
in ties/prodigy/prodigy-toplevel).


Source Files
------------
ties/prodigy/prodigy-io - I/O functions 
ties/prodigy/prodigy-toplevel - top level functions  (No changes needed)

prodigy-socket - This file - patches to the ForMAT functions
watchdog - The watchdog functions
sockets/c-interface - Needed to load the socket code
sockets/socket-interface2 - The socket code and interface functions
sockets/sock.o or sock.so - The C based socket code


Variables
---------

*prodigy-enabled* - tells if the Prodigy capability has been enabled.

*prodigy-events-to-trace* - list of history actions that are printed
   to the Prodigy history file, and in 1-minute chunks when there is
   an active connection to Prodigy.

watchdog::*watchdog-running* - tells if the Watchdog is running,
   implying an active connection with Prodigy.

*prodigy-messages* - messages received from Prodigy (as used by UI)

*prodigy-watchdog* - NOT NEEDED

*prodigy-io-basename* - NOT NEEDED


Prodigy I/O Functions
---------------------

(enable-prodigy) - activate Prodigy functionality, and create a
   Prodigy history file.

(disable-prodigy) - deactivate Prodigy functionality, closing the
   history file and stopping the Watchdog if necessary.

(open-prodigy-connection &optional BASENAME) - opens a connection to
   Prodigy by starting a Watchdog that uses the given BASENAME.  If
   BASENAME is nil, uses data/watchdog/PRODIGY.

(close-prodigy-connection) - close the connection to Prodigy by
   sending a STOP signal and closing any open I/O streams.

(reset-prodigy-connection) - reset the connection with Prodigy by
   resetting the Watchdog.

(resume-prodigy-connection) - reconnect to prodigy server after the
   connection is lost.  Request any lost messages.

PRODIGY HISTORY HOOK - On each history action, see if the action
   appears in *prodigy-events-to-trace*.  If so, write it to the
   Prodigy history file.  Furthermore, if the connection to Prodigy is
   active (i.e. the Watchdog is running), write the action to the I/O
   chunk file, sending it if a minute has passed.

(read-prodigy-output) - Read message from prodigy and do something with it.

(prodigy-data-pathname FNAME) - returns the absolute pathname of
   FNAME, in the data/prodigy directory. - NOT NEEDED

(open-next-prodigy-output-chunk) - NOT NEEDED

(send-prodigy-output-chunk) - NOT NEEDED

|#


;;; New Variables

;;; Default hostname for Prodigy
(defvar *default-prodigy-hostname* "scruffy.cs.umd.edu")

;;; Default port number for Prodigy
;(defvar *default-prodigy-port* 3283)
(defvar *default-prodigy-port* 5003)


;;; New/Modified ForMAT functions

;;; (open-prodigy-connection &optional BASENAME) - opens a connection to
;;;   Prodigy by starting a Watchdog that uses the given BASENAME.  If
;;;   BASENAME is nil, uses data/watchdog/PRODIGY.
;;; Opens a connection to Prodigy by making a socket connection to the
;;; Analogy program.  BASENAME is no longer used.  A hostname and port
;;; number should be provided if the defaults are not correct.

(defun open-prodigy-connection (&optional 
				(hostname *default-prodigy-hostname*)
				(port *default-prodigy-port*))
  (when (watchdog::client-connect hostname port)
	(setq *prodigy-messages* nil
	      *prodigy-watchdog-running* t)
	t)
  )
 

;;; (close-prodigy-connection) - close the connection to Prodigy by
;;;   sending a STOP signal and closing any open I/O streams.
;;; Closes the connection to Prodigy by sending a STOP signal and
;;; closing any open streams.

(defun close-prodigy-connection (&optional signal)
  (when (and *prodigy-watchdog-running*
	     (watchdog::client-disconnect))
	(setq *prodigy-watchdog-running* nil)
	))


;;; (reset-prodigy-connection) - reset the connection with Prodigy by
;;;   resetting the Watchdog.   NEEDED??
(defun reset-prodigy-connection ()
  ;; Disconnect then reconnect
  (close-prodigy-connection)
  (open-prodigy-connection))


;;; (resume-prodigy-connection)
;;; Resumes a broken connection to Prodigy by reconnecting the socket and 
;;; asking it for any messages ForMAT may have missed.
(defun resume-prodigy-connection ()
  (when *prodigy-watchdog-running*
	(watchdog::client-resume)
	))

(defun resend-prodigy-messages (index)
  (when *prodigy-watchdog-running*
	(watchdog::watchdog-resend-messages index)))


;;; PRODIGY HISTORY HOOK - On each history action, see if the action
;;;   appears in *prodigy-events-to-trace*.  If so, write it to the
;;;   Prodigy history file.  Furthermore, if the connection to Prodigy is
;;;   active (i.e. the Watchdog is running), write the action to the I/O
;;;   chunk file, sending it if a minute has passed.
(define-history-hook PRODIGY (TIMESTAMP ACTION ARGUMENTS)
  (multiple-value-bind (second min hour date month year day-of-week)
      (get-decoded-time)
    (when *prodigy-enabled*
      (when *prodigy-watchdog-running*
	;; On each *ForMAT* action, send it to Prodigy.

	;; SMC 3/21/1996.  Process Output from prodigy, if any.
	    (read-prodigy-output)

	;; SMC 3/30/1996.  Send actions to Prodigy
	(when (member ACTION *prodigy-events-to-trace*)
	      (let ((message 
		     (with-output-to-string (stream)
			(print-history-action TIMESTAMP 
					      (cons ACTION ARGUMENTS)
					      stream))))
		(watchdog::watchdog-send-message message :convert nil)))
	  )
      (print-history-action TIMESTAMP (cons ACTION ARGUMENTS)
			    *prodigy-stream*)
      )))


;;; (prodigy-data-pathname FNAME) - returns the absolute pathname of
;;;   FNAME, in the data/prodigy directory.
;;; NOT USED
;(trace prodigy-data-pathname)


;;; (open-next-prodigy-output-chunk) - INTERNAL.  Create an output file
;;;   (in data/io) where the actions that occur during the next minute
;;;   will be recorded.
;;; NOT USED
;(trace prodigy-data-pathname)


;;; (send-prodigy-output-chunk) - INTERNAL.  Close the chunk file, and
;;;   create a symbolic link with a name that the Watchdog will
;;;   recognize.
;;; NOT USED
;(trace send-prodigy-output-chunk)


;;; (read-prodigy-output) - INTERNAL.  Read the output from Prodigy,
;;;   creating any new messages and displaying them in the Task Window.
(defun read-prodigy-output ()
  (let ((listen (sockfig::ipc-listen)))
    (cond ((eq listen :eof)
	   (resume-prodigy-connection)
	   nil)
	  (listen
    (let (item status)
      (ui::with-io-cursor
	 (loop
	  (multiple-value-setq  (item status)  (watchdog::watchdog-read-message))
	  (cond ((or (eq status :eof) (eq item :EOF)) ;; Connection broken
		 (resume-prodigy-connection)
		 (return))
		((eq item 'stop) ;; Stop signal
		 (close-prodigy-connection t)
		 (return))
		((and (consp item) (eq (first item) :reconnect)) ;; update request
		 (resend-prodigy-messages (second item)))
		((eq status nil)
		 (return))
		(t
		 (dolist (message-info (cddr item))
		   (if (not (find-prodigy-message (second message-info)))
		       (push (make-instance 'prodigy-message
				     :id (second message-info)
				     :title (third message-info))
		      *prodigy-messages*)
		     )))))
	 (ui::update-prodigy-task-window)
       ))))))




