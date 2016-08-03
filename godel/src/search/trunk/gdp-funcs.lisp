 (in-package :gdp)

 ;;;; This function takes as input 
 ;; a) the current state,
 ;; b) the subgoal being planned for,
 ;; c) the root of the subtree of the decomposition tree being planned for.
 ;;;; it returns 2 values : a pointer to the tree with it as the root and the primitive plan 
 ;;;; the leaves form.

(defun goal-decomposition-planner (current-state current-task-node)
  (let ((task-condition (first (task-node-contents current-task-node)))
	(task-goal (second (task-node-contents current-task-node))))
    ;; first check if all goals are present in current-state. If so, we're done
    (if (subset task-goal current-state)
	(values current-task-node nil))

    ;;		(format t "state is of type tagged-state? ~A" (shop2.common::tagged-state-p current-state))

    ;; next check if task-condition is asserted in current-state. If not, then FAIL
    (if (not (subset task-condition current-state))
	(values nil nil))

    ;; else check whether there's an action that achieves 'task-goal' from initial-state
					;    (format t "actions that are executable from this state are : ~%")
    (let ((ops (domain-operators *domain*))
	  (applicable-actions nil)
	  (methods (domain-methods *domain*))
	  (applicable-methods nil)
	  (applicable-options nil))
      (maphash
       (lambda (key value)
	 (setf applicable-actions (append applicable-actions (bindings-of-operator-achieving-goal task-goal 
												  current-state 
												  value))))
       ops)

					;			(format t "ops at start are ~A ~%" applicable-actions)

      ;;			(format t "got grounded ops ...")

 ;;; ---------------------------------------
 ;;; This section is commented because we need to get the full set of applicable actions
 ;;; and methods and THEN only we must non-deterministically choose a task reduction
 ;;; from there.

      ;;      ;; at this point 'actions' contains the actions that directly achieve goal from initial-state
      ;;      ;; so, if actions is not empty, choose an action from it and set that as the child of the DT node 
      ;;      ;; once it is set, return decomposition-tree
      ;;      (if (not (null actions))
      ;;        (let* ((chosen-action (first actions)) 
      ;;               (task-node-of-chosen-action (make-task-node 
      ;;                                             :parent-task current-task-node 
      ;;                                             :contents (list chosen-action) :child-list nil)))
      ;;          (format t "chosen action is ~A~%" chosen-action)
      ;;          (setf (task-node-child-list current-task-node) (list task-node-of-chosen-action))
      ;;          (values current-task-node (list chosen-action)))))

 ;;; --------------------------------------

      ;; now that we've computed actions that achieve the goal, 
      ;; we must now look for methods to achieve the goal
      (maphash
       (lambda (key value)
	 (setf applicable-methods 
	       (append applicable-methods (bindings-of-gdr-achieving-goal task-condition 
									  task-goal 
									  current-state 
									  value))))
       methods)

      (setf options (option-list-for-task current-task-node current-state))

      ;; ------- IMPORTANT : Potential problem with copy-state --------------
					;(format t "state is ~A~%" (state-atoms current-state))
					;			(setf state-copy (copy-state current-state))
					;			(setf state-copy2 (make-initial-state *domain* *state-encoding* (state-atoms current-state)))
					;			(format t "copy of state before aats is : ~A~%" (state-atoms state-copy))
					;			(state-atoms (apply-action-to-state current-state (first options)))
					;			;(format t "state after action is ~A ~%" (state-atoms (apply-action-to-state current-state (first options))))
					;			(format t "copy of state after aats is : ~A~%" (state-atoms state-copy))
					;			(format t "sc2 is ~A~%" (state-atoms state-copy2))
      ;; --------- END ------------------------------------------------------

      ;; now you have the list of applicable methods to the task, try them one by one after ordering them
					;			(setf applicable-actions (order-actions applicable-actions))
					;			(setf applicable-methods (order-methods applicable-methods))

      ;; we have now both actions and methods that achieve the goal, we compose them
      ;; and then try each option on the list with backtracking
      (setf applicable-options (append applicable-actions applicable-methods))

					;			(format t "options are : ~A ~%" applicable-options)
					;			(loop for o in applicable-options do
					;						(format t "for option ~A : ~A ~%" o (primitive-op-p o)))

      ;; now try decomposing the task in the order of applicable-methods
					;			(decompose-task-using-method-list current-task-node applicable-methods current-state)

					;			(format t "subs for ~A are ~A~%" (car applicable-methods) (get-method-object-from-head (car applicable-methods)))

					;(decompose-task-using-method current-task-node (car applicable-options) current-state)
					;			(format t "right at the beginning ... ~A ~%" current-task-node)

					;			(format t "--------- TESTING FF HEURISTIC ------- ~%")
					;			(format t "applicable actions are ~A ~%" (applicable-actions current-state))
      (setf g (planning-graph-init current-state))
					;			(format t "g state is ~A ~%" (pg-state g))
					;			(planning-graph-print g)
      (setf counter 0)

					;			(format t "ordered methods are ~A ~%" (order-methods current-state applicable-methods task-goal))

      (setf first-m (first applicable-methods))
      (setf b (unify first-m (gdr-head (gethash (first first-m) (domain-methods *domain*)))))
      (setf g3 (apply-substitution (gdr-subgoals (gethash (first first-m) (domain-methods *domain*))) b))
      (setf g3 (append g3 task-goal))
					;			(format t "g3 is ~A ~%" g3)

					;			(format t "task-goal is ~A ~%" task-goal)
					;			(format t "goals are ~A ~%" goals)

					;			(loop
					;				(if (subset g3 (state-atoms (pg-state g)))
					;					(return)
					;					(progn
					;						(setf counter (+ counter 1))
					;						(format t "counter is ~A ~%" counter)
					;						(planning-graph-expand g)
					;						(format t "state-atoms are ~A ~%" (state-atoms (pg-state g))))))
					;			(planning-graph-print g)

					;			(format t "relaxed plan is ~A ~%" (planning-graph-level g g3))

					;			(write-problem-as-pddl "logistics" 
					;														 (get-objects-from-state current-state) 
					;														 (state-atoms current-state)
					;														 (goals-from-task-node current-task-node))

					;			(setf c-plan (invoke-classical-planner "logistics" current-state current-task-node))
					;			(setf p (read-from-string c-plan))

					;			(format t "Done! ~A ~%" c-plan)

					;			(setf p-c-plan (process-ff-output c-plan))
					;			(format t "classical plan is ~A ~%" p-c-plan)
					;			(dolist (x p-c-plan)
					;				(format t "~A : ~A ~%" x (type-of x))
					;				(dolist (y x)
					;					(format t "--~A : ~A ~%" y (type-of y))))

					;			(format t "hash of ~A is ~A ~%" (first (first p-c-plan)) (gethash (first (first p-c-plan)) (domain-operators *domain*)))

					;			(format t "state after this is ~A ~%" (state-atoms (apply-plan-to-state current-state p-c-plan)))

					;			(dolist (x c-plan)
					;				(format t "~A : ~A ~%" x (length x)))

					;			(setf new-c-plan (remove-if-not #'listp c-plan))
					;			(format t "new plan : ~A ~%" new-c-plan)

      (multiple-value-bind (final-tree plan) (achieve-subtasks "logistics" current-state (list current-task-node) nil)
	(if (eq final-tree 'FAIL)
	    (format t "No plan found ! ~%")
	    (format t "plan is ~A ~%" plan)))

      applicable-methods)))

 ;;        (format t "op name : ~S ... ~%" key)
 ;;        (format t "ops that achieve ~A are ~A~%" task-goal (bindings-of-operator-achieving-goal task-goal initial-state value)))
 ;;      (let ((binding (find-satisfiers (operator-preconditions value) initial-state)))
 ;;          (if (not (null binding))
 ;;            (format t "name : ~S ---- ~A~%" key binding))))
 ;;      ops)))

