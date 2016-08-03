(in-package :shop2)

;;;;----------------------------Structure Declarations-----------------------------------

;; This data structure encodes a node in the decomposition tree. Each node could be a task, in which case :
;;;; contents - (condition, goal) pair, parent-node - parent, child-list - list of subgoals
;; or an action, in which case :
;;;; contents - action, parent-node - parent, child-list - list of causal links it supports
(defstruct (task-node 
  (:print-function 
		(lambda (p s k)
			(format t "<~%contents:")
			(format t "~A" (task-node-contents p))
			(format t "~%childlist :~%")
			(print-contents-from-child-list (task-node-child-list p))
			(format t ">~%"))))
	(contents nil) ;; If primitive-task node a, then = ((a)) else ((c) (g))
  (parent-task nil)
  (child-list nil))

;;; this function returns all bindings of the operator that achieve the goal from the current state
(defun bindings-of-operator-achieving-goal (goal current-state op)
	(let* ((std-op (standardize op)) ; standardize operator
				 (pre-op (operator-preconditions std-op))
				 (add-op (operator-additions std-op))
				 (del-op (operator-deletions std-op))
				 (head-op (operator-head std-op)))

;		(format t "for operator ~A : ~%" head-op)
		;		(format t "--preconditions are : ~A ~%" pre-op)
;		(format t "--goal : ~A, subset result : ~A ~%" goal (subset goal current-state))

		;; if the operator has no preconditions (i.e. the INOP operator) and 
		;; the goal is asserted in the current state, then return op
		(if (and (null pre-op) (subset goal current-state))
			(progn
;				(format t "operator is ~A ~%" head-op)
				(list head-op))

			;; now check if the op additions doesn't contain the goal predicates, then 
			;; return nil.
			(progn
;				(format t "wow!! ~%")
				(if (not (goals-in-add-effects goal add-op))
					(progn
;						(format t "for op ~A, bindings are nil ~%" head-op)
					  nil)
					(let ((all-bindings (find-satisfiers pre-op current-state)) 
								;; all-bindings now contains all possible groundings of the preconditions of std-op
								(op-list nil))
						;; loop over all possible groundings of std-op and check whether goal is asserted in add-effects 
						(loop for b in all-bindings do
									(let ((grounded-add-effects (apply-substitution add-op b))
												(grounded-head (apply-substitution head-op b)))
										(if (subset goal grounded-add-effects) 
											(setf op-list (cons grounded-head op-list)))))


						;; op-list now contains the actions that assert the goal from the current state
						op-list))))))

;;; this function returns all bindings of the gdr that achieve the goal from the current state
(defun bindings-of-gdr-achieving-goal (task-condition task-goal current-state gdr)
	(let* ((head (gdr-head gdr))
				 (goal (gdr-goal gdr))
				 (pre (gdr-preconditions gdr))
				 (subgoals (gdr-subgoals gdr))
				 (goal-obj (apply 'make-initial-state *domain* *state-encoding* (list task-goal)))
				 (head-bindings (find-satisfiers goal goal-obj)))

		;; head-binding now contains a valid binding if gdr satisfies task-goal and nil if not.
;		(format t "current state : ~A ~%" (state-atoms current-state))
;		(format t "In bogag ~A ... head-binding is ~A, pre : ~A ~%" head head-bindings pre)
;		(format t "goal : ~A, task-goal : ~A ~%" goal task-goal)

		;; if head-bindings is nil, return nil
		(if (null head-bindings)
			nil

			;; if head-bindings is of length > 1 (something wrong since task-goal is fully ground), then error
			(if (> (length head-bindings) 1)
				(error "head-binding of length > 1, WRONG!")

				;; if you've got here, implies single binding to head of gdr. apply substitution to rest
				;; of gdr for next step, i.e. satisfying preconditions of gdr
				(let* ((head-binding (car head-bindings))
							 (partially-grounded-head (apply-substitution head head-binding))
							 (partially-grounded-pre (apply-substitution pre head-binding))
							 ;;							 (partially-grounded-subgoals (apply-substitution subgoals head-binding))
							 (pre-bindings (find-satisfiers partially-grounded-pre current-state))
							 (grounded-gdrs nil))

;					(format t "After binding gdr with task-goal, bindings for pre are ~A ~%" pre-bindings)

					;; IF pre-bindings is nil, then no bindings of gdr satisfy current-state, return nil
					(if (null pre-bindings)
						nil
						;; if not nil, then return a list of all groundings of the gdr that achieve the goal
						;; and whose preconditions are satisfied in the initial state
						(progn
							(loop for b in pre-bindings do
										(let ((grounded-head (apply-substitution partially-grounded-head b)))
											;;													(format t "method-head is ~A~%" final-head)
											(if (not (groundp grounded-head))
												(error "output not fully grounded!")
												(setf grounded-gdrs (cons grounded-head grounded-gdrs)))))
;							(format t "in bogag, bindings are ~A ~%" grounded-gdrs)

							grounded-gdrs)))))))

;;; Overview :
;;;		This function combines bindings-of-operator-achieving-goal and bindings-of-gdr-achieving-goal
;;;		to return all options for a given task in a given state. 
;;;	Notes :
;;;		NONE.
;;;	Return Value :
;;;		list of options, i.e. either action heads or method heads
(defun option-list-for-task (task-node current-state)
	(let ((task-goal (second (task-node-contents task-node)))
				(task-condition (first (task-node-contents task-node)))
				(methods (domain-methods *domain*))
				(operators (domain-operators *domain*))
				(applicable-methods nil)
				(applicable-actions nil))

		;				(format t "task-goal is ~A ~%" task-goal)

		;; first calculate all the applicable actions whose preconds are satisfied in 
		;; the current state and which achieve the task goal
		(maphash
			(lambda (key value)
				(setf applicable-actions (append applicable-actions (bindings-of-operator-achieving-goal task-goal 
																																																 current-state 
																																																 value))))
			operators)

		;		(format t "applicable ops are ~A ~%" applicable-actions)

		;; then calculate all applicable methods whose preconds are satisfied in 
		;; the current state and whose goal unifies with the task goal
		(maphash
			(lambda (key value)
				(setf applicable-methods 
							(append applicable-methods (bindings-of-gdr-achieving-goal task-condition 
																																				 task-goal 
																																				 current-state 
																																				 value))))
			methods)

		;		(format t "applicable ops are ~A ~%" applicable-actions)
		;		(format t "applicable methods before ordering are ~A ~%" applicable-methods)
;		(let ((ff-start-time (get-internal-run-time)))
;			(setf applicable-methods (order-methods current-state applicable-methods task-goal))
;			(format t "rpg took ~A seconds ~%" (/ (float (- (get-internal-run-time) ff-start-time)) internal-time-units-per-second)))
		;		(format t "applicable methods are ~A ~%" applicable-methods)

		;		(format t "actions are ~A, methods are ~A~%" applicable-actions applicable-methods)
		(append applicable-actions applicable-methods)))

;;; this function re-orders the actions using some tactic, FOR NOW just the identity function, later FF
(defun order-actions (a)
	a)

(defstruct method-value
	(m nil)
	(value 0))

;;; this function re-orders the methods using some tactic, FOR NOW just the identity function, later FF
(defun order-methods (state methods task-goal)
	(let ((graph (planning-graph-init state))
				(methods-with-heur-values nil)
				(sorted-methods nil))
;		(let ((sort-start-time (get-internal-run-time)))
			(dolist (m methods)
				;			(format t "considering method ~A now ... ~%" m)
				;			(format t "subgoals are ~A ~%" (append (method-subgoals m) task-goal))
				(let* ((m-subgoals (method-subgoals m))
							 (graph-levels (planning-graph-level graph m-subgoals)))
					;				(format t "value of ~A is ~A ~%" m graph-levels)
					(setf methods-with-heur-values (cons (make-method-value :m m 
																																	:value graph-levels) 
																							 methods-with-heur-values))))
;			(format t "time for sorting is ~A ~%" (/ (float (- (get-internal-run-time) sort-start-time)) internal-time-units-per-second)))
;		(format t "length of sorted-list before sorting is ~A ~%" (length methods-with-heur-values))
;		(format t "sorted list : ~A ~%" methods-with-heur-values)
		
		;; at this point, methods-with-heur-values contains list of all methods and their 
		;; heuristic values. Must now prune out all methods with INFINITY as heuristic value
		;; since the subgoals of these methods are unreachable from the current state
		(setf methods-with-heur-values 
					(remove-if (lambda (m-with-val)
;											 (format t "for method ~A, value is ~A ~%" m-with-val (method-value-value m-with-val))
											 (eq (method-value-value m-with-val) 'INFINITY))
										 methods-with-heur-values))

			(setf methods-with-heur-values (stable-sort methods-with-heur-values (lambda (m1 m2)
																																						 (< (method-value-value m1) (method-value-value m2)))))
;		(format t "length of sorted list is ~A, actual list ~A ~%" (length methods-with-heur-values) (length methods))
		(dolist (m methods-with-heur-values)
			(setf sorted-methods (append sorted-methods (list (method-value-m m)))))

;		(format t "exiting order methods ... ~% ")

		sorted-methods))

;;; Overview:
;;;		This function takes a task and a list of grounded method heads and attempts to decompose
;;;		the task using these methods in the order given. 
;;; Notes :
;;;		makes a copy of the task node so that decompose-task-using-method can destructively modify
;;;		the task node.
;;; Return Value : 
;;;		if no method is able to decompose the task completely, 'FAIL
;;;	  else the pointer to the full sub-tree
(defun decompose-task-using-method-list (task method-list state)
	(if (null method-list)
		'FAIL
		(let* ((copy-of-task (copy-task-node task))
					 (result (decompose-task-using-method copy-of-task (car method-list) state)))
			(if (= result 'FAIL)
				(decompose-task-using-method-list task (cdr method-list) state)
				result))))

;;; Overview :
;;;		This function decomposes a task node by the given grounded 
;;;		primitive action by setting the slots of the task appropriately
;;;		and calling goal-decomposition-planner on the next undecomposed node
;;; Notes :
;;;		Since this is a primitive action and the preconditions are satisfied 
;;;		in the current state, its assumed that the decomposition is guaranteed
;;;		to succeed (possible problems could occur in dynamic domains, when just
;;;		before executing the action, preconds could be invalidated, but we're
;;;		not bothered about that now).
;;;	Return Value : 
;;;		- pointer to task-node
;;;		- sub-plan (i.e. a list containing the action)
(defun decompose-task-using-action (task action state)
	(let ((action-node (make-task-node :contents (list (list action))
																		 :parent-task task
																		 :child-list nil)))
		(setf (task-node-child-list task) (list action-node))
		(values task (list action))))

;;; Overview : 
;;;		This function attempts to decompose the given task by the given 
;;;		grounded method signature by setting slots of 'task' appropriately 
;;;		and calling goal-decomposition-planner recursively on them. 
;;; Notes :
;;;		- The method is the signature, not the method object. Some work should
;;;			be done to get the object from the signature.
;;;	Return Value : 
;;;		if no valid decomposition - 'FAIL
;;;		else :
;;;		- pointer to subtree
;;;		- subplan under the task node
;;;																
(defun decompose-task-using-method (task method-head state goal-history)
	(let* ((method-obj (get-method-object-from-head method-head))
				 (method-goal (gdr-goal method-obj))
				 (subgoals (gdr-subgoals method-obj))
				 (all-goals (append subgoals method-goal))
				 (subtask-list nil)
				 (first-subgoal (first subgoals)))

;		(format t "first subgoal is ~A ~% goal history is ~A ~%" (list first-subgoal) goal-history)

		(if (member (list first-subgoal) goal-history :test #'equal)
			(progn
;				(format t "test succeeded! method-head : ~A ~%" method-head)
				(values 'FAIL nil))
			(progn
				;		(format t "all-goals are ~A ~%" all-goals)

				;; set child-list of task node to be the task-list of subgoals of the method
				(setf subtask-list (get-task-list-from-goal-list all-goals task))
				(setf (task-node-child-list task) subtask-list)
				;		(format t "direct : ~A ~%" subtask-list)

				;		(loop for x in subtask-list do
				;(format t "~A~%" x))
				;					(format t "goal is ~A~%" (second (task-node-contents x))))

				;; Now, we have the task node fully set up, need to recursively solve for these tasks
				;; in sequence, i.e. call achieve-subtasks
				(achieve-subtasks state subtask-list (cons (goals-from-task-node task) goal-history))))))
	
;;; Overview : 
;;;		This function looks to decompose a list of task-nodes starting from a state s.
;;;		The function calculates the option-list for the top-task (i.e. the first task
;;;		on the list). It then calls the helper function achieve-subtasks-given-toptask-options
;;;		which handles the recursive nature of the function. 
;;; Notes :
;;;		NONE.
;;;	Return Value : 
;;;		- the list of task-nodes completely decomposed.
;;;		- the sub-plan under these nodes.
(defun achieve-subtasks (current-state task-list goal-history)
;  (format t "~%~%entered achieve subtasks with tasklist = ~A ~%~%" task-list)
	
;	(format t "goal history is ~A ~%" goal-history)
	(if (null task-list)
		(values nil nil)
		(let ((toptask (first task-list)))
;			(format t "reached here ...  ~A ~% state : ~A ~%" (goals-from-task-node toptask) current-state)
			(if (subset (goals-from-task-node toptask) current-state)
				(progn
;				  (format t "goal ~A already asserted in current state ~%" (goals-from-task-node toptask))
					(setf (task-node-child-list toptask) (list '(!!INOP)))
					(achieve-subtasks current-state (cdr task-list) goal-history))
				(if (member (goals-from-task-node toptask) goal-history :test #'equal)
					;; if current goal trying to achieve is present in goal history, then return FAIL
					;; since no good can come out of trying to decompose the parent goal in this way
					(values 'FAIL nil)
					(let ((toptask-options (option-list-for-task toptask current-state)))
;						(format t "toptask is ~A ~%" toptask)
;						(format t "toptask options are ~A ~%" toptask-options)
						(achieve-subtasks-given-toptask-options current-state task-list toptask-options goal-history)))))))

;;; Overview : 
;;;		This function is the helper function for achieve-subtasks. It takes as argument 
;;;		the current state, the list of tasks to be decomposed and the option-list for the 
;;;		toptask. It then tries the first option (say o). If o works, it then recursively tries to 
;;;		decompose the rest of the task list from the state reached after executing the subplan
;;;		under the first task (i.e, under o). If the recursive call does not work (implying that
;;;		every decomposition tailing from o failed), then we try to decompose the toptask using
;;;		the next option recursively and so on. 
;;;	Notes :
;;;		- keep in mind the handling of the ordering of the option. has to be done somewhere.
;;;		- make-initial-state is used to make a copy of the state for backtracking purposes.
;;;			copy-state isn't working for some reason. Revisit this at some point.
;;;	Return Value : 
;;;		- list of decomposed task nodes
;;;		- sub-plan under the task nodes
(defun achieve-subtasks-given-toptask-options (current-state task-list toptask-options goal-history)
	;	(format t "toptask is ~A ~%" toptask)
;	(format t "entered asgto ... toptask options are ~A ~%" toptask-options)
	;	(format t "entered asgto with task-list : ~A ~%" task-list)
	;; if there are no more options left to achieve the top task, return FAIL
	(if (null toptask-options)
		;; not returning FAIL anymore ... invoke classical planner,
		;; check if that returns a valid plan and if so, continue.
		;; if not, ONLY then return FAIL
		(values 'FAIL nil)
		;		(let ((classical-plan (invoke-classical-planner domain-name 
		;																										current-state 
		;																										(car task-list))))
		;			(if (eq classical-plan 'FAIL)
		;				(values 'FAIL nil)
		;				;; if classical planner works, then attempt to solve for the rest of the tasks
		;				(progn
		;					(setf classical-plan (process-ff-output classical-plan))
		;					(let ((plan-node (make-task-node :contents (list classical-plan)
		;																					 :parent-task (car task-list)
		;																					 :child-list nil)))
		;						(setf (task-node-child-list (car task-list)) plan-node))   
		;					(multiple-value-bind (tree plan) (achieve-subtasks domain-name 
		;																														 (apply-plan-to-state current-state classical-plan)
		;																														 (cdr task-list) 
		;																														 nil)
		;						;; if there's no plan with classical-plan as the prefix, then return 'FAIL
		;						(if (eq tree 'FAIL)
		;							(values 'FAIL nil)
		;							;; if there IS a plan, return the concatenation of the two plans
		;							(values task-list (append classical-plan plan)))))))


		;; else, try the next option available. Once you decompose using that option, 
		;; try to solve for the rest of the subgoals keeping that fixed. 
		(let ((task (first task-list))
					(option (first toptask-options))
					;					(state-copy nil))
;					(sc-time (get-internal-run-time))
					(state-copy (make-initial-state *domain* 
																					*state-encoding* 
																					(state-atoms current-state))))
;			(format t "state copy took ~A ~%" (/ (float (- (get-internal-run-time) sc-time)) internal-time-units-per-second)) 
			;; if option is an action, apply action and solve for the rest of the goals
			;; recursively
;			(format t "current goal is ~A, option used is ~A ~%" (goals-from-task-node task) option)

			(if (primitive-op-p option)
				(progn
					(decompose-task-using-action task option current-state)
					;					(format t "task after decomposing with action ~A is ~A ~%" option task)
					;					(format t "about to start recursing ... ~%")
					(multiple-value-bind (tree plan) (achieve-subtasks (apply-action-to-state current-state option) 
																														 (cdr task-list) 
																														 nil)
						(if (eq tree 'FAIL)
							(achieve-subtasks-given-toptask-options state-copy 
																											task-list 
																											(cdr toptask-options) 
																											goal-history)
							(values task-list (cons option plan)))))

				;; if option is a method ... 
				(progn
          (let* ((method-obj (get-method-object-from-head option))
                 (method-goal (gdr-goal method-obj))
                 (subgoals (gdr-subgoals method-obj))
                 (all-goals (append subgoals method-goal))
                 (subtask-list (get-task-list-from-goal-list all-goals task))
                 (first-subgoal (first subgoals)))
            ;; at this point, you've set up subtask-list which is the subgoals of 'task'
            ;; you want to now call achieve-subtasks 'subtask-list+task-list' in current-state
            (if (member (list first-subgoal) goal-history :test #'equal)
              ; return FAIL if first subgoal is in goal-history (implying a loop)
              (progn
;                (format t "loop found! g - ~A ~%" first-subgoal)
                (achieve-subtasks-given-toptask-options current-state
                                                        task-list
                                                        (cdr toptask-options)
                                                        goal-history))
              (progn
                (setf (task-node-child-list task) subtask-list)
                (multiple-value-bind (tree plan) (achieve-subtasks current-state
                                                                   (append subtask-list (cdr task-list))
                                                                   (cons (goals-from-task-node task) goal-history))
                  (if (eq tree 'FAIL)
                    ;; if tree = FAIL, then it implies that no decomposition with 'option' as head
                    ;; gave an executable plan, so try next option
                    (achieve-subtasks-given-toptask-options current-state
                                                            task-list
                                                            (cdr toptask-options)
                                                            goal-history)
                    ;; if not equal to FAIL, then a solution has been found
                    (values tree plan)))))))))))


          
					;; first, solve for the first task using the given option
;					(multiple-value-bind (tree1 plan1) (decompose-task-using-method domain-name task option current-state goal-history)
;						;; if this does not work, then discard the option and try the remaining options
;						(if (eq tree1 'FAIL)
;							(achieve-subtasks-given-toptask-options domain-name 
;																											state-copy 
;																											task-list 
;																											(cdr toptask-options) 
;																											goal-history)
;							;; if it does work, now you have to see if the rest of the goals are solvable
;							;; from the resulting state
;							(multiple-value-bind (tree2 plan2) (achieve-subtasks domain-name 
;																																	 (apply-plan-to-state current-state plan1) 
;																																	 (cdr task-list) 
;																																	 nil)
;								;; if you are unable to solve for the rest of the goals, then must 
;								;; retry with a different option for the first task
;								(if (eq tree2 'FAIL)
;									(achieve-subtasks-given-toptask-options domain-name
;																													state-copy 
;																													task-list
;																													(cdr toptask-options)
;																													goal-history)
;									;; if success, then return the concatenation of the two subplans along with the task list
;									(values task-list (append plan1 plan2)))))))))))

;;; writes problem into the problem file 'Prob.pddl'. 
(defun write-problem-as-pddl (objects start-state goal)
;	(in-package :shop2-user)
	(format t 
;					"entered write-problem with objects : ~A ~% start-state : ~A ~% goal : ~A ... ~%"
					objects
					start-state
					goal)

	(with-open-file (stream (concatenate 'string domain-name "Prob.pddl")
													:direction :output
													:if-exists :supersede
													:if-does-not-exist :create)
		(format stream "(define (problem ~AProb)~%" (domain-name *domain*))
		(format stream "  (:domain ~A)~%" (domain-name *domain*))
		(format stream "  ~S~%" (cons ':objects objects))
		(format stream "  ~S~%" (cons ':init start-state))
		(format stream "  ~S)" (if (null (cdr goal))
														 (cons ':goal goal)
														 (list ':goal (cons 'and goal))))
		(close stream)))
;	(in-package :shop2))

;;; invokes classical planner (in this case, FF) on the planning problem 
;;; (current-state, goal). 
(defun invoke-classical-planner (current-state goals objects)
	(let ((atoms (state-atoms current-state))
				(goal goals)
				(plan-found t)
				(plan-string nil)
        (dom-name (domain-name *domain*)))
		(write-problem-as-pddl dom-name objects atoms goal)
		(format t "ff called to achieve ~A ~%" goal)
		(asdf:run-shell-command (concatenate 'string "./ff" " -o " dom-name "-classical.lisp -f " dom-name "Prob.pddl -i 0 > my-domain.SOL"))
		(with-open-file (ff-output "my-domain.SOL" :direction :input)
			(loop for line = (read-line ff-output nil)
						until (string= line "ff: found legal plan as follows")
						when (null line) do 
						(progn
							(setf plan-found nil)
							(return)))
			;; if plan-found is nil, means no plan found
			(if plan-found
				(progn
					(loop for line = (read-line ff-output nil)
								until (string= line "     ")
								do (push (subseq line 11) plan-string))
					plan-string)
				'FAIL))))

(defun domain-name-string ()
	(in-package :shop2-user)
	(setf s (concatenate 'string "" (domain-name *domain*)))
	(in-package :shop2)
	s)

(defun process-ff-output (ff-output)
	(let ((processed-output nil))
		(dolist (x ff-output)
			(if (> (length x) 0)
				(setf processed-output (cons (read-from-string x) processed-output))))
		processed-output))
		

				









;;;;-----------------------GDR accessors------------------------;;;;

(defun gdr-head (gdr)
  (second gdr))

(defun gdr-goal (gdr)
  (caddr gdr))

(defun gdr-preconditions (gdr)
  (cadddr gdr))

(defun gdr-subgoals (gdr)
  (cadddr (cdr gdr)))

(defun make-gdr (head goal pre subgoals)
	(list ':gdr head goal pre subgoals))




(defun print-contents-from-child-list (task-list)
	(loop for x in task-list do
				(format t "--contents are ~A ~%" (task-node-contents x))))

;;;;------------------------------ Helper Functions ------------------------------------

;;; This function returns true if the elements of l1 are present in l2, i.e. l1 \subseteq l2.
(defun subset (l1 l2)
	 (if (null l1)
		t
		(if (shop2.common::tagged-state-p l2)
			(and (shop2.common::atom-in-state-p (car l1) l2) (subset (cdr l1) l2))
			(and (member (car l1) l2 :test #'equal) (subset (cdr l1) l2)))))

;;; This function returns the goals from the task
(defun goals-from-task (task)
  (let ((goals (cdr (second task))))
    (cons goals nil)))

(defun goal-list-from-problem (problem)
	(let ((task-list (cdr (tasks problem)))
				(goals nil))
		(dolist (task task-list)
			(setf goals (append goals (list (cdr task)))))
		goals))


(defun goals-from-task-node (task-node)
	(second (task-node-contents task-node)))

;;; Overview :
;;;		This function makes a copy of the task node. Not a deep copy, but a shallow one.
;;; Notes :
;;;		NONE.
;;; Return Value : 
;;;		a copy of the task
(defun copy-task-node (task)
	(let ((node-contents-copy (task-node-contents task))
				(parent-task-copy (task-node-parent-task task))
				(child-list-copy (task-node-child-list task)))
		(make-task-node :contents node-contents-copy :parent-task parent-task-copy :child-list child-list-copy)))

;;; Overview :
;;;		This function gets the full method object from the grounded head
;;; Notes : 
;;;		NONE.
;;;	Return Value : 
;;;		grounded method object
(defun get-method-object-from-head (m-head)
	(let* ((methods (domain-methods *domain*))
				(ungrounded-method (gethash (car m-head) methods))
				(subs (unify (gdr-head ungrounded-method) m-head)))
		(if (eq subs 'shop2.unifier::fail)
			(error "Unable to unify in get-method-object-from-head") ; ~A with ~A in get-method-object-from-head ~%" ungrounded-method m-head)
			(let ((grd-goal (apply-substitution (gdr-goal ungrounded-method) subs))
						(grd-pre (apply-substitution (gdr-preconditions ungrounded-method) subs))
						(grd-sub (apply-substitution (gdr-subgoals ungrounded-method) subs)))
				(make-gdr m-head grd-goal grd-pre grd-sub)))))

;;; Overview :
;;;		Constructs task-list out of goal-list
;;;	Notes :
;;;		NONE.
;;;	Return Value : 
;;;		list of tasks
(defun get-task-list-from-goal-list (goal-list task)
	(if (null goal-list)
		nil
		(cons (make-task-node :contents (list nil (list (car goal-list))) :parent-task task :child-list nil)
					(get-task-list-from-goal-list (cdr goal-list) task))))

;;; Overview :
;;;		This function tests whether the given operator is a primitive one or a non-primitive one.
;;; Notes : 
;;;		This assumes that there can exist no operators and methods with the same names. 
;;; Return Value : 
;;;		T if primitive operator, nil if not.
(defun primitive-op-p (op)
	(let ((operators (domain-operators *domain*))
				(methods (domain-methods *domain*))
				(name (first op)))
		(if (gethash name operators)
			t
			(if (gethash name methods)
				nil
				(error "name ~A doesn't exist in either ops or methods!" name)))))

;;; Overview : 
;;;		This function applies a subplan to a state and returns the resulting state
;;;	Notes :
;;;		DESTRUCTIVELY modifies the state argument
;;;	Return : 
;;;		The modified state object
(defun apply-plan-to-state (state plan)
	(if (null plan)
		state
		(let ((new-state (apply-action-to-state state (car plan))))
			(apply-plan-to-state new-state (cdr plan)))))

;;; Overview :
;;;		This function applies an action to a state and returns resulting state
;;;	Notes :
;;;		DESTRUCTIVELY modifies state argument
;;;	Return :
;;;		Modified state object
(defun apply-action-to-state (state action)
	(let* ((operators (domain-operators *domain*))
				 (op (gethash (first action) operators))
				 (subs (unify (operator-head op) action))
				 (adds (apply-substitution (operator-additions op) subs))
				 (dels (apply-substitution (operator-deletions op) subs)))
;		(format t "for ~A, adds are : ~A, dels are : ~A ~%" action adds dels)
		(loop for p in dels do
					(delete-atom-from-state p state 0 op))
		(loop for p in adds do
					(add-atom-to-state p state 0 op))
		state))

;;; Overview : 
;;;		These functions are helpers to 'bindings-of-operator-achieving-goal'. Checks whether the 
;;;		predicates in the goal are present in the add effects.
;;;	Return Value :
;;;		nil if not present, t if present
;;;	NOTES :
;;;		NONE.

(defun goals-in-add-effects (goals add-effects)
	;; if no more goals are left to check, return TRUE
	(if (null goals)
		t
		;; if more, then check if both the first goal is present and the remaining 
		;; are (recursively).
		(and (goal-predicate-in-add-effects (car goals) add-effects)
				 (goals-in-add-effects (cdr goals) add-effects))))

(defun goal-predicate-in-add-effects (goal add-effects)
	(if (null add-effects)
		nil
		(if (equal (car goal) (car (car add-effects)))
			t
			(goal-predicate-in-add-effects goal (cdr add-effects)))))

;;; Takes a list of objects in the problem and sets global variable
;;; *problem-objects* 
;(defun defobjects (objects)
;	(setf *problem-objects* (cons ':objects objects))
;	(format t "HAHA! ~A ~%" *problem-objects*))

(defun get-objects-from-state (state)
	(get-objects-from-state-helper (state-atoms state) nil))

(defun get-objects-from-state-helper (atoms objects)
	(if (null atoms)
		(remove-duplicates objects :test #'equal)
		(let ((a (car atoms)))
			(cond
				((not (listp a)) (get-objects-from-state-helper (cdr atoms) objects))
				((eq (car a) 'not) (get-objects-from-state-helper (cons (cdr a) atoms) objects))
				((= (length a) 1) (get-objects-from-state-helper (cdr atoms) objects))
				(t (get-objects-from-state-helper (cdr atoms) (append objects (cdr a))))))))

(defun state-objects (current-state)
	(let ((atoms (state-atoms current-state))
				(objects nil))
;		(format t "atoms : ~A ~%" atoms)
		(dolist (x atoms)
			(setf objects (append objects (cdr x))))
		(remove-duplicates objects :test #'equal)))









