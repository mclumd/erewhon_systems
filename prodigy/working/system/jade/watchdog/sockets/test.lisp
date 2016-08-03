(setf *prod-ui-home* ".")
(load "sockets/c-interface")
(load "sockets/socket-interface2")
(setf *trace-ipc* t)


;;; Test the occasional message passing...


;;; SERVER
(defun test-server (&optional init)
  (when init (ipc-server-init))

  ;;; loop until connected
  (do (result stop)
      (stop)
      (setq result (ipc-server-connect-no-block))
      (cond ((eq result :EWOULDBLOCK))
	    ((sockfig-p result) 
	     (setq stop t)))
      (print result))

  ;;; loop until stop is signaled
  (do (message)
      ((equal message "STOP"))

      (when (ipc-listen)
	    (setf message (ipc-length-read))
	    (print message)
	    )
      (format t ".")
      )
  (ipc-close-stream)
  ;(ipc-server-shutdown)
  )


;;; CLIENT
(defun test-client ()
  (when (ipc-client-connect)
	(do (message)
	    ((equal message "STOP"))
      
	    (setq message (read-line))
	    (ipc-length-print :string (format nil "~A" message))
	    )
	(ipc-client-disconnect)))



#|  ForMAT / Prodigy functions

(defvar *default-prodigy-server-port* 3283)
(defvar *default-prodigy-server-host* "scruffy.cs.umd.edu")
(defvar *prodigy-message-number* 0)

(defun start-prodigy-server (&optional (port *default-prodigy-server-port*))
  ;;; initialize server port
  (unless (sockfig-connected-p *last-sockfig*)
	  (ipc-server-init port))

  ;;; Wait for connection
  (ipc-server-connect)
  )

(defun stop-prodigy-server ()
  (ipc-close-stream)
  (ipc-server-shutdown))

(defun send-message (message)
  (when connectedp 
	(let ((message-number (incf *prodigy-message-number*)))
	  
      
  
  
|#

