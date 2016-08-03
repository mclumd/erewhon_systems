(in-package p4)
(defun old-gen-apps-r (node applied-inst-ops)
  (cond ((null (nexus-parent node)) nil)

	((and (binding-node-p node)
	     (not (inference-rule-a-or-b-node-p node))
	     (applicable-op-p node)
	     (not (member node applied-inst-ops)))
;	 (list (binding-node-instantiated-op node))
	 ;;aperez: Jan 93 put this back so :permute-application-order
	 ;;works 
;this was out
	;; This used to be done, but isn't needed for completeness.
	 (cons (binding-node-instantiated-op node)
	       (old-gen-apps-r (nexus-parent node) (cons node applied-inst-ops))))
;this was out


	;;; If this op could be applied earlier in some other branch, leading
	;;; to the same application sequence, don't do it here.
	((and (typep node 'goal-node)
	      (null applied-inst-ops)
	      (something-should-be-applied-here-p (nexus-parent node)))
	 nil)

	((and (typep node 'applied-op-node)
	      (not (inference-rule-a-or-b-node-p node)))
	 (old-gen-apps-r (nexus-parent node)
		     (cons (instantiated-op-binding-node-back-pointer
			    (applied-op-node-instantiated-op node))
			   applied-inst-ops)))

	(t (old-gen-apps-r (nexus-parent node) applied-inst-ops))))


;;from my-release-partial.lisp
(defun process-initial-state (state)
  (dolist (literal state)
    (let* ((literal-values (gethash literal *literals-hash*))
	  (need-ops (if literal-values (car literal-values) nil)))
      (if literal-values 
	  (dolist (need-op need-ops)
	    (setf (aref *partial-graph* 0 need-op) 1)))))
   (process-initial-state-negated-lits state)
   ;;Jun 12 95
   (add-missing-links-from-0 (car (array-dimensions *partial-graph*)))
   )

(defun add-missing-links-from-0 (dim)
  (declare (special *partial-graph*))
  (do ((i 0 (1+ i)))
      ((eq i dim))
    (unless (reachable-p 0 (list 0) i *partial-graph* dim)
      (setf (aref *partial-graph* 0 i) 1))))

;;from access-fns-pro4-new.lisp
(defun create-plan-step (node)
  (declare (type applied-op-node node))
  ;; an a-or-b-node node may have several application structures
  ;; corresponding to inference rules. Assume that in an applied-op
  ;; node the one we want is the last one (check this with Jim)
  (let* ((application (car (last (a-or-b-node-applied node))))
	 (op (op-application-instantiated-op application)))
    (make-plan-step
     :name (create-op-list op)
     :preconds (build-plan-step-preconds op)
     :add-list (mapcar #'create-goal-list
		       ;;(op-application-delta-adds application)
		       ;i don't trust mapcan
		       (apply #'append (mapcar #'op-application-delta-adds
					       (a-or-b-node-applied node))))
     :del-list (mapcar #'create-goal-list
		       ;;(op-application-delta-dels application)
		       (apply #'append (mapcar #'op-application-delta-dels
					       (a-or-b-node-applied node)))))))

(in-package user)
