(in-package 'p4)
(export 'prepare-plan-for-partial-order-all-preconds)

;;; Process preconditions so OR's and Exist's are dealt with properly
;;; (they were ignored in access-fns-pro.lisp) To do this we have to
;;; simulate the plan execution to find which of the disjuncts or
;;; possible bindings were matched.

;;; result = (run)

;;; ********** Using Karen's code ***********

;;; To build the partial order call:
;;;
;;;     (build-partial
;;;        (prepare-plan-for-partial-order-all-preconds result)
;;;        (get-initial-state))
;;; *****************************************************************
;;; Change Log: 
;;; aperez Dec 7 1993
;;; Modified prepare-plan-for-partial-order to use prodigy-result structure.
;;; *****************************************************************


;;; This function  replaces prepare-plan-for-partial-order (in
;;; access-fns-pro4.lisp) 
;;; The call to footprint fills the :satisfying-preconds property of
;;; instantiated-op-plist with the list of preconditions

(defun prepare-plan-for-partial-order-all-preconds ()
  ;;returns a list of plan steps
  (user::footprint
   (p4::path-from-root
    (cdr (user::prodigy-result-interrupt user::*prodigy-result*))))
  (append
   (mapcan #'create-plan-step-all-preconds
	   (cdr (path-from-root
		 (cdr (user::prodigy-result-interrupt user::*prodigy-result*))
		 #'applied-op-node-p)))
   (list (create-finish-step))))

;;; This function replaces create-plan-step
;;; We need to allow also inference rules:
;;; an a-or-b-node node may have several application structures
;;; corresponding to inference rules. The last node is the operator
;;; and the rest are inference rules that fire as a consequence of
;;; applying the operator.

;;; What about eager inference rules? Do we want all of them in the
;;; partial order? 

(defun create-plan-step-all-preconds (node)
  (declare (type applied-op-node node))
  ;;returns a list of plan steps.
  (mapcar #'create-one-step (reverse (a-or-b-node-applied node))))

(defun create-one-step (application)
  (let ((op (op-application-instantiated-op application)))
    (make-plan-step
     :name (create-op-list op)
     :preconds
     (mapcar #'(lambda (x)
		 (if (literal-p x) (create-goal-list x)
		     ;;assume is a negation
		     (list 'user::~ (create-goal-list (second x)))))
	     (getf (p4::instantiated-op-plist op)
		   :satisfying-preconds))
     :add-list (mapcar #'create-goal-list
		       (op-application-delta-adds application))
     :del-list (mapcar #'create-goal-list
		       (op-application-delta-dels application)))))


#|
;;; ********** Using my replay code ***********
;; This takes much longer because it has to set the initial state, and
;; fire eager inference rules both at the beginning and every time an
;; op is applied. The code above takes advantage if the search tree bu
;; calling maintain-state-and-goals. 

;;; Sets value of *expert-plan-steps* as side effect.
;;; -- *expert-plan-steps* contains operators and lazy inference rules
;;; obtained by executing the plan. It is a list of plan-step
;;; structures that may be used directly by the partial order
;;; generator: to get the partial order call (in P4 package):
;;;
;;;   (build-partial *expert-plan-steps* (get-initial-state))


(defun replay-to-build-plan-steps (result &key verbose-replay)
  (setf *expert-plan-steps* nil)
  (let  ((*verbose-replay* verbose-replay)
	 (goal (prog1 (set-initial-state-and-goal)
		 (replay-eager-inference-rules))))
    (declare (special *verbose-replay*))
    (dolist (node (cdr (path-from-root (cdar result)
				       #'applied-op-node-p)))
      (dolist (application (reverse (a-or-b-node-applied node)))
	(execute-step (op-application-instantiated-op application))))
    (if (true-goal-p goal) ;;this sets the plan step for *finish*
	(setf *expert-plan-steps* (reverse *expert-plan-steps*)))))



;;temp help fns

(defun find-step (op-as-list)
  (find-if #'(lambda (step)
	       (let ((name (plan-step-name step)))
		 (and (eq (car name) (car op-as-list))
		      ;(progn (break) t)
		      (eq (second name) (second op-as-list))
		      (eq (third name)(Third op-as-list))
		      (eq (fourth name)(fourth op-as-list)))))
	   *expert-plan-steps*))

|#