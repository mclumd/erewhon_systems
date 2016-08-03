;;;
;;; This file implements routines for generating Abstraction
;;; Hierarchies, based on Craig Knoblock's thesis.
;;;
;;; File Created: 26/9/91
;;; Author: Jim Blythe

;;; Modified 2/3/92 to add a link between all corresponding
;;; subschema pairs when the link is there between
;;; schema pairs.

;;; Modified 3/3/92 so as not to include static predicates. The stuff
;;; that determines the abstraction level of a literal automatically
;;; gives a static predicate the highest possible level. This is as
;;; Craig states in his thesis.

#-clisp
(unless (find-package "PRODIGY4")
  (make-package "PRODIGY4" :nicknames '("P4") :use "LISP"))
(in-package "PRODIGY4")

(export '(*abstraction-chatty*))

;;; Knobs to twiddle
(defvar *abs-add-subtypes* t
  "Whether to add links between all subtypes of schemas
you add links for. Note that templates are only for the lowest level
of the hierarchy.")

(defparameter *doing-goal* nil "A hack")

(defvar *abstraction-chatty* nil
  "If non-nil, more stuff will be printed out when prodigy is creating
an abstraction hierarchy.")

;;;=====================
;;; Representation
;;;=====================

;;; Constraint graph representation: A graph is a list of these nodes.
;;; Representation may change when I have written the code and see
;;; what types of operations are most common.

;;; If the literal field has a non-nil value, then this abstraction
;;; node deals with a literal rather than a literal schema. If it is
;;; nil, then the node deals with a schema and the name and args
;;; fields will have values in either case (promise!). When you
;;; generate hierarchies, they are for literals unless the problem
;;; space property :schema-abstractions is set to a non-nil value.
;;; (This is the default.)

(defstruct (abs-node (:print-function print-abs-node))
  (literal nil)				; A literal (perhaps)
  (name nil)				; A literal predicate name
  (args nil)				; List of arguments (types)
  (out nil)				; List of nodes pointed to
  (in  nil)				; List of nodes that point to this one
  (dfnumber 0)				; For depth-first search
  (lowlink 0)				; ditto
  (marker nil)				; I treat this as reusable
  (type)                                ; binding, recursive, goal or plain.
  )

(defun print-abs-node (abs-node stream z)
  (declare (type abs-node abs-node)
	   (stream stream)
	   (ignore z))
  (princ "#<AbsNode: " stream)
  (print-short-abs-node abs-node stream nil)
  (princ ">" stream))

(defun print-short-abs-node (abs-node &optional (stream t) z)
  (declare (ignore z))
  (princ "[" stream)
  (princ (abs-node-name abs-node))
  (dolist (arg (abs-node-args abs-node))
    (princ #\Space stream) (princ arg stream))
  (princ "]" stream))

;;;===============================================
;;; The bit you will recognise from Craig's thesis.
;;;===============================================

;;; routine: create-hierarchy
;;; Arguments: pspace (problem space)
;;;            [optional] problem (problem)
;;;
;;; If the optional problem argument is specified, it creates a
;;; problem-dependant hierarchy, otherwise a problem-independent one.
;;; This is an implementation of the algorithm on page 69 of Craig's thesis.

;;; 23-Jan-92 Jim: added the check for infinite types to avoid the
;;; problem that you cannot currently get the exact type of an object
;;; that belongs to some infinite type by not doing abstraction when
;;; there are infinite types. See also template-abstraction-level.
;;; It should be possible to get the type, by restricting the
;;; predicates that take infinite types to give the types, or
;;; something like that.

(defun create-hierarchy (pspace &optional problem)
  (declare (type problem-space pspace))
  (unless (has-infinite-types-p pspace)
    (let* ((graph (find-constraints pspace problem))
	   (reduced 
	    (construct-reduced-graph
	     graph (find-strongly-connected-components graph))))

      (construct-abs-hierarchy (topological-sort reduced) pspace))))

;;; find-constraints
;;; Arguments: pspace (problem space)
;;;            [optional] problem (problem)
;;;
;;; If the optional problem argument is specified, it finds
;;; problem-dependant constraints, otherwise problem-independent ones.
;;; The constraints are in the form of a directed graph whose nodes
;;; are generalised literals - mentioning the types of the arguments.
;;; A directed edge in the graph from A to B means that A must be at
;;; least as high as B in any abstraction hierarchy.

(defun find-constraints (pspace &optional problem)
  (declare (type problem-space pspace))
  (let ((graph (create-empty-graph)))
    (cond ((and problem
		(getf (problem-space-plist pspace) :schema-abstractions))
	   (find-specific-schema-constraints
	    (explode-goals problem graph pspace t) pspace graph
	    (explode-operators graph pspace)))
	  (problem
	   (find-specific-literal-constraints
	    (explode-goals problem graph pspace nil) pspace graph))
	  (t
	   (find-independent-constraints graph pspace)))
    (cdr graph)))

;;; find-independent-constraints finds the constraints in a problem
;;; space independent of any problem. It is an implementation of the
;;; algorithm on page 67 of Craig's thesis.

(defun find-independent-constraints (graph pspace)
  (declare (type problem-space pspace))
  (dolist (operator (problem-space-operators pspace))
    (declare (type rule operator))
    ;; Make all literals in the effects be at the same level.
    (let ((effects-lits (explode-effects operator graph pspace))
	  (preconditions-lits (explode-preconditions operator graph pspace)))
      (dolist (elit1 effects-lits)
	(dolist (elit2 effects-lits)
	  (add-directed-edge elit1 elit2)
	  (add-directed-edge elit2 elit1))
	(dolist (plit preconditions-lits)
	  (add-directed-edge elit1 plit))))))

;;; Extracts the relevant literal schemas from the operator
;;; preconditions and effects. This means I only walk through the
;;; operator syntax once.
(defun explode-operators (graph pspace)
  (mapcan #'(lambda (op-group)
	      (mapcar #'(lambda (op)
			  (list op (explode-effects op graph pspace)
				(explode-preconditions op graph pspace)))
		      op-group))
	  (list (problem-space-operators pspace)
		(problem-space-lazy-inference-rules pspace)
		(problem-space-eager-inference-rules pspace))))


;;; find-specific-constraints finds the constraints in a problem space
;;; when a problem is also specified.  This version is meant to be
;;; more in line with Alpine as described in Craig's thesis.

(defun find-specific-schema-constraints (goals pspace graph op-list)
  (declare (type problem-space pspace)
	   (list op-list))
  (alpine-find-constraints goals goals pspace graph op-list)
  ;; The simplest way to make sure that static predicates are at the
  ;; top of the hierarchy, given that I add them to the graph at all,
  ;; is to add links here from static absnodes to all the others, even
  ;; though this is not the most efficient solution.
  (add-static-links graph))

(defun alpine-find-constraints (goals context pspace graph op-list)
  (dolist (goal goals)
    (unless (abs-node-marker goal)
      (setf (abs-node-marker goal) 'constraints-determined)
      (if *abstraction-chatty*
	  (format t "~%Working on ~S:" goal))
      (dolist (op op-list)
	(let ((op-effects (second op))
	      (op-preconds (third op)))
	  (when (primary-effect-p goal (car op) pspace (second op))
	    (if *abstraction-chatty*
		(format t "op ~S " (car op)))
	    (dolist (effect op-effects)
	      (add-directed-edge goal effect))
	    (let ((subgoals
		   ;; (subgoalable-preconds op goal op-preconds context)
		   ;; Although Craig's thesis says you shouldn't add
		   ;; links from effects to static preconditions, it
		   ;; seems to me that this is wrong, leading to
		   ;; hierarchies that don't have the ordered
		   ;; monotonicity property in ways that matter.
		   op-preconds))
	      (dolist (precond subgoals)
		(add-directed-edge goal precond))
	      (alpine-find-constraints
	       subgoals op-preconds pspace graph op-list))))))))

(defun find-specific-literal-constraints (goals pspace graph)
  (declare (type problem problem))
  (dolist (goal goals)
    (unless (abs-node-marker goal)
      (setf (abs-node-marker goal) 'constraints-determined)
      (dolist (op (problem-space-operators pspace))
	(dolist (unis (get-unifications goal op pspace))
	  (dolist (effect (propagate-effect-unifications unis op graph pspace))
	    (add-directed-edge goal effect))
	  (let ((preconds
		 (propagate-precond-unifications unis op graph pspace)))
	    (dolist (precond preconds)
	      (add-directed-edge goal precond))
	    (find-specific-literal-constraints preconds pspace graph)))))))

(defun add-static-links (graph)
  (dolist (absnode (cdr graph))
    (if (member (abs-node-name absnode)
		(problem-space-static-preds *current-problem-space*))
	(dolist (other (cdr graph))
	  (unless (or (eq other absnode)
		      (member absnode (abs-node-in other)))
	    (push absnode (abs-node-in other))
	    (push other (abs-node-out absnode)))))))
		      


;;;=============================================================
;;; Determining subgoalable preconditions and primary effects
;;;=============================================================

;;; These should be generated once for a domain and stored in a table,
;;; but here I'm only filtering out static predicates to begin with.
;;; Actually, there shouldn't be any such absnodes, but I'm paranoid
;;; about bugs coming in at this stage so I'm removing them here as
;;; well as trying not to generate them in the first place.

;;; This function should also say that a precondition can't be
;;; subgoaled on if it's also a precondition of the calling op, or if
;;; it's the negation of the goal to achieve, but I haven't done that
;;; yet.

(defun subgoalable-preconds (op goal preconds context)
  (declare (list op goal preconds context))
  ;; preconds is a list of absnodes.
  (let ((res nil)
	(statics (problem-space-static-preds *current-problem-space*)))
    (dolist (pre preconds)
      (unless (member (abs-node-name pre) statics)
	(push pre res)))
    res))

(defun primary-effect-p (absnode op pspace op-effects)
  (cond (;; If there are no primary effects, then everything is.
	 (or (null (getf (problem-space-plist pspace) :primary-effects))
	     (not (getf (problem-space-plist pspace) :use-primary-effects)))
	 (member absnode op-effects))
	(;; "done" is a primary effect of *finish*
	 (and (eq (abs-node-name absnode) 'done)
	      (eq (rule-name op) '*finish*))
	 t)
	(t
	 (member absnode (getf (rule-plist op) :primary-effects)
		 :test #'match-absnode-primary))))

;;; There's something very like this in get-all-ops.
(defun match-absnode-primary (absnode primary)
  (and (eq (abs-node-name absnode) (car primary))
       (= (length (abs-node-args absnode)) (length (cdr primary)))
       (every #'(lambda (a-arg e-arg)
		  (if (symbolp a-arg)
		      (if (symbolp e-arg)
			  (eq a-arg e-arg))))
	      (abs-node-args absnode) (cdr primary))))


;;;=============================================================
;;; Turning prodigy4 language constructs into abstraction nodes.
;;;=============================================================


;;; Note that this routine ignores literals in the conditions of
;;; conditional effects. Not sure if this is correct.
(defun explode-effects (operator graph pspace)
  (let ((declarations (list (second (operator-precond-exp operator))
			    (second (operator-effects operator))))
	(effects (cons :root nil)))
    (dolist (effect (third (operator-effects operator)))
      (if (member (first effect) '(user::add user::del))
	  (maybe-add-lit (second effect) declarations nil effects
			 graph pspace t)

	  ;; Otherwise it's a conditional or universal effect: proceed
	  ;; with the right hand side of the condition.

	  (dolist (subeffect (case (car effect)
			       (user::if (third effect))
			       (user::forall (fourth effect))))
	    (maybe-add-lit (second subeffect)
			   (if (eq (car effect) 'user::forall)
			       (cons (second effect) declarations)
			       declarations)
			   nil effects graph pspace t))))
    (cdr effects)))

(defun explode-preconditions (operator graph pspace)
  (declare (type rule operator)
	   (list graph))
  (let ((precond-expr (third (operator-precond-exp operator)))
	(declarations (list (second (operator-precond-exp operator))))
	(preconds (cons :root nil)))
    (if (eq (rule-name operator) '*finish*)
	(setf *doing-goal* t))
    (walk-through-expr
     ;; (augment-goal-expr precond-expr declarations)
     precond-expr
     declarations nil preconds graph pspace t)
    (setf *doing-goal* nil)
    (cdr preconds)))


;;; Changed 3/492 by Jim to include augmentation from axioms.
(defun explode-goals (problem graph pspace &optional schemap)
  (declare (type problem problem)
	   (type problem-space pspace))
  ;; If the operator *finish* exists, we assume things have been set
  ;; up as usual and return the goal "done" as the top level goal.
  ;; Otherwise get the goals from the problem structure.
  (setf *doing-goal* t)
  (let* ((finish-op (rule-name-to-rule '*finish* pspace))
	 (res
	  (if finish-op
	      (list (lit-to-schema '(done) nil nil graph pspace schemap))
	      (let* ((lits (cons :root nil))
		     (goal (problem-goal problem))
		     (goal-expr (if (eq (car goal) 'user::goal)
				    (third goal)
				    (second goal)))
		     (augmented-goal-expr (augment-goal-expr goal-expr))
		     (declarations (if (eq (car goal) 'user::goal)
				       (list (second goal)))))
		(walk-through-expr goal-expr declarations
				   (problem-objects problem) lits graph
				   pspace schemap)
		;; Make sure the constraints-determined field is off.
		(dolist (lit (cdr lits))
		  (setf (abs-node-marker lit) nil))
		(cdr lits)))))
    (setf *doing-goal* nil)
    res))


;;; This function recursively walks through a logical precondition
;;; expression, picking out the literals. The "lit" variable says
;;; whether to transform objects to types or not.
(defun walk-through-expr (expr declarations objects lits graph pspace schemap)
  (case (car expr)
    ((nil))
    ;; This isn't quite right, because it can't cope with this:
    ;; (and (exists ((<x> Y)) (p1 <x>)) (p2 <x>)), which I think is
    ;; (sadly) legal syntax.
    ((user::forall user::exists)
     (walk-through-expr (third expr) (cons (second expr) declarations)
			objects lits graph pspace schemap))
    ((user::and user::or)
     (dolist (subexpr (cdr expr))
       (walk-through-expr subexpr declarations objects
			  lits graph pspace schemap)))
    ((user::~)
     (walk-through-expr (second expr) declarations objects lits
			graph pspace schemap))
    (t
     (maybe-add-lit expr declarations objects lits graph pspace schemap))))

;;; Create the literal schema, add it to the list of lits unless
;;; it's already there.
(defun maybe-add-lit (lit declarations objects lits graph pspace
                          &optional schemap)
  (declare (special *abs-add-subtypes*) (list lit))
  (if *abs-add-subtypes*
      (setf (cdr lits) 
	    (nunion (lit-to-schema-and-subs lit declarations objects
					    graph pspace schemap)
		    (cdr lits)))
      (pushnew (lit-to-schema lit declarations objects graph pspace schemap)
	       (cdr lits))))

(defun lit-to-schema-and-subs (lit declarations objects graph pspace schemap)
  "Create all schemas that could match the type specification of the given expression"
  (declare (list lit))
  (let ((possargs (mapcar
                   #'(lambda (arg)
                       (let ((top (arg-to-type arg declarations objects
					       pspace schemap)))
                         (if (and (listp top) (eq (car top) 'user::or))
			     (apply #'nunion
				    (mapcar #'(lambda (typ)
						(lower-types
						 (type-name-to-type typ pspace)
						 pspace))
					    (cdr top)))
			     (lower-types 
			      (type-name-to-type top pspace) pspace))))
                   (cdr lit))))
    (if (every #'(lambda (list) (= (length list) 1)) possargs)
	(list (lit-to-schema lit declarations objects graph pspace schemap))
	(mapcar #'(lambda (argset)
		    (lit-to-schema-2 lit graph argset nil))
		(abs-cartesian-product possargs)))))


;;; This used to return all the lower types. But each literal should
;;; match the type it belongs to, so I'm changing this to return only
;;; the lowest sub-types.
(defun lower-types (top pspace)
  (declare (type type top)
	   (type problem-space pspace))
;;;  (cons top (mapcar #'type-name (all-subtypes top pspace)))
    (if (type-sub top)
	;; this assumes the type hierarchy is a tree.
	(mapcan #'(lambda (type)
		    (lower-types type pspace))
		(type-sub top))
	(list (type-name top))))

;;; Note that this implementation of cartesian product will make
;;; the different sets share their tails recursively. This is memory
;;; efficient but don't try to destructively modify any abs-node!!
(defun abs-cartesian-product (sets)
  (if sets
    (mapcan #'(lambda (one)
                (mapcar #'(lambda (oneres) (cons one oneres))
                        (abs-cartesian-product (cdr sets))))
            (car sets))
    (list nil)))
    
;;; lit-to-schema takes a literal from the operator and produces the
;;; right node of the abstraction constraint graph. This creates garbage.
(defun lit-to-schema (lit declarations objects graph pspace schemap)
  (declare (list lit))
  (let* ((schema-args
	  (mapcar #'(lambda (arg)
		      (arg-to-type arg declarations objects pspace schemap))
		  (cdr lit)))
	 (literal
	  (if (every #'prodigy-object-p schema-args)
	      (instantiate-literal (car lit) schema-args))))
    (lit-to-schema-2 lit graph schema-args literal)))

(defun lit-to-schema-2 (lit graph schema-args literal)
  (or (find-if #'(lambda (node)
		   (if literal
		       (eq (abs-node-literal node) literal)
		       (and (eq (abs-node-name node) (car lit))
			    (equal (abs-node-args node) schema-args))))
	       (cdr graph))
      (let ((new (make-abs-node :name (car lit) :args schema-args)))
	(if literal (setf (abs-node-literal new) literal))
	(cond (*doing-goal*
	       (setf (abs-node-type new) 'goal))
	      ((match-abs-primary new)
	       (if (plain-abs new)
		   (setf (abs-node-type new) 'plain)))
	      (t
	       (setf (abs-node-type new) 'binding)))
	(push new (cdr graph))
	new)))

(defun plain-abs (node)
  ;; This is where the quick fix comes in.
  (some #'(lambda (type) (match-abs-template type node))
	(problem-space-property :lit-types)))
  

(defun match-abs-primary (node)
  (declare (type abs-node node))
  (some #'(lambda (primary) (match-abs-template primary node))
	(problem-space-property :primary-effects)))

(defun match-abs-template (template node)
  (if (and (eq (caar template) (abs-node-name node))
	   (= (length (cdar template)) (length (abs-node-args node)))
	   (every #'(lambda (p-arg s-arg)
		      (and 
		       (if (symbolp p-arg) ; a type name
			   (eq s-arg p-arg)
			   ;; Otherwise p-arg is a list for an object
			   )))
		  (cdar template) (abs-node-args node) ))
      (cdr template)))

(defun var-type (arg declarations)
  ;; Here's a quick hack for those funny variable names of Craig's..
  (let* ((named-type (intern (argument-type (symbol-name arg) 0)))
	 (implicit-type (if (type-name-to-type named-type *current-problem-space*)
			    named-type)))
    (or implicit-type
	(some #'(lambda (decs)
		  (let ((type-spec (second (assoc arg decs))))
		    (if (listp type-spec) (second type-spec)
			type-spec)))
	      declarations))))

(defun arg-to-type (arg declarations objects pspace schemap)
  (declare (symbol arg)
	   (list declarations))
  ;; It's either a variable, a problem-specific object or a permanent
  ;; object. Should really do some error checking here..
  (cond ((strong-is-var-p arg)
	 (var-type arg declarations))
	((and (not schemap) (symbolp arg))
	 (object-name-to-object arg pspace))
	((symbolp arg)
	 (type-name (prodigy-object-type (object-name-to-object arg pspace))))
	((and (not schemap) (prodigy-object-p arg)) arg)
	((prodigy-object-p arg)
	 (type-name (prodigy-object-type arg)))
	;; This will fail if there is a problem-specific object with
	;; the same name as a type but not belonging to that type. But
	;; if the user does that, they deserve everything they get...
	((some #'(lambda (obj-list)
		   (if (member arg obj-list)
		       (car (last obj-list))))
	       objects))
	;; If it wasn't a variable or problem-specific object, assume
	;; it's a permanent object.
	(t
	 (type-name (prodigy-object-type (object-name-to-object arg pspace))))))

;;;==================================================
;;; General graph accessing and manipulation routines.
;;;===================================================

;;; create-empty-graph returns an empty graph. Since a graph is just a
;;; list, but I want to update it destructively, so the root is an
;;; empty cons cell..

(defun create-empty-graph () (cons :root nil))


;;; add-directed-edge takes two literal schemas and adds a directed
;;; edge between them, unless they are the same or the edge already
;;; exists. Returns t if it does anything, nil otherwise.
(defun add-directed-edge (node1 node2)
  (declare (type abs-node node1 node2))
  (unless (or (eq node1 node2)
	      (member node2 (abs-node-out node1)))
    (push node2 (abs-node-out node1))
    (push node1 (abs-node-in node2))
    t))


;;; finds the strongly connected components of the graph, using
;;; depth-first search. It is an implementation of Algorith 5.4 on
;;; page 193 of "The design and analysis of computer algorithms", Aho
;;; et al 1974.
#|
(defun find-strongly-connected-components (graph)
  (declare (list graph))

  ;; I'm re-using the marker field here for the depth-first search.
  (dolist (node graph)
    (setf (abs-node-marker node) 'new))
  (let ((*count* 1)
	(*stack* nil))
    (declare (special *count* *stack*))
    (do ((new-vertex
	  (find-if #'(lambda (n) (eq (abs-node-marker n) 'new))
		   graph)
	  (find-if #'(lambda (n) (eq (abs-node-marker n) 'new))
		   graph))
	 (components nil))
	((null new-vertex) components)
      (setf components (nconc (df-search new-vertex) components)))))
|#

;;; Just because I'm nervous, I'm going to do this again, using the
;;; algorithm from Aho et al 83, because I feel I understand the
;;; algorithm a little better if not the proof.
(defun find-strongly-connected-components (graph)
  (declare (list graph))

  ;; First, do a depth-first search following the abs-node-out link.
  ;; Number the nodes according to their outcome in this one.
  (dolist (node graph)
    (setf (abs-node-marker node) 'unvisited))
  (do ((newroot (find-if #'(lambda (n) (eq (abs-node-marker n) 'unvisited))
		   graph)
		(find-if #'(lambda (n) (eq (abs-node-marker n) 'unvisited))
		   graph))
       (number 1))
      ((null newroot) (return))
    (setf number (dfs1 newroot number)))

  ;; Now do another depth-first search, always picking the highest
  ;; numbered root possible.
  (dolist (node graph)
    (setf (abs-node-marker node) 'unvisited))
  (do ((new-root (find-max-root graph) (find-max-root graph))
       (clusters nil))
      ((null new-root) clusters)
    ;; This time save each cluster
    (push (dfs2 new-root) clusters)))

;;; The first search numbers the nodes in the order it bottoms out on them.
(defun dfs1 (node number)
  (setf (abs-node-marker node) 'visited)
  (dolist (child (abs-node-out node))
    (if (eq (abs-node-marker child) 'unvisited)
	(setf number (dfs1 child number))))
  (setf (abs-node-dfnumber node) number)
  (1+ number))

;;; The second search picks the highest numbered vertices and builds clusters.
(defun dfs2 (node)
  (setf (abs-node-marker node) 'visited)
  (do ((best-child (find-max-child node) (find-max-child node))
       (cluster (list node)))
      ((null best-child) cluster)
    (setf cluster (nconc (dfs2 best-child) cluster))))

(defun find-max-root (graph)
  (let ((max 0) (best nil))
    (dolist (node graph)
      (when (and (eq (abs-node-marker node) 'unvisited)
	       (> (abs-node-dfnumber node) max))
	(setf max (abs-node-dfnumber node))
	(setf best node)))
    best))

(defun find-max-child (node)
  (find-max-root (abs-node-in node)))
  

;;; df-search does a depth-first search of a directed graph to find
;;; the strongly connected components. It is an implementation of the
;;; procedure search described on page 192 of Aho et al 1974 (see above).
(defun df-search (v)
  (declare (type abs-node v)
	   (special *count* *stack*))

  (let ((components nil)
	(result nil)
	(vcell nil))
    (setf (abs-node-marker v) 'old)
    (setf (abs-node-dfnumber v) *count*)
    (incf *count*)
    (setf (abs-node-lowlink v) (abs-node-dfnumber v))
    (push v *stack*)
    (dolist (w (abs-node-out v))
      (cond ((eq (abs-node-marker w) 'new)
	     (setf components (nconc (df-search w) components))
	     (setf (abs-node-lowlink v)
		   (min (abs-node-lowlink v) (abs-node-lowlink w))))
	    ((and (< (abs-node-dfnumber w) (abs-node-dfnumber v))
		  (member w *stack*))
	     (setf (abs-node-lowlink v)
		   (min (abs-node-dfnumber w) (abs-node-lowlink v))))))
    (cond ((= (abs-node-lowlink v) (abs-node-dfnumber v))
	   ;; Add everything on the stack up to and including v to the result.
	   (setf result *stack*)
	   (setf vcell (member v *stack*))
	   (setf *stack* (cdr vcell))
	   (setf (cdr vcell) nil)
	   (cons result components))
	  (t components))))

;;; This function makes a graph whose nodes are the strongly connected
;;; components of the constraint graph. There is a link between two
;;; nodes in the new graph if there was one between any members of the
;;; components in the original graph. The new graph is represented as
;;; a list of nodes (the components) with adjacent nodes - ie, cons
;;; cells whose cars are the nodes and whose cdrs are a list of the
;;; nodes to which there is a directed edge from this node.

;;; In addition, the dfnumber slot of the first node in the component
;;; says whether this component is a root of the graph.
(defun construct-reduced-graph (graph components)
  (declare (list graph components))

  ;; Quick error check
  (let ((offender (find-if #'(lambda (node)
			       (not (some #'(lambda (cpt)
					      (member node cpt))
					  components)))
			   graph)))
    (if offender
	(error "~S is not in any component." offender)))

  ;; First, go through each component, and for each node add a link to
  ;; its containing component so we don't have to search in the next
  ;; step. Initialise each "node" in the new graph.
  (let ((reduced-graph
	 (mapcar #'(lambda (cpt)
		     (let ((reduced-graph-node (list cpt)))
		       (setf (abs-node-dfnumber (car cpt)) t)
		       (dolist (node cpt)
			 (setf (abs-node-marker node)
			       reduced-graph-node))
		       reduced-graph-node))
		 components)))
    
    ;; Second, go through each node in the old graph, and add the
    ;; links in the reduced graph.
    (dolist (node graph)
      (let ((from-node (abs-node-marker node)))
	(dolist (to (abs-node-out node))
	  (let ((to-node (abs-node-marker to)))
	    (unless (eq to-node from-node)
	      ;; Just for a giggle I'm turning this around.
	      ;; (pushnew from-node (cdr to-node))
	      (pushnew to-node (cdr from-node))
	      (setf (abs-node-dfnumber (caar to-node)) nil))
	      ))))
    reduced-graph))
    

;;; Topologically sort the partial order defined by the DAG using
;;; depth first search. This version modified 3/3/92 by Jim to try to
;;; use the heuristics mentioned in Craig's thesis.

(defun topological-sort (partial-order)
  (declare (list partial-order))
  (dolist (node partial-order)
    (push 'unvisited (cdr node)))
  (let ((*res* nil))
    (declare (special *res*))
    (do ((node (find-best-unvisited partial-order)
	       (find-best-unvisited partial-order)))
	((null node) *res*)
      (dfs-sort node))))

(defun print-po (po)
  (dolist (n po)
    (print (car n))
    (dolist (c (cdr n))
      (print (caar c)))
    (terpri)))

;;; The later you pick something, the higher it is on the hierarchy,
;;; so only pick the "done" one after everything else. Note that all
;;; top level goals hang off of done. Otherwise, pick binding literal
;;; clusters as soon as possible. The slot "dfnumber" for the first
;;; schema in an abstract node says whether the node is a root or not.

(defun find-best-unvisited (partial-order)
  (let ((roots (mapcan #'(lambda (n)
			   (if (and (abs-node-dfnumber (caar n))
				    (eq (second n) 'unvisited))
			       (list n)))
		       partial-order)))
    (if (> (length roots) 1)
	(setf roots (delete-if
		     #'(lambda (n)
			 (member 'done (car n) :key #'abs-node-name))
		     roots)))
    (cond ((find-if #'binding-cluster roots))
	  (t (car roots)))))

(defun binding-cluster (cluster)
  "True if none of the nodes appear in the primary effects"
  (every #'(lambda (node) (eq (abs-node-type node) 'binding))
	 (car cluster)))

(defun dfs-sort (root)
  (declare (list root)
	   (special *res*))
  (setf (second root) 'visited)
  ;; Again, try to pick binding clusters first.
  #|
  (do ((children (mapcan #'(lambda (c)
			     (if (eq (second c) 'unvisited)
				 (list c)))
			 (cddr root))
		 (delete chosen children))
       (chosen (or (find-if #'binding-cluster children) (car children))
	       (or (find-if #'binding-cluster children) (car children))))
      ((null children))
    (dfs-sort chosen))|# ;; actually, they will always be roots.
  (dolist (child (cddr root))
    (if (eq (second child) 'unvisited)
	(dfs-sort child)))
  (push root *res*))


;;; construct-abs-hierarchy takes the given total order and does the
;;; biz for it to be used as the abstraction hierarchy in the current
;;; problem space.
(defun construct-abs-hierarchy (total-order pspace)
  (declare (list total-order)
	   (ignore pspace))
  ;; This is where I collapse levels that involve only plain or
  ;; binding literals. I reverse
  ;; it so the highest things come last, and will get a higher abs
  ;; level using position. 
  (mapcar #'car
	  (combine-adjacent-plains (reverse total-order))))

(defun combine-adjacent-plains (list)
  (cond ((or (null list) (null (cdr list)))
	 list)
	((and (plain-cluster (first list))
	      (plain-cluster (second list)))
	 (combine-adjacent-plains
	  (cons (list (nconc (car (first list)) (car (second list))))
		(cddr list))))
	(t
	 (cons (car list)
	       (combine-adjacent-plains (cdr list))))))

(defun plain-cluster (cluster)
  (every #'(lambda (node)
	     (or (eq (abs-node-type node) 'binding)
		 (eq (abs-node-type node) 'plain)))
	 (car cluster)))


;;;
;;; This is the extra code for unification used to try and squeeze as
;;; much as possible out of the abstraction.
;;;

(defun get-unifications (node op pspace)
  (declare (type abs-node node)
	   (type rule op)
	   (type problem-space pspace))
  "Return a list of ways the operator can unify with the node, which
may have both objects and types in its argument list. The unifications
are binding lists of variables to objects or types."
  (get-effects-unifications node (third (rule-effects op)) pspace
			    (list (second (rule-precond-exp op))
				  (second (rule-effects op)))))

(defun get-effects-unifications (node effects pspace declarations)
  (cond ((null effects) nil)
	((and (member (first (car effects)) '(user::add user::del))
	      (eq (abs-node-name node) (car (second (car effects)))))
	 (let ((attempt (abs-unify (abs-node-args node)
				   (cdr (second (car effects)))
				   pspace declarations nil)))
	   (if attempt
	       (cons attempt (get-effects-unifications node (cdr effects)
						       pspace declarations))
	       (get-effects-unifications node (cdr effects)
					 pspace declarations))))
	;; otherwise it's a conditional effect..
	(t
	 (nconc (get-effects-unifications node (third (car effects))
					  pspace declarations)
		(get-effects-unifications node (cdr effects)
					  pspace declarations)))))

;;; instargs are types or objecst, expargs are objects or variables
;;; that appear in the declarations.
(defun abs-unify (instargs expargs pspace decls bindings)
  (map nil #'(lambda (inst exp)
	       (let ((instobj (prodigy-object-p inst))
		     (expvar (strong-is-var-p exp))
		     (expbind (assoc exp bindings)))
		 (cond ((and instobj (not expvar))
			(unless (eq (prodigy-object-name inst) exp)
			  (return-from abs-unify nil)))
		       ((and instobj expbind)
			(unless (eq inst (cdr expbind))
			  (return-from abs-unify nil)))
		       ;; reject if types won't match.
		       ((not (eq (if instobj
				     (type-name (prodigy-object-type inst))
				     inst)
				 (arg-to-type exp decls nil pspace nil)))
			(return-from abs-unify nil))
		       ;; Otherwise can just bind if inst is an object
		       (instobj (push (cons exp inst) bindings)))))
       instargs expargs)
  (or bindings t))

;;; This is like explode-effects, except we have bindings that are
;;; substituted first.
(defun propagate-effect-unifications (bindings op graph pspace)
  (let ((declarations (list (second (rule-precond-exp op))
			    (second (rule-effects op))))
	(effect-list (third (rule-effects op)))
	(effects (cons :root nil)))
    (dolist (effect (if (eq bindings t) effect-list
			(sublis bindings effect-list)))
      (if (member (first effect) '(user::add user::del))
	  (maybe-add-lit (second effect) declarations nil effects
			 graph pspace nil)
	  (dolist (subeffect (third effect))
	    (maybe-add-lit (second subeffect) declarations nil effects
			   graph pspace nil))))
    (cdr effects)))

;;; This is like explode-preconds, except again we make use of bindings.
(defun propagate-precond-unifications (bindings op graph pspace)
  (let ((prec-expr (if (eq bindings t)
		       (third (rule-precond-exp op))
		       (sublis bindings (third (rule-precond-exp op)))))
	(declarations (list (second (rule-precond-exp op))))
	(preconds (cons :root nil)))
    (walk-through-expr prec-expr declarations nil preconds graph
		       pspace nil)
    (cdr preconds)))


