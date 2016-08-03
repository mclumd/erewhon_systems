;;**************************************************************;;
;;--------------------------------------------------------------;;
;; Program:	X-ANALOGY: Experimental Extensions For		;;
;;			PRODIGY/ANALOGY				;;
;; Author:	Anthony G. Francis, Jr.				;;
;; Class:	CS8503: Guided Research				;;
;; Assignment:	Thesis Research Implementation			;;
;; Due:		Not Specified					;;
;;--------------------------------------------------------------;;
;; Module:	Experimental Analogy Replay Extensions		;;
;; File:	"x-replay.lisp"					;;
;;--------------------------------------------------------------;;
;; Notes:	This contains code that specifies a new replay	;;
;;		mode, Integrative, for Analogy.			;;
;;--------------------------------------------------------------;;
;; File Contents:						;;
;; 1. Base Loader and Verbosity Flags				;;
;; 2. Data-Structure Analysis Functions				;;
;; 3. Replay Functions 						;;
;; 4. Helper Functions						;;
;;--------------------------------------------------------------;;
;; History:	9jul97 Michael Cox changed three functions to 	;;
;;              choose a better default for the depth-bound.    ;;
;;              These functions are replay-problem, replay-body,;;
;;              and replay-problem-foolish. The functions now   ;;
;;              check the :depth-bound flag first. Additionally ;;
;;              cases are set according to the problem path if  ;;
;;              not explicitly provided to fn replay-problem    ;;
;;              and if *case-headers* not already set. Finally, ;;
;;              setting of *analogical-replay* moved from fn    ;;
;;              replay-body to fn replay-problem since it needs ;;
;;              to be set before the call of domain so that     ;;
;;              analogical-replay control rules are loaded.     ;;
;;                                                              ;;
;;              15jul97 Michael Cox comments out redundant      ;;
;;              *x-goal-list* because it is already defined in  ;;
;;              file x-retrieval.lisp.                          ;;
;;                                                              ;;
;;              16jul97 Renamed replay-problem to just replay   ;;
;;                                                              ;;
;;              22jul98 Changed verbose keyword parameters      ;;
;;              throughout to take the default of *verbose*     ;;
;;              rather than t.                                  ;;
;;                                                              ;;
;;**************************************************************;;
(in-package "USER")

;;**************************************************************;;
;; 1. Base Loader and Verbosity Flags				;;
;;**************************************************************;;
;;--------------------------------------------------------------;;
;; UTILITY *load-trace*					;;
;;--------------------------------------------------------------;;
;; NOTES: 							;;
;;--------------------------------------------------------------;;
(unless (boundp *load-trace*)
	(load "loadtrace"))

;;**************************************************************;;
;; 2. Data-Structure Analysis Functions				;;
;;**************************************************************;;
;;--------------------------------------------------------------;;
;; VARIABLE *x-goal-list*					;;
;;--------------------------------------------------------------;;
;; NOTES: Commented out [cox 15jul97]				;;
;;--------------------------------------------------------------;;
;(loadtrace "~%   Defining variable *x-goal-list* ...")
;(defvar *x-goal-list* nil)


;;**************************************************************;;
;; 3. Replay Functions					        ;;
;;**************************************************************;;
;;--------------------------------------------------------------;;
;; FUNCTION process-integrative-merge				;;
;;--------------------------------------------------------------;;
;; NOTES: 							;;
;;--------------------------------------------------------------;;
(loadtrace "~%   Defining function process-integrative-merge ...")
(defun process-integrative-merge (guiding-cases 
				  unguided-goals 
				  unguided-applicable-ops)

  ;; Initially, we have no current goal...
  (let ((current-goal nil))
    ;;---COND---
    ;; determines if there is interaction between current goal and other ones
    (cond

     ;; If there is no guiding case, pick a goal from the 
     ;; list of unguided goals.
     ((eq *guiding-case* 'no-case)
      (setq *chosen-goal* (car unguided-goals))
      (setf current-goal (goal-from-literal *chosen-goal*)))

     ;; If case-goal-p is true for the pointer of the guiding case...
     ;; set the current goal to the goal of the new case...
     ((case-goal-p (guiding-case-ptr *guiding-case*))
      (setq current-goal (get-case-new-visible-goal
			  (guiding-case-ptr *guiding-case*)
			  *guiding-case*)))
     )
    ;;---END COND---

    ;; When we have a current goal
    (when current-goal
	  (let* ((involved-goals (goal-interaction current-goal 
						   *case-goals*)))
	    ;; +--- here, I assume that involved-goals is a pair: 
	    ;; |    I only look at the first goal, assuming that 
	    ;; |    there is only one other goal which is the 
	    ;; |    rejected (put-off) previous "current goal"
	    (if *talk-case-p* 
		(format t "~%Involved goals: ~S" involved-goals))

	    ;; When we've got em...
	    (when involved-goals

		  
		  ;; jump to a new case
		  (if *talk-case-p*
		      (format t "~% jumping to a new case --> ~S" 
			      (car (assoc (car involved-goals) 
					  *case-goals* :test #'equal))))
		  ;; Set the guiding case...
		  (setf *guiding-case*
			(cdr (assoc (car involved-goals) 
				    *case-goals* :test #'equal)))
		  ;; If no case
		  (if (eq *guiding-case* 'no-case)
		      (setf *chosen-goal* (car involved-goals)))
		  )
	    )
	  ;; END LET
	  )
    
    )
  ;; END LET
  )





;;**************************************************************;;
;; 4. Helper Functions						;;
;;**************************************************************;;
;;--------------------------------------------------------------;;
;; FUNCTION replay         					;;
;;--------------------------------------------------------------;;
;; NOTES: Automates replay of the current problem with the	;;
;;	currently loaded set of cases. Can also be used	to load	;;
;;	the domain, problem and the cases, if need be.		;;
;;--------------------------------------------------------------;;
(loadtrace "~%   Defining function replay ...")
(defun replay         
  (&key (domain          nil) 
	(problem         nil)
	(cases           nil)
	(max-goals       nil)
	(match-threshold 0.6)
	(default-max-goals 1)
	(merge-mode      *merge-mode*)
	(mode            :full)
	(depth-bound     (or (pspace-prop :depth-bound) 100))
	(replay-function #'simple-select-replay-cases)
	(verbose         *verbose*)
	(do-not-replay   nil) ;Added to disable actual replay. [cox 20may98]
	)

  ;;---------------------------------------------------------------
  ;; Initialize a few temp variables. I probably don't need all
  ;; or any of these, but they were useful during the debugging
  ;; phase.
  ;;---------------------------------------------------------------
  (let 
      (
       (solution    nil)
       (num-goals   nil)
       )

    ;;---------------------------------------------------------------
    ;; Bug the user.
    (when verbose
	  (format t "~%===BEGINNING AUTOMATIC REPLAY===" problem)
	  )

    ;;---------------------------------------------------------------
    ;; Activate Analogical Replay
    (when verbose
	  (format t "~%--- Activating Analogical Replay..."))
    (setf *analogical-replay* t)

    ;;---------------------------------------------------------------
    ;; Load the domain, if asked to.
    (when domain
	  (when verbose (format t "~%--- Loading domain ~s..." domain))
	  (domain domain)
	  )

    ;;---------------------------------------------------------------
    ;; DOMAIN LOAD CHECK: Did the domain load successfully?
    ;;---------------------------------------------------------------
    (cond
     ;;---------------------------------------------------------------
     ;; Successful Domain Load - Continue Replay...
     ;;---------------------------------------------------------------
     (*problem-path*
      (when verbose 
	    (format t "~%--- Domain specified by:")
	    (format t "~%       ~A" *problem-path*)
	    (format t "~%    has been loaded...")
	    )
  
      ;;---------------------------------------------------------------
      ;; Load the problem, if asked to.
      ;;---------------------------------------------------------------
      (when problem
	    (when verbose (format t "~%--- Loading problem ~s..." problem))
	    (problem problem))

      ;;---------------------------------------------------------------
      ;; Did the problem load?
      ;;---------------------------------------------------------------
      (cond 
       ;;---------------------------------------------------------------
       ;; --- Succesful load - continue 
       ;;---------------------------------------------------------------
       ((setf current-problem (current-problem))
	(when verbose (format t "~%    Problem ~s is loaded."
			      current-problem)
	      )

	;;---------------------------------------------------------------
	;; Load the problem's objects
	;;---------------------------------------------------------------
	(when verbose 
	      (format t "~%--- Loading problem ~s's objects..." 
		      (current-problem)))
	(p4::load-problem (current-problem) nil)

	;;---------------------------------------------------------------
	;; Load the cases
	;;---------------------------------------------------------------

	;; If no cases were explicitly passed to fn and no previous case 
	;; headers present, then use cases from problem path.
	(if (and (null cases) (not *case-headers*))
	    (setf cases 
		  (return-file-strings
		   (concatenate 'string 
				*problem-path* 
				"probs/cases/headers/"))))
	(when cases
	      (when verbose (format t "~%--- Loading cases ~s'..." cases))
	      (apply #'load-case-headers cases))

	;;---------------------------------------------------------------
	;; --- Did the cases load?
	;;---------------------------------------------------------------
	(cond 
	 ;;---------------------------------------------------------------
	 ;; Successful case load.
	 ;;---------------------------------------------------------------
	 (*case-headers*
	  (when verbose (format t "~%--- ~s case headers loaded..."
				(length *case-headers*)
				)
		)


	  ;;---------------------------------------------------------------
	  ;; Evaluate similarities
	  ;;---------------------------------------------------------------
	  (setf num-goals
		(or max-goals
		    (max default-max-goals
			 (length (get-lits-no-and 
				  (p4::problem-goal (current-problem))
				  )
				 )
			 )
		    )
		)
	  (when verbose
		(format t "~%--- Evaluating Similarities. Goals: ~s Threshold: ~s"
			num-goals match-threshold))
	  (evaluate-similarities 
	   :match-threshold match-threshold
	   :max-goals       num-goals
	   )
    
	  ;;---------------------------------------------------------------
	  ;; --- Are there Cover-matches?
	  ;;---------------------------------------------------------------
	  (cond
	   ;;---------------------------------------------------------------
	   ;; Successful Matching.
	   ;;---------------------------------------------------------------
	   (*cover-matches*

	    ;;---------------------------------------------------------------
	    ;; Set up *replay-cases*
	    ;;---------------------------------------------------------------
	    (when verbose 
		  (format t "~%--- Setting up replay structure using ~s..."
			  replay-function))
	    (funcall replay-function)

	    ;;---------------------------------------------------------------
	    ;; --- Are there replay-cases?
	    ;;---------------------------------------------------------------
	    (cond

	     ;;---------------------------------------------------------------
	     ;; REPLAY CASE
	     ;; Successful Replay Structures Built
	     ;;---------------------------------------------------------------
	     ((and *replay-cases*
		   (not do-not-replay))
	      (setf solution
		    (replay-body :merge-mode  merge-mode
				 :verbose     verbose
				 :depth-bound depth-bound
				 )
		    )
	      )
	     ;;---------------------------------------------------------------
	     ;; Unsuccessful Replay Structures or not replaying.
	     ;;---------------------------------------------------------------
	     (t
	      (if (and *replay-cases* do-not-replay)
		  (format t "~%--- Replay suppressed.")
		(format t "~%--- No replay structure."))
	      )
	     )
	    )



	   ;;---------------------------------------------------------------
	   ;; Successful Replay. Go for it.
	   ;;---------------------------------------------------------------
	   (t
	    (format t "~%--- No case matches. Stopping replay.")
	    )
	   )
	  )

	 ;;---------------------------------------------------------------
	 ;; No cases loaded - shut down.
	 ;;---------------------------------------------------------------
	 (t
	  (format t "~%--- No cases loaded. Stopping replay.")
	  )
	 )
	)
      
       ;;---------------------------------------------------------------
       ;; No problem loaded - shut down.
       ;;---------------------------------------------------------------
       (t
	(format t "~%--- No problem loaded. Stopping replay.")
	)
       )
      )

     ;;---------------------------------------------------------------
     ;; No domain has been loaded. Shut down.
     ;;---------------------------------------------------------------

     (t
      (format t "~%---No domain apparently loaded. Stopping replay.")
      )
     )
    ;;---------------------------------------------------------------
    ;; Bug the user in closing
    (when verbose
	  (format t "~%===ENDING AUTOMATIC REPLAY===")
	  )
    solution
    )
  )

;;--------------------------------------------------------------;;
;; FUNCTION replay-body 					;;
;;--------------------------------------------------------------;;
;; NOTES:							;;
;;--------------------------------------------------------------;;
(loadtrace "~%   Defining function replay-body ...")
(defun replay-body (&key (verbose     *verbose*) 
			 (merge-mode  *merge-mode*)
			 (depth-bound (or (pspace-prop :depth-bound) 100))
			 )
  ;;============================================================
  ;; MAIN REPLAY BODY
  ;;============================================================
  ;; NO ERROR CHECKING FROM HERE ON OUT!
  ;; YOU ARE ON YOUR OWN!
  ;;============================================================

  ;;---------------------------------------------------------------	
  ;; Load the cases
  (when verbose
	(format t "~%--- Loading Cases..."))
  (load-cases)
  ;; [cox 6jun98]
  (when *UI*
      (load-cases-tcl merge-mode)
      (send-to-tcl 0)
    )

  ;;---------------------------------------------------------------
  ;; Set Merge Mode
  (when verbose
	(format t "~%--- Merge Mode set to ~s..." merge-mode))
  (if (null
       (setf *merge-mode* merge-mode))
      (format t "~%--- No merging strategy selected."))

  ;;---------------------------------------------------------------
  ;; Initialize the Guiding Structures
  (when verbose
	(format t "~%--- Initializing Guiding Structures..."))
  (init-guiding)

  ;;; Added [cox 11jun98]
  (if *UI*   
      (send-to-tcl 0))

;;---------------------------------------------------------------
  ;; Adding handler for replay [cox 2jun98]
  (when verbose
	(format t "~%--- Adding handler for replay..."))
  (add-handler 'link-to-case-prodigy-node )

  ;;---------------------------------------------------------------
  ;; Run the problem
  (when verbose
	(format t "~%--- Running Problem with Replay..."))

  (run :depth-bound depth-bound)
  ;;============================================================
  ;; END MAIN REPLAY BODY
  ;;============================================================
  )

;;--------------------------------------------------------------;;
;; FUNCTION replay-problem-foolish				;;
;;--------------------------------------------------------------;;
;; NOTES: Automates replay of the current problem with the	;;
;;	currently loaded set of cases. Can also be used	to load	;;
;;	the domain, problem and the cases, if need be.		;;
;; 	THIS VERSION DOES NO ERROR CHECKING...			;;
;;--------------------------------------------------------------;;
(loadtrace "~%   Defining function replay-problem-foolish ...")
(defun replay-problem-foolish
  (&key (domain          nil) 
	(problem         nil)
	(cases           nil)
	(max-goals       nil)
	(match-threshold 0.6)
	(default-max-goals 2)
	(merge-mode      *merge-mode*)
	(mode            :full)
	(depth-bound     (or (pspace-prop :depth-bound)  100))
	(replay-function #'simple-select-replay-cases)
	(verbose         *verbose*)
	)

  (format t "~%---BEGINNING REPLAY---" problem)
    
  ;; Load the domain, if neccessary
  (cond (domain
	 (when verbose (format t "~%   - Loading domain ~s..." domain))
	 (domain domain))
	(t
	 (when verbose (format t "~%   - Assuming domain specified..."))
	 )
	)


  ;; Load the problem
  (cond (problem 
	 (when verbose (format t "~%   - Loading problem ~s..." problem))
	 (problem problem))
	(t
	 (when verbose (format t "~%   - Assuming problem specified..."))
	 )
	)

  ;; Load the problem's objects
  (when verbose 
	(format t "~%   - Loading problem ~s's objects..." 
		(current-problem)))
  (p4::load-problem (current-problem) nil)

  ;; Load the cases
  (cond (cases
	 (when verbose (format t "~%   - Loading cases ~s'..." cases))
	 (apply #'load-case-headers cases))
	(t
	 (when verbose (format t "~%   - Assuming cases already loaded..."))
	 )
	)

  ;; Evaluate similarities
  (let ((num-goals (or max-goals
		       (max default-max-goals
			    (length (get-lits-no-and 
				     (p4::problem-goal (current-problem))
				     )
				    )
			    )
		       )))
    (when verbose
	  (format t "~%   - Evaluating Similarities. Goals: ~s Threshold: ~s"
		  num-goals match-threshold))
    (evaluate-similarities 
     :match-threshold match-threshold
     :max-goals       num-goals
     )
    )

  ;; Set up *replay-cases*
  (when verbose 
	(format t "~%   - Setting up replay structure using ~s..."
		replay-function))
  (funcall replay-function)

  ;; Load the cases
  (when verbose
	(format t "~%   - Loading Cases..."))
  (load-cases)

  ;; Set Merge Mode
  (when verbose
	(format t "~%   - Merge Mode set to ~s..." merge-mode))
  (setf *merge-mode* merge-mode)

  ;; Initialize the Guiding Structures
  (when verbose
	(format t "~%   - Initializing Guiding Structures..."))
  (init-guiding)

  ;; Activate Analogical Replay
  (when verbose
	(format t "~%   - Activating Analogical Replay..."))
  (setf *analogical-replay* t)

  ;; Run the problem
  (when verbose
	(format t "~%   - Running Problem with Replay..."))
  (prog1 
      (run :depth-bound depth-bound)
    (setf *analogical-replay* nil)
    )
  )

