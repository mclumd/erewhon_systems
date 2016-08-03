(in-package "USER")

(defvar *default-port* 5679 
  "Changes socket between lisp and Tcl. USeful when multiple user")

(defvar *last-line-from-socket* nil
  "this will be set to the last line sent")

;;; This is for when things don't work out
(defvar *tcl-send* nil)


(defvar *send-socket* nil)



;;; Do NOT quote server arg.
(defun kill-socket-server(server &key silent)
  (unless silent 
    (format 
     t 
     "Shutting down socket connection ~s~%" server))
  (if server
      (mp:process-kill server))
  (mp:process-allow-schedule)
  t)

;;; ****************************************************************
;;; ****************************************************************
;;; ****************************************************************





(defun send-to-socket (string &optional (socket *tcl-send*))
  (declare (special *print-pretty* *print-case*))
  (let ((*print-pretty* nil)
	(*print-case* :upcase))
    (format socket "~A~%" string)
    (format t 
	    "~%send to tcl ~s~%"
	    string)
    (force-output socket))
  )

;;; Useful for quick sanity checks
(defun ping () (send-to-socket "hi"))


(defun socket-server (&optional (inet nil) (port *default-port*))
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
					   (format 
					    t 
					    "About to read from socket.~%send-str = ~s~%" 
					    send-str)
					 (format t "send-str not set yet.~%"))
				       (if send-str
					   (do ((input_line (read-line send-str nil "quit") 
							    (read-line send-str nil "quit")))
					       ((string= input_line "quit")
						(format 
						 t 
						 "Socket server on port ~s quits~%" 
						 port)
						(setq *last-line-from-socket* input_line)
						(return-from socket-server))
					     (setq *last-line-from-socket* input_line)
;					     (eval-for-tcl input_line send-str)
					     )
					 )
				       (if send-str (ipc-close-stream))
				       ))
				(mp::process-sleep 5)
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


;;;
;;; Server variable passed to this function must be quoted.
;;;
(defun start-socket-server (server &optional (inet nil) (port *default-port*))
  (set server
       (mp::process-run-function 
	"TCL LISP COMMAND SERVER" 
;	`(:NAME "TCL LISP COMMAND SERVER" 
;		:INITIAL-BINDINGS 
;		((*SEND-SOCKET* . nil)
;		 (*TCL-SEND* . NIL)
;		 (*end-of-file* . ',*end-of-file*)
;		 (*load-ui-immediately* . ',*load-ui-immediately*)
;		 (*last-line-from-socket* . nil)
;		 (*default-port* . ',*default-port*)
;		 )
;		)
;	`(:NAME "TCL LISP COMMAND SERVER" 
;		:INITIAL-BINDINGS 
;		((*SEND-SOCKET* . ',*SEND-SOCKET*)
;		 (*TCL-SEND* . NIL)
;		 (*end-of-file* . ',*end-of-file*)
;		 (*load-ui-immediately* . ',*load-ui-immediately*)
;		 (*last-line-from-socket* . ',*last-line-from-socket*)
;		 (*default-port* . ',*default-port*)
;		 )
;		)
			      #'socket-server inet port))
;;; Commented out line below since no such function exists 
;;; in the mp package. [12dec99 cox]
;  (setf (mp::process-interruptable-p *tcl-lisp-command-server*) nil)
  (setf (getf (mp::process-property-list (symbol-value server))
	      ':survive-dumplisp)
	'mp:process-kill)
  )

;;; Quote server arg
(defun spawn-socket-server (server 
			    &optional
			    (port *default-port*)
			    )
  (if (not (eql port *default-port*))
      (setf *default-port* port))
  (kill-socket-server (symbol-value server) :silent t )
  (start-socket-server server t port)
  )


#|

(defun get-socket-message (&optional (socket-stream *tcl-send*))
  (IPC-READ socket-stream)
  )

|#


(defun get-socket-message (&optional silent-p)
  ;; Wait until input received from socket
  (do ()
      (*last-line-from-socket*
       (if (not silent-p)
	   (format t "Received Message ~s.~%"
		  *last-line-from-socket* )))
    )
  (let ((temp *last-line-from-socket*))
    (setf *last-line-from-socket* nil)
    temp)
  )


(defun socket-connected-p (&optional
			   (sockfig *send-socket*))
  (sockfig-connected-p sockfig)
  )


(defun wait-for-socket-connection (&optional
				   (sockfig *send-socket*))
  (do ()
      ((socket-connected-p sockfig))
    )
  )
  