;;;***********************************************************

(defun case-goal-p (case-node)
  (p4::goal-node-p case-node))

(defun case-operator-p (case-node)
  (p4::operator-node-p case-node))

(defun case-bindings-p (case-node)
  (p4::binding-node-p case-node))

(defun case-applied-op-p (case-node)
  (p4::applied-op-node-p case-node))

;;;***********************************************************

(defun get-case-node-name (case-node)
  (p4::nexus-name case-node))

(defun get-case-visible-goal (case-goal-node)
  (goal-from-literal (p4::goal-node-goal case-goal-node)))

(defun get-case-new-visible-goal (case-goal-node case)
  (apply-case-substitutions 
   (get-case-visible-goal case-goal-node) case))

(defun get-case-visible-operator (case-operator-node)
  (p4::operator-name
   (p4::operator-node-operator case-operator-node)))

;;; returns a list of a list of vars and a list of names, not objects.
;;; ((<object> <place> <rocket>) (hammer loca apollo))

(defun get-case-visible-bindings (case-bindings-node)
  (let* ((case-instantiated-op
	  (p4::binding-node-instantiated-op case-bindings-node))
	 (case-op (p4::instantiated-op-op case-instantiated-op))
	 (case-op-vars (p4::operator-vars case-op))
	 (case-op-vals-names
	  (mapcar #'(lambda (obj)
		      (cond
			((eq (type-of obj) 'p4::prodigy-object)
			 (p4::prodigy-object-name obj))
			(t obj)))
		  (p4::instantiated-op-values case-instantiated-op))))
    (list case-op-vars case-op-vals-names)))

(defun get-case-new-visible-bindings (case-bindings-node case)
  (apply-case-substitutions
   (get-case-visible-bindings case-bindings-node) case))

(defun get-case-visible-inst-op (case-applied-op-node)
  (get-visible-inst-op
   (p4::applied-op-node-instantiated-op case-applied-op-node)))

(defun get-case-new-visible-inst-op (case-applied-op-node case)
  (apply-case-substitutions
   (get-case-visible-inst-op case-applied-op-node) case))
  
(defun get-case-parent-node (case-node)
  (p4::nexus-parent case-node))

(defun get-case-children-nodes (case-node)
  (p4::nexus-children case-node))

;;; This function returns a list of numbers that are the
;;; names of the CASE nodes that introduced the goal at
;;; the given case-goal-node -- this list is used to
;;; mark all dependent steps from goal.

(defun get-case-node-names-goal-introducing-operators (case-goal-node)
  (map 'list #'(lambda (x) (p4::binding-node-name x))
       (p4::goal-node-introducing-operators
	case-goal-node)))

(defun get-case-node-name-introducing-binding-node (case-applied-node)
  (p4::binding-node-name
   (p4::instantiated-op-binding-node-back-pointer
    (p4::applied-op-node-instantiated-op
     case-applied-node))))

;;;***********************************************************

;;; flat-list can be a goal (on a b) or a visible inst op
;;; (load-rocket hammer apollo loca) or a list of names
;;; of variables (hammer apollo loca)
;;; apply-case-substitutions accesses *guiding-case*

(defun apply-case-substitutions (flat-list case)
  (let* ((case-header (get-case-header-from-case-name
		       (guiding-case-real-name case)))
	 (insts-to-vars (case-header-insts-to-vars case-header))
	 (base-substitution (guiding-case-base-substitution case))
	 (additional-bindings (guiding-case-additional-bindings case)))
    (sublis additional-bindings 
	    (sublis base-substitution
		    (sublis insts-to-vars flat-list)))))

;;;***********************************************************
