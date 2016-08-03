;; This file describes the GDP package, in which all of GDP's pre-process and search functionality and other auxiliary scripts and utilities are defined. 

(defpackage :gdp
  (:use :common-lisp :shop2)
  (:export #:write-problem-as-pddl
	   #:invoke-classical-planner
	   #:domain-name-string
	   #:process-ff-output

	   ;; from gdp-decls
	   #:task-node
	   #:method-value
	   #:option-value

	   ;; from gdp-funcs
	   #:goal-decomposition-planner
	   #:*hgn-output*

	   ;; from gdp-search
	   #:decompose-task-using-method-list
	   #:decompose-task-using-action
	   #:decompose-task-using-method
	   #:achieve-subtasks
	   #:achieve-subtasks-given-toptask-options

	   ;; from gdp-test
	   #:*planning-graph*
	   #:state-changed-p*
	   #:*infinity*

	   ;; from gdp-utils
	   #:bindings-of-operator-achieving-goal
	   #:bindings-of-gdr-achieving-goal
	   #:order-methods
	   #:order-actions
	   #:order-options
	   #:option-list-for-task
	   #:gdr-head
	   #:gdr-goal
	   #:gdr-preconditions
	   #:gdr-subgoals
	   #:make-gdr
	   #:print-contents-from-child-list
	   #:goals-from-task
	   #:goals-from-task-node
	   #:copy-task-node
	   #:get-task-list-from-goal-list
	   #:pretty-print-task-list
	   #:get-method-object-from-head
	   #:primitive-op-p
	   #:action?
	   #:goals-in-add-effects
	   #:goal-predicate-in-add-effects
	   #:apply-plan-to-state
	   #:apply-action-to-state
	   #:get-objects-from-state
	   #:get-objects-from-state-helper
	   #:state-objects

	   ;; from utils
	   #:subset
	   #:randomize-list
	   #:remove-nth
	   #:remove-nth-helper

	   ;; from ff-heuristic
	   #:pg-node
	   #:pg
	   #:planning-graph-modify
	   #:planning-graph-rp-heuristic-optimized
	   #:planning-graph-expand
	   #:planning-graph-init
	   #:planning-graph-print
	   #:applicable-actions
	   #:planning-graph-extract	
	   #:planning-graph-extract-helper
	   #:max-level-among-prop-nodes
	   #:min-level-among-action-nodes
	   #:planning-graph-level-ff
	   #:planning-graph-level
	   #:planning-graph-rp-heuristic
	   #:extract-relaxed-plan
	   #:generate-formula-vector
	   #:extract-relaxed-plan-helper
	   #:ff-difficulty-heuristic
	   #:action-preconditions
	   #:action-add-effects
	   #:action-operator
	   #:method-object-from-head
	   #:method-subgoals
	   #:def-operator-type
	   #:build-action-preconditions
	   #:tonc
	   #:tconc-add
	   #:tconc-add-list
	   #:tconc-pop
	   #:tconc-list))