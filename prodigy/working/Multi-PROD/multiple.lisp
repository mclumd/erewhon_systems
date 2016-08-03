(in-package :user)

;;;; NOT SURE THAT THE NON-BLOCKING MODE FOR FAKE-P4P IS RIGHT.

(defvar *muliple-PRODIGYs-on*
    t
  "When t multiple copies of PRODIGY are cooperating.")



;;; 
;;; Transform a literal into its list equivalent
;;; 
(defun literal->list (lit)
  (declare (type literal lit)
	   )
  (cons (p4::literal-name lit)
	(let ((l) 
	      (a (p4::literal-arguments 
		  lit)))
	  (dotimes (i (array-dimension a 0)) 
	    (setf l 
	      (cons (p4::prodigy-object-name 
		     (aref a i)) 
		    l)))
	  (reverse l)))
  )


;;; 
;;; Take a literal, change it into a list form, return a list whose first
;;; element is either 'a (add) or 'd (delete) and whose second element is the
;;; transformed literal.
;;; 
;;; return for example (a (on blocka blockb))
;;; 
(defun literal->data (lit add-p)
  (cons
   (if add-p
       'a
     'd)
   (list
    (literal->list lit)))
  )


;;; 
;;; Fake-P4P code in Wrapper/P4P/fake-P4P.lisp
;;; 
;;; NOTE that the add-and-deletes, i.e., the deltas passed here, are deletes
;;; first and then adds.
;;;  
(defun declare-2-others (deltas)
  (fake-P4P
   (list
    (append
     (mapcar #'literal->data
	     (first deltas)
	     (make-list 
	      (length (first deltas)) 
	      :initial-element nil))
     (mapcar #'literal->data
	     (second deltas)
	     (make-list 
	      (length (second deltas)) 
	      :initial-element t))   
     )
    )
   t ;non-blocking is t
   )
  )





(defun tell-user-state-change (signal)
  (format 
   t
   "~%detect-change on signal ~S~%"
   signal)
  (probe-file
   *data-file-name*)
  )

;;;(add-handler 'detect-change :always)


(defun do-session (&optional
		   (is-accepter-p)
		   (port 5510)
		   )
  (init-vars)
  (if is-accepter-p
      (wait-4-socket-connect port)
    (connect-2-socket port)
    )
  (reset)  
  (run)
  (format 
   *env-socket*
   "DONE~%")
  (force-output
   *env-socket*)
  (if (not *other-PROD-Stopped*)
      (do ((collaborator-response
	    (read *env-socket*)
	    (read *env-socket*))
	   )
	  ((eq
	    collaborator-response
	    'DONE))
	(format t "~S~%"
		collaborator-response)
	)
    )
  (close-socket *env-socket*)
  )

