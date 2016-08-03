(in-package :p4)


(defun apply-op (node inst-op &optional (justn nil))
  (declare (type a-or-b-node node)
	   (type instantiated-op inst-op))
  "Change the state and record the actual changes in the delta-assertions slot"

  (let* ((op (instantiated-op-op inst-op))
	 (application (make-op-application :instantiated-op inst-op))
	 (vars (rule-vars op))
	 (values (instantiated-op-values inst-op))
	 (justification
	  (if (inference-rule-p op)
	      (or justn
		  (preconds-to-list
		   (instantiated-op-binding-node-back-pointer inst-op)))))
	 (precond-bindings
	  (precond-bindings vars values)))

    ;; The application structure will record this application at this node.
    (push application (a-or-b-node-applied node))

    ;; Iterate over the del-list and add-list of the operator. For each
    ;; one, find the associated literal in the state and do the dirty.
    ;; We have to work out what literals to fire first, in case there
    ;; are bindings, and firing off one lot alters the bindings of the
    ;; other. If that is the case, it matters what order the adds and
    ;; dels are in, but we don't preserve that order. I do the del's
    ;; first so that if a literal is in both lists, it stays around.
    (let ((adds-and-deletes (compute-effects op precond-bindings node)))
      ;; Added [28jul00 cox]
      (user::declare-2-others
       adds-and-deletes)
      (dolist (dellit (first adds-and-deletes))
	(apply-for-one-literal dellit justification application nil node))
      (dolist (addlit (second adds-and-deletes))
	(apply-for-one-literal addlit justification application t node)))
    
    ;;Peter 12/14/94.  Put in to call the change-state function.
    (change-state-on-apply node application)

    ;; Not sure this is the right thing to do..
    (unless justn (delete-instantiated-op-from-literals inst-op))))
