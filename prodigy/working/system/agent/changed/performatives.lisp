(in-package :user)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; 
;;; HISTORY
;;; 
;;; 24sep04 
;;; Added new use of inform performative for Michelle's project. She needs to
;;; request from Prodigy/Agent a partial order plan. Thus a
;;; 'PARTIAL-ORDER-REQUEST symbol in the content field of an inform will
;;; generate a raw response of the partial order matrix. The code additions in
;;; function handle-GTrans-informs and macro inform assumes that the user has
;;; loaded code in *system-directory* agent/lisp-source.



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; 
;;; THE PROGRAM PARAMETERS 
;;; 

;;;
;;; the inform macro uses this to keep track of threshold for Jeremy's CONDUIT.
;;; 
(defvar 
    *window-count*
    0
  "The number of windows open so far informed by CONDUIT."
  )

;;; 
;;; When the program parameter *interactive-wrapper* has the value t,
;;; the achieve macro prompts the user whether or not to run PRODIGY.
;;; 
(defparameter 
    *interactive-wrapper*
    nil
  "When t, achieve asks the user before running PRODIGY."
  )



;;; 
;;; The program parameter *kqml-performatives* lists the kqml
;;; performatives defined for PRODIGY/Agent.
;;; 
(defparameter *kqml-performatives*
    '(;; For planning conversation
      achieve
      next
      cancel
      standby
      ask-one
      eos
      tell
      inform
      
      ;; Next 3 for constraint eval conversation
      
      ask-about				;Currently (29oct00) not implemented
      ask-if
      reply

      ;; Used implicitly only
      quit
      )
  "The list of kqml performatives defined for PRODIGYAgent."
  )



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; 
;;; THE GLOBAL VARIABLES 
;;; 



;;; 
;;; The *done* global variable is used to stop both the registrar-loop
;;; and registrar functions in file registrar.lisp." It is set to t by
;;; the cancel performative.
;;;
(defvar *done* nil)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; 
;;; THE PREDICATES
;;; 



;;; Predicate isa-performative-p returns t iff the argument symbol is a member
;;; of the list of known kqml performatives
;;; 
(defun isa-performative-p (symbol)
  (if (member symbol 
	      *kqml-performatives*)
      t)
  )


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; 
;;; UTILITY FUNCTIONS
;;;


;;; Function process-ontology parses the ontology field into global variables 
;;; *world-path*, *domain-name* and *domain-file* used by performative macros
;;; [mme 19Sep 01]
;;;

(defun process-ontology(ontology)

    ;;Divide the ontology field to global variables
    ;;*domain-name* & *world-path*
    (let* ((rstr (reverse ontology))
	   (newstr (subseq rstr (+ (search "/" rstr) 1) )))
      (setf *domain-name* (read-from-string 
			   (reverse (subseq newstr 0 (search "/" newstr)))))
      (setf *world-path* (reverse (subseq newstr (+ (search "/" newstr) 1))))
    )
    
    ;; set the global variable *domain-file* to contain the current path
    (setf *domain-file* 
      (concatenate 'string 
	*world-path* "/" (string-downcase *domain-name*) "/domain.lisp"))
)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; 
;;; THE PERFORMATIVES
;;; 
;;; (that PRODIGY/Agent can receive from agents)
;;;
;;; Because these are macros, they should not be compiled?
;;; See *wrapper-home* loader.lisp. 
;;;


(defmacro cancel (&key sender 
		       content 
		       (receiver 'PRODIGY-Agent) 
		       reply-with 
		       (language 'PDL)
		       (ontology *domain-file*))

  (setf *done* t)
  (format
   t
   "~%Received CANCEL.~%")
  nil
  )



;;; The macro achieve takes from the content field a list of three
;;; elements. These elements themselves are lists. The first element is the
;;; *goal-list*, the second is the *object-list*, and the third is the
;;; *state-list*. See file set-problem.lisp in the jade directory off system
;;; dir in prodigy.
;;;
(defmacro achieve (&key (run-now t)
		        sender 
			content 
			(receiver 'PRODIGY-Agent) 
			reply-with 
			(language 'PDL)
			(ontology *domain-file*))

					
;; if ack received and content not null
  (when (and content (pingACK 'achieve))
    (setf *achieve-id* reply-with)	;REMOVE LATER
;   (setf *sender-name* sender)

    ;; extract *world-path*, *domain-name* from ontology field [mme 19Sep 01]
    (process-ontology ontology)
    
    (domain *domain-name*)
    
    ;; extract goal, object, and state lists from content
    (setf *goal-list* 
      (append '(and) (first content)))
    
    ;;check to see whether state and object lists are specified
    (if (> (length content) 2)
	(progn
          (setf *object-list* (second content))
          (setf *state-list*  (third content))
	  (setf *has-state-info* t))

        ;;else
        ;;if object and state list not specified in content, and also
        ;;not known previously, query the Prodigy-Client, get state-info 
      (if (not *has-state-info*)
	  (progn
	    (send-message `(query :sender (quote ,receiver)
		:content
		(state-list object-list)
		:receiver ,sender
		:reply-with ,reply-with
		:language ,language
		:ontology ,ontology))
	    
	    (let ((state-info (read-message)))
	       (setf *object-list* (first state-info))
               (setf *state-list*  (second state-info))
	       (setf *has-state-info* t)))))
    
    (set-problem *goal-list*)
    (if *interactive-wrapper*
	(format t "Run?~%"))
    
    ;; Check for the time-bound value, which is last element of content field
    (let ((last-element (first (last content))))
        (if (numberp last-element)    ;; if the last element is a number
	
	    ;; calculate time limit [=90% of the received time-bound value]
            (setf time-limit (* 0.9 last-element))
	
	  (setf time-limit 1000)   ;; default value
	  ))
    
    (when (and run-now
	       (or
		(not 
		 *interactive-wrapper*)
		(y-or-n-p)))
      (let ((result (run :time-bound time-limit)))
	(if (null 
	     ;;Changed test from from solutions to solutionp [mcox 29oct00]
	     (prodigy-result-solutionp result))
	    (send-message '(eos :sender receiver
		 :content
		 "NO (MORE) PLAN(S) EXISTS"
		 :receiver sender
		 :reply-with reply-with
		 :language language
                 :ontology ontology))

	    (send-message `(tell :sender (quote ,receiver)
		:content
		,(format 
		 nil
		 "~s"
		 (gen-file) ;Call to gen-file fn of frame2alternate.lisp
		 )
		:receiver ,sender
		:reply-with ,reply-with
		:language ,language
		:ontology ,ontology))))
      ))
  )



(defmacro standby (&key sender 
			content 
			(receiver 'PRODIGY-Agent) 
			reply-with 
			(language 'PDL)
			(ontology *domain-file*))

  ;; extract *world-path*, *domain-name* from ontology field [mme 19Sep 01]
  (process-ontology ontology)
  
  (if (is-achieve-performative-p 
       content)
      `(progn
	 (achieve
	  :run-now nil
	  ,@(rest content)) 
	 (ask-one
	  :sender (quote ,receiver)
	  :content "HAVE-PARAMS?"
	  :receiver (quote ,sender)
	  :reply-with "prodigy-ask-one"
	  ))
	 )
  )

;;; code to extract depth-bound from next message [19Sep 01]
;(depth-bound (or *depth-bound*
;		 (setf *depth-bound*
;		   (second (member :depth-bound (eval content))))))

(defmacro next (&key sender 
		     content 
		     (receiver 'PRODIGY-Agent) 
		     reply-with 
		     (language 'PDL)
		     (ontology
		      *domain-file*))

  (let ((m-sols (p4::extract-m-sols-arg	;Function defined in patches3.lisp
		 (eval content))))
    (if (eq m-sols t)
	`(apply #'run-with-params
		,content)
      `(let ((result (p4::call-main-search (quote ,cox-plan) ,m-sols (pspace-prop :depth-bound))))
	 (p4::store-solution (p4::announce-plan (p4::prepare-plan result)))
	 (if (null 
	      ;; (prodigy-result-solutions result)
	      result
		   ) 
	     (eos :sender ,receiver
		  :content
		  "NO PLAN GENERATED"
		  :receiver ,sender
		  :reply-with ,reply-with
		  :language ,language
		  :ontology ,ontology)
	   ;; Wrapped quote around receiver because it is not a string 
	   ;; any longer. [mcox 26may01]
	   (tell :sender (quote ,receiver)
		 :content
		 (format 
		  nil
		  "~s"
		  (gen-file)		;Call to gen-file fn of frame2alternate.lisp
		  )
		 :receiver (quote ,sender)
		 :reply-with (quote ,reply-with)
		 :language (quote ,language)
		 :ontology ,ontology)))
      ))
  )




;;;; 
;;;; This begins the conversation between PRODIGY and the KQML-Carolina Translator Agent.
;;;; 

(defmacro reply (&key (run-now t)
		      sender 
		      content 
		      (receiver 'PRODIGY-Agent) 
		      reply-with 
		      (language 'PDL)
		      (ontology *domain-file*))

  (format t "~%~S~%" sender)
  (format t "~%~S~%" content)
  (format t "~%~S~%" receiver)
  )

;;;
;;; This is the inform macro for conversation between Prodigy-Agent and 
;;; Jeremy's CONDUIT program.
;;;
;;; This informs that a given proposition is true 
;;; [mme Oct30, 01]
;;;
;;; NOTE that *window-stack* var is defined in application-agent.lisp
;;; 
(defmacro inform (&key sender 
		       content 
		       (receiver 'PRODIGY-Agent) 
		       (language 'PDL))

  (cond ((and
	  (consp content)
	  (equal (first content) 'CW))
	 (setf *window-count* 
	   (+ 1 *window-count*))
	 
	 (if (> *window-count* 10)
	     ;; if threshold exceeded, send tell
	     ;; with a random window number  
	     (progn
               (send-message `(tell :sender (quote ,receiver)
				    :content
				    ,(format 
				      nil
				      "~a"
				      (pop *window-stack*)
			;		 (+ (random *window-count*) 1) 
				      )
				    :receiver ,sender
				    :language ,language))

	       (setf *window-count* 0))
	   
	   ;; else send an arbitrary message
	   (progn
	     (push (second (second (member :content request)))
		   *window-stack*)
	     (format t "~%Received INFORM # ~a.~%" *window-count*)
	     (send-message '(inform received)))))
  
	(t 
	 (or
	  (equal content 'PARTIAL-ORDER-REQUEST) ; For Michelle's code [mcox 24sep04]
	  (equal content 'OBJ-REQUEST)
	  (equal content 'GOAL-REQUEST)
	  (equal content 'TREE-GOAL-REQUEST)
	  (equal content 'STATE-REQUEST)
	  )
	 (handle-GTrans-informs content)
	 (format t "~%Processed GTrans inform~%"))
	(t 
	 (format t "~%Received inform without CW~%"))
	))




;;; 
;;; Created in August 2004 to make Prodigy/Agent initialization interaction
;;; with GTrans use inform performative [mcox 24sep04]]
;;; 
(defun handle-GTrans-informs (request)
  (cond 
   ;; This request added for Michelle's code. It delivers a partial order 
   ;; plan matrix and assumes that the code from *base-dir* 
   ;; working/system/ui/order/ 
   ((equal 'PARTIAL-ORDER-REQUEST
	   request)
    (format t "Cond in partial-order-req~%")
    (write-data-to-socket 
     (build-partial
      (prepare-plan-for-partial-order)  
      (get-initial-state)))
    )
	  
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
	  
   (t
    (format t "~%Input ~s Fell thru cracks.~%"
	    request)
    )
   )
  )
