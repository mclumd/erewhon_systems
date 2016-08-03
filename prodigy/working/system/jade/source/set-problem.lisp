(in-package "USER")

;;;
;;; HISTORY
;;;
;;; 11dec99 Changed code so can be used by programs other than the JADE module
;;; of PRODIGY.
;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;
;;;; SET-PROBLEM.LISP
;;;;
;;;; This program facilitates the creation and testing of problems. Instead of 
;;;; having to define problems in a problem file within the probs directory,
;;;; the programmer can define the three program parameters below:
;;;; *object-list*, *state-list*, and *goal-list*. The example in this file
;;;; represents the Sussman Anomaly.
;;;;
;;;; Initial State:
;;;;
;;;;    C
;;;;    A  B  
;;;;
;;;; Goal State:
;;;;
;;;;    A
;;;;    B  
;;;;    C
;;;;
;;;; Calling the function (set-problem *goal-list* t) will generate the form
;;;; 
;;;; (setf (current-problem)
;;;;       (create-problem (name prod-format.185)
;;;;                       (objects (objects-are blocka blockb blockc object))
;;;;                       (state (and (on-table blocka) (on-table blockb)
;;;;                                   (on blockc blocka) (clear blockb)
;;;;                                   (clear blockc) (arm-empty)))
;;;;                       (goal (and (on blocka blockb) (on blockb blockc)))))
;;;;
;;;; although the name of the problem may differ from the above name 
;;;; "prod-format.185". Calling the function without the optional second 
;;;; parameter (or passing nil as a second argument) results in such a form 
;;;; being evaluated and a new problem being created. Note that to do such an 
;;;; action requires that the PRODIGY problem space already be initialized. We 
;;;; suggest first calling the domain function; for instance, the call (domain 
;;;; "blocksworld") will load the appropriate domain and functions files. This
;;;; must be done only once per session, unless the programmer changes the 
;;;; operators or functions present in these files.
;;;;
;;;; Finally, the function create-problem-file can be used to write to disk the 
;;;; debugged problem of your choice. Simply pass the function a file-name 
;;;; (with path to the proper probs directory) to which the problem definition 
;;;; should be written (e.g., (create-problem-file "sussman.lisp")).
;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;; 
;;; Added this variable when generalizing code for non-JADE systems. [11dec99 cox]
;;; Can override the value.
;;;
(defvar *prob-name* (gentemp "PROD-FORMAT."))


;;;
;;; The following three global variables should be set to appropriate values by
;;;  another file when using this code. 
;;;

;;;
;;; Global variable *object-list* defines the objects in the initial state. 
;;; This value, along with global variable *state-list* below, is used to 
;;; create new problems for planning runs. See function build-problem-
;;; statement. 
;;;
(defvar *object-list*
  '(
    (objects-are blockA  blockb blockC object)
    )
  "Defines the objects in initial state.")



;;;
;;; Global variable *state-list* defines the initial state, given the objects 
;;; in the global variable *object-list* above. This value, along with
;;; *object-list*, is used to create new problems for planning runs. See 
;;; function build-problem-statement. 
;;;
(defvar *state-list*
  '(
    (on-table blockA)
    (on-table blockB)
    (on blockC blockA)
    (clear blockB)
    (clear blockC)
    (arm-empty)
    )
  "Defines PRODIGY's initial state.")



;;;
;;; Global variable *goal-list* defines the current PRODIGY goal(s). The 
;;; programmer can therefore call (set-problem *goal-list*) to establish these
;;; goals with the above initial state. One does not have to call the "problem" 
;;; function.
;;;
(defvar *goal-list*
  '(and
    (on blockA blockB)
    (on blockB blockC)
    )
  )


;;;
;;; Predicate is-ForMAT-goal-action-p determines whether or not the given 
;;; goal-action is from the ForMAT system. A legitimate ForMAT goal-action will
;;; begin with a string.
;;;
(defun is-ForMAT-goal-action-p (goal-action)
  "Return t if goal-action is a ForMAT goal-action."
  (stringp 
   (first goal-action))
  )




;;;
;;; Function build-problem-statement ...
;;; 
;;; If goal-action is null, then set up dummy goal guaranteed to be true so
;;; front-end can be initialized. Dummy goal is either first state in the 
;;; state list or the vacuuous goal '(and).
;;;
;;; If the goal action is a ForMAT goal-action, then translate to PRODIGY 
;;; format, else they are already in PRODIGY form.
;;;
;;; See file problem-file.lisp for values of *object-list* and *state-list*.
;;;
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
    (goal
     ,(if (null goal-action)
	  (if (null state-list)
	      '(and)              ; Dummy goal always evaluates to true during (run).
	    (first state-list))
	(if (is-ForMAT-goal-action-p goal-action)
	    (if fe::*ForMat-Loaded* 
		(fe::translate-goals goal-action)
	      (error "ERROR in function build-problem-statement."))
	  goal-action))
     ))
  )



;;; Function set-problem produces a form that, when evaluated, creates a new
;;; problem for PRODIGY to solve. The form is created from a goal action
;;; received from ForMAT (i.e., the fgoal-action). After the domain is loaded
;;; and this function is called, PRODIGY may be invoked to solve the problem by
;;; calling (run).
;;;
;;; If the optional parameter do-not-eval is set to non-nil, then the clause is
;;; returned as the value of the function and is not evaluated. If the optional
;;; parameter no-outut is non-nil, the evaluation will produce no output to
;;; *standard-output*.
;;; 
(defun set-Problem (fgoal-action 
		    &optional 
		    do-not-eval
		    no-output
		    &aux 
		    (setf-clause 
		     `(setf (current-problem)
			    (create-problem 
			     ,@(build-problem-statement
				fgoal-action)))))
  (cond (do-not-eval
	 setf-clause)
	(no-output
	 (eval
		  setf-clause))
	(t
	 (format t 
		 "~%New problem: ~s" 
		 (eval
		  setf-clause))
	 (format t 
		 "~%Top level goals: ~%~s~%~%" 
		 (fe::get-current-goals))))
  )



;;;
;;; Function create-problem-file takes as input a ForMAT goal action (but the 
;;; input resorts to the value of the *goal-list* in lieu of a specific value),
;;; and writes to a PRODIGY problem file (file-name) a translated specification.
;;; This file can later be selected with the PRODIGY (problem) function call for 
;;; a subsequent PRODIGY problem-solving session. See file problem-file.lisp for
;;; value of *goal-list*.
;;;
(defun create-problem-file (file-name 
			    &optional 
			    (fgoal-action *goal-list*))
  (with-open-file 
   (problem-file file-name 
		 :direction :output
		 :if-exists :rename-and-delete
		 :if-does-not-exist :create)
   (format problem-file 
	   "~S"
	   (set-problem fgoal-action t)))
  )



