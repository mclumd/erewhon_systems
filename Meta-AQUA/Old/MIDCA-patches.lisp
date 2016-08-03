;;; -*- Mode: LISP; Syntax: Common-lisp; Package: Meta-aqua; Base: 10 -*-

(in-package :metaaqua)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;      MAIN CONTROL  -  THE META-AQUA FUNCTION
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;; 
;;; Main Program Function.
;;;
;;; Function meta-aqua is the outer-most function (not including aliases above)
;;; of the Meta-AQUA program.  Meta-AQUA has three modes in which it can be run
;;; (and is determined by the mode parameter). The standard mode is for story
;;; understanding and is signaled by the constant 'read-story, whereas the
;;; constant 'act-out-story signals problem solving mode.  A new mode is
;;; 'LISP-programming used for modeling Mimi Recker's data. The function first
;;; initializes the system, enters a main loop that process input until no
;;; remaining goals exist to be achieved, then exists after displaying both the
;;; world model of the input and the mental model of the processing of the
;;; input.
;;;
;;; The optional parameter automatic? can be either nil, t or 'semi. It
;;; controls the user-prompts for whether to continue or not at the end of each
;;; cycle thru the main do-loop. At non-automatic speed (automatic? = nil),
;;; Meta-AQUA will prompt the user whether to continue both after processing a
;;; previous sentence and after presenting the subsequent sentence on the
;;; screen. Semi(automatic) will not stop between finishing the last sentence
;;; and presenting the next for display. At fully automatic (Automatic? = t)
;;; speed, Meta-AQUA will not prompt the user whether or not to process any
;;; sentence. It stops only to prompt whether to process a question of which it
;;; is reminded or whether to use an explanation is has retrieved.
;;;
;;; Meta-AQUA actually returns a value. It returns the number of scripts
;;; matched while processing a story. Because spinqua can call Meta-AQUA
;;; numerous times during evaluation runs, the old count is passed in as the
;;; parameter script-match-number so that Meta-AQUA can maintain the running
;;; count and return it to spinqua.
;;; 
(defun meta-aqua (&optional
		  automatic?			; Automatic processing is not a default.
		  (mode 'read-story)		; Default mode of reading stories.
		  (script-match-number 0)	; Number of scripts matched from previous runs.
		  suppress?			; Flag for suppressing the Meta-AQUA process.
		  called-by-spinqua?		; Flag used to effect output of say-input.
		  remove-unanswered-questions	; If t, then remove remaining questions after
		  				; processing a story.
		  &aux
		  (start-time
		    (get-universal-time))	; Used to time the run.
		  )
  (if suppress?
      (return-from meta-aqua
	script-match-number))
  (init-run mode *Previous-Mode*)		; Initialize program in the given mode.
  ;; Main program control loop.
  (do ((next-goal (front-of *Goal-Queue*)
		  (front-of *Goal-Queue*)))
      ;; Stopping Conditions and cleanup.
      ((or (if (action-mode-p mode)		; We are done if either 
	       (and (empty-queue-p		; a program goal queue is empty
		      *Cop-Queue*)
		    (empty-queue-p
		      *Robber-Queue*))
	       (empty-queue-p *Goal-Queue*))
	   (user-quits-p automatic?		; or the user signals to quit.
			 next-goal))
       (format
	 *aqua-window*				; If so, 
	 (str-concat
	   "~%Done.~% ~%Time to "		; signal program completion 
	   "completion: ~s minutes.~%~%")	; show elapsed execution time,
	 (set-time-to-completion		; Compute the time it took 
	   *Current-Result-Record*		; to complete one run of Meta-AQUA.
	   start-time))
       (if (or (goal-monitor-mode-p)
	       (memory-monitor-mode-p))
	   (display-models mode automatic?))	; display the domain and mental models,
       (setf *Previous-Mode* mode)		; set previous mode for next invocation of init-run,
       (set-world-model-length
	 *Current-Result-Record*		; set the world-model-length field of the current result,
	 *World-Model*)
       (setf *Eval-Results*			; update the global results of all runs in this series
	     (cons *Current-Result-Record*	; by adding the latest result record,
		   *Eval-Results*))
       (if remove-unanswered-questions		; if this flag argument is t, 
	   (set-unanswered-questions		; then record the result of removing any old questions
	     *Current-Result-Record*	        ; in the current result record, therefore,
	     (remove-old-questions)))	        ; not allowing questions to interfere with further stories,
       (if user::*Run-MIDCA*			; Here is the patch. [mcox 4oct13]
	   'XP
	 script-match-number))		; and finally, return the running match number.
    ;; Main body.
    (cond ((is-new-goal-p next-goal)		; New goal is one that is not a subgoal.
	   (update-models next-goal)		; For new goals, update world & mental models
	   (say-input				; and print the new input,
	     (goal-state next-goal)
	     called-by-spinqua?))
	  (t
	   (say-sub-goal			; otherwise display subgoal info.
	     next-goal)))
    (cond ((is-goal-type-p			; If the current goal 
	     'world-goal next-goal)		; is a world-goal
	   (do-plan next-goal))			; then plan to achieve it.
	  ((is-goal-type-p			; otherwise, if the current goal 
	     'knowledge-goal next-goal)		; is a knowledge-goal
	   (setf script-match-number
		 (do-understand			; then perform understanding 
		   next-goal			; to achieve the knowledge.
		   script-match-number
		   automatic?))))
    (if (action-mode-p mode)			; When in action mode, agents perspectives 
	(swap-perspective))			; are swapped for the next round.
    )
  )


(in-package :user)
