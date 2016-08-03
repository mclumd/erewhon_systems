(defpackage :watchdog)
(in-package :watchdog)


;;;
;;; Load Socket Code and interface
;;;

;;; SET to path of the watchdog directory
(defparameter *watchdog-dir* 
  (concatenate
   'string
   FE::*format-directory* 
   "watchdog/"))

;;; Change if you don't need to load socket C code, or need
;;; non-blocking server connect function.
(defpackage :sockfig)
(defvar sockfig::*load-sock-file-p* t)
(defvar sockfig::*sock2p* nil)

;;; Load Socket code
(eval-when
 (eval load)
 (setf sockfig::*prod-ui-home* *watchdog-dir*)
 (
  #+LUCID lucid::load-foreign-files
  #+ALLEGRO load
  (concatenate 'string *watchdog-dir* "sockets/c-interface")  )

 (
  #+LUCID lucid::load-foreign-files
  #+ALLEGRO load
  (concatenate 'string *watchdog-dir* "sockets/socket-interface2")
  )
)

(use-package :sockfig)


;;; Global Variables

;;; Default hostname for Server
(defvar *default-server-hostname* "yoyoma.prodigy.cs.cmu.edu")
;(defvar *default-server-hostname* "gama.prodigy.cs.cmu.edu")

;;; Default port number for Server
;(defvar *default-server-port* 3283)
(defvar *default-server-port* 5003)

;;; Hostname and port of current watchdog connections
(defvar *current-hostname-and-port* nil)

;;; List of messages sent
(defvar *watchdog-sent-messages* nil)

;;; Number of messagese sent
(defvar *watchdog-sent-message-count* 0)

;;; List of messages received
(defvar *watchdog-received-messages* nil)

;;; Number of messages received
(defvar *watchdog-received-message-count* 0)

;;; Is the watchdog running
(defvar *watchdog-running* nil)

;;; Watchdog socket configuration
(defvar *watchdog* nil)



;;; Watchdog Interface functions

;;; (client-connect &optional hostname port)
;;; Opens a connection to the watchdog server at the given (or default) 
;;; hostname and port.  Initializes all global variables.  Returns t
;;; if successful, nil otherwise.

(defun client-connect (&optional 
		       (hostname *default-server-hostname*)
		       (port *default-server-port*))
  (unless *watchdog-running*
	  ;; Connect to Watchdog Server
	  (let ((result (sockfig:ipc-client-connect hostname port)))
	    ;; returns nil if server is not running, otherwise initialize
	    ;; vars and return t
	    (when result
		  (setq *watchdog-sent-messages* nil
			*watchdog-sent-message-count* 0
			*watchdog-received-messages* nil
			*watchdog-received-message-count* 0
			*watchdog-running* t
			*current-hostname-and-port* (list hostname port)
			*watchdog* result)
		  t)
	    ))) 
 

;;; (client-disconnect &optional (signalp t))
;;; Closes the connection to the watchdog server.  Sends a stop signal
;;; if signalp is true. 

(defun client-disconnect (&optional (signalp t) (process-hook nil))
  (when (and *watchdog-running*
	     (sockfig:sockfig-connected-p *watchdog*))
	;; Tell prodigy to stop (unless we received the stop signal)
	(when signalp (watchdog-send-message :STOP))

#|	;; Wait for Stop signal from server 
	;; Need to handle real messages (through hook function), and
	;; reconnect, and :eof correctly
	(when signalp 
	      (let (message)
		(loop
		 (when (sockfig:ipc-listen *watchdog*)
		       (setq message (watchdog-read-message))
		       (cond ((eq message :stop)
			      (break))
			     ((eq message :eof)
			      (break))
			     )))))
|#
	       

	;; close connection (WAIT FOR CONFIRMATION FROM SERVER??)
	(when (sockfig:ipc-client-disconnect *watchdog*)
	      (setq *watchdog* nil
		    *watchdog-running* nil)
	      t)
	))


;;; (client-resume)
;;; Resumes a broken connection to the watchdog server by reestablishing
;;; the socket and asking for any messages the client may have
;;; missed.  Returns T if successful.

(defun client-resume ()
  (when *watchdog-running*
	;; Reconnect to server
	(sockfig:ipc-client-disconnect *watchdog*)
	(let ((result (sockfig:ipc-client-connect (first *current-hostname-and-port*)
					  (second *current-hostname-and-port*))))
	  (when result
		(setf *watchdog* result)

		;; Ask for messages we missed
		(watchdog-send-message 
		 (list :reconnect *watchdog-received-message-count*)))
	  )))


;;; (server-init &optional (port *default-server-port*))
;;; Starts a watchdog server on the given port

(defun server-init (&optional (port *default-server-port*))
  (unless *watchdog-running*
	  (let ((sf (sockfig:ipc-server-init port)))
	    (when sf
		  (setq *watchdog* sf
			*watchdog-running* t)
		  t))))


;;; (server-connect)
;;; Have the server accept a waiting connection (blocking)

(defun server-connect ()
  (when *watchdog-running*
	(if (sockfig:sockfig-connected-p *watchdog*)
	    (warn "watchdog already connected.")
	  (let ((result (sockfig:ipc-server-connect *watchdog*)))
	    (when (sockfig:sockfig-connected-p result)
		  (setq *watchdog-sent-messages* nil
			*watchdog-sent-message-count* 0
			*watchdog-received-messages* nil
			*watchdog-received-message-count* 0
			*watchdog* result)))
	  )))


;;; (server-disconnect)
;;; Close the current connection

(defun server-disconnect ()
  (when (and *watchdog-running* 
	     (sockfig:sockfig-connected-p *watchdog*))
	(watchdog-send-message :stop)
	(sockfig:ipc-close-stream *watchdog*)
	t))


;;; (server-resume)
;;; Resume a broken server connection

(defun server-resume ()
  (when *watchdog-running*
	(when (sockfig:sockfig-connected-p *watchdog*)
	      (server-disconnect))
	(when (sockfig:sockfig-ready-p *watchdog*)
	      (when (server-connect)
		    ;; Ask for messages we missed
		    (watchdog-send-message 
		     (list :reconnect *watchdog-received-message-count*))))
	))

;;; (server-shutdown)
;;; Shutdown the watchdog server

(defun server-shutdown ()
  (when *watchdog-running*
	(when (sockfig:sockfig-connected-p *watchdog*)
	      (server-disconnect))
	(sockfig:ipc-server-shutdown)
	(setq *watchdog* nil
	      *watchdog-running* nil)
	t))




;;; (watchdog-read-message)
;;; Reads the next message (client or server) and returns it.  Returns
;;; :EOF if the the stream has been closed.  Returns nil if the
;;; message is not new or a message has been skipped (in which case a
;;; request is made to get the skipped message).

(defun watchdog-read-message ()
  (when (and *watchdog-running*
	     (sockfig:sockfig-connected-p *watchdog*))
	(let (string status)  
	  (if (sockfig:ipc-listen *watchdog*)
	      (multiple-value-setq (string status) 
				   (sockfig:ipc-length-read :sf *watchdog*))
	    (setq status :none))
	  (cond ((eq string :EOF)
		 :eof)
		((eq status :none)
		 nil)
		((= status (1+ *watchdog-received-message-count*))
		 (incf *watchdog-received-message-count*)
		 (push string *watchdog-received-messages*)
		 (read-from-string string))
		((<= status *watchdog-received-message-count*)
		 (when sockfig:*trace-ipc*
		       (format t "~%Duplicate message received ~D (seen ~D)~%  ~A~%" 
			       status *watchdog-received-message-count* string))
		 nil)
		((> status *watchdog-received-message-count*)
		 (when sockfig:*trace-ipc*
		       (format t "~%Skipped message ~D (seen ~D)~%  ~A~%" 
			       status *watchdog-received-message-count* string))
		 (watchdog-send-message (Format nil "(:reconnect ~D)"
					   *watchdog-received-message-count*))
		 nil)
		)
	  )))


;;; (watchdog-send-message (message &key (index nil) (convert t)))
;;; Send a message (client or server).  If index is given and refers
;;; to a message that was previously sent then that message is
;;; resent.  Otherwise the message is converted to a string (if
;;; convert is true) and sent.

(defun watchdog-send-message (message &key (index nil) (convert t))
  (when (and *watchdog-running*
	     (sockfig:sockfig-connected-p *watchdog*))
	(let (string status)
	  (cond ((and (integerp index) ;; resend message 
		      (<= 1 index *watchdog-sent-message-count*))
		 (setq string (elt *watchdog-sent-messages* 
				   (- *watchdog-sent-message-count* message))
		       status message))
		(convert
		 (setq string (format nil "~S" message)
		       status (incf *watchdog-sent-message-count*))
		 (push string *watchdog-sent-messages*))
		((stringp message)
		 (setq string message
		       status (incf *watchdog-sent-message-count*))
		 (push string *Watchdog-sent-messages*))
		)
	  (when string
		(sockfig:ipc-length-print :sf *watchdog* :string string :status status))
	  )))


;;; (watchdog-resend-messages (index)
;;; Resends all the messages after the given index.

(defun watchdog-resend-messages (index)
  ;; Resend all messages since the given index
  (when (and *watchdog-running*
	     (sockfig:sockfig-connected-p *watchdog*)
	     (integerp index))
	(do ((i (1+ index) (1+ i)))
	    ((> i *watchdog-sent-message-count*))
	    (watchdog-send-message :index i))))


(export '(*default-server-hostname* *default-server-port*
	*watchdog-running* client-connect client-disconnect
	server-init server-connect server-disconnect server-shutdown
	client-resume watchdog-read-message watchdog-send-message
        watchdog-resend-messages server-resume))
	
	
(provide 'watchdog)
