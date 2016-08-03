;;; ********************************************************
;;; Purpose:
;;; Code to not add the goal choices if apply is selected.
;;; In order NOT to get this behavior, just
;;; set *no-goal-choices-if-apply-p* to nil

;;; ********************************************************
;;; Author: Manuela Veloso - November 1992
;;; Send bugs and suggestions to mmv@cs.cmu.edu
;;; Change Log: none yet
;;; *******************************************************

(in-package "P4")

(defvar *no-goal-choices-if-apply-p* t)

;;; This redefines the function expand-binding-or-applied-op
;;; Added code is marked - just two lines

(defun expand-binding-or-applied-op (node)
  "Expand a binding node"
  (declare (type a-or-b-node node))

  (let* ((next (compute-next-thing node))
	 (applicables
	  (cache a-or-b-node-applicable-ops-left
		 node
		 (abs-generate-applicable-ops
		  node next)))
	 (subgoals
	  ;; **********************************
	  ;; New code
	  ;; **********************************
	  (if (and applicables *no-goal-choices-if-apply-p*)
	      (cache a-or-b-node-goals-left node
		     (setf (a-or-b-node-pending-goals node)
			   nil))
	      ;; **********************************
	      ;; End of new code
	      ;; **********************************
	      (cache a-or-b-node-goals-left node
		     (setf (a-or-b-node-pending-goals node)
			   (delete-if
			    #'(lambda (goal)
				(goal-loop-p node goal))
			    (abs-generate-goals node next)))))))
    (if (and (null applicables) (null subgoals))
	(close-node node :no-choices)
	(let ((what-next (choose-apply-or-subgoal node applicables subgoals)))
	  (case what-next
	    (:apply
	     (if applicables
		 (do-apply-op node applicables next)
		 (close-node node :no-choices)))
	    (:sub-goal
	     (if subgoals
		 (do-subgoal node subgoals next)
		 (close-node node :no-choices)))
	    (otherwise what-next))))))

(in-package "user")
