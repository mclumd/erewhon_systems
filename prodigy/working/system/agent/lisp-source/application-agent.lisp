(in-package :user)

(defvar *time-out* 10)
(defvar *active-socket* nil)

;; function to establish an active socket using port given as argument  
(defun establish-active-agent-connection (port-to-connect)
  ;;wait for a time interval *time-out* for the connection to
  ;;be established
  (socket:with-pending-connect
      (mp:with-timeout (*time-out* (error "Timeout: Connect failed."))
  (setf *active-socket* 
    (socket:make-socket :remote-host "hypatia" :remote-port port-to-connect))))
  )

;; function to request a kqml performative (through request parameter) and 
;; read returned message from socket
(defun request-and-return-plan (&key
				(socket *active-socket*)
				(request
				 *test-performative1*)
				(no-ack t)
				&aux ack-time-out)
  (format socket "~S" request)
  (finish-output socket)
  
  ;; if no-ack is t, acknowledgement is disabled   
  (cond ((not no-ack)
    
      ;; wait for the ACK from server
      ;; if timeout occurs, close socket connection 
       (mp:with-timeout (*time-out* 
		    (format t "Timeout: ACK not received within time~%")
		    (format t "Connection closed~%")
		    (setf ack-time-out t)
		    (close socket))
          (format t "~%Received ~S from server."  (read socket)))  
    
       ;; send ACK back to server only if ACK received in time
       (cond ((not ack-time-out)
	     (format t "~%Sending ACK back to server...")
	    
	     (format socket "~s~%" 'Go)
	     (finish-output socket)
  
	     ;; to read the dummy message
	     (read socket)))))

  ;; this part executed regardless of ACK
  ;; if-cond used only to avoid execution even if time-out occurred
  (if (not ack-time-out)
	 ;; read return message, send cancel and close socket
	 (let 
	     ((temp 
	       (read socket))
	      )
	   ;; Added to handle stand-by [mcox 26may01]
	   (when (eq (first temp) 'ask-one)
	     (setf temp 
	       (process-standby socket)))	

	   ;; Added to handle query sent by Prodigy-Agent when
	   ;; initial state info is not known [mme 11Sep01]
	   (when (eq (first temp) 'query)
	     (setf temp 
	       (process-query socket)))
	   
	   ;; Added to handle inform sent by Jeremy's CONDUIT [mme 7Nov01]
	   ;; for the first time after receiving inform Prodigy-Agent will
	   ;; send a message back to the client. For subsequent informs, 
	   ;; no messages are sent, except the tell message when *window-count*
	   ;; exceeds the threshold.
	   ;;
	   (when (eq (first temp) 'inform)
	     (setf temp 
	       (process-inform socket)))
           
	   ;; Changed 'cancel to cancel performative [mcox 26may01]
	   (format socket "~S" '(cancel :content nil))
	   (finish-output socket)
	   (close socket)
	   temp
	   ))
)

;; used to start a conversation with prodigy server
;; with a parameter specifying which port to use
(defun send-request (port)
  (establish-active-agent-connection port)  ;should use port variable
  (request-and-return-plan)
)


;;;
;;; Several demos to test behavior of Prodigy-Agent
;;;

;;; Demo 1 # ACHIEVE demo
(defun send-achieve (port)
  (establish-active-agent-connection port) ;should use port variable
  (request-and-return-plan :request *test-performative1*)
  )

;;; Demo 2 # STANDBY demo
(defun send-standby (port)
  (establish-active-agent-connection port) ;should use port variable
  (request-and-return-plan :request *test-performative2*)
  )


;;; Demo 3 # INFORM demo
(defun send-inform (port) 
  (establish-active-agent-connection port) ;should use port variable
  (request-and-return-plan :request *test-performative3*))

;;;
;;; To produce a number of inform messages and receive tell
;;; from Prodigy-Agent when threshold exceeded.
;;;
(defun process-inform (socket &key
			      (request *test-performative3*)
			      &aux temp)

  (format socket "~S" request)
  (finish-output socket)

  (format t
	  "Received ~S~%~%"
	  (setf temp
	    (read socket)))

  (do ()
      ((eq (first temp) 'tell))
    
    (format socket "~S" request)
    (finish-output socket)
    
    (format t
	    "Received ~S~%~%"
	    (setf temp
	      (read socket))))
  temp
  )

;;;
;;; Used to test standby performative. Need to make more general.
;;; [mcox 26may01]
;;; 
(defun process-standby (socket &aux temp)
  ;;(format t "Received ask-one ~s~%~%" temp)
  (format socket
	  "~s"
	  '(next
	    :content
	    (quote (:depth-bound 100 :time-bound 100 :multiple-sols t))
	    :sender PRODIGY-Client))
  (finish-output socket)
  (format t
	  "Received 1st ~S~%~%"
	  (setf temp
	    (read socket)))
  (when (eq (first temp) 'tell)
    ;;(format t "Received tell ~s~%~%" temp)
    (format socket
	    "~s"
	    '(next
	      :content
	      (quote (:multiple-sols :different :depth-bound 100 :time-bound 100))
	      :sender PRODIGY-Client))
    (finish-output socket)
    (format t
	    "Received 2nd ~S~%~%"
	    (setf temp
	      (read socket))))
  (when (eq (first temp) 'tell)
    ;;(format t "Received tell ~s~%~%" temp)
    (format socket
	    "~s"
	    '(next
	      :content
	      (quote (:multiple-sols :different :depth-bound 100 :time-bound 100))
	      :sender PRODIGY-Client))
    (finish-output socket)
    (format t
	    "Received 3rd ~S~%~%"
	    (setf temp
	      (read socket))))
  (when (eq (first temp) 'tell)
    ;;(format t "Received tell ~s~%~%" temp)
    (format socket
	    "~s"
	    '(next
	      :content
	      (quote (:multiple-sols :different :depth-bound 100 :time-bound 100))
	      :sender PRODIGY-Client))
    (finish-output socket)
    (format t
	    "Received 4th ~S~%~%"
	    (setf temp
	      (read socket))))
  temp
  )


;;;
;;; Used to test query sent by Prodigy-Agent to the client when 
;;; context (state info) is not known. [mme 11Sep01]
;;; 
(defun process-query (socket &aux temp)
  ;;(format t "Received ask-one ~s~%~%" temp)
  (format socket
	  "~s"
	  '((
	(object-is package1  OBJECT)
	(objects-are pgh-truck bos-truck  TRUCK)
	(objects-are airplane1 airplane2 AIRPLANE)
	(objects-are bos-po pgh-po POST-OFFICE)
	(objects-are pgh-airport bos-airport  AIRPORT)
	(objects-are pittsburgh boston CITY)
	)
       ( 
	(at-obj package1 pgh-po)
	(at-airplane airplane1 pgh-airport)
	(at-airplane airplane2 pgh-airport)
	(at-truck pgh-truck pgh-po)
	(at-truck bos-truck bos-po)
	(part-of bos-truck boston)
	(part-of pgh-truck pittsburgh)
	(loc-at pgh-po pittsburgh)
	(loc-at pgh-airport pittsburgh)
	(loc-at bos-po boston)
	(loc-at bos-airport boston)
	(same-city bos-po bos-airport)
	(same-city pgh-po pgh-airport)
	(same-city pgh-airport pgh-po)
	(same-city bos-airport bos-po)
	)))
     (finish-output socket)
     (format t
	    "Received ~S~%~%"
	    (setf temp
	      (read socket))))
