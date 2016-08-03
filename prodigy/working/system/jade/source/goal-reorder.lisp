(in-package "FRONT-END")


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; This file contains the code responsible for detecting dependencies in a 
;;; list of PRODIGY goals and reordering the goals so that supergoals precede 
;;; subgoals. This is done only if no cycle exists in the graph describing the 
;;; dependencies. A goal X depends on goal Y if X is a subgoal of Y. In such a 
;;; case, the dependency is represented as a directed edge between X and Y and 
;;; the goals are reordered after calculating the graph so that Y precedes X. 
;;; Therefore PRODIGY's goal trees will be maximally deep and minimal in 
;;; number.
;;;
;;; The graph representations used in this file are as follows:
;;;
;;; A graph consists of a list of vertices and a list of edges (both are 
;;; necessary in case some vertices have no edges.
;;;
;;; The edge-list is a graph representation consisting of a list of adjacency
;;; pairs such that for every edge between vertices x and y in the graph there 
;;; exists one sublist (x y) in the edge-list. 
;;;
;;; So the following graph   a
;;;                        / | \
;;;                       b  c  d
;;;                         / \ /
;;;                        e   f
;;;
;;; may take the form ((a b)(a c)(a d)(c e)(c f)(d f))
;;;
;;; Equivalent forms are possible because order is not significant in the list 
;;; although order is significant in the sublist pairs (i.e., the graph is 
;;; directed with an edge going from x to y in every edge (x y) ).
;;;
;;;
;;; Trees are either the empty tree, (), or of the form 
;;; tree :- (node tree*) where node is any arbitrary Lisp object.
;;;
;;; So the following tree    a
;;;                        / | \
;;;                       b  c  d
;;;                         / \ 
;;;                        e   f
;;;
;;; takes the form (a (b) (c (e)(f)) (d))
;;;
;;; Note that the first graph above is not a tree, although the tree above is a
;;; graph.
;;;



;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;
;;;; GLOBAL VARIABLES
;;;; AND PARAMETERS
;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;


;;;
;;; Initialized by function find-cycle.
;;;
(defvar *has-cycle* nil
  "Set to t if functions expand or find-adjacent-nodes detects a cycle.")



;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;
;;;;  UTILITIES
;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;

;;;
;;; Function remove-list-structure actually just removes the top list
;;; structure. Any subsequent nesting is retained.
;;;
(defun remove-list-structure (l)
;  (mapcan #'(lambda (x) x) l) 
  ;; Turns out that mapcan destructively screws up the edge-list.
  ;; So instead use the following recursive function.
  (cond ((null l) nil)
	(t (append 
	    (first l) 
	    (remove-list-structure 
	     (rest l)))))
  )



;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;
;;;;  GRAPH
;;;;  FUNCTIONS
;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;

;;;
;;; Function extract-points is given a graph represented by a list of vertices 
;;; and a list of edge, and it returns a list of vertices without edges either
;;; coming into or going out of it. This is computed by taking the difference
;;; between the list of vertices in the graph and the list of vertices in the 
;;; edge list (i.e., all points having edges). 
;;;
;;; The second list is calculated by simply removing the list structure of the
;;; edge list. That is, if the edge list is ((a b)(b c)), then the function 
;;; subtracts (a b b c) from the vertex-list. Redundant points in list do not 
;;; affect the value returned by the function set-difference.
;;;
(defun extract-points (vertex-list edge-list)
  "Return those points in the vertex-list having no adjacent vertex."
  (set-difference 
   vertex-list
   (remove-list-structure edge-list)
   :test
   #'equal)
  )


;;;
;;; Function remove-sink-edges returns the edge list with all edges whose 
;;; second vertex lacks any outgoing edges (i.e., all sink edges) removed.
;;; This is computed here by finding all sink nodes, then removing from the 
;;; list all edges which have those vertices as a second element (edges are
;;; tuples).
;;; 
(defun remove-sink-edges (edge-list 
			  &aux
			  (sink-nodes 
			   (compute-nodes edge-list :sink)))
  (remove-if 
   #'(lambda (each-edge)
       (member (second each-edge)
	       sink-nodes))
   edge-list)
  )



;;;
;;; Function compute-nodes finds either all sink nodes or all source nodes 
;;; contained in a given edge-list representation of a graph, depending on the 
;;; value of node-type (takes either the constant assignment :sink or :source).
;;;
(defun compute-nodes (edge-list node-type)
  "Return all sinks or sources in edge-list."
  (assert (member node-type '(:sink :source)) (node-type))
  (set-difference                               ; Represents all sink nodes.
   (remove-duplicates
    (remove-list-structure edge-list))          ; Represents all points.
   (mapcar #'(lambda (x)                        ; Represents all points with 
	       (case node-type                  ; outgoing or incoming edge
		     (:sink (first x))          ; depending on node-type.
		     (:source (second x))))
	   edge-list)  
   :test
   #'equal)
  )
  

;;;
;;; Do not forget to remove-duplicates before passing edge-list initially to 
;;; this function. 
;;;
(defun find-cycle (edge-list 
		   &optional 
		   (has-cycle (setf *has-cycle* nil)))
  (declare (special *has-cycle*))
  (cond ((null edge-list) 
	 *has-cycle*)
	((eq *has-cycle* t)
	 t)
	(t
	 (find-cycle (set-difference
		      edge-list
		      (print 
		       (convert-2-edges 
			(let ((source-node (a-source-node edge-list)))
			  (expand source-node
				  (move-source-edge-2-front 
				   source-node
				   edge-list)))))
		      :test
		      #'equal)
		     has-cycle)))
  )


;;;
;;; Predicate has-goal-dependency-cycles-p is simply the function find-cycle
;;; that is forced to return either t or nil , rather than non-nil or nil.
;;;
(defun has-goal-dependency-cycles-p (dependency-list)
  "Return t if cycle exists in dependency list."
  (if (find-cycle dependency-list)
      t
    nil)
  )



;;;
;;; Function move-source-edge-2-front finds a source edge given a source node, 
;;; and then moves the edge to the front of the edge-list. The resultant list 
;;; is returned.
;;;
(defun move-source-edge-2-front (source-node 
				 edge-list 
				 &aux 
				 (source-edge 
				  (find-edge-given-source 
				   source-node 
				   edge-list)))
  (cons source-edge 
	(remove source-edge 
		edge-list 
		:test #'equal))
  )


;;;
;;; Function find-edge-given-source searches edge-list for an edge (may be more
;;; than one) corresponding to the input source node. Because source nodes have 
;;; no incoming edges, the edge will be any one with source-node as the first 
;;; element.
;;;
(defun find-edge-given-source (source-node edge-list)
  (assoc source-node 
	 edge-list
	 :test #'equal)
  )


;;;
;;; Since compute-nodes returns all nodes of a given type (here of type 
;;; :source), function a-source-node returns just the first.
;;;
(defun a-source-node (edge-list)
  "Return a source node from the edge-list."
  (first 
   (compute-nodes edge-list 
		  :source))
  )



;;;
;;; Function convert-2-edges returns an edge-list representation for the 
;;; given tree.
;;;
;;; Given the tree (root (subtree) rest-of-tree), return the edge from root to 
;;; the root of subtree and concatenate that with the edges from the subtree 
;;; and the edges from the rest of the tree.
;;;
(defun convert-2-edges (tree)
  "Convert tree to edge-list representation."
  (cond ((eq (length tree) 1)
	 nil)
	(t
	 (cons 
	  (list (first tree) 
		(first (second tree)))
	  (append (convert-2-edges 
		   (second tree))
		  (convert-2-edges 
		   (cons (first tree)
			 (rest (rest tree))))))))
  )


;;;
;;; Function expand returns a tree representation of the paths in the edge-list
;;; to all nodes reachable from the parameter node. As an important side-effect,
;;; the function watches for cycles in the graph. If detected, the global 
;;; variable *has-cycle* is set to true.
;;;
;;; Assumes that node is the vertex at which the first edge starts in e-list.
;;;
;;; This function performs a depth-first search of the graph given node 
;;; argument.
;;;
(defun expand (node 
	       e-list 
	       &optional 
	       visited)
  (declare (special *has-cycle*))
  (if (member node visited :test #'equal)
      (setf *has-cycle* t)
    (cons node 
	  (expanded-children            ; Expand is recursively called in here.
	   (find-adjacent-nodes 
	    node 
	    e-list
	    visited)
	   e-list
	   (cons node visited))))
  )



;;; 
;;; Function expanded-children recursively expands the children of the root of
;;; a (sub)tree.
;;;
(defun expanded-children (children e-list visited)
  (cond ((null children)
	 nil)
	(t (cons 
	    (expand (first children) 
		    e-list 
		    visited)
	    (expanded-children (rest children) 
			       e-list 
			       visited))))
  )



(defun find-adjacent-nodes (node 
			    e-list 
			    visited 
			    &aux 
			    (match (assoc node e-list)))
  "Return a list of all nodes adjacent to node argument."
  (declare (special *has-cycle*))
  (cond ((null match)
	 nil)
	((member (second match) 
		 visited 
		 :test #'equal)
	 (setf *has-cycle* t)           ; Redundant I think.
	 nil)
	(t
	 (cons (second match) 
	       (find-adjacent-nodes 
		node 
		(remove match e-list 
			:test #'equal)
		(cons (second match) visited)))))
  )






;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;
;;;; PRODIGY-SPECIFIC 
;;;; FUNCTIONS
;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;


;;;
;;; Function collect-dependencies is initially passed a list of PRODIGY goals 
;;; as the value of end (thus front is nil). The function then traverses this 
;;; list, testing in turn whether each goal is a subgoal of any of the others. 
;;; A given goal, G1, is considered a subgoal of another goal, G2, if there 
;;; exists an operator that can achieve G2 and has G1 as a precondition. Each 
;;; goal that meets such a condition is collected into a list that is returned 
;;; as the value of the call of collect-dependencies.
;;;
(defun collect-dependencies (end &optional provide-feedback front)
  (cond ((null end) 
	 nil)
	(t 
	 (append 
	  (mapcan #'(lambda (goal) 
		      (let ((temp
			     (user::solves-precondition-of 
			      (first end) 
			      goal
			      provide-feedback)))
			(if temp (list temp))))
		  (append front (rest end)))
	  (collect-dependencies (rest end) 
		provide-feedback 
		(cons (first end) front)))))
  )



;;;
;;; The goals are order so that all with no dependency edges precede the rest. 
;;; Then all goals represented as sinks come next. This is accomplished by 
;;; removing all edges coming into all sinks and then recursively repeating the
;;; process.
;;;
(defun order-goals (goal-list edge-list)
  (cond ((null goal-list)
	 nil)
	(t
	 (let ((points-list 
		(extract-points goal-list 
				edge-list)))
	   (append 
	    points-list 
	    (order-goals 
	     (set-difference goal-list 
			     points-list
			     :test
			     #'equal)
	     (remove-sink-edges edge-list))))))
  )



;;;
;;  For testing ...
;;  (setf *x* '((a b)(c a)(d a)(e a)(a f)(c z)(z e)))
;;  (reorder-goals (remove-duplicates (remove-list-structure *z*)) *z*)
;;
;;;
(defun reorder-goals (&optional 
		      (goal-list
		       (get-current-goals))
		      (dependency-list 
		       (collect-dependencies
			goal-list)))
  (if (not 
       (has-goal-dependency-cycles-p 
	dependency-list))
      (reverse 
       (order-goals goal-list dependency-list))
    goal-list)
  )



;;;
;;; Function change-goals takes a problem (by default it is the current 
;;; problem) and returns the dependency list for that problem. Most
;;; importantly, however, as a side-effect, it reorders the goals of the 
;;; problem so that subgoals precede supergoals.
;;; 
(defun change-goals (&optional 
		     (problem (current-problem))
		     &aux 
		     (goal-list
		      (get-current-goals))
		     (dependency-list 
		      (collect-dependencies
		       goal-list)))
  (setf (p4::problem-goal problem)
	`(user::goal (and ,@(reorder-goals goal-list dependency-list))))
  dependency-list
  )



