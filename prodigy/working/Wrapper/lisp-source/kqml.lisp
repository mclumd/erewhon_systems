(in-package :user)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;  MUST HAVE WRITE PERMISSION FOR EVERYONE ON THIS FILE.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; 
;;; THE PROGRAM PARAMETERS 
;;; 




(defparameter *CS790-style*
    '(:style 
      (*cs790-style*
	  (start      (lambda (stream)
			(format stream "~%( ")
			)
	   )
	  (head-print (lambda (head stream)
			(format stream "~s "  head)
			)
	   )
	(role-print (lambda (role stream)
		      (if (second role)
			  (format stream "~s "  (second role)))
		      )
	 )
	(done (lambda (stream)
		(format stream ")"))
	 ) 
	)				;default
      )
  "default for CS790 Term Proj"
  )


(setf  *current-style*
    '*CS790-style*
  )

;;; 
;;; Used for testing. The default is a simulated achieve request.
;;; 
;;; Here is an old test:
;;;(setf x '(achieve :sender joe :content (((on-top Window1)))))
;;; 
(defparameter
    *test-performative*
    '(achieve 
      :sender AgentA
      :content 
      (
       (
	(at-obj package1 bos-po)
	)
       (
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
	)
       )
      :receiver PRODIGY-Wrapper
      :reply-with My-Reply
      :language PDL
      :ontology
      "/usr/local/users/mcox/prodigy/working/domains/gtrans/domain.lisp"
					; "/usr/local/users/mcox/prodigy/working/domains/logistics/domain.lisp"
      )
  "Used to test the behavior of the PRODIGY/Agent."
  )






;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; 
;;; THE GLOBAL VARIABLES 
;;; 



;;; This holds the reply-with field of the achieve message, so that the returns
;;; messages can pass it back."
(defvar 
    *achieve-id*
    nil
  "This holds the reply-with field of the achieve message."
  )


;;; 
;;; The global var *has-state-info* signals the presence of PRODIGY
;;; state and object information for the current problem. 
;;; 
;;; When receiving an achieve performative, PRODIGY/Agent looks to see
;;; if initial state info is known. If not, it sends a query to the
;;; requesting agent asking for the info.
;;; 
;;; Currently (29oct00) not used.
;;; 
(defvar *has-state-info*
    nil
  "Signals the presence of PRODIGY state and object information."
  )


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; 
;;; THE PREDICATES
;;; 



;;; 
;;; Predicate is-achieve-performative-p tests whether the given
;;; content-field is an achieve.
;;; 
(defun is-achieve-performative-p (content-field)
  (equal 'achieve
	 (first content-field))
  )






;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; 
;;; THE MAJOR FUNCTIONS
;;; 



;;; 
;;; Function handle-kqml is the main function to interpret a
;;; performative sent to PRODIGY/Agent. 
;;; 
;;; The argument msg is assumed to be a string. It is immediately
;;; converted to a list an assigned to the optional parameter
;;; converted-request
;;; 
(defun handle-kqml (msg
		    &optional 
		    (converted-request 
		     (read-from-string msg))
		    (silent-p t)
		    )
  (let ((performative 
	 (first converted-request))
	 )
    (cond ((isa-performative-p 
	    performative)
	   (if (not silent-p)
	       (format 
		t
		"~%The KQML msg is: ~S~%"
		msg))
	   ;;Return the evaluation value
	   (or (eval converted-request)
	       t))
	  (t
	   ;; Not a performative
	   (format 
	    t
	    "~%ERROR: ~s not a performative~%"
	    performative)
	   ;; Return nil
	   nil
	   )
	  ))
  )




;;; 
;;; Function run-with-params is called by the next macro in performatives.lisp.
;;; 
;;; What if the content is NOT an achieve request?
(defun run-with-params (&key (search-default 'depth-first)
			     (depth-bound 50)
			     max-nodes
			     time-bound
			     (output-level 2)
			     multiple-sols)
  (cond (t
;	 (setf *first-run* nil)
	 (run :search-default search-default
	      :depth-bound depth-bound
	      :max-nodes max-nodes
	      :time-bound time-bound
	      :output-level output-level
	      :multiple-sols (if multiple-sols
				 t)
	      ))
;	(t
;	 (format
;	  t
;	  "~%In run-with-params: SHould NOT be here.~%")
;	 )
	)
  )


;;; 
;;; next 3 are specific to Multi-soln version but are not yet used by any
;;; code. Function set-4-multiple-sols is called by registrar-loop in file
;;; registrar.lisp, but is-first-run-p is never called (nor is *first-run*
;;; accessed directly).
;;; 

(defvar *first-run* nil 
  "If t PRODIGY has not run through 2 multiple solutions.")

(defun is-first-run-p ()
  *first-run*)

;;; Called in function registrar-loop (file registrar.lisp)
(defun set-4-multiple-sols ()
  (setf *first-run* t)
  )




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; 
;;; THE PERFORMATIVES 
;;; 
;;; (that PRODIGY/Agent can send to agents)
;;; 
;;;




(defun ask-one (&key sender 
		     content 
		     receiver 
		     reply-with 
		     (language 'PDL)
		     (ontology
		      (concatenate
			  'string
			*prodigy-base-directory*
;			"working/domains/logistics/domain.lisp")))
  			"working/domains/gtrans/domain.lisp")))
  (cond ((equal sender "PRODIGY-Wrapper")
	 (send-to-socket 
	  (format nil "~S"
		  `(ask-one
		    :sender ,sender 
		    :content ,content
		    :receiver ,receiver
		    :reply-with ,reply-with
		    :language ,language
		    :ontology ,ontology
		    ))
	  *tcl-send*)
	 )
	(t
	 "Here write the code to receive an ask-one."))
  
  )




(defun eos (&key sender 
		 content 
		 receiver 
		 reply-with 
		 (language 'PDL)
		 (ontology
		  (concatenate
		      'string
		    *prodigy-base-directory*
;		    "working/domains/logistics/domain.lisp")))
  		    "working/domains/gtrans/domain.lisp")))
  (cond ((equal sender "PRODIGY-Wrapper")
	 (send-to-socket 
	  (format nil "~S"
		  `(eos
		    :sender ,sender 
		    :content ,content
		    :receiver ,receiver
		    :reply-with ,reply-with
		    :language ,language
		    :ontology ,ontology
		    ))
	  *tcl-send*)
	 )
	(t
	 "Here write the code to receive a eos."))
  
  )



;;; Eventually need to call this something else so that we can have a real tell
;;; macro to handle tell input.
(defun tell (&key sender 
		  content 
		  receiver 
		  reply-with 
		  (language 'PDL)
		  (ontology
		   (concatenate
		       'string
		     *prodigy-base-directory*
;		     "/working/domains/logistics/domain.lisp"))
		     "/working/domains/gtrans/domain.lisp"))
		  )
  (cond ((equal sender "PRODIGY-Wrapper")
	 (send-to-socket 
	  (format nil "~S"
		  `(tell
		    :sender ,sender 

		    :content ,content
		    :receiver ,receiver
		    :reply-with ,reply-with
		    :language ,language
		    :ontology ,ontology
		    ))
	  *tcl-send*)
	 )
	(t
	 (format
	  t
	  "Here write the code to receive a tell message.")))
  )



;;; 
;;; Ask Carolina a yes/no question
;;; 
(defun ask-if (&key sender 
		     content 
		     receiver 
		     reply-with 
		     (language 'PDL)
		     (ontology
		      (concatenate
			  'string
			*prodigy-base-directory*
;			"working/domains/logistics/domain.lisp")))
  			"working/domains/gtrans/domain.lisp")))
  (cond ((equal sender "PRODIGY-Wrapper")
	 (send-to-socket 
	  (format nil "~S"
		  `(ask-if
		    :sender ,sender 
		    :content ,content
		    :receiver ,receiver
		    :reply-with ,reply-with
		    :language ,language
		    :ontology ,ontology
		    ))
	  *tcl-send*)
	 )
	(t
	 "Here write the code to receive an ask-one."))
  
  )



