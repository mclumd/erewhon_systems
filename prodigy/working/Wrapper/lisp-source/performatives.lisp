;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; 
;;; THE PROGRAM PARAMETERS 
;;; 




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
;;; THE PERFORMATIVES
;;; 
;;; (that PRODIGY/Agent can receive from agents)
;;;
;;; Because these are macros, they should not be compiled?
;;; See *wrapper-home* loader.lisp. 
;;;





(defmacro cancel (&key sender 
		       content 
		       (receiver "PRODIGY-Wrapper") 
		       reply-with 
		       (language 'PDL)
		       (ontology
			(concatenate
			 'string
			 *prodigy-base-directory*
;			 "working/domains/logistics/domain.lisp")))
  			 "working/domains/gtrans/domain.lisp")))
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
			(receiver "PRODIGY-Wrapper") 
			reply-with 
			(language 'PDL)
			(ontology
			 (concatenate
			     'string
			   *prodigy-base-directory*
;			   "/working/domains/logistics/domain.lisp")))
  			   "/working/domains/gtrans/domain.lisp")))
					;  (format t "~%~S~%" sender)
					;  (format t "~%~S~%" content)
					;  (format t "~%~S~%" receiver)
  (when content
    (setf *achieve-id* reply-with)	;REMOVE LATER
					;    (setf *sender-name* sender)
;    (domain 'logistics)
    (domain 'gtrans)
    (setf *goal-list* 
      (append '(and) (first content)))
    (setf *object-list* (second content))
    (setf *state-list*  (third content))
    (set-problem *goal-list*)
    (if *interactive-wrapper*
	(format t "Run?~%"))
    (when (and run-now
	       (or
		(not 
		 *interactive-wrapper*)
		(y-or-n-p)))
      (let ((result (run)))
	(if (null 
	     ;;Changed test from from solutions to solutionp [mcox 29oct00]
	     (prodigy-result-solutionp result))
	    (eos :sender receiver
		 :content
		 "NO (MORE) PLAN(S) EXISTS"
		 :receiver sender
		 :reply-with reply-with
		 :language language
		 :ontology ontology)
	  (tell :sender receiver
		:content
		(format 
		 nil
		 "~s"
		 (gen-file) ;Call to gen-file fn of frame2alternate.lisp
		 )
		:receiver sender
		:reply-with reply-with
		:language language
		:ontology ontology)))
      ))
  )



(defmacro standby (&key sender 
			content 
			(receiver "PRODIGY-Wrapper") 
			reply-with 
			(language 'PDL)
			(ontology
			 (concatenate
			     'string
			   *prodigy-base-directory*
;			   "/working/domains/logistics/domain.lisp")))
  			   "/working/domains/gtrans/domain.lisp")))
  (if (is-achieve-performative-p 
       content)
      `(progn
	 (achieve
	  :run-now nil
	  ,@(rest content)) 
	 (ask-one
	  :sender ,receiver
	  :content "HAVE-PARAMS?"
	  :receiver (quote ,sender)
	  :reply-with "prodigy-ask-one"
	  ))
	 )
  )





(defmacro next (&key sender 
		     content 
		     (receiver "PRODIGY-Wrapper") 
		     reply-with 
		     (language 'PDL)
		     (ontology
		      (concatenate
		       'string
		       *prodigy-base-directory*
;		       "working/domains/logistics/domain.lisp")))
  		       "working/domains/gtrans/domain.lisp")))
  (if (p4::extract-m-sols-arg (eval content)) ;Function defined in patches3.lisp
      `(apply #'run-with-params
			   ,content)
      `(let ((result (apply #'run-with-params
			   ,content)))
	(if (null (prodigy-result-solutions result)) 
	    (eos :sender ,receiver
		 :content
		 "NO PLAN GENERATED"
		 :receiver ,sender
		 :reply-with ,reply-with
		 :language ,language
		 :ontology ,ontology)
	  (tell :sender ,receiver
		:content
		(format 
		 nil
		 "~s"
		 (gen-file) ;Call to gen-file fn of frame2alternate.lisp
		 )
		:receiver (quote ,sender)
		:reply-with (quote ,reply-with)
		:language (quote ,language)
		:ontology ,ontology)))
    )
  )




;;;; 
;;;; This begins the conversation between PRODIGY and the KQML-Carolina Translator Agent.
;;;; 

(defmacro reply (&key (run-now t)
		      sender 
		      content 
		      (receiver "PRODIGY-Wrapper") 
		      reply-with 
		      (language 'PDL)
		      (ontology
		       (concatenate
			   'string
			 *prodigy-base-directory*
					;			  "/working/domains/logistics/domain.lisp")))
			 "/working/domains/gtrans/domain.lisp")))
  (format t "~%~S~%" sender)
  (format t "~%~S~%" content)
  (format t "~%~S~%" receiver)
  )




