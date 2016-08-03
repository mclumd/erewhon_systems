(in-package :user)

;;; 
;;; Prodigy/P4P adds an interrupt handler for :state-change signals. By doing
;;; so the planner can react to new states of the (micro-window) world that
;;; represents cluttered screens.
;;;
;;; To test Prodigy/P4P, first get fake-p4p running in a separate Lisp. See
;;; comments in file fake-P4P.lisp this dir.
;;;
;;; THEN
;;; 
;;; To load Prodigy/P4P load PRODIGY first (with JADE and Monitors optional),
;;; then
;;; (load "/usr/local/users/mcox/Research/PRODIGY/Wrapper/P4P/loader.lisp")
;;; (Prodigy/P4P t)
;;; 

;;; INPUT format
;;; 
;;; The input is in the form of a list of lists. Each sublist has a symbol as
;;; its first element. If the first item is a "q," the monitoring of the
;;; environment is halted. Otherwise the element can be either an "a" or a "d"
;;; followed by a state predicate.  The d signals a delete state, whereas, the
;;; a signals an add.
;;; 
;;; Example:
;;; 
;;; ((a (in View_Window A4))
;;; (a (on-top-of View_Window Email))
;;; (a (on-top View_Window))
;;; (d (on-top Email))
;;; (q)) 
;;;

;;;
;;; In the future, the system should react to arbitrary states that determine
;;; interface management goals need to be achieved. See function formulate-UI
;;; -problem.
;;; 


;;; 
;;; Eventually need to get this running, but , many dependencies exist that
;;; must be resolved.
;;; 
;;; Make identifiers case-senitive so that 'Hello is different than 'HELLO
;(excl:set-case-mode :case-sensitive-lower)

;;; Do not allow normal monitors while testing Prodigy/P4P code.
(setf *use-monitors-p* nil)

(defvar *active-p4p* t
  "Flag t then p4p is being used and is active."
  )


(defun init-Prodigy/P4P (&optional
			 fake-demo)
  ;; The following will need to be made more general.
  (setf *object-list*
    '(
      (emacs User_Interface_for_Prodigy 
	     Load_Window Email View_Window
	     PortDialogBox Alert A_Simple_Frame 
	     Load View_Domain Close Cancel
	     Cancel OK Load_Domain Run Load_Problem View_Problem
	     WINDOW)
      (A1 A2 A3 A4 AREA)
      (runPRODIGY input2PRODIGY input2user control-display FUNCTION-VAL)
      (SCR SCREEN)))
  (setf *state-list*
    '(
      (has-function emacs runPRODIGY)
      (has-function Load_Window input2PRODIGY)
      (has-function View_Window input2user)
      (has-function User_Interface_for_Prodigy control-display)
      ))
  (setf 
      *goal-list* 
    '(and (clutterless SCR)))
   (setf 
       *world-path* 
     (concatenate
	 'string
       *wrapper-home* 
    "P4P/domains/"))
  (domain 'windows)
  (problem 'p4p-init)
  (when fake-demo
    (format 
     t 
     (concatenate 
	 'string
       "~%Initializing by creating "
       "ready2.txt~%"))
					;    (create-data-file nil)
    (create-ready-file 
     *ready2-file-name*)
    )
  )




;;; 
;;; Function Prodigy/P4P is the main function of this code. It works with Boris's
;;; UIA and Chaitresh's UIP to plan for the User-Interface. If arg fake-demo is
;;; non-nil, the system is considered to be using fake-p4p.
;;; 
(defun Prodigy/P4P (&optional
		    fake-demo)
  
  (init-Prodigy/P4P 
   fake-demo)
  (do ()
      (nil)
    (format 
     t
     (concatenate 'string
       "~%~%Object List: ~S"
       "~%~%State List: ~S"
       "~%~%Goal List: ~S~%")
     *Object-List*
     *State-List*
     *Goal-List*)
    (ready)				;Wait until IUA is ready.
    (reset)
    (run :output-level 3)				; Run PRODIGY
;    (delete-file 
;     *ready1-file-name*)
    (setf *state-list*
      (save-state-list))
    (set-problem 
     *goal-list*)
;    (delete-file *data-file-name*)
    (create-data-file 
     (if (prodigy-result-solutions 
	  *prodigy-result*)
	 (gen-file)))
    (create-ready-file 
     *ready2-file-name*)
      )
  )



;;; 
;;; Function save-current-state takes the current state (usually used after a
;;; PRODIGY run call) that is represented as a list of literal structures, and
;;; transformas them to a list structure appropriate to be saved on the global
;;; *object-list*. By doing this, the state can be saved for the next
;;; invocation of PRODIGY.
;;; 
(defun save-state-list (&optional
			(current-state 
			 (show-state)))
  (let ((result 
	 (save-state-list-1 current-state)))
    (remove '(CLUTTERLESS SCR)
	    (if (eq 'P4::DONE
		    (first
		     (first 
		      (last
		       result))))
		(butlast result)
	      result)
	    :test #'equal))
  )


;;; Helper fn
(defun save-state-list-1 (&optional
			(current-state 
			 (show-state))
			)
  (cond ((null current-state)
	 nil)
	(t
	 (cons 
	  (cons 
	   (p4::literal-name 
	    (first current-state))
	   (map 'list
	     #'(lambda (x) 
		 (if (P4::prodigy-object-p x)
		     (P4::prodigy-object-name x)
		   x))
	     (p4::literal-arguments (first current-state))))
	  (save-state-list-1 
	   (rest current-state)))))
  )

(defun detect-UI-goals (state-set
			&optional
			(goal-types
			    (list :clutter-free)))
  (cond ((null goal-types)
	 nil)
	(t
	 (cons (gen-goal-of-type
		(first goal-types)
		state-set)
	       (detect-UI-goals
		state-set
		(rest goal-types))))
	)  
  )


(defun formulate-UI-problem (state-set
			     &optional 
			     eval-p);Make sure got the sense of this flag right.
  (set-problem 
   (setf *goal-list*
     (cons
      'and
      (detect-UI-goals 
       state-set)))
   (not eval-p))
  )


;;; 
;;; NOTE that state-set is never used. NOTE also that show-state list states as
;;; prodigy objects. If in the future the systemneeds to have a non-structure
;;; representation transform it with save-state-list function.
;;; 
(defun gen-goal-of-type (goal-type state-set)
  (case goal-type
    (:clutter-free
     '(clutterless SCR)))
  )

;;;
;;; Given the input from P4P as a list of adds and dels,
;;; compute the new PRODIGY state. 
;;;
;;; This may be already calculated. Seesensing.lisp in monitors dir.
;;;
(defun infer-stateset-given-deltas (&optional
				    delta-list)
  (show-state)
  )



;;; NOTE that this cide is unclear as to whether or not it is needed.
;;; 
;;; Function interpret-new-state is the interrupt handler for the :state-change
;;; signal. This signal is raised when the function perceive detects new state
;;; changes in the world. 
;;; 
(defun interpret-new-state (signal)
  (format 
   t
   "~%Interpret-net-state on signal ~S~%"
   signal)
  (formulate-UI-problem 
    (infer-stateset-given-deltas
;     delta-list
     )
    t)
  (create-ready-file)
  ;; Now run PRODIGY if new goals were formed and output the resultant plan ???
  )


;;; Now it is included in the reset function in patches.lisp
;(add-handler 'interpret-new-state :state-change)