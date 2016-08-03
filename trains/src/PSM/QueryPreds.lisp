(in-package "PSM")

;;    This handles all queries that are directly answered from the Task Tree. Generally, these
;;    are queries that explore the structure of the plans.


(defun handle-PS-level-query (op prop vars-of-interest plan ps-state Retrieval-fn)
  (let* ((predname (car prop))
	 (plan-nodes (task-tree-leaf-cache ps-state))
	 (ST (task-tree-symbol-table ps-state))
	 (plan-tuples  (mapcar #'(lambda (n)
			     (apply retrieval-fn (list (get-node-by-name n ST))))
			       plan-nodes))
	 ;;  handle those predicates that also may apply to solution sets
	 (tuples (if (member predname '(:actions :cost :duration :distance))
		     (append plan-tuples 
			     (mapcar #'(lambda (ss)
					 (Get-ss-info predname ss))
				     (find-st-values-by-type :solution-set)))
		   plan-tuples)))
	       
    (prepare-answer-from-tuples
     op 
     prop 
     vars-of-interest
     tuples
     )))

;;============
;;
;;  DEFINING THE PS-LEVEL PREDICATES
;;
;;  All we need to do is define a function that given a task-node, returns the instantiation
;;  of the arguments to the predicate for that node

;; (:GOAL ?goal ?plan)
(set-ps-level-predicate-names nil)

(add-ps-level-predicate :GOAL)

(defun handle-query-goal (node)
    (list (task-objective (task-node-content node))
          (task-node-name node)))

;;  (:AGENT ?agent ?plan)

(add-ps-level-predicate :AGENT)

(defun handle-query-agent (node)
  (let* ((content (task-node-content node))
         (soln (task-solution content)))
    (list (if (solution-set-p soln) 
            (solution-set-agents soln)
            (find-arg (task-objective content) :AGENT))
          (task-node-name node))))

;;  (:PARTICIPANT ?object ?plan)

(add-ps-level-predicate :PARTICIPANTS)

(defun handle-query-participants (node)
  (list (task-key-objects (task-node-content node))
        (task-node-name node)))


;;  (:ACTIONS ?list-of-acts ?plan)

(add-ps-level-predicate :ACTIONS)

(defun handle-query-actions (node)
  (let* ((content (task-node-content node))
         (soln (task-solution content)))
    (if (solution-set-p soln)
      (list (solution-set-decomposition soln)
            (task-node-name node)))))


;;  (:PS-STATUS ?status-flag ?plan)

(add-ps-level-predicate :PS-STATUS)

(defun handle-query-ps-status (node)
  (list (task-status (task-node-content node))
        (task-node-name node)))

;;  (:DS-STATUS ?status-flag ?plan)

(add-ps-level-predicate :DS-STATUS)

(defun handle-query-ds-status (node)
  (list (task-goal-Dstatus (task-node-content node))
        (task-node-name node)))



;;  (SUBPLANS ?list-of-plans ?plan)

(add-ps-level-predicate :SUBPLANS)

(defun handle-query-subplans (node)
  (list (task-node-decomposition node)
        (task-node-name node)))

;;  (DURATION ?time ?plan)

(add-ps-level-predicate :DURATION)

(defun handle-query-duration (node)
   (let* ((soln (task-solution
	       (task-node-content node)))
	  (info (if (solution-set-p soln) (solution-set-domain-info soln))))
     (when (route-soln-p info)
       (list (route-time-to-travel
	      (route-soln-current
	       info))
	   (task-node-name node)))))

;;  (COST ?v ?plan)

(add-ps-level-predicate :COST)

(defun handle-query-cost (node)
   (let* ((soln (task-solution
	       (task-node-content node)))
	  (info (if (solution-set-p soln) (solution-set-domain-info soln))))
     (when (route-soln-p info)
       (list (route-cost-fn
	    (route-soln-current
	     info))
        (task-node-name node)))))

;;  (DISTANCE ?v ?plan)

(add-ps-level-predicate :DISTANCE)

(defun handle-query-distance (node)
  (let* ((soln (task-solution
	       (task-node-content node)))
	 (info (if (solution-set-p soln) (solution-set-domain-info soln))))
    (when (route-soln-p info)
      (list (route-distance
	     (route-soln-current
	      info))
	    (task-node-name node)))))



;;  (SOLUTION-SET ?solution-set ?plan)


(add-ps-level-predicate :SOLUTION-SET)

(defun handle-query-solution-set (node)
  (let* ((content (task-node-content node))
         (soln (task-solution content)))
    (if (solution-set-p soln)
      (list (solution-set-name soln)
            (task-node-name node)))))


;;=========================================================================================

;;  QUERIES ABOUT SOLUTION SETS
;;   All predicates involving solution sets have the reference solution set as the first argument

(defun handle-SS-level-query (op prop vars-of-interest plan ps-state retrieval-fn)
  (let* ((ans (apply retrieval-fn (list (cdr prop)))))
    (if (eq (car ans) 'error)
	ans
      (prepare-answer-from-tuples op prop vars-of-interest ans))
    ))


;; GET-Ss-INFO
;;  This handles cost, distance and action queries that also apply to plans

(defun get-ss-info (op ss)
  (let* ((soln-info (route-soln-current (solution-set-domain-info ss))))
    (case op
      (:cost (list (route-cost-fn soln-info) (solution-set-name ss)))
      (:duration (list (route-time-to-travel soln-info) (solution-set-name ss)))
      (:actions (list (solution-set-decomposition ss) (solution-set-name ss)))
      (:distance (list (route-distance soln-info) (solution-set-name ss))))))

;;  (:SOLUTION-SET-BY-CONSTRAINTS ?ss ?objective)
;;  NB: Both args cannot be variables. If ?ss is a variable, a solution set is generated/

(add-ss-level-predicate :SOLUTION-SET-BY-CONSTRAINTS)

(defun handle-query-solution-set-by-constraints (args)
  (let* ((ss-id (car args))
	 (objective (second args)))
    (if (isvariable ss-id)
	;; solution set is a variable - we construct the set from the objective
	(if (isvariable objective)
	    nil ;; can't handle both being variables
	  (let* ((constraints (sort-constraints (get-constraints-from-act objective)))
		 (simplified-objective (cons (car objective) 
					     (cons (second objective) (append (constraints-general constraints)
										       (constraints-specific constraints)))))
		(ans (instantiate-action simplified-objective nil nil)))
	    (if (solution-set-p ans)
		(list
		 (list (declare-an-object (solution-set-name ans) :SOLUTION-SET ans)
		      objective)))))
	  ;; not a variable, look it up
	  (let ((soln-set (lookup-solution-set ss-id)))
	    (if (solution-set-p soln-set) 
		(list (list ss-id (solution-set-action-type soln-set)))
	      )))))

(add-ss-level-predicate :CURRENT-SOLUTION)

(defun handle-query-current-solution (args)
  (let* ((soln-set (lookup-solution-set (car args))))
    (if (solution-set-p soln-set)
	(list (list (car args) (solution-set-decomposition soln-set)))
      (mapcan #'(lambda (x)
		  (let ((soln-set (lookup-solution-set  x)))
		    (if (solution-set-p soln-set)
			(list (list x (solution-set-decomposition soln-set))))))
	      (find-st-objects-by-type :solution-set)))))


;;   SOLUTION SET FILTER

(add-ss-level-predicate :solution-set-filter)

(defun handle-query-solution-set-filter (args)
  (let* ((orig-soln-set (lookup-solution-set (car args)))
	 (filter (second args)))
    (if (solution-set-p orig-soln-set)
	(cond
	 ;; a valid filter => compute the new solution set
	 ((valid-filter-fn filter)
	  (list (list (car args) (second args) (filter-solution-set filter orig-soln-set))))
	 ;; a variable filter - retrieve the filter for the original solution set
	 ((isvariable filter)
	  (list (list (car args) (solution-set-filters orig-soln-set) (car args))))
	 (t
	    (make-error-msg (format nil "Invalid filter function: ~A" filter))))
      (make-error-msg (format nil "Original solution set must be defined: ~A" (car args))))))

;;  SOLUTION SET PREFERENCE

(add-ss-level-predicate :solution-set-preference)

(defun handle-query-solution-set-preference (args)
  (let* ((orig-soln-set (lookup-solution-set (car args)))
	 (preference-fn (second args)))
       (if (solution-set-p orig-soln-set)
	(if (valid-preference-fn preference-fn)
	    (list (list (car args) (second args) (sort-solution-set preference-fn orig-soln-set)))
	  (make-error-msg (format nil "Invalid filter function: ~A" preference-fn)))
     nil)))

(defun lookup-solution-set (name)
  "find a solution set - either in symbol table or as part of a plan"
  (if (symbolp name)
      (let ((soln-set (lookup-object name)))
	(or soln-set
	(let* ((nodes (task-tree-leaf-cache (current-pss)))
	       (st (task-tree-symbol-table (current-pss)))
	       (plan (find-if #'(lambda (n)
				  (let ((soln (task-solution (task-node-content n))))
				    (and (solution-set-p soln) (eq (solution-set-name soln) name))))
			      (mapcar #'(lambda (n) (get-node-by-name n st))
				      nodes))))
	  (if (task-node-p plan)
	      (task-solution (task-node-content plan))))))))
    
;;==========================================================================================
;; testing

(defun test-binary (rel)
  "Basic test of binary relations:
   Find a plan and retrieve the goal. The retreive the plan by the goal"
  (let* ((ans (handle-psm-query 'ask-one `(,rel ?x ?y) '(?y)))
	 (plan-id (car (find-arg (cdr ans) :RESULT)))
	 (goal (car (find-arg (cdr (handle-psm-query 'ask-one 
				      `(,rel ?x ,plan-id) '(?x))) :RESULT))))
    (handle-psm-query 'ask-all (list rel goal '?x) 
		      '(?x))
    (handle-psm-query 'ask-one `(,rel ?x ,plan-id) '(?x))
    
    (handle-psm-query 'ask-all `(,rel ?x ?y) '(?x ?y))))

(defun test-builtins nil
  (handle-psm-query 'ask-all '(:and (:agent ?agent ?plan) (:goal ?goal ?plan))
                    'all)
  (handle-psm-query 'ask-all '(:and (:agent ?agent ?plan) (:goal ?goal ?plan))
                    '(?agent ?goal))
  (handle-psm-query 'ask-one '(:and (:agent ?agent ?plan) (:goal ?goal ?plan))
                    '(?goal))
  (handle-psm-query 'ask-one '(:and (:agent ?agent ?plan) (:goal ?goal ?plan))
                    '(?agent ?goal))
)

(defun test-KB-level nil
  (handle-psm-assert '(:PROBLEM :WIND chicago 5))
  (handle-psm-assert '(:AND (:PROBLEM :ICE boston 4) (:AT-LOC ENG3 Chicago)))
  (handle-psm-assert '(:PROBLEM :WINF chicago ?x))
  (handle-psm-query 'ask-one '(:and (:problem :WIND ?city ?dur) (:at-loc ?eng ?city))
                    '(?eng))
  (handle-psm-query 'ask-all '(:at-loc ?eng Chicago)
                  '(?eng))
  )
