;;**************************************************************;;
;;--------------------------------------------------------------;;
;; Program:	X-ANALOGY: Experimental Extensions For		;;
;;			PRODIGY/ANALOGY				;;
;; Author:	Anthony G. Francis, Jr.				;;
;; Class:	CS8503: Guided Research				;;
;; Assignment:	Thesis Research Implementation			;;
;; Due:		Not Specified					;;
;;--------------------------------------------------------------;;
;; Module:	Experimental Prodigy Stepper Function		;;
;; File:	"x-step.lisp"					;;
;;--------------------------------------------------------------;;
;; Notes:	This contains extra functions for the Prodigy	;;
;;		main search loop.				;;
;;--------------------------------------------------------------;;
;; File Contents:						;;
;;**************************************************************;;
(in-package "USER")

;;**************************************************************;;
;; 1. Base Loader and Verbosity Flags				;;
;;**************************************************************;;
(unless (boundp *load-trace*)
	(load "loadtrace"))

;;**************************************************************;;
;; 2. Stepper Interrupts and Restarters				;;
;;**************************************************************;;
;;--------------------------------------------------------------;;
;; VARIABLE *step-mode*						;;
;;--------------------------------------------------------------;;
;; NOTES: 							;;
;;--------------------------------------------------------------;;
(loadtrace "~%   Defining variable *step-mode* ...")
(defvar *step-mode* :run)

;;--------------------------------------------------------------;;
;; VARIABLE *step-limit*					;;
;;--------------------------------------------------------------;;
;; NOTES: 							;;
;;--------------------------------------------------------------;;
(loadtrace "~%   Defining variable *step-limit* ...")
(defvar *step-limit* 30)

;;--------------------------------------------------------------;;
;; VARIABLE *step-counter*					;;
;;--------------------------------------------------------------;;
;; NOTES: 							;;
;;--------------------------------------------------------------;;
(loadtrace "~%   Defining variable *step-counter* ...")
(defvar *step-counter* 0)

;;--------------------------------------------------------------;;
;; FUNCTION get-current-node-and-pause				;;
;;--------------------------------------------------------------;;
;; NOTES: Based on (send-node-and-wait) from the Prodigy UI.	;;
;;	If we're at a stoppable node (conditions for which are	;;
;;	directly based on (send-node-and-wait)) then check the	;;
;;	step logic for one of four modes:			;;
;;		:run		Just keeps running (default).	;;
;;		:interactive	Queries the user at each node.	;;
;;		:step		Steps until *step-limit* is hit	;;
;;				and then stops. Only counts	;;
;;				valid stop nodes, so the step	;;
;;				limit may not equal the node 	;;
;;				count.				;;
;;		:step-int	Steps until *step-limit* and	;;
;;				queries the user.		;;
;;		otherwise	Just runs.			;;
;;	This should be a prodigy interrupt handler for :always.	;;
;;--------------------------------------------------------------;;
(loadtrace "~%   Defining function get-current-node-and-pause ...")
(defun get-current-node-and-pause (signal)
  (declare (ignore signal)
	   )
  ;; When there is a current node...
  (when (and 
	 ;; When there is a current node...
	 (boundp '*current-node*)

	 ;; And when the nexus-name ain't 4 ... I dunno why..
	 (not (= (p4::nexus-name *current-node*) 
		 4))

	 ;; And when the current node ain't an operator ????
	 (not (p4::operator-node-p *current-node*))

	 ;; And when the step logic sez so...
	 (case *step-mode*
	       ;; If we're running, don't stop. Ever.
	       (:run
		nil)
	       
	       ;; Interactive: ask the user.
	       (:interactive
		(yes-or-no-p "Should I stop at ~s?" *current-node*))
	       
	       ;; Step a specific number of nodes
	       (:step
		(cond ((<= *step-counter* *step-limit*)
		       (incf *step-counter*)
		       nil)
		      (t
		       (setf *step-counter* 0)
		       t)))

	       ;; Interactive Number-Based Stepping
	       (:step-int
		(cond ((<= *step-counter* *step-limit*)
		       (incf *step-counter*)
		       nil)
		      (t
		       (setf *step-counter* 0)
		       (yes-or-no-p "Should I stop at ~s?" *current-node*)
		       )
		      )
		)

	       ;; If the user can't decide, don't stop. Ever.
	       (t nil))
	 )
	 
	;; Inform the user of the stopping mode.
	(format t "~%---Pausing Prodigy at ~s---"
		*current-node* prodigy4::*node-counter*)

	;; Record important Prodigy data that will be lost
	;; in separate variables for inspection and recovery.
	(setf *step-current-node* *current-node*)
	(setf *step-node-counter* prodigy4::*node-counter*)

	;; Return the signal handler with the info that
	;; (prodigy-restart) needs to pick up where we 
	;; are currently leaving off.
	(list :stop 
	      :restartable 
	      *current-node*
	      prodigy4::*node-counter*)
	)
  )


;;--------------------------------------------------------------;;
;; FUNCTION prodigy-restart					;;
;;--------------------------------------------------------------;;
;; NOTES: Based on the abandoned (prodigy-restart) function	;;
;;	from the Prodigy UI. Works hand in hand with the 	;;
;;	(get-current-node-and-pause) handler above.		;;
;;--------------------------------------------------------------;;
;; ORIGINAL NOTES (from the Prodigy UI)				;;
;; This was a first pass based on the idea of stopping a run 	;;
;; completely and restarting it using this top-level lisp 	;;
;; command. This has the disadvantage that you have to recover	;;
;; lots of state, which you can't look at while you've stopped.	;;
;;								;;
;; Need to recover the last node. This is left behind by the	;;
;; stepper break caused by the "send-node-and-wait" signal 	;;
;; handler above. 						;;
;;--------------------------------------------------------------;;
(loadtrace "~%   Defining function prodigy-restart ...")

;;; Commented the following function out becausse it generated a bus error when
;;; compiling. I do not think it was ever finished, nor is it currently being
;;; used. [cox 12sep97]

;(defun prodigy-restart
;  (&optional (depth-bound (or (pspace-prop :depth-bound) 30)
;			  )
;	     )
;  (let* ((interrupt (prodigy-result-interrupt *prodigy-result*)
;		    )
;	 (last-node (if (eq (second interrupt) :restartable)
;			(third interrupt)
;		      )
;		    )
;	 (next-node
;	  (p4::choose-node last-node (p4::generate-nodes last-node)
;			   )
;	  )
;	 (node-counter (fourth interrupt))
;	 (current-depth
;	  (p4::maintain-state-and-goals last-node next-node)
;	  )
;	 )
;    (cond ((not last-node)
;	   (format t "~%This is not a restartable break~%")
;	   )
;	  ((not next-node)
;	   (format
;	    t "~%Cannot restart because the search space is exhausted~%")
;	   )
;	  ;; fudging depth bound for now.
;	  (t (setf p4::*node-counter* node-counter)
;	     (p4::main-search next-node last-node current-depth 30)
;	     )
;	  )
;    )
;  )


;;--------------------------------------------------------------;;
;; FUNCTION dump-state						;;
;;--------------------------------------------------------------;;
(loadtrace "~%   Defining function dump-state ...")
(defun dump-state ()
  (loop for i from 1 to *step-node-counter* do
		 (pshow 'node i)))

