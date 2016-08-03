(in-package :user)

;;; A shell stream used to set environment variable.
(defvar *registrar-shell* nil)

(defvar *registrar-command-server* nil)

;;;;
;;;; CODE TO HANDLE UNIQUE PORT NUMBER ASSIGNMENTS 
;;;;



;;; First available port to be released.
;;;
(defparameter *first-port* 5510)

(defvar *highest-port-released* nil)

(defvar *ports-available* (list *first-port*))

(defvar *port-released-p* nil "Set to t when the first release is made.")


;;; Function release-port returns an available port number for another process
;;; to use in socket communication. 
(defun release-port (&optional
		    (p-a-list-name '*ports-available*)
		    (ports (symbol-value p-a-list-name))
		    )
  (if (null ports)
      (setf ports
	(list
	 (setf *highest-port-released*
	   (+ 1 *highest-port-released*)))))
  (set p-a-list-name (rest ports))
  (when (not *port-released-p*)
    (setf *port-assigned-p* t)
    (setf *highest-port-released*
      (first ports)))
  (first ports)
  )

(defun return-port (port)
  (setf 
      *ports-available* 
    (cons port *ports-available*))
  )


;;;;
;;;; MAIN REGISTRAR CODE
;;;;



;;; For now the registrar will be an independent process. It will not spawn
;;; subprocesses.
;;;
(defun registrar (&optional 
		  (registrar-port (release-port))
		  &aux
		  got-first-msg-p
		  )
  (connect-with-DND '*registrar-command-server* registrar-port)
  (do ((request (get-socket-message)(get-socket-message))
	(port-num (release-port)(release-port))
       )
      ((equal request "(quit)")
       (format t "Received ~s. Registrar HALT." request)
       (kill-socket-server *registrar-command-server* :silent t)
       (return-port registrar-port))
    (format t "*last-line-from-socket* = ~s.~%" *last-line-from-socket*)
    (format t "Received request ~s~%" request)
    (when (not got-first-msg-p)
      (send-shell (format nil "setenv DNDPORT \"\"") 
		  *registrar-shell*)
      (quit-shell *registrar-shell* 
		  '*registrar-shell*)
      (setf got-first-msg-p t)
      )
    (cond ((equal "obj-request"
	       request)
	   (format t "Cond in obj-req~%")
	   (send-to-socket port-num)
	   (format t "Sent port number ~s~%" port-num)
	   (send-obj-strings port-num)
	   )
	  ((equal 'goal-request
	       request)
	   (generate-all-goals)
	   )
	  ((equal 'prob-request
	       request)
	   (set-problem)
	   )
	  ((equal 'plan-request
	       request)
	   (input-wrapper port-num)
	   )
	  )
    (setf *last-line-from-socket* nil)
    )
  )

;;; 
;;; Function connect-with-DND first sets an environment variable (DNDPORT) to
;;; the given port number. This will be read at initialize time for the Drag
;;; and Drop (DND) program so that a socket can be established between the
;;; registrar and the DND application. The function then starts a socket server
;;; and waits for the connection.
;;;
;;; Update comments!
;;;
(defun connect-with-DND (server port)
  (init-shell *registrar-shell* '*registrar-shell*)
  (send-shell (format nil "setenv DNDPORT ~S" port) 
	      *registrar-shell*)
  (format t "DNDPORT set to ~s~%" port)
  (spawn-socket-server 
   server
   port)
  )

