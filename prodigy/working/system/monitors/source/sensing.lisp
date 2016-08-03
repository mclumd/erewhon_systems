(in-package user)

(defvar *sensing* nil
  "Sense added and deleted literals in a changing environment if t, otherwise static world.")

(defvar *interactive* nil
  "If *sensing* and *interactive* t, then get changing wordl state from user.")


;;;
;;; A list of state changes (t indicates no change for that cycle) and comments. 
;;;
(defvar *sequence-list*  
  '(
    (t t t t t t t a (alt b2) a (g1))
    "Test for the artificial domain."
    (t t t t t t t t t t t t t t t t t t t t t t t t t t t t t t t t t t t d (is-usable airport2))
    "Tests the do-add-to-pending-goals function."
    (t t t t t t t t t t t t t a (threat-at weapons-smuggling1 korea-south))
    "tests the jump-2-node heuristic." 
    (t t t t t t t t t t t t t  t t t t t t t t t t t t t t t a (airport-secure-at korea-south airport2))
    "Undoes part of plan after 3 sends, secure, deploy and blow are all in head plan, but should only undo sends and secure."
    (t t t t t t t t t t t t t t t t t t a (airport-secure-at korea-south airport2) t t t t t t t t a (enables-movement-over ford1 Yalu))
    "Airport becomes secure after starting to plan to make it secure."
    (t t t t t t t t t t t t t t t t t t a (is-usable airport6) t t t t t t t t a (enables-movement-over ford1 Yalu))
    "Another airport becomes secure and was already usable while planning to secure another airport."
    (t t t t t t t t t t t t t t t t t t a (is-deployed infantry-battalion-a korea-south) t t t t t t t t a (enables-movement-over ford1 Yalu))
    ""
    (t t t t t t t t t t t t t t t t t t t t t t t t t t t t t t t t t t t t t t t t t t t t a (enables-movement-over ford1 Yalu))
    "Bridges plus town center: New input after solved top level goal for removing all crossings over Yalu, but while still planning for securing town center."
    (t t t t t t t t t t t t t t t t t t t t t t t t t t t a (enables-movement-over ford1 Yalu))
    "For the SanFran demo. Definitely after second goal generated."
    (t t t t t t t t t t t t t t t t t t t t t t t t t t t a (enables-movement-over ford1 Yalu))
    "Bridge: New input right before (after?) generating second forall goal."
    (t t t t t t t t t t t t t t t t a (enables-movement-over ford1 Yalu)) 
    "Bridge Example: New input after starting to execute part of plan"
    (t t t t t t t t a (enables-movement-over ford1 Yalu)) 
    "Bridge Example: New input before starting to execute part of plan"
    ;;  (a (on-table b) d (holding a) q) 
    ;;  "Veloso example"
    ))

(if *run-experiment*
    (setf *sequence-list*  
	  (if (eq  *test-condition* 'alternative-based-subgoal)
	      '(
		(a (alt b2) a (g1))
		"Test for alternative-based subgoal monitors in the artificial domain.")
	    (if (eq  *test-condition* 'alternative-based-usability)
		'(
		  (d (static b1))
		  "Test for alternative-based usability monitors in the artificial domain.")))))


;;; For testing paolo's toast domain.
;(setf *sequence* '(t t t t t t d (on c) t t t t t d (on f)))

(defparameter *sequence* (first *sequence-list*))


;;; Input can be obtained from this variable instead of the user.
(defvar *senses* *sequence*)



(defun load-senses (&optional (sequence *sequence*)
			      (reset-sensing t))
  "Turn on sensing and reload the senses."
  (if reset-sensing
      (setf *sensing* t))
  (setf *senses* sequence)
  )


(defun perceive ()
  "Get input from *senses* rather than user."
  (pop *senses*)
  )

;;; Temporary predicate until fix sense-world.
(defun more-input-p ()
  (not (eq (first *senses*)
	   t))
  )



;;; Should be set to 4 for running experiments in Veloso, Pollock, & Cox, 1997.
(defparameter *sensing-cycle-length* 0
  "The number of planning cycles before sensing the world.")

(defvar *sensor-count* 0
  "Counter used to determine when to sense.")


;;;
;;; Removed output when not in an interactive mode [12oct97 cox]
;;;
;;; Funtion sense-world handles an :always interrupt if it is installed. Can be
;;; installed by calling (add-handler) during initialization of application.
;;;
;;; Signals a :state-change interrupt upon detection of new input from the
;;; environment, that in turn, are handled by monitors if installed as Prodigy
;;; handlers (see monnitor.lisp).
;;;
(defun sense-world (signal)
  "The Prodigy interrupt handler that provides an interface to the environment."
  (cond  ((and *sensing*
	       (= *sensor-count* 0))
	  (setf *sensor-count* *sensing-cycle-length*)
	  (when 
	   *interactive*
	   (format t "~%~%This is the current state ~S" (show-state))
	   (format 
	    t 
	    "~%Enter add (a), del (d), quit-sensing (q), otherwise terminate: "))
	  (let ((ans (if *interactive* (read)
		       (perceive)))
		(action nil))
	    (case ans
		  ((a) (setf action t))
		  ((d) (setf action nil))
		  ;;If user responds with quit or *senses* empty.
		  ((q nil) (setf *sensing* nil ans nil))
		  (t (setf ans nil)))
	    (when ans
		  (if *interactive*
		      (format t "Enter sensed state literal: "))
		  (let ((new-visible (if *interactive* (read)
				       (perceive))))
		    (when new-visible
			  (setf (p4::literal-state-p
				 (p4::instantiate-consed-literal 
				  new-visible))
				action)
			  (if (not *interactive*)
			      (if *monitor-trace*
				  (format t 
					  "~%~a new literal ~S~%" 
					  (if (eq ans 'a) "Adding" "Deleting") 
					  new-visible))
			    (format t "This is the new state ~S" (show-state)))
			  ;; Added interrupt signal for new input so that
			  ;; monitors can see the change [12oct97 cox]
			  (prod-signal :state-change 
				       (cons ans (list new-visible)))
			  ))
		  ;; This next clause temporarily replaces the recursive call
		  ;; to sense-world [2dec97 cox]
;		  (when (more-input-p)
;			(setf ans (perceive))
;			(setf action nil)
;			(case ans
;			      ((a) (setf action t))
;			      ((d) (setf action nil))
;			      ;;If user responds with quit or *senses* empty.
;			      ((q nil) (setf *sensing* nil ans nil))
;			      (t (setf ans nil)))
;			(when ans
;			      (setf new-visible (perceive))
;			      (when new-visible
;				    (setf (p4::literal-state-p
;					   (p4::instantiate-consed-literal 
;					    new-visible))
;					  action)
;				    (if *monitor-trace*
;					(format t 
;						"~%~a new literal ~S~%" 
;						(if (eq ans 'a) "Adding" "Deleting") 
;						new-visible))
;				    ;; Added interrupt signal for new input so that
;				    ;; monitors can see the change [12oct97 cox]
;				    (prod-signal :state-change (cons ans (list new-visible)))
;				    ))
;			)
		  (sense-world signal)
		  )))
	 (*sensing*
	  (setf *sensor-count* (1- *sensor-count*))))
  )



;;;
;;; Generic function for installing interrupt handlers. Checks to make sure the
;;; handler is not already installed before adding it.
;;;
(defun add-handler (&optional
		    (handler 'sense-world)
		    (signal :always)
		    &aux
		    (handler-function (symbol-function handler)))
  (unless (member handler-function
		  (cdr (assoc signal p4::*prodigy-handlers*)))
    (define-prod-handler signal handler-function)))


(defun remove-handler (&optional
		       (handler 'sense-world)
		       (signal :always)
		       &aux
		       (handler-function (symbol-function handler)))
  (remove-prod-handler
   signal handler-function)
  )


(defvar *pause* nil)
(defvar *interactive-pause* nil)
;(defvar *node-7-exists-p* nil)

(defun pause (signal &aux user-input)
  "Simple pause interrupt for each planning cycle."
  (declare (ignore signal)
	   (special *pause*))
  (when *pause*
	(format t 
		"~%Pending Goals are ~s~% at ~s~%" 
		(p4::give-me-all-pending-goals *current-node*)
		*current-node*)
;	(if (and (not *node-7-exists-p*)
;		 (p4::binding-node-p *current-node*)
;		 (eql (p4::binding-node-name *current-node*) 7))
;	    (setf *node-7-exists-p* t))
;	(if *node-7-exists-p*
;	    (describe (find-node 7)))
	(when *interactive-pause*
	      (setf user-input (y-or-n-p "Stop pausing? "))
	      (if user-input 
		  (setf *pause* nil)))
	)
  )




(defun reset (&optional 
	      (do-pause *pause*)
	      (interactive-pause *interactive-pause*))
  "Simple function for restarting a new demo."
  (declare (special *pause*)
	   (special *interactive-pause*))
  (setf *done-already* nil) ; Added [5dec97 cox]. Remove later.
  (clear-prod-handlers)
  (add-handler) 
  ;; Reset cycle counter used by sense-world.
  (setf *sensor-count* *sensing-cycle-length*)
  (set-pause do-pause interactive-pause)
;  (setf *node-7-exists-p* 
;	(if (find-node 7)
;	    t))
  (load-senses)
  )



(defun set-pause (&optional 
		  do-pause
		  interactive-pause)
  (if do-pause
      (add-handler 'pause))
  (setf *pause* do-pause)
  (setf *interactive-pause* interactive-pause)
  )
