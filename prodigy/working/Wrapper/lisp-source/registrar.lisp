(in-package :user)

;;; A shell stream used to set environment variable.
(defvar *registrar-shell* nil)

(defvar *registrar-command-server* nil)

;;;;
;;;; CODE TO HANDLE UNIQUE PORT NUMBER ASSIGNMENTS 
;;;;

;;; We currently use this default instead of port assignment trough the old
;;; registrar method. Thus we can set different port for sockets in the
;;; multiple CS790 agents running concurrently. Added [10aug00 cox]
;;; 
(defvar *hard-coded--port* 5510)

;;; First available port to be released.
;;;
(defparameter *first-port* 5510)

(defvar *highest-port-released* nil)

(defvar *ports-available* (list *first-port*))

(defvar *port-released-p* nil "Set to t when the first release is made.")


;;;
;;; Changed to use *world-path* [mcox 15nov00]
(defvar *problem-file-name* 
    (concatenate 
	'string 
      *world-path*
      "gtrans/probs/temp-prob.lisp"))


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

(defvar *registrar-quit* nil
  "Global signals to stop system.")

;;;;
;;;; MAIN REGISTRAR CODE
;;;;

;;;
;;; Call this loop to process multiple agent conversations
;;; (sequentially).
;;;
(defun registrar-loop ()
  (setf *registrar-quit* nil
	*done* nil)
  (do ((conversation-num 1 (+ 1 conversation-num)))
      (*registrar-quit*
       nil)
    ;; Defined in kqml.lisp but variable initialized in the fn is never used.
    (set-4-multiple-sols)
    (registrar)
    (format t "~%FINISHED CONVERSATION #~S~%~%"
	    conversation-num))
  )

;;; For now the registrar will be an independent process. It will not spawn
;;; subprocesses.
;;;
(defun registrar (&optional 
		  (registrar-port 
		   *hard-coded--port* ;changed to this from next line [10aug00 cox]
		   ;(release-port)
		   )
		  (silent-p t))
  (connect-with-DND 
   '*registrar-command-server* 
   registrar-port)
  (process-requests 
   registrar-port
   nil)
  )


(defun process-requests (&optional 
			 (registrar-port (release-port))
			 (silent-p t)
			 &aux
			 got-first-msg-p
			 return-val
			 )
  (do ((request (get-socket-message silent-p)
		(get-socket-message silent-p))
       (port-num (release-port)(release-port))
       ) 
      ;; Need to quit more gracefully.
      ((or
	*done* ;Set by cancel performative.
	(equal request "quit")
	(and
	 (equal 'cancel
		(first (read-from-string request)))
	 (setf *registrar-quit* t)))
       (format 
	t 
	"~%Received ~s. ~%Registrar HALT.~%" 
	request)
       (kill-socket-server 
	*registrar-command-server* 
	:silent t)
       (return-port registrar-port))
    (print-feedback request silent-p)
    (when (not got-first-msg-p)
      (send-shell 
       (format 
	nil 
	"setenv DNDPORT \"\"") 
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
	   (send-obj-strings 
	    port-num 
	    silent-p)
	   )
	  ((equal 'goal-request
		  request)
	   (generate-all-goals)
	   )
	  ((equal 'goal-request
		  request)
	   (generate-all-tree-goals)
	   )
	  ((equal 'prob-request
		  request)
	   ;; (domain 'goal-trans)
	   ;; (read-lists *goal-list* *object-list* *state-list*)
	   (set-problem *goal-list*)
	   ;; (run)
	   )
	  ((equal 'plan-request
		  request)
	   (input-wrapper port-num)
	   )
	  ((setf return-val 
	     ;; Function from kqml.lisp
	     (handle-kqml request))
	   (if *done* 
	       (return return-val))
	   )
	  (t
	   (format t "~%Input ~s Fell thru cracks.~%"
		   request))
	  )
    (setf *last-line-from-socket* nil)
    )
  return-val
  )



(defun print-feedback (request
		       silent-p)
  (when (not silent-p)
    (format 
     t 
     "*last-line-from-socket* = ~s.~%" 
     *last-line-from-socket*)
    (format 
     t 
     "Received request ~s~%" 
     request)
    )
  )



;;; This versiom of the registrar uses files rather than sockets to communicate
;;; with GTrans. 
(defun f-version-registrar ( )
  (format t "Registrar Start~%Waiting for request~%")
  (init-shell *registrar-shell* '*registrar-shell*)
  (do ((request (get-file-message)(get-file-message))
       )
      ((equal request 'quit)
       (delete-file *data-file-name*)
       (delete-file *ready1-file-name*)
       (format t "~%Received ~s. ~%Registrar HALT.~%" request))
    (format t "Received request ~s~%" request)
    (cond ((equal 'OBJ-REQUEST
	       request)
	   (format t "Cond in obj-req~%")
	   (delete-file *data-file-name*)
	   (create-data-file (extract-types))
	   )
	  ((equal 'GOAL-REQUEST
	       request)
	   (format t "Cond in goal-req~%")
	   (delete-file *data-file-name*)
	   (create-data-file (generate-all-goals))
	   )
	  ((equal 'TREE-GOAL-REQUEST
	       request)
	   (format t "Cond in tree-goal-req~%")
	   (delete-file *data-file-name*)
	   (create-data-file (generate-all-tree-goals))
	   )
	  ((equal 'STATE-REQUEST
	       request)
	   (format t "Cond in state-req~%")
	   (delete-file *data-file-name*)
	   (create-data-file (generate-all-states))
	   )
	  ((equal 'SAVEP-REQUEST
		  request)
;	   (domain 'gtrans)
	   (multiple-value-setq 
	       (request 
		*object-list* 
		*state-list* 
		*goal-list*)
	     (get-file-message))
	   (setf *goal-list* 
	     (cons 'and *goal-list*))
	   (format t "~s~% ~s~% n~s~%" 
		   *object-list* 
		   *state-list* 
		   *goal-list*)
	   (create-problem-file *problem-file-name*)
	   (delete-file *data-file-name*)
	   )
	  ((equal 'RUN-REQUEST
		  request)
	   (domain 'gtrans)
	   (multiple-value-setq 
	       (request *object-list* *state-list* *goal-list*)
	     (get-file-message))
	   (setf *goal-list* (cons 'and *goal-list*))
	   (format t "~s~% ~s~% n~s~%" 
		   *object-list* 
		   *state-list* 
		   *goal-list*)
	   (delete-file *data-file-name*)
;	   (create-data-file '(quit))
	   (format t "~s~%"
		   (set-problem *goal-list* t))
	   (set-problem *goal-list*)
	   (format t "Run?~%")
	   (if (y-or-n-p)
	       (run))
	   )	  
	  ((equal 'PLAN-REQUEST
		  request)
	   (input-wrapper port-num)
	   )
	  (t (format t "ERROR~%"))
	  )
    (delete-file *ready1-file-name*)
    (create-ready-file)
    (format t "Waiting for Request~%")
    )
  (quit-shell *registrar-shell* 
	      '*registrar-shell*)
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

