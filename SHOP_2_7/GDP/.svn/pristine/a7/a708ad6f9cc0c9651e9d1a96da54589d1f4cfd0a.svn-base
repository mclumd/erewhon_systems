(in-package :gdp)

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
  ;  (pretty-print-task-list task-list) 
  ; (format t "~%~%entered achieve subtasks with tasklist = ~A ~%~%" task-list)

  ;	(format t "goal history is ~A ~%" goal-history)
  (if (null task-list)
    (values nil nil)
    (let ((toptask (first task-list)))
      ;			(format t "reached here ... state : ~A ~%" ;(goals-from-task-node toptask) 
      ;              (state-atoms current-state))
      ;     (pretty-print-task-list task-list)
      (if (subset (goals-from-task-node toptask) current-state)
        (progn
          ;				  (format t "goal ~A already asserted in current state ~%" (goals-from-task-node toptask))
          (setf (task-node-child-list toptask) (list '(!!INOP)))
          (achieve-subtasks current-state (cdr task-list) goal-history))
        (if (member (goals-from-task-node toptask) goal-history :test #'equal)
          ;; if current goal trying to achieve is present in goal history, then return FAIL
          ;; since no good can come out of trying to decompose the parent goal in this way
          (values 'FAIL nil)

          ;; If we get here, clear that there exists a goal currently not asserted in current-state
          (let ((toptask-options (option-list-for-task toptask current-state)))
            ;						(format t "toptask is ~A ~%" toptask)
            ;						(format t "toptask options are ~A ~%" toptask-options)
            ;						(format t "toptask options are ~A ~%" (length toptask-options))
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
  ;	(format t "state : ~A ~% " (state-atoms current-state))
  ;  (format t "task list : ")
  ;  (pretty-print-task-list task-list)
  ;  (format t "~%top-task options are : ~A ~%~%" toptask-options)
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
          (state-copy (shop2.common:make-initial-state *domain* 
                                          *state-encoding* 
                                          (state-atoms current-state))))
      ;			(format t "state copy took ~A ~%" (/ (float (- (get-internal-run-time) sc-time)) internal-time-units-per-second)) 
      ;; if option is an action, apply action and solve for the rest of the goals
      ;; recursively
      ;			(format t "current goal is ~A, option used is ~A ~%" (goals-from-task-node task) option)

      (if (primitive-op-p option)
        (progn
          (decompose-task-using-action task option current-state)
          ;          (format t "action applied is ~A~%" option)
          (setf *state-changed-p* t)

          ;          (format t "applied action ~A ~%" option)
          ;					(format t "task after decomposing with action ~A is ~A ~%" option task)
          ;					(format t "about to start recursing ... ~%")
          (multiple-value-bind (tree plan) (achieve-subtasks (apply-action-to-state current-state option) 
                                                             task-list 
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
                 (all-goals ;(if (equal (second (task-node-contents task)) (list method-goal))
                   subgoals)
                 ; (append subgoals (list method-goal))))
                 (subtask-list (get-task-list-from-goal-list all-goals task))
                 (first-subgoal (first subgoals)))

            ;            (format t "all-goals is ~A ~%" all-goals)

            (setf *state-changed-p* nil)

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
                                                                   (append subtask-list task-list)
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
