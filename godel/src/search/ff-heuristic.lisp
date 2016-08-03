;;;; This file contains the implementation of the FF heuristic as used in Hoffman's FF planner.

(in-package :gdp)

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

;; ----------- THIS is the modified planning graph generation algorithm----------------
;;
;; This takes as input the current planning graph, the new state (to which you wish to change 
;; the planning graph's source state to) and the list of goals. The algorithm starts by setting 
;; levels of all literals in the new-state to 0 and all other elements to \inf and then iterate
;; through the graph, recalculating the levels of the nodes currently set to \inf. At the end of this
;; operation, if the goals are unreachable, then we expand the planning graph until the goals 
;; are re-achieved.
(defun planning-graph-modify (old-pg new-state goals)
					;  (format t "at start of pgm, goals : ~A ~%" goals)
					;  (format t "pass~%")
  (let ((pg-state (pg-state old-pg))
        (pg-atoms (pg-atoms-hash-table old-pg))
        (pg-actions (pg-actions-hash-table old-pg))
        (open-list (make-tconc)))

    ;; Initialize open-list first
    (tconc-add-list open-list (state-atoms new-state))

					;    (format t "open-list in the beginning is ~A ~%" (tconc-list open-list))

    ;; Firstly, set levels of all literals to infinity
    (maphash (lambda (key value)
               (setf (pg-node-level value) *infinity*))
             pg-atoms)

    ;; Now, do the same for all actions in the planning graph
    (maphash (lambda (key value)
               (setf (pg-node-level value) *infinity*))
             pg-actions)


    ;; Now, set levels of literals in the new-state to 0
    (dolist (x (tconc-list open-list))
      (if (gethash x pg-atoms)
	  (setf (pg-node-level (gethash x pg-atoms)) 0)
	  (progn
	    (planning-graph-print old-pg)
	    (error "~A not in the planning graph, state ~A ~% PLANNING GRAPH : ~%" x (state-atoms new-state)))))

					;    (planning-graph-print old-pg)

    ;; open-list now contains all literals asserted in level 0. Start re-numbering levels of 
    ;; the planning graph starting from here
    (loop
					;      (format t "open-list at this point is ~A ~%" (tconc-list open-list))
       (let ((x (tconc-pop open-list)))
	 (if (or (null x) (null goals))
	     (return)
	     ;; current-vertex is a valid pg node, examine its children
	     (if (not (action? x))
		 (let* ((x-node (gethash x pg-atoms))
			(x-actions (pg-node-child-list x-node)))
		   (dolist (a x-actions)
		     (let* ((a-node (gethash a pg-actions))
			    (current-a-level (pg-node-level a-node))
			    (new-a-level (max-level-among-prop-nodes old-pg (pg-node-parent-list a-node))))
					;                  (format t "level of ~A is ~A, pre : ~A~%" a (+ 1 new-a-level) (pg-node-parent-list a-node))
		       (if (> current-a-level (+ 1 new-a-level))
			   (progn
			     (setf (pg-node-level a-node) (+ 1 new-a-level))
			     (tconc-add open-list a))))))
		 ;; x is an action if it comes here
		 (let* ((x-node (gethash x pg-actions))
			(x-effects (pg-node-child-list x-node)))
		   ;; for each effect p of x, update level and 
		   ;; add to open-list if level changes
		   (dolist (p x-effects)
		     (let* ((p-node (gethash p pg-atoms))
			    (current-p-level (pg-node-level p-node))
			    (new-p-level (min-level-among-action-nodes old-pg (pg-node-parent-list p-node))))
					;                  (format t "level of ~A is ~A~%" p new-p-level)
		       (if (> current-p-level new-p-level)
			   (progn
			     (setf (pg-node-level p-node) new-p-level)
			     (tconc-add open-list p)
			     (setf goals (set-difference goals (list p)))))))))))))
  old-pg)

;; Relaxed version of the FF heuristic
(defun planning-graph-rp-heuristic-simple (new-pg new-state goals)
  (if (null new-pg)
      (setf new-pg (planning-graph-init new-state)))
  (if (= (max-level-among-prop-nodes new-pg goals) *infinity*)
      (let ((fixpoint-reached-p nil))
	(loop while (not fixpoint-reached-p) do
	     (if (< (max-level-among-prop-nodes new-pg goals) *infinity*)
		 (progn
					;                (format t "got goals ... max level : ~A, goals: ~A ~%" (max-level-among-prop-nodes new-pg goals) goals)
		   (setf output (max (- (max-level-among-prop-nodes new-pg goals) 
					(max-level-among-prop-nodes new-pg (state-atoms new-state)))
				     0))
		   (return))
					;                  (planning-graph-print new-pg)
					;                  (let ((relaxed-plan (extract-relaxed-plan new-pg goals)))
					;                   (length relaxed-plan)))
		 (multiple-value-bind (temp-pg temp-fixpoint-reached-p) (planning-graph-expand-optimized new-pg)
		   (setf new-pg temp-pg)
		   (setf fixpoint-reached-p temp-fixpoint-reached-p)
		   (if fixpoint-reached-p
		       (progn
			 (setf output 'INFINITY)
			 (return)))))))
      (setf output (max (- (max-level-among-prop-nodes new-pg goals) 
			   (max-level-among-prop-nodes new-pg (state-atoms new-state)))
			0)))
  (setf *planning-graph* new-pg)
  output)

;; This function now uses the above defined function planning-graph-modify. It takes as input 
;; the new state, the goals and a predicate state-changed-p that is true when
;; the state has changed (implying that you need to recalculate the planning graph). The function 
;; returns length of the relaxed plan ('INFINITY if goals are unreachable)
(defun planning-graph-rp-heuristic-optimized (new-pg new-state goals state-changed-p)
					;  (format t "state is ~A ~%" (state-atoms new-state))
					; (format t "goals at start of heuristic function are ~A ~A ~%" goals new-pg)
  (if (and new-pg state-changed-p)
      (progn
					;      (format t "about to start modifying ... ~%")
					;      (planning-graph-print new-pg)
	(setf new-pg (planning-graph-modify new-pg new-state goals))
					;      (format t "finished modifying ... ~%")
					;      (planning-graph-print new-pg)
	))
  ;; At this point, the planning graph matches the one for the current state, loop either 
  ;; until goals are achieved in the pg or fixpoint is reached
  (progn
					;    (format t "expansion phase ... goals are ~A ~%" goals)
    (if (null new-pg)
	(setf new-pg (planning-graph-init new-state)))
    (let ((fixpoint-reached-p nil)
          (output nil))
      (loop while (not fixpoint-reached-p) do
	   (if (< (max-level-among-prop-nodes new-pg goals) *infinity*)
	       (progn
					;                (format t "got goals ... max level : ~A, goals: ~A ~%" (max-level-among-prop-nodes new-pg goals) goals)
		 (setf output (max-level-among-prop-nodes new-pg goals))
		 (return))
					;                  (planning-graph-print new-pg)
					;                  (let ((relaxed-plan (extract-relaxed-plan new-pg goals)))
					;                   (length relaxed-plan)))
	       (multiple-value-bind (temp-pg temp-fixpoint-reached-p) (planning-graph-expand-optimized new-pg)
		 (setf new-pg temp-pg)
		 (setf fixpoint-reached-p temp-fixpoint-reached-p)
		 (if fixpoint-reached-p
		     (progn
		       (setf output 'INFINITY)
		       (return))))))
      (setf *planning-graph* new-pg)
      output)))

;; The function used to expand the planning graph by one level
(defun planning-graph-expand-optimized (graph)
					;  (format t 
					;  (planning-graph-print graph)
  (let* ((pg-state (pg-state graph))
	 (pg-atoms (pg-atoms-hash-table graph))
	 (pg-actions (pg-actions-hash-table graph))
	 (new-actions (applicable-actions-optimized graph pg-state)))
					;		(format t "appicable-actions took ~A seconds ~%" (/ (float (- (get-internal-run-time) aa-time)) internal-time-units-per-second))
    ;; prunes out actions already present in graph
					;		(setf new-actions (remove-if 
					;												(lambda (x)
					;													(gethash x pg-actions))
					;												new-actions))

					;    (planning-graph-print graph)
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
		   (action-node (make-pg-node :contents a :parent-list a-pre :child-list a-add :level new-level)))
					;						(format t "for action ~A, new-level is ~A ~%" a new-level)
	      (setf (gethash a pg-actions) action-node)

	      ;; add a as a child node to all propositions in a-pre
	      (dolist (x a-pre)
		(let* ((x-node (gethash x pg-atoms))
		       (x-children (pg-node-child-list x-node)))
		  (setf (pg-node-child-list x-node) (cons a x-children))))

	      ;; add all propositions of a-add to pg-atoms and set parent list to (a)
	      (dolist (y a-add)
		(let ((y-value (gethash y pg-atoms)))
		  (if (not y-value)
		      (progn
			(add-atom-to-state y pg-state 0 a)
			(setf (gethash y pg-atoms) (make-pg-node :contents y 
								 :parent-list (list a) 
								 :child-list nil 
								 :level new-level)))
		      (let ((current-parents (pg-node-parent-list y-value)))
			(setf (pg-node-parent-list y-value) (union (list a) current-parents :test #'equal))
			(setf (pg-node-level y-value) (min new-level (pg-node-level y-value)))
					;                    (format t "parent-list is ~A ~%" (pg-node-parent-list y-value))
			))))))

	  (values graph nil)))))

;; Function to calculate actions applicable to the reachable part of the planning graph
(defun applicable-actions-optimized (pg state)
  (let ((actions nil)
	(operators (domain-operators *domain*))
        (pg-atoms (pg-atoms-hash-table pg)))
    (maphash 
     (lambda (op-name op-obj)
       (let* ((op-pre (operator-preconditions op-obj))
	      (op-head (operator-head op-obj))
	      (op-add (operator-additions op-obj))
	      (op-bindings (find-satisfiers op-pre state)))
	 (loop for x in op-bindings do
	      (if (and (= (max-level-among-prop-nodes pg (apply-substitution op-add x)) *infinity*)
		       (< (max-level-among-prop-nodes pg (apply-substitution op-pre x)) *infinity*))
		  (setf actions (cons (apply-substitution op-head x) actions))))))
     operators)
    actions))











;; ------------ END OPTIMIZATION ------------------------------------------------------

;;; one-level expansion of planning graph
(defun planning-graph-expand (graph)
					;  (planning-graph-print graph)
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

	      ;; --- removed because we are trying to add back-links from atoms to ALL actions that
	      ;; --- produced that atom, not just the first one

					;						(setf a-add (remove-if 
					;													(lambda (x) (gethash x pg-atoms))
					;													a-add))

	      (dolist (y a-add)
		(let ((y-value (gethash y pg-atoms)))
		  (if (not y-value)
		      (progn
			(add-atom-to-state y pg-state 0 a)
			(setf (gethash y pg-atoms) (make-pg-node :contents y 
								 :parent-list (list a) 
								 :child-list nil 
								 :level new-level)))
		      (let ((current-parents (pg-node-parent-list y-value)))
			(setf (pg-node-parent-list y-value) (cons a current-parents))
					;                    (format t "parent-list is ~A ~%" (pg-node-parent-list y-value))
			))))))

	  (values graph nil)))))

;;; initialize planning graph given the initial state. 
;;; MAKES A NEW COPY OF STATE. The state object in the planning graph is
;;; a copy of the state passed into it since all subsequent expansions
;;; destructively modify state
(defun planning-graph-init (state)
  (let* ((atoms (state-atoms state))
	 (graph (make-pg :state (shop2::make-initial-state *domain* *state-encoding* atoms)))
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
	     (format t "---- parent of ~A is ~A, level is ~A ~%" key (pg-node-parent-list value) (pg-node-level value)))
	   (pg-atoms-hash-table graph))
  (format t "-- actions hash table : (count : ~A) ~%" (hash-table-count (pg-actions-hash-table graph)))
  (maphash (lambda (key value)
	     (format t "---- parent of ~A is ~A, level is ~A ~%" key (pg-node-parent-list value) (pg-node-level value)))
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
					;						(planning-graph-print graph)
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
      (let ((p-node (gethash p (pg-atoms-hash-table graph))))
        (if (null p-node)
	    (setf max-level *infinity*)
	    (let ((p-level (pg-node-level p-node)))
	      (if (> p-level max-level)
		  (setf max-level p-level))))))
    max-level))

;;; min of the levels of all the action nodes
(defun min-level-among-action-nodes (graph action-nodes)
					;	(format t "action nodes are ~A ~%" action-nodes)
  (let ((min-level *infinity*))
    (dolist (a action-nodes)
      (let ((a-node (gethash a (pg-actions-hash-table graph))))
        (if (not (null a-node))
	    (let ((a-level (pg-node-level a-node)))
	      (if (< a-level min-level)
		  (setf min-level a-level))))))
    min-level))


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
					;  (format t "~A is the formula ~%" formula)
  (let ((graph-state (pg-state graph))
	(graph-atoms (pg-atoms-hash-table graph))
	(graph-actions (pg-actions-hash-table graph)))
					;		(format t "state-atoms are : ~A, subset : ~A ~%" graph-state (subset formula graph-state)) 
    (if (subset formula graph-state)
	(progn
	  (planning-graph-print graph)
	  (max-level-among-prop-nodes graph formula))
	(multiple-value-bind (graph fixpoint-reached) (planning-graph-expand graph)
	  (if fixpoint-reached
	      (progn
					;						(format t "formula is ~A, graph-atoms is ~A ~%" formula graph-atoms)
		'INFINITY)
	      (planning-graph-level graph formula))))))

;;; extract the length of relaxed plan from the first level 
;;; where the given propositional formula is satisfied, return 'INFINITY if fixpoint reached
(defun planning-graph-rp-heuristic (graph formula)
					;  (format t "~A is the formula ~%" formula)
  (let ((graph-state (pg-state graph))
	(graph-atoms (pg-atoms-hash-table graph))
	(graph-actions (pg-actions-hash-table graph)))
					;		(format t "state-atoms are : ~A, subset : ~A ~%" graph-state (subset formula graph-state)) 
    (if (subset formula graph-state)
	(let ((relaxed-plan (extract-relaxed-plan graph formula)))
					;        (format t "relaxed plan is ~A ~%" relaxed-plan)
					;        (planning-graph-print graph)
	  (length relaxed-plan))
	(multiple-value-bind (graph fixpoint-reached) (planning-graph-expand graph)
	  (if fixpoint-reached
	      (progn
					;						(format t "formula is ~A, graph-atoms is ~A ~%" formula graph-atoms)
		'INFINITY)
	      (planning-graph-rp-heuristic graph formula))))))

;;; Relaxed plan extraction wrapper
(defun extract-relaxed-plan (graph formula)
  (let ((formula-vector (generate-formula-vector graph formula)))
    (extract-relaxed-plan-helper graph formula-vector (- (length formula-vector) 1) nil)))


;;; Get back a vector of formula arranged by their levels in the planning graph
(defun generate-formula-vector (graph formula)
  (let* ((max-level (max-level-among-prop-nodes graph formula))
         (formula-vector (make-array (+ 1 max-level))))
					;    (format t "max-level is ~A ~%" max-level)
    (dolist (f formula)
      (let ((f-level (pg-node-level (gethash f (pg-atoms-hash-table graph)))))
        (setf (aref formula-vector f-level) (cons f (aref formula-vector f-level)))))
    formula-vector))


;;; Extract relaxed plan from graph
(defun extract-relaxed-plan-helper (graph formula-vector max-level plan)
					;  (format t "formula : ~A, max-level : ~A, plan : ~A ~%" formula-vector max-level plan)
  (if (= max-level 0)
      plan
      (if (null (aref formula-vector max-level))
	  (extract-relaxed-plan-helper graph formula-vector (- max-level 1) plan)
	  (let* ((max-level-goal-list (aref formula-vector max-level))
		 (first-goal (car max-level-goal-list))
		 (goal-node (gethash first-goal (pg-atoms-hash-table graph)))
 		 (action-list (pg-node-parent-list goal-node)))
					;        (setf (aref formula-vector max-level) (cdr (aref formula-vector max-level)))
	    (let* ((current-best-action (first action-list))
		   (current-best-value (ff-difficulty-heuristic graph current-best-action)))
	      (dolist (x (cdr action-list))
		(let ((x-value (ff-difficulty-heuristic graph x)))
		  (if (< x-value current-best-value)
		      (setf current-best-action x))))

	      ;; at this point, current-best-action is the best action to achieve first-goal.
	      ;; apply it, remove all add effects from level 'max-level',
	      ;; and add preconditions of current-best-action to level (max-level-1). 
	      (let* ((best-action-add (action-add-effects current-best-action))
		     (best-action-pre (action-preconditions current-best-action)))
		(setf (aref formula-vector max-level) (set-difference max-level-goal-list
								      best-action-add
								      :test #'equal))
		(dolist (p best-action-pre)
		  (let ((p-level (pg-node-level (gethash p (pg-atoms-hash-table graph)))))
		    (setf (aref formula-vector p-level) (union (aref formula-vector p-level)
							       (list p)
							       :test #'equal))))
		(extract-relaxed-plan-helper graph 
					     formula-vector
					     max-level
					     (cons current-best-action plan))))))))

(defun ff-difficulty-heuristic (graph action)
  (let ((pre (action-preconditions action))
        (atoms (pg-atoms-hash-table graph))
        (value 0))
    (dolist (p pre)
      (setf value (+ value (pg-node-level (gethash p atoms)))))
    value))

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


;; ----- TAIL-CONCATENATE FUNCTION
(defstruct tconc
  (head nil)
  (tail nil))

(defun tconc-add (l x)
  ;; l is a tconc structure and x is the element to add at the end
  (if (not (tconc-tail l))
      (progn
	(setf (tconc-head l) (list x))
	(setf (tconc-tail l) (tconc-head l)))
      ;; If its not the first element of the list ...
      (progn
	(setf (cdr (tconc-tail l)) (list x))
	(setf (tconc-tail l) (cdr (tconc-tail l))))))

(defun tconc-add-list (l l-new)
  (if (not (tconc-tail l))
      (progn
	(setf (tconc-head l) l-new)
	(setf (tconc-tail l) (last l-new)))
      ;; If its not the first element of the list ...
      (progn
	(setf (cdr (tconc-tail l)) l-new)
	(setf (tconc-tail l) (last l-new)))))

(defun tconc-pop (l)
  (if (null (tconc-head l))
      nil
      (let ((top-element (car (tconc-head l))))
	(if (= (length (tconc-head l)) 1)
	    (progn
	      (setf (tconc-head l) nil)
	      (setf (tconc-tail l) nil))
	    (setf (tconc-head l) (cdr (tconc-head l))))
	top-element)))


(defun tconc-list (l)
  (tconc-head l))











