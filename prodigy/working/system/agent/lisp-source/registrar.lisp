(in-package :user)

;;; A shell stream used to set environment variable.
(defvar *registrar-shell* nil)
(defvar *language* 'LISP)
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
;;; Added [cox 27mar01]
;;; 
(defvar *domain-name* 
    'gtrans)

;;; 
;;; Changed to use *world-path* [mcox 15nov00] and *domain-name* [cox 27mar01]
;;; 
(defvar *problem-file-name* 
    (concatenate 
	'string 
      *world-path*
      (string-downcase
       (format nil "~s" *domain-name*))
      "/probs/temp-prob.lisp"))



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
(defun registrar-loop (port &optional
			    do-not-ask)
  (init-domain-extract) ;Added [31jan01 cox]
  (setf *registrar-quit* nil
	*done* nil)
  
  (establish-passive-agent-connection port)
  
  (do ((conversation-num 1 (+ 1 conversation-num)))
      (*registrar-quit*
       nil)
    ;; Defined in kqml.lisp but variable initialized in the fn is never used.
    (set-4-multiple-sols)    
    (registrar port)
    
    ;; if second argument is true, don't ask user, continue by default
    ;; mme [14Jan02]
    (if (not do-not-ask)
	(progn
          (format t "~%FINISHED CONVERSATION #~S~%~%"
	      conversation-num)
    
          (format t "~%Continue? ")
          (if (not 
	       (y-or-n-p))
	     (setf *registrar-quit* t))))
        )
  (close *passive-socket*)		; close socket stream
)

;;** changed by mme
(defvar *passive-socket* nil)
(defvar *str-socket* nil)

(defun establish-passive-agent-connection (&optional
					   port)
  (setf *passive-socket* 
    ;; Added with-pending-connect and timeout so that clean
    ;; failure occurs when the system cannot make a socket in a reasonable
    ;; amout of time.  [cox 6jun01]
    (socket:with-pending-connect
	(mp:with-timeout (10 (error "connect failed"))
	  (socket:make-socket :connect :passive :local-port port))))
  )


;;; For now the registrar will be an independent process. It will not spawn
;;; subprocesses.
;;;
(defun registrar (&optional 
		  registrar-port 
		   ;*hard-coded--port* ;changed to this from next line [10aug00 cox]
		   ;(release-port)
		   ;)
		  (silent-p t))

  ;; ** commented by mme
  ;(connect-with-DND             
  ; '*registrar-command-server* 
  ; registrar-port)
  ;; **
  
  (setf *str-socket* (socket:accept-connection *passive-socket*))
  
  (process-requests 
   registrar-port
   nil)
  )



#|
;; OLD process-requests - without merging f-version-registrar

(defun process-requests (&optional 
			 (registrar-port (release-port))
			 (silent-p t)
			 &aux
			 got-first-msg-p
			 return-val
			 )
  
  ;; reading is now generalized for both Java and Lisp interface
  ;; For java, read-from-string used to convert socket data read as string
  (do ( 
       (request 
	   (if (eq *language* 'LISP)
		    (read *str-socket*)
	     (read-from-string (read *str-socket*)))
	   
	   (if (eq *language* 'LISP)
	            ;; Added option args. [6jun01 mcox]
		    (read *str-socket* nil '(eof))
	     (read-from-string (read *str-socket* nil '(eof))))
        )
      )

      ;; Need to quit more gracefully.
      ((or
	*done*	;Set by cancel performative.
	(equal request 'quit)
        ;; should be changed to be performed by cancel performative
	(or
	 ;; Added test for eof to make sure that input exists [6jun01 mcox]
	 (equal request '(eof))
	 (equal request 'cancel)
	 (and (consp request) 
	      (eq (first request) 'cancel))
	 ;(setf *registrar-quit* t) ;; commented to work with > 2 agents
	)
       )

       (format 
	t 
	"~%Received ~s. ~%Registrar HALT.~%" 
	request)
       ;; ** commented and changed by mme
       ;(kill-socket-server 
       ;   *registrar-command-server* 
       ;:silent t)
       
       ;;re-initialize global var for known state and object list
       (setf *has-state-info* nil)
       
       (close *str-socket*)
				        ; (return-port registrar-port)
       )
					;(print-feedback request silent-p)
    
    (cond ((equal "obj-request" request)
	       (format t "Cond in obj-req~%")
	  )
	  
	  ((setf return-val 
	     ;; Function from kqml.lisp
	       (handle-kqml request)
	       )
	   
	   (if *done* 
	       (return return-val)
	       
	   )
	  )
	  
	  (t
	   (format t "~%Input ~s Fell thru cracks.~%"
		   request)
	  )
	)
   
    )
  return-val
  )
|#

;; NEW process-requests - f-version-registrar merged
;; changed so that GTrans can use registrar-loop instead of f-version-registrar
;; [mme 3Dec01]
(defun process-requests (&optional 
			 (registrar-port (release-port))
			 (silent-p t)
			 &aux
			 got-first-msg-p
			 return-val
			 )
  
  (init-domain-extract)			;Added [31jan01 cox]
  
  ;; reading is now generalized for both Java and Lisp interface
  ;; For java, read-from-string used to convert socket data read as string
  (do ( 
       (request 
	   (if (eq *language* 'LISP)
		    (read *str-socket*)
	     (read-from-string (read *str-socket*)))
	   
	   (if (eq *language* 'LISP)
	            ;; Added option args. [6jun01 mcox]
		    (read *str-socket* nil '(eof))
	     (read-from-string (read *str-socket* nil '(eof))))
        )
      )

      ;; Need to quit more gracefully.
      ((or
	*done*	;Set by cancel performative.
	(equal request 'quit)
        ;; should be changed to be performed by cancel performative
	(or
	 ;; Added test for eof to make sure that input exists [6jun01 mcox]
	 (equal request '(eof))
	 (equal request 'cancel)
	 (and (consp request) 
	      (eq (first request) 'cancel))
	 ;(setf *registrar-quit* t) ;; commented to work with > 2 agents
	)
       )

       (format 
	     t 
	     "~%Received ~s. ~%Registrar HALT.~%" 
	     request)
       
       ;;re-initialize global var for known state and object list
       (setf *has-state-info* nil)
       
       ;; close socket connection used for current conversation
       (close *str-socket*)
				        ; (return-port registrar-port)
       )
					;(print-feedback request silent-p)
    
    (cond 
	  ((equal 'OBJ-REQUEST
	       request)
	   (format t "Cond in obj-req~%")
	   (write-data-to-socket (extract-types))
	   )
	  
	  ((equal 'GOAL-REQUEST
	       request)
	   (format t "Cond in goal-req~%")
	   (write-data-to-socket (generate-all-goals))
	   )
	  
	  ((equal 'TREE-GOAL-REQUEST
	       request)
	   (format t "Cond in tree-goal-req~%")
	   (write-data-to-socket (generate-all-tree-goals))
	   )
	  
	  ((equal 'STATE-REQUEST
	       request)
	   (format t "Cond in state-req~%")
	   (write-data-to-socket (remove-duplicates
			      (generate-all-states)
			      :test
			      #'equal))
	   )
	  
	  ((equal 'SAVEP-REQUEST
		  request)
	   ;(multiple-value-setq 
	   ;    (request 
	   (let* ((templist 
		  (if (eq *language* 'LISP)
		    (read *str-socket*)
	       (read-from-string (read *str-socket*)))))
	       (setf *object-list* (first templist)) 
	       (setf *state-list* (first (rest templist)))
	       (setf *goal-list* (first (rest (rest templist))))
	     )
	   (setf *goal-list* 
	     (if (has-variablized-goals *goal-list*)
		 (list (first *goal-list*)
		       (cons 'and (second *goal-list*)))
	       (cons 'and *goal-list*)))
	   (format t "~s~% ~s~% n~s~%" 
		   *object-list* 
		   *state-list* 
		   *goal-list*)
	   (create-problem-file *problem-file-name*)
	   (format *str-socket* 
		 "READY~%")
	   (finish-output *str-socket*)
	   )
	  
	  (;; Added [cox 27mar01]
	   (equal 'CHANGE-DOMAIN-REQUEST
		  request)
	   ;(multiple-value-setq 
	   ;    (request 
		(setf *domain-name*
	     (if (eq *language* 'LISP)
		    (read *str-socket*)
	       (read-from-string (read *str-socket*)))
	     )
	   (setf *domain-file*
	       (concatenate 'string
		 *world-path*
		 (string-downcase
		  (format nil "~s" *domain-name*))
		 "/domain.lisp")
	     )
	   (setf *problem-file-name* 
	       (concatenate 
		   'string 
		 *world-path*
		 (string-downcase
		  (format nil "~s" *domain-name*))
		 "/probs/temp-prob.lisp"))
	   (format t "~%Before IDE: Name: ~s File: ~s~%" *domain-name* *domain-file*)
	   (init-domain-extract *domain-file*)
	   (format *str-socket* 
		 "READY~%")
	 (finish-output *str-socket*)
	   )
	  
	  ((equal 'RUN-REQUEST
		  request)
	   (domain *domain-name*)
	   (multiple-value-setq 
	       (request *object-list* *state-list* *goal-list*)
	     (if (eq *language* 'LISP)
		    (read *str-socket*)
	       (read-from-string (read *str-socket*)))
	     )
	   (setf *goal-list* (cons 'and *goal-list*))
	   (format t "~s~% ~s~% n~s~%" 
		   *object-list* 
		   *state-list* 
		   *goal-list*)
	   (write-data-to-socket '(quit))
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
	  
	  ;; if a performative, do that
	  ((setf return-val 
	     ;; Function from kqml.lisp
	       (handle-kqml request)
	       )
	   
	   (if *done* 
	       (return return-val)
	   )
	   )
	  
	  (t
	   (format t "~%Input ~s Fell thru cracks.~%"
		   request)
	  )
	)
   
    )
  return-val
  )

(defun write-list (socket alist)
  (cond ((null alist)
	 (format socket 
		 "READY~%")
	 (finish-output socket)
	 )
	(t
	 (format socket 
		 "~s~%"
		 (first alist))
	 (finish-output socket)
	 (write-list socket (rest alist)))
	)
  )


(defun write-data-to-socket (alist
			 &optional 
			  (socket 
			   *str-socket*))
  (write-list socket alist)
  
    (format 
     t 
     "~%Writing DATA to socket~%")
  )

(defun print-feedback (request
		       silent-p)
  ;(when (not silent-p)
  ;  (format 
  ;   t 
  ;   "*last-line-from-socket* = ~s.~%" 
  ;   *last-line-from-socket*)
    (format 
     t 
     "Received request ~s~%" 
     request)
    )
  ;)


;;; 
;;; Returns whether or not input symbol is a variable. A variable is a symbol
;;; that starts with left angle bracket and ends with a right angle
;;; bracket. For example '<truck>.
;;; 
(defun is-var-p (symbol 
		 &aux 
		 (char-list 
		  (if (atom symbol) 
		      (coerce (string symbol) 
			      'list))))
  (and (eq #\< (first char-list))
       (eq #\> (first (last char-list))))
  )


(defun has-variablized-goals (goal-list
			      &aux
			      (first-sublist (and (consp goal-list)
						  (first goal-list)))
			      (first-var-list (and (consp first-sublist)
						   (first first-sublist))))
  (and (consp first-var-list)
       (is-var-p (first first-var-list)))
  )


;;; This versiom of the registrar uses files rather than sockets to communicate
;;; with GTrans. 
(defun f-version-registrar ( )
  (format t "Registrar Start~%Waiting for request~%")
  (init-shell *registrar-shell* '*registrar-shell*)
  (init-domain-extract) ;Added [31jan01 cox]
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
	   (create-data-file (remove-duplicates
			      (generate-all-states)
			      :test
			      #'equal))
	   )
	  ((equal 'SAVEP-REQUEST
		  request)
	   (multiple-value-setq 
	       (request 
		*object-list* 
		*state-list* 
		*goal-list*)
	     (get-file-message))
	   (setf *goal-list* 
	     (if (has-variablized-goals *goal-list*)
		 (list (first *goal-list*)
		       (cons 'and (second *goal-list*)))
	       (cons 'and *goal-list*)))
	   (format t "~s~% ~s~% n~s~%" 
		   *object-list* 
		   *state-list* 
		   *goal-list*)
	   (create-problem-file *problem-file-name*)
	   (delete-file *data-file-name*)
	   )
	  (;; Added [cox 27mar01]
	   (equal 'CHANGE-DOMAIN-REQUEST
		  request)
	   (multiple-value-setq 
	       (request 
		*domain-name*)
	     (get-file-message))
	   (setf *domain-file*
	       (concatenate 'string
		 *world-path*
		 (string-downcase
		  (format nil "~s" *domain-name*))
		 "/domain.lisp")
	     )
	   (setf *problem-file-name* 
	       (concatenate 
		   'string 
		 *world-path*
		 (string-downcase
		  (format nil "~s" *domain-name*))
		 "/probs/temp-prob.lisp"))
	   (init-domain-extract *domain-file*)
;	   (delete-file *data-file-name*)
	   )
	  ((equal 'RUN-REQUEST
		  request)
	   (domain *domain-name*)
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


(defun build-problem-statement (goal-action 
				&optional
				(object-list
				 *object-list*)
				(state-list
				 *state-list*
				 )
				(prob-name *prob-name*)
				 
				)
  `((name ,prob-name)			; Added this so non-JADE code
					; can use it. [11dec99 cox]
    (objects ,@object-list)
    (state
     (and ,@state-list))
    ,(if (has-variablized-goals goal-action)
	 (cons 'goal goal-action)
       `(goal
	 ,(if (null goal-action)
	      (if (null state-list)
		  '(and)		; Dummy goal always evaluates to true during (run).
		(first state-list))
	    (if (is-ForMAT-goal-action-p goal-action)
		(if fe::*ForMat-Loaded* 
		    (fe::translate-goals goal-action)
		  (error "ERROR in function build-problem-statement."))
	      goal-action))
	 )))
  )


