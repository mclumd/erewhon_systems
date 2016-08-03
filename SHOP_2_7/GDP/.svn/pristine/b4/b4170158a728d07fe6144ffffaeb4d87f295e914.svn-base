;;;; This file contains the implementation of the FF heuristic as used in Hoffman's FF planner.

(in-package :shop2)

;;; node of planning graph
(defstruct pg-node
	(contents nil)
	(parent-list nil)
	(child-list nil)
	(level 0))

;;; planning graph
(defstruct pg
	(atoms-hash-table (make-hash-table :test #'equal)) ; store pointers to vertices
	(actions-hash-table (make-hash-table :test #'equal)) ; pointers to edges
	(state nil)) ; state object, keeps track of all atoms in the graph

;;; one-level expansion of planning graph
(defun planning-graph-expand (graph)
	(let* ((pg-state (pg-state graph))
				 (pg-atoms (pg-atoms-hash-table graph))
				 (pg-actions (pg-actions-hash-table graph))
				 (aa-time (get-internal-run-time))
				 (new-actions (applicable-actions pg-state)))
;		(format t "appicable-actions took ~A seconds ~%" (/ (float (- (get-internal-run-time) aa-time)) internal-time-units-per-second))
		;; prunes out actions already present in graph
;		(setf new-actions (remove-if 
;												(lambda (x)
;													(gethash x pg-actions))
;												new-actions))

;		(format t "new actions are ~A ~%" new-actions)
		;; if no new actions are added, it means fixpoint has been reached.
		(if (null new-actions)
			(values graph t)
			(progn
				;; handles each action now ...
				(dolist (a new-actions)
					(let* ((a-pre (action-preconditions a))
								 (new-level (+ 1 (max-level-among-prop-nodes graph a-pre)))
								 (a-add (action-add-effects a))
								 (action-node (make-pg-node :contents a :parent-list a-pre :child-list nil :level new-level)))
;						(format t "for action ~A, new-level is ~A ~%" a new-level)
						(setf (gethash a pg-actions) action-node)
						(setf a-add (remove-if 
													(lambda (x) (gethash x pg-atoms))
													a-add))
						(dolist (y a-add)
							(add-atom-to-state y pg-state 0 a)
							(setf (gethash y pg-atoms) (make-pg-node :contents y 
																											 :parent-list (list a) 
																											 :child-list nil 
																											 :level new-level)))))

				(values graph nil)))))

;;; initialize planning graph given the initial state. 
;;; MAKES A NEW COPY OF STATE. The state object in the planning graph is
;;; a copy of the state passed into it since all subsequent expansions
;;; destructively modify state
(defun planning-graph-init (state)
	(let* ((atoms (state-atoms state))
				 (graph (make-pg :state (make-initial-state *domain* *state-encoding* atoms)))
				 (atoms-table (pg-atoms-hash-table graph)))
		(dolist (x atoms)
			(setf (gethash x atoms-table) (make-pg-node :contents x)))
		graph))

;;; print planning graph
(defun planning-graph-print (graph)
	(format t "planning graph : ~%")
	(format t "-- state atoms are : ~A ~%" (state-atoms (pg-state graph)))
	(format t "-- atoms hash table : (count : ~A) ~%" (hash-table-count (pg-atoms-hash-table graph)))
	(maphash (lambda (key value)
						 (format t "---- parent of ~A is ~A ~%" key (pg-node-parent-list value)))
					 (pg-atoms-hash-table graph))
	(format t "-- actions hash table : (count : ~A) ~%" (hash-table-count (pg-actions-hash-table graph)))
	(maphash (lambda (key value)
						 (format t "---- parent of ~A is ~A ~%" key (pg-node-parent-list value)))
					 (pg-actions-hash-table graph))
	(format t "end planning graph ~%"))

;;; returns actions applicable in the given state
(defun applicable-actions (state)
	(let ((actions nil)
				(operators (domain-operators *domain*)))
		(maphash 
			(lambda (op-name op-obj)
				(let* ((op-pre (operator-preconditions op-obj))
							 (op-head (operator-head op-obj))
							 (op-add (operator-additions op-obj))
							 (op-bindings (find-satisfiers op-pre state)))
					(loop for x in op-bindings do
								(if (not (subset (apply-substitution op-add x) state))
									(setf actions (cons (apply-substitution op-head x) actions))))))
			operators)
		actions))

;;; extracting relaxed plan from planning graph
(defun planning-graph-extract (graph goals)
	(remove-duplicates (planning-graph-extract-helper graph goals nil) :test #'equal))

;;; the main extraction function
(defun planning-graph-extract-helper (graph goals plan)
	(if (null goals)
			plan
			(let ((graph-state (pg-state graph))
						(graph-atoms (pg-atoms-hash-table graph))
						(graph-actions (pg-actions-hash-table graph))
						(current-goal (car goals)))
				(if (not (shop2.common::atom-in-state-p current-goal graph-state))
					(progn
						(planning-graph-print graph)
						(error "goals ~A not yet achieved in planning graph, can't extract!" goals))
					(let* ((g-node (gethash current-goal graph-atoms))
								 (g-parent (pg-node-parent-list g-node)))
						(if (null g-parent)
							(planning-graph-extract-helper graph (cdr goals) plan)
							(let* ((a-node (gethash (car g-parent) graph-actions))
										 (a-pre (pg-node-parent-list a-node)))
								(planning-graph-extract-helper graph (append (cdr goals) a-pre) (cons (car g-parent) plan)))))))))

;;; max of the levels of all the proposition nodes
(defun max-level-among-prop-nodes (graph prop-nodes)
;	(format t "prop nodes are ~A ~%" prop-nodes)
	(let ((max-level 0))
		(dolist (p prop-nodes)
			(let* ((p-node (gethash p (pg-atoms-hash-table graph)))
					   (p-level (pg-node-level p-node)))
				(if (> p-level max-level)
					(setf max-level p-level))))
		max-level))

(defun planning-graph-level-ff (current-state subgoals)
	(let ((relaxed-plan (invoke-classical-planner "route-finding" 
																								current-state
																								goal-list
																								*problem-objects*)))
		(if (eq relaxed-plan 'FAIL)
			'INFINITY
			(length (process-ff-output relaxed-plan)))))




;;; extract the first level at which the given propositional formula is satisfied
(defun planning-graph-level (graph formula)
	(let ((graph-state (pg-state graph))
				(graph-atoms (pg-atoms-hash-table graph))
				(graph-actions (pg-actions-hash-table graph)))
;		(format t "state-atoms are : ~A, subset : ~A ~%" graph-state (subset formula graph-state)) 
		(if (subset formula graph-state)
			(max-level-among-prop-nodes graph formula)
			(multiple-value-bind (graph fixpoint-reached) (planning-graph-expand graph)
				(if fixpoint-reached
					(progn
						(format t "formula is ~A, graph-atoms is ~A ~%" formula graph-atoms)
						'INFINITY)
					(planning-graph-level graph formula))))))


					

;;;; -------- ACTION UTILS -------------

(defun action-preconditions (action-head)
	(let* ((op (action-operator action-head))
				 (binding (unify (operator-head op) action-head)))
		(apply-substitution (operator-preconditions op) binding)))

(defun action-add-effects (action-head)
	(let* ((op (action-operator action-head))
				 (binding (unify (operator-head op) action-head)))
		(apply-substitution (operator-additions op) binding)))

(defun action-operator (action-head)
	(let* ((ops (domain-operators *domain*))
				 (name (first action-head))
				 (op (gethash name ops)))
		(if (null op)
			(error "in action-preconditions : No operator with the head of ~A ~%" action-head)
			op)))

(defun method-object-from-head (m-head)
	(let* ((methods (domain-methods *domain*))
				 (name (first m-head))
				 (m (gethash name methods)))
		(if (null m)
			(error "in method-object-from-head: No method with the name of ~A ~%" name)
			m)))

(defun method-subgoals (m-head)
	(let* ((m (method-object-from-head m-head))
				 (binding (unify (gdr-head m) m-head)))
		(apply-substitution (gdr-subgoals m) binding)))

(defun def-operator-type (list-of-op-types)
	(dolist (op-type list-of-op-types)
		(let ((op-name (first op-type))
					(op-signature (second op-type)))
			(setf (gethash op-name *op-types*) op-signature)
			(format t "type of ~A is ~A ~%" op-name (gethash op-name *op-types*)))))

(defun build-action-preconditions (initial-state)
	(let ((objects (get-objects-from-state initial-state)))
		(format t "objects in initial state are : ~A ~%" (length objects))))













